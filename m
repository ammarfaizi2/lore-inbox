Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275286AbTHMRuQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 13:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275287AbTHMRuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 13:50:16 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:59069 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S275286AbTHMRuF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 13:50:05 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Deep call trace from PCMCIA CF eject
Date: Wed, 13 Aug 2003 19:50:16 +0200
User-Agent: KMail/1.5
Cc: Paul Dickson <dickson@permanentmail.com>, linux-kernel@vger.kernel.org
References: <20030813072456.35d62460.dickson@permanentmail.com> <20030813175311.B20676@flint.arm.linux.org.uk>
In-Reply-To: <20030813175311.B20676@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308131950.16912.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 of August 2003 18:53, Russell King wrote:
> On Wed, Aug 13, 2003 at 07:24:56AM -0700, Paul Dickson wrote:
> > Besides the minor concern about the trace itself, a bigger concern on my
> > part is how deep the call trace is (60+ levels).  How's it doing for
> > stack space?
>
> Not all those functions listed were involved - never, ever believe an
> x86 call trace as being the absolute truth. 8)
>
> The real calltrace is much closer to:
> > Aug 13 06:57:59 violet cardmgr[1559]: executing: './ide check hde'
> > Aug 13 06:58:00 violet cardmgr[1559]: executing: './ide stop hde'
> > Aug 13 06:58:01 violet kernel: hde: task_no_data_intr: status=0x51 {
> > DriveReady SeekComplete Error } Aug 13 06:58:01 violet kernel: hde:
> > task_no_data_intr: error=0x04 { DriveStatusError } Aug 13 06:58:01 violet
> > kernel: hde: Write Cache FAILED Flushing! Aug 13 06:58:01 violet
> > cardmgr[1559]: + /dev/hde1 umounted
> > Aug 13 06:58:01 violet kernel: updfstab: numerical sysctl 1 23 is
> > obsolete. Aug 13 06:58:02 violet kernel: hde: task_no_data_intr:
> > status=0x51 { DriveReady SeekComplete Error } Aug 13 06:58:02 violet
> > kernel: hde: task_no_data_intr: error=0x04 { DriveStatusError } Aug 13
> > 06:58:02 violet kernel: hde: Write Cache FAILED Flushing! Aug 13 06:58:02
> > violet kernel: Debug: sleeping function called from invalid context at
> > include/linux/rwsem.h:66 Aug 13 06:58:02 violet kernel: Call Trace:
> > Aug 13 06:58:02 violet kernel:  [<c011bc81>] __might_sleep+0x61/0x80
> > Aug 13 06:58:02 violet kernel:  [<c02376dc>] unlink+0x3c/0xa0
> > Aug 13 06:58:02 violet kernel:  [<c0267a32>] kobj_unmap+0x62/0x110
> > Aug 13 06:58:02 violet kernel:  [<c026cf62>]
> > blk_unregister_region+0x22/0x30 Aug 13 06:58:02 violet kernel: 
> > [<c0287eb3>] ide_unregister+0x2f3/0x8d0 Aug 13 06:58:02 violet kernel: 
> > [<d096cba4>] ide_release+0x94/0x130 [ide_cs] Aug 13 06:58:02 violet
> > kernel:  [<d096c1fc>] ide_detach+0xac/0xc0 [ide_cs] Aug 13 06:58:02
> > violet kernel:  [<d09727e2>] unbind_request+0xd2/0xe0 [ds] Aug 13
> > 06:58:02 violet kernel:  [<d0972fa1>] ds_ioctl+0x441/0x770 [ds] Aug 13
> > 06:58:02 violet kernel:  [<c01652b0>] sys_ioctl+0x100/0x290 Aug 13
> > 06:58:02 violet kernel:  [<c010b1f9>] sysenter_past_esp+0x52/0x71
>
> The problem is IDE - ide_unregister() does the following:
>
>         spin_lock_irq(&ide_lock);
> ...
>         blk_unregister_region(MKDEV(hwif->major, 0),
> MAX_DRIVES<<PARTN_BITS);
>
> Since blk_unregister_region is sleepy, and sleeping with a spinlock
> held is a big NO NO, it's an IDE problem not a PCMCIA problem.  It
> should be calling blk_unregister_region with a spinlock held.

Yep, thanks.
This patch should be sufficient until ide locking rework is ready.

--bartlomiej

 drivers/ide/ide.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff -puN drivers/ide/ide.c~ide-unregister-bandaid drivers/ide/ide.c
--- linux-2.6.0-test2-bk7/drivers/ide/ide.c~ide-unregister-bandaid	2003-08-13 19:39:13.281512048 +0200
+++ linux-2.6.0-test2-bk7-root/drivers/ide/ide.c	2003-08-13 19:43:49.900459576 +0200
@@ -778,6 +778,17 @@ void ide_unregister (unsigned int index)
 	/* More fucked up locking ... */
 	spin_unlock_irq(&ide_lock);
 	device_unregister(&hwif->gendev);
+
+	/*
+	 * Remove us from the kernel's knowledge
+	 */
+	blk_unregister_region(MKDEV(hwif->major, 0), MAX_DRIVES<<PARTN_BITS);
+	for (i = 0; i < MAX_DRIVES; i++) {
+		struct gendisk *disk = hwif->drives[i].disk;
+		hwif->drives[i].disk = NULL;
+		put_disk(disk);
+	}
+	unregister_blkdev(hwif->major, hwif->name);
 	spin_lock_irq(&ide_lock);
 
 #if !defined(CONFIG_DMA_NONPCI)
@@ -793,18 +804,6 @@ void ide_unregister (unsigned int index)
 		hwif->dma_prdtable = 0;
 	}
 #endif /* !(CONFIG_DMA_NONPCI) */
-
-	/*
-	 * Remove us from the kernel's knowledge
-	 */
-	blk_unregister_region(MKDEV(hwif->major, 0), MAX_DRIVES<<PARTN_BITS);
-	for (i = 0; i < MAX_DRIVES; i++) {
-		struct gendisk *disk = hwif->drives[i].disk;
-		hwif->drives[i].disk = NULL;
-		put_disk(disk);
-	}
-	unregister_blkdev(hwif->major, hwif->name);
-
 	old_hwif			= *hwif;
 	init_hwif_data(index);	/* restore hwif data to pristine status */
 	hwif->hwgroup			= old_hwif.hwgroup;

_




