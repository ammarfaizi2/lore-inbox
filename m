Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbVJaCFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbVJaCFR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 21:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVJaCFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 21:05:16 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:12767 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751181AbVJaCFP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 21:05:15 -0500
Date: Sun, 30 Oct 2005 18:05:36 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, oleg@tv-sign.ru, dipankar@in.ibm.com,
       suzannew@cs.pdx.edu
Subject: [PATCH] Fixes for RCU handling of task_struct
Message-ID: <20051031020535.GA46@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

My earlier code that applies RCU to the task list (in PREEMPT_RT)
was missing some rcu_dereference() and rcu_assign_pointer() calls.
This patch fixes these problems.

Signed-off-by: <paulmck@us.ibm.com>

---

 include/linux/list.h |   20 ++++++++++++++++++++
 kernel/pid.c         |   20 ++++++++++----------
 2 files changed, 30 insertions(+), 10 deletions(-)

diff -urpNa -X dontdiff linux-2.6.14-rc5-rt2/include/linux/list.h linux-2.6.14-rc5-rt2-RCUusefix/include/linux/list.h
--- linux-2.6.14-rc5-rt2/include/linux/list.h	2005-10-22 14:41:46.000000000 -0700
+++ linux-2.6.14-rc5-rt2-RCUusefix/include/linux/list.h	2005-10-27 11:02:53.000000000 -0700
@@ -208,6 +208,7 @@ static inline void list_replace_rcu(stru
 	smp_wmb();
 	new->next->prev = new;
 	new->prev->next = new;
+	old->prev = LIST_POISON2;
 }
 
 /**
@@ -578,6 +579,25 @@ static inline void hlist_del_init(struct
 	}
 }
 
+/*
+ * hlist_replace_rcu - replace old entry by new one
+ * @old : the element to be replaced
+ * @new : the new element to insert
+ *
+ * The old entry will be replaced with the new entry atomically.
+ */
+static inline void hlist_replace_rcu(struct hlist_node *old, struct hlist_node *new){
+	struct hlist_node *next = old->next;
+
+	new->next = next;
+	new->pprev = old->pprev;
+	smp_wmb();
+	if (next)
+		new->next->pprev = &new->next;
+	*new->pprev = new;
+	old->pprev = LIST_POISON2;
+}
+
 static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
 {
 	struct hlist_node *first = h->first;
diff -urpNa -X dontdiff linux-2.6.14-rc5-rt2/kernel/pid.c linux-2.6.14-rc5-rt2-RCUusefix/kernel/pid.c
--- linux-2.6.14-rc5-rt2/kernel/pid.c	2005-10-22 14:45:56.000000000 -0700
+++ linux-2.6.14-rc5-rt2-RCUusefix/kernel/pid.c	2005-10-27 11:12:15.000000000 -0700
@@ -136,7 +136,7 @@ struct pid * fastcall find_pid(enum pid_
 	struct hlist_node *elem;
 	struct pid *pid;
 
-	hlist_for_each_entry(pid, elem,
+	hlist_for_each_entry_rcu(pid, elem,
 			&pid_hash[type][pid_hashfn(nr)], pid_chain) {
 		if (pid->nr == nr)
 			return pid;
@@ -151,12 +151,12 @@ int fastcall attach_pid(task_t *task, en
 	task_pid = &task->pids[type];
 	pid = find_pid(type, nr);
 	if (pid == NULL) {
-		hlist_add_head(&task_pid->pid_chain,
-				&pid_hash[type][pid_hashfn(nr)]);
 		INIT_LIST_HEAD(&task_pid->pid_list);
+		hlist_add_head_rcu(&task_pid->pid_chain,
+				   &pid_hash[type][pid_hashfn(nr)]);
 	} else {
 		INIT_HLIST_NODE(&task_pid->pid_chain);
-		list_add_tail(&task_pid->pid_list, &pid->pid_list);
+		list_add_tail_rcu(&task_pid->pid_list, &pid->pid_list);
 	}
 	task_pid->nr = nr;
 
@@ -170,20 +170,20 @@ static fastcall int __detach_pid(task_t 
 
 	pid = &task->pids[type];
 	if (!hlist_unhashed(&pid->pid_chain)) {
-		hlist_del(&pid->pid_chain);
 
-		if (list_empty(&pid->pid_list))
+		if (list_empty(&pid->pid_list)) {
 			nr = pid->nr;
-		else {
+			hlist_del_rcu(&pid->pid_chain);
+		} else {
 			pid_next = list_entry(pid->pid_list.next,
 						struct pid, pid_list);
 			/* insert next pid from pid_list to hash */
-			hlist_add_head(&pid_next->pid_chain,
-				&pid_hash[type][pid_hashfn(pid_next->nr)]);
+			hlist_replace_rcu(&pid->pid_chain,
+					  &pid_next->pid_chain);
 		}
 	}
 
-	list_del(&pid->pid_list);
+	list_del_rcu(&pid->pid_list);
 	pid->nr = 0;
 
 	return nr;
