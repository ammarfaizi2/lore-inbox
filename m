Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270101AbRHGGX7>; Tue, 7 Aug 2001 02:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270102AbRHGGXs>; Tue, 7 Aug 2001 02:23:48 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:59580 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270101AbRHGGXf>;
	Tue, 7 Aug 2001 02:23:35 -0400
Date: Tue, 7 Aug 2001 02:23:44 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <200108070553.f775rQ631046@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0108070205370.16817-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Aug 2001, Richard Gooch wrote:

> Damn. I've just run into a snag. My read_inode() needs to dereference
> inode->u.generic_ip, however, I can only initialise this *after* the
> call to iget() finishes. Now, I could shoehorn my pointer into
> inode->ino (thanks to it being an unsigned long), but that's pretty
> gross.
> 
> I also notice iget4() and the read_inode2() method, however, from the
> comments, it looks like those are reiserfs-specific, and will die
> soon. At the very least, it seems use thereof is discouraged.
> 
> Suggestions?

Lose ->read_inode(). Since your inode numbers are not stable across
reboot you can't use iget for NFS-exporting devfs (even if you would
want to export it in the first place). So there is no reason whatsoever
to use it.

Add put_inode: force_delete, into your super_operations and replace
your call of iget() with

	inode = new_inode(sb);
	if (inode) {
		inode->i_ino = whatever;
		/* stuff you've used to do in devfs_read_inode */
	}

Notice that here you have pointer to 'entry', so there is no problem
with passing it. ->read_inode() simply goes away. Besides, that way
you don't pollute icache hash chains - devfs inodes stay out of hash.

