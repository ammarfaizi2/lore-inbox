Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262875AbREVWik>; Tue, 22 May 2001 18:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbREVWiU>; Tue, 22 May 2001 18:38:20 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:21263 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262875AbREVWiT>; Tue, 22 May 2001 18:38:19 -0400
Date: Tue, 22 May 2001 15:37:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andries.Brouwer@cwi.nl
cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct char_device
In-Reply-To: <UTC200105222054.WAA79836.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.21.0105221521330.4332-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 May 2001 Andries.Brouwer@cwi.nl wrote:
> 
> The operations are different, but all bdev/cdev code is identical.
> 
> So the choice is between two uglies:
> (i) have some not entirely trivial amount of code twice in the kernel
> (ii) have a union at the point where the struct operations
> is assigned.
> 
> I preferred the union.

I would much prefer a union of pointers over a pointer to a union.

So I'd much rather have the inode have a

	union {
		struct block_device *block;
		struct char_device *char;
	} dev;

and then have people do

	cdev = inode->dev.char;

to get the right information, than to have 

	union block_char_union {
		struct block_device block;
		struct char_device char;
	};

	.. with struct inode containing ..
	union block_char_union *dev;

Why? Because if you have a "struct inode", you also have enough
information to decide _which_ of the two types of pointers you have, so
you can do the proper dis-ambiguation of the union and properly select
either 'inode->dev.char' or 'inode->dev.block' depending on other
information in the inode.

In contrast, if you have a pointer to a union, you don't have information
of which sub-type it is, and you'd have to carry that along some other way
(for example, by having common fields at the beginning). Which I think is
broken.

So my suggestion for eventual interfaces:

 - have functions like

	struct block_dev *bdget(struct inode *);
	struct char_dev *cdget(struct inode *);

   which populate the "inode->dev" union pointer, which in turn is _only_
   a cache of the lookup. Right now we do this purely based on "dev_t",
   and I think that is bogus. We should never pass a "dev_t" around
   without an inode, I think.

   And we should not depend on the "inode->dev.xxxx" pointer being valid all
   the time, as there is absolutely zero point in initializing the pointer
   every time the inode is read just because somebody does a "ls -l /dev".
   Thus the "cache" part above.

 - NO reason to try to make "struct block_dev" and "struct char_dev" look
   similar. They will have some commonality for lookup purposes (that
   issue is similar, as Andries points out), and maybe that commonality
   can be separated out into a sub-structure or something. But apart from
   that, they have absolutely nothing to do with each other, and I'd
   rather not have them have even a _superficial_ connection.

   Block devices will have the "request queue" pointer, and the size and
   partitioning information. Character devices currently would not have
   much more than the operations pointer and name, but who knows..

But the most important thing is to be able to do this in steps. One of the
reasons Andries has had patches for a long time is that it was never very
gradual. Al's patch is gradual, and I like that.

		Linus

