Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268559AbTCAOyU>; Sat, 1 Mar 2003 09:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268564AbTCAOyU>; Sat, 1 Mar 2003 09:54:20 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:42676 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S268559AbTCAOyJ>; Sat, 1 Mar 2003 09:54:09 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Andrew Morton <akpm@digeo.com>
Subject: [PATCH] tiobench on UP and ptg-D3-mm1
Date: Sat, 1 Mar 2003 10:04:49 -0500
User-Agent: KMail/1.5.9
References: <20030227025900.1205425a.akpm@digeo.com> <3E5F7DAD.2080306@cyberone.com.au> <200302282227.56311.tomlins@cam.org>
In-Reply-To: <200302282227.56311.tomlins@cam.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200303011004.49264.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

You mentioned problems with tiobench on UP.  This message was partly 
composed with this script running:

for dir in /pool{a,e,g}/tio
do
        (       cd $dir
                tiobench --size 128 --threads 16 > /dev/null 2>&1 &
        )
done
  
response was slow but usable.  Its actually a fairly good example showing 
what the ptg patch can do.  Here is a "vmstat -a 5" of the run.

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free  inact active   si   so    bi    bo   in    cs us sy id wa
 3  0  72188 255068  39132 180080    0    0     0    67 1052   621  4  3 93  0
 2  0  72188 254868  39236 180144    0    0     0    66 1062   639  5  3 92  0
39  0  72188 250604  39324 183796    0    0     2    82 1201  1163 27 13 60  0
49  0  72188 250196  39416 183924    0    0     0    65 1200  1053 92  8  0  0
52  3  72188 129660 159300 184104    0    0     0 12670 1228   782 27 73  0  0
52  2  72188  10364 275964 185144    0    0     0 16706 1304   970 16 84  0  0
58  6  74248   5292 275584 190256   13  394    21 19348 1401   925 15 85  0  0
22 29  74248   2248 277480 191160   36    0    65 19530 1543  1249 37 55  0  8
31 27  74248   2284 277472 191124    0    0    19  8378 1277   686 87 13  0  0
11 34  74248   4308 275360 191124    0    0     6  5119 1576  1174 54 19  0 28
 3 51  74248   4164 275036 191544    0    0    51  1805 1603  1005 44 11  0 45
 1 49  74248   3524 274308 192388    0    0   133  1690 1613  1694 21  9  0 69
 2 38  74248   3484 274664 193212    0    0    56  1755 1485   831  7  6  0 87
19 11  74248   3300 273792 194276    0    0   204  1741 1502   955 24  7  0 69
16  7  74248   3584 216036 252272    0    0 10351  1333 1716  1456 32 33  0 35
14 25  74248 128772 147112 196100   39    0  5041   376 1413  1565 70 29  0  1
 3 16  74248  57316 156176 259012    0    0 14367     0 1698  1393 51 49  0  0
 4  4  74248 150240  83964 238672    0    0  7649   722 1396  1096 66 34  0  0
 9  3  74248 142896  85368 244680    0    0  1466    12 1286  1053 90 10  0  0
 8  0  74248 220180  33184 219640   82    0   917    77 1263   985 86 14  0  0
 2  0  74248 270764   9512 193160    0    0     0    58 1057   665 69  6 25  0
 4  0  74248 270788   9576 193220    0    0     0    60 1056   720 15  4 81  0

This is using cfq on a k6-III 400 with 512m all impacted fs(es) are reiserfs.  

What this does is detect thread groups (where they are defined as processes sharing 
both mm and FDs or processes tagged as members of a kernel thread group) and reduces 
the timeslices given to these processes when to many processes are active in a 
group.  This allows other tasks to get cpu IF there is a demand.  There is also a 
governor set for user tasks - in this case it will not affect the test.

The patch has been tested on UP and compiles for SMP.  It should be OK on SMP.  On
numa boxes it would really benefit from a dynamic way to alloc per node storage.  
The ptgroup->active[] and user->active[] arrays should really point to atomic_t(s) 
in per node storage.

I have been using variants of this patch since the beginning of Jan - it lets me run
a java freenet server, which is heavily threaded, without it impacting my interactive
response much.

Ed Tomlinson

PS. patch applies to 2.5.63-mm1, with a little twiddling it should also be
applicable to .63 (sched.c) or .63bk (sched.c, fork.c)

--------------- 
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1026  -> 1.1028 
#	include/linux/sched.h	1.139   -> 1.140  
#	       kernel/fork.c	1.111   -> 1.113  
#	       kernel/user.c	1.8     -> 1.9    
#	      kernel/sched.c	1.164   -> 1.165  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/28	ed@oscar.et.ca	1.1027
# Add user and thread group governors to prevent either from monoplizing
# the system.  The governors work by limiting the sum of the timeslices
# of active tasks in a group to <n> timeslices.  The defaults set <n> to
# 1.5 for thread groups and to 30 for user tasks.  For numa systems the
# governors are per node.
# --------------------------------------------
#
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Fri Feb 28 07:33:49 2003
+++ b/include/linux/sched.h	Fri Feb 28 07:33:49 2003
@@ -195,6 +195,11 @@
 
 #include <linux/aio.h>
 
