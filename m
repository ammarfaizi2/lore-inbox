Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287627AbRLaT4J>; Mon, 31 Dec 2001 14:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287632AbRLaT4A>; Mon, 31 Dec 2001 14:56:00 -0500
Received: from dsl-213-023-043-129.arcor-ip.net ([213.23.43.129]:60932 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S287627AbRLaTzs>;
	Mon, 31 Dec 2001 14:55:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, alad@hss.hns.com
Subject: Re: locked page handling
Date: Mon, 31 Dec 2001 20:58:49 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <65256B33.0039476C.00@sandesh.hss.hns.com> <3C30BE70.6E5E95CE@zip.com.au>
In-Reply-To: <3C30BE70.6E5E95CE@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16L8aA-0000at-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 31, 2001 08:37 pm, Andrew Morton wrote:
> alad@hss.hns.com wrote:
> > 
> > In 2.4.16, vmscan.c::shrink_cache(), we have following piece of code -
> > 
> >           /*
> >            * The page is locked. IO in progress?
> >            * Move it to the back of the list.
> >            */
> >           if (unlikely(TryLockPage(page))) {
> >                if (PageLaunder(page) && (gfp_mask & __GFP_FS)) {
> >                     page_cache_get(page);
> >                     spin_unlock(&pagemap_lru_lock);
> >                     wait_on_page(page);
> >                     page_cache_release(page);
> >                     spin_lock(&pagemap_lru_lock);
> >                }
> >                continue;
> >           }
> > 
> > 1) Who is moving the page the back of list ?
> 
> Nobody.  The comment is wrong.
> 
> Possibly the code is wrong, too.  We don't want to keep scanning
> the same page all the time.
> 
> > 2) Is the locked page worth waiting for? I can understand that the page is being
> >  laundered so after wait we may get a clean page but from performance
> >      point of view this is involving unnecessary context switches. Also during
> > high memory pressure kswapd shall sleep here when it can get more
> >      clean pages on the inactive list ? What are we loosing if we don't wait on
> > the page and believe that in next pass we shall free this page
> > 
> 
> Well we need to wait on I/O _somewhere_ in there.  Otherwise everyone
> just ends up busywaiting on IO completion.  The idea is that on the
> first pass through the inactive list, we start I/O, mark the page as
> PG_Launder and don't wait on the I/O.  On the second pass through the
> list, when we find a PG_Launder page, we wait on it.  This has the
> effect of slowing memory-requesters down to the speed of the I/O
> system.  All this is for mmapped pages.  The same behaviour is
> implemented for write() pages via the BH_Launder bits on its buffers
> over in sync_page_buffers().

I think we want the pages in process of being written to live on a separate 
list.  Pages can be pulled of that list by a separate thread, or perhaps in 
the IO completion interrupt (opportunistically, if the list lock is available)
meaning kswapd would block less and waste less time examining locked pages.

--
Daniel
