Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284752AbRLKALz>; Mon, 10 Dec 2001 19:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284754AbRLKALo>; Mon, 10 Dec 2001 19:11:44 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:19820 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S284752AbRLKALh>; Mon, 10 Dec 2001 19:11:37 -0500
Date: Tue, 11 Dec 2001 01:11:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
Message-ID: <20011211011158.A4801@athlon.random>
In-Reply-To: <Pine.LNX.4.21.0112101705281.25362-100000@freak.distro.conectiva> <3C151F7B.44125B1@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C151F7B.44125B1@zip.com.au>; from akpm@zip.com.au on Mon, Dec 10, 2001 at 12:47:55PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2001 at 12:47:55PM -0800, Andrew Morton wrote:
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

please check 2.4.17pre4aa1, see the per-classzone info, they will
prevent all the problems with the refill inactive with highmem.

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

done ages ago here.

> 
> In my swapless testing, I burnt HUGE amounts of CPU in flush_tlb_others().
> So we're madly trying to swap pages out and finding that there's no swap
> space.  I beleive that when we find there's no swap left we should move
> the page onto the active list so we don't keep rescanning it pointlessly.

yes, however I think the swap-flood with no swap isn't a very
interesting case to optimize.

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

dunno about this modify_ldt failure.

> 
> I did some similar testing a week or so ago, also tested
> the -aa patches.  They seemed to maybe help a tiny bit,
> but not significantly.

I don't have any pending bug report. AFIK those bugs are only in
mainline. If you can reproduce with -aa please send me a bug report.
thanks,

Andrea
