Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268234AbUIPWsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268234AbUIPWsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268293AbUIPWsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:48:19 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:28831 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S268234AbUIPWrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:47:40 -0400
Subject: Re: [PATCH] Suspend2 Merge: Driver model patches 2/2
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040916223539.GA16151@kroah.com>
References: <1095332331.3855.161.camel@laptop.cunninghams>
	 <20040916142847.GA32352@kroah.com>
	 <1095373127.5897.23.camel@laptop.cunninghams>
	 <20040916223539.GA16151@kroah.com>
Content-Type: multipart/mixed; boundary="=-05mn05o6HeBKZhcgCdhy"
Message-Id: <1095374947.6537.34.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 17 Sep 2004 08:49:07 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-05mn05o6HeBKZhcgCdhy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Fri, 2004-09-17 at 08:35, Greg KH wrote:
> > > Ick, no.  I've been over this before with the fb people, and am not going
> > > to accept this patch (nevermind that it's broken...)  See the lkml
> > > archives for more info on why I don't like this.
> > 
> > Please excuse my ignorance but I don't see how it's broken
> 
> This function, as written is very broken.  I will not accept it.  Not to

What's broken? (I want to learn what I've done wrong that I'm not
seeing).

> mention the fact that the functionality this function proposes to offer
> is not needed either.
> 
> > (their patch just fills in a field that was left blank previously),
> 
> What patch?

Attached. Sorry if I wrongly assumed this was the patch you're talking
about.

> > and this patch just makes use of that change. What's the point to
> > device_class if we don't use it?
> 
> I don't see a use of device_class in this function.  I'm confused.

This patch finds the device_class that the frame buffer drivers
register. It gets called by suspend code I haven't posted yet, which
then moves the drivers in this class from one pm tree to another so that
the frame buffer drivers don't get suspended until it's time for the
atomic snapshot and can be resumed afterwards while we write the rest of
the image, without resuming all drivers. Given Pavel's work with the new
_SNAPSHOT flag, I guess this won't eventually be needed (provided, of
course that drivers do the right thing when called with _SNAPSHOT).

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

--=-05mn05o6HeBKZhcgCdhy
Content-Disposition: attachment; filename=204-frame-buffer-class-support
Content-Type: text/x-patch; name=204-frame-buffer-class-support; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

diff -ruN linux-2.6.9-rc1/drivers/video/aty/atyfb_base.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/aty/atyfb_base.c
--- linux-2.6.9-rc1/drivers/video/aty/atyfb_base.c	2004-09-07 21:58:51.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/aty/atyfb_base.c	2004-09-09 19:36:24.000000000 +1000
@@ -1972,7 +1972,7 @@
 
 			info->fix = atyfb_fix;
 			info->par = default_par;
-
+			info->device = &pdev->dev;
 #ifdef __sparc__
 			/*
 			 * Map memory-mapped registers.
diff -ruN linux-2.6.9-rc1/drivers/video/chipsfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/chipsfb.c
--- linux-2.6.9-rc1/drivers/video/chipsfb.c	2004-09-07 21:58:51.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/chipsfb.c	2004-09-09 19:36:24.000000000 +1000
@@ -416,7 +416,7 @@
 		release_mem_region(addr, size);
 		return -ENOMEM;
 	}
-
+	p->device = &dp->dev;
 	init_chips(p, addr);
 
 #ifdef CONFIG_PMAC_PBOOK
diff -ruN linux-2.6.9-rc1/drivers/video/cyber2000fb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/cyber2000fb.c
--- linux-2.6.9-rc1/drivers/video/cyber2000fb.c	2004-09-07 21:58:51.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/cyber2000fb.c	2004-09-09 19:36:24.000000000 +1000
@@ -1399,6 +1399,8 @@
 		cfb->fb.var.xres, cfb->fb.var.yres,
 		h_sync / 1000, h_sync % 1000, v_sync);
 
+	if (cfb->dev)
+		cfb->fb.device = &cfb->dev->dev;
 	err = register_framebuffer(&cfb->fb);
 
 failed:
diff -ruN linux-2.6.9-rc1/drivers/video/fbmem.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/fbmem.c
--- linux-2.6.9-rc1/drivers/video/fbmem.c	2004-09-07 21:58:51.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/fbmem.c	2004-09-09 19:36:24.000000000 +1000
@@ -1444,7 +1444,8 @@
 			break;
 	fb_info->node = i;
 
-	c = class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i), NULL, "fb%d", i);
+	c = class_simple_device_add(fb_class, MKDEV(FB_MAJOR, i),
+				    fb_info->device, "fb%d", i);
 	if (IS_ERR(c)) {
 		/* Not fatal */
 		printk(KERN_WARNING "Unable to create class_device for framebuffer %d; errno = %ld\n", i, PTR_ERR(c));
