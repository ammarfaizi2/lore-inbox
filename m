Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266514AbSLJCro>; Mon, 9 Dec 2002 21:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266520AbSLJCro>; Mon, 9 Dec 2002 21:47:44 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:34211 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266514AbSLJCrh>; Mon, 9 Dec 2002 21:47:37 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] ATI Rage 128 Pro (aty128fb) acceleration fix
Date: Tue, 10 Dec 2002 03:54:11 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Ani Joshi <ajoshi@shell.unixbox.com>
MIME-Version: 1.0
Message-Id: <200212100346.58670.m.c.p@wolk-project.de>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_BQUVIZWHP9YNKMMLHLI8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_BQUVIZWHP9YNKMMLHLI8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcelo, Hi Ani,

this bug (marc.theaimsgroup.com/?l=3Dlinux-fbdev-devel&m=3D10297746150432=
2&w=3D2) is=20
still not fixed in latest -BK 2.4.21.

I had the same errors as mentioned in that email. After that patch applie=
d,=20
problems are gone and all is working very well.

Patch credits go to Sergey Vlasov.

This fix has been in WOLK for ages.

ciao, Marc
--------------Boundary-00=_BQUVIZWHP9YNKMMLHLI8
Content-Type: text/x-diff;
  charset="us-ascii";
  name="aty128fb-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="aty128fb-fix.patch"

--- linux/drivers/video/aty128fb.c.aty128fb_fix	Sat Jun  1 14:51:15 2002
+++ linux/drivers/video/aty128fb.c	Sun Jun  2 11:11:03 2002
@@ -2599,6 +2599,15 @@
         return;
     }
 
+    if (srcx < dstx) {
+	srcx += width - 1;
+	dstx += width - 1;
+    }
+    if (srcy < dsty) {
+	srcy += height - 1;
+	dsty += height - 1;
+    }
+
     wait_for_fifo(2, info);
     save_dp_datatype = aty_ld_le32(DP_DATATYPE);
     save_dp_cntl     = aty_ld_le32(DP_CNTL);
@@ -2606,7 +2615,9 @@
     wait_for_fifo(6, info);
     aty_st_le32(SRC_Y_X, (srcy << 16) | srcx);
     aty_st_le32(DP_MIX, ROP3_SRCCOPY | DP_SRC_RECT);
-    aty_st_le32(DP_CNTL, DST_X_LEFT_TO_RIGHT | DST_Y_TOP_TO_BOTTOM);
+    aty_st_le32(DP_CNTL,
+		((srcx >= dstx) ? DST_X_LEFT_TO_RIGHT : 0) |
+		((srcy >= dsty) ? DST_Y_TOP_TO_BOTTOM : 0));
     aty_st_le32(DP_DATATYPE, save_dp_datatype | dstval | SRC_DSTCOLOR);
 
     aty_st_le32(DST_Y_X, (dsty << 16) | dstx);
@@ -2641,6 +2652,18 @@
 
 
 #ifdef FBCON_HAS_CFB8
+static void fbcon_aty8_clear(struct vc_data *conp, struct display *p,
+			     int sy, int sx, int height, int width)
+{
+    struct fb_info_aty128 *fb = (struct fb_info_aty128 *)(p->fb_info);
+
+    if (fb->blitter_may_be_busy)
+        wait_for_idle(fb);
+
+    fbcon_cfb8_clear(conp, p, sy, sx, height, width);
+}
+
+
 static void fbcon_aty8_putc(struct vc_data *conp, struct display *p,
                             int c, int yy, int xx)
 {
@@ -2666,6 +2689,17 @@
 }
 
 
