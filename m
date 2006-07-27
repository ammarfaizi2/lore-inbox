Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWG0N72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWG0N72 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 09:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWG0N72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 09:59:28 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:15025 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751099AbWG0N71 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 09:59:27 -0400
Date: Thu, 27 Jul 2006 15:53:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] ipc/msg.c: clean up coding style
Message-ID: <20060727135321.GA24644@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.3 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] ipc/msg.c: clean up coding style
From: Ingo Molnar <mingo@elte.hu>

clean up ipc/msg.c to conform to Documentation/CodingStyle. (before it
was an inconsistent hodepodge of various coding styles)

verified that the before/after .o's are identical.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 ipc/msg.c |  389 ++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 205 insertions(+), 184 deletions(-)

Index: linux/ipc/msg.c
===================================================================
--- linux.orig/ipc/msg.c
+++ linux/ipc/msg.c
@@ -1,6 +1,6 @@
 /*
  * linux/ipc/msg.c
- * Copyright (C) 1992 Krishna Balasubramanian 
+ * Copyright (C) 1992 Krishna Balasubramanian
  *
  * Removed all the remaining kerneld mess
  * Catch the -EFAULT stuff properly
@@ -41,22 +41,24 @@ int msg_ctlmax = MSGMAX;
 int msg_ctlmnb = MSGMNB;
 int msg_ctlmni = MSGMNI;
 
-/* one msg_receiver structure for each sleeping receiver */
+/*
+ * one msg_receiver structure for each sleeping receiver:
+ */
 struct msg_receiver {
-	struct list_head r_list;
-	struct task_struct* r_tsk;
+	struct list_head	r_list;
+	struct task_struct	*r_tsk;
 
-	int r_mode;
-	long r_msgtype;
-	long r_maxsize;
+	int			r_mode;
+	long			r_msgtype;
+	long			r_maxsize;
 
-	struct msg_msg* volatile r_msg;
+	volatile struct msg_msg	*r_msg;
 };
 
 /* one msg_sender for each sleeping sender */
 struct msg_sender {
-	struct list_head list;
-	struct task_struct* tsk;
+	struct list_head	list;
+	struct task_struct	*tsk;
 };
 
 #define SEARCH_ANY		1
