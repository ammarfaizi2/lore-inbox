Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbTFWVcb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 17:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbTFWVca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 17:32:30 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:64664 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266195AbTFWVcM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 17:32:12 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] proper allocation of hwif->io_ports resources
Date: Mon, 23 Jun 2003 23:45:43 +0200
User-Agent: KMail/1.4.1
Cc: Rusty Russell <rusty@rustcorp.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200306232345.43959.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch gets rid of check_region/check_mem_region from ide-probe.c.
I will push to Linus if there are no objections...
--
Bartlomiej

[ide] proper allocation of hwif->io_ports resources

 drivers/ide/ide-probe.c |   81 +++-------------------------------------------
 drivers/ide/ide.c       |   84 +++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/ide.h     |    3 +
 3 files changed, 88 insertions(+), 80 deletions(-)

diff -puN drivers/ide/ide-probe.c~ide-hwif-res-alloc-fix drivers/ide/ide-probe.c
--- linux-2.5.73/drivers/ide/ide-probe.c~ide-hwif-res-alloc-fix	Mon Jun 23 20:16:33 2003
+++ linux-2.5.73-root/drivers/ide/ide-probe.c	Mon Jun 23 20:16:34 2003
@@ -634,64 +634,8 @@ static inline u8 probe_for_drive (ide_dr
 	return drive->present;
 }
 
-static int hwif_check_region(ide_hwif_t *hwif, unsigned long addr, int num)
-{
-	int err;
-	
-	if(hwif->mmio)
-		err = check_mem_region(addr, num);
-	else
-		err = check_region(addr, num);
-		
-	if(err)
-	{
-		printk("%s: %s resource 0x%lX-0x%lX not free.\n",
-			hwif->name, hwif->mmio?"MMIO":"I/O", addr, addr+num-1);
-	}
-	return err;
-}
-	
-
-/**
- *	hwif_check_regions	-	check resources for IDE
- *	@hwif: interface to use
- *
- *	Checks if all the needed resources for an interface are free
- *	providing the interface is PIO. Right now core IDE code does
- *	this work which is deeply wrong. MMIO leaves it to the controller
- *	driver, PIO will migrate this way over time
- */
- 
-static int hwif_check_regions (ide_hwif_t *hwif)
-{
-	u32 i		= 0;
-	int addr_errs	= 0;
-
-	if (hwif->mmio == 2)
-		return 0;
-	addr_errs  = hwif_check_region(hwif, hwif->io_ports[IDE_DATA_OFFSET], 1);
-	for (i = IDE_ERROR_OFFSET; i <= IDE_STATUS_OFFSET; i++)
-		addr_errs += hwif_check_region(hwif, hwif->io_ports[i], 1);
-	if (hwif->io_ports[IDE_CONTROL_OFFSET])
-		addr_errs += hwif_check_region(hwif, hwif->io_ports[IDE_CONTROL_OFFSET], 1);
-#if defined(CONFIG_AMIGA) || defined(CONFIG_MAC)
-	if (hwif->io_ports[IDE_IRQ_OFFSET])
-		addr_errs += hwif_check_region(hwif, hwif->io_ports[IDE_IRQ_OFFSET], 1);
-#endif /* (CONFIG_AMIGA) || (CONFIG_MAC) */
-	/* If any errors are return, we drop the hwif interface. */
-	hwif->straight8 = 0;
-	return(addr_errs);
-}
-
-//EXPORT_SYMBOL(hwif_check_regions);
-
-#define hwif_request_region(addr, num, name)	\
-	((hwif->mmio) ? request_mem_region((addr),(num),(name)) : request_region((addr),(num),(name)))
-
 static void hwif_register (ide_hwif_t *hwif)
 {
-	u32 i = 0;
-
 	/* register with global device tree */
 	strlcpy(hwif->gendev.bus_id,hwif->name,BUS_ID_SIZE);
 	snprintf(hwif->gendev.name,DEVICE_NAME_SIZE,"IDE Controller");
@@ -701,24 +645,6 @@ static void hwif_register (ide_hwif_t *h
 	else
 		hwif->gendev.parent = NULL; /* Would like to do = &device_legacy */
 	device_register(&hwif->gendev);
-
-	if (hwif->mmio == 2)
-		return;
-	if (hwif->io_ports[IDE_CONTROL_OFFSET])
-		hwif_request_region(hwif->io_ports[IDE_CONTROL_OFFSET], 1, hwif->name);
-#if defined(CONFIG_AMIGA) || defined(CONFIG_MAC)
-	if (hwif->io_ports[IDE_IRQ_OFFSET])
-		hwif_request_region(hwif->io_ports[IDE_IRQ_OFFSET], 1, hwif->name);
-#endif /* (CONFIG_AMIGA) || (CONFIG_MAC) */
-	if (((unsigned long)hwif->io_ports[IDE_DATA_OFFSET] | 7) ==
-	    ((unsigned long)hwif->io_ports[IDE_STATUS_OFFSET])) {
-		hwif_request_region(hwif->io_ports[IDE_DATA_OFFSET], 8, hwif->name);
-		hwif->straight8 = 1;
-		return;
-	}
-
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++)
-		hwif_request_region(hwif->io_ports[i], 1, hwif->name);
 }
 
 //EXPORT_SYMBOL(hwif_register);
