Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270263AbRHSI5C>; Sun, 19 Aug 2001 04:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270267AbRHSI4y>; Sun, 19 Aug 2001 04:56:54 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:40097 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S270263AbRHSI4n>; Sun, 19 Aug 2001 04:56:43 -0400
Date: Sun, 19 Aug 2001 01:56:56 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: mj@ucw.cz, linux-kernel@vger.kernel.org,
        linux-fbdev-devel@lists.sourceforge.net
Subject: Patch, please TEST: linux-2.4.9 console font modularization
Message-ID: <20010819015656.A369@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Here is my first pass at modularizing the framebuffer console
fonts.  The benefits of this change are primarily for users who
compile more than just the default console font in their kernel:

	o Saves unswappable kernel memory.

	o Enables smaller boot floppies (more drivers) and boot partitions.

	o At least after I get font unloading working, it will make
	  it feasible to upgrade console font modules without
	  rebooting.

	With this change, you do not have to have all of the console
fonts that you would ever want to use without rebooting locked into
kernel memory.  Instead, you can just load the fonts that to use
and still have the possibility to load other fonts later if you want.

	One big deficiency with this code is that it will
not allow you to unload a font once it has been used, because I
have not added any calls to my new release_font() routine.  However,
this is still no worse than the status quo.

	fbcon_find_font will now attempt to use modprobe to load
a font that it fails to find; however, since the font names do not
currently match the module names, you will need to edit your
/etc/modules.conf file to make this work.  Also, this functionality
does not currently extend to fbcon_get_default_font, since it does
not take a font name, although I could add a request_module("default_font")
for users to define in /etc/modules.conf if they want, if nothing
smarter can be done.

	All that I know about behavior of this patch right now is that
it does not break my VGA console (which does not use these fonts, to
the best of my knowledge).  Since this new code causes fonts to
initialized by module_init() declarations, and those routines are
called rather late in kernel initialization, I suspect that there
may be order of initialization problem with that, and would
appreciate confirmation.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="font.diff"

--- linux-2.4.9/include/video/font.h	Tue Jan 19 10:47:48 1999
+++ linux/include/video/font.h	Sun Aug 19 00:52:36 2001
@@ -12,6 +12,8 @@
 #define _VIDEO_FONT_H
 
 #include <linux/types.h>
+#include <linux/module.h>
+#include <linux/init.h>
 
 struct fbcon_font_desc {
     int idx;
@@ -19,6 +21,8 @@
     int width, height;
     void *data;
     int pref;
+    struct module *module;
+    struct fbcon_font_desc *next;
 };
 
 #define VGA8x8_IDX	0
@@ -37,6 +41,9 @@
 				font_sun_12x22,
 				font_acorn_8x8;
 
+extern void fbcon_register_font(struct fbcon_font_desc *font);
+extern void fbcon_unregister_font(struct fbcon_font_desc *font);
+
 /* Find a font with a specific name */
 
 extern struct fbcon_font_desc *fbcon_find_font(char *name);
@@ -47,5 +54,17 @@
 
 /* Max. length for the name of a predefined font */
 #define MAX_FONT_NAME	32
+
+#define DECLARE_FONT_MODULE(font)			\
+	static int __init font_init(void) {		\
+		(font)->module = THIS_MODULE;		\
+		fbcon_register_font(font);		\
+		return 0;				\
+	}						\
+	static void __exit font_exit(void) {		\
+		fbcon_unregister_font(font);		\
+	}						\
+	module_init(font_init);				\
+	module_exit(font_exit);				\
 
 #endif /* _VIDEO_FONT_H */
diff -r -u linux-2.4.9/drivers/video/Config.in linux/drivers/video/Config.in
--- linux-2.4.9/drivers/video/Config.in	Tue Jul 31 14:43:29 2001
+++ linux/drivers/video/Config.in	Sun Aug 19 01:04:32 2001
@@ -7,7 +7,7 @@
 
 bool 'Support for frame buffer devices (EXPERIMENTAL)' CONFIG_FB
 
