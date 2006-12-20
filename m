Return-Path: <linux-kernel-owner+w=401wt.eu-S1754801AbWLTMCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801AbWLTMCY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 07:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbWLTMCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 07:02:14 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1602 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964977AbWLTMCG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 07:02:06 -0500
Date: Wed, 20 Dec 2006 12:02:00 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>
cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH 2.6.20-rc1 06/10] tgafb: TURBOchannel support
Message-ID: <Pine.LNX.4.64N.0612201104460.11005@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This is support for the TC variations of the TGA boards (properly known 
as SFB+ or Smart Frame Buffer Plus boards).  The 8-plane SFB+ board uses 
the Bt459 RAMDAC (unlike its PCI counterpart, which uses the Bt485), so 
bits have been added to support this chip as well.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 These changes have been tested at the run time with an 8-plane and a 
24-plane TC board (ZLX-E1 and ZLX-E3).  As I have no PCI TGA hardware, I 
could not test these at the run time (it built with no problems for the 
Alpha), but I took care not to break support for these and I do hope I 
succeeded. ;-)

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-hx+-70
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/video/Kconfig linux-mips-2.6.18-20060920/drivers/video/Kconfig
--- linux-mips-2.6.18-20060920.macro/drivers/video/Kconfig	2006-08-21 04:55:25.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/video/Kconfig	2006-12-12 14:39:01.000000000 +0000
@@ -531,14 +531,24 @@ config FB_HP300
 	default y
 
 config FB_TGA
-	tristate "TGA framebuffer support"
-	depends on FB && ALPHA
+	tristate "TGA/SFB+ framebuffer support"
+	depends on FB && (ALPHA || TC)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	help
-	  This is the frame buffer device driver for generic TGA graphic
-	  cards. Say Y if you have one of those.
+	  This is the frame buffer device driver for generic TGA and SFB+
+	  graphic cards.  These include DEC ZLXp-E1, E2 and E3 PCI cards,
+	  also known as PBXGA-A, B and C, and DEC ZLX-E1, E2 and E3
+	  TURBOchannel cards, also known as PMAGD-A, B and C.
+
+	  Due to hardware limitations ZLX-E2 and E3 cards are not supported
+	  for DECstation 5000/200 systems.  Additionally due to firmware
+	  limitations these cards may cause troubles with booting DECstation
+	  5000/240 and /260 systems, but are fully supported under Linux if
+	  you manage to get it going.
+
+	  Say Y if you have one of those.
 
 config FB_VESA
 	bool "VESA VGA graphics support"
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c linux-mips-2.6.18-20060920/drivers/video/tgafb.c
--- linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c	2006-12-14 01:00:00.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/video/tgafb.c	2006-12-16 14:38:34.000000000 +0000
@@ -5,27 +5,45 @@
  *	Copyright (C) 1997 Geert Uytterhoeven
  *	Copyright (C) 1999,2000 Martin Lucina, Tom Zerucha
  *	Copyright (C) 2002 Richard Henderson
+ *	Copyright (C) 2006 Maciej W. Rozycki
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License. See the file COPYING in the main directory of this archive for
  *  more details.
  */
 
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
 #include <linux/delay.h>
-#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/sched.h>
 #include <linux/selection.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/tc.h>
+
 #include <asm/io.h>
+
 #include <video/tgafb.h>
 
+#ifdef CONFIG_PCI
+#define TGA_BUS_PCI(dev) (dev->bus == &pci_bus_type)
+#else
+#define TGA_BUS_PCI(dev) 0
+#endif
+
+#ifdef CONFIG_TC
+#define TGA_BUS_TC(dev) (dev->bus == &tc_bus_type)
+#else
+#define TGA_BUS_TC(dev) 0
+#endif
+
 /*
  * Local functions.
  */
@@ -42,12 +60,16 @@ static void tgafb_imageblit(struct fb_in
 static void tgafb_fillrect(struct fb_info *, const struct fb_fillrect *);
 static void tgafb_copyarea(struct fb_info *, const struct fb_copyarea *);
 
-static int __devinit tgafb_pci_register(struct pci_dev *,
-					const struct pci_device_id *);
-static void __devexit tgafb_pci_unregister(struct pci_dev *);
+static int __devinit tgafb_register(struct device *dev);
+static void __devexit tgafb_unregister(struct device *dev);
+
+static const char *mode_option;
+static const char *mode_option_pci = "640x480@60";
+static const char *mode_option_tc = "1280x1024@72";
 
-static const char *mode_option = "640x480@60";
 
+static struct pci_driver tgafb_pci_driver;
+static struct tc_driver tgafb_tc_driver;
 
 /*
  *  Frame buffer operations
@@ -65,9 +87,13 @@ static struct fb_ops tgafb_ops = {
 };
 
 
+#ifdef CONFIG_PCI
 /*
  *  PCI registration operations
  */
+static int __devinit tgafb_pci_register(struct pci_dev *,
+					const struct pci_device_id *);
+static void __devexit tgafb_pci_unregister(struct pci_dev *);
 
 static struct pci_device_id const tgafb_pci_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_TGA) },
