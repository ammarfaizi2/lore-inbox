Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288071AbSA2Arb>; Mon, 28 Jan 2002 19:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288047AbSA2ArW>; Mon, 28 Jan 2002 19:47:22 -0500
Received: from dsl-213-023-039-090.arcor-ip.net ([213.23.39.90]:5768 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288019AbSA2ArP>;
	Mon, 28 Jan 2002 19:47:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: [reiserfs-dev] Re: Note describing poor dcache utilization under high memory pressure
Date: Tue, 29 Jan 2002 01:51:29 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com, reiserfs-dev@namesys.com
In-Reply-To: <Pine.LNX.4.33.0201280930130.1557-100000@penguin.transmeta.com> <E16VLZh-0000Dp-00@starship.berlin> <3C55E9E3.50207@namesys.com>
In-Reply-To: <3C55E9E3.50207@namesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16VMUj-0000Dz-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 29, 2002 01:16 am, Hans Reiser wrote:
> Daniel Phillips wrote:
> 
> >On January 28, 2002 08:25 pm, Hans Reiser wrote:
> >
> >>If I understand you right, your scheme has the fundamental flaw that one 
> >>dcache entry on a page can keep an entire page full of "slackers" in 
> >>memory, and since there is little correlation in usage between dcache 
> >>entries that happen to get stored on a page, the result is that the 
> >>effectiveness per megabyte of the dcache is decreased by an order of 
> >>magnitude.  It would be worse to have one dcache entry per page, but 
> >>maybe not by as much as you might expect.
> >>
> >>When objects smaller than a page are stored on a page but not correlated 
> >>in their usage, they need to be aged individually not as a page, and 
> >>then garbage collected as needed.
> >>
> >
> >I had the identical thought - i.e., that this is a job for object aging and 
> >not lru, then I realized that a slight modification to lru can do the job, 
> >that is:
> >
> >  - An access to any object on the page promotes the page to the hot end
> >    of the lru list.
> >
> >  - When it's time to recover a page (or pages) scan from the cold end
> >    towards the hot end, and recover the first page(s) on which all
> >    objects are free.
> >
> >>Neither the current model nor your 
> >>proposed scheme solve the fundamental problem Josh's measurements prove 
> >>exists.  
> >>
> >
> >My suggestion might.
> >
> This fails to recover an object (e.g. dcache entry) which is used once, 
> and then spends a year in cache on the same page as an object which is 
> hot all the time.

You don't worry about that case.  If there's so much pressure that you
scan all the way to the hot end of the lru list then you will recover
that hot/cold page[1] and all will be well.  Not that the hot/cold page
will tend to migrate further away from the hot end of the list than a
hot/hot page.

[1] Assuming all the objects are freeable, otherwise you have a very
different problem: fragmentation.

> This means that the hot set of objects becomes 
> diffused over an order of magnitude more pages than if garbage 
> collection squeezes them all together.

I don't see that.  How does garbage collection squeeze things together?
I'm assuming these objects are pinned, at least from the VM's point of
view.

-- 
Daniel
