Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbVKDQlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVKDQlm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbVKDQlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:41:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19671 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750701AbVKDQll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:41:41 -0500
Date: Fri, 4 Nov 2005 08:40:52 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
cc: Andy Nelson <andy@thermo.lanl.gov>, akpm@osdl.org, arjan@infradead.org,
       arjanv@infradead.org, haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mel@csn.ul.ie, mingo@elte.hu,
       nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <331390000.1131120808@[10.10.2.4]>
Message-ID: <Pine.LNX.4.64.0511040814530.27915@g5.osdl.org>
References: <20051104145628.90DC71845CE@thermo.lanl.gov>
 <Pine.LNX.4.64.0511040738540.27915@g5.osdl.org> <331390000.1131120808@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Nov 2005, Martin J. Bligh wrote:
> 
> > So I suspect Martin's 25% is a lot more accurate on modern hardware (which 
> > means x86, possibly Power. Nothing else much matters).
> 
> It was PPC64, if that helps.

Ok. I bet x86 is even better, but Power (and possibly itanium) is the only 
other architecture that comes close.

I don't like the horrible POWER hash-tables, but for static workloads they 
should perform almost as well as a sane page table (I say "almost", 
because I bet that the high-performance x86 vendors have spent a lot more 
time on tlb latency than even IBM has). My dislike for them comes from the 
fact that they are really only optimized for static behaviour.

(And HPC is almost always static wrt TLB stuff - big, long-running 
processes).

> Well, I think it depends on the workload a lot. However fast your TLB is,
> if we move from "every cacheline read requires is a TLB miss" to "every
> cacheline read is a TLB hit" that can be a huge performance knee however
> fast your TLB is. Depends heavily on the locality of reference and size
> of data set of the application, I suspect.

I'm sure there are really pathological examples, but the thing is, they 
won't be on reasonable code.

Some modern CPU's have TLB's that can span the whole cache. In other 
words, if your data is in _any_ level of caches, the TLB will be big 
enough to find it.

Yes, that's not universally true, and when it's true, the TLB is two-level 
and you can have loads where it will usually miss in the first level, but 
we're now talking about loads where the _data_ will then always miss in 
the first level cache too. So the TLB miss cost will always be _lower_ 
than the data miss cost.

Right now, you should buy Opteron if you want that kind of large TLB. I 
_think_ Intel still has "small" TLB's (the cpuid information only goes up 
to 128 entries, I think), but at least Intel has a really good fill. And I 
would bet (but have no first-hand information) that next generation 
processors will only get bigger TLB's. These things don't tend to shrink.

(Itanium also has a two-level TLB, but it's absolutely pitiful in size).

NOTE! It is absolutely true that for a few years we had regular caches 
growing much faster than TLB's. So there are unquestionably unbalanced 
machines out there. But it seems that CPU designers started noticing, and 
every indication is that TLB's are catching up.

In other words, adding lots of kernel complexity is the wrong thing in the 
long run. This is not a long-term problem, and even in the short term you 
can fix it by just selecting the right hardware.

In todays world, AMD leads with bug TLB's (1024-entry L2 TLB), but Intel 
has slightly faster fill and the AMD TLB filtering is sadly turned off on 
SMP right now, so you might not always get the full effect of the large 
TLB (but in HPC you probably won't have task switching blowing your TLB 
away very often).

PPC64 has the huge hashed page tables that work well enough for HPC. 

Itanium has a pitifully small TLB, and an in-order CPU, so it will take a 
noticeably bigger hit on TLB's than x86 will. But even Itanium will be a 
_lot_ better than MIPS was.

			Linus