@@ -75,13 +101,68 @@ static struct pci_device_id const tgafb_
 };
 MODULE_DEVICE_TABLE(pci, tgafb_pci_table);
 
-static struct pci_driver tgafb_driver = {
+static struct pci_driver tgafb_pci_driver = {
 	.name			= "tgafb",
 	.id_table		= tgafb_pci_table,
 	.probe			= tgafb_pci_register,
 	.remove			= __devexit_p(tgafb_pci_unregister),
 };
 
+static int __devinit
+tgafb_pci_register(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	return tgafb_register(&pdev->dev);
+}
+
+static void __devexit
+tgafb_pci_unregister(struct pci_dev *pdev)
+{
+	tgafb_unregister(&pdev->dev);
+}
+#endif /* CONFIG_PCI */
+
+#ifdef CONFIG_TC
+/*
+ *  TC registration operations
+ */
+static int __devinit tgafb_tc_register(struct device *);
+static int __devexit tgafb_tc_unregister(struct device *);
+
+static struct tc_device_id const tgafb_tc_table[] = {
+	{ "DEC     ", "PMAGD-AA" },
+	{ "DEC     ", "PMAGD   " },
+	{ }
+};
+MODULE_DEVICE_TABLE(tc, tgafb_tc_table);
+
+static struct tc_driver tgafb_tc_driver = {
+	.id_table		= tgafb_tc_table,
+	.driver			= {
+		.name		= "tgafb",
+		.bus		= &tc_bus_type,
+		.probe		= tgafb_tc_register,
+		.remove		= __devexit_p(tgafb_tc_unregister),
+	},
+};
+
+static int __devinit
+tgafb_tc_register(struct device *dev)
+{
+	int status = tgafb_register(dev);
+	if (!status)
+		get_device(dev);
+	return status;
+}
+
+static int __devexit
+tgafb_tc_unregister(struct device *dev)
+{
+	put_device(dev);
+	tgafb_unregister(dev);
+	return 0;
+}
+#endif /* CONFIG_TC */
+
 
 /**
  *      tgafb_check_var - Optional function.  Validates a var passed in.
@@ -132,10 +213,10 @@ static int
 tgafb_set_par(struct fb_info *info)
 {
 	static unsigned int const deep_presets[4] = {
-		0x00014000,
-		0x0001440d,
+		0x00004000,
+		0x0000440d,
 		0xffffffff,
-		0x0001441d
+		0x0000441d
 	};
 	static unsigned int const rasterop_presets[4] = {
 		0x00000003,
@@ -157,6 +238,8 @@ tgafb_set_par(struct fb_info *info)
 	};
 
 	struct tga_par *par = (struct tga_par *) info->par;
+	int tga_bus_pci = TGA_BUS_PCI(par->dev);
+	int tga_bus_tc = TGA_BUS_TC(par->dev);
 	u32 htimings, vtimings, pll_freq;
 	u8 tga_type;
 	int i;
@@ -221,7 +304,7 @@ tgafb_set_par(struct fb_info *info)
 	TGA_WRITE_REG(par, vtimings, TGA_VERT_REG);
 
 	/* Initalise RAMDAC. */
-	if (tga_type == TGA_TYPE_8PLANE) {
+	if (tga_type == TGA_TYPE_8PLANE && tga_bus_pci) {
 
 		/* Init BT485 RAMDAC registers.  */
 		BT485_WRITE(par, 0xa2 | (par->sync_on_green ? 0x8 : 0x0),
@@ -261,6 +344,38 @@ tgafb_set_par(struct fb_info *info)
 				      TGA_RAMDAC_REG);
 		}
 
+	} else if (tga_type == TGA_TYPE_8PLANE && tga_bus_tc) {
+
+		/* Init BT459 RAMDAC registers.  */
+		BT459_WRITE(par, BT459_REG_ACC, BT459_CMD_REG_0, 0x40);
+		BT459_WRITE(par, BT459_REG_ACC, BT459_CMD_REG_1, 0x00);
+		BT459_WRITE(par, BT459_REG_ACC, BT459_CMD_REG_2,
+			    (par->sync_on_green ? 0xc0 : 0x40));
+
+		BT459_WRITE(par, BT459_REG_ACC, BT459_CUR_CMD_REG, 0x00);
+
+		/* Fill the palette.  */
+		BT459_LOAD_ADDR(par, 0x0000);
+		TGA_WRITE_REG(par, BT459_PALETTE << 2, TGA_RAMDAC_SETUP_REG);
+
+#ifdef CONFIG_HW_CONSOLE
+		for (i = 0; i < 16; i++) {
+			int j = color_table[i];
+
+			TGA_WRITE_REG(par, default_red[j], TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, default_grn[j], TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, default_blu[j], TGA_RAMDAC_REG);
+		}
+		for (i = 0; i < 240 * 3; i += 4) {
+#else
+		for (i = 0; i < 256 * 3; i += 4) {
+#endif
+			TGA_WRITE_REG(par, 0x55, TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, 0x00, TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, 0x00, TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, 0x00, TGA_RAMDAC_REG);
+		}
+
 	} else { /* 24-plane or 24plusZ */
 
 		/* Init BT463 RAMDAC registers.  */
@@ -431,6 +546,8 @@ tgafb_setcolreg(unsigned regno, unsigned
 		unsigned transp, struct fb_info *info)
 {
 	struct tga_par *par = (struct tga_par *) info->par;
+	int tga_bus_pci = TGA_BUS_PCI(par->dev);
+	int tga_bus_tc = TGA_BUS_TC(par->dev);
 
 	if (regno > 255)
 		return 1;
@@ -438,12 +555,18 @@ tgafb_setcolreg(unsigned regno, unsigned
 	green >>= 8;
 	blue >>= 8;
 
-	if (par->tga_type == TGA_TYPE_8PLANE) {
+	if (par->tga_type == TGA_TYPE_8PLANE && tga_bus_pci) {
 		BT485_WRITE(par, regno, BT485_ADDR_PAL_WRITE);
 		TGA_WRITE_REG(par, BT485_DATA_PAL, TGA_RAMDAC_SETUP_REG);
 		TGA_WRITE_REG(par, red|(BT485_DATA_PAL<<8),TGA_RAMDAC_REG);
 		TGA_WRITE_REG(par, green|(BT485_DATA_PAL<<8),TGA_RAMDAC_REG);
 		TGA_WRITE_REG(par, blue|(BT485_DATA_PAL<<8),TGA_RAMDAC_REG);
+	} else if (par->tga_type == TGA_TYPE_8PLANE && tga_bus_tc) {
+		BT459_LOAD_ADDR(par, regno);
+		TGA_WRITE_REG(par, BT459_PALETTE << 2, TGA_RAMDAC_SETUP_REG);
+		TGA_WRITE_REG(par, red, TGA_RAMDAC_REG);
+		TGA_WRITE_REG(par, green, TGA_RAMDAC_REG);
+		TGA_WRITE_REG(par, blue, TGA_RAMDAC_REG);
 	} else {
 		if (regno < 16) {
 			u32 value = (regno << 16) | (regno << 8) | regno;
@@ -1344,18 +1467,29 @@ static void
 tgafb_init_fix(struct fb_info *info)
 {
 	struct tga_par *par = (struct tga_par *)info->par;
+	int tga_bus_pci = TGA_BUS_PCI(par->dev);
+	int tga_bus_tc = TGA_BUS_TC(par->dev);
 	u8 tga_type = par->tga_type;
-	const char *tga_type_name;
+	const char *tga_type_name = NULL;
 
 	switch (tga_type) {
 	case TGA_TYPE_8PLANE:
-		tga_type_name = "Digital ZLXp-E1";
+		if (tga_bus_pci)
+			tga_type_name = "Digital ZLXp-E1";
+		if (tga_bus_tc)
+			tga_type_name = "Digital ZLX-E1";
 		break;
 	case TGA_TYPE_24PLANE:
-		tga_type_name = "Digital ZLXp-E2";
+		if (tga_bus_pci)
+			tga_type_name = "Digital ZLXp-E2";
+		if (tga_bus_tc)
+			tga_type_name = "Digital ZLX-E2";
 		break;
 	case TGA_TYPE_24PLUSZ:
-		tga_type_name = "Digital ZLXp-E3";
+		if (tga_bus_pci)
+			tga_type_name = "Digital ZLXp-E3";
+		if (tga_bus_tc)
+			tga_type_name = "Digital ZLX-E3";
 		break;
 	default:
 		tga_type_name = "Unknown";
@@ -1383,9 +1517,16 @@ tgafb_init_fix(struct fb_info *info)
 	info->fix.accel = FB_ACCEL_DEC_TGA;
 }
 
-static __devinit int
-tgafb_pci_register(struct pci_dev *pdev, const struct pci_device_id *ent)
+static int __devinit
+tgafb_register(struct device *dev)
 {
+	static const struct fb_videomode modedb_tc = {
+		/* 1280x1024 @ 72 Hz, 76.8 kHz hsync */
+		/*                 1284, 1024, ????, 224, 28, 33, 3, 160, 3  */
+		"1280x1024@72", 0, 1280, 1024, 7645, 224, 28, 33, 3, 160, 3,
+		FB_SYNC_ON_GREEN, FB_VMODE_NONINTERLACED
+	};
+
 	static unsigned int const fb_offset_presets[4] = {
 		TGA_8PLANE_FB_OFFSET,
 		TGA_24PLANE_FB_OFFSET,
@@ -1393,40 +1534,51 @@ tgafb_pci_register(struct pci_dev *pdev,
 		TGA_24PLUSZ_FB_OFFSET
 	};
 
+	const struct fb_videomode *modedb_tga = NULL;
+	resource_size_t bar0_start = 0, bar0_len = 0;
+	const char *mode_option_tga = NULL;
+	int tga_bus_pci = TGA_BUS_PCI(dev);
+	int tga_bus_tc = TGA_BUS_TC(dev);
+	unsigned int modedbsize_tga = 0;
 	void __iomem *mem_base;
-	unsigned long bar0_start, bar0_len;
 	struct fb_info *info;
 	struct tga_par *par;
 	u8 tga_type;
-	int ret;
+	int ret = 0;
 
 	/* Enable device in PCI config.  */
-	if (pci_enable_device(pdev)) {
+	if (tga_bus_pci && pci_enable_device(to_pci_dev(dev))) {
 		printk(KERN_ERR "tgafb: Cannot enable PCI device\n");
 		return -ENODEV;
 	}
 
 	/* Allocate the fb and par structures.  */
-	info = framebuffer_alloc(sizeof(struct tga_par), &pdev->dev);
+	info = framebuffer_alloc(sizeof(struct tga_par), dev);
 	if (!info) {
 		printk(KERN_ERR "tgafb: Cannot allocate memory\n");
 		return -ENOMEM;
 	}
 
 	par = info->par;
-	pci_set_drvdata(pdev, info);
+	dev_set_drvdata(dev, info);
 
 	/* Request the mem regions.  */
-	bar0_start = pci_resource_start(pdev, 0);
-	bar0_len = pci_resource_len(pdev, 0);
 	ret = -ENODEV;
+	if (tga_bus_pci) {
+		bar0_start = pci_resource_start(to_pci_dev(dev), 0);
+		bar0_len = pci_resource_len(to_pci_dev(dev), 0);
+	}
+	if (tga_bus_tc) {
+		bar0_start = to_tc_dev(dev)->resource.start;
+		bar0_len = to_tc_dev(dev)->resource.end - bar0_start + 1;
+	}
 	if (!request_mem_region (bar0_start, bar0_len, "tgafb")) {
 		printk(KERN_ERR "tgafb: cannot reserve FB region\n");
 		goto err0;
 	}
 
 	/* Map the framebuffer.  */
-	mem_base = ioremap(bar0_start, bar0_len);
+	mem_base = ioremap_nocache(bar0_start, bar0_len);
 	if (!mem_base) {
 		printk(KERN_ERR "tgafb: Cannot map MMIO\n");
 		goto err1;
@@ -1434,12 +1586,16 @@ tgafb_pci_register(struct pci_dev *pdev,
 
 	/* Grab info about the card.  */
 	tga_type = (readl(mem_base) >> 12) & 0x0f;
-	par->pdev = pdev;
+	par->dev = dev;
 	par->tga_mem_base = mem_base;
 	par->tga_fb_base = mem_base + fb_offset_presets[tga_type];
 	par->tga_regs_base = mem_base + TGA_REGS_OFFSET;
 	par->tga_type = tga_type;
-	pci_read_config_byte(pdev, PCI_REVISION_ID, &par->tga_chip_rev);
+	if (tga_bus_pci)
+		pci_read_config_byte(to_pci_dev(dev), PCI_REVISION_ID,
+				     &par->tga_chip_rev);
+	if (tga_bus_tc)
+		par->tga_chip_rev = TGA_READ_REG(par, TGA_START_REG) & 0xff;
 
 	/* Setup framebuffer.  */
 	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_COPYAREA |
@@ -1449,8 +1605,17 @@ tgafb_pci_register(struct pci_dev *pdev,
 	info->pseudo_palette = (void *)(par + 1);
 
 	/* This should give a reasonable default video mode.  */
-
-	ret = fb_find_mode(&info->var, info, mode_option, NULL, 0, NULL,
+	if (tga_bus_pci) {
+		mode_option_tga = mode_option_pci;
+	}
+	if (tga_bus_tc) {
+		mode_option_tga = mode_option_tc;
+		modedb_tga = &modedb_tc;
+		modedbsize_tga = 1;
+	}
+	ret = fb_find_mode(&info->var, info,
+			   mode_option ? mode_option : mode_option_tga,
+			   modedb_tga, modedbsize_tga, NULL,
 			   tga_type == TGA_TYPE_8PLANE ? 8 : 32);
 	if (ret == 0 || ret == 4) {
 		printk(KERN_ERR "tgafb: Could not find valid video mode\n");
@@ -1473,13 +1638,19 @@ tgafb_pci_register(struct pci_dev *pdev,
 		goto err1;
 	}
 
-	printk(KERN_INFO "tgafb: DC21030 [TGA] detected, rev=0x%02x\n",
-	       par->tga_chip_rev);
-	printk(KERN_INFO "tgafb: at PCI bus %d, device %d, function %d\n",
-	       pdev->bus->number, PCI_SLOT(pdev->devfn),
-	       PCI_FUNC(pdev->devfn));
-	printk(KERN_INFO "fb%d: %s frame buffer device at 0x%lx\n",
-	       info->node, info->fix.id, bar0_start);
+	if (tga_bus_pci) {
+		pr_info("tgafb: DC21030 [TGA] detected, rev=0x%02x\n",
+			par->tga_chip_rev);
+		pr_info("tgafb: at PCI bus %d, device %d, function %d\n",
+			to_pci_dev(dev)->bus->number,
+			PCI_SLOT(to_pci_dev(dev)->devfn),
+			PCI_FUNC(to_pci_dev(dev)->devfn));
+	}
+	if (tga_bus_tc)
+		pr_info("tgafb: SFB+ detected, rev=0x%02x\n",
+			par->tga_chip_rev);
+	pr_info("fb%d: %s frame buffer device at 0x%lx\n",
+		info->node, info->fix.id, (long)bar0_start);
 
 	return 0;
 
@@ -1491,25 +1662,39 @@ tgafb_pci_register(struct pci_dev *pdev,
 }
 
 static void __devexit
-tgafb_pci_unregister(struct pci_dev *pdev)
+tgafb_unregister(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(pdev);
-	struct tga_par *par = info->par;
+	resource_size_t bar0_start = 0, bar0_len = 0;
+	int tga_bus_pci = TGA_BUS_PCI(dev);
+	int tga_bus_tc = TGA_BUS_TC(dev);
+	struct fb_info *info = NULL;
+	struct tga_par *par;
 
+	info = dev_get_drvdata(dev);
 	if (!info)
 		return;
+
+	par = info->par;
 	unregister_framebuffer(info);
 	fb_dealloc_cmap(&info->cmap);
 	iounmap(par->tga_mem_base);
-	release_mem_region(pci_resource_start(pdev, 0),
-			   pci_resource_len(pdev, 0));
+	if (tga_bus_pci) {
+		bar0_start = pci_resource_start(to_pci_dev(dev), 0);
+		bar0_len = pci_resource_len(to_pci_dev(dev), 0);
+	}
+	if (tga_bus_tc) {
+		bar0_start = to_tc_dev(dev)->resource.start;
+		bar0_len = to_tc_dev(dev)->resource.end - bar0_start + 1;
+	}
+	release_mem_region(bar0_start, bar0_len);
 	framebuffer_release(info);
 }
 
 static void __devexit
 tgafb_exit(void)
 {
-	pci_unregister_driver(&tgafb_driver);
+	tc_unregister_driver(&tgafb_tc_driver);
+	pci_unregister_driver(&tgafb_pci_driver);
 }
 
 #ifndef MODULE
@@ -1538,6 +1723,7 @@ tgafb_setup(char *arg)
 static int __devinit
 tgafb_init(void)
 {
+	int status;
 #ifndef MODULE
 	char *option = NULL;
 
@@ -1545,7 +1731,10 @@ tgafb_init(void)
 		return -ENODEV;
 	tgafb_setup(option);
 #endif
-	return pci_register_driver(&tgafb_driver);
+	status = pci_register_driver(&tgafb_pci_driver);
+	if (!status)
+		status = tc_register_driver(&tgafb_tc_driver);
+	return status;
 }
 
 /*
@@ -1555,5 +1744,5 @@ tgafb_init(void)
 module_init(tgafb_init);
 module_exit(tgafb_exit);
 
-MODULE_DESCRIPTION("framebuffer driver for TGA chipset");
+MODULE_DESCRIPTION("Framebuffer driver for TGA/SFB+ chipset");
 MODULE_LICENSE("GPL");
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/include/video/tgafb.h linux-mips-2.6.18-20060920/include/video/tgafb.h
--- linux-mips-2.6.18-20060920.macro/include/video/tgafb.h	2004-12-05 05:57:54.000000000 +0000
+++ linux-mips-2.6.18-20060920/include/video/tgafb.h	2006-12-08 02:48:21.000000000 +0000
@@ -39,6 +39,7 @@
 #define	TGA_RASTEROP_REG		0x0034
 #define	TGA_PIXELSHIFT_REG		0x0038
 #define	TGA_DEEP_REG			0x0050
+#define	TGA_START_REG			0x0054
 #define	TGA_PIXELMASK_REG		0x005c
 #define	TGA_CURSOR_BASE_REG		0x0060
 #define	TGA_HORIZ_REG			0x0064
@@ -140,7 +141,7 @@
 
 
 /*
- * Useful defines for managing the BT463 on the 24-plane TGAs
+ * Useful defines for managing the BT463 on the 24-plane TGAs/SFB+s
  */
 
 #define	BT463_ADDR_LO		0x0
@@ -168,12 +169,35 @@
 #define	BT463_WINDOW_TYPE_BASE	0x0300
 
 /*
+ * Useful defines for managing the BT459 on the 8-plane SFB+s
+ */
+
+#define	BT459_ADDR_LO		0x0
+#define	BT459_ADDR_HI		0x1
+#define	BT459_REG_ACC		0x2
+#define	BT459_PALETTE		0x3
+
+#define	BT459_CUR_CLR_1		0x0181
+#define	BT459_CUR_CLR_2		0x0182
+#define	BT459_CUR_CLR_3		0x0183
+
+#define	BT459_CMD_REG_0		0x0201
+#define	BT459_CMD_REG_1		0x0202
+#define	BT459_CMD_REG_2		0x0203
+
+#define	BT459_READ_MASK		0x0204
+
+#define	BT459_BLINK_MASK	0x0206
+
+#define	BT459_CUR_CMD_REG	0x0300
+
+/*
  * The framebuffer driver private data.
  */
 
 struct tga_par {
-	/* PCI device.  */
-	struct pci_dev *pdev;
+	/* PCI/TC device.  */
+	struct device *dev;
 
 	/* Device dependent information.  */
 	void __iomem *tga_mem_base;
@@ -235,4 +259,21 @@ BT463_WRITE(struct tga_par *par, u32 m, 
 	TGA_WRITE_REG(par, m << 10 | v, TGA_RAMDAC_REG);
 }
 
+static inline void
+BT459_LOAD_ADDR(struct tga_par *par, u16 a)
+{
+	TGA_WRITE_REG(par, BT459_ADDR_LO << 2, TGA_RAMDAC_SETUP_REG);
+	TGA_WRITE_REG(par, a & 0xff, TGA_RAMDAC_REG);
+	TGA_WRITE_REG(par, BT459_ADDR_HI << 2, TGA_RAMDAC_SETUP_REG);
+	TGA_WRITE_REG(par, a >> 8, TGA_RAMDAC_REG);
+}
+
+static inline void
+BT459_WRITE(struct tga_par *par, u32 m, u16 a, u8 v)
+{
+	BT459_LOAD_ADDR(par, a);
+	TGA_WRITE_REG(par, m << 2, TGA_RAMDAC_SETUP_REG);
+	TGA_WRITE_REG(par, v, TGA_RAMDAC_REG);
+}
+
 #endif /* TGAFB_H */
