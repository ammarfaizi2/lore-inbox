Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284195AbRLWXVZ>; Sun, 23 Dec 2001 18:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284191AbRLWXVM>; Sun, 23 Dec 2001 18:21:12 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:32528 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S284195AbRLWXUv>; Sun, 23 Dec 2001 18:20:51 -0500
Date: Mon, 24 Dec 2001 00:20:48 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: VIA IDE v3.33, with vt82c576, vt8233c, vt8233a (UDMA133) support
Message-ID: <20011224002048.A363@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Attached you can find an update to the VIA driver, against 2.5.1. It
adds support for an old revision of the vt82c576 chip, and for the new
vt8233c (vt8233 + 3Com NIC) and vt8233a (vt8233 + UDMA133) chips.

It was tested only on other VIA chips, as I don't have any of the newly
added ones, though it should just work on those.

Bundled are a couple changes to my entries in the MAINTAINERS file,
added an ID for the 8233a in pci_ids.h and with that a couple fixes to the
VIA entries in the file (order, tabs/spaces).

Please merge into 2.5.1. I think it can go into 2.4 later, as soon as it
gets enough testing.

-- 
Vojtech Pavlik
SuSE Labs

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-3.33.diff"

diff -urN linux/MAINTAINERS linux-via/MAINTAINERS
--- linux/MAINTAINERS	Mon Dec 10 19:39:20 2001
+++ linux-via/MAINTAINERS	Mon Dec 24 00:13:51 2001
@@ -843,7 +843,7 @@
 M:	vojtech@suse.cz
 L:	linux-joystick@atrey.karlin.mff.cuni.cz
 W:	http://www.suse.cz/development/joystick/
-S:	Supported
+S:	Maintained
 
 KERNEL AUTOMOUNTER (AUTOFS)
 P:	H. Peter Anvin
@@ -1538,7 +1538,7 @@
 M:	vojtech@suse.cz
 L:	linux-usb-users@lists.sourceforge.net
 L:	linux-usb-devel@lists.sourceforge.net
-S:	Supported
+S:	Maintained
 
 USB BLUETOOTH DRIVER
 P:	Greg Kroah-Hartman
@@ -1561,7 +1561,7 @@
 L:	linux-usb-users@lists.sourceforge.net
 L:	linux-usb-devel@lists.sourceforge.net
 W:	http://www.suse.cz/development/input/
-S:	Supported
+S:	Maintained
 
 USB HUB
 P:	Johannes Erdfelt
@@ -1612,7 +1612,7 @@
 M:	vojtech@suse.cz
 L:	linux-usb-users@lists.sourceforge.net
 L:	linux-usb-devel@lists.sourceforge.net
-S:	Supported
+S:	Maintained
 
 USB SE401 DRIVER
 P:	Jeroen Vreeken
