Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263733AbTCUTQs>; Fri, 21 Mar 2003 14:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263710AbTCUTPw>; Fri, 21 Mar 2003 14:15:52 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:27090 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S263751AbTCUTOt>; Fri, 21 Mar 2003 14:14:49 -0500
Date: Fri, 21 Mar 2003 11:25:39 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk
Subject: [PATCH 2.4.21-pre5] semtimedop backport
Message-ID: <20030321192539.GJ10190@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,
	Attached is a backport of the semtimedop() system call from 2.5.65.    
Semtimedop is basically semop with a timeout. This hooks it up for x86 and
ia64. Comments are appreciated, otherwise please consider this for
inclusion.
	--Mark

--
Mark Fasheh
Software Developer, Oracle Corp
mark.fasheh@oracle.com

diff -urp /scratch/mfasheh/linux-2.4.21-pre5/arch/i386/kernel/sys_i386.c linux-2.4.21-pre5/arch/i386/kernel/sys_i386.c
--- /scratch/mfasheh/linux-2.4.21-pre5/arch/i386/kernel/sys_i386.c	2001-03-19 12:35:09.000000000 -0800
+++ linux-2.4.21-pre5/arch/i386/kernel/sys_i386.c	2003-03-20 15:48:25.000000000 -0800
@@ -139,7 +139,10 @@ asmlinkage int sys_ipc (uint call, int f
 
 	switch (call) {
 	case SEMOP:
-		return sys_semop (first, (struct sembuf *)ptr, second);
+		return sys_semtimedop (first, (struct sembuf *)ptr, second, NULL);
+	case SEMTIMEDOP:
+		return sys_semtimedop (first, (struct sembuf *)ptr, second, 
+				       (const struct timespec *)fifth);
 	case SEMGET:
 		return sys_semget (first, second, third);
 	case SEMCTL: {
diff -urp /scratch/mfasheh/linux-2.4.21-pre5/arch/ia64/ia32/sys_ia32.c linux-2.4.21-pre5/arch/ia64/ia32/sys_ia32.c
--- /scratch/mfasheh/linux-2.4.21-pre5/arch/ia64/ia32/sys_ia32.c	2003-03-20 13:45:58.000000000 -0800
+++ linux-2.4.21-pre5/arch/ia64/ia32/sys_ia32.c	2003-03-20 15:48:25.000000000 -0800
@@ -2126,6 +2126,7 @@ struct ipc_kludge {
 #define SEMOP		 1
 #define SEMGET		 2
 #define SEMCTL		 3
+#define SEMTIMEDOP	 4
 #define MSGSND		11
 #define MSGRCV		12
 #define MSGGET		13
@@ -2553,6 +2554,17 @@ shmctl32 (int first, int second, void *u
 	return err;
 }
 
+static long
+semtimedop32(int semid, struct sembuf *tsems, int nsems,
+	     const struct timespec32 *timeout32)
+{
+	struct timespec t;
+	if (get_user (t.tv_sec, &timeout32->tv_sec) ||
+	    get_user (t.tv_nsec, &timeout32->tv_nsec))
+		return -EFAULT;
+	return sys_semtimedop(semid, tsems, nsems, &t);
+}
+
 asmlinkage long
 sys32_ipc (u32 call, int first, int second, int third, u32 ptr, u32 fifth)
 {
@@ -2564,7 +2576,11 @@ sys32_ipc (u32 call, int first, int seco
 	switch (call) {
 	      case SEMOP:
 		/* struct sembuf is the same on 32 and 64bit :)) */
-		return sys_semop(first, (struct sembuf *)AA(ptr), second);
+		return sys_semtimedop(first, (struct sembuf *)AA(ptr), second,
+				      NULL);
+	      case SEMTIMEDOP:
+		return semtimedop32(first, (struct sembuf *)AA(ptr), second, 
+				    (const struct timespec32 *)AA(fifth));
 	      case SEMGET:
 		return sys_semget(first, second, third);
 	      case SEMCTL:
diff -urp /scratch/mfasheh/linux-2.4.21-pre5/arch/ia64/kernel/entry.S linux-2.4.21-pre5/arch/ia64/kernel/entry.S
--- /scratch/mfasheh/linux-2.4.21-pre5/arch/ia64/kernel/entry.S	2003-03-20 13:45:58.000000000 -0800
+++ linux-2.4.21-pre5/arch/ia64/kernel/entry.S	2003-03-20 16:20:05.000000000 -0800
@@ -1200,7 +1200,7 @@ sys_call_table:
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall			// 1245
 	data8 ia64_ni_syscall
-	data8 ia64_ni_syscall
+	data8 sys_semtimedop
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall
 	data8 ia64_ni_syscall			// 1250
diff -urp /scratch/mfasheh/linux-2.4.21-pre5/include/asm-i386/ipc.h linux-2.4.21-pre5/include/asm-i386/ipc.h
--- /scratch/mfasheh/linux-2.4.21-pre5/include/asm-i386/ipc.h	1998-12-31 12:05:12.000000000 -0800
+++ linux-2.4.21-pre5/include/asm-i386/ipc.h	2003-03-20 15:48:25.000000000 -0800
@@ -14,6 +14,7 @@ struct ipc_kludge {
 #define SEMOP		 1
 #define SEMGET		 2
 #define SEMCTL		 3
+#define SEMTIMEDOP	 4
 #define MSGSND		11
 #define MSGRCV		12
 #define MSGGET		13
diff -urp /scratch/mfasheh/linux-2.4.21-pre5/include/asm-ia64/unistd.h linux-2.4.21-pre5/include/asm-ia64/unistd.h
--- /scratch/mfasheh/linux-2.4.21-pre5/include/asm-ia64/unistd.h	2003-03-20 13:46:13.000000000 -0800
+++ linux-2.4.21-pre5/include/asm-ia64/unistd.h	2003-03-20 15:54:41.000000000 -0800
@@ -223,6 +223,7 @@
 #define __NR_security			1233
 /* 1234-1235: reserved for {alloc,free}_hugepages */
 /* 1238-1242: reserved for io_{setup,destroy,getevents,submit,cancel} */
+#define __NR_semtimedop			1247
 
 #if !defined(__ASSEMBLY__) && !defined(ASSEMBLER)
 
diff -urp /scratch/mfasheh/linux-2.4.21-pre5/include/linux/sem.h linux-2.4.21-pre5/include/linux/sem.h
--- /scratch/mfasheh/linux-2.4.21-pre5/include/linux/sem.h	2001-11-22 11:46:18.000000000 -0800
+++ linux-2.4.21-pre5/include/linux/sem.h	2003-03-20 15:48:25.000000000 -0800
@@ -124,6 +124,8 @@ struct sem_undo {
 asmlinkage long sys_semget (key_t key, int nsems, int semflg);
 asmlinkage long sys_semop (int semid, struct sembuf *sops, unsigned nsops);
 asmlinkage long sys_semctl (int semid, int semnum, int cmd, union semun arg);
+asmlinkage long sys_semtimedop (int semid, struct sembuf *sops, 
+			unsigned nsops, const struct timespec *timeout);
 
 #endif /* __KERNEL__ */
 
diff -urp /scratch/mfasheh/linux-2.4.21-pre5/ipc/sem.c linux-2.4.21-pre5/ipc/sem.c
--- /scratch/mfasheh/linux-2.4.21-pre5/ipc/sem.c	2002-11-28 15:53:15.000000000 -0800
+++ linux-2.4.21-pre5/ipc/sem.c	2003-03-20 16:23:15.000000000 -0800
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
+	return sys_semtimedop(semid, tsops, nsops, NULL);
+}
+
+asmlinkage long sys_semtimedop (int semid, struct sembuf *tsops,
+			unsigned nsops, const struct timespec *timeout)
+{
 	int error = -EINVAL;
 	struct sem_array *sma;
 	struct sembuf fast_sops[SEMOPM_FAST];
@@ -846,6 +853,7 @@ asmlinkage long sys_semop (int semid, st
 	struct sem_undo *un;
 	int undos = 0, decrease = 0, alter = 0;
 	struct sem_queue queue;
+	unsigned long jiffies_left = 0;
 
 	if (nsops < 1 || semid < 0)
 		return -EINVAL;
@@ -860,6 +868,19 @@ asmlinkage long sys_semop (int semid, st
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
+		    _timeout.tv_nsec >= 1000000000L) {
+			error = -EINVAL;
+			goto out_free;
+		}
+		jiffies_left = timespec_to_jiffies(&_timeout);
+	}
 	sma = sem_lock(semid);
 	error=-EINVAL;
 	if(sma==NULL)
@@ -932,7 +953,10 @@ asmlinkage long sys_semop (int semid, st
 		current->state = TASK_INTERRUPTIBLE;
 		sem_unlock(semid);
 
-		schedule();
+		if (timeout)
+			jiffies_left = schedule_timeout(jiffies_left);
+		else
+			schedule();
 
 		tmp = sem_lock(semid);
 		if(tmp==NULL) {
@@ -957,6 +981,8 @@ asmlinkage long sys_semop (int semid, st
 				break;
 		} else {
 			error = queue.status;
+			if (error == -EINTR && timeout && jiffies_left == 0)
+				error = -EAGAIN;
 			if (queue.prev) /* got Interrupt */
 				break;
 			/* Everything done by update_queue */
diff -urp /scratch/mfasheh/linux-2.4.21-pre5/ipc/util.c linux-2.4.21-pre5/ipc/util.c
--- /scratch/mfasheh/linux-2.4.21-pre5/ipc/util.c	2002-11-28 15:53:15.000000000 -0800
+++ linux-2.4.21-pre5/ipc/util.c	2003-03-20 15:48:25.000000000 -0800
@@ -359,6 +359,12 @@ asmlinkage long sys_semop (int semid, st
 	return -ENOSYS;
 }
 
+asmlinkage long sys_semtimedop(int semid, struct sembuf *sops, unsigned nsops,
+			       const struct timespec *timeout)
+{
+	return -ENOSYS;
+}
+
 asmlinkage long sys_semctl (int semid, int semnum, int cmd, union semun arg)
 {
 	return -ENOSYS;
