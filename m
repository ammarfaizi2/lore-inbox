Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbWGFKCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbWGFKCO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 06:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbWGFKCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 06:02:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51864 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030199AbWGFKCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 06:02:13 -0400
Date: Thu, 6 Jul 2006 02:56:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: jlan@sgi.com, pj@sgi.com, Valdis.Kletnieks@vt.edu, balbir@in.ibm.com,
       csturtiv@sgi.com, linux-kernel@vger.kernel.org, hadi@cyberus.ca,
       netdev@vger.kernel.org
Subject: Re: [PATCH] per-task delay accounting taskstats interface: control
 exit data through cpumasks]
Message-Id: <20060706025633.cd4b1c1d.akpm@osdl.org>
In-Reply-To: <44ACD7C3.5040008@watson.ibm.com>
References: <44ACD7C3.5040008@watson.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2006 05:28:35 -0400
Shailabh Nagar <nagar@watson.ibm.com> wrote:

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
> 
> Thanks to Andrew Morton for pointing out the various scalability and
> general concerns of previous attempts and for suggesting this design.
> 
> ...
>
> --- linux-2.6.17-mm3equiv.orig/include/linux/taskstats.h	2006-06-30 19:03:40.000000000 -0400
> +++ linux-2.6.17-mm3equiv/include/linux/taskstats.h	2006-07-06 02:38:28.000000000 -0400

Your email client performs space-stuffing.  Fortunately "sed -e 's/^  / /'"
is easy.

>   #include <linux/taskstats_kern.h>
>   #include <linux/delayacct.h>
> +#include <linux/cpumask.h>
> +#include <linux/percpu.h>
>   #include <net/genetlink.h>
>   #include <asm/atomic.h>

Like that.

> 
> +static int add_del_listener(pid_t pid, cpumask_t *maskp, int isadd)
> +{
> +	struct listener *s;
> +	struct listener_list *listeners;
> +	unsigned int cpu;
> +	cpumask_t mask;
> +	struct list_head *p;
> +
> +	memcpy(&mask, maskp, sizeof(cpumask_t));

	mask = *maskp; ?

> +	if (!cpus_subset(mask, cpu_possible_map))
> +		return -EINVAL;
> +
> +	if (isadd == REGISTER) {
> +		for_each_cpu_mask(cpu, mask) {
> +			s = kmalloc_node(sizeof(struct listener), GFP_KERNEL,
> +					 cpu_to_node(cpu));
> +			if (!s)
> +				return -ENOMEM;
> +			s->pid = pid;
> +			INIT_LIST_HEAD(&s->list);
> +
> +			listeners = &per_cpu(listener_array, cpu);
> +			down_write(&listeners->sem);
> +			list_add(&s->list, &listeners->list);
> +			up_write(&listeners->sem);
> +		}
> +	} else {
> +		for_each_cpu_mask(cpu, mask) {
> +			struct list_head *tmp;
> +
> +			listeners = &per_cpu(listener_array, cpu);
> +			down_write(&listeners->sem);
> +			list_for_each_safe(p, tmp, &listeners->list) {
> +				s = list_entry(p, struct listener, list);
> +				if (s->pid == pid) {
> +					list_del(&s->list);
> +					kfree(s);
> +					break;
> +				}
> +			}
> +			up_write(&listeners->sem);
> +		}
> +	}
> +	return 0;
> +}

You might choose to handle the ENOMEM situation here by backing out and not
leaving things half-installed.  I suspect that's just a simple `goto'.

> -static int taskstats_send_stats(struct sk_buff *skb, struct genl_info *info)
> +static int taskstats_user_cmd(struct sk_buff *skb, struct genl_info *info)
>   {
>   	int rc = 0;
>   	struct sk_buff *rep_skb;
> @@ -210,6 +302,25 @@ static int taskstats_send_stats(struct s
>   	void *reply;
>   	size_t size;
>   	struct nlattr *na;
> +	cpumask_t mask;

When counting add_del_listener(), that's two cpumasks on the stack.  How
big can these get?  256 bytes?  Is it possible to get by with just the one?

> +
> +	if (info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK]) {
> +		na = info->attrs[TASKSTATS_CMD_ATTR_REGISTER_CPUMASK];
> +		if (nla_len(na) > TASKSTATS_CPUMASK_MAXLEN)
> +			return -E2BIG;
> +		cpulist_parse((char *)nla_data(na), mask);

Best check the return value from this function.

> +		rc = add_del_listener(info->snd_pid, &mask, REGISTER);
> +		return rc;
> +	}
> +
> +	if (info->attrs[TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK]) {
> +		na = info->attrs[TASKSTATS_CMD_ATTR_DEREGISTER_CPUMASK];
> +		if (nla_len(na) > TASKSTATS_CPUMASK_MAXLEN)
> +			return -E2BIG;
> +		cpulist_parse((char *)nla_data(na), mask);
> +		rc = add_del_listener(info->snd_pid, &mask, DEREGISTER);
> +		return rc;
> +	}
> 
> ...
> 
> +void taskstats_exit_alloc(struct taskstats **ptidstats, unsigned int *mycpu)
> +{
> +	struct listener_list *listeners;
> +	struct taskstats *tmp;
> +	/*
> +	 * This is the cpu on which the task is exiting currently and will
> +	 * be the one for which the exit event is sent, even if the cpu
> +	 * on which this function is running changes later.
> +	 */
> +	*mycpu = raw_smp_processor_id();
> +
> +	*ptidstats = NULL;
> +	tmp = kmem_cache_zalloc(taskstats_cache, SLAB_KERNEL);
> +	if (!tmp)
> +		return;
> +
> +	listeners = &per_cpu(listener_array, *mycpu);
> +	down_read(&listeners->sem);
> +	if (!list_empty(&listeners->list)) {
> +		*ptidstats = tmp;
> +		tmp = NULL;
> +	}
> +	up_read(&listeners->sem);
> +	if (tmp)
> +		kfree(tmp);

kfree(NULL) is legal.


Looks good to me.  Does it work?
