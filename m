Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261370AbSKZW1h>; Tue, 26 Nov 2002 17:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSKZW1h>; Tue, 26 Nov 2002 17:27:37 -0500
Received: from inet-mail2.oracle.com ([148.87.2.202]:8447 "EHLO
	inet-mail2.oracle.com") by vger.kernel.org with ESMTP
	id <S261370AbSKZW1e>; Tue, 26 Nov 2002 17:27:34 -0500
Date: Tue, 26 Nov 2002 14:34:41 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.49 - semaphore operations with timeouts
Message-ID: <20021126223441.GK19970@nic1-pc.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20021126012554.GE19970@nic1-pc.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021126012554.GE19970@nic1-pc.us.oracle.com>
User-Agent: Mutt/1.4i
Organization: Oracle Corporation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
  Please apply this patch. There are cases during which an application may
not want to wait (potentially) forever on a semaphore operation - it needs a
timeout. Oracle (DB) uses this sort of thing in Solaris to gain a few
percent in performance increases over the alternative (setting alarms to
interrupt semaphore operations). Other applications may find utility in this
added functionality as well - if you're using semaphores already, this is a
more portable solution to the problem than using timed futexes (semtimedop
works on sysv semaphores). As far as code goes, the amount of change is tiny
- this patch is so simple, it really ought to be a shoo-in...
	--Mark

On Mon, Nov 25, 2002 at 05:25:54PM -0800, Mark Fasheh wrote:
> [ Ok, I'm an idiot. This is the proper patch - the previous one had some
>   whitespace issues and left around a spare copy of util.c ]
> 
> This patch adds a system call semtimedop which allows a program to execute a
> semaphore operation with a timeout. The function behaves just like semop
> except if the calling process has to be suspended. If the process has been
> suspended for longer than the timeout (and of course, its semaphore
> operation hasn't completed) then the system call returns EAGAIN to the
> calling process (via errno). Calling semtimedop with a NULL timeout is
> identical to calling semop.
> 
> The overall impact to the semaphore code is minor.
> 
> Userspace code to use/test this can be found at:
> http://www.exothermic.org/linux/semtimedop.tar.gz
>         --Mark

diff -urNp linux-2.5.49-orig/arch/i386/kernel/sys_i386.c linux-2.5.49/arch/i386/kernel/sys_i386.c
--- linux-2.5.49-orig/arch/i386/kernel/sys_i386.c	2002-11-22 13:41:11.000000000 -0800
+++ linux-2.5.49/arch/i386/kernel/sys_i386.c	2002-11-22 17:28:35.000000000 -0800
@@ -140,7 +140,11 @@ asmlinkage int sys_ipc (uint call, int f
 
 	switch (call) {
 	case SEMOP:
-		return sys_semop (first, (struct sembuf *)ptr, second);
+		return sys_semtimedop (first, (struct sembuf *)ptr, second, NULL);
+	case SEMTIMEDOP:
+		return sys_semtimedop (first, (struct sembuf *)ptr, second,
+							   (const struct timespec *)fifth);
+
 	case SEMGET:
 		return sys_semget (first, second, third);
 	case SEMCTL: {
diff -urNp linux-2.5.49-orig/arch/ia64/ia32/sys_ia32.c linux-2.5.49/arch/ia64/ia32/sys_ia32.c
--- linux-2.5.49-orig/arch/ia64/ia32/sys_ia32.c	2002-11-22 13:40:49.000000000 -0800
+++ linux-2.5.49/arch/ia64/ia32/sys_ia32.c	2002-11-22 17:28:35.000000000 -0800
@@ -2124,6 +2124,7 @@ struct ipc_kludge {
 #define SEMOP		 1
 #define SEMGET		 2
 #define SEMCTL		 3
+#define SEMTIMEDOP	 4
 #define MSGSND		11
 #define MSGRCV		12
 #define MSGGET		13
diff -urNp linux-2.5.49-orig/arch/ia64/kernel/entry.S linux-2.5.49/arch/ia64/kernel/entry.S
--- linux-2.5.49-orig/arch/ia64/kernel/entry.S	2002-11-22 13:40:24.000000000 -0800
+++ linux-2.5.49/arch/ia64/kernel/entry.S	2002-11-22 17:28:35.000000000 -0800
@@ -1254,7 +1254,7 @@ sys_call_table:
 	data8 sys_epoll_create
 	data8 sys_epoll_ctl
 	data8 sys_epoll_wait			// 1245
-	data8 ia64_ni_syscall
+	data8 sys_semtimedop
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
diff -urNp linux-2.5.49-orig/include/asm-i386/ipc.h linux-2.5.49/include/asm-i386/ipc.h
--- linux-2.5.49-orig/include/asm-i386/ipc.h	2002-11-22 13:40:58.000000000 -0800
+++ linux-2.5.49/include/asm-i386/ipc.h	2002-11-22 17:28:36.000000000 -0800
@@ -14,6 +14,7 @@ struct ipc_kludge {
 #define SEMOP		 1
 #define SEMGET		 2
 #define SEMCTL		 3
+#define SEMTIMEDOP	 4
 #define MSGSND		11
 #define MSGRCV		12
 #define MSGGET		13
diff -urNp linux-2.5.49-orig/include/asm-ia64/unistd.h linux-2.5.49/include/asm-ia64/unistd.h
--- linux-2.5.49-orig/include/asm-ia64/unistd.h	2002-11-22 13:40:19.000000000 -0800
+++ linux-2.5.49/include/asm-ia64/unistd.h	2002-11-22 17:28:36.000000000 -0800
@@ -235,6 +235,7 @@
 #define __NR_epoll_create		1243
 #define __NR_epoll_ctl			1244
 #define __NR_epoll_wait			1245
+#define __NR_semtimedop			1246
 
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
 
diff -urNp linux-2.5.49-orig/include/linux/sem.h linux-2.5.49/include/linux/sem.h
--- linux-2.5.49-orig/include/linux/sem.h	2002-11-22 13:40:39.000000000 -0800
+++ linux-2.5.49/include/linux/sem.h	2002-11-22 17:28:36.000000000 -0800
@@ -140,6 +140,8 @@ struct sysv_sem {
 asmlinkage long sys_semget (key_t key, int nsems, int semflg);
 asmlinkage long sys_semop (int semid, struct sembuf *sops, unsigned nsops);
 asmlinkage long sys_semctl (int semid, int semnum, int cmd, union semun arg);
+asmlinkage long sys_semtimedop (int semid, struct sembuf *sops,
+								unsigned nsops, const struct timespec *timeout);
 
 #endif /* __KERNEL__ */
 
diff -urNp linux-2.5.49-orig/ipc/sem.c linux-2.5.49/ipc/sem.c
--- linux-2.5.49-orig/ipc/sem.c	2002-11-22 13:40:29.000000000 -0800
+++ linux-2.5.49/ipc/sem.c	2002-11-25 17:08:32.000000000 -0800
@@ -62,6 +62,7 @@
 #include <linux/spinlock.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
+#include <linux/time.h>
 #include <linux/smp_lock.h>
 #include <linux/security.h>
 #include <asm/uaccess.h>
@@ -969,6 +970,12 @@ static int alloc_undo(struct sem_array *
 
 asmlinkage long sys_semop (int semid, struct sembuf *tsops, unsigned nsops)
 {
+	return sys_semtimedop(semid, tsops, nsops, NULL);
+}
+
+asmlinkage long sys_semtimedop (int semid, struct sembuf *tsops,
+								unsigned nsops, const struct timespec *timeout)
+{
 	int error = -EINVAL;
 	struct sem_array *sma;
 	struct sembuf fast_sops[SEMOPM_FAST];
@@ -976,6 +983,7 @@ asmlinkage long sys_semop (int semid, st
 	struct sem_undo *un;
 	int undos = 0, decrease = 0, alter = 0;
 	struct sem_queue queue;
+	unsigned long offset = MAX_SCHEDULE_TIMEOUT;
 
 
 	if (nsops < 1 || semid < 0)
@@ -991,6 +999,19 @@ asmlinkage long sys_semop (int semid, st
 		error=-EFAULT;
 		goto out_free;
 	}
+	if (timeout) {
+		struct timespec _timeout;
+		if (copy_from_user(&_timeout, timeout, sizeof(*timeout))) {
+			error = -EFAULT;
+			goto out_free;
+		}
+		if (_timeout.tv_sec < 0 || _timeout.tv_nsec < 0 ||
+			_timeout.tv_nsec >= 1000000000L) {
+			error = -EINVAL;
+			goto out_free;
+		}
+		offset = timespec_to_jiffies(&_timeout);
+	}
 	lock_semundo();
 	sma = sem_lock(semid);
 	error=-EINVAL;
@@ -1058,7 +1079,7 @@ asmlinkage long sys_semop (int semid, st
 		sem_unlock(sma);
 		unlock_semundo();
 
-		schedule();
+		offset = schedule_timeout(offset);
 
 		lock_semundo();
 		sma = sem_lock(semid);
@@ -1084,6 +1105,8 @@ asmlinkage long sys_semop (int semid, st
 				break;
 		} else {
 			error = queue.status;
+			if (error == -EINTR && offset == 0)
+				error = -EAGAIN;
 			if (queue.prev) /* got Interrupt */
 				break;
 			/* Everything done by update_queue */
diff -urNp linux-2.5.49-orig/ipc/util.c linux-2.5.49/ipc/util.c
--- linux-2.5.49-orig/ipc/util.c	2002-11-22 13:40:39.000000000 -0800
+++ linux-2.5.49/ipc/util.c	2002-11-22 17:28:36.000000000 -0800
@@ -538,6 +538,13 @@ asmlinkage long sys_semop (int semid, st
 	return -ENOSYS;
 }
 
+asmlinkage long sys_semtimedop (int semid, struct sembuf *sops, unsigned nsops,
+								const struct timespec *timeout)
+{
+	return -ENOSYS;
+}
+
+
 asmlinkage long sys_semctl (int semid, int semnum, int cmd, union semun arg)
 {
 	return -ENOSYS;

