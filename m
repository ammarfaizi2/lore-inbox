Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282968AbRLIEZz>; Sat, 8 Dec 2001 23:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282969AbRLIEZp>; Sat, 8 Dec 2001 23:25:45 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5393 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282968AbRLIEZc>; Sat, 8 Dec 2001 23:25:32 -0500
Date: Sat, 8 Dec 2001 20:19:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
In-Reply-To: <E16Cucn-00015D-00@starship.berlin>
Message-ID: <Pine.LNX.4.33.0112082012330.1344-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 9 Dec 2001, Daniel Phillips wrote:
>
> The difference is, there's only one superblock per mount.  There are
> bazillions of inodes.

.. and they share buffers.

I bet that having a pointer to the buffer will _reduce_ average
average footprint rather than increase it. The inodes are fairly densely
laid out in the buffers, so I dare you to find any real-world (or even
very contrieved) usage patterns where it ends up being problematic.

Remember: we'd save 15*4=60 bytes per inode, at the cost of pinning the
block the inode is in. But _usually_ we'd have those blocks in memory
anyway, especially if the inode gets touched (which dirties it, and
updates atime, which forces us to do writeback). For the initial IO we
obviously _have_ to have them in memory.

And we'll get rid of inodes under memory pressure too, so the pinning will
go away when memory is really tight. Yes, you can try to "attack" the
machine by trying to open all the right inodes, but the basic attack is
there already. ulimit is your friend.

> It's worth keeping in mind that tweaking the icache efficiency in this case
> is really just curing a symptom - the underlying problem is a mismatch
> between readdir order and inode order.

Well, the inode writeback read-modify-write synchronization and related
efficiency problems actually has nothing to do with the readdir order.

			Linus

