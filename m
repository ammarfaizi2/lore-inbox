Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTF2TLV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 15:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbTF2TLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 15:11:21 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:17792 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262288AbTF2TLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 15:11:13 -0400
Date: Sun, 29 Jun 2003 20:25:30 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Daniel Phillips <phillips@arcor.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC] My research agenda for 2.7
In-Reply-To: <200306271800.53487.phillips@arcor.de>
Message-ID: <Pine.LNX.4.53.0306291953490.20655@skynet>
References: <200306250111.01498.phillips@arcor.de> <Pine.LNX.4.53.0306271617210.21548@skynet>
 <200306271750.52362.phillips@arcor.de> <200306271800.53487.phillips@arcor.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jun 2003, Daniel Phillips wrote:

> >    http://www.research.att.com/sw/tools/vmalloc/
> >    (Vmalloc: A Memory Allocation Library)
>
> Whoops, I retract that.  I did a quick scan of the page and ran into a link
> labled "Non-Commercial License Agreement and Software", attached to some form
> of license loaded with ugly patent words and so on.

The paper itself is still freely available and the idea could still be
implemented but I still think that the slab allocator will be sufficent
for order0 allocations and use caches to cluster the different types of
order0 allocations together. I've read that paper before and I think it is
overkill for the kernel because the allocation pattern isn't that
complicated in comparison to userspace memory management which that
allocator is aimed at. Not to mention that to get the most out of the
allocator, you need to know what your allocation pattern is going to be
like in advance.

Of course, at this point, I still need to write an RFC about using slab
for order0 allocations and ultimatly I'll have to put code where my emails
are :-/

To help show why slab might work though, I updated vmregress and released
0.10 available at http://www.csn.ul.ie/~mel/projects/vmregress/ . The main
addition is that it now can collect some basic statistics on the types of
page allocations. Specifically, with the trace_alloc module loaded and the
trace_pagealloc.diff patch applied (see kernel_patches/ directory),
/proc/vmregress/trace_alloc will print out the number of allocations for
each order that used either the GFP_KERNEL or GFP_USER flags.

To test it, I booted a clean 2.5.73 system[1], started X and ran
konqueror.  The results were;

Kernel allocations
------------------
	 BeforeX	After X
Order 0: 6886		14595
Order 1: 335		383
Order 2: 17		23
Order 3: 2		2
Order 4: 3		3
Order 5: 0		0
Order 6: 0		0
Order 7: 0		0
Order 8: 0		0
Order 9: 0		0
Order 10: 0		0

Userspace allocations
---------------------
Order 0: 53050		71505
Order 1: 1		1
Order 2: 0		0
Order 3: 0		0
Order 4: 0		0
Order 5: 0		0
Order 6: 0		0
Order 7: 0		0
Order 8: 0		0
Order 9: 0		0
Order 10: 0		0

As you can see, order0 allocations were a *lot* more common, at least in
my system. Because they are so common in comparison to other orders, I
think that putting order0 in slabs of size 2^MAX_ORDER will make
defragmentation *so* much easier, if not plain simple, because you can
shuffle around order0 pages in the slabs to free up one slab which frees
up one large 2^MAX_ORDER adjacent block of pages.

It's possible that a journalled filesystem (or some other subsystem I am
not familiar with) would show that order > 0 allocations are a lot more
important than my system shows but the means to collect the information is
in vmregress so be my guest. When the time requires, I'll extend vm
regress to see how fragmented memory actually gets.

Much much later, it would be worth looking at the buddy allocator and
seeing would it be worth changing to something much simpler as most of its
work would be handled by the slab allocator instead.

[1] Tonnes of errors were spewed out on uninitialised timers. With highmem
    enabled, I got a sleeping while atomic error warning in a loop caused
    by default_idle(). I still have to see can I get around to tracking
    down if it's a PEBKAC problem or a kernel bug

-- 
Mel Gorman