diff -ruN linux-2.6.9-rc1/drivers/video/fbsysfs.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/fbsysfs.c
--- linux-2.6.9-rc1/drivers/video/fbsysfs.c	2004-02-18 19:16:01.000000000 +1100
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/fbsysfs.c	2004-09-09 19:36:24.000000000 +1000
@@ -51,6 +51,8 @@
 	if (size)
 		info->par = p + fb_info_size;
 
+	info->device = dev;
+
 	return info;
 #undef PADDING
 #undef BYTES_PER_LONG
diff -ruN linux-2.6.9-rc1/drivers/video/i810/i810_main.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/i810/i810_main.c
--- linux-2.6.9-rc1/drivers/video/i810/i810_main.c	2004-09-07 21:58:52.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/i810/i810_main.c	2004-09-09 19:36:24.000000000 +1000
@@ -1855,20 +1855,13 @@
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
@@ -1941,38 +1934,36 @@
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
diff -ruN linux-2.6.9-rc1/drivers/video/igafb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/igafb.c
--- linux-2.6.9-rc1/drivers/video/igafb.c	2004-09-07 21:58:52.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/igafb.c	2004-09-09 19:36:24.000000000 +1000
@@ -528,6 +528,7 @@
 	info->var = default_var;
 	info->fix = igafb_fix;
 	info->pseudo_palette = (void *)(par + 1);
+	info->device = &pdev->dev;
 
 	if (!iga_init(info, par)) {
 		iounmap((void *)par->io_base);
diff -ruN linux-2.6.9-rc1/drivers/video/imsttfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/imsttfb.c
--- linux-2.6.9-rc1/drivers/video/imsttfb.c	2004-09-07 21:58:52.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/imsttfb.c	2004-09-09 19:36:24.000000000 +1000
@@ -1524,6 +1524,7 @@
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
 	info->par = par;
 	info->pseudo_palette = (void *) (par + 1);
+	info->device = &pdev->dev;
 	init_imstt(info);
 
 	pci_set_drvdata(pdev, info);
diff -ruN linux-2.6.9-rc1/drivers/video/kyro/fbdev.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/kyro/fbdev.c
--- linux-2.6.9-rc1/drivers/video/kyro/fbdev.c	2004-09-07 21:58:52.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/kyro/fbdev.c	2004-09-09 19:36:24.000000000 +1000
@@ -735,6 +735,7 @@
 
 	fb_memset(info->screen_base, 0, size);
 
+	info->device = &pdev->dev;
 	if (register_framebuffer(info) < 0)
 		goto out_unmap;
 
diff -ruN linux-2.6.9-rc1/drivers/video/matrox/matroxfb_base.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/matrox/matroxfb_base.c
--- linux-2.6.9-rc1/drivers/video/matrox/matroxfb_base.c	2004-09-07 21:58:52.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/matrox/matroxfb_base.c	2004-09-09 19:36:24.000000000 +1000
@@ -1864,6 +1864,7 @@
 /* We do not have to set currcon to 0... register_framebuffer do it for us on first console
  * and we do not want currcon == 0 for subsequent framebuffers */
 
+	ACCESS_FBINFO(fbcon).device = &ACCESS_FBINFO(pcidev)->dev;
 	if (register_framebuffer(&ACCESS_FBINFO(fbcon)) < 0) {
 		goto failVideoIO;
 	}
diff -ruN linux-2.6.9-rc1/drivers/video/pvr2fb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/pvr2fb.c
--- linux-2.6.9-rc1/drivers/video/pvr2fb.c	2004-09-07 21:58:52.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/pvr2fb.c	2004-09-09 19:36:24.000000000 +1000
@@ -939,6 +939,7 @@
 
 	pvr2_fix.mmio_start	= pci_resource_start(pdev, 1);
 	pvr2_fix.mmio_len	= pci_resource_len(pdev, 1);
+	fbinfo->device = &pdev->dev;
 
 	return pvr2fb_common_init();
 }
diff -ruN linux-2.6.9-rc1/drivers/video/radeonfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/radeonfb.c
--- linux-2.6.9-rc1/drivers/video/radeonfb.c	2004-09-07 21:58:52.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/radeonfb.c	2004-09-09 19:36:24.000000000 +1000
@@ -3040,7 +3040,7 @@
 	pci_set_drvdata(pdev, rinfo);
 	rinfo->next = board_list;
 	board_list = rinfo;