-if [ "$CONFIG_FB" = "y" ]; then
+if [ "$CONFIG_FB" != "n" ]; then
    define_bool CONFIG_DUMMY_CONSOLE y
    if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
       if [ "$CONFIG_PCI" = "y" ]; then
@@ -101,12 +101,15 @@
          bool '    CGsix (GX,TurboGX) support' CONFIG_FB_CGSIX
       fi
    fi
-   tristate '  NEC PowerVR 2 display support' CONFIG_FB_PVR2
+   dep_tristate '  NEC PowerVR 2 display support' CONFIG_FB_PVR2 $CONFIG_SH_DREAMCAST
    dep_bool '    Debug pvr2fb' CONFIG_FB_PVR2_DEBUG $CONFIG_FB_PVR2
-   bool '  Epson 1355 framebuffer support' CONFIG_FB_E1355
-   if [ "$CONFIG_FB_E1355" = "y" ]; then
-      hex '    Register Base Address' CONFIG_E1355_REG_BASE a8000000
-      hex '    Framebuffer Base Address' CONFIG_E1355_FB_BASE a8200000
+
+   if [ "$CONFIG_SUPERH" = "y" ]; then
+      bool '  Epson 1355 framebuffer support' CONFIG_FB_E1355
+      if [ "$CONFIG_FB_E1355" = "y" ]; then
+         hex '    Register Base Address' CONFIG_E1355_REG_BASE a8000000
+         hex '    Framebuffer Base Address' CONFIG_E1355_FB_BASE a8200000
+      fi
    fi
    if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
       if [ "$CONFIG_PCI" != "n" ]; then
@@ -188,10 +191,12 @@
       tristate '    32 bpp packed pixels support' CONFIG_FBCON_CFB32
       tristate '    Amiga bitplanes support' CONFIG_FBCON_AFB
       tristate '    Amiga interleaved bitplanes support' CONFIG_FBCON_ILBM
-      tristate '    Atari interleaved bitplanes (2 planes) support' CONFIG_FBCON_IPLAN2P2
-      tristate '    Atari interleaved bitplanes (4 planes) support' CONFIG_FBCON_IPLAN2P4
-      tristate '    Atari interleaved bitplanes (8 planes) support' CONFIG_FBCON_IPLAN2P8
-#      tristate '    Atari interleaved bitplanes (16 planes) support' CONFIG_FBCON_IPLAN2P16
+      if [ "$CONFIG_ATARI" = "y" ]; then
+        tristate '    Atari interleaved bitplanes (2 planes) support' CONFIG_FBCON_IPLAN2P2
+        tristate '    Atari interleaved bitplanes (4 planes) support' CONFIG_FBCON_IPLAN2P4
+        tristate '    Atari interleaved bitplanes (8 planes) support' CONFIG_FBCON_IPLAN2P8
+#       tristate '    Atari interleaved bitplanes (16 planes) support' CONFIG_FBCON_IPLAN2P16
+      fi	
       tristate '    Mac variable bpp packed pixels support' CONFIG_FBCON_MAC
       tristate '    VGA 16-color planar support' CONFIG_FBCON_VGA_PLANES
       tristate '    VGA characters/attributes support' CONFIG_FBCON_VGA
@@ -376,43 +381,43 @@
    if [ "$ARCH" = "sparc" -o "$ARCH" = "sparc64" ]; then
       bool '  Sparc console 8x16 font' CONFIG_FONT_SUN8x16
       if [ "$CONFIG_FBCON_FONTWIDTH8_ONLY" = "n" ]; then
-	 bool '  Sparc console 12x22 font (not supported by all drivers)' CONFIG_FONT_SUN12x22
+	 tristate '  Sparc console 12x22 font (not supported by all drivers)' CONFIG_FONT_SUN12x22
       fi
       bool '  Select other fonts' CONFIG_FBCON_FONTS
       if [ "$CONFIG_FBCON_FONTS" = "y" ]; then
