Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272510AbSIST0H>; Thu, 19 Sep 2002 15:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272521AbSIST0H>; Thu, 19 Sep 2002 15:26:07 -0400
Received: from mx1.elte.hu ([157.181.1.137]:961 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S272510AbSISTZu>;
	Thu, 19 Sep 2002 15:25:50 -0400
Date: Thu, 19 Sep 2002 21:38:03 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: [patch] generic-pidhash-2.5.36-J2, BK-curr
In-Reply-To: <Pine.LNX.4.44.0209190938340.1594-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209192055480.14365-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've attached the latest version of the generic pidhash patch. The biggest
change is the removal of separately allocated pid structures: they are now
part of the task structure and the first task that uses a PID will provide
the pid structure. Task refcounting is used to avoid the freeing of the
task structure before every member of a process group or session has
exited.

this approach has a number of advantages besides the performance gains.  
Besides simplifying the whole hashing code significantly, attach_pid() is
now fundamentally atomic and can be called during create_process() without
worrying about task-list side-effects. It does not have to re-search the
pidhash to find out about raced PID-adding either, and attach_pid()  
cannot fail due to OOM. detach_pid() can do a simple put_task_struct()
instead of the kmem_cache_free().

the only minimal downside is the potential pending task structures after
session leaders or group leaders have exited - but the number of orphan
sessions and process groups is usually very low - and even if it's higher,
this can be regarded as a slow execution of the final deallocation of the
session leader, not some additional burden.

[Benchmark results comparing stock kernel against patched kernel come
after the Changelog.]

Changes since -D4:

 - remove the tty_io.c changes.

 - remove stale change from include/asm-i386/types.h

 - add list_for_each_noprefetch() to list.h, for all those list users who 
   know that in the majority of cases the list is going to be short.

 - reorganize struct pid: remove the type field, add the task pointer.

 - reorganize pid_link: remove the 'nr' field, add the struct pid field.

 - thread-exit optimization: remove the tsk->real_timer only if it was 
   pending.

 - thread-create optimization: reuse the task_cache if existent. Use 
   atomic ops to manipulate it, so that thread-create can access it from
   outside of the tasklist lock.

 - remove the pid_cache SLAB cache.

 - simplify and speed up attach_pid(): no need to drop the lock, look up
   the pid only once, and no failure path.

 - speed up detach_pid(): put_task_struct() instead of kmem_cache_free().

 - merge pidhash_init() into pid_init(). Call it from main.c only.

 - allocate not only the PID 0 bitmap slot, but also hash it into all
   three hashes to make sure no-one tries to reuse it.

 - cleanups, code simplifications.

Performance:

single-thread create+exit latency (full latency, including the
release_task() overhead) on a UP 525 MHz PIII box:

	stock BK-curr
        -------------
        -> 3864 cycles [7.025455 usecs]

	BK-curr + generic-pidhash-J2
        ----------------------------
        -> 3430 cycles [6.236364 usecs]

ie. the patched kernel is 12% faster than the stock kernel. Most of the
improvement is due to the fork.c and exit.c optimizations.

Note that this is the best-possible benchmark scenario for the old PID
allocator: the new PID allocator's best-case latency is burdened by the
fact that it avoids worst-case latencies, and its average latency is
independent of layout of the PID space. Yesterday's test that proved the
old allocator's high sensitivity to the PID allocation rate and patterns
is still valid.

i've compiled, booted & tested the patch on UP and SMP x86 as well.

	Ingo

--- linux/include/linux/pid.h.orig	Thu Sep 19 21:30:31 2002
+++ linux/include/linux/pid.h	Thu Sep 19 21:30:31 2002
@@ -0,0 +1,63 @@
+#ifndef _LINUX_PID_H
+#define _LINUX_PID_H
+
+enum pid_type
+{
+	PIDTYPE_PID,
+	PIDTYPE_PGID,
+	PIDTYPE_SID,
+	PIDTYPE_MAX
+};
+
+struct pid
+{
+	int nr;
+	atomic_t count;
+	struct task_struct *task;
+	struct list_head task_list;
+	struct list_head hash_chain;
+};
+
+struct pid_link
+{
+	struct list_head pid_chain;
+	struct pid *pidptr;
+	struct pid pid;
+};
+
+#define pid_task(elem, type) \
+	list_entry(elem, struct task_struct, pids[type].pid_chain)
+
+/*
+ * attach_pid() must be called with the tasklist_lock write-held.
+ *
+ * It might unlock the tasklist_lock for allocation, so this
+ * function must be called after installing all other links of
+ * a new task.
+ */
+extern int FASTCALL(attach_pid(struct task_struct *, enum pid_type, int));
+
+/*
+ * detach_pid() must be called with the tasklist_lock write-held.
+ */
+extern void FASTCALL(detach_pid(struct task_struct *task, enum pid_type));
+
+/*
+ * look up a PID in the hash table. Must be called with the tasklist_lock
+ * held.
+ */
+extern struct pid *FASTCALL(find_pid(enum pid_type, int));
+
+extern int alloc_pidmap(void);
+extern void FASTCALL(free_pidmap(int));
+
+#define for_each_task_pid(who, type, task, elem, pid)		\
+	if ((pid = find_pid(type, who)))			\
+	        for (elem = pid->task_list.next,			\
+			prefetch(elem->next),				\
+			task = pid_task(elem, type);			\
+			elem != &pid->task_list;			\
+			elem = elem->next, prefetch(elem->next), 	\
+			task = pid_task(elem, type))
+
+#endif /* _LINUX_PID_H */
--- linux/include/linux/sched.h.orig	Thu Sep 19 21:20:51 2002
+++ linux/include/linux/sched.h	Thu Sep 19 21:30:31 2002
@@ -28,6 +28,7 @@
 #include <linux/fs_struct.h>
 #include <linux/compiler.h>
 #include <linux/completion.h>
+#include <linux/pid.h>
 
 struct exec_domain;
 
@@ -266,6 +267,8 @@
 	atomic_inc(&__user->__count);			\
 	__user; })
 
