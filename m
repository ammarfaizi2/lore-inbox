Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262648AbSLCRse>; Tue, 3 Dec 2002 12:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262730AbSLCRse>; Tue, 3 Dec 2002 12:48:34 -0500
Received: from [203.167.79.9] ([203.167.79.9]:60680 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S262648AbSLCRs0>; Tue, 3 Dec 2002 12:48:26 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH] FBDev: vga16fb port
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0212022027510.18805-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0212022027510.18805-100000@phoenix.infradead.org>
Content-Type: multipart/mixed; boundary="=-agNDNyZP3AMBNgJVN6wJ"
Message-Id: <1038947910.1040.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Dec 2002 01:49:36 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-agNDNyZP3AMBNgJVN6wJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2002-12-03 at 01:31, James Simmons wrote:
James,

>   2) The ability to go back to vga text mode on close of /dev/fb. 
>      Yes fbdev/fbcon supports that now. 
>  

Here's a preliminary and highly unpolished patch for saving and
restoring the initial vga state.  The module allows saving/restoring of
specific hardware states (vga fonts/character maps, color map, and/or
video mode) by specifying different flags. Most hardware probably will
just need restoring of the initial video mode though.  Hopefully, it
should be generic enough to complement device specific state save and
restore routines. 

For testing purposes, I also patched vga16fb.c to use the module during
fb_open and fb_release.  Try loading vga16fb, and when opened, the video
mode will change.  On close, the state of vgacon should be restored. I
have tested this with two different VGA cards, and both seems to work
quite well. However, color map and character map state restores are still untested.  

Note that the module still makes assumptions that may not be necessarily
correct for all hardware (ie vga base is at 0xa0000). Secondly, there's
no check if the card is in VGA mode, EGA mode, or graphics mode. Please
review.

Tony

--=-agNDNyZP3AMBNgJVN6wJ
Content-Disposition: attachment; filename=vgastate.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=vgastate.diff; charset=UTF-8

diff -Naur linux-2.5.50-js/drivers/video/Makefile linux/drivers/video/Makef=
ile
--- linux-2.5.50-js/drivers/video/Makefile	2002-12-03 19:55:25.000000000 +0=
000
+++ linux/drivers/video/Makefile	2002-12-03 19:57:14.000000000 +0000
@@ -6,7 +6,7 @@
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
=20
 export-objs    	:=3D fbmem.o fbcmap.o fbmon.o modedb.o softcursor.o cfbfil=
lrect.o \
-		   cfbcopyarea.o cfbimgblt.o cyber2000fb.o=20
+		   cfbcopyarea.o cfbimgblt.o vgastate.o cyber2000fb.o=20
=20
 # Each configuration option enables a list of files.
=20
@@ -50,7 +50,7 @@
 obj-$(CONFIG_FB_S3TRIO)           +=3D S3triofb.o
 obj-$(CONFIG_FB_TGA)              +=3D tgafb.o
 obj-$(CONFIG_FB_VESA)             +=3D vesafb.o cfbfillrect.o cfbcopyarea.=
o cfbimgblt.o=20
-obj-$(CONFIG_FB_VGA16)            +=3D vga16fb.o cfbfillrect.o cfbcopyarea=
.o cfbimgblt.o=20
+obj-$(CONFIG_FB_VGA16)            +=3D vga16fb.o cfbfillrect.o cfbcopyarea=
.o cfbimgblt.o vgastate.o
 obj-$(CONFIG_FB_VIRGE)            +=3D virgefb.o
 obj-$(CONFIG_FB_G364)             +=3D g364fb.o cfbfillrect.o cfbcopyarea.=
o cfbimgblt.o
 obj-$(CONFIG_FB_FM2)              +=3D fm2fb.o cfbfillrect.o cfbcopyarea.o=
 cfbimgblt.o
diff -Naur linux-2.5.50-js/drivers/video/vga16fb.c linux/drivers/video/vga1=
6fb.c
--- linux-2.5.50-js/drivers/video/vga16fb.c	2002-12-03 19:55:29.000000000 +=
0000
+++ linux/drivers/video/vga16fb.c	2002-12-03 19:56:45.000000000 +0000
@@ -7,7 +7,8 @@
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
- * archive for more details.  */
+ * archive for more details. =20
+ */
=20
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -22,7 +23,7 @@
 #include <linux/init.h>
=20
 #include <asm/io.h>
