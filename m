Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267209AbSLEDoH>; Wed, 4 Dec 2002 22:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267210AbSLEDoH>; Wed, 4 Dec 2002 22:44:07 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:16395 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S267209AbSLEDnx>; Wed, 4 Dec 2002 22:43:53 -0500
Subject: [PATCH] FBDEV: VGA Save/Restore module - round 2
From: Antonino Daplas <adaplas@pol.net>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-aYnWKff6+41wMzosbSQ8"
Message-Id: <1039070143.1050.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Dec 2002 11:43:15 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aYnWKff6+41wMzosbSQ8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Attached is an updated patch against linux-2.5.50 + James Simmons'
fbdev.diff.  Most of the changes are as per suggestions by Petr
Vandrovec (Thanks!) targeted towards selective saves/and restores
specific to the setting of vgacon.

Tested drivers:

vga16fb using VGA_SAVE_CMAP | VGA_SAVE_MODE flags will correctly restore
VGA text mode and high resolution graphics mode.

rivafb (riva128) using VGA_SAVE_CMAP |  VGA_SAVE_MODE | VGA_SAVE_FONT0
flags effectively restores VGA text and graphics mode with minor screen
corruption.

Tony

PS: Please reverse previous patches (vgastate.diff and vgastate1.diff)
if applied.

--=-aYnWKff6+41wMzosbSQ8
Content-Disposition: attachment; filename=vgastate2.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=vgastate2.diff; charset=UTF-8

