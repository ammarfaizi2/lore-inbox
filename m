Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261368AbTBEOSv>; Wed, 5 Feb 2003 09:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbTBEOSv>; Wed, 5 Feb 2003 09:18:51 -0500
Received: from [195.39.17.254] ([195.39.17.254]:9732 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261368AbTBEOSu>;
	Wed, 5 Feb 2003 09:18:50 -0500
Date: Wed, 5 Feb 2003 00:16:53 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@digeo.com>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.0, 2.2, 2.4, 2.5: fsync buffer race
Message-ID: <20030204231652.GC128@elf.ucw.cz>
References: <Pine.LNX.4.44.0302022354570.11719-100000@artax.karlin.mff.cuni.cz> <20030202160007.554be43d.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030202160007.554be43d.akpm@digeo.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

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
> 
> and go use that in all the appropriate places.
> 
> I shall make that change for 2.5, thanks.

Should this be fixed at least in 2.4, too? It seems pretty serious for
mail servers (etc)...
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
