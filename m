Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbUJ3Ult@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbUJ3Ult (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 16:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbUJ3Uls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 16:41:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8881 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261243AbUJ3Ulp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 16:41:45 -0400
Date: Sat, 30 Oct 2004 21:41:44 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: parisc-linux@parisc-linux.org, linux-kernel@vger.kernel.org
Subject: [PATCH] stifb bugfixes against 2.6.10-rc1-bk9
Message-ID: <20041030204144.GK8958@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 - Fix "sti= parameter ignored by stifb" bug (Stuart Brady)
 - Fix the STI crash with HCRX-24 in 32bpp mode (Helge Deller)

diff -urpNX dontdiff linux-2.6.10-rc1-bk9/drivers/video/stifb.c parisc-2.6-bk/drivers/video/stifb.c
--- linux-2.6.10-rc1-bk9/drivers/video/stifb.c	Fri Oct 22 15:40:35 2004
+++ parisc-2.6-bk/drivers/video/stifb.c	Sat Oct 30 09:31:49 2004
@@ -112,6 +112,7 @@ struct stifb_info {
 	ngle_rom_t ngle_rom;
 	struct sti_struct *sti;
 	int deviceSpecificConfig;
+	u32 pseudo_palette[16];
 };
 
 static int __initdata bpp = 8;	/* parameter from modprobe */
@@ -1030,6 +1031,14 @@ stifb_setcolreg(u_int regno, u_int red, 
 				/* 0x100 is same as used in WRITE_IMAGE_COLOR() */
 		START_COLORMAPLOAD(fb, lutBltCtl.all);
 		SETUP_FB(fb);
+
+		/* info->var.bits_per_pixel == 32 */
+		if (regno < 16) 
+		  ((u32 *)(info->pseudo_palette))[regno] =
+			(red   << info->var.red.offset)   |
+			(green << info->var.green.offset) |
+			(blue  << info->var.blue.offset);
+
 	} else {
 		/* cleanup colormap hardware */
 		FINISH_IMAGE_COLORMAP_ACCESS(fb);
@@ -1327,6 +1336,7 @@ stifb_init_fb(struct sti_struct *sti, in
 	info->screen_base = (void*) REGION_BASE(fb,1);
 	info->flags = FBINFO_DEFAULT;
 	info->currcon = -1;
+	info->pseudo_palette = &fb->pseudo_palette;
 
 	/* This has to been done !!! */
 	fb_alloc_cmap(&info->cmap, 256, 0);
@@ -1383,6 +1393,7 @@ int __init
 stifb_init(void)
 {
 	struct sti_struct *sti;
+	struct sti_struct *def_sti;
 	int i;
 	
 #ifndef MODULE
@@ -1397,9 +1408,19 @@ stifb_init(void)
 		return -ENXIO;
 	}
 	
+	def_sti = sti_get_rom(0);
+	if (def_sti) {
+		for (i = 1; i < MAX_STI_ROMS; i++) {
+			sti = sti_get_rom(i);
+			if (sti == def_sti && bpp > 0)
+				stifb_force_bpp[i] = bpp;
+		}
+		stifb_init_fb(def_sti, stifb_force_bpp[i]);
+	}
+
 	for (i = 1; i < MAX_STI_ROMS; i++) {
 		sti = sti_get_rom(i);
-		if (!sti)
+		if (!sti || sti==def_sti)
 			break;
 		if (bpp > 0)
 			stifb_force_bpp[i] = bpp;

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
