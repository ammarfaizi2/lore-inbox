Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267528AbTAQRax>; Fri, 17 Jan 2003 12:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267618AbTAQRax>; Fri, 17 Jan 2003 12:30:53 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:49381 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S267528AbTAQRau> convert rfc822-to-8bit; Fri, 17 Jan 2003 12:30:50 -0500
content-class: urn:content-classes:message
Subject: RE: [PATCH] (2/3) Initial load balancing
Date: Fri, 17 Jan 2003 09:39:42 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1912E242@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] (2/3) Initial load balancing
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcK9jpJoGhiJPCmBEde/HABQi2jWFgAveNhw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Linus Torvalds" <torvalds@transmeta.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Jan 2003 17:39:42.0984 (UTC) FILETIME=[6B30A880:01C2BE4F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Martin J. Bligh [mailto:mbligh@aracnet.com] 
> -#ifdef CONFIG_NUMA
> +#if CONFIG_NUMA
> +/*
> + * If dest_cpu is allowed for this process, migrate the task to it.
> + * This is accomplished by forcing the cpu_allowed mask to only
> + * allow dest_cpu, which will force the cpu onto dest_cpu.  Then
> + * the cpu_allowed mask is restored.
> + */
> +static void sched_migrate_task(task_t *p, int dest_cpu)
> +{
> +	unsigned long old_mask;
> +
> +	old_mask = p->cpus_allowed;
> +	if (!(old_mask & (1UL << dest_cpu)))
> +		return;
> +	/* force the process onto the specified CPU */
> +	set_cpus_allowed(p, 1UL << dest_cpu);
> +
> +	/* restore the cpus allowed mask */
> +	set_cpus_allowed(p, old_mask);
> +}

It may be better to add a _note_ to this function saying that it is not
supposed
to be called by multiple callers at the same time. As of now, as it is
called 
at exec time only, I think it is safe. But, if it get used at other
places,
(or called once+preempt) we may have situations where we may loose the
cpus_allowed mask
or miss some sched_migrate_task(). I am looking at, what if some
sched_migrate_task() 
or user set_affinity gets initiated in between two set_cpus_allowed in
this routine. 

> +
> +/*
> + * Find the least loaded CPU.  Slightly favor the current CPU by
> + * setting its runqueue length as the minimum to start.
> + */
> +static int sched_best_cpu(struct task_struct *p)
> +{
> +	int i, minload, load, best_cpu, node = 0;
> +	unsigned long cpumask;
> +
> +	best_cpu = task_cpu(p);
> +	if (cpu_rq(best_cpu)->nr_running <= 2)
> +		return best_cpu;
> +
> +	minload = 10000000;
> +	for (i = 0; i < numnodes; i++) {
> +		load = atomic_read(&node_nr_running[i]);
> +		if (load < minload) {
> +			minload = load;
> +			node = i;
> +		}
> +	}
> +
> +	minload = 10000000;

Can we use some common #defines instead of numbers here. Also, is
There anything magical about this number or should we use MAXINT?

I saw a similar number used in patch 3. 
(100*load > NODE_THRESHOLD*this_load)
Can it be moved to #defined as well. Is this test just to find out the
25%
significant difference? A line of comment may help..

Otherwise patch looks simple and neat. And should help in HT case too.

Thanks,
-Venkatesh
