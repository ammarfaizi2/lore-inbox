Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267928AbRGXQjV>; Tue, 24 Jul 2001 12:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268214AbRGXQjL>; Tue, 24 Jul 2001 12:39:11 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:46345 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267928AbRGXQjD>; Tue, 24 Jul 2001 12:39:03 -0400
Date: Tue, 24 Jul 2001 09:37:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Nathan Laredo <nlaredo@transmeta.com>, Neil Brown <neilb@cse.unsw.edu.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: patch for allowing msdos/vfat nfs exports
In-Reply-To: <Pine.GSO.4.21.0107232053040.23359-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0107240929560.29354-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Mon, 23 Jul 2001, Alexander Viro wrote:
>
> On Mon, 23 Jul 2001, Nathan Laredo wrote:
>
> > +	result = d_alloc_root(inode);
> > +	if (result == NULL) {
> > +	         iput(inode);
> > +	         return ERR_PTR(-ENOMEM);
> > +	}
> > +	result->d_flags |= DCACHE_NFSD_DISCONNECTED;
> > +	return result;
>
> Erm... AFAICS it got a race - think of doing that for directory when
> dentry is already gone, but inode still in cache. You will get
> nfsd_findparent() called and that will give funny results on FAT.

Note that the code was definitely cribbed from reiserfs, and when I stole
it I had this very strong feeling that "This really should be supported in
the VFS layer instead of hidden in the low-level filesystems".

We are, after all, working with very internal knowledge of not only the
way the dentry lists are attached to the inode, but also about the whole
DISCONNECTED thing etc.

> The worst thing being, it _will_ get a decently-looking inode. Inode that
> will point to the same blocks as parent directory, but will be completely
> independent (different location).

Absolutely. And some of the NFS-export problems won't even be avoidable at
all: FAT does not have a notion of inode versions etc, and we do not have
a way to fix that.

However, what we could do is add more sanity-testing, and for example also
add the parent inode location to the dentry_to_fh code. We have space.

The patch was a fairly quick hack. What it does show is that (a) the
dentry_to_fh approach is actually a very usable one in itself and wasn't
just an ugly reiserfs hack, and (b) FAT _can_ be exported.

The reason I asked Nathan to post the damn thing instead of just applying
it to the tree was to get these kinds of comments, and hopefully move the
VFS stuff to a VFS location, ie start exporting a vfs_inode_to_dentry()
function that reiserfs, FAT and quite possibly others can sanely share.

Al, Neil, care to work something out between you? I saw that Neil had
something already..

			Linus

