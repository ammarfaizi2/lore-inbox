Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752470AbWCFXxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752470AbWCFXxW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 18:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbWCFXxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 18:53:08 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:51896 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752467AbWCFXxB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 18:53:01 -0500
Subject: [RFC][PATCH 2/6] sysvmsg: containerize
To: linux-kernel@vger.kernel.org
Cc: serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com,
       Herbert Poetzl <herbert@13thfloor.at>, Sam Vilain <sam@vilain.net>,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 06 Mar 2006 15:52:50 -0800
References: <20060306235248.20842700@localhost.localdomain>
In-Reply-To: <20060306235248.20842700@localhost.localdomain>
Message-Id: <20060306235250.35676515@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Take all of the global sysv msg context and put it inside of
a special structure.  This allows future work to give different
containers completely different views into the sysv space.

I'm still using the "_context" nomenclature here.  The consensus
seems to be to use something like "namespace".  Please speak up
if you have any other suggestions.  I'll fix it up before
submitting upstream.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 work-dave/desc.txt                  |    4 +
 work-dave/include/linux/init_task.h |    1 
 work-dave/include/linux/ipc.h       |    4 +
 work-dave/include/linux/sched.h     |    1 
 work-dave/ipc/msg.c                 |  138 ++++++++++++++++++------------------
 work-dave/ipc/util.c                |    8 +-
 work-dave/ipc/util.h                |   14 +++
 7 files changed, 99 insertions(+), 71 deletions(-)

diff -puN include/linux/init_task.h~sysvmsg-container include/linux/init_task.h
--- work/include/linux/init_task.h~sysvmsg-container	2006-03-06 15:41:56.000000000 -0800
+++ work-dave/include/linux/init_task.h	2006-03-06 15:41:56.000000000 -0800
@@ -2,6 +2,7 @@
 #define _LINUX__INIT_TASK_H
 
 #include <linux/file.h>
+#include <linux/ipc.h>
 #include <linux/rcupdate.h>
 
 #define INIT_FDTABLE \
diff -puN include/linux/ipc.h~sysvmsg-container include/linux/ipc.h
--- work/include/linux/ipc.h~sysvmsg-container	2006-03-06 15:41:56.000000000 -0800
+++ work-dave/include/linux/ipc.h	2006-03-06 15:41:56.000000000 -0800
@@ -68,6 +68,10 @@ struct kern_ipc_perm
 	void		*security;
 };
 
