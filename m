Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751127AbWALRBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbWALRBE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 12:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWALRBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 12:01:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:56286 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751127AbWALRBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 12:01:02 -0500
Date: Thu, 12 Jan 2006 09:00:34 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Arjan van de Ven <arjan@infradead.org>, simon.derr@bull.net,
       linux-kernel@vger.kernel.org, Jes Sorensen <jes@trained-monkey.org>,
       Paul Jackson <pj@sgi.com>, Ingo Molnar <mingo@elte.hu>
Message-Id: <20060112170034.22371.11823.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH v2] kernel/cpuset.c, mutex conversion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

convert cpuset.c's callback_sem and manage_sem to mutexes.
Build and boot tested by Ingo.
Build, boot, unit and stress tested by pj.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Paul Jackson <pj@sgi.com>

----

Ingo's mutex conversion of kernel/cpuset.c, with
a couple of collisions resolved.

This should apply cleanly on top of *-mm.

Be sure to apply *after* cpuset-oom-lock-fix

 kernel/cpuset.c |  196 ++++++++++++++++++++++++++++----------------------------
 1 files changed, 98 insertions(+), 98 deletions(-)

--- 2.6.15-mm2.orig/kernel/cpuset.c	2006-01-12 07:44:35.832113817 -0800
+++ 2.6.15-mm2/kernel/cpuset.c	2006-01-12 07:46:22.068680490 -0800
@@ -53,7 +53,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/atomic.h>
-#include <asm/semaphore.h>
+#include <linux/mutex.h>
 
 #define CPUSET_SUPER_MAGIC		0x27e0eb
 
@@ -169,62 +169,62 @@ static struct super_block *cpuset_sb;
 
 /*
  * We have two global cpuset semaphores below.  They can nest.
- * It is ok to first take manage_sem, then nest callback_sem.  We also
+ * It is ok to first take manage_mutex, then nest callback_mutex.  We also
  * require taking task_lock() when dereferencing a tasks cpuset pointer.
  * See "The task_lock() exception", at the end of this comment.
  *
  * A task must hold both semaphores to modify cpusets.  If a task
- * holds manage_sem, then it blocks others wanting that semaphore,
- * ensuring that it is the only task able to also acquire callback_sem
+ * holds manage_mutex, then it blocks others wanting that mutex,
+ * ensuring that it is the only task able to also acquire callback_mutex
  * and be able to modify cpusets.  It can perform various checks on
  * the cpuset structure first, knowing nothing will change.  It can
- * also allocate memory while just holding manage_sem.  While it is
+ * also allocate memory while just holding manage_mutex.  While it is
  * performing these checks, various callback routines can briefly
- * acquire callback_sem to query cpusets.  Once it is ready to make
- * the changes, it takes callback_sem, blocking everyone else.
+ * acquire callback_mutex to query cpusets.  Once it is ready to make
+ * the changes, it takes callback_mutex, blocking everyone else.
  *
  * Calls to the kernel memory allocator can not be made while holding
- * callback_sem, as that would risk double tripping on callback_sem
+ * callback_mutex, as that would risk double tripping on callback_mutex
  * from one of the callbacks into the cpuset code from within
  * __alloc_pages().
  *
- * If a task is only holding callback_sem, then it has read-only
+ * If a task is only holding callback_mutex, then it has read-only
  * access to cpusets.
  *
  * The task_struct fields mems_allowed and mems_generation may only
  * be accessed in the context of that task, so require no locks.
  *
  * Any task can increment and decrement the count field without lock.
- * So in general, code holding manage_sem or callback_sem can't rely
+ * So in general, code holding manage_mutex or callback_mutex can't rely
  * on the count field not changing.  However, if the count goes to
  * zero, then only attach_task(), which holds both semaphores, can
  * increment it again.  Because a count of zero means that no tasks
  * are currently attached, therefore there is no way a task attached
  * to that cpuset can fork (the other way to increment the count).
- * So code holding manage_sem or callback_sem can safely assume that
+ * So code holding manage_mutex or callback_mutex can safely assume that
  * if the count is zero, it will stay zero.  Similarly, if a task
- * holds manage_sem or callback_sem on a cpuset with zero count, it
+ * holds manage_mutex or callback_mutex on a cpuset with zero count, it
  * knows that the cpuset won't be removed, as cpuset_rmdir() needs
  * both of those semaphores.
  *
  * A possible optimization to improve parallelism would be to make
- * callback_sem a R/W semaphore (rwsem), allowing the callback routines
+ * callback_mutex a R/W mutex (rwsem), allowing the callback routines
  * to proceed in parallel, with read access, until the holder of
- * manage_sem needed to take this rwsem for exclusive write access
+ * manage_mutex needed to take this rwsem for exclusive write access
  * and modify some cpusets.
  *
  * The cpuset_common_file_write handler for operations that modify
- * the cpuset hierarchy holds manage_sem across the entire operation,
+ * the cpuset hierarchy holds manage_mutex across the entire operation,
  * single threading all such cpuset modifications across the system.
  *
- * The cpuset_common_file_read() handlers only hold callback_sem across
+ * The cpuset_common_file_read() handlers only hold callback_mutex across
  * small pieces of code, such as when reading out possibly multi-word
  * cpumasks and nodemasks.
  *
  * The fork and exit callbacks cpuset_fork() and cpuset_exit(), don't
- * (usually) take either semaphore.  These are the two most performance
+ * (usually) take either mutex.  These are the two most performance
  * critical pieces of code here.  The exception occurs on cpuset_exit(),
- * when a task in a notify_on_release cpuset exits.  Then manage_sem
+ * when a task in a notify_on_release cpuset exits.  Then manage_mutex
  * is taken, and if the cpuset count is zero, a usermode call made
  * to /sbin/cpuset_release_agent with the name of the cpuset (path
  * relative to the root of cpuset file system) as the argument.
@@ -244,7 +244,7 @@ static struct super_block *cpuset_sb;
  * which overwrites one tasks cpuset pointer with another.  It does
  * so using both semaphores, however there are several performance
  * critical places that need to reference task->cpuset without the
- * expense of grabbing a system global semaphore.  Therefore except as
+ * expense of grabbing a system global mutex.  Therefore except as
  * noted below, when dereferencing or, as in attach_task(), modifying
  * a tasks cpuset pointer we use task_lock(), which acts on a spinlock
  * (task->alloc_lock) already in the task_struct routinely used for
@@ -256,8 +256,8 @@ static struct super_block *cpuset_sb;
  * the routine cpuset_update_task_memory_state().
  */
 
