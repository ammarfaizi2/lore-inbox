Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265055AbTGBPj6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 11:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbTGBPj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 11:39:58 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:32416 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S265055AbTGBPjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 11:39:36 -0400
Subject: [PATCH] 2.4.22-pre2-bk fix several build errors with patchlets
	from 2.4.21-ac4
From: Steven Cole <elenstev@mesatop.com>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1057161159.13991.51.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 02 Jul 2003 09:52:39 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the current 2.4 bk tree, I got the following compile errors.

sys_i386.c: In function `sys_ipc':
sys_i386.c:142: warning: implicit declaration of function `sys_semtimedop'
sys_i386.c:143: `SEMTIMEDOP' undeclared (first use in this function)
sys_i386.c:143: (Each undeclared identifier is reported only once
sys_i386.c:143: for each function it appears in.)
make[1]: *** [sys_i386.o] Error 1

----------

dmi_scan.c: In function `exploding_pnp_bios':
dmi_scan.c:521: `BROKEN_PNP_BIOS' undeclared (first use in this function)
dmi_scan.c:521: (Each undeclared identifier is reported only once
dmi_scan.c:521: for each function it appears in.)
dmi_scan.c: In function `dmi_decode':
dmi_scan.c:944: warning: unused variable `data'
make[1]: *** [dmi_scan.o] Error 1

----------

arch/i386/kernel/kernel.o: In function `sys_ipc':
arch/i386/kernel/kernel.o(.text+0x752f): undefined reference to `sys_semtimedop'
make: *** [vmlinux] Error 1

----------

For those too impatient (like me) to wait until the next set of Alan's
patches to be applied, here is a patch which works for me.  The pieces
came from 2.4.21-ac4.

Steven

diff -ur bk-current/include/asm-i386/ipc.h linux/include/asm-i386/ipc.h
--- bk-current/include/asm-i386/ipc.h	Wed Jul  2 09:14:02 2003
+++ linux/include/asm-i386/ipc.h	Wed Jul  2 09:16:05 2003
@@ -14,6 +14,7 @@
 #define SEMOP		 1
 #define SEMGET		 2
 #define SEMCTL		 3
+#define SEMTIMEDOP	 4
 #define MSGSND		11
 #define MSGRCV		12
 #define MSGGET		13
diff -ur bk-current/include/asm-i386/system.h linux/include/asm-i386/system.h
--- bk-current/include/asm-i386/system.h	Wed Jul  2 09:12:29 2003
+++ linux/include/asm-i386/system.h	Wed Jul  2 09:16:08 2003
@@ -375,5 +375,6 @@
 
 #define BROKEN_ACPI_Sx		0x0001
 #define BROKEN_INIT_AFTER_S1	0x0002
+#define BROKEN_PNP_BIOS     	0x0004
 
 #endif
diff -ur bk-current/include/linux/sem.h linux/include/linux/sem.h
--- bk-current/include/linux/sem.h	Wed Jul  2 09:13:13 2003
+++ linux/include/linux/sem.h	Wed Jul  2 09:16:10 2003
@@ -124,6 +124,8 @@
 asmlinkage long sys_semget (key_t key, int nsems, int semflg);
 asmlinkage long sys_semop (int semid, struct sembuf *sops, unsigned nsops);
 asmlinkage long sys_semctl (int semid, int semnum, int cmd, union semun arg);
+asmlinkage long sys_semtimedop (int semid, struct sembuf *sops, 
+			unsigned nsops, const struct timespec *timeout);
 
 #endif /* __KERNEL__ */
 
diff -ur bk-current/ipc/sem.c linux/ipc/sem.c
--- bk-current/ipc/sem.c	Wed Jul  2 09:13:06 2003
+++ linux/ipc/sem.c	Wed Jul  2 09:16:14 2003
@@ -62,6 +62,7 @@
 #include <linux/spinlock.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
+#include <linux/time.h>
 #include <asm/uaccess.h>
 #include "util.h"
 
@@ -251,39 +252,38 @@
 	for (sop = sops; sop < sops + nsops; sop++) {
 		curr = sma->sem_base + sop->sem_num;
 		sem_op = sop->sem_op;
-
-		if (!sem_op && curr->semval)
+		result = curr->semval;
+  
+		if (!sem_op && result)
 			goto would_block;
 
-		curr->sempid = (curr->sempid << 16) | pid;
-		curr->semval += sem_op;
-		if (sop->sem_flg & SEM_UNDO)
-		{
+		result += sem_op;
+		if (result < 0)
+			goto would_block;
+		if (result > SEMVMX)
+			goto out_of_range;
+		if (sop->sem_flg & SEM_UNDO) {
 			int undo = un->semadj[sop->sem_num] - sem_op;
 			/*
 	 		 *	Exceeding the undo range is an error.
 			 */
 			if (undo < (-SEMAEM - 1) || undo > SEMAEM)
-			{
-				/* Don't undo the undo */
-				sop->sem_flg &= ~SEM_UNDO;
 				goto out_of_range;
-			}
-			un->semadj[sop->sem_num] = undo;
 		}
-		if (curr->semval < 0)
-			goto would_block;
-		if (curr->semval > SEMVMX)
-			goto out_of_range;
+		curr->semval = result;
 	}
 
-	if (do_undo)
-	{
-		sop--;
+	if (do_undo) {
 		result = 0;
 		goto undo;
 	}
-
+	sop--;
+	while (sop >= sops) {
+		sma->sem_base[sop->sem_num].sempid = pid;
+		if (sop->sem_flg & SEM_UNDO)
+			un->semadj[sop->sem_num] -= sop->sem_op;
+		sop--;
+	}
 	sma->sem_otime = CURRENT_TIME;
 	return 0;
 
@@ -298,13 +298,9 @@
 		result = 1;
 
 undo:
+	sop--;
 	while (sop >= sops) {
-		curr = sma->sem_base + sop->sem_num;
-		curr->semval -= sop->sem_op;
-		curr->sempid >>= 16;
-
-		if (sop->sem_flg & SEM_UNDO)
-			un->semadj[sop->sem_num] += sop->sem_op;
+		sma->sem_base[sop->sem_num].semval -= sop->sem_op;
 		sop--;
 	}
 
@@ -624,7 +620,7 @@
 		err = curr->semval;
 		goto out_unlock;
 	case GETPID:
-		err = curr->sempid & 0xffff;
+		err = curr->sempid;
 		goto out_unlock;
 	case GETNCNT:
 		err = count_semncnt(sma,semnum);
@@ -839,6 +835,12 @@
 
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
@@ -846,6 +848,7 @@
 	struct sem_undo *un;
 	int undos = 0, decrease = 0, alter = 0;
 	struct sem_queue queue;
+	unsigned long jiffies_left = 0;
 
 	if (nsops < 1 || semid < 0)
 		return -EINVAL;
@@ -860,6 +863,19 @@
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
@@ -932,7 +948,10 @@
 		current->state = TASK_INTERRUPTIBLE;
 		sem_unlock(semid);
 
-		schedule();
+		if (timeout)
+			jiffies_left = schedule_timeout(jiffies_left);
+		else
+			schedule();
 
 		tmp = sem_lock(semid);
 		if(tmp==NULL) {
@@ -957,6 +976,8 @@
 				break;
 		} else {
 			error = queue.status;
+			if (error == -EINTR && timeout && jiffies_left == 0)
+				error = -EAGAIN;
 			if (queue.prev) /* got Interrupt */
 				break;
 			/* Everything done by update_queue */








