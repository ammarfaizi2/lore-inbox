Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280737AbRKGB6a>; Tue, 6 Nov 2001 20:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280740AbRKGB6V>; Tue, 6 Nov 2001 20:58:21 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:49850 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S280737AbRKGB6K>; Tue, 6 Nov 2001 20:58:10 -0500
Date: Tue, 6 Nov 2001 17:58:04 -0800 (PST)
From: Dave Olien <oliendm@us.ibm.com>
Message-Id: <200111070158.fA71w4M15307@eng2.beaverton.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: semop patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System V semaphore SEMUNDO and pthreads are not compliant.

I've encountered a situation where the system V semaphore implementation
when used with threads, is not compliant with other UNIX systems, and not
compliant with the POSIX standard.

Following is a brief explanation of the problem, followed by the test program,
followed by the patch for linux 2.4.6 that makes the kernel compliant.

The test program is pretty simple.  The bug appears when an application creates
several threads using pthread_create().  When one thread performs a semop()
with the SEMUNDO flag set, that semop should be "undone" only when the
entire application exits, NOT when that thread exits.

Each thread currently maintains its own private list of semundo structures,
referenced by current->semundo.  The bug is that the list of sem_undo
structures for this threaded application should be shared among all the
threads in that application.

My patch adds a structure (sem_undohd) that is shared by all the threads in
the threaded application, and controls access to the shared list of sem_undo
structures. current->semundo references are replaced with current->semundohd
references.  I've tried to minimize the impact on tasks that are not using
SEMUNDO semop() operations, or that are not using pthread_create().

One issue is WHEN should a child task share its sem_undo structures list with
its parent.  Linux uses a collection of flags (CLONE_VM, CLONE_FS, etc) to the
fork() system call, to cause the child task to share various components of
the parent's state.  There is no flag indicating when the child task should
share sem_undo state.  When should a parent task and its child conform to the
POSIX threads behavior for system V semaphores? See the code in copy_semundo()
for how this decision was made.

the test program's output SHOULD look like:

Waiter, pid = 11490
Poster, pid = 11490, posting
Poster posted
Poster exiting
Waiter waiting, pid = 11490
Waiter done waiting

The Incorrect output on Linux is:

Waiter, pid = 712
Poster, pid = 713, posting
Poster posted
Poster exiting
Waiter waiting, pid = 712


---------------------tsem.c---------------------------------------------------

#include <stdio.h>
#include <unistd.h>
#include <sys/sem.h>
#include <errno.h>
#include <pthread.h>

#define KEY 0x1234

#define NUMTHREADS 2

void *retval[NUMTHREADS]; 
void * waiter(void *);
void * poster(void *);

struct sembuf Psembuf = {0, -1, SEM_UNDO};
struct sembuf Vsembuf = {0, 1, SEM_UNDO};

int sem_id;

main()
{
    int i, pid, rc;
    
    pthread_t pt[NUMTHREADS];
    pthread_attr_t attr;

    /* Create the semaphore set */
    sem_id = semget(KEY, 1, 0666 | IPC_CREAT);
    if (sem_id < 0)
    {
	printf ("semget failed, errno = %d\n", errno);
	exit (1);
    }
    
    /* setup the attributes of the thread        */
    /* set the scope to be system to make sure the process competes on a  */
    /* global scale for cpu   */
    pthread_attr_init(&attr);
    pthread_attr_setscope(&attr, PTHREAD_SCOPE_SYSTEM);

    /* Create the threads */
    for (i=0; i<NUMTHREADS; i++)
    {
	if (i == 0)
	    rc = pthread_create(&pt[i], &attr, waiter, retval[i]);
	else
	    rc = pthread_create(&pt[i], &attr, poster, retval[i]);
    }

    /* Sleep long enough to see that the other threads do what they are supposed to do */
    sleep(20);

    exit(0);
}


/* This thread sleeps 10 seconds then waits on the semaphore.  As long
   as someone has posted on the semaphore, and no undo has taken
   place, the semop should complete and we'll print "Waiter done
   waiting." */
void * waiter(void * foo)
{
    int pid;
    pid = getpid();

    printf ("Waiter, pid = %d\n", pid);
    sleep(10);

    printf("Waiter waiting, pid = %d\n", pid);
    semop(sem_id, &Psembuf, 1);
    printf("Waiter done waiting\n");
   
    pthread_exit(0);
}

