Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262646AbSKDTUa>; Mon, 4 Nov 2002 14:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262648AbSKDTUa>; Mon, 4 Nov 2002 14:20:30 -0500
Received: from fire2.LINUX.UCLA.EDU ([131.179.104.17]:44813 "EHLO
	linux.ucla.edu") by vger.kernel.org with ESMTP id <S262646AbSKDTU1>;
	Mon, 4 Nov 2002 14:20:27 -0500
Date: Mon, 4 Nov 2002 11:26:55 -0800
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br
Subject: [PATCH] add semtimedop call to kernel 2.4.19
Message-ID: <20021104192655.GJ4072@linux.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Mark Fasheh <mfasheh@linux.ucla.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	Included is a patch against 2.4.19 to allow semaphore operations
with timeouts. The new call functions exactly like semtimedop in Solaris.
Userspace code to use/test this new syscall can be found at:
http://www.exothermic.org/linux/semtimedop.tar.gz
Feedback is greatly appreciated :)
	--Mark

If merged, this patch can be attributed to mark.fasheh@oracle.com

diff -urNp linux-2.4.19-orig/arch/i386/kernel/sys_i386.c linux-2.4.19/arch/i386/kernel/sys_i386.c
--- linux-2.4.19-orig/arch/i386/kernel/sys_i386.c	2001-03-19 12:35:09.000000000 -0800
+++ linux-2.4.19/arch/i386/kernel/sys_i386.c	2002-10-30 18:12:15.000000000 -0800
@@ -139,7 +139,11 @@ asmlinkage int sys_ipc (uint call, int f
 
 	switch (call) {
 	case SEMOP:
-		return sys_semop (first, (struct sembuf *)ptr, second);
+		return sys_semtimedop (first, (struct sembuf *)ptr, second, 
+				       NULL);
+	case SEMTIMEDOP:
+		return sys_semtimedop (first, (struct sembuf *)ptr, second,
+				       (const struct timespec *)fifth);
 	case SEMGET:
 		return sys_semget (first, second, third);
 	case SEMCTL: {
diff -urNp linux-2.4.19-orig/arch/ia64/ia32/sys_ia32.c linux-2.4.19/arch/ia64/ia32/sys_ia32.c
--- linux-2.4.19-orig/arch/ia64/ia32/sys_ia32.c	2002-08-02 17:39:42.000000000 -0700
+++ linux-2.4.19/arch/ia64/ia32/sys_ia32.c	2002-10-31 13:42:26.000000000 -0800
@@ -2125,6 +2125,7 @@ struct ipc_kludge {
 #define SEMOP		 1
 #define SEMGET		 2
 #define SEMCTL		 3
+#define SEMTIMEDOP   4
 #define MSGSND		11
 #define MSGRCV		12
 #define MSGGET		13
@@ -2552,6 +2553,18 @@ shmctl32 (int first, int second, void *u
 	return err;
 }
 
+static long
+semtimedop32(int semid, struct sembuf *tsems, int nsems,
+			 const struct timespec32 *timeout32)
+{
+  struct timespec t;
+  if (get_user (t.tv_sec, &timeout32->tv_sec) || 
+	  get_user (t.tv_nsec, &timeout32->tv_nsec))
+	return -EFAULT;
+  
+  return sys_semtimedop(semid, tsems, nsems, &t);
+}
+
 asmlinkage long
 sys32_ipc (u32 call, int first, int second, int third, u32 ptr, u32 fifth)
 {
@@ -2563,7 +2576,10 @@ sys32_ipc (u32 call, int first, int seco
 	switch (call) {
 	      case SEMOP:
 		/* struct sembuf is the same on 32 and 64bit :)) */
-		return sys_semop(first, (struct sembuf *)AA(ptr), second);
+ 		return sys_semtimedop(first, (struct sembuf *)AA(ptr), second, NULL);
+ 	      case SEMTIMEDOP:
+ 		return semtimedop32(first, (struct sembuf *)AA(ptr), second,
+ 				    (const struct timespec32 *)AA(fifth));
 	      case SEMGET:
 		return sys_semget(first, second, third);
 	      case SEMCTL:
diff -urNp linux-2.4.19-orig/arch/ia64/kernel/entry.S linux-2.4.19/arch/ia64/kernel/entry.S
--- linux-2.4.19-orig/arch/ia64/kernel/entry.S	2002-08-02 17:39:42.000000000 -0700
+++ linux-2.4.19/arch/ia64/kernel/entry.S	2002-10-31 13:44:48.000000000 -0800
@@ -1133,7 +1133,7 @@ sys_call_table:
 	data8 sys_getdents64
 	data8 sys_getunwind			// 1215
 	data8 sys_readahead
-	data8 ia64_ni_syscall
+	data8 sys_semtimedop
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall			// 1220
diff -urNp linux-2.4.19-orig/include/asm-i386/ipc.h linux-2.4.19/include/asm-i386/ipc.h
--- linux-2.4.19-orig/include/asm-i386/ipc.h	1998-12-31 12:05:12.000000000 -0800
+++ linux-2.4.19/include/asm-i386/ipc.h	2002-10-30 18:08:21.000000000 -0800
@@ -14,6 +14,7 @@ struct ipc_kludge {
 #define SEMOP		 1
 #define SEMGET		 2
 #define SEMCTL		 3
+#define SEMTIMEDOP	 4
 #define MSGSND		11
 #define MSGRCV		12
 #define MSGGET		13
diff -urNp linux-2.4.19-orig/include/asm-ia64/unistd.h linux-2.4.19/include/asm-ia64/unistd.h
--- linux-2.4.19-orig/include/asm-ia64/unistd.h	2002-08-02 17:39:45.000000000 -0700
+++ linux-2.4.19/include/asm-ia64/unistd.h	2002-10-31 13:54:21.000000000 -0800
@@ -206,6 +206,7 @@
 #define __NR_getdents64			1214
 #define __NR_getunwind			1215
 #define __NR_readahead			1216
+#define __NR_semtimedop     1217
 #define __NR_tkill			1229
 
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
diff -urNp linux-2.4.19-orig/include/linux/sem.h linux-2.4.19/include/linux/sem.h
--- linux-2.4.19-orig/include/linux/sem.h	2001-11-22 11:46:18.000000000 -0800
+++ linux-2.4.19/include/linux/sem.h	2002-10-30 18:07:33.000000000 -0800
@@ -124,6 +124,8 @@ struct sem_undo {
 asmlinkage long sys_semget (key_t key, int nsems, int semflg);
 asmlinkage long sys_semop (int semid, struct sembuf *sops, unsigned nsops);
 asmlinkage long sys_semctl (int semid, int semnum, int cmd, union semun arg);
+asmlinkage long sys_semtimedop (int semid, struct sembuf *sops,
+							   unsigned nsops, const struct timespec *timeout);
 
 #endif /* __KERNEL__ */
 
diff -urNp linux-2.4.19-orig/ipc/sem.c linux-2.4.19/ipc/sem.c
--- linux-2.4.19-orig/ipc/sem.c	2002-08-02 17:39:46.000000000 -0700
+++ linux-2.4.19/ipc/sem.c	2002-10-31 13:35:07.000000000 -0800
@@ -62,6 +62,7 @@
 #include <linux/spinlock.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
+#include <linux/time.h>
 #include <asm/uaccess.h>
 #include "util.h"
 
@@ -839,6 +840,12 @@ static int alloc_undo(struct sem_array *
 
 asmlinkage long sys_semop (int semid, struct sembuf *tsops, unsigned nsops)
 {
+  return sys_semtimedop(semid, tsops, nsops, NULL);
+}
+
+asmlinkage long sys_semtimedop (int semid, struct sembuf *tsops,
+								unsigned nsops, const struct timespec *timeout)
+{
 	int error = -EINVAL;
 	struct sem_array *sma;
 	struct sembuf fast_sops[SEMOPM_FAST];
@@ -846,6 +853,7 @@ asmlinkage long sys_semop (int semid, st
 	struct sem_undo *un;
 	int undos = 0, decrease = 0, alter = 0;
 	struct sem_queue queue;
+	unsigned long jiffies = MAX_SCHEDULE_TIMEOUT;
 
 	if (nsops < 1 || semid < 0)
 		return -EINVAL;
@@ -860,6 +868,19 @@ asmlinkage long sys_semop (int semid, st
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
+	  jiffies = timespec_to_jiffies(&_timeout);
+	}
 	sma = sem_lock(semid);
 	error=-EINVAL;
 	if(sma==NULL)
@@ -932,7 +953,7 @@ asmlinkage long sys_semop (int semid, st
 		current->state = TASK_INTERRUPTIBLE;
 		sem_unlock(semid);
 
-		schedule();
+		jiffies = schedule_timeout(jiffies);
 
 		tmp = sem_lock(semid);
 		if(tmp==NULL) {
@@ -943,7 +964,7 @@ asmlinkage long sys_semop (int semid, st
 			goto out_free;
 		}
 		/*
-		 * If queue.status == 1 we where woken up and
+		 * If queue.status == 1 we were woken up and
 		 * have to retry else we simply return.
 		 * If an interrupt occurred we have to clean up the
 		 * queue
@@ -957,6 +978,8 @@ asmlinkage long sys_semop (int semid, st
 				break;
 		} else {
 			error = queue.status;
+ 			if (error == -EINTR && jiffies == 0)
+			    error = -EAGAIN;
 			if (queue.prev) /* got Interrupt */
 				break;
 			/* Everything done by update_queue */
diff -urNp linux-2.4.19-orig/ipc/util.c linux-2.4.19/ipc/util.c
--- linux-2.4.19-orig/ipc/util.c	2001-08-12 17:37:53.000000000 -0700
+++ linux-2.4.19/ipc/util.c	2002-10-31 13:37:21.000000000 -0800
@@ -355,6 +355,12 @@ asmlinkage long sys_semop (int semid, st
 	return -ENOSYS;
 }
 
+asmlinkage long sys_semtimedop (int semid, struct sembuf *sops, unsigned nsops,
+								const struct timespec *timeout)
+{
+  return -ENOSYS;
+}
+
 asmlinkage long sys_semctl (int semid, int semnum, int cmd, union semun arg)
 {
 	return -ENOSYS;
