Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318344AbSIBSQf>; Mon, 2 Sep 2002 14:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318346AbSIBSQf>; Mon, 2 Sep 2002 14:16:35 -0400
Received: from dsl-213-023-021-067.arcor-ip.net ([213.23.21.67]:33164 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318344AbSIBSQe>;
	Mon, 2 Sep 2002 14:16:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Subject: Re: [RFC] [PATCH] Include LRU in page count
Date: Mon, 2 Sep 2002 20:01:05 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
References: <3D644C70.6D100EA5@zip.com.au> <E17lEDR-0004Qq-00@starship> <20020902172322.23692.qmail@thales.mathematik.uni-ulm.de>
In-Reply-To: <20020902172322.23692.qmail@thales.mathematik.uni-ulm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17lvVa-0004in-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 September 2002 19:23, Christian Ehrhardt wrote:
> On Sat, Aug 31, 2002 at 09:47:29PM +0200, Daniel Phillips wrote:
> > > Also there may be lru only pages on the active list, i.e. refill
> > > inactive should have this hunk as well:
> > > 
> > > > +#if LRU_PLUS_CACHE==2
> > > > +             BUG_ON(!page_count(page));
> > > > +             if (unlikely(page_count(page) == 1)) {
> > > > +                     mmstat(vmscan_free_page);
> > > > +                     BUG_ON(!TestClearPageLRU(page)); // side effect abuse!!
> > > > +                     put_page(page);
> > > > +                     continue;
> > > > +             }
> > > > +#endif
> > 
> > If we have orphans on the active list, we'd probably better just count
> > them and figure out what we're doing wrong to put them there in the first
> > place.  In time they will migrate to the inactive list and get cleaned
> > up.
> 
> Hm, think of your favourite memory hog being killed with lots of anon
> pages on the active list while someone else holds the lru lock.
> Won't all these anon pages legally end up orphaned on the active list
> (due to the trylock in page_cache_release)?

Some of them will, for one pass of refill_inactive.  It seems hard to justify
saving a single pass through the active list executed in rare, pathological
circumstances, in return for adding even a simple test, executed commonly.

On a dual processor system, one of them should be scanning while the
other is oom_killing.   It should work out fine.

-- 
Daniel
