Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262912AbTCUCbb>; Thu, 20 Mar 2003 21:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262970AbTCUCba>; Thu, 20 Mar 2003 21:31:30 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:52352 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262912AbTCUCbQ>; Thu, 20 Mar 2003 21:31:16 -0500
Date: Fri, 21 Mar 2003 11:40:11 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       James Simmons <jsimmons@infradead.org>
Subject: [PATCH 2.5.65-ac1] Support PC-9800 subarchitecture (2/14) console
Message-ID: <20030321024011.GB1847@yuzuki.cinet.co.jp>
References: <20030321022850.GA1767@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321022850.GA1767@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.65-ac1. (2/14)

PC98 Standard console support (without japanese kanji character).
Text mode video card on PC98 is useing 2bytes of VRAM by 1 character to
support japanese kanji character. VRAM for attributes is mapped another
address (+0x2000).
Character codes 0x80-0xff are diffrent with standerd PC.

Regards,
Osamu Tomita

diff -Nru linux-2.5.60/drivers/char/Makefile linux98-2.5.60/drivers/char/Makefile
--- linux-2.5.60/drivers/char/Makefile	2003-02-18 11:10:03.000000000 +0900
+++ linux98-2.5.60/drivers/char/Makefile	2003-02-20 09:16:30.000000000 +0900
@@ -5,7 +5,11 @@
 #
 # This file contains the font map for the default (hardware) font
 #
+ifeq ($(CONFIG_X86_PC9800),y)
+FONTMAPFILE = pc9800.uni
+else
 FONTMAPFILE = cp437.uni
+endif
 
 obj-y	 += mem.o tty_io.o n_tty.o tty_ioctl.o pty.o misc.o random.o
 
diff -Nru linux/drivers/char/console_macros.h linux98/drivers/char/console_macros.h
--- linux/drivers/char/console_macros.h	Sat Oct 19 13:01:17 2002
+++ linux98/drivers/char/console_macros.h	Mon Oct 28 16:53:39 2002
@@ -55,6 +55,10 @@
 #define	s_reverse	(vc_cons[currcons].d->vc_s_reverse)
 #define	ulcolor		(vc_cons[currcons].d->vc_ulcolor)
 #define	halfcolor	(vc_cons[currcons].d->vc_halfcolor)
+#define def_attr	(vc_cons[currcons].d->vc_def_attr)
+#define ul_attr		(vc_cons[currcons].d->vc_ul_attr)
+#define half_attr	(vc_cons[currcons].d->vc_half_attr)
+#define bold_attr	(vc_cons[currcons].d->vc_bold_attr)
 #define tab_stop	(vc_cons[currcons].d->vc_tab_stop)
 #define palette		(vc_cons[currcons].d->vc_palette)
 #define bell_pitch	(vc_cons[currcons].d->vc_bell_pitch)
diff -Nru linux/drivers/char/console_pc9800.h linux98/drivers/char/console_pc9800.h
--- linux/drivers/char/console_pc9800.h	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/char/console_pc9800.h	Mon Oct 28 11:48:10 2002
@@ -0,0 +1,14 @@
+#ifndef __CONSOLE_PC9800_H
+#define __CONSOLE_PC9800_H
+
+#define BLANK_ATTR	0x00E1
+
+#define JIS_CODE       0x01
+#define EUC_CODE       0x00
+#define SJIS_CODE      0x02
+#define JIS_CODE_ASCII  0x00
+#define JIS_CODE_78     0x01
+#define JIS_CODE_83     0x02
+#define JIS_CODE_90     0x03
+
+#endif /* __CONSOLE_PC9800_H */
diff -Nru linux/drivers/char/consolemap.c linux98/drivers/char/consolemap.c
--- linux/drivers/char/consolemap.c	2002-12-10 11:46:14.000000000 +0900
+++ linux98/drivers/char/consolemap.c	2002-12-16 11:27:23.000000000 +0900
@@ -23,7 +23,7 @@
 #include <linux/consolemap.h>
 #include <linux/vt_kern.h>
 
-static unsigned short translations[][256] = {
+unsigned short translations[][256] = {
   /* 8-bit Latin-1 mapped to Unicode -- trivial mapping */
   {
     0x0000, 0x0001, 0x0002, 0x0003, 0x0004, 0x0005, 0x0006, 0x0007,
@@ -163,7 +163,59 @@
     0xf0e8, 0xf0e9, 0xf0ea, 0xf0eb, 0xf0ec, 0xf0ed, 0xf0ee, 0xf0ef,
     0xf0f0, 0xf0f1, 0xf0f2, 0xf0f3, 0xf0f4, 0xf0f5, 0xf0f6, 0xf0f7,
     0xf0f8, 0xf0f9, 0xf0fa, 0xf0fb, 0xf0fc, 0xf0fd, 0xf0fe, 0xf0ff
-  }
+  },
+  /* JIS X0201 mapped to Unicode */
+  /* code marked with ** is not defined in JIS X0201.
+	 So 0x00 - 0x1f are mapped to same to Laten1,
+	 and others are mapped to PC-9800 internal font# directry */
+  {
+    0x0000, 0x0001, 0x0002, 0x0003, 0x0004, 0x0005, 0x0006, 0x0007,
+/*    **      **      **      **      **      **      **      **    */
+    0x0008, 0x0009, 0x000a, 0x000b, 0x000c, 0x000d, 0x000e, 0x000f,
+/*    **      **      **      **      **      **      **      **    */
+    0x0010, 0x0011, 0x0012, 0x0013, 0x0014, 0x0015, 0x0016, 0x0017,
+/*    **      **      **      **      **      **      **      **    */
+    0x0018, 0x0019, 0x001a, 0x001b, 0x001c, 0x001d, 0x001e, 0x001f,
+/*    **      **      **      **      **      **      **      **    */
+    0x0020, 0x0021, 0x0022, 0x0023, 0x0024, 0x0025, 0x0026, 0x0027,
+    0x0028, 0x0029, 0x002a, 0x002b, 0x002c, 0x002d, 0x002e, 0x002f,
+    0x0030, 0x0031, 0x0032, 0x0033, 0x0034, 0x0035, 0x0036, 0x0037,
+    0x0038, 0x0039, 0x003a, 0x003b, 0x003c, 0x003d, 0x003e, 0x003f,
+    0x0040, 0x0041, 0x0042, 0x0043, 0x0044, 0x0045, 0x0046, 0x0047,
+    0x0048, 0x0049, 0x004a, 0x004b, 0x004c, 0x004d, 0x004e, 0x004f,
+    0x0050, 0x0051, 0x0052, 0x0053, 0x0054, 0x0055, 0x0056, 0x0057,
+    0x0058, 0x0059, 0x005a, 0x005b, 0x00a5, 0x005d, 0x005e, 0x005f,
+    0x0060, 0x0061, 0x0062, 0x0063, 0x0064, 0x0065, 0x0066, 0x0067,
+    0x0068, 0x0069, 0x006a, 0x006b, 0x006c, 0x006d, 0x006e, 0x006f,
+    0x0070, 0x0071, 0x0072, 0x0073, 0x0074, 0x0075, 0x0076, 0x0077,
+    0x0078, 0x0079, 0x007a, 0x007b, 0x007c, 0x007d, 0x203e, 0xf07f,
+/*                                                            **   */
+    0xf080, 0xf081, 0xf082, 0xf083, 0xf084, 0xf085, 0xf086, 0xf087,
+/*    **      **      **      **      **      **      **      **    */
+    0xf088, 0xf089, 0xf08a, 0xf08b, 0xf08c, 0xf08d, 0xf08e, 0xf08f,
+/*    **      **      **      **      **      **      **      **    */
+    0xf090, 0xf091, 0xf092, 0xf093, 0xf094, 0xf095, 0xf096, 0xf097,
+/*    **      **      **      **      **      **      **      **    */
+    0xf098, 0xf099, 0xf09a, 0xf09b, 0xf09c, 0xf09d, 0xf09e, 0xf09f,
+/*    **      **      **      **      **      **      **      **    */
+    0xf0a0, 0xff61, 0xff62, 0xff63, 0xff64, 0xff65, 0xff66, 0xff67,
+/*    **                                                            */
+    0xff68, 0xff69, 0xff6a, 0xff6b, 0xff6c, 0xff6d, 0xff6e, 0xff6f,
+    0xff70, 0xff71, 0xff72, 0xff73, 0xff74, 0xff75, 0xff76, 0xff77,
+    0xff78, 0xff79, 0xff7a, 0xff7b, 0xff7c, 0xff7d, 0xff7e, 0xff7f,
+    0xff80, 0xff81, 0xff82, 0xff83, 0xff84, 0xff85, 0xff86, 0xff87,
+    0xff88, 0xff89, 0xff8a, 0xff8b, 0xff8c, 0xff8d, 0xff8e, 0xff8f,
+    0xff90, 0xff91, 0xff92, 0xff93, 0xff94, 0xff95, 0xff96, 0xff97,
+    0xff98, 0xff99, 0xff9a, 0xff9b, 0xff9c, 0xff9d, 0xff9e, 0xff9f,
+    0xf0e0, 0xf0e1, 0xf0e2, 0xf0e3, 0xf0e4, 0xf0e5, 0xf0e6, 0xf0e7,
+/*    **      **      **      **      **      **      **      **    */
+    0xf0e8, 0xf0e9, 0xf0ea, 0xf0eb, 0xf0ec, 0xf0ed, 0xf0ee, 0xf0ef,
+/*    **      **      **      **      **      **      **      **    */
+    0xf0f0, 0xf0f1, 0xf0f2, 0xf0f3, 0xf0f4, 0xf0f5, 0xf0f6, 0xf0f7,
+/*    **      **      **      **      **      **      **      **    */
+    0xf0f8, 0xf0f9, 0xf0fa, 0xf0fb, 0xf0fc, 0xf0fd, 0xf0fe, 0xf0ff
+/*    **      **      **      **      **      **      **      **    */
+  },
 };
 
 /* The standard kernel character-to-font mappings are not invertible
@@ -177,7 +229,7 @@
 	u16 		**uni_pgdir[32];
 	unsigned long	refcount;
 	unsigned long	sum;
-	unsigned char	*inverse_translations[4];
+	unsigned char	*inverse_translations[5];
 	int		readonly;
 };
 
diff -Nru linux/drivers/char/pc9800.uni linux98/drivers/char/pc9800.uni
--- linux/drivers/char/pc9800.uni	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/char/pc9800.uni	Fri Aug 17 21:50:17 2001
@@ -0,0 +1,260 @@
+#
+# Unicode table for PC-9800 console.
+# Copyright (C) 1998,2001  Linux/98 project (project Seraphim)
+#			   Kyoto University Microcomputer Club (KMC).
+#
+
+# Kore ha unicode wo 98 no ROM no font ni taio saseru tame no
+# map desu.
+
+# Characters for control codes.
+# PC-9800 uses 2-char sequences while Unicode uses 3-char for some codes.
+0x00	
+0x01	U+2401	# SH / SOH
+0x02	U+2402	# SX / SOX
+0x03	U+2403	# EX / ETX
+0x04	U+2404	# ET / EOT
+0x05	U+2405	# EQ / ENQ
+0x06	U+2406	# AK / ACK
+0x07	U+2407	# BL / BEL
+0x08	U+2408	# BS
+0x09	U+2409	# HT
+0x0a	U+240a	# LF
+0x0b		# HM / (VT)
+0x0c		# CL / (FF)
+0x0d	U+240d	# CR
+0x0e		# SO / (SS)
+0x0f	U+240f	# SI
+0x10	U+2410	# DE / DLE
+0x11	U+2411	# D1 / DC1
+0x12	U+2412	# D2 / DC2
+0x13	U+2413	# D3 / DC3
+0x14	U+2414	# D4 / DC4
+0x15	U+2415	# NK / NAK
+0x16	U+2416	# SN / SYN
+0x17	U+2417	# EB / ETB
+0x18	U+2418	# CN / CAN
+0x19	U+2419	# EM
+0x1a	U+241a	# SB / SUB
+0x1b	U+241b	# EC / ESC
+
+# arrow
+0x1c	U+2192 U+ffeb	# right
+0x1d	U+2190 U+ffe9	# left
+0x1e	U+2191 U+ffea	# up
+0x1f	U+2193 U+ffec	# down
+
+#
+# The ASCII range is identity-mapped, but some of the characters also
+# have to act as substitutes, especially the upper-case characters.
+#
+0x20	U+0020
+0x21	U+0021
+# U+00a8 is Latin-1 Supplement DIAELESIS.
+0x22	U+0022 U+00a8
+0x23	U+0023
+0x24	U+0024
+0x25	U+0025
+0x26	U+0026
+0x26	U+2019	# General Punctuation "RIGHT SINGLE QUOTATION MARK"
+0x27	U+0027 U+2032
+0x28	U+0028
+0x29	U+0029
+0x2a	U+002a
+0x2b	U+002b
+# U+00b8 is Latin-1 Supplement CEDILLA.
+0x2c	U+002c U+00b8
+# U+00b8 is Latin-1 Supplement SOFT HYPHEN.
+0x2d	U+002d U+00ad
+0x2d	U+2212	# Mathematical Operators "MINUS SIGN"
+0x2e	U+002e
+0x2f	U+002f
+0x2f	U+2044	# General Punctuation "FRACTION SLASH"
+0x2f	U+2215	# Mathematical Operators "DIVISION SLASH"
+0x30	U+0030
+0x31	U+0031
+0x32	U+0032
+0x33	U+0033
+0x34	U+0034
+0x35	U+0035
+0x36	U+0036
+0x37	U+0037
+0x38	U+0038
+0x39	U+0039
+0x3a	U+003a
+0x3a	U+003a	# Mathematical Operators "RATIO"
+0x3b	U+003b
+0x3c	U+003c
+0x3d	U+003d
+0x3e	U+003e
+0x3f	U+003f
+0x40	U+0040
+0x41	U+0041 U+00c0 U+00c1 U+00c2 U+00c3
+0x42	U+0042
+# U+00a9 is Latin-1 Supplement COPYRIGHT SIGN.
+0x43	U+0043 U+00a9
+0x44	U+0044
+0x45	U+0045 U+00c8 U+00ca U+00cb
+0x46	U+0046
+0x47	U+0047
+0x48	U+0048
+0x49	U+0049 U+00cc U+00cd U+00ce U+00cf
+0x4a	U+004a
+# U+212a: Letterlike Symbols "KELVIN SIGN"
+0x4b	U+004b U+212a
+0x4c	U+004c
+0x4d	U+004d
+0x4e	U+004e
+0x4f	U+004f U+00d2 U+00d3 U+00d4 U+00d5
+0x50	U+0050
+0x51	U+0051
+# U+00ae: Latin-1 Supplement "REGISTERED SIGN"
+0x52	U+0052 U+00ae
+0x53	U+0053
+0x54	U+0054
+0x55	U+0055 U+00d9 U+00da U+00db
+0x56	U+0056
+0x57	U+0057
+0x58	U+0058
+0x59	U+0059 U+00dd
+0x5a	U+005a
+0x5b	U+005b
+0x5c	U+00a5	# Latin-1 Supplement "YEN SIGN"
+0x5d	U+005d
+0x5e	U+005e
+0x5f	U+005f U+f804
+0x60	U+0060 U+2035
+0x61	U+0061 U+00e3
+0x62	U+0062
+0x63	U+0063
+0x64	U+0064
+0x65	U+0065
+0x66	U+0066
+0x67	U+0067
+0x68	U+0068
+0x69	U+0069
+0x6a	U+006a
+0x6b	U+006b
+0x6c	U+006c
+0x6d	U+006d
+0x6e	U+006e
+0x6f	U+006f U+00f5
+0x70	U+0070
+0x71	U+0071
+0x72	U+0072
+0x73	U+0073
+0x74	U+0074
+0x75	U+0075
+0x76	U+0076
+0x77	U+0077
+0x78	U+0078 U+00d7
+0x79	U+0079 U+00fd
+0x7a	U+007a
+0x7b	U+007b
+# U+00a6: Latin-1 Supplement "BROKEN (VERTICAL) BAR"
+0x7c	U+007c U+00a6
+0x7d	U+007d
+0x7e	U+007e
+
+# kuhaku
+0x7f	# U+2302
+
+# Block Elements.
+0x80	U+2581	# LOWER ONE EIGHTH BLOCK
+0x81	U+2582	# LOWER ONE QUARTER BLOCK
+0x82	U+2583	# LOWER THREE EIGHTHS BLOCK
+0x83	U+2584	# LOWER HALF BLOCK
+0x84	U+2585	# LOWER FIVE EIGHTHS BLOCK
+0x85	U+2586	# LOWER THREE QUARTERS BLOCK
+0x86	U+2587	# LOWER SEVEN EIGHTHS BLOCK
+0x87	U+2588	# FULL BLOCK
+0x88	U+258f	# LEFT ONE EIGHTH BLOCK
+0x89	U+258e	# LEFT ONE QUARTER BLOCK
+0x8a	U+258d	# LEFT THREE EIGHTHS BLOCK
+0x8b	U+258c	# LEFT HALF BLOCK
+0x8c	U+258b	# LEFT FIVE EIGHTHS BLOCK
+0x8d	U+258a	# LEFT THREE QUARTERS BLOCK
+0x8e	U+2589	# LEFT SEVEN EIGHTHS BLOCK
+
+# Box Drawing.
+0x8f	U+253c
+0x90	U+2534
+0x91	U+252c
+0x92	U+2524
+0x93	U+251c
+0x94	U+203e	# General Punctuation "OVERLINE" (= "SPACING OVERSCORE")
+0x95	U+2500	# Box Drawing "BOX DRAWING LIGHT HORIZONTAL"
+0x96	U+2502	# Box Drawing "BOX DRAWING LIGHT VERTICAL"
+0x96	U+ffe8	# Halfwidth symbol variants "HALFWIDTH FORMS LIGHT VERTICAL"
+0x97	U+2595	# Block Elements "RIGHT ONE EIGHTH BLOCK"
+0x98	U+250c
+0x99	U+2510
+0x9a	U+2514
+0x9b	U+2518
+
+0x9c	U+256d	# "BOX DRAWING LIGHT ARC DOWN AND RIGHT"
+0x9d	U+256e	# "BOX DRAWING LIGHT ARC DOWN AND LEFT"
+0x9e	U+2570	# "BOX DRAWING LIGHT ARC UP AND RIGHT"
+0x9f	U+256f	# "BOX DRAWING LIGHT ARC UP AND LEFT"
+
+0xa0	# another whitespace
+
+# Halfwidth CJK punctuation
+0xa1 - 0xa4	U+ff61 - U+ff64
+
+# Halfwidth Katakana variants
+0xa5 - 0xdf	U+ff65 - U+ff9f
+0xa5	U+00b7	# Latin-1 Supplement "MIDDLE DOT"
+0xdf	U+00b0	# Latin-1 Supplement "DEGREE SIGN"
+
+# Box Drawing
+0xe0	U+2550	# "BOX DRAWING DOUBLE HORIZONTAL"
+0xe1	U+255e	# "BOX DRAWING VERTICAL SINGLE AND RIGHT DOUBLE"
+0xe2	U+256a	# "BOX DRAWING VERTICAL SINGLE AND HORIZONTAL DOUBLE"
+0xe3	U+2561	# "BOX DRAWING VERTICAL SINGLE AND LEFT DOUBLE"
+
+# Geometric Shapes
+0xe4	U+25e2	# "BLACK LOWER RIGHT TRIANGLE"
+0xe5	U+25e3	# "BLACK LOWER LEFT TRIANGLE"
+0xe6	U+25e5	# "BLACK UPPER RIGHT TRIANGLE"
+0xe7	U+25e4	# "BLACK UPPER LEFT TRIANGLE"
+
+# Playing card symbols
+0xe8	U+2660	# "BLACK SPADE SUIT"
+0xe9	U+2665	# "BLACK HEART SUIT"
+0xea	U+2666	# "BLACK DIAMOND SUIT"
+0xeb	U+2663	# "BLACK CLUB SUIT"
+
+# Geometric Shapes
+0xec	U+25cf	# "BLACK CIRCLE"
+0xed	U+25cb U+25ef	# "WHITE CIRCLE", "LARGE CIRCLE"
+
+# Box Drawing
+0xee	U+2571	# "BOX DRAWING LIGHT DIAGONAL UPPER RIGHT TO LOWER LEFT"
+0xef	U+2572	# "BOX DRAWING LIGHT DIAGONAL UPPER LEFT TO LOWER RIGHT"
+0xf0	U+2573	# "BOX DRAWING LIGHT DIAGONAL CROSS"
+
+# CJK Unified Ideographs (XXX - should these be here?)
+0xf1	U+5186
+0xf2	U+5e74
+0xf3	U+6708
+0xf4	U+65e5
+0xf5	U+6642
+0xf6	U+5206
+0xf7	U+79d2
+
+# unassigned
+0xf8
+0xf9
+0xfa
+0xfb
+
+0xfc	U+005c	# "REVERSE SOLIDUS" / "BACKSLASH"
+0xfc	U+2216	# Mathematical Operators "SET MINUS"
+
+# unassigned
+0xfd
+0xfe
+0xff
+
+# End of pc9800.uni
diff -Nru linux-2.5.65/drivers/char/vt.c linux98-2.5.65/drivers/char/vt.c
--- linux-2.5.65/drivers/char/vt.c	2003-03-18 08:52:14.000000000 +0900
+++ linux98-2.5.65/drivers/char/vt.c	2003-03-18 11:12:28.000000000 +0900
@@ -107,6 +107,10 @@
 
 #include "console_macros.h"
 
+#ifdef CONFIG_X86_PC9800
+#include "console_pc9800.h"
+extern unsigned short translations[][256];
+#endif
 
 const struct consw *conswitchp;
 
@@ -301,7 +305,7 @@
 		xx = nxx; yy = nyy;
 	}
 	for(;;) {
-		u16 attrib = scr_readw(p) & 0xff00;
+		vram_char_t attrib = scr_readw(p) & 0xff00;
 		int startx = xx;
 		u16 *q = p;
 		while (xx < video_num_columns && count) {
@@ -387,6 +391,8 @@
 {
 	attr = build_attr(currcons, color, intensity, blink, underline, reverse ^ decscnm);
 	video_erase_char = (build_attr(currcons, color, 1, blink, 0, decscnm) << 8) | ' ';
+	if (pc98 && decscnm)
+		video_erase_char |= 0x0400; /* reverse */
 }
 
 /* Note: inverting the screen twice should revert to the original state */
