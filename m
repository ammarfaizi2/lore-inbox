Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265690AbSJXVsq>; Thu, 24 Oct 2002 17:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265693AbSJXVsq>; Thu, 24 Oct 2002 17:48:46 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:38633 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265690AbSJXVsR>; Thu, 24 Oct 2002 17:48:17 -0400
Message-ID: <3DB86B05.447E7410@us.ibm.com>
Date: Thu, 24 Oct 2002 14:49:57 -0700
From: mingming cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>,
       manfred@colorfullife.com
CC: linux-kernel@vger.kernel.org, dipankar@in.ibm.com,
       lse-tech@lists.sourceforge.net, cmm@us.ibm.com
Subject: [PATCH]updated ipc lock patch
References: <Pine.LNX.4.44.0210211946470.17128-100000@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------04DCA32FFDAA242C091697BE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------04DCA32FFDAA242C091697BE
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Andrew,

Here is the updated ipc lock patch:

- It greatly reduces the lock contention by having one lock per id. The
global spinlock is removed and a spinlock is added in kern_ipc_perm
structure.

- Uses ReadCopyUpdate in grow_ary() for locking-free resizing.

- In the places where ipc_rmid() is called, delay calling ipc_free() to
RCU callbacks.  This is to prevent ipc_lock() returning an invalid
pointer after ipc_rmid().  In addition, use the workqueue to enable RCU
freeing vmalloced entries.

Also some other changes:
- Remove redundant ipc_lockall/ipc_unlockall
- Now ipc_unlock() directly takes IPC ID pointer as argument, avoid
extra looking up the array.

The changes are made based on the input from Huge Dickens, Manfred
Spraul and Dipankar Sarma. In addition, Cliff White has run OSDL's dbt1
test on a 2 way against the earlier version of this patch. Results shows
about 2-6% improvement on the average number of transactions per
second.  Here is the summary of his tests:

                        2.5.42-mm2      2.5.42-mm2-ipclock
----------------------------------------------------------
Average over 5 runs	85.0 BT		89.8 BT
Std Deviation 5 runs	7.4  BT		1.0 BT

Average over 4 best 	88.15 BT	90.2 BT
Std Deviation 4 best	2.8 BT		0.5 BT

Full details of the tests could be found here:
http://www.osdl.org/projects/dbt1prfrns/results/mingming/index.html

patch is against 2.5.44-mm4.  Please include or give any feedback.

Thanks,

Mingming Cao
--------------04DCA32FFDAA242C091697BE
Content-Type: text/plain; charset=us-ascii;
 name="ipclock-2544mm4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipclock-2544mm4.patch"