+extern struct user_struct *find_user(uid_t);
+
 extern struct user_struct root_user;
 #define INIT_USER (&root_user)
 
@@ -326,9 +329,8 @@
 	struct task_struct *group_leader;
 	struct list_head thread_group;
 
-	/* PID hash table linkage. */
-	struct task_struct *pidhash_next;
-	struct task_struct **pidhash_pprev;
+	/* PID/PID hash table linkage. */
+	struct pid_link pids[PIDTYPE_MAX];
 
 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
@@ -474,38 +476,7 @@
 
 extern struct   mm_struct init_mm;
 
-/* PID hashing. (shouldnt this be dynamic?) */
-#define PIDHASH_SZ 8192
-extern struct task_struct *pidhash[PIDHASH_SZ];
-
-#define pid_hashfn(x)	((((x) >> 8) ^ (x)) & (PIDHASH_SZ - 1))
-
-static inline void hash_pid(struct task_struct *p)
-{
-	struct task_struct **htable = &pidhash[pid_hashfn(p->pid)];
-
-	if((p->pidhash_next = *htable) != NULL)
-		(*htable)->pidhash_pprev = &p->pidhash_next;
-	*htable = p;
-	p->pidhash_pprev = htable;
-}
-
-static inline void unhash_pid(struct task_struct *p)
-{
-	if(p->pidhash_next)
-		p->pidhash_next->pidhash_pprev = p->pidhash_pprev;
-	*p->pidhash_pprev = p->pidhash_next;
-}
-
-static inline struct task_struct *find_task_by_pid(int pid)
-{
-	struct task_struct *p, **htable = &pidhash[pid_hashfn(pid)];
-
-	for(p = *htable; p && p->pid != pid; p = p->pidhash_next)
-		;
-
-	return p;
-}
+extern struct task_struct *find_task_by_pid(int pid);
 
 /* per-UID process charging. */
 extern struct user_struct * alloc_uid(uid_t);
--- linux/include/linux/threads.h.orig	Thu Sep 19 21:20:33 2002
+++ linux/include/linux/threads.h	Thu Sep 19 21:30:31 2002
@@ -17,8 +17,13 @@
 #define MIN_THREADS_LEFT_FOR_ROOT 4
 
 /*
- * This controls the maximum pid allocated to a process
+ * This controls the default maximum pid allocated to a process
  */
-#define DEFAULT_PID_MAX 0x8000
+#define PID_MAX_DEFAULT 0x8000
+
+/*
+ * A maximum of 4 million PIDs should be enough for a while:
+ */
+#define PID_MAX_LIMIT (4*1024*1024)
 
 #endif
--- linux/include/linux/list.h.orig	Thu Sep 19 21:20:33 2002
+++ linux/include/linux/list.h	Thu Sep 19 21:30:31 2002
@@ -195,6 +195,10 @@
 #define list_for_each(pos, head) \
 	for (pos = (head)->next, prefetch(pos->next); pos != (head); \
         	pos = pos->next, prefetch(pos->next))
