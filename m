Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268018AbTBRS0I>; Tue, 18 Feb 2003 13:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268015AbTBRSZH>; Tue, 18 Feb 2003 13:25:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59657 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268018AbTBRSYO>; Tue, 18 Feb 2003 13:24:14 -0500
Subject: PATCH: make the sl82c105 work again
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2003 18:34:29 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18lCZa-0006Ec-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/drivers/ide/pci/sl82c105.c linux-2.5.61-ac2/drivers/ide/pci/sl82c105.c
--- linux-2.5.61/drivers/ide/pci/sl82c105.c	2003-02-10 18:38:17.000000000 +0000
+++ linux-2.5.61-ac2/drivers/ide/pci/sl82c105.c	2003-02-18 18:06:19.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/sl82c105.c
+ * linux/drivers/ide/pci/sl82c105.c
  *
  * SL82C105/Winbond 553 IDE driver
  *
@@ -7,6 +7,10 @@
  *
  * Drive tuning added from Rebel.com's kernel sources
  *  -- Russell King (15/11/98) linux@arm.linux.org.uk
+ * 
+ * Merge in Russell's HW workarounds, fix various problems
+ * with the timing registers setup.
+ *  -- Benjamin Herrenschmidt (01/11/03) benh@kernel.crashing.org
  */
 
 #include <linux/config.h>
@@ -28,6 +32,24 @@
 #include "ide_modes.h"
 #include "sl82c105.h"
 
+#undef DEBUG
+
+#ifdef DEBUG
+#define DBG(arg) printk arg
+#else
+#define DBG(fmt,...)
+#endif
+/*
+ * SL82C105 PCI config register 0x40 bits.
+ */
+#define CTRL_IDE_IRQB   (1 << 30)
+#define CTRL_IDE_IRQA   (1 << 28)
+#define CTRL_LEGIRQ     (1 << 11)
+#define CTRL_P1F16      (1 << 5)
+#define CTRL_P1EN       (1 << 4)
+#define CTRL_P0F16      (1 << 1)
+#define CTRL_P0EN       (1 << 0)
+
 /*
  * Convert a PIO mode and cycle time to the required on/off
  * times for the interface.  This has protection against run-away
@@ -57,7 +79,7 @@
 /*
  * Configure the drive and chipset for PIO
  */
-static void config_for_pio(ide_drive_t *drive, int pio, int report)
+static void config_for_pio(ide_drive_t *drive, int pio, int report, int chipset_only)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct pci_dev *dev = hwif->pci_dev;
@@ -65,14 +87,20 @@
 	u16 drv_ctrl = 0x909;
 	unsigned int xfer_mode, reg;
 
+	DBG(("config_for_pio(drive:%s, pio:%d, report:%d, chipset_only:%d)\n",
+		drive->name, pio, report, chipset_only));
+		
 	reg = (hwif->channel ? 0x4c : 0x44) + (drive->select.b.unit ? 4 : 0);
 
 	pio = ide_get_best_pio_mode(drive, pio, 5, &p);
 
 	xfer_mode = XFER_PIO_0 + pio;
 
