Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266560AbSLDO2U>; Wed, 4 Dec 2002 09:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266565AbSLDO2U>; Wed, 4 Dec 2002 09:28:20 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:22543 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S266560AbSLDO2M>; Wed, 4 Dec 2002 09:28:12 -0500
Subject: [PATCH 1/3: FBDEV: VGA State Save/Restore module
From: Antonino Daplas <adaplas@pol.net>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-FL/76Vc4R2xmMByXdCDi"
Message-Id: <1039017469.1013.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Dec 2002 22:26:10 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FL/76Vc4R2xmMByXdCDi
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Attached is a patch against linux-2.5.50 + James Simmons fbdev.diff to
save and restore the VGA state. This includes character maps (plane
0-3), the colormap, and the video mode.  This can be used in fb_open()
and fb_release() to go back to VGA text/graphics mode.

Usage:

struct fb_vgastate state;

/* To save VGA state */
state.flags = VGA_SAVE_MODE | VGA_SAVE_CMAP | VGA_SAVE_FONTS;
fb_save_vga(&state);

/* To restore VGA state */
fb_restore_vga(&state);

Limitations:
1.  Restoring the VGA state from high-resolution graphics mode may
result in a corrupt display which can be corrected by switching
consoles.  May need a screen redraw at this point.  Restoring from VGA
graphics mode to text mode and vice versa is okay.

2. Assumes some things about the hardware which is not universally
correct:  VGA memory base is at 0xA0000, memory size is 64KB, the
hardware palette is readable, etc. 

Any comments welcome.

Tony

PS:  Please reverse the early patch I submitted if it was applied --
vgastate.diff





--=-FL/76Vc4R2xmMByXdCDi
Content-Disposition: attachment; filename=vgastate1.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=vgastate1.diff; charset=UTF-8

diff -Naur linux-2.5.50-js/drivers/video/Makefile linux/drivers/video/Makef=
ile
--- linux-2.5.50-js/drivers/video/Makefile	2002-12-04 15:15:25.000000000 +0=
000
+++ linux/drivers/video/Makefile	2002-12-04 15:14:40.000000000 +0000
@@ -6,7 +6,7 @@
 # This list comes from 'grep -l EXPORT_SYMBOL *.[hc]'.
=20
 export-objs    	:=3D fbmem.o fbcmap.o fbmon.o modedb.o softcursor.o cfbfil=
lrect.o \
-		   cfbcopyarea.o cfbimgblt.o cyber2000fb.o=20
+		   cfbcopyarea.o cfbimgblt.o cyber2000fb.o vgastate.o
=20
 # Each configuration option enables a list of files.
=20
diff -Naur linux-2.5.50-js/drivers/video/vgastate.c linux/drivers/video/vga=
state.c
--- linux-2.5.50-js/drivers/video/vgastate.c	1970-01-01 00:00:00.000000000 =
+0000
+++ linux/drivers/video/vgastate.c	2002-12-04 15:14:17.000000000 +0000
@@ -0,0 +1,438 @@
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
+#include <linux/fb.h>
+
+#include "vga.h"
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
+
+static void save_vga_text(struct fb_vgastate *state)
+{
+	int i;
+	u8 misc, attr10, gr4, gr5, gr6, seq1, seq2, seq4;
+
+	/* if in graphics mode, no need to save */
+	attr10 =3D vga_rattr(state->vgabase, 0x10);
+	if (attr10 & 1)
+		return;
+=09
+	/* save regs */
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
+	/* blank screen */
+	seq1 =3D vga_rseq(state->vgabase, VGA_SEQ_CLOCK_MODE);
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x1);
+	vga_wseq(state->vgabase, VGA_SEQ_CLOCK_MODE, seq1 | 1 << 5);
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x3);
+
+	/* save font 0 */
+	if (state->flags & VGA_SAVE_FONT0) {
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x4);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x2);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 8 * 8192; i++)=20
+			state->vga_font0[i] =3D vga_r(state->fbbase, i);
+	}
+	/* save font 1 */
+	if (state->flags & VGA_SAVE_FONT1) {
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x8);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x3);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 8 * 8192; i++)=20
+			state->vga_font1[i] =3D vga_r(state->fbbase, i);
+	}
+	/* save font 2 */
+	if (state->flags & VGA_SAVE_TEXT) {
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x1);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 2 * 8192; i++)=20
+			state->vga_text[i] =3D vga_r(state->fbbase, i);
+
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x2);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x1);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 2 * 8192; i++)=20
+			state->vga_text[i] =3D vga_r(state->fbbase +=20
+						    2 * 8192, i);
+	}
+
+	/* restore regs */
+	vga_wattr(state->vgabase, 0x10, attr10);
+
+	vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, seq2);
+	vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, seq4);
+
+	vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, gr4);
+	vga_wgfx(state->vgabase, VGA_GFX_MODE, gr5);
+	vga_wgfx(state->vgabase, VGA_GFX_MISC, gr6);
+	vga_w(state->vgabase, VGA_MIS_W, misc);
+
+	/* unblank screen */
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x1);
+	vga_wseq(state->vgabase, VGA_SEQ_CLOCK_MODE, seq1 & ~(1 << 5));
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x3);
+
+	vga_wseq(state->vgabase, VGA_SEQ_CLOCK_MODE, seq1);
+}
+
+static void restore_vga_text(struct fb_vgastate *state)
+{
+	int i;
+	u8 misc, gr1, gr3, gr4, gr5, gr6, gr8;=20
+	u8 seq1, seq2, seq4;
+
+	/* save regs */
+	misc =3D vga_r(state->vgabase, VGA_MIS_R);
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
+	/* blank screen */
+	seq1 =3D vga_rseq(state->vgabase, VGA_SEQ_CLOCK_MODE);
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x1);
+	vga_wseq(state->vgabase, VGA_SEQ_CLOCK_MODE, seq1 | 1 << 5);
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x3);
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
+			vga_w(state->fbbase, i, state->vga_font0[i]);
+	}
+	/* restore font 1 */
+	if (state->flags & VGA_SAVE_FONT1) {
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x8);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x3);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 8 * 8192; i++)=20
+			vga_w(state->fbbase, i, state->vga_font1[i]);
+	}
+	/* restore font 2 */
+	if (state->flags & VGA_SAVE_TEXT) {
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x1);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 2 * 8192; i++)=20
+			vga_w(state->fbbase, i, state->vga_text[i]);
+	=09
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x2);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x1);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 2 * 8192; i++)=20
+			vga_w(state->fbbase + 2 * 8192, i,=20
+			      state->vga_text[i]);
+	}
+	/* unblank screen */
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x1);
+	vga_wseq(state->vgabase, VGA_SEQ_CLOCK_MODE, seq1 & ~(1 << 5));
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x3);
+
+	/* restore regs */
+	vga_w(state->vgabase, VGA_MIS_W, misc);
+
+	vga_wgfx(state->vgabase, VGA_GFX_SR_ENABLE, gr1);
+	vga_wgfx(state->vgabase, VGA_GFX_DATA_ROTATE, gr3);
+	vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, gr4);
+	vga_wgfx(state->vgabase, VGA_GFX_MODE, gr5);
+	vga_wgfx(state->vgabase, VGA_GFX_MISC, gr6);
+	vga_wgfx(state->vgabase, VGA_GFX_BIT_MASK, gr8);
+
+	vga_wseq(state->vgabase, VGA_SEQ_CLOCK_MODE, seq1);
+	vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, seq2);
+	vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, seq4);
+}
+			     =20
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
+	vga_r(state->vgabase, iobase + 0xa);=20
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
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x01);
+	vga_wseq(state->vgabase, VGA_SEQ_CLOCK_MODE,=20
+		 state->seq[VGA_SEQ_CLOCK_MODE] | 0x20);
+
+	for (i =3D 2; i < state->num_seq; i++)=20
+		vga_wseq(state->vgabase, i, state->seq[i]);
+
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x03);
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
+	vga_wseq(state->vgabase, VGA_SEQ_CLOCK_MODE,=20
+		 state->seq[VGA_SEQ_CLOCK_MODE]);
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
+	if (state->vga_font0)=20
+		kfree(state->vga_font0);
+	if (state->vga_font1)=20
+		kfree(state->vga_font1);
+	if (state->vga_text)
+		kfree(state->vga_text);
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
+	state->vga_font0 =3D NULL;
+	state->vga_font1 =3D NULL;
+	state->vga_text =3D NULL;
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
+		state->vga_font0 =3D kmalloc(8192 * 8, GFP_KERNEL);
+		if (!state->vga_font0) {
+			vga_cleanup(state);
+			return 1;
+		}
+	}
+	if (state->flags & VGA_SAVE_FONT1) {
+		state->vga_font1 =3D kmalloc(8192 * 8, GFP_KERNEL);
+		if (!state->vga_font1) {
+			vga_cleanup(state);
+			return 1;
+		}
+	}
+	if (state->flags & VGA_SAVE_TEXT) {
+		state->vga_text =3D kmalloc(8192 * 4, GFP_KERNEL);
+		if (!state->vga_text) {
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
+
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
diff -Naur linux-2.5.50-js/include/linux/fb.h linux/include/linux/fb.h
--- linux-2.5.50-js/include/linux/fb.h	2002-12-04 15:07:13.000000000 +0000
+++ linux/include/linux/fb.h	2002-12-04 15:20:00.000000000 +0000
@@ -321,6 +321,37 @@
 	struct fb_image	image;	/* Cursor image */
 };
=20
+/* VGA State Save and Restore */
+#define VGA_SAVE_FONT0 1  /* save/restore plane 2 fonts   */
+#define VGA_SAVE_FONT1 2  /* save/restore plane 3 fonts   */
+#define VGA_SAVE_TEXT  4  /* save/restore plane 0/1 fonts */
+#define VGA_SAVE_FONTS 7  /* save/restore all fonts       */
+#define VGA_SAVE_MODE  8  /* save/restore video mode      */
+#define VGA_SAVE_CMAP  16 /* save/restore color map/DAC  */
+
+struct fb_vgastate {
+	caddr_t vgabase;         /* mmio base, if supported                 */
+	__u32 flags;             /* what state/s to save (see VGA_SAVE_*)   */=20
+	__u32 depth;             /* current fb depth, not important         */
+	__u32 num_attr;          /* number of att registers, 0 for default  */
+	__u32 num_crtc;          /* number of crt registers, 0 for default  */
+	__u32 num_gfx;           /* number of gfx registers, 0 for default  */
+	__u32 num_seq;           /* number of seq registers, 0 for default  */
+	caddr_t fbbase;          /*    -- DO NOT ALTER STARTING HERE --     */
+	__u8 *vga_font0;        =20
+	__u8 *vga_font1;        =20
+	__u8 *vga_text;        =20
+	__u8 *vga_cmap;         =20
+	__u8 *attr;              =20
+	__u8 *crtc;             =20
+	__u8 *gfx;              =20
+	__u8 *seq;              =20
+	__u8 misc;              =20
+};
+
+extern int fb_save_vga(struct fb_vgastate *state);
+extern int fb_restore_vga(struct fb_vgastate *state);
+
 #ifdef __KERNEL__
=20
 #include <linux/fs.h>

--=-FL/76Vc4R2xmMByXdCDi--

