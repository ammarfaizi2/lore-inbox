Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750792AbWFEIh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWFEIh3 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 04:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbWFEIgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 04:36:09 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:14300 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750771AbWFEIgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 04:36:06 -0400
Date: Mon, 5 Jun 2006 10:35:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
        Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm3] fix IDE deadlock in error reporting code
Message-ID: <20060605083530.GA31738@elte.hu>
References: <20060603232004.68c4e1e3.akpm@osdl.org> <986ed62e0606040238t712d7b01xde5f4a23da12fb1a@mail.gmail.com> <20060604024937.0fb57258.akpm@osdl.org> <6bffcb0e0606040308j28d9e89axa0136908c5530ae3@mail.gmail.com> <20060604104121.GA16117@elte.hu> <6bffcb0e0606040407u4f56f7fdyf5ec479314afc082@mail.gmail.com> <20060604213803.GC5898@elte.hu> <6bffcb0e0606041535u10fdb7c2o9ac38d6fb80fd28d@mail.gmail.com> <20060605083016.GA31013@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605083016.GA31013@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5002]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> ah. That's a real deadlock scenario. Does the patch below fix it? If 
> yes then i think this is a candidate for 2.6.17 merging too.

actually, the replacement patch below is better i think - it moves the 
ide_lock taking to outside the printing section. That should still be OK 
as we dont call other functions from within the section, and it should 
also result in slightly more robust printing, as the whole printing code 
will be atomic under ide_lock.

	Ingo

---------
Subject: [patch, -rc5-mm3] fix IDE deadlock in error reporting code
From: Ingo Molnar <mingo@elte.hu>

Michal Piotrowski reported the following validator assert:

 hdd: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
 hdd: set_drive_speed_status: error=0xb4 { AbortedCommand LastFailedSense=0x0b }

 ============================
 [ BUG: illegal lock usage! ]
 ----------------------------
 illegal {in-hardirq-W} -> {hardirq-on-W} usage.
 hdparm/1821 [HC0[0]:SC0[0]:HE1:SE1] takes:
  (ide_lock){++..}, at: [<c0268388>] ide_dump_opcode+0x13/0x9b

 [...]

 stack backtrace:
  [<c0104513>] show_trace+0x1b/0x20
  [<c01045f1>] dump_stack+0x1f/0x24
  [<c013976c>] print_usage_bug+0x1a5/0x1b1
  [<c0139e90>] mark_lock+0x2ca/0x4f7
  [<c013aa96>] __lockdep_acquire+0x47e/0xaa4
  [<c013b536>] lockdep_acquire+0x67/0x7f
  [<c030552d>] _spin_lock+0x24/0x32
  [<c0268388>] ide_dump_opcode+0x13/0x9b
  [<c02688b6>] ide_dump_status+0x4a6/0x4cc
  [<c0267ae6>] ide_config_drive_speed+0x32a/0x33a
  [<c0262dc5>] piix_tune_chipset+0x2ed/0x2f8
  [<c0262e31>] piix_config_drive_xfer_rate+0x61/0xb5
  [<c0263a82>] set_using_dma+0x2f/0x60
  [<c0263bee>] ide_write_setting+0x4a/0xc3
  [<c02647ca>] generic_ide_ioctl+0x8a/0x47f
  [<f886003a>] idecd_ioctl+0xfd/0x133 [ide_cd]
  [<c01f1fff>] blkdev_driver_ioctl+0x4b/0x5f
  [<c01f2783>] blkdev_ioctl+0x770/0x7bd
  [<c017dc0d>] block_ioctl+0x1f/0x21
  [<c0189353>] do_ioctl+0x27/0x6e
  [<c0189604>] vfs_ioctl+0x26a/0x280
  [<c0189667>] sys_ioctl+0x4d/0x7e
  [<c0305ed2>] sysenter_past_esp+0x63/0xa1

in ide_dump_opcode() takes the ide_lock in an irq-unsafe manner,
i.e. this function expects to be called with irqs disabled. But
ide_dump_ata[pi]_status() doesnt do that - it enables interrupts
specifically. That is a no-no - what guarantees that another IDE
port couldnt generate an IDE interrupt while we are dumping this
error? The fix is to turn the irq-enabling in these functions into
irq-disabling.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 drivers/ide/ide-lib.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

Index: linux/drivers/ide/ide-lib.c
===================================================================
--- linux.orig/drivers/ide/ide-lib.c
+++ linux/drivers/ide/ide-lib.c
@@ -471,11 +471,9 @@ static void ide_dump_opcode(ide_drive_t 
 	u8 opcode = 0;
 	int found = 0;
 
-	spin_lock(&ide_lock);
 	rq = NULL;
 	if (HWGROUP(drive))
 		rq = HWGROUP(drive)->rq;
-	spin_unlock(&ide_lock);
 	if (!rq)
 		return;
 	if (rq->flags & (REQ_DRIVE_CMD | REQ_DRIVE_TASK)) {
@@ -506,7 +504,7 @@ static u8 ide_dump_ata_status(ide_drive_
 	unsigned long flags;
 	u8 err = 0;
 
-	local_irq_set(flags);
+	spin_lock_irqsave(&ide_lock, flags);
 	printk("%s: %s: status=0x%02x { ", drive->name, msg, stat);
 	if (stat & BUSY_STAT)
 		printk("Busy ");
@@ -566,7 +564,8 @@ static u8 ide_dump_ata_status(ide_drive_
 		printk("\n");
 	}
 	ide_dump_opcode(drive);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&ide_lock, flags);
+
 	return err;
 }
 
@@ -588,7 +587,9 @@ static u8 ide_dump_atapi_status(ide_driv
 
 	status.all = stat;
 	error.all = 0;
-	local_irq_set(flags);
+
+	spin_lock_irqsave(&ide_lock, flags);
+
 	printk("%s: %s: status=0x%02x { ", drive->name, msg, stat);
 	if (status.b.bsy)
 		printk("Busy ");
@@ -614,7 +615,8 @@ static u8 ide_dump_atapi_status(ide_driv
 		printk("}\n");
 	}
 	ide_dump_opcode(drive);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&ide_lock, flags);
+
 	return error.all;
 }
 
