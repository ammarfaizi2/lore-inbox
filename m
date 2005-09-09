Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbVIIWBa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbVIIWBa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030386AbVIIWBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:01:30 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43750 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030393AbVIIWB3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:01:29 -0400
Date: Fri, 9 Sep 2005 15:01:16 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Simon Derr <Simon.Derr@bull.net>,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20050909220116.26993.9674.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] cpuset semaphore depth check deadlock fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The cpusets-formalize-intermediate-gfp_kernel-containment patch
has a deadlock problem.

This patch was part of a set of four patches to make more
extensive use of the cpuset 'mem_exclusive' attribute to
manage kernel GFP_KERNEL memory allocations and to constrain
the out-of-memory (oom) killer.

A task that is changing cpusets in particular ways on a system
when it is very short of free memory could double trip over
the global cpuset_sem semaphore (get the lock and then deadlock
trying to get it again).

The second attempt to get cpuset_sem would be in the routine
cpuset_zone_allowed().  This was discovered by code inspection.
I can not reproduce the problem except with an artifically
hacked kernel and a specialized stress test.

In real life you cannot hit this unless you are manipulating
cpusets, and are very unlikely to hit it unless you are rapidly
modifying cpusets on a memory tight system.  Even then it would
be a rare occurence.

If you did hit it, the task double tripping over cpuset_sem
would deadlock in the kernel, and any other task also trying
to manipulate cpusets would deadlock there too, on cpuset_sem.
Your batch manager would be wedged solid (if it was cpuset
savvy), but classic Unix shells and utilities would work well
enough to reboot the system.

The unusual condition that led to this bug is that unlike most
semaphores, cpuset_sem _can_ be acquired while in the page
allocation code, when __alloc_pages() calls cpuset_zone_allowed.
So it easy to mistakenly perform the following sequence:
  1) task makes system call to alter a cpuset
  2) take cpuset_sem
  3) try to allocate memory
  4) memory allocator, via cpuset_zone_allowed, trys to take cpuset_sem
  5) deadlock

The reason that this is not a serious bug for most users
is that almost all calls to allocate memory don't require
taking cpuset_sem.  Only some code paths off the beaten
track require taking cpuset_sem -- which is good.  Taking
a global semaphore on the main code path for allocating
memory would not scale well.

This patch fixes this deadlock by wrapping the up() and down()
calls on cpuset_sem in kernel/cpuset.c with code that tracks
the nesting depth of the current task on that semaphore, and
only does the real down() if the task doesn't hold the lock
already, and only does the real up() if the nesting depth
(number of unmatched downs) is exactly one.

The previous required use of refresh_mems(), anytime that
the cpuset_sem semaphore was acquired and the code executed
while holding that semaphore might try to allocate memory, is
no longer required.  Two refresh_mems() calls were removed
thanks to this.  This is a good change, as failing to get
all the necessary refresh_mems() calls placed was a primary
source of bugs in this cpuset code.  The only remaining call
to refresh_mems() is made while doing a memory allocation,
if certain task memory placement data needs to be updated
from its cpuset, due to the cpuset having been changed behind
the tasks back.

Signed-off-by: Paul Jackson <pj@sgi.com>


