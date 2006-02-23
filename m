Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751595AbWBWQQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595AbWBWQQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWBWQQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:16:26 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14231 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751595AbWBWQQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:16:25 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 12/23] proc: Rewrite the proc dentry flush on exit
 optimization.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1fymahxwr.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqwyhxua.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j7mhxs0.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biahxpd.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0aqgiyv.fsf_-_@ebiederm.dsl.xmission.com>
	<m1pslegiwg.fsf_-_@ebiederm.dsl.xmission.com>
	<m1lkw2giue.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hd6qgirv.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d5heginy.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xs2gikb.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 09:15:15 -0700
In-Reply-To: <m18xs2gikb.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 09:12:52 -0700")
Message-ID: <m14q2qgigc.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


To keep the dcache from filling up with dead /proc entries we flush
them on process exit.  However over the years that code has gotten
hairy with a dentry pointer and a lock in task_struct and
misdocumented as a correctness feature. 

I have rewritten this code to look and see if we have a corresponding
entry in the dcache and if so flush it on process exit.  This removes
the extra fields in the task_struct and allows me to trivially handle
the case of a /proc/<tgid>/task/<pid> entry as well as the current
/proc/<pid> entries. 

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/exec.c                 |    9 ---
 fs/proc/base.c            |  143 ++++++++++++++++++++++-----------------------
 include/linux/init_task.h |    1 
 include/linux/proc_fs.h   |    6 +-
 include/linux/sched.h     |    3 -
 kernel/exit.c             |   12 ----
 kernel/fork.c             |    3 -
 7 files changed, 72 insertions(+), 105 deletions(-)

