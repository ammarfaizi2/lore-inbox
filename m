Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269248AbRHGSL7>; Tue, 7 Aug 2001 14:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269250AbRHGSLt>; Tue, 7 Aug 2001 14:11:49 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:47750 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269248AbRHGSLm>; Tue, 7 Aug 2001 14:11:42 -0400
Date: Tue, 7 Aug 2001 12:11:52 -0600
Message-Id: <200108071811.f77IBqq06242@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <Pine.GSO.4.21.0108070255010.16817-100000@weyl.math.psu.edu>
In-Reply-To: <200108070647.f776lB831865@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0108070255010.16817-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> On Tue, 7 Aug 2001, Richard Gooch wrote:
> 
> > > They call ->setattr() (devfs_notify_change(), in your case) and that
> > > has nothing to icache (you already have the inode). Or had I
> > > completely misparsed you?
> > 
> > You parsed correctly. I know ->setattr() is called. I just wanted to
> > make sure that the icache didn't have some subtle interaction I was
> > missing. Such as ->write_inode() not being called.
> 
> Oh... That actually begs for another question - why the heck do you
> need ->write_inode()?
> 
> Sorry - I had missed the presense of that animal. Hmm... OK.
> Variant 1:
> 	insert_inode_hash(inode). Silly, but will work
> Variant 2:
> 	kill devfs_write_inode() - do its equivalent in notify_change()
> _and_ set the de->atime in ->readlink() and ->follow_link(). The latter
> is due to update_atime() logics. And no, I don't like it.

OK, I've implemented variant 2. Everything looked OK, but then I
noticed that pwd no longer works in subdirectories in devfs. Sigh.
I'll have to get back to it tonight and track this one down. How
annoying. Still, it was satisfying to rip out the table code.

BTW: I'm not bothering to update atime in the symlink methods. It's
not important anyway. And if you get you VFS change in, then it should
just magically save atimes for symlinks again, right?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
