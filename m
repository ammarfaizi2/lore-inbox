Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUDLHnO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 03:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbUDLHnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 03:43:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:2786 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261742AbUDLHnM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 03:43:12 -0400
Date: Mon, 12 Apr 2004 00:42:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul P Komkoff Jr <i@stingr.net>
Cc: linux-kernel@vger.kernel.org, Joe Thornber <thornber@redhat.com>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: 2.6.5-mm4
Message-Id: <20040412004244.0f50a7d4.akpm@osdl.org>
In-Reply-To: <20040412064605.GO14129@stingr.net>
References: <20040410200551.31866667.akpm@osdl.org>
	<20040412064605.GO14129@stingr.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul P Komkoff Jr <i@stingr.net> wrote:
>
> Replying to Andrew Morton:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm4/
> 
> I've got couple of these:
> Apr 12 10:31:41 h1 Debug: sleeping function called from invalid
> context at drivers/block/ll_rw_blk.c:1156
> Apr 12 10:31:41 h1 in_atomic():1, irqs_disabled():1
> Apr 12 10:31:41 h1 Call Trace:
> Apr 12 10:31:41 h1 [<c011e396>] __might_sleep+0xb6/0xe0
> Apr 12 10:31:41 h1 [<c02e4f05>] generic_unplug_device+0x15/0x80
> Apr 12 10:31:41 h1 [<c03b8597>] unplug_slaves+0xa7/0xb0
> Apr 12 10:31:41 h1 [<c02e76f4>] blk_backing_dev_unplug+0x14/0x16
> Apr 12 10:31:41 h1 [<c016287a>] __wait_on_buffer+0xea/0xf0
> Apr 12 10:31:41 h1 [<c011e980>] autoremove_wake_function+0x0/0x40
> Apr 12 10:31:41 h1 [<c0166514>] submit_bh+0x94/0x1e0
> Apr 12 10:31:41 h1 [<c011e980>] autoremove_wake_function+0x0/0x40
> Apr 12 10:31:41 h1 [<c01a8298>] ext3_get_inode_loc+0x168/0x250
> Apr 12 10:31:41 h1 [<c01a8409>] ext3_read_inode+0x29/0x2f0
> Apr 12 10:31:41 h1 [<c017c7f5>] get_new_inode_fast+0x45/0x130
> Apr 12 10:31:41 h1 [<c01aa2a4>] ext3_lookup+0x84/0xb0
> Apr 12 10:31:41 h1 [<c016f98e>] real_lookup+0xce/0x100
> Apr 12 10:31:41 h1 [<c016fc25>] do_lookup+0x75/0x80
> Apr 12 10:31:41 h1 [<c016fd57>] link_path_walk+0x127/0xa20
> Apr 12 10:31:41 h1 [<c02a0aa4>] set_cursor+0x64/0x80
> Apr 12 10:31:41 h1 [<c0170934>] path_lookup+0xa4/0x1d0
> Apr 12 10:31:41 h1 [<c01711c9>] open_namei+0x89/0x420
> Apr 12 10:31:41 h1 [<c016043d>] filp_open+0x2d/0x50
> Apr 12 10:31:41 h1 [<c01608ed>] sys_open+0x4d/0xa0
> Apr 12 10:31:41 h1 [<c01003e9>] init+0xd9/0x180
> Apr 12 10:31:41 h1 [<c0100310>] init+0x0/0x180
> Apr 12 10:31:41 h1 [<c01042c5>] kernel_thread_helper+0x5/0x10

I don't think this can happen in -mm only.

> Actually, it is not -mm4 itself but Joe Thornber's -udm2 on top
> of it and evms patches.

I added a might_sleep() to generic_unplug_device(), because some drivers'
unplug functions can sleep.

It appears that either the EVMS or the udm2 patch is calling
generic_unplug_device() under a lock.  Probably spin_lock_irq(q->lock).
