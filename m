Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTHTTLX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 15:11:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbTHTTLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 15:11:22 -0400
Received: from mail.kroah.org ([65.200.24.183]:48616 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262175AbTHTTKm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 15:10:42 -0400
Date: Wed, 20 Aug 2003 12:10:01 -0700
From: Greg KH <greg@kroah.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [RFC] add class/video to fb drivers - Take 2
Message-ID: <20030820191001.GA4185@kroah.com>
References: <20030819002754.GB1363@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030819002754.GB1363@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, here's a smaller version of the patch, that doesn't break any fb
drivers.  Only those that have a struct device associated with them
should be changed (and that's just a 1 line addition).  I think it's
much better because of this.

Any comments?

thanks,

greg k-h


diff -Nru a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
--- a/drivers/video/aty/aty128fb.c	Wed Aug 20 11:43:10 2003
+++ b/drivers/video/aty/aty128fb.c	Wed Aug 20 11:43:10 2003
@@ -1536,6 +1536,7 @@
 	/* fill in info */
 	info->fbops = &aty128fb_ops;
 	info->flags = FBINFO_FLAG_DEFAULT;
+	info->dev = &pdev->dev;
 
 #ifdef CONFIG_PMAC_PBOOK
 	par->lcd_on = default_lcd_on;
diff -Nru a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
--- a/drivers/video/cirrusfb.c	Wed Aug 20 11:43:10 2003
+++ b/drivers/video/cirrusfb.c	Wed Aug 20 11:43:10 2003
@@ -2787,6 +2787,7 @@
 	fb_info->gen.info.switch_con = &fbgen_switch;
 	fb_info->gen.info.updatevar = &fbgen_update_var;
 	fb_info->gen.info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info->gen.info.dev = fb_info->pdev;
 
 	for (j = 0; j < 256; j++) {
 		if (j < 16) {
diff -Nru a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
--- a/drivers/video/cyber2000fb.c	Wed Aug 20 11:43:12 2003
+++ b/drivers/video/cyber2000fb.c	Wed Aug 20 11:43:12 2003
@@ -1366,6 +1366,7 @@
 	cfb->fb.fix.smem_len   = smem_size;
 	cfb->fb.fix.mmio_len   = MMIO_SIZE;
 	cfb->fb.screen_base    = cfb->region;
+	cfb->fb.dev            = &cfb->dev->dev;
 
 	err = -EINVAL;
 	if (!fb_find_mode(&cfb->fb.var, &cfb->fb, NULL, NULL, 0,
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	Wed Aug 20 11:43:12 2003
+++ b/drivers/video/fbmem.c	Wed Aug 20 11:43:12 2003
@@ -31,6 +31,7 @@
 #include <linux/kmod.h>
 #endif
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 
 #if defined(__mc68000__) || defined(CONFIG_APUS)
 #include <asm/setup.h>
@@ -1199,6 +1200,83 @@
 #endif
 };
 
+struct fb_dev {
+	struct list_head node;
+	dev_t dev;
+	struct class_device class_dev;
+};
+#define to_fb_dev(d) container_of(d, struct fb_dev, class_dev)
+
+static void release_fb_dev(struct class_device *class_dev)
+{
+	struct fb_dev *fb_dev = to_fb_dev(class_dev);
+	kfree(fb_dev);
+}
+
+static struct class fb_class = {
+	.name		= "video",
+	.release	= &release_fb_dev,
+};
+
+static LIST_HEAD(fb_dev_list);
+static spinlock_t fb_dev_list_lock = SPIN_LOCK_UNLOCKED;
+
+static ssize_t show_dev(struct class_device *class_dev, char *buf)
+{
+	struct fb_dev *fb_dev = to_fb_dev(class_dev);
+	return print_dev_t(buf, fb_dev->dev);
+}
+static CLASS_DEVICE_ATTR(dev, S_IRUGO, show_dev, NULL);
+
+static void fb_add_class_device(int minor, struct device *device)
+{
+	struct fb_dev *fb_dev = NULL;
+	int retval;
+
+	fb_dev = kmalloc(sizeof(*fb_dev), GFP_KERNEL);
+	if (!fb_dev)
+		return;
+	memset(fb_dev, 0x00, sizeof(*fb_dev));
+
+	fb_dev->dev = MKDEV(FB_MAJOR, minor);
+	fb_dev->class_dev.dev = device;
+	fb_dev->class_dev.class = &fb_class;
+	snprintf(fb_dev->class_dev.class_id, BUS_ID_SIZE, "fb%d", minor);
+	retval = class_device_register(&fb_dev->class_dev);
+	if (retval)
+		goto error;
+	class_device_create_file(&fb_dev->class_dev, &class_device_attr_dev);
+	spin_lock(&fb_dev_list_lock);
+	list_add(&fb_dev->node, &fb_dev_list);
+	spin_unlock(&fb_dev_list_lock);
+	return;
+error:
+	kfree(fb_dev);
+}
+
+void fb_remove_class_device(int minor)
+{
+	struct fb_dev *fb_dev = NULL;
+	struct list_head *tmp;
+	int found = 0;
+
+	spin_lock(&fb_dev_list_lock);
+	list_for_each(tmp, &fb_dev_list) {
+		fb_dev = list_entry(tmp, struct fb_dev, node);
+		if ((MINOR(fb_dev->dev) == minor)) {
+			found = 1;
+			break;
+		}
+	}
+	if (found) {
+		list_del(&fb_dev->node);
+		spin_unlock(&fb_dev_list_lock);
+		class_device_unregister(&fb_dev->class_dev);
+	} else {
+		spin_unlock(&fb_dev_list_lock);
+	}
+}
+
 /**
  *	register_framebuffer - registers a frame buffer device
  *	@fb_info: frame buffer info structure
@@ -1242,6 +1320,8 @@
 
 	devfs_mk_cdev(MKDEV(FB_MAJOR, i),
 			S_IFCHR | S_IRUGO | S_IWUGO, "fb/%d", i);
+
+	fb_add_class_device(i, fb_info->dev);
 	return 0;
 }
 
@@ -1270,6 +1350,7 @@
 		kfree(fb_info->pixmap.addr);
 	registered_fb[i]=NULL;
 	num_registered_fb--;
+	fb_remove_class_device(i);
 	return 0;
 }
 
@@ -1293,6 +1374,8 @@
 	devfs_mk_dir("fb");
 	if (register_chrdev(FB_MAJOR,"fb",&fb_fops))
 		printk("unable to get major %d for fb devs\n", FB_MAJOR);
+
+	class_register(&fb_class);
 
 #ifdef CONFIG_FB_OF
 	if (ofonly) {
diff -Nru a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c	Wed Aug 20 11:43:11 2003
+++ b/drivers/video/i810/i810_main.c	Wed Aug 20 11:43:11 2003
@@ -1880,6 +1880,7 @@
 	info->fbops = &par->i810fb_ops;
 	info->pseudo_palette = par->pseudo_palette;
 	info->flags = FBINFO_FLAG_DEFAULT;
+	info->dev = &dev->dev;
 	
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
diff -Nru a/drivers/video/igafb.c b/drivers/video/igafb.c
--- a/drivers/video/igafb.c	Wed Aug 20 11:43:11 2003
+++ b/drivers/video/igafb.c	Wed Aug 20 11:43:11 2003
@@ -332,7 +332,7 @@
 #endif
 };
 
-static int __init iga_init(struct fb_info *info, struct iga_par *par)
+static int __init iga_init(struct fb_info *info, struct iga_par *par, struct pci_dev *dev)
 {
         char vramsz = iga_inb(par, IGA_EXT_CNTRL, IGA_IDX_EXT_BUS_CNTL) 
 		                                         & MEM_SIZE_ALIAS;
@@ -358,6 +358,7 @@
 
 	info->fbops = &igafb_ops;
 	info->flags = FBINFO_FLAG_DEFAULT;
+	info->dev = &dev->dev;
 
 	fb_alloc_cmap(info->cmap, video_cmap_len, 0);
 
@@ -529,7 +530,7 @@
 	info->fix = igafb_fix;
 	info->pseudo_palette = (void *)(par + 1);
 
-	if (!iga_init(info, par)) {
+	if (!iga_init(info, par, pdev)) {
 		iounmap((void *)par->io_base);
 		iounmap(info->screen_base);
 		if (par->mmap_map)
diff -Nru a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
--- a/drivers/video/imsttfb.c	Wed Aug 20 11:43:10 2003
+++ b/drivers/video/imsttfb.c	Wed Aug 20 11:43:10 2003
@@ -1348,7 +1348,7 @@
 };
 
 static void __init 
-init_imstt(struct fb_info *info)
+init_imstt(struct fb_info *info, struct pci_dev *pdev)
 {
 	struct imstt_par *par = (struct imstt_par *) info->par;
 	__u32 i, tmp, *ip, *end;
@@ -1442,6 +1442,7 @@
 
 	info->fbops = &imsttfb_ops;
 	info->flags = FBINFO_FLAG_DEFAULT;
+	info->dev = &pdev->dev;
 
 	fb_alloc_cmap(&info->cmap, 0, 0);
 
@@ -1506,7 +1507,7 @@
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
 	info->par = par;
 	info->pseudo_palette = (void *) (par + 1);
-	init_imstt(info);
+	init_imstt(info, pdev);
 
 	pci_set_drvdata(pdev, info);
 	return 0;
diff -Nru a/drivers/video/matrox/matroxfb_crtc2.c b/drivers/video/matrox/matroxfb_crtc2.c
--- a/drivers/video/matrox/matroxfb_crtc2.c	Wed Aug 20 11:43:11 2003
+++ b/drivers/video/matrox/matroxfb_crtc2.c	Wed Aug 20 11:43:11 2003
@@ -605,6 +605,7 @@
 	m2info->fbcon.flags = FBINFO_FLAG_DEFAULT;
 	m2info->fbcon.currcon = -1;
 	m2info->fbcon.pseudo_palette = m2info->cmap;
+	m2info->fbcon.dev = &m2info->primary_dev->pcidev->dev;
 	fb_alloc_cmap(&m2info->fbcon.cmap, 256, 1);
 
 	if (mem < 64)
diff -Nru a/drivers/video/neofb.c b/drivers/video/neofb.c
--- a/drivers/video/neofb.c	Wed Aug 20 11:43:10 2003
+++ b/drivers/video/neofb.c	Wed Aug 20 11:43:10 2003
@@ -1943,6 +1943,7 @@
 	info->flags = FBINFO_FLAG_DEFAULT;
 	info->par = par;
 	info->pseudo_palette = (void *) (par + 1);
+	info->dev = &dev->dev;
 
 	fb_alloc_cmap(&info->cmap, NR_PALETTE, 0);
 
diff -Nru a/drivers/video/radeonfb.c b/drivers/video/radeonfb.c
--- a/drivers/video/radeonfb.c	Wed Aug 20 11:43:12 2003
+++ b/drivers/video/radeonfb.c	Wed Aug 20 11:43:12 2003
@@ -3033,6 +3033,7 @@
 	pci_set_drvdata(pdev, rinfo);
 	rinfo->next = board_list;
 	board_list = rinfo;
+	rinfo->info.dev = &pdev->dev;
 
 	if (register_framebuffer ((struct fb_info *) rinfo) < 0) {
 		printk ("radeonfb: could not register framebuffer\n");
diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	Wed Aug 20 11:43:12 2003
+++ b/drivers/video/riva/fbdev.c	Wed Aug 20 11:43:12 2003
@@ -1751,6 +1751,7 @@
 	if (info->pixmap.addr == NULL)
 		goto err_out_kfree1;
 	memset(info->pixmap.addr, 0, 64 * 1024);
+	info->dev = &pd->dev;
 
 	strcat(rivafb_fix.id, rci->name);
 	default_par->riva.Architecture = rci->arch_rev;
diff -Nru a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
--- a/drivers/video/sis/sis_main.c	Wed Aug 20 11:43:11 2003
+++ b/drivers/video/sis/sis_main.c	Wed Aug 20 11:43:11 2003
@@ -4507,6 +4507,7 @@
 		sis_fb_info.par = &ivideo;
 		sis_fb_info.screen_base = ivideo.video_vbase;
 		sis_fb_info.fbops = &sisfb_ops;
+		sis_fb_info.dev = &pdev->dev;
 		sisfb_get_fix(&sis_fb_info.fix, -1, &sis_fb_info);
 		sis_fb_info.pseudo_palette = pseudo_palette;
 		
diff -Nru a/drivers/video/sstfb.c b/drivers/video/sstfb.c
--- a/drivers/video/sstfb.c	Wed Aug 20 11:43:12 2003
+++ b/drivers/video/sstfb.c	Wed Aug 20 11:43:12 2003
@@ -1478,6 +1478,7 @@
 	info->fbops	= &sstfb_ops;
 	info->currcon	= -1;
 	info->pseudo_palette = &all->pseudo_palette;
+	info->dev	= &pdev->dev;
 
 	fix->type	= FB_TYPE_PACKED_PIXELS;
 	fix->visual	= FB_VISUAL_TRUECOLOR;
diff -Nru a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
--- a/drivers/video/tdfxfb.c	Wed Aug 20 11:43:13 2003
+++ b/drivers/video/tdfxfb.c	Wed Aug 20 11:43:13 2003
@@ -1248,6 +1248,7 @@
 	info->par		= default_par;
 	info->pseudo_palette	= (void *)(default_par + 1); 
 	info->flags		= FBINFO_FLAG_DEFAULT;
+	info->dev		= &pdev->dev;
 
 #ifndef MODULE
 	if (!mode_option)
diff -Nru a/drivers/video/tgafb.c b/drivers/video/tgafb.c
--- a/drivers/video/tgafb.c	Wed Aug 20 11:43:11 2003
+++ b/drivers/video/tgafb.c	Wed Aug 20 11:43:11 2003
@@ -1430,6 +1430,7 @@
 	all->info.currcon = -1;
 	all->info.par = &all->par;
 	all->info.pseudo_palette = all->pseudo_palette;
+	all->info.dev = &pdev->dev;
 
 	/* This should give a reasonable default video mode.  */
 
diff -Nru a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
--- a/drivers/video/tridentfb.c	Wed Aug 20 11:43:13 2003
+++ b/drivers/video/tridentfb.c	Wed Aug 20 11:43:13 2003
@@ -1129,7 +1129,7 @@
 		return -1;
 	}
 
-	output("%s board found\n", dev->dev.name);
+	output("%s board found\n", pci_name(dev));
 #if 0	
 	output("Trident board found : mem = %X,io = %X, mem_v = %X, io_v = %X\n",
 		tridentfb_fix.smem_start, tridentfb_fix.mmio_start, fb_info.screen_base, default_par.io_virt);
@@ -1155,6 +1155,7 @@
 		default_var.accel_flags &= ~FB_ACCELF_TEXT;
 	default_var.activate |= FB_ACTIVATE_NOW;
 	fb_info.var = default_var;
+	fb_info.dev = &dev->dev;
 	if (register_framebuffer(&fb_info) < 0) {
 		output("Could not register Trident framebuffer\n");
 		return -EINVAL;
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	Wed Aug 20 11:43:12 2003
+++ b/include/linux/fb.h	Wed Aug 20 11:43:12 2003
@@ -352,6 +352,7 @@
 struct fb_info;
 struct vm_area_struct;
 struct file;
+struct device;
 
     /*
      *  Frame buffer operations
@@ -412,6 +413,7 @@
    struct vc_data *display_fg;		/* Console visible on this display */
    int currcon;				/* Current VC. */	
    void *pseudo_palette;                /* Fake palette of 16 colors */ 
+   struct device *dev;                  /* pointer to the device for this fb */
    /* From here on everything is device dependent */
    void *par;	
 };
