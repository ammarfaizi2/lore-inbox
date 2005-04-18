Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVDRXoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVDRXoZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 19:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261178AbVDRXoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 19:44:25 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:6502 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261169AbVDRXoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 19:44:15 -0400
Message-ID: <42644646.3030104@yahoo.com.au>
Date: Tue, 19 Apr 2005 09:44:06 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: dino@in.ibm.com
CC: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       lkml <linux-kernel@vger.kernel.org>,
       lsetech <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Matthew Dobson <colpatch@us.ibm.com>
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
References: <1097110266.4907.187.camel@arrakis> <20050418202644.GA5772@in.ibm.com>
In-Reply-To: <20050418202644.GA5772@in.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar Guniguntala wrote:
> Here's an attempt at dynamic sched domains aka isolated cpusets
> 

Very good, I was wondering when someone would try to implement this ;)

It needs some work. A few initial comments on the kernel/sched.c change
- sorry, don't have too much time right now...

> --- linux-2.6.12-rc1-mm1.orig/kernel/sched.c	2005-04-18 00:46:40.000000000 +0530
> +++ linux-2.6.12-rc1-mm1/kernel/sched.c	2005-04-18 00:47:55.000000000 +0530
> @@ -4895,40 +4895,41 @@ static void check_sibling_maps(void)
>  }
>  #endif
>  
> -/*
> - * Set up scheduler domains and groups.  Callers must hold the hotplug lock.
> - */
> -static void __devinit arch_init_sched_domains(void)
> +static void attach_domains(cpumask_t cpu_map)
>  {

This shouldn't be needed. There should probably just be one place that
attaches all domains. It is a bit difficult to explain what I mean when
you have 2 such places below.

[...]

> +void rebuild_sched_domains(cpumask_t change_map, cpumask_t span1, cpumask_t span2)
> +{

Interface isn't bad. It would seem to be able to handle everything, but
I think it can be made a bit simpler.

	fn_name(cpumask_t span1, cpumask_t span2)

Yeah? The change_map is implicitly the union of the 2 spans. Also I don't
really like the name. It doesn't rebuild so much as split (or join). I
can't think of anything good off the top of my head.

> +	unsigned long flags;
> +	int i;
> +
> +	local_irq_save(flags);
> +
> +	for_each_cpu_mask(i, change_map)
> +		spin_lock(&cpu_rq(i)->lock);
> +

Locking is wrong. And it has changed again in the latest -mm kernel.
Please diff against that.

> +	if (!cpus_empty(span1))
> +		build_sched_domains(span1);
> +	if (!cpus_empty(span2))
> +		build_sched_domains(span2);
> +

You also can't do this - you have to 'offline' the domains first before
building new ones. See the CPU hotplug code that handles this.

[...]

> @@ -5046,13 +5082,13 @@ static int update_sched_domains(struct n
>  				unsigned long action, void *hcpu)
>  {
>  	int i;
> +	cpumask_t temp_map, hotcpu = cpumask_of_cpu((long)hcpu);
>  
>  	switch (action) {
>  	case CPU_UP_PREPARE:
>  	case CPU_DOWN_PREPARE:
> -		for_each_online_cpu(i)
> -			cpu_attach_domain(&sched_domain_dummy, i);
> -		arch_destroy_sched_domains();
> +		cpus_andnot(temp_map, cpu_online_map, hotcpu);
> +		rebuild_sched_domains(cpu_online_map, temp_map, CPU_MASK_NONE);

This makes a hotplug event destroy your nicely set up isolated domains,
doesn't it?

This looks like the most difficult problem to overcome. It needs some
external information to redo the cpuset splits at cpu hotplug time.
Probably a hotplug handler in the cpusets code might be the best way
to do that.

-- 
SUSE Labs, Novell Inc.

