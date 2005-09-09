Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030720AbVIIWUB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030720AbVIIWUB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbVIIWUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:20:00 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:10183 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932577AbVIIWT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:19:59 -0400
Message-ID: <43220A8C.7070508@gentoo.org>
Date: Fri, 09 Sep 2005 23:19:56 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050820)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, posting@blx4.net,
       vsu@altlinux.ru
Subject: Re: [PATCH] via82cxxx IDE: Support multiple controllers
References: <43146CC3.4010005@gentoo.org> <58cb370e05083008121f2eb783@mail.gmail.com> <43179CC9.8090608@gentoo.org>
In-Reply-To: <43179CC9.8090608@gentoo.org>
Content-Type: multipart/mixed;
 boundary="------------030208010101050704080206"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030208010101050704080206
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Bart, any word on this? I know you're busy but it would be much appreciated if 
you could comment, even if it is hurling abuse ;)

Thanks.

Daniel Drake wrote:
> Hows this? I don't have any hardware with two VIA controllers, however I 
> have tested this on a pc which has a single vt8233a controller.
> 
> ---
> 
> Support multiple controllers in the via82cxxx IDE driver
> 
> Signed-off-by: Daniel Drake <dsd@gentoo.org>


--------------030208010101050704080206
Content-Type: text/x-patch;
 name="via82cxxx-multi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via82cxxx-multi.patch"

--- linux/drivers/ide/pci/via82cxxx.c.orig	2005-08-31 01:32:05.000000000 +0100
+++ linux/drivers/ide/pci/via82cxxx.c	2005-09-02 01:16:59.000000000 +0100
@@ -101,11 +101,19 @@ static struct via_isa_bridge {
 	{ NULL }
 };
 
-static struct via_isa_bridge *via_config;
-static unsigned int via_80w;
-static unsigned int via_clock;
 static char *via_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100", "UDMA133" };
 
+struct via82cxxx_dev
+{
+	struct pci_dev *pci_dev, *isa_dev;
+	struct via_isa_bridge *via_config;
+	unsigned int via_clock;
+	unsigned int via_80w;
+};
+
+#define VIA_MAX_CONTROLLERS 4
+static struct via82cxxx_dev *via_controllers[VIA_MAX_CONTROLLERS];
+
 /*
  * VIA /proc entry.
  */
@@ -116,9 +124,6 @@ static char *via_dma[] = { "MWDMA16", "U
 #include <linux/proc_fs.h>
 
 static u8 via_proc = 0;
-static unsigned long via_base;
-static struct pci_dev *bmide_dev, *isa_dev;
-
 static char *via_control3[] = { "No limit", "64", "128", "192" };
 
 #define via_print(format, arg...) p += sprintf(p, format "\n" , ## arg)
@@ -127,43 +132,42 @@ static char *via_control3[] = { "No limi
 
 
 /**
- *	via_get_info		-	generate via /proc file 
- *	@buffer: buffer for data
- *	@addr: set to start of data to use
- *	@offset: current file offset
- *	@count: size of read
+ *	via_print_controller_info	-	produce /proc info for one controller
+ *	@p: buffer for data
+ *	@hwif: hwif of controller
  *
  *	Fills in buffer with the debugging/configuration information for
- *	the VIA chipset tuning and attached drives
+ *	the VIA chipset tuning and attached drives on the specified
+ *	controller. Returns the end of the buffer that was reached.
  */
- 
-static int via_get_info(char *buffer, char **addr, off_t offset, int count)
+
+static char* via_print_controller_info(char *p, struct via82cxxx_dev *vdev)
 {
+	struct pci_dev *dev = vdev->pci_dev;
 	int speed[4], cycle[4], setup[4], active[4], recover[4], den[4],
 		 uen[4], udma[4], umul[4], active8b[4], recover8b[4];
-	struct pci_dev *dev = bmide_dev;
 	unsigned int v, u, i;
-	int len;
 	u16 c, w;
 	u8 t, x;
-	char *p = buffer;
+	unsigned long via_base;
 
 	via_print("----------VIA BusMastering IDE Configuration"
 		"----------------");
 
 	via_print("Driver Version:                     3.38");
 	via_print("South Bridge:                       VIA %s",
-		via_config->name);
+		vdev->via_config->name);
 
-	pci_read_config_byte(isa_dev, PCI_REVISION_ID, &t);
+	pci_read_config_byte(vdev->isa_dev, PCI_REVISION_ID, &t);
 	pci_read_config_byte(dev, PCI_REVISION_ID, &x);
 	via_print("Revision:                           ISA %#x IDE %#x", t, x);
 	via_print("Highest DMA rate:                   %s",
-		via_dma[via_config->flags & VIA_UDMA]);
+		via_dma[vdev->via_config->flags & VIA_UDMA]);
 
+	via_base = pci_resource_start(dev, 4);
 	via_print("BM-DMA base:                        %#lx", via_base);
 	via_print("PCI clock:                          %d.%dMHz",
-		via_clock / 1000, via_clock / 100 % 10);
+		vdev->via_clock / 1000, vdev->via_clock / 100 % 10);
 
 	pci_read_config_byte(dev, VIA_MISC_1, &t);
 	via_print("Master Read  Cycle IRDY:            %dws",
@@ -199,7 +203,7 @@ static int via_get_info(char *buffer, ch
 		(c & 0x80) ? "yes" : "no", (c & 0x8000) ? "yes" : "no");
 
 	via_print("Cable Type:            %10s%20s",
-		(via_80w & 1) ? "80w" : "40w", (via_80w & 2) ? "80w" : "40w");
+		(vdev->via_80w & 1) ? "80w" : "40w", (vdev->via_80w & 2) ? "80w" : "40w");
 
 	via_print("-------------------drive0----drive1"
 		"----drive2----drive3-----");
