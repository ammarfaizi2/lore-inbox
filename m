Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbVKFHfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbVKFHfb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 02:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVKFHfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 02:35:31 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:24518 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751324AbVKFHfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 02:35:31 -0500
Date: Sat, 5 Nov 2005 23:34:08 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, andy@thermo.lanl.gov, mbligh@mbligh.org, akpm@osdl.org,
       arjan@infradead.org, arjanv@infradead.org, haveblue@us.ibm.com,
       kravetz@us.ibm.com, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-Id: <20051105233408.3037a6fe.pj@sgi.com>
In-Reply-To: <20051104155317.GA7281@elte.hu>
References: <20051104010021.4180A184531@thermo.lanl.gov>
	<Pine.LNX.4.64.0511032105110.27915@g5.osdl.org>
	<20051103221037.33ae0f53.pj@sgi.com>
	<20051104063820.GA19505@elte.hu>
	<Pine.LNX.4.64.0511040725090.27915@g5.osdl.org>
	<20051104155317.GA7281@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> i think the current hugepages=<N> boot option could transparently be 
> morphed into a 'separate zone' approach, and ...
> 
> this would already be alot more flexible that what we have: the hugetlb 
> area would not be 'lost' altogether, like now. Once we are at this stage 
> we can see how usable it is in practice. I strongly suspect it will 
> cover most of the HPC uses.

It seems to me this is making it harder than it should be.  You're
trying to create a zone that is 100% cleanable, whereas the HPC folks
only desire 99.8% cleanable.

Unlike the hot(un)plug folks, the HPC folks don't mind a few pages of
Linus's unmoveable kmalloc memory in their way.  They rather expect
that some modest percentage of each node will have some 'kernel stuff'
on it that refuses to move.  They just want to be able to free up
most of the pages on a node, once one job is done there, before the
next job begins.

They are also quite willing (based on my experience with bootcpusets)
to designate a few nodes for the 'general purpose Unix load', and
reserve the remaining nodes just to run their special jobs.

On the other hand, as Eric Dumazet mentions on another subthread of
this topic, requiring that their apps use the hugetlbfs interface
to place the bulk of their memory would be a serious obstacle.
Their apps are already fairly tightly wound around a rich variety
of compiler, tool, library and runtime memory placement mechanisms,
and they would be hardpressed to make systematic changes in that.

I suspect that the answers lie in some further improvements in memory
placement on various nodes.  Perhaps this means a cpuset option to
put the easily reclaimed (what Mel Gorman's patch would mark with
__GFP_EASYRCLM) kernel pages and the user pages on the the nodes of
the current cpuset, but to prefer placing the less easily reclaimed
pages on the bootcpuset nodes.  Then, when a job on such a dedicated
set of nodes completed, most of the memory would be easily reclaimable,
in preparation for the next job.

The bootcpuset stuff is entirely invisible to kernel hackers, because
I am doing it entirely in user space, with a pre-init program that
configures the bootcpuset, moves the unpinned kernel threads into
the bootcpuset, and fires up the real init in that bootcpuset.

With one more twist to the cpuset API, providing a way to state
per-cpuset a separate set of nodes (on what the HPC folks would call
their bootcpuset) as the preferred place to allocate not-EASYRCLM
kernel memory, we might be very close to meeting these HPC needs,
with no changes to or reliance on hugetlbs, with no changes to the
kernel boottime code, and with no changes to the memory management
mechanisms used within these HPC apps.

I am imagining yet another per-cpuset field, which I call 'kmems'.  It
would be a nodemask, as is the current 'mems' field.  I'd pick up the
__GFP_EASYRCLM flag of Mel Gorman's patch (no comment on suitability of
the rest of his patch), and prefer to place __GFP_EASYRCLM pages on the
'mems' nodes, but other pages evenly spread across the 'kmems' nodes.
For compatibility with the current cpuset API, an unset 'kmems'
would tell the kernel to use the 'mems' setting as a fallback.

The hardest part might be providing a mechanism, that would be invoked
by the batch scheduler between jobs, to flush the easily reclaimed
memory off a node (free it or write it to disk).  Again, unlike the
hot(un)plug folks, a 98% solution is plenty good enough.

This will have to be coded and some HPC type loads tried on it, before
we know if it flies.

There is an obvious, unanswered question here.  Would moving some of
the kernels pages (the not easily reclaimed pages) off the current
(faulting) node into some possibly far off node be an acceptable
price to pay, to increase the percentage of the dedicated job nodes
that can be freed up between jobs?  Since these HPC jobs tend to be
far more sensitive to their own internal data placement than they
are to the kernels internal data placement, I am hopeful that this
tradeoff is a good one, for HPC apps.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
