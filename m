Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286168AbRLJGeI>; Mon, 10 Dec 2001 01:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286169AbRLJGd5>; Mon, 10 Dec 2001 01:33:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40715 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286168AbRLJGdq>; Mon, 10 Dec 2001 01:33:46 -0500
Date: Sun, 9 Dec 2001 22:27:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
In-Reply-To: <E16DAKP-00019T-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0112092220400.13692-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Dec 2001, Daniel Phillips wrote:
>
> Continuing the little warts list, there's Alan's comment re needing endian
> reversal on big endian machines.

Now that's a load of bollocks.

We _already_ keep the in-memory data in "disk format", and for a very
simple reason: that way we can naturally share all the functions that take
a pointer to a block tree, and they don't need to care whether the block
numbers come from a disk buffer or from the inode.

Which means that we have only _one_ set of routines for handling block
allocation etc, instead of duplicating them all.

Having in-core data in CPU-native byte order is _stupid_. We used to do
that, and I winced every time I had to look at all the duplication of
functions. I think it was early 2.3.x when Ingo did the page cache write
stuff where I fixed that - the people who had done the original ext2
endianness patches were just fairly lacking in brains (Hi, Davem ;), and
didn't realize that keeping inode data in host order was the fundamental
problem that caused them to have to duplicate all the functions.

So the _wart_ is in 2.2.x, which is just stupid and ugly, and keeps block
numbers in host data format - which causes no end of trouble. 2.4.x
doesn't have this problem, and could easily have a pointer to the on-disk
representation.

			Linus

