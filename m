Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282371AbRKXGaJ>; Sat, 24 Nov 2001 01:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282372AbRKXGaA>; Sat, 24 Nov 2001 01:30:00 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:56500 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282371AbRKXG3v>;
	Sat, 24 Nov 2001 01:29:51 -0500
Date: Sat, 24 Nov 2001 01:29:26 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
In-Reply-To: <20011124072039.A2398@athlon.random>
Message-ID: <Pine.GSO.4.21.0111240121120.4000-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Nov 2001, Andrea Arcangeli wrote:

> > First of all, there is ->read_super() side of the things.  If it fails
> > after iget() on root, we have nothing to kick inode out of cache.  And
> > no, we can't call invalidate_inodes() here - too late for calling any
> > methods.
> 
> why should you call any method, the ->read_super just make sure if it
> fails you can safely get rid of the logical struct inode. I don't see
> any problem in solving this case without special iput cases.

RTFS.

Suppose ->read_super() fails to allocate root dentry.  It already has inode
of root directory in cache.  It does iput() and returns.

Fine.  Now we have an inode in cache.  Superblock gets freed.  See what
will happen next?

Right, after a while memory pressure will shrink icache.  That will call
clear_inode() on our inode, followed by destroy_inode().

And clear_inode() will call inode->i_sb->s_op->clear_inode().  Oops...

That problem exists for almost every filesystem in the tree.  Had been there
for quite a while.

As for the invalidate_inodes() after ->put_super() - check what 2.4.15 does
_before_ ->put_super().  All this stuff is not about inodes that need to
be written out after something that ->put_super() had done - I agree that
it's ->put_super() headache.  It's about inodes that stay in icache for too
long.

Again, whenever struct inode is freed, we call ->i_sb->s_op->clear_inode()
and we'd better do that while relevant data structures are guaranteed to
be alive.

