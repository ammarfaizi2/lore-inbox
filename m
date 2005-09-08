Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbVIHOgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbVIHOgE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 10:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVIHOgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 10:36:04 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:31836
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751369AbVIHOgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 10:36:03 -0400
Message-Id: <432068B7020000780002441E@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 16:37:11 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] constify font data
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartC0E2AE87.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartC0E2AE87.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

const-ify the font control structures and data, to make somewhat
better
guarantees that these are not modified anywhere in the kernel.
Specifically for a kernel debugger to share this information from the
normal kernel code, such a guarantee seems rather desirable.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/drivers/video/console/fbcon.c
2.6.13-fonts-const/drivers/video/console/fbcon.c
--- 2.6.13/drivers/video/console/fbcon.c	2005-08-29
01:41:01.000000000 +0200
+++ 2.6.13-fonts-const/drivers/video/console/fbcon.c	2005-09-05
09:20:08.000000000 +0200
@@ -736,7 +736,7 @@ static const char *fbcon_startup(void)
 	const char *display_desc = "frame buffer device";
 	struct display *p = &fb_display[fg_console];
 	struct vc_data *vc = vc_cons[fg_console].d;
-	struct font_desc *font = NULL;
+	const struct font_desc *font = NULL;
 	struct module *owner;
 	struct fb_info *info = NULL;
 	struct fbcon_ops *ops;
@@ -810,7 +810,7 @@ static const char *fbcon_startup(void)
 						info->var.yres);
 		vc->vc_font.width = font->width;
 		vc->vc_font.height = font->height;
-		vc->vc_font.data = p->fontdata = font->data;
+		vc->vc_font.data = (void *)(p->fontdata = font->data);
 		vc->vc_font.charcount = 256; /* FIXME  Need to support
more fonts */
 	}
 
