Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbTBEPDq>; Wed, 5 Feb 2003 10:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261463AbTBEPDp>; Wed, 5 Feb 2003 10:03:45 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:58762 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261456AbTBEPDo>; Wed, 5 Feb 2003 10:03:44 -0500
Date: Wed, 5 Feb 2003 16:13:19 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.0, 2.2, 2.4, 2.5: fsync buffer race
In-Reply-To: <20030204231652.GC128@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0302051605400.14908-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi!
>
> > > there's a race condition in filesystem
> > >
> > > let's have a two inodes that are placed in the same buffer.
> > >
> > > call fsync on inode 1
> > > it goes down to ext2_update_inode [update == 1]
> > > it calls ll_rw_block at the end
> > > ll_rw_block starts to write buffer
> > > ext2_update_inode waits on buffer
> > >
> > > while the buffer is writing, another process calls fsync on inode 2
> > > it goes again to ext2_update_inode
> > > it calls ll_rw_block
> > > ll_rw_block sees buffer locked and exits immediatelly
> > > ext2_update_inode waits for buffer
> > > the first write finished, ext2_update_inode exits and changes made by
> > > second proces to inode 2 ARE NOT WRITTEN TO DISK.
> > >
> >
> > hmm, yes.  This is a general weakness in the ll_rw_block() interface.  It is
> > not suitable for data-integrity writeouts, as you've pointed out.
> >
> > A suitable fix would be do create a new
> >
> > void wait_and_rw_block(...)
> > {
> > 	wait_on_buffer(bh);
> > 	ll_rw_block(...);
> > }
> >
> > and go use that in all the appropriate places.
> >
> > I shall make that change for 2.5, thanks.
>
> Should this be fixed at least in 2.4, too? It seems pretty serious for
> mail servers (etc)...
> 								Pavel

It should, but it is a hazard. The problem is that every use of
ll_rw_block has this bug, not only the one in ext2 fsync. The most clean
thing would be to modify ll_rw_block to wait until buffer becomes
unlocked, no one knows if it can produce some weird things.

Even Linus didn't know what he was doing, see this comment around the
buggy part in 2.2, 2.0 and previous kernels.

ll_rw_blk.c:
        /* Uhhuh.. Nasty dead-lock possible here.. */
        if (buffer_locked(bh))
                return;
        /* Maybe the above fixes it, and maybe it doesn't boot. Life is
interesting */
        lock_buffer(bh);

Mikulas