@@ -208,7 +212,7 @@ static int via_get_info(char *buffer, ch
 	pci_read_config_dword(dev, VIA_DRIVE_TIMING, &v);
 	pci_read_config_word(dev, VIA_8BIT_TIMING, &w);
 
-	if (via_config->flags & VIA_UDMA)
+	if (vdev->via_config->flags & VIA_UDMA)
 		pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
 	else u = 0;
 
@@ -224,32 +228,32 @@ static int via_get_info(char *buffer, ch
 		uen[i]       = ((u >> ((3 - i) << 3)) & 0x20);
 		den[i]       = (c & ((i & 1) ? 0x40 : 0x20) << ((i & 2) << 2));
 
-		speed[i] = 2 * via_clock / (active[i] + recover[i]);
-		cycle[i] = 1000000 * (active[i] + recover[i]) / via_clock;
+		speed[i] = 2 * vdev->via_clock / (active[i] + recover[i]);
+		cycle[i] = 1000000 * (active[i] + recover[i]) / vdev->via_clock;
 
 		if (!uen[i] || !den[i])
 			continue;
 
-		switch (via_config->flags & VIA_UDMA) {
+		switch (vdev->via_config->flags & VIA_UDMA) {
 
 			case VIA_UDMA_33:
-				speed[i] = 2 * via_clock / udma[i];
-				cycle[i] = 1000000 * udma[i] / via_clock;
+				speed[i] = 2 * vdev->via_clock / udma[i];
+				cycle[i] = 1000000 * udma[i] / vdev->via_clock;
 				break;
 
 			case VIA_UDMA_66:
-				speed[i] = 4 * via_clock / (udma[i] * umul[i]);
-				cycle[i] = 500000 * (udma[i] * umul[i]) / via_clock;
+				speed[i] = 4 * vdev->via_clock / (udma[i] * umul[i]);
+				cycle[i] = 500000 * (udma[i] * umul[i]) / vdev->via_clock;
 				break;
 
 			case VIA_UDMA_100:
-				speed[i] = 6 * via_clock / udma[i];
-				cycle[i] = 333333 * udma[i] / via_clock;
+				speed[i] = 6 * vdev->via_clock / udma[i];
+				cycle[i] = 333333 * udma[i] / vdev->via_clock;
 				break;
 
 			case VIA_UDMA_133:
-				speed[i] = 8 * via_clock / udma[i];
-				cycle[i] = 250000 * udma[i] / via_clock;
+				speed[i] = 8 * vdev->via_clock / udma[i];
+				cycle[i] = 250000 * udma[i] / vdev->via_clock;
 				break;
 		}
 	}
@@ -258,20 +262,46 @@ static int via_get_info(char *buffer, ch
 		den[i] ? (uen[i] ? "UDMA" : "DMA") : "PIO");
 
 	via_print_drive("Address Setup: ", "%8dns",
-		1000000 * setup[i] / via_clock);
+		1000000 * setup[i] / vdev->via_clock);
 	via_print_drive("Cmd Active:    ", "%8dns",
-		1000000 * active8b[i] / via_clock);
+		1000000 * active8b[i] / vdev->via_clock);
 	via_print_drive("Cmd Recovery:  ", "%8dns",
-		1000000 * recover8b[i] / via_clock);
+		1000000 * recover8b[i] / vdev->via_clock);
 	via_print_drive("Data Active:   ", "%8dns",
-		1000000 * active[i] / via_clock);
+		1000000 * active[i] / vdev->via_clock);
 	via_print_drive("Data Recovery: ", "%8dns",
-		1000000 * recover[i] / via_clock);
+		1000000 * recover[i] / vdev->via_clock);
 	via_print_drive("Cycle Time:    ", "%8dns",
 		cycle[i]);
 	via_print_drive("Transfer Rate: ", "%4d.%dMB/s",
 		speed[i] / 1000, speed[i] / 100 % 10);
 
