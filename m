Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264912AbUGLGWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264912AbUGLGWp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 02:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266735AbUGLGWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 02:22:45 -0400
Received: from havoc.gtf.org ([216.162.42.101]:20163 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264912AbUGLGWh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 02:22:37 -0400
Date: Mon, 12 Jul 2004 02:22:36 -0400
From: David Eger <eger@havoc.gtf.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH] radeonfb: cleanup and little fixes
Message-ID: <20040712062236.GA17610@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andrew, Please apply.

radeonfb: cleanup and little fixes

Very similar to François Romieu's fixes for cirrusfb, here we:
* Provide meaningful error values from radeonfb_pci_register()
* Fix unbalanced pci_enable_device()
* Fix unbalanced fb_alloc_cmap()
* Fix a failure-case bug where we accidentally memset_io(0, 0, size);
* Use pci_request_regions() instead of request_mem_region()

Signed-off-by: David Eger <eger@havoc.gtf.org>

diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c	2004-07-12 07:58:26 +02:00
+++ b/drivers/video/aty/radeon_base.c	2004-07-12 07:58:26 +02:00
@@ -2069,19 +2069,22 @@
 	struct fb_info *info;
 	struct radeonfb_info *rinfo;
 	u32 tmp;
+	int ret;
 
 	RTRACE("radeonfb_pci_register BEGIN\n");
 	
 	/* Enable device in PCI config */
