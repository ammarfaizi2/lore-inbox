Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265488AbSJaXIr>; Thu, 31 Oct 2002 18:08:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265483AbSJaXHh>; Thu, 31 Oct 2002 18:07:37 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:13228 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265470AbSJaXF1>;
	Thu, 31 Oct 2002 18:05:27 -0500
Message-ID: <3DC1B594.812B8200@us.ibm.com>
Date: Thu, 31 Oct 2002 14:58:28 -0800
From: mingming cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: [PATCH] Latest IPC lock patch- 2.5.44
References: <1036102379.3365.16.camel@dell_ss3.pdx.osdl.net>
Content-Type: multipart/mixed;
 boundary="------------3E7808A0117B063146435ED0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3E7808A0117B063146435ED0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Stephen Hemminger wrote:
> 
> With all the discussion, I lost track of what the current IPC patch is
> for 2.5.44 (or 2.5.45).  Where is it located? Could you send me a copy?

Here is the latest ipc lock patch for 2.5.44 kernel. 

Thanks for your interest.

Mingming
--------------3E7808A0117B063146435ED0
Content-Type: text/plain; charset=us-ascii;
 name="44-ipc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="44-ipc.patch"

diff -urN linux-2.5.44/include/linux/ipc.h 2544-ipc/include/linux/ipc.h
--- linux-2.5.44/include/linux/ipc.h	Fri Oct 18 21:00:42 2002
+++ 2544-ipc/include/linux/ipc.h	Thu Oct 31 09:05:46 2002
@@ -56,6 +56,8 @@
 /* used by in-kernel data structures */
 struct kern_ipc_perm
 {
+	spinlock_t	lock;
+	int		deleted;
 	key_t		key;
 	uid_t		uid;
 	gid_t		gid;
diff -urN linux-2.5.44/ipc/msg.c 2544-ipc/ipc/msg.c
--- linux-2.5.44/ipc/msg.c	Fri Oct 18 21:00:43 2002
+++ 2544-ipc/ipc/msg.c	Thu Oct 31 09:05:46 2002
@@ -65,7 +65,7 @@
 static struct ipc_ids msg_ids;
 
 #define msg_lock(id)	((struct msg_queue*)ipc_lock(&msg_ids,id))
-#define msg_unlock(id)	ipc_unlock(&msg_ids,id)
+#define msg_unlock(msq)	ipc_unlock(&(msq)->q_perm)
 #define msg_rmid(id)	((struct msg_queue*)ipc_rmid(&msg_ids,id))
 #define msg_checkid(msq, msgid)	\
 	ipc_checkid(&msg_ids,&msq->q_perm,msgid)
@@ -93,7 +93,7 @@
 	int retval;
 	struct msg_queue *msq;
 
-	msq  = (struct msg_queue *) kmalloc (sizeof (*msq), GFP_KERNEL);
+	msq  = ipc_rcu_alloc(sizeof(*msq));
 	if (!msq) 
 		return -ENOMEM;
 
@@ -103,14 +103,14 @@
 	msq->q_perm.security = NULL;
 	retval = security_ops->msg_queue_alloc_security(msq);
 	if (retval) {
-		kfree(msq);
+		ipc_rcu_free(msq, sizeof(*msq));
 		return retval;
 	}
 
 	id = ipc_addid(&msg_ids, &msq->q_perm, msg_ctlmni);
 	if(id == -1) {
 		security_ops->msg_queue_free_security(msq);
-		kfree(msq);
+		ipc_rcu_free(msq, sizeof(*msq));
 		return -ENOSPC;
 	}
 
@@ -122,7 +122,7 @@
 	INIT_LIST_HEAD(&msq->q_messages);
 	INIT_LIST_HEAD(&msq->q_receivers);
 	INIT_LIST_HEAD(&msq->q_senders);
-	msg_unlock(id);
+	msg_unlock(msq);
 
 	return msg_buildid(id,msq->q_perm.seq);
 }
@@ -271,7 +271,7 @@
 
 	expunge_all(msq,-EIDRM);
 	ss_wakeup(&msq->q_senders,1);
-	msg_unlock(id);
+	msg_unlock(msq);
 		
 	tmp = msq->q_messages.next;
 	while(tmp != &msq->q_messages) {
@@ -282,7 +282,7 @@
 	}
 	atomic_sub(msq->q_cbytes, &msg_bytes);
 	security_ops->msg_queue_free_security(msq);
