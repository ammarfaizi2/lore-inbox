Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbTLWXHU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 18:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262844AbTLWXFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 18:05:09 -0500
Received: from mail.kroah.org ([65.200.24.183]:19592 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262782AbTLWXEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 18:04:07 -0500
Date: Tue, 23 Dec 2003 15:01:03 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: [PATCH] add video sysfs class [6/5]
Message-ID: <20031223230103.GC16315@kroah.com>
References: <20031223212459.GA15700@kroah.com> <3FE8BA64.7070607@pobox.com> <20031223220707.GC15946@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223220707.GC15946@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 02:07:07PM -0800, Greg KH wrote:
> On Tue, Dec 23, 2003 at 04:57:56PM -0500, Jeff Garzik wrote:
> > Interesting...  I bet that will be useful to the iPAQ folks (I've been 
> > wading through their patches lately), as they have created a couple 
> > ultra-simple classes for SoC devices and such.
> 
> I bet it will.  I've ported my old frame buffer patch to use it, and
> it saved a lot of code.

And here is that patch, against a clean 2.6.0 tree.

Andrew, feel free to add this to your -mm tree if you like.  If the "big
framebuffer" resync isn't ever going to happen, getting this patch into
the tree would be a good thing.

thanks,

greg k-h

diff -Nru a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
--- a/drivers/video/aty/aty128fb.c	Tue Dec 23 12:53:13 2003
+++ b/drivers/video/aty/aty128fb.c	Tue Dec 23 12:53:13 2003
@@ -1536,6 +1536,7 @@
 	/* fill in info */
 	info->fbops = &aty128fb_ops;
 	info->flags = FBINFO_FLAG_DEFAULT;
+	info->dev = &pdev->dev;
 
 #ifdef CONFIG_PMAC_PBOOK
 	par->lcd_on = default_lcd_on;
diff -Nru a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
--- a/drivers/video/cirrusfb.c	Tue Dec 23 12:53:13 2003
+++ b/drivers/video/cirrusfb.c	Tue Dec 23 12:53:13 2003
@@ -2787,6 +2787,7 @@
 	fb_info->gen.info.switch_con = &fbgen_switch;
 	fb_info->gen.info.updatevar = &fbgen_update_var;
 	fb_info->gen.info.flags = FBINFO_FLAG_DEFAULT;
+	fb_info->gen.info.dev = fb_info->pdev;
 
 	for (j = 0; j < 256; j++) {
 		if (j < 16) {
diff -Nru a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
--- a/drivers/video/cyber2000fb.c	Tue Dec 23 12:53:40 2003
+++ b/drivers/video/cyber2000fb.c	Tue Dec 23 12:53:40 2003
@@ -1366,6 +1366,7 @@
 	cfb->fb.fix.smem_len   = smem_size;
 	cfb->fb.fix.mmio_len   = MMIO_SIZE;
 	cfb->fb.screen_base    = cfb->region;
+	cfb->fb.dev            = &cfb->dev->dev;
 
 	err = -EINVAL;
 	if (!fb_find_mode(&cfb->fb.var, &cfb->fb, NULL, NULL, 0,
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	Tue Dec 23 12:53:40 2003
+++ b/drivers/video/fbmem.c	Tue Dec 23 12:53:40 2003
@@ -31,6 +31,7 @@
 #include <linux/kmod.h>
 #endif
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 
 #if defined(__mc68000__) || defined(CONFIG_APUS)
 #include <asm/setup.h>
@@ -1199,6 +1200,10 @@
 #endif
 };
 
+static struct class fb_class = {
+	.name	= "video",
+};
+
 /**
  *	register_framebuffer - registers a frame buffer device
  *	@fb_info: frame buffer info structure
@@ -1242,6 +1247,8 @@
 
 	devfs_mk_cdev(MKDEV(FB_MAJOR, i),
 			S_IFCHR | S_IRUGO | S_IWUGO, "fb/%d", i);
+
+	simple_add_class_device(&fb_class, MKDEV(FB_MAJOR, i), fb_info->dev, "fb%d", i);
 	return 0;
 }
 
@@ -1270,6 +1277,7 @@
 		kfree(fb_info->pixmap.addr);
 	registered_fb[i]=NULL;
 	num_registered_fb--;
+	simple_remove_class_device(MKDEV(FB_MAJOR, i));
 	return 0;
 }
 
@@ -1293,6 +1301,8 @@
 	devfs_mk_dir("fb");
 	if (register_chrdev(FB_MAJOR,"fb",&fb_fops))
 		printk("unable to get major %d for fb devs\n", FB_MAJOR);
+
+	class_register(&fb_class);
 
 #ifdef CONFIG_FB_OF
 	if (ofonly) {
diff -Nru a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c	Tue Dec 23 12:53:19 2003
+++ b/drivers/video/i810/i810_main.c	Tue Dec 23 12:53:19 2003
@@ -1880,6 +1880,7 @@
 	info->fbops = &par->i810fb_ops;
 	info->pseudo_palette = par->pseudo_palette;
 	info->flags = FBINFO_FLAG_DEFAULT;
+	info->dev = &dev->dev;
 	
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
diff -Nru a/drivers/video/igafb.c b/drivers/video/igafb.c
--- a/drivers/video/igafb.c	Tue Dec 23 12:53:19 2003
+++ b/drivers/video/igafb.c	Tue Dec 23 12:53:19 2003
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
 
 	fb_alloc_cmap(&info->cmap, video_cmap_len, 0);
 
@@ -529,7 +530,7 @@
 	info->fix = igafb_fix;
 	info->pseudo_palette = (void *)(par + 1);
 
-	if (!iga_init(info, par)) {
+	if (!iga_init(info, par, pdev)) {
 		iounmap((void *)par->io_base);
 		iounmap(info->screen_base);
 		if (par->mmap_map)
diff -Nru a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
--- a/drivers/video/imsttfb.c	Tue Dec 23 12:53:11 2003
+++ b/drivers/video/imsttfb.c	Tue Dec 23 12:53:11 2003
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
 
@@ -1520,7 +1521,7 @@
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
 	info->par = par;
 	info->pseudo_palette = (void *) (par + 1);
-	init_imstt(info);
+	init_imstt(info, pdev);
 
 	pci_set_drvdata(pdev, info);
 	return 0;
diff -Nru a/drivers/video/matrox/matroxfb_crtc2.c b/drivers/video/matrox/matroxfb_crtc2.c
--- a/drivers/video/matrox/matroxfb_crtc2.c	Tue Dec 23 12:53:30 2003
+++ b/drivers/video/matrox/matroxfb_crtc2.c	Tue Dec 23 12:53:30 2003
@@ -605,6 +605,7 @@
 	m2info->fbcon.flags = FBINFO_FLAG_DEFAULT;
 	m2info->fbcon.currcon = -1;
 	m2info->fbcon.pseudo_palette = m2info->cmap;
+	m2info->fbcon.dev = &m2info->primary_dev->pcidev->dev;
 	fb_alloc_cmap(&m2info->fbcon.cmap, 256, 1);
 
 	if (mem < 64)
diff -Nru a/drivers/video/neofb.c b/drivers/video/neofb.c
--- a/drivers/video/neofb.c	Tue Dec 23 12:53:12 2003
+++ b/drivers/video/neofb.c	Tue Dec 23 12:53:12 2003
@@ -1943,6 +1943,7 @@
 	info->flags = FBINFO_FLAG_DEFAULT;
 	info->par = par;
 	info->pseudo_palette = (void *) (par + 1);
+	info->dev = &dev->dev;
 
 	fb_alloc_cmap(&info->cmap, NR_PALETTE, 0);
 
diff -Nru a/drivers/video/radeonfb.c b/drivers/video/radeonfb.c
--- a/drivers/video/radeonfb.c	Tue Dec 23 12:53:34 2003
+++ b/drivers/video/radeonfb.c	Tue Dec 23 12:53:34 2003
@@ -3033,6 +3033,7 @@
 	pci_set_drvdata(pdev, rinfo);
 	rinfo->next = board_list;
 	board_list = rinfo;
+	rinfo->info.dev = &pdev->dev;
 
 	if (register_framebuffer ((struct fb_info *) rinfo) < 0) {
 		printk ("radeonfb: could not register framebuffer\n");
diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	Tue Dec 23 12:53:31 2003
+++ b/drivers/video/riva/fbdev.c	Tue Dec 23 12:53:31 2003
@@ -1751,6 +1751,7 @@
 	if (info->pixmap.addr == NULL)
 		goto err_out_kfree1;
 	memset(info->pixmap.addr, 0, 64 * 1024);
+	info->dev = &pd->dev;
 
 	strcat(rivafb_fix.id, rci->name);
 	default_par->riva.Architecture = rci->arch_rev;
diff -Nru a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
--- a/drivers/video/sis/sis_main.c	Tue Dec 23 12:53:29 2003
+++ b/drivers/video/sis/sis_main.c	Tue Dec 23 12:53:29 2003
@@ -4507,6 +4507,7 @@
 		sis_fb_info.par = &ivideo;
 		sis_fb_info.screen_base = ivideo.video_vbase;
 		sis_fb_info.fbops = &sisfb_ops;
+		sis_fb_info.dev = &pdev->dev;
 		sisfb_get_fix(&sis_fb_info.fix, -1, &sis_fb_info);
 		sis_fb_info.pseudo_palette = pseudo_palette;
 		
diff -Nru a/drivers/video/sstfb.c b/drivers/video/sstfb.c
--- a/drivers/video/sstfb.c	Tue Dec 23 12:53:40 2003
+++ b/drivers/video/sstfb.c	Tue Dec 23 12:53:40 2003
@@ -1477,6 +1477,7 @@
 	info->fbops	= &sstfb_ops;
 	info->currcon	= -1;
 	info->pseudo_palette = &all->pseudo_palette;
+	info->dev	= &pdev->dev;
 
 	fix->type	= FB_TYPE_PACKED_PIXELS;
 	fix->visual	= FB_VISUAL_TRUECOLOR;
diff -Nru a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
--- a/drivers/video/tdfxfb.c	Tue Dec 23 12:53:46 2003
+++ b/drivers/video/tdfxfb.c	Tue Dec 23 12:53:46 2003
@@ -1248,6 +1248,7 @@
 	info->par		= default_par;
 	info->pseudo_palette	= (void *)(default_par + 1); 
 	info->flags		= FBINFO_FLAG_DEFAULT;
+	info->dev		= &pdev->dev;
 
 #ifndef MODULE
 	if (!mode_option)
diff -Nru a/drivers/video/tgafb.c b/drivers/video/tgafb.c
--- a/drivers/video/tgafb.c	Tue Dec 23 12:53:25 2003
+++ b/drivers/video/tgafb.c	Tue Dec 23 12:53:25 2003
@@ -1430,6 +1430,7 @@
 	all->info.currcon = -1;
 	all->info.par = &all->par;
 	all->info.pseudo_palette = all->pseudo_palette;
+	all->info.dev = &pdev->dev;
 
 	/* This should give a reasonable default video mode.  */
 
diff -Nru a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
--- a/drivers/video/tridentfb.c	Tue Dec 23 12:53:46 2003
+++ b/drivers/video/tridentfb.c	Tue Dec 23 12:53:46 2003
@@ -1156,6 +1156,7 @@
 		default_var.accel_flags &= ~FB_ACCELF_TEXT;
 	default_var.activate |= FB_ACTIVATE_NOW;
 	fb_info.var = default_var;
+	fb_info.dev = &dev->dev;
 	if (register_framebuffer(&fb_info) < 0) {
 		output("Could not register Trident framebuffer\n");
 		return -EINVAL;
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	Tue Dec 23 12:53:34 2003
+++ b/include/linux/fb.h	Tue Dec 23 12:53:34 2003
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
