Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVDDGYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVDDGYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 02:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVDDGYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 02:24:40 -0400
Received: from mx2.elte.hu ([157.181.151.9]:4061 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261472AbVDDGYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 02:24:37 -0400
Date: Mon, 4 Apr 2005 08:24:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Paul Jackson <pj@engr.sgi.com>, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db benchmark result on recent 2.6 kernels]
Message-ID: <20050404062414.GA22664@elte.hu>
References: <20050403142959.GB22798@elte.hu> <200504040131.j341Vlg31981@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504040131.j341Vlg31981@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> Ingo Molnar wrote on Sunday, April 03, 2005 7:30 AM
> > how close are these numbers to the real worst-case migration costs on
> > that box?
> 
> I booted your latest patch on a 4-way SMP box (1.5 GHz, 9MB ia64). This
> is what it produces.  I think the estimate is excellent.
> 
> [00]:     -    10.4(0) 10.4(0) 10.4(0)
> [01]:  10.4(0)    -    10.4(0) 10.4(0)
> [02]:  10.4(0) 10.4(0)    -    10.4(0)
> [03]:  10.4(0) 10.4(0) 10.4(0)    -
> ---------------------
> cacheflush times [1]: 10.4 (10448800)

great! How long does the benchmark take (hours?), and is there any way 
to speed up the benchmarking (without hurting accuracy), so that 
multiple migration-cost settings could be tried? Would it be possible to 
try a few other values via the migration_factor boot option, in 0.5 msec 
steps or so, to find the current sweet spot? It used to be at 11 msec 
previously, correct? E.g. migration_factor=105 will change the cost to 
10.9 msec, migration_factor=110 will change it to 11.4, etc. Or with the 
latest snapshot you can set absolute values as well, 
migration_cost=11500 sets the cost to 11.5 msec.

> One other minor thing: when booting a numa kernel on smp box, there is 
> a numa scheduler domain at the top level and cache_hot_time will be 
> set to 0 in that case on smp box.  Though this will be a mutt point 
> with recent patch from Suresh Siddha for removing the extra bogus 
> scheduler domains.  
> http://marc.theaimsgroup.com/?t=111240208000001&r=1&w=2

at first sight the dummy domain should not be a problem, the ->cache_hot 
values are only used when deciding whether a task should migrate to a 
parallel domain or not - if there's an extra highlevel domain instance 
then such decisions are never made, so a zero value makes no difference.

	Ingo