+struct ptg_struct {		/* pseudo thread groups */
+	atomic_t active[MAX_NUMNODES];
+        atomic_t count;         /* number of refs */
+};
+
 struct mm_struct {
 	struct vm_area_struct * mmap;		/* list of VMAs */
 	struct rb_root mm_rb;
@@ -295,6 +300,7 @@
 struct user_struct {
 	atomic_t __count;	/* reference count */
 	atomic_t processes;	/* How many processes does this user have? */
+	atomic_t active[MAX_NUMNODES];
 	atomic_t files;		/* How many open files does this user have? */
 
 	/* Hash table maintenance information */
@@ -361,6 +367,8 @@
 	struct list_head ptrace_list;
 
 	struct mm_struct *mm, *active_mm;
+	struct ptg_struct * ptgroup;		/* pseudo thread group for this task */
+	atomic_t *governor;			/* the atomic_t that governs this task */
 
 /* task state */
 	struct linux_binfmt *binfmt;
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Fri Feb 28 07:33:49 2003
+++ b/kernel/fork.c	Fri Feb 28 07:33:49 2003
@@ -72,12 +72,24 @@
 	return total;
 }
 
+void free_ptgroup(struct task_struct *tsk)
+{
+	if (tsk->ptgroup && atomic_sub_and_test(1,&tsk->ptgroup->count)) {
+                kfree(tsk->ptgroup);
+                tsk->ptgroup = NULL;
+                tsk->governor = &tsk->user->active[cpu_to_node(task_cpu(tsk))];
+                if (tsk == current)
+                        atomic_inc(tsk->governor);
+        }
+}
+
 void __put_task_struct(struct task_struct *tsk)
 {
 	WARN_ON(!(tsk->state & (TASK_DEAD | TASK_ZOMBIE)));
 	WARN_ON(atomic_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
+	free_ptgroup(tsk);
 	security_task_free(tsk);
 	free_uid(tsk->user);
 
@@ -465,6 +477,7 @@
 
 	tsk->mm = NULL;
 	tsk->active_mm = NULL;
+	tsk->ptgroup = NULL;
 
 	/*
 	 * Are we cloning a kernel thread?
@@ -730,6 +743,32 @@
 	p->flags = new_flags;
 }
 
+static inline int setup_governor(unsigned long clone_flags, struct task_struct *p)
+{
+	if ( ((clone_flags & CLONE_VM) && (clone_flags & CLONE_FILES)) ||
+	     (clone_flags & CLONE_THREAD)) {
+		if (current->ptgroup)
+			atomic_inc(&current->ptgroup->count);
+		else {
+			int i;
+			current->ptgroup = kmalloc(sizeof(struct ptg_struct), GFP_ATOMIC);
+			if (!current->ptgroup)
+				return 1;
+			/* printk(KERN_INFO "ptgroup - pid %u\n",current->pid); */
+			atomic_set(&current->ptgroup->count,2);
+			for(i=0; i < MAX_NUMNODES; i++)
+				atomic_set(&current->ptgroup->active[i], 0);
+			atomic_set(&current->ptgroup->active[numa_node_id()], 1);
+			atomic_dec(current->governor);
+			current->governor = &current->ptgroup->active[numa_node_id()];
+		}
+		p->ptgroup = current->ptgroup;
+		p->governor = &p->ptgroup->active[numa_node_id()];
+	} else
+		p->governor = &p->user->active[numa_node_id()];
+	return 0;
+}
+
 asmlinkage int sys_set_tid_address(int *tidptr)
 {
 	current->clear_child_tid = tidptr;
@@ -872,6 +911,12 @@
 		goto bad_fork_cleanup_mm;
 	retval = copy_thread(0, clone_flags, stack_start, stack_size, p, regs);
 	if (retval)
+		goto bad_fork_cleanup_namespace;
+	/*
+	 * Setup the governor pointer for the new process, allocating a new ptg as
+	 * required if the process is a thread. 
+	 */
+	if (setup_governor(clone_flags, p))
 		goto bad_fork_cleanup_namespace;
 
 	if (clone_flags & CLONE_CHILD_SETTID)
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Fri Feb 28 07:33:49 2003
+++ b/kernel/sched.c	Fri Feb 28 07:33:49 2003
@@ -69,6 +69,9 @@
 #define STARVATION_LIMIT	(2*HZ)
 #define AGRESSIVE_IDLE_STEAL	1
 #define NODE_THRESHOLD          125
+#define THREAD_GOVERNOR		15	/* allow threads groups 1.5 full timeslices */
+#define USER_GOVERNOR		300	/* allow user 30 full timeslices */
+
 
 /*
  * If a task is 'interactive' then we reinsert it in the active
@@ -124,7 +127,26 @@
 
 static inline unsigned int task_timeslice(task_t *p)
 {
-	return BASE_TIMESLICE(p);
+	int slice = BASE_TIMESLICE(p);
+	int threads = atomic_read(p->governor) * 10;
+	int govern = threads;
+	if (p->user->uid)
+		govern = (p->ptgroup) ? THREAD_GOVERNOR : USER_GOVERNOR;
+	if (threads > govern) {
+		slice = (slice * govern) / threads;
+		slice = (slice > MIN_TIMESLICE) ? slice : MIN_TIMESLICE;
+	}
+#if 1
+	{
+		static int next;
+		if (time_after(jiffies, next)) {
+			printk(KERN_INFO "uid %d pid %d nod %d ptg %x gov %x threads %d lim %d slice %d\n",
+			  p->uid, p->pid, numa_node_id(), p->ptgroup, p->governor, threads/10, govern, slice);
+			next = jiffies + HZ*300;
+		}
+	}
+#endif
+	return slice;
 }
 
 /*
@@ -251,16 +273,18 @@
 	rq->node_nr_running = &node_nr_running[0];
 }
 
-static inline void nr_running_inc(runqueue_t *rq)
+static inline void nr_running_inc(task_t *p, runqueue_t *rq)
 {
 	atomic_inc(rq->node_nr_running);
 	rq->nr_running++;
+	atomic_inc(p->governor);
 }
 
-static inline void nr_running_dec(runqueue_t *rq)
+static inline void nr_running_dec(task_t *p, runqueue_t *rq)
 {
 	atomic_dec(rq->node_nr_running);
 	rq->nr_running--;
+	atomic_dec(p->governor);
 }
 
 __init void node_nr_running_init(void)
@@ -274,8 +298,8 @@
 #else /* !CONFIG_NUMA */
 
 # define nr_running_init(rq)   do { } while (0)
-# define nr_running_inc(rq)    do { (rq)->nr_running++; } while (0)
-# define nr_running_dec(rq)    do { (rq)->nr_running--; } while (0)
+# define nr_running_inc(p, rq)    do { (rq)->nr_running++; atomic_inc((p)->governor); } while (0)
+# define nr_running_dec(p, rq)    do { (rq)->nr_running--; atomic_dec((p)->governor); } while (0)
 
 #endif /* CONFIG_NUMA */
 
@@ -380,7 +404,7 @@
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
 	enqueue_task(p, rq->active);
-	nr_running_inc(rq);
+	nr_running_inc(p, rq);
 }
 
 static inline void activate_task(task_t *p, runqueue_t *rq)
