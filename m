Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312141AbSDXNdn>; Wed, 24 Apr 2002 09:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312178AbSDXNdm>; Wed, 24 Apr 2002 09:33:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60427 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S312141AbSDXNdl>;
	Wed, 24 Apr 2002 09:33:41 -0400
Date: Wed, 24 Apr 2002 15:33:29 +0200
From: Jens Axboe <axboe@suse.de>
To: rwhron@earthlink.net
Cc: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
Message-ID: <20020424133329.GA8988@suse.de>
In-Reply-To: <20020424093021.A21652@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24 2002, rwhron@earthlink.net wrote:
> >> Oops on 2.5.9 at boot time.
> 
> > Could you please introduce two printk("BANG\n") printk("BOOM\n")
> > aroung the ata_ar_get() in ide-cd? Just to see whatever the
> > command queue is already up and initialized.
> 
> This may not be what you wanted:
> 
> 	printk("BANG\n");
>         ar = ata_ar_get(drive);
>         printk("BOOM\n");
> 
> If it is, neither BANG nor BOOM printed before oops.

Look, the problem is easy. Backout the changes to ide_cdrom_do_request()
and cdrom_start_read(), then re-add the

	HWGROUP(drive)->rq->special = NULL;

in cdrom_end_request() before calling ide_end_request()

Something ala, completely untested (not even compiled). See the thread
about the ide-cd changes being broken.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.558   -> 1.559  
#	drivers/ide/ide-cd.c	1.35    -> 1.36   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/24	axboe@burns.home.kernel.dk	1.559
# "fix" rq->special and ar usage, needs proper fixing
# --------------------------------------------
#
diff -Nru a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
--- a/drivers/ide/ide-cd.c	Wed Apr 24 15:32:59 2002
+++ b/drivers/ide/ide-cd.c	Wed Apr 24 15:32:59 2002
@@ -558,10 +558,7 @@
 	if ((rq->flags & REQ_CMD) && !rq->current_nr_sectors)
 		uptodate = 1;
 
-#if 0
-	/* FIXME --mdcki */
 	HWGROUP(drive)->rq->special = NULL;
-#endif
 	ide_end_request(drive, uptodate);
 }
 
@@ -1217,22 +1214,13 @@
 /*
  * Start a read request from the CD-ROM.
  */
-static ide_startstop_t cdrom_start_read(struct ata_device *drive, struct ata_request *ar, unsigned int block)
+static ide_startstop_t cdrom_start_read(struct ata_device *drive, unsigned int block)
 {
 	struct cdrom_info *info = drive->driver_data;
-	struct request *rq = ar->ar_rq;
-
-	if (ar->ar_flags & ATA_AR_QUEUED) {
-//		spin_lock_irqsave(DRIVE_LOCK(drive), flags);
-		blkdev_dequeue_request(rq);
-//		spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
-	}
-
+	struct request *rq = HWGROUP(drive)->rq;
 
 	restore_request(rq);
 
-	rq->special = ar;
-
 	/* Satisfy whatever we can of this request from our cached sector. */
 	if (cdrom_read_from_buffer(drive))
 		return ide_stopped;
@@ -1665,30 +1653,8 @@
 		if (IDE_LARGE_SEEK(info->last_block, block, IDECD_SEEK_THRESHOLD) && drive->dsc_overlap)
 			action = cdrom_start_seek (drive, block);
 		else {
-			unsigned long flags;
-			struct ata_request *ar;
-
-			/*
-			 * get a new command (push ar further down to avoid grabbing lock here
-			 */
-			spin_lock_irqsave(DRIVE_LOCK(drive), flags);
-
-			ar = ata_ar_get(drive);
-
-			/*
-			 * we've reached maximum queue depth, bail
-			 */
-			if (!ar) {
-				spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
-
-				return ide_started;
-			}
-
-			ar->ar_rq = rq;
-			spin_unlock_irqrestore(DRIVE_LOCK(drive), flags);
-
 			if (rq_data_dir(rq) == READ)
-				action = cdrom_start_read(drive, ar, block);
+				action = cdrom_start_read(drive, block);
 			else
 				action = cdrom_start_write(drive, rq);
 		}

-- 
Jens Axboe

