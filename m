Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270120AbRHGHbq>; Tue, 7 Aug 2001 03:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270122AbRHGHbg>; Tue, 7 Aug 2001 03:31:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:14741 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270120AbRHGHbY>;
	Tue, 7 Aug 2001 03:31:24 -0400
Date: Tue, 7 Aug 2001 03:31:34 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <200108070647.f776lB831865@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0108070255010.16817-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Aug 2001, Richard Gooch wrote:

> > They call ->setattr() (devfs_notify_change(), in your case) and that
> > has nothing to icache (you already have the inode). Or had I
> > completely misparsed you?
> 
> You parsed correctly. I know ->setattr() is called. I just wanted to
> make sure that the icache didn't have some subtle interaction I was
> missing. Such as ->write_inode() not being called.

Oh... That actually begs for another question - why the heck do you
need ->write_inode()?

Sorry - I had missed the presense of that animal. Hmm... OK.
Variant 1:
	insert_inode_hash(inode). Silly, but will work
Variant 2:
	kill devfs_write_inode() - do its equivalent in notify_change()
_and_ set the de->atime in ->readlink() and ->follow_link(). The latter
is due to update_atime() logics. And no, I don't like it.

Actually, it stinks - we have UPDATE_ATIME implemented by direct assignment to
->i_atime instead of the proper way (->setattr()). Linus, would you mind if
I change that? That would be the Right Thing(tm), but it might be too heavy.

