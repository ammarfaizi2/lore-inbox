Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030646AbWJJX0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030646AbWJJX0g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 19:26:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030680AbWJJX0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 19:26:36 -0400
Received: from havoc.gtf.org ([69.61.125.42]:50347 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1030646AbWJJX0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 19:26:35 -0400
Date: Tue, 10 Oct 2006 19:26:34 -0400
From: Jeff Garzik <jeff@garzik.org>
To: adaplas@pol.net, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] atyfb, rivafb: minor fixes
Message-ID: <20061010232634.GA19328@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


aty128fb: return an error in the unlikely event that we cannot calculate
some key PLL info

rivafb:
* call CalcStateExt() directly, rather than via function pointers, since
  CalcStateExt() is the only value ever assigned to ->CalcStateExt().
* propagate error return back from CalcVClock() through callers

Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/video/aty/aty128fb.c  |    5 +++++
 drivers/video/riva/fbdev.c    |   22 +++++++++++++++++-----
 drivers/video/riva/riva_hw.c  |   12 ++++++------
 drivers/video/riva/riva_hw.h  |   17 ++++++++++++++++-

diff --git a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
index 276a215..3feddf8 100644
--- a/drivers/video/aty/aty128fb.c
+++ b/drivers/video/aty/aty128fb.c
@@ -1333,6 +1333,8 @@ static int aty128_var_to_pll(u32 period_
 	if (vclk * 12 < c.ppll_min)
 		vclk = c.ppll_min/12;
 
+	pll->post_divider = -1;
+
 	/* now, find an acceptable divider */
 	for (i = 0; i < sizeof(post_dividers); i++) {
 		output_freq = post_dividers[i] * vclk;
@@ -1342,6 +1344,9 @@ static int aty128_var_to_pll(u32 period_
 		}
 	}
 
+	if (pll->post_divider < 0)
+		return -EINVAL;
+
 	/* calculate feedback divider */
 	n = c.ref_divider * output_freq;
 	d = c.ref_clk;
diff --git a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
index a433cc7..1fdfb64 100644
--- a/drivers/video/riva/fbdev.c
+++ b/drivers/video/riva/fbdev.c
@@ -774,11 +774,12 @@ static void riva_load_state(struct riva_
  * CALLED FROM:
  * rivafb_set_par()
  */
-static void riva_load_video_mode(struct fb_info *info)
+static int riva_load_video_mode(struct fb_info *info)
 {
 	int bpp, width, hDisplaySize, hDisplay, hStart,
 	    hEnd, hTotal, height, vDisplay, vStart, vEnd, vTotal, dotClock;
 	int hBlankStart, hBlankEnd, vBlankStart, vBlankEnd;
+	int rc;
 	struct riva_par *par = info->par;
 	struct riva_regs newmode;
 	
@@ -884,8 +885,10 @@ static void riva_load_video_mode(struct 
 	else
 		newmode.misc_output |= 0x80;	
 
-	par->riva.CalcStateExt(&par->riva, &newmode.ext, bpp, width,
-				  hDisplaySize, height, dotClock);
+	rc = CalcStateExt(&par->riva, &newmode.ext, bpp, width,
+			  hDisplaySize, height, dotClock);
+	if (rc)
+		goto out;
 
 	newmode.ext.scale = NV_RD32(par->riva.PRAMDAC, 0x00000848) &
 		0xfff000ff;
@@ -917,8 +920,12 @@ static void riva_load_video_mode(struct 
 	par->current_state = newmode;
 	riva_load_state(par, &par->current_state);
 	par->riva.LockUnlock(&par->riva, 0); /* important for HW cursor */
+
+out:
 	rivafb_blank(FB_BLANK_UNBLANK, info);
 	NVTRACE_LEAVE();
+
+	return rc;
 }
 
 static void riva_update_var(struct fb_var_screeninfo *var, struct fb_videomode *modedb)
@@ -1286,12 +1293,15 @@ static int rivafb_check_var(struct fb_va
 static int rivafb_set_par(struct fb_info *info)
 {
 	struct riva_par *par = info->par;
+	int rc = 0;
 
 	NVTRACE_ENTER();
 	/* vgaHWunlock() + riva unlock (0x7F) */
 	CRTCout(par, 0x11, 0xFF);
 	par->riva.LockUnlock(&par->riva, 0);
-	riva_load_video_mode(info);
+	rc = riva_load_video_mode(info);
+	if (rc)
+		goto out;
 	if(!(info->flags & FBINFO_HWACCEL_DISABLED))
 		riva_setup_accel(info);
 	
@@ -1304,8 +1314,10 @@ static int rivafb_set_par(struct fb_info
 		info->pixmap.scan_align = 1;
 	else
 		info->pixmap.scan_align = 4;
+
+out:
 	NVTRACE_LEAVE();
-	return 0;
+	return rc;
 }
 
 /**
diff --git a/drivers/video/riva/riva_hw.c b/drivers/video/riva/riva_hw.c
index b6f8690..c1f092c 100644
--- a/drivers/video/riva/riva_hw.c
+++ b/drivers/video/riva/riva_hw.c
@@ -1227,7 +1227,7 @@ (
  * Calculate extended mode parameters (SVGA) and save in a 
  * mode state structure.
  */
-static void CalcStateExt
+int CalcStateExt
 (
     RIVA_HW_INST  *chip,
     RIVA_HW_STATE *state,
@@ -1249,7 +1249,8 @@ (
      * Extended RIVA registers.
      */
     pixelDepth = (bpp + 1)/8;
-    CalcVClock(dotClock, &VClk, &m, &n, &p, chip);
+    if (!CalcVClock(dotClock, &VClk, &m, &n, &p, chip))
+    	return -EINVAL;
 
     switch (chip->Architecture)
     {
@@ -1327,6 +1328,8 @@ (
     state->pitch1   =
     state->pitch2   =
     state->pitch3   = pixelDepth * width;
+
+    return 0;
 }
 /*
  * Load fixed function state and pre-calculated/stored state.
@@ -2026,7 +2029,6 @@ (
      */
     chip->Busy            = nv3Busy;
     chip->ShowHideCursor  = ShowHideCursor;
-    chip->CalcStateExt    = CalcStateExt;
     chip->LoadStateExt    = LoadStateExt;
     chip->UnloadStateExt  = UnloadStateExt;
     chip->SetStartAddress = SetStartAddress3;
@@ -2084,7 +2086,6 @@ (
      */
     chip->Busy            = nv4Busy;
     chip->ShowHideCursor  = ShowHideCursor;
-    chip->CalcStateExt    = CalcStateExt;
     chip->LoadStateExt    = LoadStateExt;
     chip->UnloadStateExt  = UnloadStateExt;
     chip->SetStartAddress = SetStartAddress;
@@ -2186,7 +2187,6 @@ #endif
      */
     chip->Busy            = nv10Busy;
     chip->ShowHideCursor  = ShowHideCursor;
-    chip->CalcStateExt    = CalcStateExt;
     chip->LoadStateExt    = LoadStateExt;
     chip->UnloadStateExt  = UnloadStateExt;
     chip->SetStartAddress = SetStartAddress;
diff --git a/drivers/video/riva/riva_hw.h b/drivers/video/riva/riva_hw.h
index a1e71a6..c2769f7 100644
--- a/drivers/video/riva/riva_hw.h
+++ b/drivers/video/riva/riva_hw.h
@@ -463,7 +463,6 @@ typedef struct _riva_hw_inst
      * Common chip functions.
      */
     int  (*Busy)(struct _riva_hw_inst *);
-    void (*CalcStateExt)(struct _riva_hw_inst *,struct _riva_hw_state *,int,int,int,int,int);
     void (*LoadStateExt)(struct _riva_hw_inst *,struct _riva_hw_state *);
     void (*UnloadStateExt)(struct _riva_hw_inst *,struct _riva_hw_state *);
     void (*SetStartAddress)(struct _riva_hw_inst *,U032);
@@ -528,6 +527,22 @@ typedef struct _riva_hw_state
     U032 pitch2;
     U032 pitch3;
 } RIVA_HW_STATE;
+
+/*
+ * function prototypes
+ */
+
+extern int CalcStateExt
+(
+    RIVA_HW_INST  *chip,
+    RIVA_HW_STATE *state,
+    int            bpp,
+    int            width,
+    int            hDisplaySize,
+    int            height,
+    int            dotClock
+);
+
 /*
  * External routines.
  */
