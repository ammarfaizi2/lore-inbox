Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423270AbWJaNuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423270AbWJaNuG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 08:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423272AbWJaNuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 08:50:05 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:13191 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1423274AbWJaNuE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 08:50:04 -0500
Date: Tue, 31 Oct 2006 16:49:38 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
       Jay Lan <jlan@sgi.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] taskstats: cleanup do_exit() path
Message-ID: <20061031134938.GA3098@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_exit:
	taskstats_exit_alloc()
	...
	taskstats_exit_send()
	taskstats_exit_free()

I think this is not good, let it be a single function exported to the core
kernel, taskstats_exit(), which does alloc + send + free itself.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

 include/linux/taskstats_kern.h |   17 ++---------------
 kernel/exit.c                  |    8 ++------
 kernel/taskstats.c             |   41 +++++++++++++++--------------------------
 3 files changed, 19 insertions(+), 47 deletions(-)

--- STATS/include/linux/taskstats_kern.h~3_exit	2006-10-27 02:13:11.000000000 +0400
+++ STATS/include/linux/taskstats_kern.h	2006-10-31 14:39:32.000000000 +0300
@@ -15,12 +15,6 @@
 extern kmem_cache_t *taskstats_cache;
 extern struct mutex taskstats_exit_mutex;
 
-static inline void taskstats_exit_free(struct taskstats *tidstats)
-{
-	if (tidstats)
-		kmem_cache_free(taskstats_cache, tidstats);
-}
-
 static inline void taskstats_tgid_init(struct signal_struct *sig)
 {
 	sig->stats = NULL;
@@ -54,17 +48,10 @@ static inline void taskstats_tgid_free(s
 		kmem_cache_free(taskstats_cache, sig->stats);
 }
 
-extern void taskstats_exit_alloc(struct taskstats **, unsigned int *);
-extern void taskstats_exit_send(struct task_struct *, struct taskstats *, int, unsigned int);
+extern void taskstats_exit(struct task_struct *, int group_dead);
 extern void taskstats_init_early(void);
 #else
-static inline void taskstats_exit_alloc(struct taskstats **ptidstats, unsigned int *mycpu)
-{}
-static inline void taskstats_exit_free(struct taskstats *ptidstats)
-{}
-static inline void taskstats_exit_send(struct task_struct *tsk,
-				       struct taskstats *tidstats,
-				       int group_dead, unsigned int cpu)
+static inline void taskstats_exit(struct task_struct *tsk, int group_dead)
 {}
 static inline void taskstats_tgid_init(struct signal_struct *sig)
 {}
--- STATS/kernel/exit.c~3_exit	2006-10-27 01:34:15.000000000 +0400
+++ STATS/kernel/exit.c	2006-10-31 14:43:01.000000000 +0300
@@ -850,9 +850,7 @@ static void exit_notify(struct task_stru
 fastcall NORET_TYPE void do_exit(long code)
 {
 	struct task_struct *tsk = current;
-	struct taskstats *tidstats;
 	int group_dead;
-	unsigned int mycpu;
 
 	profile_task_exit(tsk);
 
@@ -890,8 +888,6 @@ fastcall NORET_TYPE void do_exit(long co
 				current->comm, current->pid,
 				preempt_count());
 
-	taskstats_exit_alloc(&tidstats, &mycpu);
-
 	acct_update_integrals(tsk);
 	if (tsk->mm) {
 		update_hiwater_rss(tsk->mm);
@@ -911,8 +907,8 @@ fastcall NORET_TYPE void do_exit(long co
 #endif
 	if (unlikely(tsk->audit_context))
 		audit_free(tsk);
-	taskstats_exit_send(tsk, tidstats, group_dead, mycpu);
-	taskstats_exit_free(tidstats);
+
+	taskstats_exit(tsk, group_dead);
 
 	exit_mm(tsk);
 
--- STATS/kernel/taskstats.c~3_exit	2006-10-31 01:02:09.000000000 +0300
+++ STATS/kernel/taskstats.c	2006-10-31 15:25:06.000000000 +0300
@@ -124,10 +124,10 @@ static int send_reply(struct sk_buff *sk
 /*
  * Send taskstats data in @skb to listeners registered for @cpu's exit data
  */
-static void send_cpu_listeners(struct sk_buff *skb, unsigned int cpu)
+static void send_cpu_listeners(struct sk_buff *skb,
+					struct listener_list *listeners)
 {
 	struct genlmsghdr *genlhdr = nlmsg_data((struct nlmsghdr *)skb->data);
-	struct listener_list *listeners;
 	struct listener *s, *tmp;
 	struct sk_buff *skb_next, *skb_cur = skb;
 	void *reply = genlmsg_data(genlhdr);
@@ -140,7 +140,6 @@ static void send_cpu_listeners(struct sk
 	}
 
 	rc = 0;
-	listeners = &per_cpu(listener_array, cpu);
 	down_read(&listeners->sem);
 	list_for_each_entry(s, &listeners->list, list) {
 		skb_next = NULL;
@@ -418,28 +417,12 @@ err:
 	return rc;
 }
 
-void taskstats_exit_alloc(struct taskstats **ptidstats, unsigned int *mycpu)
-{
-	struct listener_list *listeners;
-	/*
-	 * This is the cpu on which the task is exiting currently and will
-	 * be the one for which the exit event is sent, even if the cpu
-	 * on which this function is running changes later.
-	 */
-	*mycpu = raw_smp_processor_id();
-
-	listeners = &per_cpu(listener_array, *mycpu);
-
-	*ptidstats = NULL;
-	if (!list_empty(&listeners->list))
-		*ptidstats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
-}
-
 /* Send pid data out on exit */
-void taskstats_exit_send(struct task_struct *tsk, struct taskstats *tidstats,
-			int group_dead, unsigned int mycpu)
+void taskstats_exit(struct task_struct *tsk, int group_dead)
 {
 	int rc;
+	struct listener_list *listeners;
+	struct taskstats *tidstats;
 	struct sk_buff *rep_skb;
 	void *reply;
 	size_t size;
@@ -463,12 +446,17 @@ void taskstats_exit_send(struct task_str
 		fill_tgid_exit(tsk);
 	}
 
+	listeners = &__raw_get_cpu_var(listener_array);
+	if (list_empty(&listeners->list))
+		return;
+
+	tidstats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
 	if (!tidstats)
 		return;
 
 	rc = prepare_reply(NULL, TASKSTATS_CMD_NEW, &rep_skb, &reply, size);
 	if (rc < 0)
-		goto ret;
+		goto free_stats;
 
 	rc = fill_pid(tsk->pid, tsk, tidstats);
 	if (rc < 0)
@@ -497,15 +485,16 @@ void taskstats_exit_send(struct task_str
 	nla_nest_end(rep_skb, na);
 
 send:
-	send_cpu_listeners(rep_skb, mycpu);
+	send_cpu_listeners(rep_skb, listeners);
+free_stats:
+	kmem_cache_free(taskstats_cache, tidstats);
 	return;
 
 nla_put_failure:
 	genlmsg_cancel(rep_skb, reply);
 err_skb:
 	nlmsg_free(rep_skb);
-ret:
-	return;
+	goto free_stats;
 }
 
 static struct genl_ops taskstats_ops = {