@@ -64,45 +66,42 @@ struct msg_sender {
 #define SEARCH_NOTEQUAL		3
 #define SEARCH_LESSEQUAL	4
 
-static atomic_t msg_bytes = ATOMIC_INIT(0);
-static atomic_t msg_hdrs = ATOMIC_INIT(0);
+static atomic_t msg_bytes =	ATOMIC_INIT(0);
+static atomic_t msg_hdrs =	ATOMIC_INIT(0);
 
 static struct ipc_ids msg_ids;
 
-#define msg_lock(id)	((struct msg_queue*)ipc_lock(&msg_ids,id))
-#define msg_unlock(msq)	ipc_unlock(&(msq)->q_perm)
-#define msg_rmid(id)	((struct msg_queue*)ipc_rmid(&msg_ids,id))
-#define msg_checkid(msq, msgid)	\
-	ipc_checkid(&msg_ids,&msq->q_perm,msgid)
-#define msg_buildid(id, seq) \
-	ipc_buildid(&msg_ids, id, seq)
+#define msg_lock(id)		((struct msg_queue *)ipc_lock(&msg_ids, id))
+#define msg_unlock(msq)		ipc_unlock(&(msq)->q_perm)
+#define msg_rmid(id)		((struct msg_queue *)ipc_rmid(&msg_ids, id))
+#define msg_checkid(msq, msgid)	ipc_checkid(&msg_ids, &msq->q_perm, msgid)
+#define msg_buildid(id, seq)	ipc_buildid(&msg_ids, id, seq)
 
-static void freeque (struct msg_queue *msq, int id);
-static int newque (key_t key, int msgflg);
+static void freeque(struct msg_queue *msq, int id);
+static int newque(key_t key, int msgflg);
 #ifdef CONFIG_PROC_FS
 static int sysvipc_msg_proc_show(struct seq_file *s, void *it);
 #endif
 
-void __init msg_init (void)
+void __init msg_init(void)
 {
-	ipc_init_ids(&msg_ids,msg_ctlmni);
+	ipc_init_ids(&msg_ids, msg_ctlmni);
 	ipc_init_proc_interface("sysvipc/msg",
 				"       key      msqid perms      cbytes       qnum lspid lrpid   uid   gid  cuid  cgid      stime      rtime      ctime\n",
 				&msg_ids,
 				sysvipc_msg_proc_show);
 }
 
-static int newque (key_t key, int msgflg)
+static int newque(key_t key, int msgflg)
 {
-	int id;
-	int retval;
 	struct msg_queue *msq;
+	int id, retval;
 
-	msq  = ipc_rcu_alloc(sizeof(*msq));
-	if (!msq) 
+	msq = ipc_rcu_alloc(sizeof(*msq));
+	if (!msq)
 		return -ENOMEM;
 
-	msq->q_perm.mode = (msgflg & S_IRWXUGO);
+	msq->q_perm.mode = msgflg & S_IRWXUGO;
 	msq->q_perm.key = key;
 
 	msq->q_perm.security = NULL;
@@ -113,13 +112,13 @@ static int newque (key_t key, int msgflg
 	}
 
 	id = ipc_addid(&msg_ids, &msq->q_perm, msg_ctlmni);
-	if(id == -1) {
+	if (id == -1) {
 		security_msg_queue_free(msq);
 		ipc_rcu_putref(msq);
 		return -ENOSPC;
 	}
 
-	msq->q_id = msg_buildid(id,msq->q_perm.seq);
+	msq->q_id = msg_buildid(id, msq->q_perm.seq);
 	msq->q_stime = msq->q_rtime = 0;
 	msq->q_ctime = get_seconds();
 	msq->q_cbytes = msq->q_qnum = 0;
@@ -133,44 +132,44 @@ static int newque (key_t key, int msgflg
 	return msq->q_id;
 }
 
-static inline void ss_add(struct msg_queue* msq, struct msg_sender* mss)
+static inline void ss_add(struct msg_queue *msq, struct msg_sender *mss)
 {
-	mss->tsk=current;
-	current->state=TASK_INTERRUPTIBLE;
-	list_add_tail(&mss->list,&msq->q_senders);
+	mss->tsk = current;
+	current->state = TASK_INTERRUPTIBLE;
+	list_add_tail(&mss->list, &msq->q_senders);
 }
 
-static inline void ss_del(struct msg_sender* mss)
+static inline void ss_del(struct msg_sender *mss)
 {
-	if(mss->list.next != NULL)
+	if (mss->list.next != NULL)
 		list_del(&mss->list);
 }
 
-static void ss_wakeup(struct list_head* h, int kill)
+static void ss_wakeup(struct list_head *h, int kill)
 {
 	struct list_head *tmp;
 
 	tmp = h->next;
 	while (tmp != h) {
-		struct msg_sender* mss;
-		
-		mss = list_entry(tmp,struct msg_sender,list);
+		struct msg_sender *mss;
+
+		mss = list_entry(tmp, struct msg_sender, list);
 		tmp = tmp->next;
-		if(kill)
-			mss->list.next=NULL;
+		if (kill)
+			mss->list.next = NULL;
 		wake_up_process(mss->tsk);
 	}
 }
 
-static void expunge_all(struct msg_queue* msq, int res)
+static void expunge_all(struct msg_queue *msq, int res)
 {
 	struct list_head *tmp;
 
 	tmp = msq->q_receivers.next;
 	while (tmp != &msq->q_receivers) {
-		struct msg_receiver* msr;
-		
-		msr = list_entry(tmp,struct msg_receiver,r_list);
+		struct msg_receiver *msr;
+
+		msr = list_entry(tmp, struct msg_receiver, r_list);
 		tmp = tmp->next;
 		msr->r_msg = NULL;
 		wake_up_process(msr->r_tsk);
@@ -178,26 +177,28 @@ static void expunge_all(struct msg_queue
 		msr->r_msg = ERR_PTR(res);
 	}
 }
-/* 
- * freeque() wakes up waiters on the sender and receiver waiting queue, 
- * removes the message queue from message queue ID 
+
+/*
+ * freeque() wakes up waiters on the sender and receiver waiting queue,
+ * removes the message queue from message queue ID
  * array, and cleans up all the messages associated with this queue.
  *
  * msg_ids.mutex and the spinlock for this message queue is hold
  * before freeque() is called. msg_ids.mutex remains locked on exit.
  */
-static void freeque (struct msg_queue *msq, int id)
+static void freeque(struct msg_queue *msq, int id)
 {
 	struct list_head *tmp;
 
-	expunge_all(msq,-EIDRM);
-	ss_wakeup(&msq->q_senders,1);
+	expunge_all(msq, -EIDRM);
+	ss_wakeup(&msq->q_senders, 1);
 	msq = msg_rmid(id);
 	msg_unlock(msq);
-		
+
 	tmp = msq->q_messages.next;
-	while(tmp != &msq->q_messages) {
-		struct msg_msg* msg = list_entry(tmp,struct msg_msg,m_list);
+	while (tmp != &msq->q_messages) {
+		struct msg_msg *msg = list_entry(tmp, struct msg_msg, m_list);
+
 		tmp = tmp->next;
 		atomic_dec(&msg_hdrs);
 		free_msg(msg);
@@ -207,10 +208,10 @@ static void freeque (struct msg_queue *m
 	ipc_rcu_putref(msq);
 }
 
-asmlinkage long sys_msgget (key_t key, int msgflg)
+asmlinkage long sys_msgget(key_t key, int msgflg)
 {
-	int id, ret = -EPERM;
 	struct msg_queue *msq;
+	int id, ret = -EPERM;
 	
 	mutex_lock(&msg_ids.mutex);
 	if (key == IPC_PRIVATE) 
@@ -224,31 +225,34 @@ asmlinkage long sys_msgget (key_t key, i
 		ret = -EEXIST;
 	} else {
 		msq = msg_lock(id);
-		BUG_ON(msq==NULL);
+		BUG_ON(msq == NULL);
 		if (ipcperms(&msq->q_perm, msgflg))
 			ret = -EACCES;
 		else {
 			int qid = msg_buildid(id, msq->q_perm.seq);
-		    	ret = security_msg_queue_associate(msq, msgflg);
+
+			ret = security_msg_queue_associate(msq, msgflg);
 			if (!ret)
 				ret = qid;
 		}
 		msg_unlock(msq);
 	}
 	mutex_unlock(&msg_ids.mutex);
+
 	return ret;
 }
 
-static inline unsigned long copy_msqid_to_user(void __user *buf, struct msqid64_ds *in, int version)
+static inline unsigned long
+copy_msqid_to_user(void __user *buf, struct msqid64_ds *in, int version)
 {
 	switch(version) {
 	case IPC_64:
-		return copy_to_user (buf, in, sizeof(*in));
+		return copy_to_user(buf, in, sizeof(*in));
 	case IPC_OLD:
-	    {
+	{
 		struct msqid_ds out;
 
-		memset(&out,0,sizeof(out));
+		memset(&out, 0, sizeof(out));
 
 		ipc64_perm_to_ipc_perm(&in->msg_perm, &out.msg_perm);
 
@@ -256,18 +260,18 @@ static inline unsigned long copy_msqid_t
 		out.msg_rtime		= in->msg_rtime;
 		out.msg_ctime		= in->msg_ctime;
 
-		if(in->msg_cbytes > USHRT_MAX)
+		if (in->msg_cbytes > USHRT_MAX)
 			out.msg_cbytes	= USHRT_MAX;
 		else
 			out.msg_cbytes	= in->msg_cbytes;
 		out.msg_lcbytes		= in->msg_cbytes;
 
-		if(in->msg_qnum > USHRT_MAX)
+		if (in->msg_qnum > USHRT_MAX)
 			out.msg_qnum	= USHRT_MAX;
 		else
 			out.msg_qnum	= in->msg_qnum;
 
-		if(in->msg_qbytes > USHRT_MAX)
+		if (in->msg_qbytes > USHRT_MAX)
 			out.msg_qbytes	= USHRT_MAX;
 		else
 			out.msg_qbytes	= in->msg_qbytes;
@@ -276,8 +280,8 @@ static inline unsigned long copy_msqid_t
 		out.msg_lspid		= in->msg_lspid;
 		out.msg_lrpid		= in->msg_lrpid;
 
-		return copy_to_user (buf, &out, sizeof(out));
-	    }
+		return copy_to_user(buf, &out, sizeof(out));
+	}
 	default:
 		return -EINVAL;
 	}
@@ -290,14 +294,15 @@ struct msq_setbuf {
 	mode_t		mode;
 };
 
-static inline unsigned long copy_msqid_from_user(struct msq_setbuf *out, void __user *buf, int version)
+static inline unsigned long
+copy_msqid_from_user(struct msq_setbuf *out, void __user *buf, int version)
 {
 	switch(version) {
 	case IPC_64:
-	    {
+	{
 		struct msqid64_ds tbuf;
 
-		if (copy_from_user (&tbuf, buf, sizeof (tbuf)))
+		if (copy_from_user(&tbuf, buf, sizeof(tbuf)))
 			return -EFAULT;
 
 		out->qbytes		= tbuf.msg_qbytes;
@@ -306,60 +311,61 @@ static inline unsigned long copy_msqid_f
 		out->mode		= tbuf.msg_perm.mode;
 
 		return 0;
-	    }
+	}
 	case IPC_OLD:
-	    {
+	{
 		struct msqid_ds tbuf_old;
 
-		if (copy_from_user (&tbuf_old, buf, sizeof (tbuf_old)))
+		if (copy_from_user(&tbuf_old, buf, sizeof(tbuf_old)))
 			return -EFAULT;
 
 		out->uid		= tbuf_old.msg_perm.uid;
 		out->gid		= tbuf_old.msg_perm.gid;
 		out->mode		= tbuf_old.msg_perm.mode;
 
-		if(tbuf_old.msg_qbytes == 0)
+		if (tbuf_old.msg_qbytes == 0)
 			out->qbytes	= tbuf_old.msg_lqbytes;
 		else
 			out->qbytes	= tbuf_old.msg_qbytes;
 
 		return 0;
-	    }
+	}
 	default:
 		return -EINVAL;
 	}
 }
 
-asmlinkage long sys_msgctl (int msqid, int cmd, struct msqid_ds __user *buf)
+asmlinkage long sys_msgctl(int msqid, int cmd, struct msqid_ds __user *buf)
 {
-	int err, version;
-	struct msg_queue *msq;
-	struct msq_setbuf setbuf;
 	struct kern_ipc_perm *ipcp;
-	
+	struct msq_setbuf setbuf;
+	struct msg_queue *msq;
+	int err, version;
+
 	if (msqid < 0 || cmd < 0)
 		return -EINVAL;
 
 	version = ipc_parse_version(&cmd);
 
 	switch (cmd) {
-	case IPC_INFO: 
-	case MSG_INFO: 
-	{ 
+	case IPC_INFO:
+	case MSG_INFO:
+	{
 		struct msginfo msginfo;
 		int max_id;
+
 		if (!buf)
 			return -EFAULT;
-		/* We must not return kernel stack data.
+		/*
+		 * We must not return kernel stack data.
 		 * due to padding, it's not enough
 		 * to set all member fields.
 		 */
-
 		err = security_msg_queue_msgctl(NULL, cmd);
 		if (err)
 			return err;
 
-		memset(&msginfo,0,sizeof(msginfo));	
+		memset(&msginfo, 0, sizeof(msginfo));
 		msginfo.msgmni = msg_ctlmni;
 		msginfo.msgmax = msg_ctlmax;
 		msginfo.msgmnb = msg_ctlmnb;
@@ -377,36 +383,37 @@ asmlinkage long sys_msgctl (int msqid, i
 		}
 		max_id = msg_ids.max_id;
 		mutex_unlock(&msg_ids.mutex);
-		if (copy_to_user (buf, &msginfo, sizeof(struct msginfo)))
+		if (copy_to_user(buf, &msginfo, sizeof(struct msginfo)))
 			return -EFAULT;
-		return (max_id < 0) ? 0: max_id;
+		return (max_id < 0) ? 0 : max_id;
 	}
 	case MSG_STAT:
 	case IPC_STAT:
 	{
 		struct msqid64_ds tbuf;
 		int success_return;
+
 		if (!buf)
 			return -EFAULT;
-		if(cmd == MSG_STAT && msqid >= msg_ids.entries->size)
+		if (cmd == MSG_STAT && msqid >= msg_ids.entries->size)
 			return -EINVAL;
 
-		memset(&tbuf,0,sizeof(tbuf));
+		memset(&tbuf, 0, sizeof(tbuf));
 
 		msq = msg_lock(msqid);
 		if (msq == NULL)
 			return -EINVAL;
 
-		if(cmd == MSG_STAT) {
+		if (cmd == MSG_STAT) {
 			success_return = msg_buildid(msqid, msq->q_perm.seq);
 		} else {
 			err = -EIDRM;
-			if (msg_checkid(msq,msqid))
+			if (msg_checkid(msq, msqid))
 				goto out_unlock;
 			success_return = 0;
 		}
 		err = -EACCES;
-		if (ipcperms (&msq->q_perm, S_IRUGO))
+		if (ipcperms(&msq->q_perm, S_IRUGO))
 			goto out_unlock;
 
 		err = security_msg_queue_msgctl(msq, cmd);
@@ -430,7 +437,7 @@ asmlinkage long sys_msgctl (int msqid, i
 	case IPC_SET:
 		if (!buf)
 			return -EFAULT;
-		if (copy_msqid_from_user (&setbuf, buf, version))
+		if (copy_msqid_from_user(&setbuf, buf, version))
 			return -EFAULT;
 		break;
 	case IPC_RMID:
@@ -441,12 +448,12 @@ asmlinkage long sys_msgctl (int msqid, i
 
 	mutex_lock(&msg_ids.mutex);
 	msq = msg_lock(msqid);
-	err=-EINVAL;
+	err = -EINVAL;
 	if (msq == NULL)
 		goto out_up;
 
 	err = -EIDRM;
-	if (msg_checkid(msq,msqid))
+	if (msg_checkid(msq, msqid))
 		goto out_unlock_up;
 	ipcp = &msq->q_perm;
 
@@ -454,15 +461,16 @@ asmlinkage long sys_msgctl (int msqid, i
 	if (err)
 		goto out_unlock_up;
 	if (cmd==IPC_SET) {
-		err = audit_ipc_set_perm(setbuf.qbytes, setbuf.uid, setbuf.gid, setbuf.mode);
+		err = audit_ipc_set_perm(setbuf.qbytes, setbuf.uid, setbuf.gid,
+					 setbuf.mode);
 		if (err)
 			goto out_unlock_up;
 	}
 
 	err = -EPERM;
-	if (current->euid != ipcp->cuid && 
+	if (current->euid != ipcp->cuid &&
 	    current->euid != ipcp->uid && !capable(CAP_SYS_ADMIN))
-	    /* We _could_ check for CAP_CHOWN above, but we don't */
+		/* We _could_ check for CAP_CHOWN above, but we don't */
 		goto out_unlock_up;
 
 	err = security_msg_queue_msgctl(msq, cmd);
@@ -480,22 +488,22 @@ asmlinkage long sys_msgctl (int msqid, i
 
 		ipcp->uid = setbuf.uid;
 		ipcp->gid = setbuf.gid;
-		ipcp->mode = (ipcp->mode & ~S_IRWXUGO) | 
-			(S_IRWXUGO & setbuf.mode);
+		ipcp->mode = (ipcp->mode & ~S_IRWXUGO) |
+			     (S_IRWXUGO & setbuf.mode);
 		msq->q_ctime = get_seconds();
 		/* sleeping receivers might be excluded by
 		 * stricter permissions.
 		 */
-		expunge_all(msq,-EAGAIN);
+		expunge_all(msq, -EAGAIN);
 		/* sleeping senders might be able to send
 		 * due to a larger queue size.
 		 */
-		ss_wakeup(&msq->q_senders,0);
+		ss_wakeup(&msq->q_senders, 0);
 		msg_unlock(msq);
 		break;
 	}
 	case IPC_RMID:
-		freeque (msq, msqid); 
+		freeque(msq, msqid);
 		break;
 	}
 	err = 0;
@@ -510,41 +518,44 @@ out_unlock:
 	return err;
 }
 
-static int testmsg(struct msg_msg* msg,long type,int mode)
+static int testmsg(struct msg_msg *msg, long type, int mode)
 {
 	switch(mode)
 	{
 		case SEARCH_ANY:
 			return 1;
 		case SEARCH_LESSEQUAL:
-			if(msg->m_type <=type)
+			if (msg->m_type <=type)
 				return 1;
 			break;
 		case SEARCH_EQUAL:
-			if(msg->m_type == type)
+			if (msg->m_type == type)
 				return 1;
 			break;
 		case SEARCH_NOTEQUAL:
-			if(msg->m_type != type)
+			if (msg->m_type != type)
 				return 1;
 			break;
 	}
 	return 0;
 }
 
-static inline int pipelined_send(struct msg_queue* msq, struct msg_msg* msg)
+static inline int pipelined_send(struct msg_queue *msq, struct msg_msg *msg)
 {
-	struct list_head* tmp;
+	struct list_head *tmp;
 
 	tmp = msq->q_receivers.next;
 	while (tmp != &msq->q_receivers) {
-		struct msg_receiver* msr;
-		msr = list_entry(tmp,struct msg_receiver,r_list);
+		struct msg_receiver *msr;
+
+		msr = list_entry(tmp, struct msg_receiver, r_list);
 		tmp = tmp->next;
-		if(testmsg(msg,msr->r_msgtype,msr->r_mode) &&
-		   !security_msg_queue_msgrcv(msq, msg, msr->r_tsk, msr->r_msgtype, msr->r_mode)) {
+		if (testmsg(msg, msr->r_msgtype, msr->r_mode) &&
+		    !security_msg_queue_msgrcv(msq, msg, msr->r_tsk,
+					       msr->r_msgtype, msr->r_mode)) {
+
 			list_del(&msr->r_list);
-			if(msr->r_maxsize < msg->m_ts) {
+			if (msr->r_maxsize < msg->m_ts) {
 				msr->r_msg = NULL;
 				wake_up_process(msr->r_tsk);
 				smp_mb();
@@ -556,6 +567,7 @@ static inline int pipelined_send(struct 
 				wake_up_process(msr->r_tsk);
 				smp_mb();
 				msr->r_msg = msg;
+
 				return 1;
 			}
 		}
@@ -563,40 +575,41 @@ static inline int pipelined_send(struct 
 	return 0;
 }
 
-asmlinkage long sys_msgsnd (int msqid, struct msgbuf __user *msgp, size_t msgsz, int msgflg)
+asmlinkage long
+sys_msgsnd(int msqid, struct msgbuf __user *msgp, size_t msgsz, int msgflg)
 {
 	struct msg_queue *msq;
 	struct msg_msg *msg;
 	long mtype;
 	int err;
-	
+
 	if (msgsz > msg_ctlmax || (long) msgsz < 0 || msqid < 0)
 		return -EINVAL;
 	if (get_user(mtype, &msgp->mtype))
-		return -EFAULT; 
+		return -EFAULT;
 	if (mtype < 1)
 		return -EINVAL;
 
 	msg = load_msg(msgp->mtext, msgsz);
-	if(IS_ERR(msg))
+	if (IS_ERR(msg))
 		return PTR_ERR(msg);
 
 	msg->m_type = mtype;
 	msg->m_ts = msgsz;
 
 	msq = msg_lock(msqid);
-	err=-EINVAL;
-	if(msq==NULL)
+	err = -EINVAL;
+	if (msq == NULL)
 		goto out_free;
 
 	err= -EIDRM;
-	if (msg_checkid(msq,msqid))
+	if (msg_checkid(msq, msqid))
 		goto out_unlock_free;
 
 	for (;;) {
 		struct msg_sender s;
 
-		err=-EACCES;
+		err = -EACCES;
 		if (ipcperms(&msq->q_perm, S_IWUGO))
 			goto out_unlock_free;
 
@@ -604,14 +617,14 @@ asmlinkage long sys_msgsnd (int msqid, s
 		if (err)
 			goto out_unlock_free;
 
-		if(msgsz + msq->q_cbytes <= msq->q_qbytes &&
+		if (msgsz + msq->q_cbytes <= msq->q_qbytes &&
 				1 + msq->q_qnum <= msq->q_qbytes) {
 			break;
 		}
 
 		/* queue full, wait: */
-		if(msgflg&IPC_NOWAIT) {
-			err=-EAGAIN;
+		if (msgflg & IPC_NOWAIT) {
+			err = -EAGAIN;
 			goto out_unlock_free;
 		}
 		ss_add(msq, &s);
@@ -626,9 +639,9 @@ asmlinkage long sys_msgsnd (int msqid, s
 			goto out_unlock_free;
 		}
 		ss_del(&s);
-		
+
 		if (signal_pending(current)) {
-			err=-ERESTARTNOHAND;
+			err = -ERESTARTNOHAND;
 			goto out_unlock_free;
 		}
 	}
@@ -636,47 +649,47 @@ asmlinkage long sys_msgsnd (int msqid, s
 	msq->q_lspid = current->tgid;
 	msq->q_stime = get_seconds();
 
-	if(!pipelined_send(msq,msg)) {
+	if (!pipelined_send(msq, msg)) {
 		/* noone is waiting for this message, enqueue it */
-		list_add_tail(&msg->m_list,&msq->q_messages);
+		list_add_tail(&msg->m_list, &msq->q_messages);
 		msq->q_cbytes += msgsz;
 		msq->q_qnum++;
-		atomic_add(msgsz,&msg_bytes);
+		atomic_add(msgsz, &msg_bytes);
 		atomic_inc(&msg_hdrs);
 	}
-	
+
 	err = 0;
 	msg = NULL;
 
 out_unlock_free:
 	msg_unlock(msq);
 out_free:
-	if(msg!=NULL)
+	if (msg != NULL)
 		free_msg(msg);
 	return err;
 }
 
-static inline int convert_mode(long* msgtyp, int msgflg)
+static inline int convert_mode(long *msgtyp, int msgflg)
 {
-	/* 
+	/*
 	 *  find message of correct type.
 	 *  msgtyp = 0 => get first.
 	 *  msgtyp > 0 => get first message of matching type.
-	 *  msgtyp < 0 => get message with least type must be < abs(msgtype).  
+	 *  msgtyp < 0 => get message with least type must be < abs(msgtype).
 	 */
-	if(*msgtyp==0)
+	if (*msgtyp == 0)
 		return SEARCH_ANY;
-	if(*msgtyp<0) {
-		*msgtyp=-(*msgtyp);
+	if (*msgtyp < 0) {
+		*msgtyp = -*msgtyp;
 		return SEARCH_LESSEQUAL;
 	}
-	if(msgflg & MSG_EXCEPT)
+	if (msgflg & MSG_EXCEPT)
 		return SEARCH_NOTEQUAL;
 	return SEARCH_EQUAL;
 }
 
-asmlinkage long sys_msgrcv (int msqid, struct msgbuf __user *msgp, size_t msgsz,
-			    long msgtyp, int msgflg)
+asmlinkage long sys_msgrcv(int msqid, struct msgbuf __user *msgp, size_t msgsz,
+			   long msgtyp, int msgflg)
 {
 	struct msg_queue *msq;
 	struct msg_msg *msg;
@@ -684,44 +697,51 @@ asmlinkage long sys_msgrcv (int msqid, s
 
 	if (msqid < 0 || (long) msgsz < 0)
 		return -EINVAL;
-	mode = convert_mode(&msgtyp,msgflg);
+	mode = convert_mode(&msgtyp, msgflg);
 
 	msq = msg_lock(msqid);
-	if(msq==NULL)
+	if (msq == NULL)
 		return -EINVAL;
 
 	msg = ERR_PTR(-EIDRM);
-	if (msg_checkid(msq,msqid))
+	if (msg_checkid(msq, msqid))
 		goto out_unlock;
 
 	for (;;) {
 		struct msg_receiver msr_d;
-		struct list_head* tmp;
+		struct list_head *tmp;
 
 		msg = ERR_PTR(-EACCES);
-		if (ipcperms (&msq->q_perm, S_IRUGO))
+		if (ipcperms(&msq->q_perm, S_IRUGO))
 			goto out_unlock;
 
 		msg = ERR_PTR(-EAGAIN);
 		tmp = msq->q_messages.next;
 		while (tmp != &msq->q_messages) {
 			struct msg_msg *walk_msg;
-			walk_msg = list_entry(tmp,struct msg_msg,m_list);
-			if(testmsg(walk_msg,msgtyp,mode) &&
-			   !security_msg_queue_msgrcv(msq, walk_msg, current, msgtyp, mode)) {
+
+			walk_msg = list_entry(tmp, struct msg_msg, m_list);
+			if (testmsg(walk_msg, msgtyp, mode) &&
+			    !security_msg_queue_msgrcv(msq, walk_msg, current,
+						       msgtyp, mode)) {
+
 				msg = walk_msg;
-				if(mode == SEARCH_LESSEQUAL && walk_msg->m_type != 1) {
-					msg=walk_msg;
-					msgtyp=walk_msg->m_type-1;
+				if (mode == SEARCH_LESSEQUAL &&
+						walk_msg->m_type != 1) {
+					msg = walk_msg;
+					msgtyp = walk_msg->m_type - 1;
 				} else {
-					msg=walk_msg;
+					msg = walk_msg;
 					break;
 				}
 			}
 			tmp = tmp->next;
 		}
-		if(!IS_ERR(msg)) {
-			/* Found a suitable message. Unlink it from the queue. */
+		if (!IS_ERR(msg)) {
+			/*
+			 * Found a suitable message.
+			 * Unlink it from the queue.
+			 */
 			if ((msgsz < msg->m_ts) && !(msgflg & MSG_NOERROR)) {
 				msg = ERR_PTR(-E2BIG);
 				goto out_unlock;
@@ -731,9 +751,9 @@ asmlinkage long sys_msgrcv (int msqid, s
 			msq->q_rtime = get_seconds();
 			msq->q_lrpid = current->tgid;
 			msq->q_cbytes -= msg->m_ts;
-			atomic_sub(msg->m_ts,&msg_bytes);
+			atomic_sub(msg->m_ts, &msg_bytes);
 			atomic_dec(&msg_hdrs);
-			ss_wakeup(&msq->q_senders,0);
+			ss_wakeup(&msq->q_senders, 0);
 			msg_unlock(msq);
 			break;
 		}
@@ -742,13 +762,13 @@ asmlinkage long sys_msgrcv (int msqid, s
 			msg = ERR_PTR(-ENOMSG);
 			goto out_unlock;
 		}
-		list_add_tail(&msr_d.r_list,&msq->q_receivers);
+		list_add_tail(&msr_d.r_list, &msq->q_receivers);
 		msr_d.r_tsk = current;
 		msr_d.r_msgtype = msgtyp;
 		msr_d.r_mode = mode;
-		if(msgflg & MSG_NOERROR)
+		if (msgflg & MSG_NOERROR)
 			msr_d.r_maxsize = INT_MAX;
-		 else
+		else
 			msr_d.r_maxsize = msgsz;
 		msr_d.r_msg = ERR_PTR(-EAGAIN);
 		current->state = TASK_INTERRUPTIBLE;
@@ -773,17 +793,17 @@ asmlinkage long sys_msgrcv (int msqid, s
 		 * wake_up_process(). There is a race with exit(), see
 		 * ipc/mqueue.c for the details.
 		 */
-		msg = (struct msg_msg*) msr_d.r_msg;
+		msg = (struct msg_msg*)msr_d.r_msg;
 		while (msg == NULL) {
 			cpu_relax();
-			msg = (struct msg_msg*) msr_d.r_msg;
+			msg = (struct msg_msg *)msr_d.r_msg;
 		}
 
 		/* Lockless receive, part 3:
 		 * If there is a message or an error then accept it without
 		 * locking.
 		 */
-		if(msg != ERR_PTR(-EAGAIN)) {
+		if (msg != ERR_PTR(-EAGAIN)) {
 			rcu_read_unlock();
 			break;
 		}
@@ -798,7 +818,7 @@ asmlinkage long sys_msgrcv (int msqid, s
 		 * Repeat test after acquiring the spinlock.
 		 */
 		msg = (struct msg_msg*)msr_d.r_msg;
-		if(msg != ERR_PTR(-EAGAIN))
+		if (msg != ERR_PTR(-EAGAIN))
 			goto out_unlock;
 
 		list_del(&msr_d.r_list);
@@ -810,14 +830,15 @@ out_unlock:
 		}
 	}
 	if (IS_ERR(msg))
-       		return PTR_ERR(msg);
+		return PTR_ERR(msg);
 
 	msgsz = (msgsz > msg->m_ts) ? msg->m_ts : msgsz;
 	if (put_user (msg->m_type, &msgp->mtype) ||
 	    store_msg(msgp->mtext, msg, msgsz)) {
-		    msgsz = -EFAULT;
+		msgsz = -EFAULT;
 	}
 	free_msg(msg);
+
 	return msgsz;
 }
 
@@ -827,20 +848,20 @@ static int sysvipc_msg_proc_show(struct 
 	struct msg_queue *msq = it;
 
 	return seq_printf(s,
-			  "%10d %10d  %4o  %10lu %10lu %5u %5u %5u %5u %5u %5u %10lu %10lu %10lu\n",
-			  msq->q_perm.key,
-			  msq->q_id,
-			  msq->q_perm.mode,
-			  msq->q_cbytes,
-			  msq->q_qnum,
-			  msq->q_lspid,
-			  msq->q_lrpid,
-			  msq->q_perm.uid,
-			  msq->q_perm.gid,
-			  msq->q_perm.cuid,
-			  msq->q_perm.cgid,
-			  msq->q_stime,
-			  msq->q_rtime,
-			  msq->q_ctime);
+			"%10d %10d  %4o  %10lu %10lu %5u %5u %5u %5u %5u %5u %10lu %10lu %10lu\n",
+			msq->q_perm.key,
+			msq->q_id,
+			msq->q_perm.mode,
+			msq->q_cbytes,
+			msq->q_qnum,
+			msq->q_lspid,
+			msq->q_lrpid,
+			msq->q_perm.uid,
+			msq->q_perm.gid,
+			msq->q_perm.cuid,
+			msq->q_perm.cgid,
+			msq->q_stime,
+			msq->q_rtime,
+			msq->q_ctime);
 }
 #endif