@@ -408,7 +432,7 @@
  */
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
-	nr_running_dec(rq);
+	nr_running_dec(p, rq);
 	if (p->state == TASK_UNINTERRUPTIBLE)
 		rq->nr_uninterruptible++;
 	dequeue_task(p, p->array);
@@ -1068,9 +1092,15 @@
 static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
 {
 	dequeue_task(p, src_array);
-	nr_running_dec(src_rq);
+	nr_running_dec(p, src_rq);
 	set_task_cpu(p, this_cpu);
-	nr_running_inc(this_rq);
+#ifdef CONFIG_NUMA
+        if (p->ptgroup)
+                p->governor = &p->ptgroup->active[cpu_to_node(this_cpu)];
+        else
+                p->governor = &p->user->active[cpu_to_node(this_cpu)];
+#endif
+	nr_running_inc(p, this_rq);
 	enqueue_task(p, this_rq->active);
 	wake_up_cpu(this_rq, this_cpu, p);
 }
@@ -2729,6 +2759,8 @@
 	cpu_idle_ptr(smp_processor_id()) = current;
 
 	set_task_cpu(current, smp_processor_id());
+        current->governor = &current->user->active[numa_node_id()];
+	atomic_inc(current->governor);
 	wake_up_forked_process(current);
 
 	init_timers();
diff -Nru a/kernel/user.c b/kernel/user.c
--- a/kernel/user.c	Fri Feb 28 07:33:49 2003
+++ b/kernel/user.c	Fri Feb 28 07:33:49 2003
@@ -30,6 +30,7 @@
 struct user_struct root_user = {
 	.__count	= ATOMIC_INIT(1),
 	.processes	= ATOMIC_INIT(1),
+	.active		= {[0 ...MAX_NUMNODES-1] = ATOMIC_INIT(0)},
 	.files		= ATOMIC_INIT(0)
 };
 
@@ -89,6 +90,7 @@
 
 	if (!up) {
 		struct user_struct *new;
+		int i;
 
 		new = kmem_cache_alloc(uid_cachep, SLAB_KERNEL);
 		if (!new)
@@ -96,6 +98,8 @@
 		new->uid = uid;
 		atomic_set(&new->__count, 1);
 		atomic_set(&new->processes, 0);
+		for(i=0; i < MAX_NUMNODES; i++)
+			atomic_set(&new->active[i], 0);
 		atomic_set(&new->files, 0);
 
 		/*
@@ -130,6 +134,11 @@
 	atomic_inc(&new_user->processes);
 	atomic_dec(&old_user->processes);
 	current->user = new_user;
+	if (!current->ptgroup) {
+		atomic_dec(current->governor);
+		current->governor = &current->user->active[numa_node_id()];
+		atomic_inc(current->governor);
+	}
 	free_uid(old_user);
 }
 




