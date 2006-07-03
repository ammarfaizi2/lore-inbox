Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWGCVMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWGCVMI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWGCVMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:12:08 -0400
Received: from mta6.srv.hcvlny.cv.net ([167.206.4.201]:45152 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S932114AbWGCVMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:12:06 -0400
Date: Mon, 03 Jul 2006 17:11:59 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
In-reply-to: <20060630205148.4f66b125.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: pj@sgi.com, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org, hadi@cyberus.ca,
       netdev@vger.kernel.org
Message-id: <44A9881F.7030103@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <44892610.6040001@watson.ibm.com> <449C6620.1020203@engr.sgi.com>
 <20060623164743.c894c314.akpm@osdl.org> <449CAA78.4080902@watson.ibm.com>
 <20060623213912.96056b02.akpm@osdl.org> <449CD4B3.8020300@watson.ibm.com>
 <44A01A50.1050403@sgi.com> <20060626105548.edef4c64.akpm@osdl.org>
 <44A020CD.30903@watson.ibm.com> <20060626111249.7aece36e.akpm@osdl.org>
 <44A026ED.8080903@sgi.com> <20060626113959.839d72bc.akpm@osdl.org>
 <44A2F50D.8030306@engr.sgi.com> <20060628145341.529a61ab.akpm@osdl.org>
 <44A2FC72.9090407@engr.sgi.com> <20060629014050.d3bf0be4.pj@sgi.com>
 <200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
 <20060629094408.360ac157.pj@sgi.com> <20060629110107.2e56310b.akpm@osdl.org>
 <44A57310.3010208@watson.ibm.com> <44A5770F.3080206@watson.ibm.com>
 <20060630155030.5ea1faba.akpm@osdl.org> <44A5DBE7.2020704@watson.ibm.com>
 <44A5EDE6.3010605@watson.ibm.com> <20060630205148.4f66b125.akpm@osdl.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Fri, 30 Jun 2006 23:37:10 -0400
>Shailabh Nagar <nagar@watson.ibm.com> wrote:
>
>  
>
>>>Set aside the implementation details and ask "what is a good design"?
>>>
>>>A kernel-wide constant, whether determined at build-time or by a /proc poke
>>>isn't a nice design.
>>>
>>>Can we permit userspace to send in a netlink message describing a cpumask? 
>>>That's back-compatible.
>>> 
>>>
>>>      
>>>
>>Yes, that should be doable. And passing in a cpumask is much better 
>>since we no longer
>>have to maintain mappings.
>>
>>So the strawman is:
>>Listener bind()s to genetlink using its real pid.
>>Sends a separate "registration" message with cpumask to listen to. 
>>Kernel stores (real) pid and cpumask.
>>During task exit, kernel goes through each registered listener (small 
>>list) and decides which
>>one needs to get this exit data and calls a genetlink_unicast to each 
>>one that does need it.
>>
>>If number of listeners is small, the lookups should be swift enough. If 
>>it grows large, we
>>can consider a fancier lookup (but there I go again, delving into 
>>implementation too early :-)
>>    
>>
>
>We'll need a map.
>
>1024 CPUs, 1024 listeners, 1000 exits/sec/CPU and we're up to a million
>operations per second per CPU.  Meltdown.
>
>But it's a pretty simple map.  A per-cpu array of pointers to the head of a
>linked list.  One lock for each CPU's list.
>  
>
Here's a patch that implements the above ideas.

A listener register's interest by specifying a cpumask in the
cpulist format (comma separated ranges of cpus). The listener's pid
is entered into per-cpu lists for those cpus and exit events from those
cpus go to the listeners using netlink unicasts.

Please comment.

Andrew, this is not being proposed for inclusion yet since there is 
atleast one more issue that needs to be resolved:

What happens when a listener exits without doing deregistration
(or if the listener attempts to register another cpumask while a current
registration is still active).

More on that in a separate thread.

--Shailabh



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

 include/linux/taskstats.h      |    4 -
 include/linux/taskstats_kern.h |   12 ---
 kernel/taskstats.c             |  136 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 135 insertions(+), 17 deletions(-)

Index: linux-2.6.17-mm3equiv/include/linux/taskstats.h
===================================================================
--- linux-2.6.17-mm3equiv.orig/include/linux/taskstats.h	2006-06-30 19:03:40.000000000 -0400
+++ linux-2.6.17-mm3equiv/include/linux/taskstats.h	2006-07-01 23:53:01.000000000 -0400
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
+++ linux-2.6.17-mm3equiv/include/linux/taskstats_kern.h	2006-07-01 23:53:01.000000000 -0400
@@ -19,20 +19,14 @@ enum {
 #ifdef CONFIG_TASKSTATS
 extern kmem_cache_t *taskstats_cache;
 extern struct mutex taskstats_exit_mutex;
-
-static inline int taskstats_has_listeners(void)
-{
-	if (!genl_sock)
-		return 0;
-	return netlink_has_listeners(genl_sock, TASKSTATS_LISTEN_GROUP);
-}
-
+DECLARE_PER_CPU(struct list_head, listener_list);

 static inline void taskstats_exit_alloc(struct taskstats **ptidstats)
 {
 	*ptidstats = NULL;
-	if (taskstats_has_listeners())
+	if (!list_empty(&get_cpu_var(listener_list)))
 		*ptidstats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
+	put_cpu_var(listener_list);
 }

 static inline void taskstats_exit_free(struct taskstats *tidstats)
Index: linux-2.6.17-mm3equiv/kernel/taskstats.c
===================================================================
--- linux-2.6.17-mm3equiv.orig/kernel/taskstats.c	2006-06-30 23:38:39.000000000 -0400
+++ linux-2.6.17-mm3equiv/kernel/taskstats.c	2006-07-02 00:16:18.000000000 -0400
@@ -19,6 +19,8 @@
 #include <linux/kernel.h>
 #include <linux/taskstats_kern.h>
 #include <linux/delayacct.h>
+#include <linux/cpumask.h>
+#include <linux/percpu.h>
 #include <net/genetlink.h>
 #include <asm/atomic.h>

@@ -26,6 +28,9 @@ static DEFINE_PER_CPU(__u32, taskstats_s
 static int family_registered = 0;
 kmem_cache_t *taskstats_cache;

+DEFINE_PER_CPU(struct list_head, listener_list);
+static DEFINE_PER_CPU(struct rw_semaphore, listener_list_sem);
+
 static struct genl_family family = {
 	.id		= GENL_ID_GENERATE,
 	.name		= TASKSTATS_GENL_NAME,
@@ -37,9 +42,19 @@ static struct nla_policy taskstats_cmd_g
 __read_mostly = {
 	[TASKSTATS_CMD_ATTR_PID]  = { .type = NLA_U32 },
 	[TASKSTATS_CMD_ATTR_TGID] = { .type = NLA_U32 },
-};
+	[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK] = { .type = NLA_STRING },
+	[TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK] = { .type = NLA_STRING },};

+struct listener {
+	struct list_head list;
+	pid_t pid;
+};

+enum actions {
+	REGISTER,
+	DEREGISTER
+};
+
 static int prepare_reply(struct genl_info *info, u8 cmd, struct sk_buff **skbp,
 			void **replyp, size_t size)
 {
@@ -77,6 +92,8 @@ static int prepare_reply(struct genl_inf
 static int send_reply(struct sk_buff *skb, pid_t pid, int event)
 {
 	struct genlmsghdr *genlhdr = nlmsg_data((struct nlmsghdr *)skb->data);
+	struct rw_semaphore *sem;
+	struct list_head *p, *head;
 	void *reply;
 	int rc;

@@ -88,9 +105,30 @@ static int send_reply(struct sk_buff *sk
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
+	 * interest in this cpu
+	 */
+	sem = &get_cpu_var(listener_list_sem);
+	head = &get_cpu_var(listener_list);
+
+	down_read(sem);
+	list_for_each(p, head) {
+		int ret;
+		struct listener *s = list_entry(p, struct listener, list);
+		ret = genlmsg_unicast(skb, s->pid);
+		if (ret)
+			rc = ret;
+	}
+	up_read(sem);
+
+	put_cpu_var(listener_list);
+	put_cpu_var(listener_list_sem);
+
+	return rc;
 }

 static int fill_pid(pid_t pid, struct task_struct *pidtsk,
@@ -201,8 +239,73 @@ ret:
 	return;
 }

+static int add_del_listener(pid_t pid, cpumask_t *maskp, int isadd)
+{
+	struct listener *s;
+	unsigned int cpu, mycpu;
+	cpumask_t mask;
+	struct rw_semaphore *sem;
+	struct list_head *head, *p;

-static int taskstats_send_stats(struct sk_buff *skb, struct genl_info *info)
+	memcpy(&mask, maskp, sizeof(cpumask_t));
+	if (cpus_empty(mask))
+		return -EINVAL;
+
+	mycpu = get_cpu();
+	put_cpu();
+	if (isadd == REGISTER) {
+		for_each_cpu_mask(cpu, mask) {
+			if (!cpu_possible(cpu))
+				continue;
+			if (cpu == mycpu)
+				preempt_disable();
+
+			sem = &per_cpu(listener_list_sem, cpu);
+			head = &per_cpu(listener_list, cpu);
+
+			s = kmalloc(sizeof(struct listener), GFP_KERNEL);
+			if (!s)
+				return -ENOMEM;
+			s->pid = pid;
+			INIT_LIST_HEAD(&s->list);
+
+			down_write(sem);
+			list_add(&s->list, head);
+			up_write(sem);
+
+			if (cpu == mycpu)
+				preempt_enable();
+		}
+	} else {
+		for_each_cpu_mask(cpu, mask) {
+			struct list_head *tmp;
+
+			if (!cpu_possible(cpu))
+				continue;
+			if (cpu == mycpu)
+				preempt_disable();
+
+			sem = &per_cpu(listener_list_sem, cpu);
+			head = &per_cpu(listener_list, cpu);
+
+			down_write(sem);
+			list_for_each_safe(p, tmp, head) {
+				s = list_entry(p, struct listener, list);
+				if (s->pid == pid) {
+					list_del(&s->list);
+					break;
+				}
+			}
+			up_write(sem);
+
+			if (cpu == mycpu)
+				preempt_enable();
+		}
+	}
+	return 0;
+}
+
+static int taskstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
 {
 	int rc = 0;
 	struct sk_buff *rep_skb;
@@ -210,6 +313,21 @@ static int taskstats_send_stats(struct s
 	void *reply;
 	size_t size;
 	struct nlattr *na;
+	cpumask_t mask;
+
+	if (info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK]) {
+		na = info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK];
+		cpulist_parse((char *)nla_data(na), mask);
+		rc = add_del_listener(info->snd_pid, &mask, REGISTER);
+		return rc;
+	}
+
+	if (info->attrs[TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK]) {
+		na = info->attrs[TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK];
+		cpulist_parse((char *)nla_data(na), mask);
+		rc = add_del_listener(info->snd_pid, &mask, DEREGISTER);
+		return rc;
+	}

 	/*
 	 * Size includes space for nested attributes
@@ -334,7 +452,7 @@ ret:

 static struct genl_ops taskstats_ops = {
 	.cmd		= TASKSTATS_CMD_GET,
-	.doit		= taskstats_send_stats,
+	.doit		= taskstats_user_cmd,
 	.policy		= taskstats_cmd_get_policy,
 };

@@ -349,6 +467,7 @@ void __init taskstats_init_early(void)
 static int __init taskstats_init(void)
 {
 	int rc;
+	unsigned int i;

 	rc = genl_register_family(&family);
 	if (rc)
@@ -358,6 +477,11 @@ static int __init taskstats_init(void)
 	rc = genl_register_ops(&family, &taskstats_ops);
 	if (rc < 0)
 		goto err;
+
+	for_each_possible_cpu(i) {
+		INIT_LIST_HEAD(&(per_cpu(listener_list, i)));
+		init_rwsem(&(per_cpu(listener_list_sem, i)));
+	}

 	return 0;
 err:



