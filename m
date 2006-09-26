Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751665AbWIZAnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbWIZAnT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 20:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbWIZAnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 20:43:19 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:17030 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751665AbWIZAnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 20:43:18 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 25 Sep 2006 17:43:10 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, Michael Kerrisk <michael.kerrisk@gmx.net>
Subject: [patch] epoll_pwait for 2.6.18 ...
Message-ID: <Pine.LNX.4.64.0609251735070.4749@alien.or.mcafeemobile.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch implements the epoll_pwait system call, that extend the 
event wait mechanism with the same logic ppoll and pselect do. The 
definition of epoll_pwait is:

int epoll_pwait(int epfd, struct epoll_event *events, int maxevents,
                 int timeout, const sigset_t *sigmask, size_t sigsetsize);

The difference between the vanilla epoll_wait and epoll_pwait is that the 
latter allows the caller to specify a signal mask to be set while waiting 
for events. Hence epoll_pwait will wait until either one monitored event, 
or an unmasked signal happen. If sigmask is NULL, the epoll_pwait system 
call will act exactly like epoll_wait. For the POSIX definition of 
pselect, information is available here:

http://www.opengroup.org/onlinepubs/009695399/functions/select.html

This patch goes over 2.6.18 and the epoll_pwait definition depends on 
the TIF_RESTORE_SIGMASK bits.




Signed-off-by: Davide Libenzi <davidel@xmailserver.org>



- Davide



arch/i386/kernel/syscall_table.S |    1
fs/eventpoll.c                   |   55 ++++++++++++++++++++++++++++++++++++---
include/asm-i386/unistd.h        |    3 +-
include/linux/syscalls.h         |    3 ++
4 files changed, 58 insertions(+), 4 deletions(-)




diff -Nru linux-2.6.18/arch/i386/kernel/syscall_table.S linux-2.6.18.pepoll/arch/i386/kernel/syscall_table.S
--- linux-2.6.18/arch/i386/kernel/syscall_table.S	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.18.pepoll/arch/i386/kernel/syscall_table.S	2006-09-25 16:20:02.000000000 -0700
@@ -317,3 +317,4 @@
  	.long sys_tee			/* 315 */
  	.long sys_vmsplice
  	.long sys_move_pages
+ 	.long sys_epoll_pwait
diff -Nru linux-2.6.18/fs/eventpoll.c linux-2.6.18.pepoll/fs/eventpoll.c
--- linux-2.6.18/fs/eventpoll.c	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.18.pepoll/fs/eventpoll.c	2006-09-25 16:11:32.000000000 -0700
@@ -105,6 +105,8 @@
  /* Maximum msec timeout value storeable in a long int */
  #define EP_MAX_MSTIMEO min(1000ULL * MAX_SCHEDULE_TIMEOUT / HZ, (LONG_MAX - 999ULL) / HZ)

+#define EP_MAX_EVENTS (INT_MAX / sizeof(struct epoll_event))
+

  struct epoll_filefd {
  	struct file *file;
@@ -497,7 +499,7 @@
   */
  asmlinkage long sys_epoll_create(int size)
  {
-	int error, fd;
+	int error, fd = -1;
  	struct eventpoll *ep;
  	struct inode *inode;
  	struct file *file;
@@ -640,7 +642,6 @@
  	return error;
  }

-#define MAX_EVENTS (INT_MAX / sizeof(struct epoll_event))

  /*
   * Implement the event wait interface for the eventpoll file. It is the kernel
@@ -657,7 +658,7 @@
  		     current, epfd, events, maxevents, timeout));

  	/* The maximum number of event must be greater than zero */
-	if (maxevents <= 0 || maxevents > MAX_EVENTS)
+	if (maxevents <= 0 || maxevents > EP_MAX_EVENTS)
  		return -EINVAL;

  	/* Verify that the area passed by the user is writeable */
@@ -699,6 +700,54 @@
  }


+#ifdef TIF_RESTORE_SIGMASK
+
+/*
+ * Implement the event wait interface for the eventpoll file. It is the kernel
+ * part of the user space epoll_pwait(2).
+ */
+asmlinkage long sys_epoll_pwait(int epfd, struct epoll_event __user *events,
+				int maxevents, int timeout, const sigset_t __user *sigmask,
+				size_t sigsetsize)
+{
+	int error;
+	sigset_t ksigmask, sigsaved;
+
+	/*
+	 * If the caller wants a certain signal mask to be set during the wait,
+	 * we apply it here.
+	 */
+	if (sigmask) {
+		if (sigsetsize != sizeof(sigset_t))
+			return -EINVAL;
+		if (copy_from_user(&ksigmask, sigmask, sizeof(ksigmask)))
+			return -EFAULT;
+		sigdelsetmask(&ksigmask, sigmask(SIGKILL) | sigmask(SIGSTOP));
+		sigprocmask(SIG_SETMASK, &ksigmask, &sigsaved);
+	}
+
+	error = sys_epoll_wait(epfd, events, maxevents, timeout);
+
+	/*
+	 * If we changed the signal mask, we need to restore the original one.
+	 * In case we've got a signal while waiting, we do not restore the signal
+	 * mask yet, and we allow do_signal() to deliver the signal on the way back
+	 * to userspace, before the signal mask is restored.
+	 */
+	if (sigmask) {
+		if (error == -EINTR) {
+			memcpy(&current->saved_sigmask, &sigsaved, sizeof(sigsaved));
+			set_thread_flag(TIF_RESTORE_SIGMASK); 
+		} else
+			sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+	}
+
+	return error;
+}
+
+#endif /* #ifdef TIF_RESTORE_SIGMASK */
+
+
  /*
   * Creates the file descriptor to be used by the epoll interface.
   */
diff -Nru linux-2.6.18/include/asm-i386/unistd.h linux-2.6.18.pepoll/include/asm-i386/unistd.h
--- linux-2.6.18/include/asm-i386/unistd.h	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.18.pepoll/include/asm-i386/unistd.h	2006-09-25 16:21:05.000000000 -0700
@@ -323,10 +323,11 @@
  #define __NR_tee		315
  #define __NR_vmsplice		316
  #define __NR_move_pages		317
+#define __NR_epoll_pwait	318

  #ifdef __KERNEL__

-#define NR_syscalls 318
+#define NR_syscalls 319

  /*
   * user-visible error numbers are in the range -1 - -128: see
diff -Nru linux-2.6.18/include/linux/syscalls.h linux-2.6.18.pepoll/include/linux/syscalls.h
--- linux-2.6.18/include/linux/syscalls.h	2006-09-19 20:42:06.000000000 -0700
+++ linux-2.6.18.pepoll/include/linux/syscalls.h	2006-09-25 16:11:32.000000000 -0700
@@ -430,6 +430,9 @@
  				struct epoll_event __user *event);
  asmlinkage long sys_epoll_wait(int epfd, struct epoll_event __user *events,
  				int maxevents, int timeout);
+asmlinkage long sys_epoll_pwait(int epfd, struct epoll_event __user *events,
+				int maxevents, int timeout, const sigset_t __user *sigmask,
+				size_t sigsetsize);
  asmlinkage long sys_gethostname(char __user *name, int len);
  asmlinkage long sys_sethostname(char __user *name, int len);
  asmlinkage long sys_setdomainname(char __user *name, int len);
