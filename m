Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161154AbVKDQBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161154AbVKDQBj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161155AbVKDQBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:01:39 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11980 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161154AbVKDQBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:01:37 -0500
Date: Fri, 4 Nov 2005 08:00:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andy Nelson <andy@thermo.lanl.gov>
cc: akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie, mingo@elte.hu,
       nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <20051104145628.90DC71845CE@thermo.lanl.gov>
Message-ID: <Pine.LNX.4.64.0511040738540.27915@g5.osdl.org>
References: <20051104145628.90DC71845CE@thermo.lanl.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Nov 2005, Andy Nelson wrote:
>
> Big pages don't work now, and zones do not help because the
> load is too unpredictable. Sysadmins *always* turn them
> off, for very good reasons. They cripple the machine.

They do. Guess why? It's complicated.

SGI used to do things like that in Irix. They had the flakiest Unix kernel 
out there. There's a reason people use Linux, and it's not all price. A 
lot of it is development speed, and that in turn comes very much from not 
making insane decisions that aren't maintainable in the long run.

Trust me. We can make things _better_, by having zones that you can't do 
kernel allocations from. But you'll never get everything you want, without 
turning the kernel into an unmaintainable mess. 

> I think it was Martin Bligh who wrote that his customer gets
> 25% speedups with big pages. That is peanuts compared to my
> factor 3.4 (search comp.arch for John Mashey's and my name
> at the University of Edinburgh in Jan/Feb 2003 for a conversation
> that includes detailed data about this), but proves the point that 
> it is far more than just me that wants big pages. 

I didn't find your post on google, but I assume that a large portion on 
your 3.4 factor was hardware.

The fact is, there are tons of architectures that suck at TLB handling. 
They have small TLB's, and they fill slowly.

x86 is actually one of the best ones out there. It has a hw TLB fill, and 
the page tables are cached, with real-life TLB fill times in the single 
cycles (a P4 can almost be seen as effectively having 32kB pages because 
it fills it's TLB entries to fast when they are next to each other in the 
page tables). Even when you have lots of other cache pressure, the page 
tables are at least in the L2 (or L3) caches, and you effectively have a 
really huge TLB.

In contrast, a lot of other machines will use non-temporal loads to load 
the TLB entries, forcing them to _always_ go to memory, and use software 
fills, causing the whole machine to stall. To make matters worse, many of 
them use hashed page tables, so that even if they could (or do) cache 
them, the caching just doesn't work very well.

(I used to be a big proponent of software fill - it's very flexible. It's 
also very slow. I've changed my mind after doing timing on x86)

Basically, any machine that gets more than twice the slowdown is _broken_. 
If the memory access is cached, then so should be page table entry be 
(page tables are _much_ smaller than the pages themselves), so even if you 
take a TLB fault on every single access, you shouldn't see a 3.4 factor.

So without finding your post, my guess is that you were on a broken 
machine. MIPS or alpha do really well when things generally fit in the 
TLB, but break down completely when they don't due to their sw fill (alpha 
could have fixed it, it had _archtiecturally_ sane page tables that it 
could have walked in hw, but never got the chance. May it rest in peace).

If I remember correctly, ia64 used to suck horribly because Linux had to 
use a mode where the hw page table walker didn't work well (maybe it was 
just an itanium 1 bug), but should be better now. But x86 probably kicks 
its butt.

The reason x86 does pretty well is that it's got one of the few sane page 
table setups out there (oh, page table trees are old-fashioned and simple, 
but they are dense and cache well), and the microarchitecture is largely 
optimized for TLB faults. Not having ASI's and having to work with an OS 
that invalidated the TLB about every couple of thousand memory accesses 
does that to you - it puts the pressure to do things right.

So I suspect Martin's 25% is a lot more accurate on modern hardware (which 
means x86, possibly Power. Nothing else much matters).

> If your and other kernel developer's (<<0.01% of the universe) kernel
> builds slow down by 5% and my and other people's simulations (perhaps 
> 0.01% of the universe) speed up by a factor up to 3 or 4, who wins? 

First off, you won't speed up by a factor of three or four. Not even 
_close_. 

Second, it's not about performance. It's about maintainability. It's about 
having a system that we can use and understand 10 years down the line. And 
the VM is a big part of that.

			Linus
