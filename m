Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWHVIkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWHVIkG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 04:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWHVIkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 04:40:06 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:37867 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751368AbWHVIkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 04:40:04 -0400
Date: Tue, 22 Aug 2006 17:43:02 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, ebiederm@xmission.com, pj@sgi.com,
       saito.tadashi@soft.fujitsu.com
Subject: [RFC][PATCH] ps command race fix take2 [4/4] proc_pid_readdir
Message-Id: <20060822174302.e97f23d1.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

proc_pid_readdir() by list_token.

Remember 'where we are reading' by inserting a token in the list.
It seems a bit complicated because of RCU but what we do is very simple.

Considering task A-G.

--(A)--(B)--(C)--(D)--(E)--(F)--(G)--

When we have read (C) (and return to user process),
inserting a token before (D)

--(A)--(B)--(C)--(token)--(D)--(E)--(F)--(G)--

If (A),(B),(C),(D),(E),(F) exits before next readdir(), the list is

--(token)--(G)--

readdir() can restart from (G).

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Signed-Off-By: Tadashi Saito <shiba@mail2.accsnet.ne.jp>

 fs/proc/base.c |  124 +++++++++++++++++++++++++++++++--------------------------
 fs/proc/root.c |   11 +++++
 2 files changed, 80 insertions(+), 55 deletions(-)

Index: linux-2.6.18-rc4/fs/proc/base.c
===================================================================
--- linux-2.6.18-rc4.orig/fs/proc/base.c
+++ linux-2.6.18-rc4/fs/proc/base.c
@@ -2141,44 +2141,35 @@ out_no_task:
 }
 
 /*
- * Find the first tgid to return to user space.
- *
- * Usually this is just whatever follows &init_task, but if the users
- * buffer was too small to hold the full list or there was a seek into
- * the middle of the directory we have more work to do.
- *
- * In the case of a short read we start with find_task_by_pid.
- *
- * In the case of a seek we start with &init_task and walk nr
- * threads past it.
+ * Find the first tgid to return to user space. Usually this is just
+ * whatever follows &init_task.
  */
