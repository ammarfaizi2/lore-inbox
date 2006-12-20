Return-Path: <linux-kernel-owner+w=401wt.eu-S964977AbWLTMDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWLTMDB (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 07:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbWLTMCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 07:02:51 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:1644 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803AbWLTMC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 07:02:26 -0500
Date: Wed, 20 Dec 2006 12:02:22 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>
cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH 2.6.20-rc1 09/10] pmagb-b-fb: Convert to the driver model
Message-ID: <Pine.LNX.4.64N.0612201122510.11005@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This is a set of changes to convert the driver to the driver model.  As a 
side-effect the driver now supports building as a module.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-tc-pmagb-b-6
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/video/Kconfig linux-mips-2.6.18-20060920/drivers/video/Kconfig
--- linux-mips-2.6.18-20060920.macro/drivers/video/Kconfig	2006-08-21 04:55:25.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/video/Kconfig	2006-12-16 15:01:26.000000000 +0000
@@ -1452,8 +1452,8 @@ config FB_PMAG_BA
 	  used mainly in the MIPS-based DECstation series.
 
 config FB_PMAGB_B
-	bool "PMAGB-B TURBOchannel framebuffer support"
-	depends on (FB = y) && TC
+	tristate "PMAGB-B TURBOchannel framebuffer support"
+	depends on TC
  	select FB_CFB_FILLRECT
  	select FB_CFB_COPYAREA
  	select FB_CFB_IMAGEBLIT
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/video/pmagb-b-fb.c linux-mips-2.6.18-20060920/drivers/video/pmagb-b-fb.c
--- linux-mips-2.6.18-20060920.macro/drivers/video/pmagb-b-fb.c	2006-05-30 17:03:12.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/video/pmagb-b-fb.c	2006-12-19 23:48:52.000000000 +0000
@@ -11,7 +11,7 @@
  *	Michael Engel <engel@unix-ag.org>,
  *	Karsten Merker <merker@linuxtag.org> and
  *	Harald Koerfgen.
- *	Copyright (c) 2005  Maciej W. Rozycki
+ *	Copyright (c) 2005, 2006  Maciej W. Rozycki
  *
  *	This file is subject to the terms and conditions of the GNU General
  *	Public License.  See the file COPYING in the main directory of this
@@ -25,18 +25,16 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/tc.h>
 #include <linux/types.h>
 
 #include <asm/io.h>
 #include <asm/system.h>
 
