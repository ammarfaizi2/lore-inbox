Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbVJWCGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbVJWCGV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 22:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbVJWCGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 22:06:21 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:62597 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751391AbVJWCGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 22:06:20 -0400
Date: Sat, 22 Oct 2005 19:05:59 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: nikita@clusterfs.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       Roman Zippel <zippel@linux-m68k.org>, Robin Holt <holt@sgi.com>,
       Linus Torvalds <torvalds@osdl.org>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>, Christoph Lameter <clameter@sgi.com>
Message-Id: <20051023020559.16992.36386.sendpatchset@sam.engr.sgi.com>
Subject: [PATCH 01/02] cpuset remove depth counted locking hack
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a rather hackish depth counter on cpuset locking.  The depth
counter was avoiding a possible double trip on the global cpuset_sem
semaphore.  It worked, but now an improved version of cpuset locking
is available, to come in the next patch, using two global semaphores.

This patch reverses "cpuset semaphore depth check deadlock fix"

The kernel still works, even after this patch, except for some rare
and difficult to reproduce race conditions when agressively creating
and destroying cpusets marked with the notify_on_release option,
on very large systems.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |  105 +++++++++++++++++++++-----------------------------------
 1 files changed, 40 insertions(+), 65 deletions(-)

This patch applies to 2.6.14-rc4-mm1.

--- 2.6.14-rc4-mm1-cpuset-patches.orig/kernel/cpuset.c	2005-10-11 21:11:00.480263796 -0700
+++ 2.6.14-rc4-mm1-cpuset-patches/kernel/cpuset.c	2005-10-11 21:11:06.086769511 -0700
@@ -180,42 +180,6 @@ static struct super_block *cpuset_sb = N
  */
 
 static DECLARE_MUTEX(cpuset_sem);
-static struct task_struct *cpuset_sem_owner;
-static int cpuset_sem_depth;
-
-/*
- * The global cpuset semaphore cpuset_sem can be needed by the
- * memory allocator to update a tasks mems_allowed (see the calls
- * to cpuset_update_current_mems_allowed()) or to walk up the
- * cpuset hierarchy to find a mem_exclusive cpuset see the calls
- * to cpuset_excl_nodes_overlap()).
- *
- * But if the memory allocation is being done by cpuset.c code, it
- * usually already holds cpuset_sem.  Double tripping on a kernel
- * semaphore deadlocks the current task, and any other task that
- * subsequently tries to obtain the lock.
- *
- * Run all up's and down's on cpuset_sem through the following
- * wrappers, which will detect this nested locking, and avoid
- * deadlocking.
- */
-
-static inline void cpuset_down(struct semaphore *psem)
-{
-	if (cpuset_sem_owner != current) {
-		down(psem);
-		cpuset_sem_owner = current;
-	}
-	cpuset_sem_depth++;
-}
-
-static inline void cpuset_up(struct semaphore *psem)
-{
-	if (--cpuset_sem_depth == 0) {
-		cpuset_sem_owner = NULL;
-		up(psem);
-	}
-}
 
 /*
  * A couple of forward declarations required, due to cyclic reference loop:
@@ -558,10 +522,19 @@ static void guarantee_online_mems(const 
  * Refresh current tasks mems_allowed and mems_generation from
  * current tasks cpuset.  Call with cpuset_sem held.
  *
- * This routine is needed to update the per-task mems_allowed
- * data, within the tasks context, when it is trying to allocate
- * memory (in various mm/mempolicy.c routines) and notices
- * that some other task has been modifying its cpuset.
+ * Be sure to call refresh_mems() on any cpuset operation which
+ * (1) holds cpuset_sem, and (2) might possibly alloc memory.
+ * Call after obtaining cpuset_sem lock, before any possible
+ * allocation.  Otherwise one risks trying to allocate memory
+ * while the task cpuset_mems_generation is not the same as
+ * the mems_generation in its cpuset, which would deadlock on
+ * cpuset_sem in cpuset_update_current_mems_allowed().
+ *
+ * Since we hold cpuset_sem, once refresh_mems() is called, the
+ * test (current->cpuset_mems_generation != cs->mems_generation)
+ * in cpuset_update_current_mems_allowed() will remain false,
+ * until we drop cpuset_sem.  Anyone else who would change our
+ * cpusets mems_generation needs to lock cpuset_sem first.
  */
 
 static void refresh_mems(void)
@@ -867,7 +840,7 @@ static ssize_t cpuset_common_file_write(
 	}
 	buffer[nbytes] = 0;	/* nul-terminate */
 
