Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262642AbVDHBVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbVDHBVl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 21:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVDHBVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 21:21:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:34528 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262642AbVDHBVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 21:21:13 -0400
Subject: Re: [PATCH] radeonfb: (#2) Implement proper workarounds for PLL
	accesses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Dave Airlie <airlied@gmail.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <jemzsa6sxg.fsf@sykes.suse.de>
References: <1110519743.5810.13.camel@gaston>
	 <1110672745.5787.60.camel@gaston> <je8y3wyk3g.fsf@sykes.suse.de>
	 <1112743901.9568.67.camel@gaston> <jeoecr1qk8.fsf@sykes.suse.de>
	 <1112827655.9518.194.camel@gaston> <jehdii8hjk.fsf@sykes.suse.de>
	 <21d7e9970504071422349426eb@mail.gmail.com>
	 <1112914795.9568.320.camel@gaston>  <jemzsa6sxg.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Fri, 08 Apr 2005 11:19:46 +1000
Message-Id: <1112923186.9567.349.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 01:58 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > Yes, that's very extreme, I suspect somebody is banging on set_par or
> > something like that.
> 
> fb_setcolreg is it.

Ok, what about that patch:

---

This patch adds to the fbdev interface a set_cmap callback that allow
the driver to "batch" palette changes. This is useful for drivers like
radeonfb which might require lenghtly workarounds on palette accesses,
thus allowing to factor out those workarounds efficiently.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/include/linux/fb.h
===================================================================
--- linux-work.orig/include/linux/fb.h	2005-04-01 09:04:19.000000000 +1000
+++ linux-work/include/linux/fb.h	2005-04-08 10:24:56.000000000 +1000
@@ -563,6 +563,9 @@
 	int (*fb_setcolreg)(unsigned regno, unsigned red, unsigned green,
 			    unsigned blue, unsigned transp, struct fb_info *info);
 
+	/* set color registers in batch */
+	int (*fb_setcmap)(struct fb_cmap *cmap, struct fb_info *info);
+
 	/* blank display */
 	int (*fb_blank)(int blank, struct fb_info *info);
 
Index: linux-work/drivers/video/aty/radeon_base.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_base.c	2005-04-01 09:04:18.000000000 +1000
+++ linux-work/drivers/video/aty/radeon_base.c	2005-04-08 11:15:13.000000000 +1000
@@ -1057,13 +1057,14 @@
 	return radeon_screen_blank(rinfo, blank, 0);
 }
 