-static struct task_struct *first_tgid(int tgid, unsigned int nr)
+/*
+ * return the first *alive* task.
+ */
+static inline struct task_struct *first_alive_task(struct task_struct *task)
+{
+	while (!pid_alive(task) && task != &init_task)
+		task = next_task(task);
+	if (task == &init_task)
+		return NULL;
+	return task;
+}
+
+static struct task_struct *first_tgid(struct list_token *start)
 {
 	struct task_struct *pos;
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
 
-	/* If we haven't found our starting place yet start with
-	 * the init_task and walk nr tasks forward.
-	 */
-	for (pos = next_task(&init_task); nr > 0; --nr) {
-		pos = next_task(pos);
-		if (pos == &init_task) {
-			pos = NULL;
-			goto done;
-		}
+ 	rcu_read_lock();
+	if (!start) {
+		pos = next_task(&init_task);
+	} else {
+		start = list_next_rcu_skiptoken(start);
+		pos = container_of(start, struct task_struct, tasks);
 	}
-found:
-	get_task_struct(pos);
-done:
+	pos = first_alive_task(pos);
+	if (pos)
+		get_task_struct(pos);
 	rcu_read_unlock();
 	return pos;
 }
@@ -2192,16 +2183,12 @@ done:
 static struct task_struct *next_tgid(struct task_struct *start)
 {
 	struct task_struct *pos;
-	rcu_read_lock();
+
 	pos = start;
-	if (pid_alive(start))
-		pos = next_task(start);
-	if (pid_alive(pos) && (pos != &init_task)) {
+	rcu_read_lock();
+	pos = first_alive_task(next_task(pos));
+	if(pos)
 		get_task_struct(pos);
-		goto done;
-	}
-	pos = NULL;
-done:
 	rcu_read_unlock();
 	put_task_struct(start);
 	return pos;
@@ -2212,24 +2199,31 @@ int proc_pid_readdir(struct file * filp,
 {
 	char buf[PROC_NUMBUF];
 	unsigned int nr = filp->f_pos - FIRST_PROCESS_ENTRY;
-	struct task_struct *task;
+	struct task_struct *task, *pos;
 	int tgid;
+	struct list_token *token, *old_token;
 
 	if (!nr) {
 		ino_t ino = fake_ino(0,PROC_TGID_INO);
 		if (filldir(dirent, "self", 4, filp->f_pos, ino, DT_LNK) < 0)
 			return 0;
 		filp->f_pos++;
-		nr++;
+		filp->private_data = NULL;
+	} else if (filp->private_data == NULL)
+		return 0;  /* all entries were read */
+
+retry:
+	token = kzalloc(sizeof(*token), GFP_KERNEL);
+	if (!token) {
+		/* this small kmalloc() can fail in rare case, but readdir()
+		 * is not allowed to return ENOMEM. retrying is reasonable. */
+		yield();
+		goto retry;
 	}
-	nr -= 1;
 
-	/* f_version caches the tgid value that the last readdir call couldn't
-	 * return. lseek aka telldir automagically resets f_version to 0.
-	 */
-	tgid = filp->f_version;
-	filp->f_version = 0;
-	for (task = first_tgid(tgid, nr);
+	old_token = filp->private_data;
+	filp->private_data = NULL;
+	for (task = first_tgid(old_token);
 	     task;
 	     task = next_tgid(task), filp->f_pos++) {
 		int len;
@@ -2237,14 +2231,34 @@ int proc_pid_readdir(struct file * filp,
 		tgid = task->pid;
 		len = snprintf(buf, sizeof(buf), "%d", tgid);
 		ino = fake_ino(tgid, PROC_TGID_INO);
-		if (filldir(dirent, buf, len, filp->f_pos, ino, DT_DIR) < 0) {
-			/* returning this tgid failed, save it as the first
-			 * pid for the next readir call */
-			filp->f_version = tgid;
-			put_task_struct(task);
+		if (filldir(dirent, buf, len, filp->f_pos, ino, DT_DIR) < 0)
 			break;
+	}
+	write_lock_irq(&tasklist_lock);
+	/*
+	 * insert token and remember it for next access.
+	 * insertion of token should be done just before not-stale task.
+	 */
+	if (task) {
+		pos = first_alive_task(task);
+		if (pos != task) { /* task is not alive */
+			if (pos)
+				get_task_struct(pos);
+			put_task_struct(task);
+		}
+		if (pos) { /* remember here for next access */
+			/* token->token turns to be 1 */
+			insert_list_token_rcu(token, &pos->tasks);
+			put_task_struct(pos);
+			filp->private_data = token;
 		}
 	}
+	if (old_token)
+		remove_list_token_rcu(old_token);
+	write_unlock_irq(&tasklist_lock);
+
+	if (!token->token) /* this token was not inserted */
+		kfree(token);
 	return 0;
 }
 
Index: linux-2.6.18-rc4/fs/proc/root.c
===================================================================
--- linux-2.6.18-rc4.orig/fs/proc/root.c
+++ linux-2.6.18-rc4/fs/proc/root.c
@@ -118,6 +118,16 @@ static int proc_root_readdir(struct file
 	return ret;
 }
 
+static int proc_root_release(struct inode * dir, struct file * filp)
+{
+	if (filp->private_data) {
+		write_lock_irq(&tasklist_lock);
+		remove_list_token_rcu(filp->private_data);
+		write_unlock_irq(&tasklist_lock);
+	}
+	return 0;
+}
+
 /*
  * The root /proc directory is special, as it has the
  * <pid> directories. Thus we don't use the generic
@@ -126,6 +136,7 @@ static int proc_root_readdir(struct file
 static struct file_operations proc_root_operations = {
 	.read		 = generic_read_dir,
 	.readdir	 = proc_root_readdir,
+	.release	 = proc_root_release,
 };
 
 /*