@@ -403,7 +409,7 @@
 	else {
 		u16 *q = p;
 		int cnt = count;
-		u16 a;
+		vram_char_t a;
 
 		if (!can_do_color) {
 			while (cnt--) {
@@ -437,7 +443,7 @@
 void complement_pos(int currcons, int offset)
 {
 	static unsigned short *p;
-	static unsigned short old;
+	static vram_char_t old;
 	static unsigned short oldx, oldy;
 
 	if (p) {
@@ -448,10 +454,15 @@
 	if (offset == -1)
 		p = NULL;
 	else {
-		unsigned short new;
+		vram_char_t new;
 		p = screenpos(currcons, offset, 1);
 		old = scr_readw(p);
+#ifdef CONFIG_FB_EGC
+		new = (old & 0xff0000ff) | ((old & 0xf000) >> 4)
+			| ((old & 0xf00) << 4);
+#else
 		new = old ^ complement_mask;
+#endif
 		scr_writew(new, p);
 		if (DO_UPDATE) {
 			oldx = (offset >> 1) % video_num_columns;
@@ -510,7 +521,7 @@
 
 static void add_softcursor(int currcons)
 {
-	int i = scr_readw((u16 *) pos);
+	vram_char_t i = scr_readw((u16 *) pos);
 	u32 type = cursor_type;
 
 	if (! (type & 0x10)) return;
@@ -646,8 +657,12 @@
     complement_mask = 0;
     can_do_color = 0;
     sw->con_init(vc_cons[currcons].d, init);
-    if (!complement_mask)
-        complement_mask = can_do_color ? 0x7700 : 0x0800;
+    if (!complement_mask) {
+	if (pc98)
+        	complement_mask = 0x0400;
+	else
+        	complement_mask = can_do_color ? 0x7700 : 0x0800;
+    }
     s_complement_mask = complement_mask;
     video_size_row = video_num_columns<<1;
     screenbuf_size = video_num_lines*video_size_row;
@@ -679,7 +694,7 @@
 	    visual_init(currcons, 1);
 	    if (!*vc_cons[currcons].d->vc_uni_pagedir_loc)
 		con_set_default_unimap(currcons);
-	    q = (long)kmalloc(screenbuf_size, GFP_KERNEL);
+	    q = (long)kmalloc(screenbuf_size + (pc98 ? screenbuf_size : 0), GFP_KERNEL);
 	    if (!q) {
 		kfree((char *) p);
 		vc_cons[currcons].d = NULL;
@@ -732,7 +747,7 @@
 	if (new_cols == video_num_columns && new_rows == video_num_lines)
 		return 0;
 
-	newscreen = (unsigned short *) kmalloc(new_screen_size, GFP_USER);
+	newscreen = (unsigned short *) kmalloc(new_screen_size + (pc98 ? new_screen_size : 0), GFP_USER);
 	if (!newscreen)
 		return -ENOMEM;
 
@@ -1263,6 +1278,10 @@
 /* console_sem is held */
 static void setterm_command(int currcons)
 {
+	if (sw->con_setterm_command
+	    && sw->con_setterm_command(vc_cons[currcons].d))
+		return;
+
 	switch(par[0]) {
 		case 1:	/* set color for underline mode */
 			if (can_do_color && par[1] < 16) {
@@ -2429,9 +2448,17 @@
 		vc_cons[currcons].d->vc_palette[k++] = default_grn[j] ;
 		vc_cons[currcons].d->vc_palette[k++] = default_blu[j] ;
 	}
-	def_color       = 0x07;   /* white */
-	ulcolor		= 0x0f;   /* bold white */
-	halfcolor       = 0x08;   /* grey */
+	if (pc98) {
+		def_color	= 0x07;		/* white */
+		def_attr	= 0xE1;
+		ul_attr		= 0x08;		/* underline */
+		half_attr	= 0x00;		/* ignore half color */
+		bold_attr	= 0xC1;		/* yellow */
+	} else {
+		def_color       = 0x07;   /* white */
+		ulcolor		= 0x0f;   /* bold white */
+		halfcolor       = 0x08;   /* grey */
+	}
 	init_waitqueue_head(&vt_cons[currcons]->paste_wait);
 	reset_terminal(currcons, do_clear);
 }
@@ -2472,7 +2499,12 @@
 		vt_cons[currcons] = (struct vt_struct *)
 				alloc_bootmem(sizeof(struct vt_struct));
 		visual_init(currcons, 1);
+#if defined(CONFIG_X86_PC9800) || defined(CONFIG_FB)
+		screenbuf
+			= (unsigned short *) alloc_bootmem(screenbuf_size * 2);
+#else
 		screenbuf = (unsigned short *) alloc_bootmem(screenbuf_size);
+#endif
 		kmalloced = 0;
 		vc_init(currcons, video_num_lines, video_num_columns, 
 			currcons || !sw->con_save_screen);
@@ -2976,9 +3008,12 @@
 /* used by selection */
 u16 screen_glyph(int currcons, int offset)
 {
-	u16 w = scr_readw(screenpos(currcons, offset, 1));
+	vram_char_t w = scr_readw(screenpos(currcons, offset, 1));
 	u16 c = w & 0xff;
 
+	if (pc98)
+		return ((u16)(w >> 16) & 0xff00) | c;
+
 	if (w & hi_font_mask)
 		c |= 0x100;
 	return c;
@@ -3040,8 +3075,10 @@
 EXPORT_SYMBOL(default_red);
 EXPORT_SYMBOL(default_grn);
 EXPORT_SYMBOL(default_blu);
+#ifndef CONFIG_X86_PC9800
 EXPORT_SYMBOL(video_font_height);
 EXPORT_SYMBOL(video_scan_lines);
+#endif
 EXPORT_SYMBOL(vc_cons_allocated);
 EXPORT_SYMBOL(update_region);
 EXPORT_SYMBOL(redraw_screen);
diff -Nru linux/drivers/char/vt_ioctl.c linux98/drivers/char/vt_ioctl.c
--- linux/drivers/char/vt_ioctl.c	2002-12-10 11:46:13.000000000 +0900
+++ linux98/drivers/char/vt_ioctl.c	2002-12-16 13:15:34.000000000 +0900
@@ -63,9 +63,11 @@
 asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 #endif
 
+#ifndef CONFIG_X86_PC9800
 unsigned int video_font_height;
 unsigned int default_font_height;
 unsigned int video_scan_lines;
+#endif
 
 /*
  * these are the valid i/o ports we're allowed to change. they map all the
@@ -637,6 +639,17 @@
 		return 0;
 	}
 
+#ifdef CONFIG_X86_PC9800
+	case VT_GDC_RESIZE:
+	{
+		if (!perm)
+			return -EPERM; 
+/*		con_adjust_height(0);*/
+		update_screen(console);
+		return 0;
+	}
+#endif 
+
 	case VT_SETMODE:
 	{
 		struct vt_mode tmp;
@@ -830,7 +843,9 @@
 		__get_user(clin, &vtconsize->v_clin);
 		__get_user(vcol, &vtconsize->v_vcol);
 		__get_user(ccol, &vtconsize->v_ccol);
+#ifndef CONFIG_X86_PC9800
 		vlin = vlin ? vlin : video_scan_lines;
+#endif
 		if (clin) {
 			if (ll) {
 				if (ll != vlin/clin)
@@ -849,10 +864,12 @@
 		if (clin > 32)
 			return -EINVAL;
 		    
+#ifndef CONFIG_X86_PC9800		    
 		if (vlin)
 			video_scan_lines = vlin;
 		if (clin)
 			video_font_height = clin;
+#endif
 	
 		for (i = 0; i < MAX_NR_CONSOLES; i++)
 			vc_resize(i, cc, ll);
@@ -1022,8 +1039,10 @@
 	vt_cons[new_console]->vt_mode.frsig = 0;
 	vt_cons[new_console]->vt_pid = -1;
 	vt_cons[new_console]->vt_newvt = -1;
+#ifndef CONFIG_X86_PC9800
 	if (!in_interrupt())    /* Via keyboard.c:SAK() - akpm */
 		reset_palette(new_console) ;
+#endif
 }
 
 /*
diff -Nru linux-2.5.59/drivers/video/console/Kconfig linux98-2.5.59/drivers/video/console/Kconfig
--- linux-2.5.59/drivers/video/console/Kconfig	2003-01-17 13:22:14.000000000 +0900
+++ linux98-2.5.59/drivers/video/console/Kconfig	2003-01-17 13:43:44.000000000 +0900
@@ -6,7 +6,7 @@
 
 config VGA_CONSOLE
 	bool "VGA text console"
-	depends on !ARCH_ACORN && !ARCH_EBSA110 || !4xx && !8xx
+	depends on !X86_PC9800 && !ARCH_ACORN && !ARCH_EBSA110 || !4xx && !8xx
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
 	  display that complies with the generic VGA standard. Virtually
@@ -97,6 +97,18 @@
 	  Say Y to build a console driver for Sun machines that uses the
 	  terminal emulation built into their console PROMS.
 
+config GDC_CONSOLE
+	bool "PC-9800 GDC text console"
+	depends on X86_PC9800
+	default y
+	help
+	  This enables support for PC-9800 standard text mode console.
+	  If use NEC PC-9801/PC-9821, Say Y.
+
+config GDC_32BITACCESS
+	bool "Enable 32-bit access to text video RAM"
+	depends on GDC_CONSOLE
+
 config DUMMY_CONSOLE
 	bool
 	depends on PROM_CONSOLE!=y || VGA_CONSOLE!=y || SGI_NEWPORT_CONSOLE!=y
diff -Nru linux/include/linux/console.h linux98/include/linux/console.h
--- linux/include/linux/console.h	2003-02-15 08:51:33.000000000 +0900
+++ linux98/include/linux/console.h	2003-02-20 09:47:41.000000000 +0900
@@ -17,6 +17,13 @@
 #include <linux/types.h>
 #include <linux/kdev_t.h>
 #include <linux/spinlock.h>
+#include <linux/config.h>
+
+#ifdef CONFIG_X86_PC9800
+typedef __u32 vram_char_t;
+#else
+typedef __u16 vram_char_t;
+#endif
 
 struct vc_data;
 struct console_font_op;
@@ -32,7 +39,7 @@
 	void	(*con_init)(struct vc_data *, int);
 	void	(*con_deinit)(struct vc_data *);
 	void	(*con_clear)(struct vc_data *, int, int, int, int);
-	void	(*con_putc)(struct vc_data *, int, int, int);
+	void	(*con_putc)(struct vc_data *, int, vram_char_t, int);
 	void	(*con_putcs)(struct vc_data *, const unsigned short *, int, int, int);
 	void	(*con_cursor)(struct vc_data *, int);
 	int	(*con_scroll)(struct vc_data *, int, int, int, int);
@@ -49,6 +56,7 @@
 	void	(*con_invert_region)(struct vc_data *, u16 *, int);
 	u16    *(*con_screen_pos)(struct vc_data *, int);
 	unsigned long (*con_getxy)(struct vc_data *, unsigned long, int *, int *);
+	int	(*con_setterm_command)(struct vc_data *);
 };
 
 extern const struct consw *conswitchp;
@@ -56,6 +64,7 @@
 extern const struct consw dummy_con;	/* dummy console buffer */
 extern const struct consw fb_con;	/* frame buffer based console */
 extern const struct consw vga_con;	/* VGA text console */
+extern const struct consw gdc_con;	/* PC-9800 GDC text console */
 extern const struct consw newport_con;	/* SGI Newport console  */
 extern const struct consw prom_con;	/* SPARC PROM console */
 
diff -Nru linux/include/linux/console_struct.h linux98/include/linux/console_struct.h
--- linux/include/linux/console_struct.h	2002-12-10 11:45:40.000000000 +0900
+++ linux98/include/linux/console_struct.h	2002-12-16 13:25:55.000000000 +0900
@@ -9,6 +9,9 @@
  * to achieve effects such as fast scrolling by changing the origin.
  */
 
+#include <linux/config.h>
+#include <linux/console.h>
+
 #define NPAR 16
 
 struct vc_data {
@@ -25,10 +28,14 @@
 	unsigned char	vc_s_color;		/* Saved foreground & background */
 	unsigned char	vc_ulcolor;		/* Color for underline mode */
 	unsigned char	vc_halfcolor;		/* Color for half intensity mode */
+	unsigned char	vc_def_attr;		/* Default attributes */
+	unsigned char	vc_ul_attr;		/* Attribute for underline mode */
+	unsigned char	vc_half_attr;		/* Attribute for half intensity mode */
+	unsigned char	vc_bold_attr;		/* Attribute for bold mode */
 	unsigned short	vc_complement_mask;	/* [#] Xor mask for mouse pointer */
 	unsigned short	vc_hi_font_mask;	/* [#] Attribute set for upper 256 chars of font or 0 if not supported */
 	struct console_font_op vc_font;		/* Current VC font set */
-	unsigned short	vc_video_erase_char;	/* Background erase character */
+	vram_char_t	vc_video_erase_char;	/* Background erase character */
 	unsigned short	vc_s_complement_mask;	/* Saved mouse pointer mask */
 	unsigned int	vc_x, vc_y;		/* Cursor position */
 	unsigned int	vc_top, vc_bottom;	/* Scrolling region */
@@ -106,6 +113,10 @@
 #define CUR_HWMASK	0x0f
 #define CUR_SWMASK	0xfff0
 
+#ifdef CONFIG_X86_PC9800
+#define CUR_DEFAULT CUR_BLOCK
+#else
 #define CUR_DEFAULT CUR_UNDERLINE
+#endif
 
 #define CON_IS_VISIBLE(conp) (*conp->vc_display_fg == conp)
diff -Nru linux/include/linux/tty.h linux98/include/linux/tty.h
--- linux/include/linux/tty.h	Sat Oct 19 13:01:54 2002
+++ linux98/include/linux/tty.h	Mon Oct 21 14:22:18 2002
@@ -123,6 +123,10 @@
 
 #define VIDEO_TYPE_PMAC		0x60	/* PowerMacintosh frame buffer. */
 
+#define VIDEO_TYPE_98NORMAL	0xa4	/* NEC PC-9800 normal */
+#define VIDEO_TYPE_9840		0xa5	/* NEC PC-9800 normal 40 lines */
+#define VIDEO_TYPE_98HIRESO	0xa6	/* NEC PC-9800 hireso */
+
 /*
  * This character is the same as _POSIX_VDISABLE: it cannot be used as
  * a c_cc[] character, but indicates that a particular special character
diff -Nru linux/include/linux/vt.h linux98/include/linux/vt.h
--- linux/include/linux/vt.h	Sat Oct 19 13:02:30 2002
+++ linux98/include/linux/vt.h	Mon Oct 21 14:26:03 2002
@@ -50,5 +50,6 @@
 #define VT_RESIZEX      0x560A  /* set kernel's idea of screensize + more */
 #define VT_LOCKSWITCH   0x560B  /* disallow vt switching */
 #define VT_UNLOCKSWITCH 0x560C  /* allow vt switching */
+#define VT_GDC_RESIZE   0x5698
 
 #endif /* _LINUX_VT_H */
diff -Nru linux/include/linux/vt_buffer.h linux98/include/linux/vt_buffer.h
--- linux/include/linux/vt_buffer.h	Sat Oct 19 13:02:24 2002
+++ linux98/include/linux/vt_buffer.h	Mon Oct 21 14:28:40 2002
@@ -19,6 +19,10 @@
 #include <asm/vga.h>
 #endif
 
+#ifdef CONFIG_GDC_CONSOLE
+#include <asm/gdc.h>
+#endif
+
 #ifndef VT_BUF_HAVE_RW
 #define scr_writew(val, addr) (*(addr) = (val))
 #define scr_readw(addr) (*(addr))
