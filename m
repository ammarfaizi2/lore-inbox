Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272052AbRHVRMC>; Wed, 22 Aug 2001 13:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272049AbRHVRLu>; Wed, 22 Aug 2001 13:11:50 -0400
Received: from hood.tvd.be ([195.162.196.21]:41355 "EHLO hood.tvd.be")
	by vger.kernel.org with ESMTP id <S272050AbRHVRLP>;
	Wed, 22 Aug 2001 13:11:15 -0400
Date: Wed, 22 Aug 2001 19:06:12 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
cc: Olaf Hering <olh@suse.de>, Hollis Blanchard <hollis@austin.ibm.com>
Subject: scr_*() audit
Message-ID: <Pine.LNX.4.05.10108221846140.6842-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

Since there are still some issues left with the scr_*() functions on
big-endian platforms that can have both VGA and frame buffer consoles, I
decided to spent some precious time on auditing the usage of these functions.

Screen buffers contain characters/attribute pairs. You may not access a screen
buffer directly, only through the scr_*() functions!! On systems with VGA text,
scr_*() should convert the character/attribute pair to/from the hardware VGA
text format, which is little endian. On systems with frame buffer consoles, the
exact format doesn't matter (unless support for VGA text is compiled in), but
simple stores/loads give best performance. (Note: this opens a nice way to
debug scr_*() usage on a frame buffer console: just let scr_{read,write}w()
(un)mangle the data, so you immediately see when something goes wrong).