diff -urN linux/drivers/ide/ide-timing.h linux-via/drivers/ide/ide-timing.h
--- linux/drivers/ide/ide-timing.h	Sat Feb  3 20:27:43 2001
+++ linux-via/drivers/ide/ide-timing.h	Mon Dec 24 00:04:13 2001
@@ -2,11 +2,9 @@
 #define _IDE_TIMING_H
 
 /*
- * $Id: ide-timing.h,v 1.5 2001/01/15 21:48:56 vojtech Exp $
+ * $Id: ide-timing.h,v 1.6 2001/12/23 22:47:56 vojtech Exp $
  *
- *  Copyright (c) 1999-2000 Vojtech Pavlik
- *
- *  Sponsored by SuSE
+ *  Copyright (c) 1999-2001 Vojtech Pavlik
  */
 
 /*
@@ -25,16 +23,14 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  *
  * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@suse.cz>, or by paper mail:
- * Vojtech Pavlik, Ucitelska 1576, Prague 8, 182 00 Czech Republic
+ * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
+ * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/hdreg.h>
 
-#ifndef XFER_PIO_5
 #define XFER_PIO_5		0x0d
 #define XFER_UDMA_SLOW		0x4f
-#endif
 
 struct ide_timing {
 	short mode;
@@ -49,13 +45,15 @@
 };
 
 /*
- * PIO 0-5, MWDMA 0-2 and UDMA 0-5 timings (in nanoseconds).
+ * PIO 0-5, MWDMA 0-2 and UDMA 0-6 timings (in nanoseconds).
  * These were taken from ATA/ATAPI-6 standard, rev 0a, except
- * for PIO 5, which is a nonstandard extension.
+ * for PIO 5, which is a nonstandard extension and UDMA6, which
+ * is currently supported only by Maxtor drives. 
  */
 
 static struct ide_timing ide_timing[] = {
 
+	{ XFER_UDMA_6,     0,   0,   0,   0,   0,   0,   0,  15 },
 	{ XFER_UDMA_5,     0,   0,   0,   0,   0,   0,   0,  20 },
 	{ XFER_UDMA_4,     0,   0,   0,   0,   0,   0,   0,  30 },
 	{ XFER_UDMA_3,     0,   0,   0,   0,   0,   0,   0,  45 },
@@ -105,6 +103,7 @@
 #define EZ(v,unit)	((v)?ENOUGH(v,unit):0)
 
 #define XFER_MODE	0xf0
+#define XFER_UDMA_133	0x48
 #define XFER_UDMA_100	0x44
 #define XFER_UDMA_66	0x42
 #define XFER_UDMA	0x40
@@ -123,6 +122,9 @@
 
 	if ((map & XFER_UDMA) && (id->field_valid & 4)) {	/* Want UDMA and UDMA bitmap valid */
 
+		if ((map & XFER_UDMA_133) == XFER_UDMA_133)
+			if ((best = (id->dma_ultra & 0x0040) ? XFER_UDMA_6 : 0)) return best;
+
 		if ((map & XFER_UDMA_100) == XFER_UDMA_100)
 			if ((best = (id->dma_ultra & 0x0020) ? XFER_UDMA_5 : 0)) return best;
 
@@ -174,14 +176,14 @@
 
 static void ide_timing_quantize(struct ide_timing *t, struct ide_timing *q, int T, int UT)
 {
-	q->setup   = EZ(t->setup,   T);
-	q->act8b   = EZ(t->act8b,   T);
-	q->rec8b   = EZ(t->rec8b,   T);
-	q->cyc8b   = EZ(t->cyc8b,   T);
-	q->active  = EZ(t->active,  T);
-	q->recover = EZ(t->recover, T);
-	q->cycle   = EZ(t->cycle,   T);
-	q->udma    = EZ(t->udma,   UT);
+	q->setup   = EZ(t->setup   * 1000,  T);
+	q->act8b   = EZ(t->act8b   * 1000,  T);
+	q->rec8b   = EZ(t->rec8b   * 1000,  T);
+	q->cyc8b   = EZ(t->cyc8b   * 1000,  T);
+	q->active  = EZ(t->active  * 1000,  T);
+	q->recover = EZ(t->recover * 1000,  T);
+	q->cycle   = EZ(t->cycle   * 1000,  T);
+	q->udma    = EZ(t->udma    * 1000, UT);
 }
 
 static void ide_timing_merge(struct ide_timing *a, struct ide_timing *b, struct ide_timing *m, unsigned int what)
diff -urN linux/drivers/ide/via82cxxx.c linux-via/drivers/ide/via82cxxx.c
--- linux/drivers/ide/via82cxxx.c	Tue Nov 27 18:23:27 2001
+++ linux-via/drivers/ide/via82cxxx.c	Mon Dec 24 00:09:23 2001
@@ -1,5 +1,5 @@
 /*
- * $Id: via82cxxx.c,v 3.29 2001/09/10 10:06:00 vojtech Exp $
+ * $Id: via82cxxx.c,v 3.33 2001/12/23 22:46:12 vojtech Exp $
  *
  *  Copyright (c) 2000-2001 Vojtech Pavlik
  *
@@ -7,23 +7,21 @@
  *	Michel Aubry
  *	Jeff Garzik
  *	Andre Hedrick
- *
- *  Sponsored by SuSE
  */
 
 /*
  * VIA IDE driver for Linux. Supports
  *
  *   vt82c576, vt82c586, vt82c586a, vt82c586b, vt82c596a, vt82c596b,
- *   vt82c686, vt82c686a, vt82c686b, vt8231, vt8233
+ *   vt82c686, vt82c686a, vt82c686b, vt8231, vt8233, vt8233c, vt8233a
  *
  * southbridges, which can be found in
  *
  *  VIA Apollo Master, VP, VP2, VP2/97, VP3, VPX, VPX/97, MVP3, MVP4, P6, Pro,
  *    ProII, ProPlus, Pro133, Pro133+, Pro133A, Pro133A Dual, Pro133T, Pro133Z,
  *    PLE133, PLE133T, Pro266, Pro266T, ProP4X266, PM601, PM133, PN133, PL133T,
- *    PX266, PM266, KX133, KT133, KT133A, KLE133, KT266, KX266, KM133, KM133A,
- *    KL133, KN133, KM266
+ *    PX266, PM266, KX133, KT133, KT133A, KT133E, KLE133, KT266, KX266, KM133,
+ *    KM133A, KL133, KN133, KM266
  *  PC-Chips VXPro, VXPro+, VXTwo, TXPro-III, TXPro-AGP, AGPPro, ViaGra, BXToo,
  *    BXTel, BXpert
  *  AMD 640, 640 AGP, 750 IronGate, 760, 760MP
@@ -32,9 +30,9 @@
  *
  * chipsets. Supports
  *
- *   PIO 0-5, MWDMA 0-2, SWDMA 0-2 and UDMA 0-5
+ *   PIO 0-5, MWDMA 0-2, SWDMA 0-2 and UDMA 0-6
  *
- * (this includes UDMA33, 66 and 100) modes. UDMA66 and higher modes are
+ * (this includes UDMA33, 66, 100 and 133) modes. UDMA66 and higher modes are
  * autoenabled only in case the BIOS has detected a 80 wire cable. To ignore
  * the BIOS data and assume the cable is present, use 'ide0=ata66' or
  * 'ide1=ata66' on the kernel command line.
@@ -56,8 +54,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  *
  * Should you need to contact me, the author, you can do so either by
- * e-mail - mail your message to <vojtech@suse.cz>, or by paper mail:
- * Vojtech Pavlik, Ucitelska 1576, Prague 8, 182 00 Czech Republic
+ * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
+ * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
 #include <linux/config.h>
@@ -87,10 +85,12 @@
 #define VIA_UDMA_33		0x001
 #define VIA_UDMA_66		0x002
 #define VIA_UDMA_100		0x003
+#define VIA_UDMA_133		0x004
 #define VIA_BAD_PREQ		0x010	/* Crashes if PREQ# till DDACK# set */
 #define VIA_BAD_CLK66		0x020	/* 66 MHz clock doesn't work correctly */
 #define VIA_SET_FIFO		0x040	/* Needs to have FIFO split set */
 #define VIA_NO_UNMASK		0x080	/* Doesn't work with IRQ unmasking on */
+#define VIA_BAD_ID		0x100	/* Has wrong vendor ID (0x1107) */
 
 /*
  * VIA SouthBridge chips.
@@ -104,10 +104,11 @@
 	unsigned short flags;
 } via_isa_bridges[] = {
 #ifdef FUTURE_BRIDGES
-	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_100 },
-	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_100 },
-	{ "vt8233c",	PCI_DEVICE_ID_VIA_8233C,    0x00, 0x2f, VIA_UDMA_100 },
+	{ "vt8237",	PCI_DEVICE_ID_VIA_8237,     0x00, 0x2f, VIA_UDMA_133 },
+	{ "vt8235",	PCI_DEVICE_ID_VIA_8235,     0x00, 0x2f, VIA_UDMA_133 },
 #endif
+	{ "vt8233a",	PCI_DEVICE_ID_VIA_8233A,    0x00, 0x2f, VIA_UDMA_133 },
+	{ "vt8233c",	PCI_DEVICE_ID_VIA_8233C_0,  0x00, 0x2f, VIA_UDMA_100 },
 	{ "vt8233",	PCI_DEVICE_ID_VIA_8233_0,   0x00, 0x2f, VIA_UDMA_100 },
 	{ "vt8231",	PCI_DEVICE_ID_VIA_8231,     0x00, 0x2f, VIA_UDMA_100 },
 	{ "vt82c686b",	PCI_DEVICE_ID_VIA_82C686,   0x40, 0x4f, VIA_UDMA_100 },
@@ -121,6 +122,7 @@
 	{ "vt82c586a",	PCI_DEVICE_ID_VIA_82C586_0, 0x20, 0x2f, VIA_UDMA_33 | VIA_SET_FIFO },
 	{ "vt82c586",	PCI_DEVICE_ID_VIA_82C586_0, 0x00, 0x0f, VIA_UDMA_NONE | VIA_SET_FIFO },
 	{ "vt82c576",	PCI_DEVICE_ID_VIA_82C576,   0x00, 0x2f, VIA_UDMA_NONE | VIA_SET_FIFO | VIA_NO_UNMASK },
+	{ "vt82c576",	PCI_DEVICE_ID_VIA_82C576,   0x00, 0x2f, VIA_UDMA_NONE | VIA_SET_FIFO | VIA_NO_UNMASK | VIA_BAD_ID },
 	{ NULL }
 };
 
@@ -128,7 +130,7 @@
 static unsigned char via_enabled;
 static unsigned int via_80w;
 static unsigned int via_clock;
-static char *via_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100" };
+static char *via_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100", "UDMA133" };
 
 /*
  * VIA /proc entry.
@@ -151,7 +153,7 @@
 
 static int via_get_info(char *buffer, char **addr, off_t offset, int count)
 {
-	short speed[4], cycle[4], setup[4], active[4], recover[4], den[4],
+	int speed[4], cycle[4], setup[4], active[4], recover[4], den[4],
 		 uen[4], udma[4], umul[4], active8b[4], recover8b[4];
 	struct pci_dev *dev = bmide_dev;
 	unsigned int v, u, i;
@@ -161,7 +163,7 @@
 
 	via_print("----------VIA BusMastering IDE Configuration----------------");
 
-	via_print("Driver Version:                     3.29");
+	via_print("Driver Version:                     3.33");
 	via_print("South Bridge:                       VIA %s", via_config->name);
 
 	pci_read_config_byte(isa_dev, PCI_REVISION_ID, &t);
@@ -170,7 +172,7 @@
 	via_print("Highest DMA rate:                   %s", via_dma[via_config->flags & VIA_UDMA]);
 
 	via_print("BM-DMA base:                        %#x", via_base);
-	via_print("PCI clock:                          %dMHz", via_clock);
+	via_print("PCI clock:                          %d.%dMHz", via_clock / 1000, via_clock / 100 % 10);
 
 	pci_read_config_byte(dev, VIA_MISC_1, &t);
 	via_print("Master Read  Cycle IRDY:            %dws", (t & 64) >> 6);
@@ -218,40 +220,45 @@
 		uen[i]       = ((u >> ((3 - i) << 3)) & 0x20);
 		den[i]       = (c & ((i & 1) ? 0x40 : 0x20) << ((i & 2) << 2));
 
-		speed[i] = 20 * via_clock / (active[i] + recover[i]);
-		cycle[i] = 1000 / via_clock * (active[i] + recover[i]);
+		speed[i] = 2 * via_clock / (active[i] + recover[i]);
+		cycle[i] = 1000000 * (active[i] + recover[i]) / via_clock;
 
 		if (!uen[i] || !den[i])
 			continue;
 
 		switch (via_config->flags & VIA_UDMA) {
-			
-			case VIA_UDMA_100:
-				speed[i] = 60 * via_clock / udma[i];
-				cycle[i] = 333 / via_clock * udma[i];
+
+			case VIA_UDMA_33:
+				speed[i] = 2 * via_clock / udma[i];
+				cycle[i] = 1000000 * udma[i] / via_clock;
 				break;
 
 			case VIA_UDMA_66:
-				speed[i] = 40 * via_clock / (udma[i] * umul[i]);
-				cycle[i] = 500 / via_clock * (udma[i] * umul[i]);
+				speed[i] = 4 * via_clock / (udma[i] * umul[i]);
+				cycle[i] = 500000 * (udma[i] * umul[i]) / via_clock;
 				break;
 
-			case VIA_UDMA_33:
-				speed[i] = 20 * via_clock / udma[i];
-				cycle[i] = 1000 / via_clock * udma[i];
+			case VIA_UDMA_100:
+				speed[i] = 6 * via_clock / udma[i];
+				cycle[i] = 333333 * udma[i] / via_clock;
+				break;
+
+			case VIA_UDMA_133:
+				speed[i] = 8 * via_clock / udma[i];
+				cycle[i] = 250000 * udma[i] / via_clock;
 				break;
 		}
 	}
 
 	via_print_drive("Transfer Mode: ", "%10s", den[i] ? (uen[i] ? "UDMA" : "DMA") : "PIO");
 
-	via_print_drive("Address Setup: ", "%8dns", (1000 / via_clock) * setup[i]);
-	via_print_drive("Cmd Active:    ", "%8dns", (1000 / via_clock) * active8b[i]);
-	via_print_drive("Cmd Recovery:  ", "%8dns", (1000 / via_clock) * recover8b[i]);
-	via_print_drive("Data Active:   ", "%8dns", (1000 / via_clock) * active[i]);
-	via_print_drive("Data Recovery: ", "%8dns", (1000 / via_clock) * recover[i]);
+	via_print_drive("Address Setup: ", "%8dns", 1000000 * setup[i] / via_clock);
+	via_print_drive("Cmd Active:    ", "%8dns", 1000000 * active8b[i] / via_clock);
+	via_print_drive("Cmd Recovery:  ", "%8dns", 1000000 * recover8b[i] / via_clock);
+	via_print_drive("Data Active:   ", "%8dns", 1000000 * active[i] / via_clock);
+	via_print_drive("Data Recovery: ", "%8dns", 1000000 * recover[i] / via_clock);
 	via_print_drive("Cycle Time:    ", "%8dns", cycle[i]);
-	via_print_drive("Transfer Rate: ", "%4d.%dMB/s", speed[i] / 10, speed[i] % 10);
+	via_print_drive("Transfer Rate: ", "%4d.%dMB/s", speed[i] / 1000, speed[i] / 100 % 10);
 
 	return p - buffer;	/* hoping it is less than 4K... */
 }
@@ -280,6 +287,7 @@
 		case VIA_UDMA_33:  t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 5) - 2)) : 0x03; break;
 		case VIA_UDMA_66:  t = timing->udma ? (0xe8 | (FIT(timing->udma, 2, 9) - 2)) : 0x0f; break;
 		case VIA_UDMA_100: t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 9) - 2)) : 0x07; break;
