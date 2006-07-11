Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbWGKE1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbWGKE1y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965141AbWGKE1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:27:54 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:51175 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965139AbWGKE1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:27:53 -0400
Subject: [Patch 1/6] per task delay accounting taskstats interface: code
	cleanup
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jay Lan <jlan@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Paul Jackson <pj@sgi.com>,
       Balbir Singh <balbir@in.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>
In-Reply-To: <1152591838.14142.114.camel@localhost.localdomain>
References: <1152591838.14142.114.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Message-Id: <1152592070.14142.119.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 11 Jul 2006 00:27:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup cpumask related code and rearrange functions for clarity

Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>

 include/linux/taskstats_kern.h |    5 ---
 kernel/taskstats.c             |   53 ++++++++++++++++++++++-------------------
 2 files changed, 29 insertions(+), 29 deletions(-)

Index: linux-2.6.18-rc1/include/linux/taskstats_kern.h
===================================================================
--- linux-2.6.18-rc1.orig/include/linux/taskstats_kern.h	2006-07-10 23:44:14.000000000 -0400
+++ linux-2.6.18-rc1/include/linux/taskstats_kern.h	2006-07-10 23:44:16.000000000 -0400
@@ -11,11 +11,6 @@
 #include <linux/sched.h>
 #include <net/genetlink.h>
 
-enum {
-	TASKSTATS_MSG_UNICAST,		/* send data only to requester */
-	TASKSTATS_MSG_MULTICAST,	/* send data to a group */
-};
-
 #ifdef CONFIG_TASKSTATS
 extern kmem_cache_t *taskstats_cache;
 extern struct mutex taskstats_exit_mutex;
Index: linux-2.6.18-rc1/kernel/taskstats.c
===================================================================
--- linux-2.6.18-rc1.orig/kernel/taskstats.c	2006-07-10 23:44:14.000000000 -0400
+++ linux-2.6.18-rc1/kernel/taskstats.c	2006-07-10 23:44:16.000000000 -0400
@@ -99,35 +99,45 @@ static int prepare_reply(struct genl_inf
 	return 0;
 }
 
-static int send_reply(struct sk_buff *skb, pid_t pid, int event, unsigned int cpu)
+/*
+ * Send taskstats data in @skb to listener with nl_pid @pid
+ */
+static int send_reply(struct sk_buff *skb, pid_t pid)
 {
 	struct genlmsghdr *genlhdr = nlmsg_data((struct nlmsghdr *)skb->data);
-	struct listener_list *listeners;
-	struct list_head *p, *tmp;
-	void *reply;
+	void *reply = genlmsg_data(genlhdr);
 	int rc;
 
-	reply = genlmsg_data(genlhdr);
-
 	rc = genlmsg_end(skb, reply);
 	if (rc < 0) {
 		nlmsg_free(skb);
 		return rc;
 	}
 
-	if (event == TASKSTATS_MSG_UNICAST)
-		return genlmsg_unicast(skb, pid);
+	return genlmsg_unicast(skb, pid);
+}
 
-	/*
-	 * Taskstats multicast is unicasts to listeners who have registered
-	 * interest in cpu
-	 */
+/*
+ * Send taskstats data in @skb to listeners registered for @cpu's exit data
+ */
+static int send_cpu_listeners(struct sk_buff *skb, unsigned int cpu)
+{
+	struct genlmsghdr *genlhdr = nlmsg_data((struct nlmsghdr *)skb->data);
+	struct listener_list *listeners;
+	struct listener *s, *tmp;
+	void *reply = genlmsg_data(genlhdr);
+	int rc, ret;
+
+	rc = genlmsg_end(skb, reply);
+	if (rc < 0) {
+		nlmsg_free(skb);
+		return rc;
+	}
 
+	rc = 0;
 	listeners = &per_cpu(listener_array, cpu);
 	down_write(&listeners->sem);
-	list_for_each_safe(p, tmp, &listeners->list) {
-		int ret;
-		struct listener *s = list_entry(p, struct listener, list);
+	list_for_each_entry_safe(s, tmp, &listeners->list, list) {
 		ret = genlmsg_unicast(skb, s->pid);
 		if (ret) {
 			list_del(&s->list);
@@ -253,11 +263,10 @@ ret:
 
 static int add_del_listener(pid_t pid, cpumask_t *maskp, int isadd)
 {
-	struct listener *s;
 	struct listener_list *listeners;
+	struct listener *s, *tmp;
 	unsigned int cpu;
 	cpumask_t mask = *maskp;
-	struct list_head *p;
 
 	if (!cpus_subset(mask, cpu_possible_map))
 		return -EINVAL;
@@ -282,12 +291,9 @@ static int add_del_listener(pid_t pid, c
 	/* Deregister or cleanup */
 cleanup:
 	for_each_cpu_mask(cpu, mask) {
-		struct list_head *tmp;
-
 		listeners = &per_cpu(listener_array, cpu);
 		down_write(&listeners->sem);
-		list_for_each_safe(p, tmp, &listeners->list) {
-			s = list_entry(p, struct listener, list);
+		list_for_each_entry_safe(s, tmp, &listeners->list, list) {
 			if (s->pid == pid) {
 				list_del(&s->list);
 				kfree(s);
@@ -376,8 +382,7 @@ static int taskstats_user_cmd(struct sk_
 
 	nla_nest_end(rep_skb, na);
 
-	return send_reply(rep_skb, info->snd_pid, TASKSTATS_MSG_UNICAST,
-			  CPU_DONT_CARE);
+	return send_reply(rep_skb, info->snd_pid);
 
 nla_put_failure:
 	return genlmsg_cancel(rep_skb, reply);
@@ -475,7 +480,7 @@ void taskstats_exit_send(struct task_str
 	nla_nest_end(rep_skb, na);
 
 send:
-	send_reply(rep_skb, 0, TASKSTATS_MSG_MULTICAST, mycpu);
+	send_cpu_listeners(rep_skb, mycpu);
 	return;
 
 nla_put_failure:


