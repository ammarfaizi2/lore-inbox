Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161126AbWBNQbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbWBNQbs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161125AbWBNQbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:31:48 -0500
Received: from gate.crashing.org ([63.228.1.57]:26775 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1161122AbWBNQbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:31:47 -0500
Date: Tue, 14 Feb 2006 10:22:56 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
X-X-Sender: galak@gate.crashing.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Andrew Morton <akpm@osdl.org>
cc: linux-ide@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ide: Allow IDE interface to specify its not capable of 32-bit
 operations
Message-ID: <Pine.LNX.4.44.0602141022000.27351-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In some embedded systems the IDE hardware interface may only support 16-bit
or smaller accesses.  Allow the interface to specify if this is the case
and don't allow the drive or user to override the setting.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Acked-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
commit 1680d879c98c1680df6f331b486c1985103f379a
tree 4931bdac07f175bd3a6d417d37ccf1297b25ea02
parent 0a585bec4ddbef76ed4036388085c694ddd34494
author Kumar Gala <galak@kernel.crashing.org> Tue, 14 Feb 2006 10:29:58 -0600
committer Kumar Gala <galak@kernel.crashing.org> Tue, 14 Feb 2006 10:29:58 -0600

 drivers/ide/ide-disk.c  |    2 --
 drivers/ide/ide-probe.c |    9 +++++++++
 include/linux/ide.h     |    1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

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

