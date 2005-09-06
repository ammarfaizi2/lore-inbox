Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbVIFXmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVIFXmW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 19:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVIFXmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 19:42:22 -0400
Received: from serv01.siteground.net ([70.85.91.68]:35499 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751132AbVIFXmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 19:42:20 -0400
Date: Tue, 6 Sep 2005 16:42:20 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Alok Kataria <alokk@calsoftinc.com>
Subject: [patch 3/4] ide: Break ide_lock -- change controller drivers
Message-ID: <20050906234220.GD3642@localhost.localdomain>
References: <20050906233322.GA3642@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906233322.GA3642@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to make ide-host controllers use hwgroup lock where serialization with
hwgroup->lock is necessary


Signed-off-by: Vaibhav V. Nivargi <vaibhav.nivargi@gmail.com>
Signed-off-by: Alok N. Kataria <alokk@calsoftinc.com>
Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.13/drivers/ide/legacy/ht6560b.c
===================================================================
--- linux-2.6.13.orig/drivers/ide/legacy/ht6560b.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13/drivers/ide/legacy/ht6560b.c	2005-09-06 15:57:46.113541000 -0400
@@ -256,9 +256,11 @@
 {
 	unsigned long flags;
 	int t = HT_PREFETCH_MODE << 8;
-	
-	spin_lock_irqsave(&ide_lock, flags);
-	
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
+
+	spin_lock_irqsave(&hwgroup->lock, flags);
+	spin_lock(&ide_lock);
+
 	/*
 	 *  Prefetch mode and unmask irq seems to conflict
 	 */
@@ -270,9 +272,10 @@
 		drive->drive_data &= ~t;  /* disable prefetch mode */
 		drive->no_unmask = 0;
 	}
-	
-	spin_unlock_irqrestore(&ide_lock, flags);
-	
+
+	spin_unlock(&ide_lock);
+	spin_unlock_irqrestore(&hwgroup->lock, flags);
+
 #ifdef DEBUG
 	printk("ht6560b: drive %s prefetch mode %sabled\n", drive->name, (state ? "en" : "dis"));
 #endif
@@ -282,6 +285,7 @@
 {
 	unsigned long flags;
 	u8 timing;
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	
 	switch (pio) {
 	case 8:         /* set prefetch off */
@@ -291,14 +295,15 @@
 	}
 	
 	timing = ht_pio2timings(drive, pio);
-	
-	spin_lock_irqsave(&ide_lock, flags);
+
+	spin_lock_irqsave(&hwgroup->lock, flags);
+	spin_lock(&ide_lock);
 	
 	drive->drive_data &= 0xff00;
 	drive->drive_data |= timing;
 	
-	spin_unlock_irqrestore(&ide_lock, flags);
-	
+	spin_unlock(&ide_lock);
+	spin_unlock_irqrestore(&hwgroup->lock, flags);
 #ifdef DEBUG
 	printk("ht6560b: drive %s tuned to pio mode %#x timing=%#x\n", drive->name, pio, timing);
 #endif
Index: linux-2.6.13/drivers/ide/pci/cmd640.c
===================================================================
--- linux-2.6.13.orig/drivers/ide/pci/cmd640.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.13/drivers/ide/pci/cmd640.c	2005-09-06 15:50:35.330618750 -0400
@@ -442,11 +442,14 @@
 static void set_prefetch_mode (unsigned int index, int mode)
 {
 	ide_drive_t *drive = cmd_drives[index];
+	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	int reg = prefetch_regs[index];
 	u8 b;
 	unsigned long flags;
 
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&hwgroup->lock, flags);
+	spin_lock(&ide_lock);
+
 	b = __get_cmd640_reg(reg);
 	if (mode) {	/* want prefetch on? */
 #if CMD640_PREFETCH_MASKS
@@ -462,7 +465,9 @@
 		b |= prefetch_masks[index];	/* disable prefetch */
 	}
 	__put_cmd640_reg(reg, b);
-	spin_unlock_irqrestore(&ide_lock, flags);
+
+	spin_unlock(&ide_lock);
+	spin_unlock_irqrestore(&hwgroup->lock, flags);
 }
 
 /*
Index: linux-2.6.13/drivers/ide/pci/piix.c
===================================================================
--- linux-2.6.13.orig/drivers/ide/pci/piix.c	2005-09-06 15:49:48.271677750 -0400
+++ linux-2.6.13/drivers/ide/pci/piix.c	2005-09-06 15:56:55.982408000 -0400
@@ -215,6 +215,7 @@
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
+	ide_hwgroup_t *hwgroup  = HWGROUP(drive);
 	int is_slave		= (&hwif->drives[1] == drive);
 	int master_port		= hwif->channel ? 0x42 : 0x40;
 	int slave_port		= 0x44;
@@ -229,7 +230,8 @@
 			    { 2, 3 }, };
 
 	pio = ide_get_best_pio_mode(drive, pio, 5, NULL);
-	spin_lock_irqsave(&ide_lock, flags);
+	spin_lock_irqsave(&hwgroup->lock, flags);
+	spin_lock(&ide_lock);
 	pci_read_config_word(dev, master_port, &master_data);
 	if (is_slave) {
 		master_data = master_data | 0x4000;
@@ -249,7 +251,8 @@
 	pci_write_config_word(dev, master_port, master_data);
 	if (is_slave)
 		pci_write_config_byte(dev, slave_port, slave_data);
-	spin_unlock_irqrestore(&ide_lock, flags);
+	spin_unlock(&ide_lock);
+	spin_unlock_irqrestore(&hwgroup->lock, flags);
 }
 
 /**