-	kfree(msq);
+	ipc_rcu_free(msq, sizeof(struct msg_queue));
 }
 
 asmlinkage long sys_msgget (key_t key, int msgflg)
@@ -308,7 +308,7 @@
 			ret = -EACCES;
 		else
 			ret = msg_buildid(id, msq->q_perm.seq);
-		msg_unlock(id);
+		msg_unlock(msq);
 	}
 	up(&msg_ids.sem);
 	return ret;
@@ -488,7 +488,7 @@
 		tbuf.msg_qbytes = msq->q_qbytes;
 		tbuf.msg_lspid  = msq->q_lspid;
 		tbuf.msg_lrpid  = msq->q_lrpid;
-		msg_unlock(msqid);
+		msg_unlock(msq);
 		if (copy_msqid_to_user(buf, &tbuf, version))
 			return -EFAULT;
 		return success_return;
@@ -541,7 +541,7 @@
 		 * due to a larger queue size.
 		 */
 		ss_wakeup(&msq->q_senders,0);
-		msg_unlock(msqid);
+		msg_unlock(msq);
 		break;
 	}
 	case IPC_RMID:
@@ -553,10 +553,10 @@
 	up(&msg_ids.sem);
 	return err;
 out_unlock_up:
-	msg_unlock(msqid);
+	msg_unlock(msq);
 	goto out_up;
 out_unlock:
-	msg_unlock(msqid);
+	msg_unlock(msq);
 	return err;
 }
 
@@ -651,7 +651,7 @@
 			goto out_unlock_free;
 		}
 		ss_add(msq, &s);
-		msg_unlock(msqid);
+		msg_unlock(msq);
 		schedule();
 		current->state= TASK_RUNNING;
 
@@ -684,7 +684,7 @@
 	msg = NULL;
 
 out_unlock_free:
-	msg_unlock(msqid);
+	msg_unlock(msq);
 out_free:
 	if(msg!=NULL)
 		free_msg(msg);
@@ -766,7 +766,7 @@
 		atomic_sub(msg->m_ts,&msg_bytes);
 		atomic_dec(&msg_hdrs);
 		ss_wakeup(&msq->q_senders,0);
-		msg_unlock(msqid);
+		msg_unlock(msq);
 out_success:
 		msgsz = (msgsz > msg->m_ts) ? msg->m_ts : msgsz;
 		if (put_user (msg->m_type, &msgp->mtype) ||
@@ -777,7 +777,6 @@
 		return msgsz;
 	} else
 	{
-		struct msg_queue *t;
 		/* no message waiting. Prepare for pipelined
 		 * receive.
 		 */
@@ -795,7 +794,7 @@
 		 	msr_d.r_maxsize = msgsz;
 		msr_d.r_msg = ERR_PTR(-EAGAIN);
 		current->state = TASK_INTERRUPTIBLE;
-		msg_unlock(msqid);
+		msg_unlock(msq);
 
 		schedule();
 		current->state = TASK_RUNNING;
@@ -804,21 +803,19 @@
 		if(!IS_ERR(msg)) 
 			goto out_success;
 
-		t = msg_lock(msqid);
-		if(t==NULL)
-			msqid=-1;
+		msq = msg_lock(msqid);
 		msg = (struct msg_msg*)msr_d.r_msg;
 		if(!IS_ERR(msg)) {
 			/* our message arived while we waited for
 			 * the spinlock. Process it.
 			 */
-			if(msqid!=-1)
-				msg_unlock(msqid);
+			if(msq)
+				msg_unlock(msq);
 			goto out_success;
 		}
 		err = PTR_ERR(msg);
 		if(err == -EAGAIN) {
-			if(msqid==-1)
+			if(!msq)
 				BUG();
 			list_del(&msr_d.r_list);
 			if (signal_pending(current))
@@ -828,8 +825,8 @@
 		}
 	}
 out_unlock:
-	if(msqid!=-1)
-		msg_unlock(msqid);
+	if(msq)
+		msg_unlock(msq);
 	return err;
 }
 
@@ -862,7 +859,7 @@
 				msq->q_stime,
 				msq->q_rtime,
 				msq->q_ctime);
