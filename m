Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264726AbSKEGjU>; Tue, 5 Nov 2002 01:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264741AbSKEGjU>; Tue, 5 Nov 2002 01:39:20 -0500
Received: from fire2.LINUX.UCLA.EDU ([131.179.104.17]:49163 "EHLO
	linux.ucla.edu") by vger.kernel.org with ESMTP id <S264726AbSKEGjS>;
	Tue, 5 Nov 2002 01:39:18 -0500
Date: Mon, 4 Nov 2002 22:45:47 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@transmeta.com
Subject: Re: [PATCH] add semtimedop call to kernel 2.5.46 (was against 2.4.19)
Message-ID: <20021105064546.GO4072@linux.ucla.edu>
References: <20021104192655.GJ4072@linux.ucla.edu> <1036440171.1113.127.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036440171.1113.127.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
From: Mark Fasheh <mfasheh@linux.ucla.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan, thank you very much for the feedback. I fixed the dumb variable naming
and have ported the patch to kernel 2.5.46 (inlined below). As always, I'd
love feedback, otherwise it'd be cool to see this merged :)

On Mon, Nov 04, 2002 at 08:02:51PM +0000, Alan Cox wrote:
> On Mon, 2002-11-04 at 19:26, Mark Fasheh wrote:
> > Hello,
> > 	Included is a patch against 2.4.19 to allow semaphore operations
> > with timeouts. The new call functions exactly like semtimedop in Solaris.
> > Userspace code to use/test this new syscall can be found at:
> > http://www.exothermic.org/linux/semtimedop.tar.gz
> > Feedback is greatly appreciated :)
> 
> Only two feedbacks from a first glance - its a 2.5 type change not a 2.4
> one. Also call your local variable something other than "jiffies" as
> that is used for a global to do with time !

diff -urNp linux-2.5.46-orig/arch/i386/kernel/sys_i386.c linux-2.5.46/arch/i386/kernel/sys_i386.c
--- linux-2.5.46-orig/arch/i386/kernel/sys_i386.c	2002-11-04 14:30:52.000000000 -0800
+++ linux-2.5.46/arch/i386/kernel/sys_i386.c	2002-11-04 21:06:25.000000000 -0800
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
diff -urNp linux-2.5.46-orig/arch/ia64/ia32/sys_ia32.c linux-2.5.46/arch/ia64/ia32/sys_ia32.c
--- linux-2.5.46-orig/arch/ia64/ia32/sys_ia32.c	2002-11-04 14:30:33.000000000 -0800
+++ linux-2.5.46/arch/ia64/ia32/sys_ia32.c	2002-11-04 21:08:30.000000000 -0800
@@ -2124,6 +2124,7 @@ struct ipc_kludge {
 #define SEMOP		 1
 #define SEMGET		 2
 #define SEMCTL		 3
+#define SEMTIMEDOP	 4
 #define MSGSND		11
 #define MSGRCV		12
 #define MSGGET		13
diff -urNp linux-2.5.46-orig/arch/ia64/kernel/entry.S linux-2.5.46/arch/ia64/kernel/entry.S
--- linux-2.5.46-orig/arch/ia64/kernel/entry.S	2002-11-04 14:30:15.000000000 -0800
+++ linux-2.5.46/arch/ia64/kernel/entry.S	2002-11-04 21:11:39.000000000 -0800
@@ -1254,7 +1254,7 @@ sys_call_table:
 	data8 sys_epoll_create
 	data8 sys_epoll_ctl
 	data8 sys_epoll_wait			// 1245
-	data8 ia64_ni_syscall
+	data8 sys_semtimedop
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
diff -urNp linux-2.5.46-orig/include/asm-i386/ipc.h linux-2.5.46/include/asm-i386/ipc.h
--- linux-2.5.46-orig/include/asm-i386/ipc.h	2002-11-04 14:30:49.000000000 -0800
+++ linux-2.5.46/include/asm-i386/ipc.h	2002-11-04 21:44:53.000000000 -0800
@@ -14,6 +14,7 @@ struct ipc_kludge {
 #define SEMOP		 1
 #define SEMGET		 2
 #define SEMCTL		 3
+#define SEMTIMEDOP	 4
 #define MSGSND		11
 #define MSGRCV		12
 #define MSGGET		13
diff -urNp linux-2.5.46-orig/include/asm-ia64/unistd.h linux-2.5.46/include/asm-ia64/unistd.h
--- linux-2.5.46-orig/include/asm-ia64/unistd.h	2002-11-04 14:30:07.000000000 -0800
+++ linux-2.5.46/include/asm-ia64/unistd.h	2002-11-04 21:13:19.000000000 -0800
@@ -235,6 +235,7 @@
 #define __NR_epoll_create		1243
 #define __NR_epoll_ctl			1244
 #define __NR_epoll_wait			1245
+#define __NR_semtimedop			1246
 
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
 
diff -urNp linux-2.5.46-orig/include/linux/sem.h linux-2.5.46/include/linux/sem.h
--- linux-2.5.46-orig/include/linux/sem.h	2002-11-04 14:30:24.000000000 -0800
+++ linux-2.5.46/include/linux/sem.h	2002-11-04 21:15:39.000000000 -0800
@@ -140,6 +140,8 @@ struct sysv_sem {
 asmlinkage long sys_semget (key_t key, int nsems, int semflg);
 asmlinkage long sys_semop (int semid, struct sembuf *sops, unsigned nsops);
 asmlinkage long sys_semctl (int semid, int semnum, int cmd, union semun arg);
+asmlinkage long sys_semtimedop (int semid, struct sembuf *sops,
+								unsigned nsops, const struct timespec *timeout);
 
 #endif /* __KERNEL__ */
 
diff -urNp linux-2.5.46-orig/ipc/sem.c linux-2.5.46/ipc/sem.c
--- linux-2.5.46-orig/ipc/sem.c	2002-11-04 14:30:22.000000000 -0800
+++ linux-2.5.46/ipc/sem.c	2002-11-04 21:19:02.000000000 -0800
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
+    return sys_semtimedop(semid, tsops, nsops, NULL);
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
+ 	if (timeout) {
+	  struct timespec _timeout;
+	  if (copy_from_user(&_timeout, timeout, sizeof(*timeout))) {
+		error = -EFAULT;
+		goto out_free;
+	  }
+	  if (_timeout.tv_sec < 0 || _timeout.tv_nsec < 0 ||
+		  _timeout.tv_nsec >= 1000000000L) {
+		error = -EINVAL;
+		goto out_free;
+	  }
+	  offset = timespec_to_jiffies(&_timeout);
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
+ 			if (error == -EINTR && offset == 0)
+			    error = -EAGAIN;
 			if (queue.prev) /* got Interrupt */
 				break;
 			/* Everything done by update_queue */
diff -urNp linux-2.5.46-orig/ipc/util.c linux-2.5.46/ipc/util.c
--- linux-2.5.46-orig/ipc/util.c	2002-11-04 14:30:24.000000000 -0800
+++ linux-2.5.46/ipc/util.c	2002-11-04 21:16:39.000000000 -0800
@@ -532,6 +532,13 @@ asmlinkage long sys_semop (int semid, st
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