List of functions that were audited (i.e. all usage of these routines was
checked):

  - scr_*() operations:

      o scr_readw(): read from a screen buffer
      o scr_writew(): write to a screen buffer
      o scr_memcpyw(): copy between screen buffers
      o scr_memcpyw_from(): copy from a screen buffer to a buffer in native
        format
      o scr_memcpyw_to(): copy from a buffer in native format to a screen
        buffer
      o scr_memmovew(): move between screen buffers
      o scr_memsetw(): screen buffer fill

  - Routines or macros having parameters or results pointing to screen buffers
    (some are unsigned long instead of unsigned short *):

      o consw.con_invert_region()
      o consw.con_putcs()
      o consw.con_screen_pos()
      o consw.con_getxy()
      o display_switch.putcs
      o drivers/video/mdacon.c:MDA_ADDR()
      o drivers/char/console.c:screenpos()
      o drivers/video/promcon.c:promcon_repaint_line()
      o drivers/char/console.c:do_update_region()
      o drivers/char/console.c:vcs_scr_readw()
      o drivers/char/console.c:vcs_scr_writew()
      o drivers/char/console.c:screen_pos()
      o drivers/char/console.c:update_region()

  - Variables pointing to screen buffers (some are unsigned long instead of
    unsigned short *):

      o drivers/video/fbcon.c:softback_{buf,curr,in,top,end}
      o drivers/video/vgacon.c:vga_vram_{base,end}
      o drivers/video/mdacon.c:mda_vram_base
      o drivers/video/hgafb.c:hga_vram_base
      o vc_data.vc_origin (and origin, if #include "console_macros.h")
      o vc_data.vc_pos (and pos, if #include "console_macros.h")
      o vc_data.vc_scr_end (and scr_end, if #include "console_macros.h")
      o vc_data.vc_screenbuf (and screenbuf, if #include "console_macros.h")
      o vc_data.vc_translate (and translate, if #include "console_macros.h")
      o vc_data.vc_visible_origin (and visible_origin, if #include
	"console_macros.h")


List of fixes:

  - Accesses to screen buffers must use the correct scr_*() routines. BTW, it
    turns out scr_memcpyw_{from,to} are no longer used.

  - Hgafb ISA memory space fixes:
      o Use isa_memset_io() instead of memset()
      o Use isa_writeb() instead of pointer dereferencing

  - Sticon*: consw.con_screen_pos() and consw.con_getxy() must not return zero.
    Use a NULL function pointer instead, to indicate that these functions are
    not available.

  - Optimizations:
      o avoid multiple scr_readw(s) for identical s
      o fbcon_riva{8,16,32}_putcs(): attr is invariant of the character loop


Note: I did not look at arch-specific implementations of the scr_*()
operations.


The patch is against 2.4.8-ac9, but it should apply to any recent tree
(including 2.4.9).

Caveat: the patch is completely untested, except for human brain processing.

All comments are welcome. Sorry for delays in responding to comments.


diff -ur linux-2.4.8-ac9/drivers/char/console.c scr-audit-2.4.8-ac9/drivers/char/console.c
--- linux-2.4.8-ac9/drivers/char/console.c	Fri Jun 29 11:01:19 2001
+++ scr-audit-2.4.8-ac9/drivers/char/console.c	Wed Aug 22 18:48:32 2001
@@ -399,20 +399,28 @@
 	else {
 		u16 *q = p;
 		int cnt = count;
+		u16 a;
 
 		if (!can_do_color) {
-			while (cnt--) *q++ ^= 0x0800;
+			while (cnt--) {
+			    a = scr_readw(q);
+			    a ^= 0x0800;
+			    scr_writew(a, q);
+			    q++;
+			}
 		} else if (hi_font_mask == 0x100) {
 			while (cnt--) {
-				u16 a = *q;
+				a = scr_readw(q);
 				a = ((a) & 0x11ff) | (((a) & 0xe000) >> 4) | (((a) & 0x0e00) << 4);
-				*q++ = a;
+				scr_writew(a, q);
+				q++;
 			}
 		} else {
 			while (cnt--) {
-				u16 a = *q;
+				a = scr_readw(q);
 				a = ((a) & 0x88ff) | (((a) & 0x7000) >> 4) | (((a) & 0x0700) << 4);
-				*q++ = a;
+				scr_writew(a, q);
+				q++
 			}
 		}
 	}
diff -ur linux-2.4.8-ac9/drivers/video/cgsixfb.c scr-audit-2.4.8-ac9/drivers/video/cgsixfb.c
--- linux-2.4.8-ac9/drivers/video/cgsixfb.c	Thu Feb 22 08:29:07 2001
+++ scr-audit-2.4.8-ac9/drivers/video/cgsixfb.c	Wed Aug 22 18:48:32 2001
@@ -362,13 +362,15 @@
 	unsigned long flags;
 	int i, x, y;
 	u8 *fd1, *fd2, *fd3, *fd4;
+	u16 c;
 
 	spin_lock_irqsave(&fb->lock, flags);
 	do {
 		i = sbus_readl(&fbc->s);
 	} while (i & 0x10000000);
-	sbus_writel(attr_fgcol(p, scr_readw(s)), &fbc->fg);
-	sbus_writel(attr_bgcol(p, scr_readw(s)), &fbc->bg);
+	c = scr_readw(s);
+	sbus_writel(attr_fgcol(p, c), &fbc->fg);
+	sbus_writel(attr_bgcol(p, c), &fbc->bg);
 	sbus_writel(0x140000, &fbc->mode);
 	sbus_writel(0xe880fc30, &fbc->alu);
 	sbus_writel(~0, &fbc->pixelm);
diff -ur linux-2.4.8-ac9/drivers/video/creatorfb.c scr-audit-2.4.8-ac9/drivers/video/creatorfb.c
--- linux-2.4.8-ac9/drivers/video/creatorfb.c	Wed Jun 13 07:42:20 2001
+++ scr-audit-2.4.8-ac9/drivers/video/creatorfb.c	Wed Aug 22 18:48:32 2001
@@ -475,11 +475,13 @@
 	unsigned long flags;
 	int i, xy;
 	u8 *fd1, *fd2, *fd3, *fd4;
+	u16 c;
 	u64 fgbg;
 
 	spin_lock_irqsave(&fb->lock, flags);
-	fgbg = (((u64)(((u32 *)p->dispsw_data)[attr_fgcol(p,scr_readw(s))])) << 32) |
-	       ((u32 *)p->dispsw_data)[attr_bgcol(p,scr_readw(s))];
+	c = scr_readw(s);
+	fgbg = (((u64)(((u32 *)p->dispsw_data)[attr_fgcol(p, c)])) << 32) |
+	       ((u32 *)p->dispsw_data)[attr_bgcol(p, c)];
 	if (fgbg != *(u64 *)&fb->s.ffb.fg_cache) {
 		FFBFifo(fb, 2);
 		upa_writeq(fgbg, &fbc->fg);
diff -ur linux-2.4.8-ac9/drivers/video/dn_cfb8.c scr-audit-2.4.8-ac9/drivers/video/dn_cfb8.c
--- linux-2.4.8-ac9/drivers/video/dn_cfb8.c	Mon Feb 19 10:37:00 2001
+++ scr-audit-2.4.8-ac9/drivers/video/dn_cfb8.c	Wed Aug 22 18:48:32 2001
@@ -518,7 +518,7 @@
     underl = attr_underline(p,conp);
 
     while (count--) {
-	c = *s++;
+	c = scr_readw(s++);
 	dest = dest0++;
 	cdat = p->fontdata+c*p->fontheight;
 	for (rows = p->fontheight; rows--; dest += p->next_line) {
diff -ur linux-2.4.8-ac9/drivers/video/fbcon-afb.c scr-audit-2.4.8-ac9/drivers/video/fbcon-afb.c
--- linux-2.4.8-ac9/drivers/video/fbcon-afb.c	Tue Jul 25 03:24:25 2000
+++ scr-audit-2.4.8-ac9/drivers/video/fbcon-afb.c	Wed Aug 22 18:48:32 2001
@@ -290,8 +290,9 @@
     int fg0, bg0, fg, bg;
 
     dest0 = p->screen_base+yy*fontheight(p)*p->next_line+xx;
-    fg0 = attr_fgcol(p, scr_readw(s));
-    bg0 = attr_bgcol(p, scr_readw(s));
+    c1 = scr_readw(s);
+    fg0 = attr_fgcol(p, c1);
+    bg0 = attr_bgcol(p, c1);
 
     while (count--)
 	if (xx&3 || count < 3) {	/* Slow version */
diff -ur linux-2.4.8-ac9/drivers/video/fbcon-cfb16.c scr-audit-2.4.8-ac9/drivers/video/fbcon-cfb16.c
--- linux-2.4.8-ac9/drivers/video/fbcon-cfb16.c	Tue Jul 25 03:24:25 2000
+++ scr-audit-2.4.8-ac9/drivers/video/fbcon-cfb16.c	Wed Aug 22 18:48:32 2001
@@ -178,8 +178,9 @@
     u32 eorx, fgx, bgx;
 
     dest0 = p->screen_base + yy * fontheight(p) * bytes + xx * fontwidth(p) * 2;
-    fgx = ((u16 *)p->dispsw_data)[attr_fgcol(p, scr_readw(s))];
-    bgx = ((u16 *)p->dispsw_data)[attr_bgcol(p, scr_readw(s))];
+    c = scr_readw(s);
+    fgx = ((u16 *)p->dispsw_data)[attr_fgcol(p, c)];
+    bgx = ((u16 *)p->dispsw_data)[attr_bgcol(p, c)];
     fgx |= (fgx << 16);
     bgx |= (bgx << 16);
     eorx = fgx ^ bgx;
diff -ur linux-2.4.8-ac9/drivers/video/fbcon-cfb2.c scr-audit-2.4.8-ac9/drivers/video/fbcon-cfb2.c
--- linux-2.4.8-ac9/drivers/video/fbcon-cfb2.c	Tue Jul 25 03:24:26 2000
+++ scr-audit-2.4.8-ac9/drivers/video/fbcon-cfb2.c	Wed Aug 22 18:48:32 2001
@@ -154,8 +154,9 @@
 	u32 eorx, fgx, bgx;
 
 	dest0 = p->screen_base + yy * fontheight(p) * bytes + xx * 2;
-	fgx=3/*attr_fgcol(p,scr_readw(s))*/;
-	bgx=attr_bgcol(p,scr_readw(s));
+	c = scr_readw(s);
+	fgx = 3/*attr_fgcol(p, c)*/;
+	bgx = attr_bgcol(p, c);
 	fgx |= (fgx << 2);
 	fgx |= (fgx << 4);
 	bgx |= (bgx << 2);
diff -ur linux-2.4.8-ac9/drivers/video/fbcon-cfb24.c scr-audit-2.4.8-ac9/drivers/video/fbcon-cfb24.c
--- linux-2.4.8-ac9/drivers/video/fbcon-cfb24.c	Tue Jul 25 03:24:26 2000
+++ scr-audit-2.4.8-ac9/drivers/video/fbcon-cfb24.c	Wed Aug 22 18:48:32 2001
@@ -191,8 +191,9 @@
     u32 eorx, fgx, bgx, d1, d2, d3, d4;
 
     dest0 = p->screen_base + yy * fontheight(p) * bytes + xx * fontwidth(p) * 3;
-    fgx = ((u32 *)p->dispsw_data)[attr_fgcol(p, scr_readw(s))];
-    bgx = ((u32 *)p->dispsw_data)[attr_bgcol(p, scr_readw(s))];
+    c = scr_readw(s);
+    fgx = ((u32 *)p->dispsw_data)[attr_fgcol(p, c)];
+    bgx = ((u32 *)p->dispsw_data)[attr_bgcol(p, c)];
     eorx = fgx ^ bgx;
     while (count--) {
 	c = scr_readw(s++) & p->charmask;
diff -ur linux-2.4.8-ac9/drivers/video/fbcon-cfb32.c scr-audit-2.4.8-ac9/drivers/video/fbcon-cfb32.c
--- linux-2.4.8-ac9/drivers/video/fbcon-cfb32.c	Tue Jul 25 03:24:26 2000
+++ scr-audit-2.4.8-ac9/drivers/video/fbcon-cfb32.c	Wed Aug 22 18:48:32 2001
@@ -164,8 +164,9 @@
     u32 eorx, fgx, bgx, *pt;
 
     dest0 = p->screen_base + yy * fontheight(p) * bytes + xx * fontwidth(p) * 4;
-    fgx = ((u32 *)p->dispsw_data)[attr_fgcol(p, scr_readw(s))];
-    bgx = ((u32 *)p->dispsw_data)[attr_bgcol(p, scr_readw(s))];
+    c = scr_readw(s);
+    fgx = ((u32 *)p->dispsw_data)[attr_fgcol(p, c)];
+    bgx = ((u32 *)p->dispsw_data)[attr_bgcol(p, c)];
     eorx = fgx ^ bgx;
     while (count--) {
 	c = scr_readw(s++) & p->charmask;
diff -ur linux-2.4.8-ac9/drivers/video/fbcon-cfb4.c scr-audit-2.4.8-ac9/drivers/video/fbcon-cfb4.c
--- linux-2.4.8-ac9/drivers/video/fbcon-cfb4.c	Tue Jul 25 03:24:26 2000
+++ scr-audit-2.4.8-ac9/drivers/video/fbcon-cfb4.c	Wed Aug 22 18:48:32 2001
@@ -156,8 +156,9 @@
 	u32 eorx, fgx, bgx;
 
 	dest0 = p->screen_base + yy * fontheight(p) * bytes + xx * 4;
-	fgx=attr_fgcol(p,scr_readw(s));
-	bgx=attr_bgcol(p,scr_readw(s));
+	c = scr_readw(s);
+	fgx = attr_fgcol(p, c);
+	bgx = attr_bgcol(p, c);
 	fgx |= (fgx << 4);
 	fgx |= (fgx << 8);
 	fgx |= (fgx << 16);
diff -ur linux-2.4.8-ac9/drivers/video/fbcon-cfb8.c scr-audit-2.4.8-ac9/drivers/video/fbcon-cfb8.c
--- linux-2.4.8-ac9/drivers/video/fbcon-cfb8.c	Tue Jul 25 03:24:26 2000
+++ scr-audit-2.4.8-ac9/drivers/video/fbcon-cfb8.c	Wed Aug 22 18:48:32 2001
@@ -163,8 +163,9 @@
     u32 eorx, fgx, bgx;
 
     dest0 = p->screen_base + yy * fontheight(p) * bytes + xx * fontwidth(p);
-    fgx=attr_fgcol(p,scr_readw(s));
-    bgx=attr_bgcol(p,scr_readw(s));
+    c = scr_readw(s);
+    fgx = attr_fgcol(p, c);
+    bgx = attr_bgcol(p, c);
     fgx |= (fgx << 8);
     fgx |= (fgx << 16);
     bgx |= (bgx << 8);
diff -ur linux-2.4.8-ac9/drivers/video/fbcon-hga.c scr-audit-2.4.8-ac9/drivers/video/fbcon-hga.c
--- linux-2.4.8-ac9/drivers/video/fbcon-hga.c	Tue Jul 25 03:24:26 2000
+++ scr-audit-2.4.8-ac9/drivers/video/fbcon-hga.c	Wed Aug 22 18:48:32 2001
@@ -148,9 +148,10 @@
 	u8 d;
 	u16 c;
 	
-	bold = attr_bold(p,scr_readw(s));
-	revs = attr_reverse(p,scr_readw(s));
-	underl = attr_underline(p,scr_readw(s));
+	c = scr_readw(s);
+	bold = attr_bold(p, c);
+	revs = attr_reverse(p, c);
+	underl = attr_underline(p, c);
 	y0 = yy*fontheight(p);
 
 	while (count--) {
diff -ur linux-2.4.8-ac9/drivers/video/fbcon-ilbm.c scr-audit-2.4.8-ac9/drivers/video/fbcon-ilbm.c
--- linux-2.4.8-ac9/drivers/video/fbcon-ilbm.c	Tue Jul 25 03:24:26 2000
+++ scr-audit-2.4.8-ac9/drivers/video/fbcon-ilbm.c	Wed Aug 22 18:48:32 2001
@@ -154,8 +154,9 @@
     int fg0, bg0, fg, bg;
 
     dest0 = p->screen_base+yy*fontheight(p)*p->next_line+xx;
-    fg0 = attr_fgcol(p,scr_readw(s));
-    bg0 = attr_bgcol(p,scr_readw(s));
+    c1 = scr_readw(s);
+    fg0 = attr_fgcol(p, c1);
+    bg0 = attr_bgcol(p, c1);
 
     while (count--)
 	if (xx&3 || count < 3) {	/* Slow version */
diff -ur linux-2.4.8-ac9/drivers/video/fbcon-iplan2p2.c scr-audit-2.4.8-ac9/drivers/video/fbcon-iplan2p2.c
--- linux-2.4.8-ac9/drivers/video/fbcon-iplan2p2.c	Tue Jul 25 03:24:26 2000
+++ scr-audit-2.4.8-ac9/drivers/video/fbcon-iplan2p2.c	Wed Aug 22 18:48:32 2001
@@ -364,8 +364,9 @@
     else
 	dest0 = (p->screen_base + yy * bytes * fontheight(p) +
 		 (xx>>1)*4 + (xx & 1));
-    fgx = expand2w(COLOR_2P(attr_fgcol(p,scr_readw(s))));
-    bgx = expand2w(COLOR_2P(attr_bgcol(p,scr_readw(s))));
+    c = scr_readw(s);
+    fgx = expand2w(COLOR_2P(attr_fgcol(p, c)));
+    bgx = expand2w(COLOR_2P(attr_bgcol(p, c)));
     eorx = fgx ^ bgx;
 
     while (count--) {
diff -ur linux-2.4.8-ac9/drivers/video/fbcon-iplan2p4.c scr-audit-2.4.8-ac9/drivers/video/fbcon-iplan2p4.c
--- linux-2.4.8-ac9/drivers/video/fbcon-iplan2p4.c	Tue Jul 25 03:24:26 2000
+++ scr-audit-2.4.8-ac9/drivers/video/fbcon-iplan2p4.c	Wed Aug 22 18:48:32 2001
@@ -374,8 +374,9 @@
     else
 	dest0 = (p->screen_base + yy * bytes * fontheight(p) +
 		 (xx>>1)*8 + (xx & 1));
-    fgx = expand4l(attr_fgcol(p,scr_readw(s)));
-    bgx = expand4l(attr_bgcol(p,scr_readw(s)));
+    c = scr_readw(s);
+    fgx = expand4l(attr_fgcol(p, c));
+    bgx = expand4l(attr_bgcol(p, c));
     eorx = fgx ^ bgx;
 
     while (count--) {
diff -ur linux-2.4.8-ac9/drivers/video/fbcon-iplan2p8.c scr-audit-2.4.8-ac9/drivers/video/fbcon-iplan2p8.c
--- linux-2.4.8-ac9/drivers/video/fbcon-iplan2p8.c	Tue Jul 25 03:24:26 2000
+++ scr-audit-2.4.8-ac9/drivers/video/fbcon-iplan2p8.c	Wed Aug 22 18:48:32 2001
@@ -407,8 +407,9 @@
 	dest0 = (p->screen_base + yy * bytes * fontheight(p) +
 		 (xx>>1)*16 + (xx & 1));
 
-    expand8dl(attr_fgcol(p,scr_readw(s)), &fgx1, &fgx2);
-    expand8dl(attr_bgcol(p,scr_readw(s)), &bgx1, &bgx2);
+    c = scr_readw(s);
+    expand8dl(attr_fgcol(p, c), &fgx1, &fgx2);
+    expand8dl(attr_bgcol(p, c), &bgx1, &bgx2);
     eorx1 = fgx1 ^ bgx1; eorx2  = fgx2 ^ bgx2;
 
     while (count--) {
diff -ur linux-2.4.8-ac9/drivers/video/fbcon-mfb.c scr-audit-2.4.8-ac9/drivers/video/fbcon-mfb.c
--- linux-2.4.8-ac9/drivers/video/fbcon-mfb.c	Tue Jul 25 03:24:26 2000
+++ scr-audit-2.4.8-ac9/drivers/video/fbcon-mfb.c	Wed Aug 22 18:48:32 2001
@@ -117,9 +117,10 @@
     u16 c;
 
     dest0 = p->screen_base+yy*fontheight(p)*p->next_line+xx;
-    bold = attr_bold(p,scr_readw(s));
-    revs = attr_reverse(p,scr_readw(s));
-    underl = attr_underline(p,scr_readw(s));
+    c = scr_readw(s);
+    bold = attr_bold(p, c);
+    revs = attr_reverse(p, c);
+    underl = attr_underline(p, c);
 
     while (count--) {
 	c = scr_readw(s++) & p->charmask;
diff -ur linux-2.4.8-ac9/drivers/video/fbcon-sti.c scr-audit-2.4.8-ac9/drivers/video/fbcon-sti.c
--- linux-2.4.8-ac9/drivers/video/fbcon-sti.c	Mon Feb 19 10:04:58 2001
+++ scr-audit-2.4.8-ac9/drivers/video/fbcon-sti.c	Wed Aug 22 18:48:32 2001
@@ -257,9 +257,10 @@
 		return;
 	}	
 
-	bold = attr_bold(p,scr_readw(s));
-	revs = attr_reverse(p,scr_readw(s));
-	underl = attr_underline(p,scr_readw(s));
+	c = scr_readw(s);
+	bold = attr_bold(p, c);
+	revs = attr_reverse(p, c);
+	underl = attr_underline(p, c);
 
 	while (count--) {
 		c = scr_readw(s++) & p->charmask;
diff -ur linux-2.4.8-ac9/drivers/video/fbcon-vga-planes.c scr-audit-2.4.8-ac9/drivers/video/fbcon-vga-planes.c
--- linux-2.4.8-ac9/drivers/video/fbcon-vga-planes.c	Tue Jul 25 03:24:26 2000
+++ scr-audit-2.4.8-ac9/drivers/video/fbcon-vga-planes.c	Wed Aug 22 18:48:32 2001
@@ -236,8 +236,9 @@
 void fbcon_ega_planes_putcs(struct vc_data *conp, struct display *p, const unsigned short *s,
 		   int count, int yy, int xx)
 {
-	int fg = attr_fgcol(p,scr_readw(s));
-	int bg = attr_bgcol(p,scr_readw(s));
+	u16 c = scr_readw(s);
+	int fg = attr_fgcol(p, c);
+	int bg = attr_bgcol(p, c);
 
 	char *where;
 	int n;
@@ -274,8 +275,9 @@
 void fbcon_vga_planes_putcs(struct vc_data *conp, struct display *p, const unsigned short *s,
 		   int count, int yy, int xx)
 {
-	int fg = attr_fgcol(p,*s);
-	int bg = attr_bgcol(p,*s);
+	u16 c = scr_readw(s);
+	int fg = attr_fgcol(p, c);
+	int bg = attr_bgcol(p, c);
 
 	char *where;
 	int n;
@@ -295,7 +297,7 @@
 	wmb();
 	for (n = 0; n < count; n++) {
 		int y;
-		int c = *s++ & p->charmask;
+		int c = scr_readw(s++) & p->charmask;
 		u8 *cdat = p->fontdata + (c & p->charmask) * fontheight(p);
 
 		for (y = 0; y < fontheight(p); y++, cdat++) {
diff -ur linux-2.4.8-ac9/drivers/video/fbcon.c scr-audit-2.4.8-ac9/drivers/video/fbcon.c
--- linux-2.4.8-ac9/drivers/video/fbcon.c	Fri Mar 23 08:17:54 2001
+++ scr-audit-2.4.8-ac9/drivers/video/fbcon.c	Wed Aug 22 18:48:32 2001
@@ -664,7 +664,7 @@
     	    	scr_memsetw(save, conp->vc_video_erase_char, logo_lines * nr_cols * 2);
     	    	r = q - step;
     	    	for (cnt = 0; cnt < logo_lines; cnt++, r += i)
-    	    		scr_memcpyw_from(save + cnt * nr_cols, r, 2 * i);
+    	    		scr_memcpyw(save + cnt * nr_cols, r, 2 * i);
     	    	r = q;
     	    }
     	}
@@ -682,7 +682,7 @@
     	}
     	scr_memsetw((unsigned short *)conp->vc_origin,
 		    conp->vc_video_erase_char, 
-    		conp->vc_size_row * logo_lines);
+		    conp->vc_size_row * logo_lines);
     }
     
     /*
@@ -2010,17 +2010,14 @@
 static void fbcon_invert_region(struct vc_data *conp, u16 *p, int cnt)
 {
     while (cnt--) {
+	u16 a = scr_readw(p);
 	if (!conp->vc_can_do_color)
-	    *p++ ^= 0x0800;
-	else if (conp->vc_hi_font_mask == 0x100) {
-	    u16 a = *p;
+	    a ^= 0x0800;
+	else if (conp->vc_hi_font_mask == 0x100)
 	    a = ((a) & 0x11ff) | (((a) & 0xe000) >> 4) | (((a) & 0x0e00) << 4);
-	    *p++ = a;
-	} else {
-	    u16 a = *p;
+	else
 	    a = ((a) & 0x88ff) | (((a) & 0x7000) >> 4) | (((a) & 0x0700) << 4);
-	    *p++ = a;
-	}
+	scr_writew(a, p++);
 	if (p == (u16 *)softback_end)
 	    p = (u16 *)softback_buf;
 	if (p == (u16 *)softback_in)
diff -ur linux-2.4.8-ac9/drivers/video/hgafb.c scr-audit-2.4.8-ac9/drivers/video/hgafb.c
--- linux-2.4.8-ac9/drivers/video/hgafb.c	Mon May 28 11:07:02 2001
+++ scr-audit-2.4.8-ac9/drivers/video/hgafb.c	Wed Aug 22 18:48:32 2001
@@ -203,7 +203,7 @@
 		fillchar = 0x00;
 	spin_unlock_irqrestore(&hga_reg_lock, flags);
 	if (fillchar != 0xbf)
-		memset((char *)hga_vram_base, fillchar, hga_vram_len);
+		isa_memset_io((char *)hga_vram_base, fillchar, hga_vram_len);
 }
 
 
@@ -279,7 +279,8 @@
 	char *logo = linux_logo_bw;
 	for (y = 134; y < 134 + 80 ; y++) /* this needs some cleanup */
 		for (x = 0; x < 10 ; x++)
-			*(dest + (y%4)*8192 + (y>>2)*90 + x + 40) = ~*(logo++);
+			isa_writeb(~*(logo++),
+				   (dest + (y%4)*8192 + (y>>2)*90 + x + 40));
 }
 #endif /* MODULE */	
 
diff -ur linux-2.4.8-ac9/drivers/video/leofb.c scr-audit-2.4.8-ac9/drivers/video/leofb.c
--- linux-2.4.8-ac9/drivers/video/leofb.c	Thu Feb 22 08:29:07 2001
+++ scr-audit-2.4.8-ac9/drivers/video/leofb.c	Wed Aug 22 18:48:32 2001
@@ -285,14 +285,16 @@
 	unsigned long flags;
 	int i, x, y;
 	u8 *fd1, *fd2, *fd3, *fd4;
+	u16 c;
 	u32 *u;
 
 	spin_lock_irqsave(&fb->lock, flags);
 	do {
 		i = sbus_readl(&us->csr);
 	} while (i & 0x20000000);
-	sbus_writel(attr_fgcol(p,scr_readw(s)) << 24, &ss->fg);
-	sbus_writel(attr_bgcol(p,scr_readw(s)) << 24, &ss->bg);
+	c = scr_readw(s);
+	sbus_writel(attr_fgcol(p, c) << 24, &ss->fg);
+	sbus_writel(attr_bgcol(p, c) << 24, &ss->bg);
 	sbus_writel(0xFFFFFFFF<<(32-fontwidth(p)), &us->fontmsk);
 	if (fontwidthlog(p))
 		x = (xx << fontwidthlog(p));
diff -ur linux-2.4.8-ac9/drivers/video/matrox/matroxfb_accel.c scr-audit-2.4.8-ac9/drivers/video/matrox/matroxfb_accel.c
--- linux-2.4.8-ac9/drivers/video/matrox/matroxfb_accel.c	Wed Jun 20 11:06:14 2001
+++ scr-audit-2.4.8-ac9/drivers/video/matrox/matroxfb_accel.c	Wed Aug 22 18:48:32 2001
@@ -654,13 +654,15 @@
 
 #ifdef FBCON_HAS_CFB8
 static void matrox_cfb8_putcs(struct vc_data* conp, struct display* p, const unsigned short* s, int count, int yy, int xx) {
+	u_int16_t c;
 	u_int32_t fgx, bgx;
 	MINFO_FROM_DISP(p);
 
 	DBG_HEAVY("matroxfb_cfb8_putcs");
 
-	fgx = attr_fgcol(p, scr_readw(s));
-	bgx = attr_bgcol(p, scr_readw(s));
+	c = scr_readw(s);
+	fgx = attr_fgcol(p, c);
+	bgx = attr_bgcol(p, c);
 	fgx |= (fgx << 8);
 	fgx |= (fgx << 16);
 	bgx |= (bgx << 8);
@@ -671,13 +673,15 @@
 
 #ifdef FBCON_HAS_CFB16
 static void matrox_cfb16_putcs(struct vc_data* conp, struct display* p, const unsigned short* s, int count, int yy, int xx) {
+	u_int16_t c;
 	u_int32_t fgx, bgx;
 	MINFO_FROM_DISP(p);
 
 	DBG_HEAVY("matroxfb_cfb16_putcs");
 
-	fgx = ((u_int16_t*)p->dispsw_data)[attr_fgcol(p, scr_readw(s))];
-	bgx = ((u_int16_t*)p->dispsw_data)[attr_bgcol(p, scr_readw(s))];
+	c = scr_readw(s);
+	fgx = ((u_int16_t*)p->dispsw_data)[attr_fgcol(p, c)];
+	bgx = ((u_int16_t*)p->dispsw_data)[attr_bgcol(p, c)];
 	fgx |= (fgx << 16);
 	bgx |= (bgx << 16);
 	ACCESS_FBINFO(curr.putcs)(fgx, bgx, p, s, count, yy, xx);
@@ -686,13 +690,15 @@
 
 #if defined(FBCON_HAS_CFB32) || defined(FBCON_HAS_CFB24)
 static void matrox_cfb32_putcs(struct vc_data* conp, struct display* p, const unsigned short* s, int count, int yy, int xx) {
+	u_int16_t c;
 	u_int32_t fgx, bgx;
 	MINFO_FROM_DISP(p);
 
 	DBG_HEAVY("matroxfb_cfb32_putcs");
 
-	fgx = ((u_int32_t*)p->dispsw_data)[attr_fgcol(p, scr_readw(s))];
-	bgx = ((u_int32_t*)p->dispsw_data)[attr_bgcol(p, scr_readw(s))];
+	c = scr_readw(s);
+	fgx = ((u_int32_t*)p->dispsw_data)[attr_fgcol(p, c)];
+	bgx = ((u_int32_t*)p->dispsw_data)[attr_bgcol(p, c)];
 	ACCESS_FBINFO(curr.putcs)(fgx, bgx, p, s, count, yy, xx);
 }
 #endif
@@ -900,12 +906,14 @@
 	unsigned int offs;
 	unsigned int attr;
 	unsigned int step;
+	u_int16_t c;
 	CRITFLAGS
 	MINFO_FROM_DISP(p);
 
 	step = ACCESS_FBINFO(devflags.textstep);
 	offs = yy * p->next_line + xx * step;
-	attr = attr_fgcol(p, scr_readw(s)) | (attr_bgcol(p, scr_readw(s)) << 4);
+	c = scr_readw(s);
+	attr = attr_fgcol(p, c) | (attr_bgcol(p, c) << 4);
 
 	CRITBEGIN
 
diff -ur linux-2.4.8-ac9/drivers/video/newport_con.c scr-audit-2.4.8-ac9/drivers/video/newport_con.c
--- linux-2.4.8-ac9/drivers/video/newport_con.c	Mon Oct 16 21:53:18 2000
+++ scr-audit-2.4.8-ac9/drivers/video/newport_con.c	Wed Aug 22 18:48:32 2001
@@ -359,7 +359,7 @@
     int charattr;
     unsigned char *p; 
 
-    charattr = (*s >> 8) & 0xff;
+    charattr = (scr_readw(s) >> 8) & 0xff;
 
     xpos <<= 3;
     ypos <<= 4;
@@ -378,7 +378,7 @@
 			     NPORT_DMODE0_L32);
     
     for (i = 0; i < count; i++, xpos += 8) {
-	p = &FONT_DATA[(s[i] & 0xff) << 4];
+	p = &FONT_DATA[(scr_readw(s++) & 0xff) << 4];
 
 	newport_wait();
 
diff -ur linux-2.4.8-ac9/drivers/video/promcon.c scr-audit-2.4.8-ac9/drivers/video/promcon.c
--- linux-2.4.8-ac9/drivers/video/promcon.c	Mon Feb 19 10:37:00 2001
+++ scr-audit-2.4.8-ac9/drivers/video/promcon.c	Wed Aug 22 18:48:32 2001
@@ -51,27 +51,30 @@
 {
 	unsigned short *s = (unsigned short *)
 			(conp->vc_origin + py * conp->vc_size_row + (px << 1));
+	u16 cs;
 
+	cs = scr_readw(s);
 	if (px == pw) {
 		unsigned short *t = s - 1;
+		u16 ct = scr_readw(t);
 
-		if (inverted(*s) && inverted(*t))
-			return sprintf(b, "\b\033[7m%c\b\033[@%c\033[m",
-				       *s, *t);
-		else if (inverted(*s))
-			return sprintf(b, "\b\033[7m%c\033[m\b\033[@%c",
-				       *s, *t);
-		else if (inverted(*t))
-			return sprintf(b, "\b%c\b\033[@\033[7m%c\033[m",
-				       *s, *t);
+		if (inverted(cs) && inverted(ct))
+			return sprintf(b, "\b\033[7m%c\b\033[@%c\033[m", cs,
+				       ct);
+		else if (inverted(cs))
+			return sprintf(b, "\b\033[7m%c\033[m\b\033[@%c", cs,
+				       ct);
+		else if (inverted(ct))
+			return sprintf(b, "\b%c\b\033[@\033[7m%c\033[m", cs,
+				       ct);
 		else
-			return sprintf(b, "\b%c\b\033[@%c", *s, *t);
+			return sprintf(b, "\b%c\b\033[@%c", cs, ct);
 	}
 
-	if (inverted(*s))
-		return sprintf(b, "\033[7m%c\033[m\b", *s);
+	if (inverted(cs))
+		return sprintf(b, "\033[7m%c\033[m\b", cs);
 	else
-		return sprintf(b, "%c\b", *s);
+		return sprintf(b, "%c\b", cs);
 }
 
 static int
@@ -80,27 +83,30 @@
 	unsigned short *s = (unsigned short *)
 			(conp->vc_origin + py * conp->vc_size_row + (px << 1));
 	char *p = b;
+	u16 cs;
 
 	b += sprintf(b, "\033[%d;%dH", py + 1, px + 1);
 
+	cs = scr_readw(s);
 	if (px == pw) {
 		unsigned short *t = s - 1;
+		u16 ct = scr_readw(t);
 
-		if (inverted(*s) && inverted(*t))
-			b += sprintf(b, "\b%c\b\033[@\033[7m%c\033[m", *s, *t);
-		else if (inverted(*s))
-			b += sprintf(b, "\b%c\b\033[@%c", *s, *t);
-		else if (inverted(*t))
-			b += sprintf(b, "\b\033[7m%c\b\033[@%c\033[m", *s, *t);
+		if (inverted(cs) && inverted(ct))
+			b += sprintf(b, "\b%c\b\033[@\033[7m%c\033[m", cs, ct);
+		else if (inverted(cs))
+			b += sprintf(b, "\b%c\b\033[@%c", cs, ct);
+		else if (inverted(ct))
+			b += sprintf(b, "\b\033[7m%c\b\033[@%c\033[m", cs, ct);
 		else
-			b += sprintf(b, "\b\033[7m%c\033[m\b\033[@%c", *s, *t);
+			b += sprintf(b, "\b\033[7m%c\033[m\b\033[@%c", cs, ct);
 		return b - p;
 	}
 
-	if (inverted(*s))
-		b += sprintf(b, "%c\b", *s);
+	if (inverted(cs))
+		b += sprintf(b, "%c\b", cs);
 	else
-		b += sprintf(b, "\033[7m%c\033[m\b", *s);
+		b += sprintf(b, "\033[7m%c\033[m\b", cs);
 	return b - p;
 }
 
@@ -206,8 +212,9 @@
 	unsigned char *b = *bp;
 
 	while (cnt--) {
-		if (attr != inverted(*s)) {
-			attr = inverted(*s);
+		u16 c = scr_readw(s);
+		if (attr != inverted(c)) {
+			attr = inverted(c);
 			if (attr) {
 				strcpy (b, "\033[7m");
 				b += 4;
@@ -216,7 +223,8 @@
 				b += 3;
 			}
 		}
-		*b++ = *s++;
+		*b++ = c;
+		s++;
 		if (b - buf >= 224) {
 			promcon_puts(buf, b - buf);
 			b = buf;
@@ -246,9 +254,9 @@
 	if (x + count >= pw + 1) {
 		if (count == 1) {
 			x -= 1;
-			save = *(unsigned short *)(conp->vc_origin
+			save = scr_readw((unsigned short *)(conp->vc_origin
 						   + y * conp->vc_size_row
-						   + (x << 1));
+						   + (x << 1)));
 
 			if (px != x || py != y) {
 				b += sprintf(b, "\033[%d;%dH", y + 1, x + 1);
diff -ur linux-2.4.8-ac9/drivers/video/riva/accel.c scr-audit-2.4.8-ac9/drivers/video/riva/accel.c
--- linux-2.4.8-ac9/drivers/video/riva/accel.c	Mon Feb 19 10:37:00 2001
+++ scr-audit-2.4.8-ac9/drivers/video/riva/accel.c	Wed Aug 22 18:48:32 2001
@@ -207,10 +207,11 @@
 	xx *= fontwidth(p);
 	yy *= fontheight(p);
 
+	c = scr_readw(s);
+	fgx = attr_fgcol(p, c);
+	bgx = attr_bgcol(p, c);
 	while (count--) {
 		c = scr_readw(s++);
-		fgx = attr_fgcol(p,c);
-		bgx = attr_bgcol(p,c);
 		fbcon_riva_writechr(conp, p, c, fgx, bgx, yy, xx);
 		xx += fontwidth(p);
 	}
@@ -321,12 +322,13 @@
 	xx *= fontwidth(p);
 	yy *= fontheight(p);
 
+	c = scr_readw(s);
+	fgx = ((u16 *)p->dispsw_data)[attr_fgcol(p, c)];
+	bgx = ((u16 *)p->dispsw_data)[attr_bgcol(p, c)];
+	if (p->var.green.length == 6)
+		convert_bgcolor_16(&bgx);
 	while (count--) {
 		c = scr_readw(s++);
-		fgx = ((u16 *)p->dispsw_data)[attr_fgcol(p,c)];
-		bgx = ((u16 *)p->dispsw_data)[attr_bgcol(p,c)];
-		if (p->var.green.length == 6)
-			convert_bgcolor_16(&bgx);
 		fbcon_riva_writechr(conp, p, c, fgx, bgx, yy, xx);
 		xx += fontwidth(p);
 	}
@@ -396,10 +398,11 @@
 	xx *= fontwidth(p);
 	yy *= fontheight(p);
 
+	c = scr_readw(s);
+	fgx = ((u32 *)p->dispsw_data)[attr_fgcol(p, c)];
+	bgx = ((u32 *)p->dispsw_data)[attr_bgcol(p, c)];
 	while (count--) {
 		c = scr_readw(s++);
-		fgx = ((u32 *)p->dispsw_data)[attr_fgcol(p,c)];
-		bgx = ((u32 *)p->dispsw_data)[attr_bgcol(p,c)];
 		fbcon_riva_writechr(conp, p, c, fgx, bgx, yy, xx);
 		xx += fontwidth(p);
 	}
diff -ur linux-2.4.8-ac9/drivers/video/sticon-bmode.c scr-audit-2.4.8-ac9/drivers/video/sticon-bmode.c
--- linux-2.4.8-ac9/drivers/video/sticon-bmode.c	Mon Feb 19 10:04:59 2001
+++ scr-audit-2.4.8-ac9/drivers/video/sticon-bmode.c	Wed Aug 22 18:48:32 2001
@@ -318,7 +318,7 @@
 	int count, int ypos, int xpos)
 {
 	while(count--) {
-		sti_putc(&default_sti, *s++, ypos, xpos++);
+		sti_putc(&default_sti, scr_readw(s++), ypos, xpos++);
 	}
 }
 
@@ -402,16 +402,6 @@
 	return 0;
 }
 
-static u16 *sticon_screen_pos(struct vc_data *conp, int offset)
-{
-	return NULL;
-}
-
-static unsigned long sticon_getxy(struct vc_data *conp, unsigned long pos, int *px, int *py)
-{
-	return 0;
-}
-
 static u8 sticon_build_attr(struct vc_data *conp, u8 color, u8 intens, u8 blink, u8 underline, u8 reverse)
 {
 	u8 attr = ((color & 0x70) >> 1) | ((color & 7));
@@ -440,11 +430,7 @@
 	con_set_palette:	sticon_set_palette,
 	con_scrolldelta:	sticon_scrolldelta,
 	con_set_origin: 	sticon_set_origin,
-	con_save_screen:	NULL,
 	con_build_attr:		sticon_build_attr,
-	con_invert_region:	NULL,
-	con_screen_pos:		sticon_screen_pos,
-	con_getxy:		sticon_getxy,
 };
 
 #include <asm/pgalloc.h>	/* need cache flush routines */
diff -ur linux-2.4.8-ac9/drivers/video/sticon.c scr-audit-2.4.8-ac9/drivers/video/sticon.c
--- linux-2.4.8-ac9/drivers/video/sticon.c	Tue Dec  5 21:29:39 2000
+++ scr-audit-2.4.8-ac9/drivers/video/sticon.c	Wed Aug 22 18:48:32 2001
@@ -86,7 +86,7 @@
 	int count, int ypos, int xpos)
 {
 	while(count--) {
-		sti_putc(&default_sti, *s++, ypos, xpos++);
+		sti_putc(&default_sti, scr_readw(s++), ypos, xpos++);
 	}
 }
 
@@ -170,16 +170,6 @@
 	return 0;
 }
 
-static u16 *sticon_screen_pos(struct vc_data *conp, int offset)
-{
-	return NULL;
-}
-
-static unsigned long sticon_getxy(struct vc_data *conp, unsigned long pos, int *px, int *py)
-{
-	return 0;
-}
-
 static u8 sticon_build_attr(struct vc_data *conp, u8 color, u8 intens, u8 blink, u8 underline, u8 reverse)
 {
 	u8 attr = ((color & 0x70) >> 1) | ((color & 7));
@@ -208,11 +198,7 @@
 	con_set_palette:	sticon_set_palette,
 	con_scrolldelta:	sticon_scrolldelta,
 	con_set_origin: 	sticon_set_origin,
-	con_save_screen:	NULL,
 	con_build_attr:		sticon_build_attr,
-	con_invert_region:	NULL,
-	con_screen_pos:		sticon_screen_pos,
-	con_getxy:		sticon_getxy,
 };
 
 static int __init sti_init(void)
diff -ur linux-2.4.8-ac9/drivers/video/tdfxfb.c scr-audit-2.4.8-ac9/drivers/video/tdfxfb.c
--- linux-2.4.8-ac9/drivers/video/tdfxfb.c	Wed Aug  8 11:51:07 2001
+++ scr-audit-2.4.8-ac9/drivers/video/tdfxfb.c	Wed Aug 22 18:48:32 2001
@@ -1088,27 +1088,27 @@
 			    struct display* p,
 			    const unsigned short *s,int count,int yy,int xx)
 {
-   u32 fgx,bgx;
-   fgx=attr_fgcol(p, *s);
-   bgx=attr_bgcol(p, *s);
+   u16 c = scr_readw(s);
+   u32 fgx = attr_fgcol(p, c);
+   u32 bgx = attr_bgcol(p, c);
    do_putcs( fgx,bgx,p,s,count,yy,xx );
 }
 static void tdfx_cfb16_putcs(struct vc_data* conp,
 			    struct display* p,
 			    const unsigned short *s,int count,int yy,int xx)
 {
-   u32 fgx,bgx;
-   fgx=((u16*)p->dispsw_data)[attr_fgcol(p,*s)];
-   bgx=((u16*)p->dispsw_data)[attr_bgcol(p,*s)];
+   u16 c = scr_readw(s);
+   u32 fgx = ((u16*)p->dispsw_data)[attr_fgcol(p, c)];
+   u32 bgx = ((u16*)p->dispsw_data)[attr_bgcol(p, c)];
    do_putcs( fgx,bgx,p,s,count,yy,xx );
 }
 static void tdfx_cfb32_putcs(struct vc_data* conp,
 			    struct display* p,
 			    const unsigned short *s,int count,int yy,int xx)
 {
-   u32 fgx,bgx;
-   fgx=((u32*)p->dispsw_data)[attr_fgcol(p,*s)];
-   bgx=((u32*)p->dispsw_data)[attr_bgcol(p,*s)];
+   u16 c = scr_readw(s);
+   u32 fgx = ((u32*)p->dispsw_data)[attr_fgcol(p, c)];
+   u32 bgx = ((u32*)p->dispsw_data)[attr_bgcol(p, c)];
    do_putcs( fgx,bgx,p,s,count,yy,xx );
 }
 
diff -ur linux-2.4.8-ac9/drivers/video/vgacon.c scr-audit-2.4.8-ac9/drivers/video/vgacon.c
--- linux-2.4.8-ac9/drivers/video/vgacon.c	Mon Feb 19 10:37:01 2001
+++ scr-audit-2.4.8-ac9/drivers/video/vgacon.c	Wed Aug 22 18:48:32 2001
@@ -486,7 +486,7 @@
 	vga_video_num_columns = c->vc_cols;
 	vga_video_num_lines = c->vc_rows;
 	if (!vga_is_gfx)
-		scr_memcpyw_to((u16 *) c->vc_origin, (u16 *) c->vc_screenbuf, c->vc_screenbuf_size);
+		scr_memcpyw((u16 *) c->vc_origin, (u16 *) c->vc_screenbuf, c->vc_screenbuf_size);
 	return 0;	/* Redrawing not needed */
 }
 
@@ -977,7 +977,7 @@
 		c->vc_y = ORIG_Y;
 	}
 	if (!vga_is_gfx)
-		scr_memcpyw_from((u16 *) c->vc_screenbuf, (u16 *) c->vc_origin, c->vc_screenbuf_size);
+		scr_memcpyw((u16 *) c->vc_screenbuf, (u16 *) c->vc_origin, c->vc_screenbuf_size);
 }
 
 static int vgacon_scroll(struct vc_data *c, int t, int b, int dir, int lines)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

