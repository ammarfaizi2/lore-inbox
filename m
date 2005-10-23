Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbVJWCG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbVJWCG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 22:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbVJWCG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 22:06:28 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:646 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751388AbVJWCG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 22:06:27 -0400
Date: Sat, 22 Oct 2005 19:06:07 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Jackson <pj@sgi.com>, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>,
       Robin Holt <holt@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       nikita@clusterfs.com, Dave Hansen <haveblue@us.ibm.com>,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051023020607.16992.30279.sendpatchset@sam.engr.sgi.com>
In-Reply-To: <20051023020559.16992.36386.sendpatchset@sam.engr.sgi.com>
References: <20051023020559.16992.36386.sendpatchset@sam.engr.sgi.com>
Subject: [PATCH 02/02] cpuset dual semaphore locking overhaul
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Overhaul cpuset locking.  Replace single semaphore with two semaphores.

The suggestion to use two locks was made by Roman Zippel.

Both locks are global.  Code that wants to modify cpusets must first
acquire the exclusive manage_sem, which allows them read-only access to
cpusets, and holds off other would-be modifiers.  Before making actual
changes, the second semaphore, callback_sem must be acquired as well.
Code that needs only to query cpusets must acquire callback_sem,
which is also a global exclusive lock.

The earlier problems with double tripping are avoided, because it is
allowed for holders of manage_sem to nest the second callback_sem
lock, and only callback_sem is needed by code called from within
__alloc_pages(), where the double tripping had been possible.

This is not quite the same as a normal read/write semaphore, because
obtaining read-only access with intent to change must hold off other
such attempts, while allowing read-only access w/o such intention.
Changing cpusets involves several related checks and changes, which
must be done while allowing read-only queries (to avoid the double
trip), but while ensuring nothing changes (holding off other would
be modifiers.)

This overhaul of cpuset locking also makes careful use of task_lock()
to guard access to the task->cpuset pointer, closing a couple of
race conditions noticed while reading this code (thanks, Roman).
I've never seen these races fail in any use or test.

See further the comments in the code.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 include/linux/sched.h |    2 
 kernel/cpuset.c       |  416 +++++++++++++++++++++++++++++++++-----------------
 2 files changed, 281 insertions(+), 137 deletions(-)

Test built for several arch's, using crosstools.
Built, booted, cpuset regression and stress tested on ia64 SN2.
This patch applies to 2.6.14-rc4-mm1.
This patch depends on "cpuset remove depth counted locking hack"