diff -Naur linux-2.5.50-js/drivers/video/Makefile linux/drivers/video/Makef=
ile
--- linux-2.5.50-js/drivers/video/Makefile	2002-12-05 06:15:22.000000000 +0=
000
+++ linux/drivers/video/Makefile	2002-12-05 06:14:08.000000000 +0000
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
+++ linux/drivers/video/vgastate.c	2002-12-05 06:13:35.000000000 +0000
@@ -0,0 +1,504 @@
+/*
+ * linux/drivers/video/vgastate.c -- VGA state save/restore
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
+struct regstate {
+  	__u8 *vga_font0;
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
+static void save_vga_text(struct fb_vgastate *state, caddr_t fbbase)
+{
+	struct regstate *saved =3D (struct regstate *) state->vidstate;
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
+	/* save font at plane 2 */
+	if (state->flags & VGA_SAVE_FONT0) {
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x4);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x2);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 4 * 8192; i++)=20
+			saved->vga_font0[i] =3D vga_r(fbbase, i);
+	}
+
+	/* save font at plane 3 */
+	if (state->flags & VGA_SAVE_FONT1) {
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x8);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x3);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < state->memsize; i++)=20
+			saved->vga_font1[i] =3D vga_r(fbbase, i);
+	}
+
+	/* save font at plane 0/1 */
+	if (state->flags & VGA_SAVE_TEXT) {
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x1);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 8192; i++)=20
+			saved->vga_text[i] =3D vga_r(fbbase, i);
+
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x2);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x1);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 8192; i++)=20
+			saved->vga_text[i] =3D vga_r(fbbase + 2 * 8192, i);
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
+static void restore_vga_text(struct fb_vgastate *state, caddr_t fbbase)
+{
+	struct regstate *saved =3D (struct regstate *) state->vidstate;
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
+
+	/* restore font at plane 2 */
+	if (state->flags & VGA_SAVE_FONT0) {
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x4);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x2);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 4 * 8192; i++)=20
+			vga_w(fbbase, i, saved->vga_font0[i]);
+	}
+
+	/* restore font at plane 3 */
+	if (state->flags & VGA_SAVE_FONT1) {
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x8);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x3);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 4 * 8192; i++)=20
+			vga_w(fbbase, i, saved->vga_font1[i]);
+	}
+
+	/* restore font at plane 0/1 */
+	if (state->flags & VGA_SAVE_TEXT) {
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x1);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 8192; i++)=20
+			vga_w(fbbase, i, saved->vga_text[i]);
+	=09
+		vga_wseq(state->vgabase, VGA_SEQ_PLANE_WRITE, 0x2);
+		vga_wseq(state->vgabase, VGA_SEQ_MEMORY_MODE, 0x6);
+		vga_wgfx(state->vgabase, VGA_GFX_PLANE_READ, 0x1);
+		vga_wgfx(state->vgabase, VGA_GFX_MODE, 0x0);
+		vga_wgfx(state->vgabase, VGA_GFX_MISC, 0x5);
+		for (i =3D 0; i < 8192; i++)=20
+			vga_w(fbbase + 2 * 8192, i,=20
+			      saved->vga_text[i]);
+	}
+
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
+	struct regstate *saved =3D (struct regstate *) state->vidstate;
+	unsigned short iobase;
+	int i;
+
+	saved->misc =3D vga_r(state->vgabase, VGA_MIS_R);
+	if (saved->misc & 1)
+		iobase =3D 0x3d0;
+	else
+		iobase =3D 0x3b0;
+
+	for (i =3D 0; i < state->num_crtc; i++)=20
+		saved->crtc[i] =3D vga_rcrtcs(state->vgabase, iobase, i);
+=09
+	vga_r(state->vgabase, iobase + 0xa);=20
+	vga_w(state->vgabase, VGA_ATT_W, 0x00);
+	for (i =3D 0; i < state->num_attr; i++) {
+		vga_r(state->vgabase, iobase + 0xa);
+		saved->attr[i] =3D vga_rattr(state->vgabase, i);
+	}
+	vga_r(state->vgabase, iobase + 0xa);
+	vga_w(state->vgabase, VGA_ATT_W, 0x20);
+
+	for (i =3D 0; i < state->num_gfx; i++)=20
+		saved->gfx[i] =3D vga_rgfx(state->vgabase, i);
+
+	for (i =3D 0; i < state->num_seq; i++)=20
+		saved->seq[i] =3D vga_rseq(state->vgabase, i);
+}
+
+static void restore_vga_mode(struct fb_vgastate *state)
+{
+	struct regstate *saved =3D (struct regstate *) state->vidstate;
+	unsigned short iobase;
+	int i;
+
+	vga_w(state->vgabase, VGA_MIS_W, saved->misc);
+
+	if (saved->misc & 1)
+		iobase =3D 0x3d0;
+	else
+		iobase =3D 0x3b0;
+
+	/* turn off display */
+	vga_wseq(state->vgabase, VGA_SEQ_CLOCK_MODE,=20
+		 saved->seq[VGA_SEQ_CLOCK_MODE] | 0x20);
+
+	/* disable sequencer */
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x01);
+=09
+	/* enable palette addressing */
+	vga_r(state->vgabase, iobase + 0xa);
+	vga_w(state->vgabase, VGA_ATT_W, 0x00);
+
+	for (i =3D 2; i < state->num_seq; i++)=20
+		vga_wseq(state->vgabase, i, saved->seq[i]);
+
+
+	/* unprotect vga regs */
+	vga_wcrtcs(state->vgabase, iobase, 17, saved->crtc[17] & ~0x80);
+	for (i =3D 0; i < state->num_crtc; i++)=20
+		vga_wcrtcs(state->vgabase, iobase, i, saved->crtc[i]);
+=09
+	for (i =3D 0; i < state->num_gfx; i++)=20
+		vga_wgfx(state->vgabase, i, saved->gfx[i]);
+
+	for (i =3D 0; i < state->num_attr; i++) {
+		vga_r(state->vgabase, iobase + 0xa);
+		vga_wattr(state->vgabase, i, saved->attr[i]);
+	}
+
+	/* reenable sequencer */
+	vga_wseq(state->vgabase, VGA_SEQ_RESET, 0x03);
+	/* turn display on */
+	vga_wseq(state->vgabase, VGA_SEQ_CLOCK_MODE,=20
+		 saved->seq[VGA_SEQ_CLOCK_MODE] & ~(1 << 5));
+
+	/* disable video/palette source */
+	vga_r(state->vgabase, iobase + 0xa);
+	vga_w(state->vgabase, VGA_ATT_W, 0x20);
+}
+
+static void save_vga_cmap(struct fb_vgastate *state)
+{
+	struct regstate *saved =3D (struct regstate *) state->vidstate;
+	int i;
+
+	vga_w(state->vgabase, VGA_PEL_MSK, 0xff);
+=09
+	/* assumes DAC is readable and writable */
+	vga_w(state->vgabase, VGA_PEL_IR, 0x00);
+	for (i =3D 0; i < 768; i++)
+		saved->vga_cmap[i] =3D vga_r(state->vgabase, VGA_PEL_D);
+}
+
+static void restore_vga_cmap(struct fb_vgastate *state)
+{
+	struct regstate *saved =3D (struct regstate *) state->vidstate;
+	int i;
+
+	vga_w(state->vgabase, VGA_PEL_MSK, 0xff);
+
+	/* assumes DAC is readable and writable */
+	vga_w(state->vgabase, VGA_PEL_IW, 0x00);
+	for (i =3D 0; i < 768; i++)
+		vga_w(state->vgabase, VGA_PEL_D, saved->vga_cmap[i]);
+}
+
+static void vga_cleanup(struct fb_vgastate *state)
+{
+        if (state->vidstate !=3D NULL) {
+		struct regstate *saved =3D (struct regstate *) state->vidstate;
+
+		if (saved->vga_font0)=20
+			vfree(saved->vga_font0);
+		if (saved->vga_font1)=20
+			vfree(saved->vga_font1);
+		if (saved->vga_text)
+			vfree(saved->vga_text);
+		if (saved->vga_cmap)
+			vfree(saved->vga_cmap);
+		if (saved->attr)
+			vfree(saved->attr);
+		kfree(saved);
+		state->vidstate =3D NULL;
+	}
+}
+	=09
+int fb_save_vga(struct fb_vgastate *state)
+{
+        struct regstate *saved;
+
+	saved =3D kmalloc(sizeof(struct regstate), GFP_KERNEL);
+	if (saved =3D=3D NULL)
+		return 1;
+	memset (saved, 0, sizeof(struct regstate));
+        (struct regstate *) state->vidstate =3D saved;
+=09
+	if (state->flags & VGA_SAVE_CMAP) {
+		saved->vga_cmap =3D vmalloc(768);
+		if (!saved->vga_cmap) {
+			vga_cleanup(state);
+			return 1;
+		}
+		save_vga_cmap(state);
+	}
+
+	if (state->flags & VGA_SAVE_MODE) {
+		int total;
+
+		if (state->num_attr < 21)
+			state->num_attr =3D 21;
+		if (state->num_crtc < 25)
+			state->num_crtc =3D 25;
+		if (state->num_gfx < 9)
+			state->num_gfx =3D 9;
+		if (state->num_seq < 5)
+			state->num_seq =3D 5;
+		total =3D state->num_attr + state->num_crtc +
+			state->num_gfx + state->num_seq;
+
+		saved->attr =3D vmalloc(total);
+		if (!saved->attr) {
+			vga_cleanup(state);
+			return 1;
+		}
+		saved->crtc =3D saved->attr + state->num_attr;
+		saved->gfx =3D saved->crtc + state->num_crtc;
+		saved->seq =3D saved->gfx + state->num_gfx;
+
+		save_vga_mode(state);
+	}
+
+	if (state->flags & VGA_SAVE_FONTS) {
+		caddr_t fbbase;
+
+		/* exit if window is less than 32K */
+		if (state->memsize && state->memsize < 4 * 8192) {
+			vga_cleanup(state);
+			return 1;
+		}
+		if (!state->memsize)
+			state->memsize =3D 8 * 8192;
+	=09
+		if (!state->membase)
+			state->membase =3D 0xA0000;
+
+		fbbase =3D ioremap(state->membase, state->memsize);
+
+		if (!fbbase) {
+			vga_cleanup(state);
+			iounmap(fbbase);
+			return 1;
+		}
+
+		/*=20
+		 * save only first 32K used by vgacon
+		 */
+		if (state->flags & VGA_SAVE_FONT0) {
+			saved->vga_font0 =3D vmalloc(4 * 8192);
+			if (!saved->vga_font0) {
+				vga_cleanup(state);
+				return 1;
+			}
+		}
+		/*=20
+		 * largely unused, but if required by the caller
+		 * we'll just save everything.
+		 */
+		if (state->flags & VGA_SAVE_FONT1) {
+			saved->vga_font1 =3D vmalloc(state->memsize);
+			if (!saved->vga_font1) {
+				vga_cleanup(state);
+				return 1;
+			}
+		}
+		/*
+		 * Save 8K at plane0[0], and 8K at plane1[16K]
+		 */
+		if (state->flags & VGA_SAVE_TEXT) {
+			saved->vga_text =3D vmalloc(8192 * 2);
+			if (!saved->vga_text) {
+				vga_cleanup(state);
+				return 1;
+			}
+		}
+	=09
+		save_vga_text(state, fbbase);
+		iounmap(fbbase);
+	}
+	return 0;
+}
+
+int fb_restore_vga (struct fb_vgastate *state)
+{
+	if (state->vidstate =3D=3D NULL)
+		return 1;
+
+	if (state->flags & VGA_SAVE_MODE)
+		restore_vga_mode(state);
+
+	if (state->flags & VGA_SAVE_FONTS) {
+		caddr_t fbbase =3D ioremap(state->membase, state->memsize);
+
+		if (!fbbase) {
+			vga_cleanup(state);
+			iounmap(fbbase);
+			return 1;
+		}
+		restore_vga_text(state, fbbase);
+		iounmap(fbbase);
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
--- linux-2.5.50-js/include/linux/fb.h	2002-12-05 06:15:44.000000000 +0000
+++ linux/include/linux/fb.h	2002-12-05 06:14:47.000000000 +0000
@@ -321,6 +321,30 @@
 	struct fb_image	image;	/* Cursor image */
 };
=20
+/* VGA State Save and Restore */
+#define VGA_SAVE_FONT0 1  /* save/restore plane 2 fonts     */
+#define VGA_SAVE_FONT1 2  /* save/restore plane 3 fonts     */
+#define VGA_SAVE_TEXT  4  /* save/restore plane 0/1 fonts   */
+#define VGA_SAVE_FONTS 7  /* save/restore all fonts         */
+#define VGA_SAVE_MODE  8  /* save/restore video mode        */
+#define VGA_SAVE_CMAP  16 /* save/restore color map/DAC     */
+
+struct fb_vgastate {
+	caddr_t vgabase;         /* mmio base, if supported                 */
+	__u32 flags;             /* what state/s to save (see VGA_SAVE_*)   */=20
+	__u32 membase;           /* VGA window base, 0 for default - 0xa0000*/
+	__u32 memsize;           /* VGA window size, 0 for default - 64K    */
+	__u32 depth;             /* current fb depth, not important         */
+	__u32 num_attr;          /* number of att registers, 0 for default  */
+	__u32 num_crtc;          /* number of crt registers, 0 for default  */
+	__u32 num_gfx;           /* number of gfx registers, 0 for default  */
+	__u32 num_seq;           /* number of seq registers, 0 for default  */
+	void *vidstate;
+};
+
+extern int fb_save_vga(struct fb_vgastate *state);
+extern int fb_restore_vga(struct fb_vgastate *state);
+
 #ifdef __KERNEL__
=20
 #include <linux/fs.h>

--=-aYnWKff6+41wMzosbSQ8--