-			msg_unlock(i);
+			msg_unlock(msq);
 
 			pos += len;
 			if(pos < offset) {
diff -urN linux-2.5.44/ipc/sem.c 2544-ipc/ipc/sem.c
--- linux-2.5.44/ipc/sem.c	Fri Oct 18 21:01:48 2002
+++ 2544-ipc/ipc/sem.c	Thu Oct 31 09:05:46 2002
@@ -69,7 +69,7 @@
 
 
 #define sem_lock(id)	((struct sem_array*)ipc_lock(&sem_ids,id))
-#define sem_unlock(id)	ipc_unlock(&sem_ids,id)
+#define sem_unlock(sma)	ipc_unlock(&(sma)->sem_perm)
 #define sem_rmid(id)	((struct sem_array*)ipc_rmid(&sem_ids,id))
 #define sem_checkid(sma, semid)	\
 	ipc_checkid(&sem_ids,&sma->sem_perm,semid)
@@ -126,7 +126,7 @@
 		return -ENOSPC;
 
 	size = sizeof (*sma) + nsems * sizeof (struct sem);
-	sma = (struct sem_array *) ipc_alloc(size);
+	sma = ipc_rcu_alloc(size);
 	if (!sma) {
 		return -ENOMEM;
 	}
@@ -138,14 +138,14 @@
 	sma->sem_perm.security = NULL;
 	retval = security_ops->sem_alloc_security(sma);
 	if (retval) {
-		ipc_free(sma, size);
+		ipc_rcu_free(sma, size);
 		return retval;
 	}
 
 	id = ipc_addid(&sem_ids, &sma->sem_perm, sc_semmni);
 	if(id == -1) {
 		security_ops->sem_free_security(sma);
-		ipc_free(sma, size);
+		ipc_rcu_free(sma, size);
 		return -ENOSPC;
 	}
 	used_sems += nsems;
@@ -156,7 +156,7 @@
 	/* sma->undo = NULL; */
 	sma->sem_nsems = nsems;
 	sma->sem_ctime = CURRENT_TIME;
-	sem_unlock(id);
+	sem_unlock(sma);
 
 	return sem_buildid(id, sma->sem_perm.seq);
 }
@@ -189,7 +189,7 @@
 			err = -EACCES;
 		else
 			err = sem_buildid(id, sma->sem_perm.seq);
-		sem_unlock(id);
+		sem_unlock(sma);
 	}
 
 	up(&sem_ids.sem);
@@ -205,12 +205,12 @@
 	if(smanew==NULL)
 		return -EIDRM;
 	if(smanew != sma || sem_checkid(sma,semid) || sma->sem_nsems != nsems) {
-		sem_unlock(semid);
+		sem_unlock(smanew);
 		return -EIDRM;
 	}
 
 	if (ipcperms(&sma->sem_perm, flg)) {
-		sem_unlock(semid);
+		sem_unlock(smanew);
 		return -EACCES;
 	}
 	return 0;
@@ -423,12 +423,12 @@
 		q->prev = NULL;
 		wake_up_process(q->sleeper); /* doesn't sleep */
 	}
-	sem_unlock(id);
+	sem_unlock(sma);
 
 	used_sems -= sma->sem_nsems;
 	size = sizeof (*sma) + sma->sem_nsems * sizeof (struct sem);
 	security_ops->sem_free_security(sma);
-	ipc_free(sma, size);
+	ipc_rcu_free(sma, size);
 }
 
 static unsigned long copy_semid_to_user(void *buf, struct semid64_ds *in, int version)
@@ -456,6 +456,7 @@
 static int semctl_nolock(int semid, int semnum, int cmd, int version, union semun arg)
 {
 	int err = -EINVAL;
+	struct sem_array *sma;
 
 	switch(cmd) {
 	case IPC_INFO:
@@ -489,7 +490,6 @@
 	}
 	case SEM_STAT:
 	{
-		struct sem_array *sma;
 		struct semid64_ds tbuf;
 		int id;
 
@@ -511,7 +511,7 @@
 		tbuf.sem_otime  = sma->sem_otime;
 		tbuf.sem_ctime  = sma->sem_ctime;
 		tbuf.sem_nsems  = sma->sem_nsems;
-		sem_unlock(semid);
+		sem_unlock(sma);
 		if (copy_semid_to_user (arg.buf, &tbuf, version))
 			return -EFAULT;
 		return id;
@@ -521,7 +521,7 @@
 	}
 	return err;
 out_unlock:
-	sem_unlock(semid);
+	sem_unlock(sma);
 	return err;
 }
 
