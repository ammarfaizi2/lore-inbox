Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbVKGKhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbVKGKhm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 05:37:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVKGKhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 05:37:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35252 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750865AbVKGKhl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 05:37:41 -0500
Date: Mon, 7 Nov 2005 02:37:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@suse.de>
Cc: reuben-lkml@reub.net, linux-kernel@vger.kernel.org, n@suse.de
Subject: Re: 2.6.14-mm1
Message-Id: <20051107023723.5cf63393.akpm@osdl.org>
In-Reply-To: <17263.11214.992300.34384@cse.unsw.edu.au>
References: <20051106182447.5f571a46.akpm@osdl.org>
	<436F2452.9020207@reub.net>
	<20051107020905.69c0b6dc.akpm@osdl.org>
	<17263.11214.992300.34384@cse.unsw.edu.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@suse.de> wrote:
>
> On Monday November 7, akpm@osdl.org wrote:
> > Reuben Farrelly <reuben-lkml@reub.net> wrote:
> > >
> > > Hi again,
> > > 
> > > On 7/11/2005 3:24 p.m., Andrew Morton wrote:
> > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm1/
> > > > 
> > > > - Added the 1394 development tree to the -mm lineup, as git-ieee1394.patch
> > > > 
> > > > - Re-added rmk's driver-model tree git-drvmodel.patch
> > > > 
> > > > - Added davem's sparc64 tree, as git-sparc64.patch
> > > > 
> > > > - v4l updates
> > > > 
> > > > - dvb updates
> > > 
> > > Just rebooted into 2.6.14-mm1 and now every few seconds I get this spewed up 
> > > on the console:
> > > 
> > > Nov  7 22:49:47 tornado kernel: Debug: sleeping function called from invalid 
> > > context at include/asm/semaphore.h:99
> > > Nov  7 22:49:47 tornado kernel: in_atomic():0, irqs_disabled():1
> > > Nov  7 22:49:47 tornado kernel:  [<c0103a50>] dump_stack+0x17/0x19
> > > Nov  7 22:49:47 tornado kernel:  [<c011971b>] __might_sleep+0x9d/0xad
> > > Nov  7 22:49:47 tornado kernel:  [<c028aa4b>] scsi_disk_get_from_dev+0x15/0x48
> > > Nov  7 22:49:47 tornado kernel:  [<c028b28e>] sd_prepare_flush+0x17/0x5a
> > > Nov  7 22:49:47 tornado kernel:  [<c027abff>] scsi_prepare_flush_fn+0x30/0x33
> > > Nov  7 22:49:47 tornado kernel:  [<c0255332>] blk_start_pre_flush+0xd5/0x13f
> > > Nov  7 22:49:47 tornado kernel:  [<c025490b>] elv_next_request+0x112/0x16f
> > > Nov  7 22:49:47 tornado kernel:  [<c027b045>] scsi_request_fn+0x4b/0x2fd
> > > Nov  7 22:49:47 tornado kernel:  [<c0254748>] __elv_add_request+0x109/0x176
> > > Nov  7 22:49:47 tornado kernel:  [<c0257ab4>] __make_request+0x1d0/0x474
> > > Nov  7 22:49:47 tornado kernel:  [<c0257e96>] generic_make_request+0xb3/0x128
> ....
> > > 
> > > The box has raid-1 and I'm guessing that that may be the culprit here... ?
> > > 
> > 
> > It's not immediately obvious.  Could you enable CONFIG_DEBUG_PREEMPT? 
> > That'll tell us where the thread went into atomic mode.
> 
> Quick code inspection:
>  ll_rw_blk.c:2693 __make_request calls spin_lock_irq - goes atomic
>    line 2793, calls add_request()
>       This is before the spin_unlock_irq on line 2798
>    line 2438, add_request calls __elv_add_request 
>  and the rest you can get from the stack trace until
>   scsi_disk_get_from_dev in sd.c calls 
>     down(&sd_ref_sem);
>  which causes the message.
> 
> Note raid-1 at all :-)  (this time).
> 

Possibly.  But scsi like to undo host->lock in the strangest places.

Would still like that CONFIG_DEBUG_PREEMPT trace, please.
