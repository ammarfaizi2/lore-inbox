Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbTLaKGy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 05:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbTLaKGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 05:06:54 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:55455 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264142AbTLaKF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 05:05:57 -0500
Date: Wed, 31 Dec 2003 11:05:48 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1
Message-ID: <20031231100548.GA16860@louise.pinerecords.com>
References: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-31 2003, Wed, 00:36 -0800
Linus Torvalds <torvalds@osdl.org> wrote:

> Most of the updates is for stuff that has been in -mm for a long while and 
> is stable, along with driver updates (SCSI, network, i2c and USB).

Linus, would you please consider applying the following patch (taken
from -mm) that puts radeonfb back in shape?

-- 
Tomas Szepe <szepe@pinerecords.com>


radeon-line-length-fix.patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 drivers/video/radeonfb.c |   30 +++++++++++++++++-------------
 1 files changed, 17 insertions(+), 13 deletions(-)

diff -puN drivers/video/radeonfb.c~radeon-line-length-fix drivers/video/radeonfb.c
--- 25/drivers/video/radeonfb.c~radeon-line-length-fix	2003-11-13 19:48:31.000000000 -0800
+++ 25-akpm/drivers/video/radeonfb.c	2003-11-13 19:48:31.000000000 -0800
@@ -679,7 +679,7 @@ static __inline__ int _max(int val1, int
  */
         
 static char *mode_option __initdata;
-static char noaccel = 1;
+static char noaccel = 0;
 static char mirror = 0;
 static int panel_yres __initdata = 0;
 static char force_dfp __initdata = 0;
@@ -1241,9 +1241,6 @@ static void radeon_engine_init (struct r
 	radeon_fifo_wait (1);
 	OUTREG(RB2D_DSTCACHE_MODE, 0);
 
-	/* XXX */
-	rinfo->pitch = ((rinfo->xres_virtual * (rinfo->bpp / 8) + 0x3f)) >> 6;
-
 	radeon_fifo_wait (1);
 	temp = INREG(DEFAULT_PITCH_OFFSET);
 	OUTREG(DEFAULT_PITCH_OFFSET, ((temp & 0xc0000000) | 
@@ -1782,6 +1779,7 @@ static int radeonfb_set_par (struct fb_i
 	int hsync_start, hsync_fudge, bytpp, hsync_wid, vsync_wid;
 	int primary_mon = PRIMARY_MONITOR(rinfo);
 	int depth = var_to_depth(mode);
+        int accel = (mode->accel_flags & FB_ACCELF_TEXT) != 0;
 
 	rinfo->xres = mode->xres;
 	rinfo->yres = mode->yres;
@@ -1878,7 +1876,15 @@ static int radeonfb_set_par (struct fb_i
 	newmode.crtc_v_sync_strt_wid = (((vSyncStart - 1) & 0xfff) |
 					 (vsync_wid << 16) | (v_sync_pol  << 23));
 
-	newmode.crtc_pitch = (mode->xres_virtual >> 3);
+	if (accel) {
+		/* We first calculate the engine pitch */
+		rinfo->pitch = ((mode->xres_virtual * ((mode->bits_per_pixel + 1) / 8) + 0x3f)
+ 				& ~(0x3f)) >> 6;
+
+		/* Then, re-multiply it to get the CRTC pitch */
+		newmode.crtc_pitch = (rinfo->pitch << 3) / ((mode->bits_per_pixel + 1) / 8);
+	} else
+		newmode.crtc_pitch = (mode->xres_virtual >> 3);
 	newmode.crtc_pitch |= (newmode.crtc_pitch << 16);
 
 #if defined(__BIG_ENDIAN)
@@ -2085,18 +2091,21 @@ static int radeonfb_set_par (struct fb_i
 	if (!rinfo->asleep) {
 		radeon_write_mode (rinfo, &newmode);
 		/* (re)initialize the engine */
-		if (!noaccel)
+		if (noaccel)
 			radeon_engine_init (rinfo);
 	
 	}
 	/* Update fix */
-        info->fix.line_length = rinfo->pitch*64;
+	if (accel)
+        	info->fix.line_length = rinfo->pitch*64;
+        else
+		info->fix.line_length = mode->xres_virtual * ((mode->bits_per_pixel + 1) / 8);
         info->fix.visual = rinfo->depth == 8 ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
 
 #ifdef CONFIG_BOOTX_TEXT
 	/* Update debug text engine */
 	btext_update_display(rinfo->fb_base_phys, mode->xres, mode->yres,
-			     rinfo->depth, rinfo->pitch*64);
+			     rinfo->depth, info->fix.line_length);
 #endif
 
 	return 0;
@@ -3022,11 +3031,6 @@ static int radeonfb_pci_register (struct
 	 */
 	radeon_save_state (rinfo, &rinfo->init_state);
 
-	if (!noaccel) {
-		/* initialize the engine */
-		radeon_engine_init (rinfo);
-	}
-
 	/* set all the vital stuff */
 	radeon_set_fbinfo (rinfo);
 
