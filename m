Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266852AbTAKBGF>; Fri, 10 Jan 2003 20:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266971AbTAKBGD>; Fri, 10 Jan 2003 20:06:03 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:27666 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266852AbTAKBFf>;
	Fri, 10 Jan 2003 20:05:35 -0500
Date: Fri, 10 Jan 2003 17:13:27 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [BK PATCH] LSM changes for 2.5.56
Message-ID: <20030111011326.GL22363@kroah.com>
References: <20030111011251.GK22363@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030111011251.GK22363@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.889.20.1, 2003/01/10 12:30:59-08:00, sds@epoch.ncsc.mil

[PATCH] 2.5.52-lsm-{dummy,ipc}.patch

This patch adds the remaining System V IPC hooks, including the inline
documentation for them in security.h.  This includes a restored
sem_semop hook, as it does seem to be necessary to support fine-grained
access.

All of these System V IPC hooks are used by SELinux.  The SELinux System
V IPC access controls were originally described in the technical report
available from http://www.nsa.gov/selinux/slinux-abs.html, and the
LSM-based implementation is described in the technical report available
from http://www.nsa.gov/selinux/module-abs.html.


diff -Nru a/include/linux/msg.h b/include/linux/msg.h
--- a/include/linux/msg.h	Fri Jan 10 17:08:23 2003
+++ b/include/linux/msg.h	Fri Jan 10 17:08:23 2003
@@ -69,6 +69,7 @@
 	long  m_type;          
 	int m_ts;           /* message text size */
 	struct msg_msgseg* next;
+	void *security;
 	/* the actual message follows immediately */
 };
 
diff -Nru a/include/linux/security.h b/include/linux/security.h
--- a/include/linux/security.h	Fri Jan 10 17:08:23 2003
+++ b/include/linux/security.h	Fri Jan 10 17:08:23 2003
@@ -594,6 +594,17 @@
  *	@flag contains the desired (requested) permission set
  *	Return 0 if permission is granted.
  *
+ * Security hooks for individual messages held in System V IPC message queues
+ * @msg_msg_alloc_security:
+ *	Allocate and attach a security structure to the msg->security field.
+ *	The security field is initialized to NULL when the structure is first
+ *	created.
+ *	@msg contains the message structure to be modified.
+ *	Return 0 if operation was successful and permission is granted.
+ * @msg_msg_free_security:
+ *	Deallocate the security structure for this message.
+ *	@msg contains the message structure to be modified.
+ *
  * Security hooks for System V IPC Message Queues
  *
  * @msg_queue_alloc_security:
@@ -605,6 +616,39 @@
  * @msg_queue_free_security:
  *	Deallocate security structure for this message queue.
  *	@msq contains the message queue structure to be modified.
+ * @msg_queue_associate:
+ *	Check permission when a message queue is requested through the
+ *	msgget system call.  This hook is only called when returning the
+ *	message queue identifier for an existing message queue, not when a
+ *	new message queue is created.
+ *	@msq contains the message queue to act upon.
+ *	@msqflg contains the operation control flags.
+ *	Return 0 if permission is granted.
+ * @msg_queue_msgctl:
+ *	Check permission when a message control operation specified by @cmd
+ *	is to be performed on the message queue @msq.
+ *	The @msq may be NULL, e.g. for IPC_INFO or MSG_INFO.
+ *	@msq contains the message queue to act upon.  May be NULL.
+ *	@cmd contains the operation to be performed.
+ *	Return 0 if permission is granted.  
+ * @msg_queue_msgsnd:
+ *	Check permission before a message, @msg, is enqueued on the message
+ *	queue, @msq.
+ *	@msq contains the message queue to send message to.
+ *	@msg contains the message to be enqueued.
+ *	@msqflg contains operational flags.
+ *	Return 0 if permission is granted.
+ * @msg_queue_msgrcv:
+ *	Check permission before a message, @msg, is removed from the message
+ *	queue, @msq.  The @target task structure contains a pointer to the 
+ *	process that will be receiving the message (not equal to the current 
+ *	process when inline receives are being performed).
+ *	@msq contains the message queue to retrieve message from.
+ *	@msg contains the message destination.
+ *	@target contains the task structure for recipient process.
+ *	@type contains the type of message requested.
+ *	@mode contains the operational flags.
+ *	Return 0 if permission is granted.
  *
  * Security hooks for System V Shared Memory Segments
  *
