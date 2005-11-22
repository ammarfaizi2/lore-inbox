Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750973AbVKVDr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbVKVDr6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 22:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbVKVDr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 22:47:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:38793 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750962AbVKVDr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 22:47:56 -0500
Date: Mon, 21 Nov 2005 19:47:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: sander@humilis.net, linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: Please help me understand ->writepage. Was Re: segfault mdadm
 --write-behind, 2.6.14-mm2  (was: Re: RAID1 ramdisk patch)
Message-Id: <20051121194730.3993f4ca.akpm@osdl.org>
In-Reply-To: <17282.35980.613583.592130@cse.unsw.edu.au>
References: <431B9558.1070900@baanhofman.nl>
	<17179.40731.907114.194935@cse.unsw.edu.au>
	<20051116133639.GA18274@favonius>
	<20051116142000.5c63449f.akpm@osdl.org>
	<17275.48113.533555.948181@cse.unsw.edu.au>
	<20051117075041.GA5563@favonius>
	<20051117101251.GA2883@favonius>
	<20051117101511.GB2883@favonius>
	<17282.21309.229128.930997@cse.unsw.edu.au>
	<20051121155144.62bedaab.akpm@osdl.org>
	<17282.35980.613583.592130@cse.unsw.edu.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:
>
> Uhm, what would you think of testing mapping_cap_writeback_dirty in
>  write_one_page??  If you don't like it, I can take it into write_page.

write_one_page() is a little library function for filesystems to call, and
filesystems implicitly know whether or not they have backing store.  So
probably it's best to do this test in the (unusual) caller.

> > Also, write_page() doesn't need to run set_page_dirty(); ->commit_write()
> > will do that.
>
> Ok.... but I think I'm dropping prepare_write / commit_write.
>

Those functions do some pretty handy things, like creating disk blocks
within the file to back the page.  If someone comes along and ftruncate()s
the bitmap file while you're not looking, what happens?  Generally we use
i_sem for this sort of thing.


If you know that the page is still mapped into the file then yes, you can do

	lock_page()
	kmap_atomic()
	<modify>
	kunmap_atomic()
	flush_dcache_page()
	set_page_dirty()
	unlock_page()
	write_one_page(wait==1)

but that's rather a lot of work.

bitmap_unplug() looks risky - calling filesystem functions (like
lock_page()) from inside an unplug function.  Can this all be called from
the vmscan->writepage path?

It might be simpler and more maintainable to maintain the bitmap in normal
kernel memory, sync it to disk via higher-level entrypoints like
sys_write(), vfs_write(), sys_sync(), do_sync(), etc.
