Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267275AbTAKQZH>; Sat, 11 Jan 2003 11:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267273AbTAKQZH>; Sat, 11 Jan 2003 11:25:07 -0500
Received: from AMarseille-201-1-3-14.abo.wanadoo.fr ([193.253.250.14]:33906
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267280AbTAKQZA>; Sat, 11 Jan 2003 11:25:00 -0500
Subject: [PATCH] sl82c105 driver update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-Tm9lrPt41sMeISBPiu3z"
Organization: 
Message-Id: <1042302798.525.66.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 11 Jan 2003 17:33:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Tm9lrPt41sMeISBPiu3z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Enclosed is an update to the sl82c105 driver against 2.4.21-pre3, I'll
produce a 2.5 version once this is accepted by Alan.

It adds a pio_speed field to the generic IDE struct drive. This field is
currently only used by this driver, not by the core, and stores the last
used PIO speed for use when disabling DMA.

This patch fix the current oops caused by this driver on boot, along
with other fixes & HW bugs workarounds by Russel King and me.

Alan, please send to Marcelo if you are ok. Currently tested on a briQ
HW (one channel, one master disk).

Note that I intentionally stop force-enabling the second channel (the
old driver did that) since this cause problems on machines with only one
channel wired and no pull down resistor on D7. It's the responsibility
of the BIOS or arch fixup of machines with 2 channels to properly set
the enable bits for the second one. The first one is always assumed
enabled for now (though I have nothing against changing that too).

-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

--=-Tm9lrPt41sMeISBPiu3z
Content-Disposition: attachment; filename=winbond.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=winbond.diff; charset=ISO-8859-1

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC
# This patch format is intended for GNU patch command version 2.5 or higher=
.
# This patch includes the following deltas:
#	           ChangeSet	1.747   -> 1.749 =20
#	drivers/ide/pci/sl82c105.c	1.6     -> 1.7   =20
#	 include/linux/ide.h	1.8     -> 1.9   =20
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/01/11	benh@zion.wanadoo.fr	1.748
# sl82c105 IDE driver update and fixes
# --------------------------------------------
# 03/01/11	benh@zion.wanadoo.fr	1.749
# Add pio_speed field to IDE struct drive as discussed with Alan Cox
# Used by new sl82c105 driver
# --------------------------------------------
#
diff -Nru a/drivers/ide/pci/sl82c105.c b/drivers/ide/pci/sl82c105.c
--- a/drivers/ide/pci/sl82c105.c	Sat Jan 11 17:27:28 2003
+++ b/drivers/ide/pci/sl82c105.c	Sat Jan 11 17:27:28 2003
@@ -7,6 +7,10 @@
  *
  * Drive tuning added from Rebel.com's kernel sources
  *  -- Russell King (15/11/98) linux@arm.linux.org.uk
+ *=20
+ * Merge in Russell's HW workarounds, fix various problems
+ * with the timing registers setup.
+ *  -- Benjamin Herrenschmidt (01/11/03) benh@kernel.crashing.org
  */
=20
 #include <linux/config.h>
@@ -28,6 +32,24 @@
 #include "ide_modes.h"
 #include "sl82c105.h"
=20
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
+static void config_for_pio(ide_drive_t *drive, int pio, int report, int ch=
ipset_only)
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
 	struct pci_dev *dev =3D hwif->pci_dev;
@@ -65,14 +87,20 @@
 	u16 drv_ctrl =3D 0x909;
 	unsigned int xfer_mode, reg;
=20
+	DBG(("config_for_pio(drive:%s, pio:%d, report:%d, chipset_only:%d)\n",
+		drive->name, pio, report, chipset_only));
+	=09
 	reg =3D (hwif->channel ? 0x4c : 0x44) + (drive->select.b.unit ? 4 : 0);
=20
 	pio =3D ide_get_best_pio_mode(drive, pio, 5, &p);
=20
 	xfer_mode =3D XFER_PIO_0 + pio;
=20
-	if (ide_config_drive_speed(drive, xfer_mode) =3D=3D 0)
+	if (chipset_only || ide_config_drive_speed(drive, xfer_mode) =3D=3D 0) {
 		drv_ctrl =3D get_timing_sl82c105(&p);
+		drive->pio_speed =3D xfer_mode;
+	} else
+		drive->pio_speed =3D XFER_PIO_0;
=20
 	if (drive->using_dma =3D=3D 0) {
 		/*
@@ -96,15 +124,16 @@
 {
 	ide_hwif_t *hwif =3D HWIF(drive);
 	struct pci_dev *dev =3D hwif->pci_dev;
-	u16 drv_ctrl =3D 0x909;
 	unsigned int reg;
=20
+	DBG(("config_for_dma(drive:%s)\n", drive->name));
+
 	reg =3D (hwif->channel ? 0x4c : 0x44) + (drive->select.b.unit ? 4 : 0);
=20
-	if (ide_config_drive_speed(drive, XFER_MW_DMA_2) =3D=3D 0)
-		drv_ctrl =3D 0x0240;
+	if (ide_config_drive_speed(drive, XFER_MW_DMA_2) !=3D 0)
+		return 1;
=20
-	pci_write_config_word(dev, reg, drv_ctrl);
+	pci_write_config_word(dev, reg, 0x0240);
=20
 	return 0;
 }
@@ -117,6 +146,9 @@
 static int sl82c105_check_drive (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	=3D HWIF(drive);
+
+	DBG(("sl82c105_check_drive(drive:%s)\n", drive->name));
+
 	do {
 		struct hd_driveid *id =3D drive->id;
=20
@@ -143,34 +175,188 @@
 	return hwif->ide_dma_off_quietly(drive);
 }
=20
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
+	ide_hwif_t *hwif =3D HWIF(drive);
+	struct pci_dev *dev =3D hwif->pci_dev;
+	u32 val, mask =3D hwif->channel ? CTRL_IDE_IRQB : CTRL_IDE_IRQA;
+	unsigned long dma_base =3D hwif->dma_base;
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
+	val =3D hwif->INB(dma_base);
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
+	ide_hwif_t *hwif =3D HWIF(drive);
+	struct pci_dev *dev =3D hwif->pci_dev;
+
+//	DBG(("sl82c105_ide_dma_begin(drive:%s)\n", drive->name));
+
+	sl82c105_reset_host(dev);
+	return __ide_dma_begin(drive);
+}
+
+static int sl82c105_ide_dma_timeout(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif =3D HWIF(drive);
+	struct pci_dev *dev =3D hwif->pci_dev;
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
=20
 static int sl82c105_ide_dma_off (ide_drive_t *drive)
 {
-	config_for_pio(drive, 4, 0);
-	return __ide_dma_off(drive);
+	u8 speed =3D XFER_PIO_0;
+	int rc;
+=09
+	DBG(("sl82c105_ide_dma_off(drive:%s)\n", drive->name));
+
+	rc =3D __ide_dma_off(drive);
+	if (drive->pio_speed)
+		speed =3D drive->pio_speed - XFER_PIO_0;
+	config_for_pio(drive, speed, 0, 1);
+	drive->current_speed =3D drive->pio_speed;
+
+	return rc;
 }
=20
 static int sl82c105_ide_dma_off_quietly (ide_drive_t *drive)
 {
-	config_for_pio(drive, 4, 0);
-	return __ide_dma_off_quietly(drive);
+	u8 speed =3D XFER_PIO_0;
+	int rc;
+=09
+	DBG(("sl82c105_ide_dma_off_quietly(drive:%s)\n", drive->name));
+
+	rc =3D __ide_dma_off_quietly(drive);
+	if (drive->pio_speed)
+		speed =3D drive->pio_speed - XFER_PIO_0;
+	config_for_pio(drive, speed, 0, 1);
+	drive->current_speed =3D drive->pio_speed;
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
+	ide_hwif_t *hwif =3D HWIF(drive);
+	struct pci_dev *dev =3D hwif->pci_dev;
+	u32 val, old, mask;
+
+	//DBG(("sl82c105_selectproc(drive:%s)\n", drive->name));
+
+	mask =3D hwif->channel ? CTRL_P1F16 : CTRL_P0F16;
+	old =3D val =3D *((u32 *)&hwif->hwif_data);
+	if (drive->using_dma)
+		val &=3D ~mask;
+	else
+		val |=3D mask;
+	if (old !=3D val) {
+		pci_write_config_dword(dev, 0x40, val);=09
+		*((u32 *)&hwif->hwif_data) =3D val;
+	}
 }
=20
 /*
+ * ATA reset will clear the 16 bits mode in the control
+ * register, we need to update our cache
+ */
+static void sl82c105_resetproc(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif =3D HWIF(drive);
+	struct pci_dev *dev =3D hwif->pci_dev;
+	u32 val;
+
+	DBG(("sl82c105_resetproc(drive:%s)\n", drive->name));
+
+	pci_read_config_dword(dev, 0x40, &val);
+	*((u32 *)&hwif->hwif_data) =3D val;
+}
+=09
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
=20
 	/*
 	 * We support 32-bit I/O on this interface, and it
@@ -189,16 +375,20 @@
 	struct pci_dev *bridge;
 	u8 rev;
=20
-	bridge =3D pci_find_device(PCI_VENDOR_ID_WINBOND, PCI_DEVICE_ID_WINBOND_8=
3C553, NULL);
-
 	/*
-	 * If we are part of a Winbond 553
+	 * The bridge should be part of the same device, but function 0.
 	 */
-	if (!bridge || bridge->class >> 8 !=3D PCI_CLASS_BRIDGE_ISA)
+	bridge =3D pci_find_slot(dev->bus->number,
+			       PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
+	if (!bridge)
 		return -1;
=20
-	if (bridge->bus !=3D dev->bus ||
-	    PCI_SLOT(bridge->devfn) !=3D PCI_SLOT(dev->devfn))
+	/*
+	 * Make sure it is a Winbond 553 and is an ISA bridge.
+	 */
+	if (bridge->vendor !=3D PCI_VENDOR_ID_WINBOND ||
+	    bridge->device !=3D PCI_DEVICE_ID_WINBOND_83C553 ||
+	    bridge->class >> 8 !=3D PCI_CLASS_BRIDGE_ISA)
 		return -1;
=20
 	/*
@@ -211,16 +401,21 @@
=20
 /*
  * Enable the PCI device
+ *=20
+ * --BenH: It's arch fixup code that should enable channels that
+ * have not been enabled by firmware. I decided we can still enable
+ * channel 0 here at least, but channel 1 has to be enabled by
+ * firmware or arch code. We still set both to 16 bits mode.
  */
 static unsigned int __init init_chipset_sl82c105(struct pci_dev *dev, cons=
t char *msg)
 {
-	u8 ctrl_stat;
+	u32 val;
=20
-	/*
-	 * Enable the ports
-	 */
-	pci_read_config_byte(dev, 0x40, &ctrl_stat);
-	pci_write_config_byte(dev, 0x40, ctrl_stat | 0x33);
+	DBG(("init_chipset_sl82c105()\n"));
+
+	pci_read_config_dword(dev, 0x40, &val);
+	val |=3D CTRL_P0EN | CTRL_P0F16 | CTRL_P1F16;
+	pci_write_config_dword(dev, 0x40, val);
=20
 	return dev->irq;
 }
@@ -230,6 +425,8 @@
 	unsigned int rev;
 	u8 dma_state;
=20
+	DBG(("init_dma_sl82c105(hwif: ide%d, dma_base: 0x%08x)\n", hwif->index, d=
ma_base));
+
 	hwif->autodma =3D 0;
=20
 	if (!dma_base)
@@ -238,8 +435,6 @@
 	dma_state =3D hwif->INB(dma_base + 2);
 	rev =3D sl82c105_bridge_revision(hwif->pci_dev);
 	if (rev <=3D 5) {
-		hwif->drives[0].autotune =3D 1;
-		hwif->drives[1].autotune =3D 1;
 		printk("    %s: Winbond 553 bridge revision %d, BM-DMA disabled\n",
 		       hwif->name, rev);
 		dma_state &=3D ~0x60;
@@ -259,8 +454,28 @@
=20
 static void __init init_hwif_sl82c105(ide_hwif_t *hwif)
 {
-	hwif->tuneproc =3D tune_sl82c105;
+	struct pci_dev *dev =3D hwif->pci_dev;
+	u32 val;
+=09
+	DBG(("init_hwif_sl82c105(hwif: ide%d)\n", hwif->index));
=20
+	hwif->tuneproc =3D tune_sl82c105;
+	hwif->selectproc =3D sl82c105_selectproc;
+	hwif->resetproc =3D sl82c105_resetproc;
+=09
+	/* Default to PIO 0 for fallback unless tuned otherwise,
+	 * we always autotune PIO, this is done before DMA is
+	 * checked, so there is no risk of accidentally disabling
+	 * DMA
+	  */
+	hwif->drives[0].pio_speed =3D XFER_PIO_0;
+	hwif->drives[0].autotune =3D 1;
+	hwif->drives[1].pio_speed =3D XFER_PIO_1;
+	hwif->drives[1].autotune =3D 1;
+
+	pci_read_config_dword(dev, 0x40, &val);
+	*((u32 *)&hwif->hwif_data) =3D val;
+=09
 	if (!hwif->dma_base)
 		return;
=20
@@ -273,6 +488,10 @@
 	hwif->ide_dma_on =3D &sl82c105_ide_dma_on;
 	hwif->ide_dma_off =3D &sl82c105_ide_dma_off;
 	hwif->ide_dma_off_quietly =3D &sl82c105_ide_dma_off_quietly;
+	hwif->ide_dma_lostirq =3D &sl82c105_ide_dma_lost_irq;
+	hwif->ide_dma_begin =3D &sl82c105_ide_dma_begin;
+	hwif->ide_dma_timeout =3D &sl82c105_ide_dma_timeout;
+
 	if (!noautodma)
 		hwif->autodma =3D 1;
 	hwif->drives[0].autodma =3D hwif->autodma;
diff -Nru a/include/linux/ide.h b/include/linux/ide.h
--- a/include/linux/ide.h	Sat Jan 11 17:27:28 2003
+++ b/include/linux/ide.h	Sat Jan 11 17:27:28 2003
@@ -765,6 +765,7 @@
         u8	quirk_list;	/* considered quirky, set for a specific host */
         u8	suspend_reset;	/* drive suspend mode flag, soft-reset recovers =
*/
         u8	init_speed;	/* transfer rate set at boot */
+        u8	pio_speed;      /* unused by core, used by some drivers for fal=
lback from DMA */
         u8	current_speed;	/* current transfer rate set */
         u8	dn;		/* now wide spread use */
         u8	wcache;		/* status of write cache */

--=-Tm9lrPt41sMeISBPiu3z--
