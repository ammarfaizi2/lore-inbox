Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265341AbUFHVxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265341AbUFHVxt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 17:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265342AbUFHVxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 17:53:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:33972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265341AbUFHVxr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 17:53:47 -0400
Date: Tue, 8 Jun 2004 14:56:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: mika.penttila@kolumbus.fi, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] writeback_inodes can race with unmount
Message-Id: <20040608145627.0191c026.akpm@osdl.org>
In-Reply-To: <1086725926.10973.161.camel@watt.suse.com>
References: <1086722523.10973.157.camel@watt.suse.com>
	<40C61A20.4000906@kolumbus.fi>
	<1086725926.10973.161.camel@watt.suse.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> On Tue, 2004-06-08 at 15:57, Mika Penttilä wrote:
> > Chris Mason wrote:
> > 
> > >There's a small window where the filesystem can be unmounted during
> > >writeback_inodes.  The end result is the iput done by sync_sb_inodes
> > >could be done after the FS put_super and and the super has been removed
> > >from all lists.
> > >  
> > >
> > 
> > Why don't we have the same race in the sync() path as well? Moving the 
> > locking to sync_sb_inodes() itself would fix it also.
> 
> In the sync() path we're already taking a read lock on s_umount sem. 
> Moving the locking into sync_sb_inodes would be tricky, it is sometimes
> called with the write lock on s_umount_sem held and sometimes with a
> read lock.
> 

Plus we'd be dead if we had to do the above.  If that read_trylock() fails
the sync() will forget to sync stuff.

And, contra your description, we'll fail the trylock relatively frequently
- when some other process is writing back this superblock.

But as this codepath is never used for data-integrity writeout things
should be OK.  I'll slip a comment in there and maybe a
BUG_ON(wbc->sync_mode == WB_SYNC_ALL).

You didn't tell us where the window is?  It's a bit weird that some other
process can come in and unmount the fs while there are non-zero-refcount
inodes floating about on the superblock.
