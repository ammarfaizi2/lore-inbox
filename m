Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270804AbTHFRTo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 13:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270832AbTHFRTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 13:19:44 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:18311 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S270804AbTHFRT1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 13:19:27 -0400
Date: Wed, 6 Aug 2003 19:19:21 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RESEND, first time as BKPATCH] matroxfb updates
Message-ID: <20030806171921.GA4892@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please do a

	bk pull http://ncpfs.bkbits.net/matroxfb

I hope that this format is more acceptable to you than patches - and if nothing
else, it will make further resends simpler...
						Thanks,
							Petr Vandrovec

This will update the following files:

 drivers/video/matrox/matroxfb_DAC1064.c |    2 
 drivers/video/matrox/matroxfb_Ti3026.c  |    1 
 drivers/video/matrox/matroxfb_base.c    |   67 +++++++++++++++++++++-----------
 drivers/video/matrox/matroxfb_base.h    |    2 
 drivers/video/matrox/matroxfb_crtc2.c   |    7 ---
 drivers/video/matrox/matroxfb_crtc2.h   |    1 
 6 files changed, 51 insertions(+), 29 deletions(-)

through these ChangeSets:

<vandrove@vc.cvut.cz> (03/08/06 1.1122)
   Add support for panning at vertical blanking to the matroxfb. Now mplayer output 
   looks much better on primary output (secondary output is always synced with vbl).

<vandrove@vc.cvut.cz> (03/08/06 1.1121)
   matroxfb: Initialize fbcon's cmap.

<vandrove@vc.cvut.cz> (03/08/06 1.1120)
   Remove write-only palette variable from matroxfb. Now it is possible to build 
   matroxfb without fbcon support.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1119  -> 1.1122 
#	drivers/video/matrox/matroxfb_Ti3026.c	1.7     -> 1.8    
#	drivers/video/matrox/matroxfb_crtc2.h	1.4     -> 1.5    
#	drivers/video/matrox/matroxfb_DAC1064.c	1.15    -> 1.16   
#	drivers/video/matrox/matroxfb_base.h	1.22    -> 1.24   
#	drivers/video/matrox/matroxfb_base.c	1.39    -> 1.42   
#	drivers/video/matrox/matroxfb_crtc2.c	1.24    -> 1.27   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/06	vandrove@vc.cvut.cz	1.1120
# Remove write-only palette variable from matroxfb. Now it is possible to build 
# matroxfb without fbcon support.
# --------------------------------------------
# 03/08/06	vandrove@vc.cvut.cz	1.1121
# matroxfb: Initialize fbcon's cmap.
# --------------------------------------------
# 03/08/06	vandrove@vc.cvut.cz	1.1122
# Add support for panning at vertical blanking to the matroxfb. Now mplayer output 
# looks much better on primary output (secondary output is always synced with vbl).
# --------------------------------------------
#
diff -Nru a/drivers/video/matrox/matroxfb_DAC1064.c b/drivers/video/matrox/matroxfb_DAC1064.c
--- a/drivers/video/matrox/matroxfb_DAC1064.c	Wed Aug  6 19:16:11 2003
+++ b/drivers/video/matrox/matroxfb_DAC1064.c	Wed Aug  6 19:16:11 2003
@@ -1036,6 +1036,7 @@
 
 	DAC1064_restore_1(PMINFO2);
 	matroxfb_vgaHWrestore(PMINFO2);
+	ACCESS_FBINFO(crtc1.panpos) = -1;
 	for (i = 0; i < 6; i++)
 		mga_setr(M_EXTVGA_INDEX, i, hw->CRTCEXT[i]);
 	DAC1064_restore_2(PMINFO2);
@@ -1062,6 +1063,7 @@
 	if (ACCESS_FBINFO(devflags.support32MB))
 		mga_setr(M_EXTVGA_INDEX, 8, hw->CRTCEXT[8]);
 #endif
