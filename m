Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286381AbRLJU7c>; Mon, 10 Dec 2001 15:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286380AbRLJU7U>; Mon, 10 Dec 2001 15:59:20 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:33551 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S286384AbRLJU7J>; Mon, 10 Dec 2001 15:59:09 -0500
Date: Mon, 10 Dec 2001 17:42:38 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrew Morton <akpm@zip.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
In-Reply-To: <3C151F7B.44125B1@zip.com.au>
Message-ID: <Pine.LNX.4.21.0112101741430.25397-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Dec 2001, Andrew Morton wrote:

> Marcelo Tosatti wrote:
> > 
> > Andrea,
> > 
> > Could you please start looking at any 2.4 VM issues which show up ?
> > 
> 
> Just fwiw, I did some testing on this yesterday.
> 
> Buffers and cache data are sitting on the active list, and shrink_caches()
> is *not* getting them off the active list, and onto the inactive list
> where they can be freed.
> 
> So we end up with enormous amounts of anon memory on the inactive
> list, so this code:
> 
>         /* try to keep the active list 2/3 of the size of the cache */
>         ratio = (unsigned long) nr_pages * nr_active_pages / ((nr_inactive_pages + 1) * 2);
>         refill_inactive(ratio);
> 
> just calls refill_inactive(0) all the time.  Nothing gets moved
> onto the inactive list - it remains full of unfreeable anon
> allocations.  And with no swap, there's nowhere to go.
> 
> I think a little fix is to add
> 
>         if (ratio < nr_pages)
>                 ratio = nr_pages;
> 
> so we at least move *something* onto the inactive list.
> 
> Also refill_inactive needs to be changed so that it counts
> the number of pages which it actually moved, rather than
> the number of pages which it inspected.
> 
> In my swapless testing, I burnt HUGE amounts of CPU in flush_tlb_others().
> So we're madly trying to swap pages out and finding that there's no swap
> space.  I beleive that when we find there's no swap left we should move
> the page onto the active list so we don't keep rescanning it pointlessly.
> 
> A fix may be to just remove the use-once stuff.  It is one of the
> sources of this problem, because it's overpopulating the inactive list.
> 
> In my testing last night, I tried to allocate 650 megs on a 768 meg
> swapless box.  Got oom-killed when there was almost 100 megs of freeable
> memory: half buffercache, half filecache.  Presumably, all of it was
> stuck on the active list with no way to get off.
> 
> We also need to do something about shrink_[di]cache_memory(),
> which seem to be called in the wrong place.
> 
> There's also the report concerning modify_ldt() failure in a
> similar situation.  I'm not sure why this one occurred.  It
> vmallocs 64k of memory and that seems to fail.

I haven't applied the modify_ldt() patch because I want to make sure its
needed: It may just be a bad effect of this one bug. 

> I did some similar testing a week or so ago, also tested
> the -aa patches.  They seemed to maybe help a tiny bit,
> but not significantly.