diff -urN 2544-mm4/include/linux/ipc.h 2544-mm4-ipc/include/linux/ipc.h
--- 2544-mm4/include/linux/ipc.h	Fri Oct 18 21:00:42 2002
+++ 2544-mm4-ipc/include/linux/ipc.h	Thu Oct 24 13:59:24 2002
@@ -56,6 +56,8 @@
 /* used by in-kernel data structures */
 struct kern_ipc_perm
 {
+	spinlock_t	lock;
+	int		deleted;
 	key_t		key;
 	uid_t		uid;
 	gid_t		gid;
diff -urN 2544-mm4/ipc/msg.c 2544-mm4-ipc/ipc/msg.c
--- 2544-mm4/ipc/msg.c	Fri Oct 18 21:00:43 2002
+++ 2544-mm4-ipc/ipc/msg.c	Thu Oct 24 13:59:24 2002
@@ -65,7 +65,7 @@
 static struct ipc_ids msg_ids;
 
 #define msg_lock(id)	((struct msg_queue*)ipc_lock(&msg_ids,id))
-#define msg_unlock(id)	ipc_unlock(&msg_ids,id)
+#define msg_unlock(msq)	ipc_unlock(&(msq)->q_perm)
 #define msg_rmid(id)	((struct msg_queue*)ipc_rmid(&msg_ids,id))
 #define msg_checkid(msq, msgid)	\
 	ipc_checkid(&msg_ids,&msq->q_perm,msgid)
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
diff -urN 2544-mm4/ipc/sem.c 2544-mm4-ipc/ipc/sem.c
--- 2544-mm4/ipc/sem.c	Fri Oct 18 21:01:48 2002
+++ 2544-mm4-ipc/ipc/sem.c	Thu Oct 24 13:59:24 2002
@@ -69,7 +69,7 @@
 
 
 #define sem_lock(id)	((struct sem_array*)ipc_lock(&sem_ids,id))
-#define sem_unlock(id)	ipc_unlock(&sem_ids,id)
+#define sem_unlock(sma)	ipc_unlock(&(sma)->sem_perm)
 #define sem_rmid(id)	((struct sem_array*)ipc_rmid(&sem_ids,id))
 #define sem_checkid(sma, semid)	\
 	ipc_checkid(&sem_ids,&sma->sem_perm,semid)
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
diff -urN 2544-mm4/ipc/shm.c 2544-mm4-ipc/ipc/shm.c
--- 2544-mm4/ipc/shm.c	Thu Oct 24 09:22:14 2002
+++ 2544-mm4-ipc/ipc/shm.c	Thu Oct 24 13:59:24 2002
@@ -38,9 +38,7 @@
 static struct ipc_ids shm_ids;
 
 #define shm_lock(id)	((struct shmid_kernel*)ipc_lock(&shm_ids,id))
-#define shm_unlock(id)	ipc_unlock(&shm_ids,id)
-#define shm_lockall()	ipc_lockall(&shm_ids)
-#define shm_unlockall()	ipc_unlockall(&shm_ids)
+#define shm_unlock(shp)	ipc_unlock(&(shp)->shm_perm)
 #define shm_get(id)	((struct shmid_kernel*)ipc_get(&shm_ids,id))
 #define shm_buildid(id, seq) \
 	ipc_buildid(&shm_ids, id, seq)
@@ -93,7 +91,7 @@
 	shp->shm_atim = CURRENT_TIME;
 	shp->shm_lprid = current->pid;
 	shp->shm_nattch++;
-	shm_unlock(id);
+	shm_unlock(shp);
 }
 
 /* This is called by fork, once for every shm attach. */
@@ -114,7 +112,7 @@
 {
 	shm_tot -= (shp->shm_segsz + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	shm_rmid (shp->id);
-	shm_unlock(shp->id);
+	shm_unlock(shp);
 	if (!is_file_hugepages(shp->shm_file))
 		shmem_lock(shp->shm_file, 0);
 	fput (shp->shm_file);
@@ -145,7 +143,7 @@
 	   shp->shm_flags & SHM_DEST)
 		shm_destroy (shp);
 	else
-		shm_unlock(id);
+		shm_unlock(shp);
 	up (&shm_ids.sem);
 }
 
@@ -225,7 +223,7 @@
 	else
 		file->f_op = &shm_file_operations;
 	shm_tot += numpages;
-	shm_unlock (id);
+	shm_unlock(shp);
 	return shp->id;
 
 no_id:
@@ -261,7 +259,7 @@
 			err = -EACCES;
 		else
 			err = shm_buildid(id, shp->shm_perm.seq);
-		shm_unlock(id);
+		shm_unlock(shp);
 	}
 	up(&shm_ids.sem);
 
@@ -421,14 +419,12 @@
 
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
 		if(copy_to_user (buf, &shm_info, sizeof(shm_info))) {
 			err = -EFAULT;
@@ -470,7 +466,7 @@
 		tbuf.shm_cpid	= shp->shm_cprid;
 		tbuf.shm_lpid	= shp->shm_lprid;
 		tbuf.shm_nattch	= shp->shm_nattch;
-		shm_unlock(shmid);
+		shm_unlock(shp);
 		if(copy_shmid_to_user (buf, &tbuf, version))
 			err = -EFAULT;
 		else
@@ -505,7 +501,7 @@
 				shmem_lock(shp->shm_file, 0);
 			shp->shm_flags &= ~SHM_LOCKED;
 		}
