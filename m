Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318047AbSIETCL>; Thu, 5 Sep 2002 15:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318069AbSIETCK>; Thu, 5 Sep 2002 15:02:10 -0400
Received: from dsl-213-023-039-222.arcor-ip.net ([213.23.39.222]:53160 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318047AbSIETBw>;
	Thu, 5 Sep 2002 15:01:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: Race in shrink_cache
Date: Thu, 5 Sep 2002 21:08:33 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <E17mooe-00064m-00@starship> <E17n1ZQ-00069v-00@starship> <3D77A7A3.FBA1C598@zip.com.au>
In-Reply-To: <3D77A7A3.FBA1C598@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17n1zV-0006AJ-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 September 2002 20:51, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > ..
> > On the other hand, if what you want is a private list that page_cache_release
> > doesn't act on automatically, all you have to do is set the lru state to zero,
> > leave the page count incremented and move to the private list.  You then take
> > explicit responsibility for freeing the page or moving it back onto a
> > mainstream lru list.
> 
> That's the one.  Page reclaim speculatively removes a chunk (typically 32) of
> pages from the LRU, works on them, and puts back any unfreeable ones later
> on.

Convergent evolution.  That's exactly the same number I'm handling as a
chunk in my rmap sharing project (backgrounded for the moment).  In this
case, the 32 comes from the number of bits you can store in a long, and
it conveniently happens to fall in the sweet spot of performance as well.

In this case I only have to manipulate one list element though, because
I'm taking the lru list itself out onto the shared rmap node, saving 8
bytes in struct page as a side effect.  So other than the size of the
chunk, the resemblance is slight.  ETA for this is 2.7, unless you
suddenly start threatening to back out rmap again.

> And the rest of the VM was taught to play correctly with pages that
> can be off the LRU.  This was to avoid hanging onto the LRU lock while
> running page reclaim.
> 
> And when those 32 pages are speculatively removed, their refcounts are
> incremented.  Maybe that isn't necessary - I'd need to think about
> that.  If it isn't, then the double-free thing is fixed.  If it is
> necessary then then lru-adds-a-ref approach is nice, because shrink_cache
> doesn't need to page_cache_get each page while holding the LRU lock,
> as you say.

I think the extra refcount strategy is inherently stronger, and this
is an example of why.  The other would require you to take/drop an
extra count explicitly for your private list.

-- 
Daniel