-	 bool '    VGA 8x8 font' CONFIG_FONT_8x8
-	 bool '    VGA 8x16 font' CONFIG_FONT_8x16
+	 tristate '    VGA 8x8 font' CONFIG_FONT_8x8
+	 tristate '    VGA 8x16 font' CONFIG_FONT_8x16
 	 if [ "$CONFIG_FBCON_FONTWIDTH8_ONLY" = "n" ]; then
-	    bool '    Mac console 6x11 font (not supported by all drivers)' CONFIG_FONT_6x11
+	    tristate '    Mac console 6x11 font (not supported by all drivers)' CONFIG_FONT_6x11
 	 fi
-	 bool '    Pearl (old m68k) console 8x8 font' CONFIG_FONT_PEARL_8x8
-	 bool '    Acorn console 8x8 font' CONFIG_FONT_ACORN_8x8
+	 tristate '    Pearl (old m68k) console 8x8 font' CONFIG_FONT_PEARL_8x8
+	 tristate '    Acorn console 8x8 font' CONFIG_FONT_ACORN_8x8
       fi
    else
       bool '  Select compiled-in fonts' CONFIG_FBCON_FONTS
       if [ "$CONFIG_FBCON_FONTS" = "y" ]; then
-	 bool '    VGA 8x8 font' CONFIG_FONT_8x8
-	 bool '    VGA 8x16 font' CONFIG_FONT_8x16
-	 bool '    Sparc console 8x16 font' CONFIG_FONT_SUN8x16
+	 tristate '    VGA 8x8 font' CONFIG_FONT_8x8
+	 tristate '    VGA 8x16 font' CONFIG_FONT_8x16
+	 tristate '    Sparc console 8x16 font' CONFIG_FONT_SUN8x16
 	 if [ "$CONFIG_FBCON_FONTWIDTH8_ONLY" = "n" ]; then
-	    bool '    Sparc console 12x22 font (not supported by all drivers)' CONFIG_FONT_SUN12x22
-	    bool '    Mac console 6x11 font (not supported by all drivers)' CONFIG_FONT_6x11
+	    tristate '    Sparc console 12x22 font (not supported by all drivers)' CONFIG_FONT_SUN12x22
+	    tristate '    Mac console 6x11 font (not supported by all drivers)' CONFIG_FONT_6x11
 	 fi
-	 bool '    Pearl (old m68k) console 8x8 font' CONFIG_FONT_PEARL_8x8
-	 bool '    Acorn console 8x8 font' CONFIG_FONT_ACORN_8x8
+	 tristate '    Pearl (old m68k) console 8x8 font' CONFIG_FONT_PEARL_8x8
+	 tristate '    Acorn console 8x8 font' CONFIG_FONT_ACORN_8x8
       else
-	 define_bool CONFIG_FONT_8x8 y
-	 define_bool CONFIG_FONT_8x16 y
+	 define_tristate CONFIG_FONT_8x8 y
+	 define_tristate CONFIG_FONT_8x16 y
 	 if [ "$CONFIG_MAC" = "y" ]; then
 	    if [ "$CONFIG_FBCON_FONTWIDTH8_ONLY" = "n" ]; then
-	       define_bool CONFIG_FONT_6x11 y
+	       define_tristate CONFIG_FONT_6x11 y
 	    fi
 	 fi
 	 if [ "$CONFIG_AMIGA" = "y" ]; then
-	    define_bool CONFIG_FONT_PEARL_8x8 y
+	    define_tristate CONFIG_FONT_PEARL_8x8 y
 	 fi
 	 if [ "$CONFIG_ARM" = "y" -a "$CONFIG_ARCH_ACORN" = "y" ]; then
-	    define_bool CONFIG_FONT_ACORN_8x8 y
+	    define_tristate CONFIG_FONT_ACORN_8x8 y
 	 fi
       fi
    fi
diff -r -u linux-2.4.9/drivers/video/Makefile linux/drivers/video/Makefile
--- linux-2.4.9/drivers/video/Makefile	Tue Jul 31 14:43:29 2001
+++ linux/drivers/video/Makefile	Sat Aug 18 23:18:21 2001
@@ -9,7 +9,7 @@
 # All of the (potential) objects that export symbols.
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
 