-		shm_unlock(shmid);
+		shm_unlock(shp);
 		goto out;
 	}
 	case IPC_RMID:
@@ -538,7 +534,7 @@
 			shp->shm_flags |= SHM_DEST;
 			/* Do not find it any more */
 			shp->shm_perm.key = IPC_PRIVATE;
-			shm_unlock(shmid);
+			shm_unlock(shp);
 		} else
 			shm_destroy (shp);
 		up(&shm_ids.sem);
@@ -581,12 +577,12 @@
 
 	err = 0;
 out_unlock_up:
-	shm_unlock(shmid);
+	shm_unlock(shp);
 out_up:
 	up(&shm_ids.sem);
 	goto out;
 out_unlock:
-	shm_unlock(shmid);
+	shm_unlock(shp);
 out:
 	return err;
 }
@@ -646,18 +642,18 @@
 	}
 	err = shm_checkid(shp,shmid);
 	if (err) {
-		shm_unlock(shmid);
+		shm_unlock(shp);
 		goto out;
 	}
 	if (ipcperms(&shp->shm_perm, acc_mode)) {
-		shm_unlock(shmid);
+		shm_unlock(shp);
 		err = -EACCES;
 		goto out;
 	}
 	file = shp->shm_file;
 	size = file->f_dentry->d_inode->i_size;
 	shp->shm_nattch++;
-	shm_unlock(shmid);
+	shm_unlock(shp);
 
 	down_write(&current->mm->mmap_sem);
 	if (addr && !(shmflg & SHM_REMAP)) {
@@ -686,7 +682,7 @@
 	   shp->shm_flags & SHM_DEST)
 		shm_destroy (shp);
 	else
-		shm_unlock(shmid);
+		shm_unlock(shp);
 	up (&shm_ids.sem);
 
 	*raddr = (unsigned long) user_addr;
@@ -764,7 +760,7 @@
 				shp->shm_atim,
 				shp->shm_dtim,
 				shp->shm_ctim);
-			shm_unlock(i);
+			shm_unlock(shp);
 
 			pos += len;
 			if(pos < offset) {
diff -urN 2544-mm4/ipc/util.c 2544-mm4-ipc/ipc/util.c
--- 2544-mm4/ipc/util.c	Fri Oct 18 21:01:49 2002
+++ 2544-mm4-ipc/ipc/util.c	Thu Oct 24 13:59:24 2002
@@ -8,6 +8,8 @@
  *            Chris Evans, <chris@ferret.lmh.ox.ac.uk>
  * Nov 1999 - ipc helper functions, unified SMP locking
  *	      Manfred Spraul <manfreds@colorfullife.com>
+ * Oct 2002 - One lock per IPC id. RCU ipc_free for lock-free grow_ary().
+ *            Mingming Cao <cmm@us.ibm.com>
  */
 
 #include <linux/config.h>
@@ -75,7 +77,6 @@
 		printk(KERN_ERR "ipc_init_ids() failed, ipc service disabled.\n");
 		ids->size = 0;
 	}
-	ids->ary = SPIN_LOCK_UNLOCKED;
 	for(i=0;i<ids->size;i++)
 		ids->entries[i].p = NULL;
 }
