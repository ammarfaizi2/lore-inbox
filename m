Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131794AbQL2TEf>; Fri, 29 Dec 2000 14:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131773AbQL2TEZ>; Fri, 29 Dec 2000 14:04:25 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:61592 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131794AbQL2TEN>;
	Fri, 29 Dec 2000 14:04:13 -0500
Date: Fri, 29 Dec 2000 13:33:04 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Chris Mason <mason@suse.com>, Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <Pine.LNX.4.21.0012291418570.13063-100000@freak.distro.conectiva>
Message-ID: <Pine.GSO.4.21.0012291316510.29829-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2000, Marcelo Tosatti wrote:

> Now the ext2 changes will for sure make a difference since right now the
> superblock lock is suffering from contention. 

superblock lock is suffering from more than just contention. Consider the
following:

sys_ustat() does get_super(), which leaves the sb unlocked.
We are going to call ->statfs().
In the meanwhile, fs is umounted. Woops...

In other words, get_super() callers are oopsen waiting to happen. That's
what is fundamentally wrong with lock_super()/wait_super()/unlock_super() -
we have no reference counter on superblocks and we blindly grab references
to them assuming that they will stay.

The main source of get_super() calls is in device drivers. I propose to add

void invalidate_dev(kdev_t dev, int sync_flag)
{
	struct super_block *sb = get_super(dev);
	switch (sync_flag) {
		case 1: sync_dev(dev);break;
		case 2: fsync_dev(dev);break;
	}
	if (sb)
		invalidate_inodes(sb);
	invalidate_buffers(dev);
}

to fs/buffer.c, export it and let drivers call that instead of doing the
thing by hands. Then we have a chance to deal with the problem inside the
kernel proper. Right now almost every block device has that sequence in
BLKRRPART handling and fixing each of them separately is going to hurt like
hell.

Linus, I realize that it's changing the block devices near to release, but
AFAICS we have to change them anyway. I'm asking for permission to take
get_super() out.
							Cheers,
								Al

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
