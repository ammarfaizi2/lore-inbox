Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275259AbTHSA20 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 20:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275255AbTHSA20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 20:28:26 -0400
Received: from mail.kroah.org ([65.200.24.183]:9409 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S275261AbTHSA16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 20:27:58 -0400
Date: Mon, 18 Aug 2003 17:27:55 -0700
From: Greg KH <greg@kroah.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [RFC] add class/video to fb drivers
Message-ID: <20030819002754.GB1363@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As promised last week, here's a patch against the latest 2.6.0-test3-bk
tree that adds /sys/class/video support to the fb drivers.

With this patch, my /sys/class/video looks like:

$ tree /sys/class/video/
/sys/class/video/
`-- fb0
    |-- dev
    |-- device -> ../../../devices/pci0000:00/0000:00:14.0
    `-- driver -> ../../../bus/pci/drivers/radeonfb

$ cat /sys/class/video/fb0/dev
29:0


If you use a fb driver that is not attached to a pci device, then the
"device" and "driver" symlinks will not be present.

Yeah, it's a hack for now, and it requires that all callers of
register_framebuffer() be modified (I know I missed some, I only got the
ones that I was able to actually build, and then a few more.)

To do this patch "correctly", I would like to add a struct class_device
to the struct fb_info structure, but that would require that all fb
drivers dynamically create this structure, when almost all of them
statically create it right now :(

But if that was done, then lots of good fb info could be exported to
sysfs much easier, with some of the core information done by the fb
core, and other fb driver specific info exported by the individual
drivers as they want to.  I'll work on trying to get that to work at a
later time...

So for now, the patch below is the simplest way to get video support in
sysfs, which is needed for udev and other persistent device naming
schemes.

Comments?

thanks,

greg k-h


diff -Nru a/drivers/video/68328fb.c b/drivers/video/68328fb.c
--- a/drivers/video/68328fb.c	Mon Aug 18 16:51:42 2003
+++ b/drivers/video/68328fb.c	Mon Aug 18 16:51:42 2003
@@ -429,7 +429,7 @@
 		fix->visual = FB_VISUAL_DIRECTCOLOR;
 	info->screen_base = (u_char *) mc68328_fix.smem_start;
 	
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(&fb_info, NULL) < 0)
 		panic("Cannot register frame buffer\n");
 	return 0;
 }
diff -Nru a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
--- a/drivers/video/aty/aty128fb.c	Mon Aug 18 16:51:41 2003
+++ b/drivers/video/aty/aty128fb.c	Mon Aug 18 16:51:41 2003
@@ -1615,7 +1615,7 @@
 
 	aty128_init_engine(par);
 
-	if (register_framebuffer(info) < 0)
+	if (register_framebuffer(info, &pdev->dev) < 0)
 		return 0;
 
 #ifdef CONFIG_PMAC_BACKLIGHT
diff -Nru a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c	Mon Aug 18 16:51:45 2003
+++ b/drivers/video/aty/atyfb_base.c	Mon Aug 18 16:51:45 2003
@@ -1895,7 +1895,7 @@
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
-	if (register_framebuffer(info) < 0)
+	if (register_framebuffer(info, NULL) < 0)
 		return 0;
 
 	fb_list = info;
diff -Nru a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
--- a/drivers/video/cirrusfb.c	Mon Aug 18 16:51:41 2003
+++ b/drivers/video/cirrusfb.c	Mon Aug 18 16:51:41 2003
@@ -2817,7 +2817,7 @@
 	fbgen_set_disp (-1, &fb_info->gen);
 	do_install_cmap (0, &fb_info->gen.info);
 
-	err = register_framebuffer (&fb_info->gen.info);
+	err = register_framebuffer (&fb_info->gen.info, fb_info->pdev);
 	if (err) {
 		printk (KERN_ERR "clgen: ERROR - could not register fb device; err = %d!\n", err);
 		DPRINTK ("EXIT, returning -EINVAL\n");
diff -Nru a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
--- a/drivers/video/cyber2000fb.c	Mon Aug 18 16:51:44 2003
+++ b/drivers/video/cyber2000fb.c	Mon Aug 18 16:51:44 2003
@@ -1399,7 +1399,7 @@
 		cfb->fb.var.xres, cfb->fb.var.yres,
 		h_sync / 1000, h_sync % 1000, v_sync);
 
-	err = register_framebuffer(&cfb->fb);
+	err = register_framebuffer(&cfb->fb, &cfb->dev->dev);
 
 failed:
 	return err;
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	Mon Aug 18 16:51:44 2003
+++ b/drivers/video/fbmem.c	Mon Aug 18 16:51:44 2003
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
@@ -1210,7 +1288,7 @@
  */
 
 int