/* This thread immediately posts on the semaphore and then immediately
   exits.  If the *thread* exits, the undo should not happen, and the
   waiter thread which will start waiting on it in 10 seconds, should
   still get it.   */
void * poster(void * foo)
{
    int pid;
   
    pid = getpid();
    printf ("Poster, pid = %d, posting\n", pid);
    semop(sem_id, &Vsembuf, 1);
    printf ("Poster posted\n");
    printf ("Poster exiting\n");
    
    pthread_exit(0);
}

------------------------Begin Patch for linux 2.4.6-------------------------
diff -urN --exclude-from=/usr/src/dontdiff linux-2.4.6_unchanged/linux/include/linux/sched.h linux-2.4.6_original/linux/include/linux/sched.h
--- linux-2.4.6_unchanged/linux/include/linux/sched.h	Tue Jul  3 15:42:55 2001
+++ linux-2.4.6_original/linux/include/linux/sched.h	Sun Oct 28 16:20:21 2001
@@ -372,7 +372,7 @@
 	struct tty_struct *tty; /* NULL if no tty */
 	unsigned int locks; /* How many file locks are being held */
 /* ipc stuff */
-	struct sem_undo *semundo;
+	struct sem_undohd *semundohd;
 	struct sem_queue *semsleeping;
 /* CPU-specific state of this task */
 	struct thread_struct thread;
diff -urN --exclude-from=/usr/src/dontdiff linux-2.4.6_unchanged/linux/include/linux/sem.h linux-2.4.6_original/linux/include/linux/sem.h
--- linux-2.4.6_unchanged/linux/include/linux/sem.h	Tue Jul  3 15:42:55 2001
+++ linux-2.4.6_original/linux/include/linux/sem.h	Sun Oct 28 16:20:16 2001
@@ -121,6 +121,18 @@
 	short *			semadj;		/* array of adjustments, one per semaphore */
 };
 
+/* Each PROCESS (i.e. collection of tasks that are running POSIX style threads)
+ * must share the same semundo list, in order to support POSIX SEMUNDO
+ * semantics for threads.  The sem_undohd controls shared access to this
+ * list among all the tasks (threads) in that process.
+ */ 
+struct sem_undohd {
+	atomic_t	refcnt;
+	spinlock_t	lock;
+	volatile unsigned long	add_count;
+	struct sem_undo	*proc_list;
+};
+
 asmlinkage long sys_semget (key_t key, int nsems, int semflg);
 asmlinkage long sys_semop (int semid, struct sembuf *sops, unsigned nsops);
 asmlinkage long sys_semctl (int semid, int semnum, int cmd, union semun arg);
diff -urN --exclude-from=/usr/src/dontdiff linux-2.4.6_unchanged/linux/ipc/sem.c linux-2.4.6_original/linux/ipc/sem.c
--- linux-2.4.6_unchanged/linux/ipc/sem.c	Mon Feb 19 10:18:18 2001
+++ linux-2.4.6_original/linux/ipc/sem.c	Tue Oct 30 16:37:59 2001
@@ -775,12 +775,75 @@
 	}
 }
 
