Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbVDEBnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVDEBnx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 21:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVDEBnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 21:43:53 -0400
Received: from fmr24.intel.com ([143.183.121.16]:42632 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261515AbVDEBnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 21:43:49 -0400
Message-Id: <200504050143.j351hag10217@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>
Cc: "Paul Jackson" <pj@engr.sgi.com>, <torvalds@osdl.org>,
       <nickpiggin@yahoo.com.au>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: [patch] sched: auto-tune migration costs [was: Re: Industry db benchmark result on recent 2.6 kernels]
Date: Mon, 4 Apr 2005 18:43:35 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcU5CsbjG352dxwJSZOzGb9TpdCgcwAdHSUA
In-Reply-To: <20050404113743.GA28994@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:
> The cache size information on ia64 is already available at the finger
> tip. Here is a patch that I whipped up to set max_cache_size for ia64.

Ingo Molnar wrote on Monday, April 04, 2005 4:38 AM
> thanks - i've added this to my tree.
>
> i've attached the latest snapshot. There are a number of changes in the
> patch: firstly, i changed the direction of the iteration to go from
> small sizes to larger sizes, and i added a method to detect the maximum.
>
> Furthermore, i tweaked the test some more to make it both faster and
> more reliable, and i cleaned up the code. (e.g. now we migrate via the
> scheduler, not via on_each_cpu().) The default patch should print enough
> debug information as-is.
>
> I changed the workload too so potentially the detected values might be
> off from the ideal value on your box. The values detected on x86 are
> mostly unchanged, relative to previous patches.

Perhaps, I'm not getting the latest patch?  It skipped measuring because
migration cost array is non-zero (initialized to -1LL):

        [00]    [01]    [02]    [03]
[00]:     -     0.0(0)  0.0(0)  0.0(0)
[01]:   0.0(0)    -     0.0(0)  0.0(0)
[02]:   0.0(0)  0.0(0)    -     0.0(0)
[03]:   0.0(0)  0.0(0)  0.0(0)    -
--------------------------------
| cacheflush times [1]: 0.0 (-1)
| calibration delay: 0 seconds
--------------------------------


Need this change?  I bet you had that in your tree already.

--- ./kernel/sched.c.orig	2005-04-04 18:01:45.000000000 -0700
+++ ./kernel/sched.c	2005-04-04 18:21:41.000000000 -0700
@@ -5050,7 +5050,7 @@ void __devinit calibrate_migration_costs
 			/*
 			 * Do we have the result cached already?
 			 */
-			if (migration_cost[distance])
+			if (migration_cost[distance] != -1LL)
 				cost = migration_cost[distance];
 			else {
 				cost = measure_migration_cost(cpu1, cpu2);



Also, the cost calculation in measure_one() looks fishy to me in this version.

> +	/*
> +	 * Dirty the working set:
> +	 */
> +	t0 = sched_clock();
> +	touch_cache(cache, size);
> +	t1 = sched_clock();
> +
> +	/*
> +	 * Migrate to the target CPU, dirty the L2 cache and access
> +	 * the shared buffer. (which represents the working set
> +	 * of a migrated task.)
> +	 */
> +	mask = cpumask_of_cpu(target);
> +	set_cpus_allowed(current, mask);
> +	WARN_ON(smp_processor_id() != target);
> +
> +	t2 = sched_clock();
> +	touch_cache(cache, size);
> +	t3 = sched_clock();
> +
> +	cost = t2-t1 + t3-t2;

Typo here ??


