Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261399AbSJMByb>; Sat, 12 Oct 2002 21:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261400AbSJMByb>; Sat, 12 Oct 2002 21:54:31 -0400
Received: from p0032.as-l042.contactel.cz ([194.108.237.32]:11904 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S261399AbSJMByL>;
	Sat, 12 Oct 2002 21:54:11 -0400
Date: Sun, 13 Oct 2002 03:53:01 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Bob Billson <reb@bhive.dhs.org>
Cc: linux-kernel@vger.kernel.org, James Simmons <jsimmons@transvirtual.com>
Subject: Re: 2.5.42 compiler error in video/vga16fb.c
Message-ID: <20021013015301.GB1508@ppc.vc.cvut.cz>
References: <20021012230145.GA3508@etain.bhive.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021012230145.GA3508@etain.bhive.dhs.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 07:01:45PM -0400, Bob Billson wrote:
> In drivers/video/vga16fb.c gcc (2.95.4 and 3.2) gives:
> 
> gcc -Wp,-MD,drivers/video/.vga16fb.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=vga16fb   -c -o drivers/video/vga16fb.o drivers/video/vga16fb.c
> drivers/video/vga16fb.c: In function `vga16fb_set_disp':
> drivers/video/vga16fb.c:177: structure has no member named `visual'
> drivers/video/vga16fb.c:178: structure has no member named `type'
> drivers/video/vga16fb.c:179: structure has no member named `type_aux'
> drivers/video/vga16fb.c:180: structure has no member named `ypanstep'
> drivers/video/vga16fb.c:181: structure has no member named `ywrapstep'
> drivers/video/vga16fb.c:182: structure has no member named `line_length'

It looks like that nobody is interested in VGA anymore. Are there 
any objections against patch below? It is for current 2.5.42-bk,
and it fixes vga16fb compilability, and adds -depth 8 (to get 320x200, or
360x480 in planar mode) and -depth 0 (to get fast textmode) to the vga16fb.

If there are no objections, I'll split it up and send to Linus. But as
I already said (and already asked), I'm not going to be vga16fb maintainer
(because of I use matroxfb everywhere), so if there is somebody else
who has vga16fb fixes, or who wants to maintain vga16fb, please step up...

					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz

diff -urdN linux/drivers/video/Config.help linux/drivers/video/Config.help
--- linux/drivers/video/Config.help	2002-10-13 02:32:19.000000000 +0200
+++ linux/drivers/video/Config.help	2002-10-13 02:41:20.000000000 +0200
@@ -250,6 +250,11 @@
   Only answer Y here if you have a (very old) VGA card that isn't VESA
   2 compatible.
 
+CONFIG_FBCON_VGA
+  This is the low level frame buffer console driver for VGA text mode;
+  it is used by frame buffer device drivers that support VGA text
+  mode.
+
 CONFIG_FB_VGA16
   This is the frame buffer device driver for VGA 16 color graphic
   cards. Say Y if you have such a card.
diff -urdN linux/drivers/video/Config.in linux/drivers/video/Config.in
--- linux/drivers/video/Config.in	2002-10-13 02:33:09.000000000 +0200
+++ linux/drivers/video/Config.in	2002-10-13 02:41:20.000000000 +0200
@@ -234,6 +234,7 @@
       tristate '    Atari interleaved bitplanes (8 planes) support' CONFIG_FBCON_IPLAN2P8
 #      tristate '    Atari interleaved bitplanes (16 planes) support' CONFIG_FBCON_IPLAN2P16
       tristate '    VGA 16-color planar support' CONFIG_FBCON_VGA_PLANES
+      tristate '    VGA characters/attributes support' CONFIG_FBCON_VGA
       tristate '    HGA monochrome support (EXPERIMENTAL)' CONFIG_FBCON_HGA
    else
       # Guess what we need
@@ -391,9 +392,11 @@
       fi
       if [ "$CONFIG_FB_VGA16" = "y" ]; then
 	 define_tristate CONFIG_FBCON_VGA_PLANES y
+	 define_tristate CONFIG_FBCON_VGA y
       else
 	 if [ "$CONFIG_FB_VGA16" = "m" ]; then
 	    define_tristate CONFIG_FBCON_VGA_PLANES m
+	    define_tristate CONFIG_FBCON_VGA m
 	 fi
       fi
       if [ "$CONFIG_FB_HGA" = "y" ]; then
diff -urdN linux/drivers/video/Makefile linux/drivers/video/Makefile
--- linux/drivers/video/Makefile	2002-10-13 02:32:06.000000000 +0200
+++ linux/drivers/video/Makefile	2002-10-13 02:41:20.000000000 +0200
@@ -8,7 +8,7 @@
 export-objs    	:= fbmem.o fbcmap.o fbcon.o fbmon.o modedb.o \
 		   fbcon-afb.o fbcon-ilbm.o fbcon-accel.o cyber2000fb.o \
 		   fbcon-iplan2p2.o fbcon-iplan2p4.o fbgen.o \
-		   fbcon-iplan2p8.o fbcon-vga-planes.o fbcon-cfb16.o \
+		   fbcon-iplan2p8.o fbcon-vga-planes.o fbcon-vga8-planes.o fbcon-vga.o fbcon-cfb16.o \
 		   fbcon-cfb2.o fbcon-cfb24.o fbcon-cfb32.o fbcon-cfb4.o \
 		   fbcon-cfb8.o fbcon-mfb.o fbcon-hga.o
 
@@ -68,7 +68,7 @@
 obj-$(CONFIG_FB_S3TRIO)           += S3triofb.o
 obj-$(CONFIG_FB_TGA)              += tgafb.o
 obj-$(CONFIG_FB_VESA)             += vesafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
-obj-$(CONFIG_FB_VGA16)            += vga16fb.o fbcon-vga-planes.o
+obj-$(CONFIG_FB_VGA16)            += vga16fb.o fbcon-vga-planes.o fbcon-vga8-planes.o
 obj-$(CONFIG_FB_VIRGE)            += virgefb.o
 obj-$(CONFIG_FB_G364)             += g364fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_FM2)              += fm2fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
@@ -115,6 +115,7 @@
 obj-$(CONFIG_FBCON_IPLAN2P4)      += fbcon-iplan2p4.o
 obj-$(CONFIG_FBCON_IPLAN2P8)      += fbcon-iplan2p8.o
 obj-$(CONFIG_FBCON_MFB)           += fbcon-mfb.o
+obj-$(CONFIG_FBCON_VGA)		  += fbcon-vga.o
 obj-$(CONFIG_FBCON_HGA)           += fbcon-hga.o
 obj-$(CONFIG_FBCON_STI)           += fbcon-sti.o
 obj-$(CONFIG_FBCON_ACCEL)	  += fbcon-accel.o
diff -urdN linux/drivers/video/fbcon-vga.c linux/drivers/video/fbcon-vga.c
--- linux/drivers/video/fbcon-vga.c	1970-01-01 01:00:00.000000000 +0100
+++ linux/drivers/video/fbcon-vga.c	2002-10-13 02:41:20.000000000 +0200
@@ -0,0 +1,213 @@
+/*
+ *  linux/drivers/video/fbcon-vga.c -- Low level frame buffer operations for
+ *				       VGA characters/attributes
+ *
+ *	Created 28 Mar 1998 by Geert Uytterhoeven
+ *	Monochrome attributes added May 1998 by Andrew Apted
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <linux/module.h>
+#include <linux/tty.h>
+#include <linux/console.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+
+#include <asm/io.h>
+
+#include <video/fbcon.h>
+#include <video/fbcon-vga.h>
+
+
+    /*
+     *  VGA screen access
+     */ 
+
+static inline void vga_writew(u16 val, u16 *addr)
+{
+#ifdef __powerpc__
+    st_le16(addr, val);
+#else
+    writew(val, (unsigned long)addr);
+#endif /* !__powerpc__ */
+}
+
+static inline u16 vga_readw(u16 *addr)
+{
+#ifdef __powerpc__
+    return ld_le16(addr);
+#else
+    return readw((unsigned long)addr);
+#endif /* !__powerpc__ */	
+}
+
+static inline void vga_memsetw(void *s, u16 c, unsigned int count)
+{
+    u16 *addr = (u16 *)s;
+
+    while (count) {
+	count--;
+	vga_writew(c, addr++);
+    }
+}
+
+static inline void vga_memmovew(u16 *to, u16 *from, unsigned int count)
+{
+    if (to < from) {
+	while (count) {
+	    count--;
+	    vga_writew(vga_readw(from++), to++);
+	}
+    } else {
+	from += count;
+	to += count;
+	while (count) {
+	    count--;
+	    vga_writew(vga_readw(--from), --to);
+	}
+    }
+}
+
+
+    /*
+     *  VGA characters/attributes
+     */
+
+static inline u16 fbcon_vga_attr(struct display *p,
+				 unsigned short s)
+{
+        /* Underline and reverse-video are mutually exclusive on MDA.
+         * Since reverse-video is used for cursors and selected areas, 
+	 * it takes precedence.
+         */
+
+	return (attr_reverse(p, s) ? 0x7000 :
+		(attr_underline(p, s) ? 0x0100 : 0x0700)) |
+	       (attr_bold(p, s) ? 0x0800 : 0) |
+	       (attr_blink(p, s) ? 0x8000 : 0);
+}
+
+void fbcon_vga_setup(struct display *p)
+{
+    p->next_line = p->fb_info->fix.line_length;
+    p->next_plane = 0;
+}
+
+void fbcon_vga_bmove(struct display *p, int sy, int sx, int dy, int dx,
+		     int height, int width)
+{
+    u16 *src, *dst;
+    int rows;
+
+    if (sx == 0 && dx == 0 && width == p->next_line/2) {
+	src = (u16 *)(p->fb_info->screen_base+sy*p->next_line);
+	dst = (u16 *)(p->fb_info->screen_base+dy*p->next_line);
+	vga_memmovew(dst, src, height*width);
+    } else if (dy < sy || (dy == sy && dx < sx)) {
+	src = (u16 *)(p->fb_info->screen_base+sy*p->next_line+sx*2);
+	dst = (u16 *)(p->fb_info->screen_base+dy*p->next_line+dx*2);
+	for (rows = height; rows-- ;) {
+	    vga_memmovew(dst, src, width);
+	    src += p->next_line/2;
+	    dst += p->next_line/2;
+	}
+    } else {
+	src = (u16 *)(p->fb_info->screen_base+(sy+height-1)*p->next_line+sx*2);
+	dst = (u16 *)(p->fb_info->screen_base+(dy+height-1)*p->next_line+dx*2);
+	for (rows = height; rows-- ;) {
+	    vga_memmovew(dst, src, width);
+	    src -= p->next_line/2;
+	    dst -= p->next_line/2;
+	}
+    }
+}
+
+void fbcon_vga_clear(struct vc_data *conp, struct display *p, int sy, int sx,
+		     int height, int width)
+{
+    u16 *dest = (u16 *)(p->fb_info->screen_base+sy*p->next_line+sx*2);
+    int rows;
+
+    if (sx == 0 && width*2 == p->next_line)      
+	vga_memsetw(dest, conp->vc_video_erase_char, height*width);
+    else
+	for (rows = height; rows-- ; dest += p->next_line/2)
+	    vga_memsetw(dest, conp->vc_video_erase_char, width);
+}
+
+void fbcon_vga_putc(struct vc_data *conp, struct display *p, int c, int y,
+		    int x)
+{
+    u16 *dst = (u16 *)(p->fb_info->screen_base+y*p->next_line+x*2);
+    if (conp->vc_can_do_color)
+    	vga_writew(c, dst);
+    else
+    	vga_writew(fbcon_vga_attr(p, c) | (c & 0xff), dst);
+}
+
+void fbcon_vga_putcs(struct vc_data *conp, struct display *p, 
+		     const unsigned short *s, int count, int y, int x)
+{
+    u16 *dst = (u16 *)(p->fb_info->screen_base+y*p->next_line+x*2);
+    u16 sattr;
+    if (conp->vc_can_do_color)
+    	while (count--)
+    	    vga_writew(scr_readw(s++), dst++);
+    else {
+        sattr = fbcon_vga_attr(p, scr_readw(s));
+        while (count--)
+	    vga_writew(sattr | ((int) (scr_readw(s++)) & 0xff), dst++);
+    }
+}
+
+void fbcon_vga_revc(struct display *p, int x, int y)
+{
+    u16 *dst = (u16 *)(p->fb_info->screen_base+y*p->next_line+x*2);
+    u16 val = vga_readw(dst);
+    val = (val & 0x88ff) | ((val<<4) & 0x7000) | ((val>>4) & 0x0700);
+    vga_writew(val, dst);
+}
+
+
+    /*
+     *  `switch' for the low level operations
+     */
+
+struct display_switch fbcon_vga = {
+    setup:		fbcon_vga_setup,
+    bmove:		fbcon_vga_bmove,
+    clear:		fbcon_vga_clear,
+    putc:		fbcon_vga_putc,
+    putcs:		fbcon_vga_putcs,
+    revc:		fbcon_vga_revc,
+    fontwidthmask:	FONTWIDTH(8)
+};
+
+
+#ifdef MODULE
+MODULE_LICENSE("GPL");
+
+int init_module(void)
+{
+    return 0;
+}
+
+void cleanup_module(void)
+{}
+#endif /* MODULE */
+
+
+    /*
+     *  Visible symbols for modules
+     */
+
+EXPORT_SYMBOL(fbcon_vga);
+EXPORT_SYMBOL(fbcon_vga_setup);
+EXPORT_SYMBOL(fbcon_vga_bmove);
+EXPORT_SYMBOL(fbcon_vga_clear);
+EXPORT_SYMBOL(fbcon_vga_putc);
+EXPORT_SYMBOL(fbcon_vga_putcs);
+EXPORT_SYMBOL(fbcon_vga_revc);
diff -urdN linux/drivers/video/fbcon-vga8-planes.c linux/drivers/video/fbcon-vga8-planes.c
--- linux/drivers/video/fbcon-vga8-planes.c	1970-01-01 01:00:00.000000000 +0100
+++ linux/drivers/video/fbcon-vga8-planes.c	2002-10-13 02:41:20.000000000 +0200
@@ -0,0 +1,382 @@
+/*
+ *  linux/drivers/video/fbcon-vga8-planes.c -- Low level frame buffer operations
+ *				  for VGA 256 color, 4-plane modes
+ *
+ *      Created Feb 2, 1999, by Petr Vandrovec <vandrove@vc.cvut.cz>
+ *	                     and Ben Pfaff
+ *	Based on code by Michael Schmitz
+ *	Based on the old macfb.c 4bpp code by Alan Cox
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#include <linux/module.h>
+#include <linux/tty.h>
+#include <linux/console.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+#include <linux/vt_buffer.h>
+
+#include <asm/io.h>
+
+#include <video/fbcon.h>
+#include <video/fbcon-vga-planes.h>
+#include "vga.h"
+
+#define GRAPHICS_ADDR_REG VGA_GFX_I	/* Graphics address register. */
+#define GRAPHICS_DATA_REG VGA_GFX_D	/* Graphics data register. */
+
+#define SET_RESET_INDEX VGA_GFX_SR_VALUE		/* Set/Reset Register index. */
+#define ENABLE_SET_RESET_INDEX VGA_GFX_SR_ENABLE	/* Enable Set/Reset Register index. */
+#define DATA_ROTATE_INDEX VGA_GFX_DATA_ROTATE		/* Data Rotate Register index. */
+#define GRAPHICS_MODE_INDEX VGA_GFX_MODE		/* Graphics Mode Register index. */
+#define BIT_MASK_INDEX VGA_GFX_BIT_MASK		/* Bit Mask Register index. */
+
+/* The VGA's weird architecture often requires that we read a byte and
+   write a byte to the same location.  It doesn't matter *what* byte
+   we write, however.  This is because all the action goes on behind
+   the scenes in the VGA's 32-bit latch register, and reading and writing
+   video memory just invokes latch behavior.
+
+   To avoid race conditions (is this necessary?), reading and writing
+   the memory byte should be done with a single instruction.  One
+   suitable instruction is the x86 bitwise OR.  The following
+   read-modify-write routine should optimize to one such bitwise
+   OR. */
+static inline void rmw(volatile char *p)
+{
+	readb(p);
+	writeb(0, p);
+}
+
+/* Set the Graphics Mode Register, and return its previous value.
+   Bits 0-1 are write mode, bit 3 is read mode. */
+static inline int setmode(int mode)
+{
+	int oldmode;
+	vga_io_w(GRAPHICS_ADDR_REG, GRAPHICS_MODE_INDEX);
+	oldmode = vga_io_r(GRAPHICS_DATA_REG);
+	vga_io_w(GRAPHICS_DATA_REG, mode);
+	return oldmode;
+}
+
+/* Select the Bit Mask Register and return its value. */
+static inline int selectmask(void)
+{
+	return vga_io_rgfx(BIT_MASK_INDEX);
+}
+
+/* Set the value of the Bit Mask Register. */
+static inline void setmask(int mask)
+{
+	vga_io_w(GRAPHICS_DATA_REG, mask);
+}
+
+/* Set the Data Rotate Register and return its old value.  Bits 0-2
+   are rotate count, bits 3-4 are logical operation (0=NOP, 1=AND,
+   2=OR, 3=XOR). */
+static inline int setop(int op)
+{
+	int oldop;
+	vga_io_w(GRAPHICS_ADDR_REG, DATA_ROTATE_INDEX);
+	oldop = vga_io_r(GRAPHICS_DATA_REG);
+	vga_io_w(GRAPHICS_DATA_REG, op);
+	return oldop;
+}
+
+/* Set the Enable Set/Reset Register and return its old value.  The
+   code here always uses value 0xf for this register.  */
+static inline int setsr(int sr)
+{
+	int oldsr;
+	vga_io_w(GRAPHICS_ADDR_REG, ENABLE_SET_RESET_INDEX);
+	oldsr = vga_io_r(GRAPHICS_DATA_REG);
+	vga_io_w(GRAPHICS_DATA_REG, sr);
+	return oldsr;
+}
+
+/* Set the Set/Reset Register and return its old value. */
+static inline int setcolor(int color)
+{
+	int oldcolor;
+	vga_io_w(GRAPHICS_ADDR_REG, SET_RESET_INDEX);
+	oldcolor = vga_io_r(GRAPHICS_DATA_REG);
+	vga_io_w(GRAPHICS_DATA_REG, color);
+	return oldcolor;
+}
+
+/* Return the value in the Graphics Address Register. */
+static inline int getindex(void)
+{
+	return vga_io_r(GRAPHICS_ADDR_REG);
+}
+
+/* Set the value in the Graphics Address Register. */
+static inline void setindex(int index)
+{
+	vga_io_w(GRAPHICS_ADDR_REG, index);
+}
+
+static void fbcon_vga8_planes_setup(struct display *p)
+{
+}
+
+static void fbcon_vga8_planes_bmove(struct display *p, int sy, int sx,
+				    int dy, int dx, int height, int width)
+{
+	char oldindex = getindex();
+	char oldmode = setmode(0x41);
+	char oldop = setop(0);
+	char oldsr = setsr(0xf);
+
+	char *src;
+	char *dest;
+	int line_ofs;
+	int x;
+
+	sy *= fontheight(p);
+	dy *= fontheight(p);
+	height *= fontheight(p);
+	sx *= fontwidth(p) / 4;
+	dx *= fontwidth(p) / 4;
+	width *= fontwidth(p) / 4;
+	if (dy < sy || (dy == sy && dx < sx)) {
+		line_ofs = p->fb_info->fix.line_length - width;
+		dest = p->fb_info->screen_base + dx + dy * p->fb_info->fix.line_length;
+		src = p->fb_info->screen_base + sx + sy * p->fb_info->fix.line_length;
+		while (height--) {
+			for (x = 0; x < width; x++) {
+				readb(src);
+				writeb(0, dest);
+				src++;
+				dest++;
+			}
+			src += line_ofs;
+			dest += line_ofs;
+		}
+	} else {
+		line_ofs = p->fb_info->fix.line_length - width;
+		dest = p->fb_info->screen_base + dx + width + (dy + height - 1) * p->fb_info->fix.line_length;
+		src = p->fb_info->screen_base + sx + width + (sy + height - 1) * p->fb_info->fix.line_length;
+		while (height--) {
+			for (x = 0; x < width; x++) {
+				--src;
+				--dest;
+				readb(src);
+				writeb(0, dest);
+			}
+			src -= line_ofs;
+			dest -= line_ofs;
+		}
+	}
+
+	setsr(oldsr);
+	setop(oldop);
+	setmode(oldmode);
+	setindex(oldindex);
+}
+
+static void fbcon_vga8_planes_clear(struct vc_data *conp, struct display *p,
+				    int sy, int sx, int height, int width)
+{
+	char oldindex = getindex();
+	char oldmode = setmode(0x40);
+	char oldop = setop(0);
+	char oldsr = setsr(0);
+	char oldmask = selectmask();
+
+	int line_ofs;
+	char *where;
+	int color = attr_bgcol_ec(p, conp);
+
+	width *= fontwidth(p) / 4;
+	sx *= fontwidth(p) / 4;
+	line_ofs = p->fb_info->fix.line_length - width;
+	setmask(0xff);
+
+	sy *= fontheight(p);
+	height *= fontheight(p);
+
+	where = p->fb_info->screen_base + sx + sy * p->fb_info->fix.line_length;
+	while (height--) {
+		int x;
+
+		/* we can do memset... */
+		for (x = width; x > 0; --x) {
+			writeb(color, where);
+			where++;
+		}
+		where += line_ofs;
+	}
+
+	setmask(oldmask);
+	setsr(oldsr);
+	setop(oldop);
+	setmode(oldmode);
+	setindex(oldindex);
+}
+
+#ifdef __LITTLE_ENDIAN
+static unsigned int transl_l[] =
+{0x0,0x8,0x4,0xC,0x2,0xA,0x6,0xE,0x1,0x9,0x5,0xD,0x3,0xB,0x7,0xF};
+static unsigned int transl_h[] =
+{0x000, 0x800, 0x400, 0xC00, 0x200, 0xA00, 0x600, 0xE00,
+ 0x100, 0x900, 0x500, 0xD00, 0x300, 0xB00, 0x700, 0xF00};
+#else
+#ifdef __BIG_ENDIAN
+static unsigned int transl_h[] =
+{0x0,0x8,0x4,0xC,0x2,0xA,0x6,0xE,0x1,0x9,0x5,0xD,0x3,0xB,0x7,0xF};
+static unsigned int transl_l[] =
+{0x000, 0x800, 0x400, 0xC00, 0x200, 0xA00, 0x600, 0xE00,
+ 0x100, 0x900, 0x500, 0xD00, 0x300, 0xB00, 0x700, 0xF00};
+#else
+#error "Only __BIG_ENDIAN and __LITTLE_ENDIAN are supported in vga-planes"
+#endif
+#endif
+static void fbcon_vga8_planes_putc(struct vc_data *conp, struct display *p,
+				   int c, int yy, int xx)
+{
+	int fg = attr_fgcol(p,c);
+	int bg = attr_bgcol(p,c);
+
+	char oldindex = getindex();
+	char oldmode = setmode(0x40);
+	char oldop = setop(0);
+	char oldsr = setsr(0);
+	char oldmask = selectmask();
+
+	int y;
+	u8 *cdat = p->fontdata + (c & p->charmask) * fontheight(p);
+	char *where;
+
+	xx *= fontwidth(p) / 4;
+	where = p->fb_info->screen_base + xx + yy * p->fb_info->fix.line_length * fontheight(p);
+
+	setmask(0xff);
+	writeb(bg, where);
+	readb(where);
+	selectmask();
+	setmask(fg ^ bg);
+	setmode(0x42);
+	setop(0x18);
+	for (y = 0; y < fontheight(p); y++, where += p->fb_info->fix.line_length) {
+		writew(transl_h[cdat[y]&0xF] | transl_l[cdat[y] >> 4],
+		       where);
+	}
+	setmask(oldmask);
+	setsr(oldsr);
+	setop(oldop);
+	setmode(oldmode);
+	setindex(oldindex);
+}
+
+static void fbcon_vga8_planes_putcs(struct vc_data *conp, struct display *p, 
+				    const unsigned short *s, int count, 
+				    int yy, int xx)
+{
+	int fg = attr_fgcol(p,scr_readw(s));
+	int bg = attr_bgcol(p,scr_readw(s));
+
+	char oldindex = getindex();
+	char oldmode = setmode(0x40);
+	char oldop = setop(0);
+	char oldsr = setsr(0);
+	char oldmask = selectmask();
+
+	char *where;
+	int n;
+
+	xx *= fontwidth(p) / 4;
+	/* First clear it all to the background color. */
+	setmask(0xff);
+	where = p->fb_info->screen_base + xx + yy * p->fb_info->fix.line_length * fontheight(p);
+	writeb(bg, where);
+	readb(where); /* fill latches with background */
+	selectmask();
+	setmask(fg ^ bg);
+	setmode(0x42);
+	setop(0x18);
+	for (n = 0; n < count; n++) {
+		int y;
+		int c = scr_readw(s++) & p->charmask;
+		u8 *cdat = p->fontdata + (c & p->charmask) * fontheight(p);
+
+		for (y = 0; y < fontheight(p); y++, cdat++) {
+			writew(transl_h[*cdat&0xF] | transl_l[*cdat >> 4],
+			       where);
+			where += p->fb_info->fix.line_length;
+		}
+		where += 2 - p->fb_info->fix.line_length * fontheight(p);
+	}
+	
+	selectmask();
+	setmask(oldmask);
+	setop(oldop);
+	setmode(oldmode);
+	setsr(oldsr);
+	setindex(oldindex);
+}
+
+static void fbcon_vga8_planes_revc(struct display *p, int xx, int yy)
+{
+	char oldindex = getindex();
+	char oldmode = setmode(0x40);
+	char oldop = setop(0x18);
+	char oldsr = setsr(0xf);
+	char oldcolor = setcolor(0xf);
+	char oldmask = selectmask();
+
+	char *where;
+	int y;
+
+	xx *= fontwidth(p) / 4;
+	where = p->fb_info->screen_base + xx + yy * p->fb_info->fix.line_length * fontheight(p);
+	
+	setmask(0x0F);
+	for (y = 0; y < fontheight(p); y++) {
+		rmw(where);
+		rmw(where+1);
+		where += p->fb_info->fix.line_length;
+	}
+
+	setmask(oldmask);
+	setcolor(oldcolor);
+	setsr(oldsr);
+	setop(oldop);
+	setmode(oldmode);
+	setindex(oldindex);
+}
+
+struct display_switch fbcon_vga8_planes = {
+    fbcon_vga8_planes_setup, fbcon_vga8_planes_bmove, fbcon_vga8_planes_clear,
+    fbcon_vga8_planes_putc, fbcon_vga8_planes_putcs, fbcon_vga8_planes_revc,
+    NULL, NULL, NULL, FONTWIDTH(8)
+};
+
+#ifdef MODULE
+int init_module(void)
+{
+    return 0;
+}
+
+void cleanup_module(void)
+{}
+#endif /* MODULE */
+
+
+    /*
+     *  Visible symbols for modules
+     */
+
+EXPORT_SYMBOL(fbcon_vga8_planes);
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
+
diff -urdN linux/drivers/video/fbgen.c linux/drivers/video/fbgen.c
--- linux/drivers/video/fbgen.c	2002-10-13 02:33:08.000000000 +0200
+++ linux/drivers/video/fbgen.c	2002-10-13 02:41:20.000000000 +0200
@@ -175,12 +175,26 @@
 
 void do_install_cmap(int con, struct fb_info *info)
 {
+    struct display* disp;
+
     if (con != info->currcon)
 	return;
-    if (fb_display[con].cmap.len)
-	fb_set_cmap(&fb_display[con].cmap, 1, info);
+    if (con >= 0) {
+        disp = fb_display + con;
+    } else {
+        disp = info->disp;
+    }
+    if (disp->cmap.len)
+	fb_set_cmap(&disp->cmap, 1, info);
     else {
-	int size = fb_display[con].var.bits_per_pixel == 16 ? 64 : 256;
+	int size;
+	
+	switch (disp->var.bits_per_pixel) {
+		case 1:  size = 2; break;
+		case 2:  size = 4; break;
+		case 3:  size = 8; break;
+		default: size = 16; break;
+	}
 	fb_set_cmap(fb_default_cmap(size), 1, info);
     }
 }
diff -urdN linux/drivers/video/vga16fb.c linux/drivers/video/vga16fb.c
--- linux/drivers/video/vga16fb.c	2002-10-13 02:32:23.000000000 +0200
+++ linux/drivers/video/vga16fb.c	2002-10-13 02:41:20.000000000 +0200
@@ -27,10 +27,13 @@
 
 #include <video/fbcon.h>
 #include <video/fbcon-vga-planes.h>
+#include <video/fbcon-vga.h>
+#include <video/fbcon-cfb4.h>
+#include <video/fbcon-cfb8.h>
 #include "vga.h"
 
-#define dac_reg	(0x3c8)
-#define dac_val	(0x3c9)
+#define dac_reg	(VGA_PEL_IW)
+#define dac_val	(VGA_PEL_D)
 
 #define VGA_FB_PHYS 0xA0000
 #define VGA_FB_PHYS_LEN 65536
@@ -70,11 +73,11 @@
 
 struct vga16fb_par {
 	u8 crtc[VGA_CRT_C];
-	u8 atc[VGA_ATT_C];
-	u8 gdc[VGA_GFX_C];
-	u8 seq[VGA_SEQ_C];
 	u8 misc;
+	u8 pel_msk;
 	u8 vss;
+	int mode;
+	u8 clkdiv;
 	struct fb_var_screeninfo var;
 };
 
@@ -104,103 +107,136 @@
 
 /* --------------------------------------------------------------------- */
 
-static void vga16fb_pan_var(struct fb_info *info, struct fb_var_screeninfo *var)
+static void vga16fb_pan_var(struct fb_info *info, 
+			    struct fb_var_screeninfo *var,
+			    struct display *p)
 {
-	u32 pos = (var->xres_virtual * var->yoffset + var->xoffset) >> 3;
-	outb(VGA_CRTC_START_HI, VGA_CRT_IC);
-	outb(pos >> 8, VGA_CRT_DC);
-	outb(VGA_CRTC_START_LO, VGA_CRT_IC);
-	outb(pos & 0xFF, VGA_CRT_DC);
-#if 0
+	u32 pos;
+	u32 xoffset;
+
+	xoffset = info->var.xoffset = var->xoffset;
+	info->var.yoffset = var->yoffset;
+	if (info->var.bits_per_pixel == 8) {
+		pos = (info->var.xres_virtual * info->var.yoffset + xoffset) >> 2;
+	} else if (info->var.bits_per_pixel == 0) {
+		int fh = fontheight(p);
+		if (!fh) fh = 16;
+		pos = (info->var.xres_virtual * (info->var.yoffset / fh) + xoffset) >> 3;
+	} else {
+		if (info->var.nonstd)
+			xoffset--;
+		pos = (info->var.xres_virtual * info->var.yoffset + xoffset) >> 3;
+	}
+	vga_io_wcrt(VGA_CRTC_START_HI, pos >> 8);
+	vga_io_wcrt(VGA_CRTC_START_LO, pos & 0xFF);
+/* if we support CFB4, then we must! support xoffset with pixel granularity */
 	/* if someone supports xoffset in bit resolution */
-	inb(VGA_IS1_RC);		/* reset flip-flop */
-	outb(VGA_ATC_PEL, VGA_ATT_IW);
-	outb(xoffset & 7, VGA_ATT_IW);
-	inb(VGA_IS1_RC);
-	outb(0x20, VGA_ATT_IW);
-#endif
+	vga_io_r(VGA_IS1_RC);		/* reset flip-flop */
+	vga_io_w(VGA_ATT_IW, VGA_ATC_PEL);
+	if (info->var.bits_per_pixel == 8)
+		vga_io_w(VGA_ATT_IW, (xoffset & 3) << 1);
+	else
+		vga_io_w(VGA_ATT_IW, xoffset & 7);
+	vga_io_r(VGA_IS1_RC);
+	vga_io_w(VGA_ATT_IW, 0x20);
 }
 
 static int vga16fb_update_var(int con, struct fb_info *info)
 {
-	vga16fb_pan_var(info, &fb_display[con].var);
+	struct display* p;
+
+	p = (con < 0) ? info->disp : fb_display + con;
+	vga16fb_pan_var(info, &p->var, p);
 	return 0;
 }
 
-static int vga16fb_get_fix(struct fb_fix_screeninfo *fix, int con,
-			   struct fb_info *info)
+static void vga16fb_update_fix(struct fb_info *info)
 {
-	struct display *p;
-
-	if (con < 0)
-		p = &disp;
-	else
-		p = fb_display + con;
+	struct fb_fix_screeninfo *fix = &info->fix;
 
 	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
 	strcpy(fix->id,"VGA16 VGA");
 
 	fix->smem_start = VGA_FB_PHYS;
 	fix->smem_len = VGA_FB_PHYS_LEN;
-	fix->type = FB_TYPE_VGA_PLANES;
+	if (info->var.bits_per_pixel == 4) {
+		if (info->var.nonstd) {
+			fix->type = FB_TYPE_PACKED_PIXELS;
+			fix->line_length = info->var.xres_virtual / 2;
+		} else {
+			fix->type = FB_TYPE_VGA_PLANES;
+			fix->type_aux = FB_AUX_VGA_PLANES_VGA4;
+			fix->line_length = info->var.xres_virtual / 8;
+		}
+	} else if (info->var.bits_per_pixel == 0) {
+		fix->type = FB_TYPE_TEXT;
+		fix->type_aux = FB_AUX_TEXT_CGA;
+		fix->line_length = info->var.xres_virtual / 4;
+	} else {	/* 8bpp */
+		if (info->var.nonstd) {
+			fix->type = FB_TYPE_VGA_PLANES;
+			fix->type_aux = FB_AUX_VGA_PLANES_CFB8;
+			fix->line_length = info->var.xres_virtual / 4;
+		} else {
+			fix->type = FB_TYPE_PACKED_PIXELS;
+			fix->line_length = info->var.xres_virtual;
+		}
+	}
 	fix->visual = FB_VISUAL_PSEUDOCOLOR;
 	fix->xpanstep  = 8;
 	fix->ypanstep  = 1;
 	fix->ywrapstep = 0;
-	fix->line_length = p->var.xres_virtual / 8;
-	return 0;
-}
-
-static int vga16fb_get_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info)
-{
-	if(con==-1)
-		memcpy(var, &vga16fb_defined, sizeof(struct fb_var_screeninfo));
-	else
-		*var=fb_display[con].var;
-	return 0;
 }
 