@@ -555,7 +555,7 @@
 		int i;
 
 		if(nsems > SEMMSL_FAST) {
-			sem_unlock(semid);			
+			sem_unlock(sma);			
 			sem_io = ipc_alloc(sizeof(ushort)*nsems);
 			if(sem_io == NULL)
 				return -ENOMEM;
@@ -566,7 +566,7 @@
 
 		for (i = 0; i < sma->sem_nsems; i++)
 			sem_io[i] = sma->sem_base[i].semval;
-		sem_unlock(semid);
+		sem_unlock(sma);
 		err = 0;
 		if(copy_to_user(array, sem_io, nsems*sizeof(ushort)))
 			err = -EFAULT;
@@ -577,7 +577,7 @@
 		int i;
 		struct sem_undo *un;
 
-		sem_unlock(semid);
+		sem_unlock(sma);
 
 		if(nsems > SEMMSL_FAST) {
 			sem_io = ipc_alloc(sizeof(ushort)*nsems);
@@ -619,7 +619,7 @@
 		tbuf.sem_otime  = sma->sem_otime;
 		tbuf.sem_ctime  = sma->sem_ctime;
 		tbuf.sem_nsems  = sma->sem_nsems;
-		sem_unlock(semid);
+		sem_unlock(sma);
 		if (copy_semid_to_user (arg.buf, &tbuf, version))
 			return -EFAULT;
 		return 0;
@@ -665,7 +665,7 @@
 	}
 	}
 out_unlock:
-	sem_unlock(semid);
+	sem_unlock(sma);
 out_free:
 	if(sem_io != fast_sem_io)
 		ipc_free(sem_io, sizeof(ushort)*nsems);
@@ -750,18 +750,18 @@
 		ipcp->mode = (ipcp->mode & ~S_IRWXUGO)
 				| (setbuf.mode & S_IRWXUGO);
 		sma->sem_ctime = CURRENT_TIME;
-		sem_unlock(semid);
+		sem_unlock(sma);
 		err = 0;
 		break;
 	default:
-		sem_unlock(semid);
+		sem_unlock(sma);
 		err = -EINVAL;
 		break;
 	}
 	return err;
 
 out_unlock:
-	sem_unlock(semid);
+	sem_unlock(sma);
 	return err;
 }
 
@@ -914,7 +914,7 @@
 	saved_add_count = 0;
 	if (current->sysvsem.undo_list != NULL)
 		saved_add_count = current->sysvsem.undo_list->add_count;
-	sem_unlock(semid);
+	sem_unlock(sma);
 	unlock_semundo();
 
 	error = get_undo_list(&undo_list);
@@ -1052,18 +1052,17 @@
 	current->sysvsem.sleep_list = &queue;
 
 	for (;;) {
-		struct sem_array* tmp;
 		queue.status = -EINTR;
 		queue.sleeper = current;
 		current->state = TASK_INTERRUPTIBLE;
-		sem_unlock(semid);
+		sem_unlock(sma);
 		unlock_semundo();
 
 		schedule();
 
 		lock_semundo();
-		tmp = sem_lock(semid);
-		if(tmp==NULL) {
+		sma = sem_lock(semid);
+		if(sma==NULL) {
 			if(queue.prev != NULL)
 				BUG();
 			current->sysvsem.sleep_list = NULL;
@@ -1098,7 +1097,7 @@
 	if (alter)
 		update_queue (sma);
 out_unlock_semundo_free:
-	sem_unlock(semid);
+	sem_unlock(sma);
 out_semundo_free:
 	unlock_semundo();
 out_free:
@@ -1185,7 +1184,7 @@
 			remove_from_queue(q->sma,q);
 		}
 		if(sma!=NULL)
-			sem_unlock(semid);
+			sem_unlock(sma);
 	}
 
 	undo_list = current->sysvsem.undo_list;
@@ -1233,7 +1232,7 @@
 		/* maybe some queued-up processes were waiting for this */
 		update_queue(sma);
 next_entry:
-		sem_unlock(semid);
+		sem_unlock(sma);
 	}
 	__exit_semundo(current);
 
@@ -1265,7 +1264,7 @@
 				sma->sem_perm.cgid,
 				sma->sem_otime,
 				sma->sem_ctime);
