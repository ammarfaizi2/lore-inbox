Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262968AbTJPSQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 14:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbTJPSQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 14:16:59 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:36773 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262968AbTJPSQx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 14:16:53 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jeremy Higdon <jeremy@sgi.com>
Subject: Re: Patch to add support for SGI's IOC4 chipset
Date: Thu, 16 Oct 2003 20:20:51 +0200
User-Agent: KMail/1.5.4
Cc: gwh@sgi.com, jbarnes@sgi.com, aniket_m@hotmail.com,
       linux-kernel@vger.kernel.org
References: <3F7CB4A9.3C1F1237@sgi.com> <200310071527.56813.bzolnier@elka.pw.edu.pl> <20031008033809.GA29878@sgi.com>
In-Reply-To: <20031008033809.GA29878@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310162020.51303.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 of October 2003 05:38, Jeremy Higdon wrote:

> Attached is the latest patch, which also includes your patch sent
> previously. Thanks for your review and assistance.

Thanks.

> I will be on a vacation starting tomorrow, so I won't be able to reply
> until Oct 19th or 20th, in case there are any more issues.  Hopefully this
> one will be okay  :-)

I think that after applying attached incremental patch it can go in.

- defining IDE_ARCH_ACK_INTR and ide_ack_intr() in sgiioc4.c is a no-op,
  it should be done <asm/ide.h> to make it work
  (I think the same problem is present in 2.4.x)
- fix NULL pointer dereference (accessing hwif->name while hwif is NULL)
  in sgiioc4_ide_setup_pci_device() (was this driver ever tested?)
- make config option SN2 specific
- replace uint{8,32,64}_t by u{8,32,64}

--bartlomiej

 drivers/ide/Kconfig       |    3 ++-
 drivers/ide/pci/sgiioc4.c |   44 ++++++++++++++++----------------------------
 include/asm-ia64/ide.h    |    6 ++++++
 3 files changed, 24 insertions(+), 29 deletions(-)

diff -puN drivers/ide/Kconfig~ide-sgiioc4-fixes drivers/ide/Kconfig
--- linux-2.6.0-test6-bk2/drivers/ide/Kconfig~ide-sgiioc4-fixes	2003-10-09 00:00:08.000000000 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/Kconfig	2003-10-09 00:41:09.000000000 +0200
@@ -742,11 +742,12 @@ config BLK_DEV_SVWKS
 
 config BLK_DEV_SGIIOC4
 	tristate "Silicon Graphics IOC4 chipset support"
+	depends on IA64_SGI_SN2
 	help
 	  This driver adds PIO & MultiMode DMA-2 support for the SGI IOC4
 	  chipset, which has one channel and can support two devices.
 	  Please say Y here if you have an Altix System from SGI.
-		
+
 config BLK_DEV_SIIMAGE
 	tristate "Silicon Image chipset support"
 	help
diff -puN include/asm-ia64/ide.h~ide-sgiioc4-fixes include/asm-ia64/ide.h
--- linux-2.6.0-test6-bk2/include/asm-ia64/ide.h~ide-sgiioc4-fixes	2003-10-08 23:59:39.000000000 +0200
+++ linux-2.6.0-test6-bk2-root/include/asm-ia64/ide.h	2003-10-09 00:04:18.000000000 +0200
@@ -91,6 +91,12 @@ ide_init_default_hwifs (void)
 #endif
 }
 
+#ifdef CONFIG_BLK_DEV_SGIIOC4
+#define IDE_ARCH_ACK_INTR
+/* Weeds out non-IDE interrupts to the IOC4 */
+#define ide_ack_intr(hwif) ((hwif)->hw.ack_intr ? (hwif)->hw.ack_intr(hwif) : 1)
+#endif
+
 #include <asm-generic/ide_iops.h>
 
 #endif /* __KERNEL__ */
diff -puN drivers/ide/pci/sgiioc4.c~ide-sgiioc4-fixes drivers/ide/pci/sgiioc4.c
--- linux-2.6.0-test6-bk2/drivers/ide/pci/sgiioc4.c~ide-sgiioc4-fixes	2003-10-08 23:57:34.000000000 +0200
+++ linux-2.6.0-test6-bk2-root/drivers/ide/pci/sgiioc4.c	2003-10-09 00:22:52.000000000 +0200
@@ -37,7 +37,6 @@
 #include <linux/blkdev.h>
 #include <asm/io.h>
 
-#define IDE_ARCH_ACK_INTR	1
 #include <linux/ide.h>
 
 /* IOC4 Specific Definitions */
@@ -77,12 +76,6 @@
 #define IOC4_CMD_CTL_BLK_SIZE	0x20
 #define IOC4_SUPPORTED_FIRMWARE_REV 46
 
