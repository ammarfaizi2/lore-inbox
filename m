Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267263AbUIIVpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267263AbUIIVpZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266854AbUIIVpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:45:24 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:17058 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267633AbUIIVea
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:34:30 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 6/7] fbdev: Pass struct device to class_simple_device_add
Date: Fri, 10 Sep 2004 05:34:52 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org,
       Nigel Cunningham <ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409100534.52600.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Swsusp turns off the display when a power-management-enabled framebuffer
driver is used. According to Nigel Cunningham <ncunningham@linuxmail.org>,
the fix may involve the following:
  
"...I thought the best approach would be to use device classes to find the
struct dev for the frame buffer driver, and then use the same code I use for
storage devices to avoid suspending the frame buffer until later..."

Changes:

- pass info->device to class_simple_device_add()
- add struct device *device to struct fb_info
- store struct device in framebuffer_alloc()
- for drivers not using framebuffer_alloc(), store the struct during
  initalization
- port i810fb and rivafb to use framebuffer_alloc()

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/aty/atyfb_base.c       |    2
 drivers/video/chipsfb.c              |    2
 drivers/video/cyber2000fb.c          |    2
 drivers/video/fbmem.c                |    3 -
 drivers/video/fbsysfs.c              |    2
 drivers/video/i810/i810_main.c       |   75 +++++++++++++++--------------------
 drivers/video/igafb.c                |    1
 drivers/video/imsttfb.c              |    1
 drivers/video/kyro/fbdev.c           |    1
 drivers/video/matrox/matroxfb_base.c |    1
 drivers/video/pvr2fb.c               |    1
 drivers/video/radeonfb.c             |    2
 drivers/video/riva/fbdev.c           |   22 +++-------
 drivers/video/sstfb.c                |    1
 drivers/video/tgafb.c                |    1
 drivers/video/tridentfb.c            |    1
 include/linux/fb.h                   |    1
 17 files changed, 58 insertions(+), 61 deletions(-)

diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/aty/atyfb_base.c linux-2.6.9-rc1-mm4/drivers/video/aty/atyfb_base.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/aty/atyfb_base.c	2004-09-10 04:43:33.846740064 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/aty/atyfb_base.c	2004-09-10 04:59:00.261903552 +0800
@@ -1976,7 +1976,7 @@ int __init atyfb_init(void)
 
 			info->fix = atyfb_fix;
 			info->par = default_par;