-			sem_unlock(i);
+			sem_unlock(sma);
 
 			pos += len;
 			if(pos < offset) {
diff -urN linux-2.5.44/ipc/shm.c 2544-ipc/ipc/shm.c
--- linux-2.5.44/ipc/shm.c	Fri Oct 18 21:01:54 2002
+++ 2544-ipc/ipc/shm.c	Thu Oct 31 09:09:44 2002
@@ -37,9 +37,7 @@
 static struct ipc_ids shm_ids;
 
 #define shm_lock(id)	((struct shmid_kernel*)ipc_lock(&shm_ids,id))
-#define shm_unlock(id)	ipc_unlock(&shm_ids,id)
-#define shm_lockall()	ipc_lockall(&shm_ids)
-#define shm_unlockall()	ipc_unlockall(&shm_ids)
+#define shm_unlock(shp)	ipc_unlock(&(shp)->shm_perm)
 #define shm_get(id)	((struct shmid_kernel*)ipc_get(&shm_ids,id))
 #define shm_buildid(id, seq) \
 	ipc_buildid(&shm_ids, id, seq)
@@ -92,7 +90,7 @@
 	shp->shm_atim = CURRENT_TIME;
 	shp->shm_lprid = current->pid;
 	shp->shm_nattch++;
-	shm_unlock(id);
+	shm_unlock(shp);
 }
 
 /* This is called by fork, once for every shm attach. */
@@ -113,11 +111,11 @@
 {
 	shm_tot -= (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	shm_rmid (shp->id);
-	shm_unlock(shp->id);
+	shm_unlock(shp);
 	shmem_lock(shp->shm_file, 0);
 	fput (shp->shm_file);
 	security_ops->shm_free_security(shp);
-	kfree (shp);
+	ipc_rcu_free (shp, sizeof(struct shmid_kernel));
 }
 
 /*
@@ -143,7 +141,7 @@
 	   shp->shm_flags & SHM_DEST)
 		shm_destroy (shp);
 	else
-		shm_unlock(id);
+		shm_unlock(shp);
 	up (&shm_ids.sem);
 }
 
@@ -180,7 +178,7 @@
 	if (shm_tot + numpages >= shm_ctlall)
 		return -ENOSPC;
 
-	shp = (struct shmid_kernel *) kmalloc (sizeof (*shp), GFP_USER);
+	shp = ipc_rcu_alloc(sizeof(*shp));
 	if (!shp)
 		return -ENOMEM;
 
@@ -190,7 +188,7 @@
 	shp->shm_perm.security = NULL;
 	error = security_ops->shm_alloc_security(shp);
 	if (error) {
-		kfree(shp);
+		ipc_rcu_free(shp, sizeof(*shp));
 		return error;
 	}
 
@@ -216,14 +214,14 @@
 	file->f_dentry->d_inode->i_ino = shp->id;
 	file->f_op = &shm_file_operations;
 	shm_tot += numpages;
-	shm_unlock (id);
+	shm_unlock(shp);
 	return shp->id;
 
 no_id:
 	fput(file);
 no_file:
 	security_ops->shm_free_security(shp);
-	kfree(shp);
+	ipc_rcu_free(shp, sizeof(*shp));
 	return error;
 }
 
@@ -252,7 +250,7 @@
 			err = -EACCES;
 		else
 			err = shm_buildid(id, shp->shm_perm.seq);
-		shm_unlock(id);
+		shm_unlock(shp);
 	}
 	up(&shm_ids.sem);
 	return err;
@@ -409,14 +407,12 @@
 
 		memset(&shm_info,0,sizeof(shm_info));
 		down(&shm_ids.sem);
-		shm_lockall();
 		shm_info.used_ids = shm_ids.in_use;
 		shm_get_stat (&shm_info.shm_rss, &shm_info.shm_swp);
 		shm_info.shm_tot = shm_tot;
 		shm_info.swap_attempts = 0;
 		shm_info.swap_successes = 0;
 		err = shm_ids.max_id;
-		shm_unlockall();
 		up(&shm_ids.sem);
 		if(copy_to_user (buf, &shm_info, sizeof(shm_info)))
 			return -EFAULT;
@@ -454,7 +450,7 @@
 		tbuf.shm_cpid	= shp->shm_cprid;
 		tbuf.shm_lpid	= shp->shm_lprid;
 		tbuf.shm_nattch	= shp->shm_nattch;
-		shm_unlock(shmid);
+		shm_unlock(shp);
 		if(copy_shmid_to_user (buf, &tbuf, version))
 			return -EFAULT;
 		return result;
@@ -481,7 +477,7 @@
 			shmem_lock(shp->shm_file, 0);
 			shp->shm_flags &= ~SHM_LOCKED;
 		}
-		shm_unlock(shmid);
+		shm_unlock(shp);
 		return err;
 	}
 	case IPC_RMID:
@@ -514,7 +510,7 @@
 			shp->shm_flags |= SHM_DEST;
 			/* Do not find it any more */
 			shp->shm_perm.key = IPC_PRIVATE;
-			shm_unlock(shmid);
+			shm_unlock(shp);
 		} else
 			shm_destroy (shp);
 		up(&shm_ids.sem);
