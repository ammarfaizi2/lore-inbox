Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261488AbSIZUXe>; Thu, 26 Sep 2002 16:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSIZUXd>; Thu, 26 Sep 2002 16:23:33 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:18187 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261488AbSIZUXA>;
	Thu, 26 Sep 2002 16:23:00 -0400
Date: Thu, 26 Sep 2002 13:26:47 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [RFC] LSM changes for 2.5.38
Message-ID: <20020926202647.GB6908@kroah.com>
References: <20020926202552.GA6908@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020926202552.GA6908@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.611   -> 1.612  
#	 include/linux/ipc.h	1.1     -> 1.2    
#	           ipc/msg.c	1.6     -> 1.7    
#	include/linux/security.h	1.3     -> 1.4    
#	    security/dummy.c	1.6     -> 1.7    
#	security/capability.c	1.5     -> 1.6    
#	           ipc/sem.c	1.11    -> 1.12   
#	          ipc/util.c	1.5     -> 1.6    
#	           ipc/shm.c	1.17    -> 1.18   
#	 include/linux/msg.h	1.2     -> 1.3    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/26	sds@tislabs.com	1.612
# [PATCH] LSM: SysV IPC hooks addition
# 
# The patch below adds the LSM hooks for System V IPC to the 2.5.38 kernel.
# --------------------------------------------
#
diff -Nru a/include/linux/ipc.h b/include/linux/ipc.h
--- a/include/linux/ipc.h	Thu Sep 26 13:23:57 2002
+++ b/include/linux/ipc.h	Thu Sep 26 13:23:57 2002
@@ -63,6 +63,7 @@
 	gid_t		cgid;
 	mode_t		mode; 
 	unsigned long	seq;
+	void		*security;
 };
 
 #endif /* __KERNEL__ */
diff -Nru a/include/linux/msg.h b/include/linux/msg.h
--- a/include/linux/msg.h	Thu Sep 26 13:23:57 2002
+++ b/include/linux/msg.h	Thu Sep 26 13:23:57 2002
@@ -69,6 +69,7 @@
 	long  m_type;          
 	int m_ts;           /* message text size */
 	struct msg_msgseg* next;
+	void *security;
 	/* the actual message follows immediately */
 };
 
diff -Nru a/include/linux/security.h b/include/linux/security.h
--- a/include/linux/security.h	Thu Sep 26 13:23:57 2002
+++ b/include/linux/security.h	Thu Sep 26 13:23:57 2002
@@ -572,6 +572,159 @@
  * 	is being reparented to the init task.
  *	@p contains the task_struct for the kernel thread.
  *
