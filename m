Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318065AbSIETVu>; Thu, 5 Sep 2002 15:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318079AbSIETVu>; Thu, 5 Sep 2002 15:21:50 -0400
Received: from zeus.kernel.org ([204.152.189.113]:34714 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S318065AbSIETVt>;
	Thu, 5 Sep 2002 15:21:49 -0400
Message-ID: <3D77AEED.5ADAA4@zip.com.au>
Date: Thu, 05 Sep 2002 12:22:21 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Race in shrink_cache
References: <E17mooe-00064m-00@starship> <E17n1ZQ-00069v-00@starship> <3D77A7A3.FBA1C598@zip.com.au> <E17n1zV-0006AJ-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Thursday 05 September 2002 20:51, Andrew Morton wrote:
> > Daniel Phillips wrote:
> > >
> > > ..
> > > On the other hand, if what you want is a private list that page_cache_release
> > > doesn't act on automatically, all you have to do is set the lru state to zero,
> > > leave the page count incremented and move to the private list.  You then take
> > > explicit responsibility for freeing the page or moving it back onto a
> > > mainstream lru list.
> >
> > That's the one.  Page reclaim speculatively removes a chunk (typically 32) of
> > pages from the LRU, works on them, and puts back any unfreeable ones later
> > on.
> 
> Convergent evolution.  That's exactly the same number I'm handling as a
> chunk in my rmap sharing project (backgrounded for the moment).  In this
> case, the 32 comes from the number of bits you can store in a long, and
> it conveniently happens to fall in the sweet spot of performance as well.

That's SWAP_CLUSTER_MAX.  I've never really seen a reason to change
its value.  On 4k pagesize.

The pagevecs use 16 pages.  The thinking here is that we want it to
be large enough to be efficient, but small enough so that all the
pageframes are still in L1 when we come around and hit on them again.
Plus pagevecs are placed on the stack.

> ...
> I think the extra refcount strategy is inherently stronger, and this
> is an example of why.  The other would require you to take/drop an
> extra count explicitly for your private list.

OK.  I assume you taught invalidate_inode_pages[2] about the extra ref?