-static void vga16fb_set_disp(int con, struct vga16fb_info *info)
+static void vga16fb_set_disp(struct display *display, struct vga16fb_info *info)
 {
-	struct fb_fix_screeninfo fix;
-	struct display *display;
-
-	if (con < 0)
-		display = &disp;
-	else
-		display = fb_display + con;
-
-	
-	vga16fb_get_fix(&fix, con, &info->fb_info);
+	struct fb_fix_screeninfo *fix = &info->fb_info.fix;
 
-	display->visual = fix.visual;
-	display->type = fix.type;
-	display->type_aux = fix.type_aux;
-	display->ypanstep = fix.ypanstep;
-	display->ywrapstep = fix.ywrapstep;
-	display->line_length = fix.line_length;
-	display->next_line = fix.line_length;
+	vga16fb_update_fix(&info->fb_info);
+	display->next_line = fix->line_length;
 	display->can_soft_blank = 1;
 	display->inverse = 0;
 
-	if (info->isVGA)
-		display->dispsw = &fbcon_vga_planes;
-	else
-		display->dispsw = &fbcon_ega_planes;
-	display->scrollmode = SCROLL_YREDRAW;
-}
-
-static void vga16fb_encode_var(struct fb_var_screeninfo *var,
-			       const struct vga16fb_par *par,
-			       const struct vga16fb_info *info)
-{
-	*var = par->var;
+	switch (fix->type) {
+#ifdef FBCON_HAS_VGA_PLANES
+		case FB_TYPE_VGA_PLANES:
+			if (fix->type_aux == FB_AUX_VGA_PLANES_VGA4) {
+				if (info->isVGA)
+					display->dispsw = &fbcon_vga_planes;
+				else
+					display->dispsw = &fbcon_ega_planes;
+			} else
+				display->dispsw = &fbcon_vga8_planes;
+			break;
+#endif
+#ifdef FBCON_HAS_VGA
+		case FB_TYPE_TEXT:
+			display->dispsw = &fbcon_vga;
+			break;
+#endif
+		default: /* only FB_TYPE_PACKED_PIXELS */
+			switch (display->var.bits_per_pixel) {
+#ifdef FBCON_HAS_CFB4
+				case 4:
+					display->dispsw = &fbcon_cfb4;
+					break;
+#endif
+#ifdef FBCON_HAS_CFB8
+				case 8: 
+					display->dispsw = &fbcon_cfb8;
+					break;
+#endif
+				default:
+					display->dispsw = &fbcon_dummy;
+			}
+			break;
+	}
 }
 
 static void vga16fb_clock_chip(struct vga16fb_par *par,
 			       unsigned int pixclock,
-			       const struct vga16fb_info *info)
+			       const struct vga16fb_info *info,
+			       int mul, int div)
 {
 	static struct {
 		u32 pixclock;
@@ -214,6 +250,7 @@
 		{     0 /* bad */,    0x00, 0x00}};
 	int err;
 
+	pixclock = (pixclock * mul) / div;
 	best = vgaclocks;
 	err = pixclock - best->pixclock;
 	if (err < 0) err = -err;
@@ -228,25 +265,89 @@
 		}
 	}
 	par->misc |= best->misc;
