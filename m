Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWHYJYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWHYJYq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 05:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWHYJYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 05:24:46 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:63364 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932367AbWHYJYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 05:24:45 -0400
Date: Fri, 25 Aug 2006 18:28:13 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: ebiederm@xmission.com, kamezawa.hiroyu@jp.fujitsu.com,
       Andrew Morton <akpm@osdl.org>, saito.tadashi@soft.fujitsu.com,
       ak@suse.de
Subject: [RFC][PATCH] ps command race fix take 4 [3/4] callback subroutine
Message-Id: <20060825182813.f4539c83.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For remembering 'what process should be read in the next time',
uses adaptive_pointer and records pointer to the next task.

While task is being stale, adaptive_pointer is invalidated and
registered callback ,'proc_pid_readdir_callback' is invoked.

proc_pid_readdir_callback moves pointer to the next (alive) task.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


 fs/proc/base.c |  127 +++++++++++++++++++++++++++++++--------------------------
 1 files changed, 70 insertions(+), 57 deletions(-)

Index: linux-2.6.18-rc4/fs/proc/base.c
===================================================================
--- linux-2.6.18-rc4.orig/fs/proc/base.c
+++ linux-2.6.18-rc4/fs/proc/base.c
@@ -71,6 +71,8 @@
 #include <linux/cpuset.h>
 #include <linux/audit.h>
 #include <linux/poll.h>
+#include <linux/adaptive_pointer.h>
+
 #include "internal.h"
 
 /* NOTE:
@@ -2140,70 +2142,68 @@ out_no_task:
 	return result;
 }
 
-/*
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
- */
-static struct task_struct *first_tgid(int tgid, unsigned int nr)
+/* caller must take rcu_read_lock() */
+static struct task_struct *first_alive_process(struct task_struct *pos)
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
+	while (!pid_alive(pos)) {
+		if (pos == &init_task)
+			break;
 		pos = next_task(pos);
-		if (pos == &init_task) {
-			pos = NULL;
-			goto done;
-		}
 	}
-found:
-	get_task_struct(pos);
-done:
+	if (pos == &init_task)
+		return NULL;
+	return pos;
+}
+
+static struct task_struct *next_tgid(struct task_struct *task)
+{
+	struct task_struct *pos;
+	rcu_read_lock();
+	pos = next_task(task);
+	pos = first_alive_process(pos);
+	put_task_struct(task);
+	if (pos)
+		get_task_struct(pos);
 	rcu_read_unlock();
 	return pos;
 }
 
 /*
- * Find the next task in the task list.
- * Return NULL if we loop or there is any error.
- *
- * The reference to the input task_struct is released.
+ * the task next to be read is removed.
+ * then, adjust pointer to next task.
+ * this callback is called under write_lock(tasklist_lock);
+ * next_task() is alive and all ops are safe.
  */
-static struct task_struct *next_tgid(struct task_struct *start)
+void proc_pid_readdir_callback(
+			struct adaptive_pointer *ap,
+			struct adaptive_pointer *obj)
 {
-	struct task_struct *pos;
+	struct task_struct *task;
+	task = container_of(obj, struct task_struct, ap_target);
+	task = next_task(task);
+	ap_attach(ap, &task->ap_target);
+}
+
+/*
+ * return the first process pointer by head.
+ * if head points no where, returns next_alive_task(init_task)
+ * if head points to init_task, returns NULL.
+ */
+static struct task_struct *first_tgid(struct adaptive_pointer *head)
+{
+	struct task_struct *pos = NULL;
 	rcu_read_lock();
-	pos = start;
-	if (pid_alive(start))
-		pos = next_task(start);
-	if (pid_alive(pos) && (pos != &init_task)) {
-		get_task_struct(pos);
-		goto done;
+	pos = ap_get_remove_pointer(head,struct task_struct,ap_target);
+	if (!pos) {
+		pos = first_alive_process(next_task(&init_task));
+	} else if (pos == &init_task) {
+		pos = NULL;
+	} else {
+		pos = first_alive_process(pos);
 	}
-	pos = NULL;
-done:
+	if (pos)
+		get_task_struct(pos);
 	rcu_read_unlock();
-	put_task_struct(start);
 	return pos;
 }
 
@@ -2213,6 +2213,7 @@ int proc_pid_readdir(struct file * filp,
 	char buf[PROC_NUMBUF];
 	unsigned int nr = filp->f_pos - FIRST_PROCESS_ENTRY;
 	struct task_struct *task;
+	struct adaptive_pointer *head;
 	int tgid;
 
 	if (!nr) {
@@ -2227,9 +2228,11 @@ int proc_pid_readdir(struct file * filp,
 	/* f_version caches the tgid value that the last readdir call couldn't
 	 * return. lseek aka telldir automagically resets f_version to 0.
 	 */
-	tgid = filp->f_version;
-	filp->f_version = 0;
-	for (task = first_tgid(tgid, nr);
+	head = filp->private_data;
+	/* if we reached to the end of task_list once, head is invalidated */
+	if (is_ap_invalid(head))
+		return 0;
+	for (task = first_tgid(head);
 	     task;
 	     task = next_tgid(task), filp->f_pos++) {
 		int len;
@@ -2238,13 +2241,26 @@ int proc_pid_readdir(struct file * filp,
 		len = snprintf(buf, sizeof(buf), "%d", tgid);
 		ino = fake_ino(tgid, PROC_TGID_INO);
 		if (filldir(dirent, buf, len, filp->f_pos, ino, DT_DIR) < 0) {
-			/* returning this tgid failed, save it as the first
-			 * pid for the next readir call */
-			filp->f_version = tgid;
+			/* this task is failed to be returned. remember this */
+			struct task_struct *pos = task;
+			head->callback = proc_pid_readdir_callback;
+			rcu_read_lock();
+			do {
+				pos = first_alive_process(pos);
+				if (pos && ap_attach(head, &pos->ap_target))
+					break;
+				if (pos)
+					pos = next_task(pos);
+			} while (pos && pos != &init_task);
+			rcu_read_unlock();
 			put_task_struct(task);
+			task = pos;
 			break;
 		}
 	}
+	/* reached to the end of task_list */
+	if (!task)
+		invalidate_ap(head);
 	return 0;
 }
 