@@ -92,8 +93,10 @@
 {
 	int id;
 	struct kern_ipc_perm* p;
+	int max_id = ids->max_id;
 
-	for (id = 0; id <= ids->max_id; id++) {
+	read_barrier_depends();
+	for (id = 0; id <= max_id; id++) {
 		p = ids->entries[id].p;
 		if(p==NULL)
 			continue;
@@ -121,14 +124,14 @@
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
 
@@ -166,7 +169,10 @@
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
@@ -188,6 +194,7 @@
 	int lid = id % SEQ_MULTIPLIER;
 	if(lid >= ids->size)
 		BUG();
+	rmb();
 	p = ids->entries[lid].p;
 	ids->entries[lid].p = NULL;
 	if(p==NULL)
@@ -202,6 +209,7 @@
 		} while (ids->entries[lid].p == NULL);
 		ids->max_id = lid;
 	}
+	p->deleted = 1;
 	return p;
 }
 
@@ -240,6 +248,44 @@
 		kfree(ptr);
 }
 
+/* 
+ * Since RCU callback function is called in bh,
+ * we need to defer the vfree to schedule_work
+ */
+static void ipc_free_scheduled(void* arg)
+{
+	struct rcu_ipc_free *a = (struct rcu_ipc_free *)arg;
+	vfree(a->ptr);
+	kfree(a);
+}
+
+static void ipc_free_callback(void* arg)
+{
+	struct rcu_ipc_free *a = (struct rcu_ipc_free *)arg;
+	/* 
+	 * if data is vmalloced, then we need to delay the free
+	 */
+	if (a->size > PAGE_SIZE) {
+		INIT_WORK(&a->work, ipc_free_scheduled, arg);
+		schedule_work(&a->work);
+	} else {
+		kfree(a->ptr);
+		kfree(a);
+	}
+}
+
+void ipc_rcu_free(void* ptr, int size)
+{
+	struct rcu_ipc_free* arg;
+
+	arg = (struct rcu_ipc_free *) kmalloc(sizeof(*arg), GFP_KERNEL);
+	if (arg == NULL)
+		return;
+	arg->ptr = ptr;
+	arg->size = size;
+	call_rcu(&arg->rcu_head, ipc_free_callback, arg);
+}
+
 /**
  *	ipcperms	-	check IPC permissions
  *	@ipcp: IPC permission set
diff -urN 2544-mm4/ipc/util.h 2544-mm4-ipc/ipc/util.h
--- 2544-mm4/ipc/util.h	Fri Oct 18 21:01:57 2002
+++ 2544-mm4-ipc/ipc/util.h	Thu Oct 24 13:59:24 2002
@@ -4,6 +4,8 @@
  *
  * ipc helper functions (c) 1999 Manfred Spraul <manfreds@colorfullife.com>
  */
+#include <linux/rcupdate.h>
+#include <linux/workqueue.h>
 
 #define USHRT_MAX 0xffff
 #define SEQ_MULTIPLIER	(IPCMNI)
@@ -12,6 +14,13 @@
 void msg_init (void);
 void shm_init (void);
 
+struct rcu_ipc_free {
+	struct rcu_head		rcu_head;
+	void 			*ptr;
+	int 			size;
+	struct work_struct	work;
+};
+
 struct ipc_ids {
 	int size;
 	int in_use;
@@ -19,7 +28,6 @@
 	unsigned short seq;
 	unsigned short seq_max;
 	struct semaphore sem;	
-	spinlock_t ary;
 	struct ipc_id* entries;
 };
 
@@ -44,11 +52,7 @@
  */
 void* ipc_alloc(int size);
 void ipc_free(void* ptr, int size);
-
-extern inline void ipc_lockall(struct ipc_ids* ids)
-{
-	spin_lock(&ids->ary);
-}
+void ipc_rcu_free(void* arg, int size);
 
 extern inline struct kern_ipc_perm* ipc_get(struct ipc_ids* ids, int id)
 {
@@ -56,32 +60,44 @@
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
-		return NULL;
 
-	spin_lock(&ids->ary);
+	rcu_read_lock();
+	if(lid >= ids->size) {
+		rcu_read_unlock();
+		return NULL;
+	}
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

--------------04DCA32FFDAA242C091697BE--

