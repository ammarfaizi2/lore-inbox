Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286302AbRLJQMO>; Mon, 10 Dec 2001 11:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286299AbRLJQME>; Mon, 10 Dec 2001 11:12:04 -0500
Received: from dsl-213-023-043-133.arcor-ip.net ([213.23.43.133]:15876 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S286196AbRLJQLy>;
	Mon, 10 Dec 2001 11:11:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
Date: Mon, 10 Dec 2001 17:14:38 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112092220400.13692-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0112092220400.13692-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16DT4k-0001EY-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 10, 2001 07:27 am, Linus Torvalds wrote:
> On Sun, 9 Dec 2001, Daniel Phillips wrote:
> >
> > Continuing the little warts list, there's Alan's comment re needing endian
> > reversal on big endian machines.
> 
> Now that's a load of bollocks.
> 
> We _already_ keep the in-memory data in "disk format", and for a very
> simple reason: that way we can naturally share all the functions that take
> a pointer to a block tree, and they don't need to care whether the block
> numbers come from a disk buffer or from the inode.

Yes, as the length of an email approaches infinity the chance of saying 
something stupid approaches certainty ;)

> Which means that we have only _one_ set of routines for handling block
> allocation etc, instead of duplicating them all.

I don't know how bad it was in the old code, but now the little-ended data is 
confined to get_block/truncate, as it should be.  However, reading ahead...

> Having in-core data in CPU-native byte order is _stupid_. We used to do
> that, and I winced every time I had to look at all the duplication of
> functions. I think it was early 2.3.x when Ingo did the page cache write
> stuff where I fixed that - the people who had done the original ext2
> endianness patches were just fairly lacking in brains (Hi, Davem ;), and
> didn't realize that keeping inode data in host order was the fundamental
> problem that caused them to have to duplicate all the functions.

I'm not proposing to change this, but I would have chosen Davem's approach in 
this case, with the aid of:

	typedef struct { u32 value; } le_u32;

This is a no-op for Intel, and it would make things nicer for non-intel 
arches, for what that's worth.  But it seems I've stepped into an old 
flamewar, so I'm getting out while my skin is still non-crispy ;)

> So the _wart_ is in 2.2.x, which is just stupid and ugly, and keeps block
> numbers in host data format - which causes no end of trouble. 2.4.x
> doesn't have this problem, and could easily have a pointer to the on-disk
> representation.

Probably what I should have said is that *I* plan to do some conversions 
between on-disk and in-memory format for a patch I'm working on, that it's a 
natural thing to do, and that tying the in-memory inode straight to the disk 
buffer interferes with that.  On the other hand, if the direct pointer really 
is a cache win, it would trump the layering issue.

--
Daniel
