Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272257AbRIKCHI>; Mon, 10 Sep 2001 22:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272256AbRIKCG6>; Mon, 10 Sep 2001 22:06:58 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:54022 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S272257AbRIKCGs>; Mon, 10 Sep 2001 22:06:48 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: linux-2.4.10-pre5
Date: Tue, 11 Sep 2001 03:16:54 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Andreas Dilger <adilger@turbolabs.com>, Andrea Arcangeli <andrea@suse.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0109101716590.3249-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0109101716590.3249-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010911020707Z16564-26185+172@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 11, 2001 02:20 am, Linus Torvalds wrote:
> On Tue, 11 Sep 2001, Daniel Phillips wrote:
> > On September 11, 2001 12:15 am, Linus Torvalds wrote:
> > > However, physical read-ahead really isn't the answer here. I bet you could
> > > cut your time down with it, agreed. But you'd hurt a lot of other loads,
> > > and it really depends on nice layout on disk. Plus you wouldn't even know
> > > where to put the data you read-ahead: you only have the physical address,
> > > not the logical address, and the page-cache is purely logically indexed..
> >
> > You leave it in the buffer cache and the page cache checks for it there
> > before deciding it has to hit the disk.
> 
> Umm..
> 
> Ehh.. So now you have two cases:
>  - you hit in the cache, in which case you've done an extra allocation,
>    and will have to do an extra memcpy.
>  - you don't hit in the cache, in which case you did IO that was
>    completely useless and just made the system slower.

If the read comes from block_read then the data goes into the page cache.  If
it comes from getblk (because of physical readahead or "dd xxx >null") the 
data goes into the buffer cache and may later be moved to the page cache, 
once we know what the logical mapping is.

> Considering that the extra allocation and memcpy is likely to seriously
> degrade performance on any high-end hardware if it happens any noticeable
> percentage of the time, I don't see how your suggest can _ever_ be a win.
> The only time you avoid the memcpy is when you wasted the IO completely.

We don't have any extra allocation in the cases we're already handling now, 
it works exactly the same.  The only overhead is an extra hash probe on cache 
miss.

> So please explain to me how you think this is all a good idea? Or explain
> why you think the memcpy is not going to be noticeable in disk throughput
> for normal loads?

When we're forced to do a memcpy it's for a case where we're saving a read or 
a seek.  Even then, the memcpy can be optimized away in the common case that 
the blocksize matches page_size.  Sometimes, even when the blocksize doesn't 
match this optimization would be possible.  But the memcpy optimization isn't 
important, the goal is to save reads and seeks by combining reads and reading 
blocks in physical order as opposed to file order.

An observation: logical readahead can *never* read a block before it knows 
what the physical mapping is, whereas physical readahead can.

--
Daniel
