Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261814AbUK2Vgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261814AbUK2Vgi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 16:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUK2Vgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 16:36:37 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:203 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261811AbUK2VfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 16:35:23 -0500
Date: Mon, 29 Nov 2004 22:35:10 +0100
From: Kronos <kronos@people.it>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] why does radeonfb work fine in 2.6, but not in 2.4.29-pre1?
Message-ID: <20041129213510.GA9551@dreamland.darkstar.lan>
References: <20041128184606.GA2537@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041128184606.GA2537@middle.of.nowhere>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Sun, Nov 28, 2004 at 07:46:06PM +0100, Jurriaan ha scritto: 
> The same radeonfb-setup works fine in every 2.6 kernel I can remember
> (last tested with 2.6.10-rc2-mm3) but give the dreaded 'cannot map FB'
> in 2.4.29-pre1.
> 
> The card has 128 Mb of ram, and my system has 3 Mb of RAM.
> 
> Is there any reason the ioremap() call works on 2.6, but doesn't on 2.4?

Driver in 2.6 only ioremap()s the memory needed for the framebuffer,
while the one in 2.4 ioremap()s all the VRAM (and fails).

> Is there any way to test 2.4 with my radeonfb and all of my memory?

I proposed the following patch some time ago (for 2.4.28-pre2 IIRC) as a
quick fix:

--- a/drivers/video/radeonfb.c	2004-06-27 22:26:56.000000000 +0200
+++ b/drivers/video/radeonfb.c	2004-06-29 19:13:24.000000000 +0200
@@ -176,7 +176,8 @@
 #define RTRACE		if(0) printk
 #endif
 
-
+#define MAX_MAPPED_VRAM (2048*2048*4)
+#define MIN_MAPPED_VRAM (1024*768*1)
 
 enum radeon_chips {
 	RADEON_QD,
@@ -499,7 +500,8 @@
 
 	short chipset;
 	unsigned char arch;
-	int video_ram;
+	unsigned int video_ram;
+	unsigned int mapped_vram;
 	u8 rev;
 	int pitch, bpp, depth;
 	int xres, yres, pixclock;
@@ -1823,8 +1825,19 @@
 		}
 	}
 
-	rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys,
-				  		  rinfo->video_ram);
+	if (rinfo->video_ram < rinfo->mapped_vram)
+		rinfo->mapped_vram = rinfo->video_ram;
+	else
+		rinfo->mapped_vram = MAX_MAPPED_VRAM;
+	do {
+		rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys,
+				  		  rinfo->mapped_vram);
+		if (rinfo->fb_base)
+			break;
+
+		rinfo->mapped_vram /= 2;
+	} while(rinfo->mapped_vram > MIN_MAPPED_VRAM);
+	
 	if (!rinfo->fb_base) {
 		printk ("radeonfb: cannot map FB\n");
 		iounmap ((void*)rinfo->mmio_base);
@@ -1835,6 +1848,7 @@
 		kfree (rinfo);
 		return -ENODEV;
 	}
+	RTRACE(KERN_INFO "radeonfb: mapped %dk videoram\n", rinfo->mapped_vram/1024);
 
 	/* currcon not yet configured, will be set by first switch */
 	rinfo->currcon = -1;
@@ -2204,7 +2218,7 @@
                 printk("radeonfb: using max available virtual resolution\n");
                 for (i=0; modes[i].xres != -1; i++) {
                         if (modes[i].xres * nom / den * modes[i].yres <
-                            rinfo->video_ram / 2)
+                            rinfo->mapped_vram / 2)
                                 break;
                 }
                 if (modes[i].xres == -1) {
@@ -2217,15 +2231,15 @@
                 printk("radeonfb: virtual resolution set to max of %dx%d\n",
                         v->xres_virtual, v->yres_virtual);
         } else if (v->xres_virtual == -1) {
-                v->xres_virtual = (rinfo->video_ram * den /   
+                v->xres_virtual = (rinfo->mapped_vram * den /   
                                 (nom * v->yres_virtual * 2)) & ~15;
         } else if (v->yres_virtual == -1) {
                 v->xres_virtual = (v->xres_virtual + 15) & ~15;
-                v->yres_virtual = rinfo->video_ram * den /
+                v->yres_virtual = rinfo->mapped_vram * den /
                         (nom * v->xres_virtual *2);
         } else {
                 if (v->xres_virtual * nom / den * v->yres_virtual >
-                        rinfo->video_ram) {
+                        rinfo->mapped_vram) {
                         return -EINVAL;
                 }
         }
@@ -2261,7 +2275,7 @@
 	sprintf (fix->id, "ATI Radeon %s", rinfo->name);
         
         fix->smem_start = rinfo->fb_base_phys;
-        fix->smem_len = rinfo->video_ram;
+        fix->smem_len = rinfo->mapped_vram;
 
         fix->type = disp->type;
         fix->type_aux = disp->type_aux;
@@ -2429,6 +2443,9 @@
                         return -EINVAL;
         }
 
+	if (((v.xres_virtual * v.yres_virtual * nom) / den) > rinfo->mapped_vram)
+		return -EINVAL;
+
         if (radeonfb_do_maximize(rinfo, var, &v, nom, den) < 0)
                 return -EINVAL;  
                 

Problem is that fix->smem_len is used both by FBIOGET_FSCREENINFO to
report the amount of VRAM to userspace and by read/write/mmap on fb
for bounds checking. So with my patch FBIOGET_FSCREENINFO reports mapped
VRAM instead of physical VRAM.

smem_len should be splitted in (say) smem_mapped (for read/write/mmap)
and smem_total_vram (for FBIOGET_FSCREENINFO). I'll code something
tomorrow... -ENEEDSLEEP ;)

Luca
-- 
Home: http://kronoz.cjb.net
E' stato a causa di una donna che ho cominciato a bere e non ho mai
avuto la cortesia di ringraziarla.
