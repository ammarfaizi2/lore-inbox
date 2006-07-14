Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161085AbWGNLiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbWGNLiL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 07:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161086AbWGNLiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 07:38:11 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:5606 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161085AbWGNLiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 07:38:10 -0400
Date: Fri, 14 Jul 2006 20:39:39 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [RFC] ps command race fix
Message-Id: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is an experimental patch for the probelm
	- "ps command can miss some pid occationally"
please comment 


the problem itself is very rare case, but the result is sometimes terrible

for example, when a user does

alive=`ps | grep command | grep -v command | wc -l`

to check process is alive or not (I think this user should use kill-0 ;)

-Kame
==
Now, prod_pid_readir() uses direct access to task and 
indexing 'task list' as fallback.
Of course, entries in this list can be removed randomly.

So, following can happen when using 'ps' command.
==
1. assume task_list as
....-(taskA)-(taskB)-(taskC)-(taskD)-(taskE)-(taskF)-(taskG)-...

2. at getdents() iteration 'N', ps command's getdents() read entries before taskC.
and remenbers "I read X entries".

....-(taskA)-(taskB)-(taskC)-(taskD)-(taskE)-(taskF)-(taskG)-...
------(f_pos=X)---------^

getdents() remembers
	- "taskC is next candidate to be read"
	- "we already read X ents".

3. consider taskA and taskC exits, before next getdents(N+1)

....-(lost)-(taskB)-(lost)-(taskD)-(taskE)-(taskF)-(taskG)-...
------(f_pos=X)--------^

4. at getdents(N+1), becasue getdents() cannot find taskC, it skips 'X'
   ents in the list.
   from head of the list.
....-(taskB)-(taskD)-(taskE)-(taskF)-(taskG)-..
------(f_pos=X)--------^

5. in this case, taskD is skipped.
==

This patch changes indexing in the list to indexing in a table.
Table is created only for storing valid tgid.(not pid)
Tested on x86/ia64.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 fs/proc/base.c          |  187 ++++++++++++++++++++++++++++++++----------------
 include/linux/proc_fs.h |    4 +
 include/linux/sched.h   |    6 +
 kernel/exit.c           |    1 
 kernel/fork.c           |    2 
 5 files changed, 138 insertions(+), 62 deletions(-)

Index: linux-2.6.18-rc1-kame/fs/proc/base.c
===================================================================
--- linux-2.6.18-rc1-kame.orig/fs/proc/base.c	2006-07-14 09:14:45.000000000 +0900
+++ linux-2.6.18-rc1-kame/fs/proc/base.c	2006-07-14 17:04:35.000000000 +0900
@@ -2121,59 +2121,126 @@
  * In the case of a seek we start with &init_task and walk nr
  * threads past it.
  */
