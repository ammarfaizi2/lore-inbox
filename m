Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265494AbUFIBcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265494AbUFIBcB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 21:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265500AbUFIBbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 21:31:41 -0400
Received: from cantor.suse.de ([195.135.220.2]:51332 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265494AbUFIBb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 21:31:27 -0400
Subject: Re: [PATCH] writeback_inodes can race with unmount
From: Chris Mason <mason@suse.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mika.penttila@kolumbus.fi, linux-kernel@vger.kernel.org
In-Reply-To: <20040608145627.0191c026.akpm@osdl.org>
References: <1086722523.10973.157.camel@watt.suse.com>
	 <40C61A20.4000906@kolumbus.fi> <1086725926.10973.161.camel@watt.suse.com>
	 <20040608145627.0191c026.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1086744565.10973.192.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 08 Jun 2004 21:29:26 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-06-08 at 17:56, Andrew Morton wrote:
> Chris Mason <mason@suse.com> wrote:

> > > Why don't we have the same race in the sync() path as well? Moving the 
> > > locking to sync_sb_inodes() itself would fix it also.
> > 
> > In the sync() path we're already taking a read lock on s_umount sem. 
> > Moving the locking into sync_sb_inodes would be tricky, it is sometimes
> > called with the write lock on s_umount_sem held and sometimes with a
> > read lock.
> > 
> 
> Plus we'd be dead if we had to do the above.  If that read_trylock() fails
> the sync() will forget to sync stuff.
> 
> And, contra your description, we'll fail the trylock relatively frequently
> - when some other process is writing back this superblock.

The write lock is taken much less frequently.  Should be just on
mount/unmount no?

> 
> But as this codepath is never used for data-integrity writeout things
> should be OK.  I'll slip a comment in there and maybe a
> BUG_ON(wbc->sync_mode == WB_SYNC_ALL).
> 
> You didn't tell us where the window is?  It's a bit weird that some other
> process can come in and unmount the fs while there are non-zero-refcount
> inodes floating about on the superblock.

It's the iput in sync_sb_inodes().  The test workload is 8 parallel runs
of this loop (each run to a different /dev/xxx)

while(true) ; do
    mkfs /dev/xxx
    mount /dev/xxx /xxx
    dd if=/dev/zero of=/xxx/foo bs=1MB count=80
    rm /xxx/foo
    umount /dev/xxx
done

So, each FS only has a single dirty inode, and that single inode gets
deleted during the run.  With enough memory pressure, write calls
frequently go into throttling, increasing the chance for sync_sb_inodes
to be called for writeback at the same time as unmount.

Right before the iput in sync_sb_inodes, we've dropped both the sb_lock
and the inode_lock, nothing prevents the unmount from continuing.  The
super block won't be freed because we've got it pinned, but the unmount
can proceed.

So, it looks like we get this:

CPU 0				CPU 1
writeback_inodes		generic_shutdown_super
sync_sb_inodes			
iget(inode)
spin_unlock(&inode_lock)
				sop->put_super(sb)
iput(inode)
generic_delete_inode()




