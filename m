Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbTBCBDe>; Sun, 2 Feb 2003 20:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbTBCBDe>; Sun, 2 Feb 2003 20:03:34 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:6552 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S265196AbTBCBDd>; Sun, 2 Feb 2003 20:03:33 -0500
Date: Mon, 3 Feb 2003 02:13:01 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.0, 2.2, 2.4, 2.5: fsync buffer race
In-Reply-To: <20030202160007.554be43d.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0302030210460.26710-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Feb 2003, Andrew Morton wrote:

> Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> wrote:
> >
> > Hi
> >
> > there's a race condition in filesystem
> >
> > let's have a two inodes that are placed in the same buffer.
> >
> > call fsync on inode 1
> > it goes down to ext2_update_inode [update == 1]
> > it calls ll_rw_block at the end
> > ll_rw_block starts to write buffer
> > ext2_update_inode waits on buffer
> >
> > while the buffer is writing, another process calls fsync on inode 2
> > it goes again to ext2_update_inode
> > it calls ll_rw_block
> > ll_rw_block sees buffer locked and exits immediatelly
> > ext2_update_inode waits for buffer
> > the first write finished, ext2_update_inode exits and changes made by
> > second proces to inode 2 ARE NOT WRITTEN TO DISK.
> >
>
> hmm, yes.  This is a general weakness in the ll_rw_block() interface.  It is
> not suitable for data-integrity writeouts, as you've pointed out.
>
> A suitable fix would be do create a new
>
> void wait_and_rw_block(...)
> {
> 	wait_on_buffer(bh);
> 	ll_rw_block(...);
> }

It would fail if other CPU submits IO with ll_rw_block after
wait_on_buffer but before ll_rw_block. ll_rw_block really needs to be
rewritten.

Mikulas

> and go use that in all the appropriate places.
>
> I shall make that change for 2.5, thanks.
>

