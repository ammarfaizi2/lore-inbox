Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314303AbSEBJm2>; Thu, 2 May 2002 05:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314318AbSEBJm1>; Thu, 2 May 2002 05:42:27 -0400
Received: from [195.63.194.11] ([195.63.194.11]:36105 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314303AbSEBJmY>; Thu, 2 May 2002 05:42:24 -0400
Message-ID: <3CD0FB4E.7070600@evision-ventures.com>
Date: Thu, 02 May 2002 10:39:42 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.12 IDE 49
In-Reply-To: <Pine.LNX.4.33.0203181243210.10517-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------060808070107040600020602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060808070107040600020602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Fix compilation of piix.c

- Revoke the PADAM_ prefix from sleep hwgroup member.

- Fix Pacific Digital host chip driver API.

- Fix Tekram host chip driver API.

- Fold hwif_unregister() directly in to channel code.

--------------060808070107040600020602
Content-Type: text/plain;
 name="ide-clean-49.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-49.diff"

diff -ur linux-2.5.12/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.12/drivers/ide/ide.c	2002-05-01 02:08:56.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-05-02 03:20:40.000000000 +0200
@@ -1187,12 +1188,12 @@
 {
 	if (timeout > WAIT_WORSTCASE)
 		timeout = WAIT_WORSTCASE;
-	drive->PADAM_sleep = timeout + jiffies;
+	drive->sleep = timeout + jiffies;
 }
 
 
 /*
- * Determine the longes sleep time for the devices in our hwgroup.
+ * Determine the longest sleep time for the devices at this channel.
  */
 static unsigned long longest_sleep(struct ata_channel *channel)
 {
@@ -1218,8 +1219,8 @@
 			/* This device is sleeping and waiting to be serviced
 			 * later than any other device we checked thus far.
 			 */
-			if (drive->PADAM_sleep && (!sleep || time_after(sleep, drive->PADAM_sleep)))
-				sleep = drive->PADAM_sleep;
+			if (drive->sleep && (!sleep || time_after(sleep, drive->sleep)))
+				sleep = drive->sleep;
 		}
 	}
 
@@ -1256,16 +1257,15 @@
 			if (list_empty(&drive->queue.queue_head))
 				continue;
 
-			/* This device still want's to remain idle.
+			/* This device still wants to remain idle.
 			 */
-			if (drive->PADAM_sleep && time_after(jiffies, drive->PADAM_sleep))
+			if (drive->sleep && time_after(jiffies, drive->sleep))
 				continue;
 
 			/* Take this device, if there is no device choosen thus far or
 			 * it's more urgent.
 			 */
