Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVCSW6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVCSW6u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 17:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVCSW6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 17:58:49 -0500
Received: from mail.dif.dk ([193.138.115.101]:4325 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261908AbVCSW6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 17:58:21 -0500
Date: Sat, 19 Mar 2005 23:59:50 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Antonino Daplas <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net,
       Alex Kern <alex.kern@gmx.de>, Ani Joshi <ajoshi@shell.unixbox.com>,
       "Ben. Herrenschmidt" <benh@kernel.crashing.org>,
       Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
       Helge Deller <deller@gmx.de>, Philipp Rumpf <prumpf@tux.org>,
       James Simmons <jsimmons@users.sf.net>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       "Eddie C. Dost" <ecd@skynet.be>, Nicolas Pitre <nico@cam.org>,
       linux-arm-kernel@lists.arm.linux.org.uk, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] remove redundant NULL checks before kfree() in drivers/video/
Message-ID: <Pine.LNX.4.62.0503192339190.5507@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Checking a pointer for NULL before calling kfree() on it is redundant, 
kfree() deals with NULL pointers just fine.
This patch removes such checks from files in drivers/video/

Since this is a fairly trivial change (and the same change made 
everywhere) I've just made a single patch for all the files and CC all 
authors/maintainers of those files I could find for comments. If spliting 
this into one patch pr file is prefered, then I can easily do that as 
well.

These are the files being modified : 
	drivers/video/aty/atyfb_base.c
	drivers/video/aty/radeon_base.c
	drivers/video/aty/radeon_monitor.c
	drivers/video/console/bitblit.c
	drivers/video/console/sticore.c
	drivers/video/fbmem.c
	drivers/video/fbmon.c
	drivers/video/igafb.c
	drivers/video/pxafb.c
	drivers/video/riva/fbdev.c
	drivers/video/sa1100fb.c