-	cpuset_down(&cpuset_sem);
+	down(&cpuset_sem);
 
 	if (is_removed(cs)) {
 		retval = -ENODEV;
@@ -901,7 +874,7 @@ static ssize_t cpuset_common_file_write(
 	if (retval == 0)
 		retval = nbytes;
 out2:
-	cpuset_up(&cpuset_sem);
+	up(&cpuset_sem);
 	cpuset_release_agent(pathbuf);
 out1:
 	kfree(buffer);
@@ -941,9 +914,9 @@ static int cpuset_sprintf_cpulist(char *
 {
 	cpumask_t mask;
 
-	cpuset_down(&cpuset_sem);
+	down(&cpuset_sem);
 	mask = cs->cpus_allowed;
-	cpuset_up(&cpuset_sem);
+	up(&cpuset_sem);
 
 	return cpulist_scnprintf(page, PAGE_SIZE, mask);
 }
@@ -952,9 +925,9 @@ static int cpuset_sprintf_memlist(char *
 {
 	nodemask_t mask;
 
-	cpuset_down(&cpuset_sem);
+	down(&cpuset_sem);
 	mask = cs->mems_allowed;
-	cpuset_up(&cpuset_sem);
+	up(&cpuset_sem);
 
 	return nodelist_scnprintf(page, PAGE_SIZE, mask);
 }
@@ -1351,7 +1324,8 @@ static long cpuset_create(struct cpuset 
 	if (!cs)
 		return -ENOMEM;
 
-	cpuset_down(&cpuset_sem);
+	down(&cpuset_sem);
+	refresh_mems();
 	cs->flags = 0;
 	if (notify_on_release(parent))
 		set_bit(CS_NOTIFY_ON_RELEASE, &cs->flags);
@@ -1376,14 +1350,14 @@ static long cpuset_create(struct cpuset 
 	 * will down() this new directory's i_sem and if we race with
 	 * another mkdir, we might deadlock.
 	 */
-	cpuset_up(&cpuset_sem);
+	up(&cpuset_sem);
 
 	err = cpuset_populate_dir(cs->dentry);
 	/* If err < 0, we have a half-filled directory - oh well ;) */
 	return 0;
 err:
 	list_del(&cs->sibling);
-	cpuset_up(&cpuset_sem);
+	up(&cpuset_sem);
 	kfree(cs);
 	return err;
 }
@@ -1405,13 +1379,14 @@ static int cpuset_rmdir(struct inode *un
 
 	/* the vfs holds both inode->i_sem already */
 
-	cpuset_down(&cpuset_sem);
+	down(&cpuset_sem);
+	refresh_mems();
 	if (atomic_read(&cs->count) > 0) {
-		cpuset_up(&cpuset_sem);
+		up(&cpuset_sem);
 		return -EBUSY;
 	}
 	if (!list_empty(&cs->children)) {
-		cpuset_up(&cpuset_sem);
+		up(&cpuset_sem);
 		return -EBUSY;
 	}
 	parent = cs->parent;
@@ -1427,7 +1402,7 @@ static int cpuset_rmdir(struct inode *un
 	spin_unlock(&d->d_lock);
 	cpuset_d_remove_dir(d);
 	dput(d);
-	cpuset_up(&cpuset_sem);
+	up(&cpuset_sem);
 	cpuset_release_agent(pathbuf);
 	return 0;
 }
@@ -1530,10 +1505,10 @@ void cpuset_exit(struct task_struct *tsk
 	if (notify_on_release(cs)) {
 		char *pathbuf = NULL;
 
-		cpuset_down(&cpuset_sem);
+		down(&cpuset_sem);
 		if (atomic_dec_and_test(&cs->count))
 			check_for_release(cs, &pathbuf);
-		cpuset_up(&cpuset_sem);
+		up(&cpuset_sem);
 		cpuset_release_agent(pathbuf);
 	} else {
 		atomic_dec(&cs->count);
@@ -1554,11 +1529,11 @@ cpumask_t cpuset_cpus_allowed(const stru
 {
 	cpumask_t mask;
 
-	cpuset_down(&cpuset_sem);
+	down(&cpuset_sem);
 	task_lock((struct task_struct *)tsk);
 	guarantee_online_cpus(tsk->cpuset, &mask);
 	task_unlock((struct task_struct *)tsk);
-	cpuset_up(&cpuset_sem);
+	up(&cpuset_sem);
 
 	return mask;
 }
@@ -1583,9 +1558,9 @@ void cpuset_update_current_mems_allowed(
 	if (!cs)
 		return;		/* task is exiting */
 	if (current->cpuset_mems_generation != cs->mems_generation) {
-		cpuset_down(&cpuset_sem);
+		down(&cpuset_sem);
 		refresh_mems();
-		cpuset_up(&cpuset_sem);
+		up(&cpuset_sem);
 	}
 }
 
@@ -1684,14 +1659,14 @@ int cpuset_zone_allowed(struct zone *z, 
 		return 0;
 
 	/* Not hardwall and node outside mems_allowed: scan up cpusets */
-	cpuset_down(&cpuset_sem);
+	down(&cpuset_sem);
 	cs = current->cpuset;
 	if (!cs)
 		goto done;		/* current task exiting */
 	cs = nearest_exclusive_ancestor(cs);
 	allowed = node_isset(node, cs->mems_allowed);
 done:
-	cpuset_up(&cpuset_sem);
+	up(&cpuset_sem);
 	return allowed;
 }
 
@@ -1712,7 +1687,7 @@ int cpuset_excl_nodes_overlap(const stru
 	const struct cpuset *cs1, *cs2;	/* my and p's cpuset ancestors */
 	int overlap = 0;		/* do cpusets overlap? */
 
-	cpuset_down(&cpuset_sem);
+	down(&cpuset_sem);
 	cs1 = current->cpuset;
 	if (!cs1)
 		goto done;		/* current task exiting */
@@ -1723,7 +1698,7 @@ int cpuset_excl_nodes_overlap(const stru
 	cs2 = nearest_exclusive_ancestor(cs2);
 	overlap = nodes_intersects(cs1->mems_allowed, cs2->mems_allowed);
 done:
-	cpuset_up(&cpuset_sem);
+	up(&cpuset_sem);
 
 	return overlap;
 }
@@ -1746,7 +1721,7 @@ static int proc_cpuset_show(struct seq_f
 		return -ENOMEM;
 
 	tsk = m->private;
-	cpuset_down(&cpuset_sem);
+	down(&cpuset_sem);
 	task_lock(tsk);
 	cs = tsk->cpuset;
 	task_unlock(tsk);
@@ -1761,7 +1736,7 @@ static int proc_cpuset_show(struct seq_f
 	seq_puts(m, buf);
 	seq_putc(m, '\n');
 out:
-	cpuset_up(&cpuset_sem);
+	up(&cpuset_sem);
 	kfree(buf);
 	return retval;
 }

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
