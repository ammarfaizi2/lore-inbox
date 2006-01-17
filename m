Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751165AbWAQOu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbWAQOu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWAQOuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:50:51 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:19363 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751005AbWAQOua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:30 -0500
Message-Id: <20060117143324.863217000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:03 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 05/34] PID Virtualization Change pid accesses: ipc
Content-Disposition: inline; filename=B4-change-pid-tgid-references-ipc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change pid accesses for ipc/.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 mqueue.c |    8 ++++----
 msg.c    |    6 +++---
 sem.c    |    8 ++++----
 shm.c    |    6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

Index: linux-2.6.15/ipc/mqueue.c
===================================================================
--- linux-2.6.15.orig/ipc/mqueue.c	2006-01-17 08:36:28.000000000 -0500
+++ linux-2.6.15/ipc/mqueue.c	2006-01-17 08:36:59.000000000 -0500
@@ -359,7 +359,7 @@
 	struct mqueue_inode_info *info = MQUEUE_I(filp->f_dentry->d_inode);
 
 	spin_lock(&info->lock);
-	if (current->tgid == info->notify_owner)
+	if (task_tgid(current) == info->notify_owner)
 		remove_notification(info);
 
 	spin_unlock(&info->lock);
@@ -511,7 +511,7 @@
 			sig_i.si_errno = 0;
 			sig_i.si_code = SI_MESGQ;
 			sig_i.si_value = info->notify.sigev_value;
-			sig_i.si_pid = current->tgid;
+			sig_i.si_pid = task_tgid(current);
 			sig_i.si_uid = current->uid;
 
 			kill_proc_info(info->notify.sigev_signo,
@@ -1034,7 +1034,7 @@
 	ret = 0;
 	spin_lock(&info->lock);
 	if (u_notification == NULL) {
-		if (info->notify_owner == current->tgid) {
+		if (info->notify_owner == task_tgid(current)) {
 			remove_notification(info);
 			inode->i_atime = inode->i_ctime = CURRENT_TIME;
 		}
@@ -1058,7 +1058,7 @@
 			info->notify.sigev_notify = SIGEV_SIGNAL;
 			break;
 		}
-		info->notify_owner = current->tgid;
+		info->notify_owner = task_tgid(current);
 		inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	}
 	spin_unlock(&info->lock);
Index: linux-2.6.15/ipc/msg.c
===================================================================
--- linux-2.6.15.orig/ipc/msg.c	2006-01-17 08:36:28.000000000 -0500
+++ linux-2.6.15/ipc/msg.c	2006-01-17 08:36:59.000000000 -0500
@@ -539,7 +539,7 @@
 				msr->r_msg = ERR_PTR(-E2BIG);
 			} else {
 				msr->r_msg = NULL;
-				msq->q_lrpid = msr->r_tsk->pid;
+				msq->q_lrpid = task_pid(msr->r_tsk);
 				msq->q_rtime = get_seconds();
 				wake_up_process(msr->r_tsk);
 				smp_mb();
@@ -621,7 +621,7 @@
 		}
 	}
 
-	msq->q_lspid = current->tgid;
+	msq->q_lspid = task_tgid(current);
 	msq->q_stime = get_seconds();
 
 	if(!pipelined_send(msq,msg)) {
@@ -717,7 +717,7 @@
 			list_del(&msg->m_list);
 			msq->q_qnum--;
 			msq->q_rtime = get_seconds();
-			msq->q_lrpid = current->tgid;
+			msq->q_lrpid = task_tgid(current);
 			msq->q_cbytes -= msg->m_ts;
 			atomic_sub(msg->m_ts,&msg_bytes);
 			atomic_dec(&msg_hdrs);
Index: linux-2.6.15/ipc/sem.c
===================================================================
--- linux-2.6.15.orig/ipc/sem.c	2006-01-17 08:36:28.000000000 -0500
+++ linux-2.6.15/ipc/sem.c	2006-01-17 08:36:59.000000000 -0500
@@ -742,7 +742,7 @@
 		for (un = sma->undo; un; un = un->id_next)
 			un->semadj[semnum] = 0;
 		curr->semval = val;
-		curr->sempid = current->tgid;
+		curr->sempid = task_tgid(current);
 		sma->sem_ctime = get_seconds();
 		/* maybe some queued-up processes were waiting for this */
 		update_queue(sma);
@@ -1134,7 +1134,7 @@
 	if (error)
 		goto out_unlock_free;
 
-	error = try_atomic_semop (sma, sops, nsops, un, current->tgid);
+	error = try_atomic_semop (sma, sops, nsops, un, task_tgid(current));
 	if (error <= 0) {
 		if (alter && error == 0)
 			update_queue (sma);
@@ -1149,7 +1149,7 @@
 	queue.sops = sops;
 	queue.nsops = nsops;
 	queue.undo = un;
-	queue.pid = current->tgid;
+	queue.pid = task_tgid(current);
 	queue.id = semid;
 	queue.alter = alter;
 	if (alter)
@@ -1319,7 +1319,7 @@
 					sem->semval = 0;
 				if (sem->semval > SEMVMX)
 					sem->semval = SEMVMX;
-				sem->sempid = current->tgid;
+				sem->sempid = task_tgid(current);
 			}
 		}
 		sma->sem_otime = get_seconds();
Index: linux-2.6.15/ipc/shm.c
===================================================================
--- linux-2.6.15.orig/ipc/shm.c	2006-01-17 08:36:28.000000000 -0500
+++ linux-2.6.15/ipc/shm.c	2006-01-17 08:36:59.000000000 -0500
@@ -94,7 +94,7 @@
 	if(!(shp = shm_lock(id)))
 		BUG();
 	shp->shm_atim = get_seconds();
-	shp->shm_lprid = current->tgid;
+	shp->shm_lprid = task_tgid(current);
 	shp->shm_nattch++;
 	shm_unlock(shp);
 }
@@ -144,7 +144,7 @@
 	/* remove from the list of attaches of the shm segment */
 	if(!(shp = shm_lock(id)))
 		BUG();
-	shp->shm_lprid = current->tgid;
+	shp->shm_lprid = task_tgid(current);
 	shp->shm_dtim = get_seconds();
 	shp->shm_nattch--;
 	if(shp->shm_nattch == 0 &&
@@ -232,7 +232,7 @@
 	if(id == -1) 
 		goto no_id;
 
-	shp->shm_cprid = current->tgid;
+	shp->shm_cprid = task_tgid(current);
 	shp->shm_lprid = 0;
 	shp->shm_atim = shp->shm_dtim = 0;
 	shp->shm_ctim = get_seconds();

--