Index: linux-2.6.13-mem_exclusive_oom/kernel/cpuset.c
===================================================================
--- linux-2.6.13-mem_exclusive_oom.orig/kernel/cpuset.c
+++ linux-2.6.13-mem_exclusive_oom/kernel/cpuset.c
@@ -182,6 +182,37 @@ static struct super_block *cpuset_sb = N
 static DECLARE_MUTEX(cpuset_sem);
 
 /*
+ * The global cpuset semaphore cpuset_sem can be needed by the
+ * memory allocator to update a tasks mems_allowed (see the calls
+ * to cpuset_update_current_mems_allowed()) or to walk up the
+ * cpuset hierarchy to find a mem_exclusive cpuset see the calls
+ * to cpuset_excl_nodes_overlap()).
+ *
+ * But if the memory allocation is being done by cpuset.c code, it
+ * usually already holds cpuset_sem.  Double tripping on a kernel
+ * semaphore deadlocks the current task, and any other task that
+ * subsequently tries to obtain the lock.
+ *
+ * Run all up's and down's on cpuset_sem through the following
+ * wrappers, which will detect this nested locking, and avoid
+ * deadlocking.
+ */
+
+static inline void cs_down(struct semaphore *psem)
+{
+	if (current->cpuset_sem_nest_depth == 0)
+		down(psem);
+	current->cpuset_sem_nest_depth++;
+}
+
+static inline void cs_up(struct semaphore *psem)
+{
+	current->cpuset_sem_nest_depth--;
+	if (current->cpuset_sem_nest_depth == 0)
+		up(psem);
+}
+
+/*
  * A couple of forward declarations required, due to cyclic reference loop:
  *  cpuset_mkdir -> cpuset_create -> cpuset_populate_dir -> cpuset_add_file
  *  -> cpuset_create_file -> cpuset_dir_inode_operations -> cpuset_mkdir.
@@ -522,19 +553,10 @@ static void guarantee_online_mems(const 
  * Refresh current tasks mems_allowed and mems_generation from
  * current tasks cpuset.  Call with cpuset_sem held.
  *
- * Be sure to call refresh_mems() on any cpuset operation which
- * (1) holds cpuset_sem, and (2) might possibly alloc memory.
- * Call after obtaining cpuset_sem lock, before any possible
- * allocation.  Otherwise one risks trying to allocate memory
- * while the task cpuset_mems_generation is not the same as
- * the mems_generation in its cpuset, which would deadlock on
- * cpuset_sem in cpuset_update_current_mems_allowed().
- *
- * Since we hold cpuset_sem, once refresh_mems() is called, the
- * test (current->cpuset_mems_generation != cs->mems_generation)
- * in cpuset_update_current_mems_allowed() will remain false,
- * until we drop cpuset_sem.  Anyone else who would change our
- * cpusets mems_generation needs to lock cpuset_sem first.
+ * This routine is needed to update the per-task mems_allowed
+ * data, within the tasks context, when it is trying to allocate
+ * memory (in various mm/mempolicy.c routines) and notices
+ * that some other task has been modifying its cpuset.
  */
 
 static void refresh_mems(void)
@@ -852,7 +874,7 @@ static ssize_t cpuset_common_file_write(
 	}
 	buffer[nbytes] = 0;	/* nul-terminate */
 