-#include <asm/dec/tc.h>
-
 #include <video/pmagb-b-fb.h>
 
 
 struct pmagbbfb_par {
-	struct fb_info *next;
 	volatile void __iomem *mmio;
 	volatile void __iomem *smem;
 	volatile u32 __iomem *sfb;
@@ -47,8 +45,6 @@ struct pmagbbfb_par {
 };
 
 
-static struct fb_info *root_pmagbbfb_dev;
-
 static struct fb_var_screeninfo pmagbbfb_defined __initdata = {
 	.bits_per_pixel	= 8,
 	.red.length	= 8,
@@ -190,8 +186,9 @@ static void __init pmagbbfb_osc_setup(st
 		69197, 66000, 65000, 50350, 36000, 32000, 25175
 	};
 	struct pmagbbfb_par *par = info->par;
+	struct tc_bus *tbus = to_tc_dev(info->device)->bus;
 	u32 count0 = 8, count1 = 8, counttc = 16 * 256 + 8;
-	u32 freq0, freq1, freqtc = get_tc_speed() / 250;
+	u32 freq0, freq1, freqtc = tc_get_speed(tbus) / 250;
 	int i, j;
 
 	gp0_write(par, 0);				/* select Osc0 */
@@ -249,26 +246,21 @@ static void __init pmagbbfb_osc_setup(st
 };
 
 
-static int __init pmagbbfb_init_one(int slot)
+static int __init pmagbbfb_probe(struct device *dev)
 {
-	char freq0[12], freq1[12];
+	struct tc_dev *tdev = to_tc_dev(dev);
+	resource_size_t start, len;
 	struct fb_info *info;
 	struct pmagbbfb_par *par;
-	unsigned long base_addr;
+	char freq0[12], freq1[12];
 	u32 vid_base;
 
-	info = framebuffer_alloc(sizeof(struct pmagbbfb_par), NULL);
+	info = framebuffer_alloc(sizeof(struct pmagbbfb_par), dev);
 	if (!info)
 		return -ENOMEM;
 
 	par = info->par;
-	par->slot = slot;
-	claim_tc_card(par->slot);
-
-	base_addr = get_tc_base_addr(par->slot);
-
-	par->next = root_pmagbbfb_dev;
-	root_pmagbbfb_dev = info;
+	dev_set_drvdata(dev, info);
 
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0)
 		goto err_alloc;
@@ -278,16 +270,22 @@ static int __init pmagbbfb_init_one(int 
 	info->var = pmagbbfb_defined;
 	info->flags = FBINFO_DEFAULT;
 
+	/* Request the I/O MEM resource.  */
+	start = tdev->resource.start;
+	len = tdev->resource.end - start + 1;
+	if (!request_mem_region(start, len, dev->bus_id))
+		goto err_cmap;
+
 	/* MMIO mapping setup.  */
-	info->fix.mmio_start = base_addr;
+	info->fix.mmio_start = start;
 	par->mmio = ioremap_nocache(info->fix.mmio_start, info->fix.mmio_len);
 	if (!par->mmio)
-		goto err_cmap;
+		goto err_resource;
 	par->sfb = par->mmio + PMAGB_B_SFB;
 	par->dac = par->mmio + PMAGB_B_BT459;
 
 	/* Frame buffer mapping setup.  */
-	info->fix.smem_start = base_addr + PMAGB_B_FBMEM;
+	info->fix.smem_start = start + PMAGB_B_FBMEM;
 	par->smem = ioremap_nocache(info->fix.smem_start, info->fix.smem_len);
 	if (!par->smem)
 		goto err_mmio_map;
@@ -302,13 +300,15 @@ static int __init pmagbbfb_init_one(int 
 	if (register_framebuffer(info) < 0)
 		goto err_smem_map;
 
+	get_device(dev);
+
 	snprintf(freq0, sizeof(freq0), "%u.%03uMHz",
 		 par->osc0 / 1000, par->osc0 % 1000);
 	snprintf(freq1, sizeof(freq1), "%u.%03uMHz",
 		 par->osc1 / 1000, par->osc1 % 1000);
 
-	pr_info("fb%d: %s frame buffer device in slot %d\n",
-		info->node, info->fix.id, par->slot);
+	pr_info("fb%d: %s frame buffer device at %s\n",
+		info->node, info->fix.id, dev->bus_id);
 	pr_info("fb%d: Osc0: %s, Osc1: %s, Osc%u selected\n",
 		info->node, freq0, par->osc1 ? freq1 : "disabled",
 		par->osc1 != 0);
@@ -322,54 +322,68 @@ err_smem_map:
 err_mmio_map:
 	iounmap(par->mmio);
 
+err_resource:
+	release_mem_region(start, len);
+
 err_cmap:
 	fb_dealloc_cmap(&info->cmap);
 
 err_alloc:
-	root_pmagbbfb_dev = par->next;
-	release_tc_card(par->slot);
 	framebuffer_release(info);
 	return -ENXIO;
 }
 
-static void __exit pmagbbfb_exit_one(void)
+static int __exit pmagbbfb_remove(struct device *dev)
 {
-	struct fb_info *info = root_pmagbbfb_dev;
+	struct tc_dev *tdev = to_tc_dev(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct pmagbbfb_par *par = info->par;
+	resource_size_t start, len;
 
+	put_device(dev);
 	unregister_framebuffer(info);
 	iounmap(par->smem);
 	iounmap(par->mmio);
+	start = tdev->resource.start;
+	len = tdev->resource.end - start + 1;
+	release_mem_region(start, len);
 	fb_dealloc_cmap(&info->cmap);
-	root_pmagbbfb_dev = par->next;
-	release_tc_card(par->slot);
 	framebuffer_release(info);
+	return 0;
 }
 
 
 /*
- * Initialise the framebuffer.
+ * Initialize the framebuffer.
  */
+static const struct tc_device_id pmagbbfb_tc_table[] = {
+	{ "DEC     ", "PMAGB-BA" },
+	{ }
+};
+MODULE_DEVICE_TABLE(tc, pmagbbfb_tc_table);
+
+static struct tc_driver pmagbbfb_driver = {
+	.id_table	= pmagbbfb_tc_table,
+	.driver		= {
+		.name	= "pmagbbfb",
+		.bus	= &tc_bus_type,
+		.probe	= pmagbbfb_probe,
+		.remove	= __exit_p(pmagbbfb_remove),
+	},
+};
+
 static int __init pmagbbfb_init(void)
 {
-	int count = 0;
-	int slot;
-
+#ifndef MODULE
 	if (fb_get_options("pmagbbfb", NULL))
 		return -ENXIO;
-
-	while ((slot = search_tc_card("PMAGB-BA")) >= 0) {
-		if (pmagbbfb_init_one(slot) < 0)
-			break;
-		count++;
-	}
-	return (count > 0) ? 0 : -ENXIO;
+#endif
+	return tc_register_driver(&pmagbbfb_driver);
 }
 
 static void __exit pmagbbfb_exit(void)
 {
-	while (root_pmagbbfb_dev)
-		pmagbbfb_exit_one();
+	tc_unregister_driver(&pmagbbfb_driver);
 }
 
 
