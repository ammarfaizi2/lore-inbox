Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265961AbUF2TBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265961AbUF2TBy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 15:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUF2TBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 15:01:36 -0400
Received: from mail-relay-1.tiscali.it ([212.123.84.91]:35212 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S265928AbUF2TAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 15:00:40 -0400
Date: Tue, 29 Jun 2004 21:00:22 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH][2.4] Fix ioremap in radeonfb
Message-ID: <20040629190022.GA5015@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,
the following patch fixes a problem in radeonfb. The driver tries to
ioreamp()s the whole vram of the board (which can be 128MB or more), but
on system with lots of RAM (ie. >= 1GB) there isn't enough space in
lowmem to ioreamp that much vram. The problem was described here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=108828732909305&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=108829040825180&w=2

and the OP confirmed that the driver works fine with the patch (same
thread). With the patch the driver ioremap()s only a small portion of
the vram (at most 16MB) and tries until it succedes or it goes below the
minimum requirement (768KB). 
2.6 also does the same.

Signed-off-by: Luca Tettamanti <kronos@kronoz.cjb.net>

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
+	RTRACE(KERN_INFO "radeonfb: mapped %dk of videoram\n", rinfo->mapped_vram/1024);
 
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
                 


Luca
-- 
Home: http://kronoz.cjb.net
"La mia teoria scientifica preferita e` quella secondo la quale gli 
 anelli di Saturno sarebbero interamente composti dai bagagli andati 
 persi nei viaggi aerei." -- Mark Russel
