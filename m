Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263187AbVBDG0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263187AbVBDG0l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 01:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVBDG0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 01:26:40 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:4321 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263187AbVBDG00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 01:26:26 -0500
Date: Thu, 3 Feb 2005 22:26:07 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Paul Mackerras <paulus@samba.org>
cc: Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       David Woodhouse <dwmw2@infradead.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: A scrub daemon (prezeroing)
In-Reply-To: <16899.2175.599702.827882@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.58.0502032220430.28851@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
 <1106828124.19262.45.camel@hades.cambridge.redhat.com> <20050202153256.GA19615@logos.cnet>
 <Pine.LNX.4.58.0502021103410.12695@schroedinger.engr.sgi.com>
 <20050202163110.GB23132@logos.cnet> <Pine.LNX.4.61.0502022204140.2678@chimarrao.boston.redhat.com>
 <16898.46622.108835.631425@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0502031650590.26551@schroedinger.engr.sgi.com>
 <16899.2175.599702.827882@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005, Paul Mackerras wrote:

> The dcbz instruction on the G5 (PPC970) establishes the new cache line
> in the L2 cache and doesn't disturb the L1 cache (except to invalidate
> the line in the L1 data cache if it is present there).  The L2 cache
> is 512kB and 8-way set associative (LRU).  So zeroing a page is
> unlikely to disturb the cache lines that the page fault handler is
> using.  Then, when the page fault handler returns to the user program,
> any cache lines that the program wants to touch are available in 12
> cycles (L2 hit latency) instead of 200 - 300 (memory access latency).

If the program does not use these cache lines then you have wasted time
in the page fault handler allocating and handling them. That is what
prezeroing does for you.

> > cpu caches) is extraordinarily fast and the zeroing of large portions of
> > memory is so too. That is why the impact of scrubd is negligible since
> > its extremely fast.
>
> But that also disturbs cache lines that may well otherwise be useful.

Yes but its a short burst that only occurs very infrequestly and it takes
advantage of all the optimizations that modern memory subsystems have for
linear accesses. And if hardware exists that can offload that from the cpu
then the cpu caches are only minimally affected.

> As has my scepticism about pre-zeroing actually providing any benefit
> on ppc64.  Nevertheless, the only definitive answer is to actually
> measure the performance both ways.

Of course. The optimization depends on the type of load. If you use a
benchmark that writes to all pages in a page then you will see no benefit
at all. For a kernel compile you will see a slight benefit. For processing
of a sparse matrix (page tables are one example) a significant benefit can
be obtained.