@@ -921,7 +921,7 @@ static void fbcon_init(struct vc_data *v
 	   fb, copy the font from that console */
 	t = &fb_display[svc->vc_num];
 	if (!vc->vc_font.data) {
-		vc->vc_font.data = p->fontdata = t->fontdata;
+		vc->vc_font.data = (void *)(p->fontdata = t->fontdata);
 		vc->vc_font.width = (*default_mode)->vc_font.width;
 		vc->vc_font.height = (*default_mode)->vc_font.height;
 		p->userfont = t->userfont;
@@ -1168,7 +1168,7 @@ static void fbcon_set_disp(struct fb_inf
 		return;
 	t = &fb_display[svc->vc_num];
 	if (!vc->vc_font.data) {
-		vc->vc_font.data = p->fontdata = t->fontdata;
+		vc->vc_font.data = (void *)(p->fontdata = t->fontdata);
 		vc->vc_font.width = (*default_mode)->vc_font.width;
 		vc->vc_font.height = (*default_mode)->vc_font.height;
 		p->userfont = t->userfont;
@@ -2115,7 +2115,7 @@ static int fbcon_get_font(struct vc_data
 }
 
 static int fbcon_do_set_font(struct vc_data *vc, int w, int h,
-			     u8 * data, int userfont)
+			     const u8 * data, int userfont)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	struct display *p = &fb_display[vc->vc_num];
@@ -2133,7 +2133,7 @@ static int fbcon_do_set_font(struct vc_d
 		cnt = FNTCHARCNT(data);
 	else
 		cnt = 256;
-	vc->vc_font.data = p->fontdata = data;
+	vc->vc_font.data = (void *)(p->fontdata = data);
 	if ((p->userfont = userfont))
 		REFCOUNT(data)++;
 	vc->vc_font.width = w;
@@ -2290,7 +2290,7 @@ static int fbcon_set_font(struct vc_data
 		    tmp->vc_font.width == w &&
 		    !memcmp(fb_display[i].fontdata, new_data, size)) {
 			kfree(new_data - FONT_EXTRA_WORDS *
sizeof(int));
-			new_data = fb_display[i].fontdata;
+			new_data = (u8 *)fb_display[i].fontdata;
 			break;
 		}
 	}
@@ -2300,7 +2300,7 @@ static int fbcon_set_font(struct vc_data
 static int fbcon_set_def_font(struct vc_data *vc, struct console_font
*font, char *name)
 {
 	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
-	struct font_desc *f;
+	const struct font_desc *f;
 
 	if (!name)
 		f = get_default_font(info->var.xres, info->var.yres);
diff -Npru 2.6.13/drivers/video/console/fbcon.h
2.6.13-fonts-const/drivers/video/console/fbcon.h
--- 2.6.13/drivers/video/console/fbcon.h	2005-08-29
01:41:01.000000000 +0200
+++ 2.6.13-fonts-const/drivers/video/console/fbcon.h	2005-09-05
10:09:55.000000000 +0200
@@ -29,7 +29,7 @@ struct display {
     /* Filled in by the frame buffer device */
     u_short inverse;                /* != 0 text black on white as
default */
     /* Filled in by the low-level console driver */
-    u_char *fontdata;
+    const u_char *fontdata;
     int userfont;                   /* != 0 if fontdata kmalloc()ed
*/
     u_short scrollmode;             /* Scroll Method */
     short yscroll;                  /* Hardware scrolling */
diff -Npru 2.6.13/drivers/video/console/font_10x18.c
2.6.13-fonts-const/drivers/video/console/font_10x18.c
--- 2.6.13/drivers/video/console/font_10x18.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-fonts-const/drivers/video/console/font_10x18.c	2005-09-01
17:38:31.000000000 +0200
@@ -7,7 +7,7 @@
 
 #define FONTDATAMAX 9216
 
-static unsigned char fontdata_10x18[FONTDATAMAX] = {
+static const unsigned char fontdata_10x18[FONTDATAMAX] = {
 
 	/* 0 0x00 '^@' */
 	0x00, 0x00, /* 0000000000 */
@@ -5132,7 +5132,7 @@ static unsigned char fontdata_10x18[FONT
 };
 
 
-struct font_desc font_10x18 = {
+const struct font_desc font_10x18 = {
 	FONT10x18_IDX,
 	"10x18",
 	10,
diff -Npru 2.6.13/drivers/video/console/font_6x11.c
2.6.13-fonts-const/drivers/video/console/font_6x11.c
--- 2.6.13/drivers/video/console/font_6x11.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-fonts-const/drivers/video/console/font_6x11.c	2005-03-16
12:24:41.000000000 +0100
@@ -8,7 +8,7 @@
 
 #define FONTDATAMAX (11*256)
 
-static unsigned char fontdata_6x11[FONTDATAMAX] = {
+static const unsigned char fontdata_6x11[FONTDATAMAX] = {
 
 	/* 0 0x00 '^@' */
 	0x00, /* 00000000 */
@@ -3341,7 +3341,7 @@ static unsigned char fontdata_6x11[FONTD
 };
 
 
-struct font_desc font_vga_6x11 = {
+const struct font_desc font_vga_6x11 = {
 	VGA6x11_IDX,
 	"ProFont6x11",
 	6,
diff -Npru 2.6.13/drivers/video/console/font_7x14.c
2.6.13-fonts-const/drivers/video/console/font_7x14.c
--- 2.6.13/drivers/video/console/font_7x14.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-fonts-const/drivers/video/console/font_7x14.c	2005-09-01
17:38:42.000000000 +0200
@@ -7,7 +7,7 @@
 
 #define FONTDATAMAX 3584
 
-static unsigned char fontdata_7x14[FONTDATAMAX] = {
+static const unsigned char fontdata_7x14[FONTDATAMAX] = {
 
 	/* 0 0x00 '^@' */
 	0x00, /* 0000000 */
@@ -4108,7 +4108,7 @@ static unsigned char fontdata_7x14[FONTD
 };
 
 
-struct font_desc font_7x14 = {
+const struct font_desc font_7x14 = {
 	FONT7x14_IDX,
 	"7x14",
 	7,
diff -Npru 2.6.13/drivers/video/console/font_8x16.c
2.6.13-fonts-const/drivers/video/console/font_8x16.c
--- 2.6.13/drivers/video/console/font_8x16.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-fonts-const/drivers/video/console/font_8x16.c	2005-03-16
12:24:41.000000000 +0100
@@ -8,7 +8,7 @@
 
 #define FONTDATAMAX 4096
 
-static unsigned char fontdata_8x16[FONTDATAMAX] = {
+static const unsigned char fontdata_8x16[FONTDATAMAX] = {
 
 	/* 0 0x00 '^@' */
 	0x00, /* 00000000 */
@@ -4621,7 +4621,7 @@ static unsigned char fontdata_8x16[FONTD
 };
 
 
-struct font_desc font_vga_8x16 = {
+const struct font_desc font_vga_8x16 = {
 	VGA8x16_IDX,
 	"VGA8x16",
 	8,
diff -Npru 2.6.13/drivers/video/console/font_8x8.c
2.6.13-fonts-const/drivers/video/console/font_8x8.c
--- 2.6.13/drivers/video/console/font_8x8.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-fonts-const/drivers/video/console/font_8x8.c	2005-03-16
12:24:41.000000000 +0100
@@ -8,7 +8,7 @@
 
 #define FONTDATAMAX 2048
 
-static unsigned char fontdata_8x8[FONTDATAMAX] = {
+static const unsigned char fontdata_8x8[FONTDATAMAX] = {
 
 	/* 0 0x00 '^@' */
 	0x00, /* 00000000 */
@@ -2573,7 +2573,7 @@ static unsigned char fontdata_8x8[FONTDA
 };
 
 
-struct font_desc font_vga_8x8 = {
+const struct font_desc font_vga_8x8 = {
 	VGA8x8_IDX,
 	"VGA8x8",
 	8,
diff -Npru 2.6.13/drivers/video/console/font_acorn_8x8.c
2.6.13-fonts-const/drivers/video/console/font_acorn_8x8.c
--- 2.6.13/drivers/video/console/font_acorn_8x8.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-fonts-const/drivers/video/console/font_acorn_8x8.c	2005-03-16
12:24:41.000000000 +0100
@@ -3,7 +3,7 @@
 #include <linux/config.h>
 #include <linux/font.h>
 
-static unsigned char acorndata_8x8[] = {
+static const unsigned char acorndata_8x8[] = {
 /* 00 */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* ^@ */
 /* 01 */  0x7e, 0x81, 0xa5, 0x81, 0xbd, 0x99, 0x81, 0x7e, /* ^A */
 /* 02 */  0x7e, 0xff, 0xbd, 0xff, 0xc3, 0xe7, 0xff, 0x7e, /* ^B */
@@ -262,7 +262,7 @@ static unsigned char acorndata_8x8[] = {
 /* FF */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
 };
 
-struct font_desc font_acorn_8x8 = {
+const struct font_desc font_acorn_8x8 = {
 	ACORN8x8_IDX,
 	"Acorn8x8",
 	8,
diff -Npru 2.6.13/drivers/video/console/font_mini_4x6.c
2.6.13-fonts-const/drivers/video/console/font_mini_4x6.c
--- 2.6.13/drivers/video/console/font_mini_4x6.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-fonts-const/drivers/video/console/font_mini_4x6.c	2005-03-16
12:24:41.000000000 +0100
@@ -43,7 +43,7 @@ __END__;
 
 #define FONTDATAMAX 1536
 
-static unsigned char fontdata_mini_4x6[FONTDATAMAX] = {
+static const unsigned char fontdata_mini_4x6[FONTDATAMAX] = {
 
 	/*{*/
 	  	/*   Char 0: ' '  */
@@ -2147,7 +2147,7 @@ static unsigned char fontdata_mini_4x6[F
 	/*}*/
 };
 
-struct font_desc font_mini_4x6 = {
+const struct font_desc font_mini_4x6 = {
 	MINI4x6_IDX,
 	"MINI4x6",
 	4,
diff -Npru 2.6.13/drivers/video/console/font_pearl_8x8.c
2.6.13-fonts-const/drivers/video/console/font_pearl_8x8.c
--- 2.6.13/drivers/video/console/font_pearl_8x8.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-fonts-const/drivers/video/console/font_pearl_8x8.c	2005-03-16
12:24:41.000000000 +0100
@@ -13,7 +13,7 @@
 
 #define FONTDATAMAX 2048
 
-static unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
+static const unsigned char fontdata_pearl8x8[FONTDATAMAX] = {
 
    /* 0 0x00 '^@' */
    0x00, /* 00000000 */
@@ -2577,7 +2577,7 @@ static unsigned char fontdata_pearl8x8[F
 
 };
 
-struct font_desc font_pearl_8x8 = {
+const struct font_desc font_pearl_8x8 = {
 	PEARL8x8_IDX,
 	"PEARL8x8",
 	8,
diff -Npru 2.6.13/drivers/video/console/fonts.c
2.6.13-fonts-const/drivers/video/console/fonts.c
--- 2.6.13/drivers/video/console/fonts.c	2005-08-29
01:41:01.000000000 +0200
+++ 2.6.13-fonts-const/drivers/video/console/fonts.c	2005-09-01
11:32:11.000000000 +0200
@@ -23,7 +23,7 @@
 
 #define NO_FONTS
 
-static struct font_desc *fonts[] = {
+static const struct font_desc *fonts[] = {
 #ifdef CONFIG_FONT_8x8
 #undef NO_FONTS
     &font_vga_8x8,
@@ -84,7 +84,7 @@ static struct font_desc *fonts[] = {
  *
  */
 
-struct font_desc *find_font(char *name)
+const struct font_desc *find_font(const char *name)
 {
    unsigned int i;
 
@@ -108,10 +108,10 @@ struct font_desc *find_font(char *name)
  *
  */
 
-struct font_desc *get_default_font(int xres, int yres)
+const struct font_desc *get_default_font(int xres, int yres)
 {
     int i, c, cc;
-    struct font_desc *f, *g;
+    const struct font_desc *f, *g;
 
     g = NULL;
     cc = -10000;
@@ -138,7 +138,6 @@ struct font_desc *get_default_font(int x
     return g;
 }
 
-EXPORT_SYMBOL(fonts);
 EXPORT_SYMBOL(find_font);
 EXPORT_SYMBOL(get_default_font);
 
diff -Npru 2.6.13/drivers/video/console/font_sun12x22.c
2.6.13-fonts-const/drivers/video/console/font_sun12x22.c
--- 2.6.13/drivers/video/console/font_sun12x22.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-fonts-const/drivers/video/console/font_sun12x22.c	2005-09-01
11:32:11.000000000 +0200
@@ -2,7 +2,7 @@
 
 #define FONTDATAMAX 11264
 
-static unsigned char fontdata_sun12x22[FONTDATAMAX] = {
+static const unsigned char fontdata_sun12x22[FONTDATAMAX] = {
 
 	/* 0 0x00 '^@' */
 	0x00, 0x00, /* 000000000000 */
@@ -6151,7 +6151,7 @@ static unsigned char fontdata_sun12x22[F
 };
 
 
-struct font_desc font_sun_12x22 = {
+const struct font_desc font_sun_12x22 = {
 	SUN12x22_IDX,
 	"SUN12x22",
 	12,
diff -Npru 2.6.13/drivers/video/console/font_sun8x16.c
2.6.13-fonts-const/drivers/video/console/font_sun8x16.c
--- 2.6.13/drivers/video/console/font_sun8x16.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-fonts-const/drivers/video/console/font_sun8x16.c	2005-03-16
12:24:41.000000000 +0100
@@ -2,7 +2,7 @@
 
 #define FONTDATAMAX 4096
 
-static unsigned char fontdata_sun8x16[FONTDATAMAX] = {
+static const unsigned char fontdata_sun8x16[FONTDATAMAX] = {
 /* */
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
 /* */
0x00,0x00,0x7e,0x81,0xa5,0x81,0x81,0xbd,0x99,0x81,0x81,0x7e,0x00,0x00,0x00,0x00,
 /* */
0x00,0x00,0x7e,0xff,0xdb,0xff,0xff,0xc3,0xe7,0xff,0xff,0x7e,0x00,0x00,0x00,0x00,
@@ -261,7 +261,7 @@ static unsigned char fontdata_sun8x16[FO
 /* */
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
 };
 
-struct font_desc font_sun_8x16 = {
+const struct font_desc font_sun_8x16 = {
 	SUN8x16_IDX,
 	"SUN8x16",
 	8,
diff -Npru 2.6.13/include/linux/fb.h
2.6.13-fonts-const/include/linux/fb.h
--- 2.6.13/include/linux/fb.h	2005-08-29 01:41:01.000000000 +0200
+++ 2.6.13-fonts-const/include/linux/fb.h	2005-09-07
13:03:22.000000000 +0200
@@ -614,7 +614,7 @@ struct fb_tilemap {
 	__u32 height;               /* height of each tile in scanlines
*/
 	__u32 depth;                /* color depth of each tile */
 	__u32 length;               /* number of tiles in the map */
-	__u8  *data;                /* actual tile map: a bitmap array,
packed
+	const __u8 *data;           /* actual tile map: a bitmap array,
packed
 				       to the nearest byte */
 };
 
diff -Npru 2.6.13/include/linux/font.h
2.6.13-fonts-const/include/linux/font.h
--- 2.6.13/include/linux/font.h	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-fonts-const/include/linux/font.h	2005-09-01
17:37:28.000000000 +0200
@@ -15,9 +15,9 @@
 
 struct font_desc {
     int idx;
-    char *name;
+    const char *name;
     int width, height;
-    void *data;
+    const void *data;
     int pref;
 };
 
@@ -32,7 +32,7 @@ struct font_desc {
 #define ACORN8x8_IDX	8
 #define	MINI4x6_IDX	9
 
-extern struct font_desc	font_vga_8x8,
+extern const struct font_desc	font_vga_8x8,
 			font_vga_8x16,
 			font_pearl_8x8,
 			font_vga_6x11,
@@ -45,11 +45,11 @@ extern struct font_desc	font_vga_8x8,
 
 /* Find a font with a specific name */
 
-extern struct font_desc *find_font(char *name);
+extern const struct font_desc *find_font(const char *name);
 
 /* Get the default font for a specific screen size */
 
-extern struct font_desc *get_default_font(int xres, int yres);
+extern const struct font_desc *get_default_font(int xres, int yres);
 
 /* Max. length for the name of a predefined font */
 #define MAX_FONT_NAME	32


--=__PartC0E2AE87.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-fonts-const.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-fonts-const.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCmNvbnN0LWlmeSB0aGUgZm9udCBjb250cm9s
IHN0cnVjdHVyZXMgYW5kIGRhdGEsIHRvIG1ha2Ugc29tZXdoYXQgYmV0dGVyCmd1YXJhbnRlZXMg
dGhhdCB0aGVzZSBhcmUgbm90IG1vZGlmaWVkIGFueXdoZXJlIGluIHRoZSBrZXJuZWwuClNwZWNp
ZmljYWxseSBmb3IgYSBrZXJuZWwgZGVidWdnZXIgdG8gc2hhcmUgdGhpcyBpbmZvcm1hdGlvbiBm
cm9tIHRoZQpub3JtYWwga2VybmVsIGNvZGUsIHN1Y2ggYSBndWFyYW50ZWUgc2VlbXMgcmF0aGVy
IGRlc2lyYWJsZS4KClNpZ25lZC1vZmYtYnk6IEphbiBCZXVsaWNoIDxqYmV1bGljaEBub3ZlbGwu
Y29tPgoKZGlmZiAtTnBydSAyLjYuMTMvZHJpdmVycy92aWRlby9jb25zb2xlL2ZiY29uLmMgMi42
LjEzLWZvbnRzLWNvbnN0L2RyaXZlcnMvdmlkZW8vY29uc29sZS9mYmNvbi5jCi0tLSAyLjYuMTMv
ZHJpdmVycy92aWRlby9jb25zb2xlL2ZiY29uLmMJMjAwNS0wOC0yOSAwMTo0MTowMS4wMDAwMDAw
MDAgKzAyMDAKKysrIDIuNi4xMy1mb250cy1jb25zdC9kcml2ZXJzL3ZpZGVvL2NvbnNvbGUvZmJj
b24uYwkyMDA1LTA5LTA1IDA5OjIwOjA4LjAwMDAwMDAwMCArMDIwMApAQCAtNzM2LDcgKzczNiw3
IEBAIHN0YXRpYyBjb25zdCBjaGFyICpmYmNvbl9zdGFydHVwKHZvaWQpCiAJY29uc3QgY2hhciAq
ZGlzcGxheV9kZXNjID0gImZyYW1lIGJ1ZmZlciBkZXZpY2UiOwogCXN0cnVjdCBkaXNwbGF5ICpw
ID0gJmZiX2Rpc3BsYXlbZmdfY29uc29sZV07CiAJc3RydWN0IHZjX2RhdGEgKnZjID0gdmNfY29u
c1tmZ19jb25zb2xlXS5kOwotCXN0cnVjdCBmb250X2Rlc2MgKmZvbnQgPSBOVUxMOworCWNvbnN0
IHN0cnVjdCBmb250X2Rlc2MgKmZvbnQgPSBOVUxMOwogCXN0cnVjdCBtb2R1bGUgKm93bmVyOwog
CXN0cnVjdCBmYl9pbmZvICppbmZvID0gTlVMTDsKIAlzdHJ1Y3QgZmJjb25fb3BzICpvcHM7CkBA
IC04MTAsNyArODEwLDcgQEAgc3RhdGljIGNvbnN0IGNoYXIgKmZiY29uX3N0YXJ0dXAodm9pZCkK
IAkJCQkJCWluZm8tPnZhci55cmVzKTsKIAkJdmMtPnZjX2ZvbnQud2lkdGggPSBmb250LT53aWR0
aDsKIAkJdmMtPnZjX2ZvbnQuaGVpZ2h0ID0gZm9udC0+aGVpZ2h0OwotCQl2Yy0+dmNfZm9udC5k
YXRhID0gcC0+Zm9udGRhdGEgPSBmb250LT5kYXRhOworCQl2Yy0+dmNfZm9udC5kYXRhID0gKHZv
aWQgKikocC0+Zm9udGRhdGEgPSBmb250LT5kYXRhKTsKIAkJdmMtPnZjX2ZvbnQuY2hhcmNvdW50
ID0gMjU2OyAvKiBGSVhNRSAgTmVlZCB0byBzdXBwb3J0IG1vcmUgZm9udHMgKi8KIAl9CiAKQEAg
LTkyMSw3ICs5MjEsNyBAQCBzdGF0aWMgdm9pZCBmYmNvbl9pbml0KHN0cnVjdCB2Y19kYXRhICp2
CiAJICAgZmIsIGNvcHkgdGhlIGZvbnQgZnJvbSB0aGF0IGNvbnNvbGUgKi8KIAl0ID0gJmZiX2Rp
c3BsYXlbc3ZjLT52Y19udW1dOwogCWlmICghdmMtPnZjX2ZvbnQuZGF0YSkgewotCQl2Yy0+dmNf
Zm9udC5kYXRhID0gcC0+Zm9udGRhdGEgPSB0LT5mb250ZGF0YTsKKwkJdmMtPnZjX2ZvbnQuZGF0
YSA9ICh2b2lkICopKHAtPmZvbnRkYXRhID0gdC0+Zm9udGRhdGEpOwogCQl2Yy0+dmNfZm9udC53
aWR0aCA9ICgqZGVmYXVsdF9tb2RlKS0+dmNfZm9udC53aWR0aDsKIAkJdmMtPnZjX2ZvbnQuaGVp
Z2h0ID0gKCpkZWZhdWx0X21vZGUpLT52Y19mb250LmhlaWdodDsKIAkJcC0+dXNlcmZvbnQgPSB0
LT51c2VyZm9udDsKQEAgLTExNjgsNyArMTE2OCw3IEBAIHN0YXRpYyB2b2lkIGZiY29uX3NldF9k
aXNwKHN0cnVjdCBmYl9pbmYKIAkJcmV0dXJuOwogCXQgPSAmZmJfZGlzcGxheVtzdmMtPnZjX251
bV07CiAJaWYgKCF2Yy0+dmNfZm9udC5kYXRhKSB7Ci0JCXZjLT52Y19mb250LmRhdGEgPSBwLT5m
b250ZGF0YSA9IHQtPmZvbnRkYXRhOworCQl2Yy0+dmNfZm9udC5kYXRhID0gKHZvaWQgKikocC0+
Zm9udGRhdGEgPSB0LT5mb250ZGF0YSk7CiAJCXZjLT52Y19mb250LndpZHRoID0gKCpkZWZhdWx0
X21vZGUpLT52Y19mb250LndpZHRoOwogCQl2Yy0+dmNfZm9udC5oZWlnaHQgPSAoKmRlZmF1bHRf
bW9kZSktPnZjX2ZvbnQuaGVpZ2h0OwogCQlwLT51c2VyZm9udCA9IHQtPnVzZXJmb250OwpAQCAt
MjExNSw3ICsyMTE1LDcgQEAgc3RhdGljIGludCBmYmNvbl9nZXRfZm9udChzdHJ1Y3QgdmNfZGF0
YQogfQogCiBzdGF0aWMgaW50IGZiY29uX2RvX3NldF9mb250KHN0cnVjdCB2Y19kYXRhICp2Yywg
aW50IHcsIGludCBoLAotCQkJICAgICB1OCAqIGRhdGEsIGludCB1c2VyZm9udCkKKwkJCSAgICAg
Y29uc3QgdTggKiBkYXRhLCBpbnQgdXNlcmZvbnQpCiB7CiAJc3RydWN0IGZiX2luZm8gKmluZm8g
PSByZWdpc3RlcmVkX2ZiW2NvbjJmYl9tYXBbdmMtPnZjX251bV1dOwogCXN0cnVjdCBkaXNwbGF5
ICpwID0gJmZiX2Rpc3BsYXlbdmMtPnZjX251bV07CkBAIC0yMTMzLDcgKzIxMzMsNyBAQCBzdGF0
aWMgaW50IGZiY29uX2RvX3NldF9mb250KHN0cnVjdCB2Y19kCiAJCWNudCA9IEZOVENIQVJDTlQo
ZGF0YSk7CiAJZWxzZQogCQljbnQgPSAyNTY7Ci0JdmMtPnZjX2ZvbnQuZGF0YSA9IHAtPmZvbnRk
YXRhID0gZGF0YTsKKwl2Yy0+dmNfZm9udC5kYXRhID0gKHZvaWQgKikocC0+Zm9udGRhdGEgPSBk
YXRhKTsKIAlpZiAoKHAtPnVzZXJmb250ID0gdXNlcmZvbnQpKQogCQlSRUZDT1VOVChkYXRhKSsr
OwogCXZjLT52Y19mb250LndpZHRoID0gdzsKQEAgLTIyOTAsNyArMjI5MCw3IEBAIHN0YXRpYyBp
bnQgZmJjb25fc2V0X2ZvbnQoc3RydWN0IHZjX2RhdGEKIAkJICAgIHRtcC0+dmNfZm9udC53aWR0
aCA9PSB3ICYmCiAJCSAgICAhbWVtY21wKGZiX2Rpc3BsYXlbaV0uZm9udGRhdGEsIG5ld19kYXRh
LCBzaXplKSkgewogCQkJa2ZyZWUobmV3X2RhdGEgLSBGT05UX0VYVFJBX1dPUkRTICogc2l6ZW9m
KGludCkpOwotCQkJbmV3X2RhdGEgPSBmYl9kaXNwbGF5W2ldLmZvbnRkYXRhOworCQkJbmV3X2Rh
dGEgPSAodTggKilmYl9kaXNwbGF5W2ldLmZvbnRkYXRhOwogCQkJYnJlYWs7CiAJCX0KIAl9CkBA
IC0yMzAwLDcgKzIzMDAsNyBAQCBzdGF0aWMgaW50IGZiY29uX3NldF9mb250KHN0cnVjdCB2Y19k
YXRhCiBzdGF0aWMgaW50IGZiY29uX3NldF9kZWZfZm9udChzdHJ1Y3QgdmNfZGF0YSAqdmMsIHN0
cnVjdCBjb25zb2xlX2ZvbnQgKmZvbnQsIGNoYXIgKm5hbWUpCiB7CiAJc3RydWN0IGZiX2luZm8g
KmluZm8gPSByZWdpc3RlcmVkX2ZiW2NvbjJmYl9tYXBbdmMtPnZjX251bV1dOwotCXN0cnVjdCBm
b250X2Rlc2MgKmY7CisJY29uc3Qgc3RydWN0IGZvbnRfZGVzYyAqZjsKIAogCWlmICghbmFtZSkK
IAkJZiA9IGdldF9kZWZhdWx0X2ZvbnQoaW5mby0+dmFyLnhyZXMsIGluZm8tPnZhci55cmVzKTsK
ZGlmZiAtTnBydSAyLjYuMTMvZHJpdmVycy92aWRlby9jb25zb2xlL2ZiY29uLmggMi42LjEzLWZv
bnRzLWNvbnN0L2RyaXZlcnMvdmlkZW8vY29uc29sZS9mYmNvbi5oCi0tLSAyLjYuMTMvZHJpdmVy
cy92aWRlby9jb25zb2xlL2ZiY29uLmgJMjAwNS0wOC0yOSAwMTo0MTowMS4wMDAwMDAwMDAgKzAy
MDAKKysrIDIuNi4xMy1mb250cy1jb25zdC9kcml2ZXJzL3ZpZGVvL2NvbnNvbGUvZmJjb24uaAky
MDA1LTA5LTA1IDEwOjA5OjU1LjAwMDAwMDAwMCArMDIwMApAQCAtMjksNyArMjksNyBAQCBzdHJ1
Y3QgZGlzcGxheSB7CiAgICAgLyogRmlsbGVkIGluIGJ5IHRoZSBmcmFtZSBidWZmZXIgZGV2aWNl
ICovCiAgICAgdV9zaG9ydCBpbnZlcnNlOyAgICAgICAgICAgICAgICAvKiAhPSAwIHRleHQgYmxh
Y2sgb24gd2hpdGUgYXMgZGVmYXVsdCAqLwogICAgIC8qIEZpbGxlZCBpbiBieSB0aGUgbG93LWxl
dmVsIGNvbnNvbGUgZHJpdmVyICovCi0gICAgdV9jaGFyICpmb250ZGF0YTsKKyAgICBjb25zdCB1
X2NoYXIgKmZvbnRkYXRhOwogICAgIGludCB1c2VyZm9udDsgICAgICAgICAgICAgICAgICAgLyog
IT0gMCBpZiBmb250ZGF0YSBrbWFsbG9jKCllZCAqLwogICAgIHVfc2hvcnQgc2Nyb2xsbW9kZTsg
ICAgICAgICAgICAgLyogU2Nyb2xsIE1ldGhvZCAqLwogICAgIHNob3J0IHlzY3JvbGw7ICAgICAg
ICAgICAgICAgICAgLyogSGFyZHdhcmUgc2Nyb2xsaW5nICovCmRpZmYgLU5wcnUgMi42LjEzL2Ry
aXZlcnMvdmlkZW8vY29uc29sZS9mb250XzEweDE4LmMgMi42LjEzLWZvbnRzLWNvbnN0L2RyaXZl
cnMvdmlkZW8vY29uc29sZS9mb250XzEweDE4LmMKLS0tIDIuNi4xMy9kcml2ZXJzL3ZpZGVvL2Nv
bnNvbGUvZm9udF8xMHgxOC5jCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisr
KyAyLjYuMTMtZm9udHMtY29uc3QvZHJpdmVycy92aWRlby9jb25zb2xlL2ZvbnRfMTB4MTguYwky
MDA1LTA5LTAxIDE3OjM4OjMxLjAwMDAwMDAwMCArMDIwMApAQCAtNyw3ICs3LDcgQEAKIAogI2Rl
ZmluZSBGT05UREFUQU1BWCA5MjE2CiAKLXN0YXRpYyB1bnNpZ25lZCBjaGFyIGZvbnRkYXRhXzEw
eDE4W0ZPTlREQVRBTUFYXSA9IHsKK3N0YXRpYyBjb25zdCB1bnNpZ25lZCBjaGFyIGZvbnRkYXRh
XzEweDE4W0ZPTlREQVRBTUFYXSA9IHsKIAogCS8qIDAgMHgwMCAnXkAnICovCiAJMHgwMCwgMHgw
MCwgLyogMDAwMDAwMDAwMCAqLwpAQCAtNTEzMiw3ICs1MTMyLDcgQEAgc3RhdGljIHVuc2lnbmVk
IGNoYXIgZm9udGRhdGFfMTB4MThbRk9OVAogfTsKIAogCi1zdHJ1Y3QgZm9udF9kZXNjIGZvbnRf
MTB4MTggPSB7Citjb25zdCBzdHJ1Y3QgZm9udF9kZXNjIGZvbnRfMTB4MTggPSB7CiAJRk9OVDEw
eDE4X0lEWCwKIAkiMTB4MTgiLAogCTEwLApkaWZmIC1OcHJ1IDIuNi4xMy9kcml2ZXJzL3ZpZGVv
L2NvbnNvbGUvZm9udF82eDExLmMgMi42LjEzLWZvbnRzLWNvbnN0L2RyaXZlcnMvdmlkZW8vY29u
c29sZS9mb250XzZ4MTEuYwotLS0gMi42LjEzL2RyaXZlcnMvdmlkZW8vY29uc29sZS9mb250XzZ4
MTEuYwkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzLWZvbnRz
LWNvbnN0L2RyaXZlcnMvdmlkZW8vY29uc29sZS9mb250XzZ4MTEuYwkyMDA1LTAzLTE2IDEyOjI0
OjQxLjAwMDAwMDAwMCArMDEwMApAQCAtOCw3ICs4LDcgQEAKIAogI2RlZmluZSBGT05UREFUQU1B
WCAoMTEqMjU2KQogCi1zdGF0aWMgdW5zaWduZWQgY2hhciBmb250ZGF0YV82eDExW0ZPTlREQVRB
TUFYXSA9IHsKK3N0YXRpYyBjb25zdCB1bnNpZ25lZCBjaGFyIGZvbnRkYXRhXzZ4MTFbRk9OVERB
VEFNQVhdID0gewogCiAJLyogMCAweDAwICdeQCcgKi8KIAkweDAwLCAvKiAwMDAwMDAwMCAqLwpA
QCAtMzM0MSw3ICszMzQxLDcgQEAgc3RhdGljIHVuc2lnbmVkIGNoYXIgZm9udGRhdGFfNngxMVtG
T05URAogfTsKIAogCi1zdHJ1Y3QgZm9udF9kZXNjIGZvbnRfdmdhXzZ4MTEgPSB7Citjb25zdCBz
dHJ1Y3QgZm9udF9kZXNjIGZvbnRfdmdhXzZ4MTEgPSB7CiAJVkdBNngxMV9JRFgsCiAJIlByb0Zv
bnQ2eDExIiwKIAk2LApkaWZmIC1OcHJ1IDIuNi4xMy9kcml2ZXJzL3ZpZGVvL2NvbnNvbGUvZm9u
dF83eDE0LmMgMi42LjEzLWZvbnRzLWNvbnN0L2RyaXZlcnMvdmlkZW8vY29uc29sZS9mb250Xzd4
MTQuYwotLS0gMi42LjEzL2RyaXZlcnMvdmlkZW8vY29uc29sZS9mb250Xzd4MTQuYwkyMDA1LTA4
LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzLWZvbnRzLWNvbnN0L2RyaXZl
cnMvdmlkZW8vY29uc29sZS9mb250Xzd4MTQuYwkyMDA1LTA5LTAxIDE3OjM4OjQyLjAwMDAwMDAw
MCArMDIwMApAQCAtNyw3ICs3LDcgQEAKIAogI2RlZmluZSBGT05UREFUQU1BWCAzNTg0CiAKLXN0
YXRpYyB1bnNpZ25lZCBjaGFyIGZvbnRkYXRhXzd4MTRbRk9OVERBVEFNQVhdID0geworc3RhdGlj
IGNvbnN0IHVuc2lnbmVkIGNoYXIgZm9udGRhdGFfN3gxNFtGT05UREFUQU1BWF0gPSB7CiAKIAkv
KiAwIDB4MDAgJ15AJyAqLwogCTB4MDAsIC8qIDAwMDAwMDAgKi8KQEAgLTQxMDgsNyArNDEwOCw3
IEBAIHN0YXRpYyB1bnNpZ25lZCBjaGFyIGZvbnRkYXRhXzd4MTRbRk9OVEQKIH07CiAKIAotc3Ry
dWN0IGZvbnRfZGVzYyBmb250Xzd4MTQgPSB7Citjb25zdCBzdHJ1Y3QgZm9udF9kZXNjIGZvbnRf
N3gxNCA9IHsKIAlGT05UN3gxNF9JRFgsCiAJIjd4MTQiLAogCTcsCmRpZmYgLU5wcnUgMi42LjEz
L2RyaXZlcnMvdmlkZW8vY29uc29sZS9mb250Xzh4MTYuYyAyLjYuMTMtZm9udHMtY29uc3QvZHJp
dmVycy92aWRlby9jb25zb2xlL2ZvbnRfOHgxNi5jCi0tLSAyLjYuMTMvZHJpdmVycy92aWRlby9j
b25zb2xlL2ZvbnRfOHgxNi5jCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisr
KyAyLjYuMTMtZm9udHMtY29uc3QvZHJpdmVycy92aWRlby9jb25zb2xlL2ZvbnRfOHgxNi5jCTIw
MDUtMDMtMTYgMTI6MjQ6NDEuMDAwMDAwMDAwICswMTAwCkBAIC04LDcgKzgsNyBAQAogCiAjZGVm
aW5lIEZPTlREQVRBTUFYIDQwOTYKIAotc3RhdGljIHVuc2lnbmVkIGNoYXIgZm9udGRhdGFfOHgx
NltGT05UREFUQU1BWF0gPSB7CitzdGF0aWMgY29uc3QgdW5zaWduZWQgY2hhciBmb250ZGF0YV84
eDE2W0ZPTlREQVRBTUFYXSA9IHsKIAogCS8qIDAgMHgwMCAnXkAnICovCiAJMHgwMCwgLyogMDAw
MDAwMDAgKi8KQEAgLTQ2MjEsNyArNDYyMSw3IEBAIHN0YXRpYyB1bnNpZ25lZCBjaGFyIGZvbnRk
YXRhXzh4MTZbRk9OVEQKIH07CiAKIAotc3RydWN0IGZvbnRfZGVzYyBmb250X3ZnYV84eDE2ID0g
eworY29uc3Qgc3RydWN0IGZvbnRfZGVzYyBmb250X3ZnYV84eDE2ID0gewogCVZHQTh4MTZfSURY
LAogCSJWR0E4eDE2IiwKIAk4LApkaWZmIC1OcHJ1IDIuNi4xMy9kcml2ZXJzL3ZpZGVvL2NvbnNv
bGUvZm9udF84eDguYyAyLjYuMTMtZm9udHMtY29uc3QvZHJpdmVycy92aWRlby9jb25zb2xlL2Zv
bnRfOHg4LmMKLS0tIDIuNi4xMy9kcml2ZXJzL3ZpZGVvL2NvbnNvbGUvZm9udF84eDguYwkyMDA1
LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzLWZvbnRzLWNvbnN0L2Ry
aXZlcnMvdmlkZW8vY29uc29sZS9mb250Xzh4OC5jCTIwMDUtMDMtMTYgMTI6MjQ6NDEuMDAwMDAw
MDAwICswMTAwCkBAIC04LDcgKzgsNyBAQAogCiAjZGVmaW5lIEZPTlREQVRBTUFYIDIwNDgKIAot
c3RhdGljIHVuc2lnbmVkIGNoYXIgZm9udGRhdGFfOHg4W0ZPTlREQVRBTUFYXSA9IHsKK3N0YXRp
YyBjb25zdCB1bnNpZ25lZCBjaGFyIGZvbnRkYXRhXzh4OFtGT05UREFUQU1BWF0gPSB7CiAKIAkv
KiAwIDB4MDAgJ15AJyAqLwogCTB4MDAsIC8qIDAwMDAwMDAwICovCkBAIC0yNTczLDcgKzI1NzMs
NyBAQCBzdGF0aWMgdW5zaWduZWQgY2hhciBmb250ZGF0YV84eDhbRk9OVERBCiB9OwogCiAKLXN0
cnVjdCBmb250X2Rlc2MgZm9udF92Z2FfOHg4ID0geworY29uc3Qgc3RydWN0IGZvbnRfZGVzYyBm
b250X3ZnYV84eDggPSB7CiAJVkdBOHg4X0lEWCwKIAkiVkdBOHg4IiwKIAk4LApkaWZmIC1OcHJ1
IDIuNi4xMy9kcml2ZXJzL3ZpZGVvL2NvbnNvbGUvZm9udF9hY29ybl84eDguYyAyLjYuMTMtZm9u
dHMtY29uc3QvZHJpdmVycy92aWRlby9jb25zb2xlL2ZvbnRfYWNvcm5fOHg4LmMKLS0tIDIuNi4x
My9kcml2ZXJzL3ZpZGVvL2NvbnNvbGUvZm9udF9hY29ybl84eDguYwkyMDA1LTA4LTI5IDAxOjQx
OjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzLWZvbnRzLWNvbnN0L2RyaXZlcnMvdmlkZW8v
Y29uc29sZS9mb250X2Fjb3JuXzh4OC5jCTIwMDUtMDMtMTYgMTI6MjQ6NDEuMDAwMDAwMDAwICsw
MTAwCkBAIC0zLDcgKzMsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2NvbmZpZy5oPgogI2luY2x1ZGUg
PGxpbnV4L2ZvbnQuaD4KIAotc3RhdGljIHVuc2lnbmVkIGNoYXIgYWNvcm5kYXRhXzh4OFtdID0g
eworc3RhdGljIGNvbnN0IHVuc2lnbmVkIGNoYXIgYWNvcm5kYXRhXzh4OFtdID0gewogLyogMDAg
Ki8gIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDAsIDB4MDAsIC8qIF5A
ICovCiAvKiAwMSAqLyAgMHg3ZSwgMHg4MSwgMHhhNSwgMHg4MSwgMHhiZCwgMHg5OSwgMHg4MSwg
MHg3ZSwgLyogXkEgKi8KIC8qIDAyICovICAweDdlLCAweGZmLCAweGJkLCAweGZmLCAweGMzLCAw
eGU3LCAweGZmLCAweDdlLCAvKiBeQiAqLwpAQCAtMjYyLDcgKzI2Miw3IEBAIHN0YXRpYyB1bnNp
Z25lZCBjaGFyIGFjb3JuZGF0YV84eDhbXSA9IHsKIC8qIEZGICovICAweDAwLCAweDAwLCAweDAw
LCAweDAwLCAweDAwLCAweDAwLCAweDAwLCAweDAwCiB9OwogCi1zdHJ1Y3QgZm9udF9kZXNjIGZv
bnRfYWNvcm5fOHg4ID0geworY29uc3Qgc3RydWN0IGZvbnRfZGVzYyBmb250X2Fjb3JuXzh4OCA9
IHsKIAlBQ09STjh4OF9JRFgsCiAJIkFjb3JuOHg4IiwKIAk4LApkaWZmIC1OcHJ1IDIuNi4xMy9k
cml2ZXJzL3ZpZGVvL2NvbnNvbGUvZm9udF9taW5pXzR4Ni5jIDIuNi4xMy1mb250cy1jb25zdC9k
cml2ZXJzL3ZpZGVvL2NvbnNvbGUvZm9udF9taW5pXzR4Ni5jCi0tLSAyLjYuMTMvZHJpdmVycy92
aWRlby9jb25zb2xlL2ZvbnRfbWluaV80eDYuYwkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAw
MCArMDIwMAorKysgMi42LjEzLWZvbnRzLWNvbnN0L2RyaXZlcnMvdmlkZW8vY29uc29sZS9mb250
X21pbmlfNHg2LmMJMjAwNS0wMy0xNiAxMjoyNDo0MS4wMDAwMDAwMDAgKzAxMDAKQEAgLTQzLDcg
KzQzLDcgQEAgX19FTkRfXzsKIAogI2RlZmluZSBGT05UREFUQU1BWCAxNTM2CiAKLXN0YXRpYyB1
bnNpZ25lZCBjaGFyIGZvbnRkYXRhX21pbmlfNHg2W0ZPTlREQVRBTUFYXSA9IHsKK3N0YXRpYyBj
b25zdCB1bnNpZ25lZCBjaGFyIGZvbnRkYXRhX21pbmlfNHg2W0ZPTlREQVRBTUFYXSA9IHsKIAog
CS8qeyovCiAJICAJLyogICBDaGFyIDA6ICcgJyAgKi8KQEAgLTIxNDcsNyArMjE0Nyw3IEBAIHN0
YXRpYyB1bnNpZ25lZCBjaGFyIGZvbnRkYXRhX21pbmlfNHg2W0YKIAkvKn0qLwogfTsKIAotc3Ry
dWN0IGZvbnRfZGVzYyBmb250X21pbmlfNHg2ID0geworY29uc3Qgc3RydWN0IGZvbnRfZGVzYyBm
b250X21pbmlfNHg2ID0gewogCU1JTkk0eDZfSURYLAogCSJNSU5JNHg2IiwKIAk0LApkaWZmIC1O
cHJ1IDIuNi4xMy9kcml2ZXJzL3ZpZGVvL2NvbnNvbGUvZm9udF9wZWFybF84eDguYyAyLjYuMTMt
Zm9udHMtY29uc3QvZHJpdmVycy92aWRlby9jb25zb2xlL2ZvbnRfcGVhcmxfOHg4LmMKLS0tIDIu
Ni4xMy9kcml2ZXJzL3ZpZGVvL2NvbnNvbGUvZm9udF9wZWFybF84eDguYwkyMDA1LTA4LTI5IDAx
OjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzLWZvbnRzLWNvbnN0L2RyaXZlcnMvdmlk
ZW8vY29uc29sZS9mb250X3BlYXJsXzh4OC5jCTIwMDUtMDMtMTYgMTI6MjQ6NDEuMDAwMDAwMDAw
ICswMTAwCkBAIC0xMyw3ICsxMyw3IEBACiAKICNkZWZpbmUgRk9OVERBVEFNQVggMjA0OAogCi1z
dGF0aWMgdW5zaWduZWQgY2hhciBmb250ZGF0YV9wZWFybDh4OFtGT05UREFUQU1BWF0gPSB7Citz
dGF0aWMgY29uc3QgdW5zaWduZWQgY2hhciBmb250ZGF0YV9wZWFybDh4OFtGT05UREFUQU1BWF0g
PSB7CiAKICAgIC8qIDAgMHgwMCAnXkAnICovCiAgICAweDAwLCAvKiAwMDAwMDAwMCAqLwpAQCAt
MjU3Nyw3ICsyNTc3LDcgQEAgc3RhdGljIHVuc2lnbmVkIGNoYXIgZm9udGRhdGFfcGVhcmw4eDhb
RgogCiB9OwogCi1zdHJ1Y3QgZm9udF9kZXNjIGZvbnRfcGVhcmxfOHg4ID0geworY29uc3Qgc3Ry
dWN0IGZvbnRfZGVzYyBmb250X3BlYXJsXzh4OCA9IHsKIAlQRUFSTDh4OF9JRFgsCiAJIlBFQVJM
OHg4IiwKIAk4LApkaWZmIC1OcHJ1IDIuNi4xMy9kcml2ZXJzL3ZpZGVvL2NvbnNvbGUvZm9udHMu
YyAyLjYuMTMtZm9udHMtY29uc3QvZHJpdmVycy92aWRlby9jb25zb2xlL2ZvbnRzLmMKLS0tIDIu
Ni4xMy9kcml2ZXJzL3ZpZGVvL2NvbnNvbGUvZm9udHMuYwkyMDA1LTA4LTI5IDAxOjQxOjAxLjAw
MDAwMDAwMCArMDIwMAorKysgMi42LjEzLWZvbnRzLWNvbnN0L2RyaXZlcnMvdmlkZW8vY29uc29s
ZS9mb250cy5jCTIwMDUtMDktMDEgMTE6MzI6MTEuMDAwMDAwMDAwICswMjAwCkBAIC0yMyw3ICsy
Myw3IEBACiAKICNkZWZpbmUgTk9fRk9OVFMKIAotc3RhdGljIHN0cnVjdCBmb250X2Rlc2MgKmZv
bnRzW10gPSB7CitzdGF0aWMgY29uc3Qgc3RydWN0IGZvbnRfZGVzYyAqZm9udHNbXSA9IHsKICNp
ZmRlZiBDT05GSUdfRk9OVF84eDgKICN1bmRlZiBOT19GT05UUwogICAgICZmb250X3ZnYV84eDgs
CkBAIC04NCw3ICs4NCw3IEBAIHN0YXRpYyBzdHJ1Y3QgZm9udF9kZXNjICpmb250c1tdID0gewog
ICoKICAqLwogCi1zdHJ1Y3QgZm9udF9kZXNjICpmaW5kX2ZvbnQoY2hhciAqbmFtZSkKK2NvbnN0
IHN0cnVjdCBmb250X2Rlc2MgKmZpbmRfZm9udChjb25zdCBjaGFyICpuYW1lKQogewogICAgdW5z
aWduZWQgaW50IGk7CiAKQEAgLTEwOCwxMCArMTA4LDEwIEBAIHN0cnVjdCBmb250X2Rlc2MgKmZp
bmRfZm9udChjaGFyICpuYW1lKQogICoKICAqLwogCi1zdHJ1Y3QgZm9udF9kZXNjICpnZXRfZGVm
YXVsdF9mb250KGludCB4cmVzLCBpbnQgeXJlcykKK2NvbnN0IHN0cnVjdCBmb250X2Rlc2MgKmdl
dF9kZWZhdWx0X2ZvbnQoaW50IHhyZXMsIGludCB5cmVzKQogewogICAgIGludCBpLCBjLCBjYzsK
LSAgICBzdHJ1Y3QgZm9udF9kZXNjICpmLCAqZzsKKyAgICBjb25zdCBzdHJ1Y3QgZm9udF9kZXNj
ICpmLCAqZzsKIAogICAgIGcgPSBOVUxMOwogICAgIGNjID0gLTEwMDAwOwpAQCAtMTM4LDcgKzEz
OCw2IEBAIHN0cnVjdCBmb250X2Rlc2MgKmdldF9kZWZhdWx0X2ZvbnQoaW50IHgKICAgICByZXR1
cm4gZzsKIH0KIAotRVhQT1JUX1NZTUJPTChmb250cyk7CiBFWFBPUlRfU1lNQk9MKGZpbmRfZm9u
dCk7CiBFWFBPUlRfU1lNQk9MKGdldF9kZWZhdWx0X2ZvbnQpOwogCmRpZmYgLU5wcnUgMi42LjEz
L2RyaXZlcnMvdmlkZW8vY29uc29sZS9mb250X3N1bjEyeDIyLmMgMi42LjEzLWZvbnRzLWNvbnN0
L2RyaXZlcnMvdmlkZW8vY29uc29sZS9mb250X3N1bjEyeDIyLmMKLS0tIDIuNi4xMy9kcml2ZXJz
L3ZpZGVvL2NvbnNvbGUvZm9udF9zdW4xMngyMi5jCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAw
MDAwICswMjAwCisrKyAyLjYuMTMtZm9udHMtY29uc3QvZHJpdmVycy92aWRlby9jb25zb2xlL2Zv
bnRfc3VuMTJ4MjIuYwkyMDA1LTA5LTAxIDExOjMyOjExLjAwMDAwMDAwMCArMDIwMApAQCAtMiw3
ICsyLDcgQEAKIAogI2RlZmluZSBGT05UREFUQU1BWCAxMTI2NAogCi1zdGF0aWMgdW5zaWduZWQg
Y2hhciBmb250ZGF0YV9zdW4xMngyMltGT05UREFUQU1BWF0gPSB7CitzdGF0aWMgY29uc3QgdW5z
aWduZWQgY2hhciBmb250ZGF0YV9zdW4xMngyMltGT05UREFUQU1BWF0gPSB7CiAKIAkvKiAwIDB4
MDAgJ15AJyAqLwogCTB4MDAsIDB4MDAsIC8qIDAwMDAwMDAwMDAwMCAqLwpAQCAtNjE1MSw3ICs2
MTUxLDcgQEAgc3RhdGljIHVuc2lnbmVkIGNoYXIgZm9udGRhdGFfc3VuMTJ4MjJbRgogfTsKIAog
Ci1zdHJ1Y3QgZm9udF9kZXNjIGZvbnRfc3VuXzEyeDIyID0geworY29uc3Qgc3RydWN0IGZvbnRf
ZGVzYyBmb250X3N1bl8xMngyMiA9IHsKIAlTVU4xMngyMl9JRFgsCiAJIlNVTjEyeDIyIiwKIAkx
MiwKZGlmZiAtTnBydSAyLjYuMTMvZHJpdmVycy92aWRlby9jb25zb2xlL2ZvbnRfc3VuOHgxNi5j
IDIuNi4xMy1mb250cy1jb25zdC9kcml2ZXJzL3ZpZGVvL2NvbnNvbGUvZm9udF9zdW44eDE2LmMK
LS0tIDIuNi4xMy9kcml2ZXJzL3ZpZGVvL2NvbnNvbGUvZm9udF9zdW44eDE2LmMJMjAwNS0wOC0y
OSAwMTo0MTowMS4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xMy1mb250cy1jb25zdC9kcml2ZXJz
L3ZpZGVvL2NvbnNvbGUvZm9udF9zdW44eDE2LmMJMjAwNS0wMy0xNiAxMjoyNDo0MS4wMDAwMDAw
MDAgKzAxMDAKQEAgLTIsNyArMiw3IEBACiAKICNkZWZpbmUgRk9OVERBVEFNQVggNDA5NgogCi1z
dGF0aWMgdW5zaWduZWQgY2hhciBmb250ZGF0YV9zdW44eDE2W0ZPTlREQVRBTUFYXSA9IHsKK3N0
YXRpYyBjb25zdCB1bnNpZ25lZCBjaGFyIGZvbnRkYXRhX3N1bjh4MTZbRk9OVERBVEFNQVhdID0g
ewogLyogKi8gMHgwMCwweDAwLDB4MDAsMHgwMCwweDAwLDB4MDAsMHgwMCwweDAwLDB4MDAsMHgw
MCwweDAwLDB4MDAsMHgwMCwweDAwLDB4MDAsMHgwMCwKIC8qICovIDB4MDAsMHgwMCwweDdlLDB4
ODEsMHhhNSwweDgxLDB4ODEsMHhiZCwweDk5LDB4ODEsMHg4MSwweDdlLDB4MDAsMHgwMCwweDAw
LDB4MDAsCiAvKiAqLyAweDAwLDB4MDAsMHg3ZSwweGZmLDB4ZGIsMHhmZiwweGZmLDB4YzMsMHhl
NywweGZmLDB4ZmYsMHg3ZSwweDAwLDB4MDAsMHgwMCwweDAwLApAQCAtMjYxLDcgKzI2MSw3IEBA
IHN0YXRpYyB1bnNpZ25lZCBjaGFyIGZvbnRkYXRhX3N1bjh4MTZbRk8KIC8qICovIDB4MDAsMHgw
MCwweDAwLDB4MDAsMHgwMCwweDAwLDB4MDAsMHgwMCwweDAwLDB4MDAsMHgwMCwweDAwLDB4MDAs
MHgwMCwweDAwLDB4MDAsCiB9OwogCi1zdHJ1Y3QgZm9udF9kZXNjIGZvbnRfc3VuXzh4MTYgPSB7
Citjb25zdCBzdHJ1Y3QgZm9udF9kZXNjIGZvbnRfc3VuXzh4MTYgPSB7CiAJU1VOOHgxNl9JRFgs
CiAJIlNVTjh4MTYiLAogCTgsCmRpZmYgLU5wcnUgMi42LjEzL2luY2x1ZGUvbGludXgvZmIuaCAy
LjYuMTMtZm9udHMtY29uc3QvaW5jbHVkZS9saW51eC9mYi5oCi0tLSAyLjYuMTMvaW5jbHVkZS9s
aW51eC9mYi5oCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMt
Zm9udHMtY29uc3QvaW5jbHVkZS9saW51eC9mYi5oCTIwMDUtMDktMDcgMTM6MDM6MjIuMDAwMDAw
MDAwICswMjAwCkBAIC02MTQsNyArNjE0LDcgQEAgc3RydWN0IGZiX3RpbGVtYXAgewogCV9fdTMy
IGhlaWdodDsgICAgICAgICAgICAgICAvKiBoZWlnaHQgb2YgZWFjaCB0aWxlIGluIHNjYW5saW5l
cyAqLwogCV9fdTMyIGRlcHRoOyAgICAgICAgICAgICAgICAvKiBjb2xvciBkZXB0aCBvZiBlYWNo
IHRpbGUgKi8KIAlfX3UzMiBsZW5ndGg7ICAgICAgICAgICAgICAgLyogbnVtYmVyIG9mIHRpbGVz
IGluIHRoZSBtYXAgKi8KLQlfX3U4ICAqZGF0YTsgICAgICAgICAgICAgICAgLyogYWN0dWFsIHRp
bGUgbWFwOiBhIGJpdG1hcCBhcnJheSwgcGFja2VkCisJY29uc3QgX191OCAqZGF0YTsgICAgICAg
ICAgIC8qIGFjdHVhbCB0aWxlIG1hcDogYSBiaXRtYXAgYXJyYXksIHBhY2tlZAogCQkJCSAgICAg
ICB0byB0aGUgbmVhcmVzdCBieXRlICovCiB9OwogCmRpZmYgLU5wcnUgMi42LjEzL2luY2x1ZGUv
bGludXgvZm9udC5oIDIuNi4xMy1mb250cy1jb25zdC9pbmNsdWRlL2xpbnV4L2ZvbnQuaAotLS0g
Mi42LjEzL2luY2x1ZGUvbGludXgvZm9udC5oCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAwMDAw
ICswMjAwCisrKyAyLjYuMTMtZm9udHMtY29uc3QvaW5jbHVkZS9saW51eC9mb250LmgJMjAwNS0w
OS0wMSAxNzozNzoyOC4wMDAwMDAwMDAgKzAyMDAKQEAgLTE1LDkgKzE1LDkgQEAKIAogc3RydWN0
IGZvbnRfZGVzYyB7CiAgICAgaW50IGlkeDsKLSAgICBjaGFyICpuYW1lOworICAgIGNvbnN0IGNo
YXIgKm5hbWU7CiAgICAgaW50IHdpZHRoLCBoZWlnaHQ7Ci0gICAgdm9pZCAqZGF0YTsKKyAgICBj
b25zdCB2b2lkICpkYXRhOwogICAgIGludCBwcmVmOwogfTsKIApAQCAtMzIsNyArMzIsNyBAQCBz
dHJ1Y3QgZm9udF9kZXNjIHsKICNkZWZpbmUgQUNPUk44eDhfSURYCTgKICNkZWZpbmUJTUlOSTR4
Nl9JRFgJOQogCi1leHRlcm4gc3RydWN0IGZvbnRfZGVzYwlmb250X3ZnYV84eDgsCitleHRlcm4g
Y29uc3Qgc3RydWN0IGZvbnRfZGVzYwlmb250X3ZnYV84eDgsCiAJCQlmb250X3ZnYV84eDE2LAog
CQkJZm9udF9wZWFybF84eDgsCiAJCQlmb250X3ZnYV82eDExLApAQCAtNDUsMTEgKzQ1LDExIEBA
IGV4dGVybiBzdHJ1Y3QgZm9udF9kZXNjCWZvbnRfdmdhXzh4OCwKIAogLyogRmluZCBhIGZvbnQg
d2l0aCBhIHNwZWNpZmljIG5hbWUgKi8KIAotZXh0ZXJuIHN0cnVjdCBmb250X2Rlc2MgKmZpbmRf
Zm9udChjaGFyICpuYW1lKTsKK2V4dGVybiBjb25zdCBzdHJ1Y3QgZm9udF9kZXNjICpmaW5kX2Zv
bnQoY29uc3QgY2hhciAqbmFtZSk7CiAKIC8qIEdldCB0aGUgZGVmYXVsdCBmb250IGZvciBhIHNw
ZWNpZmljIHNjcmVlbiBzaXplICovCiAKLWV4dGVybiBzdHJ1Y3QgZm9udF9kZXNjICpnZXRfZGVm
YXVsdF9mb250KGludCB4cmVzLCBpbnQgeXJlcyk7CitleHRlcm4gY29uc3Qgc3RydWN0IGZvbnRf
ZGVzYyAqZ2V0X2RlZmF1bHRfZm9udChpbnQgeHJlcywgaW50IHlyZXMpOwogCiAvKiBNYXguIGxl
bmd0aCBmb3IgdGhlIG5hbWUgb2YgYSBwcmVkZWZpbmVkIGZvbnQgKi8KICNkZWZpbmUgTUFYX0ZP
TlRfTkFNRQkzMgo=

--=__PartC0E2AE87.0__=--