@@ -554,12 +550,12 @@
 
 	err = 0;
 out_unlock_up:
-	shm_unlock(shmid);
+	shm_unlock(shp);
 out_up:
 	up(&shm_ids.sem);
 	return err;
 out_unlock:
-	shm_unlock(shmid);
+	shm_unlock(shp);
 	return err;
 }
 
@@ -616,17 +612,17 @@
 		return -EINVAL;
 	err = shm_checkid(shp,shmid);
 	if (err) {
-		shm_unlock(shmid);
+		shm_unlock(shp);
 		return err;
 	}
 	if (ipcperms(&shp->shm_perm, acc_mode)) {
-		shm_unlock(shmid);
+		shm_unlock(shp);
 		return -EACCES;
 	}
 	file = shp->shm_file;
 	size = file->f_dentry->d_inode->i_size;
 	shp->shm_nattch++;
-	shm_unlock(shmid);
+	shm_unlock(shp);
 
 	down_write(&current->mm->mmap_sem);
 	if (addr && !(shmflg & SHM_REMAP)) {
@@ -655,7 +651,7 @@
 	   shp->shm_flags & SHM_DEST)
 		shm_destroy (shp);
 	else
-		shm_unlock(shmid);
+		shm_unlock(shp);
 	up (&shm_ids.sem);
 
 	*raddr = (unsigned long) user_addr;
@@ -727,7 +723,7 @@
 				shp->shm_atim,
 				shp->shm_dtim,
 				shp->shm_ctim);
-			shm_unlock(i);
+			shm_unlock(shp);
 
 			pos += len;
 			if(pos < offset) {
diff -urN linux-2.5.44/ipc/util.c 2544-ipc/ipc/util.c
--- linux-2.5.44/ipc/util.c	Fri Oct 18 21:01:49 2002
+++ 2544-ipc/ipc/util.c	Thu Oct 31 09:05:46 2002
@@ -8,6 +8,8 @@
  *            Chris Evans, <chris@ferret.lmh.ox.ac.uk>
  * Nov 1999 - ipc helper functions, unified SMP locking
  *	      Manfred Spraul <manfreds@colorfullife.com>
+ * Oct 2002 - One lock per IPC id. RCU ipc_free for lock-free grow_ary().
+ *            Mingming Cao <cmm@us.ibm.com>
  */
 
 #include <linux/config.h>
@@ -20,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/highuid.h>
 #include <linux/security.h>
+#include <linux/workqueue.h>
 
 #if defined(CONFIG_SYSVIPC)
 
@@ -69,13 +72,12 @@
 		 	ids->seq_max = seq_limit;
 	}
 
-	ids->entries = ipc_alloc(sizeof(struct ipc_id)*size);
+	ids->entries = ipc_rcu_alloc(sizeof(struct ipc_id)*size);
 
 	if(ids->entries == NULL) {
 		printk(KERN_ERR "ipc_init_ids() failed, ipc service disabled.\n");
 		ids->size = 0;
 	}
-	ids->ary = SPIN_LOCK_UNLOCKED;
 	for(i=0;i<ids->size;i++)
 		ids->entries[i].p = NULL;
 }
@@ -84,7 +86,8 @@
  *	ipc_findkey	-	find a key in an ipc identifier set	
  *	@ids: Identifier set
  *	@key: The key to find
- *
+ *	
+ *	Requires ipc_ids.sem locked.
  *	Returns the identifier if found or -1 if not.
  */
  