-register_framebuffer(struct fb_info *fb_info)
+register_framebuffer(struct fb_info *fb_info, struct device *dev)
 {
 	int i;
 
@@ -1242,6 +1320,8 @@
 
 	devfs_mk_cdev(MKDEV(FB_MAJOR, i),
 			S_IFCHR | S_IRUGO | S_IWUGO, "fb/%d", i);
+
+	fb_add_class_device(i, dev);
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
diff -Nru a/drivers/video/hgafb.c b/drivers/video/hgafb.c
--- a/drivers/video/hgafb.c	Mon Aug 18 16:51:42 2003
+++ b/drivers/video/hgafb.c	Mon Aug 18 16:51:42 2003
@@ -560,7 +560,7 @@
 	fb_info.fbops = &hgafb_ops;
 	fb_info.screen_base = (char *)hga_fix.smem_start;
 
-        if (register_framebuffer(&fb_info) < 0)
+        if (register_framebuffer(&fb_info, NULL) < 0)
                 return -EINVAL;
 
         printk(KERN_INFO "fb%d: %s frame buffer device\n",
diff -Nru a/drivers/video/hitfb.c b/drivers/video/hitfb.c
--- a/drivers/video/hitfb.c	Mon Aug 18 16:51:41 2003
+++ b/drivers/video/hitfb.c	Mon Aug 18 16:51:41 2003
@@ -164,7 +164,7 @@
 	size = (fb_info.var.bits_per_pixel == 8) ? 256 : 16;
 	fb_alloc_cmap(&fb_info.cmap, size, 0); 	
 
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(&fb_info, NULL) < 0)
 		return -EINVAL;
     
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",
diff -Nru a/drivers/video/hpfb.c b/drivers/video/hpfb.c
--- a/drivers/video/hpfb.c	Mon Aug 18 16:51:44 2003
+++ b/drivers/video/hpfb.c	Mon Aug 18 16:51:44 2003
@@ -158,7 +158,7 @@
 
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(&fb_info, NULL) < 0)
 		return 1;
 	return 0;
 }
diff -Nru a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c	Mon Aug 18 16:51:42 2003
+++ b/drivers/video/i810/i810_main.c	Mon Aug 18 16:51:42 2003
@@ -1890,7 +1890,7 @@
 	encode_fix(&info->fix, info); 
 	 	    
 	i810fb_init_ringbuffer(info);
-	err = register_framebuffer(info);
+	err = register_framebuffer(info, &dev->dev);
 	if (err < 0) {
     		i810fb_release_resource(info, par); 
 		printk("i810fb_init: cannot register framebuffer device\n");
diff -Nru a/drivers/video/igafb.c b/drivers/video/igafb.c
--- a/drivers/video/igafb.c	Mon Aug 18 16:51:42 2003
+++ b/drivers/video/igafb.c	Mon Aug 18 16:51:42 2003
@@ -332,7 +332,7 @@
 #endif
 };
 
