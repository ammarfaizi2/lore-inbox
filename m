Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbVFGPgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbVFGPgp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 11:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbVFGP04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 11:26:56 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:17818 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261904AbVFGOyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 10:54:33 -0400
Date: Tue, 7 Jun 2005 09:54:31 -0500
From: Jack Steiner <steiner@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, John Hawkes <hawkes@sgi.com>
Subject: Re: Hang in sched_balance_self()
Message-ID: <20050607145431.GA7452@sgi.com>
References: <20050603225544.GA8499@sgi.com> <42A5AA85.60709@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A5AA85.60709@yahoo.com.au>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 12:09:09AM +1000, Nick Piggin wrote:
> Jack Steiner wrote:
> >Nick -
> >
> >The latest 2.6.12-rc5-mm2 tree fails to boot on some of the 64p
> >SGI systems. The system hangs immediately after printing:
> >
> >	...
> >	Inode-cache hash table entries: 8388608 (order: 12, 67108864 bytes)
> >	Mount-cache hash table entries: 1024
> >	Boot processor id 0x0/0x0
> >	Brought up 64 CPUs
> >	Total of 64 processors activated (118415.36 BogoMIPS).
> >
> >
> >I have isolated the failure to cpu 0 hanging in sched_balance_self() during
> >a fork (or clone).  The "while" loop at the end of function never 
> >terminates, ie. sd is never NULL.
> >
> >Is this a problem that you have seen before. If not, I'll do some
> >more digging & isolate the problem.
> >
> 
> Hi Jack,
> I haven't completely got to the bottom of this yet, but I was able
> to reproduce on a 64-way Altix, and something like the attached patch
> seems to 'fix' the problem.

The fix works for me. 

I'll send you notes that I collected. They may help explain
what is going wrong. (I learned a lot about scheduler domains...:-)


> 
> I didn't have time to find what's gone wrong tonight, but I'll get
> to that tomorrow.
> 
> -- 
> SUSE Labs, Novell Inc.
> 

> Index: linux-2.6/kernel/sched.c
> ===================================================================
> --- linux-2.6.orig/kernel/sched.c	2005-06-08 00:01:53.000000000 +1000
> +++ linux-2.6/kernel/sched.c	2005-06-08 00:02:47.000000000 +1000
> @@ -1113,6 +1113,7 @@ static int sched_balance_self(int cpu, i
>  		cpumask_t span;
>  		struct sched_group *group;
>  		int new_cpu;
> +		int weight;
>  
>  		span = sd->span;
>  		group = find_idlest_group(sd, t, cpu);
> @@ -1127,8 +1128,9 @@ static int sched_balance_self(int cpu, i
>  		cpu = new_cpu;
>  nextlevel:
>  		sd = NULL;
> +		weight = cpus_weight(span);
>  		for_each_domain(cpu, tmp) {
> -			if (cpus_subset(span, tmp->span))
> +			if (weight <= cpus_weight(tmp->span))
>  				break;
>  			if (tmp->flags & flag)
>  				sd = tmp;


-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