@@ -617,6 +661,29 @@
  * @shm_free_security:
  *	Deallocate the security struct for this memory segment.
  *	@shp contains the shared memory structure to be modified.
+ * @shm_associate:
+ *	Check permission when a shared memory region is requested through the
+ *	shmget system call.  This hook is only called when returning the shared
+ *	memory region identifier for an existing region, not when a new shared
+ *	memory region is created.
+ *	@shp contains the shared memory structure to be modified.
+ *	@shmflg contains the operation control flags.
+ *	Return 0 if permission is granted.
+ * @shm_shmctl:
+ *	Check permission when a shared memory control operation specified by
+ *	@cmd is to be performed on the shared memory region @shp.
+ *	The @shp may be NULL, e.g. for IPC_INFO or SHM_INFO.
+ *	@shp contains shared memory structure to be modified.
+ *	@cmd contains the operation to be performed.
+ *	Return 0 if permission is granted.
+ * @shm_shmat:
+ *	Check permissions prior to allowing the shmat system call to attach the
+ *	shared memory segment @shp to the data segment of the calling process.
+ *	The attaching address is specified by @shmaddr.
+ *	@shp contains the shared memory structure to be modified.
+ *	@shmaddr contains the address to attach memory region to.
+ *	@shmflg contains the operational flags.
+ *	Return 0 if permission is granted.
  *
  * Security hooks for System V Semaphores
  *
@@ -629,6 +696,30 @@
  * @sem_free_security:
  *	deallocate security struct for this semaphore
  *	@sma contains the semaphore structure.
+ * @sem_associate:
+ *	Check permission when a semaphore is requested through the semget
+ *	system call.  This hook is only called when returning the semaphore
+ *	identifier for an existing semaphore, not when a new one must be
+ *	created.
+ *	@sma contains the semaphore structure.
+ *	@semflg contains the operation control flags.
+ *	Return 0 if permission is granted.
+ * @sem_semctl:
+ *	Check permission when a semaphore operation specified by @cmd is to be
+ *	performed on the semaphore @sma.  The @sma may be NULL, e.g. for 
+ *	IPC_INFO or SEM_INFO.
+ *	@sma contains the semaphore structure.  May be NULL.
+ *	@cmd contains the operation to be performed.
+ *	Return 0 if permission is granted.
+ * @sem_semop
+ *	Check permissions before performing operations on members of the
+ *	semaphore set @sma.  If the @alter flag is nonzero, the semaphore set 
+ *      may be modified.
+ *	@sma contains the semaphore structure.
+ *	@sops contains the operations to perform.
+ *	@nsops contains the number of operations to perform.
+ *	@alter contains the flag indicating whether changes are to be made.
+ *	Return 0 if permission is granted.
  *
  * @ptrace:
  *	Check permission before allowing the @parent process to trace the
@@ -828,14 +919,33 @@
 
 	int (*ipc_permission) (struct kern_ipc_perm * ipcp, short flag);
 
+	int (*msg_msg_alloc_security) (struct msg_msg * msg);
+	void (*msg_msg_free_security) (struct msg_msg * msg);
+
 	int (*msg_queue_alloc_security) (struct msg_queue * msq);
 	void (*msg_queue_free_security) (struct msg_queue * msq);
+	int (*msg_queue_associate) (struct msg_queue * msq, int msqflg);
+	int (*msg_queue_msgctl) (struct msg_queue * msq, int cmd);
+	int (*msg_queue_msgsnd) (struct msg_queue * msq,
+				 struct msg_msg * msg, int msqflg);
+	int (*msg_queue_msgrcv) (struct msg_queue * msq,
+				 struct msg_msg * msg,
+				 struct task_struct * target,
+				 long type, int mode);
 
 	int (*shm_alloc_security) (struct shmid_kernel * shp);
 	void (*shm_free_security) (struct shmid_kernel * shp);
+	int (*shm_associate) (struct shmid_kernel * shp, int shmflg);
+	int (*shm_shmctl) (struct shmid_kernel * shp, int cmd);
+	int (*shm_shmat) (struct shmid_kernel * shp, 
+			  char *shmaddr, int shmflg);
 
 	int (*sem_alloc_security) (struct sem_array * sma);
 	void (*sem_free_security) (struct sem_array * sma);
