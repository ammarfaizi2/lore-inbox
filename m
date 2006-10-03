Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbWJCETp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbWJCETp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 00:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWJCETp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 00:19:45 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:19605 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S965081AbWJCETo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 00:19:44 -0400
Subject: [PATCH] ioremap balanced with iounmap for drivers/video
From: Amol Lad <amol@verismonetworks.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 09:53:04 +0530
Message-Id: <1159849384.19143.11.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap must be balanced by an iounmap and failing to do so can result
in a memory leak.

Tested (compilation only) with:
- allmodconfig
- Modifying drivers/video/Kconfig to make sure that the changed file is
compiling without error/warning

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
Forwarding to lkml as got no response from linux-fbdev-devel
---
 S3triofb.c            |    7 +++++--
 amifb.c               |    8 +++++---
 atafb.c               |   13 ++++++++++++-
 aty/atyfb_base.c      |    8 ++++++++
 cirrusfb.c            |   15 +++++++++++++--
 console/newport_con.c |    9 ++++++++-
 cyberfb.c             |    2 ++
 ffb.c                 |    4 ++++
 fm2fb.c               |    1 +
 hpfb.c                |    2 ++
 macfb.c               |   20 ++++++++++++++++++++
 offb.c                |    3 +++
 platinumfb.c          |    3 +++
 pvr2fb.c              |   18 ++++++++++++++++++
 retz3fb.c             |    4 +++-
 stifb.c               |    3 +++
 tgafb.c               |    2 ++
 tridentfb.c           |   22 +++++++++++++++++-----
 vesafb.c              |    2 ++
 virgefb.c             |   17 ++++++++++++++++-
 20 files changed, 147 insertions(+), 16 deletions(-)
---
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/amifb.c linux-2.6.18/drivers/video/amifb.c
--- linux-2.6.18-orig/drivers/video/amifb.c	2006-09-21 10:15:41.000000000 +0530
+++ linux-2.6.18/drivers/video/amifb.c	2006-09-29 16:37:46.000000000 +0530
@@ -2407,10 +2407,10 @@ default_chipset:
 						   fb_info.fix.smem_len);
 	if (!videomemory) {
 		printk("amifb: WARNING! unable to map videomem cached writethrough\n");
-		videomemory = ZTWO_VADDR(fb_info.fix.smem_start);
-	}
+		fb_info.screen_base = (char *)ZTWO_VADDR(fb_info.fix.smem_start);
+	} else
+		fb_info.screen_base = (char *)videomemory;
 
