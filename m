Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271708AbRI2W1v>; Sat, 29 Sep 2001 18:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271712AbRI2W1n>; Sat, 29 Sep 2001 18:27:43 -0400
Received: from mail.sonytel.be ([193.74.243.200]:43753 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S271708AbRI2W1k>;
	Sat, 29 Sep 2001 18:27:40 -0400
Date: Sun, 30 Sep 2001 00:27:27 +0200 (MET DST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Olaf Hering <olh@suse.de>, Hollis Blanchard <hollis@austin.ibm.com>
Subject: Re: scr_*() audit
In-Reply-To: <Pine.LNX.4.05.10108221846140.6842-100000@callisto.of.borg>
Message-ID: <Pine.GSO.4.10.10109300025140.29063-100000@rose.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Geert Uytterhoeven wrote:
> Since there are still some issues left with the scr_*() functions on
> big-endian platforms that can have both VGA and frame buffer consoles, I
> decided to spent some precious time on auditing the usage of these functions.

And here are the optimizations (I split them off from the bug fixes because
they are not that critical).

Should apply cleanly to any recent 2.4.x[-ac] kernel.

--- linux-2.4.10/drivers/video/cgsixfb.c	Tue Sep 25 10:15:11 2001
+++ scr-audit-2.4.10/drivers/video/cgsixfb.c	Sat Sep 29 17:50:23 2001
@@ -364,13 +364,15 @@
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
--- linux-2.4.10/drivers/video/creatorfb.c	Tue Sep 25 10:15:11 2001
+++ scr-audit-2.4.10/drivers/video/creatorfb.c	Sat Sep 29 17:50:23 2001
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
--- linux-2.4.10/drivers/video/fbcon-afb.c	Thu Sep 13 10:37:10 2001
+++ scr-audit-2.4.10/drivers/video/fbcon-afb.c	Sat Sep 29 17:50:23 2001
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
--- linux-2.4.10/drivers/video/fbcon-cfb16.c	Thu Sep 13 10:37:11 2001
+++ scr-audit-2.4.10/drivers/video/fbcon-cfb16.c	Sat Sep 29 17:50:23 2001
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
--- linux-2.4.10/drivers/video/fbcon-cfb2.c	Thu Sep 13 10:37:11 2001
+++ scr-audit-2.4.10/drivers/video/fbcon-cfb2.c	Sat Sep 29 17:50:23 2001
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
--- linux-2.4.10/drivers/video/fbcon-cfb24.c	Thu Sep 13 10:37:11 2001
+++ scr-audit-2.4.10/drivers/video/fbcon-cfb24.c	Sat Sep 29 17:50:23 2001
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
--- linux-2.4.10/drivers/video/fbcon-cfb32.c	Thu Sep 13 10:37:11 2001
+++ scr-audit-2.4.10/drivers/video/fbcon-cfb32.c	Sat Sep 29 17:50:23 2001
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
--- linux-2.4.10/drivers/video/fbcon-cfb4.c	Thu Sep 13 10:37:11 2001
+++ scr-audit-2.4.10/drivers/video/fbcon-cfb4.c	Sat Sep 29 17:50:23 2001
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
--- linux-2.4.10/drivers/video/fbcon-cfb8.c	Thu Sep 13 10:37:11 2001
+++ scr-audit-2.4.10/drivers/video/fbcon-cfb8.c	Sat Sep 29 17:50:24 2001
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
--- linux-2.4.10/drivers/video/fbcon-hga.c	Thu Sep 13 10:37:11 2001
+++ scr-audit-2.4.10/drivers/video/fbcon-hga.c	Sat Sep 29 17:50:24 2001
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
--- linux-2.4.10/drivers/video/fbcon-ilbm.c	Thu Sep 13 10:37:11 2001
+++ scr-audit-2.4.10/drivers/video/fbcon-ilbm.c	Sat Sep 29 17:50:24 2001
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
--- linux-2.4.10/drivers/video/fbcon-iplan2p2.c	Thu Sep 13 10:37:11 2001
+++ scr-audit-2.4.10/drivers/video/fbcon-iplan2p2.c	Sat Sep 29 17:50:24 2001
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
--- linux-2.4.10/drivers/video/fbcon-iplan2p4.c	Thu Sep 13 10:37:11 2001
+++ scr-audit-2.4.10/drivers/video/fbcon-iplan2p4.c	Sat Sep 29 17:50:24 2001
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
--- linux-2.4.10/drivers/video/fbcon-iplan2p8.c	Thu Sep 13 10:37:11 2001
+++ scr-audit-2.4.10/drivers/video/fbcon-iplan2p8.c	Sat Sep 29 17:50:24 2001
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
--- linux-2.4.10/drivers/video/fbcon-mfb.c	Thu Sep 13 10:37:11 2001
+++ scr-audit-2.4.10/drivers/video/fbcon-mfb.c	Sat Sep 29 17:50:24 2001
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
--- linux-2.4.10/drivers/video/fbcon-sti.c	Thu Sep 13 10:37:12 2001
+++ scr-audit-2.4.10/drivers/video/fbcon-sti.c	Sat Sep 29 17:50:24 2001
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
--- linux-2.4.10/drivers/video/fbcon-vga-planes.c	Thu Sep 13 10:37:12 2001
+++ scr-audit-2.4.10/drivers/video/fbcon-vga-planes.c	Sat Sep 29 17:50:24 2001
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
--- linux-2.4.10/drivers/video/leofb.c	Tue Sep 25 10:15:12 2001
+++ scr-audit-2.4.10/drivers/video/leofb.c	Sat Sep 29 17:50:24 2001
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
--- linux-2.4.10/drivers/video/matrox/matroxfb_accel.c	Wed Jun 20 11:06:14 2001
+++ scr-audit-2.4.10/drivers/video/matrox/matroxfb_accel.c	Sat Sep 29 17:50:24 2001
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
 
--- linux-2.4.10/drivers/video/riva/accel.c	Mon Feb 19 10:37:00 2001
+++ scr-audit-2.4.10/drivers/video/riva/accel.c	Sat Sep 29 17:50:24 2001
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

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

