Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751620AbWBWQWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbWBWQWK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbWBWQWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:22:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21655 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751620AbWBWQWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:22:08 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 15/23] proc: refactor reading directories of tasks.
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
	<m14q2qgigc.fsf_-_@ebiederm.dsl.xmission.com>
	<m1zmkif3t8.fsf_-_@ebiederm.dsl.xmission.com>
	<m1vev6f3q3.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 09:20:59 -0700
In-Reply-To: <m1vev6f3q3.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 09:18:44 -0700")
Message-ID: <m1r75uf3mc.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



There are a couple of problems this patch addresses.
- /proc/<tgid>/task currently does not work correctly if you stop reading
  in the middle of a directory.

- /proc/ currently requires a full pass through the task list with
  the tasklist lock held, to determine there are no more processes to read.

- The hand rolled integer to string conversion does not properly handle
  running out of buffer space.

- We seem to be batching reading of pids from the tasklist without reason,
  and complicating the logic of the code.

This patch addresses that by changing how tasks are processed.  A
first_<task_type> function is built that handles restarts, and a
next_<task_type> function is built that just advances to the next
task.

first_<task_type> when it detects a restart usually uses
find_task_by_pid.  If that doesn't work because there has been
a seek on the directory, or we have already given a complete
directory listing, it first checks the number tasks of that
type, and only if we are under that count does it walk through
all of the tasks to find the one we are interested in.

The code that fills in the directory is simpler because there is
only a single for loop.

The hand rolled integer to string conversion is replaced by snprintf
which should handle the the out of buffer case correctly.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c |  285 ++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 174 insertions(+), 111 deletions(-)

fa086d704f447a54a1f3566471d8a32f173701af
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 1ab12e5..f507887 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1479,8 +1479,6 @@ static struct file_operations proc_tgid_
 static struct inode_operations proc_tgid_attr_inode_operations;
 #endif
 
-static int get_tid_list(int index, unsigned int *tids, struct inode *dir);
-
 /* SMP-safe */
 static struct dentry *proc_pident_lookup(struct inode *dir, 
 					 struct dentry *dentry,
@@ -1964,89 +1962,89 @@ out:
 	return result;
 }
 
-#define PROC_MAXPIDS 20
-
 /*
- * Get a few tgid's to return for filldir - we need to hold the
- * tasklist lock while doing this, and we must release it before
- * we actually do the filldir itself, so we use a temp buffer..
+ * Find the first tgid to return to user space.
+ *
+ * Usually this is just whatever follows &init_task, but if the users
+ * buffer was too small to hold the full list or there was a seek into
+ * the middle of the directory we have more work to do.
+ *
+ * In the case of a short read we start with find_task_by_pid.
+ * 
+ * In the case of a seek we start with &init_task and walk nr
+ * threads past it.
  */