@@ -778,7 +704,7 @@ void probe_hwif (ide_hwif_t *hwif)
 #ifdef CONFIG_BLK_DEV_PDC4030
 	    (hwif->chipset != ide_pdc4030 || hwif->channel == 0) &&
 #endif /* CONFIG_BLK_DEV_PDC4030 */
-	    (hwif_check_regions(hwif))) {
+	    (ide_hwif_request_regions(hwif))) {
 		u16 msgout = 0;
 		for (unit = 0; unit < MAX_DRIVES; ++unit) {
 			ide_drive_t *drive = &hwif->drives[unit];
@@ -869,6 +795,11 @@ void probe_hwif (ide_hwif_t *hwif)
 	if (irqd)
 		enable_irq(irqd);
 
+	if (!hwif->present) {
+		ide_hwif_release_regions(hwif);
+		return;
+	}
+
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
 		int enable_dma = 1;
diff -puN drivers/ide/ide.c~ide-hwif-res-alloc-fix drivers/ide/ide.c
--- linux-2.5.73/drivers/ide/ide.c~ide-hwif-res-alloc-fix	Mon Jun 23 20:16:33 2003
+++ linux-2.5.73-root/drivers/ide/ide.c	Mon Jun 23 20:16:34 2003
@@ -508,12 +508,88 @@ ide_proc_entry_t generic_subdriver_entri
 };
 #endif
 
+static struct resource* hwif_request_region(ide_hwif_t *hwif,
+					    unsigned long addr, int num)
+{
+	struct resource *res;
+
+	if (hwif->mmio)
+		res = request_mem_region(addr, num, hwif->name);
+	else
+		res = request_region(addr, num, hwif->name);
+
+	if (!res)
+		printk(KERN_ERR "%s: %s resource 0x%lX-0x%lX not free.\n",
+				hwif->name, hwif->mmio ? "MMIO" : "I/O",
+				addr, addr+num-1);
+	return res;
+}
 
 #define hwif_release_region(addr, num) \
 	((hwif->mmio) ? release_mem_region((addr),(num)) : release_region((addr),(num)))
 
 /**
- *	hwif_unregister		-	free IDE resources
+ *	ide_hwif_request_regions - request resources for IDE
+ *	@hwif: interface to use
+ *
+ *	Requests all the needed resources for an interface.
+ *	Right now core IDE code does this work which is deeply wrong.
+ *	MMIO leaves it to the controller driver,
+ *	PIO will migrate this way over time.
+ */
+
+int ide_hwif_request_regions (ide_hwif_t *hwif)
+{
+	unsigned long addr;
+	unsigned int i;
+
+	if (hwif->mmio == 2)
+		return 0;
+	addr = hwif->io_ports[IDE_CONTROL_OFFSET];
+	if (addr && !hwif_request_region(hwif, addr, 1))
+		goto control_region_busy;
+#if defined(CONFIG_AMIGA) || defined(CONFIG_MAC)
+	addr = hwif->io_ports[IDE_IRQ_OFFSET];
+	if (addr && !hwif_request_region(hwif, addr, 1))
+		goto irq_region_busy;
+#endif /* (CONFIG_AMIGA) || (CONFIG_MAC) */
+	hwif->straight8 = 0;
+	addr = hwif->io_ports[IDE_DATA_OFFSET];
+	if ((addr | 7) == hwif->io_ports[IDE_STATUS_OFFSET]) {
+		if (!hwif_request_region(hwif, addr, 8))
+			goto data_region_busy;
+		hwif->straight8 = 1;
+		return 0;
+	}
+	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
+		addr = hwif->io_ports[i];
+		if (!hwif_request_region(hwif, addr, 1)) {
+			while (--i)
+				hwif_release_region(addr, 1);
+			goto data_region_busy;
+		}
+	}
+	return 0;
+
+data_region_busy:
+#if defined(CONFIG_AMIGA) || defined(CONFIG_MAC)
+	addr = hwif->io_ports[IDE_IRQ_OFFSET];
+	if (addr)
+		hwif_release_region(addr, 1);
+irq_region_busy:
+#endif /* (CONFIG_AMIGA) || (CONFIG_MAC) */
+	addr = hwif->io_ports[IDE_CONTROL_OFFSET];
+	if (addr)
+		hwif_release_region(addr, 1);
+control_region_busy:
+	/* If any errors are return, we drop the hwif interface. */
+	return -EBUSY;
+}
+
+EXPORT_SYMBOL(ide_hwif_request_regions);
+
+/**
+ *	ide_hwif_release_regions - free IDE resources
  *
  *	Note that we only release the standard ports,
  *	and do not even try to handle any extra ports
@@ -524,7 +600,7 @@ ide_proc_entry_t generic_subdriver_entri
  *	restructure this as a helper function for drivers.
  */
  
-void hwif_unregister (ide_hwif_t *hwif)
+void ide_hwif_release_regions (ide_hwif_t *hwif)
 {
 	u32 i = 0;
 
@@ -548,7 +624,7 @@ void hwif_unregister (ide_hwif_t *hwif)
 	}
 }
 
-EXPORT_SYMBOL(hwif_unregister);
+EXPORT_SYMBOL(ide_hwif_release_regions);
 
 extern void init_hwif_data(unsigned int index);
 
@@ -635,7 +711,7 @@ void ide_unregister (unsigned int index)
 	 * and do not even try to handle any extra ports
 	 * allocated for weird IDE interface chipsets.
 	 */
-	hwif_unregister(hwif);
+	ide_hwif_release_regions(hwif);
 
 	/*
 	 * Remove us from the hwgroup, and free
diff -puN include/linux/ide.h~ide-hwif-res-alloc-fix include/linux/ide.h
--- linux-2.5.73/include/linux/ide.h~ide-hwif-res-alloc-fix	Mon Jun 23 20:16:34 2003
+++ linux-2.5.73-root/include/linux/ide.h	Mon Jun 23 20:16:34 2003
@@ -1777,7 +1777,8 @@ static inline int __ide_dma_queued_off(i
 static inline void ide_release_dma(ide_hwif_t *drive) {;}
 #endif
 
-extern void hwif_unregister(ide_hwif_t *);
+extern int ide_hwif_request_regions(ide_hwif_t *hwif);
+extern void ide_hwif_release_regions(ide_hwif_t* hwif);
 extern void ide_unregister (unsigned int index);
 
 extern void export_ide_init_queue(ide_drive_t *);

_