+	return p;
+}
+
+/**
+ *	via_get_info		-	generate via /proc file 
+ *	@buffer: buffer for data
+ *	@addr: set to start of data to use
+ *	@offset: current file offset
+ *	@count: size of read
+ *
+ *	Fills in buffer with the debugging/configuration information for
+ *	the VIA chipset tuning and attached drives of all controllers
+ */
+ 
+static int via_get_info(char *buffer, char **addr, off_t offset, int count)
+{
+	unsigned int i;
+	int len;
+	char *p = buffer;
+
+	for (i = 0; i < VIA_MAX_CONTROLLERS; i++)
+		if (via_controllers[i] != NULL) {
+			via_print("====== CONTROLLER %d ======\n", i+1);
+			p = via_print_controller_info(p, via_controllers[i]);
+		}
+
 	/* hoping it is less than 4K... */
 	len = (p - buffer) - offset;
 	*addr = buffer + offset;
@@ -283,18 +313,20 @@ static int via_get_info(char *buffer, ch
 
 /**
  *	via_set_speed			-	write timing registers
- *	@dev: PCI device
+ *	@hwif: hwif of device
  *	@dn: device
  *	@timing: IDE timing data to use
  *
  *	via_set_speed writes timing values to the chipset registers
  */
 
-static void via_set_speed(struct pci_dev *dev, u8 dn, struct ide_timing *timing)
+static void via_set_speed(ide_hwif_t *hwif, u8 dn, struct ide_timing *timing)
 {
+	struct pci_dev *dev = hwif->pci_dev;
+	struct via82cxxx_dev *vdev = ide_get_hwifdata(hwif);
 	u8 t;
 
-	if (~via_config->flags & VIA_BAD_AST) {
+	if (~vdev->via_config->flags & VIA_BAD_AST) {
 		pci_read_config_byte(dev, VIA_ADDRESS_SETUP, &t);
 		t = (t & ~(3 << ((3 - dn) << 1))) | ((FIT(timing->setup, 1, 4) - 1) << ((3 - dn) << 1));
 		pci_write_config_byte(dev, VIA_ADDRESS_SETUP, t);
@@ -306,7 +338,7 @@ static void via_set_speed(struct pci_dev
 	pci_write_config_byte(dev, VIA_DRIVE_TIMING + (3 - dn),
 		((FIT(timing->active, 1, 16) - 1) << 4) | (FIT(timing->recover, 1, 16) - 1));
 
-	switch (via_config->flags & VIA_UDMA) {
+	switch (vdev->via_config->flags & VIA_UDMA) {
 		case VIA_UDMA_33:  t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 5) - 2)) : 0x03; break;
 		case VIA_UDMA_66:  t = timing->udma ? (0xe8 | (FIT(timing->udma, 2, 9) - 2)) : 0x0f; break;
 		case VIA_UDMA_100: t = timing->udma ? (0xe0 | (FIT(timing->udma, 2, 9) - 2)) : 0x07; break;
@@ -330,15 +362,16 @@ static void via_set_speed(struct pci_dev
 static int via_set_drive(ide_drive_t *drive, u8 speed)
 {
 	ide_drive_t *peer = HWIF(drive)->drives + (~drive->dn & 1);
+	struct via82cxxx_dev *vdev = ide_get_hwifdata(drive->hwif);
 	struct ide_timing t, p;
 	unsigned int T, UT;
 
 	if (speed != XFER_PIO_SLOW)
 		ide_config_drive_speed(drive, speed);
 
-	T = 1000000000 / via_clock;
+	T = 1000000000 / vdev->via_clock;
 
-	switch (via_config->flags & VIA_UDMA) {
+	switch (vdev->via_config->flags & VIA_UDMA) {
 		case VIA_UDMA_33:   UT = T;   break;
 		case VIA_UDMA_66:   UT = T/2; break;
 		case VIA_UDMA_100:  UT = T/3; break;
@@ -353,7 +386,7 @@ static int via_set_drive(ide_drive_t *dr
 		ide_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
 	}
 
-	via_set_speed(HWIF(drive)->pci_dev, drive->dn, &t);
+	via_set_speed(HWIF(drive), drive->dn, &t);
 
 	if (!drive->init_speed)
 		drive->init_speed = speed;
@@ -391,20 +424,22 @@ static void via82cxxx_tune_drive(ide_dri
  
 static int via82cxxx_ide_dma_check (ide_drive_t *drive)
 {
-	u16 w80 = HWIF(drive)->udma_four;
+	ide_hwif_t *hwif = HWIF(drive);
+	struct via82cxxx_dev *vdev = ide_get_hwifdata(hwif);
+	u16 w80 = hwif->udma_four;
 
 	u16 speed = ide_find_best_mode(drive,
 		XFER_PIO | XFER_EPIO | XFER_SWDMA | XFER_MWDMA |
-		(via_config->flags & VIA_UDMA ? XFER_UDMA : 0) |
-		(w80 && (via_config->flags & VIA_UDMA) >= VIA_UDMA_66 ? XFER_UDMA_66 : 0) |
-		(w80 && (via_config->flags & VIA_UDMA) >= VIA_UDMA_100 ? XFER_UDMA_100 : 0) |
-		(w80 && (via_config->flags & VIA_UDMA) >= VIA_UDMA_133 ? XFER_UDMA_133 : 0));
+		(vdev->via_config->flags & VIA_UDMA ? XFER_UDMA : 0) |
+		(w80 && (vdev->via_config->flags & VIA_UDMA) >= VIA_UDMA_66 ? XFER_UDMA_66 : 0) |
+		(w80 && (vdev->via_config->flags & VIA_UDMA) >= VIA_UDMA_100 ? XFER_UDMA_100 : 0) |
+		(w80 && (vdev->via_config->flags & VIA_UDMA) >= VIA_UDMA_133 ? XFER_UDMA_133 : 0));
 
 	via_set_drive(drive, speed);
 
 	if (drive->autodma && (speed & XFER_MODE) != XFER_PIO)
-		return HWIF(drive)->ide_dma_on(drive);
-	return HWIF(drive)->ide_dma_off_quietly(drive);
+		return hwif->ide_dma_on(drive);
+	return hwif->ide_dma_off_quietly(drive);
 }
 
 /**
@@ -418,9 +453,11 @@ static int via82cxxx_ide_dma_check (ide_
 
 static unsigned int __devinit init_chipset_via82cxxx(struct pci_dev *dev, const char *name)
 {
+	struct via82cxxx_dev *vdev;
+	struct via_isa_bridge *via_config;
 	struct pci_dev *isa = NULL;
 	u8 t, v;
-	unsigned int u;
+	unsigned int via_80w = 0, via_clock, u;
 	int i;
 
 	/*
@@ -444,6 +481,28 @@ static unsigned int __devinit init_chips
 	}
 
 	/*
+	 * Allocate and index a via82cxxx_dev for this controller
+	 */
+
+	for (i = 0; i <= VIA_MAX_CONTROLLERS; i++)
+		if (via_controllers[i] == NULL)
+			break;
+
+	if (i == VIA_MAX_CONTROLLERS) {
+		printk(KERN_WARNING "VP_IDE: Controller limit reached.\n");
+		return -ENODEV;
+	}
+
+	vdev = kmalloc(sizeof(struct via82cxxx_dev), GFP_KERNEL);
+	if (vdev == NULL) {
+		printk(KERN_ERR "VP_IDE: out of memory :(\n");
+		return -ENODEV;
+	}
+
+	memset(vdev, 0, sizeof(struct via82cxxx_dev));
+	via_controllers[i] = vdev;
+
+	/*
 	 * Check 80-wire cable presence and setup Clk66.
 	 */
 
@@ -562,14 +621,20 @@ static unsigned int __devinit init_chips
 		pci_name(dev));
 
 	/*
+	 * Populate our via82cxxx_dev
+	 */
+	vdev->pci_dev = dev;
+	vdev->isa_dev = isa;
+	vdev->via_config = via_config;
+	vdev->via_clock = via_clock;
+	vdev->via_80w = via_80w;
+
+	/*
 	 * Setup /proc/ide/via entry.
 	 */
 
 #if defined(DISPLAY_VIA_TIMINGS) && defined(CONFIG_PROC_FS)
 	if (!via_proc) {
-		via_base = pci_resource_start(dev, 4);
-		bmide_dev = dev;
-		isa_dev = isa;
 		ide_pci_create_host_proc("via", via_get_info);
 		via_proc = 1;
 	}
@@ -580,6 +645,19 @@ static unsigned int __devinit init_chips
 static void __devinit init_hwif_via82cxxx(ide_hwif_t *hwif)
 {
 	int i;
+	struct via82cxxx_dev *vdev;
+
+	/*
+	 * Find the via82cxxx_dev we created at init_chipset time
+	 */
+
+	for (i = 0; i < VIA_MAX_CONTROLLERS; i++)
+		if (via_controllers[i] != NULL
+			&& via_controllers[i]->pci_dev == hwif->pci_dev)
+			break;
+
+	vdev = via_controllers[i];
+	ide_set_hwifdata(hwif, vdev);
 
 	hwif->autodma = 0;
 
@@ -595,7 +673,7 @@ static void __devinit init_hwif_via82cxx
 
 	for (i = 0; i < 2; i++) {
 		hwif->drives[i].io_32bit = 1;
-		hwif->drives[i].unmask = (via_config->flags & VIA_NO_UNMASK) ? 0 : 1;
+		hwif->drives[i].unmask = (vdev->via_config->flags & VIA_NO_UNMASK) ? 0 : 1;
 		hwif->drives[i].autotune = 1;
 		hwif->drives[i].dn = hwif->channel * 2 + i;
 	}
@@ -609,7 +687,7 @@ static void __devinit init_hwif_via82cxx
 	hwif->swdma_mask = 0x07;
 
 	if (!hwif->udma_four)
-		hwif->udma_four = (via_80w >> hwif->channel) & 1;
+		hwif->udma_four = (vdev->via_80w >> hwif->channel) & 1;
 	hwif->ide_dma_check = &via82cxxx_ide_dma_check;
 	if (!noautodma)
 		hwif->autodma = 1;
@@ -658,6 +736,7 @@ static struct pci_driver driver = {
 
 static int via_ide_init(void)
 {
+	memset(via_controllers, 0, sizeof(via_controllers));
 	return ide_pci_register_driver(&driver);
 }
 

--------------030208010101050704080206--
