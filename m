Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbVKNVck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbVKNVck (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVKNVcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:32:39 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:15286 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932152AbVKNVcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:32:35 -0500
Message-Id: <20051114212527.130944000@sergelap>
References: <20051114212341.724084000@sergelap>
Date: Mon, 14 Nov 2005 15:23:46 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [RFC] [PATCH 05/13] Change pid accesses: ipc
Content-Disposition: inline; filename=B4-change-pid-tgid-references-ipc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace-Subject: Change pid accesses: ipc
From: Serge Hallyn <serue@us.ibm.com>

Change pid accesses for ipc/.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 ipc/mqueue.c |    8 ++++----
 ipc/msg.c    |    6 +++---
 ipc/sem.c    |    8 ++++----
 ipc/shm.c    |    6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

Index: linux-2.6.15-rc1/ipc/mqueue.c
===================================================================
--- linux-2.6.15-rc1.orig/ipc/mqueue.c
+++ linux-2.6.15-rc1/ipc/mqueue.c
@@ -359,7 +359,7 @@ static int mqueue_flush_file(struct file
 	struct mqueue_inode_info *info = MQUEUE_I(filp->f_dentry->d_inode);
 
 	spin_lock(&info->lock);
-	if (current->tgid == info->notify_owner)
+	if (task_tgid(current) == info->notify_owner)
 		remove_notification(info);
 
 	spin_unlock(&info->lock);
@@ -511,7 +511,7 @@ static void __do_notify(struct mqueue_in
 			sig_i.si_errno = 0;
 			sig_i.si_code = SI_MESGQ;
 			sig_i.si_value = info->notify.sigev_value;
-			sig_i.si_pid = current->tgid;
+			sig_i.si_pid = task_tgid(current);
 			sig_i.si_uid = current->uid;
 
 			kill_proc_info(info->notify.sigev_signo,
@@ -1034,7 +1034,7 @@ retry:
 	ret = 0;
 	spin_lock(&info->lock);
 	if (u_notification == NULL) {
-		if (info->notify_owner == current->tgid) {
+		if (info->notify_owner == task_tgid(current)) {
 			remove_notification(info);
 			inode->i_atime = inode->i_ctime = CURRENT_TIME;
 		}
@@ -1058,7 +1058,7 @@ retry:
 			info->notify.sigev_notify = SIGEV_SIGNAL;
 			break;
 		}
-		info->notify_owner = current->tgid;
+		info->notify_owner = task_tgid(current);
 		inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	}
 	spin_unlock(&info->lock);
Index: linux-2.6.15-rc1/ipc/msg.c
===================================================================
--- linux-2.6.15-rc1.orig/ipc/msg.c
+++ linux-2.6.15-rc1/ipc/msg.c
@@ -539,7 +539,7 @@ static inline int pipelined_send(struct 
 				msr->r_msg = ERR_PTR(-E2BIG);
 			} else {
 				msr->r_msg = NULL;
-				msq->q_lrpid = msr->r_tsk->pid;
+				msq->q_lrpid = task_pid(msr->r_tsk);
 				msq->q_rtime = get_seconds();
 				wake_up_process(msr->r_tsk);
 				smp_mb();
@@ -621,7 +621,7 @@ asmlinkage long sys_msgsnd (int msqid, s
 		}
 	}
 
-	msq->q_lspid = current->tgid;
+	msq->q_lspid = task_tgid(current);
 	msq->q_stime = get_seconds();
 
 	if(!pipelined_send(msq,msg)) {
@@ -717,7 +717,7 @@ asmlinkage long sys_msgrcv (int msqid, s
 			list_del(&msg->m_list);
 			msq->q_qnum--;
 			msq->q_rtime = get_seconds();
-			msq->q_lrpid = current->tgid;
+			msq->q_lrpid = task_tgid(current);
 			msq->q_cbytes -= msg->m_ts;
 			atomic_sub(msg->m_ts,&msg_bytes);
 			atomic_dec(&msg_hdrs);
Index: linux-2.6.15-rc1/ipc/sem.c
===================================================================
--- linux-2.6.15-rc1.orig/ipc/sem.c
+++ linux-2.6.15-rc1/ipc/sem.c
@@ -740,7 +740,7 @@ static int semctl_main(int semid, int se
 		for (un = sma->undo; un; un = un->id_next)
 			un->semadj[semnum] = 0;
 		curr->semval = val;
-		curr->sempid = current->tgid;
+		curr->sempid = task_tgid(current);
 		sma->sem_ctime = get_seconds();
 		/* maybe some queued-up processes were waiting for this */
 		update_queue(sma);
@@ -1132,7 +1132,7 @@ retry_undos:
 	if (error)
 		goto out_unlock_free;
 
-	error = try_atomic_semop (sma, sops, nsops, un, current->tgid);
+	error = try_atomic_semop (sma, sops, nsops, un, task_tgid(current));
 	if (error <= 0) {
 		if (alter && error == 0)
 			update_queue (sma);
@@ -1147,7 +1147,7 @@ retry_undos:
 	queue.sops = sops;
 	queue.nsops = nsops;
 	queue.undo = un;
-	queue.pid = current->tgid;
+	queue.pid = task_tgid(current);
 	queue.id = semid;
 	queue.alter = alter;
 	if (alter)
@@ -1317,7 +1317,7 @@ found:
 					sem->semval = 0;
 				if (sem->semval > SEMVMX)
 					sem->semval = SEMVMX;
-				sem->sempid = current->tgid;
+				sem->sempid = task_tgid(current);
 			}
 		}
 		sma->sem_otime = get_seconds();
Index: linux-2.6.15-rc1/ipc/shm.c
===================================================================
--- linux-2.6.15-rc1.orig/ipc/shm.c
+++ linux-2.6.15-rc1/ipc/shm.c
@@ -94,7 +94,7 @@ static inline void shm_inc (int id) {
 	if(!(shp = shm_lock(id)))
 		BUG();
 	shp->shm_atim = get_seconds();
-	shp->shm_lprid = current->tgid;
+	shp->shm_lprid = task_tgid(current);
 	shp->shm_nattch++;
 	shm_unlock(shp);
 }
@@ -144,7 +144,7 @@ static void shm_close (struct vm_area_st
 	/* remove from the list of attaches of the shm segment */
 	if(!(shp = shm_lock(id)))
 		BUG();
-	shp->shm_lprid = current->tgid;
+	shp->shm_lprid = task_tgid(current);
 	shp->shm_dtim = get_seconds();
 	shp->shm_nattch--;
 	if(shp->shm_nattch == 0 &&
@@ -232,7 +232,7 @@ static int newseg (key_t key, int shmflg
 	if(id == -1) 
 		goto no_id;
 
-	shp->shm_cprid = current->tgid;
+	shp->shm_cprid = task_tgid(current);
 	shp->shm_lprid = 0;
 	shp->shm_atim = shp->shm_dtim = 0;
 	shp->shm_ctim = get_seconds();

--

