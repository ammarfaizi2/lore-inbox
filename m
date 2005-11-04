Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161163AbVKDQFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161163AbVKDQFZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161162AbVKDQFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:05:25 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:45199 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161161AbVKDQFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:05:23 -0500
Date: Fri, 4 Nov 2005 17:05:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andy Nelson <andy@thermo.lanl.gov>
Cc: akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au, pj@sgi.com, torvalds@osdl.org
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <20051104160505.GA7689@elte.hu>
References: <20051104151842.GA5745@elte.hu> <20051104153903.E5D561845FF@thermo.lanl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104153903.E5D561845FF@thermo.lanl.gov>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Nelson <andy@thermo.lanl.gov> wrote:

> Ingo wrote:
> >ok, this posting of you seems to be it:
> 
> > <elided>
> 
> >to me it seems that this slowdown is due to some inefficiency in the
> >R12000's TLB-miss handling - possibly very (very!) long TLB-miss
> >latencies? On modern CPUs (x86/x64) the TLB-miss latency is rarely
> >visible. Would it be possible to run some benchmarks of hugetlbs vs. 4K
> >pages on x86/x64?
> >
> >if my assumption is correct, then hugeTLBs are more of a workaround for
> >bad TLB-miss properties of the CPUs you are using, not something that
> >will inevitably happen in the future. Hence i think the 'factor 3x'
> >slowdown should not be realistic anymore - or are you still running
> >R12000 CPUs?
> 
> >        Ingo
> 
> 
> AFAIK, mips chips have a software TLB refill that takes 1000 cycles 
> more or less. I could be wrong. [...]

x86 in comparison has a typical cost of 7 cycles per TLB miss. And a 
modern x64 chip has 1024 TLBs ... If that's not enough then i believe 
you'll be limited by cachemiss costs and RAM latency/throughput anyway, 
and the only thing the TLB misses have to do is to be somewhat better 
than those bottlenecks. TLBs are really fast in the x86/x64 world. Then 
there come other features like TLB prefetch, so if you are touching 
pages in any predictable fashion you ought to see better latencies than 
the worst-case.

> The effect is not a consequence of any excessively long tlb handling 
> times for one single arch.
> 
> The effect is a property of the code. Which has one part that is 
> extremely branchy: traversing a tree, and another part that isn't 
> branchy but grabs stuff from all over everywhere.

i dont think anyone argues against the fact that a larger 'TLB reach' 
will most likely improve performance. The question is always 'by how 
much', and that number very much depends on the cost of a single TLB 
miss. (and on alot of other factors)

(note that it's also possible for large TLBs to cause a slowdown: there 
are CPUs [e.g. P3] where there are fewer large TLBs than 4K TLBs, so 
there are workloads where you lose due to fewer TLBs. It is also 
possible for large TLBs to be zero speedup: if the working set is so 
large that you will always get a TLB miss with a new node accessed.)

	Ingo