+struct ipc_context;
+extern struct ipc_context *ipc_context;
+
+extern struct ipc_msg_context *init_ipc_context(void);
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_IPC_H */
diff -puN include/linux/sched.h~sysvmsg-container include/linux/sched.h
--- work/include/linux/sched.h~sysvmsg-container	2006-03-06 15:41:56.000000000 -0800
+++ work-dave/include/linux/sched.h	2006-03-06 15:41:56.000000000 -0800
@@ -793,6 +793,7 @@ struct task_struct {
 	int link_count, total_link_count;
 /* ipc stuff */
 	struct sysv_sem sysvsem;
+	struct ipc_context *ipc_context;
 /* CPU-specific state of this task */
 	struct thread_struct thread;
 /* filesystem information */
diff -puN ipc/msg.c~sysvmsg-container ipc/msg.c
--- work/ipc/msg.c~sysvmsg-container	2006-03-06 15:41:56.000000000 -0800
+++ work-dave/ipc/msg.c	2006-03-06 15:41:56.000000000 -0800
@@ -60,35 +60,30 @@ struct msg_sender {
 #define SEARCH_NOTEQUAL		3
 #define SEARCH_LESSEQUAL	4
 
-static atomic_t msg_bytes = ATOMIC_INIT(0);
-static atomic_t msg_hdrs = ATOMIC_INIT(0);
+#define msg_lock(ctx, id)	((struct msg_queue*)ipc_lock(&ctx->ids,id))
+#define msg_unlock(ctx, msq)	ipc_unlock(&(msq)->q_perm)
+#define msg_rmid(ctx, id)	((struct msg_queue*)ipc_rmid(&ctx->ids,id))
+#define msg_checkid(ctx, msq, msgid)	\
+	ipc_checkid(&ctx->ids,&msq->q_perm,msgid)
+#define msg_buildid(ctx, id, seq) \
+	ipc_buildid(&ctx->ids, id, seq)
 
-static struct ipc_ids msg_ids;
-
-#define msg_lock(id)	((struct msg_queue*)ipc_lock(&msg_ids,id))
-#define msg_unlock(msq)	ipc_unlock(&(msq)->q_perm)
-#define msg_rmid(id)	((struct msg_queue*)ipc_rmid(&msg_ids,id))
-#define msg_checkid(msq, msgid)	\
-	ipc_checkid(&msg_ids,&msq->q_perm,msgid)
-#define msg_buildid(id, seq) \
-	ipc_buildid(&msg_ids, id, seq)
-
-static void freeque (struct msg_queue *msq, int id);
-static int newque (key_t key, int msgflg);
+static void freeque (struct ipc_msg_context *, struct msg_queue *msq, int id);
+static int newque (struct ipc_msg_context *context, key_t key, int id);
 #ifdef CONFIG_PROC_FS
 static int sysvipc_msg_proc_show(struct seq_file *s, void *it);
 #endif
 
-void __init msg_init (void)
+void __init msg_init (struct ipc_msg_context *context)
 {
-	ipc_init_ids(&msg_ids,msg_ctlmni);
+	ipc_init_ids(&context->ids,msg_ctlmni);
 	ipc_init_proc_interface("sysvipc/msg",
 				"       key      msqid perms      cbytes       qnum lspid lrpid   uid   gid  cuid  cgid      stime      rtime      ctime\n",
-				&msg_ids,
+				&context->ids,
 				sysvipc_msg_proc_show);
 }
 
-static int newque (key_t key, int msgflg)
+static int newque (struct ipc_msg_context *context, key_t key, int msgflg)
 {
 	int id;
 	int retval;
@@ -108,14 +103,14 @@ static int newque (key_t key, int msgflg
 		return retval;
 	}
 
-	id = ipc_addid(&msg_ids, &msq->q_perm, msg_ctlmni);
+	id = ipc_addid(&context->ids, &msq->q_perm, msg_ctlmni);
 	if(id == -1) {
 		security_msg_queue_free(msq);
 		ipc_rcu_putref(msq);
 		return -ENOSPC;
 	}
 
-	msq->q_id = msg_buildid(id,msq->q_perm.seq);
+	msq->q_id = msg_buildid(context,id,msq->q_perm.seq);
 	msq->q_stime = msq->q_rtime = 0;
 	msq->q_ctime = get_seconds();
 	msq->q_cbytes = msq->q_qnum = 0;
@@ -124,7 +119,7 @@ static int newque (key_t key, int msgflg
 	INIT_LIST_HEAD(&msq->q_messages);
 	INIT_LIST_HEAD(&msq->q_receivers);
 	INIT_LIST_HEAD(&msq->q_senders);
-	msg_unlock(msq);
+	msg_unlock(context, msq);
 
 	return msq->q_id;
 }
@@ -182,23 +177,24 @@ static void expunge_all(struct msg_queue
  * msg_ids.sem and the spinlock for this message queue is hold
  * before freeque() is called. msg_ids.sem remains locked on exit.
  */
-static void freeque (struct msg_queue *msq, int id)
+static void freeque (struct ipc_msg_context *context,
+		     struct msg_queue *msq, int id)
 {
 	struct list_head *tmp;
 
 	expunge_all(msq,-EIDRM);
 	ss_wakeup(&msq->q_senders,1);
-	msq = msg_rmid(id);
-	msg_unlock(msq);
+	msq = msg_rmid(context, id);
+	msg_unlock(context, msq);
 		
 	tmp = msq->q_messages.next;
 	while(tmp != &msq->q_messages) {
 		struct msg_msg* msg = list_entry(tmp,struct msg_msg,m_list);
 		tmp = tmp->next;
-		atomic_dec(&msg_hdrs);
+		atomic_dec(&context->hdrs);
 		free_msg(msg);
 	}
-	atomic_sub(msq->q_cbytes, &msg_bytes);
+	atomic_sub(msq->q_cbytes, &context->bytes);
 	security_msg_queue_free(msq);
 	ipc_rcu_putref(msq);
 }
@@ -207,32 +203,34 @@ asmlinkage long sys_msgget (key_t key, i
 {
 	int id, ret = -EPERM;
 	struct msg_queue *msq;
-	
-	down(&msg_ids.sem);
+	struct ipc_msg_context *context = &current->ipc_context->msg;
+
+	down(&context->ids.sem);
 	if (key == IPC_PRIVATE) 
-		ret = newque(key, msgflg);
-	else if ((id = ipc_findkey(&msg_ids, key)) == -1) { /* key not used */
+		ret = newque(context, key, msgflg);
+	else if ((id = ipc_findkey(&context->ids, key)) == -1) {
+		/* key not used */
 		if (!(msgflg & IPC_CREAT))
 			ret = -ENOENT;
 		else
-			ret = newque(key, msgflg);
+			ret = newque(context, key, msgflg);
 	} else if (msgflg & IPC_CREAT && msgflg & IPC_EXCL) {
 		ret = -EEXIST;
 	} else {
-		msq = msg_lock(id);
+		msq = msg_lock(context, id);
 		if(msq==NULL)
 			BUG();
 		if (ipcperms(&msq->q_perm, msgflg))
 			ret = -EACCES;
 		else {
-			int qid = msg_buildid(id, msq->q_perm.seq);
+			int qid = msg_buildid(context, id, msq->q_perm.seq);
 		    	ret = security_msg_queue_associate(msq, msgflg);
 			if (!ret)
 				ret = qid;
 		}
-		msg_unlock(msq);
+		msg_unlock(context, msq);
 	}
-	up(&msg_ids.sem);
+	up(&context->ids.sem);
 	return ret;
 }
 
@@ -333,6 +331,7 @@ asmlinkage long sys_msgctl (int msqid, i
 	struct msg_queue *msq;
 	struct msq_setbuf setbuf;
 	struct kern_ipc_perm *ipcp;
+	struct ipc_msg_context *context = &current->ipc_context->msg;
 	
 	if (msqid < 0 || cmd < 0)
 		return -EINVAL;
@@ -362,18 +361,18 @@ asmlinkage long sys_msgctl (int msqid, i
 		msginfo.msgmnb = msg_ctlmnb;
 		msginfo.msgssz = MSGSSZ;
 		msginfo.msgseg = MSGSEG;
-		down(&msg_ids.sem);
+		down(&context->ids.sem);
 		if (cmd == MSG_INFO) {
-			msginfo.msgpool = msg_ids.in_use;
-			msginfo.msgmap = atomic_read(&msg_hdrs);
-			msginfo.msgtql = atomic_read(&msg_bytes);
+			msginfo.msgpool = context->ids.in_use;
+			msginfo.msgmap = atomic_read(&context->hdrs);
+			msginfo.msgtql = atomic_read(&context->bytes);
 		} else {
 			msginfo.msgmap = MSGMAP;
 			msginfo.msgpool = MSGPOOL;
 			msginfo.msgtql = MSGTQL;
 		}
-		max_id = msg_ids.max_id;
-		up(&msg_ids.sem);
+		max_id = context->ids.max_id;
+		up(&context->ids.sem);
 		if (copy_to_user (buf, &msginfo, sizeof(struct msginfo)))
 			return -EFAULT;
 		return (max_id < 0) ? 0: max_id;
@@ -385,20 +384,21 @@ asmlinkage long sys_msgctl (int msqid, i
 		int success_return;
 		if (!buf)
 			return -EFAULT;
-		if(cmd == MSG_STAT && msqid >= msg_ids.entries->size)
+		if(cmd == MSG_STAT && msqid >= context->ids.entries->size)
 			return -EINVAL;
 
 		memset(&tbuf,0,sizeof(tbuf));
 
-		msq = msg_lock(msqid);
+		msq = msg_lock(context, msqid);
 		if (msq == NULL)
 			return -EINVAL;
 
 		if(cmd == MSG_STAT) {
-			success_return = msg_buildid(msqid, msq->q_perm.seq);
+			success_return =
+				msg_buildid(context, msqid, msq->q_perm.seq);
 		} else {
 			err = -EIDRM;
-			if (msg_checkid(msq,msqid))
+			if (msg_checkid(context,msq,msqid))
 				goto out_unlock;
 			success_return = 0;
 		}
@@ -419,7 +419,7 @@ asmlinkage long sys_msgctl (int msqid, i
 		tbuf.msg_qbytes = msq->q_qbytes;
 		tbuf.msg_lspid  = msq->q_lspid;
 		tbuf.msg_lrpid  = msq->q_lrpid;
-		msg_unlock(msq);
+		msg_unlock(context, msq);
 		if (copy_msqid_to_user(buf, &tbuf, version))
 			return -EFAULT;
 		return success_return;
@@ -438,14 +438,14 @@ asmlinkage long sys_msgctl (int msqid, i
 		return  -EINVAL;
 	}
 
-	down(&msg_ids.sem);
-	msq = msg_lock(msqid);
+	down(&context->ids.sem);
+	msq = msg_lock(context, msqid);
 	err=-EINVAL;
 	if (msq == NULL)
 		goto out_up;
 
 	err = -EIDRM;
-	if (msg_checkid(msq,msqid))
+	if (msg_checkid(context,msq,msqid))
 		goto out_unlock_up;
 	ipcp = &msq->q_perm;
 	err = -EPERM;
@@ -480,22 +480,22 @@ asmlinkage long sys_msgctl (int msqid, i
 		 * due to a larger queue size.
 		 */
 		ss_wakeup(&msq->q_senders,0);
-		msg_unlock(msq);
+		msg_unlock(context, msq);
 		break;
 	}
 	case IPC_RMID:
-		freeque (msq, msqid); 
+		freeque (context, msq, msqid);
 		break;
 	}
 	err = 0;
 out_up:
-	up(&msg_ids.sem);
+	up(&context->ids.sem);
 	return err;
 out_unlock_up:
-	msg_unlock(msq);
+	msg_unlock(context, msq);
 	goto out_up;
 out_unlock:
-	msg_unlock(msq);
+	msg_unlock(context, msq);
 	return err;
 }
 
@@ -558,7 +558,8 @@ asmlinkage long sys_msgsnd (int msqid, s
 	struct msg_msg *msg;
 	long mtype;
 	int err;
-	
+	struct ipc_msg_context *context = &current->ipc_context->msg;
+
 	if (msgsz > msg_ctlmax || (long) msgsz < 0 || msqid < 0)
 		return -EINVAL;
 	if (get_user(mtype, &msgp->mtype))
@@ -573,13 +574,13 @@ asmlinkage long sys_msgsnd (int msqid, s
 	msg->m_type = mtype;
 	msg->m_ts = msgsz;
 
-	msq = msg_lock(msqid);
+	msq = msg_lock(context, msqid);
 	err=-EINVAL;
 	if(msq==NULL)
 		goto out_free;
 
 	err= -EIDRM;
-	if (msg_checkid(msq,msqid))
+	if (msg_checkid(context,msq,msqid))
 		goto out_unlock_free;
 
 	for (;;) {
@@ -605,7 +606,7 @@ asmlinkage long sys_msgsnd (int msqid, s
 		}
 		ss_add(msq, &s);
 		ipc_rcu_getref(msq);
-		msg_unlock(msq);
+		msg_unlock(context, msq);
 		schedule();
 
 		ipc_lock_by_ptr(&msq->q_perm);
@@ -630,15 +631,15 @@ asmlinkage long sys_msgsnd (int msqid, s
 		list_add_tail(&msg->m_list,&msq->q_messages);
 		msq->q_cbytes += msgsz;
 		msq->q_qnum++;
-		atomic_add(msgsz,&msg_bytes);
-		atomic_inc(&msg_hdrs);
+		atomic_add(msgsz,&context->bytes);
+		atomic_inc(&context->hdrs);
 	}
 	
 	err = 0;
 	msg = NULL;
 
 out_unlock_free:
-	msg_unlock(msq);
+	msg_unlock(context, msq);
 out_free:
 	if(msg!=NULL)
 		free_msg(msg);
@@ -670,17 +671,18 @@ asmlinkage long sys_msgrcv (int msqid, s
 	struct msg_queue *msq;
 	struct msg_msg *msg;
 	int mode;
+	struct ipc_msg_context *context = &current->ipc_context->msg;
 
 	if (msqid < 0 || (long) msgsz < 0)
 		return -EINVAL;
 	mode = convert_mode(&msgtyp,msgflg);
 
-	msq = msg_lock(msqid);
+	msq = msg_lock(context, msqid);
 	if(msq==NULL)
 		return -EINVAL;
 
 	msg = ERR_PTR(-EIDRM);
-	if (msg_checkid(msq,msqid))
+	if (msg_checkid(context,msq,msqid))
 		goto out_unlock;
 
 	for (;;) {
@@ -720,10 +722,10 @@ asmlinkage long sys_msgrcv (int msqid, s
 			msq->q_rtime = get_seconds();
 			msq->q_lrpid = current->tgid;
 			msq->q_cbytes -= msg->m_ts;
-			atomic_sub(msg->m_ts,&msg_bytes);
-			atomic_dec(&msg_hdrs);
+			atomic_sub(msg->m_ts,&context->bytes);
+			atomic_dec(&context->hdrs);
 			ss_wakeup(&msq->q_senders,0);
-			msg_unlock(msq);
+			msg_unlock(context, msq);
 			break;
 		}
 		/* No message waiting. Wait for a message */
@@ -741,7 +743,7 @@ asmlinkage long sys_msgrcv (int msqid, s
 			msr_d.r_maxsize = msgsz;
 		msr_d.r_msg = ERR_PTR(-EAGAIN);
 		current->state = TASK_INTERRUPTIBLE;
-		msg_unlock(msq);
+		msg_unlock(context, msq);
 
 		schedule();
 
@@ -794,7 +796,7 @@ asmlinkage long sys_msgrcv (int msqid, s
 		if (signal_pending(current)) {
 			msg = ERR_PTR(-ERESTARTNOHAND);
 out_unlock:
-			msg_unlock(msq);
+			msg_unlock(context, msq);
 			break;
 		}
 	}
diff -puN ipc/util.c~sysvmsg-container ipc/util.c
--- work/ipc/util.c~sysvmsg-container	2006-03-06 15:41:56.000000000 -0800
+++ work-dave/ipc/util.c	2006-03-06 15:41:56.000000000 -0800
@@ -45,11 +45,15 @@ struct ipc_proc_iface {
  *	The various system5 IPC resources (semaphores, messages and shared
  *	memory are initialised
  */
- 
+
 static int __init ipc_init(void)
 {
+	init_task.ipc_context = kzalloc(sizeof(*ipc_context), GFP_KERNEL);
+	if (!init_task.ipc_context)
+		return -ENOMEM;
+
 	sem_init();
-	msg_init();
+	msg_init(&init_task.ipc_context->msg);
 	shm_init();
 	return 0;
 }
diff -puN ipc/util.h~sysvmsg-container ipc/util.h
--- work/ipc/util.h~sysvmsg-container	2006-03-06 15:41:56.000000000 -0800
+++ work-dave/ipc/util.h	2006-03-06 15:41:56.000000000 -0800
@@ -12,7 +12,7 @@
 #define SEQ_MULTIPLIER	(IPCMNI)
 
 void sem_init (void);
-void msg_init (void);
+void msg_init (struct ipc_msg_context *context);
 void shm_init (void);
 
 struct ipc_id_ary {
@@ -30,6 +30,18 @@ struct ipc_ids {
 	struct ipc_id_ary* entries;
 };
 
+struct ipc_msg_context {
+	atomic_t bytes;
+	atomic_t hdrs;
+
+	struct ipc_ids ids;
+	struct kref count;
+};
+
+struct ipc_context {
+	struct ipc_msg_context msg;
+};
+
 struct seq_file;
 void __init ipc_init_ids(struct ipc_ids* ids, int size);
 #ifdef CONFIG_PROC_FS
diff -puN kernel/sysctl.c~sysvmsg-container kernel/sysctl.c
diff -puN /dev/null desc.txt
--- /dev/null	2005-03-30 22:36:15.000000000 -0800
+++ work-dave/desc.txt	2006-03-06 15:41:56.000000000 -0800
@@ -0,0 +1,4 @@
+DESC
+support namespaces for sysv
+EDESC
+
_
