Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264082AbUDRAC2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 20:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264086AbUDRABs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 20:01:48 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:16286 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264083AbUDRAAe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 20:00:34 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] IDE cleanups/fixups for 2.6.6-rc1 [1/3]
Date: Sun, 18 Apr 2004 01:51:03 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404180151.03327.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide.c: split init_hwif_default() out of init_hwif_data()

 linux-2.6.5-bk2-bzolnier/drivers/ide/ide.c |   60 +++++++++++++++++------------
 1 files changed, 37 insertions(+), 23 deletions(-)

diff -puN drivers/ide/ide.c~init_hwif_default drivers/ide/ide.c
--- linux-2.6.5-bk2/drivers/ide/ide.c~init_hwif_default	2004-04-17 23:48:05.000000000 +0200
+++ linux-2.6.5-bk2-bzolnier/drivers/ide/ide.c	2004-04-18 01:07:10.118672120 +0200
@@ -203,34 +203,23 @@ static void setup_driver_defaults(ide_dr
 /*
  * Do not even *think* about calling this!
  */
-static void init_hwif_data (unsigned int index)
+static void init_hwif_data(ide_hwif_t *hwif, unsigned int index)
 {
 	unsigned int unit;
-	hw_regs_t hw;
-	ide_hwif_t *hwif = &ide_hwifs[index];
 
 	/* bulk initialize hwif & drive info with zeros */
 	memset(hwif, 0, sizeof(ide_hwif_t));
-	memset(&hw, 0, sizeof(hw_regs_t));
 
 	/* fill in any non-zero initial values */
-	hwif->index     = index;
-	ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, &hwif->irq);
-	memcpy(&hwif->hw, &hw, sizeof(hw));
-	memcpy(hwif->io_ports, hw.io_ports, sizeof(hw.io_ports));
-	hwif->noprobe	= !hwif->io_ports[IDE_DATA_OFFSET];
-#ifdef CONFIG_BLK_DEV_HD
-	if (hwif->io_ports[IDE_DATA_OFFSET] == HD_DATA)
-		hwif->noprobe = 1; /* may be overridden by ide_setup() */
-#endif /* CONFIG_BLK_DEV_HD */
+	hwif->index	= index;
 	hwif->major	= ide_hwif_to_major[index];
+
 	hwif->name[0]	= 'i';
 	hwif->name[1]	= 'd';
 	hwif->name[2]	= 'e';
 	hwif->name[3]	= '0' + index;
-	hwif->bus_state = BUSSTATE_ON;
-	hwif->reset_poll= NULL;
-	hwif->pre_reset = NULL;
+
+	hwif->bus_state	= BUSSTATE_ON;
 
 	hwif->atapi_dma = 0;		/* disable all atapi dma */ 
 	hwif->ultra_mask = 0x80;	/* disable all ultra */
@@ -265,6 +254,24 @@ static void init_hwif_data (unsigned int
 	}
 }
 
+static void init_hwif_default(ide_hwif_t *hwif, unsigned int index)
+{
+	hw_regs_t hw;
+
+	memset(&hw, 0, sizeof(hw_regs_t));
+
+	ide_init_hwif_ports(&hw, ide_default_io_base(index), 0, &hwif->irq);
+
+	memcpy(&hwif->hw, &hw, sizeof(hw));
+	memcpy(hwif->io_ports, hw.io_ports, sizeof(hw.io_ports));
+
+	hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET];
+#ifdef CONFIG_BLK_DEV_HD
+	if (hwif->io_ports[IDE_DATA_OFFSET] == HD_DATA)
+		hwif->noprobe = 1;	/* may be overridden by ide_setup() */
+#endif
+}
+
 /*
  * init_ide_data() sets reasonable default values into all fields
  * of all instances of the hwifs and drives, but only on the first call.
@@ -285,6 +292,7 @@ static void init_hwif_data (unsigned int
 #define MAGIC_COOKIE 0x12345678
 static void __init init_ide_data (void)
 {
+	ide_hwif_t *hwif;
 	unsigned int index;
 	static unsigned long magic_cookie = MAGIC_COOKIE;
 
@@ -295,8 +303,11 @@ static void __init init_ide_data (void)
 	setup_driver_defaults(&idedefault_driver);
 
 	/* Initialise all interface structures */
-	for (index = 0; index < MAX_HWIFS; ++index)
-		init_hwif_data(index);
+	for (index = 0; index < MAX_HWIFS; ++index) {
+		hwif = &ide_hwifs[index];
+		init_hwif_data(hwif, index);
+		init_hwif_default(hwif, index);
+	}
 
 	/* Add default hw interfaces */
 	initializing = 1;
@@ -569,8 +580,6 @@ void ide_hwif_release_regions(ide_hwif_t
 
 EXPORT_SYMBOL(ide_hwif_release_regions);
 
-extern void init_hwif_data(unsigned int index);
-
 /**
  *	ide_unregister		-	free an ide interface
  *	@index: index of interface (will change soon to a pointer)
@@ -750,7 +759,10 @@ void ide_unregister (unsigned int index)
 	}
 
 	old_hwif			= *hwif;
-	init_hwif_data(index);	/* restore hwif data to pristine status */
+
+	init_hwif_data(hwif, index);	/* restore hwif data to pristine status */
+	init_hwif_default(hwif, index);
+
 	hwif->hwgroup			= old_hwif.hwgroup;
 
 	hwif->gendev.parent		= old_hwif.gendev.parent;
@@ -952,8 +964,10 @@ int ide_register_hw (hw_regs_t *hw, ide_
 found:
 	if (hwif->present)
 		ide_unregister(index);
-	else if (!hwif->hold)
-		init_hwif_data(index);
+	else if (!hwif->hold) {
+		init_hwif_data(hwif, index);
+		init_hwif_default(hwif, index);
+	}
 	if (hwif->present)
 		return -1;
 	memcpy(&hwif->hw, hw, sizeof(*hw));

_