-static DECLARE_MUTEX(manage_sem);
-static DECLARE_MUTEX(callback_sem);
+static DEFINE_MUTEX(manage_mutex);
+static DEFINE_MUTEX(callback_mutex);
 
 /*
  * A couple of forward declarations required, due to cyclic reference loop:
@@ -432,7 +432,7 @@ static inline struct cftype *__d_cft(str
 }
 
 /*
- * Call with manage_sem held.  Writes path of cpuset into buf.
+ * Call with manage_mutex held.  Writes path of cpuset into buf.
  * Returns 0 on success, -errno on error.
  */
 
@@ -484,11 +484,11 @@ static int cpuset_path(const struct cpus
  * status of the /sbin/cpuset_release_agent task, so no sense holding
  * our caller up for that.
  *
- * When we had only one cpuset semaphore, we had to call this
+ * When we had only one cpuset mutex, we had to call this
  * without holding it, to avoid deadlock when call_usermodehelper()
  * allocated memory.  With two locks, we could now call this while
- * holding manage_sem, but we still don't, so as to minimize
- * the time manage_sem is held.
+ * holding manage_mutex, but we still don't, so as to minimize
+ * the time manage_mutex is held.
  */
 
 static void cpuset_release_agent(const char *pathbuf)
@@ -520,15 +520,15 @@ static void cpuset_release_agent(const c
  * cs is notify_on_release() and now both the user count is zero and
  * the list of children is empty, prepare cpuset path in a kmalloc'd
  * buffer, to be returned via ppathbuf, so that the caller can invoke
- * cpuset_release_agent() with it later on, once manage_sem is dropped.
- * Call here with manage_sem held.
+ * cpuset_release_agent() with it later on, once manage_mutex is dropped.
+ * Call here with manage_mutex held.
  *
  * This check_for_release() routine is responsible for kmalloc'ing
  * pathbuf.  The above cpuset_release_agent() is responsible for
  * kfree'ing pathbuf.  The caller of these routines is responsible
  * for providing a pathbuf pointer, initialized to NULL, then
- * calling check_for_release() with manage_sem held and the address
- * of the pathbuf pointer, then dropping manage_sem, then calling
+ * calling check_for_release() with manage_mutex held and the address
+ * of the pathbuf pointer, then dropping manage_mutex, then calling
  * cpuset_release_agent() with pathbuf, as set by check_for_release().
  */
 
@@ -559,7 +559,7 @@ static void check_for_release(struct cpu
  * One way or another, we guarantee to return some non-empty subset
  * of cpu_online_map.
  *
- * Call with callback_sem held.
+ * Call with callback_mutex held.
  */
 
 static void guarantee_online_cpus(const struct cpuset *cs, cpumask_t *pmask)
@@ -583,7 +583,7 @@ static void guarantee_online_cpus(const 
  * One way or another, we guarantee to return some non-empty subset
  * of node_online_map.
  *
- * Call with callback_sem held.
+ * Call with callback_mutex held.
  */
 
 static void guarantee_online_mems(const struct cpuset *cs, nodemask_t *pmask)
@@ -608,12 +608,12 @@ static void guarantee_online_mems(const 
  * current->cpuset if a task has its memory placement changed.
  * Do not call this routine if in_interrupt().
  *
- * Call without callback_sem or task_lock() held.  May be called
- * with or without manage_sem held.  Doesn't need task_lock to guard
+ * Call without callback_mutex or task_lock() held.  May be called
+ * with or without manage_mutex held.  Doesn't need task_lock to guard
  * against another task changing a non-NULL cpuset pointer to NULL,
  * as that is only done by a task on itself, and if the current task
  * is here, it is not simultaneously in the exit code NULL'ing its
- * cpuset pointer.  This routine also might acquire callback_sem and
+ * cpuset pointer.  This routine also might acquire callback_mutex and
  * current->mm->mmap_sem during call.
  *
  * Reading current->cpuset->mems_generation doesn't need task_lock
@@ -658,13 +658,13 @@ void cpuset_update_task_memory_state()
 	}
 
 	if (my_cpusets_mem_gen != tsk->cpuset_mems_generation) {
-		down(&callback_sem);
+		mutex_lock(&callback_mutex);
 		task_lock(tsk);
 		cs = tsk->cpuset;	/* Maybe changed when task not locked */
 		guarantee_online_mems(cs, &tsk->mems_allowed);
 		tsk->cpuset_mems_generation = cs->mems_generation;
 		task_unlock(tsk);
-		up(&callback_sem);
+		mutex_unlock(&callback_mutex);
 		mpol_rebind_task(tsk, &tsk->mems_allowed);
 	}
 }
@@ -674,7 +674,7 @@ void cpuset_update_task_memory_state()
  *
  * One cpuset is a subset of another if all its allowed CPUs and
  * Memory Nodes are a subset of the other, and its exclusive flags
- * are only set if the other's are set.  Call holding manage_sem.
+ * are only set if the other's are set.  Call holding manage_mutex.
  */
 
 static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
@@ -692,7 +692,7 @@ static int is_cpuset_subset(const struct
  * If we replaced the flag and mask values of the current cpuset
  * (cur) with those values in the trial cpuset (trial), would
  * our various subset and exclusive rules still be valid?  Presumes
- * manage_sem held.
+ * manage_mutex held.
  *
  * 'cur' is the address of an actual, in-use cpuset.  Operations
  * such as list traversal that depend on the actual address of the
@@ -746,7 +746,7 @@ static int validate_change(const struct 
  *    exclusive child cpusets
  * Build these two partitions by calling partition_sched_domains
  *
- * Call with manage_sem held.  May nest a call to the
+ * Call with manage_mutex held.  May nest a call to the
  * lock_cpu_hotplug()/unlock_cpu_hotplug() pair.
  */
 
@@ -792,7 +792,7 @@ static void update_cpu_domains(struct cp
 }
 
 /*
- * Call with manage_sem held.  May take callback_sem during call.
+ * Call with manage_mutex held.  May take callback_mutex during call.
  */
 
 static int update_cpumask(struct cpuset *cs, char *buf)
@@ -811,9 +811,9 @@ static int update_cpumask(struct cpuset 
 	if (retval < 0)
 		return retval;
 	cpus_unchanged = cpus_equal(cs->cpus_allowed, trialcs.cpus_allowed);
-	down(&callback_sem);
+	mutex_lock(&callback_mutex);
 	cs->cpus_allowed = trialcs.cpus_allowed;
-	up(&callback_sem);
+	mutex_unlock(&callback_mutex);
 	if (is_cpu_exclusive(cs) && !cpus_unchanged)
 		update_cpu_domains(cs);
 	return 0;
@@ -827,7 +827,7 @@ static int update_cpumask(struct cpuset 
  * the cpuset is marked 'memory_migrate', migrate the tasks
  * pages to the new memory.
  *
- * Call with manage_sem held.  May take callback_sem during call.
+ * Call with manage_mutex held.  May take callback_mutex during call.
  * Will take tasklist_lock, scan tasklist for tasks in cpuset cs,
  * lock each such tasks mm->mmap_sem, scan its vma's and rebind
  * their mempolicies to the cpusets new mems_allowed.
@@ -862,11 +862,11 @@ static int update_nodemask(struct cpuset
 	if (retval < 0)
 		goto done;
 
-	down(&callback_sem);
+	mutex_lock(&callback_mutex);
 	cs->mems_allowed = trialcs.mems_allowed;
 	atomic_inc(&cpuset_mems_generation);
 	cs->mems_generation = atomic_read(&cpuset_mems_generation);
-	up(&callback_sem);
+	mutex_unlock(&callback_mutex);
 
 	set_cpuset_being_rebound(cs);		/* causes mpol_copy() rebind */
 
@@ -922,7 +922,7 @@ static int update_nodemask(struct cpuset
 	 * tasklist_lock.  Forks can happen again now - the mpol_copy()
 	 * cpuset_being_rebound check will catch such forks, and rebind
 	 * their vma mempolicies too.  Because we still hold the global
-	 * cpuset manage_sem, we know that no other rebind effort will
+	 * cpuset manage_mutex, we know that no other rebind effort will
 	 * be contending for the global variable cpuset_being_rebound.
 	 * It's ok if we rebind the same mm twice; mpol_rebind_mm()
 	 * is idempotent.  Also migrate pages in each mm to new nodes.
@@ -948,7 +948,7 @@ done:
 }
 
 /*
- * Call with manage_sem held.
+ * Call with manage_mutex held.
  */
 
 static int update_memory_pressure_enabled(struct cpuset *cs, char *buf)
@@ -967,7 +967,7 @@ static int update_memory_pressure_enable
  * cs:	the cpuset to update
  * buf:	the buffer where we read the 0 or 1
  *
- * Call with manage_sem held.
+ * Call with manage_mutex held.
  */
 
 static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs, char *buf)
@@ -989,12 +989,12 @@ static int update_flag(cpuset_flagbits_t
 		return err;
 	cpu_exclusive_changed =
 		(is_cpu_exclusive(cs) != is_cpu_exclusive(&trialcs));
-	down(&callback_sem);
+	mutex_lock(&callback_mutex);
 	if (turning_on)
 		set_bit(bit, &cs->flags);
 	else
 		clear_bit(bit, &cs->flags);
-	up(&callback_sem);
+	mutex_unlock(&callback_mutex);
 
 	if (cpu_exclusive_changed)
                 update_cpu_domains(cs);
@@ -1104,7 +1104,7 @@ static int fmeter_getrate(struct fmeter 
  * writing the path of the old cpuset in 'ppathbuf' if it needs to be
  * notified on release.
  *
- * Call holding manage_sem.  May take callback_sem and task_lock of
+ * Call holding manage_mutex.  May take callback_mutex and task_lock of
  * the task 'pid' during call.
  */
 
@@ -1144,13 +1144,13 @@ static int attach_task(struct cpuset *cs
 		get_task_struct(tsk);
 	}
 
-	down(&callback_sem);
+	mutex_lock(&callback_mutex);
 
 	task_lock(tsk);
 	oldcs = tsk->cpuset;
 	if (!oldcs) {
 		task_unlock(tsk);
-		up(&callback_sem);
+		mutex_unlock(&callback_mutex);
 		put_task_struct(tsk);
 		return -ESRCH;
 	}
@@ -1164,7 +1164,7 @@ static int attach_task(struct cpuset *cs
 	from = oldcs->mems_allowed;
 	to = cs->mems_allowed;
 
-	up(&callback_sem);
+	mutex_unlock(&callback_mutex);
 
 	mm = get_task_mm(tsk);
 	if (mm) {
@@ -1221,7 +1221,7 @@ static ssize_t cpuset_common_file_write(
 	}
 	buffer[nbytes] = 0;	/* nul-terminate */
 
-	down(&manage_sem);
+	mutex_lock(&manage_mutex);
 
 	if (is_removed(cs)) {
 		retval = -ENODEV;
@@ -1264,7 +1264,7 @@ static ssize_t cpuset_common_file_write(
 	if (retval == 0)
 		retval = nbytes;
 out2:
-	up(&manage_sem);
+	mutex_unlock(&manage_mutex);
 	cpuset_release_agent(pathbuf);
 out1:
 	kfree(buffer);
@@ -1304,9 +1304,9 @@ static int cpuset_sprintf_cpulist(char *
 {
 	cpumask_t mask;
 
-	down(&callback_sem);
+	mutex_lock(&callback_mutex);
 	mask = cs->cpus_allowed;
-	up(&callback_sem);
+	mutex_unlock(&callback_mutex);
 
 	return cpulist_scnprintf(page, PAGE_SIZE, mask);
 }
@@ -1315,9 +1315,9 @@ static int cpuset_sprintf_memlist(char *
 {
 	nodemask_t mask;
 
-	down(&callback_sem);
+	mutex_lock(&callback_mutex);
 	mask = cs->mems_allowed;
-	up(&callback_sem);
+	mutex_unlock(&callback_mutex);
 
 	return nodelist_scnprintf(page, PAGE_SIZE, mask);
 }
@@ -1754,7 +1754,7 @@ static int cpuset_populate_dir(struct de
  *	name:		name of the new cpuset. Will be strcpy'ed.
  *	mode:		mode to set on new inode
  *
- *	Must be called with the semaphore on the parent inode held
+ *	Must be called with the mutex on the parent inode held
  */
 
 static long cpuset_create(struct cpuset *parent, const char *name, int mode)
@@ -1766,7 +1766,7 @@ static long cpuset_create(struct cpuset 
 	if (!cs)
 		return -ENOMEM;
 
-	down(&manage_sem);
+	mutex_lock(&manage_mutex);
 	cpuset_update_task_memory_state();
 	cs->flags = 0;
 	if (notify_on_release(parent))
@@ -1782,28 +1782,28 @@ static long cpuset_create(struct cpuset 
 
 	cs->parent = parent;
 
-	down(&callback_sem);
+	mutex_lock(&callback_mutex);
 	list_add(&cs->sibling, &cs->parent->children);
 	number_of_cpusets++;
-	up(&callback_sem);
+	mutex_unlock(&callback_mutex);
 
 	err = cpuset_create_dir(cs, name, mode);
 	if (err < 0)
 		goto err;
 
 	/*
-	 * Release manage_sem before cpuset_populate_dir() because it
+	 * Release manage_mutex before cpuset_populate_dir() because it
 	 * will mutex_lock() this new directory's i_mutex and if we race with
 	 * another mkdir, we might deadlock.
 	 */
-	up(&manage_sem);
+	mutex_unlock(&manage_mutex);
 
 	err = cpuset_populate_dir(cs->dentry);
 	/* If err < 0, we have a half-filled directory - oh well ;) */
 	return 0;
 err:
 	list_del(&cs->sibling);
-	up(&manage_sem);
+	mutex_unlock(&manage_mutex);
 	kfree(cs);
 	return err;
 }
@@ -1825,18 +1825,18 @@ static int cpuset_rmdir(struct inode *un
 
 	/* the vfs holds both inode->i_mutex already */
 
-	down(&manage_sem);
+	mutex_lock(&manage_mutex);
 	cpuset_update_task_memory_state();
 	if (atomic_read(&cs->count) > 0) {
-		up(&manage_sem);
+		mutex_unlock(&manage_mutex);
 		return -EBUSY;
 	}
 	if (!list_empty(&cs->children)) {
-		up(&manage_sem);
+		mutex_unlock(&manage_mutex);
 		return -EBUSY;
 	}
 	parent = cs->parent;
-	down(&callback_sem);
+	mutex_lock(&callback_mutex);
 	set_bit(CS_REMOVED, &cs->flags);
 	if (is_cpu_exclusive(cs))
 		update_cpu_domains(cs);
@@ -1848,10 +1848,10 @@ static int cpuset_rmdir(struct inode *un
 	cpuset_d_remove_dir(d);
 	dput(d);
 	number_of_cpusets--;
-	up(&callback_sem);
+	mutex_unlock(&callback_mutex);
 	if (list_empty(&parent->children))
 		check_for_release(parent, &pathbuf);
-	up(&manage_sem);
+	mutex_unlock(&manage_mutex);
 	cpuset_release_agent(pathbuf);
 	return 0;
 }
@@ -1960,18 +1960,18 @@ void cpuset_fork(struct task_struct *chi
  * Description: Detach cpuset from @tsk and release it.
  *
  * Note that cpusets marked notify_on_release force every task in
- * them to take the global manage_sem semaphore when exiting.
+ * them to take the global manage_mutex mutex when exiting.
  * This could impact scaling on very large systems.  Be reluctant to
  * use notify_on_release cpusets where very high task exit scaling
  * is required on large systems.
  *
  * Don't even think about derefencing 'cs' after the cpuset use count
- * goes to zero, except inside a critical section guarded by manage_sem
- * or callback_sem.   Otherwise a zero cpuset use count is a license to
+ * goes to zero, except inside a critical section guarded by manage_mutex
+ * or callback_mutex.   Otherwise a zero cpuset use count is a license to
  * any other task to nuke the cpuset immediately, via cpuset_rmdir().
  *
- * This routine has to take manage_sem, not callback_sem, because
- * it is holding that semaphore while calling check_for_release(),
+ * This routine has to take manage_mutex, not callback_mutex, because
+ * it is holding that mutex while calling check_for_release(),
  * which calls kmalloc(), so can't be called holding callback__sem().
  *
  * We don't need to task_lock() this reference to tsk->cpuset,
@@ -1989,10 +1989,10 @@ void cpuset_exit(struct task_struct *tsk
 	if (notify_on_release(cs)) {
 		char *pathbuf = NULL;
 
-		down(&manage_sem);
+		mutex_lock(&manage_mutex);
 		if (atomic_dec_and_test(&cs->count))
 			check_for_release(cs, &pathbuf);
-		up(&manage_sem);
+		mutex_unlock(&manage_mutex);
 		cpuset_release_agent(pathbuf);
 	} else {
 		atomic_dec(&cs->count);
@@ -2013,11 +2013,11 @@ cpumask_t cpuset_cpus_allowed(struct tas
 {
 	cpumask_t mask;
 
-	down(&callback_sem);
+	mutex_lock(&callback_mutex);
 	task_lock(tsk);
 	guarantee_online_cpus(tsk->cpuset, &mask);
 	task_unlock(tsk);
-	up(&callback_sem);
+	mutex_unlock(&callback_mutex);
 
 	return mask;
 }
@@ -2041,11 +2041,11 @@ nodemask_t cpuset_mems_allowed(struct ta
 {
 	nodemask_t mask;
 
-	down(&callback_sem);
+	mutex_lock(&callback_mutex);
 	task_lock(tsk);
 	guarantee_online_mems(tsk->cpuset, &mask);
 	task_unlock(tsk);
-	up(&callback_sem);
+	mutex_unlock(&callback_mutex);
 
 	return mask;
 }
@@ -2071,7 +2071,7 @@ int cpuset_zonelist_valid_mems_allowed(s
 
 /*
  * nearest_exclusive_ancestor() - Returns the nearest mem_exclusive
- * ancestor to the specified cpuset.  Call holding callback_sem.
+ * ancestor to the specified cpuset.  Call holding callback_mutex.
  * If no ancestor is mem_exclusive (an unusual configuration), then
  * returns the root cpuset.
  */
@@ -2098,12 +2098,12 @@ static const struct cpuset *nearest_excl
  * GFP_KERNEL allocations are not so marked, so can escape to the
  * nearest mem_exclusive ancestor cpuset.
  *
- * Scanning up parent cpusets requires callback_sem.  The __alloc_pages()
+ * Scanning up parent cpusets requires callback_mutex.  The __alloc_pages()
  * routine only calls here with __GFP_HARDWALL bit _not_ set if
  * it's a GFP_KERNEL allocation, and all nodes in the current tasks
  * mems_allowed came up empty on the first pass over the zonelist.
  * So only GFP_KERNEL allocations, if all nodes in the cpuset are
- * short of memory, might require taking the callback_sem semaphore.
+ * short of memory, might require taking the callback_mutex mutex.
  *
  * The first loop over the zonelist in mm/page_alloc.c:__alloc_pages()
  * calls here with __GFP_HARDWALL always set in gfp_mask, enforcing
@@ -2138,31 +2138,31 @@ int __cpuset_zone_allowed(struct zone *z
 		return 1;
 
 	/* Not hardwall and node outside mems_allowed: scan up cpusets */
-	down(&callback_sem);
+	mutex_lock(&callback_mutex);
 
 	task_lock(current);
 	cs = nearest_exclusive_ancestor(current->cpuset);
 	task_unlock(current);
 
 	allowed = node_isset(node, cs->mems_allowed);
-	up(&callback_sem);
+	mutex_unlock(&callback_mutex);
 	return allowed;
 }
 
 /**
  * cpuset_lock - lock out any changes to cpuset structures
  *
- * The out of memory (oom) code needs to lock down cpusets
+ * The out of memory (oom) code needs to mutex_lock cpusets
  * from being changed while it scans the tasklist looking for a
- * task in an overlapping cpuset.  Expose callback_sem via this
+ * task in an overlapping cpuset.  Expose callback_mutex via this
  * cpuset_lock() routine, so the oom code can lock it, before
  * locking the task list.  The tasklist_lock is a spinlock, so
- * must be taken inside callback_sem.
+ * must be taken inside callback_mutex.
  */
 
 void cpuset_lock(void)
 {
-	down(&callback_sem);
+	mutex_lock(&callback_mutex);
 }
 
 /**
@@ -2173,7 +2173,7 @@ void cpuset_lock(void)
 
 void cpuset_unlock(void)
 {
-	up(&callback_sem);
+	mutex_unlock(&callback_mutex);
 }
 
 /**
@@ -2185,7 +2185,7 @@ void cpuset_unlock(void)
  * determine if task @p's memory usage might impact the memory
  * available to the current task.
  *
- * Call while holding callback_sem.
+ * Call while holding callback_mutex.
  **/
 
 int cpuset_excl_nodes_overlap(const struct task_struct *p)
@@ -2256,7 +2256,7 @@ void __cpuset_memory_pressure_bump(void)
  *  - Used for /proc/<pid>/cpuset.
  *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
  *    doesn't really matter if tsk->cpuset changes after we read it,
- *    and we take manage_sem, keeping attach_task() from changing it
+ *    and we take manage_mutex, keeping attach_task() from changing it
  *    anyway.
  */
 
@@ -2272,7 +2272,7 @@ static int proc_cpuset_show(struct seq_f
 		return -ENOMEM;
 
 	tsk = m->private;
-	down(&manage_sem);
+	mutex_lock(&manage_mutex);
 	cs = tsk->cpuset;
 	if (!cs) {
 		retval = -EINVAL;
@@ -2285,7 +2285,7 @@ static int proc_cpuset_show(struct seq_f
 	seq_puts(m, buf);
 	seq_putc(m, '\n');
 out:
-	up(&manage_sem);
+	mutex_unlock(&manage_mutex);
 	kfree(buf);
 	return retval;
 }

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
