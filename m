Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbTBJQv3>; Mon, 10 Feb 2003 11:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265051AbTBJQv3>; Mon, 10 Feb 2003 11:51:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42764 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265039AbTBJQv1>; Mon, 10 Feb 2003 11:51:27 -0500
Date: Mon, 10 Feb 2003 08:57:03 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
cc: Andrea Arcangeli <andrea@suse.de>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.0, 2.2, 2.4, 2.5: fsync buffer race
In-Reply-To: <Pine.LNX.4.44.0302101723540.32095-100000@artax.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.44.0302100846090.2127-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Feb 2003, Mikulas Patocka wrote:
>
> Linus, do you remember what "nasty deadlock" did you mean when writing
> this to 2.[0-2].* and maybe 1.*?
> 
> ll_rw_blk.c - ll_rw_block():
>         /* Uhhuh.. Nasty dead-lock possible here.. */
>         if (buffer_locked(bh))
>                 return;
>         /* Maybe the above fixes it, and maybe it doesn't boot. Life is interesting */
>         lock_buffer(bh);

Nope, that's a _long_ time ago. It may well have been simply a MM bug that
got fixed long since, ie something like

 - dirty writeout happens
 - writeout needs memory
 - buffer.c tries to clean up pages
 - hang.

However, some of the comments in this thread seem to just simply not be 
correct:

> > > > > while the buffer is writing, another process calls fsync on inode 2
> > > > > it goes again to ext2_update_inode
> > > > > it calls ll_rw_block
> > > > > ll_rw_block sees buffer locked and exits immediatelly
> > > > > ext2_update_inode waits for buffer
> > > > > the first write finished, ext2_update_inode exits and changes made by
> > > > > second proces to inode 2 ARE NOT WRITTEN TO DISK.

The dirty bit is not cleared, so the changes _are_ written to disk. 
Eventually. The fact that something tests "unlocked" instead of "dirty" is 
not the fault of ll_rw_block(), and never has been.

So the bug is not in ll_rw_block(), but in the waiter. If you expect to be
able to wait for dirty blocks, you can't do what the code apparently does.  
You can't assume that "unlocked" means "no longer dirty". Unlocked means
unlocked, and dirty means dirty.

If you want to synchronously wait for dirty blocks, you should do 
something like

	lock_buffer();
	.. dirty buffer..
	mark_buffer_dirty();
	unlock_buffer();

	ll_rw_block(..)

Btw, it is probably a really bad idea to just do

	wait_and_write()
	{
		wait_for_buffer(..);
		ll_rw_block(..);
	}

for things like this. It's just a better idea to lock the buffer before 
making the modification.

Of course, these days, if you really want to, you can just use submit_bh() 
etc instead. At which point _you_ are responsible for all the locking and 
unlocking.

		Linus