+	int (*sem_associate) (struct sem_array * sma, int semflg);
+	int (*sem_semctl) (struct sem_array * sma, int cmd);
+	int (*sem_semop) (struct sem_array * sma, 
+			  struct sembuf * sops, unsigned nsops, int alter);
 
 	/* allow module stacking */
 	int (*register_security) (const char *name,
@@ -1334,6 +1444,16 @@
 	return security_ops->ipc_permission (ipcp, flag);
 }
 
+static inline int security_msg_msg_alloc (struct msg_msg * msg)
+{
+	return security_ops->msg_msg_alloc_security (msg);
+}
+
+static inline void security_msg_msg_free (struct msg_msg * msg)
+{
+	security_ops->msg_msg_free_security(msg);
+}
+
 static inline int security_msg_queue_alloc (struct msg_queue *msq)
 {
 	return security_ops->msg_queue_alloc_security (msq);
@@ -1344,6 +1464,31 @@
 	security_ops->msg_queue_free_security (msq);
 }
 
+static inline int security_msg_queue_associate (struct msg_queue * msq, 
+						int msqflg)
+{
+	return security_ops->msg_queue_associate (msq, msqflg);
+}
+
+static inline int security_msg_queue_msgctl (struct msg_queue * msq, int cmd)
+{
+	return security_ops->msg_queue_msgctl (msq, cmd);
+}
+
+static inline int security_msg_queue_msgsnd (struct msg_queue * msq,
+					     struct msg_msg * msg, int msqflg)
+{
+	return security_ops->msg_queue_msgsnd (msq, msg, msqflg);
+}
+
+static inline int security_msg_queue_msgrcv (struct msg_queue * msq,
+					     struct msg_msg * msg,
+					     struct task_struct * target,
+					     long type, int mode)
+{
+	return security_ops->msg_queue_msgrcv (msq, msg, target, type, mode);
+}
+
 static inline int security_shm_alloc (struct shmid_kernel *shp)
 {
 	return security_ops->shm_alloc_security (shp);
@@ -1354,6 +1499,23 @@
 	security_ops->shm_free_security (shp);
 }
 
+static inline int security_shm_associate (struct shmid_kernel * shp, 
+					  int shmflg)
+{
+	return security_ops->shm_associate(shp, shmflg);
+}
+
+static inline int security_shm_shmctl (struct shmid_kernel * shp, int cmd)
+{
+	return security_ops->shm_shmctl (shp, cmd);
+}
+
+static inline int security_shm_shmat (struct shmid_kernel * shp, 
+				      char *shmaddr, int shmflg)
+{
+	return security_ops->shm_shmat(shp, shmaddr, shmflg);
+}
+
 static inline int security_sem_alloc (struct sem_array *sma)
 {
 	return security_ops->sem_alloc_security (sma);
@@ -1364,6 +1526,22 @@
 	security_ops->sem_free_security (sma);
 }
 
+static inline int security_sem_associate (struct sem_array * sma, int semflg)
+{
+	return security_ops->sem_associate (sma, semflg);
+}
+
+static inline int security_sem_semctl (struct sem_array * sma, int cmd)
+{
+	return security_ops->sem_semctl(sma, cmd);
+}
+
+static inline int security_sem_semop (struct sem_array * sma, 
+				      struct sembuf * sops, unsigned nsops, 
+				      int alter)
+{
+	return security_ops->sem_semop(sma, sops, nsops, alter);
+}
 
 /* prototypes */
 extern int security_scaffolding_startup	(void);
@@ -1835,6 +2013,14 @@
 	return 0;
 }
 