-export-objs    := fbmem.o fbcmap.o fbcon.o fbmon.o modedb.o \
+export-objs    := fbmem.o fbcmap.o fbcon.o fbmon.o fonts.o modedb.o \
 		  fbcon-afb.o fbcon-ilbm.o \
 		  fbcon-vga.o fbcon-iplan2p2.o fbcon-iplan2p4.o \
 		  fbcon-iplan2p8.o fbcon-vga-planes.o fbcon-cfb16.o \
diff -r -u linux-2.4.9/drivers/video/font_6x11.c linux/drivers/video/font_6x11.c
--- linux-2.4.9/drivers/video/font_6x11.c	Fri Aug 13 12:15:00 1999
+++ linux/drivers/video/font_6x11.c	Sun Aug 19 01:25:59 2001
@@ -3341,7 +3341,7 @@
 };
 
 
-struct fbcon_font_desc font_vga_6x11 = {
+static struct fbcon_font_desc font_vga_6x11 = {
 	VGA6x11_IDX,
 	"ProFont6x11",
 	6,
@@ -3349,3 +3349,5 @@
 	fontdata_6x11,
 	-2000	/* Try avoiding this font if possible unless on MAC */
 };
+
+DECLARE_FONT_MODULE(&font_vga_6x11);
diff -r -u linux-2.4.9/drivers/video/font_8x16.c linux/drivers/video/font_8x16.c
--- linux-2.4.9/drivers/video/font_8x16.c	Tue Sep 29 20:56:33 1998
+++ linux/drivers/video/font_8x16.c	Sun Aug 19 01:25:59 2001
@@ -4621,7 +4621,7 @@
 };
 
 
-struct fbcon_font_desc font_vga_8x16 = {
+static struct fbcon_font_desc font_vga_8x16 = {
 	VGA8x16_IDX,
 	"VGA8x16",
 	8,
@@ -4629,3 +4629,5 @@
 	fontdata_8x16,
 	0
 };
+
+DECLARE_FONT_MODULE(&font_vga_8x16);
diff -r -u linux-2.4.9/drivers/video/font_8x8.c linux/drivers/video/font_8x8.c
--- linux-2.4.9/drivers/video/font_8x8.c	Tue Sep 29 20:56:33 1998
+++ linux/drivers/video/font_8x8.c	Sun Aug 19 01:25:59 2001
@@ -2573,7 +2573,7 @@
 };
 
 
-struct fbcon_font_desc font_vga_8x8 = {
+static struct fbcon_font_desc font_vga_8x8 = {
 	VGA8x8_IDX,
 	"VGA8x8",
 	8,
@@ -2581,3 +2581,5 @@
 	fontdata_8x8,
 	0
 };
+
+DECLARE_FONT_MODULE(&font_vga_8x8);
diff -r -u linux-2.4.9/drivers/video/font_acorn_8x8.c linux/drivers/video/font_acorn_8x8.c
--- linux-2.4.9/drivers/video/font_acorn_8x8.c	Tue Sep 29 20:56:33 1998
+++ linux/drivers/video/font_acorn_8x8.c	Sun Aug 19 01:25:59 2001
@@ -263,7 +263,7 @@
 /* FF */  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
 };
 
-struct fbcon_font_desc font_acorn_8x8 = {
+static struct fbcon_font_desc font_acorn_8x8 = {
 	ACORN8x8_IDX,
 	"Acorn8x8",
 	8,
@@ -275,3 +275,5 @@
 	0
 #endif
 };
+
+DECLARE_FONT_MODULE(&font_acorn_8x8);
diff -r -u linux-2.4.9/drivers/video/font_pearl_8x8.c linux/drivers/video/font_pearl_8x8.c
--- linux-2.4.9/drivers/video/font_pearl_8x8.c	Tue Sep 29 20:56:33 1998
+++ linux/drivers/video/font_pearl_8x8.c	Sun Aug 19 01:25:59 2001
@@ -2577,7 +2577,7 @@
 
 };
 
