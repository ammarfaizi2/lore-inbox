Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267387AbUIARkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267387AbUIARkA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 13:40:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267382AbUIARib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 13:38:31 -0400
Received: from holomorphy.com ([207.189.100.168]:61894 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266730AbUIARde (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 13:33:34 -0400
Date: Wed, 1 Sep 2004 10:33:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kirill Korotaev <kksx@mail.ru>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [5/7] back out renaming of struct pid
Message-ID: <20040901173327.GI5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Kirill Korotaev <kksx@mail.ru>, akpm@osdl.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <E1C2TZ1-000JZr-00.kksx-mail-ru@f7.mail.ru> <20040901153624.GA5492@holomorphy.com> <20040901165808.GD5492@holomorphy.com> <20040901172710.GE5492@holomorphy.com> <20040901172839.GF5492@holomorphy.com> <20040901173027.GG5492@holomorphy.com> <20040901173218.GH5492@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901173218.GH5492@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 10:32:18AM -0700, William Lee Irwin III wrote:
> Now that the basic syntactic issues with the macros have been dealt
> with, the semantic issue of properly terminating the list iteration
> remains. The following patch introduces a local variable __list__ in
> do_each_task_pid() to store the virtual address of the list head of the
> leader of the collision chain so that the iteration may be properly
> terminated.

The renaming of struct pid was spurious; the following patch backs out
this renaming.


Index: kirill-2.6.9-rc1-mm2/kernel/sys.c
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/kernel/sys.c	2004-09-01 08:44:05.794680744 -0700
+++ kirill-2.6.9-rc1-mm2/kernel/sys.c	2004-09-01 09:29:03.608550696 -0700
@@ -1165,7 +1165,7 @@
 
 asmlinkage long sys_setsid(void)
 {
-	struct pid_struct *pid;
+	struct pid *pid;
 	int err = -EPERM;
 
 	if (!thread_group_leader(current))
Index: kirill-2.6.9-rc1-mm2/kernel/pid.c
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/kernel/pid.c	2004-09-01 08:44:05.779683024 -0700
+++ kirill-2.6.9-rc1-mm2/kernel/pid.c	2004-09-01 09:31:25.972908024 -0700
@@ -148,10 +148,10 @@
 	return -1;
 }
 
-fastcall struct pid_struct *find_pid(enum pid_type type, int nr)
+struct pid * fastcall find_pid(enum pid_type type, int nr)
 {
 	struct hlist_node *elem;
-	struct pid_struct *pid;
+	struct pid *pid;
 
 	hlist_for_each_entry(pid, elem,
 			&pid_hash[type][pid_hashfn(nr)], hash_list) {
@@ -163,7 +163,7 @@
 
 int fastcall attach_pid(task_t *task, enum pid_type type, int nr)
 {
-	struct pid_struct *pid, *task_pid;
+	struct pid *pid, *task_pid;
 
 	task_pid = &task->pids[type];
 	pid = find_pid(type, nr);
@@ -182,7 +182,7 @@
 
 static inline int __detach_pid(task_t *task, enum pid_type type)
 {
-	struct pid_struct *pid, *pid_next;
+	struct pid *pid, *pid_next;
 	int nr;
 
 	pid = &task->pids[type];
@@ -190,7 +190,7 @@
 		hlist_del(&pid->hash_list);
 		if (!list_empty(&pid->pid_list)) {
 			pid_next = list_entry(pid->pid_list.next,
-						struct pid_struct, pid_list);
+						struct pid, pid_list);
 			/* insert next pid from pid_list to hash */
 			hlist_add_head(&pid_next->hash_list,
 				&pid_hash[type][pid_hashfn(pid_next->nr)]);
@@ -218,11 +218,11 @@
 
 task_t *find_task_by_pid_type(int type, int nr)
 {
-	struct pid_struct *pid = find_pid(type, nr);
+	struct pid *pid = find_pid(type, nr);
 
-	if (!pid)
-		return NULL;
-	return pid_task(&pid->pid_list, type);
+	if (pid)
+		return pid_task(&pid->pid_list, type);
+	return NULL;
 }
 
 EXPORT_SYMBOL(find_task_by_pid_type);
Index: kirill-2.6.9-rc1-mm2/include/linux/sched.h
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/include/linux/sched.h	2004-09-01 08:44:05.775683632 -0700
+++ kirill-2.6.9-rc1-mm2/include/linux/sched.h	2004-09-01 09:28:56.542624880 -0700
@@ -503,7 +503,7 @@
 	struct task_struct *group_leader;	/* threadgroup leader */
 
 	/* PID/PID hash table linkage. */
-	struct pid_struct pids[PIDTYPE_MAX];
+	struct pid pids[PIDTYPE_MAX];
 
 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
Index: kirill-2.6.9-rc1-mm2/include/linux/pid.h
===================================================================
--- kirill-2.6.9-rc1-mm2.orig/include/linux/pid.h	2004-09-01 09:12:08.394886632 -0700
+++ kirill-2.6.9-rc1-mm2/include/linux/pid.h	2004-09-01 09:28:48.595832976 -0700
@@ -10,7 +10,7 @@
 	PIDTYPE_MAX
 };
 
-struct pid_struct
+struct pid
 {
 	/* Try to keep hash_list in the same cacheline as nr for find_pid */
 	int nr;
@@ -34,7 +34,7 @@
  * look up a PID in the hash table. Must be called with the tasklist_lock
  * held.
  */
-extern struct pid_struct *FASTCALL(find_pid(enum pid_type, int));
+struct pid *FASTCALL(find_pid(enum pid_type, int));
 
 extern int alloc_pidmap(void);
 extern void FASTCALL(free_pidmap(int));
