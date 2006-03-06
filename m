Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWCFXxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWCFXxW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 18:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbWCFXxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 18:53:06 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:51640 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752053AbWCFXxB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 18:53:01 -0500
Subject: [RFC][PATCH 4/6] sysvsem: containerize
To: linux-kernel@vger.kernel.org
Cc: serue@us.ibm.com, frankeh@watson.ibm.com, clg@fr.ibm.com,
       Herbert Poetzl <herbert@13thfloor.at>, Sam Vilain <sam@vilain.net>,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Mon, 06 Mar 2006 15:52:51 -0800
References: <20060306235248.20842700@localhost.localdomain>
In-Reply-To: <20060306235248.20842700@localhost.localdomain>
Message-Id: <20060306235251.04FABF95@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Same thing as the msgs.  

Take all of the global sysv sem context and put it inside of
a special structure.  This allows future work to give different
containers completely different views into the sysv space.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 work-dave/ipc/sem.c  |  194 ++++++++++++++++++++++++++-------------------------
 work-dave/ipc/util.c |    2 
 work-dave/ipc/util.h |   15 ++-
 3 files changed, 114 insertions(+), 97 deletions(-)

diff -puN ipc/sem.c~sysvsem-container ipc/sem.c
--- work/ipc/sem.c~sysvsem-container	2006-03-06 15:41:58.000000000 -0800
+++ work-dave/ipc/sem.c	2006-03-06 15:41:58.000000000 -0800
@@ -79,17 +79,19 @@
 #include "util.h"
 
 
-#define sem_lock(id)	((struct sem_array*)ipc_lock(&sem_ids,id))
-#define sem_unlock(sma)	ipc_unlock(&(sma)->sem_perm)
-#define sem_rmid(id)	((struct sem_array*)ipc_rmid(&sem_ids,id))
-#define sem_checkid(sma, semid)	\
-	ipc_checkid(&sem_ids,&sma->sem_perm,semid)
-#define sem_buildid(id, seq) \
-	ipc_buildid(&sem_ids, id, seq)
-static struct ipc_ids sem_ids;
+#define sem_lock(context, id)		\
+	((struct sem_array*)ipc_lock(&context->ids,id))
+#define sem_unlock(context, sma)	\
+	ipc_unlock(&(sma)->sem_perm)
+#define sem_rmid(context, id)		\
+	((struct sem_array*)ipc_rmid(&context->ids,id))
+#define sem_checkid(context, sma, semid)	\
+	ipc_checkid(&context->ids,&sma->sem_perm,semid)
+#define sem_buildid(context, id, seq) \
+	ipc_buildid(&context->ids, id, seq)
 
-static int newary (key_t, int, int);
-static void freeary (struct sem_array *sma, int id);
+static int newary (struct ipc_sem_context *, key_t, int, int);
+static void freeary (struct ipc_sem_context *, struct sem_array *, int);
 #ifdef CONFIG_PROC_FS
 static int sysvipc_sem_proc_show(struct seq_file *s, void *it);
 #endif