+ * Security hooks affecting all System V IPC operations.
+ *
+ * @ipc_permission:
+ *	Check user, group, and other permissions for access to IPC
+ *	@ipcp contains the IPC permission set
+ *	@flag contains the desired (requested) permission set
+ *	Return 0 if permission is granted.
+ * @ipc_getinfo:
+ *	Check permission to retrieve information on previously allocated IPC
+ *	resources.  Called by the IPC resource control syscalls, shmctl,
+ *	msgctl, semctl with a @cmd argument of: IPC_INFO, SEM_INFO, MSG_INFO,
+ *	or SHM_INFO as appropriate.
+ *	@id contains the resource identifier
+ *	@cmd contains the operation to be performed
+ *	Return 0 if permission is granted.
+ *
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
+ *
+ * Security hooks for System V IPC Message Queues
+ *
+ * @msg_queue_alloc_security:
+ *	Allocate and attach a security structure to the
+ *	msq->q_perm.security field. The security field is initialized to
+ *	NULL when the structure is first created.
+ *	@msq contains the message queue structure to be modified.
+ *	Return 0 if operation was successful and permission is granted.
+ * @msg_queue_free_security:
+ *	Deallocate security structure for this message queue.
+ *	@msq contains the message queue structure to be modified.
+ * @msg_queue_associate:
+ *	Check permission when a message queue is requested through the
+ *	msgget system call.  This hook is only called when returning the
+ *	message queue identifier for an existing message queue, not when a
+ *	new message queue is created.
+ *	@msq contains the message queue to act upon.
+ *	@msqid contains the resource identifier.
+ *	@msqflg contains the operation control flags.
+ *	Return 0 if permission is granted.
+ * @msg_queue_msgctl:
+ *	Check permission when a message control operation specified by @cmd
+ *	is to be performed on the message queue @msq, with identifier
+ *	@msqid.
+ *	@msq contains the message queue to act upon.
+ *	@msqid contains the resource identifier.
+ *	@cmd contains the operation to be performed.
+ *	Return 0 if permission is granted.  
+ * @msg_queue_msgsnd:
+ *	Check permission before a message, @msg, is enqueued on the message
+ *	queue, @msq, whose identifier is specified by the value of @msqid.
+ *	@msq contains the message queue to send message to.
+ *	@msg contains the message to be enqueued.
+ *	@msqid contains resource identifier.
+ *	@msqflg contains operational flags.
+ *	Return 0 if permission is granted.
+ * @msg_queue_msgrcv:
+ *	Check permission before a message, @msg, is removed from the message
+ *	queue, @msq, whose identifier is specified by the value of @msqid.  The
+ *	@target task structure contains a pointer to the process that will be
+ *	receiving the message (not equal to the current process when inline
+ *	receives are being performed).
+ *	@msq contains the message queue to retrieve message from.
+ *	@msg contains the message destination.
+ *	@target contains the task structure for recipient process.
+ *	@type contains the type of message requested.
+ *	@mode contains the operational flags.
+ *	Return 0 if permission is granted.
+ *
+ * Security hooks for System V Shared Memory Segments
+ *
+ * @shm_alloc_security:
+ *	Allocate and attach a security structure to the shp->shm_perm.security
+ *	field.  The security field is initialized to NULL when the structure is
+ *	first created.
+ *	@shp contains the shared memory structure to be modified.
+ *	Return 0 if operation was successful and permission is granted.
+ * @shm_free_security:
+ *	Deallocate the security struct for this memory segment.
+ *	@shp contains the shared memory structure to be modified.
+ * @shm_associate:
+ *	Check permission when a shared memory region is requested through the
+ *	shmget system call.  This hook is only called when returning the shared
+ *	memory region identifier for an existing region, not when a new shared
+ *	memory region is created.
+ *	@shp contains the shared memory structure to be modified.
+ *	@shmid contains the resource identifier.
+ *	@shmflg contains the operation control flags.
+ *	Return 0 if permission is granted.
+ * @shm_shmctl:
+ *	Check permission when a shared memory control operation specified by
+ *	@cmd is to be performed on the shared memory region @shp, with
+ *	identifier @shmid.
+ *	@shp contains shared memory structure to be modified.
+ *	@shmid contains the resource identifier.
+ *	@cmd contains the operation to be performed.
+ *	Return 0 if permission is granted.
+ * @shm_shmat:
+ *	Check permissions prior to allowing the shmat system call to attach the
+ *	shared memory segment @shp, identified by @shmid, to the data segment
+ *	of the calling process. The attaching address is specified by @shmaddr.
+ *	@shp contains the shared memory structure to be modified.
+ *	@shmid contains the resource identifier.
+ *	@shmaddr contains the address to attach memory region to.
+ *	@shmflg contains the operational flags.
+ *	Return 0 if permission is granted.
+ *
+ * Security hooks for System V Semaphores
+ *
+ * @sem_alloc_security:
+ *	Allocate and attach a security structure to the sma->sem_perm.security
+ *	field.  The security field is initialized to NULL when the structure is
+ *	first created.
+ *	@sma contains the semaphore structure
+ *	Return 0 if operation was successful and permission is granted.
+ * @sem_free_security:
+ *	deallocate security struct for this semaphore
+ *	@sma contains the semaphore structure.
+ * @sem_associate:
+ *	Check permission when a semaphore is requested through the semget
+ *	system call.  This hook is only called when returning the semaphore
+ *	identifier for an existing semaphore, not when a new one must be
+ *	created.
+ *	@sma contains the semaphore structure.
+ *	@semid contains the resource identifier.
+ *	@semflg contains the operation control flags.
+ *	Return 0 if permission is granted.
+ * @sem_semctl:
+ *	Check permission when a semaphore operation specified by @cmd is to be
+ *	performed on the semaphore @sma, with identifier @semid.
+ *	@sma contains the semaphore structure.
+ *	@semid contains the resource identifier.
+ *	@cmd contains the operation to be performed.
+ *	Return 0 if permission is granted.
+ * @sem_semop
+ *	Check permissions before performing operations on members of the
+ *	semaphore set @sma, identified by @semid.  If the @alter flag is
+ *	nonzero, the semaphore set may be modified.
+ *	@sma contains the semaphore structure.
+ *	@semid contains the resource identifier.
+ *	@sops contains the operations to perform.
+ *	@nsops contains the number of operations to perform.
+ *	@alter contains the flag indicating whether changes are to be made.
+ *	Return 0 if permission is granted.
+ *
  * @ptrace:
  *	Check permission before allowing the @parent process to trace the
  *	@child process.
