Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161115AbWBNQQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161115AbWBNQQf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161113AbWBNQQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:16:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:9367 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161110AbWBNQQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:16:34 -0500
Date: Tue, 14 Feb 2006 10:07:47 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
cc: linux-ide@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Compact Flash True IDE Mode Driver
In-Reply-To: <58cb370e0602140757r5b265f25wc9f1f2e44d5f075c@mail.gmail.com>
Message-ID: <Pine.LNX.4.44.0602141007090.27351-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If this looks good, I'll send a more official patch with an signed-off-by.

- k

diff --git a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
index 09086b8..359f659 100644
--- a/drivers/ide/ide-disk.c
+++ b/drivers/ide/ide-disk.c
@@ -977,8 +977,6 @@ static void idedisk_setup (ide_drive_t *
 		ide_dma_verbose(drive);
 	printk("\n");
 
-	drive->no_io_32bit = id->dword_io ? 1 : 0;
-
 	/* write cache enabled? */
 	if ((id->csfo & 1) || (id->cfs_enable_1 & (1 << 5)))
 		drive->wcache = 1;
diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 427d1c2..1b7b4c5 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -858,6 +858,15 @@ static void probe_hwif(ide_hwif_t *hwif)
 			}
 		}
 	}
+
+	for (unit = 0; unit < MAX_DRIVES; ++unit) {
+		ide_drive_t *drive = &hwif->drives[unit];
+
+		if (hwif->no_io_32bit)
+			drive->no_io_32bit = 1;
+		else
+			drive->no_io_32bit = drive->id->dword_io ? 1 : 0;
+	}
 }
 
 static int hwif_init(ide_hwif_t *hwif);
diff --git a/include/linux/ide.h b/include/linux/ide.h
index a7fc4cc..8d2db41 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -792,6 +792,7 @@ typedef struct hwif_s {
 	unsigned	no_dsc     : 1;	/* 0 default, 1 dsc_overlap disabled */
 	unsigned	auto_poll  : 1; /* supports nop auto-poll */
 	unsigned	sg_mapped  : 1;	/* sg_table and sg_nents are ready */
+	unsigned	no_io_32bit : 1; /* 1 = can not do 32-bit IO ops */
 
 	struct device	gendev;
 	struct completion gendev_rel_comp; /* To deal with device release() */