-	par->seq[VGA_SEQ_CLOCK_MODE] |= best->seq_clock_mode;
-	par->var.pixclock = best->pixclock;		
+	par->clkdiv = best->seq_clock_mode;
+	par->var.pixclock = (best->pixclock * div) / mul;		
 }
 			       
 #define FAIL(X) return -EINVAL
 
+#define MODE_SKIP4	1
+#define MODE_8BPP	2
+#define MODE_CFB	4
+#define MODE_TEXT	8
 static int vga16fb_decode_var(const struct fb_var_screeninfo *var,
 			      struct vga16fb_par *par,
-			      const struct vga16fb_info *info)
+			      const struct vga16fb_info *info,
+			      struct display *p)
 {
 	u32 xres, right, hslen, left, xtotal;
 	u32 yres, lower, vslen, upper, ytotal;
 	u32 vxres, xoffset, vyres, yoffset;
 	u32 pos;
 	u8 r7, rMode;
-	int i;
+	int shift;
+	int mode;
+	u32 maxmem;
 
-	if (var->bits_per_pixel != 4)
+	par->pel_msk = 0xFF;
+
+	if (var->bits_per_pixel == 4) {
+		if (var->nonstd) {
+#ifdef FBCON_HAS_CFB4
+			if (!info->isVGA)
+				return -EINVAL;
+			shift = 3;
+			mode = MODE_SKIP4 | MODE_CFB;
+			maxmem = 16384;
+			par->pel_msk = 0x0F;
+#else
+			return -EINVAL;
+#endif
+		} else {
+#ifdef FBCON_HAS_VGA_PLANES
+			shift = 3;
+			mode = 0;
+			maxmem = 65536;
+#else
+			return -EINVAL;
+#endif
+		}
+	} else if (var->bits_per_pixel == 8) {
+		if (!info->isVGA)
+			return -EINVAL;	/* no support on EGA */
+		shift = 2;
+		if (var->nonstd) {
+#ifdef FBCON_HAS_VGA_PLANES
+			mode = MODE_8BPP | MODE_CFB;
+			maxmem = 65536;
+#else
+			return -EINVAL;
+#endif
+		} else {
+#ifdef FBCON_HAS_CFB8
+			mode = MODE_SKIP4 | MODE_8BPP | MODE_CFB;
+			maxmem = 16384;
+#else
+			return -EINVAL;
+#endif
+		}
+	}
+#ifdef FBCON_HAS_VGA	
+	else if (var->bits_per_pixel == 0) {
+		int fh;
+
+		shift = 3;
+		mode = MODE_TEXT;
+		fh = fontheight(p);
+		if (!fh)
+			fh = 16;
+		maxmem = 32768 * fh;
+	}
+#endif
+	else
 		return -EINVAL;
+	par->var.nonstd = var->nonstd;
+
 	xres = (var->xres + 7) & ~7;
 	vxres = (var->xres_virtual + 0xF) & ~0xF;
 	xoffset = (var->xoffset + 7) & ~7;
@@ -266,11 +367,11 @@
 	par->var.xres_virtual = vxres;
 	par->var.xoffset = xoffset;
 
-	xres >>= 3;
-	right >>= 3;
-	hslen >>= 3;
-	left >>= 3;
-	vxres >>= 3;
+	xres >>= shift;
+	right >>= shift;
+	hslen >>= shift;
+	left >>= shift;
+	vxres >>= shift;
 	xtotal = xres + right + hslen + left;
 	if (xtotal >= 256)
 		FAIL("xtotal too big");
@@ -299,8 +400,8 @@
 
 	if (yres > vyres)
 		vyres = yres;
-	if (vxres * vyres > 65536) {
-		vyres = 65536 / vxres;
+	if (vxres * vyres > maxmem) {
+		vyres = maxmem / vxres;
 		if (vyres < yres)
 			return -ENOMEM;
 	}
@@ -344,7 +445,9 @@
 		par->crtc[VGA_CRTC_MAX_SCAN] |= 0x80;
 	par->crtc[VGA_CRTC_CURSOR_START] = 0x20;
 	par->crtc[VGA_CRTC_CURSOR_END]   = 0x00;
-	pos = yoffset * vxres + (xoffset >> 3);
+	if ((mode & (MODE_CFB | MODE_8BPP)) == MODE_CFB)
+		xoffset--;
+	pos = yoffset * vxres + (xoffset >> shift);
 	par->crtc[VGA_CRTC_START_HI]     = pos >> 8;
 	par->crtc[VGA_CRTC_START_LO]     = pos & 0xFF;
 	par->crtc[VGA_CRTC_CURSOR_HI]    = 0x00;
@@ -372,53 +475,39 @@
 	if (vxres >= 512)
 		FAIL("vxres too long");
 	par->crtc[VGA_CRTC_OFFSET] = vxres >> 1;
-	par->crtc[VGA_CRTC_UNDERLINE] = 0x1F;
-	par->crtc[VGA_CRTC_MODE] = rMode | 0xE3;
+	if (mode & MODE_SKIP4)
+		par->crtc[VGA_CRTC_UNDERLINE] = 0x5F;	/* 256, cfb8 */
+	else
+		par->crtc[VGA_CRTC_UNDERLINE] = 0x1F;	/* 16, vgap */
+	par->crtc[VGA_CRTC_MODE] = rMode | ((mode & MODE_TEXT) ? 0xA3 : 0xE3);
 	par->crtc[VGA_CRTC_LINE_COMPARE] = 0xFF;
 	par->crtc[VGA_CRTC_OVERFLOW] = r7;
 
 	par->vss = 0x00;	/* 3DA */
 
-	for (i = 0x00; i < 0x10; i++)
-		par->atc[i] = i;
-	par->atc[VGA_ATC_MODE] = 0x81;
-	par->atc[VGA_ATC_OVERSCAN] = 0x00;	/* 0 for EGA, 0xFF for VGA */
-	par->atc[VGA_ATC_PLANE_ENABLE] = 0x0F;
-	par->atc[VGA_ATC_PEL] = xoffset & 7;
-	par->atc[VGA_ATC_COLOR_PAGE] = 0x00;
-	
-	par->misc = 0xC3;	/* enable CPU, ports 0x3Dx, positive sync */
+	par->misc = 0xE3;	/* enable CPU, ports 0x3Dx, positive sync */
 	par->var.sync = var->sync;
 	if (var->sync & FB_SYNC_HOR_HIGH_ACT)
 		par->misc &= ~0x40;
 	if (var->sync & FB_SYNC_VERT_HIGH_ACT)
 		par->misc &= ~0x80;
 	
-	par->seq[VGA_SEQ_CLOCK_MODE] = 0x01;
-	par->seq[VGA_SEQ_PLANE_WRITE] = 0x0F;
-	par->seq[VGA_SEQ_CHARACTER_MAP] = 0x00;
-	par->seq[VGA_SEQ_MEMORY_MODE] = 0x06;
-	
-	par->gdc[VGA_GFX_SR_VALUE] = 0x00;
-	par->gdc[VGA_GFX_SR_ENABLE] = 0x0F;
-	par->gdc[VGA_GFX_COMPARE_VALUE] = 0x00;
-	par->gdc[VGA_GFX_DATA_ROTATE] = 0x20;
-	par->gdc[VGA_GFX_PLANE_READ] = 0;
-	par->gdc[VGA_GFX_MODE] = 0x00;
-	par->gdc[VGA_GFX_MISC] = 0x05;
-	par->gdc[VGA_GFX_COMPARE_MASK] = 0x0F;
-	par->gdc[VGA_GFX_BIT_MASK] = 0xFF;
-
-	vga16fb_clock_chip(par, var->pixclock, info);
+	par->mode = mode;
 
-	par->var.bits_per_pixel = 4;
+	if (mode & MODE_8BPP)
+		/* pixel clock == vga clock / 2 */
+		vga16fb_clock_chip(par, var->pixclock, info, 1, 2);
+	else
+		/* pixel clock == vga clock */
+		vga16fb_clock_chip(par, var->pixclock, info, 1, 1);
+	
+	par->var.bits_per_pixel = var->bits_per_pixel;
 	par->var.grayscale = var->grayscale;
 	par->var.red.offset = par->var.green.offset = par->var.blue.offset = 
 	par->var.transp.offset = 0;
 	par->var.red.length = par->var.green.length = par->var.blue.length =
 		(info->isVGA) ? 6 : 2;
 	par->var.transp.length = 0;
-	par->var.nonstd = 0;
 	par->var.activate = FB_ACTIVATE_NOW;
 	par->var.height = -1;
 	par->var.width = -1;
@@ -428,69 +517,158 @@
 }
 #undef FAIL
 
-static int vga16fb_set_par(const struct vga16fb_par *par,
-			   struct vga16fb_info *info)
+static void vga16fb_load_font(struct display* p) {
+	int chars;
+	unsigned char* font;
+	unsigned char* dest;
+	
+	if (!p || !p->fontdata)
+		return;
+	chars = 256;
+	font = p->fontdata;
+	dest = vga16fb.video_vbase;
+	
+	vga_io_wseq(0x00, 0x01);
+	vga_io_wseq(VGA_SEQ_PLANE_WRITE, 0x04);
+	vga_io_wseq(VGA_SEQ_MEMORY_MODE, 0x07);
+	vga_io_wseq(0x00, 0x03);
+	vga_io_wgfx(VGA_GFX_MODE, 0x00);
+	vga_io_wgfx(VGA_GFX_MISC, 0x04);
+	while (chars--) {
+		int i;
+		
+		for (i = fontheight(p); i > 0; i--)
+			writeb(*font++, dest++);
+		dest += 32 - fontheight(p);
+	}
+	vga_io_wseq(0x00, 0x01);
+	vga_io_wseq(VGA_SEQ_PLANE_WRITE, 0x03);
+	vga_io_wseq(VGA_SEQ_MEMORY_MODE, 0x03);
+	vga_io_wseq(0x00, 0x03);
+	vga_io_wgfx(VGA_GFX_MODE, 0x10);
+	vga_io_wgfx(VGA_GFX_MISC, 0x06);
+}
+
+static int vga16fb_set_par(struct vga16fb_par *par,
+			   struct vga16fb_info *info,
+			   struct display *p)
 {
 	int i;
+	int fh;
+	u8 gdc[VGA_GFX_C];
+	u8 seq[VGA_SEQ_C];
+	u8 atc[VGA_ATT_C];
 
-	outb(inb(VGA_MIS_R) | 0x01, VGA_MIS_W);
+	seq[VGA_SEQ_CLOCK_MODE] = 0x01 | par->clkdiv;
+	if (par->mode & MODE_TEXT)
+		seq[VGA_SEQ_PLANE_WRITE] = 0x03;
+	else
+		seq[VGA_SEQ_PLANE_WRITE] = 0x0F;
+	seq[VGA_SEQ_CHARACTER_MAP] = 0x00;
+	if (par->mode & MODE_TEXT)
+		seq[VGA_SEQ_MEMORY_MODE] = 0x03;
+	else if (par->mode & MODE_SKIP4)
+		seq[VGA_SEQ_MEMORY_MODE] = 0x0E;
+	else
+		seq[VGA_SEQ_MEMORY_MODE] = 0x06;
+
+	gdc[VGA_GFX_SR_VALUE] = 0x00;
+	gdc[VGA_GFX_SR_ENABLE] = 0x00;
+	gdc[VGA_GFX_COMPARE_VALUE] = 0x00;
+	gdc[VGA_GFX_DATA_ROTATE] = 0x00;
+	gdc[VGA_GFX_PLANE_READ] = 0;
+	if (par->mode & MODE_TEXT) {
+		gdc[VGA_GFX_MODE] = 0x10;
+		gdc[VGA_GFX_MISC] = 0x06;
+	} else {
+		if (par->mode & MODE_CFB)
+			gdc[VGA_GFX_MODE] = 0x40;
+		else
+			gdc[VGA_GFX_MODE] = 0x00;
+		gdc[VGA_GFX_MISC] = 0x05;
+	}
+	gdc[VGA_GFX_COMPARE_MASK] = 0x0F;
+	gdc[VGA_GFX_BIT_MASK] = 0xFF;
+
+	for (i = 0x00; i < 0x10; i++)
+		atc[i] = i;
+	if (par->mode & MODE_TEXT)
+		atc[VGA_ATC_MODE] = 0x04;
+	else if (par->mode & MODE_8BPP)
+		atc[VGA_ATC_MODE] = 0x41;
+	else
+		atc[VGA_ATC_MODE] = 0x81;
+	atc[VGA_ATC_OVERSCAN] = 0x00;	/* 0 for EGA, 0xFF for VGA */
+	atc[VGA_ATC_PLANE_ENABLE] = 0x0F;
+	if (par->mode & MODE_8BPP)
+		atc[VGA_ATC_PEL] = (par->var.xoffset & 3) << 1;
+	else
+		atc[VGA_ATC_PEL] = par->var.xoffset & 7;
+	atc[VGA_ATC_COLOR_PAGE] = 0x00;
+	
+	if (par->mode & MODE_TEXT) {
+		fh = fontheight(p);
+		if (!fh)
+			fh = 16;
+		par->crtc[VGA_CRTC_MAX_SCAN] = (par->crtc[VGA_CRTC_MAX_SCAN] 
+					       & ~0x1F) | (fh - 1);
+	}
+
+	vga_io_w(VGA_MIS_W, vga_io_r(VGA_MIS_R) | 0x01);
 
 	/* Enable graphics register modification */
 	if (!info->isVGA) {
-		outb(0x00, EGA_GFX_E0);
-		outb(0x01, EGA_GFX_E1);
+		vga_io_w(EGA_GFX_E0, 0x00);
+		vga_io_w(EGA_GFX_E1, 0x01);
 	}
 	
 	/* update misc output register */
-	outb(par->misc, VGA_MIS_W);
+	vga_io_w(VGA_MIS_W, par->misc);
 	
 	/* synchronous reset on */
-	outb(0x00, VGA_SEQ_I);
-	outb(0x01, VGA_SEQ_D);
-	
+	vga_io_wseq(0x00, 0x01);
+
+	if (info->isVGA)
+		vga_io_w(VGA_PEL_MSK, par->pel_msk);
+
 	/* write sequencer registers */
-	outb(1, VGA_SEQ_I);
-	outb(par->seq[1] | 0x20, VGA_SEQ_D);
+	vga_io_wseq(VGA_SEQ_CLOCK_MODE, seq[VGA_SEQ_CLOCK_MODE] | 0x20);
 	for (i = 2; i < VGA_SEQ_C; i++) {
-		outb(i, VGA_SEQ_I);
-		outb(par->seq[i], VGA_SEQ_D);
+		vga_io_wseq(i, seq[i]);
 	}
 	
 	/* synchronous reset off */
-	outb(0x00, VGA_SEQ_I);
-	outb(0x03, VGA_SEQ_D);
-	
+	vga_io_wseq(0x00, 0x03);
+
 	/* deprotect CRT registers 0-7 */
-	outb(0x11, VGA_CRT_IC);
-	outb(par->crtc[0x11], VGA_CRT_DC);
+	vga_io_wcrt(VGA_CRTC_V_SYNC_END, par->crtc[VGA_CRTC_V_SYNC_END]);
 
 	/* write CRT registers */
-	for (i = 0; i < VGA_CRT_C; i++) {
-		outb(i, VGA_CRT_IC);
-		outb(par->crtc[i], VGA_CRT_DC);
+	for (i = 0; i < VGA_CRTC_REGS; i++) {
+		vga_io_wcrt(i, par->crtc[i]);
 	}
 	
 	/* write graphics controller registers */
 	for (i = 0; i < VGA_GFX_C; i++) {
-		outb(i, VGA_GFX_I);
-		outb(par->gdc[i], VGA_GFX_D);
+		vga_io_wgfx(i, gdc[i]);
 	}
 	
 	/* write attribute controller registers */
 	for (i = 0; i < VGA_ATT_C; i++) {
-		inb_p(VGA_IS1_RC);		/* reset flip-flop */
-		outb_p(i, VGA_ATT_IW);
-		outb_p(par->atc[i], VGA_ATT_IW);
+		vga_io_r(VGA_IS1_RC);		/* reset flip-flop */
+		vga_io_wattr(i, atc[i]);
 	}
 
+	if (par->mode & MODE_TEXT)
+		vga16fb_load_font(p);
+		
 	/* Wait for screen to stabilize. */
 	mdelay(50);
 
-	outb(0x01, VGA_SEQ_I);
-	outb(par->seq[1], VGA_SEQ_D);
+	vga_io_wseq(VGA_SEQ_CLOCK_MODE, seq[VGA_SEQ_CLOCK_MODE]);
 
-	inb(VGA_IS1_RC);
-	outb(0x20, VGA_ATT_IW);
+	vga_io_r(VGA_IS1_RC);
+	vga_io_w(VGA_ATT_IW, 0x20);
 	
 	return 0;
 }
@@ -507,33 +685,39 @@
 		display = fb->disp;
 	else
 		display = fb_display + con;
-	if ((err = vga16fb_decode_var(var, &par, info)) != 0)
+	if ((err = vga16fb_decode_var(var, &par, info, display)) != 0)
 		return err;
-	vga16fb_encode_var(var, &par, info);
 	
 	if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_TEST)
 		return 0;
 
 	if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
-		u32 oldxres, oldyres, oldvxres, oldvyres, oldbpp;
+		u32 oldxres, oldyres, oldvxres, oldvyres, oldbpp, oldnonstd;
 
 		oldxres = display->var.xres;
 		oldyres = display->var.yres;
 		oldvxres = display->var.xres_virtual;
 		oldvyres = display->var.yres_virtual;
 		oldbpp = display->var.bits_per_pixel;
+		oldnonstd = display->var.nonstd;
 
-		display->var = *var;
+		display->var = par.var;
 
-		if (oldxres != var->xres || oldyres != var->yres ||
-		    oldvxres != var->xres_virtual || oldvyres != var->yres_virtual ||
-		    oldbpp != var->bits_per_pixel) {
-			vga16fb_set_disp(con, info);
+		if (con == info->fb_info.currcon) {
+			info->fb_info.var = par.var;
+			vga16fb_set_disp(display, info);
+		}
+		if (oldxres != var->xres || 
+		    oldyres != var->yres ||
+		    oldvxres != var->xres_virtual || 
+		    oldvyres != var->yres_virtual ||
+		    oldbpp != var->bits_per_pixel || 
+		    oldnonstd != var->nonstd) {
 			if (info->fb_info.changevar)
 				info->fb_info.changevar(con);
 		}
 		if (con == info->fb_info.currcon)
-			vga16fb_set_par(&par, info);
+			vga16fb_set_par(&par, info, display);
 	}
 
 	return 0;
@@ -544,12 +728,13 @@
 	static unsigned char map[] = { 000, 001, 010, 011 };
 	int val;
 	
+	if (regno >= 16)
+		return;
 	val = map[red>>14] | ((map[green>>14]) << 1) | ((map[blue>>14]) << 2);
-	inb_p(0x3DA);   /* ! 0x3BA */
-	outb_p(regno, 0x3C0);
-	outb_p(val, 0x3C0);
-	inb_p(0x3DA);   /* some clones need it */
-	outb_p(0x20, 0x3C0); /* unblank screen */
+	vga_io_r(VGA_IS1_RC);   /* ! 0x3BA */
+	vga_io_wattr(regno, val);
+	vga_io_r(VGA_IS1_RC);   /* some clones need it */
+	vga_io_w(VGA_ATT_IW, 0x20); /* unblank screen */
 }
 
 static int vga16_getcolreg(unsigned regno, unsigned *red, unsigned *green,
@@ -561,7 +746,7 @@
 	 *  Return != 0 for invalid regno.
 	 */
 
-	if (regno >= 16)
+	if (regno >= 256)
 		return 1;
 
 	*red   = palette[regno].red;
@@ -592,17 +777,14 @@
 	 *  != 0 for invalid regno.
 	 */
 	
-	if (regno >= 16)
+	if (regno >= 256)
 		return 1;
 
 	palette[regno].red   = red;
 	palette[regno].green = green;
 	palette[regno].blue  = blue;
 	
-	if (fb_info->currcon < 0)
-		gray = disp.var.grayscale;
-	else
-		gray = fb_display[fb_info->currcon].var.grayscale;
+	gray = fb_info->var.grayscale;
 	if (gray) {
 		/* gray = 0.30*R + 0.59*G + 0.11*B */
 		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
@@ -635,7 +817,7 @@
 	    var->yoffset + fb_display[con].var.yres > fb_display[con].var.yres_virtual)
 		return -EINVAL;
 	if (con == info->currcon)
-		vga16fb_pan_var(info, var);
+		vga16fb_pan_var(info, var, fb_display + con);
 	fb_display[con].var.xoffset = var->xoffset;
 	fb_display[con].var.yoffset = var->yoffset;
 	fb_display[con].var.vmode &= ~FB_VMODE_YWRAP;
@@ -646,59 +828,49 @@
    blanking code was originally by Huang shi chao, and modified by
    Christoph Rimek (chrimek@toppoint.de) and todd j. derr
    (tjd@barefoot.org) for Linux. */
-#define attrib_port	0x3c0
-#define seq_port_reg	0x3c4
-#define seq_port_val	0x3c5
-#define gr_port_reg	0x3ce
-#define gr_port_val	0x3cf
-#define video_misc_rd	0x3cc
-#define video_misc_wr	0x3c2
-#define vga_video_port_reg	0x3d4
-#define vga_video_port_val	0x3d5
+#define attrib_port	VGA_ATC_IW
+#define seq_port_reg	VGA_SEQ_I
+#define seq_port_val	VGA_SEQ_D
+#define gr_port_reg	VGA_GFX_I
+#define gr_port_val	VGA_GFX_D
+#define video_misc_rd	VGA_MIS_R
+#define video_misc_wr	VGA_MIS_W
+#define vga_video_port_reg	VGA_CRT_IC
+#define vga_video_port_val	VGA_CRT_DC
 
 static void vga_vesa_blank(struct vga16fb_info *info, int mode)
 {
 	unsigned char SeqCtrlIndex;
 	unsigned char CrtCtrlIndex;
 	
-	cli();
-	SeqCtrlIndex = inb_p(seq_port_reg);
-	CrtCtrlIndex = inb_p(vga_video_port_reg);
+	//cli();
+	SeqCtrlIndex = vga_io_r(seq_port_reg);
+	CrtCtrlIndex = vga_io_r(vga_video_port_reg);
 
 	/* save original values of VGA controller registers */
 	if(!info->vesa_blanked) {
-		info->vga_state.CrtMiscIO = inb_p(video_misc_rd);
-		sti();
+		info->vga_state.CrtMiscIO = vga_io_r(video_misc_rd);
+		//sti();
 
-		outb_p(0x00,vga_video_port_reg);	/* HorizontalTotal */
-		info->vga_state.HorizontalTotal = inb_p(vga_video_port_val);
-		outb_p(0x01,vga_video_port_reg);	/* HorizDisplayEnd */
-		info->vga_state.HorizDisplayEnd = inb_p(vga_video_port_val);
-		outb_p(0x04,vga_video_port_reg);	/* StartHorizRetrace */
-		info->vga_state.StartHorizRetrace = inb_p(vga_video_port_val);
-		outb_p(0x05,vga_video_port_reg);	/* EndHorizRetrace */
-		info->vga_state.EndHorizRetrace = inb_p(vga_video_port_val);
-		outb_p(0x07,vga_video_port_reg);	/* Overflow */
-		info->vga_state.Overflow = inb_p(vga_video_port_val);
-		outb_p(0x10,vga_video_port_reg);	/* StartVertRetrace */
-		info->vga_state.StartVertRetrace = inb_p(vga_video_port_val);
-		outb_p(0x11,vga_video_port_reg);	/* EndVertRetrace */
-		info->vga_state.EndVertRetrace = inb_p(vga_video_port_val);
-		outb_p(0x17,vga_video_port_reg);	/* ModeControl */
-		info->vga_state.ModeControl = inb_p(vga_video_port_val);
-		outb_p(0x01,seq_port_reg);		/* ClockingMode */
-		info->vga_state.ClockingMode = inb_p(seq_port_val);
+		info->vga_state.HorizontalTotal = vga_io_rcrt(0x00);	/* HorizontalTotal */
+		info->vga_state.HorizDisplayEnd = vga_io_rcrt(0x01);	/* HorizDisplayEnd */
+		info->vga_state.StartHorizRetrace = vga_io_rcrt(0x04);	/* StartHorizRetrace */
+		info->vga_state.EndHorizRetrace = vga_io_rcrt(0x05);	/* EndHorizRetrace */
+		info->vga_state.Overflow = vga_io_rcrt(0x07);		/* Overflow */
+		info->vga_state.StartVertRetrace = vga_io_rcrt(0x10);	/* StartVertRetrace */
+		info->vga_state.EndVertRetrace = vga_io_rcrt(0x11);	/* EndVertRetrace */
+		info->vga_state.ModeControl = vga_io_rcrt(0x17);	/* ModeControl */
+		info->vga_state.ClockingMode = vga_io_rseq(0x01);	/* ClockingMode */
 	}
 
 	/* assure that video is enabled */
 	/* "0x20" is VIDEO_ENABLE_bit in register 01 of sequencer */
-	cli();
-	outb_p(0x01,seq_port_reg);
-	outb_p(info->vga_state.ClockingMode | 0x20,seq_port_val);
+	//cli();
+	vga_io_wseq(0x01, info->vga_state.ClockingMode | 0x20);
 
 	/* test for vertical retrace in process.... */
 	if ((info->vga_state.CrtMiscIO & 0x80) == 0x80)
-		outb_p(info->vga_state.CrtMiscIO & 0xef,video_misc_wr);
+		vga_io_w(video_misc_wr, info->vga_state.CrtMiscIO & 0xef);
 
 	/*
 	 * Set <End of vertical retrace> to minimum (0) and
@@ -729,7 +901,7 @@
 	/* restore both index registers */
 	outb_p(SeqCtrlIndex,seq_port_reg);
 	outb_p(CrtCtrlIndex,vga_video_port_reg);
-	sti();
+	//sti();
 }
 
 static void vga_vesa_unblank(struct vga16fb_info *info)
@@ -737,36 +909,36 @@
 	unsigned char SeqCtrlIndex;
 	unsigned char CrtCtrlIndex;
 	
-	cli();
-	SeqCtrlIndex = inb_p(seq_port_reg);
-	CrtCtrlIndex = inb_p(vga_video_port_reg);
+	//cli();
+	SeqCtrlIndex = vga_io_r(seq_port_reg);
+	CrtCtrlIndex = vga_io_r(vga_video_port_reg);
 
 	/* restore original values of VGA controller registers */
-	outb_p(info->vga_state.CrtMiscIO,video_misc_wr);
+	vga_io_w(video_misc_wr, info->vga_state.CrtMiscIO);
 
-	outb_p(0x00,vga_video_port_reg);		/* HorizontalTotal */
-	outb_p(info->vga_state.HorizontalTotal,vga_video_port_val);
-	outb_p(0x01,vga_video_port_reg);		/* HorizDisplayEnd */
-	outb_p(info->vga_state.HorizDisplayEnd,vga_video_port_val);
-	outb_p(0x04,vga_video_port_reg);		/* StartHorizRetrace */
-	outb_p(info->vga_state.StartHorizRetrace,vga_video_port_val);
-	outb_p(0x05,vga_video_port_reg);		/* EndHorizRetrace */
-	outb_p(info->vga_state.EndHorizRetrace,vga_video_port_val);
-	outb_p(0x07,vga_video_port_reg);		/* Overflow */
-	outb_p(info->vga_state.Overflow,vga_video_port_val);
-	outb_p(0x10,vga_video_port_reg);		/* StartVertRetrace */
-	outb_p(info->vga_state.StartVertRetrace,vga_video_port_val);
-	outb_p(0x11,vga_video_port_reg);		/* EndVertRetrace */
-	outb_p(info->vga_state.EndVertRetrace,vga_video_port_val);
-	outb_p(0x17,vga_video_port_reg);		/* ModeControl */
-	outb_p(info->vga_state.ModeControl,vga_video_port_val);
-	outb_p(0x01,seq_port_reg);		/* ClockingMode */
-	outb_p(info->vga_state.ClockingMode,seq_port_val);
+	/* HorizontalTotal */
+	vga_io_wcrt(0x00, info->vga_state.HorizontalTotal);
+	/* HorizDisplayEnd */
+	vga_io_wcrt(0x01, info->vga_state.HorizDisplayEnd);
+	/* StartHorizRetrace */
+	vga_io_wcrt(0x04, info->vga_state.StartHorizRetrace);
+	/* EndHorizRetrace */
+	vga_io_wcrt(0x05, info->vga_state.EndHorizRetrace);
+	/* Overflow */
+	vga_io_wcrt(0x07, info->vga_state.Overflow);
+	/* StartVertRetrace */
+	vga_io_wcrt(0x10, info->vga_state.StartVertRetrace);
+	/* EndVertRetrace */
+	vga_io_wcrt(0x11, info->vga_state.EndVertRetrace);
+	/* ModeControl */
+	vga_io_wcrt(0x17, info->vga_state.ModeControl);
+	/* ClockingMode */
+	vga_io_wseq(0x01, info->vga_state.ClockingMode);
 
 	/* restore index/control registers */
-	outb_p(SeqCtrlIndex,seq_port_reg);
-	outb_p(CrtCtrlIndex,vga_video_port_reg);
-	sti();
+	vga_io_w(seq_port_reg, SeqCtrlIndex);
+	vga_io_w(vga_video_port_reg, CrtCtrlIndex);
+	//sti();
 }
 
 static void vga_pal_blank(void)