-	if (pci_enable_device(pdev) != 0) {
+	ret = pci_enable_device(pdev);
+	if (ret < 0) {
 		printk(KERN_ERR "radeonfb: Cannot enable PCI device\n");
-		return -ENODEV;
+		goto err_out;
 	}
 
 	info = framebuffer_alloc(sizeof(struct radeonfb_info), &pdev->dev);
 	if (!info) {
 		printk (KERN_ERR "radeonfb: could not allocate memory\n");
-		return -ENODEV;
+		ret = -ENOMEM;
+		goto err_disable;
 	}
 	rinfo = info->par;
 	rinfo->info = info;	
@@ -2106,23 +2109,19 @@
 	rinfo->mmio_base_phys = pci_resource_start (pdev, 2);
 
 	/* request the mem regions */
-	if (!request_mem_region (rinfo->fb_base_phys,
-				 pci_resource_len(pdev, 0), "radeonfb")) {
-		printk (KERN_ERR "radeonfb: cannot reserve FB region\n");
-		goto free_rinfo;
-	}
-
-	if (!request_mem_region (rinfo->mmio_base_phys,
-				 pci_resource_len(pdev, 2), "radeonfb")) {
-		printk (KERN_ERR "radeonfb: cannot reserve MMIO region\n");
-		goto release_fb;
+	ret = pci_request_regions(pdev, "radeonfb");
+	if (ret < 0) {
+		printk( KERN_ERR "radeonfb: cannot reserve PCI regions."
+			"  Someone already got them?\n");
+		goto err_release_fb;
 	}
 
 	/* map the regions */
-	rinfo->mmio_base = (unsigned long) ioremap (rinfo->mmio_base_phys, RADEON_REGSIZE);
+	rinfo->mmio_base = (unsigned long) ioremap(rinfo->mmio_base_phys, RADEON_REGSIZE);
 	if (!rinfo->mmio_base) {
-		printk (KERN_ERR "radeonfb: cannot map MMIO\n");
-		goto release_mmio;
+		printk(KERN_ERR "radeonfb: cannot map MMIO\n");
+		ret = -EIO;
+		goto err_release_pci;
 	}
 
 	/* On PPC, the firmware sets up a memory mapping that tends
@@ -2226,23 +2225,20 @@
 
 	RTRACE("radeonfb: probed %s %ldk videoram\n", (rinfo->ram_type), (rinfo->video_ram/1024));
 
-	rinfo->mapped_vram = MAX_MAPPED_VRAM;
-	if (rinfo->video_ram < rinfo->mapped_vram)
-		rinfo->mapped_vram = rinfo->video_ram;
-	for (;;) {
+	rinfo->mapped_vram = min_t(unsigned long, MAX_MAPPED_VRAM, rinfo->video_ram);
+
+	do {
 		rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys,
 							  rinfo->mapped_vram);
-		if (rinfo->fb_base == 0 && rinfo->mapped_vram > MIN_MAPPED_VRAM) {
-			rinfo->mapped_vram /= 2;
-			continue;
-		}
-		memset_io(rinfo->fb_base, 0, rinfo->mapped_vram);
-		break;
-	}
+	} while (   rinfo->fb_base == 0 && 
+		  ((rinfo->mapped_vram /=2) >= MIN_MAPPED_VRAM) );
 
-	if (!rinfo->fb_base) {
+	if (rinfo->fb_base) 
+		memset_io(rinfo->fb_base, 0, rinfo->mapped_vram);
+	else {
 		printk (KERN_ERR "radeonfb: cannot map FB\n");
-		goto unmap_rom;
+		ret = -EIO;
+		goto err_unmap_rom;
 	}
 
 	RTRACE("radeonfb: mapped %ldk videoram\n", rinfo->mapped_vram/1024);
@@ -2329,10 +2325,11 @@
 		radeon_pm_enable_dynamic_mode(rinfo);
 		printk("radeonfb: Power Management enabled for Mobility chipsets\n");
 	}
-
-	if (register_framebuffer(info) < 0) {
+	
+	ret = register_framebuffer(info);
+	if (ret < 0) {
 		printk (KERN_ERR "radeonfb: could not register framebuffer\n");
-		goto unmap_fb;
+		goto err_unmap_fb;
 	}
 
 #ifdef CONFIG_MTRR
@@ -2358,30 +2355,30 @@
 	RTRACE("radeonfb_pci_register END\n");
 
 	return 0;
-unmap_fb:
+err_unmap_fb:
 	iounmap ((void*)rinfo->fb_base);
-unmap_rom:	
+err_unmap_rom:	
 	if (rinfo->mon1_EDID)
 	    kfree(rinfo->mon1_EDID);
 	if (rinfo->mon2_EDID)
 	    kfree(rinfo->mon2_EDID);
 	if (rinfo->mon1_modedb)
 		fb_destroy_modedb(rinfo->mon1_modedb);
+	fb_dealloc_cmap(&info->cmap);
 #ifdef CONFIG_FB_RADEON_I2C
 	radeon_delete_i2c_busses(rinfo);
 #endif
 	if (rinfo->bios_seg)
 		radeon_unmap_ROM(rinfo, pdev);
 	iounmap ((void*)rinfo->mmio_base);
-release_mmio:
-	release_mem_region (rinfo->mmio_base_phys,
-			    pci_resource_len(pdev, 2));
-release_fb:	
-	release_mem_region (rinfo->fb_base_phys,
-			    pci_resource_len(pdev, 0));
-free_rinfo:	
+err_release_pci:
+	pci_release_regions(pdev);
+err_release_fb:	
 	framebuffer_release(info);
-	return -ENODEV;
+err_disable:
+	pci_disable_device(pdev);
+err_out:
+	return ret;
 }
 
 
@@ -2413,10 +2410,7 @@
         iounmap ((void*)rinfo->mmio_base);
         iounmap ((void*)rinfo->fb_base);
  
-	release_mem_region (rinfo->mmio_base_phys,
-			    pci_resource_len(pdev, 2));
-	release_mem_region (rinfo->fb_base_phys,
-			    pci_resource_len(pdev, 0));
+ 	pci_release_regions(pdev);
 
 	if (rinfo->mon1_EDID)
 		kfree(rinfo->mon1_EDID);
@@ -2427,7 +2421,9 @@
 #ifdef CONFIG_FB_RADEON_I2C
 	radeon_delete_i2c_busses(rinfo);
 #endif        
+	fb_dealloc_cmap(&info->cmap);
         framebuffer_release(info);
+	pci_disable_device(pdev);
 }
 
 