+
+#define list_for_each_noprefetch(pos, head) \
+	for (pos = (head)->next; pos != (head); pos = pos->next)
+
 /**
  * list_for_each_prev	-	iterate over a list backwards
  * @pos:	the &struct list_head to use as a loop counter.
--- linux/fs/fcntl.c.orig	Thu Sep 19 21:20:41 2002
+++ linux/fs/fcntl.c	Thu Sep 19 21:30:31 2002
@@ -480,7 +480,9 @@
 
 void send_sigio(struct fown_struct *fown, int fd, int band)
 {
-	struct task_struct * p;
+	struct task_struct *p;
+	struct list_head *l;
+	struct pid *pidptr;
 	int pid;
 	
 	read_lock(&fown->lock);
@@ -493,14 +495,8 @@
 		send_sigio_to_task(p, fown, fd, band);
 		goto out_unlock_task;
 	}
-	for_each_process(p) {
-		int match = p->pid;
-		if (pid < 0)
-			match = -p->pgrp;
-		if (pid != match)
-			continue;
-		send_sigio_to_task(p, fown, fd, band);
-	}
+	for_each_task_pid(-pid, PIDTYPE_PGID, p, l, pidptr)
+		send_sigio_to_task(p, fown,fd,band);
 out_unlock_task:
 	read_unlock(&tasklist_lock);
 out_unlock_fown:
--- linux/fs/exec.c.orig	Thu Sep 19 21:20:47 2002
+++ linux/fs/exec.c	Thu Sep 19 21:30:31 2002
@@ -609,8 +609,6 @@
 
 		ptrace_unlink(leader);
 		ptrace_unlink(current);
-		unhash_pid(current);
-		unhash_pid(leader);
 		remove_parent(current);
 		remove_parent(leader);
 		/*
@@ -631,8 +629,6 @@
 			current->ptrace = ptrace;
 			__ptrace_link(current, parent);
 		}
-		hash_pid(current);
-		hash_pid(leader);
 		
 		list_add_tail(&current->tasks, &init_task.tasks);
 		state = leader->state;
--- linux/kernel/Makefile.orig	Thu Sep 19 21:30:18 2002
+++ linux/kernel/Makefile	Thu Sep 19 21:30:31 2002
@@ -8,7 +8,7 @@
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o pid.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
--- linux/kernel/exit.c.orig	Thu Sep 19 21:30:18 2002
+++ linux/kernel/exit.c	Thu Sep 19 21:30:31 2002
@@ -33,7 +33,12 @@
 {
 	struct dentry *proc_dentry;
 	nr_threads--;
-	unhash_pid(p);
+	detach_pid(p, PIDTYPE_PID);
+	if (thread_group_leader(p)) {
+		detach_pid(p, PIDTYPE_PGID);
+		detach_pid(p, PIDTYPE_SID);
+	}
+
 	REMOVE_LINKS(p);
 	p->pid = 0;
 	proc_dentry = p->proc_dentry;
@@ -109,22 +114,18 @@
 int session_of_pgrp(int pgrp)
 {
 	struct task_struct *p;
-	int fallback;
+	struct list_head *l;
+	struct pid *pid;
+	int sid = -1;
 
-	fallback = -1;
 	read_lock(&tasklist_lock);
-	for_each_process(p) {
- 		if (p->session <= 0)
- 			continue;
-		if (p->pgrp == pgrp) {
-			fallback = p->session;
+	for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid)
+		if (p->session > 0) {
+			sid = p->session;
 			break;
 		}
-		if (p->pid == pgrp)
-			fallback = p->session;
-	}
 	read_unlock(&tasklist_lock);
-	return fallback;
+	return sid;
 }
 
 /*
@@ -135,21 +136,25 @@
  *
  * "I ask you, have you ever known what it is to be an orphan?"
  */