-static int radeonfb_setcolreg (unsigned regno, unsigned red, unsigned green,
-                             unsigned blue, unsigned transp, struct fb_info *info)
+static int radeon_setcolreg (unsigned regno, unsigned red, unsigned green,
+                             unsigned blue, unsigned transp,
+			     struct radeonfb_info *rinfo)
 {
-        struct radeonfb_info *rinfo = info->par;
 	u32 pindex;
 	unsigned int i;
-	
+
+
 	if (regno > 255)
 		return 1;
 
@@ -1078,20 +1079,7 @@
         pindex = regno;
 
         if (!rinfo->asleep) {
-        	u32 dac_cntl2, vclk_cntl = 0;
-        	
 		radeon_fifo_wait(9);
-		if (rinfo->is_mobility) {
-			vclk_cntl = INPLL(VCLK_ECP_CNTL);
-			OUTPLL(VCLK_ECP_CNTL, vclk_cntl & ~PIXCLK_DAC_ALWAYS_ONb);
-		}
-
-		/* Make sure we are on first palette */
-		if (rinfo->has_CRTC2) {
-			dac_cntl2 = INREG(DAC_CNTL2);
-			dac_cntl2 &= ~DAC2_PALETTE_ACCESS_CNTL;
-			OUTREG(DAC_CNTL2, dac_cntl2);
-		}
 
 		if (rinfo->bpp == 16) {
 			pindex = regno * 8;
@@ -1101,24 +1089,27 @@
 			if (rinfo->depth == 15 && regno > 31)
 				return 1;
 
-			/* For 565, the green component is mixed one order below */
+			/* For 565, the green component is mixed one order
+			 * below
+			 */
 			if (rinfo->depth == 16) {
 		                OUTREG(PALETTE_INDEX, pindex>>1);
-	       	         	OUTREG(PALETTE_DATA, (rinfo->palette[regno>>1].red << 16) |
-	                        	(green << 8) | (rinfo->palette[regno>>1].blue));
+	       	         	OUTREG(PALETTE_DATA,
+				       (rinfo->palette[regno>>1].red << 16) |
+	                        	(green << 8) |
+				       (rinfo->palette[regno>>1].blue));
 	                	green = rinfo->palette[regno<<1].green;
 	        	}
 		}
 
 		if (rinfo->depth != 16 || regno < 32) {
 			OUTREG(PALETTE_INDEX, pindex);
-			OUTREG(PALETTE_DATA, (red << 16) | (green << 8) | blue);
+			OUTREG(PALETTE_DATA, (red << 16) |
+			       (green << 8) | blue);
 		}
-		if (rinfo->is_mobility)
-			OUTPLL(VCLK_ECP_CNTL, vclk_cntl);
 	}
  	if (regno < 16) {
-		u32 *pal = info->pseudo_palette;
+		u32 *pal = rinfo->info->pseudo_palette;
         	switch (rinfo->depth) {
 		case 15:
 			pal[regno] = (regno << 10) | (regno << 5) | regno;
@@ -1138,6 +1129,84 @@
 	return 0;
 }
 
+static int radeonfb_setcolreg (unsigned regno, unsigned red, unsigned green,
+			       unsigned blue, unsigned transp,
+			       struct fb_info *info)
+{
+        struct radeonfb_info *rinfo = info->par;
+	u32 dac_cntl2, vclk_cntl = 0;
+	int rc;
+
+        if (!rinfo->asleep) {
+		if (rinfo->is_mobility) {
+			vclk_cntl = INPLL(VCLK_ECP_CNTL);
+			OUTPLL(VCLK_ECP_CNTL,
+			       vclk_cntl & ~PIXCLK_DAC_ALWAYS_ONb);
+		}
+
+		/* Make sure we are on first palette */
+		if (rinfo->has_CRTC2) {
+			dac_cntl2 = INREG(DAC_CNTL2);
+			dac_cntl2 &= ~DAC2_PALETTE_ACCESS_CNTL;
+			OUTREG(DAC_CNTL2, dac_cntl2);
+		}
+	}
+
+	rc = radeon_setcolreg (regno, red, green, blue, transp, rinfo);
+	
+	if (!rinfo->asleep && rinfo->is_mobility)
+		OUTPLL(VCLK_ECP_CNTL, vclk_cntl);
+
+	return rc;
+}
+
+static int radeonfb_setcmap(struct fb_cmap *cmap, struct fb_info *info)
+{
+        struct radeonfb_info *rinfo = info->par;
+	u16 *red, *green, *blue, *transp;
+	u32 dac_cntl2, vclk_cntl = 0;
+	int i, start, rc = 0;
+
+        if (!rinfo->asleep) {
+		if (rinfo->is_mobility) {
+			vclk_cntl = INPLL(VCLK_ECP_CNTL);
+			OUTPLL(VCLK_ECP_CNTL,
+			       vclk_cntl & ~PIXCLK_DAC_ALWAYS_ONb);
+		}
+
+		/* Make sure we are on first palette */
+		if (rinfo->has_CRTC2) {
+			dac_cntl2 = INREG(DAC_CNTL2);
+			dac_cntl2 &= ~DAC2_PALETTE_ACCESS_CNTL;
+			OUTREG(DAC_CNTL2, dac_cntl2);
+		}
+	}
+
+	red = cmap->red;
+	green = cmap->green;
+	blue = cmap->blue;
+	transp = cmap->transp;
+	start = cmap->start;
+
+	for (i = 0; i < cmap->len; i++) {
+		u_int hred, hgreen, hblue, htransp = 0xffff;
+
+		hred = *red++;
+		hgreen = *green++;
+		hblue = *blue++;
+		if (transp)
+			htransp = *transp++;
+		rc = radeon_setcolreg (start++, hred, hgreen, hblue, htransp,
+				       rinfo);
+		if (rc)
+			break;
+	}
+	
+	if (!rinfo->asleep && rinfo->is_mobility)
+		OUTPLL(VCLK_ECP_CNTL, vclk_cntl);
+
+	return rc;
+}
 
 static void radeon_save_state (struct radeonfb_info *rinfo,
 			       struct radeon_regs *save)
@@ -1796,6 +1865,7 @@
 	.fb_check_var		= radeonfb_check_var,
 	.fb_set_par		= radeonfb_set_par,
 	.fb_setcolreg		= radeonfb_setcolreg,
+	.fb_setcmap		= radeonfb_setcmap,
 	.fb_pan_display 	= radeonfb_pan_display,
 	.fb_blank		= radeonfb_blank,
 	.fb_ioctl		= radeonfb_ioctl,
Index: linux-work/drivers/video/fbcmap.c
===================================================================
--- linux-work.orig/drivers/video/fbcmap.c	2005-03-15 11:58:33.000000000 +1100
+++ linux-work/drivers/video/fbcmap.c	2005-04-08 11:14:51.000000000 +1000
@@ -222,8 +222,11 @@
 	transp = cmap->transp;
 	start = cmap->start;
 
-	if (start < 0 || !info->fbops->fb_setcolreg)
+	if (start < 0 || (!info->fbops->fb_setcolreg &&
+			  !info->fbops->fb_setcmap))
 		return -EINVAL;
+	if (info->fbops->fb_setcmap)
+		return info->fbops->fb_setcmap(cmap, info);
 	for (i = 0; i < cmap->len; i++) {
 		hred = *red++;
 		hgreen = *green++;
@@ -243,15 +246,40 @@
 	int i, start;
 	u16 __user *red, *green, *blue, *transp;
 	u_int hred, hgreen, hblue, htransp = 0xffff;
-
+	
 	red = cmap->red;
 	green = cmap->green;
 	blue = cmap->blue;
 	transp = cmap->transp;
 	start = cmap->start;
 
-	if (start < 0 || !info->fbops->fb_setcolreg)
+	if (start < 0 || (!info->fbops->fb_setcolreg &&
+			  !info->fbops->fb_setcmap))
 		return -EINVAL;
+	
+	/* If we can batch, do it */
+	if (info->fbops->fb_setcmap && cmap->len > 1) {
+		struct fb_cmap umap;
+		int size = cmap->len * sizeof(u16);
+		int rc;
+
+		memset(&umap, 0, sizeof(struct fb_cmap));
+		rc = fb_alloc_cmap(&umap, cmap->len, transp != NULL);
+		if (rc)
+			return rc;
+		if (copy_from_user(umap.red, red, size) ||
+		    copy_from_user(umap.green, green, size) ||
+		    copy_from_user(umap.blue, blue, size) ||
+		    (transp && copy_from_user(umap.transp, transp, size))) {
+			rc = -EFAULT;
+		}
+		umap.start = start;
+		if (rc == 0)
+			rc = info->fbops->fb_setcmap(&umap, info);
+		fb_dealloc_cmap(&umap);
+		return rc;
+	}
+
 	for (i = 0; i < cmap->len; i++, red++, blue++, green++) {
 		if (get_user(hred, red) ||
 		    get_user(hgreen, green) ||