-struct fbcon_font_desc font_pearl_8x8 = {
+static struct fbcon_font_desc font_pearl_8x8 = {
 	PEARL8x8_IDX,
 	"PEARL8x8",
 	8,
@@ -2585,3 +2585,5 @@
 	fontdata_pearl8x8,
 	2
 };
+
+DECLARE_FONT_MODULE(&font_pearl_8x8);
diff -r -u linux-2.4.9/drivers/video/font_sun12x22.c linux/drivers/video/font_sun12x22.c
--- linux-2.4.9/drivers/video/font_sun12x22.c	Mon Dec 21 14:48:04 1998
+++ linux/drivers/video/font_sun12x22.c	Sun Aug 19 01:25:59 2001
@@ -6206,7 +6206,7 @@
 };
 
 
-struct fbcon_font_desc font_sun_12x22 = {
+static struct fbcon_font_desc font_sun_12x22 = {
 	SUN12x22_IDX,
 	"SUN12x22",
 	12,
@@ -6218,3 +6218,5 @@
 	-1
 #endif
 };
+
+DECLARE_FONT_MODULE(&font_sun_12x22);
diff -r -u linux-2.4.9/drivers/video/font_sun8x16.c linux/drivers/video/font_sun8x16.c
--- linux-2.4.9/drivers/video/font_sun8x16.c	Tue Sep 29 20:56:33 1998
+++ linux/drivers/video/font_sun8x16.c	Sun Aug 19 01:25:59 2001
@@ -261,7 +261,7 @@
 /* */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
 };
 