+	ACCESS_FBINFO(crtc1.panpos) = -1;
 	for (i = 0; i < 6; i++)
 		mga_setr(M_EXTVGA_INDEX, i, hw->CRTCEXT[i]);
 	DAC1064_restore_2(PMINFO2);
diff -Nru a/drivers/video/matrox/matroxfb_Ti3026.c b/drivers/video/matrox/matroxfb_Ti3026.c
--- a/drivers/video/matrox/matroxfb_Ti3026.c	Wed Aug  6 19:16:11 2003
+++ b/drivers/video/matrox/matroxfb_Ti3026.c	Wed Aug  6 19:16:11 2003
@@ -575,6 +575,7 @@
 
 	CRITBEGIN
 
+	ACCESS_FBINFO(crtc1.panpos) = -1;
 	for (i = 0; i < 6; i++)
 		mga_setr(M_EXTVGA_INDEX, i, hw->CRTCEXT[i]);
 
diff -Nru a/drivers/video/matrox/matroxfb_base.c b/drivers/video/matrox/matroxfb_base.c
--- a/drivers/video/matrox/matroxfb_base.c	Wed Aug  6 19:16:11 2003
+++ b/drivers/video/matrox/matroxfb_base.c	Wed Aug  6 19:16:11 2003
@@ -176,6 +176,27 @@
 	}
 }
 
