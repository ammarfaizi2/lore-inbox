Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTFOKdY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 06:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTFOKdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 06:33:23 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:54657 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262116AbTFOKdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 06:33:09 -0400
Message-ID: <3EEC4E9D.5080208@colorfullife.com>
Date: Sun, 15 Jun 2003 12:46:53 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC,PATCH] sysv sem undo implementation
Content-Type: multipart/mixed;
 boundary="------------010305020408010107020106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010305020408010107020106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I found a few odd lines in the sysv sem undo implementation and wrote a 
patch to fix them:

- lock_undo() locks the list of undo structures. The lock is held 
throughout the semop() syscall, but that's unnecessary - we can drop it 
immediately after the lookup.
- undo structures are only allocated when necessary. The need for undo 
structures is only noticed in the middle of the semop operation, while 
holding the semaphore array spinlock. The result is a convoluted 
unlock&revalidate implementation. I've reordered the code, and now the 
undo allocation can happen before acquiring the semaphore array 
spinlock. As a bonus, less code runs under the semaphore array spinlock.
- sem_exit seems to be broken with CLONE_SYSVSEM: the reference count is 
never decremented if it's > 1.
- sysvsem.sleep_list looks like code to handle oopses: if an oops kills 
a thread that sleeps in sys_timedsemop(), then sem_exit tries to 
recover. I've removed that - too fragile.

Attached is my patch, not yet fully tested. What do you think?

--
    Manfred

--------------010305020408010107020106
Content-Type: text/plain;
 name="patch-sem-undo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-sem-undo"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 71
