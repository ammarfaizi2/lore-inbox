Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWGFLhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWGFLhu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 07:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965192AbWGFLhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 07:37:50 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:13234 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965184AbWGFLhs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 07:37:48 -0400
Subject: Re: [PATCH] per-task delay accounting taskstats interface: control
	exit data through cpumasks]
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Jay Lan <jlan@sgi.com>, pj@sgi.com, Valdis.Kletnieks@vt.edu,
       Balbir Singh <balbir@in.ibm.com>, csturtiv@sgi.com,
       linux-kernel <linux-kernel@vger.kernel.org>, Jamal <hadi@cyberus.ca>,
       netdev <netdev@vger.kernel.org>
In-Reply-To: <20060706025633.cd4b1c1d.akpm@osdl.org>
References: <44ACD7C3.5040008@watson.ibm.com>
	 <20060706025633.cd4b1c1d.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM
Message-Id: <1152185865.5986.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 06 Jul 2006 07:37:45 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On systems with a large number of cpus, with even a modest rate of 
tasks exiting per cpu, the volume of taskstats data sent on thread exit
can overflow a userspace listener's buffers.

One approach to avoiding overflow is to allow listeners to get data for
a limited and specific set of cpus. By scaling the number of listeners 
and/or the cpus they monitor, userspace can handle the statistical data
overload more gracefully.

In this patch, each listener registers to listen to a specific set of 
cpus by specifying a cpumask.  The interest is recorded per-cpu. When 
a task exits on a cpu, its taskstats data is unicast to each listener 
interested in that cpu.

Thanks to Andrew Morton for pointing out the various scalability and 
general concerns of previous attempts and for suggesting this design.

Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>
---

Addresses various comments by akpm:
- fix your email client !
- avoid memcpy of cpumask
- handle ENOMEM within add_del_listener properly
- check return value of cpulist_parse
- exploit kfree(NULL)

