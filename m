Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316757AbSFAQmI>; Sat, 1 Jun 2002 12:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316790AbSFAQmH>; Sat, 1 Jun 2002 12:42:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44557 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316757AbSFAQmG>; Sat, 1 Jun 2002 12:42:06 -0400
Date: Sat, 1 Jun 2002 09:42:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 12/16] fix race between writeback and unlink
In-Reply-To: <3CF88933.2EC13C8F@zip.com.au>
Message-ID: <Pine.LNX.4.44.0206010935290.10978-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 Jun 2002, Andrew Morton wrote:
>
> So run __iget prior to dropping inode_lock.

This part looks horrible:

+               spin_unlock(&inode_lock);
+               iput(inode);
+               spin_lock(&inode_lock);

Why not just split up the code inside iput(), and then just do

	if (atomic_dec(&inode->i_count))
		final_iput(inode);

where final_iput() _wants_ the spinlock held already?

That's basically what "iput()" will end up doing, except for that
"put_inode()" thing, which is just a horrible hack anyway.

So get rid of "put_inode()", and replace it with a new one that takes the
place of the

	if (!inode->i_nlink)  {
		... delete ..
	} else {
		.. free ..
	}

and makes that one be a "i_op->drop_inode" thing that defaults to the
current "delete if i_nlink is zero, free it if i_nlink is not zero and
nobody uses it".

The general VFS layer really shouldn't have assigned that strogn a meaning
to "i_nlink" anyway, it's not for the VFS layer to decide (and it only
causes problems for any non-UNIX-on-a-disk filesystems).

		Linus