-static struct sem_undo* freeundos(struct sem_array *sma, struct sem_undo* un)
+static inline void lock_semundo(void)
+{
+	struct sem_undohd *undohd;
+
+	undohd = current->semundohd;
+	if ((undohd != NULL) && (atomic_read(&undohd->refcnt) != 1))
+		spin_lock(&undohd->lock);
+}
+
+/* This code has an interesting interaction with copy_semundo():
+ * two tasks could have been sharing the semundohd at the time "first" one
+ * of those tasks acquires the lock acquired in lock_semundo.  If the other
+ * tasks exits before * "the first one" releases the lock (by calling
+ * unlock_semundo), then the spin_unlock would NOT be called.  This would
+ * leave the semundohd in a locked state.  This would NOT be a problem unless
+ * the remaining task once again creates a new task that once again shares the
+ * semundohd.  Cleanup up this last case is dealt with in copy_semundo by
+ * having it reinitialize the spin_lock when it once again creates a second
+ * task sharing the semundo.
+ */
+static inline void unlock_semundo(void)
+{
+	struct sem_undohd *undohd;
+
+	undohd = current->semundohd;
+	if ((undohd != NULL) && (atomic_read(&undohd->refcnt) != 1))
+		spin_unlock(&undohd->lock);
+}
+
+
+/* If the task doesn't already have a semundohd, then allocate one
+ * here.  We guarantee there is only one thread using this undo list,
+ * and current is THE ONE
+ *
+ * If this allocation and assignment succeeds, but later
+ * portions of this code fail, there is no need to free the sem_undohd.
+ * Just let it stay associated with the task, and it'll be freed later
+ * at exit time.
+ *
+ * This can block, so callers must hold no locks.
+ */
+static inline int get_undohd(struct sem_undohd **undohdp)
+{
+	struct sem_undohd *undohd;
+	int size;
+
+	undohd = current->semundohd;
+	if (!undohd) {
+		size = sizeof(struct sem_undohd);
+		undohd = (struct sem_undohd *) kmalloc(size, GFP_KERNEL);
+		if (undohd == NULL)
+			return -ENOMEM;
+		memset(undohd, 0, size);
+		/* don't initialize unodhd->lock here.  It's done
+		 * in copy_semundo() instead.
+		 */
+		atomic_set(&undohd->refcnt, 1);
+		current->semundohd = undohd;
+	}
+	*undohdp = undohd;
+	return 0;
+}
+
+static struct sem_undo* freeundos(struct sem_undo* un)
 {
 	struct sem_undo* u;
 	struct sem_undo** up;
 
-	for(up = &current->semundo;(u=*up);up=&u->proc_next) {
+	for(up = &current->semundohd->proc_list;(u=*up);up=&u->proc_next) {
 		if(un==u) {
 			un=u->proc_next;
 			*up=un;
@@ -792,33 +855,87 @@
 	return un->proc_next;
 }
 
-/* returns without sem_lock on error! */
+static inline struct sem_undo *find_undo(int semid)
+{
+	struct sem_undo *un;
+
+	un = NULL;
+	if (current->semundohd != NULL) {
+		un = current->semundohd->proc_list;
+	}
+	while(un != NULL) {
+		if(un->semid==semid)
+			break;
+		if(un->semid==-1)
+			un=freeundos(un);
+		 else
+			un=un->proc_next;
+	}
+	return un;
+}
+
+/* returns without sem_lock and semundo list locks on error! */
 static int alloc_undo(struct sem_array *sma, struct sem_undo** unp, int semid, int alter)
 {
 	int size, nsems, error;
-	struct sem_undo *un;
+	struct sem_undo *un, *new_un;
+	struct sem_undohd *unhd;
+	unsigned long	saved_add_count;
+
 
 	nsems = sma->sem_nsems;
-	size = sizeof(struct sem_undo) + sizeof(short)*nsems;
+	saved_add_count = 0;
+	if (current->semundohd != NULL)
+		saved_add_count = current->semundohd->add_count;
 	sem_unlock(semid);
+	unlock_semundo();
 
+	error = get_undohd(&unhd);
+	if (error)
+		return error;
+
+	size = sizeof(struct sem_undo) + sizeof(short)*nsems;
 	un = (struct sem_undo *) kmalloc(size, GFP_KERNEL);
 	if (!un)
 		return -ENOMEM;
 
 	memset(un, 0, size);
+	lock_semundo();
 	error = sem_revalidate(semid, sma, nsems, alter ? S_IWUGO : S_IRUGO);
 	if(error) {
+		unlock_semundo();
 		kfree(un);
 		return error;
 	}
 
-	un->semadj = (short *) &un[1];
-	un->semid = semid;
-	un->proc_next = current->semundo;
-	current->semundo = un;
-	un->id_next = sma->undo;
-	sma->undo = un;
+
+	/* alloc_undo has just
+	 * released all locks and reacquired them. 
+	 * But, another thread may have
+	 * added the semundo we were looking for
+	 * during that time.
+	 * So, we check for it again.
+	 * only initialize and add the new one
+	 * if we don't discover one.
+	 */
+	new_un = NULL;
+	if (current->semundohd->add_count != saved_add_count)
+		new_un = find_undo(semid);
+
+	if (new_un != NULL) {
+		if (sma->undo != new_un)
+			BUG();
+		kfree(un);
+		un = new_un;
+	} else {
+		current->semundohd->add_count++;
+		un->semadj = (short *) &un[1];
+		un->semid = semid;
+		un->proc_next = unhd->proc_list;
+		unhd->proc_list = un;
+		un->id_next = sma->undo;
+		sma->undo = un;
+	}
 	*unp = un;
 	return 0;
 }
@@ -833,6 +950,7 @@
 	int undos = 0, decrease = 0, alter = 0;
 	struct sem_queue queue;
 
+
 	if (nsops < 1 || semid < 0)
 		return -EINVAL;
 	if (nsops > sc_semopm)
@@ -846,17 +964,18 @@
 		error=-EFAULT;
 		goto out_free;
 	}
+	lock_semundo();
 	sma = sem_lock(semid);
 	error=-EINVAL;
 	if(sma==NULL)
-		goto out_free;
+		goto out_semundo_free;
 	error = -EIDRM;
 	if (sem_checkid(sma,semid))
-		goto out_unlock_free;
+		goto out_unlock_semundo_free;
 	error = -EFBIG;
 	for (sop = sops; sop < sops + nsops; sop++) {
 		if (sop->sem_num >= sma->sem_nsems)
-			goto out_unlock_free;
+			goto out_unlock_semundo_free;
 		if (sop->sem_flg & SEM_UNDO)
 			undos++;
 		if (sop->sem_op < 0)
@@ -868,24 +987,18 @@
 
 	error = -EACCES;
 	if (ipcperms(&sma->sem_perm, alter ? S_IWUGO : S_IRUGO))
-		goto out_unlock_free;
+		goto out_unlock_semundo_free;
 	if (undos) {
 		/* Make sure we have an undo structure
 		 * for this process and this semaphore set.
 		 */
-		un=current->semundo;
-		while(un != NULL) {
-			if(un->semid==semid)
-				break;
-			if(un->semid==-1)
-				un=freeundos(sma,un);
-			 else
-				un=un->proc_next;
-		}
+		
+		un = find_undo(semid);
 		if (!un) {
 			error = alloc_undo(sma,&un,semid,alter);
-			if(error)
+			if (error)
 				goto out_free;
+
 		}
 	} else
 		un = NULL;
@@ -917,16 +1030,18 @@
 		queue.sleeper = current;
 		current->state = TASK_INTERRUPTIBLE;
 		sem_unlock(semid);
+		unlock_semundo();
 
 		schedule();
 
+		lock_semundo();
 		tmp = sem_lock(semid);
 		if(tmp==NULL) {
 			if(queue.prev != NULL)
 				BUG();
 			current->semsleeping = NULL;
 			error = -EIDRM;
-			goto out_free;
+			goto out_semundo_free;
 		}
 		/*
 		 * If queue.status == 1 we where woken up and
@@ -947,7 +1062,7 @@
 				break;
 			/* Everything done by update_queue */
 			current->semsleeping = NULL;
-			goto out_unlock_free;
+			goto out_unlock_semundo_free;
 		}
 	}
 	current->semsleeping = NULL;
@@ -955,14 +1070,60 @@
 update:
 	if (alter)
 		update_queue (sma);
-out_unlock_free:
+out_unlock_semundo_free:
 	sem_unlock(semid);
+out_semundo_free:
+	unlock_semundo();
 out_free:
 	if(sops != fast_sops)
 		kfree(sops);
 	return error;
 }
 
