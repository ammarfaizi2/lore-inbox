Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266094AbUFQCWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266094AbUFQCWG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 22:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266086AbUFQCVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 22:21:39 -0400
Received: from havoc.gtf.org ([216.162.42.101]:55780 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266094AbUFQCVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 22:21:09 -0400
Date: Wed, 16 Jun 2004 22:21:00 -0400
From: David Eger <eger@havoc.gtf.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: [PATCH] fix radeonfb panning and make it play nice with copyarea()
Message-ID: <20040617022100.GA11774@havoc.gtf.org>
References: <20040616182415.GA8286@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616182415.GA8286@middle.of.nowhere>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/me looks at vanilla 2.6.7

I believe the following patch will fix the bug you describe.
(part of this patch I sent to benh before, but it never made it to 2.6.7)

Please try the following bugfix.  It works for me.
If it works for you, I'll ask Andrew/James to merge.

-dte


radeonfb: fix panning corruption on a large virtual screen,
  Make panning and copyarea() play nicely with each other.

Signed-off-by: David Eger <eger@havoc.gtf.org>

# drivers/video/aty/radeon_base.c
#   2004/06/17 03:47:12+02:00 eger@rosencrantz.theboonies.us +13 -0
#   add some fifo_wait()s to lick this corruption problem
# 
# drivers/video/aty/radeon_accel.c
#   2004/06/17 03:47:12+02:00 eger@rosencrantz.theboonies.us +2 -2
#   make radeon accel play nice when the user wants to have a large virtual
#   screen to pan on.  fix previous drain bramage.
# 
diff -Nru a/drivers/video/aty/radeon_accel.c b/drivers/video/aty/radeon_accel.c
--- a/drivers/video/aty/radeon_accel.c	2004-06-17 03:52:48 +02:00
+++ b/drivers/video/aty/radeon_accel.c	2004-06-17 03:52:48 +02:00
@@ -35,8 +35,8 @@
 		return;
 	}
 
-	vxres = info->var.xres;
-	vyres = info->var.yres;
+	vxres = info->var.xres_virtual;
+	vyres = info->var.yres_virtual;
 
 	memcpy(&modded, region, sizeof(struct fb_fillrect));
 
@@ -101,8 +102,8 @@
 		return;
 	}
 
-	vxres = info->var.xres;
-	vyres = info->var.yres;
+	vxres = info->var.xres_virtual;
+	vyres = info->var.yres_virtual;
 
 	if(!modded.width || !modded.height ||
 	   modded.sx >= vxres || modded.sy >= vyres ||
diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c	2004-06-17 03:52:48 +02:00
+++ b/drivers/video/aty/radeon_base.c	2004-06-17 03:52:48 +02:00
@@ -855,6 +855,7 @@
         if (rinfo->asleep)
         	return 0;
 
+	radeon_fifo_wait(2);
         OUTREG(CRTC_OFFSET, ((var->yoffset * var->xres_virtual + var->xoffset)
 			     * var->bits_per_pixel / 8) & ~7);
         return 0;
@@ -884,6 +885,7 @@
 			if (rc)
 				return rc;
 
+			radeon_fifo_wait(2);
 			if (value & 0x01) {
 				tmp = INREG(LVDS_GEN_CNTL);
 
@@ -960,6 +962,7 @@
                         break;
         }
 
+	radeon_fifo_wait(1);
 	switch (rinfo->mon1_type) {
 		case MT_LCD:
 			OUTREG(LVDS_GEN_CNTL, val2);
@@ -1018,6 +1021,7 @@
         if (!rinfo->asleep) {
         	u32 dac_cntl2, vclk_cntl = 0;
         	
+		radeon_fifo_wait(9);
 		if (rinfo->is_mobility) {
 			vclk_cntl = INPLL(VCLK_ECP_CNTL);
 			OUTPLL(VCLK_ECP_CNTL, vclk_cntl & ~PIXCLK_DAC_ALWAYS_ONb);
@@ -1109,6 +1113,8 @@
 {
 	int i;
 
+	radeon_fifo_wait(20);
+	
 	/* Workaround from XFree */
 	if (rinfo->is_mobility) {
 	        /* A temporal workaround for the occational blanking on certain laptop panels. 
@@ -1195,6 +1201,8 @@
 {
 	struct radeonfb_info *rinfo = (struct radeonfb_info *)data;
 
+	radeon_fifo_wait(3);
+
 	OUTREG(LVDS_GEN_CNTL, rinfo->pending_lvds_gen_cntl);
 	if (rinfo->pending_pixclks_cntl) {
 		OUTPLL(PIXCLKS_CNTL, rinfo->pending_pixclks_cntl);
@@ -1219,6 +1227,7 @@
 
 	radeon_screen_blank(rinfo, VESA_POWERDOWN);
 
+	radeon_fifo_wait(31);
 	for (i=0; i<10; i++)
 		OUTREG(common_regs[i].reg, common_regs[i].val);
 
@@ -1246,6 +1255,7 @@
 	radeon_write_pll_regs(rinfo, mode);
 
 	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD)) {
+		radeon_fifo_wait(10);
 		OUTREG(FP_CRTC_H_TOTAL_DISP, mode->fp_crtc_h_total_disp);
 		OUTREG(FP_CRTC_V_TOTAL_DISP, mode->fp_crtc_v_total_disp);
 		OUTREG(FP_H_SYNC_STRT_WID, mode->fp_h_sync_strt_wid);
@@ -1285,6 +1295,7 @@
 
 	radeon_screen_blank(rinfo, VESA_NO_BLANKING);
 
+	radeon_fifo_wait(2);
 	OUTPLL(VCLK_ECP_CNTL, mode->vclk_ecp_cntl);
 	
 	return;
@@ -1858,6 +1870,7 @@
 	del_timer_sync(&rinfo->lvds_timer);
 
 	lvds_gen_cntl |= (LVDS_BL_MOD_EN | LVDS_BLON);
+	radeon_fifo_wait(3);
 	if (on && (level > BACKLIGHT_OFF)) {
 		lvds_gen_cntl |= LVDS_DIGON;
 		if (!(lvds_gen_cntl & LVDS_ON)) {
@@ -2130,6 +2143,7 @@
           u32 tom = INREG(NB_TOM);
           tmp = ((((tom >> 16) - (tom & 0xffff) + 1) << 6) * 1024);
  
+ 		radeon_fifo_wait(6);
           OUTREG(MC_FB_LOCATION, tom);
           OUTREG(DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
           OUTREG(CRTC2_DISPLAY_BASE_ADDR, (tom & 0xffff) << 16);