-	fb_info.screen_base = (char *)videomemory;
 	memset(dummysprite, 0, DUMMYSPRITEMEMSIZE);
 
 	/*
@@ -2453,6 +2453,8 @@ static void amifb_deinit(void)
 {
 	fb_dealloc_cmap(&fb_info.cmap);
 	chipfree();
+	if (videomemory)
+		iounmap((void*)videomemory);
 	release_mem_region(CUSTOM_PHYSADDR+0xe0, 0x120);
 	custom.dmacon = DMAF_ALL | DMAF_MASTER;
 }
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/atafb.c linux-2.6.18/drivers/video/atafb.c
--- linux-2.6.18-orig/drivers/video/atafb.c	2006-09-21 10:15:41.000000000 +0530
+++ linux-2.6.18/drivers/video/atafb.c	2006-09-29 17:39:40.000000000 +0530
@@ -2804,8 +2804,19 @@ int __init atafb_init(void)
 	atafb_set_disp(-1, &fb_info);
 	do_install_cmap(0, &fb_info);
 
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(&fb_info) < 0) {
+#ifdef ATAFB_EXT
+		if (external_addr) {
+			iounmap(external_addr);
+			external_addr = NULL;
+		}
+		if (external_vgaiobase) {
+			iounmap((void*)external_vgaiobase);
+			external_vgaiobase = 0;
+		}
+#endif	
 		return -EINVAL;
+	}
 
 	printk("Determined %dx%d, depth %d\n",
 	       disp.var.xres, disp.var.yres, disp.var.bits_per_pixel);
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/aty/atyfb_base.c linux-2.6.18/drivers/video/aty/atyfb_base.c
--- linux-2.6.18-orig/drivers/video/aty/atyfb_base.c	2006-09-21 10:15:41.000000000 +0530
+++ linux-2.6.18/drivers/video/aty/atyfb_base.c	2006-09-29 17:36:47.000000000 +0530
@@ -3530,6 +3530,10 @@ static int __devinit atyfb_setup_generic
 atyfb_setup_generic_fail:
 	iounmap(par->ati_regbase);
 	par->ati_regbase = NULL;
+	if (info->screen_base) {
+		iounmap(info->screen_base);
+		info->screen_base = NULL;
+	}
 	return ret;
 }
 
@@ -3698,6 +3702,10 @@ static int __devinit atyfb_atari_probe(v
 		}
 
 		if (aty_init(info, "ISA bus")) {
+			if (info->screen_base)
+				iounmap(info->screen_base);
+			if (par->ati_regbase)
+				iounmap(par->ati_regbase);
 			framebuffer_release(info);
 			/* This is insufficient! kernel_map has added two large chunks!! */
 			return -ENXIO;
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/cirrusfb.c linux-2.6.18/drivers/video/cirrusfb.c
--- linux-2.6.18-orig/drivers/video/cirrusfb.c	2006-09-21 10:15:41.000000000 +0530
+++ linux-2.6.18/drivers/video/cirrusfb.c	2006-09-29 17:48:34.000000000 +0530
@@ -2442,7 +2442,10 @@ static int cirrusfb_pci_register (struct
 	printk ("Cirrus Logic chipset on PCI bus\n");
 	pci_set_drvdata(pdev, info);
 
-	return cirrusfb_register(cinfo);
+	ret = cirrusfb_register(cinfo);
+	if (ret)
+		iounmap(cinfo->fbmem);
+	return ret;
 
 err_release_legacy:
 	if (release_io_ports)
@@ -2574,7 +2577,15 @@ static int cirrusfb_zorro_register(struc
 	printk (KERN_INFO "Cirrus Logic chipset on Zorro bus\n");
 	zorro_set_drvdata(z, info);
 
-	return cirrusfb_register(cinfo);
+	ret = cirrusfb_register(cinfo);
+	if (ret) {
+		if (btype == BT_PICASSO4) {
+			iounmap(cinfo->fbmem);
+			iounmap(cinfo->regbase - 0x600000);
+		} else if (board_addr > 0x01000000)
+			iounmap(cinfo->fbmem);
+	}
+	return ret;
 
 err_unmap_regbase:
 	/* Parental advisory: explicit hack */
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/console/newport_con.c linux-2.6.18/drivers/video/console/newport_con.c
--- linux-2.6.18-orig/drivers/video/console/newport_con.c	2006-09-21 10:15:41.000000000 +0530
+++ linux-2.6.18/drivers/video/console/newport_con.c	2006-09-29 17:57:58.000000000 +0530
@@ -323,6 +323,8 @@ static const char *newport_startup(void)
 	return "SGI Newport";
 
 out_unmap:
+	iounmap((void *)npregs);
+	npregs = NULL;
 	return NULL;
 }
 
@@ -738,6 +740,7 @@ const struct consw newport_con = {
 #ifdef MODULE
 static int __init newport_console_init(void)
 {
+	int err;
 
 	if (!sgi_gfxaddr)
 		return NULL;
@@ -746,7 +749,11 @@ static int __init newport_console_init(v
 		npregs = (struct newport_regs *)/* ioremap cannot fail */
 			ioremap(sgi_gfxaddr, sizeof(struct newport_regs));
 
-	return take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
+	err = take_over_console(&newport_con, 0, MAX_NR_CONSOLES - 1, 1);
+	if (err)
+		iounmap((void *)npregs);
+
+	return err;
 }
 module_init(newport_console_init);
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/cyberfb.c linux-2.6.18/drivers/video/cyberfb.c
--- linux-2.6.18-orig/drivers/video/cyberfb.c	2006-09-21 10:15:41.000000000 +0530
+++ linux-2.6.18/drivers/video/cyberfb.c	2006-09-29 16:26:19.000000000 +0530
@@ -1055,6 +1055,8 @@ int __init cyberfb_init(void)
 
 	    if (register_framebuffer(&fb_info) < 0) {
 		    DPRINTK("EXIT - register_framebuffer failed\n");
+			if (CyberBase)
+				iounmap(CyberBase);
 		    release_mem_region(CyberMem_phys, 0x400000);
 		    release_mem_region(CyberRegs_phys, 0x10000);
 		    return -EINVAL;
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/ffb.c linux-2.6.18/drivers/video/ffb.c
--- linux-2.6.18-orig/drivers/video/ffb.c	2006-09-21 10:15:41.000000000 +0530
+++ linux-2.6.18/drivers/video/ffb.c	2006-09-29 11:19:09.000000000 +0530
@@ -968,6 +968,8 @@ static int ffb_init_one(struct of_device
 
 	if (fb_alloc_cmap(&all->info.cmap, 256, 0)) {
 		printk(KERN_ERR "ffb: Could not allocate color map.\n");
+		of_iounmap(all->par.fbc, sizeof(struct ffb_fbc));
+		of_iounmap(all->par.dac, sizeof(struct ffb_dac));
 		kfree(all);
 		return -ENOMEM;
 	}
@@ -978,6 +980,8 @@ static int ffb_init_one(struct of_device
 	if (err < 0) {
 		printk(KERN_ERR "ffb: Could not register framebuffer.\n");
 		fb_dealloc_cmap(&all->info.cmap);
+		of_iounmap(all->par.fbc, sizeof(struct ffb_fbc));
+		of_iounmap(all->par.dac, sizeof(struct ffb_dac));
 		kfree(all);
 		return err;
 	}
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/fm2fb.c linux-2.6.18/drivers/video/fm2fb.c
--- linux-2.6.18-orig/drivers/video/fm2fb.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.18/drivers/video/fm2fb.c	2006-09-29 11:20:30.000000000 +0530
@@ -283,6 +283,7 @@ static int __devinit fm2fb_probe(struct 
 
 	if (register_framebuffer(info) < 0) {
 		fb_dealloc_cmap(&info->cmap);
+		iounmap(info->screen_base);
 		framebuffer_release(info);
 		zorro_release_device(z);
 		return -EINVAL;
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/hpfb.c linux-2.6.18/drivers/video/hpfb.c
--- linux-2.6.18-orig/drivers/video/hpfb.c	2006-09-21 10:15:41.000000000 +0530
+++ linux-2.6.18/drivers/video/hpfb.c	2006-09-29 11:30:45.000000000 +0530
@@ -295,6 +295,8 @@ static int __init hpfb_init_one(unsigned
 
 	if (register_framebuffer(&fb_info) < 0) {
 		fb_dealloc_cmap(&fb_info.cmap);
+		iounmap(fb_info.screen_base);
+		fb_info.screen_base = NULL;
 		return 1;
 	}
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/macfb.c linux-2.6.18/drivers/video/macfb.c
--- linux-2.6.18-orig/drivers/video/macfb.c	2006-09-21 10:15:41.000000000 +0530
+++ linux-2.6.18/drivers/video/macfb.c	2006-09-29 18:14:42.000000000 +0530
@@ -608,6 +608,22 @@ void __init macfb_setup(char *options)
 	}
 }
 
+static void __init iounmap_macfb(void)
+{
+	if (valkyrie_cmap_regs)
+		iounmap(valkyrie_cmap_regs);
+	if (dafb_cmap_regs)
+		iounmap(dafb_cmap_regs);
+	if (v8_brazil_cmap_regs)
+		iounmap(v8_brazil_cmap_regs);
+	if (rbv_cmap_regs)
+		iounmap(rbv_cmap_regs);
+	if (civic_cmap_regs)
+		iounmap(civic_cmap_regs);
+	if (csc_cmap_regs)
+		iounmap(csc_cmap_regs);
+}
+
 static int __init macfb_init(void)
 {
 	int video_cmap_len, video_is_nubus = 0;
@@ -962,6 +978,10 @@ static int __init macfb_init(void)
 	if (!err)
 		printk("fb%d: %s frame buffer device\n",
 		       fb_info.node, fb_info.fix.id);
+	else {
+		iounmap(fb_info.screen_base);
+		iounmap_macfb();
+	}
 	return err;
 }
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/offb.c linux-2.6.18/drivers/video/offb.c
--- linux-2.6.18-orig/drivers/video/offb.c	2006-09-21 10:15:42.000000000 +0530
+++ linux-2.6.18/drivers/video/offb.c	2006-09-29 12:07:28.000000000 +0530
@@ -392,6 +392,9 @@ static void __init offb_init_fb(const ch
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
 	if (register_framebuffer(info) < 0) {
+		iounmap(par->cmap_adr);
+		par->cmap_adr = NULL;
+		iounmap(info->screen_base);
 		kfree(info);
 		release_mem_region(res_start, res_size);
 		return;
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/platinumfb.c linux-2.6.18/drivers/video/platinumfb.c
--- linux-2.6.18-orig/drivers/video/platinumfb.c	2006-09-21 10:15:42.000000000 +0530
+++ linux-2.6.18/drivers/video/platinumfb.c	2006-09-29 12:12:17.000000000 +0530
@@ -623,6 +623,9 @@ static int __devinit platinumfb_probe(st
 	
 	rc = platinum_init_fb(info);
 	if (rc != 0) {
+		iounmap(pinfo->frame_buffer);
+		iounmap(pinfo->platinum_regs);
+		iounmap(pinfo->cmap_regs);
 		dev_set_drvdata(&odev->dev, NULL);
 		framebuffer_release(info);
 	}
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/pvr2fb.c linux-2.6.18/drivers/video/pvr2fb.c
--- linux-2.6.18-orig/drivers/video/pvr2fb.c	2006-09-21 10:15:42.000000000 +0530
+++ linux-2.6.18/drivers/video/pvr2fb.c	2006-09-29 15:07:50.000000000 +0530
@@ -903,6 +903,15 @@ static int __init pvr2fb_dc_init(void)
 
 static void pvr2fb_dc_exit(void)
 {
+	if (fb_info->screen_base) {
+		iounmap(fb_info->screen_base);
+		fb_info->screen_base = NULL;
+	}
+	if (currentpar->mmio_base) {
+		iounmap((void *)currentpar->mmio_base);
+		currentpar->mmio_base = 0;
+	}
+
 	free_irq(HW_EVENT_VSYNC, 0);
 #ifdef CONFIG_SH_DMA
 	free_dma(pvr2dma);
@@ -944,6 +953,15 @@ static int __devinit pvr2fb_pci_probe(st
 
 static void __devexit pvr2fb_pci_remove(struct pci_dev *pdev)
 {
+	if (fb_info->screen_base) {
+		iounmap(fb_info->screen_base);
+		fb_info->screen_base = NULL;
+	}
+	if (currentpar->mmio_base) {
+		iounmap((void *)currentpar->mmio_base);
+		currentpar->mmio_base = 0;
+	}
+
 	pci_release_regions(pdev);
 }
 
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/retz3fb.c linux-2.6.18/drivers/video/retz3fb.c
--- linux-2.6.18-orig/drivers/video/retz3fb.c	2006-09-21 10:15:42.000000000 +0530
+++ linux-2.6.18/drivers/video/retz3fb.c	2006-09-29 16:06:39.000000000 +0530
@@ -1423,8 +1423,10 @@ int __init retz3fb_init(void)
 
 		do_install_cmap(0, fb_info);
 
-		if (register_framebuffer(fb_info) < 0)
+		if (register_framebuffer(fb_info) < 0) {
+			iounmap(zinfo->base);
 			return -EINVAL;
+		}
 
 		printk(KERN_INFO "fb%d: %s frame buffer device, using %ldK of "
 		       "video memory\n", fb_info->node,
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/S3triofb.c linux-2.6.18/drivers/video/S3triofb.c
--- linux-2.6.18-orig/drivers/video/S3triofb.c	2006-09-21 10:15:41.000000000 +0530
+++ linux-2.6.18/drivers/video/S3triofb.c	2006-09-29 18:22:25.000000000 +0530
@@ -535,8 +535,11 @@ static void __init s3triofb_of_init(stru
 #endif
 
     fb_info.flags = FBINFO_FLAG_DEFAULT;
-    if (register_framebuffer(&fb_info) < 0)
-	return;
+    if (register_framebuffer(&fb_info) < 0) {
+		iounmap(fb_info.screen_base);
+		fb_info.screen_base = NULL;
+		return;
+    }
 
     printk("fb%d: S3 Trio frame buffer device on %s\n",
 	   fb_info.node, dp->full_name);
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/stifb.c linux-2.6.18/drivers/video/stifb.c
--- linux-2.6.18-orig/drivers/video/stifb.c	2006-09-21 10:15:42.000000000 +0530
+++ linux-2.6.18/drivers/video/stifb.c	2006-09-29 12:42:57.000000000 +0530
@@ -1291,6 +1291,7 @@ out_err3:
 out_err2:
 	release_mem_region(fix->smem_start, fix->smem_len);
 out_err1:
+	iounmap(info->screen_base);
 	fb_dealloc_cmap(&info->cmap);
 out_err0:
 	kfree(fb);
@@ -1364,6 +1365,8 @@ stifb_cleanup(void)
 			unregister_framebuffer(sti->info);
 			release_mem_region(info->fix.mmio_start, info->fix.mmio_len);
 		        release_mem_region(info->fix.smem_start, info->fix.smem_len);
+				if (info->screen_base)
+					iounmap(info->screen_base);
 		        fb_dealloc_cmap(&info->cmap);
 		        kfree(info); 
 		}
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/tgafb.c linux-2.6.18/drivers/video/tgafb.c
--- linux-2.6.18-orig/drivers/video/tgafb.c	2006-09-21 10:15:42.000000000 +0530
+++ linux-2.6.18/drivers/video/tgafb.c	2006-09-29 12:46:01.000000000 +0530
@@ -1473,6 +1473,8 @@ tgafb_pci_register(struct pci_dev *pdev,
 	return 0;
 
  err1:
+	if (mem_base)
+		iounmap(mem_base);
 	release_mem_region(bar0_start, bar0_len);
  err0:
 	kfree(all);
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/tridentfb.c linux-2.6.18/drivers/video/tridentfb.c
--- linux-2.6.18-orig/drivers/video/tridentfb.c	2006-09-21 10:15:42.000000000 +0530
+++ linux-2.6.18/drivers/video/tridentfb.c	2006-09-29 16:46:59.000000000 +0530
@@ -1130,7 +1130,8 @@ static int __devinit trident_pci_probe(s
 	
 	if (!request_mem_region(tridentfb_fix.smem_start, tridentfb_fix.smem_len, "tridentfb")) {
 		debug("request_mem_region failed!\n");
-		return -1;
+		err = -1;
+		goto out_unmap;
 	}
 
 	fb_info.screen_base = ioremap_nocache(tridentfb_fix.smem_start,
@@ -1139,7 +1140,8 @@ static int __devinit trident_pci_probe(s
 	if (!fb_info.screen_base) {
 		release_mem_region(tridentfb_fix.smem_start, tridentfb_fix.smem_len);
 		debug("ioremap failed\n");
-		return -1;
+		err = -1;
+		goto out_unmap;
 	}
 
 	output("%s board found\n", pci_name(dev));
@@ -1162,8 +1164,10 @@ static int __devinit trident_pci_probe(s
 #endif
 	fb_info.pseudo_palette = pseudo_pal;
 
-	if (!fb_find_mode(&default_var,&fb_info,mode,NULL,0,NULL,bpp))
-		return -EINVAL;
+	if (!fb_find_mode(&default_var,&fb_info,mode,NULL,0,NULL,bpp)) {
+		err = -EINVAL;
+		goto out_unmap;
+	}
 	fb_alloc_cmap(&fb_info.cmap,256,0);
 	if (defaultaccel && acc)
 		default_var.accel_flags |= FB_ACCELF_TEXT;
@@ -1174,12 +1178,20 @@ static int __devinit trident_pci_probe(s
 	fb_info.device = &dev->dev;
 	if (register_framebuffer(&fb_info) < 0) {
 		printk(KERN_ERR "tridentfb: could not register Trident framebuffer\n");
-		return -EINVAL;
+		err = -EINVAL;
+		goto out_unmap;
 	}
 	output("fb%d: %s frame buffer device %dx%d-%dbpp\n",
 	   fb_info.node, fb_info.fix.id,default_var.xres,
 	   default_var.yres,default_var.bits_per_pixel);
 	return 0;
+
+out_unmap:
+	if (default_par.io_virt)
+		iounmap(default_par.io_virt);
+	if (fb_info.screen_base)
+		iounmap(fb_info.screen_base);
+	return err;
 }
 
 static void __devexit trident_pci_remove(struct pci_dev * dev)
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/vesafb.c linux-2.6.18/drivers/video/vesafb.c
--- linux-2.6.18-orig/drivers/video/vesafb.c	2006-09-21 10:15:42.000000000 +0530
+++ linux-2.6.18/drivers/video/vesafb.c	2006-09-29 14:19:03.000000000 +0530
@@ -456,6 +456,8 @@ static int __init vesafb_probe(struct pl
 	       info->node, info->fix.id);
 	return 0;
 err:
+	if (info->screen_base)
+		iounmap(info->screen_base);
 	framebuffer_release(info);
 	release_mem_region(vesafb_fix.smem_start, size_total);
 	return err;
diff -uprN -X linux-2.6.18-orig/Documentation/dontdiff linux-2.6.18-orig/drivers/video/virgefb.c linux-2.6.18/drivers/video/virgefb.c
--- linux-2.6.18-orig/drivers/video/virgefb.c	2006-09-29 15:18:24.000000000 +0530
+++ linux-2.6.18/drivers/video/virgefb.c	2006-09-29 15:20:34.000000000 +0530
@@ -1799,7 +1799,7 @@ int __init virgefb_init(void)
 		#warning release resources
 		printk(KERN_ERR "virgefb.c: register_framebuffer failed\n");
 		DPRINTK("EXIT\n");
-		return -EINVAL;
+		goto out_unmap;
 	}
 
 	printk(KERN_INFO "fb%d: %s frame buffer device, using %ldK of video memory\n",
@@ -1809,6 +1809,21 @@ int __init virgefb_init(void)
 
 	DPRINTK("EXIT\n");
 	return 0;
+
+out_unmap:
+	if (board_addr >= 0x01000000) {
+		if (v_ram)
+			iounmap((void*)v_ram);
+		if (vgaio_regs)
+			iounmap(vgaio_regs);
+		if (mmio_regs)
+			iounmap(mmio_regs);
+		if (vcode_switch_base)
+			iounmap((void*)vcode_switch_base);
+		v_ram = vcode_switch_base = 0;
+		vgaio_regs = mmio_regs = NULL;
+	}
+	return -EINVAL;
 }
 


_______________________________________________
Kernel-janitors mailing list
Kernel-janitors@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/kernel-janitors



