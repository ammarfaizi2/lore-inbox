Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWHXMAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWHXMAL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 08:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWHXMAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 08:00:11 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:21205 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751185AbWHXMAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 08:00:08 -0400
Date: Thu, 24 Aug 2006 21:03:03 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: ebiederm@xmission.com, kamezawa.hiroyu@jp.fujitsu.com,
       Andrew Morton <akpm@osdl.org>, saito.tadashi@soft.fujitsu.com,
       ak@suse.de
Subject: [RFC][PATCH] ps command race fix take 3 [3/4]  proc_pid_readdir()
Message-Id: <20060824210303.9fe7e77a.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For remembering 'what process should be read in the next time',
uses watch_head, dual direction pointer.

If a task which is pointed by file descriptor is removed,
that pointer is moved to the next task (see release_task()).
This will guarantee readdir() can traverse all task in the safe way.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


 fs/proc/base.c |  113 +++++++++++++++++++++++++++------------------------------
 1 files changed, 55 insertions(+), 58 deletions(-)

Index: linux-2.6.18-rc4/fs/proc/base.c
===================================================================
--- linux-2.6.18-rc4.orig/fs/proc/base.c
+++ linux-2.6.18-rc4/fs/proc/base.c
@@ -71,6 +71,8 @@
 #include <linux/cpuset.h>
 #include <linux/audit.h>
 #include <linux/poll.h>
+#include <linux/watch_head.h>
+
 #include "internal.h"
 
 /* NOTE:
@@ -2140,70 +2142,48 @@ out_no_task:
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
+	return (pos == &init_task)? NULL : pos;
+}
+
+static struct task_struct *next_tgid(struct task_struct *task)
+{
+	struct task_struct *pos;
+	rcu_read_lock();
+	pos = first_alive_process(next_task(task));
+	put_task_struct(task);
+	if (pos)
+		get_task_struct(pos);
 	rcu_read_unlock();
 	return pos;
 }
-
 /*
- * Find the next task in the task list.
- * Return NULL if we loop or there is any error.
- *
- * The reference to the input task_struct is released.
+ * return the first process pointer by head.
+ * if head points no where, returns next_alive_task(init_task)
+ * if head points to init_task, returns NULL.
  */
-static struct task_struct *next_tgid(struct task_struct *start)
+static struct task_struct *first_tgid(struct watch_head *head)
 {
-	struct task_struct *pos;
+	struct task_struct *pos = NULL;
 	rcu_read_lock();
-	pos = start;
-	if (pid_alive(start))
-		pos = next_task(start);
-	if (pid_alive(pos) && (pos != &init_task)) {
-		get_task_struct(pos);
-		goto done;
+	pos = wh_get_remove_pointer(head,struct task_struct,watch);
+	if (!pos) {
+		pos = first_alive_process(next_task(&init_task));
+	} else if (pos == &init_task) {
+		return NULL;
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
 
@@ -2213,6 +2193,7 @@ int proc_pid_readdir(struct file * filp,
 	char buf[PROC_NUMBUF];
 	unsigned int nr = filp->f_pos - FIRST_PROCESS_ENTRY;
 	struct task_struct *task;
+	struct watch_head *head;
 	int tgid;
 
 	if (!nr) {
@@ -2227,9 +2208,13 @@ int proc_pid_readdir(struct file * filp,
 	/* f_version caches the tgid value that the last readdir call couldn't
 	 * return. lseek aka telldir automagically resets f_version to 0.
 	 */
-	tgid = filp->f_version;
-	filp->f_version = 0;
-	for (task = first_tgid(tgid, nr);
+	head = filp->private_data;
+	/* if we reached to the end of task_list once, head is invalidated */
+	if (is_wh_invalid(head))
+		return 0;
+
+	/* f_pos counts # of read tasks. for lseek() */
+	for (task = first_tgid(head);
 	     task;
 	     task = next_tgid(task), filp->f_pos++) {
 		int len;
@@ -2238,13 +2223,25 @@ int proc_pid_readdir(struct file * filp,
 		len = snprintf(buf, sizeof(buf), "%d", tgid);
 		ino = fake_ino(tgid, PROC_TGID_INO);
 		if (filldir(dirent, buf, len, filp->f_pos, ino, DT_DIR) < 0) {
-			/* returning this tgid failed, save it as the first
-			 * pid for the next readir call */
-			filp->f_version = tgid;
+			/* this task is failed to be returned. remember this */
+			struct task_struct *pos = task;
+			rcu_read_lock();
+			do {
+				pos = first_alive_process(pos);
+				if (pos && add_watcher(head, &pos->watch))
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
+		invalidate_wh(head);
 	return 0;
 }
 

