Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269839AbTGKIXM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 04:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269828AbTGKIUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 04:20:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37347 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269827AbTGKIT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 04:19:58 -0400
Date: Fri, 11 Jul 2003 10:34:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: 2.5.75 does not boot - TCQ oops
Message-ID: <20030711083437.GG843@suse.de>
References: <200307102251.42787.ivg2@cornell.edu> <20030711080335.GD843@suse.de> <20030711082817.GE843@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711082817.GE843@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11 2003, Jens Axboe wrote:
> On Fri, Jul 11 2003, Jens Axboe wrote:
> > On Thu, Jul 10 2003, Ivan Gyurdiev wrote:
> > > See, 
> > > 
> > > http://www.ussg.iu.edu/hypermail/linux/kernel/0307.0/0515.html
> > > 
> > > where the bug is described for 2.5.74.
> > > I got no replies, and the bug persists in 2.5.75 (+bk patches).
> > > 
> > > Note:
> > > The machine boots with TASKFILE on, TCQ is causing the problem.
> > 
> > Looks like IDE using the queue before it has been setup, probably Bart
> > broke it when he moved the TCQ init around. I'll take a look.
> 
> Here's the fix. Bart, you moved the tcq init to a much earlier fase
> (saying ide_init_drive() was too early, well ide_dma_on is much earlier
> in the init fase). ide_init_drive() _is_ the correct location in my
> oppinion, drive and queue has been set up at this point.

Better still (and later in the probe) is this version. This is in my
oppinion the correct place to init tcq, and also contains it to ide-disk
where it should be.

--- drivers/ide/ide-dma.c~	2003-07-11 10:21:04.492561920 +0200
+++ drivers/ide/ide-dma.c	2003-07-11 10:25:28.183474808 +0200
@@ -572,10 +572,6 @@
 	if (HWIF(drive)->ide_dma_host_on(drive))
 		return 1;
 
-#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
-	HWIF(drive)->ide_dma_queued_on(drive);
-#endif
-
 	return 0;
 }
 
--- drivers/ide/ide-disk.c~	2003-07-11 10:30:51.783280160 +0200
+++ drivers/ide/ide-disk.c	2003-07-11 10:31:09.873530024 +0200
@@ -1665,6 +1665,10 @@
 	drive->no_io_32bit = id->dword_io ? 1 : 0;
 	if (drive->id->cfs_enable_2 & 0x3000)
 		write_cache(drive, (id->cfs_enable_2 & 0x3000));
+
+#ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
+	HWIF(drive)->ide_dma_queued_on(drive);
+#endif
 }
 
 static int idedisk_cleanup (ide_drive_t *drive)

-- 
Jens Axboe

