Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292289AbSCDJ2Z>; Mon, 4 Mar 2002 04:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292296AbSCDJ2Q>; Mon, 4 Mar 2002 04:28:16 -0500
Received: from dsl-213-023-043-059.arcor-ip.net ([213.23.43.59]:14228 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292289AbSCDJ2H>;
	Mon, 4 Mar 2002 04:28:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] delayed disk block allocation
Date: Mon, 4 Mar 2002 10:23:29 +0100
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>, Steve Lord <lord@sgi.com>
In-Reply-To: <3C7F3B4A.41DB7754@zip.com.au> <E16hhuI-0000S6-00@starship.berlin> <3C83202D.A9FFB902@zip.com.au>
In-Reply-To: <3C83202D.A9FFB902@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16hogr-0000ao-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 4, 2002 08:20 am, Andrew Morton wrote:
> You know where this is headed, don't you:

Yes I do, because it's more or less a carbon copy of what I had in mind.

> - writeout is performed by the writers, and by the gang-of-flush-threads.
> - kswapd is 100% non-blocking.  It never does I/O.
> - kswapd is the only process which runs page_launder/shrink_caches.
> - Memory requesters do not perform I/O.  They sleep until memory
>   is available. kswapd gives them pages as they become available, and
>   wakes them up.
> 
> So that's the grand plan.  It may be fatally flawed - I remember Linus
> had a serious-sounding objection to it some time back, but I forget
> what that was.

I remember, since he gently roasted me last autum for thinking such thoughts. 
The idea is that by making threads do their own vm scanning they throttle 
themselves.  I don't think the resulting chaotic scanning behavior is worth 
it.

> > > With this patch, writepage() is still using the buffer layer, so lock
> > > contention will still be high.
> > 
> > Right, and buffers are going away one way or another.
> 
> This is a problem.  I'm adding new stuff which does old things in
> a new way, with no believable plan in place for getting rid of the
> old stuff.
> 
> I don't think it's humanly possible to do away with struct buffer_head.
> It is *the* way of representing a disk block.   And unless we plan
> to live with 4k pages and 4k blocks for ever, the problem is about
> to get worse.  Think 64k pages with 4k blocks.

If struct page refers to an object the same size as a disk block then struct
page can take the place of a buffer in the getblk interface.  For IO we have 
other ways of doing things, kvecs, bio's and so on.  We don't need buffers 
for that, the only thing we need them for is handles for disk blocks, and 
locking thereof.

If you actually had this now your patch would be quite a lot simpler.  It's 
going to take a while though, because first we have to do active physical 
defragmentation, and that requires rmap.  So a prototype is a few months away 
at least, but six months ago I would have said two years.

> Possibly we could handle sub-page segments of memory via a per-page up-to-date
> bitmask.  And then a `dirty' bitmask.  And then a `locked' bitmask, etc.  I
> suspect eventually we'll end up with, say, a vector of structures attached to
> each page which represents the state of each of the page's sub-segments.  whoops.

You could, but that would be a lot messier than what I have in mind.  Your 
work fits really nicely with that since it gets rid of the IO function of 
buffers.

-- 
Daniel