-static int __init iga_init(struct fb_info *info, struct iga_par *par)
+static int __init iga_init(struct fb_info *info, struct iga_par *par, struct pci_dev *dev)
 {
         char vramsz = iga_inb(par, IGA_EXT_CNTRL, IGA_IDX_EXT_BUS_CNTL) 
 		                                         & MEM_SIZE_ALIAS;
@@ -361,7 +361,7 @@
 
 	fb_alloc_cmap(info->cmap, video_cmap_len, 0);
 
-	if (register_framebuffer(info) < 0)
+	if (register_framebuffer(info, &dev->dev) < 0)
 		return 0;
 
 	printk("fb%d: %s frame buffer device at 0x%08lx [%dMB VRAM]\n",
@@ -529,7 +529,7 @@
 	info->fix = igafb_fix;
 	info->pseudo_palette = (void *)(par + 1);
 
-	if (!iga_init(info, par)) {
+	if (!iga_init(info, par, pdev)) {
 		iounmap((void *)par->io_base);
 		iounmap(info->screen_base);
 		if (par->mmap_map)
diff -Nru a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
--- a/drivers/video/imsttfb.c	Mon Aug 18 16:51:41 2003
+++ b/drivers/video/imsttfb.c	Mon Aug 18 16:51:41 2003
@@ -1348,7 +1348,7 @@
 };
 
 static void __init 
-init_imstt(struct fb_info *info)
+init_imstt(struct fb_info *info, struct pci_dev *pdev)
 {
 	struct imstt_par *par = (struct imstt_par *) info->par;
 	__u32 i, tmp, *ip, *end;
@@ -1445,7 +1445,7 @@
 
 	fb_alloc_cmap(&info->cmap, 0, 0);
 
-	if (register_framebuffer(info) < 0) {
+	if (register_framebuffer(info, &pdev->dev) < 0) {
 		kfree(info);
 		return;
 	}
@@ -1506,7 +1506,7 @@
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
 	info->par = par;
 	info->pseudo_palette = (void *) (par + 1);
-	init_imstt(info);
+	init_imstt(info, pdev);
 
 	pci_set_drvdata(pdev, info);
 	return 0;
diff -Nru a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
--- a/drivers/video/matrox/matroxfb_base.c	Mon Aug 18 16:51:43 2003
+++ b/drivers/video/matrox/matroxfb_base.c	Mon Aug 18 16:51:43 2003
@@ -1824,7 +1824,7 @@
 /* We do not have to set currcon to 0... register_framebuffer do it for us on first console
  * and we do not want currcon == 0 for subsequent framebuffers */
 
-	if (register_framebuffer(&ACCESS_FBINFO(fbcon)) < 0) {
+	if (register_framebuffer(&ACCESS_FBINFO(fbcon), NULL) < 0) {
 		goto failVideoIO;
 	}
 	printk("fb%d: %s frame buffer device\n",
diff -Nru a/drivers/video/matrox/matroxfb_crtc2.c b/drivers/video/matrox/matroxfb_crtc2.c
--- a/drivers/video/matrox/matroxfb_crtc2.c	Mon Aug 18 16:51:43 2003
+++ b/drivers/video/matrox/matroxfb_crtc2.c	Mon Aug 18 16:51:43 2003
@@ -638,7 +638,7 @@
 	}
 
 	matroxfb_dh_init_fix(m2info);
-	if (register_framebuffer(&m2info->fbcon)) {
+	if (register_framebuffer(&m2info->fbcon, &m2info->primary_dev->pcidev->dev)) {
 		return -ENXIO;
 	}
 	if (m2info->fbcon.currcon < 0) {
diff -Nru a/drivers/video/neofb.c b/drivers/video/neofb.c
--- a/drivers/video/neofb.c	Mon Aug 18 16:51:41 2003
+++ b/drivers/video/neofb.c	Mon Aug 18 16:51:41 2003
@@ -2016,7 +2016,7 @@
 	       info->var.yres, h_sync / 1000, h_sync % 1000, v_sync);
 
 
-	err = register_framebuffer(info);
+	err = register_framebuffer(info, &dev->dev);
 	if (err < 0)
 		goto failed;
 
diff -Nru a/drivers/video/pmag-ba-fb.c b/drivers/video/pmag-ba-fb.c
--- a/drivers/video/pmag-ba-fb.c	Mon Aug 18 16:51:42 2003
+++ b/drivers/video/pmag-ba-fb.c	Mon Aug 18 16:51:42 2003
@@ -146,7 +146,7 @@
 
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 	
-	if (register_framebuffer(info) < 0)
+	if (register_framebuffer(info, NULL) < 0)
 		return 1;
 	return 0;
 }
diff -Nru a/drivers/video/radeonfb.c b/drivers/video/radeonfb.c
--- a/drivers/video/radeonfb.c	Mon Aug 18 16:51:43 2003
+++ b/drivers/video/radeonfb.c	Mon Aug 18 16:51:43 2003
@@ -3034,7 +3034,7 @@
 	rinfo->next = board_list;
 	board_list = rinfo;
 
-	if (register_framebuffer ((struct fb_info *) rinfo) < 0) {
+	if (register_framebuffer ((struct fb_info *) rinfo, &pdev->dev) < 0) {
 		printk ("radeonfb: could not register framebuffer\n");
 		iounmap ((void*)rinfo->fb_base);
 		iounmap ((void*)rinfo->mmio_base);
diff -Nru a/drivers/video/retz3fb.c b/drivers/video/retz3fb.c
--- a/drivers/video/retz3fb.c	Mon Aug 18 16:51:43 2003
+++ b/drivers/video/retz3fb.c	Mon Aug 18 16:51:43 2003
@@ -1424,7 +1424,7 @@
 
 		do_install_cmap(0, fb_info);
 
-		if (register_framebuffer(fb_info) < 0)
+		if (register_framebuffer(fb_info, NULL) < 0)
 			return -EINVAL;
 
 		printk(KERN_INFO "fb%d: %s frame buffer device, using %ldK of "
diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	Mon Aug 18 16:51:43 2003
+++ b/drivers/video/riva/fbdev.c	Mon Aug 18 16:51:43 2003
@@ -1866,7 +1866,7 @@
 		goto err_out_iounmap_fb;
 	}
 
-	if (register_framebuffer(info) < 0) {
+	if (register_framebuffer(info, &pd->dev) < 0) {
 		printk(KERN_ERR PFX
 			"error registering riva framebuffer\n");
 		goto err_out_iounmap_fb;
diff -Nru a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
--- a/drivers/video/sis/sis_main.c	Mon Aug 18 16:51:43 2003
+++ b/drivers/video/sis/sis_main.c	Mon Aug 18 16:51:43 2003
@@ -4528,7 +4528,7 @@
 
 		TWDEBUG("Before calling register_framebuffer");
 		
-		if(register_framebuffer(&sis_fb_info) < 0)
+		if(register_framebuffer(&sis_fb_info, &pdev->dev) < 0)
 			return -EINVAL;
 			
 		sisfb_registered = 1;			
diff -Nru a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
--- a/drivers/video/skeletonfb.c	Mon Aug 18 16:51:42 2003
+++ b/drivers/video/skeletonfb.c	Mon Aug 18 16:51:42 2003
@@ -563,7 +563,11 @@
      */	
     info.var = xxxfb_var;
 	
-    if (register_framebuffer(&info) < 0)
+    /*
+     * Pass in a pointer to the struct device that this framebuffer is
+     * associated with.  If there is no struct device available, use NULL.
+     */
+    if (register_framebuffer(&info, NULL) < 0)
 	return -EINVAL;
     printk(KERN_INFO "fb%d: %s frame buffer device\n", info.node,
 	   info.fix.id);
diff -Nru a/drivers/video/sstfb.c b/drivers/video/sstfb.c
--- a/drivers/video/sstfb.c	Mon Aug 18 16:51:44 2003
+++ b/drivers/video/sstfb.c	Mon Aug 18 16:51:44 2003
@@ -1508,7 +1508,7 @@
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
 	/* register fb */
-	if (register_framebuffer(info) < 0) {
+	if (register_framebuffer(info, &pdev->dev) < 0) {
 		eprintk("can't register framebuffer.\n");
 		goto fail;
 	}
diff -Nru a/drivers/video/stifb.c b/drivers/video/stifb.c
--- a/drivers/video/stifb.c	Mon Aug 18 16:51:44 2003
+++ b/drivers/video/stifb.c	Mon Aug 18 16:51:44 2003
@@ -1300,7 +1300,7 @@
 		goto out_err2;
 	}
 
-	if (register_framebuffer(&fb->info) < 0)
+	if (register_framebuffer(&fb->info, NULL) < 0)
 		goto out_err3;
 
 	sti->info = info; /* save for unregister_framebuffer() */
diff -Nru a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
--- a/drivers/video/tdfxfb.c	Mon Aug 18 16:51:45 2003
+++ b/drivers/video/tdfxfb.c	Mon Aug 18 16:51:45 2003
@@ -1261,7 +1261,7 @@
 	size = (info->var.bits_per_pixel == 8) ? 256 : 16;
 	fb_alloc_cmap(&info->cmap, size, 0);  
 
-	if (register_framebuffer(info) < 0) {
+	if (register_framebuffer(info, &pdev->dev) < 0) {
 		printk("tdfxfb: can't register framebuffer\n");
 		goto out_err;
 	}
@@ -1356,4 +1356,5 @@
 	} 
 }
 #endif
+
 
diff -Nru a/drivers/video/tgafb.c b/drivers/video/tgafb.c
--- a/drivers/video/tgafb.c	Mon Aug 18 16:51:43 2003
+++ b/drivers/video/tgafb.c	Mon Aug 18 16:51:43 2003
@@ -1451,7 +1451,7 @@
 	tgafb_set_par(&all->info);
 	tgafb_init_fix(&all->info);
 
-	if (register_framebuffer(&all->info) < 0) {
+	if (register_framebuffer(&all->info, &pdev->dev) < 0) {
 		printk(KERN_ERR "tgafb: Could not register framebuffer\n");
 		ret = -EINVAL;
 		goto err1;
diff -Nru a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
--- a/drivers/video/tridentfb.c	Mon Aug 18 16:51:45 2003
+++ b/drivers/video/tridentfb.c	Mon Aug 18 16:51:45 2003
@@ -1129,7 +1129,7 @@
 		return -1;
 	}
 
-	output("%s board found\n", dev->dev.name);
+	output("%s board found\n", pci_name(dev));
 #if 0	
 	output("Trident board found : mem = %X,io = %X, mem_v = %X, io_v = %X\n",
 		tridentfb_fix.smem_start, tridentfb_fix.mmio_start, fb_info.screen_base, default_par.io_virt);
@@ -1155,7 +1155,7 @@
 		default_var.accel_flags &= ~FB_ACCELF_TEXT;
 	default_var.activate |= FB_ACTIVATE_NOW;
 	fb_info.var = default_var;
-	if (register_framebuffer(&fb_info) < 0) {
+	if (register_framebuffer(&fb_info, &dev->dev) < 0) {
 		output("Could not register Trident framebuffer\n");
 		return -EINVAL;
 	}
diff -Nru a/drivers/video/tx3912fb.c b/drivers/video/tx3912fb.c
--- a/drivers/video/tx3912fb.c	Mon Aug 18 16:51:44 2003
+++ b/drivers/video/tx3912fb.c	Mon Aug 18 16:51:44 2003
@@ -304,7 +304,7 @@
 
 	fb_alloc_cmap(&info->cmap, size, 0);
 
-	if (register_framebuffer(&fb_info) < 0)
+	if (register_framebuffer(&fb_info, NULL) < 0)
 		return -1;
 
 	printk(KERN_INFO "fb%d: TX3912 frame buffer using %uKB.\n",
diff -Nru a/drivers/video/vesafb.c b/drivers/video/vesafb.c
--- a/drivers/video/vesafb.c	Mon Aug 18 16:51:41 2003
+++ b/drivers/video/vesafb.c	Mon Aug 18 16:51:41 2003
@@ -366,7 +366,7 @@
 
 	fb_alloc_cmap(&fb_info.cmap, video_cmap_len, 0);
 
-	if (register_framebuffer(&fb_info)<0)
+	if (register_framebuffer(&fb_info, NULL)<0)
 		return -EINVAL;
 
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",
diff -Nru a/drivers/video/vfb.c b/drivers/video/vfb.c
--- a/drivers/video/vfb.c	Mon Aug 18 16:51:44 2003
+++ b/drivers/video/vfb.c	Mon Aug 18 16:51:44 2003
@@ -439,7 +439,7 @@
 
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 
-	if (register_framebuffer(&fb_info) < 0) {
+	if (register_framebuffer(&fb_info, NULL) < 0) {
 		vfree(videomemory);
 		return -EINVAL;
 	}
diff -Nru a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
--- a/drivers/video/vga16fb.c	Mon Aug 18 16:51:44 2003
+++ b/drivers/video/vga16fb.c	Mon Aug 18 16:51:44 2003
@@ -1378,7 +1378,7 @@
 
 	vga16fb_update_fix(&vga16fb);
 
-	if (register_framebuffer(&vga16fb) < 0) {
+	if (register_framebuffer(&vga16fb, NULL) < 0) {
 		iounmap(vga16fb.screen_base);
 		return -EINVAL;
 	}
diff -Nru a/drivers/video/virgefb.c b/drivers/video/virgefb.c
--- a/drivers/video/virgefb.c	Mon Aug 18 16:51:45 2003
+++ b/drivers/video/virgefb.c	Mon Aug 18 16:51:45 2003
@@ -1797,7 +1797,7 @@
 	virgefb_set_disp(-1, &fb_info);
 	do_install_cmap(0, &fb_info);
 
-	if (register_framebuffer(&fb_info) < 0) {
+	if (register_framebuffer(&fb_info, NULL) < 0) {
 		#warning release resources
 		printk(KERN_ERR "virgefb.c: register_framebuffer failed\n");
 		DPRINTK("EXIT\n");
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	Mon Aug 18 16:51:43 2003
+++ b/include/linux/fb.h	Mon Aug 18 16:51:43 2003
@@ -352,6 +352,7 @@
 struct fb_info;
 struct vm_area_struct;
 struct file;
+struct device;
 
     /*
      *  Frame buffer operations
@@ -477,7 +478,7 @@
 extern void cfb_imageblit(struct fb_info *info, const struct fb_image *image);
 
 /* drivers/video/fbmem.c */
-extern int register_framebuffer(struct fb_info *fb_info);
+extern int register_framebuffer(struct fb_info *fb_info, struct device *dev);
 extern int unregister_framebuffer(struct fb_info *fb_info);
 extern int fb_prepare_logo(struct fb_info *fb_info);
 extern int fb_show_logo(struct fb_info *fb_info);
