Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284987AbRLKO3O>; Tue, 11 Dec 2001 09:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285022AbRLKO3E>; Tue, 11 Dec 2001 09:29:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33547 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S284987AbRLKO2p>;
	Tue, 11 Dec 2001 09:28:45 -0500
Date: Tue, 11 Dec 2001 15:28:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Carl Ritson <critson@perlfu.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS: 2.5.1-pre8 - cdrecord + ide_scsi
Message-ID: <20011211142831.GV13498@suse.de>
In-Reply-To: <20011209135825.GN20061@suse.de> <Pine.LNX.4.33.0112091524320.1163-100000@eden.lincnet> <20011209153820.GE28729@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="yVhtmJPUSI46BTXb"
Content-Disposition: inline
In-Reply-To: <20011209153820.GE28729@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 09 2001, Jens Axboe wrote:
> > Ok works with DMA off, so I expect that this new error is due to my resent
> > memory upgrade (36 Hours ago) and the switch to using HIGHMEM(4GB)..
> > So am I to believe that DMA is a problem with HIGHMEM(4GB) enabled ?
> 
> No it's probably still an ide-scsi bug, I'm not suspecting your
> hardware. The reason I ask is because until -pre8 (since bio merge in
> -pre2), ide-scsi never used DMA even though it was set for the drive.

Ok finally had a chance to look some more at this -- it was a bit more
hairy than I had hoped. Please try this ide-scsi one liner, it should
cure it. (the bug fix is the bio->bi_vcnt = 1 change only)

-- 
Jens Axboe


--yVhtmJPUSI46BTXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ide-scsi-dma-1

--- /opt/kernel/linux-2.5.1-pre9/drivers/scsi/ide-scsi.c	Tue Dec 11 05:01:51 2001
+++ linux/drivers/scsi/ide-scsi.c	Tue Dec 11 09:24:14 2001
@@ -261,7 +261,7 @@
 	ide_drive_t *drive = hwgroup->drive;
 	idescsi_scsi_t *scsi = drive->driver_data;
 	struct request *rq = hwgroup->rq;
-	idescsi_pc_t *pc = (idescsi_pc_t *) rq->buffer;
+	idescsi_pc_t *pc = (idescsi_pc_t *) rq->special;
 	int log = test_bit(IDESCSI_LOG_CMD, &scsi->log);
 	struct Scsi_Host *host;
 	u8 *scsi_buf;
@@ -464,7 +464,7 @@
 #endif /* IDESCSI_DEBUG_LOG */
 
 	if (rq->flags & REQ_SPECIAL) {
-		return idescsi_issue_pc (drive, (idescsi_pc_t *) rq->buffer);
+		return idescsi_issue_pc (drive, (idescsi_pc_t *) rq->special);
 	}
 	blk_dump_rq_flags(rq, "ide-scsi: unsup command");
 	idescsi_end_request (0,HWGROUP (drive));
@@ -662,6 +662,7 @@
 	if ((first_bh = bhp = bh = bio_alloc(GFP_ATOMIC, 1)) == NULL)
 		goto abort;
 	bio_init(bh);
+	bh->bi_vcnt = 1;
 	while (--count) {
 		if ((bh = bio_alloc(GFP_ATOMIC, 1)) == NULL)
 			goto abort;
@@ -802,7 +803,7 @@
 	}
 
 	ide_init_drive_cmd (rq);
-	rq->buffer = (char *) pc;
+	rq->special = (char *) pc;
 	rq->bio = idescsi_dma_bio (drive, pc);
 	rq->flags = REQ_SPECIAL;
 	spin_unlock(&cmd->host->host_lock);

--yVhtmJPUSI46BTXb--