Does not address (can't see an easy way to do)
- try to avoid allocating two cpumask's on stack from taskstats_user_cmd 

Tested on a 1-way and works ok. Testing on 2/4 way being done.


 include/linux/taskstats.h      |    4 
 include/linux/taskstats_kern.h |   22 -----
 kernel/exit.c                  |    5 -
 kernel/taskstats.c             |  168 ++++++++++++++++++++++++++++++++++++++---
 4 files changed, 168 insertions(+), 31 deletions(-)

Index: linux-2.6.17-mm3equiv/include/linux/taskstats.h
===================================================================
--- linux-2.6.17-mm3equiv.orig/include/linux/taskstats.h	2006-06-30 19:03:40.000000000 -0400
+++ linux-2.6.17-mm3equiv/include/linux/taskstats.h	2006-07-06 06:48:10.000000000 -0400
@@ -87,8 +87,6 @@ struct taskstats {
 };
 
 
-#define TASKSTATS_LISTEN_GROUP	0x1
-
 /*
  * Commands sent from userspace
  * Not versioned. New commands should only be inserted at the enum's end
@@ -120,6 +118,8 @@ enum {
 	TASKSTATS_CMD_ATTR_UNSPEC = 0,
 	TASKSTATS_CMD_ATTR_PID,
 	TASKSTATS_CMD_ATTR_TGID,
+	TASKSTATS_CMD_ATTR_REGISTER_CPUMASK,
+	TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK,
 	__TASKSTATS_CMD_ATTR_MAX,
 };
 
Index: linux-2.6.17-mm3equiv/include/linux/taskstats_kern.h
===================================================================
--- linux-2.6.17-mm3equiv.orig/include/linux/taskstats_kern.h	2006-06-30 11:57:14.000000000 -0400
+++ linux-2.6.17-mm3equiv/include/linux/taskstats_kern.h	2006-07-06 06:48:10.000000000 -0400
@@ -20,21 +20,6 @@ enum {
 extern kmem_cache_t *taskstats_cache;
 extern struct mutex taskstats_exit_mutex;
 
-static inline int taskstats_has_listeners(void)
-{
-	if (!genl_sock)
-		return 0;
-	return netlink_has_listeners(genl_sock, TASKSTATS_LISTEN_GROUP);
-}
-
-
-static inline void taskstats_exit_alloc(struct taskstats **ptidstats)
-{
-	*ptidstats = NULL;
-	if (taskstats_has_listeners())
-		*ptidstats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
-}
-
 static inline void taskstats_exit_free(struct taskstats *tidstats)
 {
 	if (tidstats)
@@ -79,17 +64,18 @@ static inline void taskstats_tgid_free(s
 		kmem_cache_free(taskstats_cache, stats);
 }
 
-extern void taskstats_exit_send(struct task_struct *, struct taskstats *, int);
+extern void taskstats_exit_alloc(struct taskstats **, unsigned int *);
+extern void taskstats_exit_send(struct task_struct *, struct taskstats *, int, unsigned int);
 extern void taskstats_init_early(void);
 extern void taskstats_tgid_alloc(struct signal_struct *);
 #else
-static inline void taskstats_exit_alloc(struct taskstats **ptidstats)
+static inline void taskstats_exit_alloc(struct taskstats **ptidstats, unsigned int *mycpu)
 {}
 static inline void taskstats_exit_free(struct taskstats *ptidstats)
 {}
 static inline void taskstats_exit_send(struct task_struct *tsk,
 				       struct taskstats *tidstats,
-				       int group_dead)
+				       int group_dead, unsigned int cpu)
 {}
 static inline void taskstats_tgid_init(struct signal_struct *sig)
 {}
Index: linux-2.6.17-mm3equiv/kernel/taskstats.c
===================================================================
--- linux-2.6.17-mm3equiv.orig/kernel/taskstats.c	2006-06-30 23:38:39.000000000 -0400
+++ linux-2.6.17-mm3equiv/kernel/taskstats.c	2006-07-06 07:02:54.000000000 -0400
@@ -19,9 +19,17 @@
 #include <linux/kernel.h>
 #include <linux/taskstats_kern.h>
 #include <linux/delayacct.h>
+#include <linux/cpumask.h>
+#include <linux/percpu.h>
 #include <net/genetlink.h>
 #include <asm/atomic.h>
 
+/*
+ * Maximum length of a cpumask that can be specified in
+ * the TASKSTATS_CMD_ATTR_REGISTER/DEREGISTER_CPUMASK attribute
+ */
+#define TASKSTATS_CPUMASK_MAXLEN	(100+6*NR_CPUS)
+
 static DEFINE_PER_CPU(__u32, taskstats_seqnum) = { 0 };
 static int family_registered = 0;
 kmem_cache_t *taskstats_cache;
@@ -37,9 +45,26 @@ static struct nla_policy taskstats_cmd_g
 __read_mostly = {
 	[TASKSTATS_CMD_ATTR_PID]  = { .type = NLA_U32 },
 	[TASKSTATS_CMD_ATTR_TGID] = { .type = NLA_U32 },
+	[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK] = { .type = NLA_STRING },
+	[TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK] = { .type = NLA_STRING },};
+
+struct listener {
+	struct list_head list;
+	pid_t pid;
 };
 
+struct listener_list {
+	struct rw_semaphore sem;
+	struct list_head list;
+};
+static DEFINE_PER_CPU(struct listener_list, listener_array);
 
+enum actions {
+	REGISTER,
+	DEREGISTER,
+	CPU_DONT_CARE
+};
+
 static int prepare_reply(struct genl_info *info, u8 cmd, struct sk_buff **skbp,
 			void **replyp, size_t size)
 {
@@ -74,9 +99,11 @@ static int prepare_reply(struct genl_inf
 	return 0;
 }
 
-static int send_reply(struct sk_buff *skb, pid_t pid, int event)
+static int send_reply(struct sk_buff *skb, pid_t pid, int event, unsigned int cpu)
 {
 	struct genlmsghdr *genlhdr = nlmsg_data((struct nlmsghdr *)skb->data);
+	struct listener_list *listeners;
+	struct list_head *p, *tmp;
 	void *reply;
 	int rc;
 
@@ -88,9 +115,29 @@ static int send_reply(struct sk_buff *sk
 		return rc;
 	}
 
-	if (event == TASKSTATS_MSG_MULTICAST)
-		return genlmsg_multicast(skb, pid, TASKSTATS_LISTEN_GROUP);
-	return genlmsg_unicast(skb, pid);
+	if (event == TASKSTATS_MSG_UNICAST)
+		return genlmsg_unicast(skb, pid);
+
+	/*
+	 * Taskstats multicast is unicasts to listeners who have registered
+	 * interest in cpu
+	 */
+
+	listeners = &per_cpu(listener_array, cpu);
+	down_write(&listeners->sem);
+	list_for_each_safe(p, tmp, &listeners->list) {
+		int ret;
+		struct listener *s = list_entry(p, struct listener, list);
+		ret = genlmsg_unicast(skb, s->pid);
+		if (ret) {
+			list_del(&s->list);
+			kfree(s);
+			rc = ret;
+		}
+	}
+	up_write(&listeners->sem);
+
+	return rc;
 }
 
 static int fill_pid(pid_t pid, struct task_struct *pidtsk,
@@ -201,8 +248,55 @@ ret:
 	return;
 }
 
+static int add_del_listener(pid_t pid, cpumask_t *maskp, int isadd)
+{
+	struct listener *s;
+	struct listener_list *listeners;
+	unsigned int cpu;
+	cpumask_t mask = *maskp;
+	struct list_head *p;
+
+	if (!cpus_subset(mask, cpu_possible_map))
+		return -EINVAL;
+
+	if (isadd == REGISTER) {
+		for_each_cpu_mask(cpu, mask) {
+			s = kmalloc_node(sizeof(struct listener), GFP_KERNEL,
+					 cpu_to_node(cpu));
+			if (!s)
+				goto cleanup;
+			s->pid = pid;
+			INIT_LIST_HEAD(&s->list);
+
+			listeners = &per_cpu(listener_array, cpu);
+			down_write(&listeners->sem);
+			list_add(&s->list, &listeners->list);
+			up_write(&listeners->sem);
+		}
+		return 0;
+	}
+
+	/* Deregister or cleanup */
+cleanup:
+	for_each_cpu_mask(cpu, mask) {
+		struct list_head *tmp;
+
+		listeners = &per_cpu(listener_array, cpu);
+		down_write(&listeners->sem);
+		list_for_each_safe(p, tmp, &listeners->list) {
+			s = list_entry(p, struct listener, list);
+			if (s->pid == pid) {
+				list_del(&s->list);
+				kfree(s);
+				break;
+			}
+		}
+		up_write(&listeners->sem);
+	}
+	return 0;
+}
 
-static int taskstats_send_stats(struct sk_buff *skb, struct genl_info *info)
+static int taskstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
 {
 	int rc = 0;
 	struct sk_buff *rep_skb;
@@ -210,6 +304,29 @@ static int taskstats_send_stats(struct s
 	void *reply;
 	size_t size;
 	struct nlattr *na;
+	cpumask_t mask;
+
+	if (info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK]) {
+		na = info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK];
+		if (nla_len(na) > TASKSTATS_CPUMASK_MAXLEN)
+			return -E2BIG;
+		rc = cpulist_parse((char *)nla_data(na), mask);
+		if (rc)
+			return rc;
+		rc = add_del_listener(info->snd_pid, &mask, REGISTER);
+		return rc;
+	}
+
+	if (info->attrs[TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK]) {
+		na = info->attrs[TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK];
+		if (nla_len(na) > TASKSTATS_CPUMASK_MAXLEN)
+			return -E2BIG;
+		rc = cpulist_parse((char *)nla_data(na), mask);
+		if (rc)
+			return rc;
+		rc = add_del_listener(info->snd_pid, &mask, DEREGISTER);
+		return rc;
+	}
 
 	/*
 	 * Size includes space for nested attributes
@@ -249,7 +366,8 @@ static int taskstats_send_stats(struct s
 
 	nla_nest_end(rep_skb, na);
 
-	return send_reply(rep_skb, info->snd_pid, TASKSTATS_MSG_UNICAST);
+	return send_reply(rep_skb, info->snd_pid, TASKSTATS_MSG_UNICAST,
+			  CPU_DONT_CARE);
 
 nla_put_failure:
 	return genlmsg_cancel(rep_skb, reply);
@@ -258,9 +376,35 @@ err:
 	return rc;
 }
 
+void taskstats_exit_alloc(struct taskstats **ptidstats, unsigned int *mycpu)
+{
+	struct listener_list *listeners;
+	struct taskstats *tmp;
+	/*
+	 * This is the cpu on which the task is exiting currently and will
+	 * be the one for which the exit event is sent, even if the cpu
+	 * on which this function is running changes later.
+	 */
+	*mycpu = raw_smp_processor_id();
+
+	*ptidstats = NULL;
+	tmp = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
+	if (!tmp)
+		return;
+
+	listeners = &per_cpu(listener_array, *mycpu);
+	down_read(&listeners->sem);
+	if (!list_empty(&listeners->list)) {
+		*ptidstats = tmp;
+		tmp = NULL;
+	}
+	up_read(&listeners->sem);
+	kfree(tmp);
+}
+
 /* Send pid data out on exit */
 void taskstats_exit_send(struct task_struct *tsk, struct taskstats *tidstats,
-			int group_dead)
+			int group_dead, unsigned int mycpu)
 {
 	int rc;
 	struct sk_buff *rep_skb;
@@ -320,7 +464,7 @@ void taskstats_exit_send(struct task_str
 	nla_nest_end(rep_skb, na);
 
 send:
-	send_reply(rep_skb, 0, TASKSTATS_MSG_MULTICAST);
+	send_reply(rep_skb, 0, TASKSTATS_MSG_MULTICAST, mycpu);
 	return;
 
 nla_put_failure:
@@ -334,7 +478,7 @@ ret:
 
 static struct genl_ops taskstats_ops = {
 	.cmd		= TASKSTATS_CMD_GET,
-	.doit		= taskstats_send_stats,
+	.doit		= taskstats_user_cmd,
 	.policy		= taskstats_cmd_get_policy,
 };
 
@@ -349,6 +493,7 @@ void __init taskstats_init_early(void)
 static int __init taskstats_init(void)
 {
 	int rc;
+	unsigned int i;
 
 	rc = genl_register_family(&family);
 	if (rc)
@@ -358,6 +503,11 @@ static int __init taskstats_init(void)
 	rc = genl_register_ops(&family, &taskstats_ops);
 	if (rc < 0)
 		goto err;
+
+	for_each_possible_cpu(i) {
+		INIT_LIST_HEAD(&(per_cpu(listener_array, i).list));
+		init_rwsem(&(per_cpu(listener_array, i).sem));
+	}
 
 	return 0;
 err:
Index: linux-2.6.17-mm3equiv/kernel/exit.c
===================================================================
--- linux-2.6.17-mm3equiv.orig/kernel/exit.c	2006-06-28 16:09:01.000000000 -0400
+++ linux-2.6.17-mm3equiv/kernel/exit.c	2006-07-05 16:22:50.000000000 -0400
@@ -852,6 +852,7 @@ fastcall NORET_TYPE void do_exit(long co
 	struct task_struct *tsk = current;
 	struct taskstats *tidstats;
 	int group_dead;
+	unsigned int mycpu;
 
 	profile_task_exit(tsk);
 
@@ -889,7 +890,7 @@ fastcall NORET_TYPE void do_exit(long co
 				current->comm, current->pid,
 				preempt_count());
 
-	taskstats_exit_alloc(&tidstats);
+	taskstats_exit_alloc(&tidstats, &mycpu);
 
 	acct_update_integrals(tsk);
 	if (tsk->mm) {
@@ -910,7 +911,7 @@ fastcall NORET_TYPE void do_exit(long co
 #endif
 	if (unlikely(tsk->audit_context))
 		audit_free(tsk);
-	taskstats_exit_send(tsk, tidstats, group_dead);
+	taskstats_exit_send(tsk, tidstats, group_dead, mycpu);
 	taskstats_exit_free(tidstats);
 	delayacct_tsk_exit(tsk);
 


