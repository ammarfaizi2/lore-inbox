Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261446AbSKBVmS>; Sat, 2 Nov 2002 16:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261447AbSKBVmS>; Sat, 2 Nov 2002 16:42:18 -0500
Received: from packet.digeo.com ([12.110.80.53]:53690 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261446AbSKBVmR>;
	Sat, 2 Nov 2002 16:42:17 -0500
Message-ID: <3DC44839.A3AEAE41@digeo.com>
Date: Sat, 02 Nov 2002 13:48:41 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.45 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: William Lee Irwin III <wli@holomorphy.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Hot/cold allocation -- swsusp can not handle hot pages
References: <20021102181900.GA140@elf.ucw.cz> <20021102184612.GI23425@holomorphy.com> <20021102202208.GC18576@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Nov 2002 21:48:41.0849 (UTC) FILETIME=[9C0D8E90:01C282B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> > > Swsusp counts free pages, and relies on fact that when it allocates
> > > page there's one free page less. That is no longer true with hot
> > > pages.
> > > I attempted to work it around but it seems I am getting hot pages even
> > > when I ask for cold one. This seems to fix it. Does it looks like
> > > "possibly mergable" patch?
> > > --- clean/mm/page_alloc.c   2002-11-01 00:37:44.000000000 +0100
> > > +++ linux-swsusp/mm/page_alloc.c    2002-11-01 22:53:47.000000000 +0100
> > > @@ -361,7 +361,7 @@
> > >     unsigned long flags;
> > >     struct page *page = NULL;
> > >
> > > -   if (order == 0) {
> > > +   if ((order == 0) && !cold) {
> > >             struct per_cpu_pages *pcp;
> > >
> > >             pcp = &zone->pageset[get_cpu()].pcp[cold];
> > >
> >
> > This doesn't seem to be doing what you want, even if it seems to work.
> > If you want there to be one free page less, then allocating it will
> > work regardless. What are you looking for besides that? If it's not
> > already working you want some additional semantics. Could this involve
> > is_head_of_free_region()? That should be solvable with a per-cpu list
> > shootdown algorithm to fully merge all the buddy bitmap things.
> 
> I need pages I allocate to disappear from "is_head_of_free_region()",
> so my counts match.
> 

hm.  swsusp does funny things.  Would it be posible to get a
big-picture "how this whole thing works" story?  What exactly
is the nature of its relationship with the page allocator?

I'm not really sure what to suggest here.  Emptying the per-cpu
page pools would be tricky.  Maybe a swsusp-special page allocator
which goes direct to the buddy lists or something.