-	if (ide_config_drive_speed(drive, xfer_mode) == 0)
+	if (chipset_only || ide_config_drive_speed(drive, xfer_mode) == 0) {
 		drv_ctrl = get_timing_sl82c105(&p);
+		drive->pio_speed = xfer_mode;
+	} else
+		drive->pio_speed = XFER_PIO_0;
 
 	if (drive->using_dma == 0) {
 		/*
@@ -96,15 +124,16 @@
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct pci_dev *dev = hwif->pci_dev;
-	u16 drv_ctrl = 0x909;
 	unsigned int reg;
 
+	DBG(("config_for_dma(drive:%s)\n", drive->name));
+
 	reg = (hwif->channel ? 0x4c : 0x44) + (drive->select.b.unit ? 4 : 0);
 
-	if (ide_config_drive_speed(drive, XFER_MW_DMA_2) == 0)
-		drv_ctrl = 0x0240;
+	if (ide_config_drive_speed(drive, XFER_MW_DMA_2) != 0)
+		return 1;
 
-	pci_write_config_word(dev, reg, drv_ctrl);
+	pci_write_config_word(dev, reg, 0x0240);
 
 	return 0;
 }
@@ -117,6 +146,9 @@
 static int sl82c105_check_drive (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
+
+	DBG(("sl82c105_check_drive(drive:%s)\n", drive->name));
+
 	do {
 		struct hd_driveid *id = drive->id;
 
@@ -143,34 +175,188 @@
 	return hwif->ide_dma_off_quietly(drive);
 }
 
+/*
+ * The SL82C105 holds off all IDE interrupts while in DMA mode until
+ * all DMA activity is completed.  Sometimes this causes problems (eg,
+ * when the drive wants to report an error condition).
+ *
+ * 0x7e is a "chip testing" register.  Bit 2 resets the DMA controller
+ * state machine.  We need to kick this to work around various bugs.
+ */
+static inline void sl82c105_reset_host(struct pci_dev *dev)
+{
+	u16 val;
+
+	pci_read_config_word(dev, 0x7e, &val);
+	pci_write_config_word(dev, 0x7e, val | (1 << 2));
+	pci_write_config_word(dev, 0x7e, val & ~(1 << 2));
+}
+
+/*
+ * If we get an IRQ timeout, it might be that the DMA state machine
+ * got confused.  Fix from Todd Inglett.  Details from Winbond.
+ *
+ * This function is called when the IDE timer expires, the drive
+ * indicates that it is READY, and we were waiting for DMA to complete.
+ */
+static int sl82c105_ide_dma_lost_irq(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	struct pci_dev *dev = hwif->pci_dev;
+	u32 val, mask = hwif->channel ? CTRL_IDE_IRQB : CTRL_IDE_IRQA;
+	unsigned long dma_base = hwif->dma_base;
+
+	printk("sl82c105: lost IRQ: resetting host\n");
+
+	/*
+	 * Check the raw interrupt from the drive.
+	 */
+	pci_read_config_dword(dev, 0x40, &val);
+	if (val & mask)
+		printk("sl82c105: drive was requesting IRQ, but host lost it\n");
+
+	/*
+	 * Was DMA enabled?  If so, disable it - we're resetting the
+	 * host.  The IDE layer will be handling the drive for us.
+	 */
+	val = hwif->INB(dma_base);
+	if (val & 1) {
+		outb(val & ~1, dma_base);
+		printk("sl82c105: DMA was enabled\n");
+	}
+
+	sl82c105_reset_host(dev);
+
+	/* ide_dmaproc would return 1, so we do as well */
+	return 1;
+}
+
+/*
+ * ATAPI devices can cause the SL82C105 DMA state machine to go gaga.
+ * Winbond recommend that the DMA state machine is reset prior to
+ * setting the bus master DMA enable bit.
+ *
+ * The generic IDE core will have disabled the BMEN bit before this
+ * function is called.
+ */
+static int sl82c105_ide_dma_begin(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	struct pci_dev *dev = hwif->pci_dev;
+
+//	DBG(("sl82c105_ide_dma_begin(drive:%s)\n", drive->name));
+
+	sl82c105_reset_host(dev);
+	return __ide_dma_begin(drive);
+}
+
+static int sl82c105_ide_dma_timeout(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	struct pci_dev *dev = hwif->pci_dev;
+
+	DBG(("sl82c105_ide_dma_timeout(drive:%s)\n", drive->name));
+
+	sl82c105_reset_host(dev);
+	return __ide_dma_timeout(drive);
+}
+
 static int sl82c105_ide_dma_on (ide_drive_t *drive)
 {
+	DBG(("sl82c105_ide_dma_on(drive:%s)\n", drive->name));
+
 	if (config_for_dma(drive)) {
-		config_for_pio(drive, 4, 0);
+		config_for_pio(drive, 4, 0, 0);
 		return HWIF(drive)->ide_dma_off_quietly(drive);
 	}
+	printk(KERN_INFO "%s: DMA enabled\n", drive->name);
 	return __ide_dma_on(drive);
 }
 
 static int sl82c105_ide_dma_off (ide_drive_t *drive)
 {
-	config_for_pio(drive, 4, 0);
-	return __ide_dma_off(drive);
+	u8 speed = XFER_PIO_0;
+	int rc;
+	
+	DBG(("sl82c105_ide_dma_off(drive:%s)\n", drive->name));
+
+	rc = __ide_dma_off(drive);
+	if (drive->pio_speed)
+		speed = drive->pio_speed - XFER_PIO_0;
+	config_for_pio(drive, speed, 0, 1);
+	drive->current_speed = drive->pio_speed;
+
+	return rc;
 }
 
 static int sl82c105_ide_dma_off_quietly (ide_drive_t *drive)
 {
-	config_for_pio(drive, 4, 0);
-	return __ide_dma_off_quietly(drive);
+	u8 speed = XFER_PIO_0;
+	int rc;
+	
+	DBG(("sl82c105_ide_dma_off_quietly(drive:%s)\n", drive->name));
+
+	rc = __ide_dma_off_quietly(drive);
+	if (drive->pio_speed)
+		speed = drive->pio_speed - XFER_PIO_0;
+	config_for_pio(drive, speed, 0, 1);
+	drive->current_speed = drive->pio_speed;
+
+	return rc;
+}
+
+/*
+ * Ok, that is nasty, but we must make sure the DMA timings
+ * won't be used for a PIO access. The solution here is
+ * to make sure the 16 bits mode is diabled on the channel
+ * when DMA is enabled, thus causing the chip to use PIO0
+ * timings for those operations.
+ */
+static void sl82c105_selectproc(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	struct pci_dev *dev = hwif->pci_dev;
+	u32 val, old, mask;
+
+	//DBG(("sl82c105_selectproc(drive:%s)\n", drive->name));
+
+	mask = hwif->channel ? CTRL_P1F16 : CTRL_P0F16;
+	old = val = *((u32 *)&hwif->hwif_data);
+	if (drive->using_dma)
+		val &= ~mask;
+	else
+		val |= mask;
+	if (old != val) {
+		pci_write_config_dword(dev, 0x40, val);	
+		*((u32 *)&hwif->hwif_data) = val;
+	}
 }
 
 /*
+ * ATA reset will clear the 16 bits mode in the control
+ * register, we need to update our cache
+ */
+static void sl82c105_resetproc(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = HWIF(drive);
+	struct pci_dev *dev = hwif->pci_dev;
+	u32 val;
+
+	DBG(("sl82c105_resetproc(drive:%s)\n", drive->name));
+
+	pci_read_config_dword(dev, 0x40, &val);
+	*((u32 *)&hwif->hwif_data) = val;
+}
+	
+/*
  * We only deal with PIO mode here - DMA mode 'using_dma' is not
  * initialised at the point that this function is called.
  */
 static void tune_sl82c105(ide_drive_t *drive, u8 pio)
 {
-	config_for_pio(drive, pio, 1);
+	DBG(("tune_sl82c105(drive:%s)\n", drive->name));
+
+	config_for_pio(drive, pio, 1, 0);
 
 	/*
 	 * We support 32-bit I/O on this interface, and it
@@ -189,16 +375,20 @@
 	struct pci_dev *bridge;
 	u8 rev;
 
-	bridge = pci_find_device(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_83C553, NULL);
-
 	/*
-	 * If we are part of a Winbond 553
+	 * The bridge should be part of the same device, but function 0.
 	 */
-	if (!bridge || bridge->class >> 8 != PCI_CLASS_BRIDGE_ISA)
+	bridge = pci_find_slot(dev->bus->number,
+			       PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+	if (!bridge)
 		return -1;
 
-	if (bridge->bus != dev->bus ||
-	    PCI_SLOT(bridge->devfn) != PCI_SLOT(dev->devfn))
+	/*
+	 * Make sure it is a Winbond 553 and is an ISA bridge.
+	 */
+	if (bridge->vendor != PCI_VENDOR_ID_WINBOND ||
+	    bridge->device != PCI_DEVICE_ID_WINBOND_83C553 ||
+	    bridge->class >> 8 != PCI_CLASS_BRIDGE_ISA)
 		return -1;
 
 	/*
@@ -211,16 +401,21 @@
 
 /*
  * Enable the PCI device
+ * 
+ * --BenH: It's arch fixup code that should enable channels that
+ * have not been enabled by firmware. I decided we can still enable
+ * channel 0 here at least, but channel 1 has to be enabled by
+ * firmware or arch code. We still set both to 16 bits mode.
  */
 static unsigned int __init init_chipset_sl82c105(struct pci_dev *dev, const char *msg)
 {
-	u8 ctrl_stat;
+	u32 val;
 
-	/*
-	 * Enable the ports
-	 */
-	pci_read_config_byte(dev, 0x40, &ctrl_stat);
-	pci_write_config_byte(dev, 0x40, ctrl_stat | 0x33);
+	DBG(("init_chipset_sl82c105()\n"));
+
+	pci_read_config_dword(dev, 0x40, &val);
+	val |= CTRL_P0EN | CTRL_P0F16 | CTRL_P1F16;
+	pci_write_config_dword(dev, 0x40, val);
 
 	return dev->irq;
 }
@@ -230,6 +425,8 @@
 	unsigned int rev;
 	u8 dma_state;
 
+	DBG(("init_dma_sl82c105(hwif: ide%d, dma_base: 0x%08x)\n", hwif->index, dma_base));
+
 	hwif->autodma = 0;
 
 	if (!dma_base)
@@ -238,8 +435,6 @@
 	dma_state = hwif->INB(dma_base + 2);
 	rev = sl82c105_bridge_revision(hwif->pci_dev);
 	if (rev <= 5) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
 		printk("    %s: Winbond 553 bridge revision %d, BM-DMA disabled\n",
 		       hwif->name, rev);
 		dma_state &= ~0x60;
@@ -259,8 +454,28 @@
 
 static void __init init_hwif_sl82c105(ide_hwif_t *hwif)
 {
-	hwif->tuneproc = tune_sl82c105;
+	struct pci_dev *dev = hwif->pci_dev;
+	u32 val;
+	
+	DBG(("init_hwif_sl82c105(hwif: ide%d)\n", hwif->index));
 
+	hwif->tuneproc = tune_sl82c105;
+	hwif->selectproc = sl82c105_selectproc;
+	hwif->resetproc = sl82c105_resetproc;
+	
+	/* Default to PIO 0 for fallback unless tuned otherwise,
+	 * we always autotune PIO, this is done before DMA is
+	 * checked, so there is no risk of accidentally disabling
+	 * DMA
+	  */
+	hwif->drives[0].pio_speed = XFER_PIO_0;
+	hwif->drives[0].autotune = 1;
+	hwif->drives[1].pio_speed = XFER_PIO_1;
+	hwif->drives[1].autotune = 1;
+
+	pci_read_config_dword(dev, 0x40, &val);
+	*((u32 *)&hwif->hwif_data) = val;
+	
 	if (!hwif->dma_base)
 		return;
 
@@ -273,6 +488,10 @@
 	hwif->ide_dma_on = &sl82c105_ide_dma_on;
 	hwif->ide_dma_off = &sl82c105_ide_dma_off;
 	hwif->ide_dma_off_quietly = &sl82c105_ide_dma_off_quietly;
+	hwif->ide_dma_lostirq = &sl82c105_ide_dma_lost_irq;
+	hwif->ide_dma_begin = &sl82c105_ide_dma_begin;
+	hwif->ide_dma_timeout = &sl82c105_ide_dma_timeout;
+
 	if (!noautodma)
 		hwif->autodma = 1;
 	hwif->drives[0].autodma = hwif->autodma;