@@ -92,8 +95,9 @@
 {
 	int id;
 	struct kern_ipc_perm* p;
+	int max_id = ids->max_id;
 
-	for (id = 0; id <= ids->max_id; id++) {
+	for (id = 0; id <= max_id; id++) {
 		p = ids->entries[id].p;
 		if(p==NULL)
 			continue;
@@ -103,6 +107,9 @@
 	return -1;
 }
 
+/*
+ * Requires ipc_ids.sem locked
+ */
 static int grow_ary(struct ipc_ids* ids, int newsize)
 {
 	struct ipc_id* new;
@@ -114,21 +121,21 @@
 	if(newsize <= ids->size)
 		return newsize;
 
-	new = ipc_alloc(sizeof(struct ipc_id)*newsize);
+	new = ipc_rcu_alloc(sizeof(struct ipc_id)*newsize);
 	if(new == NULL)
 		return ids->size;
 	memcpy(new, ids->entries, sizeof(struct ipc_id)*ids->size);
 	for(i=ids->size;i<newsize;i++) {
 		new[i].p = NULL;
 	}
-	spin_lock(&ids->ary);
-
 	old = ids->entries;
-	ids->entries = new;
 	i = ids->size;
+	
+	ids->entries = new;
+	wmb();
 	ids->size = newsize;
-	spin_unlock(&ids->ary);
-	ipc_free(old, sizeof(struct ipc_id)*i);
+
+	ipc_rcu_free(old, sizeof(struct ipc_id)*i);
 	return ids->size;
 }
 
@@ -166,7 +173,10 @@
 	if(ids->seq > ids->seq_max)
 		ids->seq = 0;
 
-	spin_lock(&ids->ary);
+	new->lock = SPIN_LOCK_UNLOCKED;
+	new->deleted = 0;
+	rcu_read_lock();
+	spin_lock(&new->lock);
 	ids->entries[id].p = new;
 	return id;
 }
@@ -180,6 +190,8 @@
  *	fed an invalid identifier. The entry is removed and internal
  *	variables recomputed. The object associated with the identifier
  *	is returned.
+ *	ipc_ids.sem and the spinlock for this ID is hold before this function
+ *	is called, and remain locked on the exit.
  */
  
 struct kern_ipc_perm* ipc_rmid(struct ipc_ids* ids, int id)
@@ -188,6 +200,7 @@
 	int lid = id % SEQ_MULTIPLIER;
 	if(lid >= ids->size)
 		BUG();
+	
 	p = ids->entries[lid].p;
 	ids->entries[lid].p = NULL;
 	if(p==NULL)
@@ -202,6 +215,7 @@
 		} while (ids->entries[lid].p == NULL);
 		ids->max_id = lid;
 	}
+	p->deleted = 1;
 	return p;
 }
 
@@ -224,14 +238,14 @@
 }
 
 /**
- *	ipc_free	-	free ipc space
+ *	ipc_free        -       free ipc space
  *	@ptr: pointer returned by ipc_alloc
  *	@size: size of block
  *
  *	Free a block created with ipc_alloc. The caller must know the size
  *	used in the allocation call.
  */
- 
+
 void ipc_free(void* ptr, int size)
 {
 	if(size > PAGE_SIZE)
@@ -240,6 +254,85 @@
 		kfree(ptr);
 }
 
+struct ipc_rcu_kmalloc
+{
+	struct rcu_head rcu;
+	/* "void *" makes sure alignment of following data is sane. */
+	void *data[0];
+};
+
+struct ipc_rcu_vmalloc
+{
+	struct rcu_head rcu;
+	struct work_struct work;
+	/* "void *" makes sure alignment of following data is sane. */
+	void *data[0];
+};
+
+static inline int rcu_use_vmalloc(int size)
+{
+	/* Too big for a single page? */
+	if (sizeof(struct ipc_rcu_kmalloc) + size > PAGE_SIZE)
+		return 1;
+	return 0;
+}
+
+/**
+ *	ipc_rcu_alloc	-	allocate ipc and rcu space 
+ *	@size: size desired
+ *
+ *	Allocate memory for the rcu header structure +  the object.
+ *	Returns the pointer to the object.
+ *	NULL is returned if the allocation fails. 
+ */
+ 
+void* ipc_rcu_alloc(int size)
+{
+	void* out;
+	/* 
+	 * We prepend the allocation with the rcu struct, and
+	 * workqueue if necessary (for vmalloc). 
+	 */
+	if (rcu_use_vmalloc(size)) {
+		out = vmalloc(sizeof(struct ipc_rcu_vmalloc) + size);
+		if (out) out += sizeof(struct ipc_rcu_vmalloc);
+	} else {
+		out = kmalloc(sizeof(struct ipc_rcu_kmalloc)+size, GFP_KERNEL);
+		if (out) out += sizeof(struct ipc_rcu_kmalloc);
+	}
+
+	return out;
+}
+
+/**
+ *	ipc_schedule_free	- free ipc + rcu space
+ * 
+ * Since RCU callback function is called in bh,
+ * we need to defer the vfree to schedule_work
+ */
+static void ipc_schedule_free(void* arg)
+{
+	struct ipc_rcu_vmalloc *free = arg;
+
+	INIT_WORK(&free->work, vfree, free);
+	schedule_work(&free->work);
+}
+
+void ipc_rcu_free(void* ptr, int size)
+{
+	if (rcu_use_vmalloc(size)) {
+		struct ipc_rcu_vmalloc *free;
+		free = ptr - sizeof(*free);
+		call_rcu(&free->rcu, ipc_schedule_free, free);
+	} else {
+		struct ipc_rcu_kmalloc *free;
+		free = ptr - sizeof(*free);
+		/* kfree takes a "const void *" so gcc warns.  So we cast. */
+		call_rcu(&free->rcu, (void (*)(void *))kfree, free);
+	}
+
+}
+
 /**
  *	ipcperms	-	check IPC permissions
  *	@ipcp: IPC permission set
diff -urN linux-2.5.44/ipc/util.h 2544-ipc/ipc/util.h
--- linux-2.5.44/ipc/util.h	Fri Oct 18 21:01:57 2002
+++ 2544-ipc/ipc/util.h	Thu Oct 31 09:05:46 2002
@@ -4,6 +4,7 @@
  *
  * ipc helper functions (c) 1999 Manfred Spraul <manfreds@colorfullife.com>
  */
