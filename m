Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbULAQP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbULAQP6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 11:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbULAQP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 11:15:58 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:39655 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261298AbULAQO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 11:14:58 -0500
Date: Wed, 1 Dec 2004 17:14:55 +0100
From: Kronos <kronos@people.it>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.29-pre1] radeonfb: don't try to ioreamp the entire VRAM [was: Re: [Linux-fbdev-devel] why does radeonfb work fine in 2.6, but not in 2.4.29-pre1?]
Message-ID: <20041201161455.GA14817@dreamland.darkstar.lan>
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
> The card has 128 MB of ram, and my system has 3 GB of RAM.
> 
> Is there any reason the ioremap() call works on 2.6, but doesn't on 2.4?
> 
> I've tried searching google for hints, but nothing has turned up.
> 
> Is there any way to test 2.4 with my radeonfb and all of my memory?

Hi Marcelo,
I sent you a patch a while ago but was discarded because introduced a
subtle API change. This time should be ok :)

Make fb layer aware of the difference between the ioremap()'ed VRAM and
total available VRAM.
smem_len in struct fb_fix_screeninfo still contains the amount of
physical VRAM (reported to userspace via FBIOGET_FSCREENINFO ioctl) and
the new field mapped_vram contains the amount of VRAM actually
ioremap()'ed by drivers (used in read/write/mmap operations).
Since there was unused padding at the end of struct fb_fix_screeninfo
binary compatibility with userspace utilities is retained.
If mapped_vram is not set it's assumed that the entire framebuffer is
mapped, thus other drivers are unaffected by this patch.

The patch has been tested by Jurriaan <thunder7@xs4all.nl>.

Signed-off-by: Luca Tettamanti <kronos@people.it>

--- a/include/linux/fb.h	2004-11-30 18:30:08.000000000 +0100
+++ b/include/linux/fb.h	2004-11-30 18:33:00.000000000 +0100
@@ -126,7 +126,8 @@
 					/* (physical address) */
 	__u32 mmio_len;			/* Length of Memory Mapped I/O  */
 	__u32 accel;			/* Type of acceleration available */
-	__u16 reserved[3];		/* Reserved for future compatibility */
+	__u32 mapped_vram;		/* Amount of ioremap()'ed VRAM */
+	__u16 reserved[1];		/* Reserved for future compatibility */
 };
 
 /* Interpretation of offset for color fields: All offsets are from the right,
--- a/drivers/video/fbmem.c	2004-11-30 18:30:00.000000000 +0100
+++ b/drivers/video/fbmem.c	2004-11-30 18:43:06.000000000 +0100
@@ -410,6 +410,7 @@
 	struct fb_info *info = registered_fb[fbidx];
 	struct fb_ops *fb = info->fbops;
 	struct fb_fix_screeninfo fix;
+	unsigned int size;
 
 	if (! fb || ! info->disp)
 		return -ENODEV;
@@ -418,10 +419,12 @@
 		return -EINVAL;
 
 	fb->fb_get_fix(&fix,PROC_CONSOLE(info), info);
-	if (p >= fix.smem_len)
+	size = fix.mapped_vram ? fix.mapped_vram : fix.smem_len;
+	
+	if (p >= size)
 	    return 0;
-	if (count > fix.smem_len - p)
-		count = fix.smem_len - p;
+	if (count > size - p)
+		count = size - p;
 	if (count) {
 	    char *base_addr;
 
@@ -444,6 +447,7 @@
 	struct fb_ops *fb = info->fbops;
 	struct fb_fix_screeninfo fix;
 	int err;
+	unsigned int size;
 
 	if (! fb || ! info->disp)
 		return -ENODEV;
@@ -452,11 +456,13 @@
 		return -EINVAL;
 
 	fb->fb_get_fix(&fix, PROC_CONSOLE(info), info);
-	if (p > fix.smem_len)
+	size = fix.mapped_vram ? fix.mapped_vram : fix.smem_len;
+	
+	if (p > size)
 	    return -ENOSPC;
 	err = 0;
-	if (count > fix.smem_len - p) {
-	    count = fix.smem_len - p;
+	if (count > size - p) {
+	    count = size - p;
 	    err = -ENOSPC;
 	}
 	if (count) {
@@ -619,7 +625,10 @@
 
 	/* frame buffer memory */
 	start = fix.smem_start;
-	len = PAGE_ALIGN((start & ~PAGE_MASK)+fix.smem_len);
+	if (fix.mapped_vram)
+		len = PAGE_ALIGN((start & ~PAGE_MASK) + fix.mapped_vram);
+	else
+		len = PAGE_ALIGN((start & ~PAGE_MASK) + fix.smem_len);
 	if (off >= len) {
 		/* memory mapped io */
 		off -= len;
--- a/drivers/video/radeonfb.c	2004-11-30 18:06:45.000000000 +0100
+++ b/drivers/video/radeonfb.c	2004-11-30 18:50:25.000000000 +0100
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
@@ -1824,8 +1826,16 @@
 		}
 	}
 
-	rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys,
-				  		  rinfo->video_ram);
+	rinfo->mapped_vram = min_t(unsigned int, MAX_MAPPED_VRAM, rinfo->video_ram);
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
@@ -1836,6 +1846,7 @@
 		kfree (rinfo);
 		return -ENODEV;
 	}
+	RTRACE(KERN_INFO "radeonfb: mapped %dk videoram\n", rinfo->mapped_vram/1024);
 
 	/* currcon not yet configured, will be set by first switch */
 	rinfo->currcon = -1;
@@ -2205,7 +2216,7 @@
                 printk("radeonfb: using max available virtual resolution\n");
                 for (i=0; modes[i].xres != -1; i++) {
                         if (modes[i].xres * nom / den * modes[i].yres <
-                            rinfo->video_ram / 2)
+                            rinfo->mapped_vram / 2)
                                 break;
                 }
                 if (modes[i].xres == -1) {
@@ -2218,15 +2229,15 @@
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
@@ -2263,6 +2274,7 @@
         
         fix->smem_start = rinfo->fb_base_phys;
         fix->smem_len = rinfo->video_ram;
+        fix->mapped_vram = rinfo->mapped_vram;
 
         fix->type = disp->type;
         fix->type_aux = disp->type_aux;
@@ -2430,6 +2442,9 @@
                         return -EINVAL;
         }
 
+	if (((v.xres_virtual * v.yres_virtual * nom) / den) > rinfo->mapped_vram)
+		return -EINVAL;
+
         if (radeonfb_do_maximize(rinfo, var, &v, nom, den) < 0)
                 return -EINVAL;  
                 


Luca
-- 
Home: http://kronoz.cjb.net
"It is more complicated than you think"
                -- The Eighth Networking Truth from RFC 1925