+static void matroxfb_crtc1_panpos(WPMINFO2) {
+	if (ACCESS_FBINFO(crtc1.panpos) >= 0) {
+		unsigned long flags;
+		int panpos;
+
+		matroxfb_DAC_lock_irqsave(flags);
+		panpos = ACCESS_FBINFO(crtc1.panpos);
+		if (panpos >= 0) {
+			unsigned int extvga_reg;
+
+			ACCESS_FBINFO(crtc1.panpos) = -1; /* No update pending anymore */
+			extvga_reg = mga_inb(M_EXTVGA_INDEX);
+			mga_setr(M_EXTVGA_INDEX, 0x00, panpos);
+			if (extvga_reg != 0x00) {
+				mga_outb(M_EXTVGA_INDEX, extvga_reg);
+			}
+		}
+		matroxfb_DAC_unlock_irqrestore(flags);
+	}
+}
+
 static irqreturn_t matrox_irq(int irq, void *dev_id, struct pt_regs *fp)
 {
 	u_int32_t status;
@@ -188,6 +209,7 @@
 	if (status & 0x20) {
 		mga_outl(M_ICLEAR, 0x20);
 		ACCESS_FBINFO(crtc1.vsync.cnt)++;
+		matroxfb_crtc1_panpos(PMINFO2);
 		wake_up_interruptible(&ACCESS_FBINFO(crtc1.vsync.wait));
 		handled = 1;
 	}
@@ -209,12 +231,13 @@
 		bm = 0x020;
 
 	if (!test_and_set_bit(0, &ACCESS_FBINFO(irq_flags))) {
-		printk(KERN_DEBUG "matroxfb: enabling IRQ\n");
 		if (request_irq(ACCESS_FBINFO(pcidev)->irq, matrox_irq,
-				SA_SHIRQ, "MGA Vertical Sync", MINFO)) {
+				SA_SHIRQ, "matroxfb", MINFO)) {
 			clear_bit(0, &ACCESS_FBINFO(irq_flags));
 			return -EINVAL;
 		}
+		/* Clear any pending field interrupts */
+		mga_outl(M_ICLEAR, bm);
 		mga_outl(M_IEN, mga_inl(M_IEN) | bm);
 	} else if (reenable) {
 		u_int32_t ien;
@@ -230,7 +253,8 @@
 
 static void matroxfb_disable_irq(WPMINFO2) {
 	if (test_and_clear_bit(0, &ACCESS_FBINFO(irq_flags))) {
-		printk(KERN_DEBUG "matroxfb: disabling IRQ\n");
+		/* Flush pending pan-at-vbl request... */
+		matroxfb_crtc1_panpos(PMINFO2);
 		if (ACCESS_FBINFO(devflags.accelerator) == FB_ACCEL_MATROX_MGAG400)
 			mga_outl(M_IEN, mga_inl(M_IEN) & ~0x220);
 		else
@@ -284,6 +308,9 @@
 #ifdef CONFIG_FB_MATROX_32MB
 	unsigned int p3;
 #endif
+	int vbl;
+	unsigned long flags;
+
 	CRITFLAGS
 
 	DBG(__FUNCTION__)
@@ -302,15 +329,26 @@
 	p3 = ACCESS_FBINFO(hw).CRTCEXT[8] = pos >> 21;
 #endif
 
+	/* FB_ACTIVATE_VBL and we can acquire interrupts? Honor FB_ACTIVATE_VBL then... */
+	vbl = (var->activate & FB_ACTIVATE_VBL) && (matroxfb_enable_irq(PMINFO 0) == 0);
+
 	CRITBEGIN
 
+	matroxfb_DAC_lock_irqsave(flags);
 	mga_setr(M_CRTC_INDEX, 0x0D, p0);
 	mga_setr(M_CRTC_INDEX, 0x0C, p1);
 #ifdef CONFIG_FB_MATROX_32MB
 	if (ACCESS_FBINFO(devflags.support32MB))
 		mga_setr(M_EXTVGA_INDEX, 0x08, p3);
 #endif
-	mga_setr(M_EXTVGA_INDEX, 0x00, p2);
+	if (vbl) {
+		ACCESS_FBINFO(crtc1.panpos) = p2;
+	} else {
+		/* Abort any pending change */
+		ACCESS_FBINFO(crtc1.panpos) = -1;
+		mga_setr(M_EXTVGA_INDEX, 0x00, p2);
+	}
+	matroxfb_DAC_unlock_irqrestore(flags);
 	
 	update_crtc2(PMINFO pos);
 
@@ -627,11 +665,6 @@
 	if (regno >= ACCESS_FBINFO(curr.cmap_len))
 		return 1;
 
-	ACCESS_FBINFO(palette[regno].red)   = red;
-	ACCESS_FBINFO(palette[regno].green) = green;
-	ACCESS_FBINFO(palette[regno].blue)  = blue;
-	ACCESS_FBINFO(palette[regno].transp) = transp;
-
 	if (ACCESS_FBINFO(fbcon).var.grayscale) {
 		/* gray = 0.30*R + 0.59*G + 0.11*B */
 		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
@@ -748,19 +781,6 @@
 		else
 			ACCESS_FBINFO(curr.ydstorg.pixels) = (ydstorg * 8) / var->bits_per_pixel;
 		ACCESS_FBINFO(curr.final_bppShift) = matroxfb_get_final_bppShift(PMINFO var->bits_per_pixel);
-		if (visual == MX_VISUAL_PSEUDOCOLOR) {
-			int i;
-
-			for (i = 0; i < 16; i++) {
-				int j;
-
-				j = color_table[i];
-				ACCESS_FBINFO(palette[i].red)   = default_red[j];
-				ACCESS_FBINFO(palette[i].green) = default_grn[j];
-				ACCESS_FBINFO(palette[i].blue)  = default_blu[j];
-			}
-		}
-
 		{	struct my_timming mt;
 			struct matrox_hw_state* hw;
 			int out;
@@ -1698,6 +1718,7 @@
 	/* after __init time we are like module... no logo */
 	ACCESS_FBINFO(fbcon.flags) = hotplug ? FBINFO_FLAG_MODULE : FBINFO_FLAG_DEFAULT;
 	ACCESS_FBINFO(video.len_usable) &= PAGE_MASK;
+	fb_alloc_cmap(&ACCESS_FBINFO(fbcon.cmap), 256, 1);
 
 #ifndef MODULE
 	/* mode database is marked __init!!! */
@@ -1990,6 +2011,7 @@
 	ACCESS_FBINFO(irq_flags) = 0;
 	init_waitqueue_head(&ACCESS_FBINFO(crtc1.vsync.wait));
 	init_waitqueue_head(&ACCESS_FBINFO(crtc2.vsync.wait));
+	ACCESS_FBINFO(crtc1.panpos) = -1;
 
 	err = initMatrox2(PMINFO b);
 	if (!err) {
@@ -2483,6 +2505,7 @@
 EXPORT_SYMBOL(matroxfb_register_driver);
 EXPORT_SYMBOL(matroxfb_unregister_driver);
 EXPORT_SYMBOL(matroxfb_wait_for_sync);
+EXPORT_SYMBOL(matroxfb_enable_irq);
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
diff -Nru a/drivers/video/matrox/matroxfb_base.h b/drivers/video/matrox/matroxfb_base.h
--- a/drivers/video/matrox/matroxfb_base.h	Wed Aug  6 19:16:11 2003
+++ b/drivers/video/matrox/matroxfb_base.h	Wed Aug  6 19:16:11 2003
@@ -457,6 +457,7 @@
 		struct matrox_vsync	vsync;
 		unsigned int	pixclock;
 		int		mnp;
+		int		panpos;
 			      } crtc1;
 	struct {
 		struct matrox_vsync	vsync;
@@ -595,7 +596,6 @@
 					dll:1;
 				      } memory;
 			      } values;
-	struct { unsigned red, green, blue, transp; } palette[256];
 	u_int32_t cmap[17];
 };
 
diff -Nru a/drivers/video/matrox/matroxfb_crtc2.c b/drivers/video/matrox/matroxfb_crtc2.c
--- a/drivers/video/matrox/matroxfb_crtc2.c	Wed Aug  6 19:16:11 2003
+++ b/drivers/video/matrox/matroxfb_crtc2.c	Wed Aug  6 19:16:11 2003
@@ -33,10 +33,6 @@
 
 	if (regno >= 16)
 		return 1;
-	m2info->palette[regno].red = red;
-	m2info->palette[regno].blue = blue;
-	m2info->palette[regno].green = green;
-	m2info->palette[regno].transp = transp;
 	if (m2info->fbcon.var.grayscale) {
 		/* gray = 0.30*R + 0.59*G + 0.11*B */
 		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
@@ -152,7 +148,7 @@
 	mga_outl(0x3C10, tmp);
 	ACCESS_FBINFO(hw).crtc2.ctl = tmp;
 
-	tmp = 0x0FFF0000;		/* line compare */
+	tmp = mt->VDisplay << 16;	/* line compare */
 	if (mt->sync & FB_SYNC_HOR_HIGH_ACT)
 		tmp |= 0x00000100;
 	if (mt->sync & FB_SYNC_VERT_HIGH_ACT)
@@ -609,6 +605,7 @@
 	m2info->fbcon.flags = FBINFO_FLAG_DEFAULT;
 	m2info->fbcon.currcon = -1;
 	m2info->fbcon.pseudo_palette = m2info->cmap;
+	fb_alloc_cmap(&m2info->fbcon.cmap, 256, 1);
 
 	if (mem < 64)
 		mem *= 1024;
diff -Nru a/drivers/video/matrox/matroxfb_crtc2.h b/drivers/video/matrox/matroxfb_crtc2.h
--- a/drivers/video/matrox/matroxfb_crtc2.h	Wed Aug  6 19:16:11 2003
+++ b/drivers/video/matrox/matroxfb_crtc2.h	Wed Aug  6 19:16:11 2003
@@ -30,7 +30,6 @@
 	int			interlaced:1;
 
 	u_int32_t cmap[17];
-	struct { unsigned red, green, blue, transp; } palette[17];
 };
 
 #endif /* __MATROXFB_CRTC2_H__ */
