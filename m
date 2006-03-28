Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWC1UIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWC1UIe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 15:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWC1UIe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 15:08:34 -0500
Received: from mga06.intel.com ([134.134.136.21]:42629 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S932125AbWC1UIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 15:08:34 -0500
TrustExchangeSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.03,139,1141632000"; 
   d="scan'208"; a="16218315:sNHT10337228237"
Date: Tue, 28 Mar 2006 11:25:21 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Mike Galbraith <efault@gmx.de>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: smpnice work around for active_load_balance()
Message-ID: <20060328112521.A27574@unix-os.sc.intel.com>
References: <4428D112.7050704@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4428D112.7050704@bigpond.net.au>; from pwil3058@bigpond.net.au on Tue, Mar 28, 2006 at 05:00:50PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2006 at 05:00:50PM +1100, Peter Williams wrote:
> Problem:
> 
> It is undesirable for HT/MC packages to have more than one of their CPUs
> busy if there are other packages that have all of their CPUs idle.  This

We need to balance even if the other packages are not idle.. For example,
consider a 4-core DP system, if we have 6 runnable(assume same priority)
processes, we want to schedule 3 of them in each package..

Todays active load balance implementation is very simple and generic. And
hence it works smoothly with dual and multi-core.. Please read my OLS 
2005 paper which talks about different scheduling scenarios and also how 
we were planning to implement Power savings policy incase of multi-core.. 
I had a prototype patch for doing this, which I held it up before going
on vacation, as it needed some rework with your smpnice patch in place..
I will post a patch ontop of current mainline for your reference.

> +		} else if (!busiest_has_loaded_cpus && avg_load < max_load) {

I haven't fully digested the result of this patch but should this be
avg_load < max_load or avg_load > max_load ?

Either way, I can show scheduling scenarios which will fail...

>  
> -		if (rqi->raw_weighted_load > max_load && rqi->nr_running > 1) {
> +		if (rqi->nr_running > 1) {
> +			if (rqi->raw_weighted_load > max_load || !busiest_is_loaded) {
> +				max_load = rqi->raw_weighted_load;
> +				busiest = rqi;
> +				busiest_is_loaded = 1;
> +			}
> +		} else if (!busiest_is_loaded && rqi->raw_weighted_load > max_load) {

Please note the point that same scheduling logic has to work for all
the different levels of scheduler domains... I think these checks complicates
the decisions as we go up in the scheduling hirerachy.. Please go through
the HT/MC/MP/Numa combinations and with same/different priority processes for
different scenarios..

Even with no HT and MC, this patch has still has issues in the presence
of different priority tasks... consider a simple DP system and run two
instances of high priority tasks(simple infinite loop) and two normal priority
tasks. With "top" I observed that these normal priority tasks keep on jumping
from one processor to another... Ideally with smpnice, we would assume that 
each processor should have two tasks (one high priority and another one 
with normal priority) ..

thanks,
suresh
