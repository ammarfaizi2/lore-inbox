Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272048AbRHVRWy>; Wed, 22 Aug 2001 13:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272049AbRHVRWp>; Wed, 22 Aug 2001 13:22:45 -0400
Received: from www.wen-online.de ([212.223.88.39]:55570 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S272048AbRHVRWg>;
	Wed, 22 Aug 2001 13:22:36 -0400
Date: Wed, 22 Aug 2001 19:22:35 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory Problem in 2.4.9 ?
In-Reply-To: <20010822130106.0c4d4bf1.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33.0108221752590.542-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Stephan von Krawczynski wrote:

> On Wed, 22 Aug 2001 07:33:38 +0200 (CEST)
> Mike Galbraith <mikeg@wen-online.de> wrote:
>
> >> HAHAHA.. I was right, hurried whack with my little hammer _did_ bust
> > it all to pieces :)
> >
> > This is also (very!) hurried and _lightly_ tested, but still cures my
> > problem..  what do you think?
> >
> > 	-Mike
> >
> >
> > --- linux-2.4.9/mm/vmscan.c.org	Sun Aug 19 08:55:24 2001
> > +++ linux-2.4.9/mm/vmscan.c	Wed Aug 22 05:03:50 2001
> > @@ -506,11 +506,17 @@
> >  		}
> [...]
> > +			if (++page->age > PAGE_AGE_START) {
>
> I am not very experienced with the aging algorithm, but can this statement be false at all? I mean if I get that right page->age starts with PAGE_AGE_START, doesn't it?

When page is added to to the pagecache, it begins life with age=0 and
is placed on the inactive_dirty list with use_once.  With the original
aging, it started with PAGE_AGE_START and was placed on the active
list.  The intent of used once (correct me Daniel if I fsck up.. haven't
been able to track vm changes very thoroughly lately [as you can see:])
is to place a new page in the line of fire of page reclamation and only
pull it into the active aging scheme if it is referenced again prior to
consumption.  This is intended to preserve other cached pages in the event
of streaming IO.  Your cache won't be demolished as quickly, the pages
which are only used one time will self destruct instead.  Cool idea.

Unfortunately, with loads like file rewrite, so many (all?) pages meet
the qualification, and are activated and aged up immediately that they
swamp the system.  Background aging can't keep up at all (even if you
accelerate it wildly btw), so you end up swapping needlessly.

This quick hack is intended to do something like use_once in that a page
which has been deactivated does not go back to the active queue merely
because of a single access (etc).  Instead, you get a couple of chances
to stay on your death march.  Often used pages will drop out of line,
seldom used pages won't.

It might be a really rotten way to cure my problem.. I'm not sure yet.

Christ on a crutch.. that sure was a longwinded way to say "yes, the
statement can be false".  Think I'll go turn on the idiot box, crack
a brew and play a round of couch potato :)

	Later,

	-Mike