//  EXTRAVERSION =
--- 2.5/include/linux/sem.h	2003-06-15 09:39:55.000000000 +0200
+++ build-2.5/include/linux/sem.h	2003-06-15 11:32:53.000000000 +0200
@@ -128,13 +128,11 @@ struct sem_undo {
 struct sem_undo_list {
 	atomic_t	refcnt;
 	spinlock_t	lock;
-	volatile unsigned long	add_count;
 	struct sem_undo	*proc_list;
 };
 
 struct sysv_sem {
 	struct sem_undo_list *undo_list;
-	struct sem_queue *sleep_list;
 };
 
 asmlinkage long sys_semget (key_t key, int nsems, int semflg);
@@ -143,6 +141,8 @@ asmlinkage long sys_semctl (int semid, i
 asmlinkage long sys_semtimedop(int semid, struct sembuf __user *sops,
 			unsigned nsops, const struct timespec __user *timeout);
 
+void exit_sem(struct task_struct *p);
+
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_SEM_H */
--- 2.5/ipc/sem.c	2003-06-15 09:40:18.000000000 +0200
+++ build-2.5/ipc/sem.c	2003-06-15 11:34:45.000000000 +0200
@@ -214,7 +214,7 @@ static int sem_revalidate(int semid, str
 		return -EIDRM;
 	}
 
-	if (ipcperms(&sma->sem_perm, flg)) {
+	if (flg && ipcperms(&sma->sem_perm, flg)) {
 		sem_unlock(smanew);
 		return -EACCES;
 	}
@@ -887,106 +887,87 @@ static inline int get_undo_list(struct s
 	return 0;
 }
 
-static struct sem_undo* freeundos(struct sem_undo* un)
+static struct sem_undo *lookup_undo(struct sem_undo_list *ulp, int semid)
 {
-	struct sem_undo* u;
-	struct sem_undo** up;
+	struct sem_undo **last, *un;
 
-	for(up = &current->sysvsem.undo_list->proc_list;(u=*up);up=&u->proc_next) {
-		if(un==u) {
-			un=u->proc_next;
-			*up=un;
-			kfree(u);
-			return un;
-		}
-	}
-	printk ("freeundos undo list error id=%d\n", un->semid);
-	return un->proc_next;
-}
-
-static inline struct sem_undo *find_undo(int semid)
-{
-	struct sem_undo *un;
-
-	un = NULL;
-	if (current->sysvsem.undo_list != NULL) {
-		un = current->sysvsem.undo_list->proc_list;
-	}
+	last = &ulp->proc_list;
+	un = *last;
 	while(un != NULL) {
 		if(un->semid==semid)
 			break;
-		if(un->semid==-1)
-			un=freeundos(un);
-		 else
-			un=un->proc_next;
+		if(un->semid==-1) {
+			*last=un->proc_next;
+			kfree(un);
+		} else {
+			last=&un->proc_next;
+		}
+		un=*last;
 	}
 	return un;
 }
 
-/* returns without sem_lock and semundo list locks on error! */
-static int alloc_undo(struct sem_array *sma, struct sem_undo** unp, int semid, int alter)
+static struct sem_undo *find_undo(int semid)
 {
-	int size, nsems, error;
-	struct sem_undo *un, *new_un;
-	struct sem_undo_list *undo_list;
-	unsigned long	saved_add_count;
+	struct sem_array *sma;
+	struct sem_undo_list *ulp;
+	struct sem_undo *un, *new;
+	int nsems;
+	int error;
 
+	error = get_undo_list(&ulp);
+	if (error)
+		return ERR_PTR(error);
 
-	nsems = sma->sem_nsems;
-	saved_add_count = 0;
-	if (current->sysvsem.undo_list != NULL)
-		saved_add_count = current->sysvsem.undo_list->add_count;
-	sem_unlock(sma);
+	lock_semundo();
+	un = lookup_undo(ulp, semid);
 	unlock_semundo();
+	if (likely(un!=NULL))
+		goto out;
 
-	error = get_undo_list(&undo_list);
-	if (error)
-		return error;
+	/* no undo structure around - allocate one. */
+	sma = sem_lock(semid);
+	un = ERR_PTR(-EINVAL);
+	if(sma==NULL)
+		goto out;
+	un = ERR_PTR(-EIDRM);
+	if (sem_checkid(sma,semid))
+		goto out_unlock;
+	nsems = sma->sem_nsems;
+	sem_unlock(sma);
 
-	size = sizeof(struct sem_undo) + sizeof(short)*nsems;
-	un = (struct sem_undo *) kmalloc(size, GFP_KERNEL);
-	if (!un)
-		return -ENOMEM;
+	new = (struct sem_undo *) kmalloc(sizeof(struct sem_undo) + sizeof(short)*nsems, GFP_KERNEL);
+	if (!new)
+		return ERR_PTR(-ENOMEM);
+	memset(new, 0, sizeof(struct sem_undo) + sizeof(short)*nsems);
+	new->semadj = (short *) &new[1];
+	new->semid = semid;
 
-	memset(un, 0, size);
 	lock_semundo();
-	error = sem_revalidate(semid, sma, nsems, alter ? S_IWUGO : S_IRUGO);
-	if(error) {
+	un = lookup_undo(ulp, semid);
+	if (un) {
 		unlock_semundo();
-		kfree(un);
-		return error;
+		kfree(new);
+		goto out;
 	}
-
-
-	/* alloc_undo has just
-	 * released all locks and reacquired them. 
-	 * But, another thread may have
-	 * added the semundo we were looking for
-	 * during that time.
-	 * So, we check for it again.
-	 * only initialize and add the new one
-	 * if we don't discover one.
-	 */
-	new_un = NULL;
-	if (current->sysvsem.undo_list->add_count != saved_add_count)
-		new_un = find_undo(semid);
-
-	if (new_un != NULL) {
-		if (sma->undo != new_un)
-			BUG();
-		kfree(un);
-		un = new_un;
-	} else {
-		current->sysvsem.undo_list->add_count++;
-		un->semadj = (short *) &un[1];
-		un->semid = semid;
-		un->proc_next = undo_list->proc_list;
-		undo_list->proc_list = un;
-		un->id_next = sma->undo;
-		sma->undo = un;
-	}
-	*unp = un;
-	return 0;
+	error = sem_revalidate(semid, sma, nsems, 0);
+	if (error) {
+		sem_unlock(sma);
+		unlock_semundo();
+		kfree(new);
+		un = ERR_PTR(error);
+		goto out;
+	}
+	new->proc_next = ulp->proc_list;
+	ulp->proc_list = new;
+	new->id_next = sma->undo;
+	sma->undo = new;
+	sem_unlock(sma);
+	un = new;
+out_unlock:
+	unlock_semundo();
+out:
+	return un;
 }
 
 asmlinkage long sys_semop (int semid, struct sembuf *tsops, unsigned nsops)
@@ -1002,7 +983,7 @@ asmlinkage long sys_semtimedop(int semid
 	struct sembuf fast_sops[SEMOPM_FAST];
 	struct sembuf* sops = fast_sops, *sop;
 	struct sem_undo *un;
-	int undos = 0, decrease = 0, alter = 0;
+	int undos = 0, decrease = 0, alter = 0, max;
 	struct sem_queue queue;
 	unsigned long jiffies_left = 0;
 
@@ -1032,18 +1013,10 @@ asmlinkage long sys_semtimedop(int semid
 		}
 		jiffies_left = timespec_to_jiffies(&_timeout);
 	}
-	lock_semundo();
-	sma = sem_lock(semid);
-	error=-EINVAL;
-	if(sma==NULL)
-		goto out_semundo_free;
-	error = -EIDRM;
-	if (sem_checkid(sma,semid))
-		goto out_unlock_semundo_free;
-	error = -EFBIG;
+	max = 0;
 	for (sop = sops; sop < sops + nsops; sop++) {
-		if (sop->sem_num >= sma->sem_nsems)
-			goto out_unlock_semundo_free;
+		if (sop->sem_num >= max)
+			max = sop->sem_num;
 		if (sop->sem_flg & SEM_UNDO)
 			undos++;
 		if (sop->sem_op < 0)
@@ -1053,30 +1026,42 @@ asmlinkage long sys_semtimedop(int semid
 	}
 	alter |= decrease;
 
-	error = -EACCES;
-	if (ipcperms(&sma->sem_perm, alter ? S_IWUGO : S_IRUGO))
-		goto out_unlock_semundo_free;
-
-	error = security_sem_semop(sma, sops, nsops, alter);
-	if (error)
-		goto out_unlock_semundo_free;
-
-	error = -EACCES;		
+retry_undos:
 	if (undos) {
-		/* Make sure we have an undo structure
-		 * for this process and this semaphore set.
-		 */
-		
 		un = find_undo(semid);
-		if (!un) {
-			error = alloc_undo(sma,&un,semid,alter);
-			if (error)
-				goto out_free;
-
+		if (IS_ERR(un)) {
+			error = PTR_ERR(un);
+			goto out_free;
 		}
 	} else
 		un = NULL;
 
+	sma = sem_lock(semid);
+	error=-EINVAL;
+	if(sma==NULL)
+		goto out_free;
+	error = -EIDRM;
+	if (sem_checkid(sma,semid))
+		goto out_unlock_free;
+	/*
+	 * semid identifies are not unique - find_undo may have
+	 * allocated an undo structure, it was invalidated by an RMID
+	 * and now a new array with received the same id. Check and retry.
+	 */
+	if (un && un->semid == -1)
+		goto retry_undos;
+	error = -EFBIG;
+	if (max >= sma->sem_nsems)
+		goto out_unlock_free;
+
+	error = -EACCES;
+	if (ipcperms(&sma->sem_perm, alter ? S_IWUGO : S_IRUGO))
+		goto out_unlock_free;
+
+	error = security_sem_semop(sma, sops, nsops, alter);
+	if (error)
+		goto out_unlock_free;
+
 	error = try_atomic_semop (sma, sops, nsops, un, current->pid, 0);
 	if (error <= 0)
 		goto update;
@@ -1096,28 +1081,24 @@ asmlinkage long sys_semtimedop(int semid
 		append_to_queue(sma ,&queue);
 	else
 		prepend_to_queue(sma ,&queue);
-	current->sysvsem.sleep_list = &queue;
 
 	for (;;) {
 		queue.status = -EINTR;
 		queue.sleeper = current;
 		current->state = TASK_INTERRUPTIBLE;
 		sem_unlock(sma);
-		unlock_semundo();
 
 		if (timeout)
 			jiffies_left = schedule_timeout(jiffies_left);
 		else
 			schedule();
 
-		lock_semundo();
 		sma = sem_lock(semid);
 		if(sma==NULL) {
 			if(queue.prev != NULL)
 				BUG();
-			current->sysvsem.sleep_list = NULL;
 			error = -EIDRM;
-			goto out_semundo_free;
+			goto out_free;
 		}
 		/*
 		 * If queue.status == 1 we where woken up and
@@ -1139,19 +1120,15 @@ asmlinkage long sys_semtimedop(int semid
 			if (queue.prev) /* got Interrupt */
 				break;
 			/* Everything done by update_queue */
-			current->sysvsem.sleep_list = NULL;
-			goto out_unlock_semundo_free;
+			goto out_unlock_free;
 		}
 	}
-	current->sysvsem.sleep_list = NULL;
 	remove_from_queue(sma,&queue);
 update:
 	if (alter)
 		update_queue (sma);
-out_unlock_semundo_free:
+out_unlock_free:
 	sem_unlock(sma);
-out_semundo_free:
-	unlock_semundo();
 out_free:
 	if(sops != fast_sops)
 		kfree(sops);
@@ -1185,21 +1162,6 @@ int copy_semundo(unsigned long clone_fla
 	return 0;
 }
 
-static inline void __exit_semundo(struct task_struct *tsk)
-{
-	struct sem_undo_list *undo_list;
-
-	undo_list = tsk->sysvsem.undo_list;
-	if (!atomic_dec_and_test(&undo_list->refcnt))
-		kfree(undo_list);
-}
-
-void exit_semundo(struct task_struct *tsk)
-{
-	if (tsk->sysvsem.undo_list != NULL)
-		__exit_semundo(tsk);
-}
-
 /*
  * add semadj values to semaphores, free undo structures.
  * undo structures are not freed when semaphore arrays are destroyed
@@ -1212,44 +1174,29 @@ void exit_semundo(struct task_struct *ts
  * The current implementation does not do so. The POSIX standard
  * and SVID should be consulted to determine what behavior is mandated.
  */
-void sem_exit (void)
+void exit_sem(struct task_struct *tsk)
 {
-	struct sem_queue *q;
-	struct sem_undo *u, *un = NULL, **up, **unp;
-	struct sem_array *sma;
 	struct sem_undo_list *undo_list;
-	int nsems, i;
+	struct sem_undo *u, **up;
 
-	lock_kernel();
-
-	/* If the current process was sleeping for a semaphore,
-	 * remove it from the queue.
-	 */
-	if ((q = current->sysvsem.sleep_list)) {
-		int semid = q->id;
-		sma = sem_lock(semid);
-		current->sysvsem.sleep_list = NULL;
-
-		if (q->prev) {
-			if(sma==NULL)
-				BUG();
-			remove_from_queue(q->sma,q);
-		}
-		if(sma!=NULL)
-			sem_unlock(sma);
-	}
+	undo_list = tsk->sysvsem.undo_list;
+	if (!undo_list)
+		return;
 
-	undo_list = current->sysvsem.undo_list;
-	if ((undo_list == NULL) || (atomic_read(&undo_list->refcnt) != 1)) {
-		unlock_kernel();
+	if (!atomic_dec_and_test(&undo_list->refcnt))
 		return;
-	}
 
 	/* There's no need to hold the semundo list lock, as current
          * is the last task exiting for this undo list.
 	 */
 	for (up = &undo_list->proc_list; (u = *up); *up = u->proc_next, kfree(u)) {
-		int semid = u->semid;
+		struct sem_array *sma;
+		int nsems, i;
+		struct sem_undo *un, **unp;
+		int semid;
+	       
+		semid = u->semid;
+
 		if(semid == -1)
 			continue;
 		sma = sem_lock(semid);
@@ -1259,8 +1206,7 @@ void sem_exit (void)
 		if (u->semid == -1)
 			goto next_entry;
 
-		if (sem_checkid(sma,u->semid))
-			goto next_entry;
+		BUG_ON(sem_checkid(sma,u->semid));
 
 		/* remove u from the sma->undo list */
 		for (unp = &sma->undo; (un = *unp); unp = &un->id_next) {
@@ -1275,10 +1221,12 @@ found:
 		nsems = sma->sem_nsems;
 		for (i = 0; i < nsems; i++) {
 			struct sem * sem = &sma->sem_base[i];
-			sem->semval += u->semadj[i];
-			if (sem->semval < 0)
-				sem->semval = 0; /* shouldn't happen */
-			sem->sempid = current->pid;
+			if (u->semadj[i]) {
+				sem->semval += u->semadj[i];
+				if (sem->semval < 0)
+					sem->semval = 0; /* shouldn't happen */
+				sem->sempid = current->pid;
+			}
 		}
 		sma->sem_otime = get_seconds();
 		/* maybe some queued-up processes were waiting for this */
@@ -1286,9 +1234,7 @@ found:
 next_entry:
 		sem_unlock(sma);
 	}
-	__exit_semundo(current);
-
-	unlock_kernel();
+	kfree(undo_list);
 }
 
 #ifdef CONFIG_PROC_FS
--- 2.5/ipc/util.c	2003-03-17 22:44:04.000000000 +0100
+++ build-2.5/ipc/util.c	2003-06-15 11:32:53.000000000 +0200
@@ -541,17 +541,11 @@ int copy_semundo(unsigned long clone_fla
 	return 0;
 }
 
-void exit_semundo(struct task_struct *tsk)
+void exit_sem(struct task_struct *tsk)
 {
 	return;
 }
 
-
-void sem_exit (void)
-{
-    return;
-}
-
 asmlinkage long sys_semget (key_t key, int nsems, int semflg)
 {
 	return -ENOSYS;
--- 2.5/kernel/fork.c	2003-06-15 09:40:18.000000000 +0200
+++ build-2.5/kernel/fork.c	2003-06-15 11:32:53.000000000 +0200
@@ -39,7 +39,7 @@
 #include <asm/tlbflush.h>
 
 extern int copy_semundo(unsigned long clone_flags, struct task_struct *tsk);
-extern void exit_semundo(struct task_struct *tsk);
+extern void exit_sem(struct task_struct *tsk);
 
 /* The idle threads do not count..
  * Protected by write_lock_irq(&tasklist_lock)
@@ -846,6 +846,7 @@ struct task_struct *copy_process(unsigne
 	p->vfork_done = NULL;
 	spin_lock_init(&p->alloc_lock);
 	spin_lock_init(&p->switch_lock);
+	spin_lock_init(&p->proc_lock);
 
 	clear_tsk_thread_flag(p, TIF_SIGPENDING);
 	init_sigpending(&p->pending);
@@ -1033,7 +1034,7 @@ bad_fork_cleanup_fs:
 bad_fork_cleanup_files:
 	exit_files(p); /* blocking */
 bad_fork_cleanup_semundo:
-	exit_semundo(p);
+	exit_sem(p);
 bad_fork_cleanup_security:
 	security_task_free(p);
 bad_fork_cleanup:
--- 2.5/kernel/exit.c	2003-06-15 09:39:55.000000000 +0200
+++ build-2.5/kernel/exit.c	2003-06-15 11:32:53.000000000 +0200
@@ -698,7 +698,7 @@ NORET_TYPE void do_exit(long code)
 	acct_process(code);
 	__exit_mm(tsk);
 
-	sem_exit();
+	exit_sem(tsk);
 	__exit_files(tsk);
 	__exit_fs(tsk);
 	exit_namespace(tsk);

--------------010305020408010107020106--