+#include <linux/rcupdate.h>
 
 #define USHRT_MAX 0xffff
 #define SEQ_MULTIPLIER	(IPCMNI)
@@ -19,7 +20,6 @@
 	unsigned short seq;
 	unsigned short seq_max;
 	struct semaphore sem;	
-	spinlock_t ary;
 	struct ipc_id* entries;
 };
 
@@ -27,7 +27,6 @@
 	struct kern_ipc_perm* p;
 };
 
-
 void __init ipc_init_ids(struct ipc_ids* ids, int size);
 
 /* must be called with ids->sem acquired.*/
@@ -44,44 +43,69 @@
  */
 void* ipc_alloc(int size);
 void ipc_free(void* ptr, int size);
+/* for allocation that need to be freed by RCU
+ * both function can sleep
+ */
+void* ipc_rcu_alloc(int size);
+void ipc_rcu_free(void* arg, int size);
 
-extern inline void ipc_lockall(struct ipc_ids* ids)
-{
-	spin_lock(&ids->ary);
-}
-
+/*
+ * ipc_get() requires ipc_ids.sem down, otherwise we need a rmb() here
+ * to sync with grow_ary();
+ *
+ * So far only shm_get_stat() uses ipc_get() via shm_get().  So ipc_get()
+ * is called with shm_ids.sem locked.  Thus a rmb() is not needed here,
+ * as grow_ary() also requires shm_ids.sem down(for shm).
+ *
+ * But if ipc_get() is used in the future without ipc_ids.sem down,
+ * we need to add a rmb() before accessing the entries array
+ */
 extern inline struct kern_ipc_perm* ipc_get(struct ipc_ids* ids, int id)
 {
 	struct kern_ipc_perm* out;
 	int lid = id % SEQ_MULTIPLIER;
 	if(lid >= ids->size)
 		return NULL;
-
+	rmb();
 	out = ids->entries[lid].p;
 	return out;
 }
 
-extern inline void ipc_unlockall(struct ipc_ids* ids)
-{
-	spin_unlock(&ids->ary);
-}
 extern inline struct kern_ipc_perm* ipc_lock(struct ipc_ids* ids, int id)
 {
 	struct kern_ipc_perm* out;
 	int lid = id % SEQ_MULTIPLIER;
-	if(lid >= ids->size)
+
+	rcu_read_lock();
+	if(lid >= ids->size) {
+		rcu_read_unlock();
 		return NULL;
+	}
 
-	spin_lock(&ids->ary);
+	/* we need a barrier here to sync with grow_ary() */
+	rmb();
 	out = ids->entries[lid].p;
-	if(out==NULL)
-		spin_unlock(&ids->ary);
+	if(out == NULL) {
+		rcu_read_unlock();
+		return NULL;
+	}
+	spin_lock(&out->lock);
+	
+	/* ipc_rmid() may have already freed the ID while ipc_lock
+	 * was spinning: here verify that the structure is still valid
+	 */
+	if (out->deleted) {
+		spin_unlock(&out->lock);
+		rcu_read_unlock();
+		return NULL;
+	}
 	return out;
 }
 
-extern inline void ipc_unlock(struct ipc_ids* ids, int id)
+extern inline void ipc_unlock(struct kern_ipc_perm* perm)
 {
-	spin_unlock(&ids->ary);
+	spin_unlock(&perm->lock);
+	rcu_read_unlock();
 }
 
 extern inline int ipc_buildid(struct ipc_ids* ids, int id, int seq)

--------------3E7808A0117B063146435ED0--

