Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263195AbRFED6I>; Mon, 4 Jun 2001 23:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263187AbRFED56>; Mon, 4 Jun 2001 23:57:58 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:1297 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263177AbRFED5o>; Mon, 4 Jun 2001 23:57:44 -0400
Date: Mon, 4 Jun 2001 23:21:17 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Andrea Arcangeli <andrea@suse.de>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.5
In-Reply-To: <Pine.LNX.4.21.0106031618100.32451-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0106042312110.2671-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



(ugh, just found this mail lost around here)

On Sun, 3 Jun 2001, Linus Torvalds wrote:

> 
> [ Back from Japan - don't start sending me tons of emails yet, as you can
>   see I'm only picking up last weeks discussion where it ended right
>   now.. ]
> 
> On Sat-Sun, 26-27 May 2001, Marcelo Tosatti wrote:
> > 
> > You are not going to fix the problem by _only_ doing this bh allocation
> > change.
> 
> I would obviously not disagree with that statement. There are multiple
> users of the low-memory zone, and they are all likely to have some of the
> same problems. 
> 
> > Even if some bh allocators _can_ block on IO, there is no guarantee that
> > they are going to free low memory --- they may start more IO on highmem
> > pages.
> 
> Now, this was actually something I already referred to earlier in this
> same thread, see one of myt first mails about this:
> 
> Fri, 25 May 2001 21:22:05 Linus Torvalds wrote:
> >>
> >> For example, we used to have logic in swapout_process to _not_ swap
> >> out zones that don't need it. We changed swapout to happen in
> >> "page_launder()", but that logic got lost. It's entirely possible that
> >> we should just say "don't bother writing out dirty pages that are in
> >> zones that have no memory pressure", so that we don't use up pages
> >> from the _precious_ zones to free pages in zones that don't need
> >> freeing.
> 
> So note how there are multiple facets to this problem.
> 
> 
> Marcelo goes on to write:
> > 
> > I've just tried something similar to the attached patch, which is a "more
> > aggressive" version of your suggestion to use SLAB_KERNEL for bh
> > allocations when possible. This one makes all bh allocators block on IO. 
> 
> The patch looks fine. Has anybody else tried it?

The XFS people have been using GFP_PAGE_IO for sometime in their
CVS. (getblk is not using GFP_PAGE_IO there, though).

> Along with, for example, something like this [warning: whitespace damage,
> I just cut-and-pasted this as a test-patch], we might actually _fix_ the
> problem:
> 
> --- v2.4.5/linux/mm/vmscan.c    Fri May 25 18:28:55 2001
> +++ linux/mm/vmscan.c   Sun Jun  3 16:26:20 2001
> @@ -463,6 +463,7 @@
>  
>                 /* Page is or was in use?  Move it to the active list. */
>                 if (PageReferenced(page) || page->age > 0 ||
> +                               page->zone->free_pages > page->zone->pages_max ||
>                                 (!page->buffers && page_count(page) > 1) ||
>                                 page_ramdisk(page)) {
>                         del_page_from_inactive_dirty_list(page);
> 
> What the above does is fairly obvious: it considers all pages in zones
> that don't need to be free'd to be "young", and doesn't even try to write
> them out. Because we have absolutely no reason to do so.

This patch makes perfect sense, but it does not avoid us from writing out
highmem pages (_even_ if the highmem zone has a shortage) in case the
lowmem is under shortage.

We _need_ low memory to writeout high memory, thats my point.



