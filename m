Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbWIEOx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbWIEOx2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 10:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbWIEOx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 10:53:28 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7571 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965080AbWIEOx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 10:53:26 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, ak@suse.de, jdelvare@suse.de,
       Albert Cahalan <acahalan@gmail.com>, Paul Jackson <pj@sgi.com>
Subject: [PATCH] proc: readdir race fix (take 3)
References: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com>
	<m1y7sz4455.fsf@ebiederm.dsl.xmission.com>
	<20060905112621.b663bc7d.kamezawa.hiroyu@jp.fujitsu.com>
	<m14pvn3tam.fsf_-_@ebiederm.dsl.xmission.com>
	<20060905101050.GA128@oleg>
Date: Tue, 05 Sep 2006 08:52:01 -0600
In-Reply-To: <20060905101050.GA128@oleg> (Oleg Nesterov's message of "Tue, 5
	Sep 2006 14:10:50 +0400")
Message-ID: <m1ac5e2woe.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problem: An opendir, readdir, closedir sequence can fail to report
process ids that are continually in use throughout the sequence of
system calls.  For this race to trigger the process that proc_pid_readdir
stops at must exit before readdir is called again.

This can cause ps to fail to report processes, and  it is in violation
of posix guarantees and normal application expectations with respect
to readdir.

Currently there is no way to work around this problem in user space
short of providing a gargantuan buffer to user space so the directory
read all happens in on system call.

This patch implements the normal directory semantics for proc,
that guarantee that a directory entry that is neither created nor
destroyed while reading the directory entry will be returned.  For
directory that are either created or destroyed during the readdir you
may or may not see them.  Furthermore you may seek to a directory
offset you have previously seen.

These are the guarantee that ext[23] provides and that posix requires,
and more importantly that user space expects. Plus it is a simple
semantic to implement reliable service.  It is just a matter of
calling readdir a second time if you are wondering if something new
has show up.

These better semantics are implemented by scanning through the
pids in numerical order and by making the file offset a pid
plus a fixed offset.

The pid scan happens on the pid bitmap, which when you look at it is
remarkably efficient for a brute force algorithm.  Given that a typical
cache line is 64 bytes and thus covers space for 64*8 == 200 pids.  There
are only 40 cache lines for the entire 32K pid space.  A typical system
will have 100 pids or more so this is actually fewer cache lines we have
to look at to scan a linked list, and the worst case of having to scan
the entire pid bitmap is pretty reasonable.

If we need something more efficient we can go to a more efficient data
structure for indexing the pids, but for now what we have should be
sufficient.

In addition this takes no additional locks and is actually less
code than what we are doing now.

Also another very subtle bug in this area has been fixed.  It is
possible to catch a task in the middle of de_thread where a thread is
assuming the thread of it's thread group leader.  This patch carefully
handles that case so if we hit it we don't fail to return the pid, that
is undergoing the de_thread dance.

This patch is against 2.6.18-rc6 and it should be relatively straight
forward to backport to older kernels as well.

Thanks to KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> for
providing the first fix, pointing this out and working on it.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/base.c        |  104 ++++++++++++++++---------------------------------
 include/linux/pid.h   |    1 
 include/linux/sched.h |   11 +++++
 kernel/pid.c          |   36 +++++++++++++++++
 4 files changed, 83 insertions(+), 69 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index fe8d55f..28e56c3 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2141,72 +2141,43 @@ out_no_task:
 }
 
 /*
- * Find the first tgid to return to user space.
+ * Find the first task with tgid >= tgid
  *
- * Usually this is just whatever follows &init_task, but if the users
- * buffer was too small to hold the full list or there was a seek into
- * the middle of the directory we have more work to do.
- *
- * In the case of a short read we start with find_task_by_pid.
- *
- * In the case of a seek we start with &init_task and walk nr
- * threads past it.
  */
-static struct task_struct *first_tgid(int tgid, unsigned int nr)
+static struct task_struct *next_tgid(unsigned int tgid)
 {
-	struct task_struct *pos;
-	rcu_read_lock();
-	if (tgid && nr) {
-		pos = find_task_by_pid(tgid);
-		if (pos && thread_group_leader(pos))
-			goto found;
-	}
-	/* If nr exceeds the number of processes get out quickly */
-	pos = NULL;
-	if (nr && nr >= nr_processes())
-		goto done;
-
-	/* If we haven't found our starting place yet start with
-	 * the init_task and walk nr tasks forward.
-	 */
-	for (pos = next_task(&init_task); nr > 0; --nr) {
-		pos = next_task(pos);
-		if (pos == &init_task) {
-			pos = NULL;
-			goto done;
-		}
-	}
-found:
-	get_task_struct(pos);
-done:
-	rcu_read_unlock();
-	return pos;
-}
+	struct task_struct *task;
+	struct pid *pid;
 