+static void fbcon_aty8_revc(struct display *p, int xx, int yy)
+{
+    struct fb_info_aty128 *fb = (struct fb_info_aty128 *)(p->fb_info);
+
+    if (fb->blitter_may_be_busy)
+        wait_for_idle(fb);
+
+    fbcon_cfb8_revc(p, xx, yy);
+}
+
+
 static void fbcon_aty8_clear_margins(struct vc_data *conp,
                                      struct display *p, int bottom_only)
 {
@@ -2680,15 +2714,27 @@
 static struct display_switch fbcon_aty128_8 = {
     setup:		fbcon_cfb8_setup,
     bmove:		fbcon_aty128_bmove,
-    clear:		fbcon_cfb8_clear,
+    clear:		fbcon_aty8_clear,
     putc:		fbcon_aty8_putc,
     putcs:		fbcon_aty8_putcs,
-    revc:		fbcon_cfb8_revc,
+    revc:		fbcon_aty8_revc,
     clear_margins:	fbcon_aty8_clear_margins,
     fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 #endif
 #ifdef FBCON_HAS_CFB16
+static void fbcon_aty16_clear(struct vc_data *conp, struct display *p,
+			      int sy, int sx, int height, int width)
+{
+    struct fb_info_aty128 *fb = (struct fb_info_aty128 *)(p->fb_info);
+
+    if (fb->blitter_may_be_busy)
+        wait_for_idle(fb);
+
+    fbcon_cfb16_clear(conp, p, sy, sx, height, width);
+}
+
+
 static void fbcon_aty16_putc(struct vc_data *conp, struct display *p,
                             int c, int yy, int xx)
 {
@@ -2714,6 +2760,17 @@
 }
 
 
+static void fbcon_aty16_revc(struct display *p, int xx, int yy)
+{
+    struct fb_info_aty128 *fb = (struct fb_info_aty128 *)(p->fb_info);
+
+    if (fb->blitter_may_be_busy)
+        wait_for_idle(fb);
+
+    fbcon_cfb16_revc(p, xx, yy);
+}
+
+
 static void fbcon_aty16_clear_margins(struct vc_data *conp,
                                      struct display *p, int bottom_only)
 {
@@ -2728,15 +2785,27 @@
 static struct display_switch fbcon_aty128_16 = {
     setup:		fbcon_cfb16_setup,
     bmove:		fbcon_aty128_bmove,
-    clear:		fbcon_cfb16_clear,
+    clear:		fbcon_aty16_clear,
     putc:		fbcon_aty16_putc,
     putcs:		fbcon_aty16_putcs,
-    revc:		fbcon_cfb16_revc,
+    revc:		fbcon_aty16_revc,
     clear_margins:	fbcon_aty16_clear_margins,
     fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 #endif
 #ifdef FBCON_HAS_CFB24
+static void fbcon_aty24_clear(struct vc_data *conp, struct display *p,
+			      int sy, int sx, int height, int width)
+{
+    struct fb_info_aty128 *fb = (struct fb_info_aty128 *)(p->fb_info);
+
+    if (fb->blitter_may_be_busy)
+        wait_for_idle(fb);
+
+    fbcon_cfb24_clear(conp, p, sy, sx, height, width);
+}
+
+
 static void fbcon_aty24_putc(struct vc_data *conp, struct display *p,
                             int c, int yy, int xx)
 {
@@ -2762,6 +2831,17 @@
 }
 
 
+static void fbcon_aty24_revc(struct display *p, int xx, int yy)
+{
+    struct fb_info_aty128 *fb = (struct fb_info_aty128 *)(p->fb_info);
+
+    if (fb->blitter_may_be_busy)
+        wait_for_idle(fb);
+
+    fbcon_cfb24_revc(p, xx, yy);
+}
+
+
 static void fbcon_aty24_clear_margins(struct vc_data *conp,
                                      struct display *p, int bottom_only)
 {
@@ -2776,15 +2856,27 @@
 static struct display_switch fbcon_aty128_24 = {
     setup:		fbcon_cfb24_setup,
     bmove:		fbcon_aty128_bmove,
-    clear:		fbcon_cfb24_clear,
+    clear:		fbcon_aty24_clear,
     putc:		fbcon_aty24_putc,
     putcs:		fbcon_aty24_putcs,
-    revc:		fbcon_cfb24_revc,
+    revc:		fbcon_aty24_revc,
     clear_margins:	fbcon_aty24_clear_margins,
     fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 #endif
 #ifdef FBCON_HAS_CFB32
+static void fbcon_aty32_clear(struct vc_data *conp, struct display *p,
+			      int sy, int sx, int height, int width)
+{
+    struct fb_info_aty128 *fb = (struct fb_info_aty128 *)(p->fb_info);
+
+    if (fb->blitter_may_be_busy)
+        wait_for_idle(fb);
+
+    fbcon_cfb32_clear(conp, p, sy, sx, height, width);
+}
+
+
 static void fbcon_aty32_putc(struct vc_data *conp, struct display *p,
                             int c, int yy, int xx)
 {
@@ -2810,6 +2902,17 @@
 }
 
 
+static void fbcon_aty32_revc(struct display *p, int xx, int yy)
+{
+    struct fb_info_aty128 *fb = (struct fb_info_aty128 *)(p->fb_info);
+
+    if (fb->blitter_may_be_busy)
+        wait_for_idle(fb);
+
+    fbcon_cfb32_revc(p, xx, yy);
+}
+
+
 static void fbcon_aty32_clear_margins(struct vc_data *conp,
                                      struct display *p, int bottom_only)
 {
@@ -2824,10 +2927,10 @@
 static struct display_switch fbcon_aty128_32 = {
     setup:		fbcon_cfb32_setup,
     bmove:		fbcon_aty128_bmove,
-    clear:		fbcon_cfb32_clear,
+    clear:		fbcon_aty32_clear,
     putc:		fbcon_aty32_putc,
     putcs:		fbcon_aty32_putcs,
-    revc:		fbcon_cfb32_revc,
+    revc:		fbcon_aty32_revc,
     clear_margins:	fbcon_aty32_clear_margins,
     fontwidthmask:	FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };

--------------Boundary-00=_BQUVIZWHP9YNKMMLHLI8--

