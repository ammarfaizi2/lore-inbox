Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271697AbRI2WZv>; Sat, 29 Sep 2001 18:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271708AbRI2WZn>; Sat, 29 Sep 2001 18:25:43 -0400
Received: from mail.sonytel.be ([193.74.243.200]:28393 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S271697AbRI2WZ3>;
	Sat, 29 Sep 2001 18:25:29 -0400
Date: Sun, 30 Sep 2001 00:25:09 +0200 (MET DST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Olaf Hering <olh@suse.de>, Hollis Blanchard <hollis@austin.ibm.com>
Subject: Re: scr_*() audit
In-Reply-To: <Pine.LNX.4.05.10108221846140.6842-100000@callisto.of.borg>
Message-ID: <Pine.GSO.4.10.10109300020100.29063-100000@rose.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001, Geert Uytterhoeven wrote:
> Since there are still some issues left with the scr_*() functions on
> big-endian platforms that can have both VGA and frame buffer consoles, I
> decided to spent some precious time on auditing the usage of these functions.

So here are the (updated) fixes. They are most critical for big-endian machines
that can have real VGA text hardware and frame buffer devices. Little-endian
machines are immune since VGA text is little-endian anyway.

Changes since previous version:
  - Fix missing semicolon in console.c
  - Fix pointer arithmetic in hgafb.c
  - Remove scr_memcpyw_{from,to}() since they are no longer used

The patch should apply cleanly to all recent 2.4.x[-ac] kernels.

Alan, please apply.

--- linux-2.4.10/drivers/char/console.c	Tue Sep 25 10:14:43 2001
+++ scr-audit-2.4.10/drivers/char/console.c	Sat Sep 29 19:30:08 2001
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
+				q++;
 			}
 		}
 	}
--- linux-2.4.10/drivers/video/dn_cfb8.c	Thu Sep 13 10:37:10 2001
+++ scr-audit-2.4.10/drivers/video/dn_cfb8.c	Sat Sep 29 17:50:23 2001
@@ -518,7 +518,7 @@
     underl = attr_underline(p,conp);
 
     while (count--) {
-	c = *s++;
+	c = scr_readw(s++);
 	dest = dest0++;
 	cdat = p->fontdata+c*p->fontheight;
 	for (rows = p->fontheight; rows--; dest += p->next_line) {
--- linux-2.4.10/drivers/video/fbcon-vga-planes.c	Thu Sep 13 10:37:12 2001
+++ scr-audit-2.4.10/drivers/video/fbcon-vga-planes.c	Sat Sep 29 17:50:24 2001
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
--- linux-2.4.10/drivers/video/fbcon.c	Thu Sep 13 10:37:12 2001
+++ scr-audit-2.4.10/drivers/video/fbcon.c	Sat Sep 29 17:50:24 2001
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
--- linux-2.4.10/drivers/video/hgafb.c	Tue Sep 25 10:15:12 2001
+++ scr-audit-2.4.10/drivers/video/hgafb.c	Sat Sep 29 19:30:08 2001
@@ -203,7 +203,7 @@
 		fillchar = 0x00;
 	spin_unlock_irqrestore(&hga_reg_lock, flags);
 	if (fillchar != 0xbf)
-		memset((char *)hga_vram_base, fillchar, hga_vram_len);
+		isa_memset_io(hga_vram_base, fillchar, hga_vram_len);
 }
 
 
@@ -275,11 +275,12 @@
 static void hga_show_logo(void)
 {
 	int x, y;
-	char *dest = (char *)hga_vram_base;
+	unsigned long dest = hga_vram_base;
 	char *logo = linux_logo_bw;
 	for (y = 134; y < 134 + 80 ; y++) /* this needs some cleanup */
 		for (x = 0; x < 10 ; x++)
-			*(dest + (y%4)*8192 + (y>>2)*90 + x + 40) = ~*(logo++);
+			isa_writeb(~*(logo++),
+				   (dest + (y%4)*8192 + (y>>2)*90 + x + 40));
 }
 #endif /* MODULE */	
 
--- linux-2.4.10/drivers/video/newport_con.c	Thu Sep 13 10:37:13 2001
+++ scr-audit-2.4.10/drivers/video/newport_con.c	Sat Sep 29 17:53:29 2001
@@ -379,7 +379,7 @@
 	int charattr;
 	unsigned char *p;
 
-	charattr = (*s >> 8) & 0xff;
+	charattr = (scr_readw(s) >> 8) & 0xff;
 
 	xpos <<= 3;
 	ypos <<= 4;
@@ -399,7 +399,7 @@
 				 NPORT_DMODE0_L32);
 
 	for (i = 0; i < count; i++, xpos += 8) {
-		p = &font_data[vc->vc_num][(s[i] & 0xff) << 4];
+		p = &font_data[vc->vc_num][(scr_readw(s++) & 0xff) << 4];
 
 		newport_wait();
 
--- linux-2.4.10/drivers/video/promcon.c	Mon Feb 19 10:37:00 2001
+++ scr-audit-2.4.10/drivers/video/promcon.c	Sat Sep 29 17:50:24 2001
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
--- linux-2.4.10/drivers/video/sticon-bmode.c	Thu Sep 13 10:37:15 2001
+++ scr-audit-2.4.10/drivers/video/sticon-bmode.c	Sat Sep 29 17:50:24 2001
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
--- linux-2.4.10/drivers/video/sticon.c	Tue Dec  5 21:29:39 2000
+++ scr-audit-2.4.10/drivers/video/sticon.c	Sat Sep 29 17:50:24 2001
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
--- linux-2.4.10/drivers/video/tdfxfb.c	Thu Sep 13 08:41:26 2001
+++ scr-audit-2.4.10/drivers/video/tdfxfb.c	Sat Sep 29 17:50:25 2001
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
 
--- linux-2.4.10/drivers/video/vgacon.c	Thu Sep 13 10:37:16 2001
+++ scr-audit-2.4.10/drivers/video/vgacon.c	Sat Sep 29 17:50:25 2001
@@ -487,7 +487,7 @@
 	vga_video_num_columns = c->vc_cols;
 	vga_video_num_lines = c->vc_rows;
 	if (!vga_is_gfx)
-		scr_memcpyw_to((u16 *) c->vc_origin, (u16 *) c->vc_screenbuf, c->vc_screenbuf_size);
+		scr_memcpyw((u16 *) c->vc_origin, (u16 *) c->vc_screenbuf, c->vc_screenbuf_size);
 	return 0;	/* Redrawing not needed */
 }
 
