Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285266AbRLFW7F>; Thu, 6 Dec 2001 17:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285274AbRLFW6z>; Thu, 6 Dec 2001 17:58:55 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:40854 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S285266AbRLFW6w>;
	Thu, 6 Dec 2001 17:58:52 -0500
Date: Thu, 6 Dec 2001 17:58:50 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro  -- clusters
In-Reply-To: <Pine.LNX.4.33.0112061422040.12667-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0112061749170.29985-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 6 Dec 2001, Linus Torvalds wrote:

> The main ones are things like "bread()" down all the way to the bottom of
> the IO path. The sad thing is that along the whole path, we actually end
> up needing the structure pointer in different places, so the IO code
> (which is supposed to be timing-critical) ends up doing various lookups on
> the kdev_t several times (both at a higher level and deep down in the IO
> submit layer).

I have a conversion patches for bread()/getblk()/get_hash_table().  Once
bio stuff settles down I'll start feeding them to you - they are very
straightforward.

Nice side effect is the death of buffer hash - once we have block_device
in all places in question we can use page hash just fine.  One level of
spinlocks in buffer.c goes to hell...

If you are interested I can feed the preparation part tomorrow - it's
a matter of adding

struct buffer_head * sb_bread(struct super_block *sb, sector_t block)
{
	return bread(sb->s_dev, block, sb->s_blocksize);
}

and replacing instances of that in filesystems with this guy.  That
alone reduces the number of places that call bread() by factor of
80, IIRC.  And it's an obvious cleanup that doesn't break anything and
can go into 2.4 as well as 2.5.

Same goes for getblk() and get_hash_table().  After that there is a payload
part of patch - switch to struct block_device * which is now available to
all callers - sb_...() have it in sb->s_bdev and the rest also have a place
to get it from.  And that I'd rather postpone until bio is stable.

However, that part is several orders of magnitude smaller than the entire
patch - most is the conversion above.  So if you want it - I can do it
as soon as I get some sleep; last version of that patch is against 2.4.12,
it's split into edible chunks and it's not hard to update.  Comments?