+static inline int security_msg_msg_alloc (struct msg_msg * msg)
+{
+	return 0;
+}
+
+static inline void security_msg_msg_free (struct msg_msg * msg)
+{ }
+
 static inline int security_msg_queue_alloc (struct msg_queue *msq)
 {
 	return 0;
@@ -1843,6 +2029,31 @@
 static inline void security_msg_queue_free (struct msg_queue *msq)
 { }
 
+static inline int security_msg_queue_associate (struct msg_queue * msq, 
+						int msqflg)
+{
+	return 0;
+}
+
+static inline int security_msg_queue_msgctl (struct msg_queue * msq, int cmd)
+{
+	return 0;
+}
+
+static inline int security_msg_queue_msgsnd (struct msg_queue * msq,
+					     struct msg_msg * msg, int msqflg)
+{
+	return 0;
+}
+
+static inline int security_msg_queue_msgrcv (struct msg_queue * msq,
+					     struct msg_msg * msg,
+					     struct task_struct * target,
+					     long type, int mode)
+{
+	return 0;
+}
+
 static inline int security_shm_alloc (struct shmid_kernel *shp)
 {
 	return 0;
@@ -1851,6 +2062,23 @@
 static inline void security_shm_free (struct shmid_kernel *shp)
 { }
 
+static inline int security_shm_associate (struct shmid_kernel * shp, 
+					  int shmflg)
+{
+	return 0;
+}
+
+static inline int security_shm_shmctl (struct shmid_kernel * shp, int cmd)
+{
+	return 0;
+}
+
+static inline int security_shm_shmat (struct shmid_kernel * shp, 
+				      char *shmaddr, int shmflg)
+{
+	return 0;
+}
+
 static inline int security_sem_alloc (struct sem_array *sma)
 {
 	return 0;
@@ -1859,6 +2087,22 @@
 static inline void security_sem_free (struct sem_array *sma)
 { }
 
+static inline int security_sem_associate (struct sem_array * sma, int semflg)
+{
+	return 0;
+}
+
+static inline int security_sem_semctl (struct sem_array * sma, int cmd)
+{
+	return 0;
+}
+
+static inline int security_sem_semop (struct sem_array * sma, 
+				      struct sembuf * sops, unsigned nsops, 
+				      int alter)
+{
+	return 0;
+}
 
 #endif	/* CONFIG_SECURITY */
 
diff -Nru a/ipc/msg.c b/ipc/msg.c
--- a/ipc/msg.c	Fri Jan 10 17:08:23 2003
+++ b/ipc/msg.c	Fri Jan 10 17:08:23 2003
@@ -132,6 +132,9 @@
 static void free_msg(struct msg_msg* msg)
 {
 	struct msg_msgseg* seg;
+
+	security_msg_msg_free(msg);
+
 	seg = msg->next;
 	kfree(msg);
 	while(seg != NULL) {
@@ -157,6 +160,7 @@
 		return ERR_PTR(-ENOMEM);
 
 	msg->next = NULL;
+	msg->security = NULL;
 
 	if (copy_from_user(msg+1, src, alen)) {
 		err = -EFAULT;
@@ -186,6 +190,11 @@
 		len -= alen;
 		src = ((char*)src)+alen;
 	}
+	
+	err = security_msg_msg_alloc(msg);
+	if (err)
+		goto out_err;
+
 	return msg;
 
 out_err:
@@ -308,8 +317,12 @@
 			BUG();
 		if (ipcperms(&msq->q_perm, msgflg))
 			ret = -EACCES;
-		else
-			ret = msg_buildid(id, msq->q_perm.seq);
+		else {
+			int qid = msg_buildid(id, msq->q_perm.seq);
+		    	ret = security_msg_queue_associate(msq, msgflg);
+			if (!ret)
+				ret = qid;
+		}
 		msg_unlock(msq);
 	}
 	up(&msg_ids.sem);
@@ -431,6 +444,11 @@
 		 * due to padding, it's not enough
 		 * to set all member fields.
 		 */
+
+		err = security_msg_queue_msgctl(NULL, cmd);
+		if (err)
+			return err;
+
 		memset(&msginfo,0,sizeof(msginfo));	
 		msginfo.msgmni = msg_ctlmni;
 		msginfo.msgmax = msg_ctlmax;
@@ -481,6 +499,10 @@
 		if (ipcperms (&msq->q_perm, S_IRUGO))
 			goto out_unlock;
 
+		err = security_msg_queue_msgctl(msq, cmd);
+		if (err)
+			goto out_unlock;
+
 		kernel_to_ipc64_perm(&msq->q_perm, &tbuf.msg_perm);
 		tbuf.msg_stime  = msq->q_stime;
 		tbuf.msg_rtime  = msq->q_rtime;
@@ -523,11 +545,16 @@
 	    /* We _could_ check for CAP_CHOWN above, but we don't */
 		goto out_unlock_up;
 
+	err = security_msg_queue_msgctl(msq, cmd);
+	if (err)
+		goto out_unlock_up;
+
 	switch (cmd) {
 	case IPC_SET:
 	{
 		if (setbuf.qbytes > msg_ctlmnb && !capable(CAP_SYS_RESOURCE))
 			goto out_unlock_up;
+
 		msq->q_qbytes = setbuf.qbytes;
 
 		ipcp->uid = setbuf.uid;
@@ -593,7 +620,8 @@
 		struct msg_receiver* msr;
 		msr = list_entry(tmp,struct msg_receiver,r_list);
 		tmp = tmp->next;
-		if(testmsg(msg,msr->r_msgtype,msr->r_mode)) {
+		if(testmsg(msg,msr->r_msgtype,msr->r_mode) &&
+		   !security_msg_queue_msgrcv(msq, msg, msr->r_tsk, msr->r_msgtype, msr->r_mode)) {
 			list_del(&msr->r_list);
 			if(msr->r_maxsize < msg->m_ts) {
 				msr->r_msg = ERR_PTR(-E2BIG);
@@ -644,6 +672,10 @@
 	if (ipcperms(&msq->q_perm, S_IWUGO)) 
 		goto out_unlock_free;
 
+	err = security_msg_queue_msgsnd(msq, msg, msgflg);
+	if (err)
+		goto out_unlock_free;
+
 	if(msgsz + msq->q_cbytes > msq->q_qbytes ||
 		1 + msq->q_qnum > msq->q_qbytes) {
 		struct msg_sender s;
@@ -742,7 +774,8 @@
 	found_msg=NULL;
 	while (tmp != &msq->q_messages) {
 		msg = list_entry(tmp,struct msg_msg,m_list);
-		if(testmsg(msg,msgtyp,mode)) {
+		if(testmsg(msg,msgtyp,mode) &&
+		   !security_msg_queue_msgrcv(msq, msg, current, msgtyp, mode)) {
 			found_msg = msg;
 			if(mode == SEARCH_LESSEQUAL && msg->m_type != 1) {
 				found_msg=msg;
diff -Nru a/ipc/sem.c b/ipc/sem.c
--- a/ipc/sem.c	Fri Jan 10 17:08:23 2003
+++ b/ipc/sem.c	Fri Jan 10 17:08:23 2003
@@ -188,8 +188,12 @@
 			err = -EINVAL;
 		else if (ipcperms(&sma->sem_perm, semflg))
 			err = -EACCES;
-		else
-			err = sem_buildid(id, sma->sem_perm.seq);
+		else {
+			int semid = sem_buildid(id, sma->sem_perm.seq);
+			err = security_sem_associate(sma, semflg);
+			if (!err)
+				err = semid;
+		}
 		sem_unlock(sma);
 	}
 
@@ -466,6 +470,10 @@
 		struct seminfo seminfo;
 		int max_id;
 
+		err = security_sem_semctl(NULL, cmd);
+		if (err)
+			return err;
+		
 		memset(&seminfo,0,sizeof(seminfo));
 		seminfo.semmni = sc_semmni;
 		seminfo.semmns = sc_semmns;
@@ -506,6 +514,11 @@
 		err = -EACCES;
 		if (ipcperms (&sma->sem_perm, S_IRUGO))
 			goto out_unlock;
+
+		err = security_sem_semctl(sma, cmd);
+		if (err)
+			goto out_unlock;
+
 		id = sem_buildid(semid, sma->sem_perm.seq);
 
 		kernel_to_ipc64_perm(&sma->sem_perm, &tbuf.sem_perm);
@@ -549,6 +562,11 @@
 	if (ipcperms (&sma->sem_perm, (cmd==SETVAL||cmd==SETALL)?S_IWUGO:S_IRUGO))
 		goto out_unlock;
 
+	err = security_sem_semctl(sma, cmd);
+	if (err)
+		goto out_unlock;
+
+	err = -EACCES;
 	switch (cmd) {
 	case GETALL:
 	{
@@ -740,6 +758,10 @@
 		goto out_unlock;
 	}
 
+	err = security_sem_semctl(sma, cmd);
+	if (err)
+		goto out_unlock;
+
 	switch(cmd){
 	case IPC_RMID:
 		freeary(semid);
@@ -1035,6 +1057,12 @@
 	error = -EACCES;
 	if (ipcperms(&sma->sem_perm, alter ? S_IWUGO : S_IRUGO))
 		goto out_unlock_semundo_free;
+
+	error = security_sem_semop(sma, sops, nsops, alter);
+	if (error)
+		goto out_unlock_semundo_free;
+
+	error = -EACCES;		
 	if (undos) {
 		/* Make sure we have an undo structure
 		 * for this process and this semaphore set.
diff -Nru a/ipc/shm.c b/ipc/shm.c
--- a/ipc/shm.c	Fri Jan 10 17:08:23 2003
+++ b/ipc/shm.c	Fri Jan 10 17:08:23 2003
@@ -257,8 +257,12 @@
 			err = -EINVAL;
 		else if (ipcperms(&shp->shm_perm, shmflg))
 			err = -EACCES;
-		else
-			err = shm_buildid(id, shp->shm_perm.seq);
+		else {
+			int shmid = shm_buildid(id, shp->shm_perm.seq);
+			err = security_shm_associate(shp, shmflg);
+			if (!err)
+				err = shmid;
+		}
 		shm_unlock(shp);
 	}
 	up(&shm_ids.sem);
@@ -399,6 +403,10 @@
 	{
 		struct shminfo64 shminfo;
 
+		err = security_shm_shmctl(NULL, cmd);
+		if (err)
+			return err;
+
 		memset(&shminfo,0,sizeof(shminfo));
 		shminfo.shmmni = shminfo.shmseg = shm_ctlmni;
 		shminfo.shmmax = shm_ctlmax;
@@ -417,6 +425,10 @@
 	{
 		struct shm_info shm_info;
 
+		err = security_shm_shmctl(NULL, cmd);
+		if (err)
+			return err;
+
 		memset(&shm_info,0,sizeof(shm_info));
 		down(&shm_ids.sem);
 		shm_info.used_ids = shm_ids.in_use;
@@ -458,6 +470,9 @@
 		err=-EACCES;
 		if (ipcperms (&shp->shm_perm, S_IRUGO))
 			goto out_unlock;
+		err = security_shm_shmctl(shp, cmd);
+		if (err)
+			goto out_unlock;
 		kernel_to_ipc64_perm(&shp->shm_perm, &tbuf.shm_perm);
 		tbuf.shm_segsz	= shp->shm_segsz;
 		tbuf.shm_atime	= shp->shm_atim;
@@ -495,6 +510,11 @@
 		err = shm_checkid(shp,shmid);
 		if(err)
 			goto out_unlock;
+
+		err = security_shm_shmctl(shp, cmd);
+		if (err)
+			goto out_unlock;
+		
 		if(cmd==SHM_LOCK) {
 			if (!is_file_hugepages(shp->shm_file))
 				shmem_lock(shp->shm_file, 1);
@@ -527,12 +547,18 @@
 		err = shm_checkid(shp, shmid);
 		if(err)
 			goto out_unlock_up;
+
 		if (current->euid != shp->shm_perm.uid &&
 		    current->euid != shp->shm_perm.cuid && 
 		    !capable(CAP_SYS_ADMIN)) {
 			err=-EPERM;
 			goto out_unlock_up;
 		}
+
+		err = security_shm_shmctl(shp, cmd);
+		if (err)
+			goto out_unlock_up;
+
 		if (shp->shm_nattch){
 			shp->shm_flags |= SHM_DEST;
 			/* Do not find it any more */
@@ -565,6 +591,10 @@
 			goto out_unlock_up;
 		}
 
+		err = security_shm_shmctl(shp, cmd);
+		if (err)
+			goto out_unlock_up;
+		
 		shp->shm_perm.uid = setbuf.uid;
 		shp->shm_perm.gid = setbuf.gid;
 		shp->shm_flags = (shp->shm_flags & ~S_IRWXUGO)
@@ -653,6 +683,13 @@
 		err = -EACCES;
 		goto out;
 	}
+
+	err = security_shm_shmat(shp, shmaddr, shmflg);
+	if (err) {
+		shm_unlock(shp);
+		return err;
+	}
+		
 	file = shp->shm_file;
 	size = file->f_dentry->d_inode->i_size;
 	shp->shm_nattch++;
diff -Nru a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Fri Jan 10 17:08:23 2003
+++ b/security/dummy.c	Fri Jan 10 17:08:23 2003
@@ -501,6 +501,15 @@
 	return 0;
 }
 
+static int dummy_msg_msg_alloc_security (struct msg_msg *msg)
+{
+	return 0;
+}
+
+static void dummy_msg_msg_free_security (struct msg_msg *msg)
+{
+	return;
+}
 
 static int dummy_msg_queue_alloc_security (struct msg_queue *msq)
 {
@@ -512,6 +521,30 @@
 	return;
 }
 
+static int dummy_msg_queue_associate (struct msg_queue *msq, 
+				      int msqflg)
+{
+	return 0;
+}
+
+static int dummy_msg_queue_msgctl (struct msg_queue *msq, int cmd)
+{
+	return 0;
+}
+
+static int dummy_msg_queue_msgsnd (struct msg_queue *msq, struct msg_msg *msg,
+				   int msgflg)
+{
+	return 0;
+}
+
+static int dummy_msg_queue_msgrcv (struct msg_queue *msq, struct msg_msg *msg,
+				   struct task_struct *target, long type,
+				   int mode)
+{
+	return 0;
+}
+
 static int dummy_shm_alloc_security (struct shmid_kernel *shp)
 {
 	return 0;
@@ -522,6 +555,22 @@
 	return;
 }
 
+static int dummy_shm_associate (struct shmid_kernel *shp, int shmflg)
+{
+	return 0;
+}
+
+static int dummy_shm_shmctl (struct shmid_kernel *shp, int cmd)
+{
+	return 0;
+}
+
+static int dummy_shm_shmat (struct shmid_kernel *shp, char *shmaddr,
+			    int shmflg)
+{
+	return 0;
+}
+
 static int dummy_sem_alloc_security (struct sem_array *sma)
 {
 	return 0;
@@ -532,6 +581,22 @@
 	return;
 }
 
+static int dummy_sem_associate (struct sem_array *sma, int semflg)
+{
+	return 0;
+}
+
+static int dummy_sem_semctl (struct sem_array *sma, int cmd)
+{
+	return 0;
+}
+
+static int dummy_sem_semop (struct sem_array *sma, 
+			    struct sembuf *sops, unsigned nsops, int alter)
+{
+	return 0;
+}
+
 static int dummy_register_security (const char *name, struct security_operations *ops)
 {
 	return -EINVAL;
@@ -640,12 +705,24 @@
 	set_to_dummy_if_null(ops, task_kmod_set_label);
 	set_to_dummy_if_null(ops, task_reparent_to_init);
 	set_to_dummy_if_null(ops, ipc_permission);
+	set_to_dummy_if_null(ops, msg_msg_alloc_security);
+	set_to_dummy_if_null(ops, msg_msg_free_security);
 	set_to_dummy_if_null(ops, msg_queue_alloc_security);
 	set_to_dummy_if_null(ops, msg_queue_free_security);
+	set_to_dummy_if_null(ops, msg_queue_associate);
+	set_to_dummy_if_null(ops, msg_queue_msgctl);
+	set_to_dummy_if_null(ops, msg_queue_msgsnd);
+	set_to_dummy_if_null(ops, msg_queue_msgrcv);
 	set_to_dummy_if_null(ops, shm_alloc_security);
 	set_to_dummy_if_null(ops, shm_free_security);
+	set_to_dummy_if_null(ops, shm_associate);
+	set_to_dummy_if_null(ops, shm_shmctl);
+	set_to_dummy_if_null(ops, shm_shmat);
 	set_to_dummy_if_null(ops, sem_alloc_security);
 	set_to_dummy_if_null(ops, sem_free_security);
+	set_to_dummy_if_null(ops, sem_associate);
+	set_to_dummy_if_null(ops, sem_semctl);
+	set_to_dummy_if_null(ops, sem_semop);
 	set_to_dummy_if_null(ops, register_security);
 	set_to_dummy_if_null(ops, unregister_security);
 }