-static int __will_become_orphaned_pgrp(int pgrp, struct task_struct * ignored_task)
+static int __will_become_orphaned_pgrp(int pgrp, task_t *ignored_task)
 {
 	struct task_struct *p;
-
-	for_each_process(p) {
-		if ((p == ignored_task) || (p->pgrp != pgrp) ||
-		    (p->state == TASK_ZOMBIE) ||
-		    (p->real_parent->pid == 1))
+	struct list_head *l;
+	struct pid *pid;
+	int ret = 1;
+
+	for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
+		if (p == ignored_task
+				|| p->state == TASK_ZOMBIE 
+				|| p->real_parent->pid == 1)
 			continue;
-		if ((p->real_parent->pgrp != pgrp) &&
-		    (p->real_parent->session == p->session)) {
- 			return 0;
+		if (p->real_parent->pgrp != pgrp
+			    && p->real_parent->session == p->session) {
+			ret = 0;
+			break;
 		}
 	}
-	return 1;	/* (sighing) "Often!" */
+	return ret;	/* (sighing) "Often!" */
 }
 
 static int will_become_orphaned_pgrp(int pgrp, struct task_struct * ignored_task)
@@ -171,11 +176,11 @@
 static inline int __has_stopped_jobs(int pgrp)
 {
 	int retval = 0;
-	struct task_struct * p;
+	struct task_struct *p;
+	struct list_head *l;
+	struct pid *pid;
 
-	for_each_process(p) {
-		if (p->pgrp != pgrp)
-			continue;
+	for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
 		if (p->state != TASK_STOPPED)
 			continue;
 		retval = 1;
@@ -605,7 +610,8 @@
 	if (tsk->pid == 1)
 		panic("Attempted to kill init!");
 	tsk->flags |= PF_EXITING;
-	del_timer_sync(&tsk->real_timer);
+	if (timer_pending(&tsk->real_timer))
+		del_timer_sync(&tsk->real_timer);
 
 	if (unlikely(preempt_count()))
 		printk(KERN_INFO "note: %s[%d] exited with preempt_count %d\n",
--- linux/kernel/user.c.orig	Thu Sep 19 21:20:08 2002
+++ linux/kernel/user.c	Thu Sep 19 21:30:31 2002
@@ -64,6 +64,11 @@
 	return NULL;
 }
 
+struct user_struct *find_user(uid_t uid)
+{
+	return uid_hash_find(uid, uidhashentry(uid));
+}
+
 void free_uid(struct user_struct *up)
 {
 	if (up && atomic_dec_and_lock(&up->__count, &uidhash_lock)) {
--- linux/kernel/pid.c.orig	Thu Sep 19 21:30:31 2002
+++ linux/kernel/pid.c	Thu Sep 19 21:30:31 2002
@@ -0,0 +1,219 @@
+/*
+ * Generic pidhash and scalable, time-bounded PID allocator
+ *
+ * (C) 2002 William Irwin, IBM
+ * (C) 2002 Ingo Molnar, Red Hat
+ *
+ * pid-structures are backing objects for tasks sharing a given ID to chain
+ * against. There is very little to them aside from hashing them and
+ * parking tasks using given ID's on a list.
+ *
+ * The hash is always changed with the tasklist_lock write-acquired,
+ * and the hash is only accessed with the tasklist_lock at least
+ * read-acquired, so there's no additional SMP locking needed here.
+ *
+ * We have a list of bitmap pages, which bitmaps represent the PID space.
+ * Allocating and freeing PIDs is completely lockless. The worst-case
+ * allocation scenario when all but one out of 1 million PIDs possible are
+ * allocated already: the scanning of 32 list entries and at most PAGE_SIZE
+ * bytes. The typical fastpath is a single successful setbit. Freeing is O(1).
+ */
+
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/bootmem.h>
+
+#define PIDHASH_SIZE 4096
+#define pid_hashfn(nr) ((nr >> 8) ^ nr) & (PIDHASH_SIZE - 1)
+static struct list_head pid_hash[PIDTYPE_MAX][PIDHASH_SIZE];
+
+int pid_max = PID_MAX_DEFAULT;
+int last_pid;
+
+#define RESERVED_PIDS		300
+
+#define PIDMAP_ENTRIES		(PID_MAX_LIMIT/PAGE_SIZE/8)
+#define BITS_PER_PAGE		(PAGE_SIZE*8)
+#define BITS_PER_PAGE_MASK	(BITS_PER_PAGE-1)
+
+/*
+ * PID-map pages start out as NULL, they get allocated upon
+ * first use and are never deallocated. This way a low pid_max
+ * value does not cause lots of bitmaps to be allocated, but
+ * the scheme scales to up to 4 million PIDs, runtime.
+ */
+typedef struct pidmap {
+	atomic_t nr_free;
+	void *page;
+} pidmap_t;
+
+static pidmap_t pidmap_array[PIDMAP_ENTRIES] =
+	 { [ 0 ... PIDMAP_ENTRIES-1 ] = { ATOMIC_INIT(BITS_PER_PAGE), NULL } };
+
+static pidmap_t *map_limit = pidmap_array + PIDMAP_ENTRIES;
+
+inline void free_pidmap(int pid)
+{
+	pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
+	int offset = pid & BITS_PER_PAGE_MASK;
+
+	clear_bit(offset, map->page);
+	atomic_inc(&map->nr_free);
+}
+
+/*
+ * Here we search for the next map that has free bits left.
+ * Normally the next map has free PIDs.
+ */
+static inline pidmap_t *next_free_map(pidmap_t *map, int *max_steps)
+{
+	while (--*max_steps) {
+		if (++map == map_limit)
+			map = pidmap_array;
+		if (unlikely(!map->page)) {
+			unsigned long page = get_zeroed_page(GFP_KERNEL);
+			/*
+			 * Free the page if someone raced with us
+			 * installing it:
+			 */
+			if (cmpxchg(&map->page, NULL, page))
+				free_page(page);
+			if (!map->page)
+				break;
+		}
+		if (atomic_read(&map->nr_free))
+			return map;
+	}
+	return NULL;
+}
+
+int alloc_pidmap(void)
+{
+	int pid, offset, max_steps = PIDMAP_ENTRIES + 1;
+	pidmap_t *map;
+
+	pid = last_pid + 1;
+	if (pid >= pid_max)
+		pid = RESERVED_PIDS;
+
+	offset = pid & BITS_PER_PAGE_MASK;
+	map = pidmap_array + pid / BITS_PER_PAGE;
+
+	if (likely(map->page && !test_and_set_bit(offset, map->page))) {
+		/*
+		 * There is a small window for last_pid updates to race,
+		 * but in that case the next allocation will go into the
+		 * slowpath and that fixes things up.
+		 */
+return_pid:
+		atomic_dec(&map->nr_free);
+		last_pid = pid;
+		return pid;
+	}
+	
+	if (!offset || !atomic_read(&map->nr_free)) {
+next_map:
+		map = next_free_map(map, &max_steps);
+		if (!map)
+			goto failure;
+		offset = 0;
+	}
+	/*
+	 * Find the next zero bit:
+	 */
+scan_more:
+	offset = find_next_zero_bit(map->page, BITS_PER_PAGE, offset);
+	if (offset == BITS_PER_PAGE)
+		goto next_map;
+	if (test_and_set_bit(offset, map->page))
+		goto scan_more;
+
+	/* we got the PID: */
+	pid = (map - pidmap_array) * BITS_PER_PAGE + offset;
+	goto return_pid;
+
+failure:
+	return -1;
+}
+
+inline struct pid *find_pid(enum pid_type type, int nr)
+{
+	struct list_head *elem, *bucket = &pid_hash[type][pid_hashfn(nr)];
+	struct pid *pid;
+
+	list_for_each_noprefetch(elem, bucket) {
+		pid = list_entry(elem, struct pid, hash_chain);
+		if (pid->nr == nr)
+			return pid;
+	}
+	return NULL;
+}
+
+int attach_pid(task_t *task, enum pid_type type, int nr)
+{
+	struct pid *pid = find_pid(type, nr);
+
+	if (pid)
+		atomic_inc(&pid->count);
+	else {
+		pid = &task->pids[type].pid;
+		pid->nr = nr;
+		atomic_set(&pid->count, 1);
+		INIT_LIST_HEAD(&pid->task_list);
+		pid->task = current;
+		get_task_struct(current);
+		list_add(&pid->hash_chain, &pid_hash[type][pid_hashfn(nr)]);
+	}
+	list_add(&task->pids[type].pid_chain, &pid->task_list);
+	task->pids[type].pidptr = pid;
+
+	return 0;
+}
+
+void detach_pid(task_t *task, enum pid_type type)
+{
+	struct pid_link *link = task->pids + type;
+	struct pid *pid = link->pidptr;
+	int nr;
+
+	list_del(&link->pid_chain);
+	if (!atomic_dec_and_test(&pid->count))
+		return;
+
+	nr = pid->nr;
+	list_del(&pid->hash_chain);
+	put_task_struct(pid->task);
+
+	for (type = 0; type < PIDTYPE_MAX; ++type)
+		if (find_pid(type, nr))
+			return;
+	free_pidmap(nr);
+}
+
+extern task_t *find_task_by_pid(int nr)
+{
+	struct pid *pid = find_pid(PIDTYPE_PID, nr);
+
+	if (!pid)
+		return NULL;
+	return pid_task(pid->task_list.next, PIDTYPE_PID);
+}
+
+void __init pidhash_init(void)
+{
+	int i, j;
+
+	/*
+	 * Allocate PID 0, and hash it via all PID types:
+	 */
+	pidmap_array->page = (void *)get_zeroed_page(GFP_KERNEL);
+	set_bit(0, pidmap_array->page);
+	atomic_dec(&pidmap_array->nr_free);
+
+	for (i = 0; i < PIDTYPE_MAX; i++) {
+		for (j = 0; j < PIDHASH_SIZE; j++)
+			INIT_LIST_HEAD(&pid_hash[i][j]);
+		attach_pid(current, i, 0);
+	}
+}
--- linux/kernel/signal.c.orig	Thu Sep 19 21:20:41 2002
+++ linux/kernel/signal.c	Thu Sep 19 21:30:31 2002
@@ -943,18 +943,18 @@
 
 int __kill_pg_info(int sig, struct siginfo *info, pid_t pgrp)
 {
-	int retval = -EINVAL;
-	if (pgrp > 0) {
-		struct task_struct *p;
-
-		retval = -ESRCH;
-		for_each_process(p) {
-			if (p->pgrp == pgrp) {
-				int err = send_sig_info(sig, info, p);
-				if (retval)
-					retval = err;
-			}
-		}
+	struct task_struct *p;
+	struct list_head *l;
+	struct pid *pid;
+	int err, retval = -ESRCH;
+
+	if (pgrp <= 0)
+		return -EINVAL;
+
+	for_each_task_pid(pgrp, PIDTYPE_PGID, p, l, pid) {
+		err = send_sig_info(sig, info, p);
+		if (retval)
+			retval = err;
 	}
 	return retval;
 }
@@ -977,28 +977,33 @@
  * the connection is lost.
  */
 
+
 int
-kill_sl_info(int sig, struct siginfo *info, pid_t sess)
+kill_sl_info(int sig, struct siginfo *info, pid_t sid)
 {
-	int retval = -EINVAL;
-	if (sess > 0) {
-		struct task_struct *p;
-
-		retval = -ESRCH;
-		read_lock(&tasklist_lock);
-		for_each_process(p) {
-			if (p->leader && p->session == sess) {
-				int err = send_sig_info(sig, info, p);
-				if (retval)
-					retval = err;
-			}
-		}
-		read_unlock(&tasklist_lock);
+	int err, retval = -EINVAL;
+	struct pid *pid;
+	struct list_head *l;
+	struct task_struct *p;
+
+	if (sid <= 0)
+		goto out;
+
+	retval = -ESRCH;
+	read_lock(&tasklist_lock);
+	for_each_task_pid(sid, PIDTYPE_SID, p, l, pid) {
+		if (!p->leader)
+			continue;
+		err = send_sig_info(sig, info, p);
+		if (retval)
+			retval = err;
 	}
+	read_unlock(&tasklist_lock);
+out:
 	return retval;
 }
 
-inline int
+int
 kill_proc_info(int sig, struct siginfo *info, pid_t pid)
 {
 	int error;
--- linux/kernel/sys.c.orig	Thu Sep 19 21:20:41 2002
+++ linux/kernel/sys.c	Thu Sep 19 21:30:31 2002
@@ -203,35 +203,34 @@
 cond_syscall(sys_quotactl)
 cond_syscall(sys_acct)
 
-static int proc_sel(struct task_struct *p, int which, int who)
+static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
-	if(p->pid)
-	{
-		switch (which) {
-			case PRIO_PROCESS:
-				if (!who && p == current)
-					return 1;
-				return(p->pid == who);
-			case PRIO_PGRP:
-				if (!who)
-					who = current->pgrp;
-				return(p->pgrp == who);
-			case PRIO_USER:
-				if (!who)
-					who = current->uid;
-				return(p->uid == who);
-		}
+	if (p->uid != current->euid &&
+		p->uid != current->uid && !capable(CAP_SYS_NICE)) {
+		error = -EPERM;
+		goto out;
 	}
-	return 0;
+
+	if (error == -ESRCH)
+		error = 0;
+	if (niceval < task_nice(p) && !capable(CAP_SYS_NICE))
+		error = -EACCES;
+	else
+		set_user_nice(p, niceval);
+out:
+	return error;
 }
 
 asmlinkage long sys_setpriority(int which, int who, int niceval)
 {
 	struct task_struct *g, *p;
-	int error;
+	struct user_struct *user;
+	struct pid *pid;
+	struct list_head *l;
+	int error = -EINVAL;
 
 	if (which > 2 || which < 0)
-		return -EINVAL;
+		goto out;
 
 	/* normalize: avoid signed division (rounding problems) */
 	error = -ESRCH;
@@ -241,31 +240,38 @@
 		niceval = 19;
 
 	read_lock(&tasklist_lock);
-	do_each_thread(g, p) {
-		int no_nice;
-		if (!proc_sel(p, which, who))
-			continue;
-		if (p->uid != current->euid &&
-			p->uid != current->uid && !capable(CAP_SYS_NICE)) {
-			error = -EPERM;
-			continue;
-		}
-		if (error == -ESRCH)
-			error = 0;
-		if (niceval < task_nice(p) && !capable(CAP_SYS_NICE)) {
-			error = -EACCES;
-			continue;
-		}
-		no_nice = security_ops->task_setnice(p, niceval);
-		if (no_nice) {
-			error = no_nice;
-			continue;
-		}
-		set_user_nice(p, niceval);
-	} while_each_thread(g, p);
-
+	switch (which) {
+		case PRIO_PROCESS:
+			if (!who)
+				who = current->pid;
+			p = find_task_by_pid(who);
+			if (p)
+				error = set_one_prio(p, niceval, error);
+			break;
+		case PRIO_PGRP:
+			if (!who)
+				who = current->pgrp;
+			for_each_task_pid(who, PIDTYPE_PGID, p, l, pid)
+				error = set_one_prio(p, niceval, error);
+			break;
+		case PRIO_USER:
+			if (!who)
+				user = current->user;
+			else
+				user = find_user(who);
+
+			if (!user)
+				goto out_unlock;
+
+			do_each_thread(g, p)
+				if (p->uid == who)
+					error = set_one_prio(p, niceval, error);
+			while_each_thread(g, p);
+			break;
+	}
+out_unlock:
 	read_unlock(&tasklist_lock);
-
+out:
 	return error;
 }
 
@@ -278,20 +284,54 @@
 asmlinkage long sys_getpriority(int which, int who)
 {
 	struct task_struct *g, *p;
-	long retval = -ESRCH;
+	struct list_head *l;
+	struct pid *pid;
+	struct user_struct *user;
+	long niceval, retval = -ESRCH;
 
 	if (which > 2 || which < 0)
 		return -EINVAL;
 
 	read_lock(&tasklist_lock);
-	do_each_thread(g, p) {
-		long niceval;
-		if (!proc_sel(p, which, who))
-			continue;
-		niceval = 20 - task_nice(p);
-		if (niceval > retval)
-			retval = niceval;
-	} while_each_thread(g, p);
+	switch (which) {
+		case PRIO_PROCESS:
+			if (!who)
+				who = current->pid;
+			p = find_task_by_pid(who);
+			if (p) {
+				niceval = 20 - task_nice(p);
+				if (niceval > retval)
+					retval = niceval;
+			}
+			break;
+		case PRIO_PGRP:
+			if (!who)
+				who = current->pgrp;
+			for_each_task_pid(who, PIDTYPE_PGID, p, l, pid) {
+				niceval = 20 - task_nice(p);
+				if (niceval > retval)
+					retval = niceval;
+			}
+			break;
+		case PRIO_USER:
+			if (!who)
+				user = current->user;
+			else
+				user = find_user(who);
+
+			if (!user)
+				goto out_unlock;
+
+			do_each_thread(g, p)
+				if (p->uid == who) {
+					niceval = 20 - task_nice(p);
+					if (niceval > retval)
+						retval = niceval;
+				}
+			while_each_thread(g, p);
+			break;
+	}
+out_unlock:
 	read_unlock(&tasklist_lock);
 
 	return retval;
@@ -849,7 +889,7 @@
 
 asmlinkage long sys_setpgid(pid_t pid, pid_t pgid)
 {
-	struct task_struct * p;
+	struct task_struct *p;
 	int err = -EINVAL;
 
 	if (!pid)
@@ -862,12 +902,15 @@
 	/* From this point forward we keep holding onto the tasklist lock
 	 * so that our parent does not change from under us. -DaveM
 	 */
-	read_lock(&tasklist_lock);
+	write_lock_irq(&tasklist_lock);
 
 	err = -ESRCH;
 	p = find_task_by_pid(pid);
 	if (!p)
 		goto out;
+	err = -EINVAL;
+	if (!thread_group_leader(p))
+		goto out;
 
 	if (p->parent == current || p->real_parent == current) {
 		err = -EPERM;
@@ -882,25 +925,26 @@
 	if (p->leader)
 		goto out;
 	if (pgid != pid) {
-		struct task_struct *g, *tmp;
-		do_each_thread(g, tmp) {
-			if (tmp->pgrp == pgid &&
-			    tmp->session == current->session)
+		struct task_struct *p;
+		struct pid *pid;
+		struct list_head *l;
+
+		for_each_task_pid(pgid, PIDTYPE_PGID, p, l, pid)
+			if (p->session == current->session)
 				goto ok_pgid;
-		} while_each_thread(g, tmp);
 		goto out;
 	}
 
 ok_pgid:
-	err = security_ops->task_setpgid(p, pgid);
-	if (err)
-		goto out;
-
-	p->pgrp = pgid;
+	if (p->pgrp != pgid) {
+		detach_pid(p, PIDTYPE_PGID);
+		p->pgrp = pgid;
+		attach_pid(p, PIDTYPE_PGID, pgid);
+	}
 	err = 0;
 out:
 	/* All paths lead to here, thus we are safe. -DaveM */
-	read_unlock(&tasklist_lock);
+	write_unlock_irq(&tasklist_lock);
 	return err;
 }
 
@@ -956,22 +1000,34 @@
 
 asmlinkage long sys_setsid(void)
 {
-	struct task_struct *g, *p;
+	struct pid *pid;
 	int err = -EPERM;
 
-	read_lock(&tasklist_lock);
-	do_each_thread(g, p)
-		if (p->pgrp == current->pid)
-			goto out;
-	while_each_thread(g, p);
+	if (!thread_group_leader(current))
+		return -EINVAL;
+
+	write_lock_irq(&tasklist_lock);
+
+	pid = find_pid(PIDTYPE_PGID, current->pid);
+	if (pid)
+		goto out;
 
 	current->leader = 1;
-	current->session = current->pgrp = current->pid;
+	if (current->session != current->pid) {
+		detach_pid(current, PIDTYPE_SID);
+		current->session = current->pid;
+		attach_pid(current, PIDTYPE_SID, current->pid);
+	}
+	if (current->pgrp != current->pid) {
+		detach_pid(current, PIDTYPE_PGID);
+		current->pgrp = current->pid;
+		attach_pid(current, PIDTYPE_PGID, current->pid);
+	}
 	current->tty = NULL;
 	current->tty_old_pgrp = 0;
 	err = current->pgrp;
 out:
-	read_unlock(&tasklist_lock);
+	write_unlock_irq(&tasklist_lock);
 	return err;
 }
 
--- linux/kernel/fork.c.orig	Thu Sep 19 21:30:18 2002
+++ linux/kernel/fork.c	Thu Sep 19 21:30:31 2002
@@ -47,17 +47,6 @@
 int max_threads;
 unsigned long total_forks;	/* Handle normal Linux uptimes. */
 
-/*
- * Protects next_safe, last_pid and pid_max:
- */
-spinlock_t lastpid_lock = SPIN_LOCK_UNLOCKED;
-
-static int next_safe = DEFAULT_PID_MAX;
-int pid_max = DEFAULT_PID_MAX;
-int last_pid;
-
-struct task_struct *pidhash[PIDHASH_SZ];
-
 rwlock_t tasklist_lock __cacheline_aligned = RW_LOCK_UNLOCKED;  /* outer */
 
 /*
@@ -75,16 +64,14 @@
 	} else {
 		int cpu = smp_processor_id();
 
-		tsk = task_cache[cpu];
+		tsk = xchg(task_cache + cpu, tsk);
 		if (tsk) {
 			free_thread_info(tsk->thread_info);
 			kmem_cache_free(task_struct_cachep,tsk);
 		}
-		task_cache[cpu] = current;
 	}
 }
 
-/* Protects next_safe and last_pid. */
 void add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
 {
 	unsigned long flags;
@@ -140,73 +127,28 @@
 	struct task_struct *tsk;
 	struct thread_info *ti;
 
-	ti = alloc_thread_info();
-	if (!ti)
-		return NULL;
-
-	tsk = kmem_cache_alloc(task_struct_cachep, GFP_KERNEL);
+	tsk = xchg(task_cache + smp_processor_id(), NULL);
 	if (!tsk) {
-		free_thread_info(ti);
-		return NULL;
-	}
+		ti = alloc_thread_info();
+		if (!ti)
+			return NULL;
+
+		tsk = kmem_cache_alloc(task_struct_cachep, GFP_KERNEL);
+		if (!tsk) {
+			free_thread_info(ti);
+			return NULL;
+		}
+	} else
+		ti = tsk->thread_info;
 
 	*ti = *orig->thread_info;
 	*tsk = *orig;
 	tsk->thread_info = ti;
 	ti->task = tsk;
 	atomic_set(&tsk->usage,1);
-
 	return tsk;
 }
 
-static int get_pid(unsigned long flags)
-{
-	struct task_struct *g, *p;
-	int pid;
-
-	if (flags & CLONE_IDLETASK)
-		return 0;
-
-	spin_lock(&lastpid_lock);
-	if (++last_pid > pid_max) {
-		last_pid = 300;		/* Skip daemons etc. */
-		goto inside;
-	}
-
-	if (last_pid >= next_safe) {
-inside:
-		if (nr_threads > pid_max >> 4)
-			pid_max <<= 1;
-		next_safe = pid_max;
-		read_lock(&tasklist_lock);
-	repeat:
-		do_each_thread(g, p) {
-			if (p->pid == last_pid	||
-			   p->pgrp == last_pid	||
-			   p->session == last_pid) {
-				if (++last_pid >= next_safe) {
-					if (last_pid >= pid_max)
-						last_pid = 300;
-					next_safe = pid_max;
-				}
-				goto repeat;
-			}
-			if (p->pid > last_pid && next_safe > p->pid)
-				next_safe = p->pid;
-			if (p->pgrp > last_pid && next_safe > p->pgrp)
-				next_safe = p->pgrp;
-			if (p->session > last_pid && next_safe > p->session)
-				next_safe = p->session;
-		} while_each_thread(g, p);
-
-		read_unlock(&tasklist_lock);
-	}
-	pid = last_pid;
-	spin_unlock(&lastpid_lock);
-
-	return pid;
-}
-
 static inline int dup_mmap(struct mm_struct * mm)
 {
 	struct vm_area_struct * mpnt, *tmp, **pprev;
@@ -726,7 +668,13 @@
 	p->state = TASK_UNINTERRUPTIBLE;
 
 	copy_flags(clone_flags, p);
-	p->pid = get_pid(clone_flags);
+	if (clone_flags & CLONE_IDLETASK)
+		p->pid = 0;
+	else {
+		p->pid = alloc_pidmap();
+		if (p->pid == -1)
+			goto bad_fork_cleanup;
+	}
 	p->proc_dentry = NULL;
 
 	INIT_LIST_HEAD(&p->run_list);
@@ -889,7 +837,13 @@
 	SET_LINKS(p);
 	if (p->ptrace & PT_PTRACED)
 		__ptrace_link(p, current->parent);
-	hash_pid(p);
+
+	attach_pid(p, PIDTYPE_PID, p->pid);
+	if (thread_group_leader(p)) {
+		attach_pid(p, PIDTYPE_PGID, p->pgrp);
+		attach_pid(p, PIDTYPE_SID, p->session);
+	}
+
 	nr_threads++;
 	write_unlock_irq(&tasklist_lock);
 	retval = 0;
@@ -914,6 +868,8 @@
 bad_fork_cleanup_security:
 	security_ops->task_free_security(p);
 bad_fork_cleanup:
+	if (p->pid > 0)
+		free_pidmap(p->pid);
 	put_exec_domain(p->thread_info->exec_domain);
 	if (p->binfmt && p->binfmt->module)
 		__MOD_DEC_USE_COUNT(p->binfmt->module);
--- linux/kernel/ksyms.c.orig	Thu Sep 19 21:20:51 2002
+++ linux/kernel/ksyms.c	Thu Sep 19 21:30:31 2002
@@ -602,7 +602,6 @@
 EXPORT_SYMBOL(init_thread_union);
 
 EXPORT_SYMBOL(tasklist_lock);
-EXPORT_SYMBOL(pidhash);
 #if defined(CONFIG_SMP) && defined(__GENERIC_PER_CPU)
 EXPORT_SYMBOL(__per_cpu_offset);
 #endif
--- linux/init/main.c.orig	Thu Sep 19 21:20:41 2002
+++ linux/init/main.c	Thu Sep 19 21:30:31 2002
@@ -66,6 +66,7 @@
 extern void sysctl_init(void);
 extern void signals_init(void);
 extern void buffer_init(void);
+extern void pidhash_init(void);
 extern void pte_chain_init(void);
 extern void radix_tree_init(void);
 extern void free_initmem(void);
@@ -432,6 +433,7 @@
 #endif
 	mem_init();
 	kmem_cache_sizes_init();
+	pidhash_init();
 	pgtable_cache_init();
 	pte_chain_init();
 	fork_init(num_physpages);

