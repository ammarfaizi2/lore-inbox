Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270028AbRHGBnM>; Mon, 6 Aug 2001 21:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270032AbRHGBmw>; Mon, 6 Aug 2001 21:42:52 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:979 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270028AbRHGBmr>;
	Mon, 6 Aug 2001 21:42:47 -0400
Date: Mon, 6 Aug 2001 21:42:56 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <200108070127.f771RNe27524@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0108062129030.16817-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Aug 2001, Richard Gooch wrote:

> I'm referring specifically to this code:
>     new->inode.ino = fs_info.num_inodes + FIRST_INODE;
>     fs_info.table[fs_info.num_inodes++] = new;
> 
> This is not SMP safe. Besides, even the allocation loop isn't SMP
> safe. If two tasks both allocate a table, they each could end up
> calling:
> 	kfree (fs_info.table);
> for the same value. Or for a different one (which is also bad).

BKL. kfree() is non-blocking. IOW, critical area can be placed under a
spinlock and BKL acts as such. We can trivially replace it with
a spinlock (static in function).

Actually, there is another problem with that code and it has nothing to
SMP. You never shrink that table and AFAICS you never reuse the entries.
IOW, you've got a leak there.

Why on the Earth do you need it, in the first place? Just put the
pointer to entry into inode->u.generic_ip and be done with that -
it kills all that mess for good. AFAICS the only places where you
really use that table is your get_devfs_entry_from_vfs_inode()
and devfs_write_inode(). In both cases pointer would be obviously more
convenient.

