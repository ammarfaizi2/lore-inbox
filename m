Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262409AbSKCUCp>; Sun, 3 Nov 2002 15:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262410AbSKCUCp>; Sun, 3 Nov 2002 15:02:45 -0500
Received: from [195.39.17.254] ([195.39.17.254]:15876 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262409AbSKCUCm>;
	Sun, 3 Nov 2002 15:02:42 -0500
Date: Sun, 3 Nov 2002 21:08:09 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Hot/cold allocation -- swsusp can not handle hot pages
Message-ID: <20021103200809.GC27271@elf.ucw.cz>
References: <20021102181900.GA140@elf.ucw.cz> <20021102184612.GI23425@holomorphy.com> <20021102202208.GC18576@atrey.karlin.mff.cuni.cz> <3DC44839.A3AEAE41@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC44839.A3AEAE41@digeo.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Swsusp counts free pages, and relies on fact that when it allocates
> > > > page there's one free page less. That is no longer true with hot
> > > > pages.
> > > > I attempted to work it around but it seems I am getting hot pages even
> > > > when I ask for cold one. This seems to fix it. Does it looks like
> > > > "possibly mergable" patch?
> > > > --- clean/mm/page_alloc.c   2002-11-01 00:37:44.000000000 +0100
> > > > +++ linux-swsusp/mm/page_alloc.c    2002-11-01 22:53:47.000000000 +0100
> > > > @@ -361,7 +361,7 @@
> > > >     unsigned long flags;
> > > >     struct page *page = NULL;
> > > >
> > > > -   if (order == 0) {
> > > > +   if ((order == 0) && !cold) {
> > > >             struct per_cpu_pages *pcp;
> > > >
> > > >             pcp = &zone->pageset[get_cpu()].pcp[cold];
> > > >
> > >
> > > This doesn't seem to be doing what you want, even if it seems to work.
> > > If you want there to be one free page less, then allocating it will
> > > work regardless. What are you looking for besides that? If it's not
> > > already working you want some additional semantics. Could this involve
> > > is_head_of_free_region()? That should be solvable with a per-cpu list
> > > shootdown algorithm to fully merge all the buddy bitmap things.
> > 
> > I need pages I allocate to disappear from "is_head_of_free_region()",
> > so my counts match.
> > 
> 
> hm.  swsusp does funny things.  Would it be posible to get a
> big-picture "how this whole thing works" story?  What exactly
> is the nature of its relationship with the page allocator?

"big-picture" should be in Documentation/swsusp.txt...

*Should* be :-(. I need to copy all used memory, to make sure my
snapshot is atomic.

Copying works by looking at what is allocated, counting needed pages,
allocating 'directory' for them, allocating memory for copies, and
actually copying.

When I suddenly find I have less data to copy than I thought, it
screws up the code.

> I'm not really sure what to suggest here.  Emptying the per-cpu
> page pools would be tricky.  Maybe a swsusp-special page allocator
> which goes direct to the buddy lists or something.

Well, see the patch above. That seems to do the trick for
me. It seems that even "cold" allocation can give page from per-cpu
pool. I thought that was a bug?
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