-/* Weeds out non-IDE interrupts to the IOC4 */
-#define ide_ack_intr(hwif) ((hwif)->hw.ack_intr ? (hwif)->hw.ack_intr(hwif) : 1)
-
-#define SGIIOC4_MAX_DEVS	32
-
-
 typedef struct {
 	u32 timing_reg0;
 	u32 timing_reg1;
@@ -100,7 +93,6 @@ typedef struct {
 #define IOC4_PRD_BYTES       16
 #define IOC4_PRD_ENTRIES     (PAGE_SIZE /(4*IOC4_PRD_BYTES))
 
-
 static inline void
 xide_delay(long ticks)
 {
@@ -111,7 +103,6 @@ xide_delay(long ticks)
 	schedule_timeout(ticks);
 }
 
-
 static void
 sgiioc4_init_hwif_ports(hw_regs_t * hw, unsigned long data_port,
 			unsigned long ctrl_port, unsigned long irq_port)
@@ -142,7 +133,7 @@ sgiioc4_maskproc(ide_drive_t * drive, in
 static int
 sgiioc4_checkirq(ide_hwif_t * hwif)
 {
-	uint8_t intr_reg =
+	u8 intr_reg =
 	    hwif->INL(hwif->io_ports[IDE_IRQ_OFFSET] + IOC4_INTR_REG * 4);
 
 	if (intr_reg & 0x03)
@@ -173,7 +164,7 @@ sgiioc4_clearirq(ide_drive_t * drive)
 
 		if (intr_reg & 0x02) {
 			/* Error when transferring DMA data on PCI bus */
-			uint32_t pci_err_addr_low, pci_err_addr_high,
+			u32 pci_err_addr_low, pci_err_addr_high,
 			    pci_stat_cmd_reg;
 
 			pci_err_addr_low =
@@ -204,7 +195,6 @@ sgiioc4_clearirq(ide_drive_t * drive)
 	return intr_reg;
 }
 
-
 static int
 sgiioc4_ide_dma_begin(ide_drive_t * drive)
 {
@@ -238,7 +228,7 @@ sgiioc4_ide_dma_end(ide_drive_t * drive)
 {
 	u32 ioc4_dma, bc_dev, bc_mem, num, valid = 0, cnt = 0;
 	ide_hwif_t *hwif = HWIF(drive);
-	uint64_t dma_base = hwif->dma_base;
+	u64 dma_base = hwif->dma_base;
 	int dma_stat = 0;
 	unsigned long *ending_dma = (unsigned long *) hwif->dma_base2;
 
@@ -465,8 +455,8 @@ sgiioc4_configure_for_dma(int dma_direct
 {
 	u32 ioc4_dma;
 	ide_hwif_t *hwif = HWIF(drive);
-	uint64_t dma_base = hwif->dma_base;
-	uint32_t dma_addr, ending_dma_addr;
+	u64 dma_base = hwif->dma_base;
+	u32 dma_addr, ending_dma_addr;
 
 	ioc4_dma = hwif->INL(dma_base + IOC4_DMA_CTRL * 4);
 
@@ -550,7 +540,7 @@ sgiioc4_build_dma_table(ide_drive_t * dr
 				       drive->name);
 				goto use_pio_instead;
 			} else {
-				uint32_t xcount, bcount =
+				u32 xcount, bcount =
 				    0x10000 - (cur_addr & 0xffff);
 
 				if (bcount > cur_len)
@@ -625,7 +615,6 @@ sgiioc4_ide_dma_write(ide_drive_t * driv
 	return 0;
 }
 
-
 static void __init
 ide_init_sgiioc4(ide_hwif_t * hwif)
 {
@@ -672,9 +661,16 @@ ide_init_sgiioc4(ide_hwif_t * hwif)
 static int __init
 sgiioc4_ide_setup_pci_device(struct pci_dev *dev, ide_pci_device_t * d)
 {
-	unsigned long base = 0, ctl = 0, dma_base = 0, irqport = 0;
-	ide_hwif_t *hwif = NULL;
-	int h = 0;
+	unsigned long base, ctl, dma_base, irqport;
+	ide_hwif_t *hwif;
+	int h;
+
+	for (h = 0; h < MAX_HWIFS; ++h) {
+		hwif = &ide_hwifs[h];
+		/* Find an empty HWIF */
+		if (hwif->chipset == ide_unknown)
+			break;
+	}
 
 	/*  Get the CmdBlk and CtrlBlk Base Registers */
 	base = pci_resource_start(dev, 0) + IOC4_CMD_OFFSET;
@@ -691,13 +687,6 @@ sgiioc4_ide_setup_pci_device(struct pci_
 		return 1;
 	}
 
-	for (h = 0; h < MAX_HWIFS; ++h) {
-		hwif = &ide_hwifs[h];
-		/* Find an empty HWIF */
-		if (hwif->chipset == ide_unknown)
-			break;
-	}
-
 	if (hwif->io_ports[IDE_DATA_OFFSET] != base) {
 		/* Initialize the IO registers */
 		sgiioc4_init_hwif_ports(&hwif->hw, base, ctl, irqport);
@@ -778,7 +767,6 @@ pci_init_sgiioc4(struct pci_dev *dev, id
 	return sgiioc4_ide_setup_pci_device(dev, d);
 }
 
-
 static ide_pci_device_t sgiioc4_chipsets[] __devinitdata = {
 	{
 	 /* Channel 0 */

_