-static struct task_struct *first_tgid(int tgid, unsigned int nr)
+
+rwlock_t	tgid_table_lock;
+struct tgid_buffer {
+	struct list_head list;
+	int base_pos;
+	int nr_free;
+	int cache;
+	int *data;
+};
+
+LIST_HEAD(tgid_table);
+DECLARE_RWSEM(tgid_table_sem);
+int nr_tgid_table;
+int tgid_end_pos;
+#define get_tgid_buf(p) ((struct tgid_buffer *)((unsigned long)p & PAGE_MASK))
+#define ENT_PER_TGIDBUF ((PAGE_SIZE - sizeof(struct tgid_buffer))/sizeof(int))
+
+static inline int tgid_ent_to_pos(int *tgid)
 {
-	struct task_struct *pos;
-	rcu_read_lock();
-	if (tgid && nr) {
-		pos = find_task_by_pid(tgid);
-		if (pos && thread_group_leader(pos))
+	struct tgid_buffer *buf =  get_tgid_buf(tgid);
+	return buf->base_pos + (tgid - buf->data);
+}
+
+static struct tgid_buffer *grow_tgid_buf(void)
+{
+	struct tgid_buffer *buf = (void *) get_zeroed_page(GFP_KERNEL);
+	BUG_ON(!buf);
+	INIT_LIST_HEAD(&buf->list);
+	buf->nr_free = ENT_PER_TGIDBUF;
+	buf->data = (void *)buf + sizeof(struct tgid_buffer);
+	buf->base_pos = nr_tgid_table * ENT_PER_TGIDBUF;
+	/* add to the tail */
+	list_add_tail(&buf->list,&tgid_table);
+	nr_tgid_table++;
+	tgid_end_pos += ENT_PER_TGIDBUF;
+	return buf;
+}
+
+void proc_register_tgid(struct task_struct *task)
+{
+	struct tgid_buffer *buf;
+	int tgid = task->tgid;
+	int *ent;
+	/* we just record thread group leader */
+	if (!thread_group_leader(task))
+		return;
+	down_write(&tgid_table_sem);
+	list_for_each_entry(buf, &tgid_table, list) {
+		if (buf->nr_free != 0)
 			goto found;
 	}
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
+	/* no free area... allocate new one */
+	buf = grow_tgid_buf();
+found:
+	ent = buf->data + buf->cache;
+	while (*ent) {
+		ent++;
+		if (ent - buf->data >= ENT_PER_TGIDBUF) {
+			ent = buf->data;
 		}
 	}
-found:
-	get_task_struct(pos);
-done:
-	rcu_read_unlock();
-	return pos;
+	*ent = tgid;
+	task->tgid_buf_pos = ent;
+	buf->cache = (ent - buf->data);
+	buf->nr_free--;
+	up_write(&tgid_table_sem);
+	return;
 }
 
-/*
- * Find the next task in the task list.
- * Return NULL if we loop or there is any error.
- *
- * The reference to the input task_struct is released.
- */
-static struct task_struct *next_tgid(struct task_struct *start)
+void proc_unregister_tgid(struct task_struct *task)
 {
-	struct task_struct *pos;
-	rcu_read_lock();
-	pos = start;
-	if (pid_alive(start))
-		pos = next_task(start);
-	if (pid_alive(pos) && (pos != &init_task)) {
-		get_task_struct(pos);
-		goto done;
+	struct tgid_buffer *buf;
+	int *ent;
+	if (task->tgid_buf_pos == NULL)
+		return;
+	down_write(&tgid_table_sem);
+	ent = task->tgid_buf_pos;
+	buf = get_tgid_buf(ent);
+	*ent = 0;
+	buf->cache = ent - buf->data;
+	buf->nr_free++;
+	up_write(&tgid_table_sem);
+}
+
+static int *next_tgid(int *ent)
+{
+	struct tgid_buffer *buf;
+	int pos;
+	buf = get_tgid_buf(ent);
+	/* search next valid entry */
+	ent++;
+	pos = ent - buf->data;
+	do {
+		while (pos < ENT_PER_TGIDBUF) {
+			ent = buf->data + pos;
+			if (*ent)
+				return ent;
+			pos++;
+		}
+		buf = list_entry(buf->list.next, struct tgid_buffer, list);
+		pos = 0;
+	} while (&buf->list != &tgid_table);
+	return NULL;
+}
+
+static int *first_tgid(int nr)
+{
+	int *ent;
+	struct tgid_buffer *buf;
+	list_for_each_entry(buf, &tgid_table, list) {
+		if (nr < ENT_PER_TGIDBUF)
+			goto found;
+		nr -= ENT_PER_TGIDBUF;
 	}
-	pos = NULL;
-done:
-	rcu_read_unlock();
-	put_task_struct(start);
-	return pos;
+	return NULL;
+found:
+	ent = buf->data + nr;
+	if (*ent)
+		return ent;
+	return next_tgid(ent);
 }
 
 /* for the /proc/ directory itself, after non-process stuff has been done */
@@ -2181,8 +2248,7 @@
 {
 	char buf[PROC_NUMBUF];
 	unsigned int nr = filp->f_pos - FIRST_PROCESS_ENTRY;
-	struct task_struct *task;
-	int tgid;
+	int *tgid;
 
 	if (!nr) {
 		ino_t ino = fake_ino(0,PROC_TGID_INO);
@@ -2192,28 +2258,25 @@
 		nr++;
 	}
 	nr -= 1;
-
-	/* f_version caches the tgid value that the last readdir call couldn't
-	 * return. lseek aka telldir automagically resets f_version to 0.
-	 */
-	tgid = filp->f_version;
-	filp->f_version = 0;
-	for (task = first_tgid(tgid, nr);
-	     task;
-	     task = next_tgid(task), filp->f_pos++) {
+	if (nr >= tgid_end_pos)
+		return 0;
+	down_read(&tgid_table_sem);
+	for (tgid = first_tgid(nr);
+	     tgid;
+	     tgid = next_tgid(tgid)) {
 		int len;
 		ino_t ino;
-		tgid = task->pid;
-		len = snprintf(buf, sizeof(buf), "%d", tgid);
-		ino = fake_ino(tgid, PROC_TGID_INO);
+		len = snprintf(buf, sizeof(buf), "%d", *tgid);
+		ino = fake_ino(*tgid, PROC_TGID_INO);
+		filp->f_pos = tgid_ent_to_pos(tgid) + FIRST_PROCESS_ENTRY + 1;
 		if (filldir(dirent, buf, len, filp->f_pos, ino, DT_DIR) < 0) {
-			/* returning this tgid failed, save it as the first
-			 * pid for the next readir call */
-			filp->f_version = tgid;
-			put_task_struct(task);
 			break;
 		}
 	}
+	up_read(&tgid_table_sem);
+	if (!tgid) { /* EOF */
+		filp->f_pos = tgid_end_pos + FIRST_PROCESS_ENTRY + 1;
+	}
 	return 0;
 }
 
Index: linux-2.6.18-rc1-kame/include/linux/proc_fs.h
===================================================================
--- linux-2.6.18-rc1-kame.orig/include/linux/proc_fs.h	2006-07-06 13:09:49.000000000 +0900
+++ linux-2.6.18-rc1-kame/include/linux/proc_fs.h	2006-07-14 19:52:23.000000000 +0900
@@ -200,6 +200,8 @@
 	remove_proc_entry(name,proc_net);
 }
 
+extern void proc_register_tgid(struct task_struct *task);
+extern void proc_unregister_tgid(struct task_struct *task);
 #else
 
 #define proc_root_driver NULL
@@ -232,6 +234,8 @@
 struct tty_driver;
 static inline void proc_tty_register_driver(struct tty_driver *driver) {};
 static inline void proc_tty_unregister_driver(struct tty_driver *driver) {};
+static inline void proc_register_tgid(struct task_struct *task) {};
+static inline void proc_unregister_tgid(struct task_struct *task) {};
 
 extern struct proc_dir_entry proc_root;
 
Index: linux-2.6.18-rc1-kame/include/linux/sched.h
===================================================================
--- linux-2.6.18-rc1-kame.orig/include/linux/sched.h	2006-07-06 13:09:49.000000000 +0900
+++ linux-2.6.18-rc1-kame/include/linux/sched.h	2006-07-14 13:54:07.000000000 +0900
@@ -940,6 +940,12 @@
 
 	atomic_t fs_excl;	/* holding fs exclusive resources */
 	struct rcu_head rcu;
+/*
+ * for proc root directory
+ */
+#ifdef CONFIG_PROC_FS
+	int	*tgid_buf_pos;
+#endif
 
 	/*
 	 * cache last used pipe for splice
Index: linux-2.6.18-rc1-kame/kernel/exit.c
===================================================================
--- linux-2.6.18-rc1-kame.orig/kernel/exit.c	2006-07-06 13:09:49.000000000 +0900
+++ linux-2.6.18-rc1-kame/kernel/exit.c	2006-07-14 13:54:07.000000000 +0900
@@ -166,6 +166,7 @@
 
 	sched_exit(p);
 	write_unlock_irq(&tasklist_lock);
+	proc_unregister_tgid(p);
 	proc_flush_task(p);
 	release_thread(p);
 	call_rcu(&p->rcu, delayed_put_task_struct);
Index: linux-2.6.18-rc1-kame/kernel/fork.c
===================================================================
--- linux-2.6.18-rc1-kame.orig/kernel/fork.c	2006-07-06 13:09:49.000000000 +0900
+++ linux-2.6.18-rc1-kame/kernel/fork.c	2006-07-14 13:54:07.000000000 +0900
@@ -179,6 +179,7 @@
 	atomic_set(&tsk->fs_excl, 0);
 	tsk->btrace_seq = 0;
 	tsk->splice_pipe = NULL;
+	tsk->tgid_buf_pos = NULL;
 	return tsk;
 }
 
@@ -1244,6 +1245,7 @@
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
 	proc_fork_connector(p);
+	proc_register_tgid(p);
 	return p;
 
 bad_fork_cleanup_namespace:

