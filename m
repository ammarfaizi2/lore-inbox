Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVAaTDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVAaTDk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVAaTDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:03:37 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64529 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261314AbVAaTB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:01:58 -0500
Date: Mon, 31 Jan 2005 20:01:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [2.6 patch] IDE: possible cleanups
Message-ID: <20050131190154.GB18316@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make some needlessly global code static
- ide-dma.c: remove the unneeded EXPORT_SYMBOL(__ide_dma_test_irq)

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/ide/ide-dma.c       |   15 +++++++--------
 drivers/ide/ide-iops.c      |   10 ++++++----
 drivers/ide/ide-pnp.c       |    2 +-
 drivers/ide/ide.c           |   10 +++++-----
 drivers/ide/legacy/ide-cs.c |    2 +-
 include/linux/ide.h         |   12 ------------
 6 files changed, 20 insertions(+), 31 deletions(-)

--- linux-2.6.11-rc2-mm2-full/drivers/ide/legacy/ide-cs.c.old	2005-01-31 19:22:47.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/ide/legacy/ide-cs.c	2005-01-31 19:23:02.000000000 +0100
@@ -209,7 +209,7 @@
 #define CS_CHECK(fn, ret) \
 do { last_fn = (fn); if ((last_ret = (ret)) != 0) goto cs_failed; } while (0)
 
