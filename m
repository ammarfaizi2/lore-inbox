Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270025AbRHGCAE>; Mon, 6 Aug 2001 22:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270031AbRHGB7y>; Mon, 6 Aug 2001 21:59:54 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:41860 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S270025AbRHGB7l>; Mon, 6 Aug 2001 21:59:41 -0400
Date: Mon, 6 Aug 2001 20:00:02 -0600
Message-Id: <200108070200.f77202G27928@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <Pine.GSO.4.21.0108062129030.16817-100000@weyl.math.psu.edu>
In-Reply-To: <200108070127.f771RNe27524@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0108062129030.16817-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> 
> 
> On Mon, 6 Aug 2001, Richard Gooch wrote:
> 
> > I'm referring specifically to this code:
> >     new->inode.ino = fs_info.num_inodes + FIRST_INODE;
> >     fs_info.table[fs_info.num_inodes++] = new;
> > 
> > This is not SMP safe. Besides, even the allocation loop isn't SMP
> > safe. If two tasks both allocate a table, they each could end up
> > calling:
> > 	kfree (fs_info.table);
> > for the same value. Or for a different one (which is also bad).
> 
> BKL. kfree() is non-blocking. IOW, critical area can be placed under a
> spinlock and BKL acts as such. We can trivially replace it with
> a spinlock (static in function).
> 
> Actually, there is another problem with that code and it has nothing
> to SMP. You never shrink that table and AFAICS you never reuse the
> entries.  IOW, you've got a leak there.

The devfs entries are reused *for the same name*. But yes, if "fred"
is registered and unregistered, and is never registered again, it will
indeed stick around forever. In general, this is not a significant
problem, since the same name tends to be re-registered later. Said
another way: there aren't many different temporary entries.

The reason for not freeing stuff is simplicity. Without proper
locking, I was able to avoid a lot of races. Now that I'm putting
locks in, I can consider freeing stuff (after the locks are in).

> Why on the Earth do you need it, in the first place? Just put the
> pointer to entry into inode->u.generic_ip and be done with that - it
> kills all that mess for good. AFAICS the only places where you
> really use that table is your get_devfs_entry_from_vfs_inode() and
> devfs_write_inode(). In both cases pointer would be obviously more
> convenient.

Again, historical reasons. When I wrote devfs, the pipe data trampled
the inode->u.generic_ip pointer. So that's no good. I see that the
pipe data has been moved away. Good. Hm. But there's still the
inode->u.socket_i structure. I'd need to check where that gets
trampled.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
