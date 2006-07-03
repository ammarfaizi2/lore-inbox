Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWGCVqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWGCVqt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbWGCVqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:46:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53673 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750914AbWGCVqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:46:46 -0400
Date: Mon, 3 Jul 2006 14:41:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: pj@sgi.com, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org, hadi@cyberus.ca,
       netdev@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
Message-Id: <20060703144106.cc5bd6f6.akpm@osdl.org>
In-Reply-To: <44A9881F.7030103@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
	<449C6620.1020203@engr.sgi.com>
	<20060623164743.c894c314.akpm@osdl.org>
	<449CAA78.4080902@watson.ibm.com>
	<20060623213912.96056b02.akpm@osdl.org>
	<449CD4B3.8020300@watson.ibm.com>
	<44A01A50.1050403@sgi.com>
	<20060626105548.edef4c64.akpm@osdl.org>
	<44A020CD.30903@watson.ibm.com>
	<20060626111249.7aece36e.akpm@osdl.org>
	<44A026ED.8080903@sgi.com>
	<20060626113959.839d72bc.akpm@osdl.org>
	<44A2F50D.8030306@engr.sgi.com>
	<20060628145341.529a61ab.akpm@osdl.org>
	<44A2FC72.9090407@engr.sgi.com>
	<20060629014050.d3bf0be4.pj@sgi.com>
	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
	<20060629094408.360ac157.pj@sgi.com>
	<20060629110107.2e56310b.akpm@osdl.org>
	<44A57310.3010208@watson.ibm.com>
	<44A5770F.3080206@watson.ibm.com>
	<20060630155030.5ea1faba.akpm@osdl.org>
	<44A5DBE7.2020704@watson.ibm.com>
	<44A5EDE6.3010605@watson.ibm.com>
	<20060630205148.4f66b125.akpm@osdl.org>
	<44A9881F.7030103@watson.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Jul 2006 17:11:59 -0400
Shailabh Nagar <nagar@watson.ibm.com> wrote:

> >>So the strawman is:
> >>Listener bind()s to genetlink using its real pid.
> >>Sends a separate "registration" message with cpumask to listen to. 
> >>Kernel stores (real) pid and cpumask.
> >>During task exit, kernel goes through each registered listener (small 
> >>list) and decides which
> >>one needs to get this exit data and calls a genetlink_unicast to each 
> >>one that does need it.
> >>
> >>If number of listeners is small, the lookups should be swift enough. If 
> >>it grows large, we
> >>can consider a fancier lookup (but there I go again, delving into 
> >>implementation too early :-)
> >>    
> >>
> >
> >We'll need a map.
> >
> >1024 CPUs, 1024 listeners, 1000 exits/sec/CPU and we're up to a million
> >operations per second per CPU.  Meltdown.
> >
> >But it's a pretty simple map.  A per-cpu array of pointers to the head of a
> >linked list.  One lock for each CPU's list.
> >  
> >
> Here's a patch that implements the above ideas.
> 
> A listener register's interest by specifying a cpumask in the
> cpulist format (comma separated ranges of cpus). The listener's pid
> is entered into per-cpu lists for those cpus and exit events from those
> cpus go to the listeners using netlink unicasts.
> 
> ...
> 
> On systems with a large number of cpus, with even a modest rate of
> tasks exiting per cpu, the volume of taskstats data sent on thread exit
> can overflow a userspace listener's buffers.
> 
> One approach to avoiding overflow is to allow listeners to get data for
> a limited and specific set of cpus. By scaling the number of listeners
> and/or the cpus they monitor, userspace can handle the statistical data
> overload more gracefully.
> 
> In this patch, each listener registers to listen to a specific set of
> cpus by specifying a cpumask.  The interest is recorded per-cpu. When
> a task exits on a cpu, its taskstats data is unicast to each listener
> interested in that cpu.

I think the approach is sane.  The impementation needs work, as you say.