-void ide_config(dev_link_t *link)
+static void ide_config(dev_link_t *link)
 {
     client_handle_t handle = link->handle;
     ide_info_t *info = link->priv;
--- linux-2.6.11-rc2-mm2-full/include/linux/ide.h.old	2005-01-31 19:25:55.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/include/linux/ide.h	2005-01-31 19:34:33.000000000 +0100
@@ -1293,8 +1293,6 @@
 extern void SELECT_MASK(ide_drive_t *, int);
 extern void QUIRK_LIST(ide_drive_t *);
 
-extern void ata_input_data(ide_drive_t *, void *, u32);
-extern void ata_output_data(ide_drive_t *, void *, u32);
 extern void atapi_input_bytes(ide_drive_t *, void *, u32);
 extern void atapi_output_bytes(ide_drive_t *, void *, u32);
 
@@ -1337,14 +1335,6 @@
 ide_startstop_t __ide_do_rw_disk(ide_drive_t *drive, struct request *rq, sector_t block);
 
 /*
- * ide_system_bus_speed() returns what we think is the system VESA/PCI
- * bus speed (in MHz).  This is used for calculating interface PIO timings.
- * The default is 40 for known PCI systems, 50 otherwise.
- * The "idebus=xx" parameter can be used to override this value.
- */
-extern int ide_system_bus_speed(void);
-
-/*
  * ide_stall_queue() can be used by a drive to give excess bandwidth back
  * to the hwgroup by sleeping for timeout jiffies.
  */
@@ -1360,7 +1350,6 @@
 extern void ide_unpin_hwgroup(ide_drive_t *);
 
 extern struct block_device_operations ide_fops[];
-extern ide_proc_entry_t generic_subdriver_entries[];
 
 extern int ata_attach(ide_drive_t *);
 
@@ -1456,7 +1445,6 @@
 extern int ide_dma_setup(ide_drive_t *);
 extern void ide_dma_start(ide_drive_t *);
 extern int __ide_dma_end(ide_drive_t *);
-extern int __ide_dma_test_irq(ide_drive_t *);
 extern int __ide_dma_lostirq(ide_drive_t *);
 extern int __ide_dma_timeout(ide_drive_t *);
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
--- linux-2.6.11-rc2-mm2-full/drivers/ide/ide.c.old	2005-01-31 19:25:14.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/ide/ide.c	2005-01-31 19:28:46.000000000 +0100
@@ -333,7 +333,7 @@
  *	Returns a guessed speed in MHz.
  */
 
-int ide_system_bus_speed (void)
+static int ide_system_bus_speed (void)
 {
 	static struct pci_device_id pci_default[] = {
 		{ PCI_DEVICE(PCI_ANY_ID, PCI_ANY_ID) },
@@ -414,7 +414,7 @@
 #ifdef CONFIG_PROC_FS
 struct proc_dir_entry *proc_ide_root;
 
-ide_proc_entry_t generic_subdriver_entries[] = {
+static ide_proc_entry_t generic_subdriver_entries[] = {
 	{ "capacity",	S_IFREG|S_IRUGO,	proc_ide_read_capacity,	NULL },
 	{ NULL, 0, NULL, NULL }
 };
@@ -1684,7 +1684,7 @@
  *
  * Remember to update Documentation/ide.txt if you change something here.
  */
-int __init ide_setup (char *s)
+static int __init ide_setup (char *s)
 {
 	int i, vals[3];
 	ide_hwif_t *hwif;
@@ -2248,7 +2248,7 @@
 /*
  * This is gets invoked once during initialization, to set *everything* up
  */
-int __init ide_init (void)
+static int __init ide_init (void)
 {
 	printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n");
 	devfs_mk_dir("ide");
@@ -2295,7 +2295,7 @@
 }
 
 #ifdef MODULE
-char *options = NULL;
+static char *options = NULL;
 module_param(options, charp, 0);
 MODULE_LICENSE("GPL");
 
--- linux-2.6.11-rc2-mm2-full/drivers/ide/ide-pnp.c.old	2005-01-31 19:29:26.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/ide/ide-pnp.c	2005-01-31 19:29:39.000000000 +0100
@@ -21,7 +21,7 @@
 #include <linux/ide.h>
 
 /* Add your devices here :)) */
-struct pnp_device_id idepnp_devices[] = {
+static struct pnp_device_id idepnp_devices[] = {
   	/* Generic ESDI/IDE/ATA compatible hard disk controller */
 	{.id = "PNP0600", .driver_data = 0},
 	{.id = ""}
--- linux-2.6.11-rc2-mm2-full/drivers/ide/ide-iops.c.old	2005-01-31 19:30:18.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/ide/ide-iops.c	2005-01-31 19:38:28.000000000 +0100
@@ -30,6 +30,8 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
+static void ata_input_data (ide_drive_t *drive, void *buffer, u32 wcount);
+static void ata_output_data (ide_drive_t *drive, void *buffer, u32 wcount);
 /*
  *	Conventional PIO operations for ATA devices
  */
@@ -240,7 +242,7 @@
  * of the sector count register location, with interrupts disabled
  * to ensure that the reads all happen together.
  */
-void ata_vlb_sync (ide_drive_t *drive, unsigned long port)
+static void ata_vlb_sync (ide_drive_t *drive, unsigned long port)
 {
 	(void) HWIF(drive)->INB(port);
 	(void) HWIF(drive)->INB(port);
@@ -250,7 +252,7 @@
 /*
  * This is used for most PIO data transfers *from* the IDE interface
  */
-void ata_input_data (ide_drive_t *drive, void *buffer, u32 wcount)
+static void ata_input_data (ide_drive_t *drive, void *buffer, u32 wcount)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 io_32bit		= drive->io_32bit;
@@ -272,7 +274,7 @@
 /*
  * This is used for most PIO data transfers *to* the IDE interface
  */
-void ata_output_data (ide_drive_t *drive, void *buffer, u32 wcount)
+static void ata_output_data (ide_drive_t *drive, void *buffer, u32 wcount)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 io_32bit		= drive->io_32bit;
@@ -1127,7 +1129,7 @@
 		drive->special.b.set_multmode = 1;
 }
 
-void pre_reset (ide_drive_t *drive)
+static void pre_reset (ide_drive_t *drive)
 {
 	if (drive->media == ide_disk)
 		ide_disk_pre_reset(drive);
--- linux-2.6.11-rc2-mm2-full/drivers/ide/ide-dma.c.old	2005-01-31 19:34:41.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/ide/ide-dma.c	2005-01-31 19:36:10.000000000 +0100
@@ -631,7 +631,7 @@
 EXPORT_SYMBOL(__ide_dma_end);
 
 /* returns 1 if dma irq issued, 0 otherwise */
-int __ide_dma_test_irq (ide_drive_t *drive)
+static int __ide_dma_test_irq (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 dma_stat		= hwif->INB(hwif->dma_status);
@@ -651,7 +651,6 @@
 	return 0;
 }
 
-EXPORT_SYMBOL(__ide_dma_test_irq);
 #endif /* CONFIG_BLK_DEV_IDEDMA_PCI */
 
 int __ide_dma_bad_drive (ide_drive_t *drive)
@@ -784,7 +783,7 @@
 /*
  * Needed for allowing full modular support of ide-driver
  */
-int ide_release_dma_engine (ide_hwif_t *hwif)
+static int ide_release_dma_engine (ide_hwif_t *hwif)
 {
 	if (hwif->dmatable_cpu) {
 		pci_free_consistent(hwif->pci_dev,
@@ -796,7 +795,7 @@
 	return 1;
 }
 
-int ide_release_iomio_dma (ide_hwif_t *hwif)
+static int ide_release_iomio_dma (ide_hwif_t *hwif)
 {
 	if ((hwif->dma_extra) && (hwif->channel == 0))
 		release_region((hwif->dma_base + 16), hwif->dma_extra);
@@ -820,7 +819,7 @@
 	return ide_release_iomio_dma(hwif);
 }
 
-int ide_allocate_dma_engine (ide_hwif_t *hwif)
+static int ide_allocate_dma_engine (ide_hwif_t *hwif)
 {
 	hwif->dmatable_cpu = pci_alloc_consistent(hwif->pci_dev,
 						  PRD_ENTRIES * PRD_BYTES,
@@ -837,7 +836,7 @@
 	return 1;
 }
 
-int ide_mapped_mmio_dma (ide_hwif_t *hwif, unsigned long base, unsigned int ports)
+static int ide_mapped_mmio_dma (ide_hwif_t *hwif, unsigned long base, unsigned int ports)
 {
 	printk(KERN_INFO "    %s: MMIO-DMA ", hwif->name);
 
@@ -852,7 +851,7 @@
 	return 0;
 }
 
-int ide_iomio_dma (ide_hwif_t *hwif, unsigned long base, unsigned int ports)
+static int ide_iomio_dma (ide_hwif_t *hwif, unsigned long base, unsigned int ports)
 {
 	printk(KERN_INFO "    %s: BM-DMA at 0x%04lx-0x%04lx",
 		hwif->name, base, base + ports - 1);
@@ -884,7 +883,7 @@
 /*
  * 
  */
-int ide_dma_iobase (ide_hwif_t *hwif, unsigned long base, unsigned int ports)
+static int ide_dma_iobase (ide_hwif_t *hwif, unsigned long base, unsigned int ports)
 {
 	if (hwif->mmio == 2)
 		return ide_mapped_mmio_dma(hwif, base,ports);