@@ -785,6 +938,38 @@
 			   unsigned long arg5);
 	void (*task_kmod_set_label) (void);
 	void (*task_reparent_to_init) (struct task_struct * p);
+
+	int (*ipc_permission) (struct kern_ipc_perm * ipcp, short flag);
+	int (*ipc_getinfo) (int id, int cmd);
+
+	int (*msg_msg_alloc_security) (struct msg_msg * msg);
+	void (*msg_msg_free_security) (struct msg_msg * msg);
+
+	int (*msg_queue_alloc_security) (struct msg_queue * msq);
+	void (*msg_queue_free_security) (struct msg_queue * msq);
+	int (*msg_queue_associate) (struct msg_queue * msq, int msqid,
+				    int msqflg);
+	int (*msg_queue_msgctl) (struct msg_queue * msq, int msqid, int cmd);
+	int (*msg_queue_msgsnd) (struct msg_queue * msq,
+				 struct msg_msg * msg, int msqid, int msqflg);
+	int (*msg_queue_msgrcv) (struct msg_queue * msq,
+				 struct msg_msg * msg,
+				 struct task_struct * target,
+				 long type, int mode);
+
+	int (*shm_alloc_security) (struct shmid_kernel * shp);
+	void (*shm_free_security) (struct shmid_kernel * shp);
+	int (*shm_associate) (struct shmid_kernel * shp, int shmid, int shmflg);
+	int (*shm_shmctl) (struct shmid_kernel * shp, int shmid, int cmd);
+	int (*shm_shmat) (struct shmid_kernel * shp, int shmid,
+			  char *shmaddr, int shmflg);
+
+	int (*sem_alloc_security) (struct sem_array * sma);
+	void (*sem_free_security) (struct sem_array * sma);
+	int (*sem_associate) (struct sem_array * sma, int semid, int semflg);
+	int (*sem_semctl) (struct sem_array * sma, int semid, int cmd);
+	int (*sem_semop) (struct sem_array * sma, int semid,
+			  struct sembuf * sops, unsigned nsops, int alter);
 
 	/* allow module stacking */
 	int (*register_security) (const char *name,
diff -Nru a/ipc/msg.c b/ipc/msg.c
--- a/ipc/msg.c	Thu Sep 26 13:23:57 2002
+++ b/ipc/msg.c	Thu Sep 26 13:23:57 2002
@@ -89,6 +89,7 @@
 static int newque (key_t key, int msgflg)
 {
 	int id;
+	int retval;
 	struct msg_queue *msq;
 
 	msq  = (struct msg_queue *) kmalloc (sizeof (*msq), GFP_KERNEL);
@@ -98,8 +99,16 @@
 	msq->q_perm.mode = (msgflg & S_IRWXUGO);
 	msq->q_perm.key = key;
 
+	msq->q_perm.security = NULL;
+	retval = security_ops->msg_queue_alloc_security(msq);
+	if (retval) {
+		kfree(msq);
+		return retval;
+	}
+
 	id = ipc_addid(&msg_ids, &msq->q_perm, msg_ctlmni);
 	if(id == -1) {
+		security_ops->msg_queue_free_security(msq);
 		kfree(msq);
 		return -ENOSPC;
 	}
@@ -120,6 +129,9 @@
 static void free_msg(struct msg_msg* msg)
 {
 	struct msg_msgseg* seg;
+
+	security_ops->msg_msg_free_security(msg);
+
 	seg = msg->next;
 	kfree(msg);
 	while(seg != NULL) {
@@ -145,6 +157,7 @@
 		return ERR_PTR(-ENOMEM);
 
 	msg->next = NULL;
+	msg->security = NULL;
 
 	if (copy_from_user(msg+1, src, alen)) {
 		err = -EFAULT;
@@ -174,6 +187,11 @@
 		len -= alen;
 		src = ((char*)src)+alen;
 	}
+	
+	err = security_ops->msg_msg_alloc_security(msg);
+	if (err)
+		goto out_err;
+
 	return msg;
 
 out_err:
@@ -259,6 +277,8 @@
 
 	msq = msg_rmid(id);
 
+	security_ops->msg_queue_free_security(msq);
+
 	expunge_all(msq,-EIDRM);
 	ss_wakeup(&msq->q_senders,1);
 	msg_unlock(id);
@@ -295,8 +315,12 @@
 			BUG();
 		if (ipcperms(&msq->q_perm, msgflg))
 			ret = -EACCES;
-		else
-			ret = msg_buildid(id, msq->q_perm.seq);
+		else {
+			int qid = msg_buildid(id, msq->q_perm.seq);
+		    	ret = security_ops->msg_queue_associate(msq, qid, msgflg);
+			if (!ret)
+				ret = qid;
+		}
 		msg_unlock(id);
 	}
 	up(&msg_ids.sem);
@@ -418,6 +442,11 @@
 		 * due to padding, it's not enough
 		 * to set all member fields.
 		 */
+
+		err = security_ops->ipc_getinfo(msqid, cmd);
+		if (err)
+			return err;
+
 		memset(&msginfo,0,sizeof(msginfo));	
 		msginfo.msgmni = msg_ctlmni;
 		msginfo.msgmax = msg_ctlmax;
@@ -468,6 +497,10 @@
 		if (ipcperms (&msq->q_perm, S_IRUGO))
 			goto out_unlock;
 
+		err = security_ops->msg_queue_msgctl(msq, msqid, cmd);
+		if (err)
+			goto out_unlock;
+
 		kernel_to_ipc64_perm(&msq->q_perm, &tbuf.msg_perm);
 		tbuf.msg_stime  = msq->q_stime;
 		tbuf.msg_rtime  = msq->q_rtime;
@@ -515,6 +548,11 @@
 	{
 		if (setbuf.qbytes > msg_ctlmnb && !capable(CAP_SYS_RESOURCE))
 			goto out_unlock_up;
+
+		err = security_ops->msg_queue_msgctl(msq, msqid, cmd);
+		if (err)
+			goto out_unlock_up;
+		
 		msq->q_qbytes = setbuf.qbytes;
 
 		ipcp->uid = setbuf.uid;
@@ -534,6 +572,10 @@
 		break;
 	}
 	case IPC_RMID:
+		err = security_ops->msg_queue_msgctl(msq, msqid, cmd);
+		if (err)
+			goto out_unlock_up;
+
 		freeque (msqid); 
 		break;
 	}
@@ -580,7 +622,8 @@
 		struct msg_receiver* msr;
 		msr = list_entry(tmp,struct msg_receiver,r_list);
 		tmp = tmp->next;
-		if(testmsg(msg,msr->r_msgtype,msr->r_mode)) {
+		if(testmsg(msg,msr->r_msgtype,msr->r_mode) &&
+		   !security_ops->msg_queue_msgrcv(msq, msg, msr->r_tsk, msr->r_msgtype, msr->r_mode)) {
 			list_del(&msr->r_list);
 			if(msr->r_maxsize < msg->m_ts) {
 				msr->r_msg = ERR_PTR(-E2BIG);
@@ -631,6 +674,10 @@
 	if (ipcperms(&msq->q_perm, S_IWUGO)) 
 		goto out_unlock_free;
 
+	err = security_ops->msg_queue_msgsnd(msq, msg, msqid, msgflg);
+	if (err)
+		goto out_unlock_free;
+
 	if(msgsz + msq->q_cbytes > msq->q_qbytes ||
 		1 + msq->q_qnum > msq->q_qbytes) {
 		struct msg_sender s;
@@ -729,7 +776,8 @@
 	found_msg=NULL;
 	while (tmp != &msq->q_messages) {
 		msg = list_entry(tmp,struct msg_msg,m_list);
-		if(testmsg(msg,msgtyp,mode)) {
+		if(testmsg(msg,msgtyp,mode) &&
+		   !security_ops->msg_queue_msgrcv(msq, msg, current, msgtyp, mode)) {
 			found_msg = msg;
 			if(mode == SEARCH_LESSEQUAL && msg->m_type != 1) {
 				found_msg=msg;
@@ -747,6 +795,7 @@
 			err=-E2BIG;
 			goto out_unlock;
 		}
+
 		list_del(&msg->m_list);
 		msq->q_qnum--;
 		msq->q_rtime = CURRENT_TIME;
diff -Nru a/ipc/sem.c b/ipc/sem.c
--- a/ipc/sem.c	Thu Sep 26 13:23:57 2002
+++ b/ipc/sem.c	Thu Sep 26 13:23:57 2002
@@ -63,6 +63,7 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/security.h>
 #include <asm/uaccess.h>
 #include "util.h"
 
@@ -115,6 +116,7 @@
 static int newary (key_t key, int nsems, int semflg)
 {
 	int id;
+	int retval;
 	struct sem_array *sma;
 	int size;
 
@@ -133,8 +135,16 @@
 	sma->sem_perm.mode = (semflg & S_IRWXUGO);
 	sma->sem_perm.key = key;
 
+	sma->sem_perm.security = NULL;
+	retval = security_ops->sem_alloc_security(sma);
+	if (retval) {
+		ipc_free(sma, size);
+		return retval;
+	}
+
 	id = ipc_addid(&sem_ids, &sma->sem_perm, sc_semmni);
 	if(id == -1) {
+		security_ops->sem_free_security(sma);
 		ipc_free(sma, size);
 		return -ENOSPC;
 	}
@@ -177,8 +187,12 @@
 			err = -EINVAL;
 		else if (ipcperms(&sma->sem_perm, semflg))
 			err = -EACCES;
-		else
-			err = sem_buildid(id, sma->sem_perm.seq);
+		else {
+			int semid = sem_buildid(id, sma->sem_perm.seq);
+			err = security_ops->sem_associate(sma, semid, semflg);
+			if (!err)
+				err = semid;
+		}
 		sem_unlock(id);
 	}
 
@@ -399,6 +413,7 @@
 	int size;
 
 	sma = sem_rmid(id);
+	security_ops->sem_free_security(sma);
 
 	/* Invalidate the existing undo structures for this semaphore set.
 	 * (They will be freed without any further action in sem_exit()
@@ -453,6 +468,10 @@
 		struct seminfo seminfo;
 		int max_id;
 
+		err = security_ops->ipc_getinfo(semid, cmd);
+		if (err)
+			return err;
+		
 		memset(&seminfo,0,sizeof(seminfo));
 		seminfo.semmni = sc_semmni;
 		seminfo.semmns = sc_semmns;
@@ -494,6 +513,11 @@
 		err = -EACCES;
 		if (ipcperms (&sma->sem_perm, S_IRUGO))
 			goto out_unlock;
+
+		err = security_ops->sem_semctl(sma, semid, cmd);
+		if (err)
+			goto out_unlock;
+
 		id = sem_buildid(semid, sma->sem_perm.seq);
 
 		kernel_to_ipc64_perm(&sma->sem_perm, &tbuf.sem_perm);
@@ -537,6 +561,11 @@
 	if (ipcperms (&sma->sem_perm, (cmd==SETVAL||cmd==SETALL)?S_IWUGO:S_IRUGO))
 		goto out_unlock;
 
+	err = security_ops->sem_semctl(sma, semid, cmd);
+	if (err)
+		goto out_unlock;
+
+	err = -EACCES;
 	switch (cmd) {
 	case GETALL:
 	{
@@ -728,6 +757,10 @@
 		goto out_unlock;
 	}
 
+	err = security_ops->sem_semctl(sma, semid, cmd);
+	if (err)
+		goto out_unlock;
+
 	switch(cmd){
 	case IPC_RMID:
 		freeary(semid);
@@ -1004,6 +1037,12 @@
 	error = -EACCES;
 	if (ipcperms(&sma->sem_perm, alter ? S_IWUGO : S_IRUGO))
 		goto out_unlock_semundo_free;
+
+	error = security_ops->sem_semop(sma, semid, sops, nsops, alter);
+	if (error)
+		goto out_unlock_semundo_free;
+	error = -EACCES;		
+
 	if (undos) {
 		/* Make sure we have an undo structure
 		 * for this process and this semaphore set.
diff -Nru a/ipc/shm.c b/ipc/shm.c
--- a/ipc/shm.c	Thu Sep 26 13:23:57 2002
+++ b/ipc/shm.c	Thu Sep 26 13:23:57 2002
@@ -24,6 +24,7 @@
 #include <linux/mman.h>
 #include <linux/proc_fs.h>
 #include <linux/shmem_fs.h>
+#include <linux/security.h>
 #include <asm/uaccess.h>
 
 #include "util.h"
@@ -113,6 +114,9 @@
 	shm_tot -= (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	shm_rmid (shp->id);
 	shm_unlock(shp->id);
+
+	security_ops->shm_free_security(shp);
+
 	shmem_lock(shp->shm_file, 0);
 	fput (shp->shm_file);
 	kfree (shp);
@@ -185,6 +189,13 @@
 	shp->shm_perm.key = key;
 	shp->shm_flags = (shmflg & S_IRWXUGO);
 
+	shp->shm_perm.security = NULL;
+	error = security_ops->shm_alloc_security(shp);
+	if (error) {
+		kfree(shp);
+		return error;
+	}
+
 	sprintf (name, "SYSV%08x", key);
 	file = shmem_file_setup(name, size, VM_ACCOUNT);
 	error = PTR_ERR(file);
@@ -213,6 +224,7 @@
 no_id:
 	fput(file);
 no_file:
+	security_ops->shm_free_security(shp);
 	kfree(shp);
 	return error;
 }
@@ -240,8 +252,12 @@
 			err = -EINVAL;
 		else if (ipcperms(&shp->shm_perm, shmflg))
 			err = -EACCES;
-		else
-			err = shm_buildid(id, shp->shm_perm.seq);
+		else {
+			int shmid = shm_buildid(id, shp->shm_perm.seq);
+			err = security_ops->shm_associate(shp, shmid, shmflg);
+			if (!err)
+				err = shmid;
+		}
 		shm_unlock(id);
 	}
 	up(&shm_ids.sem);
@@ -379,6 +395,10 @@
 	{
 		struct shminfo64 shminfo;
 
+		err = security_ops->ipc_getinfo(shmid, cmd);
+		if (err)
+			return err;
+
 		memset(&shminfo,0,sizeof(shminfo));
 		shminfo.shmmni = shminfo.shmseg = shm_ctlmni;
 		shminfo.shmmax = shm_ctlmax;
@@ -397,6 +417,10 @@
 	{
 		struct shm_info shm_info;
 
+		err = security_ops->ipc_getinfo(shmid, cmd);
+		if (err)
+			return err;
+
 		memset(&shm_info,0,sizeof(shm_info));
 		down(&shm_ids.sem);
 		shm_lockall();
@@ -422,6 +446,11 @@
 		shp = shm_lock(shmid);
 		if(shp==NULL)
 			return -EINVAL;
+
+		err = security_ops->shm_shmctl(shp, shmid, cmd);
+		if (err)
+			goto out_unlock;
+		
 		if(cmd==SHM_STAT) {
 			err = -EINVAL;
 			if (shmid > shm_ids.max_id)
@@ -464,6 +493,11 @@
 		err = shm_checkid(shp,shmid);
 		if(err)
 			goto out_unlock;
+
+		err = security_ops->shm_shmctl(shp, shmid, cmd);
+		if (err)
+			goto out_unlock;
+		
 		if(cmd==SHM_LOCK) {
 			shmem_lock(shp->shm_file, 1);
 			shp->shm_flags |= SHM_LOCKED;
@@ -494,6 +528,11 @@
 		err = shm_checkid(shp, shmid);
 		if(err)
 			goto out_unlock_up;
+
+		err = security_ops->shm_shmctl(shp, shmid, cmd);
+		if (err)
+			goto out_unlock_up;
+
 		if (current->euid != shp->shm_perm.uid &&
 		    current->euid != shp->shm_perm.cuid && 
 		    !capable(CAP_SYS_ADMIN)) {
@@ -523,6 +562,11 @@
 		err = shm_checkid(shp,shmid);
 		if(err)
 			goto out_unlock_up;
+
+		err = security_ops->shm_shmctl(shp, shmid, cmd);
+		if (err)
+			goto out_unlock_up;
+		
 		err=-EPERM;
 		if (current->euid != shp->shm_perm.uid &&
 		    current->euid != shp->shm_perm.cuid && 
@@ -613,6 +657,13 @@
 		shm_unlock(shmid);
 		return -EACCES;
 	}
+
+	err = security_ops->shm_shmat(shp, shmid, shmaddr, shmflg);
+	if (err) {
+		shm_unlock(shmid);
+		return err;
+	}
+		
 	file = shp->shm_file;
 	size = file->f_dentry->d_inode->i_size;
 	shp->shm_nattch++;
diff -Nru a/ipc/util.c b/ipc/util.c
--- a/ipc/util.c	Thu Sep 26 13:23:57 2002
+++ b/ipc/util.c	Thu Sep 26 13:23:57 2002
@@ -19,6 +19,7 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/highuid.h>
+#include <linux/security.h>
 
 #if defined(CONFIG_SYSVIPC)
 
@@ -263,7 +264,7 @@
 	    !capable(CAP_IPC_OWNER))
 		return -1;
 
-	return 0;
+	return security_ops->ipc_permission(ipcp, flag);
 }
 
 /*
diff -Nru a/security/capability.c b/security/capability.c
--- a/security/capability.c	Thu Sep 26 13:23:57 2002
+++ b/security/capability.c	Thu Sep 26 13:23:57 2002
@@ -679,6 +679,112 @@
 	return;
 }
 
+static int cap_ipc_permission (struct kern_ipc_perm *ipcp, short flag)
+{
+	return 0;
+}
+
+static int cap_ipc_getinfo (int id, int cmd)
+{
+	return 0;
+}
+
+static int cap_msg_msg_alloc_security (struct msg_msg *msg)
+{
+	return 0;
+}
+
+static void cap_msg_msg_free_security (struct msg_msg *msg)
+{
+	return;
+}
+
+static int cap_msg_queue_alloc_security (struct msg_queue *msq)
+{
+	return 0;
+}
+
+static void cap_msg_queue_free_security (struct msg_queue *msq)
+{
+	return;
+}
+
+static int cap_msg_queue_associate (struct msg_queue *msq, int msgid,
+				    int msgflg)
+{
+	return 0;
+}
+
+static int cap_msg_queue_msgctl (struct msg_queue *msq, int msgid, int cmd)
+{
+	return 0;
+}
+
+static int cap_msg_queue_msgsnd (struct msg_queue *msq, struct msg_msg *msg,
+				 int msgid, int msgflg)
+{
+	return 0;
+}
+
+static int cap_msg_queue_msgrcv (struct msg_queue *msq, struct msg_msg *msg,
+				 struct task_struct *target, long type,
+				 int mode)
+{
+	return 0;
+}
+
+static int cap_shm_alloc_security (struct shmid_kernel *shp)
+{
+	return 0;
+}
+
+static void cap_shm_free_security (struct shmid_kernel *shp)
+{
+	return;
+}
+
+static int cap_shm_associate (struct shmid_kernel *shp, int shmid, int shmflg)
+{
+	return 0;
+}
+
+static int cap_shm_shmctl (struct shmid_kernel *shp, int shmid, int cmd)
+{
+	return 0;
+}
+
+static int cap_shm_shmat (struct shmid_kernel *shp, int shmid, char *shmaddr,
+			  int shmflg)
+{
+	return 0;
+}
+
+static int cap_sem_alloc_security (struct sem_array *sma)
+{
+	return 0;
+}
+
+static void cap_sem_free_security (struct sem_array *sma)
+{
+	return;
+}
+
+static int cap_sem_associate (struct sem_array *sma, int semid, int semflg)
+{
+	return 0;
+}
+
+static int cap_sem_semctl (struct sem_array *sma, int semid, int cmd)
+{
+	return 0;
+}
+
+static int cap_sem_semop (struct sem_array *sma, int semid, struct sembuf *sops,
+			  unsigned nsops, int alter)
+{
+	return 0;
+}
+
 static int cap_register (const char *name, struct security_operations *ops)
 {
 	return -EINVAL;
@@ -781,6 +887,31 @@
 	.task_prctl =			cap_task_prctl,
 	.task_kmod_set_label =		cap_task_kmod_set_label,
 	.task_reparent_to_init =	cap_task_reparent_to_init,
+
+	.ipc_permission =		cap_ipc_permission,
+	.ipc_getinfo =			cap_ipc_getinfo,
+	
+	.msg_msg_alloc_security =	cap_msg_msg_alloc_security,
+	.msg_msg_free_security =	cap_msg_msg_free_security,
+
+	.msg_queue_alloc_security =	cap_msg_queue_alloc_security,
+	.msg_queue_free_security =	cap_msg_queue_free_security,
+	.msg_queue_associate =		cap_msg_queue_associate,
+	.msg_queue_msgctl =		cap_msg_queue_msgctl,
+	.msg_queue_msgsnd =		cap_msg_queue_msgsnd,
+	.msg_queue_msgrcv =		cap_msg_queue_msgrcv,
+	
+	.shm_alloc_security =		cap_shm_alloc_security,
+	.shm_free_security =		cap_shm_free_security,
+	.shm_associate =		cap_shm_associate,
+	.shm_shmctl =			cap_shm_shmctl,
+	.shm_shmat =			cap_shm_shmat,
+	
+	.sem_alloc_security =		cap_sem_alloc_security,
+	.sem_free_security =		cap_sem_free_security,
+	.sem_associate =		cap_sem_associate,
+	.sem_semctl =			cap_sem_semctl,
+	.sem_semop =			cap_sem_semop,
 
 	.register_security =		cap_register,
 	.unregister_security =		cap_unregister,
diff -Nru a/security/dummy.c b/security/dummy.c
--- a/security/dummy.c	Thu Sep 26 13:23:57 2002
+++ b/security/dummy.c	Thu Sep 26 13:23:57 2002
@@ -493,6 +493,112 @@
 	return;
 }
 
+static int dummy_ipc_permission (struct kern_ipc_perm *ipcp, short flag)
+{
+	return 0;
+}
+
+static int dummy_ipc_getinfo (int id, int cmd)
+{
+	return 0;
+}
+
+static int dummy_msg_msg_alloc_security (struct msg_msg *msg)
+{
+	return 0;
+}
+
+static void dummy_msg_msg_free_security (struct msg_msg *msg)
+{
+	return;
+}
+
+static int dummy_msg_queue_alloc_security (struct msg_queue *msq)
+{
+	return 0;
+}
+
+static void dummy_msg_queue_free_security (struct msg_queue *msq)
+{
+	return;
+}
+
+static int dummy_msg_queue_associate (struct msg_queue *msq, int msqid,
+				      int msqflg)
+{
+	return 0;
+}
+
+static int dummy_msg_queue_msgctl (struct msg_queue *msq, int msqid, int cmd)
+{
+	return 0;
+}
+
+static int dummy_msg_queue_msgsnd (struct msg_queue *msq, struct msg_msg *msg,
+				   int msqid, int msgflg)
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
+static int dummy_shm_alloc_security (struct shmid_kernel *shp)
+{
+	return 0;
+}
+
+static void dummy_shm_free_security (struct shmid_kernel *shp)
+{
+	return;
+}
+
+static int dummy_shm_associate (struct shmid_kernel *shp, int shmid, int shmflg)
+{
+	return 0;
+}
+
+static int dummy_shm_shmctl (struct shmid_kernel *shp, int shmid, int cmd)
+{
+	return 0;
+}
+
+static int dummy_shm_shmat (struct shmid_kernel *shp, int shmid, char *shmaddr,
+			    int shmflg)
+{
+	return 0;
+}
+
+static int dummy_sem_alloc_security (struct sem_array *sma)
+{
+	return 0;
+}
+
+static void dummy_sem_free_security (struct sem_array *sma)
+{
+	return;
+}
+
+static int dummy_sem_associate (struct sem_array *sma, int semid, int semflg)
+{
+	return 0;
+}
+
+static int dummy_sem_semctl (struct sem_array *sma, int semid, int cmd)
+{
+	return 0;
+}
+
+static int dummy_sem_semop (struct sem_array *sma, int semid,
+			    struct sembuf *sops, unsigned nsops, int alter)
+{
+	return 0;
+}
+
 static int dummy_register (const char *name, struct security_operations *ops)
 {
 	return -EINVAL;
@@ -595,6 +701,31 @@
 	.task_prctl =			dummy_task_prctl,
 	.task_kmod_set_label =		dummy_task_kmod_set_label,
 	.task_reparent_to_init =	dummy_task_reparent_to_init,
+
+	.ipc_permission =		dummy_ipc_permission,
+	.ipc_getinfo =			dummy_ipc_getinfo,
+
+	.msg_msg_alloc_security =	dummy_msg_msg_alloc_security,
+	.msg_msg_free_security =	dummy_msg_msg_free_security,
+	
+	.msg_queue_alloc_security =	dummy_msg_queue_alloc_security,
+	.msg_queue_free_security =	dummy_msg_queue_free_security,
+	.msg_queue_associate =		dummy_msg_queue_associate,
+	.msg_queue_msgctl =		dummy_msg_queue_msgctl,
+	.msg_queue_msgsnd =		dummy_msg_queue_msgsnd,
+	.msg_queue_msgrcv =		dummy_msg_queue_msgrcv,
+	
+	.shm_alloc_security =		dummy_shm_alloc_security,
+	.shm_free_security =		dummy_shm_free_security,
+	.shm_associate =		dummy_shm_associate,
+	.shm_shmctl =			dummy_shm_shmctl,
+	.shm_shmat =			dummy_shm_shmat,
+	
+	.sem_alloc_security =		dummy_sem_alloc_security,
+	.sem_free_security =		dummy_sem_free_security,
+	.sem_associate =		dummy_sem_associate,
+	.sem_semctl =			dummy_sem_semctl,
+	.sem_semop =			dummy_sem_semop,
 
 	.register_security =		dummy_register,
 	.unregister_security =		dummy_unregister,
