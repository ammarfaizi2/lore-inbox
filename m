Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265764AbUATU6Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 15:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUATU6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 15:58:16 -0500
Received: from mail3-126.ewetel.de ([212.6.122.126]:45786 "EHLO
	mail3.ewetel.de") by vger.kernel.org with ESMTP id S265764AbUATU6N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 15:58:13 -0500
Date: Tue, 20 Jan 2004 21:58:00 +0100 (CET)
From: Pascal Schmidt <der.eremit@email.de>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Jens Axboe <axboe@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix for ide-scsi crash
In-Reply-To: <20040120210123.A1528@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.44.0401202154560.2427-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jan 2004, Andries Brouwer wrote:

> Yes, they are meaningless.
> The code that used them was removed in 2.5.1.

Then perhaps it would be a good idea to apply the following cleanup
patch:

--- ide-cd.c.orig	Tue Jan 20 21:47:30 2004
+++ ide-cd.c	Tue Jan 20 21:52:34 2004
@@ -1236,13 +1236,7 @@ static int cdrom_read_from_buffer (ide_d
 static ide_startstop_t cdrom_start_read_continuation (ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
-	int nsect, sector, nframes, frame, nskip;
-
-	/* Number of sectors to transfer. */
-	nsect = rq->nr_sectors;
-
-	/* Starting sector. */
-	sector = rq->sector;
+	int nskip;
 
 	/* If the requested sector doesn't start on a cdrom block boundary,
 	   we must adjust the start of the transfer so that it does,
@@ -1251,7 +1245,7 @@ static ide_startstop_t cdrom_start_read_
 	   of the buffer, it will mean that we're to skip a number
 	   of sectors equal to the amount by which CURRENT_NR_SECTORS
 	   is larger than the buffer size. */
-	nskip = (sector % SECTORS_PER_FRAME);
+	nskip = (rq->sector % SECTORS_PER_FRAME);
 	if (nskip > 0) {
 		/* Sanity check... */
 		if (rq->current_nr_sectors != bio_cur_sectors(rq->bio) &&
@@ -1261,21 +1255,9 @@ static ide_startstop_t cdrom_start_read_
 			cdrom_end_request(drive, 0);
 			return ide_stopped;
 		}
-		sector -= nskip;
-		nsect += nskip;
 		rq->current_nr_sectors += nskip;
 	}
 
-	/* Convert from sectors to cdrom blocks, rounding up the transfer
-	   length if needed. */
-	nframes = (nsect + SECTORS_PER_FRAME-1) / SECTORS_PER_FRAME;
-	frame = sector / SECTORS_PER_FRAME;
-
-	/* Largest number of frames was can transfer at once is 64k-1. For
-	   some drives we need to limit this even more. */
-	nframes = MIN (nframes, (CDROM_CONFIG_FLAGS (drive)->limit_nframes) ?
-		(65534 / CD_FRAMESIZE) : 65535);
-
 	/* Set up the command */
 	rq->timeout = WAIT_CMD;
 

-- 
Ciao,
Pascal