-#include "vga.h"
+#include "vgastate.h"
=20
 #define GRAPHICS_ADDR_REG VGA_GFX_I	/* Graphics address register. */
 #define GRAPHICS_DATA_REG VGA_GFX_D	/* Graphics data register. */
@@ -69,6 +70,8 @@
 		unsigned char	ModeControl;		/* CRT-Controller:17h */
 		unsigned char	ClockingMode;		/* Seq-Controller:01h */
 	} vga_state;
+	struct fb_vgastate state;
+	atomic_t ref_count;
 	int palette_blanked, vesa_blanked, mode, isVGA;
 	u8 misc, pel_msk, vss, clkdiv;
 	u8 crtc[VGA_CRT_C];
@@ -295,6 +298,34 @@
 			      =20
 #define FAIL(X) return -EINVAL
=20
+static int vga16fb_open(struct fb_info *info, int user)
+{
+	struct vga16fb_par *par =3D (struct vga16fb_par *) info->par;
+	int cnt =3D atomic_read(&par->ref_count);
+
+	if (!cnt) {
+		memset(&par->state, 0, sizeof(struct fb_vgastate));
+		par->state.flags =3D 8;
+		fb_save_vga(&par->state);
+	}
+	atomic_inc(&par->ref_count);
+	return 0;
+}
+
+static int vga16fb_release(struct fb_info *info, int user)
+{
+	struct vga16fb_par *par =3D (struct vga16fb_par *) info->par;
+	int cnt =3D atomic_read(&par->ref_count);
+
+	if (!cnt)
+		return -EINVAL;
+	if (cnt =3D=3D 1)
+		fb_restore_vga(&par->state);
+	atomic_dec(&par->ref_count);
+
+	return 0;
+}
+
 static int vga16fb_check_var(struct fb_var_screeninfo *var,
 			     struct fb_info *info)
 {
@@ -1346,6 +1377,8 @@
=20
 static struct fb_ops vga16fb_ops =3D {
 	.owner		=3D THIS_MODULE,
+	.fb_open        =3D vga16fb_open,
+	.fb_release     =3D vga16fb_release,
 	.fb_check_var	=3D vga16fb_check_var,
 	.fb_set_par	=3D vga16fb_set_par,
 	.fb_setcolreg 	=3D vga16fb_setcolreg,
diff -Naur linux-2.5.50-js/drivers/video/vgastate.c linux/drivers/video/vga=
state.c
--- linux-2.5.50-js/drivers/video/vgastate.c	1970-01-01 00:00:00.000000000 =
+0000
+++ linux/drivers/video/vgastate.c	2002-12-03 19:56:54.000000000 +0000
@@ -0,0 +1,425 @@
+/*
+ * linux/include/video/vgastate.c -- VGA state save/restore
+ *
+ * Copyright 2002 James Simmons
+ *=20
+ * Copyright history from vga16fb.c:
+ *	Copyright 1999 Ben Pfaff and Petr Vandrovec
+ *	Based on VGA info at http://www.goodnet.com/~tinara/FreeVGA/home.htm
+ *	Based on VESA framebuffer (c) 1998 Gerd Knorr
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details. =20
+ *
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include "vgastate.h"
+
+static inline unsigned char vga_rcrtcs(caddr_t regbase, unsigned short iob=
ase,=20
+				       unsigned char reg)
+{
+	vga_w(regbase, iobase + 0x4, reg);
+	return vga_r(regbase, iobase + 0x5);
+}
+
+static inline void vga_wcrtcs(caddr_t regbase, unsigned short iobase,=20
+			      unsigned char reg, unsigned char val)
+{
+	vga_w(regbase, iobase + 0x4, reg);
+	vga_w(regbase, iobase + 0x5, val);
+}
+			     =20
+static void save_vga_text(struct fb_vgastate *state)
+{
+	int i;
+	u8 misc, attr10, gr4, gr5, gr6, seq2, seq4, seq1;
+
+	/* if in graphics mode, no need to save */
+	attr10 =3D vga_rattr(state->vgabase, 0x10);
+	if (attr10 & 1)
+		return;
+=09
+	/* blank screen */
+	seq1 =3D vga_rseq(state->vgabase, VGA_SEQ_CLOCK_MODE);
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x1);
+	vga_wseq(state->vgabase, VGA_SEQ_CLOCK_MODE, seq1 | 1 << 5);
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x3);
+
+	misc =3D vga_r(state->vgabase, VGA_MIS_R);
+	gr4 =3D vga_rgfx(state->vgabase, VGA_GFX_PLANE_READ);
+	gr5 =3D vga_rgfx(state->vgabase, VGA_GFX_MODE);
+	gr6 =3D vga_rgfx(state->vgabase, VGA_GFX_MISC);
+	seq2 =3D vga_rseq(state->vgabase, VGA_SEQ_PLANE_WRITE);
+	seq4 =3D vga_rseq(state->vgabase, VGA_SEQ_MEMORY_MODE);
+=09
+	/* force graphics mode */
+	vga_w(state->vgabase, VGA_MIS_W, misc | 1);
+
+	/* save font 0 */
+	if (state->flags & VGA_SAVE_FONT0) {
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x4);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x2);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 8 * 8192; i++)=20
+			state->vga_text0[i] =3D vga_r(state->fbbase, i);
+	}
+	/* save font 1 */
+	if (state->flags & VGA_SAVE_FONT1) {
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x8);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x3);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 8 * 8192; i++)=20
+			state->vga_text1[i] =3D vga_r(state->fbbase, i);
+	}
+	/* save font 2 */
+	if (state->flags & VGA_SAVE_TEXT) {
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x1);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 2 * 8192; i++)=20
+			state->vga_text2[i] =3D vga_r(state->fbbase, i);
+	=09
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x2);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x1);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 2 * 8192; i++)=20
+			state->vga_text2[i] =3D vga_r(state->fbbase + 2 * 8192, i);
+	}
+
+	/* restore regs */
+	vga_wattr(state->vgabase, 0x10, attr10);
+	vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, seq2);
+	vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, seq4);
+	vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, gr4);
+	vga_wgfx(state->vgabase, VGA_GFX_MODE, gr5);
+	vga_wgfx(state->vgabase, VGA_GFX_MISC, gr6);
+	vga_w(state->vgabase, VGA_MIS_W, misc);
+
+	/* unblank screen */
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x1);
+	vga_wseq(state->vgabase, VGA_SEQ_CLOCK_MODE, seq1 & ~(1 << 5));
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x3);
+}
+
+static void restore_vga_text(struct fb_vgastate *state)
+{
+	int i;
+	u8 misc, attr10, gr1, gr3, gr4, gr5, gr6, gr8;=20
+	u8 seq2, seq4, seq1;
+
+	/* blank screen */
+	seq1 =3D vga_rseq(state->vgabase, VGA_SEQ_CLOCK_MODE);
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x1);
+	vga_wseq(state->vgabase, VGA_SEQ_CLOCK_MODE, seq1 | 1 << 5);
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x3);
+
+	misc =3D vga_r(state->vgabase, VGA_MIS_R);
+	attr10 =3D vga_rattr(state->vgabase, 0x10);
+	gr1 =3D vga_rgfx(state->vgabase, VGA_GFX_SR_ENABLE);
+	gr3 =3D vga_rgfx(state->vgabase, VGA_GFX_DATA_ROTATE);
+	gr4 =3D vga_rgfx(state->vgabase, VGA_GFX_PLANE_READ);
+	gr5 =3D vga_rgfx(state->vgabase, VGA_GFX_MODE);
+	gr6 =3D vga_rgfx(state->vgabase, VGA_GFX_MISC);
+	gr8 =3D vga_rgfx(state->vgabase, VGA_GFX_BIT_MASK);
+	seq2 =3D vga_rseq(state->vgabase, VGA_SEQ_PLANE_WRITE);
+	seq4 =3D vga_rseq(state->vgabase, VGA_SEQ_MEMORY_MODE);
+=09
+	/* force graphics mode */
+	vga_w(state->vgabase, VGA_MIS_W, misc | 1);
+
+	if (state->depth =3D=3D 4) {
+		vga_wgfx(state->vgabase, VGA_GFX_DATA_ROTATE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_BIT_MASK, 0xff);
+		vga_wgfx(state->vgabase, VGA_GFX_SR_ENABLE, 0x00);
+	}
+	/* restore font 0 */
+	if (state->flags & VGA_SAVE_FONT0) {
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x4);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x2);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 8 * 8192; i++)=20
+			vga_w(state->fbbase, i, state->vga_text0[i]);
+	}
+	/* restore font 1 */
+	if (state->flags & VGA_SAVE_FONT1) {
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x8);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x3);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 8 * 8192; i++)=20
+			vga_w(state->fbbase, i, state->vga_text1[i]);
+	}
+	/* restore font 2 */
+	if (state->flags & VGA_SAVE_TEXT) {
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x1);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 2 * 8192; i++)=20
+			vga_w(state->fbbase, i, state->vga_text2[i]);
+	=09
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x2);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x1);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 2 * 8192; i++)=20
+			vga_w(state->fbbase + 2 * 8192, i, state->vga_text2[i]);
+	}
+
+	/* restore regs */
+	vga_w(state->vgabase, VGA_MIS_W, misc);
+	vga_wattr(state->vgabase, 0x10, attr10);
+	vga_wgfx(state->vgabase, VGA_GFX_SR_ENABLE, gr1);
+	vga_wgfx(state->vgabase, VGA_GFX_DATA_ROTATE, gr3);
+	vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, gr4);
+	vga_wgfx(state->vgabase, VGA_GFX_MODE, gr5);
+	vga_wgfx(state->vgabase, VGA_GFX_MISC, gr6);
+	vga_wgfx(state->vgabase, VGA_GFX_BIT_MASK, gr8);
+	vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, seq2);
+	vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, seq4);
+
+	/* unblank screen */
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x1);
+	vga_wseq(state->vgabase, VGA_SEQ_CLOCK_MODE, seq1 & ~(1 << 5));
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x3);
+}
+
+static void save_vga_mode(struct fb_vgastate *state)
+{
+	unsigned short iobase;
+	int i;
+
+	state->misc =3D vga_r(state->vgabase, VGA_MIS_R);
+	if (state->misc & 1)
+		iobase =3D 0x3d0;
+	else
+		iobase =3D 0x3b0;
+
+	for (i =3D 0; i < state->num_crtc; i++)=20
+		state->crtc[i] =3D vga_rcrtcs(state->vgabase, iobase, i);
+=09
+	vga_r(state->vgabase, iobase + 0xa);
+	vga_w(state->vgabase, VGA_ATT_W, 0x00);
+	for (i =3D 0; i < state->num_attr; i++) {
+		vga_r(state->vgabase, iobase + 0xa);
+		state->attr[i] =3D vga_rattr(state->vgabase, i);
+	}
+	vga_r(state->vgabase, iobase + 0xa);
+	vga_w(state->vgabase, VGA_ATT_W, 0x20);
+
+	for (i =3D 0; i < state->num_gfx; i++)=20
+		state->gfx[i] =3D vga_rgfx(state->vgabase, i);
+
+	for (i =3D 0; i < state->num_seq; i++)=20
+		state->seq[i] =3D vga_rseq(state->vgabase, i);
+}
+
+static void restore_vga_mode(struct fb_vgastate *state)
+{
+	unsigned short iobase;
+	int i;
+
+	vga_w(state->vgabase, VGA_MIS_W, state->misc);
+
+	if (state->misc & 1)
+		iobase =3D 0x3d0;
+	else
+		iobase =3D 0x3b0;
+
+	vga_io_wseq(0x00, 0x01);
+	vga_io_wseq(VGA_SEQ_CLOCK_MODE, state->seq[VGA_SEQ_CLOCK_MODE] | 0x20);
+
+	for (i =3D 2; i < state->num_seq; i++)=20
+		vga_wseq(state->vgabase, i, state->seq[i]);
+
+	vga_io_wseq(0x00, 0x03);
+
+	/* unprotect vga regs */
+	vga_wcrtcs(state->vgabase, iobase, 17, state->crtc[17] & ~0x80);
+	for (i =3D 0; i < state->num_crtc; i++)=20
+		vga_wcrtcs(state->vgabase, iobase, i, state->crtc[i]);
+=09
+	for (i =3D 0; i < state->num_gfx; i++)=20
+		vga_wgfx(state->vgabase, i, state->gfx[i]);
+
+	vga_r(state->vgabase, iobase + 0xa);
+	vga_w(state->vgabase, VGA_ATT_W, 0x00);
+	for (i =3D 0; i < state->num_attr; i++) {
+		vga_r(state->vgabase, iobase + 0xa);
+		vga_wattr(state->vgabase, i, state->attr[i]);
+	}
+
+	vga_io_wseq(VGA_SEQ_CLOCK_MODE, state->seq[VGA_SEQ_CLOCK_MODE]);
+
+	vga_r(state->vgabase, iobase + 0xa);
+	vga_w(state->vgabase, VGA_ATT_W, 0x20);
+}
+
+static void save_vga_cmap(struct fb_vgastate *state)
+{
+	int i;
+
+	vga_w(state->vgabase, VGA_PEL_MSK, 0xff);
+=09
+	/* assumes DAC is readable and writable */
+	vga_w(state->vgabase, VGA_PEL_IR, 0x00);
+	for (i =3D 0; i < 768; i++)
+		state->vga_cmap[i] =3D vga_r(state->vgabase, VGA_PEL_D);
+}
+
+static void restore_vga_cmap(struct fb_vgastate *state)
+{
+	int i;
+
+	vga_w(state->vgabase, VGA_PEL_MSK, 0xff);
+
+	vga_w(state->vgabase, VGA_PEL_IW, 0x00);
+	for (i =3D 0; i < 768; i++)
+		vga_w(state->vgabase, VGA_PEL_D, state->vga_cmap[i]);
+}
+
+static void vga_cleanup(struct fb_vgastate *state)
+{
+	if (state->vga_text0)=20
+		kfree(state->vga_text0);
+	if (state->vga_text1)=20
+		kfree(state->vga_text1);
+	if (state->vga_text2)
+		kfree(state->vga_text2);
+	if (state->fbbase)
+		iounmap(state->fbbase);
+	if (state->vga_cmap)
+		kfree(state->vga_cmap);
+	if (state->attr)
+		kfree(state->attr);
+	if (state->crtc)
+		kfree(state->crtc);
+	if (state->gfx)
+		kfree(state->gfx);
+	if (state->seq)
+		kfree(state->seq);
+}
+	=09
+int fb_save_vga(struct fb_vgastate *state)
+{
+	state->vga_text0 =3D NULL;
+	state->vga_text1 =3D NULL;
+	state->vga_text2 =3D NULL;
+	state->vga_cmap =3D NULL;
+	state->attr =3D NULL;
+	state->crtc =3D NULL;
+	state->gfx =3D NULL;
+	state->seq =3D NULL;
+	=09
+	if (state->flags & VGA_SAVE_CMAP) {
+		state->vga_cmap =3D kmalloc(768, GFP_KERNEL);
+		if (!state->vga_cmap) {
+			vga_cleanup(state);
+			return 1;
+		}
+		save_vga_cmap(state);
+	}
+
+	if (state->flags & VGA_SAVE_MODE) {
+		if (state->num_attr < 21)
+			state->num_attr =3D 21;
+		if (state->num_crtc < 25)
+			state->num_crtc =3D 25;
+		if (state->num_gfx < 9)
+			state->num_gfx =3D 9;
+		if (state->num_seq < 5)
+			state->num_seq =3D 5;
+		state->attr =3D kmalloc(state->num_attr, GFP_KERNEL);
+		state->crtc =3D kmalloc(state->num_crtc, GFP_KERNEL);
+		state->gfx =3D kmalloc(state->num_gfx, GFP_KERNEL);
+		state->seq =3D kmalloc(state->num_seq, GFP_KERNEL);
+		if (!state->attr || !state->crtc || !state->gfx ||
+		    !state->seq) {
+			vga_cleanup(state);
+			return 1;
+		}
+		save_vga_mode(state);
+	}
+
+	if (state->flags & VGA_SAVE_FONT0) {
+		state->vga_text0 =3D kmalloc(8192 * 8, GFP_KERNEL);
+		if (!state->vga_text0) {
+			vga_cleanup(state);
+			return 1;
+		}
+	}
+	if (state->flags & VGA_SAVE_FONT1) {
+		state->vga_text1 =3D kmalloc(8192 * 8, GFP_KERNEL);
+		if (!state->vga_text1) {
+			vga_cleanup(state);
+			return 1;
+		}
+	}
+	if (state->flags & VGA_SAVE_TEXT) {
+		state->vga_text2 =3D kmalloc(8192 * 4, GFP_KERNEL);
+		if (!state->vga_text2) {
+			vga_cleanup(state);
+			return 1;
+		}
+	}
+	if (state->flags & VGA_SAVE_FONTS) {
+		state->fbbase =3D ioremap(0xA0000, 8 * 8192);
+		if (!state->fbbase) {
+			vga_cleanup(state);
+			return 1;
+		}
+		save_vga_text(state);
+		iounmap(state->fbbase);
+		state->fbbase =3D NULL;
+	}
+	return 0;
+}
+
+int fb_restore_vga (struct fb_vgastate *state)
+{
+	if (state->flags & VGA_SAVE_MODE)
+		restore_vga_mode(state);
+
+	if (state->flags & VGA_SAVE_FONTS) {
+		state->fbbase =3D ioremap(0xA0000, 8 * 8192);
+		if (!state->fbbase) {
+			vga_cleanup(state);
+			return 1;
+		}
+		restore_vga_text(state);
+	}
+	if (state->flags & VGA_SAVE_CMAP)
+		restore_vga_cmap(state);
+
+	vga_cleanup(state);
+	return 0;
+}
+
+#ifdef MODULE
+int init_module(void) { return 0; };
+void cleanup_module(void) {};
+#endif
+
+EXPORT_SYMBOL(fb_save_vga);
+EXPORT_SYMBOL(fb_restore_vga);
+
+MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
+MODULE_DESCRIPTION("VGA State Save/Restore");
+MODULE_LICENSE("GPL");
+
diff -Naur linux-2.5.50-js/drivers/video/vgastate.h linux/drivers/video/vga=
state.h
--- linux-2.5.50-js/drivers/video/vgastate.h	1970-01-01 00:00:00.000000000 =
+0000
+++ linux/drivers/video/vgastate.h	2002-12-03 19:56:59.000000000 +0000
@@ -0,0 +1,62 @@
+/*
+ * linux/include/video/vgasate.h -- VGA state save/restore header file=20
+ *
+ * Copyright 2002 James Simmons
+ *=20
+ * Copyright history from vga16fb.c:
+ *	Copyright 1999 Ben Pfaff and Petr Vandrovec
+ *	Based on VGA info at http://www.goodnet.com/~tinara/FreeVGA/home.htm
+ *	Based on VESA framebuffer (c) 1998 Gerd Knorr
+ *      Partly based on XFree86's vgHW.c.
+ *=20
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details. =20
+ *
+ */
+#ifndef __vgastate_h__
+#define __vgastate_h__
+
+#include <linux/slab.h>
+#include "vga.h"
+
+#define VGA_SAVE_FONT0 1  /* save/restore font 1        */
+#define VGA_SAVE_FONT1 2  /* save/restore font 2        */
+#define VGA_SAVE_TEXT  4  /* save text character map    */
+#define VGA_SAVE_FONTS 7  /* save/restore all fonts     */
+#define VGA_SAVE_MODE  8  /* save/restore video mode    */
+#define VGA_SAVE_CMAP  16 /* save/restore  color map/DAC*/
+
+/*
+ * To save/restore the vga state, create the vga_state structure and=20
+ * initialize the "flags" field, at least.  VGA_SAVE_MODE should be enough=
 for
+ * most hardware.  Pass the structure to fb_save_vga() when reference coun=
t
+ * increases, and to fb_restore_vga() when reference count becomes zero=20
+ *
+ * Assumes vga screen base is at 0xA0000.
+ */
+
+struct fb_vgastate {
+	int flags;             /* what state/s to save (see VGA_SAVE_*) */=20
+	int depth;             /* current fb depth, not so important    */
+	int num_attr;          /* number of attribute registers, 0 for default */
+	int num_crtc;          /* number of crtc register, 0 for default */
+	int num_gfx;           /* number of gr registers, 0 for default */
+	int num_seq;           /* number of seq registers, 0 for default */
+	caddr_t fbbase;        /* leave as is, will be filled up        */
+	caddr_t vgabase;       /* if not NULL, will do mmio instead of port io */
+	u8 *vga_text0;         /* leave as is, will be filled up        */
+	u8 *vga_text1;         /* leave as is, will be filled up        */
+	u8 *vga_text2;         /* leave as is, will be filled up        */
+	u8 *vga_cmap;          /* leave as is, will be filled up        */
+	u8 *attr;              /* leave as is, will be filled up        */=20
+	u8 *crtc;              /* leave as is, will be filled up        */
+	u8 *gfx;               /* leave as is, will be filled up        */
+	u8 *seq;               /* leave as is, will be filled up        */
+	u8 misc;               /* leave as is, will be filled up        */
+};
+
+extern int fb_save_vga(struct fb_vgastate *state);
+extern int fb_restore_vga(struct fb_vgastate *state);
+
+#endif /* __vgastate_h__ */

--=-agNDNyZP3AMBNgJVN6wJ--