@@ -811,8 +983,6 @@
 
 static struct fb_ops vga16fb_ops = {
 	.owner =	THIS_MODULE,
-	.fb_get_fix =	vga16fb_get_fix,
-	.fb_get_var =	vga16fb_get_var,
 	.fb_set_var =	vga16fb_set_var,
 	.fb_get_cmap =	vga16fb_get_cmap,
 	.fb_set_cmap =	gen_set_cmap,
@@ -845,14 +1015,17 @@
 	struct vga16fb_info *info = (struct vga16fb_info*)fb;
 
 	/* Do we have to save the colormap? */
-	if (fb_display[fb->currcon].cmap.len)
-		fb_get_cmap(&fb_display[fb->currcon].cmap, 1, vga16_getcolreg,
-			    fb);
+	if (fb->currcon >= 0) {
+		if (fb_display[fb->currcon].cmap.len)
+			fb_get_cmap(&fb_display[fb->currcon].cmap, 1, vga16_getcolreg,
+				    fb);
+	}
 	
 	fb->currcon = con;
-	vga16fb_decode_var(&fb_display[con].var, &par, info);
-	vga16fb_set_par(&par, info);
-	vga16fb_set_disp(con, info);
+	vga16fb_decode_var(&fb_display[con].var, &par, info, fb_display + con);
+	fb->var = par.var;
+	vga16fb_set_par(&par, info, fb_display + con);
+	vga16fb_set_disp(fb_display + con, info);
 
 	/* Install new colormap */
 	do_install_cmap(con, fb);
@@ -906,7 +1079,7 @@
 	vga16fb.fb_info.switch_con=&vga16fb_switch;
 	vga16fb.fb_info.updatevar=&vga16fb_update_var;
 	vga16fb.fb_info.flags=FBINFO_FLAG_DEFAULT;
-	vga16fb_set_disp(-1, &vga16fb);
+	vga16fb_set_disp(&disp, &vga16fb);
 
 	if (register_framebuffer(&vga16fb.fb_info)<0) {
 		iounmap(vga16fb.video_vbase);
diff -urdN linux/drivers/video/vgacon.c linux/drivers/video/vgacon.c
--- linux/drivers/video/vgacon.c	2002-10-13 02:32:50.000000000 +0200
+++ linux/drivers/video/vgacon.c	2002-10-13 02:41:20.000000000 +0200
@@ -180,6 +180,13 @@
 #endif
 	}
 
+	/* VGA16 modes are not handled by VGACON */
+	if ((ORIG_VIDEO_MODE == 0x0D) || /* 320x200/4 */
+	    (ORIG_VIDEO_MODE == 0x0E) || /* 640x200/4 */
+	    (ORIG_VIDEO_MODE == 0x10) || /* 640x350/4 */
+	    (ORIG_VIDEO_MODE == 0x12) || /* 640x480/4 */
+	    (ORIG_VIDEO_MODE == 0x6A))   /* 800x600/4, 0x6A is very common */
+		goto no_vga;
 
 	vga_video_num_lines = ORIG_VIDEO_LINES;
 	vga_video_num_columns = ORIG_VIDEO_COLS;
diff -urdN linux/include/video/fbcon-vga-planes.h linux/include/video/fbcon-vga-planes.h
--- linux/include/video/fbcon-vga-planes.h	2002-10-13 02:33:17.000000000 +0200
+++ linux/include/video/fbcon-vga-planes.h	2002-10-13 02:41:20.000000000 +0200
@@ -18,6 +18,7 @@
 #endif
 
 extern struct display_switch fbcon_vga_planes;
+extern struct display_switch fbcon_vga8_planes;
 extern struct display_switch fbcon_ega_planes;
 extern void fbcon_vga_planes_setup(struct display *p);
 extern void fbcon_vga_planes_bmove(struct display *p, int sy, int sx, int dy, int dx,
