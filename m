Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbTHUKBG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 06:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbTHUKBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 06:01:06 -0400
Received: from [66.212.224.118] ([66.212.224.118]:48909 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S262529AbTHUKBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 06:01:01 -0400
Date: Thu, 21 Aug 2003 06:00:58 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: sched_best_cpu
In-Reply-To: <1061459227.19789.22.camel@tom>
Message-ID: <Pine.LNX.4.53.0308210558190.17457@montezuma.mastecende.com>
References: <1061459227.19789.22.camel@tom>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003, Frank Cornelis wrote:

> Hi,
> 
> 
> Next patch slightly favors the local node when looking for the least
> loaded cpu; when the task would not stay on our node we add 1 to the
> load to simulate the influence the migration would have on the load.

You might need to rediff soon due to cpumask_t changes

> --- sched.c.orig	2003-08-09 06:39:35.000000000 +0200
> +++ sched.c	2003-08-21 11:45:04.000000000 +0200
> @@ -776,29 +776,30 @@
>   */
>  static int sched_best_cpu(struct task_struct *p)
>  {
> -	int i, minload, load, best_cpu, node = 0;
> +	int i, minload, load, best_cpu, node, pnode;
>  	unsigned long cpumask;
	cpumask_t cpumask;

>  
>  	best_cpu = task_cpu(p);
>  	if (cpu_rq(best_cpu)->nr_running <= 2)
>  		return best_cpu;
>  
> -	minload = 10000000;
> +	minload = INT_MAX;
> +	node = pnode = cpu_to_node(best_cpu);
>  	for_each_node_with_cpus(i) {
>  		/*
>  		 * Node load is always divided by nr_cpus_node to normalise 
>  		 * load values in case cpu count differs from node to node.
> -		 * We first multiply node_nr_running by 10 to get a little
> -		 * better resolution.   
> +		 * If the node != our node we add the load of the task.
> +		 * We multiply by NR_CPUS for better resolution.
>  		 */
> -		load = 10 * atomic_read(&node_nr_running[i]) / nr_cpus_node(i);
> +		load = NR_CPUS * (atomic_read(&node_nr_running[i]) + (i != pnode)) / nr_cpus_node(i);
>  		if (load < minload) {
>  			minload = load;
>  			node = i;
>  		}
>  	}
>  
> -	minload = 10000000;
> +	minload = INT_MAX;
>  	cpumask = node_to_cpumask(node);
>  	for (i = 0; i < NR_CPUS; ++i) {
>  		if (!(cpumask & (1UL << i)))

		if (!cpu_isset(i, cpumask))

