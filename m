Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbUCGNtU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 08:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbUCGNtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 08:49:19 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:470 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261982AbUCGNtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 08:49:07 -0500
Date: Sun, 7 Mar 2004 08:49:05 -0500
From: Willem Riede <wrlk@riede.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] remove dead ATAPI multi-lun support (used for ide-scsi)
Message-ID: <20040307134905.GK29509@serve.riede.org>
Reply-To: wrlk@riede.org
References: <200402202247.02345.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200402202247.02345.bzolnier@elka.pw.edu.pl> (from B.Zolnierkiewicz@elka.pw.edu.pl on Fri, Feb 20, 2004 at 16:47:02 -0500)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.02.20 16:47, Bartlomiej Zolnierkiewicz wrote:
> 
> [IDE] remove dead ATAPI multi-lun support (used for ide-scsi)
> 
> ChangeSet@1.889.69.2 03-01-23 14:51:03-05:00  adam@yggdrasil.com
> |  The following changes to ide-scsi.c are a recovery of the
> | changes that I had in ide-scsi.c in the stock kernel's before
> | Martin Dalecki's IDE tree was reverted and a few other changes.
> ...
> 
> broke it.
> 
> Before this change drive->id->last_id & 0x7 was used as shost->max_lun
> and "hdXlun=" kernel parameter could be used to override it.
> 
> It was needed probably only for some rare ATAPI PD-CD drives
> (http://www.geocrawler.com/archives/3/58/1999/11/50/2877161/).
> 
> However it was far from optimal:
> - people played with "hdXlun=" and then complained about multiple instances
>   of the same device (most ATAPI drives respond to each LUN)
> - probably some devices return 7 not 0 in id->last_id (=> 7 x same device)
> 
> This patch cleans things up, multi-lun will be fixed if needed in ide-scsi.
> I think that this may work but can't verify it:
> 
> 	if (id->last_lun && id->last_lun != 7)
> 		shost->max_lun = id->last_lun + 1;
> 	else
> 		shost->max_lun = 1;

I have verified that this works with my PD/CD drive, the patch to ide-scsi.c
that I suggest (against linux-2.6.4-rc1-mm2) is below.

Thanks, Willem Riede.

--- m0/drivers/scsi/ide-scsi.c	2004-03-05 19:54:33.000000000 -0500
+++ m1/drivers/scsi/ide-scsi.c	2004-03-06 14:49:47.000000000 -0500
@@ -1148,7 +1148,16 @@
 		return 1;
 
 	host->max_id = 1;
-	host->max_lun = 1;
+
+#if IDESCSI_DEBUG_LOG
+	if (drive->id->last_lun)
+		printk(KERN_NOTICE "%s: id->last_lun=%u\n", drive->name, drive->id->last_lun);
+#endif
+	if ((drive->id->last_lun & 0x7) != 7)
+		host->max_lun = (drive->id->last_lun & 0x7) + 1;
+	else
+		host->max_lun = 1;
+
 	drive->driver_data = host;
 	idescsi = scsihost_to_idescsi(host);
 	idescsi->drive = drive;

