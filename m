Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269686AbRHCXXe>; Fri, 3 Aug 2001 19:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269692AbRHCXXY>; Fri, 3 Aug 2001 19:23:24 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53949 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269686AbRHCXXP>;
	Fri, 3 Aug 2001 19:23:15 -0400
Date: Fri, 3 Aug 2001 19:23:17 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Wedgwood <cw@f00f.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Mason <mason@suse.com>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic
 change patch)
In-Reply-To: <20010804111645.C17925@weta.f00f.org>
Message-ID: <Pine.GSO.4.21.0108031916580.5264-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Aug 2001, Chris Wedgwood wrote:

> Can I lock a dentry to prevent this?

dget_locked() under dcache_lock + dput() when you are done.

>     	b) access to ->d_parent requires at least one of the
>     following: dcache_lock, BKL, i_sem or ->i_zombie on inode of
>     parent.
> 
> I assume BLK lock is undesirable here?  dcache_lock seems quite
> reasonable and very cheap.  I can't see how else to do it as getting
> inode of parent required d_parent.
> 
>     	c) as it is, you will get a hell of IO load on a dumb fs.
>     dumb == anything that uses file_fsync() as ->fsync() of
>     directories.  You'll do full sync of fs on every bloody step.
> 
> Yes, but it reality it's not that bad. As is, reiserfs and ext3 (used
> to, might not now) sync pending transaction on fsync anyhow.  Run lilo
> recently on reiserfs of ext3?  Ever seemed slow?  strace -f and you'll
> see it calls fsync after writing to the map files each time (no idea
> why) and it it still acceptable.

Sure. And now each fsync() turns into a bunch of such calls.
 
>     	d) sequence of inodes you sync has only one property
>     guaranteed: at some moment nth inode is a parent of
>     (n-1)th. That's it. E.g. it's easy to get a situation when _none_
>     of the inodes you sync had ever been a grandparent of the original
>     inode.
> 
> I'm not sure I follow you hear... is this because of bind semantics or
> somethng else?  I can see it relevant in the case of a fs mount in
> /var/somewhere/blah when you fsync /var/somewhere/blah/dir/file, you
> don't need to go past blah --- but how would I detect this 'edge'?

It has nothing to bindings/mount/etc. fsync /a/b/c. While c is written
out, mv a/b/c /a/d/c. While d is written out, mv a/d/c a/b/c && mv a/d e/d
Through all these renames /a remained the grandparent of c. You won't sync it -
you sync c, then d, then e, then root.

Constructing less convoluted examples with similar results is left as an
exercise to reader...

