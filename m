Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319271AbSHNTTC>; Wed, 14 Aug 2002 15:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319272AbSHNTTB>; Wed, 14 Aug 2002 15:19:01 -0400
Received: from p0465.as-l042.contactel.cz ([194.108.238.211]:8576 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S319271AbSHNTSy>;
	Wed, 14 Aug 2002 15:18:54 -0400
Date: Wed, 14 Aug 2002 21:23:27 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] broken cfb* support in the 2.5.31-bk
Message-ID: <20020814192327.GD37217@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, hello others,
  please apply this.

line_length, type and visual moved from display struct to the fb_info's fix
structure during last fbdev updates. Unfortunately generic code was not updated
together, so now every fbdev driver is broken.

						Thanks,
							Petr Vandrovec
							vandrove@vc.cvut.cz

diff -urdN linux/drivers/video/fbcon-cfb16.c linux/drivers/video/fbcon-cfb16.c
--- linux/drivers/video/fbcon-cfb16.c	2002-08-14 17:55:16.000000000 +0200
+++ linux/drivers/video/fbcon-cfb16.c	2002-08-14 17:59:19.000000000 +0200
@@ -36,7 +36,7 @@
 
 void fbcon_cfb16_setup(struct display *p)
 {
-    p->next_line = p->line_length ? p->line_length : p->var.xres_virtual<<1;
+    p->next_line = p->fb_info->fix.line_length ? p->fb_info->fix.line_length : p->var.xres_virtual<<1;
     p->next_plane = 0;
 }
 
diff -urdN linux/drivers/video/fbcon-cfb32.c linux/drivers/video/fbcon-cfb32.c
--- linux/drivers/video/fbcon-cfb32.c	2002-08-14 17:55:09.000000000 +0200
+++ linux/drivers/video/fbcon-cfb32.c	2002-08-14 17:59:19.000000000 +0200
@@ -25,7 +25,7 @@
 
 void fbcon_cfb32_setup(struct display *p)
 {
-    p->next_line = p->line_length ? p->line_length : p->var.xres_virtual<<2;
+    p->next_line = p->fb_info->fix.line_length ? p->fb_info->fix.line_length : p->var.xres_virtual<<2;
     p->next_plane = 0;
 }
 
diff -urdN linux/drivers/video/fbcon-cfb4.c linux/drivers/video/fbcon-cfb4.c
--- linux/drivers/video/fbcon-cfb4.c	2002-08-14 17:55:12.000000000 +0200
+++ linux/drivers/video/fbcon-cfb4.c	2002-08-14 17:59:19.000000000 +0200
@@ -50,7 +50,7 @@
 
 void fbcon_cfb4_setup(struct display *p)
 {
-    p->next_line = p->line_length ? p->line_length : p->var.xres_virtual>>1;
+    p->next_line = p->fb_info->fix.line_length ? p->fb_info->fix.line_length : p->var.xres_virtual>>1;
     p->next_plane = 0;
 }
 
diff -urdN linux/drivers/video/fbcon-cfb8.c linux/drivers/video/fbcon-cfb8.c
--- linux/drivers/video/fbcon-cfb8.c	2002-08-14 17:55:16.000000000 +0200
+++ linux/drivers/video/fbcon-cfb8.c	2002-08-14 17:59:19.000000000 +0200
@@ -41,7 +41,7 @@
 
 void fbcon_cfb8_setup(struct display *p)
 {
-    p->next_line = p->line_length ? p->line_length : p->var.xres_virtual;
+    p->next_line = p->fb_info->fix.line_length ? p->fb_info->fix.line_length : p->var.xres_virtual;
     p->next_plane = 0;
 }
 
