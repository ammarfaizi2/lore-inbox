Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbTEWIYN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 04:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTEWIYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 04:24:13 -0400
Received: from griffon.mipsys.com ([217.167.51.129]:52934 "EHLO gaston")
	by vger.kernel.org with ESMTP id S263928AbTEWIYJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 04:24:09 -0400
Subject: [PATCH] Update ide/ppc/pmac.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Paul Mackerras <paulus@samba.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053679009.1160.95.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 May 2003 10:36:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo !

This patch against 2.4.21-rc3 will update drivers/ide/ppc/pmac.c to the
latest version in my 2.4.21 tree. It makes use of the "hold" field you
added to hwif in -rc3 to avoid a problem with ide-cs, fix the DMA
routines for proper usage of the new ide_exectute_command(), and remove
a now useless delay (since ide-probe.c now contains the wait for BSY,
the delay is no longer useful), and finally, allow the new "Kauai" 
ATA/100 interfaces to be probed before the old ones so the internal HD
of those machines becomes hda and not hde

Please apply before your release 2.4.21 final,

Ben.

===== drivers/ide/Config.in 1.27 vs edited =====
--- 1.27/drivers/ide/Config.in	Wed May  7 16:37:33 2003
+++ edited/drivers/ide/Config.in	Fri May 23 08:51:27 2003
@@ -82,6 +82,7 @@
       fi
       if [ "$CONFIG_ALL_PPC" = "y" ]; then
 	 bool '    Builtin PowerMac IDE support' CONFIG_BLK_DEV_IDE_PMAC
+	 dep_bool '      Probe internal Kauai ATA/100 first' CONFIG_BLK_DEV_IDE_PMAC_ATA100FIRST $CONFIG_BLK_DEV_IDE_PMAC
 	 dep_bool '      PowerMac IDE DMA support' CONFIG_BLK_DEV_IDEDMA_PMAC $CONFIG_BLK_DEV_IDE_PMAC
 	 dep_bool '        Use DMA by default' CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO $CONFIG_BLK_DEV_IDEDMA_PMAC
 	 if [ "$CONFIG_BLK_DEV_IDE_PMAC" = "y" ]; then
===== drivers/ide/ppc/pmac.c 1.13 vs edited =====
--- 1.13/drivers/ide/ppc/pmac.c	Sat Apr  5 16:56:00 2003
+++ edited/drivers/ide/ppc/pmac.c	Fri May 23 08:39:21 2003
@@ -48,7 +48,7 @@
 extern void ide_do_request(ide_hwgroup_t *hwgroup, int masked_irq);
 
 #undef IDE_PMAC_DEBUG