-
+			info->device = &pdev->dev;
 #ifdef __sparc__
 			/*
 			 * Map memory-mapped registers.
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/chipsfb.c linux-2.6.9-rc1-mm4/drivers/video/chipsfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/chipsfb.c	2004-09-10 04:43:33.852739152 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/chipsfb.c	2004-09-10 04:59:00.263903248 +0800
@@ -416,7 +416,7 @@ chipsfb_pci_init(struct pci_dev *dp, con
 		release_mem_region(addr, size);
 		return -ENOMEM;
 	}
-
+	p->device = &dp->dev;
 	init_chips(p, addr);
 
 #ifdef CONFIG_PMAC_PBOOK
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/cyber2000fb.c linux-2.6.9-rc1-mm4/drivers/video/cyber2000fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/cyber2000fb.c	2004-09-10 04:43:33.862737632 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/cyber2000fb.c	2004-09-10 04:59:00.265902944 +0800
@@ -1399,6 +1399,8 @@ static int __devinit cyberpro_common_pro
 		cfb->fb.var.xres, cfb->fb.var.yres,
 		h_sync / 1000, h_sync % 1000, v_sync);
 
+	if (cfb->dev)
+		cfb->fb.device = &cfb->dev->dev;
 	err = register_framebuffer(&cfb->fb);
 
 failed:
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/fbmem.c linux-2.6.9-rc1-mm4/drivers/video/fbmem.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/fbmem.c	2004-09-10 04:59:19.627959464 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/fbmem.c	2004-09-10 04:59:00.268902488 +0800
@@ -1131,7 +1131,8 @@ register_framebuffer(struct fb_info *fb_
 			break;
 	fb_info->node = i;
 
-	c = class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i), NULL, "fb%d", i);
+	c = class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i),
+				    fb_info->device, "fb%d", i);
 	if (IS_ERR(c)) {
 		/* Not fatal */
 		printk(KERN_WARNING "Unable to create class_device for framebuffer %d; errno = %ld\n", i, PTR_ERR(c));
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/fbsysfs.c linux-2.6.9-rc1-mm4/drivers/video/fbsysfs.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/fbsysfs.c	2004-09-10 04:43:33.866737024 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/fbsysfs.c	2004-09-10 04:59:00.269902336 +0800
@@ -51,6 +51,8 @@ struct fb_info *framebuffer_alloc(size_t
 	if (size)
 		info->par = p + fb_info_size;
 
+	info->device = dev;
+
 	return info;
 #undef PADDING
 #undef BYTES_PER_LONG
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/i810/i810_main.c linux-2.6.9-rc1-mm4/drivers/video/i810/i810_main.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/i810/i810_main.c	2004-09-10 04:43:33.875735656 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/i810/i810_main.c	2004-09-10 04:59:00.271902032 +0800
@@ -1855,20 +1855,13 @@ static int __devinit i810fb_init_pci (st
 	int i, err = -1, vfreq, hfreq, pixclock;
 
 	i = 0;
-	if (!(info = kmalloc(sizeof(struct fb_info), GFP_KERNEL))) {
-		i810fb_release_resource(info, par);
-		return -ENOMEM;
-	}
-	memset(info, 0, sizeof(struct fb_info));
 
-	if(!(par = kmalloc(sizeof(struct i810fb_par), GFP_KERNEL))) {
-		i810fb_release_resource(info, par);
+	info = framebuffer_alloc(sizeof(struct i810fb_par), &dev->dev);
+	if (!info)
 		return -ENOMEM;
-	}
-	memset(par, 0, sizeof(struct i810fb_par));
 
+	par = (struct i810fb_par *) info->par;
 	par->dev = dev;
-	info->par = par;
 
 	if (!(info->pixmap.addr = kmalloc(64*1024, GFP_KERNEL))) {
 		i810fb_release_resource(info, par);
@@ -1941,38 +1934,36 @@ static int __devinit i810fb_init_pci (st
 static void i810fb_release_resource(struct fb_info *info, 
 				    struct i810fb_par *par)
 {
-	if (par) {
-		unset_mtrr(par);
-		if (par->drm_agp) {
-			drm_agp_t *agp = par->drm_agp;
-			struct gtt_data *gtt = &par->i810_gtt;
-
-			if (par->i810_gtt.i810_cursor_memory) 
-				agp->free_memory(gtt->i810_cursor_memory);
-			if (par->i810_gtt.i810_fb_memory) 
-				agp->free_memory(gtt->i810_fb_memory);
-
-			inter_module_put("drm_agp");
-			par->drm_agp = NULL;
-		}
-
-		if (par->mmio_start_virtual) 
-			iounmap(par->mmio_start_virtual);
-		if (par->aperture.virtual) 
-			iounmap(par->aperture.virtual);
-
-		if (par->res_flags & FRAMEBUFFER_REQ)
-			release_mem_region(par->aperture.physical, 
-					   par->aperture.size);
-		if (par->res_flags & MMIO_REQ)
-			release_mem_region(par->mmio_start_phys, MMIO_SIZE);
+	unset_mtrr(par);
+	if (par->drm_agp) {
+		drm_agp_t *agp = par->drm_agp;
+		struct gtt_data *gtt = &par->i810_gtt;
+
+		if (par->i810_gtt.i810_cursor_memory)
+			agp->free_memory(gtt->i810_cursor_memory);
+		if (par->i810_gtt.i810_fb_memory)
+			agp->free_memory(gtt->i810_fb_memory);
+
+		inter_module_put("drm_agp");
+		par->drm_agp = NULL;
+	}
+
+	if (par->mmio_start_virtual)
+		iounmap(par->mmio_start_virtual);
+	if (par->aperture.virtual)
+		iounmap(par->aperture.virtual);
+
+	if (par->res_flags & FRAMEBUFFER_REQ)
+		release_mem_region(par->aperture.physical,
+				   par->aperture.size);
+	if (par->res_flags & MMIO_REQ)
+		release_mem_region(par->mmio_start_phys, MMIO_SIZE);
 
-		if (par->res_flags & PCI_DEVICE_ENABLED)
-			pci_disable_device(par->dev); 
+	if (par->res_flags & PCI_DEVICE_ENABLED)
+		pci_disable_device(par->dev);
+
+	framebuffer_release(info);
 
-		kfree(par);
-	}
-	kfree(info);
 }
 
 static void __exit i810fb_remove_pci(struct pci_dev *dev)
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/igafb.c linux-2.6.9-rc1-mm4/drivers/video/igafb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/igafb.c	2004-09-10 04:43:33.878735200 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/igafb.c	2004-09-10 04:59:00.273901728 +0800
@@ -528,6 +528,7 @@ int __init igafb_init(void)
 	info->var = default_var;
 	info->fix = igafb_fix;
 	info->pseudo_palette = (void *)(par + 1);
+	info->device = &pdev->dev;
 
 	if (!iga_init(info, par)) {
 		iounmap((void *)par->io_base);
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/imsttfb.c linux-2.6.9-rc1-mm4/drivers/video/imsttfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/imsttfb.c	2004-09-10 04:43:33.902731552 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/imsttfb.c	2004-09-10 04:59:00.275901424 +0800
@@ -1524,6 +1524,7 @@ imsttfb_probe(struct pci_dev *pdev, cons
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
 	info->par = par;
 	info->pseudo_palette = (void *) (par + 1);
+	info->device = &pdev->dev;
 	init_imstt(info);
 
 	pci_set_drvdata(pdev, info);
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/kyro/fbdev.c linux-2.6.9-rc1-mm4/drivers/video/kyro/fbdev.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/kyro/fbdev.c	2004-09-10 04:43:33.918729120 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/kyro/fbdev.c	2004-09-10 04:59:00.277901120 +0800
@@ -735,6 +735,7 @@ static int __devinit kyrofb_probe(struct
 
 	fb_memset(info->screen_base, 0, size);
 
+	info->device = &pdev->dev;
 	if (register_framebuffer(info) < 0)
 		goto out_unmap;
 
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/matrox/matroxfb_base.c linux-2.6.9-rc1-mm4/drivers/video/matrox/matroxfb_base.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/matrox/matroxfb_base.c	2004-09-10 04:43:33.927727752 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/matrox/matroxfb_base.c	2004-09-10 04:59:00.280900664 +0800
@@ -1864,6 +1864,7 @@ static int initMatrox2(WPMINFO struct bo
 /* We do not have to set currcon to 0... register_framebuffer do it for us on first console
  * and we do not want currcon == 0 for subsequent framebuffers */
 
+	ACCESS_FBINFO(fbcon).device = &ACCESS_FBINFO(pcidev)->dev;
 	if (register_framebuffer(&ACCESS_FBINFO(fbcon)) < 0) {
 		goto failVideoIO;
 	}
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/pvr2fb.c linux-2.6.9-rc1-mm4/drivers/video/pvr2fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/pvr2fb.c	2004-09-10 04:43:33.935726536 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/pvr2fb.c	2004-09-10 04:59:00.283900208 +0800
@@ -939,6 +939,7 @@ static int __devinit pvr2fb_pci_probe(st
 
 	pvr2_fix.mmio_start	= pci_resource_start(pdev, 1);
 	pvr2_fix.mmio_len	= pci_resource_len(pdev, 1);
+	fbinfo->device = &pdev->dev;
 
 	return pvr2fb_common_init();
 }
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/radeonfb.c linux-2.6.9-rc1-mm4/drivers/video/radeonfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/radeonfb.c	2004-09-10 04:43:33.946724864 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/radeonfb.c	2004-09-10 04:59:00.286899752 +0800
@@ -3040,7 +3040,7 @@ static int radeonfb_pci_register (struct
 	pci_set_drvdata(pdev, rinfo);
 	rinfo->next = board_list;
 	board_list = rinfo;
-
+	((struct fb_info *) rinfo)->device = &pdev->dev;
 	if (register_framebuffer ((struct fb_info *) rinfo) < 0) {
 		printk ("radeonfb: could not register framebuffer\n");
 		iounmap ((void*)rinfo->fb_base);
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/riva/fbdev.c linux-2.6.9-rc1-mm4/drivers/video/riva/fbdev.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/riva/fbdev.c	2004-09-10 04:58:27.705852824 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/riva/fbdev.c	2004-09-10 04:59:00.289899296 +0800
@@ -1858,21 +1858,17 @@ static int __devinit rivafb_probe(struct
 	NVTRACE_ENTER();
 	assert(pd != NULL);
 
-	info = kmalloc(sizeof(struct fb_info), GFP_KERNEL);
+	info = framebuffer_alloc(sizeof(struct riva_par), &pd->dev);
+
 	if (!info)
 		goto err_out;
 
-	default_par = kmalloc(sizeof(struct riva_par), GFP_KERNEL);
-	if (!default_par)
-		goto err_out_kfree;
-
-	memset(info, 0, sizeof(struct fb_info));
-	memset(default_par, 0, sizeof(struct riva_par));
+	default_par = (struct riva_par *) info->par;
 	default_par->pdev = pd;
 
 	info->pixmap.addr = kmalloc(64 * 1024, GFP_KERNEL);
 	if (info->pixmap.addr == NULL)
-		goto err_out_kfree1;
+		goto err_out_kfree;
 	memset(info->pixmap.addr, 0, 64 * 1024);
 
 	if (pci_enable_device(pd)) {
@@ -1896,7 +1892,7 @@ static int __devinit rivafb_probe(struct
 
 	if(default_par->riva.Architecture == 0) {
 		printk(KERN_ERR PFX "unknown NV_ARCH\n");
-		goto err_out_kfree1;
+		goto err_out_free_base0;
 	}
 	if(default_par->riva.Architecture == NV_ARCH_10 ||
 	   default_par->riva.Architecture == NV_ARCH_20 ||
@@ -2001,7 +1997,6 @@ static int __devinit rivafb_probe(struct
 	fb_destroy_modedb(info->monspecs.modedb);
 	info->monspecs.modedb_len = 0;
 	info->monspecs.modedb = NULL;
-
 	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR PFX
 			"error registering riva framebuffer\n");
@@ -2040,10 +2035,8 @@ err_out_request:
 	pci_disable_device(pd);
 err_out_enable:
 	kfree(info->pixmap.addr);
-err_out_kfree1:
-	kfree(default_par);
 err_out_kfree:
-	kfree(info);
+	framebuffer_release(info);
 err_out:
 	return -ENODEV;
 }
@@ -2077,8 +2070,7 @@ static void __exit rivafb_remove(struct 
 	pci_release_regions(pd);
 	pci_disable_device(pd);
 	kfree(info->pixmap.addr);
-	kfree(par);
-	kfree(info);
+	framebuffer_release(info);
 	pci_set_drvdata(pd, NULL);
 	NVTRACE_LEAVE();
 }
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/sstfb.c linux-2.6.9-rc1-mm4/drivers/video/sstfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/sstfb.c	2004-09-10 04:43:33.966721824 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/sstfb.c	2004-09-10 04:59:00.292898840 +0800
@@ -1507,6 +1507,7 @@ static int __devinit sstfb_probe(struct 
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
 	/* register fb */
+	info->device = &pdev->dev;
 	if (register_framebuffer(info) < 0) {
 		eprintk("can't register framebuffer.\n");
 		goto fail;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/tgafb.c linux-2.6.9-rc1-mm4/drivers/video/tgafb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/tgafb.c	2004-09-10 04:43:33.975720456 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/tgafb.c	2004-09-10 04:59:00.294898536 +0800
@@ -1454,6 +1454,7 @@ tgafb_pci_register(struct pci_dev *pdev,
 	tgafb_set_par(&all->info);
 	tgafb_init_fix(&all->info);
 
+	all->info.device = &pdev->dev;
 	if (register_framebuffer(&all->info) < 0) {
 		printk(KERN_ERR "tgafb: Could not register framebuffer\n");
 		ret = -EINVAL;
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/tridentfb.c linux-2.6.9-rc1-mm4/drivers/video/tridentfb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/tridentfb.c	2004-09-10 04:43:33.985718936 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/tridentfb.c	2004-09-10 04:59:00.296898232 +0800
@@ -1164,6 +1164,7 @@ static int __devinit trident_pci_probe(s
 		default_var.accel_flags &= ~FB_ACCELF_TEXT;
 	default_var.activate |= FB_ACTIVATE_NOW;
 	fb_info.var = default_var;
+	fb_info.device = &dev->dev;
 	if (register_framebuffer(&fb_info) < 0) {
 		output("Could not register Trident framebuffer\n");
 		return -EINVAL;
diff -uprN linux-2.6.9-rc1-mm4-orig/include/linux/fb.h linux-2.6.9-rc1-mm4/include/linux/fb.h
--- linux-2.6.9-rc1-mm4-orig/include/linux/fb.h	2004-09-10 04:58:27.708852368 +0800
+++ linux-2.6.9-rc1-mm4/include/linux/fb.h	2004-09-10 04:59:00.298897928 +0800
@@ -601,6 +601,7 @@ struct fb_info {
 	struct fb_cmap cmap;		/* Current cmap */
 	struct list_head modelist;      /* mode list */
 	struct fb_ops *fbops;
+	struct device *device;
 	char *screen_base;		/* Virtual address */
 	int currcon;			/* Current VC. */
 	void *pseudo_palette;		/* Fake palette of 16 colors */ 


