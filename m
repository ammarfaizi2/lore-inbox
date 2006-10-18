Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422717AbWJRRY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422717AbWJRRY0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422723AbWJRRY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:24:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:4485 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422717AbWJRRYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:24:25 -0400
Date: Wed, 18 Oct 2006 22:54:22 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Cpuset: remove useless sched domain line
Message-ID: <20061018172422.GA7885@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20061014045517.22007.863.sendpatchset@v0>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061014045517.22007.863.sendpatchset@v0>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 09:55:17PM -0700, Paul Jackson wrote:
> Dinakar,
> 
> (1) Does this patch look right to you?
> 
> (2) I don't understand this code:
> 
>       * When do we ever create sched domains for cpusets
>         that -are- cpu_exclusive?  All I see here are
> 	calls to partition_sched_domains() with various
> 	permutations of pspan and cspan that are the
> 	cpus from various non-exclusive cpusets.
> 
>       * Why do we return (setting up no sched domains
> 	at this time) if the current cpuset's cpus
> 	covers all the non exclusive cpus of our parent,
> 	but continue on to make a sched domain just for
> 	our parent if there are other non-exclusive cpus
> 	in our sibling cpusets?
> 
> ====
> 
> Remove a useless line from the sched domain setup code in cpusets.
> 
> When I removed the 'is_removed()' flag test from the sched domain
> setup code in cpusets, as part of my July 23, 2006 patch:
> 
>     Cpuset: fix ABBA deadlock with cpu hotplug lock
> 
> I failed to notice that this opened the door to a little bit of code
> simplification.  A line of code that had to cover for the possibility
> that a cpuset marked cpu_exclusive was marked for removal could
> be eliminated.  In the code section visible in this patch, it is
> now the case that cur->cpus_allowed is always a subset of pspan,
> so it is always a no-op to cpus_or() cur->cpus_allowed into pspan.
> 
> Signed-off-by: Paul Jackson <pj@sgi.com>
> 
> ---
> 
>  kernel/cpuset.c |    1 -
>  1 files changed, 1 deletion(-)
> 
> --- 2.6.19-rc1-mm1.orig/kernel/cpuset.c	2006-10-13 21:31:16.000000000 -0700
> +++ 2.6.19-rc1-mm1/kernel/cpuset.c	2006-10-13 21:32:20.000000000 -0700
> @@ -783,7 +783,6 @@ static void update_cpu_domains(struct cp
>  			cpus_andnot(pspan, pspan, c->cpus_allowed);
>  	}
>  	if (!is_cpu_exclusive(cur)) {
> -		cpus_or(pspan, pspan, cur->cpus_allowed);
>  		if (cpus_equal(pspan, cur->cpus_allowed))
>  			return;
>  		cspan = CPU_MASK_NONE;


I dont think this is a valid optimization. What we are checking here
is if a previously exclusive cpuset has been changed to a non-exclusive one
(echo 0 > cpu_exclusive), we then OR all the cpus in the current cpuset
to the parent cpuset. We then rebuild a sched domain to include all of the cpus
in the current cpuset and those in the parent not part of exclusive children

So I dont see why this can be done away with

	-Dinakar