@@ -112,15 +114,12 @@ int sem_ctls[4] = {SEMMSL, SEMMNS, SEMOP
 #define sc_semopm	(sem_ctls[2])
 #define sc_semmni	(sem_ctls[3])
 
-static int used_sems;
-
-void __init sem_init (void)
+void __init sem_init (struct ipc_sem_context *context)
 {
-	used_sems = 0;
-	ipc_init_ids(&sem_ids,sc_semmni);
+	ipc_init_ids(&context->ids,sc_semmni);
 	ipc_init_proc_interface("sysvipc/sem",
 				"       key      semid perms      nsems   uid   gid  cuid  cgid      otime      ctime\n",
-				&sem_ids,
+				&context->ids,
 				sysvipc_sem_proc_show);
 }
 
@@ -158,7 +157,8 @@ void __init sem_init (void)
  */
 #define IN_WAKEUP	1
 
-static int newary (key_t key, int nsems, int semflg)
+static int newary (struct ipc_sem_context *context,
+		   key_t key, int nsems, int semflg)
 {
 	int id;
 	int retval;
@@ -167,7 +167,7 @@ static int newary (key_t key, int nsems,
 
 	if (!nsems)
 		return -EINVAL;
-	if (used_sems + nsems > sc_semmns)
+	if (context->nr_used + nsems > sc_semmns)
 		return -ENOSPC;
 
 	size = sizeof (*sma) + nsems * sizeof (struct sem);
@@ -187,22 +187,22 @@ static int newary (key_t key, int nsems,
 		return retval;
 	}
 
-	id = ipc_addid(&sem_ids, &sma->sem_perm, sc_semmni);
+	id = ipc_addid(&context->ids, &sma->sem_perm, sc_semmni);
 	if(id == -1) {
 		security_sem_free(sma);
 		ipc_rcu_putref(sma);
 		return -ENOSPC;
 	}
-	used_sems += nsems;
+	context->nr_used += nsems;
 
-	sma->sem_id = sem_buildid(id, sma->sem_perm.seq);
+	sma->sem_id = sem_buildid(context, id, sma->sem_perm.seq);
 	sma->sem_base = (struct sem *) &sma[1];
 	/* sma->sem_pending = NULL; */
 	sma->sem_pending_last = &sma->sem_pending;
 	/* sma->undo = NULL; */
 	sma->sem_nsems = nsems;
 	sma->sem_ctime = get_seconds();
-	sem_unlock(sma);
+	sem_unlock(context, sma);
 
 	return sma->sem_id;
 }
@@ -211,22 +211,23 @@ asmlinkage long sys_semget (key_t key, i
 {
 	int id, err = -EINVAL;
 	struct sem_array *sma;
+	struct ipc_sem_context *context = &current->ipc_context->sem;
 
 	if (nsems < 0 || nsems > sc_semmsl)
 		return -EINVAL;
-	down(&sem_ids.sem);
+	down(&context->ids.sem);
 	
 	if (key == IPC_PRIVATE) {
-		err = newary(key, nsems, semflg);
-	} else if ((id = ipc_findkey(&sem_ids, key)) == -1) {  /* key not used */
+		err = newary(context, key, nsems, semflg);
+	} else if ((id = ipc_findkey(&context->ids, key)) == -1) {  /* key not used */
 		if (!(semflg & IPC_CREAT))
 			err = -ENOENT;
 		else
-			err = newary(key, nsems, semflg);
+			err = newary(context, key, nsems, semflg);
 	} else if (semflg & IPC_CREAT && semflg & IPC_EXCL) {
 		err = -EEXIST;
 	} else {
-		sma = sem_lock(id);
+		sma = sem_lock(context, id);
 		if(sma==NULL)
 			BUG();
 		if (nsems > sma->sem_nsems)
@@ -234,15 +235,15 @@ asmlinkage long sys_semget (key_t key, i
 		else if (ipcperms(&sma->sem_perm, semflg))
 			err = -EACCES;
 		else {
-			int semid = sem_buildid(id, sma->sem_perm.seq);
+			int semid = sem_buildid(context, id, sma->sem_perm.seq);
 			err = security_sem_associate(sma, semflg);
 			if (!err)
 				err = semid;
 		}
-		sem_unlock(sma);
+		sem_unlock(context, sma);
 	}
 
-	up(&sem_ids.sem);
+	up(&context->ids.sem);
 	return err;
 }
 
@@ -437,11 +438,12 @@ static int count_semzcnt (struct sem_arr
 	return semzcnt;
 }
 
-/* Free a semaphore set. freeary() is called with sem_ids.sem down and
- * the spinlock for this semaphore set hold. sem_ids.sem remains locked
+/* Free a semaphore set. freeary() is called with context->ids.sem down and
+ * the spinlock for this semaphore set hold. context->ids.sem remains locked
  * on exit.
  */
-static void freeary (struct sem_array *sma, int id)
+static void freeary (struct ipc_sem_context *context,
+		     struct sem_array *sma, int id)
 {
 	struct sem_undo *un;
 	struct sem_queue *q;
@@ -469,10 +471,10 @@ static void freeary (struct sem_array *s
 	}
 
 	/* Remove the semaphore set from the ID array*/
-	sma = sem_rmid(id);
-	sem_unlock(sma);
+	sma = sem_rmid(context, id);
+	sem_unlock(context, sma);
 
-	used_sems -= sma->sem_nsems;
+	context->nr_used -= sma->sem_nsems;
 	size = sizeof (*sma) + sma->sem_nsems * sizeof (struct sem);
 	security_sem_free(sma);
 	ipc_rcu_putref(sma);
@@ -500,7 +502,8 @@ static unsigned long copy_semid_to_user(
 	}
 }
 
-static int semctl_nolock(int semid, int semnum, int cmd, int version, union semun arg)
+static int semctl_nolock(struct ipc_sem_context *context,
+		         int semid, int semnum, int cmd, int version, union semun arg)
 {
 	int err = -EINVAL;
 	struct sem_array *sma;
@@ -525,16 +528,16 @@ static int semctl_nolock(int semid, int 
 		seminfo.semmnu = SEMMNU;
 		seminfo.semmap = SEMMAP;
 		seminfo.semume = SEMUME;
-		down(&sem_ids.sem);
+		down(&context->ids.sem);
 		if (cmd == SEM_INFO) {
-			seminfo.semusz = sem_ids.in_use;
-			seminfo.semaem = used_sems;
+			seminfo.semusz = context->ids.in_use;
+			seminfo.semaem = context->nr_used;
 		} else {
 			seminfo.semusz = SEMUSZ;
 			seminfo.semaem = SEMAEM;
 		}
-		max_id = sem_ids.max_id;
-		up(&sem_ids.sem);
+		max_id = context->ids.max_id;
+		up(&context->ids.sem);
 		if (copy_to_user (arg.__buf, &seminfo, sizeof(struct seminfo))) 
 			return -EFAULT;
 		return (max_id < 0) ? 0: max_id;
@@ -544,12 +547,12 @@ static int semctl_nolock(int semid, int 
 		struct semid64_ds tbuf;
 		int id;
 
-		if(semid >= sem_ids.entries->size)
+		if(semid >= context->ids.entries->size)
 			return -EINVAL;
 
 		memset(&tbuf,0,sizeof(tbuf));
 
-		sma = sem_lock(semid);
+		sma = sem_lock(context, semid);
 		if(sma == NULL)
 			return -EINVAL;
 
@@ -561,13 +564,13 @@ static int semctl_nolock(int semid, int 
 		if (err)
 			goto out_unlock;
 
-		id = sem_buildid(semid, sma->sem_perm.seq);
+		id = sem_buildid(context, semid, sma->sem_perm.seq);
 
 		kernel_to_ipc64_perm(&sma->sem_perm, &tbuf.sem_perm);
 		tbuf.sem_otime  = sma->sem_otime;
 		tbuf.sem_ctime  = sma->sem_ctime;
 		tbuf.sem_nsems  = sma->sem_nsems;
-		sem_unlock(sma);
+		sem_unlock(context, sma);
 		if (copy_semid_to_user (arg.buf, &tbuf, version))
 			return -EFAULT;
 		return id;
@@ -577,11 +580,13 @@ static int semctl_nolock(int semid, int 
 	}
 	return err;
 out_unlock:
-	sem_unlock(sma);
+	sem_unlock(context, sma);
 	return err;
 }
 
-static int semctl_main(int semid, int semnum, int cmd, int version, union semun arg)
+static int semctl_main(struct ipc_sem_context *context,
+		       int semid, int semnum, int cmd,
+		       int version, union semun arg)
 {
 	struct sem_array *sma;
 	struct sem* curr;
@@ -590,14 +595,14 @@ static int semctl_main(int semid, int se
 	ushort* sem_io = fast_sem_io;
 	int nsems;
 
-	sma = sem_lock(semid);
+	sma = sem_lock(context, semid);
 	if(sma==NULL)
 		return -EINVAL;
 
 	nsems = sma->sem_nsems;
 
 	err=-EIDRM;
-	if (sem_checkid(sma,semid))
+	if (sem_checkid(context, sma,semid))
 		goto out_unlock;
 
 	err = -EACCES;
@@ -617,20 +622,20 @@ static int semctl_main(int semid, int se
 
 		if(nsems > SEMMSL_FAST) {
 			ipc_rcu_getref(sma);
-			sem_unlock(sma);			
+			sem_unlock(context, sma);
 
 			sem_io = ipc_alloc(sizeof(ushort)*nsems);
 			if(sem_io == NULL) {
 				ipc_lock_by_ptr(&sma->sem_perm);
 				ipc_rcu_putref(sma);
-				sem_unlock(sma);
+				sem_unlock(context, sma);
 				return -ENOMEM;
 			}
 
 			ipc_lock_by_ptr(&sma->sem_perm);
 			ipc_rcu_putref(sma);
 			if (sma->sem_perm.deleted) {
-				sem_unlock(sma);
+				sem_unlock(context, sma);
 				err = -EIDRM;
 				goto out_free;
 			}
@@ -638,7 +643,7 @@ static int semctl_main(int semid, int se
 
 		for (i = 0; i < sma->sem_nsems; i++)
 			sem_io[i] = sma->sem_base[i].semval;
-		sem_unlock(sma);
+		sem_unlock(context, sma);
 		err = 0;
 		if(copy_to_user(array, sem_io, nsems*sizeof(ushort)))
 			err = -EFAULT;
@@ -650,14 +655,14 @@ static int semctl_main(int semid, int se
 		struct sem_undo *un;
 
 		ipc_rcu_getref(sma);
-		sem_unlock(sma);
+		sem_unlock(context, sma);
 
 		if(nsems > SEMMSL_FAST) {
 			sem_io = ipc_alloc(sizeof(ushort)*nsems);
 			if(sem_io == NULL) {
 				ipc_lock_by_ptr(&sma->sem_perm);
 				ipc_rcu_putref(sma);
-				sem_unlock(sma);
+				sem_unlock(context, sma);
 				return -ENOMEM;
 			}
 		}
@@ -665,7 +670,7 @@ static int semctl_main(int semid, int se
 		if (copy_from_user (sem_io, arg.array, nsems*sizeof(ushort))) {
 			ipc_lock_by_ptr(&sma->sem_perm);
 			ipc_rcu_putref(sma);
-			sem_unlock(sma);
+			sem_unlock(context, sma);
 			err = -EFAULT;
 			goto out_free;
 		}
@@ -674,7 +679,7 @@ static int semctl_main(int semid, int se
 			if (sem_io[i] > SEMVMX) {
 				ipc_lock_by_ptr(&sma->sem_perm);
 				ipc_rcu_putref(sma);
-				sem_unlock(sma);
+				sem_unlock(context, sma);
 				err = -ERANGE;
 				goto out_free;
 			}
@@ -682,7 +687,7 @@ static int semctl_main(int semid, int se
 		ipc_lock_by_ptr(&sma->sem_perm);
 		ipc_rcu_putref(sma);
 		if (sma->sem_perm.deleted) {
-			sem_unlock(sma);
+			sem_unlock(context, sma);
 			err = -EIDRM;
 			goto out_free;
 		}
@@ -706,7 +711,7 @@ static int semctl_main(int semid, int se
 		tbuf.sem_otime  = sma->sem_otime;
 		tbuf.sem_ctime  = sma->sem_ctime;
 		tbuf.sem_nsems  = sma->sem_nsems;
-		sem_unlock(sma);
+		sem_unlock(context, sma);
 		if (copy_semid_to_user (arg.buf, &tbuf, version))
 			return -EFAULT;
 		return 0;
@@ -752,7 +757,7 @@ static int semctl_main(int semid, int se
 	}
 	}
 out_unlock:
-	sem_unlock(sma);
+	sem_unlock(context, sma);
 out_free:
 	if(sem_io != fast_sem_io)
 		ipc_free(sem_io, sizeof(ushort)*nsems);
@@ -799,7 +804,9 @@ static inline unsigned long copy_semid_f
 	}
 }
 
-static int semctl_down(int semid, int semnum, int cmd, int version, union semun arg)
+static int semctl_down(struct ipc_sem_context *context,
+		       int semid, int semnum, int cmd,
+		       int version, union semun arg)
 {
 	struct sem_array *sma;
 	int err;
@@ -812,11 +819,11 @@ static int semctl_down(int semid, int se
 		if ((err = audit_ipc_perms(0, setbuf.uid, setbuf.gid, setbuf.mode)))
 			return err;
 	}
-	sma = sem_lock(semid);
+	sma = sem_lock(context, semid);
 	if(sma==NULL)
 		return -EINVAL;
 
-	if (sem_checkid(sma,semid)) {
+	if (sem_checkid(context, sma,semid)) {
 		err=-EIDRM;
 		goto out_unlock;
 	}	
@@ -834,7 +841,7 @@ static int semctl_down(int semid, int se
 
 	switch(cmd){
 	case IPC_RMID:
-		freeary(sma, semid);
+		freeary(context, sma, semid);
 		err = 0;
 		break;
 	case IPC_SET:
@@ -843,18 +850,18 @@ static int semctl_down(int semid, int se
 		ipcp->mode = (ipcp->mode & ~S_IRWXUGO)
 				| (setbuf.mode & S_IRWXUGO);
 		sma->sem_ctime = get_seconds();
-		sem_unlock(sma);
+		sem_unlock(context, sma);
 		err = 0;
 		break;
 	default:
-		sem_unlock(sma);
+		sem_unlock(context, sma);
 		err = -EINVAL;
 		break;
 	}
 	return err;
 
 out_unlock:
-	sem_unlock(sma);
+	sem_unlock(context, sma);
 	return err;
 }
 
@@ -862,6 +869,7 @@ asmlinkage long sys_semctl (int semid, i
 {
 	int err = -EINVAL;
 	int version;
+	struct ipc_sem_context *context = &current->ipc_context->sem;
 
 	if (semid < 0)
 		return -EINVAL;
@@ -872,7 +880,7 @@ asmlinkage long sys_semctl (int semid, i
 	case IPC_INFO:
 	case SEM_INFO:
 	case SEM_STAT:
-		err = semctl_nolock(semid,semnum,cmd,version,arg);
+		err = semctl_nolock(context, semid,semnum,cmd,version,arg);
 		return err;
 	case GETALL:
 	case GETVAL:
@@ -882,13 +890,13 @@ asmlinkage long sys_semctl (int semid, i
 	case IPC_STAT:
 	case SETVAL:
 	case SETALL:
-		err = semctl_main(semid,semnum,cmd,version,arg);
+		err = semctl_main(context, semid,semnum,cmd,version,arg);
 		return err;
 	case IPC_RMID:
 	case IPC_SET:
-		down(&sem_ids.sem);
-		err = semctl_down(semid,semnum,cmd,version,arg);
-		up(&sem_ids.sem);
+		down(&context->ids.sem);
+		err = semctl_down(context, semid,semnum,cmd,version,arg);
+		up(&context->ids.sem);
 		return err;
 	default:
 		return -EINVAL;
@@ -976,7 +984,7 @@ static struct sem_undo *lookup_undo(stru
 	return un;
 }
 
-static struct sem_undo *find_undo(int semid)
+static struct sem_undo *find_undo(struct ipc_sem_context *context, int semid)
 {
 	struct sem_array *sma;
 	struct sem_undo_list *ulp;
@@ -995,24 +1003,24 @@ static struct sem_undo *find_undo(int se
 		goto out;
 
 	/* no undo structure around - allocate one. */
-	sma = sem_lock(semid);
+	sma = sem_lock(context, semid);
 	un = ERR_PTR(-EINVAL);
 	if(sma==NULL)
 		goto out;
 	un = ERR_PTR(-EIDRM);
-	if (sem_checkid(sma,semid)) {
-		sem_unlock(sma);
+	if (sem_checkid(context, sma,semid)) {
+		sem_unlock(context, sma);
 		goto out;
 	}
 	nsems = sma->sem_nsems;
 	ipc_rcu_getref(sma);
-	sem_unlock(sma);
+	sem_unlock(context, sma);
 
 	new = (struct sem_undo *) kmalloc(sizeof(struct sem_undo) + sizeof(short)*nsems, GFP_KERNEL);
 	if (!new) {
 		ipc_lock_by_ptr(&sma->sem_perm);
 		ipc_rcu_putref(sma);
-		sem_unlock(sma);
+		sem_unlock(context, sma);
 		return ERR_PTR(-ENOMEM);
 	}
 	memset(new, 0, sizeof(struct sem_undo) + sizeof(short)*nsems);
@@ -1026,13 +1034,13 @@ static struct sem_undo *find_undo(int se
 		kfree(new);
 		ipc_lock_by_ptr(&sma->sem_perm);
 		ipc_rcu_putref(sma);
-		sem_unlock(sma);
+		sem_unlock(context, sma);
 		goto out;
 	}
 	ipc_lock_by_ptr(&sma->sem_perm);
 	ipc_rcu_putref(sma);
 	if (sma->sem_perm.deleted) {
-		sem_unlock(sma);
+		sem_unlock(context, sma);
 		unlock_semundo();
 		kfree(new);
 		un = ERR_PTR(-EIDRM);
@@ -1042,7 +1050,7 @@ static struct sem_undo *find_undo(int se
 	ulp->proc_list = new;
 	new->id_next = sma->undo;
 	sma->undo = new;
-	sem_unlock(sma);
+	sem_unlock(context, sma);
 	un = new;
 	unlock_semundo();
 out:
@@ -1052,6 +1060,7 @@ out:
 asmlinkage long sys_semtimedop(int semid, struct sembuf __user *tsops,
 			unsigned nsops, const struct timespec __user *timeout)
 {
+	struct ipc_sem_context *context = &current->ipc_context->sem;
 	int error = -EINVAL;
 	struct sem_array *sma;
 	struct sembuf fast_sops[SEMOPM_FAST];
@@ -1099,7 +1108,7 @@ asmlinkage long sys_semtimedop(int semid
 
 retry_undos:
 	if (undos) {
-		un = find_undo(semid);
+		un = find_undo(context, semid);
 		if (IS_ERR(un)) {
 			error = PTR_ERR(un);
 			goto out_free;
@@ -1107,12 +1116,12 @@ retry_undos:
 	} else
 		un = NULL;
 
-	sma = sem_lock(semid);
+	sma = sem_lock(context, semid);
 	error=-EINVAL;
 	if(sma==NULL)
 		goto out_free;
 	error = -EIDRM;
-	if (sem_checkid(sma,semid))
+	if (sem_checkid(context, sma,semid))
 		goto out_unlock_free;
 	/*
 	 * semid identifies are not unique - find_undo may have
@@ -1120,7 +1129,7 @@ retry_undos:
 	 * and now a new array with received the same id. Check and retry.
 	 */
 	if (un && un->semid == -1) {
-		sem_unlock(sma);
+		sem_unlock(context, sma);
 		goto retry_undos;
 	}
 	error = -EFBIG;
@@ -1161,7 +1170,7 @@ retry_undos:
 	queue.status = -EINTR;
 	queue.sleeper = current;
 	current->state = TASK_INTERRUPTIBLE;
-	sem_unlock(sma);
+	sem_unlock(context, sma);
 
 	if (timeout)
 		jiffies_left = schedule_timeout(jiffies_left);
@@ -1180,7 +1189,7 @@ retry_undos:
 		goto out_free;
 	}
 
-	sma = sem_lock(semid);
+	sma = sem_lock(context, semid);
 	if(sma==NULL) {
 		if(queue.prev != NULL)
 			BUG();
@@ -1205,7 +1214,7 @@ retry_undos:
 	goto out_unlock_free;
 
 out_unlock_free:
-	sem_unlock(sma);
+	sem_unlock(context, sma);
 out_free:
 	if(sops != fast_sops)
 		kfree(sops);
@@ -1258,6 +1267,7 @@ void exit_sem(struct task_struct *tsk)
 {
 	struct sem_undo_list *undo_list;
 	struct sem_undo *u, **up;
+	struct ipc_sem_context *context = &tsk->ipc_context->sem;
 
 	undo_list = tsk->sysvsem.undo_list;
 	if (!undo_list)
@@ -1279,14 +1289,14 @@ void exit_sem(struct task_struct *tsk)
 
 		if(semid == -1)
 			continue;
-		sma = sem_lock(semid);
+		sma = sem_lock(context, semid);
 		if (sma == NULL)
 			continue;
 
 		if (u->semid == -1)
 			goto next_entry;
 
-		BUG_ON(sem_checkid(sma,u->semid));
+		BUG_ON(sem_checkid(context, sma,u->semid));
 
 		/* remove u from the sma->undo list */
 		for (unp = &sma->undo; (un = *unp); unp = &un->id_next) {
@@ -1327,7 +1337,7 @@ found:
 		/* maybe some queued-up processes were waiting for this */
 		update_queue(sma);
 next_entry:
-		sem_unlock(sma);
+		sem_unlock(context, sma);
 	}
 	kfree(undo_list);
 }
diff -puN ipc/util.c~sysvsem-container ipc/util.c
--- work/ipc/util.c~sysvsem-container	2006-03-06 15:41:58.000000000 -0800
+++ work-dave/ipc/util.c	2006-03-06 15:41:58.000000000 -0800
@@ -52,7 +52,7 @@ static int __init ipc_init(void)
 	if (!init_task.ipc_context)
 		return -ENOMEM;
 
-	sem_init();
+	sem_init(&init_task.ipc_context->sem);
 	msg_init(&init_task.ipc_context->msg);
 	shm_init();
 	return 0;
diff -puN ipc/util.h~sysvsem-container ipc/util.h
--- work/ipc/util.h~sysvsem-container	2006-03-06 15:41:58.000000000 -0800
+++ work-dave/ipc/util.h	2006-03-06 15:41:58.000000000 -0800
@@ -11,10 +11,6 @@
 #define USHRT_MAX 0xffff
 #define SEQ_MULTIPLIER	(IPCMNI)
 
-void sem_init (void);
-void msg_init (struct ipc_msg_context *context);
-void shm_init (void);
-
 struct ipc_id_ary {
 	int size;
 	struct kern_ipc_perm *p[0];
@@ -42,10 +38,21 @@ struct ipc_msg_context {
 	struct kref count;
 };
 
+struct ipc_sem_context {
+	struct ipc_ids ids;
+
+	int nr_used;
+};
+
 struct ipc_context {
 	struct ipc_msg_context msg;
+	struct ipc_sem_context sem;
 };
 
+void sem_init (struct ipc_sem_context *context);
+void msg_init (struct ipc_msg_context *context);
+void shm_init (void);
+
 struct seq_file;
 void __init ipc_init_ids(struct ipc_ids* ids, int size);
 #ifdef CONFIG_PROC_FS
_