> +++ linux-2.6.17-mm3equiv/include/linux/taskstats_kern.h	2006-07-01 23:53:01.000000000 -0400
> @@ -19,20 +19,14 @@ enum {
>  #ifdef CONFIG_TASKSTATS
>  extern kmem_cache_t *taskstats_cache;
>  extern struct mutex taskstats_exit_mutex;
> -
> -static inline int taskstats_has_listeners(void)
> -{
> -	if (!genl_sock)
> -		return 0;
> -	return netlink_has_listeners(genl_sock, TASKSTATS_LISTEN_GROUP);
> -}
> -
> +DECLARE_PER_CPU(struct list_head, listener_list);
> 
>  static inline void taskstats_exit_alloc(struct taskstats **ptidstats)
>  {
>  	*ptidstats = NULL;
> -	if (taskstats_has_listeners())
> +	if (!list_empty(&get_cpu_var(listener_list)))
>  		*ptidstats = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
> +	put_cpu_var(listener_list);
>  }

It's time to uninline this function..

>  static inline void taskstats_exit_free(struct taskstats *tidstats)
> Index: linux-2.6.17-mm3equiv/kernel/taskstats.c
> ===================================================================
> --- linux-2.6.17-mm3equiv.orig/kernel/taskstats.c	2006-06-30 23:38:39.000000000 -0400
> +++ linux-2.6.17-mm3equiv/kernel/taskstats.c	2006-07-02 00:16:18.000000000 -0400
> @@ -19,6 +19,8 @@
>  #include <linux/kernel.h>
>  #include <linux/taskstats_kern.h>
>  #include <linux/delayacct.h>
> +#include <linux/cpumask.h>
> +#include <linux/percpu.h>
>  #include <net/genetlink.h>
>  #include <asm/atomic.h>
> 
> @@ -26,6 +28,9 @@ static DEFINE_PER_CPU(__u32, taskstats_s
>  static int family_registered = 0;
>  kmem_cache_t *taskstats_cache;
> 
> +DEFINE_PER_CPU(struct list_head, listener_list);
> +static DEFINE_PER_CPU(struct rw_semaphore, listener_list_sem);

Which will permit listener_list to become static - it wasn't a good name
for a global anyway.

I suggest you implement a new

struct whatever {
	struct rw_semaphore sem;
	struct list_head list;
};

static DEFINE_PER_CPU(struct whatever, listener_aray);


>  static int prepare_reply(struct genl_info *info, u8 cmd, struct sk_buff **skbp,
>  			void **replyp, size_t size)
>  {
> @@ -77,6 +92,8 @@ static int prepare_reply(struct genl_inf
>  static int send_reply(struct sk_buff *skb, pid_t pid, int event)
>  {
>  	struct genlmsghdr *genlhdr = nlmsg_data((struct nlmsghdr *)skb->data);
> +	struct rw_semaphore *sem;
> +	struct list_head *p, *head;
>  	void *reply;
>  	int rc;
> 
> @@ -88,9 +105,30 @@ static int send_reply(struct sk_buff *sk
>  		return rc;
>  	}
> 
> -	if (event == TASKSTATS_MSG_MULTICAST)
> -		return genlmsg_multicast(skb, pid, TASKSTATS_LISTEN_GROUP);
> -	return genlmsg_unicast(skb, pid);
> +	if (event == TASKSTATS_MSG_UNICAST)
> +		return genlmsg_unicast(skb, pid);
> +
> +	/*
> +	 * Taskstats multicast is unicasts to listeners who have registered
> +	 * interest in this cpu
> +	 */
> +	sem = &get_cpu_var(listener_list_sem);
> +	head = &get_cpu_var(listener_list);

This has a double preempt_disable(), but the above will fix that.

> +	down_read(sem);
> +	list_for_each(p, head) {
> +		int ret;
> +		struct listener *s = list_entry(p, struct listener, list);
> +		ret = genlmsg_unicast(skb, s->pid);
> +		if (ret)
> +			rc = ret;
> +	}
> +	up_read(sem);
> +
> +	put_cpu_var(listener_list);
> +	put_cpu_var(listener_list_sem);
> +
> +	return rc;
>  }
> 
>  static int fill_pid(pid_t pid, struct task_struct *pidtsk,
> @@ -201,8 +239,73 @@ ret:
>  	return;
>  }
> 
> +static int add_del_listener(pid_t pid, cpumask_t *maskp, int isadd)
> +{
> +	struct listener *s;
> +	unsigned int cpu, mycpu;
> +	cpumask_t mask;
> +	struct rw_semaphore *sem;
> +	struct list_head *head, *p;
> 
> -static int taskstats_send_stats(struct sk_buff *skb, struct genl_info *info)
> +	memcpy(&mask, maskp, sizeof(cpumask_t));
> +	if (cpus_empty(mask))
> +		return -EINVAL;
> +
> +	mycpu = get_cpu();
> +	put_cpu();

This is effectively raw_smp_processor_id().  And after the put_cpu(),
`mycpu' is meaningless.

> +	if (isadd == REGISTER) {
> +		for_each_cpu_mask(cpu, mask) {
> +			if (!cpu_possible(cpu))
> +				continue;
> +			if (cpu == mycpu)
> +				preempt_disable();
> +
> +			sem = &per_cpu(listener_list_sem, cpu);
> +			head = &per_cpu(listener_list, cpu);
> +
> +			s = kmalloc(sizeof(struct listener), GFP_KERNEL);

Cannot do GFP_KERNEL inside preempt_disable().

There's no easy solution to this problem.  GFP_ATOMIC is not a good fix at
all.  One approach would be to run lock_cpu_hotplug(), then allocate (with
GFP_KERNEL) all the memory which will be needed within the locked region,
then take the lock, then use that preallocated memory.

You should use kmalloc_node() here, to ensure that the memory on each CPU's
list resides with that CPU's local memory (not _this_ CPU's local memory).

> +			if (!s)
> +				return -ENOMEM;
> +			s->pid = pid;
> +			INIT_LIST_HEAD(&s->list);
> +
> +			down_write(sem);
> +			list_add(&s->list, head);
> +			up_write(sem);
> +
> +			if (cpu == mycpu)
> +				preempt_enable();

Actually, I don't understand the tricks which are going on with the local CPU here. 
What's it all for?


> +		}
> +	} else {
> +		for_each_cpu_mask(cpu, mask) {
> +			struct list_head *tmp;
> +
> +			if (!cpu_possible(cpu))
> +				continue;

I guess you could just do cpus_and(mask, cpus_possible_map) on entry.


> +			if (cpu == mycpu)
> +				preempt_disable();
> +
> +			sem = &per_cpu(listener_list_sem, cpu);
> +			head = &per_cpu(listener_list, cpu);
> +
> +			down_write(sem);
> +			list_for_each_safe(p, tmp, head) {
> +				s = list_entry(p, struct listener, list);
> +				if (s->pid == pid) {
> +					list_del(&s->list);

kfree(s);

> +					break;
> +				}
> +			}
> +			up_write(sem);
> +
> +			if (cpu == mycpu)
> +				preempt_enable();
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int taskstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
>  {
>  	int rc = 0;
>  	struct sk_buff *rep_skb;
> @@ -210,6 +313,21 @@ static int taskstats_send_stats(struct s
>  	void *reply;
>  	size_t size;
>  	struct nlattr *na;
> +	cpumask_t mask;
> +
> +	if (info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK]) {
> +		na = info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK];
> +		cpulist_parse((char *)nla_data(na), mask);

OK, so we're passing in an ASCII string.  Fair enough, I think.  Paul would
know better.