--- 2.6.14-rc4-mm1-cpuset-patches.orig/kernel/cpuset.c	2005-10-17 23:16:21.498086142 -0700
+++ 2.6.14-rc4-mm1-cpuset-patches/kernel/cpuset.c	2005-10-17 23:17:13.136322261 -0700
@@ -60,6 +60,9 @@ struct cpuset {
 	cpumask_t cpus_allowed;		/* CPUs allowed to tasks in cpuset */
 	nodemask_t mems_allowed;	/* Memory Nodes allowed to tasks */
 
+	/*
+	 * Count is atomic so can incr (fork) or decr (exit) without a lock.
+	 */
 	atomic_t count;			/* count tasks using this cpuset */
 
 	/*
@@ -142,44 +145,91 @@ static struct vfsmount *cpuset_mount;
 static struct super_block *cpuset_sb = NULL;
 
 /*
- * cpuset_sem should be held by anyone who is depending on the children
- * or sibling lists of any cpuset, or performing non-atomic operations
- * on the flags or *_allowed values of a cpuset, such as raising the
- * CS_REMOVED flag bit iff it is not already raised, or reading and
- * conditionally modifying the *_allowed values.  One kernel global
- * cpuset semaphore should be sufficient - these things don't change
- * that much.
- *
- * The code that modifies cpusets holds cpuset_sem across the entire
- * operation, from cpuset_common_file_write() down, single threading
- * all cpuset modifications (except for counter manipulations from
- * fork and exit) across the system.  This presumes that cpuset
- * modifications are rare - better kept simple and safe, even if slow.
- *
- * The code that reads cpusets, such as in cpuset_common_file_read()
- * and below, only holds cpuset_sem across small pieces of code, such
- * as when reading out possibly multi-word cpumasks and nodemasks, as
- * the risks are less, and the desire for performance a little greater.
- * The proc_cpuset_show() routine needs to hold cpuset_sem to insure
- * that no cs->dentry is NULL, as it walks up the cpuset tree to root.
- *
- * The hooks from fork and exit, cpuset_fork() and cpuset_exit(), don't
- * (usually) grab cpuset_sem.  These are the two most performance
- * critical pieces of code here.  The exception occurs on exit(),
- * when a task in a notify_on_release cpuset exits.  Then cpuset_sem
+ * We have two global cpuset semaphores below.  They can nest.
+ * It is ok to first take manage_sem, then nest callback_sem.  We also
+ * require taking task_lock() when dereferencing a tasks cpuset pointer.
+ * See "The task_lock() exception", at the end of this comment.
+ *
+ * A task must hold both semaphores to modify cpusets.  If a task
+ * holds manage_sem, then it blocks others wanting that semaphore,
+ * ensuring that it is the only task able to also acquire callback_sem
+ * and be able to modify cpusets.  It can perform various checks on
+ * the cpuset structure first, knowing nothing will change.  It can
+ * also allocate memory while just holding manage_sem.  While it is
+ * performing these checks, various callback routines can briefly
+ * acquire callback_sem to query cpusets.  Once it is ready to make
+ * the changes, it takes callback_sem, blocking everyone else.
+ *
+ * Calls to the kernel memory allocator can not be made while holding
+ * callback_sem, as that would risk double tripping on callback_sem
+ * from one of the callbacks into the cpuset code from within
+ * __alloc_pages().
+ *
+ * If a task is only holding callback_sem, then it has read-only
+ * access to cpusets.
+ *
+ * The task_struct fields mems_allowed and mems_generation may only
+ * be accessed in the context of that task, so require no locks.
+ *
+ * Any task can increment and decrement the count field without lock.
+ * So in general, code holding manage_sem or callback_sem can't rely
+ * on the count field not changing.  However, if the count goes to
+ * zero, then only attach_task(), which holds both semaphores, can
+ * increment it again.  Because a count of zero means that no tasks
+ * are currently attached, therefore there is no way a task attached
+ * to that cpuset can fork (the other way to increment the count).
+ * So code holding manage_sem or callback_sem can safely assume that
+ * if the count is zero, it will stay zero.  Similarly, if a task
+ * holds manage_sem or callback_sem on a cpuset with zero count, it
+ * knows that the cpuset won't be removed, as cpuset_rmdir() needs
+ * both of those semaphores.
+ *
+ * A possible optimization to improve parallelism would be to make
+ * callback_sem a R/W semaphore (rwsem), allowing the callback routines
+ * to proceed in parallel, with read access, until the holder of
+ * manage_sem needed to take this rwsem for exclusive write access
+ * and modify some cpusets.
+ *
+ * The cpuset_common_file_write handler for operations that modify
+ * the cpuset hierarchy holds manage_sem across the entire operation,
+ * single threading all such cpuset modifications across the system.
+ *
+ * The cpuset_common_file_read() handlers only hold callback_sem across
+ * small pieces of code, such as when reading out possibly multi-word
+ * cpumasks and nodemasks.
+ *
+ * The fork and exit callbacks cpuset_fork() and cpuset_exit(), don't
+ * (usually) take either semaphore.  These are the two most performance
+ * critical pieces of code here.  The exception occurs on cpuset_exit(),
+ * when a task in a notify_on_release cpuset exits.  Then manage_sem
  * is taken, and if the cpuset count is zero, a usermode call made
  * to /sbin/cpuset_release_agent with the name of the cpuset (path
  * relative to the root of cpuset file system) as the argument.
  *
- * A cpuset can only be deleted if both its 'count' of using tasks is
- * zero, and its list of 'children' cpusets is empty.  Since all tasks
- * in the system use _some_ cpuset, and since there is always at least
- * one task in the system (init, pid == 1), therefore, top_cpuset
- * always has either children cpusets and/or using tasks.  So no need
- * for any special hack to ensure that top_cpuset cannot be deleted.
+ * A cpuset can only be deleted if both its 'count' of using tasks
+ * is zero, and its list of 'children' cpusets is empty.  Since all
+ * tasks in the system use _some_ cpuset, and since there is always at
+ * least one task in the system (init, pid == 1), therefore, top_cpuset
+ * always has either children cpusets and/or using tasks.  So we don't
+ * need a special hack to ensure that top_cpuset cannot be deleted.
+ *
+ * The above "Tale of Two Semaphores" would be complete, but for:
+ *
+ *	The task_lock() exception
+ *
+ * The need for this exception arises from the action of attach_task(),
+ * which overwrites one tasks cpuset pointer with another.  It does
+ * so using both semaphores, however there are several performance
+ * critical places that need to reference task->cpuset without the
+ * expense of grabbing a system global semaphore.  Therefore except as
+ * noted below, when dereferencing or, as in attach_task(), modifying
+ * a tasks cpuset pointer we use task_lock(), which acts on a spinlock
+ * (task->alloc_lock) already in the task_struct routinely used for
+ * such matters.
  */
 
-static DECLARE_MUTEX(cpuset_sem);
+static DECLARE_MUTEX(manage_sem);
+static DECLARE_MUTEX(callback_sem);
 
 /*
  * A couple of forward declarations required, due to cyclic reference loop:
@@ -354,7 +404,7 @@ static inline struct cftype *__d_cft(str
 }
 
 /*
- * Call with cpuset_sem held.  Writes path of cpuset into buf.
+ * Call with manage_sem held.  Writes path of cpuset into buf.
  * Returns 0 on success, -errno on error.
  */
 
@@ -406,10 +456,11 @@ static int cpuset_path(const struct cpus
  * status of the /sbin/cpuset_release_agent task, so no sense holding
  * our caller up for that.
  *
- * The simple act of forking that task might require more memory,
- * which might need cpuset_sem.  So this routine must be called while
- * cpuset_sem is not held, to avoid a possible deadlock.  See also
- * comments for check_for_release(), below.
+ * When we had only one cpuset semaphore, we had to call this
+ * without holding it, to avoid deadlock when call_usermodehelper()
+ * allocated memory.  With two locks, we could now call this while
+ * holding manage_sem, but we still don't, so as to minimize
+ * the time manage_sem is held.
  */
 
 static void cpuset_release_agent(const char *pathbuf)
@@ -441,15 +492,15 @@ static void cpuset_release_agent(const c
  * cs is notify_on_release() and now both the user count is zero and
  * the list of children is empty, prepare cpuset path in a kmalloc'd
  * buffer, to be returned via ppathbuf, so that the caller can invoke
- * cpuset_release_agent() with it later on, once cpuset_sem is dropped.
- * Call here with cpuset_sem held.
+ * cpuset_release_agent() with it later on, once manage_sem is dropped.
+ * Call here with manage_sem held.
  *
  * This check_for_release() routine is responsible for kmalloc'ing
  * pathbuf.  The above cpuset_release_agent() is responsible for
  * kfree'ing pathbuf.  The caller of these routines is responsible
  * for providing a pathbuf pointer, initialized to NULL, then
- * calling check_for_release() with cpuset_sem held and the address
- * of the pathbuf pointer, then dropping cpuset_sem, then calling
+ * calling check_for_release() with manage_sem held and the address
+ * of the pathbuf pointer, then dropping manage_sem, then calling
  * cpuset_release_agent() with pathbuf, as set by check_for_release().
  */
 
@@ -480,7 +531,7 @@ static void check_for_release(struct cpu
  * One way or another, we guarantee to return some non-empty subset
  * of cpu_online_map.
  *
- * Call with cpuset_sem held.
+ * Call with callback_sem held.
  */
 
 static void guarantee_online_cpus(const struct cpuset *cs, cpumask_t *pmask)
@@ -504,7 +555,7 @@ static void guarantee_online_cpus(const 
  * One way or another, we guarantee to return some non-empty subset
  * of node_online_map.
  *
- * Call with cpuset_sem held.
+ * Call with callback_sem held.
  */
 
 static void guarantee_online_mems(const struct cpuset *cs, nodemask_t *pmask)
@@ -519,31 +570,44 @@ static void guarantee_online_mems(const 
 }
 
 /*
- * Refresh current tasks mems_allowed and mems_generation from
- * current tasks cpuset.  Call with cpuset_sem held.
+ * Refresh current tasks mems_allowed and mems_generation from current
+ * tasks cpuset.
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
+ * Call without callback_sem or task_lock() held.  May be called with
+ * or without manage_sem held.  Will acquire task_lock() and might
+ * acquire callback_sem during call.
+ *
+ * The task_lock() is required to dereference current->cpuset safely.
+ * Without it, we could pick up the pointer value of current->cpuset
+ * in one instruction, and then attach_task could give us a different
+ * cpuset, and then the cpuset we had could be removed and freed,
+ * and then on our next instruction, we could dereference a no longer
+ * valid cpuset pointer to get its mems_generation field.
+ *
+ * This routine is needed to update the per-task mems_allowed data,
+ * within the tasks context, when it is trying to allocate memory
+ * (in various mm/mempolicy.c routines) and notices that some other
+ * task has been modifying its cpuset.
  */
 
 static void refresh_mems(void)
 {
-	struct cpuset *cs = current->cpuset;
+	int my_cpusets_mem_gen;
 
-	if (current->cpuset_mems_generation != cs->mems_generation) {
+	task_lock(current);
+	my_cpusets_mem_gen = current->cpuset->mems_generation;
+	task_unlock(current);
+
+	if (current->cpuset_mems_generation != my_cpusets_mem_gen) {
+		struct cpuset *cs;
+
+		down(&callback_sem);
+		task_lock(current);
+		cs = current->cpuset;
 		guarantee_online_mems(cs, &current->mems_allowed);
 		current->cpuset_mems_generation = cs->mems_generation;
+		task_unlock(current);
+		up(&callback_sem);
 	}
 }
 
@@ -552,7 +616,7 @@ static void refresh_mems(void)
  *
  * One cpuset is a subset of another if all its allowed CPUs and
  * Memory Nodes are a subset of the other, and its exclusive flags
- * are only set if the other's are set.
+ * are only set if the other's are set.  Call holding manage_sem.
  */
 
 static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
@@ -570,7 +634,7 @@ static int is_cpuset_subset(const struct
  * If we replaced the flag and mask values of the current cpuset
  * (cur) with those values in the trial cpuset (trial), would
  * our various subset and exclusive rules still be valid?  Presumes
- * cpuset_sem held.
+ * manage_sem held.
  *
  * 'cur' is the address of an actual, in-use cpuset.  Operations
  * such as list traversal that depend on the actual address of the
@@ -624,7 +688,7 @@ static int validate_change(const struct 
  *    exclusive child cpusets
  * Build these two partitions by calling partition_sched_domains
  *
- * Call with cpuset_sem held.  May nest a call to the
+ * Call with manage_sem held.  May nest a call to the
  * lock_cpu_hotplug()/unlock_cpu_hotplug() pair.
  */
 
@@ -669,6 +733,10 @@ static void update_cpu_domains(struct cp
 	unlock_cpu_hotplug();
 }
 
+/*
+ * Call with manage_sem held.  May take callback_sem during call.
+ */
+
 static int update_cpumask(struct cpuset *cs, char *buf)
 {
 	struct cpuset trialcs;
@@ -685,12 +753,18 @@ static int update_cpumask(struct cpuset 
 	if (retval < 0)
 		return retval;
 	cpus_unchanged = cpus_equal(cs->cpus_allowed, trialcs.cpus_allowed);
+	down(&callback_sem);
 	cs->cpus_allowed = trialcs.cpus_allowed;
+	up(&callback_sem);
 	if (is_cpu_exclusive(cs) && !cpus_unchanged)
 		update_cpu_domains(cs);
 	return 0;
 }
 
+/*
+ * Call with manage_sem held.  May take callback_sem during call.
+ */
+
 static int update_nodemask(struct cpuset *cs, char *buf)
 {
 	struct cpuset trialcs;
@@ -705,9 +779,11 @@ static int update_nodemask(struct cpuset
 		return -ENOSPC;
 	retval = validate_change(cs, &trialcs);
 	if (retval == 0) {
+		down(&callback_sem);
 		cs->mems_allowed = trialcs.mems_allowed;
 		atomic_inc(&cpuset_mems_generation);
 		cs->mems_generation = atomic_read(&cpuset_mems_generation);
+		up(&callback_sem);
 	}
 	return retval;
 }
@@ -718,6 +794,8 @@ static int update_nodemask(struct cpuset
  *						CS_NOTIFY_ON_RELEASE)
  * cs:	the cpuset to update
  * buf:	the buffer where we read the 0 or 1
+ *
+ * Call with manage_sem held.
  */
 
 static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs, char *buf)
@@ -739,16 +817,27 @@ static int update_flag(cpuset_flagbits_t
 		return err;
 	cpu_exclusive_changed =
 		(is_cpu_exclusive(cs) != is_cpu_exclusive(&trialcs));
+	down(&callback_sem);
 	if (turning_on)
 		set_bit(bit, &cs->flags);
 	else
 		clear_bit(bit, &cs->flags);
+	up(&callback_sem);
 
 	if (cpu_exclusive_changed)
                 update_cpu_domains(cs);
 	return 0;
 }
 
+/*
+ * Attack task specified by pid in 'pidbuf' to cpuset 'cs', possibly
+ * writing the path of the old cpuset in 'ppathbuf' if it needs to be
+ * notified on release.
+ *
+ * Call holding manage_sem.  May take callback_sem and task_lock of
+ * the task 'pid' during call.
+ */
+
 static int attach_task(struct cpuset *cs, char *pidbuf, char **ppathbuf)
 {
 	pid_t pid;
@@ -765,7 +854,7 @@ static int attach_task(struct cpuset *cs
 		read_lock(&tasklist_lock);
 
 		tsk = find_task_by_pid(pid);
-		if (!tsk) {
+		if (!tsk || tsk->flags & PF_EXITING) {
 			read_unlock(&tasklist_lock);
 			return -ESRCH;
 		}
@@ -783,10 +872,13 @@ static int attach_task(struct cpuset *cs
 		get_task_struct(tsk);
 	}
 
+	down(&callback_sem);
+
 	task_lock(tsk);
 	oldcs = tsk->cpuset;
 	if (!oldcs) {
 		task_unlock(tsk);
+		up(&callback_sem);
 		put_task_struct(tsk);
 		return -ESRCH;
 	}
@@ -797,6 +889,7 @@ static int attach_task(struct cpuset *cs
 	guarantee_online_cpus(cs, &cpus);
 	set_cpus_allowed(tsk, cpus);
 
+	up(&callback_sem);
 	put_task_struct(tsk);
 	if (atomic_dec_and_test(&oldcs->count))
 		check_for_release(oldcs, ppathbuf);
@@ -840,7 +933,7 @@ static ssize_t cpuset_common_file_write(
 	}
 	buffer[nbytes] = 0;	/* nul-terminate */
 
-	down(&cpuset_sem);
+	down(&manage_sem);
 
 	if (is_removed(cs)) {
 		retval = -ENODEV;
@@ -874,7 +967,7 @@ static ssize_t cpuset_common_file_write(
 	if (retval == 0)
 		retval = nbytes;
 out2:
-	up(&cpuset_sem);
+	up(&manage_sem);
 	cpuset_release_agent(pathbuf);
 out1:
 	kfree(buffer);
@@ -914,9 +1007,9 @@ static int cpuset_sprintf_cpulist(char *
 {
 	cpumask_t mask;
 
-	down(&cpuset_sem);
+	down(&callback_sem);
 	mask = cs->cpus_allowed;
-	up(&cpuset_sem);
+	up(&callback_sem);
 
 	return cpulist_scnprintf(page, PAGE_SIZE, mask);
 }
@@ -925,9 +1018,9 @@ static int cpuset_sprintf_memlist(char *
 {
 	nodemask_t mask;
 
-	down(&cpuset_sem);
+	down(&callback_sem);
 	mask = cs->mems_allowed;
-	up(&cpuset_sem);
+	up(&callback_sem);
 
 	return nodelist_scnprintf(page, PAGE_SIZE, mask);
 }
@@ -1135,7 +1228,9 @@ struct ctr_struct {
 
 /*
  * Load into 'pidarray' up to 'npids' of the tasks using cpuset 'cs'.
- * Return actual number of pids loaded.
+ * Return actual number of pids loaded.  No need to task_lock(p)
+ * when reading out p->cpuset, as we don't really care if it changes
+ * on the next cycle, and we are not going to try to dereference it.
  */
 static inline int pid_array_load(pid_t *pidarray, int npids, struct cpuset *cs)
 {
@@ -1177,6 +1272,12 @@ static int pid_array_to_buf(char *buf, i
 	return cnt;
 }
 
+/*
+ * Handle an open on 'tasks' file.  Prepare a buffer listing the
+ * process id's of tasks currently attached to the cpuset being opened.
+ *
+ * Does not require any specific cpuset semaphores, and does not take any.
+ */
 static int cpuset_tasks_open(struct inode *unused, struct file *file)
 {
 	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
@@ -1324,7 +1425,7 @@ static long cpuset_create(struct cpuset 
 	if (!cs)
 		return -ENOMEM;
 
-	down(&cpuset_sem);
+	down(&manage_sem);
 	refresh_mems();
 	cs->flags = 0;
 	if (notify_on_release(parent))
@@ -1339,25 +1440,27 @@ static long cpuset_create(struct cpuset 
 
 	cs->parent = parent;
 
+	down(&callback_sem);
 	list_add(&cs->sibling, &cs->parent->children);
+	up(&callback_sem);
 
 	err = cpuset_create_dir(cs, name, mode);
 	if (err < 0)
 		goto err;
 
 	/*
-	 * Release cpuset_sem before cpuset_populate_dir() because it
+	 * Release manage_sem before cpuset_populate_dir() because it
 	 * will down() this new directory's i_sem and if we race with
 	 * another mkdir, we might deadlock.
 	 */
-	up(&cpuset_sem);
+	up(&manage_sem);
 
 	err = cpuset_populate_dir(cs->dentry);
 	/* If err < 0, we have a half-filled directory - oh well ;) */
 	return 0;
 err:
 	list_del(&cs->sibling);
-	up(&cpuset_sem);
+	up(&manage_sem);
 	kfree(cs);
 	return err;
 }
@@ -1379,30 +1482,32 @@ static int cpuset_rmdir(struct inode *un
 
 	/* the vfs holds both inode->i_sem already */
 
-	down(&cpuset_sem);
+	down(&manage_sem);
 	refresh_mems();
 	if (atomic_read(&cs->count) > 0) {
-		up(&cpuset_sem);
+		up(&manage_sem);
 		return -EBUSY;
 	}
 	if (!list_empty(&cs->children)) {
-		up(&cpuset_sem);
+		up(&manage_sem);
 		return -EBUSY;
 	}
 	parent = cs->parent;
+	down(&callback_sem);
 	set_bit(CS_REMOVED, &cs->flags);
 	if (is_cpu_exclusive(cs))
 		update_cpu_domains(cs);
 	list_del(&cs->sibling);	/* delete my sibling from parent->children */
-	if (list_empty(&parent->children))
-		check_for_release(parent, &pathbuf);
 	spin_lock(&cs->dentry->d_lock);
 	d = dget(cs->dentry);
 	cs->dentry = NULL;
 	spin_unlock(&d->d_lock);
 	cpuset_d_remove_dir(d);
 	dput(d);
-	up(&cpuset_sem);
+	up(&callback_sem);
+	if (list_empty(&parent->children))
+		check_for_release(parent, &pathbuf);
+	up(&manage_sem);
 	cpuset_release_agent(pathbuf);
 	return 0;
 }
@@ -1462,16 +1567,26 @@ void __init cpuset_init_smp(void)
  * cpuset_fork - attach newly forked task to its parents cpuset.
  * @tsk: pointer to task_struct of forking parent process.
  *
- * Description: By default, on fork, a task inherits its
- * parent's cpuset.  The pointer to the shared cpuset is
- * automatically copied in fork.c by dup_task_struct().
- * This cpuset_fork() routine need only increment the usage
- * counter in that cpuset.
+ * Description: A task inherits its parent's cpuset at fork().
+ *
+ * A pointer to the shared cpuset was automatically copied in fork.c
+ * by dup_task_struct().  However, we ignore that copy, since it was
+ * not made under the protection of task_lock(), so might no longer be
+ * a valid cpuset pointer.  attach_task() might have already changed
+ * current->cpuset, allowing the previously referenced cpuset to
+ * be removed and freed.  Instead, we task_lock(current) and copy
+ * its present value of current->cpuset for our freshly forked child.
+ *
+ * At the point that cpuset_fork() is called, 'current' is the parent
+ * task, and the passed argument 'child' points to the child task.
  **/
 
-void cpuset_fork(struct task_struct *tsk)
+void cpuset_fork(struct task_struct *child)
 {
-	atomic_inc(&tsk->cpuset->count);
+	task_lock(current);
+	child->cpuset = current->cpuset;
+	atomic_inc(&child->cpuset->count);
+	task_unlock(current);
 }
 
 /**
@@ -1480,35 +1595,42 @@ void cpuset_fork(struct task_struct *tsk
  *
  * Description: Detach cpuset from @tsk and release it.
  *
- * Note that cpusets marked notify_on_release force every task
- * in them to take the global cpuset_sem semaphore when exiting.
- * This could impact scaling on very large systems.  Be reluctant
- * to use notify_on_release cpusets where very high task exit
- * scaling is required on large systems.
- *
- * Don't even think about derefencing 'cs' after the cpuset use
- * count goes to zero, except inside a critical section guarded
- * by the cpuset_sem semaphore.  If you don't hold cpuset_sem,
- * then a zero cpuset use count is a license to any other task to
- * nuke the cpuset immediately.
+ * Note that cpusets marked notify_on_release force every task in
+ * them to take the global manage_sem semaphore when exiting.
+ * This could impact scaling on very large systems.  Be reluctant to
+ * use notify_on_release cpusets where very high task exit scaling
+ * is required on large systems.
+ *
+ * Don't even think about derefencing 'cs' after the cpuset use count
+ * goes to zero, except inside a critical section guarded by manage_sem
+ * or callback_sem.   Otherwise a zero cpuset use count is a license to
+ * any other task to nuke the cpuset immediately, via cpuset_rmdir().
+ *
+ * This routine has to take manage_sem, not callback_sem, because
+ * it is holding that semaphore while calling check_for_release(),
+ * which calls kmalloc(), so can't be called holding callback__sem().
+ *
+ * We don't need to task_lock() this reference to tsk->cpuset,
+ * because tsk is already marked PF_EXITING, so attach_task() won't
+ * mess with it.
  **/
 
 void cpuset_exit(struct task_struct *tsk)
 {
 	struct cpuset *cs;
 
-	task_lock(tsk);
+	BUG_ON(!(tsk->flags & PF_EXITING));
+
 	cs = tsk->cpuset;
 	tsk->cpuset = NULL;
-	task_unlock(tsk);
 
 	if (notify_on_release(cs)) {
 		char *pathbuf = NULL;
 
-		down(&cpuset_sem);
+		down(&manage_sem);
 		if (atomic_dec_and_test(&cs->count))
 			check_for_release(cs, &pathbuf);
-		up(&cpuset_sem);
+		up(&manage_sem);
 		cpuset_release_agent(pathbuf);
 	} else {
 		atomic_dec(&cs->count);
@@ -1529,11 +1651,11 @@ cpumask_t cpuset_cpus_allowed(const stru
 {
 	cpumask_t mask;
 
-	down(&cpuset_sem);
+	down(&callback_sem);
 	task_lock((struct task_struct *)tsk);
 	guarantee_online_cpus(tsk->cpuset, &mask);
 	task_unlock((struct task_struct *)tsk);
-	up(&cpuset_sem);
+	up(&callback_sem);
 
 	return mask;
 }
@@ -1549,19 +1671,28 @@ void cpuset_init_current_mems_allowed(vo
  * If the current tasks cpusets mems_allowed changed behind our backs,
  * update current->mems_allowed and mems_generation to the new value.
  * Do not call this routine if in_interrupt().
+ *
+ * Call without callback_sem or task_lock() held.  May be called
+ * with or without manage_sem held.  Unless exiting, it will acquire
+ * task_lock().  Also might acquire callback_sem during call to
+ * refresh_mems().
  */
 
 void cpuset_update_current_mems_allowed(void)
 {
-	struct cpuset *cs = current->cpuset;
+	struct cpuset *cs;
+	int need_to_refresh = 0;
 
+	task_lock(current);
+	cs = current->cpuset;
 	if (!cs)
-		return;		/* task is exiting */
-	if (current->cpuset_mems_generation != cs->mems_generation) {
-		down(&cpuset_sem);
+		goto done;
+	if (current->cpuset_mems_generation != cs->mems_generation)
+		need_to_refresh = 1;
+done:
+	task_unlock(current);
+	if (need_to_refresh)
 		refresh_mems();
-		up(&cpuset_sem);
-	}
 }
 
 /**
@@ -1595,7 +1726,7 @@ int cpuset_zonelist_valid_mems_allowed(s
 
 /*
  * nearest_exclusive_ancestor() - Returns the nearest mem_exclusive
- * ancestor to the specified cpuset.  Call while holding cpuset_sem.
+ * ancestor to the specified cpuset.  Call holding callback_sem.
  * If no ancestor is mem_exclusive (an unusual configuration), then
  * returns the root cpuset.
  */
@@ -1622,12 +1753,12 @@ static const struct cpuset *nearest_excl
  * GFP_KERNEL allocations are not so marked, so can escape to the
  * nearest mem_exclusive ancestor cpuset.
  *
- * Scanning up parent cpusets requires cpuset_sem.  The __alloc_pages()
+ * Scanning up parent cpusets requires callback_sem.  The __alloc_pages()
  * routine only calls here with __GFP_HARDWALL bit _not_ set if
  * it's a GFP_KERNEL allocation, and all nodes in the current tasks
  * mems_allowed came up empty on the first pass over the zonelist.
  * So only GFP_KERNEL allocations, if all nodes in the cpuset are
- * short of memory, might require taking the cpuset_sem semaphore.
+ * short of memory, might require taking the callback_sem semaphore.
  *
  * The first loop over the zonelist in mm/page_alloc.c:__alloc_pages()
  * calls here with __GFP_HARDWALL always set in gfp_mask, enforcing
@@ -1659,14 +1790,16 @@ int cpuset_zone_allowed(struct zone *z, 
 		return 0;
 
 	/* Not hardwall and node outside mems_allowed: scan up cpusets */
-	down(&cpuset_sem);
-	cs = current->cpuset;
-	if (!cs)
-		goto done;		/* current task exiting */
-	cs = nearest_exclusive_ancestor(cs);
+	down(&callback_sem);
+
+	if (current->flags & PF_EXITING) /* Let dying task have memory */
+		return 1;
+	task_lock(current);
+	cs = nearest_exclusive_ancestor(current->cpuset);
+	task_unlock(current);
+
 	allowed = node_isset(node, cs->mems_allowed);
-done:
-	up(&cpuset_sem);
+	up(&callback_sem);
 	return allowed;
 }
 
@@ -1679,7 +1812,7 @@ done:
  * determine if task @p's memory usage might impact the memory
  * available to the current task.
  *
- * Acquires cpuset_sem - not suitable for calling from a fast path.
+ * Acquires callback_sem - not suitable for calling from a fast path.
  **/
 
 int cpuset_excl_nodes_overlap(const struct task_struct *p)
@@ -1687,18 +1820,27 @@ int cpuset_excl_nodes_overlap(const stru
 	const struct cpuset *cs1, *cs2;	/* my and p's cpuset ancestors */
 	int overlap = 0;		/* do cpusets overlap? */
 
-	down(&cpuset_sem);
-	cs1 = current->cpuset;
-	if (!cs1)
-		goto done;		/* current task exiting */
-	cs2 = p->cpuset;
-	if (!cs2)
-		goto done;		/* task p is exiting */
-	cs1 = nearest_exclusive_ancestor(cs1);
-	cs2 = nearest_exclusive_ancestor(cs2);
+	down(&callback_sem);
+
+	task_lock(current);
+	if (current->flags & PF_EXITING) {
+		task_unlock(current);
+		goto done;
+	}
+	cs1 = nearest_exclusive_ancestor(current->cpuset);
+	task_unlock(current);
+
+	task_lock((struct task_struct *)p);
+	if (p->flags & PF_EXITING) {
+		task_unlock((struct task_struct *)p);
+		goto done;
+	}
+	cs2 = nearest_exclusive_ancestor(p->cpuset);
+	task_unlock((struct task_struct *)p);
+
 	overlap = nodes_intersects(cs1->mems_allowed, cs2->mems_allowed);
 done:
-	up(&cpuset_sem);
+	up(&callback_sem);
 
 	return overlap;
 }
@@ -1707,6 +1849,10 @@ done:
  * proc_cpuset_show()
  *  - Print tasks cpuset path into seq_file.
  *  - Used for /proc/<pid>/cpuset.
+ *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
+ *    doesn't really matter if tsk->cpuset changes after we read it,
+ *    and we take manage_sem, keeping attach_task() from changing it
+ *    anyway.
  */
 
 static int proc_cpuset_show(struct seq_file *m, void *v)
@@ -1721,10 +1867,8 @@ static int proc_cpuset_show(struct seq_f
 		return -ENOMEM;
 
 	tsk = m->private;
-	down(&cpuset_sem);
-	task_lock(tsk);
+	down(&manage_sem);
 	cs = tsk->cpuset;
-	task_unlock(tsk);
 	if (!cs) {
 		retval = -EINVAL;
 		goto out;
@@ -1736,7 +1880,7 @@ static int proc_cpuset_show(struct seq_f
 	seq_puts(m, buf);
 	seq_putc(m, '\n');
 out:
-	up(&cpuset_sem);
+	up(&manage_sem);
 	kfree(buf);
 	return retval;
 }
--- 2.6.14-rc4-mm1-cpuset-patches.orig/include/linux/sched.h	2005-10-17 23:02:46.352856380 -0700
+++ 2.6.14-rc4-mm1-cpuset-patches/include/linux/sched.h	2005-10-17 23:17:13.183197752 -0700
@@ -1187,7 +1187,7 @@ extern void unhash_process(struct task_s
 /*
  * Protects ->fs, ->files, ->mm, ->ptrace, ->group_info, ->comm, keyring
  * subscriptions and synchronises with wait4().  Also used in procfs.  Also
- * pins the final release of task.io_context.
+ * pins the final release of task.io_context.  Also protects ->cpuset.
  *
  * Nests both inside and outside of read_lock(&tasklist_lock).
  * It must not be nested with write_lock_irq(&tasklist_lock),

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
