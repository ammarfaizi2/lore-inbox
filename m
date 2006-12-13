Return-Path: <linux-kernel-owner+w=401wt.eu-S932664AbWLMRnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbWLMRnu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 12:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbWLMRmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 12:42:49 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:3120 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932574AbWLMRmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 12:42:47 -0500
Date: Wed, 13 Dec 2006 17:10:30 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>
cc: linux-fbdev-devel@lists.sourceforge.net, axp-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19 1/6] tgafb: Switch to framebuffer_alloc()
Message-ID: <Pine.LNX.4.64N.0612131553430.24220@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 This is a set of changes to update the driver to the framebuffer_alloc() 
API.  Included, there is also a fix to a memory leak due to the colour map 
allocation not being freed upon driver's removal.  Aside from the fix 
there are no functional changes.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-tgafb-alloc-4
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c linux-mips-2.6.18-20060920/drivers/video/tgafb.c
--- linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c	2006-09-20 20:50:52.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/video/tgafb.c	2006-12-12 23:13:57.000000000 +0000
@@ -1376,14 +1376,10 @@ tgafb_pci_register(struct pci_dev *pdev,
 		TGA_24PLUSZ_FB_OFFSET
 	};
 
-	struct all_info {
-		struct fb_info info;
-		struct tga_par par;
-		u32 pseudo_palette[16];
-	} *all;
-
 	void __iomem *mem_base;
 	unsigned long bar0_start, bar0_len;
+	struct fb_info *info;
+	struct tga_par *par;
 	u8 tga_type;
 	int ret;
 
@@ -1394,13 +1390,14 @@ tgafb_pci_register(struct pci_dev *pdev,
 	}
 
 	/* Allocate the fb and par structures.  */
-	all = kmalloc(sizeof(*all), GFP_KERNEL);
-	if (!all) {
+	info = framebuffer_alloc(sizeof(struct tga_par), &pdev->dev);
+	if (!info) {
 		printk(KERN_ERR "tgafb: Cannot allocate memory\n");
 		return -ENOMEM;
 	}
-	memset(all, 0, sizeof(*all));
-	pci_set_drvdata(pdev, all);
+
+	par = info->par;
+	pci_set_drvdata(pdev, info);
 
 	/* Request the mem regions.  */
 	bar0_start = pci_resource_start(pdev, 0);
@@ -1420,25 +1417,23 @@ tgafb_pci_register(struct pci_dev *pdev,
 
 	/* Grab info about the card.  */
 	tga_type = (readl(mem_base) >> 12) & 0x0f;
-	all->par.pdev = pdev;
-	all->par.tga_mem_base = mem_base;
-	all->par.tga_fb_base = mem_base + fb_offset_presets[tga_type];
-	all->par.tga_regs_base = mem_base + TGA_REGS_OFFSET;
-	all->par.tga_type = tga_type;
-	pci_read_config_byte(pdev, PCI_REVISION_ID, &all->par.tga_chip_rev);
+	par->pdev = pdev;
+	par->tga_mem_base = mem_base;
+	par->tga_fb_base = mem_base + fb_offset_presets[tga_type];
+	par->tga_regs_base = mem_base + TGA_REGS_OFFSET;
+	par->tga_type = tga_type;
+	pci_read_config_byte(pdev, PCI_REVISION_ID, &par->tga_chip_rev);
 
 	/* Setup framebuffer.  */
-	all->info.flags = FBINFO_DEFAULT | FBINFO_HWACCEL_COPYAREA |
-                          FBINFO_HWACCEL_IMAGEBLIT | FBINFO_HWACCEL_FILLRECT;
-	all->info.fbops = &tgafb_ops;
-	all->info.screen_base = all->par.tga_fb_base;
-	all->info.par = &all->par;
-	all->info.pseudo_palette = all->pseudo_palette;
+	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_COPYAREA |
+		      FBINFO_HWACCEL_IMAGEBLIT | FBINFO_HWACCEL_FILLRECT;
+	info->fbops = &tgafb_ops;
+	info->screen_base = par->tga_fb_base;
+	info->pseudo_palette = (void *)(par + 1);
 
 	/* This should give a reasonable default video mode.  */
 
-	ret = fb_find_mode(&all->info.var, &all->info, mode_option,
-			   NULL, 0, NULL,
+	ret = fb_find_mode(&info->var, info, mode_option, NULL, 0, NULL,
 			   tga_type == TGA_TYPE_8PLANE ? 8 : 32);
 	if (ret == 0 || ret == 4) {
 		printk(KERN_ERR "tgafb: Could not find valid video mode\n");
@@ -1446,36 +1441,35 @@ tgafb_pci_register(struct pci_dev *pdev,
 		goto err1;
 	}
 
-	if (fb_alloc_cmap(&all->info.cmap, 256, 0)) {
+	if (fb_alloc_cmap(&info->cmap, 256, 0)) {
 		printk(KERN_ERR "tgafb: Could not allocate color map\n");
 		ret = -ENOMEM;
 		goto err1;
 	}
 
-	tgafb_set_par(&all->info);
-	tgafb_init_fix(&all->info);
+	tgafb_set_par(info);
+	tgafb_init_fix(info);
 
-	all->info.device = &pdev->dev;
-	if (register_framebuffer(&all->info) < 0) {
+	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR "tgafb: Could not register framebuffer\n");
 		ret = -EINVAL;
 		goto err1;
 	}
 
 	printk(KERN_INFO "tgafb: DC21030 [TGA] detected, rev=0x%02x\n",
-	       all->par.tga_chip_rev);
+	       par->tga_chip_rev);
 	printk(KERN_INFO "tgafb: at PCI bus %d, device %d, function %d\n",
 	       pdev->bus->number, PCI_SLOT(pdev->devfn),
 	       PCI_FUNC(pdev->devfn));
 	printk(KERN_INFO "fb%d: %s frame buffer device at 0x%lx\n",
-	       all->info.node, all->info.fix.id, bar0_start);
+	       info->node, info->fix.id, bar0_start);
 
 	return 0;
 
  err1:
 	release_mem_region(bar0_start, bar0_len);
  err0:
-	kfree(all);
+	framebuffer_release(info);
 	return ret;
 }
 
@@ -1488,10 +1482,11 @@ tgafb_pci_unregister(struct pci_dev *pde
 	if (!info)
 		return;
 	unregister_framebuffer(info);
+	fb_dealloc_cmap(&info->cmap);
 	iounmap(par->tga_mem_base);
 	release_mem_region(pci_resource_start(pdev, 0),
 			   pci_resource_len(pdev, 0));
-	kfree(info);
+	framebuffer_release(info);
 }
 
 #ifdef MODULE