+		case VIA_UDMA_133: t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 9) - 2)) : 0x07; break;
 		default: return;
 	}
 
@@ -296,20 +304,21 @@
 {
 	ide_drive_t *peer = HWIF(drive)->drives + (~drive->dn & 1);
 	struct ide_timing t, p;
-	int T, UT;
+	unsigned int T, UT;
 
 	if (speed != XFER_PIO_SLOW && speed != drive->current_speed)
 		if (ide_config_drive_speed(drive, speed))
 			printk(KERN_WARNING "ide%d: Drive %d didn't accept speed setting. Oh, well.\n",
 				drive->dn >> 1, drive->dn & 1);
 
-	T = 1000 / via_clock;
+	T = 1000000000 / via_clock;
 
 	switch (via_config->flags & VIA_UDMA) {
 		case VIA_UDMA_33:   UT = T;   break;
 		case VIA_UDMA_66:   UT = T/2; break;
 		case VIA_UDMA_100:  UT = T/3; break;
-		default:	    UT = T;   break;
+		case VIA_UDMA_133:  UT = T/4; break;
+		default: UT = T;
 	}
 
 	ide_timing_compute(drive, speed, &t, T, UT);
@@ -365,7 +374,8 @@
 			XFER_PIO | XFER_EPIO | XFER_SWDMA | XFER_MWDMA |
 			(via_config->flags & VIA_UDMA ? XFER_UDMA : 0) |
 			(w80 && (via_config->flags & VIA_UDMA) >= VIA_UDMA_66 ? XFER_UDMA_66 : 0) |
-			(w80 && (via_config->flags & VIA_UDMA) >= VIA_UDMA_100 ? XFER_UDMA_100 : 0));
+			(w80 && (via_config->flags & VIA_UDMA) >= VIA_UDMA_100 ? XFER_UDMA_100 : 0) |
+			(w80 && (via_config->flags & VIA_UDMA) >= VIA_UDMA_133 ? XFER_UDMA_133 : 0));
 
 		via_set_drive(drive, speed);
 
