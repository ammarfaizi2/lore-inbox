Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272220AbRHWE5m>; Thu, 23 Aug 2001 00:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272221AbRHWE5d>; Thu, 23 Aug 2001 00:57:33 -0400
Received: from www.wen-online.de ([212.223.88.39]:20241 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S272220AbRHWE51>;
	Thu, 23 Aug 2001 00:57:27 -0400
Date: Thu, 23 Aug 2001 06:57:10 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, <phillips@bonn-fries.net>
Subject: Re: Memory Problem in 2.4.9 ?
In-Reply-To: <20010822211849.14a4481a.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33.0108230609270.666-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Stephan von Krawczynski wrote:

> On Wed, 22 Aug 2001 19:22:35 +0200 (CEST)
> Mike Galbraith <mikeg@wen-online.de> wrote:
>
> > When page is added to to the pagecache, it begins life with age=0 and
> > is placed on the inactive_dirty list with use_once.  With the original
> > aging, it started with PAGE_AGE_START and was placed on the active
> > list.  The intent of used once (correct me Daniel if I fsck up.. haven't
> > been able to track vm changes very thoroughly lately [as you can see:])
> > is to place a new page in the line of fire of page reclamation and only
> > pull it into the active aging scheme if it is referenced again prior to
> > consumption.  This is intended to preserve other cached pages in the event
> > of streaming IO.  Your cache won't be demolished as quickly, the pages
> > which are only used one time will self destruct instead.  Cool idea.
>

(your mailer doesn't wrap lines.. formatting)

> Well, maybe I am completely off the road, but the primary problem seems
> to be that a whole lot of the pages _look_ like being of the same age,
> and the algorithm cannot cope with that very well. There is obviously
> no way out of this problem for the code, and thats basically why it
>  fails to alloc pages with this warning message. So the primary goal

Sure, having a poor distribution of age isn't good (makes vm 'rough'),
but I don't think that's what is causing most of the allocation
failures.  IMHO, the largest problem with these is not keeping our
inactive_clean ammo belt full enough in general.  I bet that changing
page_launder to have a cleaned_pages target instead of limiting the
scan to 1/64 would cure a lot of that.  A 1/64 scan is nice as long
as the list is very long.  As it shrinks though, you do less and less
work.  It needs min and max limits.  IMHO, kswapd should never launder
less than at _least_ freepages.min even if that's the entire list.

>  should be to refine the algorithm and give it a way to _know_ a way
>  out, and not to _guess_ ("maybe we got some free pages later") or
>  _give up_ on the problem. How about the following (ridiculously
>  simple) approach:
> every alloc'ed page gets a "timestamp". If an alloc-request reaches
>  the current "dead point" it simply throws out the oldest x pages of
>  the lowest aging level reachable. This is sort of a garbage-collection
>  idea. It sounds not very fast indeed, but it sounds working, does it?
> Best of all, very few changes have to be made to make it work.

Many changes are required to make it work.  First of all, it requires
enforced deallocation.

> Shoot me for this :-)

<click click click.. dang, no bullets> :)

	-Mike

