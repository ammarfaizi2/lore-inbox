Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319034AbSH1WUY>; Wed, 28 Aug 2002 18:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319035AbSH1WUY>; Wed, 28 Aug 2002 18:20:24 -0400
Received: from dsl-213-023-022-149.arcor-ip.net ([213.23.22.149]:35020 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319034AbSH1WUW>;
	Wed, 28 Aug 2002 18:20:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: MM patches against 2.5.31
Date: Thu, 29 Aug 2002 00:04:46 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3D644C70.6D100EA5@zip.com.au> <E17k9dO-0002tR-00@starship> <3D6D3AA4.31A4AD3A@zip.com.au>
In-Reply-To: <3D6D3AA4.31A4AD3A@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17kAvf-0002tx-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 August 2002 23:03, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > Going right back to basics, what do you suppose is wrong with the 2.4
> > strategy of always doing the lru removal in free_pages_ok?
> 
> That's equivalent to what we have at present, which is:
> 
> 	if (put_page_testzero(page)) {
> 		/* window here */
> 		lru_cache_del(page);
> 		__free_pages_ok(page, 0);
> 	}
> 
> versus:
> 
> 	spin_lock(lru lock);
> 	page = list_entry(lru, ...);
> 	if (page_count(page) == 0)
> 		continue;
> 	/* window here */
> 	page_cache_get(page);
> 	page_cache_release(page);	/* double-free */

Indeed it is.  In 2.4.19 we have:

(vmscan.c: shrink_cache)                        (page_alloc.c: __free_pages)

365       if (unlikely(!page_count(page)))
366               continue;
					        444         if (!PageReserved(page) && put_page_testzero(page))
          [many twisty paths, all different]
511       /* effectively free the page here */
512       page_cache_release(page);
					        445                 __free_pages_ok(page, order);
                                                [free it again just to make sure]

So there's no question that the race is lurking in 2.4.  I noticed several
more paths besides the one above that look suspicious as well.  The bottom
line is, 2.4 needs a fix along the lines of my suggestion or Christian's,
something that can actually be proved.

It's a wonder that this problem manifests so rarely in practice.

-- 
Daniel