+/* For now, assume that if ALL clone flags are set, then
+ * we must be creating a POSIX thread, and we want undo lists
+ * to be shared among all the threads in that thread group.
+ *
+ * See the notes above unlock_semundo() regarding the spin_lock_init()
+ * in this code.  Initialize the undohd->lock here instead of get_undohd()
+ * because of the reasoning in the note referenced here.
+ */
+#define CLONE_SEMUNDO (CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND)
+
+int copy_semundo(unsigned long clone_flags, struct task_struct *tsk)
+{
+	struct sem_undohd *undohd;
+	int error;
+
+	if ((clone_flags & CLONE_SEMUNDO) == CLONE_SEMUNDO) {
+		error = get_undohd(&undohd);
+		if (error)
+			return error;
+		if (atomic_read(&undohd->refcnt) == 1)
+			spin_lock_init(&undohd->lock);
+		atomic_inc(&undohd->refcnt);
+		tsk->semundohd = undohd;
+	} else 
+		tsk->semundohd = NULL;
+
+	return 0;
+}
+
+static inline void __exit_semundo(struct task_struct *tsk)
+{
+	struct sem_undohd *unhd;
+
+	unhd = tsk->semundohd;
+	if (!atomic_dec_and_test(&unhd->refcnt))
+		kfree(unhd);
+}
+
+void exit_semundo(struct task_struct *tsk)
+{
+	if (tsk->semundohd != NULL)
+		__exit_semundo(tsk);
+}
+
 /*
  * add semadj values to semaphores, free undo structures.
  * undo structures are not freed when semaphore arrays are destroyed
@@ -980,6 +1141,7 @@
 	struct sem_queue *q;
 	struct sem_undo *u, *un = NULL, **up, **unp;
 	struct sem_array *sma;
+	struct sem_undohd *undohd;
 	int nsems, i;
 
 	/* If the current process was sleeping for a semaphore,
@@ -999,7 +1161,14 @@
 			sem_unlock(semid);
 	}
 
-	for (up = &current->semundo; (u = *up); *up = u->proc_next, kfree(u)) {
+	undohd = current->semundohd;
+	if ((undohd == NULL) || (atomic_read(&undohd->refcnt) != 1))
+		return;
+
+	/* There's no need to hold the semundo list lock, as current
+         * is the last task exiting for this undo list.
+	 */
+	for (up = &undohd->proc_list; (u = *up); *up = u->proc_next, kfree(u)) {
 		int semid = u->semid;
 		if(semid == -1)
 			continue;
@@ -1037,7 +1206,7 @@
 next_entry:
 		sem_unlock(semid);
 	}