@@ -978,7 +978,7 @@
 		c->vc_y = ORIG_Y;
 	}
 	if (!vga_is_gfx)
-		scr_memcpyw_from((u16 *) c->vc_screenbuf, (u16 *) c->vc_origin, c->vc_screenbuf_size);
+		scr_memcpyw((u16 *) c->vc_screenbuf, (u16 *) c->vc_origin, c->vc_screenbuf_size);
 }
 
 static int vgacon_scroll(struct vc_data *c, int t, int b, int dir, int lines)
--- linux-2.4.10/include/asm-alpha/vga.h	Fri Mar 17 22:01:38 2000
+++ scr-audit-2.4.10/include/asm-alpha/vga.h	Sat Sep 29 19:59:57 2001
@@ -12,7 +12,6 @@
 #define VT_BUF_HAVE_RW
 #define VT_BUF_HAVE_MEMSETW
 #define VT_BUF_HAVE_MEMCPYW
-#define VT_BUF_HAVE_MEMCPYF
 
 extern inline void scr_writew(u16 val, volatile u16 *addr)
 {
@@ -40,8 +39,6 @@
 
 /* Do not trust that the usage will be correct; analyze the arguments.  */
 extern void scr_memcpyw(u16 *d, const u16 *s, unsigned int count);
-#define scr_memcpyw_from scr_memcpyw
-#define scr_memcpyw_to   scr_memcpyw
 
 /* ??? These are currently only used for downloading character sets.  As
    such, they don't need memory barriers.  Is this all they are intended
--- linux-2.4.10/include/linux/vt_buffer.h	Thu Jan  4 23:51:24 2001
+++ scr-audit-2.4.10/include/linux/vt_buffer.h	Sat Sep 29 20:00:36 2001
@@ -26,9 +26,6 @@
 #define scr_memmovew(d, s, c) memmove(d, s, c)
 #define VT_BUF_HAVE_MEMCPYW
 #define VT_BUF_HAVE_MEMMOVEW
-#define scr_memcpyw_from(d, s, c) memcpy(d, s, c)
-#define scr_memcpyw_to(d, s, c) memcpy(d, s, c)
-#define VT_BUF_HAVE_MEMCPYF
 #endif
 
 #ifndef VT_BUF_HAVE_MEMSETW
@@ -61,22 +58,6 @@
 		while (count--)
 			scr_writew(scr_readw(--s), --d);
 	}
-}
-#endif
-
-#ifndef VT_BUF_HAVE_MEMCPYF
-static inline void scr_memcpyw_from(u16 *d, const u16 *s, unsigned int count)
-{
-	count /= 2;
-	while (count--)
-		*d++ = scr_readw(s++);
-}
-
-static inline void scr_memcpyw_to(u16 *d, const u16 *s, unsigned int count)
-{
-	count /= 2;
-	while (count--)
-		scr_writew(*s++, d++);
 }
 #endif
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

