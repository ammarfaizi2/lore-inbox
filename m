Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269756AbSISCm4>; Wed, 18 Sep 2002 22:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269759AbSISCm4>; Wed, 18 Sep 2002 22:42:56 -0400
Received: from mx2.elte.hu ([157.181.151.9]:59819 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S269756AbSISCmm>;
	Wed, 18 Sep 2002 22:42:42 -0400
Date: Thu, 19 Sep 2002 04:54:46 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, <linux-kernel@vger.kernel.org>
Subject: [patch] generic-pidhash-2.5.36-D4, BK-curr
In-Reply-To: <Pine.LNX.4.44.0209182101150.27697-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209190344280.3935-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch is a significantly cleaned up version of the generic
pidhash patch, against BK-curr. Changes:

 - merged the pidhash and id-hash concepts into a single 'generic 
   pidhash' thing. 

 - unified kernel/pid.c and kernel/idtag.c into kernel/pid.c.

 - eliminated the pidhash lock.

 - simplified the use of the generic pidhash, in most cases we simply
   iterate over a given PID 'type' (or class):

       for_each_task_pid(current->session, PIDTYPE_SID, p, l, pid)
               p->tty = NULL;

   there's no get_tag()/put_tag() anymore, just simple loops.

 - fixed a number of bugs that caused inconsistent pid hashing. Added two 
   bugchecks that catch all cases when the pidhash gets out of sync with
   the pidmap.

 - removed the per-user task-list changes, it will be done in a separate
   patch.

 - removed the PIDTYPE_TGID class, it's not necessary anymore with the
   latest threading changes in 2.5.35.

 - lots of other cleanups and simplifications.

the patch is stable in both UP and SMP tests.

performance and robustness measurements:

thread creation+destruction (full) latency is the one that is most
sensitive to the PID allocation code. I've done testing on a 'low end
server' system with 1000 tasks running, and i've also done 5000, 10000 and
50000 (inactive) threads test. In all cases pid_max is at a safely large
value, 1 million, the PID fill ratio is 1% for the 10K threads test, 0.1%
in the 1000 threads test.

i created and destroyed 1 million threads, in a serial way:

    ./perf -s 1000000 -t 1 -r 0 -T --sync-join

4 of such measurements were running at once, to load the dual-P4 SMP box.  
All CPUs were 100% loaded during the test. Note that pid_max and the
number of threads created is 1 million as well, this is to get a fair
average of passing the whole PID range.

BK-stock gives the following results:

	# of tasks:		250	1000	5000 	10000	50000
        -------------------------------------------------------------
	4x 1m threads (sec):	21.2	23.0	47.4	[NMI]	[NMI]

the results prove that even this extremely low PID space fill rate causes
noticeable PID allocation overhead. Things really escallate at 10000
threads, the NMI watchdog triggered very quickly (ie. an irqs-off latency
of more than 5 seconds happened). The results would have been well above
200 seconds. Even in the 5000 threads test the system was occasionally
very jerky, and probably missed interrupts as well.

Note that the inactive threads (1K, 5K, 10K and 10K threads) were using a
consecutive PID range, which favors the get_pid() algorithm, as all
cachemisses will be concentrated into one big chunk, and ~0.95 million
PIDs can be allocated without any interference afterwards. With a more
random distribution of PIDs the overhead is larger.

BK+patch gives the following results:

	# of tasks:		250	1000	5000 	10000	50000
        -------------------------------------------------------------
	4x 1m threads (sec):	23.8	23.8	24.1	25.5	27.7

ie. thread creation performance is stable, it increases slightly, probably
due to hash-chains getting bigger. The catastrophic breakdown in
performance is solved.

but i'm still not happy about the 250 tasks performance of the generic
pidhash - it has some constant overhead. It's not noticeable in fork
latencies though. I think there are still a number of performance
optimizations possible that we can do.

(i have not attempted to measure the improvement in those cases where the
for_each_task loop was eliminated - it's no doubt significant.)

	Ingo

--- linux/drivers/char/tty_io.c.orig	Thu Sep 19 00:40:44 2002
+++ linux/drivers/char/tty_io.c	Thu Sep 19 01:27:37 2002
@@ -432,6 +432,7 @@
 	struct file * cons_filp = NULL;
 	struct task_struct *p;
 	struct list_head *l;
+	struct pid *pid;
 	int    closecount = 0, n;
 
 	if (!tty)
@@ -496,17 +497,17 @@
 	}
 	
 	read_lock(&tasklist_lock);
- 	for_each_process(p) {
-		if ((tty->session > 0) && (p->session == tty->session) &&
-		    p->leader) {
-			send_sig(SIGHUP,p,1);
-			send_sig(SIGCONT,p,1);
+	if (tty->session > 0)
+		for_each_task_pid(tty->session, PIDTYPE_SID, p, l, pid) {
+			if (p->tty == tty)
+				p->tty = NULL;
+			if (!p->leader)
+				continue;
+			send_sig(SIGHUP, p, 1);
+			send_sig(SIGCONT, p, 1);
 			if (tty->pgrp > 0)
 				p->tty_old_pgrp = tty->pgrp;
 		}
-		if (p->tty == tty)
-			p->tty = NULL;
-	}
 	read_unlock(&tasklist_lock);
 
 	tty->flags = 0;
@@ -571,6 +572,8 @@
 {
 	struct tty_struct *tty = current->tty;
 	struct task_struct *p;
+	struct list_head *l;
+	struct pid *pid;
 	int tty_pgrp = -1;
 
 	lock_kernel();
@@ -598,9 +601,8 @@
 	tty->pgrp = -1;
 
 	read_lock(&tasklist_lock);
-	for_each_process(p)
-	  	if (p->session == current->session)
-			p->tty = NULL;
+	for_each_task_pid(current->session, PIDTYPE_SID, p, l, pid)
+		p->tty = NULL;
 	read_unlock(&tasklist_lock);
 	unlock_kernel();
 }
@@ -1221,12 +1223,15 @@
 	 */
 	if (tty_closing || o_tty_closing) {
 		struct task_struct *p;
+		struct list_head *l;
+		struct pid *pid;
 
 		read_lock(&tasklist_lock);
-		for_each_process(p) {
-			if (p->tty == tty || (o_tty && p->tty == o_tty))
+		for_each_task_pid(tty->session, PIDTYPE_SID, p, l, pid)
+			p->tty = NULL;
+		if (o_tty)
+			for_each_task_pid(o_tty->session, PIDTYPE_SID, p,l, pid)
 				p->tty = NULL;
-		}
 		read_unlock(&tasklist_lock);
 
 		if (redirect == tty || (o_tty && redirect == o_tty))
@@ -1540,6 +1545,10 @@
 
 static int tiocsctty(struct tty_struct *tty, int arg)
 {
+	struct list_head *l;
+	struct pid *pid;
+	task_t *p;
+
 	if (current->leader &&
 	    (current->session == tty->session))
 		return 0;
@@ -1558,12 +1567,10 @@
 			/*
 			 * Steal it away
 			 */
-			struct task_struct *p;
 
 			read_lock(&tasklist_lock);
-			for_each_process(p)
-				if (p->tty == tty)
-					p->tty = NULL;
+			for_each_task_pid(tty->session, PIDTYPE_SID, p, l, pid)
+				p->tty = NULL;
 			read_unlock(&tasklist_lock);
 		} else
 			return -EPERM;
--- linux/include/linux/pid.h.orig	Thu Sep 19 00:41:21 2002
+++ linux/include/linux/pid.h	Thu Sep 19 01:18:29 2002
@@ -0,0 +1,61 @@
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
+	enum pid_type type;
+	atomic_t count;
+	struct list_head hash_chain;
+	struct list_head task_list;
+};
+
+struct pid_link
+{
+	int nr;
+	struct list_head pid_chain;
+	struct pid *pid;
+};
+
+#define pid_task(elem, type) \
+	list_entry(elem, struct task_struct, pids[(int)(type)].pid_chain)
+
+/*
+ * attach_pid() must be called with the tasklist_lock write-held.
+ * It might unlock the tasklist_lock for allocation, so this
+ * function must be called last after installing the links of
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
+ * Quick & dirty hash table lookup.
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
--- linux/include/linux/sched.h.orig	Thu Sep 19 00:40:52 2002
+++ linux/include/linux/sched.h	Thu Sep 19 02:56:18 2002
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
--- linux/include/linux/threads.h.orig	Thu Sep 19 00:40:38 2002
+++ linux/include/linux/threads.h	Thu Sep 19 00:41:21 2002
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
--- linux/include/asm-i386/types.h.orig	Sun Jun  9 07:26:52 2002
+++ linux/include/asm-i386/types.h	Thu Sep 19 00:41:21 2002
@@ -41,7 +41,8 @@
 typedef signed long long s64;
 typedef unsigned long long u64;
 
-#define BITS_PER_LONG 32
+#define BITS_PER_LONG_SHIFT	5
+#define BITS_PER_LONG		(1 << BITS_PER_LONG_SHIFT)
 
 /* DMA addresses come in generic and 64-bit flavours.  */
 
--- linux/fs/fcntl.c.orig	Thu Sep 19 00:40:45 2002
+++ linux/fs/fcntl.c	Thu Sep 19 01:32:06 2002
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
--- linux/fs/exec.c.orig	Thu Sep 19 00:40:51 2002
+++ linux/fs/exec.c	Thu Sep 19 01:48:30 2002
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
--- linux/kernel/Makefile.orig	Thu Sep 19 00:40:12 2002
+++ linux/kernel/Makefile	Thu Sep 19 00:41:21 2002
@@ -15,7 +15,7 @@
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o pid.o
 
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
--- linux/kernel/exit.c.orig	Thu Sep 19 00:41:07 2002
+++ linux/kernel/exit.c	Thu Sep 19 02:45:34 2002
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
--- linux/kernel/user.c.orig	Thu Sep 19 02:53:48 2002
+++ linux/kernel/user.c	Thu Sep 19 02:54:02 2002
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
--- linux/kernel/pid.c.orig	Thu Sep 19 00:41:21 2002
+++ linux/kernel/pid.c	Thu Sep 19 03:24:47 2002
@@ -0,0 +1,268 @@
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
+#include <linux/bootmem.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+
+static kmem_cache_t *pid_cache;
+
+#define PIDHASH_SIZE 4096
+static struct list_head pid_hash[PIDTYPE_MAX][PIDHASH_SIZE];
+#define pid_hashfn(nr) ((nr >> 8) ^ nr) & (PIDHASH_SIZE - 1)
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
+static inline int check_pid(int pid)
+{
+	pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
+	int offset = pid & BITS_PER_PAGE_MASK;
+
+	return test_bit(offset, map->page);
+}
+
+void free_pidmap(int pid)
+{
+	pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
+	int offset = pid & BITS_PER_PAGE_MASK;
+
+	if (!test_and_clear_bit(offset, map->page))
+		BUG();
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
+struct pid *find_pid(enum pid_type type, int nr)
+{
+	struct list_head *elem, *bucket = &pid_hash[type][pid_hashfn(nr)];
+	struct pid *pid;
+
+	list_for_each(elem, bucket) {
+		pid = list_entry(elem, struct pid, hash_chain);
+		if (pid->nr == nr) {
+			if (unlikely(!check_pid(nr)))
+				BUG();
+			return pid;
+		}
+	}
+	return NULL;
+}
+
+static inline struct pid *get_pid(enum pid_type type, int nr)
+{
+	struct pid *pid, *raced_pid;
+
+	pid = find_pid(type, nr);
+	if (pid)
+		goto out_inc;
+
+	while (!pid) {
+		write_unlock_irq(&tasklist_lock);
+		pid = kmem_cache_alloc(pid_cache, SLAB_KERNEL);
+		write_lock_irq(&tasklist_lock);
+	}
+
+	raced_pid = find_pid(type, nr);
+	if (likely(!raced_pid)) {
+		INIT_LIST_HEAD(&pid->task_list);
+		atomic_set(&pid->count, 1);
+		pid->type = type;
+		pid->nr   = nr;
+		list_add(&pid->hash_chain, &pid_hash[type][pid_hashfn(nr)]);
+		return pid;
+	}
+	kmem_cache_free(pid_cache, pid);
+
+	pid = raced_pid;
+out_inc:
+	atomic_inc(&pid->count);
+	return pid;
+}
+
+int attach_pid(task_t *task, enum pid_type type, int nr)
+{
+	struct pid *pid;
+
+	if (unlikely(!check_pid(nr)))
+		BUG();
+
+	pid = get_pid(type, nr);
+	if (unlikely(!pid))
+		return -ENOMEM;
+
+	list_add(&task->pids[type].pid_chain, &pid->task_list);
+	task->pids[type].nr = nr;
+	task->pids[type].pid = pid;
+
+	return 0;
+}
+
+void detach_pid(task_t *task, enum pid_type type)
+{
+	struct pid_link *link = task->pids + type;
+	struct pid *pid = link->pid;
+	int nr;
+
+	list_del(&link->pid_chain);
+
+	if (!atomic_dec_and_test(&pid->count))
+		return;
+
+	nr = pid->nr;
+	list_del(&pid->hash_chain);
+	kmem_cache_free(pid_cache, pid);
+	for (type = 0; type < PIDTYPE_MAX; ++type)
+		if (find_pid(type, nr))
+			return;
+	free_pidmap(nr);
+}
+
+extern struct task_struct *find_task_by_pid(int nr)
+{
+	struct pid *pid = find_pid(PIDTYPE_PID, nr);
+
+	if (!pid || list_empty(&pid->task_list))
+		return NULL;
+
+	return pid_task(pid->task_list.next, PIDTYPE_PID);
+}
+
+void __init pid_init(void)
+{
+	pidmap_t *map = pidmap_array;
+
+	/*
+	 * Allocate PID 0:
+	 */
+	map->page = alloc_bootmem(PAGE_SIZE);
+	set_bit(0, map->page);
+	atomic_dec(&map->nr_free);
+}
+
+void __init pidhash_init(void)
+{
+	int i, j;
+
+	pid_cache = kmem_cache_create("pid_cache", sizeof(struct pid),
+				0, SLAB_HWCACHE_ALIGN, NULL, NULL);
+
+	for (i = 0; i < PIDTYPE_MAX; ++i)
+		for (j = 0; j < PIDHASH_SIZE; ++j)
+			INIT_LIST_HEAD(&pid_hash[i][j]);
+}
--- linux/kernel/sched.c.orig	Thu Sep 19 00:40:48 2002
+++ linux/kernel/sched.c	Thu Sep 19 00:41:21 2002
@@ -2099,6 +2099,7 @@
 {
 	runqueue_t *rq;
 	int i, j, k;
+	extern void pid_init(void);
 
 	for (i = 0; i < NR_CPUS; i++) {
 		prio_array_t *array;
@@ -2139,5 +2140,7 @@
 	 */
 	atomic_inc(&init_mm.mm_count);
 	enter_lazy_tlb(&init_mm, current, smp_processor_id());
+
+	pid_init();
 }
 
--- linux/kernel/signal.c.orig	Thu Sep 19 00:40:48 2002
+++ linux/kernel/signal.c	Thu Sep 19 01:41:03 2002
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
--- linux/kernel/sys.c.orig	Thu Sep 19 02:51:05 2002
+++ linux/kernel/sys.c	Thu Sep 19 02:55:49 2002
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
 
--- linux/kernel/fork.c.orig	Thu Sep 19 00:41:07 2002
+++ linux/kernel/fork.c	Thu Sep 19 02:52:17 2002
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
@@ -84,7 +73,6 @@
 	}
 }
 
-/* Protects next_safe and last_pid. */
 void add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
 {
 	unsigned long flags;
@@ -159,54 +147,6 @@
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
@@ -726,7 +666,13 @@
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
@@ -889,7 +835,13 @@
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
@@ -914,6 +866,8 @@
 bad_fork_cleanup_security:
 	security_ops->task_free_security(p);
 bad_fork_cleanup:
+	if (p->pid > 0)
+		free_pidmap(p->pid);
 	put_exec_domain(p->thread_info->exec_domain);
 	if (p->binfmt && p->binfmt->module)
 		__MOD_DEC_USE_COUNT(p->binfmt->module);
--- linux/kernel/ksyms.c.orig	Thu Sep 19 00:40:52 2002
+++ linux/kernel/ksyms.c	Thu Sep 19 00:41:21 2002
@@ -602,7 +602,6 @@
 EXPORT_SYMBOL(init_thread_union);
 
 EXPORT_SYMBOL(tasklist_lock);
-EXPORT_SYMBOL(pidhash);
 #if defined(CONFIG_SMP) && defined(__GENERIC_PER_CPU)
 EXPORT_SYMBOL(__per_cpu_offset);
 #endif
--- linux/init/main.c.orig	Thu Sep 19 00:40:48 2002
+++ linux/init/main.c	Thu Sep 19 00:41:21 2002
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