-	down(&cpuset_sem);
+	cs_down(&cpuset_sem);
 
 	if (is_removed(cs)) {
 		retval = -ENODEV;
@@ -886,7 +908,7 @@ static ssize_t cpuset_common_file_write(
 	if (retval == 0)
 		retval = nbytes;
 out2:
-	up(&cpuset_sem);
+	cs_up(&cpuset_sem);
 	cpuset_release_agent(pathbuf);
 out1:
 	kfree(buffer);
@@ -926,9 +948,9 @@ static int cpuset_sprintf_cpulist(char *
 {
 	cpumask_t mask;
 
-	down(&cpuset_sem);
+	cs_down(&cpuset_sem);
 	mask = cs->cpus_allowed;
-	up(&cpuset_sem);
+	cs_up(&cpuset_sem);
 
 	return cpulist_scnprintf(page, PAGE_SIZE, mask);
 }
@@ -937,9 +959,9 @@ static int cpuset_sprintf_memlist(char *
 {
 	nodemask_t mask;
 
-	down(&cpuset_sem);
+	cs_down(&cpuset_sem);
 	mask = cs->mems_allowed;
-	up(&cpuset_sem);
+	cs_up(&cpuset_sem);
 
 	return nodelist_scnprintf(page, PAGE_SIZE, mask);
 }
@@ -1342,8 +1364,7 @@ static long cpuset_create(struct cpuset 
 	if (!cs)
 		return -ENOMEM;
 
-	down(&cpuset_sem);
-	refresh_mems();
+	cs_down(&cpuset_sem);
 	cs->flags = 0;
 	if (notify_on_release(parent))
 		set_bit(CS_NOTIFY_ON_RELEASE, &cs->flags);
@@ -1368,14 +1389,14 @@ static long cpuset_create(struct cpuset 
 	 * will down() this new directory's i_sem and if we race with
 	 * another mkdir, we might deadlock.
 	 */
-	up(&cpuset_sem);
+	cs_up(&cpuset_sem);
 
 	err = cpuset_populate_dir(cs->dentry);
 	/* If err < 0, we have a half-filled directory - oh well ;) */
 	return 0;
 err:
 	list_del(&cs->sibling);
-	up(&cpuset_sem);
+	cs_up(&cpuset_sem);
 	kfree(cs);
 	return err;
 }
@@ -1397,14 +1418,13 @@ static int cpuset_rmdir(struct inode *un
 
 	/* the vfs holds both inode->i_sem already */
 
-	down(&cpuset_sem);
-	refresh_mems();
+	cs_down(&cpuset_sem);
 	if (atomic_read(&cs->count) > 0) {
-		up(&cpuset_sem);
+		cs_up(&cpuset_sem);
 		return -EBUSY;
 	}
 	if (!list_empty(&cs->children)) {
-		up(&cpuset_sem);
+		cs_up(&cpuset_sem);
 		return -EBUSY;
 	}
 	parent = cs->parent;
@@ -1420,7 +1440,7 @@ static int cpuset_rmdir(struct inode *un
 	spin_unlock(&d->d_lock);
 	cpuset_d_remove_dir(d);
 	dput(d);
-	up(&cpuset_sem);
+	cs_up(&cpuset_sem);
 	cpuset_release_agent(pathbuf);
 	return 0;
 }
@@ -1523,10 +1543,10 @@ void cpuset_exit(struct task_struct *tsk
 	if (notify_on_release(cs)) {
 		char *pathbuf = NULL;
 
-		down(&cpuset_sem);
+		cs_down(&cpuset_sem);
 		if (atomic_dec_and_test(&cs->count))
 			check_for_release(cs, &pathbuf);
-		up(&cpuset_sem);
+		cs_up(&cpuset_sem);
 		cpuset_release_agent(pathbuf);
 	} else {
 		atomic_dec(&cs->count);
@@ -1547,11 +1567,11 @@ cpumask_t cpuset_cpus_allowed(const stru
 {
 	cpumask_t mask;
 
-	down(&cpuset_sem);
+	cs_down(&cpuset_sem);
 	task_lock((struct task_struct *)tsk);
 	guarantee_online_cpus(tsk->cpuset, &mask);
 	task_unlock((struct task_struct *)tsk);
-	up(&cpuset_sem);
+	cs_up(&cpuset_sem);
 
 	return mask;
 }
@@ -1576,9 +1596,9 @@ void cpuset_update_current_mems_allowed(
 	if (!cs)
 		return;		/* task is exiting */
 	if (current->cpuset_mems_generation != cs->mems_generation) {
-		down(&cpuset_sem);
+		cs_down(&cpuset_sem);
 		refresh_mems();
-		up(&cpuset_sem);
+		cs_up(&cpuset_sem);
 	}
 }
 
@@ -1677,14 +1697,14 @@ int cpuset_zone_allowed(struct zone *z, 
 		return 0;
 
 	/* Not hardwall and node outside mems_allowed: scan up cpusets */
-	down(&cpuset_sem);
+	cs_down(&cpuset_sem);
 	cs = current->cpuset;
 	if (!cs)
 		goto done;		/* current task exiting */
 	cs = nearest_exclusive_ancestor(cs);
 	allowed = node_isset(node, cs->mems_allowed);
 done:
-	up(&cpuset_sem);
+	cs_up(&cpuset_sem);
 	return allowed;
 }
 
@@ -1705,7 +1725,7 @@ int cpuset_excl_nodes_overlap(const stru
 	const struct cpuset *cs1, *cs2;	/* my and p's cpuset ancestors */
 	int overlap = 0;		/* do cpusets overlap? */
 
-	down(&cpuset_sem);
+	cs_down(&cpuset_sem);
 	cs1 = current->cpuset;
 	if (!cs1)
 		goto done;		/* current task exiting */
@@ -1716,7 +1736,7 @@ int cpuset_excl_nodes_overlap(const stru
 	cs2 = nearest_exclusive_ancestor(cs2);
 	overlap = nodes_intersects(cs1->mems_allowed, cs2->mems_allowed);
 done:
-	up(&cpuset_sem);
+	cs_up(&cpuset_sem);
 
 	return overlap;
 }
@@ -1739,7 +1759,7 @@ static int proc_cpuset_show(struct seq_f
 		return -ENOMEM;
 
 	tsk = m->private;
-	down(&cpuset_sem);
+	cs_down(&cpuset_sem);
 	task_lock(tsk);
 	cs = tsk->cpuset;
 	task_unlock(tsk);
@@ -1754,7 +1774,7 @@ static int proc_cpuset_show(struct seq_f
 	seq_puts(m, buf);
 	seq_putc(m, '\n');
 out:
-	up(&cpuset_sem);
+	cs_up(&cpuset_sem);
 	kfree(buf);
 	return retval;
 }
Index: linux-2.6.13-mem_exclusive_oom/include/linux/sched.h
===================================================================
--- linux-2.6.13-mem_exclusive_oom.orig/include/linux/sched.h
+++ linux-2.6.13-mem_exclusive_oom/include/linux/sched.h
@@ -765,6 +765,7 @@ struct task_struct {
 	short il_next;
 #endif
 #ifdef CONFIG_CPUSETS
+	short cpuset_sem_nest_depth;
 	struct cpuset *cpuset;
 	nodemask_t mems_allowed;
 	int cpuset_mems_generation;

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
