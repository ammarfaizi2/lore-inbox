Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbTDMUKT (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 16:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbTDMUKT (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 16:10:19 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:14729 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261896AbTDMUKM (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Apr 2003 16:10:12 -0400
Message-ID: <3E99C6B6.5040703@colorfullife.com>
Date: Sun, 13 Apr 2003 22:21:10 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, mingo@elte.hu, maneesh@in.ibm.com,
       dipankar@in.ibm.com, viro@math.psu.edu
Subject: Re: [PATCH, RFC] tasklist_lock/dcache_lock race bugfix
References: <3E9086BB.4080403@colorfullife.com> <20030407023734.02b99056.akpm@digeo.com>
In-Reply-To: <20030407023734.02b99056.akpm@digeo.com>
Content-Type: multipart/mixed;
 boundary="------------060904080700060102030809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060904080700060102030809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

>Manfred Spraul <manfred@colorfullife.com> wrote:
>  
>
>>__unhash_process acquires the dcache_lock while holding the 
>>tasklist_lock for writing. This can deadlock. While trying to fix that 
>>race, I found further races with proc_dentry.
>>The attached patch (hopefully) fixes all these races.
>>
>>Changes:
>>- fs/proc/base.c assumed that p->pid is reset to 0 during exit. This is 
>>not the case anymore. I now look at the count of the pid structure for 
>>PIDTYPE_PID.
>>- pid_delete_dentry and pid_revalidate removed. The implementation 
>>didn't work, and noone complained.
>>- only d_add the new proc entry if the task is still valid: d_add+d_drop 
>>is a race, if a lookup happens between both calls.
>>- add a new spinlock that protects proc_dentry.
>>    
>>
>
>Did you send the correct patch?
>  
>
Yes, but my diff script was incomplete :-(

>kernel/exit.c: In function `release_task':
>kernel/exit.c:59: warning: implicit declaration of function `proc_pid_unhash'
>
Missing updates to <linux/proc_fs.h>

>kernel/exit.c:59: warning: assignment makes pointer from integer without a cast
>kernel/exit.c:86: warning: implicit declaration of function `proc_pid_flush'
>kernel/exit.c: In function `unhash_process':
>kernel/exit.c:95: warning: `proc_dentry' might be used uninitialized in this function
>
And this one is a fatal error: proc_dentry remained uninitialized, and 
that crashes during smp boot.

New patch attached.
Changelog unchanged.

--
    Manfred

--------------060904080700060102030809
Content-Type: text/plain;
 name="patch-proc_dentry-nodocu"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-proc_dentry-nodocu"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 67
//  EXTRAVERSION = -mm1
--- 2.5/include/linux/sched.h	2003-04-13 21:54:48.000000000 +0200
+++ build-2.5/include/linux/sched.h	2003-04-13 21:56:59.000000000 +0200
@@ -431,6 +431,8 @@
    	u32 self_exec_id;
 /* Protection of (de-)allocation: mm, files, fs, tty */
 	spinlock_t alloc_lock;
+/* Protection of proc_dentry: nesting proc_lock, dcache_lock, write_lock_irq(&tasklist_lock); */
+	spinlock_t proc_lock;
 /* context-switch lock */
 	spinlock_t switch_lock;
 
--- 2.5/fs/proc/base.c	2003-04-13 21:54:46.000000000 +0200
+++ build-2.5/fs/proc/base.c	2003-04-13 21:56:59.000000000 +0200
@@ -799,17 +799,11 @@
 
 /* dentry stuff */
 
-/*
- *	Exceptional case: normally we are not allowed to unhash a busy
- * directory. In this case, however, we can do it - no aliasing problems
- * due to the way we treat inodes.
- */
-static int pid_revalidate(struct dentry * dentry, int flags)
+static int pid_alive(struct task_struct *p)
 {
-	if (proc_task(dentry->d_inode)->pid)
-		return 1;
-	d_drop(dentry);
-	return 0;
+	BUG_ON(p->pids[PIDTYPE_PID].pidptr != &p->pids[PIDTYPE_PID].pid);
+
+	return atomic_read(&p->pids[PIDTYPE_PID].pid.count);
 }
 
 static int pid_fd_revalidate(struct dentry * dentry, int flags)
@@ -840,35 +834,25 @@
 static void pid_base_iput(struct dentry *dentry, struct inode *inode)
 {
 	struct task_struct *task = proc_task(inode);
-	write_lock_irq(&tasklist_lock);
+	spin_lock(&task->proc_lock);
 	if (task->proc_dentry == dentry)
 		task->proc_dentry = NULL;
-	write_unlock_irq(&tasklist_lock);
+	spin_unlock(&task->proc_lock);
 	iput(inode);
 }
 
-static int pid_delete_dentry(struct dentry * dentry)
-{
-	return proc_task(dentry->d_inode)->pid == 0;
-}
-
 static struct dentry_operations pid_fd_dentry_operations =
 {
 	.d_revalidate	= pid_fd_revalidate,
-	.d_delete	= pid_delete_dentry,
 };
 
 static struct dentry_operations pid_dentry_operations =
 {
-	.d_revalidate	= pid_revalidate,
-	.d_delete	= pid_delete_dentry,
 };
 
 static struct dentry_operations pid_base_dentry_operations =
 {
-	.d_revalidate	= pid_revalidate,
 	.d_iput		= pid_base_iput,
-	.d_delete	= pid_delete_dentry,
 };
 
 /* Lookups */
@@ -1093,6 +1077,60 @@
 	.follow_link	= proc_self_follow_link,
 };
 
+/**
+ * proc_pid_unhash -  Unhash /proc/<pid> entry from the dcache.
+ * @p: task that should be flushed.
+ *
+ * Drops the /proc/<pid> dcache entry from the hash chains.
+ *
+ * As a special exception, dropping happens even if the directory
+ * is busy. Normally we are not allowed to unhash a busy
+ * directory. In this case, however, we can do it - no aliasing problems
+ * due to the way we treat inodes. (No idea what that means - manfred)
+ *
+ * Dropping /proc/<pid> entries and detach_pid must be synchroneous,
+ * otherwise e.g. /proc/<pid>/exe might point to the wrong executable,
+ * if the pid value is immediately reused. This is enforced by
+ * - caller must acquire spin_lock(p->proc_lock)
+ * - must be called before detach_pid()
+ * - proc_pid_lookup acquires proc_lock, and checks that
+ *   the target is not dead by looking at the attach count
+ *   of PIDTYPE_PID.
+ */
+
+struct dentry *proc_pid_unhash(struct task_struct *p)
+{
+	struct dentry *proc_dentry;
+
+	proc_dentry = p->proc_dentry;
+	if (proc_dentry != NULL) {
+
+		spin_lock(&dcache_lock);
+		if (!d_unhashed(proc_dentry)) {
+			dget_locked(proc_dentry);
+			__d_drop(proc_dentry);
+		} else
+			proc_dentry = NULL;
+		spin_unlock(&dcache_lock);
+	}
+	return proc_dentry;
+}
+
+/**
+ * proc_pid_flush - recover memory used by stale /proc/<pid>/x entries
+ * @proc_entry: directoy to prune.
+ *
+ * Shrink the /proc directory that was used by the just killed thread.
+ */
+	
+void proc_pid_flush(struct dentry *proc_dentry)
+{
+	if(proc_dentry != NULL) {
+		shrink_dcache_parent(proc_dentry);
+		dput(proc_dentry);
+	}
+}
+
 /* SMP-safe */
 struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry)
 {
@@ -1141,13 +1179,16 @@
 	inode->i_flags|=S_IMMUTABLE;
 
 	dentry->d_op = &pid_base_dentry_operations;
-	d_add(dentry, inode);
-	read_lock(&tasklist_lock);
-	proc_task(dentry->d_inode)->proc_dentry = dentry;
-	read_unlock(&tasklist_lock);
-	if (!proc_task(dentry->d_inode)->pid)
-		d_drop(dentry);
-	return NULL;
+
+	spin_lock(&task->proc_lock);
+	if (pid_alive(task)) {
+		task->proc_dentry = dentry;
+		d_add(dentry, inode);
+		dentry = NULL;
+	}
+	spin_unlock(&task->proc_lock);
+	if (!dentry)
+		return NULL;
 out:
 	return ERR_PTR(-ENOENT);
 }
--- 2.5/kernel/exit.c	2003-04-13 21:54:48.000000000 +0200
+++ build-2.5/kernel/exit.c	2003-04-13 21:56:59.000000000 +0200
@@ -21,6 +21,7 @@
 #include <linux/ptrace.h>
 #include <linux/profile.h>
 #include <linux/mount.h>
+#include <linux/proc_fs.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -31,10 +32,8 @@
 
 int getrusage(struct task_struct *, int, struct rusage *);
 
-static struct dentry * __unhash_process(struct task_struct *p)
+static void __unhash_process(struct task_struct *p)
 {
-	struct dentry *proc_dentry;
-
 	nr_threads--;
 	detach_pid(p, PIDTYPE_PID);
 	detach_pid(p, PIDTYPE_TGID);
@@ -46,34 +45,25 @@
 	}
 
 	REMOVE_LINKS(p);
-	proc_dentry = p->proc_dentry;
-	if (unlikely(proc_dentry != NULL)) {
-		spin_lock(&dcache_lock);
-		if (!d_unhashed(proc_dentry)) {
-			dget_locked(proc_dentry);
-			__d_drop(proc_dentry);
-		} else
-			proc_dentry = NULL;
-		spin_unlock(&dcache_lock);
-	}
-	return proc_dentry;
 }
 
 void release_task(struct task_struct * p)
 {
-	struct dentry *proc_dentry;
 	task_t *leader;
+	struct dentry *proc_dentry;
  
 	BUG_ON(p->state < TASK_ZOMBIE);
  
 	atomic_dec(&p->user->processes);
+	spin_lock(&p->proc_lock);
+	proc_dentry = proc_pid_unhash(p);
 	write_lock_irq(&tasklist_lock);
 	if (unlikely(p->ptrace))
 		__ptrace_unlink(p);
 	BUG_ON(!list_empty(&p->ptrace_list) || !list_empty(&p->ptrace_children));
 	__exit_signal(p);
 	__exit_sighand(p);
-	proc_dentry = __unhash_process(p);
+	__unhash_process(p);
 
 	/*
 	 * If we are the last non-leader member of the thread
@@ -92,11 +82,8 @@
 	p->parent->cnswap += p->nswap + p->cnswap;
 	sched_exit(p);
 	write_unlock_irq(&tasklist_lock);
-
-	if (unlikely(proc_dentry != NULL)) {
-		shrink_dcache_parent(proc_dentry);
-		dput(proc_dentry);
-	}
+	spin_unlock(&p->proc_lock);
+	proc_pid_flush(proc_dentry);
 	release_thread(p);
 	put_task_struct(p);
 }
@@ -107,14 +94,13 @@
 {
 	struct dentry *proc_dentry;
 
+	spin_lock(&p->proc_lock);
+	proc_dentry = proc_pid_unhash(p);
 	write_lock_irq(&tasklist_lock);
-	proc_dentry = __unhash_process(p);
+	__unhash_process(p);
 	write_unlock_irq(&tasklist_lock);
-
-	if (unlikely(proc_dentry != NULL)) {
-		shrink_dcache_parent(proc_dentry);
-		dput(proc_dentry);
-	}
+	spin_unlock(&p->proc_lock);
+	proc_pid_flush(proc_dentry);
 }
 
 /*
--- 2.5/include/linux/init_task.h	2003-04-13 21:54:48.000000000 +0200
+++ build-2.5/include/linux/init_task.h	2003-04-13 21:56:59.000000000 +0200
@@ -101,6 +101,7 @@
 	.blocked	= {{0}},					\
 	 .posix_timers	 = LIST_HEAD_INIT(tsk.posix_timers),		   \
 	.alloc_lock	= SPIN_LOCK_UNLOCKED,				\
+	.proc_lock	= SPIN_LOCK_UNLOCKED,				\
 	.switch_lock	= SPIN_LOCK_UNLOCKED,				\
 	.journal_info	= NULL,						\
 }
--- 2.5/fs/exec.c	2003-04-13 21:54:43.000000000 +0200
+++ build-2.5/fs/exec.c	2003-04-13 21:56:59.000000000 +0200
@@ -528,30 +528,6 @@
 	return 0;
 }
 
-static struct dentry *clean_proc_dentry(struct task_struct *p)
-{
-	struct dentry *proc_dentry = p->proc_dentry;
-
-	if (proc_dentry) {
-		spin_lock(&dcache_lock);
-		if (!d_unhashed(proc_dentry)) {
-			dget_locked(proc_dentry);
-			__d_drop(proc_dentry);
-		} else
-			proc_dentry = NULL;
-		spin_unlock(&dcache_lock);
-	}
-	return proc_dentry;
-}
-
-static inline void put_proc_dentry(struct dentry *dentry)
-{
-	if (dentry) {
-		shrink_dcache_parent(dentry);
-		dput(dentry);
-	}
-}
-
 /*
  * This function makes sure the current process has its own signal table,
  * so that flush_signal_handlers can later reset the handlers without
@@ -659,9 +635,11 @@
 		while (leader->state != TASK_ZOMBIE)
 			yield();
 
+		task_lock(leader);
+		task_lock(current);
+		proc_dentry1 = proc_pid_unhash(current);
+		proc_dentry2 = proc_pid_unhash(leader);
 		write_lock_irq(&tasklist_lock);
-		proc_dentry1 = clean_proc_dentry(current);
-		proc_dentry2 = clean_proc_dentry(leader);
 
 		if (leader->tgid != current->tgid)
 			BUG();
@@ -701,9 +679,10 @@
 		state = leader->state;
 
 		write_unlock_irq(&tasklist_lock);
-
-		put_proc_dentry(proc_dentry1);
-		put_proc_dentry(proc_dentry2);
+		task_unlock(current);
+		task_unlock(leader);
+		proc_pid_flush(proc_dentry1);
+		proc_pid_flush(proc_dentry2);
 
 		if (state != TASK_ZOMBIE)
 			BUG();
--- 2.5/include/linux/proc_fs.h	2003-03-17 22:43:37.000000000 +0100
+++ build-2.5/include/linux/proc_fs.h	2003-04-13 21:56:59.000000000 +0200
@@ -87,6 +87,8 @@
 extern void proc_misc_init(void);
 
 struct dentry *proc_pid_lookup(struct inode *dir, struct dentry * dentry);
+struct dentry *proc_pid_unhash(struct task_struct *p);
+void proc_pid_flush(struct dentry *proc_dentry);
 int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir);
 
 extern struct proc_dir_entry *create_proc_entry(const char *name, mode_t mode,

--------------060904080700060102030809--

