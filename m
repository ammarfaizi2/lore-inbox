Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267175AbTBKHOx>; Tue, 11 Feb 2003 02:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267189AbTBKHOx>; Tue, 11 Feb 2003 02:14:53 -0500
Received: from dp.samba.org ([66.70.73.150]:19343 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267175AbTBKHOv>;
	Tue, 11 Feb 2003 02:14:51 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: trond.myklebust@fys.uio.no
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] Modernize sched.h iteration macros
Date: Tue, 11 Feb 2003 18:22:16 +1100
Message-Id: <20030211072438.C25822C04B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joern Engel pointed this out.  The exposed "if" scares me: noone uses
it in a dangerous way yet, but it's (1) damn ugly, and (2) waiting to
trap someone.

The task_for_first() usage I left with a FIXME: probably better would
be to introduce:

#define task_first(head)					\
	(list_empty(head) ? NULL				\
	 : list_entry((head)->next, struct rpc_task, tk_list))

Then change the callsites to use the more straightforward:
     if ((task = task_first(head)) != NULL) {

But that's a patch for another day (volunteers?).
Rusty.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.21-pre4/include/linux/sunrpc/sched.h working-2.4.21-pre4-rest-non_drivers/include/linux/sunrpc/sched.h
--- linux-2.4.21-pre4/include/linux/sunrpc/sched.h	2003-01-30 14:01:03.000000000 +1100
+++ working-2.4.21-pre4-rest-non_drivers/include/linux/sunrpc/sched.h	2003-02-11 16:05:10.000000000 +1100
@@ -85,18 +85,17 @@ struct rpc_task {
 #define tk_xprt			tk_client->cl_xprt
 
 /* support walking a list of tasks on a wait queue */
-#define	task_for_each(task, pos, head) \
-	list_for_each(pos, head) \
-		if ((task=list_entry(pos, struct rpc_task, tk_list)),1)
+#define	task_for_each(task, head) \
+	list_for_each_entry(task, head, tk_list)
 
+/* FIXME: Exposed "if" in macro is dangerous. */
 #define	task_for_first(task, head) \
 	if (!list_empty(head) &&  \
 	    ((task=list_entry((head)->next, struct rpc_task, tk_list)),1))
 
 /* .. and walking list of all tasks */
 #define	alltask_for_each(task, pos, head) \
-	list_for_each(pos, head) \
-		if ((task=list_entry(pos, struct rpc_task, tk_task)),1)
+	list_for_each_entry(task, head, tk_task)
 
 typedef void			(*rpc_action)(struct rpc_task *);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.4.21-pre4/net/sunrpc/sched.c working-2.4.21-pre4-rest-non_drivers/net/sunrpc/sched.c
--- linux-2.4.21-pre4/net/sunrpc/sched.c	2002-12-02 17:33:51.000000000 +1100
+++ working-2.4.21-pre4-rest-non_drivers/net/sunrpc/sched.c	2003-02-11 16:06:05.000000000 +1100
@@ -886,10 +886,9 @@ static inline struct rpc_task *
 rpc_find_parent(struct rpc_task *child)
 {
 	struct rpc_task	*task, *parent;
-	struct list_head *le;
 
 	parent = (struct rpc_task *) child->tk_calldata;
-	task_for_each(task, le, &childq.tasks)
+	task_for_each(task, &childq.tasks)
 		if (task == parent)
 			return parent;
 
@@ -947,7 +946,6 @@ void
 rpc_killall_tasks(struct rpc_clnt *clnt)
 {
 	struct rpc_task	*rovr;
-	struct list_head *le;
 
 	dprintk("RPC:      killing all tasks for client %p\n", clnt);
 
@@ -955,7 +953,7 @@ rpc_killall_tasks(struct rpc_clnt *clnt)
 	 * Spin lock all_tasks to prevent changes...
 	 */
 	spin_lock(&rpc_sched_lock);
-	alltask_for_each(rovr, le, &all_tasks)
+	alltask_for_each(rovr, &all_tasks)
 		if (!clnt || rovr->tk_client == clnt) {
 			rovr->tk_flags |= RPC_TASK_KILLED;
 			rpc_exit(rovr, -EIO);
@@ -1138,7 +1136,6 @@ out:
 #ifdef RPC_DEBUG
 void rpc_show_tasks(void)
 {
-	struct list_head *le;
 	struct rpc_task *t;
 
 	spin_lock(&rpc_sched_lock);
@@ -1148,7 +1145,7 @@ void rpc_show_tasks(void)
 	}
 	printk("-pid- proc flgs status -client- -prog- --rqstp- -timeout "
 		"-rpcwait -action- --exit--\n");
-	alltask_for_each(t, le, &all_tasks)
+	alltask_for_each(t, &all_tasks)
 		printk("%05d %04d %04x %06d %8p %6d %8p %08ld %8s %8p %8p\n",
 			t->tk_pid, t->tk_msg.rpc_proc, t->tk_flags, t->tk_status,
 			t->tk_client, t->tk_client->cl_prog,
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