diff -urdN linux/drivers/video/fbcon-vga-planes.c linux/drivers/video/fbcon-vga-planes.c
--- linux/drivers/video/fbcon-vga-planes.c	2002-08-14 17:55:16.000000000 +0200
+++ linux/drivers/video/fbcon-vga-planes.c	2002-08-14 17:59:19.000000000 +0200
@@ -119,9 +119,9 @@
 	height *= fontheight(p);
 
 	if (dy < sy || (dy == sy && dx < sx)) {
-		line_ofs = p->line_length - width;
-		dest = p->fb_info->screen_base + dx + dy * p->line_length;
-		src = p->fb_info->screen_base + sx + sy * p->line_length;
+		line_ofs = p->fb_info->fix.line_length - width;
+		dest = p->fb_info->screen_base + dx + dy * p->fb_info->fix.line_length;
+		src = p->fb_info->screen_base + sx + sy * p->fb_info->fix.line_length;
 		while (height--) {
 			for (x = 0; x < width; x++) {
 				readb(src);
@@ -133,9 +133,9 @@
 			dest += line_ofs;
 		}
 	} else {
-		line_ofs = p->line_length - width;
-		dest = p->fb_info->screen_base + dx + width + (dy + height - 1) * p->line_length;
-		src = p->fb_info->screen_base + sx + width + (sy + height - 1) * p->line_length;
+		line_ofs = p->fb_info->fix.line_length - width;
+		dest = p->fb_info->screen_base + dx + width + (dy + height - 1) * p->fb_info->fix.line_length;
+		src = p->fb_info->screen_base + sx + width + (sy + height - 1) * p->fb_info->fix.line_length;
 		while (height--) {
 			for (x = 0; x < width; x++) {
 				dest--;
@@ -152,7 +152,7 @@
 void fbcon_vga_planes_clear(struct vc_data *conp, struct display *p, int sy, int sx,
 		   int height, int width)
 {
-	int line_ofs = p->line_length - width;
+	int line_ofs = p->fb_info->fix.line_length - width;
 	char *where;
 	int x;
 	
@@ -167,7 +167,7 @@
 	sy *= fontheight(p);
 	height *= fontheight(p);
 
-	where = p->fb_info->screen_base + sx + sy * p->line_length;
+	where = p->fb_info->screen_base + sx + sy * p->fb_info->fix.line_length;
 	while (height--) {
 		for (x = 0; x < width; x++) {
 			writeb(0, where);
@@ -184,7 +184,7 @@
 
 	int y;
 	u8 *cdat = p->fontdata + (c & p->charmask) * fontheight(p);
-	char *where = p->fb_info->screen_base + xx + yy * p->line_length * fontheight(p);
+	char *where = p->fb_info->screen_base + xx + yy * p->fb_info->fix.line_length * fontheight(p);
 
 	setmode(0);
 	setop(0);
@@ -193,13 +193,13 @@
 	selectmask();
 
 	setmask(0xff);
-	for (y = 0; y < fontheight(p); y++, where += p->line_length) 
+	for (y = 0; y < fontheight(p); y++, where += p->fb_info->fix.line_length) 
 		rmw(where);
 
-	where -= p->line_length * y;
+	where -= p->fb_info->fix.line_length * y;
 	setcolor(fg);
 	selectmask();
-	for (y = 0; y < fontheight(p); y++, where += p->line_length) 
+	for (y = 0; y < fontheight(p); y++, where += p->fb_info->fix.line_length) 
 		if (cdat[y]) {
 			setmask(cdat[y]);
 			rmw(where);
@@ -213,7 +213,7 @@
 
 	int y;
 	u8 *cdat = p->fontdata + (c & p->charmask) * fontheight(p);
-	char *where = p->fb_info->screen_base + xx + yy * p->line_length * fontheight(p);
+	char *where = p->fb_info->screen_base + xx + yy * p->fb_info->fix.line_length * fontheight(p);
 
 	setmode(2);
 	setop(0);
@@ -227,7 +227,7 @@
 	readb(where); /* fill latches */
 	setmode(3);
 	wmb();
-	for (y = 0; y < fontheight(p); y++, where += p->line_length) 
+	for (y = 0; y < fontheight(p); y++, where += p->fb_info->fix.line_length) 
 		writeb(cdat[y], where);
 	wmb();
 }
@@ -248,7 +248,7 @@
 	selectmask();
 
 	setmask(0xff);
-	where = p->fb_info->screen_base + xx + yy * p->line_length * fontheight(p);
+	where = p->fb_info->screen_base + xx + yy * p->fb_info->fix.line_length * fontheight(p);
 	writeb(bg, where);
 	rmb();
 	readb(where); /* fill latches */
@@ -263,9 +263,9 @@
 			outb(*cdat++, GRAPHICS_DATA_REG);	
 			wmb();
 			writeb(fg, where);
-			where += p->line_length;
+			where += p->fb_info->fix.line_length;
 		}
-		where += 1 - p->line_length * fontheight(p);
+		where += 1 - p->fb_info->fix.line_length * fontheight(p);
 	}
 	
 	wmb();
@@ -289,7 +289,7 @@
 	selectmask();
 
 	setmask(0xff);
-	where = p->fb_info->screen_base + xx + yy * p->line_length * fontheight(p);
+	where = p->fb_info->screen_base + xx + yy * p->fb_info->fix.line_length * fontheight(p);
 	writeb(bg, where);
 	rmb();
 	readb(where); /* fill latches */
@@ -302,9 +302,9 @@
 
 		for (y = 0; y < fontheight(p); y++, cdat++) {
 			writeb (*cdat, where);
-			where += p->line_length;
+			where += p->fb_info->fix.line_length;
 		}
-		where += 1 - p->line_length * fontheight(p);
+		where += 1 - p->fb_info->fix.line_length * fontheight(p);
 	}
 	
 	wmb();
@@ -312,7 +312,7 @@
 
 void fbcon_vga_planes_revc(struct display *p, int xx, int yy)
 {
-	char *where = p->fb_info->screen_base + xx + yy * p->line_length * fontheight(p);
+	char *where = p->fb_info->screen_base + xx + yy * p->fb_info->fix.line_length * fontheight(p);
 	int y;
 	
 	setmode(0);
@@ -324,7 +324,7 @@
 	setmask(0xff);
 	for (y = 0; y < fontheight(p); y++) {
 		rmw(where);
-		where += p->line_length;
+		where += p->fb_info->fix.line_length;
 	}
 }
 
diff -urdN linux/drivers/video/fbcon.c linux/drivers/video/fbcon.c
--- linux/drivers/video/fbcon.c	2002-08-14 17:55:08.000000000 +0200
+++ linux/drivers/video/fbcon.c	2002-08-14 17:59:19.000000000 +0200
@@ -2306,7 +2306,7 @@
 	}
 #endif
 #if defined(CONFIG_FBCON_CFB4)
-	if (depth == 4 && p->type == FB_TYPE_PACKED_PIXELS) {
+	if (depth == 4 && info->fix.type == FB_TYPE_PACKED_PIXELS) {
 		src = logo;
 		for( y1 = 0; y1 < LOGO_H; y1++) {
 			dst = fb + y1*line + x/2;
@@ -2320,7 +2320,7 @@
 	}
 #endif
 #if defined(CONFIG_FBCON_CFB8) || defined(CONFIG_FB_SBUS)
-	if (depth == 8 && p->type == FB_TYPE_PACKED_PIXELS) {
+	if (depth == 8 && info->fix.type == FB_TYPE_PACKED_PIXELS) {
 	    /* depth 8 or more, packed, with color registers */
 		
 	    src = logo;
@@ -2335,8 +2335,8 @@
 #if defined(CONFIG_FBCON_AFB) || defined(CONFIG_FBCON_ILBM) || \
     defined(CONFIG_FBCON_IPLAN2P2) || defined(CONFIG_FBCON_IPLAN2P4) || \
     defined(CONFIG_FBCON_IPLAN2P8)
-	if (depth >= 2 && (p->type == FB_TYPE_PLANES ||
-			   p->type == FB_TYPE_INTERLEAVED_PLANES)) {
+	if (depth >= 2 && (info->fix.type == FB_TYPE_PLANES ||
+			   info->fix.type == FB_TYPE_INTERLEAVED_PLANES)) {
 	    /* planes (normal or interleaved), with color registers */
 	    int bit;
 	    unsigned char val, mask;
@@ -2388,9 +2388,9 @@
 #if defined(CONFIG_FBCON_MFB) || defined(CONFIG_FBCON_AFB) || \
     defined(CONFIG_FBCON_ILBM) || defined(CONFIG_FBCON_HGA)
 
-	if (depth == 1 && (p->type == FB_TYPE_PACKED_PIXELS ||
-			   p->type == FB_TYPE_PLANES ||
-			   p->type == FB_TYPE_INTERLEAVED_PLANES)) {
+	if (depth == 1 && (p->fix.type == FB_TYPE_PACKED_PIXELS ||
+			   p->fix.type == FB_TYPE_PLANES ||
+			   p->fix.type == FB_TYPE_INTERLEAVED_PLANES)) {
 
 	    /* monochrome */
 	    unsigned char inverse = p->inverse || p->visual == FB_VISUAL_MONO01
@@ -2411,7 +2411,7 @@
 	}
 #endif
 #if defined(CONFIG_FBCON_VGA_PLANES)
-	if (depth == 4 && p->type == FB_TYPE_VGA_PLANES) {
+	if (depth == 4 && info->fix.type == FB_TYPE_VGA_PLANES) {
 		outb_p(1,0x3ce); outb_p(0xf,0x3cf);
 		outb_p(3,0x3ce); outb_p(0,0x3cf);
 		outb_p(5,0x3ce); outb_p(0,0x3cf);