-	current->semundo = NULL;
+	__exit_semundo(current);
 }
 
 #ifdef CONFIG_PROC_FS
diff -urN --exclude-from=/usr/src/dontdiff linux-2.4.6_unchanged/linux/ipc/util.c linux-2.4.6_original/linux/ipc/util.c
--- linux-2.4.6_unchanged/linux/ipc/util.c	Mon Feb 19 10:18:18 2001
+++ linux-2.4.6_original/linux/ipc/util.c	Tue Oct 23 18:43:43 2001
@@ -340,6 +340,17 @@
  * Dummy functions when SYSV IPC isn't configured
  */
 
+int copy_semundo(unsigned long clone_flags, struct task_struct *tsk)
+{
+	return 0;
+}
+
+void exit_semundo(struct task_struct *tsk)
+{
+	return;
+}
+
+
 void sem_exit (void)
 {
     return;
diff -urN --exclude-from=/usr/src/dontdiff linux-2.4.6_unchanged/linux/kernel/fork.c linux-2.4.6_original/linux/kernel/fork.c
--- linux-2.4.6_unchanged/linux/kernel/fork.c	Mon Apr 30 22:23:29 2001
+++ linux-2.4.6_original/linux/kernel/fork.c	Tue Oct 23 18:44:03 2001
@@ -24,6 +24,9 @@
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
 
+extern int copy_semundo(unsigned long clone_flags, struct task_struct *tsk);
+extern void exit_semundo(struct task_struct *tsk);
+
 /* The idle threads do not count.. */
 int nr_threads;
 int nr_running;
@@ -642,8 +645,10 @@
 
 	retval = -ENOMEM;
 	/* copy all the process information */
-	if (copy_files(clone_flags, p))
+	if (copy_semundo(clone_flags, p))
 		goto bad_fork_cleanup;
+	if (copy_files(clone_flags, p))
+		goto bad_fork_cleanup_semundo;
 	if (copy_fs(clone_flags, p))
 		goto bad_fork_cleanup_files;
 	if (copy_sighand(clone_flags, p))
@@ -653,7 +658,6 @@
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
 		goto bad_fork_cleanup_mm;
-	p->semundo = NULL;
 	
 	/* Our parent execution domain becomes current domain
 	   These must match for thread signalling to apply */
@@ -714,6 +718,8 @@
 	exit_fs(p); /* blocking */
 bad_fork_cleanup_files:
 	exit_files(p); /* blocking */
+bad_fork_cleanup_semundo:
+	exit_semundo(p);
 bad_fork_cleanup:
 	put_exec_domain(p->exec_domain);
 	if (p->binfmt && p->binfmt->module)

