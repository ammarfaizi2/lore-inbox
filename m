Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317473AbSIETxe>; Thu, 5 Sep 2002 15:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318026AbSIETxe>; Thu, 5 Sep 2002 15:53:34 -0400
Received: from dsl-213-023-039-222.arcor-ip.net ([213.23.39.222]:17065 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317473AbSIETxd>;
	Thu, 5 Sep 2002 15:53:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: Race in shrink_cache
Date: Thu, 5 Sep 2002 22:00:14 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <E17mooe-00064m-00@starship> <E17n1zV-0006AJ-00@starship> <3D77AEED.5ADAA4@zip.com.au>
In-Reply-To: <3D77AEED.5ADAA4@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17n2nX-0006Ah-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 September 2002 21:22, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > On Thursday 05 September 2002 20:51, Andrew Morton wrote:
> > > Daniel Phillips wrote:
> > > >
> > > > ..
> > > > On the other hand, if what you want is a private list that page_cache_release
> > > > doesn't act on automatically, all you have to do is set the lru state to zero,
> > > > leave the page count incremented and move to the private list.  You then take
> > > > explicit responsibility for freeing the page or moving it back onto a
> > > > mainstream lru list.
> > >
> > > That's the one.  Page reclaim speculatively removes a chunk (typically 32) of
> > > pages from the LRU, works on them, and puts back any unfreeable ones later
> > > on.
> > 
> > Convergent evolution.  That's exactly the same number I'm handling as a
> > chunk in my rmap sharing project (backgrounded for the moment).  In this
> > case, the 32 comes from the number of bits you can store in a long, and
> > it conveniently happens to fall in the sweet spot of performance as well.
> 
> That's SWAP_CLUSTER_MAX.  I've never really seen a reason to change
> its value.  On 4k pagesize.
> 
> The pagevecs use 16 pages.  The thinking here is that we want it to
> be large enough to be efficient, but small enough so that all the
> pageframes are still in L1 when we come around and hit on them again.
> Plus pagevecs are placed on the stack.
> 
> > ...
> > I think the extra refcount strategy is inherently stronger, and this
> > is an example of why.  The other would require you to take/drop an
> > extra count explicitly for your private list.
> 
> OK.  I assume you taught invalidate_inode_pages[2] about the extra ref?

Yes, all the magic tests have been replaced with versions that depend on
the LRU_PLUS_CACHE define (1 or 2).  As a side effect, this lets you find
all the places that care about this with a simple grep, so I'd be inclined
to leave the symbol in, even after we decide which setting we prefer.

-- 
Daniel