8ab2fe374434b424ef579e6e8d644a2b81ec4459
diff --git a/fs/exec.c b/fs/exec.c
index fc1c7a2..8033939 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -657,7 +657,6 @@ static int de_thread(struct task_struct 
 	 */
 	if (!thread_group_leader(current)) {
 		struct task_struct *parent;
-		struct dentry *proc_dentry1, *proc_dentry2;
 		unsigned long ptrace;
 
 		/*
@@ -669,10 +668,6 @@ static int de_thread(struct task_struct 
 		while (leader->exit_state != EXIT_ZOMBIE)
 			yield();
 
-		spin_lock(&leader->proc_lock);
-		spin_lock(&current->proc_lock);
-		proc_dentry1 = proc_pid_unhash(current);
-		proc_dentry2 = proc_pid_unhash(leader);
 		write_lock_irq(&tasklist_lock);
 
 		BUG_ON(leader->tgid != current->tgid);
@@ -729,10 +724,6 @@ static int de_thread(struct task_struct 
 		leader->exit_state = EXIT_DEAD;
 
 		write_unlock_irq(&tasklist_lock);
-		spin_unlock(&leader->proc_lock);
-		spin_unlock(&current->proc_lock);
-		proc_pid_flush(proc_dentry1);
-		proc_pid_flush(proc_dentry2);
         }
 
 	/*
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4bdc859..9fab7fe 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -911,7 +911,7 @@ static int proc_check_dentry_visible(str
 	/* See if the the two tasks share a commone set of 
 	 * file descriptors.  If so everything is visible.
 	 */
-	task = get_proc_task(inode);
+	task = proc_task(inode);
 	if (!task)
 		goto out;
 	files = get_files_struct(current);
@@ -922,7 +922,6 @@ static int proc_check_dentry_visible(str
 		put_files_struct(task_files);
 	if (files)
 		put_files_struct(files);
-	put_task_struct(task);
 	if (!error)
 		goto out;
 
@@ -1291,16 +1290,6 @@ static int tid_fd_revalidate(struct dent
 	return 0;
 }
 
-static void pid_base_iput(struct dentry *dentry, struct inode *inode)
-{
-	struct task_struct *task = proc_task(inode);
-	spin_lock(&task->proc_lock);
-	if (task->proc_dentry == dentry)
-		task->proc_dentry = NULL;
-	spin_unlock(&task->proc_lock);
-	iput(inode);
-}
-
 static int pid_delete_dentry(struct dentry * dentry)
 {
 	/* Is the task we represent dead?
@@ -1322,13 +1311,6 @@ static struct dentry_operations pid_dent
 	.d_delete	= pid_delete_dentry,
 };
 
-static struct dentry_operations pid_base_dentry_operations =
-{
-	.d_revalidate	= pid_revalidate,
-	.d_iput		= pid_base_iput,
-	.d_delete	= pid_delete_dentry,
-};
-
 /* Lookups */
 
 static unsigned name_to_int(struct dentry *dentry)
@@ -1787,57 +1769,78 @@ static struct inode_operations proc_self
 };
 
 /**
- * proc_pid_unhash -  Unhash /proc/@pid entry from the dcache.
- * @p: task that should be flushed.
+ * proc_flush_task -  Remove dcache entries for @task from the /proc dcache.
+ *
+ * @task: task that should be flushed.
+ *
+ * Looks in the dcache for
+ * /proc/@pid 
+ * /proc/@tgid/task/@pid
+ * if either directory is present flushes it and all of it'ts children
+ * from the dcache.
  *
- * Drops the /proc/@pid dcache entry from the hash chains.
+ * It is safe and reasonable to cache /proc entries for a task until
+ * that task exits.  After that they just clog up the dcache with
+ * useless entries, possibly causing useful dcache entries to be
+ * flushed instead.  This routine is proved to flush those useless
+ * dcache entries at process exit time.
  *
- * Dropping /proc/@pid entries and detach_pid must be synchroneous,
- * otherwise e.g. /proc/@pid/exe might point to the wrong executable,
- * if the pid value is immediately reused. This is enforced by
- * - caller must acquire spin_lock(p->proc_lock)
- * - must be called before detach_pid()
- * - proc_pid_lookup acquires proc_lock, and checks that
- *   the target is not dead by looking at the attach count
- *   of PIDTYPE_PID.
+ * NOTE: This routine is just an optimization so it does not guarantee
+ *       that no dcache entries will exist at process exit time it
+ *       just makes it very unlikely that any will persist.
  */
-
-struct dentry *proc_pid_unhash(struct task_struct *p)
+void proc_flush_task(struct task_struct *task)
 {
-	struct dentry *proc_dentry;
+	struct dentry *dentry, *leader, *dir;
+	char buf[30];
+	struct qstr name;
+
+	name.name = buf;
+	name.len = snprintf(buf, sizeof(buf), "%d", task->pid);
+	name.hash = full_name_hash(name.name, name.len);
+
+	dentry = d_lookup(proc_mnt->mnt_root, &name);
+	if (dentry) {
+		shrink_dcache_parent(dentry);
+		d_drop(dentry);
+		dput(dentry);
+	}
+	
+	if (thread_group_leader(task))
+		goto out;
 
-	proc_dentry = p->proc_dentry;
-	if (proc_dentry != NULL) {
+	name.name = buf;
+	name.len = snprintf(buf, sizeof(buf), "%d", task->tgid);
+	name.hash = full_name_hash(name.name, name.len);
 
-		spin_lock(&dcache_lock);
-		spin_lock(&proc_dentry->d_lock);
-		if (!d_unhashed(proc_dentry)) {
-			dget_locked(proc_dentry);
-			__d_drop(proc_dentry);
-			spin_unlock(&proc_dentry->d_lock);
-		} else {
-			spin_unlock(&proc_dentry->d_lock);
-			proc_dentry = NULL;
-		}
-		spin_unlock(&dcache_lock);
-	}
-	return proc_dentry;
-}
+	leader = d_lookup(proc_mnt->mnt_root, &name);
+	if (!leader)
+		goto out;
 
-/**
- * proc_pid_flush - recover memory used by stale /proc/@pid/x entries
- * @proc_dentry: directoy to prune.
- *
- * Shrink the /proc directory that was used by the just killed thread.
- */
+	name.name = "task";
+	name.len = strlen(name.name);
+	name.hash = full_name_hash(name.name, name.len);
 	
-void proc_pid_flush(struct dentry *proc_dentry)
-{
-	might_sleep();
-	if(proc_dentry != NULL) {
-		shrink_dcache_parent(proc_dentry);
-		dput(proc_dentry);
+	dir = d_lookup(leader, &name);
+	if (!dir)
+		goto out_put_leader;
+
+	name.name = buf;
+	name.len = snprintf(buf, sizeof(buf), "%d", task->pid);
+	name.hash = full_name_hash(name.name, name.len);
+
+	dentry = d_lookup(dir, &name);
+	if (dentry) {
+		shrink_dcache_parent(dentry);
+		d_drop(dentry);
+		dput(dentry);
 	}
+	
+	dput(dir);	
+out_put_leader:
+	dput(leader);	
+out:
+	return;
 }
 
 /* SMP-safe */
@@ -1847,7 +1850,6 @@ struct dentry *proc_pid_lookup(struct in
 	struct inode *inode;
 	struct proc_inode *ei;
 	unsigned tgid;
-	int died;
 
 	if (dentry->d_name.len == 4 && !memcmp(dentry->d_name.name,"self",4)) {
 		inode = new_inode(dir->i_sb);
@@ -1893,23 +1895,16 @@ struct dentry *proc_pid_lookup(struct in
 	inode->i_nlink = 4;
 #endif
 
-	dentry->d_op = &pid_base_dentry_operations;
+	dentry->d_op = &pid_dentry_operations;
 
-	died = 0;
 	d_add(dentry, inode);
-	spin_lock(&task->proc_lock);
-	task->proc_dentry = dentry;
 	if (!pid_alive(task)) {
-		dentry = proc_pid_unhash(task);
-		died = 1;
+		d_drop(dentry);
+		shrink_dcache_parent(dentry);
+		goto out;
 	}
-	spin_unlock(&task->proc_lock);
 
 	put_task_struct(task);
-	if (died) {
-		proc_pid_flush(dentry);
-		goto out;
-	}
 	return NULL;
 out:
 	return ERR_PTR(-ENOENT);
@@ -1952,7 +1947,7 @@ static struct dentry *proc_task_lookup(s
 	inode->i_nlink = 3;
 #endif
 
-	dentry->d_op = &pid_base_dentry_operations;
+	dentry->d_op = &pid_dentry_operations;
 
 	d_add(dentry, inode);
 
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index dcfd2ec..62deb30 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -117,7 +117,6 @@ extern struct group_info init_groups;
 		.signal = {{0}}},					\
 	.blocked	= {{0}},					\
 	.alloc_lock	= SPIN_LOCK_UNLOCKED,				\
-	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
 	.cpu_timers	= INIT_CPU_TIMERS(tsk.cpu_timers),		\
 	.fs_excl	= ATOMIC_INIT(0),				\
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index cab152d..302c24e 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -97,9 +97,8 @@ extern void proc_misc_init(void);
 
 struct mm_struct;
 
+void proc_flush_task(struct task_struct *task);
 struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry, struct nameidata *);
-struct dentry *proc_pid_unhash(struct task_struct *p);
-void proc_pid_flush(struct dentry *proc_dentry);
 int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir);
 unsigned long task_vsize(struct mm_struct *);
 int task_statm(struct mm_struct *, int *, int *, int *, int *);
@@ -209,8 +208,7 @@ static inline void proc_net_remove(const
 #define proc_net_create(name, mode, info)	({ (void)(mode), NULL; })
 static inline void proc_net_remove(const char *name) {}
 
-static inline struct dentry *proc_pid_unhash(struct task_struct *p) { return NULL; }
-static inline void proc_pid_flush(struct dentry *proc_dentry) { }
+static inline void proc_flush_task(struct task_struct *task) { }
 
 static inline struct proc_dir_entry *create_proc_entry(const char *name,
 	mode_t mode, struct proc_dir_entry *parent) { return NULL; }
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b6f51e3..9fb7688 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -824,8 +824,6 @@ struct task_struct {
    	u32 self_exec_id;
 /* Protection of (de-)allocation: mm, files, fs, tty, keyrings */
 	spinlock_t alloc_lock;
-/* Protection of proc_dentry: nesting proc_lock, dcache_lock, write_lock_irq(&tasklist_lock); */
-	spinlock_t proc_lock;
 
 #ifdef CONFIG_DEBUG_MUTEXES
 	/* mutex deadlock detection */
@@ -838,7 +836,6 @@ struct task_struct {
 /* VM state */
 	struct reclaim_state *reclaim_state;
 
-	struct dentry *proc_dentry;
 	struct backing_dev_info *backing_dev_info;
 
 	struct io_context *io_context;
diff --git a/kernel/exit.c b/kernel/exit.c
index 531aadc..64956e0 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -63,12 +63,9 @@ void release_task(struct task_struct * p
 {
 	int zap_leader;
 	task_t *leader;
-	struct dentry *proc_dentry;
 
 repeat: 
 	atomic_dec(&p->user->processes);
-	spin_lock(&p->proc_lock);
-	proc_dentry = proc_pid_unhash(p);
 	write_lock_irq(&tasklist_lock);
 	if (unlikely(p->ptrace))
 		__ptrace_unlink(p);
@@ -104,8 +101,7 @@ repeat: 
 
 	sched_exit(p);
 	write_unlock_irq(&tasklist_lock);
-	spin_unlock(&p->proc_lock);
-	proc_pid_flush(proc_dentry);
+	proc_flush_task(p);
 	release_thread(p);
 	put_task_struct(p);
 
@@ -118,15 +114,9 @@ repeat: 
 
 void unhash_process(struct task_struct *p)
 {
-	struct dentry *proc_dentry;
-
-	spin_lock(&p->proc_lock);
-	proc_dentry = proc_pid_unhash(p);
 	write_lock_irq(&tasklist_lock);
 	__unhash_process(p);
 	write_unlock_irq(&tasklist_lock);
-	spin_unlock(&p->proc_lock);
-	proc_pid_flush(proc_dentry);
 }
 
 /*
diff --git a/kernel/fork.c b/kernel/fork.c
index 3f56d5a..fae6510 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -984,13 +984,10 @@ static task_t *copy_process(unsigned lon
 		if (put_user(p->pid, parent_tidptr))
 			goto bad_fork_cleanup;
 
-	p->proc_dentry = NULL;
-
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
 	p->vfork_done = NULL;
 	spin_lock_init(&p->alloc_lock);
-	spin_lock_init(&p->proc_lock);
 
 	clear_tsk_thread_flag(p, TIF_SIGPENDING);
 	init_sigpending(&p->pending);
-- 
1.2.2.g709a