-
+	((struct fb_info *) rinfo)->device = &pdev->dev;
 	if (register_framebuffer ((struct fb_info *) rinfo) < 0) {
 		printk ("radeonfb: could not register framebuffer\n");
 		iounmap ((void*)rinfo->fb_base);
diff -ruN linux-2.6.9-rc1/drivers/video/riva/fbdev.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/riva/fbdev.c
--- linux-2.6.9-rc1/drivers/video/riva/fbdev.c	2004-09-07 21:58:52.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/riva/fbdev.c	2004-09-09 19:36:24.000000000 +1000
@@ -1850,21 +1850,17 @@
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
@@ -1888,7 +1884,7 @@
 
 	if(default_par->riva.Architecture == 0) {
 		printk(KERN_ERR PFX "unknown NV_ARCH\n");
-		goto err_out_kfree1;
+		goto err_out_free_base0;
 	}
 	if(default_par->riva.Architecture == NV_ARCH_10 ||
 	   default_par->riva.Architecture == NV_ARCH_20 ||
@@ -1994,7 +1990,6 @@
 	fb_destroy_modedb(info->monspecs.modedb);
 	info->monspecs.modedb_len = 0;
 	info->monspecs.modedb = NULL;
-
 	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR PFX
 			"error registering riva framebuffer\n");
@@ -2033,10 +2028,8 @@
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
@@ -2070,8 +2063,7 @@
 	pci_release_regions(pd);
 	pci_disable_device(pd);
 	kfree(info->pixmap.addr);
-	kfree(par);
-	kfree(info);
+	framebuffer_release(info);
 	pci_set_drvdata(pd, NULL);
 	NVTRACE_LEAVE();
 }
diff -ruN linux-2.6.9-rc1/drivers/video/sstfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/sstfb.c
--- linux-2.6.9-rc1/drivers/video/sstfb.c	2004-09-07 21:58:52.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/sstfb.c	2004-09-09 19:36:24.000000000 +1000
@@ -1507,6 +1507,7 @@
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
 	/* register fb */
+	info->device = &pdev->dev;
 	if (register_framebuffer(info) < 0) {
 		eprintk("can't register framebuffer.\n");
 		goto fail;
diff -ruN linux-2.6.9-rc1/drivers/video/tgafb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/tgafb.c
--- linux-2.6.9-rc1/drivers/video/tgafb.c	2004-09-07 21:58:52.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/tgafb.c	2004-09-09 19:36:24.000000000 +1000
@@ -1454,6 +1454,7 @@
 	tgafb_set_par(&all->info);
 	tgafb_init_fix(&all->info);
 
+	all->info.device = &pdev->dev;
 	if (register_framebuffer(&all->info) < 0) {
 		printk(KERN_ERR "tgafb: Could not register framebuffer\n");
 		ret = -EINVAL;
diff -ruN linux-2.6.9-rc1/drivers/video/tridentfb.c software-suspend-linux-2.6.9-rc1-rev3/drivers/video/tridentfb.c
--- linux-2.6.9-rc1/drivers/video/tridentfb.c	2004-09-07 21:58:52.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/drivers/video/tridentfb.c	2004-09-09 19:36:24.000000000 +1000
@@ -1164,6 +1164,7 @@
 		default_var.accel_flags &= ~FB_ACCELF_TEXT;
 	default_var.activate |= FB_ACTIVATE_NOW;
 	fb_info.var = default_var;
+	fb_info.device = &dev->dev;
 	if (register_framebuffer(&fb_info) < 0) {
 		output("Could not register Trident framebuffer\n");
 		return -EINVAL;
diff -ruN linux-2.6.9-rc1/include/linux/fb.h software-suspend-linux-2.6.9-rc1-rev3/include/linux/fb.h
--- linux-2.6.9-rc1/include/linux/fb.h	2004-09-07 21:58:59.000000000 +1000
+++ software-suspend-linux-2.6.9-rc1-rev3/include/linux/fb.h	2004-09-09 19:36:24.000000000 +1000
@@ -595,6 +595,7 @@
 	struct fb_pixmap sprite;	/* Cursor hardware mapper */
 	struct fb_cmap cmap;		/* Current cmap */
 	struct fb_ops *fbops;
+	struct device *device;
 	char *screen_base;		/* Virtual address */
 	int currcon;			/* Current VC. */
 	void *pseudo_palette;		/* Fake palette of 16 colors */ 

--=-05mn05o6HeBKZhcgCdhy--

