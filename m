Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265148AbUF1Tdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUF1Tdf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 15:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265135AbUF1Tcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 15:32:53 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:56978 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265199AbUF1TbC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 15:31:02 -0400
Date: Mon, 28 Jun 2004 21:27:27 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Andrew Morton <akpm@osdl.org>
Cc: David Eger <eger@havoc.gtf.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.7-mm3] cirrusfb: minor fixes
Message-ID: <20040628212727.A23504@electric-eye.fr.zoreil.com>
References: <20040626233105.0c1375b2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040626233105.0c1375b2.akpm@osdl.org>; from akpm@osdl.org on Sat, Jun 26, 2004 at 11:31:05PM -0700
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Testers welcome.

- fix unbalanced invocation of pci_enable_device();
- leaks plugged in cirrusfb_zorro_setup();
- move framebuffer_release() into cirrusfb_{pci/zorro}_unmap() to balance
  cirrusfb_{pci/zorro}_setup();
- make cirrusfb_{pci/zorro}_setup() return adequate error codes when
  something fails;
- cirrusfb_zorro_unmap: iounmap() now take as argument values previously
  returned by ioremap().

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

diff -puN drivers/video/cirrusfb.c~cirrusfb-00 drivers/video/cirrusfb.c
--- linux-2.6.7/drivers/video/cirrusfb.c~cirrusfb-00	2004-06-24 22:55:10.000000000 +0200
+++ linux-2.6.7-fr/drivers/video/cirrusfb.c	2004-06-28 21:10:41.000000000 +0200
@@ -2144,15 +2144,17 @@ static void get_pci_addrs (const struct 
 
 static void __devexit cirrusfb_pci_unmap (struct cirrusfb_info *cinfo)
 {
-	iounmap (cinfo->fbmem);
-	release_mem_region(cinfo->fbmem_phys, cinfo->size);
+	struct pci_dev *pdev = cinfo->pdev;
 
+	iounmap(cinfo->fbmem);
 #if 0 /* if system didn't claim this region, we would... */
 	release_mem_region(0xA0000, 65535);
 #endif
-
 	if (release_io_ports)
 		release_region(0x3C0, 32);
+	pci_release_regions(pdev);
+	framebuffer_release(cinfo->info);
+	pci_disable_device(pdev);
 }
 
 
@@ -2163,16 +2165,19 @@ static struct cirrusfb_info *cirrusfb_pc
 	struct fb_info *info;
 	cirrusfb_board_t btype;
 	unsigned long board_addr, board_size;
+	int ret;
 
-	if (pci_enable_device(pdev) != 0) {
+	ret = pci_enable_device(pdev);
+	if (ret < 0) {
 		printk(KERN_ERR "cirrusfb: Cannot enable PCI device\n");
-		return NULL;
+		goto err_out;
 	}
 
 	info = framebuffer_alloc(sizeof(struct cirrusfb_info), &pdev->dev);
 	if (!info) {
-		printk (KERN_ERR "cirrusfb: could not allocate memory\n");
-		return NULL;
+		printk(KERN_ERR "cirrusfb: could not allocate memory\n");
+		ret = -ENOMEM;
+		goto err_disable;
 	}
 
 	cinfo = info->par;
@@ -2202,25 +2207,30 @@ static struct cirrusfb_info *cirrusfb_pc
 	board_size = (btype == BT_GD5480) ?
 		32 * MB_ : cirrusfb_get_memsize (cinfo->regbase);
 
-	if (!request_mem_region(board_addr, board_size, "cirrusfb")) {
+	ret = pci_request_regions(pdev, "cirrusfb");
+	if (ret <0) {
 		printk(KERN_ERR "cirrusfb: cannot reserve region 0x%lx, abort\n",
 		       board_addr);
-		framebuffer_release (info);
-		return NULL;
+		goto err_release_fb;
 	}
 #if 0 /* if the system didn't claim this region, we would... */
 	if (!request_mem_region(0xA0000, 65535, "cirrusfb")) {
-		printk(KERN_ERR "cirrusfb: cannot reserve region 0x%lx, abort\n",
+		printk(KERN_ERR "cirrusfb: cannot reserve region 0x%lx, abort\n"
+,
 		       0xA0000L);
-		release_mem_region(board_addr, board_size);
-		framebuffer_release (info);
-		return NULL;
+		ret = -EBUSY;
+		goto err_release_regions;
 	}
 #endif
 	if (request_region(0x3C0, 32, "cirrusfb"))
 		release_io_ports = 1;
 
-	cinfo->fbmem = ioremap (board_addr, board_size);
+	cinfo->fbmem = ioremap(board_addr, board_size);
+	if (!cinfo->fbmem) {
+		ret = -EIO;
+		goto err_release_legacy;
+	}
+
 	cinfo->fbmem_phys = board_addr;
 	cinfo->size = board_size;
 
@@ -2228,6 +2238,21 @@ static struct cirrusfb_info *cirrusfb_pc
 	printk ("Cirrus Logic chipset on PCI bus\n");
 
 	return cinfo;
+
+err_release_legacy:
+	if (release_io_ports)
+		release_region(0x3C0, 32);
+#if 0
+	release_mem_region(0xA0000, 65535);
+err_release_regions:
+#endif
+	pci_release_regions(pdev);
+err_release_fb:
+	framebuffer_release(info);
+err_disable:
+	pci_disable_device(pdev);
+err_out:
+	return ERR_PTR(ret);
 }
 #endif				/* CONFIG_PCI */
 
@@ -2266,7 +2291,7 @@ static int cirrusfb_zorro_find (struct z
 	}
 
 	printk (KERN_NOTICE "cirrusfb: no supported board found.\n");
-	return -1;
+	return -ENODEV;
 }
 
 
@@ -2275,30 +2300,35 @@ static void __devexit cirrusfb_zorro_unm
 	release_mem_region(cinfo->board_addr, cinfo->board_size);
 
 	if (cinfo->btype == BT_PICASSO4) {
-		iounmap ((void *)cinfo->board_addr);
-		iounmap ((void *)cinfo->fbmem_phys);
+		cinfo->regbase -= 0x600000;
+		iounmap ((void *)cinfo->regbase);
+		iounmap ((void *)cinfo->fbmem);
 	} else {
 		if (cinfo->board_addr > 0x01000000)
-			iounmap ((void *)cinfo->board_addr);
+			iounmap ((void *)cinfo->fbmem);
 	}
+	framebuffer_release(cinfo->info);
 }
 
 
-static struct cirrusfb_info *cirrusfb_zorro_setup ()
+static struct cirrusfb_info *cirrusfb_zorro_setup(void)
 {
 	struct cirrusfb_info *cinfo;
 	struct fb_info *info;
 	cirrusfb_board_t btype;
 	struct zorro_dev *z = NULL, *z2 = NULL;
 	unsigned long board_addr, board_size, size;
+	int ret;
 
-	if (cirrusfb_zorro_find (&z, &z2, &btype, &size))
-		return NULL;
+	ret = cirrusfb_zorro_find (&z, &z2, &btype, &size);
+	if (ret < 0)
+		goto err_out;
 
 	info = framebuffer_alloc(sizeof(struct cirrusfb_info), &z->dev);
 	if (!info) {
 		printk (KERN_ERR "cirrusfb: could not allocate memory\n");
-		return NULL;
+		ret = -ENOMEM;
+		goto err_out;
 	}
 
 	cinfo = info->par;
@@ -2316,11 +2346,14 @@ static struct cirrusfb_info *cirrusfb_zo
 	if (!request_mem_region(board_addr, board_size, "cirrusfb")) {
 		printk(KERN_ERR "cirrusfb: cannot reserve region 0x%lx, abort\n",
 		       board_addr);
-		return -1;
+		ret = -EBUSY;
+		goto err_release_fb;
 	}
 
 	printk (" RAM (%lu MB) at $%lx, ", board_size / MB_, board_addr);
 
+	ret = -EIO;
+
 	if (btype == BT_PICASSO4) {
 		printk (" REG at $%lx\n", board_addr + 0x600000);
 
@@ -2329,12 +2362,17 @@ static struct cirrusfb_info *cirrusfb_zo
 		/* for P4, map in its address space in 2 chunks (### TEST! ) */
 		/* (note the ugly hardcoded 16M number) */
 		cinfo->regbase = ioremap (board_addr, 16777216);
+		if (!cinfo->regbase)
+			goto err_release_region;
+
 		DPRINTK ("cirrusfb: Virtual address for board set to: $%p\n", cinfo->regbase);
 		cinfo->regbase += 0x600000;
 		cinfo->fbregs_phys = board_addr + 0x600000;
 
 		cinfo->fbmem_phys = board_addr + 16777216;
 		cinfo->fbmem = ioremap (info->fbmem_phys, 16777216);
+		if (!cinfo->fbmem)
+			goto err_unmap_regbase;
 	} else {
 		printk (" REG at $%lx\n", (unsigned long) z2->resource.start);
 
@@ -2343,6 +2381,8 @@ static struct cirrusfb_info *cirrusfb_zo
 			cinfo->fbmem = ioremap (board_addr, board_size);
 		else
 			cinfo->fbmem = (caddr_t) ZTWO_VADDR (board_addr);
+		if (!cinfo->fbmem)
+			goto err_release_region;
 
 		/* set address for REG area of board */
 		cinfo->regbase = (caddr_t) ZTWO_VADDR (z2->resource.start);
@@ -2354,6 +2394,16 @@ static struct cirrusfb_info *cirrusfb_zo
 	printk (KERN_INFO "Cirrus Logic chipset on Zorro bus\n");
 
 	return 0;
+
+err_unmap_regbase:
+	/* Parental advisory: explicit hack */
+	iounmap(cinfo->regbase - 0x600000);
+err_release_region:
+	release_region(board_addr, board_size);
+err_release_fb:
+	framebuffer_release(info);
+err_out:
+	return ERR_PTR(ret);
 }
 #endif /* CONFIG_ZORRO */
 
@@ -2430,8 +2480,10 @@ static int cirrusfb_pci_register (struct
 
 	cinfo = cirrusfb_bus_setup(pdev, ent);
 
-	if (!cinfo)
-		return -ENODEV;
+	if (IS_ERR(cinfo)) {
+		err = PTR_ERR(cinfo);
+		goto err_out;
+	}
 
 	info = cinfo->info;
 	btype = cinfo->btype;
@@ -2446,13 +2498,12 @@ static int cirrusfb_pci_register (struct
 	/* state, even though we haven't written the mode to the hw yet...  */
 	info->var = cirrusfb_predefined[cirrusfb_def_mode].var;
 	info->var.activate = FB_ACTIVATE_NOW;
+
 	err = cirrusfb_decode_var(&info->var, &cinfo->currentmode, info);
-	if(err) {
+	if (err < 0) {
 		/* should never happen */
 		DPRINTK("choking on default var... umm, no good.\n");
-		cirrusfb_unmap (cinfo);
-		framebuffer_release (info);
-		return -EINVAL;
+		goto err_unmap_cirrusfb;
 	}
 
 	/* set all the vital stuff */
@@ -2460,16 +2511,21 @@ static int cirrusfb_pci_register (struct
 
 	pci_set_drvdata(pdev, info);
 
-	if ((err = register_framebuffer (info)) < 0) {
+	err = register_framebuffer(info);
+	if (err < 0) {
 		printk (KERN_ERR "cirrusfb: could not register fb device; err = %d!\n", err);
-		fb_dealloc_cmap(&info->cmap);
-		cirrusfb_unmap (cinfo);
-		framebuffer_release (info);
-		return -EINVAL;
+		goto err_dealloc_cmap;
 	}
 
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
+
+err_dealloc_cmap:
+	fb_dealloc_cmap(&info->cmap);
+err_unmap_cirrusfb:
+	cirrusfb_unmap(cinfo);
+err_out:
+	return err;
 }
 
 
@@ -2482,11 +2538,10 @@ static void __devexit cirrusfb_cleanup (
 	switch_monitor (cinfo, 0);
 #endif
 
-	cirrusfb_unmap (cinfo);
-	fb_dealloc_cmap (&info->cmap);
 	unregister_framebuffer (info);
+	fb_dealloc_cmap (&info->cmap);
 	printk ("Framebuffer unregistered\n");
-	framebuffer_release (info);
+	cirrusfb_unmap (cinfo);
 
 	DPRINTK ("EXIT\n");
 }

_