-#define DMA_WAIT_TIMEOUT	500
+#define DMA_WAIT_TIMEOUT	100
 
 typedef struct pmac_ide_hwif {
 	ide_ioreg_t			regbase;
@@ -940,10 +940,10 @@
 {
 	struct device_node *np;
 	int i;
-	struct device_node *atas;
-	struct device_node *p, **pp, *removables, **rp;
+	struct device_node *atas = NULL;
+	struct device_node *p, *nextp, **pp, *removables, **rp;
 	unsigned long base, regbase;
-	int irq, big_delay;
+	int irq;
 	ide_hwif_t *hwif;
 
 	if (_machine != _MACH_Pmac)
@@ -959,19 +959,29 @@
 		p = find_type_devices("ata");
 	/* Move removable devices such as the media-bay CDROM
 	   on the PB3400 to the end of the list. */
-	for (; p != NULL; p = p->next) {
+	for (; p != NULL; p = nextp) {
+		nextp = p->next;
 		if (p->parent && p->parent->type
 		    && strcasecmp(p->parent->type, "media-bay") == 0) {
 			*rp = p;
 			rp = &p->next;
-		} else {
+		}
+#ifdef CONFIG_BLK_DEV_IDE_PMAC_ATA100FIRST
+		/* Move Kauai ATA/100 if it exist to first postition in list */
+		else if (device_is_compatible(p, "kauai-ata")) {
+			p->next = atas;
+			if (pp == &atas)
+				pp = &p->next;
+			atas = p;
+		}
+#endif /* CONFIG_BLK_DEV_IDE_PMAC_ATA100FIRST */
+		else {
 			*pp = p;
 			pp = &p->next;
 		}
 	}
 	*rp = NULL;
 	*pp = removables;
-	big_delay = 0;
 
 	for (i = 0, np = atas; i < MAX_HWIFS && np != NULL; np = np->next) {
 		struct device_node *tp;
@@ -1128,7 +1138,6 @@
 			ppc_md.feature_call(PMAC_FTR_IDE_ENABLE, np, pmif->aapl_bus_id, 1);
 			mdelay(10);
 			ppc_md.feature_call(PMAC_FTR_IDE_RESET, np, pmif->aapl_bus_id, 0);
-			big_delay = 1;
 		}
 
 		hwif = &ide_hwifs[i];
@@ -1142,6 +1151,7 @@
 		memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
 		hwif->chipset = ide_pmac;
 		hwif->noprobe = !hwif->io_ports[IDE_DATA_OFFSET] || in_bay;
+		hwif->hold = in_bay;
 		hwif->udma_four = pmif->cable_80;
 		hwif->pci_dev = pdev;
 		hwif->drives[0].unmask = 1;
@@ -1193,9 +1203,6 @@
 
 	if (pmac_ide_count == 0)
 		return;
-		
-	if (big_delay)
-		mdelay(IDE_WAKEUP_DELAY_MS);
 
 #ifdef CONFIG_PMAC_PBOOK
 	pmu_register_sleep_notifier(&idepmac_sleep_notifier);
@@ -1573,10 +1580,6 @@
 	drive->waiting_for_dma = 1;	
 	if (drive->media != ide_disk)
 		return 0;
-	/* paranoia check */
-	if (HWGROUP(drive)->handler != NULL)	/* paranoia check */
-		BUG();
-	ide_set_handler(drive, &ide_dma_intr, 2*WAIT_CMD, NULL);
 	/*
 	 * FIX ME to use only ACB ide_task_t args Struct
 	 */
@@ -1592,8 +1595,8 @@
 		command = args->tfRegister[IDE_COMMAND_OFFSET];
 	}
 #endif
-	/* issue cmd to drive */
-	hwif->OUTB(command, IDE_COMMAND_REG);
+	 /* issue cmd to drive */
+        ide_execute_command(drive, command, &ide_dma_intr, 2*WAIT_CMD, NULL);
 
 	return pmac_ide_dma_begin(drive);
 }
@@ -1630,10 +1633,6 @@
 	if (drive->media != ide_disk)
 		return 0;
 
-	/* paranoia check */
-	if (HWGROUP(drive)->handler != NULL)	/* paranoia check */
-		BUG();
-	ide_set_handler(drive, &ide_dma_intr, 2*WAIT_CMD, NULL);
 	/*
 	 * FIX ME to use only ACB ide_task_t args Struct
 	 */
@@ -1650,7 +1649,7 @@
 	}
 #endif
 	/* issue cmd to drive */
-	hwif->OUTB(command, IDE_COMMAND_REG);
+        ide_execute_command(drive, command, &ide_dma_intr, 2*WAIT_CMD, NULL);
 
 	return pmac_ide_dma_begin(drive);
 }
@@ -1693,7 +1692,11 @@
 	writel(((RUN|WAKE|DEAD) << 16), &dma->control);
 	pmac_ide_destroy_dmatable(drive);
 	/* verify good dma status */
-	return (dstat & (RUN|DEAD|ACTIVE)) != RUN;
+	if ((dstat & (RUN|DEAD|ACTIVE)) == RUN)	
+		return 0;
+	printk(KERN_WARNING "%s: bad status at DMA end, dstat=%x\n",
+		drive->name, dstat);
+	return 1;
 }
 
 static int __pmac
@@ -1735,18 +1738,18 @@
 	if (!(status & ACTIVE))
 		return 1;
 	if (!drive->waiting_for_dma)
-		printk(KERN_WARNING "ide%d, ide_dma_test_irq \
-			called while not waiting\n", HWIF(drive)->index);
+		printk(KERN_WARNING "%s: ide_dma_test_irq \
+			called while not waiting\n", drive->name);
 
 	/* If dbdma didn't execute the STOP command yet, the
 	 * active bit is still set */
 	drive->waiting_for_dma++;
 	if (drive->waiting_for_dma >= DMA_WAIT_TIMEOUT) {
-		printk(KERN_WARNING "ide%d, timeout waiting \
-			for dbdma command stop\n", HWIF(drive)->index);
+		printk(KERN_WARNING "%s: timeout waiting \
+			for dbdma command stop\n", drive->name);
 		return 1;
 	}
-	udelay(1);
+	udelay(10);
 	return 0;
 }
 
@@ -1774,7 +1777,7 @@
 	dma = pmif->dma_regs;
 
 	status = readl(&dma->status);
-	printk(KERN_ERR "ide-pmac lost interrupt, dma status: %lx\n", status);
+	printk(KERN_ERR "%s: lost interrupt, dma status: %lx\n", drive->name, status);
 	return 0;
 }
 