-/*
- * Find the next task in the task list.
- * Return NULL if we loop or there is any error.
- *
- * The reference to the input task_struct is released.
- */
-static struct task_struct *next_tgid(struct task_struct *start)
-{
-	struct task_struct *pos;
+	task = NULL;
 	rcu_read_lock();
-	pos = start;
-	if (pid_alive(start))
-		pos = next_task(start);
-	if (pid_alive(pos) && (pos != &init_task)) {
-		get_task_struct(pos);
-		goto done;
+retry:
+	pid = find_ge_pid(tgid);
+	if (pid) {
+		tgid = pid->nr + 1;
+		task = pid_task(pid, PIDTYPE_PID);
+		/* What we to know is if the pid we have find is the
+		 * pid of a thread_group_leader.  Testing for task
+		 * being a thread_group_leader is the obvious thing
+		 * todo but there is a window when it fails, due to
+		 * the pid transfer logic in de_thread.
+		 *
+		 * So we perform the straight forward test of seeing
+		 * if the pid we have found is the pid of a thread
+		 * group leader, and don't worry if the task we have
+		 * found doesn't happen to be a thread group leader.
+		 * As we don't care in the case of readdir.
+		 */
+		if (!task || !has_group_leader_pid(task))
+			goto retry;
+		get_task_struct(task);
 	}
-	pos = NULL;
-done:
 	rcu_read_unlock();
-	put_task_struct(start);
-	return pos;
+	return task;
 }
 
+#define TGID_OFFSET (FIRST_PROCESS_ENTRY + (1 /* /proc/self */))
+
 /* for the /proc/ directory itself, after non-process stuff has been done */
 int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
@@ -2222,29 +2193,24 @@ int proc_pid_readdir(struct file * filp,
 		filp->f_pos++;
 		nr++;
 	}
-	nr -= 1;
 
-	/* f_version caches the tgid value that the last readdir call couldn't
-	 * return. lseek aka telldir automagically resets f_version to 0.
-	 */
-	tgid = filp->f_version;
-	filp->f_version = 0;
-	for (task = first_tgid(tgid, nr);
+	tgid = filp->f_pos - TGID_OFFSET;
+	for (task = next_tgid(tgid);
 	     task;
-	     task = next_tgid(task), filp->f_pos++) {
+	     put_task_struct(task), task = next_tgid(tgid + 1)) {
 		int len;
 		ino_t ino;
 		tgid = task->pid;
+		filp->f_pos = tgid + TGID_OFFSET;
 		len = snprintf(buf, sizeof(buf), "%d", tgid);
 		ino = fake_ino(tgid, PROC_TGID_INO);
 		if (filldir(dirent, buf, len, filp->f_pos, ino, DT_DIR) < 0) {
-			/* returning this tgid failed, save it as the first
-			 * pid for the next readir call */
-			filp->f_version = tgid;
 			put_task_struct(task);
-			break;
+			goto out;
 		}
 	}
+	filp->f_pos = PID_MAX_LIMIT + TGID_OFFSET;
+out:
 	return 0;
 }
 
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 29960b0..525af8b 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -87,6 +87,7 @@ extern struct pid *FASTCALL(find_pid(int
  * Lookup a PID in the hash table, and return with it's count elevated.
  */
 extern struct pid *find_get_pid(int nr);
+extern struct pid *find_ge_pid(int nr);
 
 extern struct pid *alloc_pid(void);
 extern void FASTCALL(free_pid(struct pid *pid));
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 34ed0d9..a5dea85 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1332,6 +1332,17 @@ #define while_each_thread(g, t) \
 /* de_thread depends on thread_group_leader not being a pid based check */
 #define thread_group_leader(p)	(p == p->group_leader)
 
+/* Do to the insanities of de_thread it is possible for a process
+ * to have the pid of the thread group leader without actually being
+ * the thread group leader.  For iteration through the pids in proc
+ * all we care about is that we have a task with the appropriate 
+ * pid, we don't actually care if we have the right task.
+ */
+static inline int has_group_leader_pid(struct task_struct *p)
+{
+	return p->pid == p->tgid;
+}
+
 static inline struct task_struct *next_thread(const struct task_struct *p)
 {
 	return list_entry(rcu_dereference(p->thread_group.next),
diff --git a/kernel/pid.c b/kernel/pid.c
index 93e212f..f396796 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -145,6 +145,23 @@ static int alloc_pidmap(void)
 	return -1;
 }
 
+static int next_pidmap(int last)
+{
+	int offset;
+	pidmap_t *map;
+
+	offset = (last + 1) & BITS_PER_PAGE_MASK;
+	map = &pidmap_array[(last + 1)/BITS_PER_PAGE];
+	for (; map < &pidmap_array[PIDMAP_ENTRIES]; map++, offset = 0) {
+		if (unlikely(!map->page))
+			continue;
+		offset = find_next_bit((map)->page, BITS_PER_PAGE, offset);
+		if (offset < BITS_PER_PAGE) 
+			return mk_pid(map, offset);
+	}
+	return -1;
+}
+
 fastcall void put_pid(struct pid *pid)
 {
 	if (!pid)
@@ -297,6 +314,25 @@ struct pid *find_get_pid(pid_t nr)
 }
 
 /*
+ * Used by proc to find the first pid that is greater then or equal to nr.
+ *
+ * If there is a pid at nr this function is exactly the same as find_pid.
+ */
+struct pid *find_ge_pid(int nr)
+{
+	struct pid *pid;
+
+	do {
+		pid = find_pid(nr);
+		if (pid)
+			break;
+		nr = next_pidmap(nr);
+	} while (nr > 0);
+
+	return pid;
+}
+
+/*
  * The pid hash table is scaled according to the amount of memory in the
  * machine.  From a minimum of 16 slots up to 4096 slots at one gigabyte or
  * more.
-- 