@@ -395,14 +405,16 @@
  */
 
 	for (via_config = via_isa_bridges; via_config->id; via_config++)
-		if ((isa = pci_find_device(PCI_VENDOR_ID_VIA, via_config->id, NULL))) {
+		if ((isa = pci_find_device(PCI_VENDOR_ID_VIA +
+			!!(via_config->flags & VIA_BAD_ID), via_config->id, NULL))) {
+
 			pci_read_config_byte(isa, PCI_REVISION_ID, &t);
 			if (t >= via_config->rev_min && t <= via_config->rev_max)
 				break;
 		}
 
 	if (!via_config->id) {
-		printk(KERN_WARNING "VP_IDE: Unknown VIA SouthBridge, contact Vojtech Pavlik <vojtech@suse.cz>\n");
+		printk(KERN_WARNING "VP_IDE: Unknown VIA SouthBridge, contact Vojtech Pavlik <vojtech@ucw.cz>\n");
 		return -ENODEV;
 	}
 
@@ -412,22 +424,28 @@
 
 	switch (via_config->flags & VIA_UDMA) {
 
-		case VIA_UDMA_100:
-
-			pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
-			for (i = 24; i >= 0; i -= 8)
-				if (((u >> i) & 0x10) || (((u >> i) & 0x20) && (((u >> i) & 7) < 3)))
-					via_80w |= (1 << (1 - (i >> 4)));	/* BIOS 80-wire bit or UDMA w/ < 50ns/cycle */
-			break;
-
 		case VIA_UDMA_66:
-
 			pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);	/* Enable Clk66 */
 			pci_write_config_dword(dev, VIA_UDMA_TIMING, u | 0x80008);
 			for (i = 24; i >= 0; i -= 8)
 				if (((u >> (i & 16)) & 8) && ((u >> i) & 0x20) && (((u >> i) & 7) < 2))
 					via_80w |= (1 << (1 - (i >> 4)));	/* 2x PCI clock and UDMA w/ < 3T/cycle */
 			break;
+
+		case VIA_UDMA_100:
+			pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
+			for (i = 24; i >= 0; i -= 8)
+				if (((u >> i) & 0x10) || (((u >> i) & 0x20) && (((u >> i) & 7) < 4)))
+					via_80w |= (1 << (1 - (i >> 4)));	/* BIOS 80-wire bit or UDMA w/ < 60ns/cycle */
+			break;
+
+		case VIA_UDMA_133:
+			pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
+			for (i = 24; i >= 0; i -= 8)
+				if (((u >> i) & 0x10) || (((u >> i) & 0x20) && (((u >> i) & 7) < 8)))
+					via_80w |= (1 << (1 - (i >> 4)));	/* BIOS 80-wire bit or UDMA w/ < 60ns/cycle */
+			break;
+
 	}
 
 	if (via_config->flags & VIA_BAD_CLK66) {			/* Disable Clk66 */
@@ -466,10 +484,17 @@
  * Determine system bus clock.
  */
 
-	via_clock = system_bus_clock();
-	if (via_clock < 20 || via_clock > 50) {
+	via_clock = system_bus_clock() * 1000;
+
+	switch (via_clock) {
+		case 33000: via_clock = 33333; break;
+		case 37000: via_clock = 37500; break;
+		case 41000: via_clock = 41666; break;
+	}
+
+	if (via_clock < 20000 || via_clock > 50000) {
 		printk(KERN_WARNING "VP_IDE: User given PCI clock speed impossible (%d), using 33 MHz instead.\n", via_clock);
-		printk(KERN_WARNING "VP_IDE: Use ide0=ata66 if you want to force UDMA66/UDMA100.\n");
+		printk(KERN_WARNING "VP_IDE: Use ide0=ata66 if you want to assume 80-wire cable.\n");
 		via_clock = 33;
 	}
 
diff -urN linux/include/linux/pci_ids.h linux-via/include/linux/pci_ids.h
--- linux/include/linux/pci_ids.h	Sat Dec  8 01:26:13 2001
+++ linux-via/include/linux/pci_ids.h	Mon Dec 24 00:11:15 2001
@@ -946,11 +946,12 @@
 #define PCI_DEVICE_ID_VIA_8233_7	0x3065
 #define PCI_DEVICE_ID_VIA_82C686_6	0x3068
 #define PCI_DEVICE_ID_VIA_8233_0	0x3074
-#define PCI_DEVICE_ID_VIA_8622          0x3102 
-#define PCI_DEVICE_ID_VIA_8233C_0	0x3109
-#define PCI_DEVICE_ID_VIA_8361          0x3112 
 #define PCI_DEVICE_ID_VIA_8633_0	0x3091
 #define PCI_DEVICE_ID_VIA_8367_0	0x3099 
+#define PCI_DEVICE_ID_VIA_8622		0x3102 
+#define PCI_DEVICE_ID_VIA_8233C_0	0x3109
+#define PCI_DEVICE_ID_VIA_8361		0x3112 
+#define PCI_DEVICE_ID_VIA_8233A		0x3147
 #define PCI_DEVICE_ID_VIA_86C100A	0x6100
 #define PCI_DEVICE_ID_VIA_8231		0x8231
 #define PCI_DEVICE_ID_VIA_8231_4	0x8235
@@ -960,7 +961,7 @@
 #define PCI_DEVICE_ID_VIA_82C597_1	0x8597
 #define PCI_DEVICE_ID_VIA_82C598_1	0x8598
 #define PCI_DEVICE_ID_VIA_8601_1	0x8601
-#define PCI_DEVICE_ID_VIA_8505_1	0X8605
+#define PCI_DEVICE_ID_VIA_8505_1	0x8605
 #define PCI_DEVICE_ID_VIA_8633_1	0xB091
 #define PCI_DEVICE_ID_VIA_8367_1	0xB099
 

--ReaqsoxgOBHFXBhH--