-struct fbcon_font_desc font_sun_8x16 = {
+static struct fbcon_font_desc font_sun_8x16 = {
 	SUN8x16_IDX,
 	"SUN8x16",
 	8,
@@ -273,3 +273,5 @@
 	-1
 #endif
 };
+
+DECLARE_FONT_MODULE(&font_sun_8x16);
diff -r -u linux-2.4.9/drivers/video/fonts.c linux/drivers/video/fonts.c
--- linux-2.4.9/drivers/video/fonts.c	Fri Mar  2 18:38:39 2001
+++ linux/drivers/video/fonts.c	Sun Aug 19 01:22:00 2001
@@ -14,57 +14,77 @@
 
 
 #include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kmod.h>
+#include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/string.h>
 #if defined(__mc68000__) || defined(CONFIG_APUS)
 #include <asm/setup.h>
 #endif
 #include <video/font.h>
+#include <asm/semaphore.h>
 
-#define NO_FONTS
+static DECLARE_MUTEX(fonts_mutex);
+static struct fbcon_font_desc *fonts = NULL;
 
-static struct fbcon_font_desc *fbcon_fonts[] = {
-#ifdef CONFIG_FONT_8x8
-#undef NO_FONTS
-    &font_vga_8x8,
-#endif
-#ifdef CONFIG_FONT_8x16
-#undef NO_FONTS
-    &font_vga_8x16,
-#endif
-#ifdef CONFIG_FONT_6x11
-#if defined(CONFIG_FBCON_MAC) || defined(CONFIG_FB_SBUS)
-#undef NO_FONTS
-#endif
-    &font_vga_6x11,
-#endif
-#ifdef CONFIG_FONT_SUN8x16
-#undef NO_FONTS
-    &font_sun_8x16,
-#endif
-#ifdef CONFIG_FONT_SUN12x22
-#if defined(CONFIG_FB_SBUS) || defined(CONFIG_FBCON_CFB8) || defined(CONFIG_FBCON_CFB16) || defined(CONFIG_FBCON_CFB24) || defined(CONFIG_FBCON_CFB32)
-#undef NO_FONTS
-#endif
-    &font_sun_12x22,
-#endif
-#ifdef CONFIG_FONT_ACORN_8x8
-#undef NO_FONTS
-    &font_acorn_8x8,
-#endif
-#ifdef CONFIG_FONT_PEARL_8x8
-#undef NO_FONTS
-    &font_pearl_8x8,
-#endif
-};
+void
+fbcon_register_font(struct fbcon_font_desc *font)
+{
+	down(&fonts_mutex);
+
+	font->next = fonts;
+	fonts = font;
+
+	up(&fonts_mutex);
+}
+
+void
+fbcon_unregister_font(struct fbcon_font_desc *font)
+{
+	struct fbcon_font_desc **font_p;
+	down(&fonts_mutex);
 
-#define num_fonts (sizeof(fbcon_fonts)/sizeof(*fbcon_fonts))
+	/* Take the kernel panic if the font is not present. */
+	for(font_p = &fonts; *font_p != font; font_p = &(*font_p)->next);
 
-#ifdef NO_FONTS
-#error No fonts configured.
+	*font_p = font;
+
+	up(&fonts_mutex);
+}
+
+#if 	!defined(CONFIG_FONT_8x8) && \
+	!defined(CONFIG_FONT_8x16) && \
+	!defined(CONFIG_FONT_16x11) && \
+	!defined(CONFIG_FONT_SUN8x16) && \
+	!defined(CONFIG_FONT_SUN12x22) && \
+	!defined(CONFIG_FONT_ACORN8x8) && \
+	!defined(CONFIG_FONT_PEARL_8x8)
+/* There definitely are cases where it is OK to initially have no fonts
+   defined.  The question is whether there are configurations where you
+   really could not boot the point where a script can load the first
+   console font and proceed from there, and, if so, which configurations
+   those are.  Until I know of such a configuration, I am commenting out
+   the following #error line.  -Adam Richter 2001.08.19 */
+/*# error No fonts configured.*/
 #endif
 
 
+static struct fbcon_font_desc *
+fbcon_find_existing_font(char *name)
+{
+	struct fbcon_font_desc *font;
+	for(font = fonts; font != NULL; font = font->next) {
+		if (!strcmp(font->name, name)) {
+			if (font->module != NULL) {
+				__MOD_INC_USE_COUNT(font->module);
+			}
+			return font;
+		}
+	}
+	return NULL;
+}
+
 /**
  *	fbcon_find_font - find a font
  *	@name: string name of a font
@@ -78,12 +98,18 @@
 
 struct fbcon_font_desc *fbcon_find_font(char *name)
 {
-   unsigned int i;
-
-   for (i = 0; i < num_fonts; i++)
-      if (!strcmp(fbcon_fonts[i]->name, name))
-	  return fbcon_fonts[i];
-   return NULL;
+#ifdef CONFIG_KMOD
+	struct fbcon_font_desc *font;
+	char module[50];
+
+	if ((font = fbcon_find_existing_font(name)) != NULL)
+		return font;
+
+	snprintf(module, sizeof(module),"font_%s", name);
+	module[sizeof(module)-1] = '\0';
+	request_module(module);
+#endif
+	return fbcon_find_existing_font(name);
 }
 
 
@@ -102,13 +128,12 @@
 
 struct fbcon_font_desc *fbcon_get_default_font(int xres, int yres)
 {
-    int i, c, cc;
+    int c, cc;
     struct fbcon_font_desc *f, *g;
 
     g = NULL;
     cc = -10000;
-    for(i=0; i<num_fonts; i++) {
-	f = fbcon_fonts[i];
+    for(f = fonts; f != NULL; f = f->next) {
 	c = f->pref;
 #if defined(__mc68000__) || defined(CONFIG_APUS)
 #ifdef CONFIG_FONT_PEARL_8x8
@@ -127,5 +152,19 @@
 	    g = f;
 	}
     }
+    if (g != NULL && g->module != NULL) {
+        __MOD_INC_USE_COUNT(g->module);
+    }
     return g;
 }
+
+void
+fbcon_release_font(struct fbcon_font_desc *font)
+{
+	if (font->module != NULL) {
+		__MOD_DEC_USE_COUNT(font->module);
+	}
+}
+
+EXPORT_SYMBOL(fbcon_register_font);
+EXPORT_SYMBOL(fbcon_unregister_font);

--HcAYCG3uE/tztfnV--
