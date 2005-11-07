Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbVKGK0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVKGK0d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 05:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbVKGK0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 05:26:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:43692 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964818AbVKGK0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 05:26:31 -0500
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 7 Nov 2005 21:26:22 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17263.11214.992300.34384@cse.unsw.edu.au>
Cc: Reuben Farrelly <reuben-lkml@reub.net>, linux-kernel@vger.kernel.org,
       n@suse.de
Subject: Re: 2.6.14-mm1
In-Reply-To: message from Andrew Morton on Monday November 7
References: <20051106182447.5f571a46.akpm@osdl.org>
	<436F2452.9020207@reub.net>
	<20051107020905.69c0b6dc.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 7, akpm@osdl.org wrote:
> Reuben Farrelly <reuben-lkml@reub.net> wrote:
> >
> > Hi again,
> > 
> > On 7/11/2005 3:24 p.m., Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.14-mm1/
> > > 
> > > - Added the 1394 development tree to the -mm lineup, as git-ieee1394.patch
> > > 
> > > - Re-added rmk's driver-model tree git-drvmodel.patch
> > > 
> > > - Added davem's sparc64 tree, as git-sparc64.patch
> > > 
> > > - v4l updates
> > > 
> > > - dvb updates
> > 
> > Just rebooted into 2.6.14-mm1 and now every few seconds I get this spewed up 
> > on the console:
> > 
> > Nov  7 22:49:47 tornado kernel: Debug: sleeping function called from invalid 
> > context at include/asm/semaphore.h:99
> > Nov  7 22:49:47 tornado kernel: in_atomic():0, irqs_disabled():1
> > Nov  7 22:49:47 tornado kernel:  [<c0103a50>] dump_stack+0x17/0x19
> > Nov  7 22:49:47 tornado kernel:  [<c011971b>] __might_sleep+0x9d/0xad
> > Nov  7 22:49:47 tornado kernel:  [<c028aa4b>] scsi_disk_get_from_dev+0x15/0x48
> > Nov  7 22:49:47 tornado kernel:  [<c028b28e>] sd_prepare_flush+0x17/0x5a
> > Nov  7 22:49:47 tornado kernel:  [<c027abff>] scsi_prepare_flush_fn+0x30/0x33
> > Nov  7 22:49:47 tornado kernel:  [<c0255332>] blk_start_pre_flush+0xd5/0x13f
> > Nov  7 22:49:47 tornado kernel:  [<c025490b>] elv_next_request+0x112/0x16f
> > Nov  7 22:49:47 tornado kernel:  [<c027b045>] scsi_request_fn+0x4b/0x2fd
> > Nov  7 22:49:47 tornado kernel:  [<c0254748>] __elv_add_request+0x109/0x176
> > Nov  7 22:49:47 tornado kernel:  [<c0257ab4>] __make_request+0x1d0/0x474
> > Nov  7 22:49:47 tornado kernel:  [<c0257e96>] generic_make_request+0xb3/0x128
....
> > 
> > The box has raid-1 and I'm guessing that that may be the culprit here... ?
> > 
> 
> It's not immediately obvious.  Could you enable CONFIG_DEBUG_PREEMPT? 
> That'll tell us where the thread went into atomic mode.

Quick code inspection:
 ll_rw_blk.c:2693 __make_request calls spin_lock_irq - goes atomic
   line 2793, calls add_request()
      This is before the spin_unlock_irq on line 2798
   line 2438, add_request calls __elv_add_request 
 and the rest you can get from the stack trace until
  scsi_disk_get_from_dev in sd.c calls 
    down(&sd_ref_sem);
 which causes the message.

Note raid-1 at all :-)  (this time).

NeilBrown
