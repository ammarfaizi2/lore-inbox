Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266383AbTGEQFd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 12:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266386AbTGEQFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 12:05:33 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10115
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S266383AbTGEQFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 12:05:10 -0400
Date: Sat, 5 Jul 2003 17:18:28 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307051618.h65GIS57003382@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: PATCH: (resend) collected semaphore fixes and semtimedop
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --exclude-from /usr/src/exclude -u --recursive linux.22-bk2/ipc/sem.c linux.22-pre2-ac1/ipc/sem.c
--- linux.22-bk2/ipc/sem.c	2003-07-05 16:58:37.000000000 +0100
+++ linux.22-pre2-ac1/ipc/sem.c	2003-06-29 16:09:50.000000000 +0100
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