-static int get_tgid_list(int index, unsigned long version, unsigned int *tgids)
+static struct task_struct *first_tgid(int tgid, int nr)
 {
-	struct task_struct *p;
-	int nr_tgids = 0;
-
-	index--;
+	struct task_struct *pos = NULL;
 	read_lock(&tasklist_lock);
-	p = NULL;
-	if (version) {
-		p = find_task_by_pid(version);
-		if (p && !thread_group_leader(p))
-			p = NULL;
-	}
+	if (tgid && nr) {
+		pos = find_task_by_pid(tgid);
+		if (pos && !thread_group_leader(pos))
+			pos = NULL;
+		if (pos)
+			nr = 0;
+	}
+	/* If nr exceeds the number of processes get out quickly */
+	if (nr && nr >= nr_processes())
+		goto done;
 
-	if (p)
-		index = 0;
-	else
-		p = next_task(&init_task);
+	/* If we haven't found our starting place yet start with
+	 * the init_task and walk nr tasks forward.
+	 */
+	if (!pos && (nr >= 0))
+		pos = next_task(&init_task);
 
-	for ( ; p != &init_task; p = next_task(p)) {
-		int tgid = p->pid;
-		if (!pid_alive(p))
-			continue;
-		if (--index >= 0)
+	/* The pid_alive test serves two purposes.
+	 * - The first is to verify the task is actually valid.
+	 * - The second is to ensure we don't go around the list
+	 *   of processes more than once.  pid_alive always
+	 *   fails for init_task as it has pid == 0 and is unhashed.
+	 */
+	for (; pos && pid_alive(pos); pos = next_task(pos)) {
+		if (--nr > 0)
 			continue;
-		tgids[nr_tgids] = tgid;
-		nr_tgids++;
-		if (nr_tgids >= PROC_MAXPIDS)
-			break;
+		get_task_struct(pos);
+		goto done;
 	}
+	pos = NULL;
+done:
 	read_unlock(&tasklist_lock);
-	return nr_tgids;
+	return pos;
 }
 
-/*
- * Get a few tid's to return for filldir - we need to hold the
- * tasklist lock while doing this, and we must release it before
- * we actually do the filldir itself, so we use a temp buffer..
+/* 
+ * Find the next task in the task list.
+ * Return NULL if we loop or there is any error.
+ *
+ * The reference to the input task_struct is released.
  */
-static int get_tid_list(int index, unsigned int *tids, struct inode *dir)
+static struct task_struct *next_tgid(struct task_struct *start)
 {
-	struct task_struct *leader_task = proc_task(dir);
-	struct task_struct *task = leader_task;
-	int nr_tids = 0;
-
-	index -= 2;
+	struct task_struct *pos;
 	read_lock(&tasklist_lock);
-	/*
-	 * The starting point task (leader_task) might be an already
-	 * unlinked task, which cannot be used to access the task-list
-	 * via next_thread().
-	 */
-	if (pid_alive(task)) do {
-		int tid = task->pid;
-
-		if (--index >= 0)
-			continue;
-		if (tids != NULL)
-			tids[nr_tids] = tid;
-		nr_tids++;
-		if (nr_tids >= PROC_MAXPIDS)
-			break;
-	} while ((task = next_thread(task)) != leader_task);
+	pos = start;
+	if (pid_alive(start))
+		pos = next_task(start);
+	if (pid_alive(pos)) {
+		get_task_struct(pos);
+		goto done;
+	}
+	pos = NULL;
+done:		
 	read_unlock(&tasklist_lock);
-	return nr_tids;
+	put_task_struct(start);
+	return pos;
 }
 
 /* for the /proc/ directory itself, after non-process stuff has been done */
 int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
-	unsigned int tgid_array[PROC_MAXPIDS];
 	char buf[PROC_NUMBUF];
 	unsigned int nr = filp->f_pos - FIRST_PROCESS_ENTRY;
-	unsigned int nr_tgids, i;
-	int next_tgid;
-
+	struct task_struct *task;
+	int tgid;
+	
 	if (!nr) {
 		ino_t ino = fake_ino(0,PROC_TGID_INO);
 		if (filldir(dirent, "self", 4, filp->f_pos, ino, DT_LNK) < 0)
@@ -2054,62 +2052,123 @@ int proc_pid_readdir(struct file * filp,
 		filp->f_pos++;
 		nr++;
 	}
+	nr -= 1;
 
 	/* f_version caches the tgid value that the last readdir call couldn't
 	 * return. lseek aka telldir automagically resets f_version to 0.
 	 */
-	next_tgid = filp->f_version;
+	tgid = filp->f_version;
 	filp->f_version = 0;
-	for (;;) {
-		nr_tgids = get_tgid_list(nr, next_tgid, tgid_array);
-		if (!nr_tgids) {
-			/* no more entries ! */
+	for (task = first_tgid(tgid, nr);
+	     task;
+	     task = next_tgid(task), filp->f_pos++) {
+		int len;
+		ino_t ino;
+		tgid = task->pid;
+		len = snprintf(buf, sizeof(buf), "%d", tgid);
+		ino = fake_ino(tgid, PROC_TGID_INO);
+		if (filldir(dirent, buf, len, filp->f_pos, ino, DT_DIR) < 0) {
+			/* returning this tgid failed, save it as the first
+			 * pid for the next readir call */
+			filp->f_version = tgid;
+			put_task_struct(task);
 			break;
 		}
-		next_tgid = 0;
+	}
+	return 0;
+}
 
-		/* do not use the last found pid, reserve it for next_tgid */
-		if (nr_tgids == PROC_MAXPIDS) {
-			nr_tgids--;
-			next_tgid = tgid_array[nr_tgids];
-		}
+/*
+ * Find the first tid of a thread group to return to user space.
+ *
+ * Usually this is just the thread group leader, but if the users
+ * buffer was too small or there was a seek into the middle of the
+ * directory we have more work todo.
+ *
+ * In the case of a short read we start with find_task_by_pid.
+ *
+ * In the case of a seek we start with the leader and walk nr
+ * threads past it.
+ */
+static struct task_struct *first_tid(struct task_struct *leader, int tid, int nr)
+{
+	struct task_struct *pos = NULL;
+	read_lock(&tasklist_lock);
 
-		for (i=0;i<nr_tgids;i++) {
-			int tgid = tgid_array[i];
-			ino_t ino = fake_ino(tgid,PROC_TGID_INO);
-			unsigned long j = PROC_NUMBUF;
-
-			do
-				buf[--j] = '0' + (tgid % 10);
-			while ((tgid /= 10) != 0);
-
-			if (filldir(dirent, buf+j, PROC_NUMBUF-j, filp->f_pos, ino, DT_DIR) < 0) {
-				/* returning this tgid failed, save it as the first
-				 * pid for the next readir call */
-				filp->f_version = tgid_array[i];
-				goto out;
-			}
-			filp->f_pos++;
-			nr++;
-		}
+	/* Attempt to start with the pid of a thread */
+	if (tid && (nr > 0)) {
+		pos = find_task_by_pid(tid);
+		if (pos && (pos->group_leader != leader))
+			pos = NULL;
+		if (pos)
+			nr = 0;
+	}
+
+	/* If nr exceeds the number of threads there is nothing todo */
+	if (nr) {
+		int threads = 0;
+		task_lock(leader);
+		if (leader->signal)
+			threads = atomic_read(&leader->signal->count);
+		task_unlock(leader);
+		if (nr >= threads)
+			goto done;
 	}
-out:
-	return 0;
+
+	/* If we haven't found our starting place yet start with the
+	 * leader and walk nr threads forward.
+	 */
+	if (!pos && (nr >= 0))
+		pos = leader;
+
+	for (; pos && pid_alive(pos); pos = next_thread(pos)) {
+		if (--nr > 0)
+			continue;
+		get_task_struct(pos);
+		goto done;
+	}
+	pos = NULL;
+done:
+	read_unlock(&tasklist_lock);
+	return pos;
 }
 
+/*
+ * Find the next thread in the thread list.
+ * Return NULL if there is an error or no next thread.
+ * 
+ * The reference to the input task_struct is released.
+ */
+static struct task_struct *next_tid(struct task_struct *start)
+{
+	struct task_struct *pos;
+	read_lock(&tasklist_lock);
+	pos = start;
+	if (pid_alive(start))
+		pos = next_thread(start);
+	if (pid_alive(pos) && (pos != start->group_leader))
+		get_task_struct(pos);
+	else
+		pos = NULL;
+	read_unlock(&tasklist_lock);
+	put_task_struct(start);
+	return pos;
+}
+  
 /* for the /proc/TGID/task/ directories */
 static int proc_task_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
-	unsigned int tid_array[PROC_MAXPIDS];
 	char buf[PROC_NUMBUF];
-	unsigned int nr_tids, i;
 	struct dentry *dentry = filp->f_dentry;
 	struct inode *inode = dentry->d_inode;
+	struct task_struct *leader = proc_task(inode);
+	struct task_struct *task;
 	int retval = -ENOENT;
 	ino_t ino;
+	int tid;
 	unsigned long pos = filp->f_pos;  /* avoiding "long long" filp->f_pos */
 
-	if (!pid_alive(proc_task(inode)))
+	if (!pid_alive(leader))
 		goto out;
 	retval = 0;
 
@@ -2128,21 +2187,25 @@ static int proc_task_readdir(struct file
 		/* fall through */
 	}
 
-	nr_tids = get_tid_list(pos, tid_array, inode);
-
-	for (i = 0; i < nr_tids; i++) {
-		unsigned long j = PROC_NUMBUF;
-		int tid = tid_array[i];
-
-		ino = fake_ino(tid,PROC_TID_INO);
-
-		do
-			buf[--j] = '0' + (tid % 10);
-		while ((tid /= 10) != 0);
-
-		if (filldir(dirent, buf+j, PROC_NUMBUF-j, pos, ino, DT_DIR) < 0)
+	/* f_version caches the tgid value that the last readdir call couldn't
+	 * return. lseek aka telldir automagically resets f_version to 0.
+	 */
+	tid = filp->f_version;
+	filp->f_version = 0;
+	for (task = first_tid(leader, tid, pos - 2);
+	     task;
+	     task = next_tid(task), pos++) {
+		int len;
+		tid = task->pid;
+		len = snprintf(buf, sizeof(buf), "%d", tid);
+		ino = fake_ino(tid, PROC_TID_INO);
+		if (filldir(dirent, buf, len, pos, ino, DT_DIR < 0)) {
+			/* returning this tgid failed, save it as the first
+			 * pid for the next readir call */
+			filp->f_version = tid;
+			put_task_struct(task);
 			break;
-		pos++;
+		}
 	}
 out:
 	filp->f_pos = pos;
-- 
1.2.2.g709a

