Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTGOOAZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 10:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267874AbTGOOAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 10:00:24 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:58288 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261151AbTGOOAP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 10:00:15 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 15 Jul 2003 16:10:23 +0200
From: Gerd Knorr <kraxel@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Kernel List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: [patch] vesafb fix
Message-ID: <20030715141023.GA14133@bytesex.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 79C4 EE94 CC44 6DD4 58C6  3088 DBB7 EC73 8750 D2C4  [1024D/8750D2C4]
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

The patch below fixes some vesafb issues.  Changes:

 * fixed struct screen_info in tty.h to use portable types.
   "unsigned long" for 32bit values doesn't work on hammer
   machines ...
 * limited the framebuffer memory used by vesafb to 16 MB.
   This avoids that vesafb's ioremap() eats plenty of kernel
   address space for no real benefit if the gfx card has very
   much memory (some have 128 MB or more, ia32 has 128 MB address
   space for vmalloc and ioremap ...).
 * mtrr is enabled by default.  That should improve the vesafb
   performance alot.  Also added a option to disable mtrr.

please apply,

  Gerd

--- linux-2.6.0-test1/drivers/video/vesafb.c.fix	2003-07-15 09:59:34.000000000 +0200
+++ linux-2.6.0-test1/drivers/video/vesafb.c	2003-07-15 10:49:41.924647592 +0200
@@ -51,7 +51,7 @@
 static u32 pseudo_palette[17];
 
 static int             inverse   = 0;
-static int             mtrr      = 0;
+static int             mtrr      = 1;
 
 static int             pmi_setpal = 0;	/* pmi for palette changes ??? */
 static int             ypan       = 0;  /* 0..nothing, 1..ypan, 2..ywrap */
@@ -208,6 +208,8 @@
 			pmi_setpal=1;
 		else if (! strcmp(this_opt, "mtrr"))
 			mtrr=1;
+		else if (! strcmp(this_opt, "nomtrr"))
+			mtrr=0;
 	}
 	return 0;
 }
@@ -231,6 +233,12 @@
 	vesafb_fix.visual   = (vesafb_defined.bits_per_pixel == 8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 
+	/* limit framebuffer size to 16 MB.  Otherwise we'll eat tons of
+	 * kernel address space for nothing if the gfx card has alot of
+	 * memory (>= 128 MB isn't uncommon these days ...) */
+	if (vesafb_fix.smem_len > 16 * 1024 * 1024)
+		vesafb_fix.smem_len = 16 * 1024 * 1024;
+
 #ifndef __i386__
 	screen_info.vesapm_seg = 0;
 #endif
--- linux-2.6.0-test1/include/linux/tty.h.fix	2003-07-15 10:24:11.000000000 +0200
+++ linux-2.6.0-test1/include/linux/tty.h	2003-07-15 10:26:35.000000000 +0200
@@ -57,40 +57,40 @@
  */
 
 struct screen_info {
-	unsigned char  orig_x;			/* 0x00 */
-	unsigned char  orig_y;			/* 0x01 */
-	unsigned short dontuse1;		/* 0x02 -- EXT_MEM_K sits here */
-	unsigned short orig_video_page;		/* 0x04 */
-	unsigned char  orig_video_mode;		/* 0x06 */
-	unsigned char  orig_video_cols;		/* 0x07 */
-	unsigned short unused2;			/* 0x08 */
-	unsigned short orig_video_ega_bx;	/* 0x0a */
-	unsigned short unused3;			/* 0x0c */
-	unsigned char  orig_video_lines;	/* 0x0e */
-	unsigned char  orig_video_isVGA;	/* 0x0f */
-	unsigned short orig_video_points;	/* 0x10 */
+	u8  orig_x;		/* 0x00 */
+	u8  orig_y;		/* 0x01 */
+	u16 dontuse1;		/* 0x02 -- EXT_MEM_K sits here */
+	u16 orig_video_page;	/* 0x04 */
+	u8  orig_video_mode;	/* 0x06 */
+	u8  orig_video_cols;	/* 0x07 */
+	u16 unused2;		/* 0x08 */
+	u16 orig_video_ega_bx;	/* 0x0a */
+	u16 unused3;		/* 0x0c */
+	u8  orig_video_lines;	/* 0x0e */
+	u8  orig_video_isVGA;	/* 0x0f */
+	u16 orig_video_points;	/* 0x10 */
 
 	/* VESA graphic mode -- linear frame buffer */
-	unsigned short lfb_width;		/* 0x12 */
-	unsigned short lfb_height;		/* 0x14 */
-	unsigned short lfb_depth;		/* 0x16 */
-	unsigned long  lfb_base;		/* 0x18 */
-	unsigned long  lfb_size;		/* 0x1c */
-	unsigned short dontuse2, dontuse3;	/* 0x20 -- CL_MAGIC and CL_OFFSET here */
-	unsigned short lfb_linelength;		/* 0x24 */
-	unsigned char  red_size;		/* 0x26 */
-	unsigned char  red_pos;			/* 0x27 */
-	unsigned char  green_size;		/* 0x28 */
-	unsigned char  green_pos;		/* 0x29 */
-	unsigned char  blue_size;		/* 0x2a */
-	unsigned char  blue_pos;		/* 0x2b */
-	unsigned char  rsvd_size;		/* 0x2c */
-	unsigned char  rsvd_pos;		/* 0x2d */
-	unsigned short vesapm_seg;		/* 0x2e */
-	unsigned short vesapm_off;		/* 0x30 */
-	unsigned short pages;			/* 0x32 */
-	unsigned short vesa_attributes;		/* 0x34 */
-						/* 0x36 -- 0x3f reserved for future expansion */
+	u16 lfb_width;		/* 0x12 */
+	u16 lfb_height;		/* 0x14 */
+	u16 lfb_depth;		/* 0x16 */
+	u32 lfb_base;		/* 0x18 */
+	u32 lfb_size;		/* 0x1c */
+	u16 dontuse2, dontuse3;	/* 0x20 -- CL_MAGIC and CL_OFFSET here */
+	u16 lfb_linelength;	/* 0x24 */
+	u8  red_size;		/* 0x26 */
+	u8  red_pos;		/* 0x27 */
+	u8  green_size;		/* 0x28 */
+	u8  green_pos;		/* 0x29 */
+	u8  blue_size;		/* 0x2a */
+	u8  blue_pos;		/* 0x2b */
+	u8  rsvd_size;		/* 0x2c */
+	u8  rsvd_pos;		/* 0x2d */
+	u16 vesapm_seg;		/* 0x2e */
+	u16 vesapm_off;		/* 0x30 */
+	u16 pages;		/* 0x32 */
+	u16 vesa_attributes;	/* 0x34 */
+				/* 0x36 -- 0x3f reserved for future expansion */
 };
 
 extern struct screen_info screen_info;
