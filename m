Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751509AbVKDPjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbVKDPjv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 10:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbVKDPjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 10:39:51 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:23787 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S1751509AbVKDPj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 10:39:29 -0500
To: andy@thermo.lanl.gov, mingo@elte.hu
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Cc: akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au, pj@sgi.com, torvalds@osdl.org
In-Reply-To: <20051104151842.GA5745@elte.hu>
Message-Id: <20051104153903.E5D561845FF@thermo.lanl.gov>
Date: Fri,  4 Nov 2005 08:39:03 -0700 (MST)
From: andy@thermo.lanl.gov (Andy Nelson)
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ingo wrote:
>ok, this posting of you seems to be it:

> <elided>

>to me it seems that this slowdown is due to some inefficiency in the
>R12000's TLB-miss handling - possibly very (very!) long TLB-miss
>latencies? On modern CPUs (x86/x64) the TLB-miss latency is rarely
>visible. Would it be possible to run some benchmarks of hugetlbs vs. 4K
>pages on x86/x64?
>
>if my assumption is correct, then hugeTLBs are more of a workaround for
>bad TLB-miss properties of the CPUs you are using, not something that
>will inevitably happen in the future. Hence i think the 'factor 3x'
>slowdown should not be realistic anymore - or are you still running
>R12000 CPUs?

>        Ingo


AFAIK, mips chips have a software TLB refill that takes 1000
cycles more or less. I could be wrong. There are sgi folk on this
thread, perhaps they can correct me. What is important is
that I have done similar tests on other arch's and found very
similar results. Specifically with IBM machines running both
AIX and Linux. I've never had the opportunity to try variable
page size stuff on amd or intel chips, either itanic or x86
variants.

The effect is not a consequence of any excessively long tlb 
handling times for one single arch.

The effect is a property of the code. Which has one part that
is extremely branchy: traversing a tree, and another part that
isn't branchy but grabs stuff from all over everywhere.

The tree traversal works like this:  Start from the root and stop at
each node, load a few numbers, multiply them together and compare to
another number, then open that node or go on to a sibling node. Net, 
this is about 5-8 flops and a compare per node. The issue is that the 
next time you  want to look at a tree node, you are someplace else 
in memory entirely. That means a TLB miss almost always.

The tree traversal leaves me with a list of a few thousand nodes
and atoms. I use these nodes and atoms to calculate gravity on some
particle or small group of particles. How? For each node, I grab about
10 numbers from a couple of arrays, do about 50 flops with those 
numbers, and store back 4 more numbers. The store back doesn't hurt
anything becasuse it really only happens once at the end of the list.


In the naive case, grabbing 10 numbers out of arrays that are mutiple
GB in size means 10 TLB misses. The obvious solution is to stick
everything together that is needed together, and get that down to
one or two. I've done that. The results you quoted in your post
reflect that. In other words, the performance difference is the minimal
number of TLB misses that I can manage to get. 

Now if you have a list of thousands of nodes to cycle through, each of
which lives on a different page (ordinarily true), you thrash TLB,
and you thrash L1, as I noted in my original post. 

Believe me, I have worried about this sort of stuff intensely,
and recoded around it a lot. The performance number you saw were what
is left over. 

It is true that other sorts of codes have much more regular memory
access patterns, and don't have nearly this kind of speedup. Perhaps
more typical would be the 25% number quoted by Martin Bligh.


Andy