-			if (!choice || (drive->PADAM_sleep && (!choice->PADAM_sleep || time_after(choice->PADAM_sleep, drive->PADAM_sleep))))
-			{
+			if (!choice || (drive->sleep && (!choice->sleep || time_after(choice->sleep, drive->sleep)))) {
 				if (!blk_queue_plugged(&drive->queue))
 					choice = drive;
 			}
@@ -1315,7 +1315,6 @@
  * Feed commands to a drive until it barfs.  Called with ide_lock/DRIVE_LOCK
  * held and busy channel.
  */
-
 static void queue_commands(struct ata_device *drive, int masked_irq)
 {
 	ide_hwgroup_t *hwgroup = drive->channel->hwgroup;
@@ -1325,7 +1324,7 @@
 		struct request *rq = NULL;
 
 		if (!test_bit(IDE_BUSY, &hwgroup->flags))
-			printk(KERN_ERR"%s: hwgroup not busy while queueing\n", drive->name);
+			printk(KERN_ERR"%s: error: not busy while queueing!\n", drive->name);
 
 		/* Abort early if we can't queue another command. for non
 		 * tcq, ata_can_queue is always 1 since we never get here
@@ -1337,7 +1336,7 @@
 			break;
 		}
 
-		drive->PADAM_sleep = 0;
+		drive->sleep = 0;
 
 		if (test_bit(IDE_DMA, &hwgroup->flags)) {
 			printk("ide_do_request: DMA in progress...\n");
@@ -1825,10 +1824,9 @@
  * completed. This is again intended for careful use by the ATAPI tape/cdrom
  * driver code.
  */
-int ide_do_drive_cmd(ide_drive_t *drive, struct request *rq, ide_action_t action)
+int ide_do_drive_cmd(struct ata_device *drive, struct request *rq, ide_action_t action)
 {
 	unsigned long flags;
-	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	unsigned int major = drive->channel->major;
 	request_queue_t *q = &drive->queue;
 	struct list_head *queue_head = &q->queue_head;
@@ -1846,7 +1844,7 @@
 	spin_lock_irqsave(&ide_lock, flags);
 	if (blk_queue_empty(&drive->queue) || action == ide_preempt) {
 		if (action == ide_preempt)
-			hwgroup->rq = NULL;
+			HWGROUP(drive)->rq = NULL;
 	} else {
 		if (action == ide_wait || action == ide_end)
 			queue_head = queue_head->prev;
@@ -1873,21 +1871,22 @@
  * usage == 1 (we need an open channel to use an ioctl :-), so this
  * is our limit.
  */
-int ide_revalidate_disk (kdev_t i_rdev)
+int ide_revalidate_disk(kdev_t i_rdev)
 {
-	ide_drive_t *drive;
-	ide_hwgroup_t *hwgroup;
+	struct ata_device *drive;
 	unsigned long flags;
 	int res;
 
 	if ((drive = get_info_ptr(i_rdev)) == NULL)
 		return -ENODEV;
-	hwgroup = HWGROUP(drive);
+
 	spin_lock_irqsave(&ide_lock, flags);
+
 	if (drive->busy || (drive->usage > 1)) {
 		spin_unlock_irqrestore(&ide_lock, flags);
 		return -EBUSY;
 	}
+
 	drive->busy = 1;
 	MOD_INC_USE_COUNT;
 	spin_unlock_irqrestore(&ide_lock, flags);
@@ -2032,71 +2031,18 @@
 };
 #endif
 
-/*
- * Note that we only release the standard ports, and do not even try to handle
- * any extra ports allocated for weird IDE interface chipsets.
- */
-static void hwif_unregister(struct ata_channel *ch)
-{
-	int i;
-	ide_hwgroup_t *hwgroup = ch->hwgroup;
-
-	/*
-	 * Free the irq if we were the only channel using it.
-	 */
-	int n = 0;
-
-	for (i = 0; i < MAX_HWIFS; ++i) {
-		struct ata_channel *tmp = &ide_hwifs[i];
-
-		if (!tmp->present)
-			continue;
-
-		if (tmp->irq == ch->irq)
-			++n;
-	}
-	if (n == 1)
-		free_irq(ch->irq, hwgroup);
-
-
-	if (ch->straight8) {
-		release_region(ch->io_ports[IDE_DATA_OFFSET], 8);
-	} else {
-		if (ch->io_ports[IDE_DATA_OFFSET])
-			release_region(ch->io_ports[IDE_DATA_OFFSET], 1);
-		if (ch->io_ports[IDE_ERROR_OFFSET])
-			release_region(ch->io_ports[IDE_ERROR_OFFSET], 1);
-		if (ch->io_ports[IDE_NSECTOR_OFFSET])
-			release_region(ch->io_ports[IDE_NSECTOR_OFFSET], 1);
-		if (ch->io_ports[IDE_SECTOR_OFFSET])
-			release_region(ch->io_ports[IDE_SECTOR_OFFSET], 1);
-		if (ch->io_ports[IDE_LCYL_OFFSET])
-			release_region(ch->io_ports[IDE_LCYL_OFFSET], 1);
-		if (ch->io_ports[IDE_HCYL_OFFSET])
-			release_region(ch->io_ports[IDE_HCYL_OFFSET], 1);
-		if (ch->io_ports[IDE_SELECT_OFFSET])
-			release_region(ch->io_ports[IDE_SELECT_OFFSET], 1);
-		if (ch->io_ports[IDE_STATUS_OFFSET])
-			release_region(ch->io_ports[IDE_STATUS_OFFSET], 1);
-	}
-	if (ch->io_ports[IDE_CONTROL_OFFSET])
-		release_region(ch->io_ports[IDE_CONTROL_OFFSET], 1);
-#if defined(CONFIG_AMIGA) || defined(CONFIG_MAC)
-	if (ch->io_ports[IDE_IRQ_OFFSET])
-		release_region(ch->io_ports[IDE_IRQ_OFFSET], 1);
-#endif
-}
-
 void ide_unregister(struct ata_channel *ch)
 {
 	struct gendisk *gd;
 	struct ata_device *d;
 	ide_hwgroup_t *hwgroup;
-	int unit, i;
+	int unit;
+	int i;
 	unsigned long flags;
 	unsigned int p, minor;
 	struct ata_channel old;
-	int n = 0;
+	int n_irq;
+	int n_ch;
 
 	spin_lock_irqsave(&ide_lock, flags);
 
@@ -2146,10 +2092,40 @@
 #endif
 	spin_lock_irqsave(&ide_lock, flags);
 
-	hwif_unregister(ch);
+	/*
+	 * Note that we only release the standard ports, and do not even try to
+	 * handle any extra ports allocated for weird IDE interface chipsets.
+	 */
+
+	if (ch->straight8) {
+		release_region(ch->io_ports[IDE_DATA_OFFSET], 8);
+	} else {
+		if (ch->io_ports[IDE_DATA_OFFSET])
+			release_region(ch->io_ports[IDE_DATA_OFFSET], 1);
+		if (ch->io_ports[IDE_ERROR_OFFSET])
+			release_region(ch->io_ports[IDE_ERROR_OFFSET], 1);
+		if (ch->io_ports[IDE_NSECTOR_OFFSET])
+			release_region(ch->io_ports[IDE_NSECTOR_OFFSET], 1);
+		if (ch->io_ports[IDE_SECTOR_OFFSET])
+			release_region(ch->io_ports[IDE_SECTOR_OFFSET], 1);
+		if (ch->io_ports[IDE_LCYL_OFFSET])
+			release_region(ch->io_ports[IDE_LCYL_OFFSET], 1);
+		if (ch->io_ports[IDE_HCYL_OFFSET])
+			release_region(ch->io_ports[IDE_HCYL_OFFSET], 1);
+		if (ch->io_ports[IDE_SELECT_OFFSET])
+			release_region(ch->io_ports[IDE_SELECT_OFFSET], 1);
+		if (ch->io_ports[IDE_STATUS_OFFSET])
+			release_region(ch->io_ports[IDE_STATUS_OFFSET], 1);
+	}
+	if (ch->io_ports[IDE_CONTROL_OFFSET])
+		release_region(ch->io_ports[IDE_CONTROL_OFFSET], 1);
+#if defined(CONFIG_AMIGA) || defined(CONFIG_MAC)
+	if (ch->io_ports[IDE_IRQ_OFFSET])
+		release_region(ch->io_ports[IDE_IRQ_OFFSET], 1);
+#endif
 
 	/*
-	 * Remove us from the hwgroup
+	 * Remove us from the hwgroup.
 	 */
 
 	hwgroup = ch->hwgroup;
@@ -2177,20 +2153,30 @@
 	if (d->present)
 		hwgroup->XXX_drive = d;
 
-	/* Free the hwgroup if we were the only member.
+
+	/*
+	 * Free the irq if we were the only channel using it.
+	 *
+	 * Free the hwgroup if we were the only member.
 	 */
-	n = 0;
+	n_irq = n_ch = 0;
 	for (i = 0; i < MAX_HWIFS; ++i) {
 		struct ata_channel *tmp = &ide_hwifs[i];
 
 		if (!tmp->present)
 			continue;
 
+		if (tmp->irq == ch->irq)
+			++n_irq;
 		if (tmp->hwgroup == ch->hwgroup)
-			++n;
+			++n_ch;
 	}
-	if (n == 1)
+	if (n_irq == 1)
+		free_irq(ch->irq, ch->hwgroup);
+	if (n_ch == 1) {
 		kfree(ch->hwgroup);
+		ch->hwgroup = NULL;
+	}
 
 #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
 	ide_release_dma(ch);
diff -ur linux-2.5.12/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.12/drivers/ide/ide-dma.c	2002-05-01 02:08:49.000000000 +0200
+++ linux/drivers/ide/ide-dma.c	2002-05-02 01:18:54.000000000 +0200
@@ -270,16 +270,15 @@
 }
 
 /*
- * ide_build_dmatable() prepares a dma request.
- * Returns 0 if all went okay, returns 1 otherwise.
- * May also be invoked from trm290.c
+ * This prepares a dma request.  Returns 0 if all went okay, returns 1
+ * otherwise.  May also be invoked from trm290.c
  */
-int ide_build_dmatable (ide_drive_t *drive, ide_dma_action_t func)
+int ide_build_dmatable(struct ata_device *drive, ide_dma_action_t func)
 {
-	struct ata_channel *hwif = drive->channel;
-	unsigned int *table = hwif->dmatable_cpu;
+	struct ata_channel *ch = drive->channel;
+	unsigned int *table = ch->dmatable_cpu;
 #ifdef CONFIG_BLK_DEV_TRM290
-	unsigned int is_trm290_chipset = (hwif->chipset == ide_trm290);
+	unsigned int is_trm290_chipset = (ch->chipset == ide_trm290);
 #else
 	const int is_trm290_chipset = 0;
 #endif
@@ -287,11 +286,11 @@
 	int i;
 	struct scatterlist *sg;
 
-	hwif->sg_nents = i = build_sglist(hwif, HWGROUP(drive)->rq);
+	ch->sg_nents = i = build_sglist(ch, HWGROUP(drive)->rq);
 	if (!i)
 		return 0;
 
-	sg = hwif->sg_table;
+	sg = ch->sg_table;
 	while (i) {
 		u32 cur_addr;
 		u32 cur_len;
@@ -309,8 +308,8 @@
 			u32 xcount, bcount = 0x10000 - (cur_addr & 0xffff);
 
 			if (count++ >= PRD_ENTRIES) {
-				printk("ide-dma: req %p\n", HWGROUP(drive)->rq);
-				printk("count %d, sg_nents %d, cur_len %d, cur_addr %u\n", count, hwif->sg_nents, cur_len, cur_addr);
+				printk("ide-dma: count %d, sg_nents %d, cur_len %d, cur_addr %u\n",
+						count, ch->sg_nents, cur_len, cur_addr);
 				BUG();
 			}
 
@@ -328,9 +327,9 @@
 			 * the 64KB entry into two 32KB entries instead.
 			 */
 				if (count++ >= PRD_ENTRIES) {
-					pci_unmap_sg(hwif->pci_dev, sg,
-						     hwif->sg_nents,
-						     hwif->sg_dma_direction);
+					pci_unmap_sg(ch->pci_dev, sg,
+						     ch->sg_nents,
+						     ch->sg_dma_direction);
 					return 0;
 				}
 
diff -ur linux-2.5.12/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.12/drivers/ide/ide-probe.c	2002-05-01 02:08:44.000000000 +0200
+++ linux/drivers/ide/ide-probe.c	2002-05-02 03:15:06.000000000 +0200
@@ -745,7 +745,7 @@
 #else
 	printk("%s at %p on irq 0x%08x", ch->name,
 		ch->io_ports[IDE_DATA_OFFSET], ch->irq);
-#endif /* __mc68000__ && CONFIG_APUS */
+#endif
 	if (match)
 		printk(" (%sed with %s)",
 			ch->sharing_irq ? "shar" : "serializ", match->name);
diff -ur linux-2.5.12/drivers/ide/pdcadma.c linux/drivers/ide/pdcadma.c
--- linux-2.5.12/drivers/ide/pdcadma.c	2002-05-01 02:08:50.000000000 +0200
+++ linux/drivers/ide/pdcadma.c	2002-05-02 00:53:47.000000000 +0200
@@ -47,18 +47,18 @@
 
 	return p-buffer;	/* => must be less than 4k! */
 }
-#endif  /* defined(DISPLAY_PDCADMA_TIMINGS) && defined(CONFIG_PROC_FS) */
+#endif
 
 byte pdcadma_proc = 0;
 
 extern char *ide_xfer_verbose (byte xfer_rate);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
+
 /*
- * pdcadma_dmaproc() initiates/aborts (U)DMA read/write operations on a drive.
+ * This initiates/aborts (U)DMA read/write operations on a drive.
  */
-
-int pdcadma_dmaproc (ide_dma_action_t func, ide_drive_t *drive)
+int pdcadma_dmaproc(ide_dma_action_t func, struct ata_device *drive, struct request *rq)
 {
 	switch (func) {
 		case ide_dma_check:
@@ -66,9 +66,9 @@
 		default:
 			break;
 	}
-	return ide_dmaproc(func, drive);	/* use standard DMA stuff */
+	return ide_dmaproc(func, drive, rq);	/* use standard DMA stuff */
 }
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 
 unsigned int __init pci_init_pdcadma(struct pci_dev *dev)
 {
@@ -76,9 +76,9 @@
 	if (!pdcadma_proc) {
 		pdcadma_proc = 1;
 		bmide_dev = dev;
-		pdcadma_display_info = &pdcadma_get_info;
+		pdcadma_display_info = pdcadma_get_info;
 	}
-#endif /* DISPLAY_PDCADMA_TIMINGS && CONFIG_PROC_FS */
+#endif
 	return 0;
 }
 
diff -ur linux-2.5.12/drivers/ide/piix.c linux/drivers/ide/piix.c
--- linux-2.5.12/drivers/ide/piix.c	2002-05-01 02:08:55.000000000 +0200
+++ linux/drivers/ide/piix.c	2002-05-01 23:06:04.000000000 +0200
@@ -471,7 +471,9 @@
 				break;
 			}
 
+#ifndef CONFIG_BLK_DEV_PIIX_TRY133
 		case PIIX_UDMA_100:
+#endif
 		case PIIX_UDMA_133:
 			pci_read_config_dword(dev, PIIX_IDECFG, &u);
 			piix_80w = ((u & 0x30) ? 1 : 0) | ((u & 0xc0) ? 2 : 0);
@@ -484,7 +486,7 @@
 
 	if (piix_config->flags & PIIX_PINGPONG) {
 		pci_read_config_dword(dev, PIIX_IDECFG, &u);
-		u |= 0x400; 
+		u |= 0x400;
 		pci_write_config_dword(dev, PIIX_IDECFG, u);
 	}
 
diff -ur linux-2.5.12/drivers/ide/trm290.c linux/drivers/ide/trm290.c
--- linux-2.5.12/drivers/ide/trm290.c	2002-05-01 02:08:49.000000000 +0200
+++ linux/drivers/ide/trm290.c	2002-05-02 00:56:18.000000000 +0200
@@ -173,7 +173,7 @@
 }
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-static int trm290_dmaproc (ide_dma_action_t func, ide_drive_t *drive)
+static int trm290_dmaproc (ide_dma_action_t func, struct ata_device *drive, struct request *rq)
 {
 	struct ata_channel *hwif = drive->channel;
 	unsigned int count, reading = 2, writing = 0;
@@ -206,12 +206,12 @@
 		case ide_dma_test_irq:
 			return (inw(hwif->dma_base+2) == 0x00ff);
 		default:
-			return ide_dmaproc(func, drive);
+			return ide_dmaproc(func, drive, rq);
 	}
 	trm290_prepare_drive(drive, 0);	/* select PIO xfer */
 	return 1;
 }
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+#endif
 
 /*
  * Invoked from ide-dma.c at boot time.
@@ -263,8 +263,8 @@
 	ide_setup_dma(hwif, (hwif->config_data + 4) ^ (hwif->unit ? 0x0080 : 0x0000), 3);
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
-	hwif->dmaproc = &trm290_dmaproc;
-#endif /* CONFIG_BLK_DEV_IDEDMA */
+	hwif->udma = trm290_dmaproc;
+#endif
 
 	hwif->selectproc = &trm290_selectproc;
 	hwif->autodma = 0;				/* play it safe for now */
diff -ur linux-2.5.12/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.12/include/linux/ide.h	2002-05-01 02:08:49.000000000 +0200
+++ linux/include/linux/ide.h	2002-05-02 04:18:23.000000000 +0200
@@ -283,10 +283,8 @@
 	 */
 	request_queue_t	queue;	/* per device request queue */
 
-	/* Those are directly injected jiffie values. They should go away and
-	 * we should use generic timers instead!!!
-	 */
-	unsigned long PADAM_sleep;	/* sleep until this time */
+
+	unsigned long sleep;	/* sleep until this time */
 
 	/* Flags requesting/indicating one of the following special commands
 	 * executed on the request queue.

--------------060808070107040600020602--

