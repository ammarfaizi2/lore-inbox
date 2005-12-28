Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbVL1Vtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbVL1Vtf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 16:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbVL1Vtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 16:49:35 -0500
Received: from quark.didntduck.org ([69.55.226.66]:36039 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S964926AbVL1Vte
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 16:49:34 -0500
Message-ID: <43B30894.20904@didntduck.org>
Date: Wed, 28 Dec 2005 16:50:12 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Split out screen_info from tty.h
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it possible for boot code to use screen_info without dragging in
all of tty.h.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---
commit 24f834330f9b3b9d07e3d632a55a98fc33e54dad
tree 6a75aad4b5e927cb455badaf7b676e552d9570fc
parent e60e288822de60b794544c76c20f9dd2c9c5c22c
author Brian Gerst <bgerst@didntduck.org> Wed, 28 Dec 2005 15:45:44 -0500
committer Brian Gerst <bgerst@didntduck.org> Wed, 28 Dec 2005 15:45:44 -0500

 arch/i386/boot/compressed/misc.c        |    2 -
 arch/x86_64/boot/compressed/misc.c      |    2 -
 arch/x86_64/boot/compressed/miscsetup.h |   39 ----------------
 include/linux/screen_info.h             |   77 +++++++++++++++++++++++++++++++
 include/linux/tty.h                     |   72 -----------------------------
 5 files changed, 80 insertions(+), 112 deletions(-)

diff --git a/arch/i386/boot/compressed/misc.c b/arch/i386/boot/compressed/misc.c
index 82a807f..f19f3a7 100644
--- a/arch/i386/boot/compressed/misc.c
+++ b/arch/i386/boot/compressed/misc.c
@@ -11,7 +11,7 @@
 
 #include <linux/linkage.h>
 #include <linux/vmalloc.h>
-#include <linux/tty.h>
+#include <linux/screen_info.h>
 #include <asm/io.h>
 #include <asm/page.h>
 
diff --git a/arch/x86_64/boot/compressed/misc.c b/arch/x86_64/boot/compressed/misc.c
index 0e10fd8..cf4b88c 100644
--- a/arch/x86_64/boot/compressed/misc.c
+++ b/arch/x86_64/boot/compressed/misc.c
@@ -9,7 +9,7 @@
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
  */
 
-#include "miscsetup.h"
+#include <linux/screen_info.h>
 #include <asm/io.h>
 #include <asm/page.h>
 
diff --git a/arch/x86_64/boot/compressed/miscsetup.h b/arch/x86_64/boot/compressed/miscsetup.h
deleted file mode 100644
index bb16205..0000000
--- a/arch/x86_64/boot/compressed/miscsetup.h
+++ /dev/null
@@ -1,39 +0,0 @@
-#define NULL 0
-//typedef unsigned int size_t; 
-
-
-struct screen_info {
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
-
-	/* VESA graphic mode -- linear frame buffer */
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
-						/* 0x34 -- 0x3f reserved for future expansion */
-};
diff --git a/include/linux/screen_info.h b/include/linux/screen_info.h
new file mode 100644
index 0000000..76850b7
--- /dev/null
+++ b/include/linux/screen_info.h
@@ -0,0 +1,77 @@
+#ifndef _SCREEN_INFO_H
+#define _SCREEN_INFO_H
+
+#include <linux/types.h>
+
+/*
+ * These are set up by the setup-routine at boot-time:
+ */
+
+struct screen_info {
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
+
+	/* VESA graphic mode -- linear frame buffer */
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
+	u32  capabilities;      /* 0x36 */
+				/* 0x3a -- 0x3f reserved for future expansion */
+};
+
+extern struct screen_info screen_info;
+
+#define ORIG_X			(screen_info.orig_x)
+#define ORIG_Y			(screen_info.orig_y)
+#define ORIG_VIDEO_MODE		(screen_info.orig_video_mode)
+#define ORIG_VIDEO_COLS 	(screen_info.orig_video_cols)
+#define ORIG_VIDEO_EGA_BX	(screen_info.orig_video_ega_bx)
+#define ORIG_VIDEO_LINES	(screen_info.orig_video_lines)
+#define ORIG_VIDEO_ISVGA	(screen_info.orig_video_isVGA)
+#define ORIG_VIDEO_POINTS       (screen_info.orig_video_points)
+
+#define VIDEO_TYPE_MDA		0x10	/* Monochrome Text Display	*/
+#define VIDEO_TYPE_CGA		0x11	/* CGA Display 			*/
+#define VIDEO_TYPE_EGAM		0x20	/* EGA/VGA in Monochrome Mode	*/
+#define VIDEO_TYPE_EGAC		0x21	/* EGA in Color Mode		*/
+#define VIDEO_TYPE_VGAC		0x22	/* VGA+ in Color Mode		*/
+#define VIDEO_TYPE_VLFB		0x23	/* VESA VGA in graphic mode	*/
+
+#define VIDEO_TYPE_PICA_S3	0x30	/* ACER PICA-61 local S3 video	*/
+#define VIDEO_TYPE_MIPS_G364	0x31    /* MIPS Magnum 4000 G364 video  */
+#define VIDEO_TYPE_SGI          0x33    /* Various SGI graphics hardware */
+
+#define VIDEO_TYPE_TGAC		0x40	/* DEC TGA */
+
+#define VIDEO_TYPE_SUN          0x50    /* Sun frame buffer. */
+#define VIDEO_TYPE_SUNPCI       0x51    /* Sun PCI based frame buffer. */
+
+#define VIDEO_TYPE_PMAC		0x60	/* PowerMacintosh frame buffer. */
+
+#endif /* _SCREEN_INFO_H */
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 1267f88..5744970 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -23,6 +23,7 @@
 #include <linux/workqueue.h>
 #include <linux/tty_driver.h>
 #include <linux/tty_ldisc.h>
+#include <linux/screen_info.h>
 
 #include <asm/system.h>
 
@@ -37,77 +38,6 @@
 #define NR_LDISCS		16
 
 /*
- * These are set up by the setup-routine at boot-time:
- */
-
-struct screen_info {
-	u8  orig_x;		/* 0x00 */
-	u8  orig_y;		/* 0x01 */
-	u16 dontuse1;		/* 0x02 -- EXT_MEM_K sits here */
-	u16 orig_video_page;	/* 0x04 */
-	u8  orig_video_mode;	/* 0x06 */
-	u8  orig_video_cols;	/* 0x07 */
-	u16 unused2;		/* 0x08 */
-	u16 orig_video_ega_bx;	/* 0x0a */
-	u16 unused3;		/* 0x0c */
-	u8  orig_video_lines;	/* 0x0e */
-	u8  orig_video_isVGA;	/* 0x0f */
-	u16 orig_video_points;	/* 0x10 */
-
-	/* VESA graphic mode -- linear frame buffer */
-	u16 lfb_width;		/* 0x12 */
-	u16 lfb_height;		/* 0x14 */
-	u16 lfb_depth;		/* 0x16 */
-	u32 lfb_base;		/* 0x18 */
-	u32 lfb_size;		/* 0x1c */
-	u16 dontuse2, dontuse3;	/* 0x20 -- CL_MAGIC and CL_OFFSET here */
-	u16 lfb_linelength;	/* 0x24 */
-	u8  red_size;		/* 0x26 */
-	u8  red_pos;		/* 0x27 */
-	u8  green_size;		/* 0x28 */
-	u8  green_pos;		/* 0x29 */
-	u8  blue_size;		/* 0x2a */
-	u8  blue_pos;		/* 0x2b */
-	u8  rsvd_size;		/* 0x2c */
-	u8  rsvd_pos;		/* 0x2d */
-	u16 vesapm_seg;		/* 0x2e */
-	u16 vesapm_off;		/* 0x30 */
-	u16 pages;		/* 0x32 */
-	u16 vesa_attributes;	/* 0x34 */
-	u32  capabilities;      /* 0x36 */
-				/* 0x3a -- 0x3f reserved for future expansion */
-};
-
-extern struct screen_info screen_info;
-
-#define ORIG_X			(screen_info.orig_x)
-#define ORIG_Y			(screen_info.orig_y)
-#define ORIG_VIDEO_MODE		(screen_info.orig_video_mode)
-#define ORIG_VIDEO_COLS 	(screen_info.orig_video_cols)
-#define ORIG_VIDEO_EGA_BX	(screen_info.orig_video_ega_bx)
-#define ORIG_VIDEO_LINES	(screen_info.orig_video_lines)
-#define ORIG_VIDEO_ISVGA	(screen_info.orig_video_isVGA)
-#define ORIG_VIDEO_POINTS       (screen_info.orig_video_points)
-
-#define VIDEO_TYPE_MDA		0x10	/* Monochrome Text Display	*/
-#define VIDEO_TYPE_CGA		0x11	/* CGA Display 			*/
-#define VIDEO_TYPE_EGAM		0x20	/* EGA/VGA in Monochrome Mode	*/
-#define VIDEO_TYPE_EGAC		0x21	/* EGA in Color Mode		*/
-#define VIDEO_TYPE_VGAC		0x22	/* VGA+ in Color Mode		*/
-#define VIDEO_TYPE_VLFB		0x23	/* VESA VGA in graphic mode	*/
-
-#define VIDEO_TYPE_PICA_S3	0x30	/* ACER PICA-61 local S3 video	*/
-#define VIDEO_TYPE_MIPS_G364	0x31    /* MIPS Magnum 4000 G364 video  */
-#define VIDEO_TYPE_SGI          0x33    /* Various SGI graphics hardware */
-
-#define VIDEO_TYPE_TGAC		0x40	/* DEC TGA */
-
-#define VIDEO_TYPE_SUN          0x50    /* Sun frame buffer. */
-#define VIDEO_TYPE_SUNPCI       0x51    /* Sun PCI based frame buffer. */
-
-#define VIDEO_TYPE_PMAC		0x60	/* PowerMacintosh frame buffer. */
-
-/*
  * This character is the same as _POSIX_VDISABLE: it cannot be used as
  * a c_cc[] character, but indicates that a particular special character
  * isn't in use (eg VINTR has no character etc)


