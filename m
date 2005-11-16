Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932558AbVKPBn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932558AbVKPBn3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 20:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbVKPBn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 20:43:29 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:50379 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932558AbVKPBn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 20:43:29 -0500
Date: Wed, 16 Nov 2005 01:43:25 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Andi Kleen <ak@suse.de>
Cc: linux-mm@kvack.org, mingo@elte.hu, lhms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [PATCH 2/5] Light Fragmentation Avoidance V20: 002_usemap
In-Reply-To: <200511160036.54461.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0511160137540.8470@skynet>
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
 <20051115164957.21980.8731.sendpatchset@skynet.csn.ul.ie> <200511160036.54461.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2005, Andi Kleen wrote:

> On Tuesday 15 November 2005 17:49, Mel Gorman wrote:
> > This patch adds a "usemap" to the allocator. Each bit in the usemap indicates
> > whether a block of 2^(MAX_ORDER-1) pages are being used for kernel or
> > easily-reclaimed allocations. This enumerates two types of allocations;
>
> This will increase cache line footprint, which is costly.
> Why can't this be done in the page flags?
>

I actually did a version of these patches using page flags which are
sitting in a temporary directory. For allocation, it derived the type it
was reserved for by the list it was on and on free, it used the flags to
determine what free list it should go back to. There were a few reasons
why I didn't submit it

1. I was using a page flag, valuable commodity, thought I would get kicked
   for it. Usemap uses 1 bit per 2^(MAX_ORDER-1) pages. Page flags uses
   2^(MAX_ORDER-1) bits at worse case.
2. Fragmentation avoidance tended to break down, very fast.
3. When changing a block of pages from one type to another, there was no
   fast way to make sure all pages currently allocation would end up on
   the correct free list
4. Using page flags performed slower than using a usemap, at least with
   aim9. As using the usemap did not regress loads like kernel compiles,
   aim9 or anything else I thought to test, I figured it was not a
   problem.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