(please CC me on replies to lists other than linux-kernel)


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.11-mm4-orig/drivers/video/aty/atyfb_base.c	2005-03-16 15:45:26.000000000 +0100
+++ linux-2.6.11-mm4/drivers/video/aty/atyfb_base.c	2005-03-19 22:23:47.000000000 +0100
@@ -3435,8 +3435,7 @@ static int __devinit atyfb_pci_probe(str
 
 err_release_io:
 #ifdef __sparc__
-	if (par->mmap_map)
-		kfree(par->mmap_map);
+	kfree(par->mmap_map);
 #else
 	if (par->ati_regbase)
 		iounmap(par->ati_regbase);
@@ -3444,7 +3443,7 @@ err_release_io:
 		iounmap(info->screen_base);
 #endif
 err_release_mem:
-	if(par->aux_start)
+	if (par->aux_start)
 		release_mem_region(par->aux_start, par->aux_size);
 
 	release_mem_region(par->res_start, par->res_size);
@@ -3551,8 +3550,7 @@ static void __devexit atyfb_remove(struc
 #endif
 #endif
 #ifdef __sparc__
-	if (par->mmap_map)
-		kfree(par->mmap_map);
+	kfree(par->mmap_map);
 #endif
 	if (par->aux_start)
 		release_mem_region(par->aux_start, par->aux_size);
--- linux-2.6.11-mm4-orig/drivers/video/aty/radeon_base.c	2005-03-16 15:45:26.000000000 +0100
+++ linux-2.6.11-mm4/drivers/video/aty/radeon_base.c	2005-03-19 22:24:39.000000000 +0100
@@ -2420,10 +2420,8 @@ static int radeonfb_pci_register (struct
 err_unmap_fb:
 	iounmap(rinfo->fb_base);
 err_unmap_rom:
-	if (rinfo->mon1_EDID)
-	    kfree(rinfo->mon1_EDID);
-	if (rinfo->mon2_EDID)
-	    kfree(rinfo->mon2_EDID);
+	kfree(rinfo->mon1_EDID);
+	kfree(rinfo->mon2_EDID);
 	if (rinfo->mon1_modedb)
 		fb_destroy_modedb(rinfo->mon1_modedb);
 	fb_dealloc_cmap(&info->cmap);
@@ -2479,10 +2477,8 @@ static void __devexit radeonfb_pci_unreg
  
  	pci_release_regions(pdev);
 
-	if (rinfo->mon1_EDID)
-		kfree(rinfo->mon1_EDID);
-	if (rinfo->mon2_EDID)
-		kfree(rinfo->mon2_EDID);
+	kfree(rinfo->mon1_EDID);
+	kfree(rinfo->mon2_EDID);
 	if (rinfo->mon1_modedb)
 		fb_destroy_modedb(rinfo->mon1_modedb);
 #ifdef CONFIG_FB_RADEON_I2C
--- linux-2.6.11-mm4-orig/drivers/video/aty/radeon_monitor.c	2005-03-16 15:45:26.000000000 +0100
+++ linux-2.6.11-mm4/drivers/video/aty/radeon_monitor.c	2005-03-19 22:25:11.000000000 +0100
@@ -618,11 +618,9 @@ void __devinit radeon_probe_screens(stru
 		}
 	}
 	if (ignore_edid) {
-		if (rinfo->mon1_EDID)
-			kfree(rinfo->mon1_EDID);
+		kfree(rinfo->mon1_EDID);
 		rinfo->mon1_EDID = NULL;
-		if (rinfo->mon2_EDID)
-			kfree(rinfo->mon2_EDID);
+		kfree(rinfo->mon2_EDID);
 		rinfo->mon2_EDID = NULL;
 	}
 
--- linux-2.6.11-mm4-orig/drivers/video/console/bitblit.c	2005-03-16 15:45:26.000000000 +0100
+++ linux-2.6.11-mm4/drivers/video/console/bitblit.c	2005-03-19 22:27:39.000000000 +0100
@@ -199,8 +199,7 @@ static void bit_putcs(struct vc_data *vc
 		count -= cnt;
 	}
 
-	if (buf)
-		kfree(buf);
+	kfree(buf);
 }
 
 static void bit_clear_margins(struct vc_data *vc, struct fb_info *info,
@@ -273,8 +272,7 @@ static void bit_cursor(struct vc_data *v
 		dst = kmalloc(w * vc->vc_font.height, GFP_ATOMIC);
 		if (!dst)
 			return;
-		if (ops->cursor_data)
-			kfree(ops->cursor_data);
+		kfree(ops->cursor_data);
 		ops->cursor_data = dst;
 		update_attr(dst, src, attribute, vc);
 		src = dst;
@@ -321,8 +319,7 @@ static void bit_cursor(struct vc_data *v
 		if (!mask)
 			return;
 
-		if (ops->cursor_state.mask)
-			kfree(ops->cursor_state.mask);
+		kfree(ops->cursor_state.mask);
 		ops->cursor_state.mask = mask;
 
 		p->cursor_shape = vc->vc_cursor_type;
--- linux-2.6.11-mm4-orig/drivers/video/console/sticore.c	2005-03-16 15:45:26.000000000 +0100
+++ linux-2.6.11-mm4/drivers/video/console/sticore.c	2005-03-19 22:35:05.000000000 +0100
@@ -798,11 +798,8 @@ sti_read_rom(int wordmode, struct sti_st
 	return 1;
 
 out_err:
-	if(raw)
-		kfree(raw);
-	if(cooked)
-		kfree(cooked);
-
+	kfree(raw);
+	kfree(cooked);
 	return 0;
 }
 
--- linux-2.6.11-mm4-orig/drivers/video/fbmem.c	2005-03-16 15:45:26.000000000 +0100
+++ linux-2.6.11-mm4/drivers/video/fbmem.c	2005-03-19 22:36:26.000000000 +0100
@@ -446,8 +446,7 @@ int fb_show_logo(struct fb_info *info)
 		logo_new = kmalloc(fb_logo.logo->width * fb_logo.logo->height, 
 				   GFP_KERNEL);
 		if (logo_new == NULL) {
-			if (palette)
-				kfree(palette);
+			kfree(palette);
 			if (saved_pseudo_palette)
 				info->pseudo_palette = saved_pseudo_palette;
 			return 0;
@@ -466,12 +465,10 @@ int fb_show_logo(struct fb_info *info)
 		info->fbops->fb_imageblit(info, &image);
 	}
 	
-	if (palette != NULL)
-		kfree(palette);
+	kfree(palette);
 	if (saved_pseudo_palette != NULL)
 		info->pseudo_palette = saved_pseudo_palette;
-	if (logo_new != NULL)
-		kfree(logo_new);
+	kfree(logo_new);
 	return fb_logo.logo->height;
 }
 #else
--- linux-2.6.11-mm4-orig/drivers/video/fbmon.c	2005-03-16 15:45:26.000000000 +0100
+++ linux-2.6.11-mm4/drivers/video/fbmon.c	2005-03-19 22:36:46.000000000 +0100
@@ -588,8 +588,7 @@ static struct fb_videomode *fb_create_mo
  */
 void fb_destroy_modedb(struct fb_videomode *modedb)
 {
-	if (modedb)
-		kfree(modedb);
+	kfree(modedb);
 }
 
 static int fb_get_monitor_limits(unsigned char *edid, struct fb_monspecs *specs)
--- linux-2.6.11-mm4-orig/drivers/video/igafb.c	2005-03-02 08:38:10.000000000 +0100
+++ linux-2.6.11-mm4/drivers/video/igafb.c	2005-03-19 22:37:27.000000000 +0100
@@ -536,8 +536,7 @@ int __init igafb_init(void)
 	if (!iga_init(info, par)) {
 		iounmap((void *)par->io_base);
 		iounmap(info->screen_base);
-		if (par->mmap_map)
-			kfree(par->mmap_map);
+		kfree(par->mmap_map);
 		kfree(info);
         }
 
--- linux-2.6.11-mm4-orig/drivers/video/pxafb.c	2005-03-02 08:38:37.000000000 +0100
+++ linux-2.6.11-mm4/drivers/video/pxafb.c	2005-03-19 22:41:51.000000000 +0100
@@ -1343,8 +1343,7 @@ int __init pxafb_probe(struct device *de
 
 failed:
 	dev_set_drvdata(dev, NULL);
-	if (fbi)
-		kfree(fbi);
+	kfree(fbi);
 	return ret;
 }
 
--- linux-2.6.11-mm4-orig/drivers/video/riva/fbdev.c	2005-03-16 15:45:26.000000000 +0100
+++ linux-2.6.11-mm4/drivers/video/riva/fbdev.c	2005-03-19 22:43:06.000000000 +0100
@@ -2108,8 +2108,7 @@ static void __exit rivafb_remove(struct 
 
 #ifdef CONFIG_FB_RIVA_I2C
 	riva_delete_i2c_busses(par);
-	if (par->EDID)
-		kfree(par->EDID);
+	kfree(par->EDID);
 #endif
 
 	unregister_framebuffer(info);
--- linux-2.6.11-mm4-orig/drivers/video/sa1100fb.c	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.11-mm4/drivers/video/sa1100fb.c	2005-03-19 22:45:22.000000000 +0100
@@ -1507,8 +1507,7 @@ static int __init sa1100fb_probe(struct 
 
 failed:
 	dev_set_drvdata(dev, NULL);
-	if (fbi)
-		kfree(fbi);
+	kfree(fbi);
 	release_mem_region(0xb0100000, 0x10000);
 	return ret;
 }



