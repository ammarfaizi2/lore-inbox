Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261358AbSJQLhO>; Thu, 17 Oct 2002 07:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbSJQLhO>; Thu, 17 Oct 2002 07:37:14 -0400
Received: from precia.cinet.co.jp ([210.166.75.133]:1664 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261358AbSJQLeh>; Thu, 17 Oct 2002 07:34:37 -0400
Date: Thu, 17 Oct 2002 20:39:51 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][RFC] add support for PC-9800 architecture (3/26) console
Message-ID: <20021017203951.A1158@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 3/26 of patchset for add support NEC PC-9800 architecture,
against 2.5.43.

Summary:
 console display modules
  - add jis-x201 charset("kana") support
  - add multi-byte char("kanji") support

 Now, support japanese only and works only with PC-9800 video driver.
 I hope this may be base for ather multi-byte languege support.

diffstat:
 drivers/char/Makefile          |   18 +
 drivers/char/console_macros.h  |   24 +
 drivers/char/console_pc9800.h  |   27 +
 drivers/char/consolemap.c      |   67 +++
 drivers/char/pc9800.uni        |  260 +++++++++++++++
 drivers/char/vc_screen.c       |   33 +
 drivers/char/vt.c              |  690 ++++++++++++++++++++++++++++++++++++++++-
 drivers/char/vt_ioctl.c        |   19 +
 include/linux/console.h        |    3 
 include/linux/console_struct.h |   34 ++
 include/linux/consolemap.h     |    6 
 include/linux/tty.h            |    8 
 include/linux/vt.h             |    5 
 include/linux/vt_buffer.h      |    6 
 14 files changed, 1187 insertions(+), 13 deletions(-)

patch:
diff -urN linux/drivers/char/Makefile linux98/drivers/char/Makefile
--- linux/drivers/char/Makefile	Wed Oct 16 13:20:34 2002
+++ linux98/drivers/char/Makefile	Wed Oct 16 21:03:18 2002
@@ -5,7 +5,11 @@
 #
 # This file contains the font map for the default (hardware) font
 #
+ifneq ($(CONFIG_PC9800),y)
 FONTMAPFILE = cp437.uni
+else
+FONTMAPFILE = pc9800.uni
+endif
 
 obj-y	 += mem.o tty_io.o n_tty.o tty_ioctl.o pty.o misc.o random.o
 
@@ -15,9 +19,14 @@
 export-objs     :=	busmouse.o vt.o generic_serial.o ip2main.o \
 			ite_gpio.o keyboard.o misc.o nvram.o random.o rtc.o \
 			selection.o sonypi.o sysrq.o tty_io.o tty_ioctl.o
+export-objs     +=	upd4990a.o
 
 obj-$(CONFIG_VT) += vt_ioctl.o vc_screen.o consolemap.o consolemap_deftbl.o selection.o keyboard.o
+ifneq ($(CONFIG_PC9800),y)
 obj-$(CONFIG_HW_CONSOLE) += vt.o defkeymap.o
+else
+obj-$(CONFIG_HW_CONSOLE) += vt.o defkeymap_pc9800.o
+endif
 obj-$(CONFIG_MAGIC_SYSRQ) += sysrq.o
 obj-$(CONFIG_ATARI_DSP56K) += dsp56k.o
 obj-$(CONFIG_ROCKETPORT) += rocket.o
@@ -51,6 +60,7 @@
 
 obj-$(CONFIG_PRINTER) += lp.o
 obj-$(CONFIG_TIPAR) += tipar.o
+obj-$(CONFIG_PC9800_OLDLP)) += lp_old98.o
 
 obj-$(CONFIG_BUSMOUSE) += busmouse.o
 obj-$(CONFIG_DTLK) += dtlk.o
@@ -58,7 +68,11 @@
 obj-$(CONFIG_APPLICOM) += applicom.o
 obj-$(CONFIG_SONYPI) += sonypi.o
 obj-$(CONFIG_ATARIMOUSE) += atarimouse.o
+ifneq ($(CONFIG_PC9800),y)
 obj-$(CONFIG_RTC) += rtc.o
+else
+obj-$(CONFIG_RTC) += upd4990a.o
+endif
 obj-$(CONFIG_GEN_RTC) += genrtc.o
 obj-$(CONFIG_EFI_RTC) += efirtc.o
 ifeq ($(CONFIG_PPC),)
@@ -109,7 +123,11 @@
 $(obj)/consolemap_deftbl.c: $(src)/$(FONTMAPFILE)
 	$(call do_cmd,CONMK  $(echo_target),$(objtree)/scripts/conmakehash $< > $@)
 
+ifneq ($(CONFIG_PC9800),y)
 $(obj)/defkeymap.o:  $(obj)/defkeymap.c
+else
+$(obj)/defkeymap_pc9800.o:  $(obj)/defkeymap_pc9800.c
+endif
 
 $(obj)/qtronixmap.o: $(obj)/qtronixmap.c
 
diff -urN linux/drivers/char/console_macros.h linux98/drivers/char/console_macros.h
--- linux/drivers/char/console_macros.h	Fri Sep 18 01:35:03 1998
+++ linux98/drivers/char/console_macros.h	Fri Aug 17 22:15:12 2001
@@ -1,3 +1,5 @@
+#include <linux/config.h>
+
 #define cons_num	(vc_cons[currcons].d->vc_num)
 #define sw		(vc_cons[currcons].d->vc_sw)
 #define screenbuf	(vc_cons[currcons].d->vc_screenbuf)
@@ -27,6 +29,9 @@
 #define utf_count	(vc_cons[currcons].d->vc_utf_count)
 #define utf_char	(vc_cons[currcons].d->vc_utf_char)
 #define video_erase_char (vc_cons[currcons].d->vc_video_erase_char)
+#ifdef CONFIG_PC9800
+#define video_erase_attr (vc_cons[currcons].d->vc_video_erase_attr)
+#endif
 #define disp_ctrl	(vc_cons[currcons].d->vc_disp_ctrl)
 #define toggle_meta	(vc_cons[currcons].d->vc_toggle_meta)
 #define decscnm		(vc_cons[currcons].d->vc_decscnm)
@@ -55,6 +60,12 @@
 #define	s_reverse	(vc_cons[currcons].d->vc_s_reverse)
 #define	ulcolor		(vc_cons[currcons].d->vc_ulcolor)
 #define	halfcolor	(vc_cons[currcons].d->vc_halfcolor)
+#ifdef CONFIG_GDC_CONSOLE
+# define def_attr	(vc_cons[currcons].d->vc_def_attr)
+# define ul_attr	(vc_cons[currcons].d->vc_ul_attr)
+# define half_attr	(vc_cons[currcons].d->vc_half_attr)
+# define bold_attr	(vc_cons[currcons].d->vc_bold_attr)
+#endif
 #define tab_stop	(vc_cons[currcons].d->vc_tab_stop)
 #define palette		(vc_cons[currcons].d->vc_palette)
 #define bell_pitch	(vc_cons[currcons].d->vc_bell_pitch)
@@ -64,6 +75,19 @@
 #define complement_mask (vc_cons[currcons].d->vc_complement_mask)
 #define s_complement_mask (vc_cons[currcons].d->vc_s_complement_mask)
 #define hi_font_mask	(vc_cons[currcons].d->vc_hi_font_mask)
+#ifdef CONFIG_PC9800
+#define kanji_mode     (vc_cons[currcons].d->vc_kanji_mode)
+#define s_kanji_mode   (vc_cons[currcons].d->vc_s_kanji_mode)
+#define kanji_char1    (vc_cons[currcons].d->vc_kanji_char1)
+#define translate_ex   (vc_cons[currcons].d->vc_translate_ex)
+#define G0_charset_ex  (vc_cons[currcons].d->vc_G0_charset_ex)
+#define G1_charset_ex  (vc_cons[currcons].d->vc_G1_charset_ex)
+#define saved_G0_ex    (vc_cons[currcons].d->vc_saved_G0_ex)
+#define saved_G1_ex    (vc_cons[currcons].d->vc_saved_G1_ex)
+#define kanji_jis_mode (vc_cons[currcons].d->vc_kanji_jis_mode)
+#define s_kanji_jis_mode (vc_cons[currcons].d->vc_s_kanji_jis_mode)
+#define pc98_addbuf	(vc_cons[currcons].d->vc_pc98_addbuf)
+#endif
 
 #define vcmode		(vt_cons[currcons]->vc_mode)
 
diff -urN linux/drivers/char/console_pc9800.h linux98/drivers/char/console_pc9800.h
--- linux/drivers/char/console_pc9800.h	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/char/console_pc9800.h	Fri Aug 17 21:50:16 2001
@@ -0,0 +1,27 @@
+#ifndef __CONSOLE_PC9800_H
+#define __CONSOLE_PC9800_H
+
+#define PC9800_VRAM_ATTR_OFFSET 0x2000
+static inline unsigned long __pc9800_attr_offset(unsigned long Addr, unsigned long vss)
+{
+	if(Addr >= (unsigned long)__va(0xa0000)
+	   && Addr < (unsigned long)__va(0xa2000)) {
+		Addr += PC9800_VRAM_ATTR_OFFSET;
+	}else{
+		Addr += vss;
+	}
+	return Addr;
+}
+#define pc9800_attr_offset(x) \
+	((typeof(x))__pc9800_attr_offset((unsigned long)(x),(vc_cons[currcons].d->vc_screenbuf_size)))
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
diff -urN linux/drivers/char/consolemap.c linux98/drivers/char/consolemap.c
--- linux/drivers/char/consolemap.c	Sat Feb 10 04:30:22 2001
+++ linux98/drivers/char/consolemap.c	Fri Aug 17 21:50:16 2001
@@ -21,8 +21,13 @@
 #include <linux/consolemap.h>
 #include <linux/console_struct.h>
 #include <linux/vt_kern.h>
+#include <linux/config.h>
 
-static unsigned short translations[][256] = {
+#ifndef CONFIG_PC9800
+/* translations[][] is also used by console.c in NEC PC-9800 */
+static
+#endif
+unsigned short translations[][256] = {
   /* 8-bit Latin-1 mapped to Unicode -- trivial mapping */
   {
     0x0000, 0x0001, 0x0002, 0x0003, 0x0004, 0x0005, 0x0006, 0x0007,
@@ -162,7 +167,61 @@
     0xf0e8, 0xf0e9, 0xf0ea, 0xf0eb, 0xf0ec, 0xf0ed, 0xf0ee, 0xf0ef,
     0xf0f0, 0xf0f1, 0xf0f2, 0xf0f3, 0xf0f4, 0xf0f5, 0xf0f6, 0xf0f7,
     0xf0f8, 0xf0f9, 0xf0fa, 0xf0fb, 0xf0fc, 0xf0fd, 0xf0fe, 0xf0ff
-  }
+  },
+#ifdef CONFIG_PC9800
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
+#endif /* CONFIG_PC9800 */
 };
 
 /* The standard kernel character-to-font mappings are not invertible
@@ -176,7 +235,11 @@
 	u16 		**uni_pgdir[32];
 	unsigned long	refcount;
 	unsigned long	sum;
+#ifdef CONFIG_PC9800
+	unsigned char	*inverse_translations[5];
+#else
 	unsigned char	*inverse_translations[4];
+#endif
 	int		readonly;
 };
 
diff -urN linux/drivers/char/pc9800.uni linux98/drivers/char/pc9800.uni
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
diff -urN linux/drivers/char/vc_screen.c linux98/drivers/char/vc_screen.c
--- linux/drivers/char/vc_screen.c	Mon Apr 15 04:18:48 2002
+++ linux98/drivers/char/vc_screen.c	Wed Apr 17 10:37:20 2002
@@ -41,6 +41,10 @@
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 
+#ifdef CONFIG_PC9800
+#include "console_pc9800.h"
+#endif
+
 #undef attr
 #undef org
 #undef addr
@@ -137,6 +141,9 @@
 		goto unlock_out;
 	read = 0;
 	ret = 0;
+#ifdef CONFIG_PC9800
+	/* need modification for kanji */
+#endif
 	while (count) {
 		char *con_buf0, *con_buf_start;
 		long this_round, size;
@@ -229,7 +236,15 @@
 				this_round = (this_round + 1) >> 1;
 
 				while (this_round) {
+#ifndef CONFIG_PC9800
 					*tmp_buf++ = vcs_scr_readw(currcons, org++);
+#else
+					/* need modification for kanji */
+					*tmp_buf++ = (vcs_scr_readw(currcons, org) & 0xff)
+						| ((vcs_scr_readw(currcons, pc9800_attr_offset(org)) & 0xff) << 8);
+					org++;
+#endif
+
 					this_round --;
 					if (++col == maxcol) {
 						org = screen_pos(currcons, p, viewed);
@@ -237,6 +252,9 @@
 						p += maxcol;
 					}
 				}
+#ifdef CONFIG_PC9800
+/* need modification for kanji */
+#endif
 			}
 		}
 
@@ -395,6 +413,9 @@
 
 					this_round--;
 					c = *con_buf0++;
+#ifdef CONFIG_PC9800
+					vcs_scr_writew(currcons, c, pc9800_attr_offset(org));
+#else /* !CONFIG_PC9800 */
 #ifdef __BIG_ENDIAN
 					vcs_scr_writew(currcons, c |
 					     (vcs_scr_readw(currcons, org) & 0xff00), org);
@@ -402,6 +423,7 @@
 					vcs_scr_writew(currcons, (c << 8) |
 					     (vcs_scr_readw(currcons, org) & 0xff), org);
 #endif
+#endif /* CONFIG_PC9800 */
 					org++;
 					p++;
 					if (++col == maxcol) {
@@ -416,7 +438,14 @@
 				unsigned short w;
 
 				w = get_unaligned(((const unsigned short *)con_buf0));
+#ifndef CONFIG_PC9800
 				vcs_scr_writew(currcons, w, org++);
+#else
+				vcs_scr_writew(currcons, w & 0xff, org);
+				vcs_scr_writew(currcons, w >> 8,
+					       pc9800_attr_offset (org));
+				org++;
+#endif
 				con_buf0 += 2;
 				this_round -= 2;
 				if (++col == maxcol) {
@@ -429,11 +458,15 @@
 				unsigned char c;
 
 				c = *con_buf0++;
+#ifdef CONFIG_PC9800
+				vcs_scr_writew(currcons, c, org);
+#else
 #ifdef __BIG_ENDIAN
 				vcs_scr_writew(currcons, (vcs_scr_readw(currcons, org) & 0xff) | (c << 8), org);
 #else
 				vcs_scr_writew(currcons, (vcs_scr_readw(currcons, org) & 0xff00) | c, org);
 #endif
+#endif
 			}
 		}
 		count -= orig_count;
diff -urN linux/drivers/char/vt.c linux98/drivers/char/vt.c
--- linux/drivers/char/vt.c	Tue Oct  8 03:24:50 2002
+++ linux98/drivers/char/vt.c	Fri Oct 11 11:28:26 2002
@@ -108,6 +108,10 @@
 
 #include "console_macros.h"
 
+#ifdef CONFIG_PC9800
+#include "console_pc9800.h"
+extern unsigned short translations[][256];
+#endif
 
 const struct consw *conswitchp;
 
@@ -143,6 +147,10 @@
 static void blank_screen(unsigned long dummy);
 static void gotoxy(int currcons, int new_x, int new_y);
 static void save_cur(int currcons);
+#ifdef CONFIG_PC9800
+static void save_cur_kanji(int currcons);
+static void restore_cur_kanji(int currcons);
+#endif
 static void reset_terminal(int currcons, int do_clear);
 static void con_flush_chars(struct tty_struct *tty);
 static void set_vesa_blanking(unsigned long arg);
@@ -163,6 +171,10 @@
 
 static DECLARE_WORK(console_work, console_callback, NULL);
 
+#if defined(CONFIG_PC9800) && defined(CONFIG_FB)
+extern int	fbcon_softback_size;
+#endif
+
 /*
  * fg_console is the current virtual console,
  * last_console is the last used one,
@@ -256,6 +268,10 @@
 	s = (unsigned short *) (origin+video_size_row*(t+nr));
 	scr_memcpyw(d, s, (b-t-nr) * video_size_row);
 	scr_memsetw(d + (b-t-nr) * video_num_columns, video_erase_char, video_size_row*nr);
+#ifdef CONFIG_PC9800
+	scr_memcpyw(pc9800_attr_offset(d), pc9800_attr_offset(s), (b-t-nr) * video_size_row);
+	scr_memsetw(pc9800_attr_offset(d + (b - t - nr) * video_num_columns), video_erase_attr, video_size_row * nr);
+#endif
 }
 
 static void
@@ -274,6 +290,11 @@
 	step = video_num_columns * nr;
 	scr_memmovew(s + step, s, (b-t-nr)*video_size_row);
 	scr_memsetw(s, video_erase_char, 2*step);
+#ifdef CONFIG_PC9800
+	scr_memmovew(pc9800_attr_offset(s + step), pc9800_attr_offset(s),
+			(b - t - nr) * video_size_row);
+	scr_memsetw(pc9800_attr_offset(s), video_erase_attr, 2 * step);
+#endif
 }
 
 static void do_update_region(int currcons, unsigned long start, int count)
@@ -293,16 +314,56 @@
 		xx = nxx; yy = nyy;
 	}
 	for(;;) {
-		u16 attrib = scr_readw(p) & 0xff00;
+		u16 attrib;
 		int startx = xx;
 		u16 *q = p;
+#ifndef CONFIG_PC9800
+		attrib = scr_readw(p) & 0xff00;
+#else
+# ifdef CONFIG_FB
+		unsigned long	egc_attr_offset;
+		if (p >= vc_cons[currcons].d->vc_screenbuf
+			&& (unsigned long)p <
+			(unsigned long)(vc_cons[currcons].d->vc_screenbuf)
+				+ vc_cons[currcons].d->vc_screenbuf_size)
+			egc_attr_offset
+				= vc_cons[currcons].d->vc_screenbuf_size;
+		else
+			egc_attr_offset = fbcon_softback_size;
+
+		attrib = scr_readw((u16 *)((unsigned long)p
+				+ egc_attr_offset));
+# else
+		attrib = scr_readw(pc9800_attr_offset(p));
+# endif
+#endif
 		while (xx < video_num_columns && count) {
-			if (attrib != (scr_readw(p) & 0xff00)) {
+			if (attrib !=
+#ifndef CONFIG_PC9800
+				(scr_readw(p) & 0xff00)
+#else
+# ifdef CONFIG_FB
+				(scr_readw((u16 *)((unsigned long)p
+						+ egc_attr_offset)))
+# else
+				(scr_readw(pc9800_attr_offset(p)))
+# endif
+#endif
+				) {
 				if (p > q)
 					sw->con_putcs(vc_cons[currcons].d, q, p-q, yy, startx);
 				startx = xx;
 				q = p;
+#ifndef CONFIG_PC9800
 				attrib = scr_readw(p) & 0xff00;
+#else
+# ifdef CONFIG_FB
+				attrib = scr_readw((u16 *)((unsigned long)p
+							+ egc_attr_offset));
+# else
+				attrib = scr_readw(pc9800_attr_offset(p));
+# endif
+#endif
 			}
 			p++;
 			xx++;
@@ -378,7 +439,22 @@
 static void update_attr(int currcons)
 {
 	attr = build_attr(currcons, color, intensity, blink, underline, reverse ^ decscnm);
+#ifndef CONFIG_PC9800
 	video_erase_char = (build_attr(currcons, color, 1, blink, 0, decscnm) << 8) | ' ';
+#else /* CONFIG_PC9800 */
+#ifdef CONFIG_FB
+	attr |= (pc98_addbuf << 8);
+#endif
+	video_erase_char = 0x0000 | ' '; /* ~ST on;BL,RV,UL,VL off;RGB on */
+	video_erase_attr = build_attr(currcons, color, 1, blink, 0, decscnm);
+#ifdef CONFIG_FB
+	video_erase_attr |= (pc98_addbuf << 8);
+#endif
+	if (decscnm) {
+		video_erase_char |= 0x0000; /* reverse */
+		video_erase_attr |= 0x0004; /* reverse */
+	}
+#endif /* !CONFIG_PC9800 */
 }
 
 /* Note: inverting the screen twice should revert to the original state */
@@ -425,30 +501,99 @@
 		do_update_region(currcons, (unsigned long) p, count);
 }
 
+#ifdef CONFIG_PC9800
+/* can called form keyboard.c */
+void do_change_kanji_mode(int currcons, unsigned long mode)
+{
+	switch (mode) {
+	case 0:
+		kanji_mode = EUC_CODE;
+		break;
+	case 1:
+		kanji_mode = JIS_CODE;
+		break;
+	case 2:
+		kanji_mode = SJIS_CODE;
+		break;
+	}
+	kanji_char1 = 0;
+}
+#endif /* CONFIG_PC9800 */
+
 /* used by selection: complement pointer position */
 void complement_pos(int currcons, int offset)
 {
 	static unsigned short *p;
 	static unsigned short old;
 	static unsigned short oldx, oldy;
+#if defined(CONFIG_PC9800) && defined(CONFIG_FB)
+	static unsigned	long egc_attr_offset;
+#endif
 
 	if (p) {
+#ifndef CONFIG_PC9800
 		scr_writew(old, p);
 		if (DO_UPDATE)
 			sw->con_putc(vc_cons[currcons].d, old, oldy, oldx);
+#else
+#ifdef CONFIG_FB
+		scr_writew(old, (u16 *)((unsigned long)p
+				+ egc_attr_offset));
+#else
+		scr_writew(old, pc9800_attr_offset(p));
+#endif
+		if (DO_UPDATE) {
+#ifdef CONFIG_FB
+			pc98_addbuf = old;
+#endif
+			sw->con_putc(vc_cons[currcons].d, scr_readw(p),
+				     oldy, oldx);
+		}
+#endif
 	}
 	if (offset == -1)
 		p = NULL;
 	else {
 		unsigned short new;
 		p = screenpos(currcons, offset, 1);
+#ifndef CONFIG_PC9800
 		old = scr_readw(p);
 		new = old ^ complement_mask;
 		scr_writew(new, p);
+#else
+# ifdef CONFIG_FB
+		if (p >= vc_cons[currcons].d->vc_screenbuf
+			&& (unsigned long)p <
+			(unsigned long)(vc_cons[currcons].d->vc_screenbuf)
+				+ vc_cons[currcons].d->vc_screenbuf_size)
+			egc_attr_offset
+				= vc_cons[currcons].d->vc_screenbuf_size;
+		else
+			egc_attr_offset = fbcon_softback_size;
+
+		old = scr_readw((u16 *)((unsigned long)p
+				+ egc_attr_offset));
+		new = ((old << 4) & 0xf0) | ((old >> 4) & 0x0f);
+		scr_writew(new, (u16 *)((unsigned long)p
+				+ egc_attr_offset));
+# else
+		old = scr_readw(pc9800_attr_offset(p));
+		new = old ^ complement_mask;
+		scr_writew(new, pc9800_attr_offset(p));
+# endif
+#endif
 		if (DO_UPDATE) {
 			oldx = (offset >> 1) % video_num_columns;
 			oldy = (offset >> 1) / video_num_columns;
+#ifndef CONFIG_PC9800
 			sw->con_putc(vc_cons[currcons].d, new, oldy, oldx);
+#else
+# ifdef CONFIG_FB
+			pc98_addbuf = new;
+# endif
+			sw->con_putc(vc_cons[currcons].d, scr_readw(p),
+				     oldy, oldx);
+#endif
 		}
 	}
 }
@@ -458,18 +603,38 @@
 	unsigned short *p, *q = (unsigned short *) pos;
 
 	p = q + video_num_columns - nr - x;
-	while (--p >= q)
+	while (--p >= q) {
 		scr_writew(scr_readw(p), p + nr);
+#ifdef CONFIG_PC9800
+		scr_writew(scr_readw(pc9800_attr_offset(p)), pc9800_attr_offset(p) + nr);
+#endif
+	}
 	scr_memsetw(q, video_erase_char, nr*2);
+#ifdef CONFIG_PC9800
+	scr_memsetw(pc9800_attr_offset(q), video_erase_attr, nr * 2);
+#endif
 	need_wrap = 0;
 	if (DO_UPDATE) {
 		unsigned short oldattr = attr;
 		sw->con_bmove(vc_cons[currcons].d,y,x,y,x+nr,1,
 			      video_num_columns-x-nr);
+#ifndef CONFIG_PC9800
 		attr = video_erase_char >> 8;
+
 		while (nr--)
 			sw->con_putc(vc_cons[currcons].d,
 				     video_erase_char,y,x+nr);
+#else
+		attr = video_erase_char;
+
+		while (nr--) {
+# ifdef CONFIG_FB
+			pc98_addbuf = video_erase_attr;
+# endif
+			sw->con_putc(vc_cons[currcons].d, video_erase_char,
+				     y,x+nr);
+		}
+#endif
 		attr = oldattr;
 	}
 }
@@ -481,19 +646,38 @@
 
 	while (++i <= video_num_columns - nr) {
 		scr_writew(scr_readw(p+nr), p);
+#ifdef CONFIG_PC9800
+		scr_writew(scr_readw(pc9800_attr_offset(p+nr)), pc9800_attr_offset(p));
+#endif
 		p++;
 	}
 	scr_memsetw(p, video_erase_char, nr*2);
+#ifdef CONFIG_PC9800
+	scr_memsetw(pc9800_attr_offset(p), video_erase_attr, nr * 2);
+#endif
 	need_wrap = 0;
 	if (DO_UPDATE) {
 		unsigned short oldattr = attr;
 		sw->con_bmove(vc_cons[currcons].d, y, x+nr, y, x, 1,
 			      video_num_columns-x-nr);
+#ifndef CONFIG_PC9800
 		attr = video_erase_char >> 8;
+
 		while (nr--)
 			sw->con_putc(vc_cons[currcons].d,
 				     video_erase_char, y,
 				     video_num_columns-1-nr);
+#else
+		attr = video_erase_char;
+
+		while (nr--) {
+# ifdef CONFIG_FB
+			pc98_addbuf = video_erase_attr;
+# endif
+			sw->con_putc(vc_cons[currcons].d, video_erase_char, y,
+				     video_num_columns - 1 - nr);
+		}
+#endif
 		attr = oldattr;
 	}
 }
@@ -502,7 +686,12 @@
 
 static void add_softcursor(int currcons)
 {
+#ifndef CONFIG_PC9800
 	int i = scr_readw((u16 *) pos);
+#else
+	int i = (scr_readw((u16 *)pos) & 0xff)
+		| ((scr_readw(pc9800_attr_offset(pos)) & 0xff) << 8);
+#endif
 	u32 type = cursor_type;
 
 	if (! (type & 0x10)) return;
@@ -512,7 +701,12 @@
 	i ^= ((type) & 0xff00 );
 	if ((type & 0x20) && ((softcursor_original & 0x7000) == (i & 0x7000))) i ^= 0x7000;
 	if ((type & 0x40) && ((i & 0x700) == ((i & 0x7000) >> 4))) i ^= 0x0700;
+#ifndef CONFIG_PC9800
 	scr_writew(i, (u16 *) pos);
+#else
+	scr_writew(i & 0xff, (u16 *)pos);
+	scr_writew(i >> 8, pc9800_attr_offset(pos));
+#endif
 	if (DO_UPDATE)
 		sw->con_putc(vc_cons[currcons].d, i, y, x);
 }
@@ -522,7 +716,12 @@
 	if (currcons == sel_cons)
 		clear_selection();
 	if (softcursor_original != -1) {
+#ifndef CONFIG_PC9800
 		scr_writew(softcursor_original,(u16 *) pos);
+#else
+		scr_writew(softcursor_original & 0xff, (u16 *)pos);
+		scr_writew(softcursor_original >> 8, pc9800_attr_offset(pos));
+#endif
 		if (DO_UPDATE)
 			sw->con_putc(vc_cons[currcons].d, softcursor_original, y, x);
 		softcursor_original = -1;
@@ -602,7 +801,14 @@
 		int update;
 		set_origin(currcons);
 		update = sw->con_switch(vc_cons[currcons].d);
+#ifndef CONFIG_PC9800
 		set_palette(currcons);
+#else
+#ifdef CONFIG_FB
+		if (vc_cons[currcons].d->vc_top == 0)
+			set_palette(currcons);
+#endif
+#endif
 		if (update && vcmode != KD_GRAPHICS)
 			do_update_region(currcons, origin, screenbuf_size/2);
 	}
@@ -639,7 +845,11 @@
     can_do_color = 0;
     sw->con_init(vc_cons[currcons].d, init);
     if (!complement_mask)
+#ifndef CONFIG_PC9800
         complement_mask = can_do_color ? 0x7700 : 0x0800;
+#else
+        complement_mask = 0x0004;
+#endif
     s_complement_mask = complement_mask;
     video_size_row = video_num_columns<<1;
     screenbuf_size = video_num_lines*video_size_row;
@@ -671,7 +881,11 @@
 	    visual_init(currcons, 1);
 	    if (!*vc_cons[currcons].d->vc_uni_pagedir_loc)
 		con_set_default_unimap(currcons);
+#ifndef CONFIG_PC9800
 	    q = (long)kmalloc(screenbuf_size, GFP_KERNEL);
+#else /* CONFIG_PC9800 */
+	    q = (long)kmalloc(screenbuf_size * 2, GFP_KERNEL);
+#endif /* CONFIG_PC9800 */
 	    if (!q) {
 		kfree((char *) p);
 		vc_cons[currcons].d = NULL;
@@ -713,7 +927,11 @@
 		    (cc == video_num_columns && ll == video_num_lines))
 			newscreens[currcons] = NULL;
 		else {
+#ifndef CONFIG_PC9800
 			unsigned short *p = (unsigned short *) kmalloc(ss, GFP_USER);
+#else
+			unsigned short *p = (unsigned short *)kmalloc(ss * 2, GFP_USER);
+#endif
 			if (!p) {
 				for (i = first; i < currcons; i++)
 					if (newscreens[i])
@@ -727,12 +945,27 @@
 	if (!todo)
 		return 0;
 
+#ifdef PC9800_DEBUG
+	currcons = first;
+	printk(KERN_DEBUG "vc_resize: %ux%u -> %ux%u\n",
+		video_num_columns, video_num_lines, cc, ll);
+#endif
+
 	for (currcons = first; currcons <= last; currcons++) {
 		unsigned int occ, oll, oss, osr;
 		unsigned long ol, nl, nlend, rlth, rrem;
+#ifdef CONFIG_PC9800
+		unsigned long oaoff;
+#endif
 		if (!newscreens[currcons] || !vc_cons_allocated(currcons))
 			continue;
 
+#ifdef PC9800_DEBUG
+		printk(KERN_DEBUG "vc_resize: #%d: %p+%u -> %p+%u\n",
+			currcons + 1, screenbuf, screenbuf_size,
+			newscreens[currcons], ss);
+#endif
+
 		oll = video_num_lines;
 		occ = video_num_columns;
 		osr = video_size_row;
@@ -748,20 +981,77 @@
 		ol = origin;
 		nl = (long) newscreens[currcons];
 		nlend = nl + ss;
+#ifndef CONFIG_PC9800
 		if (ll < oll)
 			ol += (oll - ll) * osr;
+#else
+		if (y >= ll) {
+			ol += (y - ll + 1) * osr;
+			y = ll - 1;
+		}
+		oaoff = PC9800_VRAM_ATTR_OFFSET;
+		if (!IS_FG)
+			oaoff = oss;
+#endif
 
 		update_attr(currcons);
 
 		while (ol < scr_end) {
+#ifdef PC9800_DEBUG
+			int i, j;
+			printk(KERN_DEBUG
+				__FUNCTION__ ": scr_memcpyw(%p, %p, %u)"
+#ifdef CONFIG_PC9800
+				"; scr_memcpyw(%p, %p, %u)"
+#endif
+				"\n",
+				(void *) nl, (void *) ol, rlth
+#ifdef CONFIG_PC9800
+				, (void *)(nl + ss), (void *)(ol + oaoff), rlth
+#endif				
+			    );
+			for (j = cc - 1; j >= 0 && ((u16 *) ol)[j] == ' '; j--)
+				;
+			if (j >= 0) {
+				printk(KERN_DEBUG __FUNCTION__	": %p \"",
+					(void *) ol);
+				for (i = 0; i <= j; i++) {
+					u16 ch = ((u16 *) ol)[i];
+					printk("%c",
+						(' ' <= ch && ch <= '~')
+						? ch : '.');
+				}
+				printk("\"\n");
+			}
+#endif
+
 			scr_memcpyw((unsigned short *) nl, (unsigned short *) ol, rlth);
-			if (rrem)
+#ifdef CONFIG_PC9800
+			scr_memcpyw((unsigned short *)(nl + ss), (unsigned short *)(ol + oaoff), rlth);
+#endif
+			if (rrem) {
 				scr_memsetw((void *)(nl + rlth), video_erase_char, rrem);
+#ifdef CONFIG_PC9800
+				scr_memsetw((void *)(nl + ss + rlth), video_erase_attr, rrem);
+#endif
+			}
 			ol += osr;
 			nl += sr;
+#ifdef CONFIG_PC9800
+			if (nl >= nlend)
+				break;
+#endif
 		}
-		if (nlend > nl)
+#ifdef PC9800_DEBUG
+		printk(KERN_DEBUG __FUNCTION__ ":%u: nl=%#x, nlend=%#x\n",
+			__LINE__, nl, nlend);
+#endif
+		if (nlend > nl) {
 			scr_memsetw((void *) nl, video_erase_char, nlend - nl);
+#ifdef CONFIG_PC9800
+			scr_memsetw((void *)(nl + ss), video_erase_attr, nlend - nl);
+#endif
+		}
 		if (kmalloced)
 			kfree(screenbuf);
 		screenbuf = newscreens[currcons];
@@ -984,6 +1274,9 @@
 			return;
 	}
 	scr_memsetw(start, video_erase_char, 2*count);
+#ifdef CONFIG_PC9800
+	scr_memsetw(pc9800_attr_offset(start), video_erase_attr, 2 * count);
+#endif
 	need_wrap = 0;
 }
 
@@ -1018,6 +1311,9 @@
 			return;
 	}
 	scr_memsetw(start, video_erase_char, 2 * count);
+#ifdef CONFIG_PC9800
+	scr_memsetw(pc9800_attr_offset(start), video_erase_attr, 2 * count);
+#endif
 	need_wrap = 0;
 }
 
@@ -1030,6 +1326,10 @@
 	count = (vpar > video_num_columns-x) ? (video_num_columns-x) : vpar;
 
 	scr_memsetw((unsigned short *) pos, video_erase_char, 2 * count);
+#ifdef CONFiG_PC9800
+	scr_memsetw((unsigned short *)pc9800_attr_offset(pos), video_erase_attr, 2 * count);
+#endif
+
 	if (DO_UPDATE)
 		sw->con_clear(vc_cons[currcons].d, y, x, 1, count);
 	need_wrap = 0;
@@ -1077,6 +1377,9 @@
 				translate = set_translate(charset == 0
 						? G0_charset
 						: G1_charset,currcons);
+#ifdef CONFIG_PC9800
+				translate_ex = (charset == 0 ? G0_charset_ex : G1_charset_ex);
+#endif
 				disp_ctrl = 0;
 				toggle_meta = 0;
 				break;
@@ -1085,6 +1388,9 @@
 				  * chars < 32 be displayed as ROM chars.
 				  */
 				translate = set_translate(IBMPC_MAP,currcons);
+#ifdef CONFIG_PC9800
+				translate_ex = 0;
+#endif
 				disp_ctrl = 1;
 				toggle_meta = 0;
 				break;
@@ -1093,6 +1399,9 @@
 				  * high bit before displaying as ROM char.
 				  */
 				translate = set_translate(IBMPC_MAP,currcons);
+#ifdef CONFIG_PC9800
+				translate_ex = 0;
+#endif
 				disp_ctrl = 1;
 				toggle_meta = 1;
 				break;
@@ -1253,6 +1562,10 @@
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
@@ -1302,6 +1615,22 @@
 		case 14: /* set vesa powerdown interval */
 			vesa_off_interval = ((par[1] < 60) ? par[1] : 60) * 60 * HZ;
 			break;
+#ifdef CONFIG_PC9800
+	case 98:
+		if (par[1] < 10) /* change kanji mode */
+			do_change_kanji_mode(currcons, par[1]); /* 0208 */
+		else if (par[1] == 10) { /* save restore kanji mode */
+			switch (par[2]) {
+			case 1:
+				save_cur_kanji(currcons);
+				break;
+			case 2:
+				restore_cur_kanji(currcons);
+				break;
+			}
+		}
+		break;
+#endif /* CONFIG_PC9800 */
 	}
 }
 
@@ -1379,8 +1708,26 @@
 	need_wrap = 0;
 }
 
+#ifdef CONFIG_PC9800
+static void save_cur_kanji(int currcons)
+{
+        s_kanji_mode = kanji_mode;
+        s_kanji_jis_mode = kanji_jis_mode;
+}
+
+static void restore_cur_kanji(int currcons)
+{
+        kanji_mode = s_kanji_mode;
+        kanji_jis_mode = s_kanji_jis_mode;
+        kanji_char1 = 0;
+}
+#endif
+
 enum { ESnormal, ESesc, ESsquare, ESgetpars, ESgotpars, ESfunckey,
 	EShash, ESsetG0, ESsetG1, ESpercent, ESignore, ESnonstd,
+#ifdef CONFIG_PC9800
+	ESsetJIS, ESsetJIS2,
+#endif
 	ESpalette };
 
 /* console_sem is held (except via vc_init()) */
@@ -1390,9 +1737,18 @@
 	bottom		= video_num_lines;
 	vc_state	= ESnormal;
 	ques		= 0;
+#ifndef CONFIG_PC9800
 	translate	= set_translate(LAT1_MAP,currcons);
 	G0_charset	= LAT1_MAP;
 	G1_charset	= GRAF_MAP;
+#else
+	translate	= set_translate(JP_MAP, currcons);
+	translate_ex    = 0;
+	G0_charset      = JP_MAP;
+	G0_charset_ex   = 0;
+	G1_charset      = GRAF_MAP;
+	G1_charset_ex   = 0;
+#endif
 	charset		= 0;
 	need_wrap	= 0;
 	report_mouse	= 0;
@@ -1434,6 +1790,12 @@
 	bell_pitch = DEFAULT_BELL_PITCH;
 	bell_duration = DEFAULT_BELL_DURATION;
 
+#ifdef CONFIG_PC9800
+	kanji_mode = EUC_CODE;
+	kanji_char1 = 0;
+	kanji_jis_mode = JIS_CODE_ASCII;
+#endif
+
 	gotoxy(currcons,0,0);
 	save_cur(currcons);
 	if (do_clear)
@@ -1476,11 +1838,17 @@
 	case 14:
 		charset = 1;
 		translate = set_translate(G1_charset,currcons);
+#ifdef CONFIG_PC9800
+		translate_ex = G1_charset_ex;
+#endif
 		disp_ctrl = 1;
 		return;
 	case 15:
 		charset = 0;
 		translate = set_translate(G0_charset,currcons);
+#ifdef CONFIG_PC9800
+		translate_ex = G0_charset_ex;
+#endif
 		disp_ctrl = 0;
 		return;
 	case 24: case 26:
@@ -1537,6 +1905,11 @@
 		case ')':
 			vc_state = ESsetG1;
 			return;
+#ifdef CONFIG_PC9800
+		case '$':
+			vc_state = ESsetJIS;
+			return;
+#endif
 		case '#':
 			vc_state = EShash;
 			return;
@@ -1770,7 +2143,10 @@
 		if (c == '8') {
 			/* DEC screen alignment test. kludge :-) */
 			video_erase_char =
-				(video_erase_char & 0xff00) | 'E';
+#ifndef CONFIG_PC9800
+				(video_erase_char & 0xff00) |
+#endif /* !CONFIG_PC9800 */
+				'E';
 			csi_J(currcons, 2);
 			video_erase_char =
 				(video_erase_char & 0xff00) | ' ';
@@ -1778,6 +2154,16 @@
 		}
 		return;
 	case ESsetG0:
+#ifdef CONFIG_PC9800
+		if (c == 'J') {
+			G0_charset = JP_MAP;
+			G0_charset_ex = 0;
+		} else if (c == 'I'){
+			G0_charset = JP_MAP;
+			G0_charset_ex = 1;
+		} else {
+			G0_charset_ex = 0;
+#endif /* CONFIG_PC9800 */
 		if (c == '0')
 			G0_charset = GRAF_MAP;
 		else if (c == 'B')
@@ -1786,11 +2172,32 @@
 			G0_charset = IBMPC_MAP;
 		else if (c == 'K')
 			G0_charset = USER_MAP;
-		if (charset == 0)
+#ifdef CONFIG_PC9800
+		}
+#endif
+		if (charset == 0) {
 			translate = set_translate(G0_charset,currcons);
+#ifdef CONFIG_PC9800
+			translate_ex = G0_charset_ex;
+#endif
+		}
+#ifdef CONFIG_PC9800
+		kanji_jis_mode = JIS_CODE_ASCII;
+		kanji_char1 = 0;
+#endif
 		vc_state = ESnormal;
 		return;
 	case ESsetG1:
+#ifdef CONFIG_PC9800
+		if (c == 'J') {
+			G1_charset = JP_MAP;
+			G1_charset_ex = 0;
+		} else if (c == 'I'){
+			G1_charset = JP_MAP;
+			G1_charset_ex = 1;
+		} else {
+			G1_charset_ex = 0;
+#endif /* CONFIG_PC9800 */
 		if (c == '0')
 			G1_charset = GRAF_MAP;
 		else if (c == 'B')
@@ -1799,10 +2206,45 @@
 			G1_charset = IBMPC_MAP;
 		else if (c == 'K')
 			G1_charset = USER_MAP;
-		if (charset == 1)
+#ifdef CONFIG_PC9800
+		}
+#endif
+		if (charset == 1) {
 			translate = set_translate(G1_charset,currcons);
+#ifdef CONFIG_PC9800
+			translate_ex = G1_charset_ex;
+#endif
+		}
+#ifdef CONFIG_PC9800
+		kanji_jis_mode = JIS_CODE_ASCII;
+		kanji_char1 = 0;
+#endif
 		vc_state = ESnormal;
 		return;
+#ifdef CONFIG_PC9800
+	case ESsetJIS:
+		if (c == '@')
+			kanji_jis_mode = JIS_CODE_78;
+		else if (c == 'B')
+			kanji_jis_mode = JIS_CODE_83;
+		else if (c == '('){
+			vc_state = ESsetJIS2;
+			return;
+		} else {
+		vc_state = ESnormal;
+		return;
+		}
+		vc_state = ESnormal;
+		kanji_char1 = 0;
+		return;
+	case ESsetJIS2:
+		if (c == 'D'){
+			kanji_jis_mode = JIS_CODE_90;
+			kanji_char1 = 0;
+		}
+		vc_state = ESnormal;
+		return;
+#endif /* CONIFG_PC9800 */
 	default:
 		vc_state = ESnormal;
 	}
@@ -1834,7 +2276,7 @@
 	}
 #endif
 
-	int c, tc, ok, n = 0, draw_x = -1;
+	int c, tc = 0, ok, n = 0, draw_x = -1;
 	unsigned int currcons;
 	unsigned long draw_from = 0, draw_to = 0;
 	struct vt_struct *vt = (struct vt_struct *)tty->driver_data;
@@ -1891,11 +2333,112 @@
 		hide_cursor(currcons);
 
 	while (!tty->stopped && count) {
+#ifdef CONFIG_PC9800
+		int realkanji = 0;
+		int kanjioverrun = 0;
+#endif
 		c = *buf;
 		buf++;
 		n++;
 		count--;
 
+#ifdef CONFIG_PC9800
+		if (vc_state == ESnormal && !disp_ctrl) {
+			switch (kanji_jis_mode) {
+			case JIS_CODE_78:
+			case JIS_CODE_83:
+			case JIS_CODE_90:
+				if (utf)
+					break;
+				if (c >= 127 || c <= 0x20) {
+					kanji_char1 = 0;
+					break;
+				}
+				if (kanji_char1) {
+					tc = (((unsigned int)kanji_char1) << 8) |
+                        (((unsigned int)c) & 0x007f);
+					kanji_char1 = 0;
+					realkanji = 1;
+				} else {
+					kanji_char1 = ((unsigned int)c) & 0x007f;
+					continue;
+				} 
+				break;
+			case JIS_CODE_ASCII:
+			default:
+				switch (kanji_mode) {
+				case SJIS_CODE:
+					if (kanji_char1) {
+                        if ((0x40 <= c && c <= 0x7E) ||
+                            (0x80 <= c && c <= 0xFC)) {
+							realkanji = 1;
+							/* SJIS to JIS */
+							kanji_char1 <<= 1; /* 81H-9FH --> 22H-3EH */
+							/* EOH-EFH --> C0H-DEH */
+							c -= 0x1f;         /* 40H-7EH --> 21H-5FH */
+							/* 80H-9EH --> 61H-7FH */
+							/* 9FH-FCH --> 80H-DDH */
+							if (!(c & 0x80)) {
+								if (c < 0x61)
+									c++;
+								c += 0xde;
+							}
+							c &= 0xff;
+							c += 0xa1;
+							kanji_char1 += 0x1f;
+							tc = (kanji_char1 << 8) + c;
+							tc &= 0x7f7f;
+							kanji_char1 = 0;
+                        }
+					} else {
+                        if ((0x81 <= c && c <= 0x9f) ||
+                            (0xE0 <= c && c <= 0xEF)) {
+							realkanji = 1;
+							kanji_char1 = c;
+							continue;
+#if 1 /* hankaku kana patch */
+                        } else if (0xA1 <= c && c <= 0xDF) {
+							tc = (unsigned int)translations[JP_MAP][c];
+							goto hankana_skip;
+#endif
+                        }
+					}
+					break;
+				case EUC_CODE:
+					if (utf)
+                        break;
+					if (c <= 0x7f) {
+                        kanji_char1 = 0;
+                        break;
+					}
+					if (kanji_char1) {
+                        if (kanji_char1 == 0x8e) {  /* SS2 */
+							/* realkanji ha tatenai */
+							tc = (unsigned int)translations[JP_MAP][c];
+							kanji_char1 = 0;
+#if 1 /* hankaku kana patch */
+							goto hankana_skip;
+#endif
+                        } else {
+							tc = (((unsigned int)kanji_char1) << 8) |
+								(((unsigned int)c) & 0x007f);
+							kanji_char1 = 0;
+							realkanji = 1;
+                        }
+					} else {
+                        kanji_char1 = (unsigned int)c;
+                        continue;
+					}
+					break;
+				case JIS_CODE:
+					/* to be supported */
+					break;
+				} /* switch (kanji_mode) */
+			} /* switch (kanji_jis_mode) */
+		} /* if (vc_state == ESnormal) */
+
+		if (!realkanji) {
+#endif /* CONFIG_PC9800 */
 		if (utf) {
 		    /* Combine UTF-8 into Unicode */
 		    /* Incomplete characters silently ignored */
@@ -1931,8 +2474,18 @@
 		      utf_count = 0;
 		    }
 		} else {	/* no utf */
+#ifndef CONFIG_PC9800
 		  tc = translate[toggle_meta ? (c|0x80) : c];
+#else
+		  tc = translate[(toggle_meta || translate_ex) ? (c | 0x80) : c];
+#endif
 		}
+#ifdef CONFIG_PC9800
+		} /* if (!realkanji) */
+#if 1 /* hankaku kana patch */
+	hankana_skip:
+#endif
+#endif
 
                 /* If the original code was a control character we
                  * only allow a glyph to be displayed if the code is
@@ -1949,8 +2502,14 @@
                                          : CTRL_ACTION) >> c) & 1)))
                         && (c != 127 || disp_ctrl)
 			&& (c != 128+27);
+#ifdef CONFIG_PC9800
+                ok = realkanji || ok;
+#endif
 
 		if (vc_state == ESnormal && ok) {
+#ifdef CONFIG_PC9800
+			if (!realkanji) {
+#endif /* CONFIG_PC9800 */
 			/* Now try to find out how to display it */
 			tc = conv_uni_to_pc(vc_cons[currcons].d, tc);
 			if ( tc == -4 ) {
@@ -1969,23 +2528,55 @@
                         }
 			if (tc & ~charmask)
                                 continue; /* Conversion failed */
+#ifdef CONFIG_PC9800
+			} /* !realkanji */
+#endif /* CONFIG_PC9800 */
 
 			if (need_wrap || decim)
 				FLUSH
 			if (need_wrap) {
 				cr(currcons);
 				lf(currcons);
+#ifdef CONFIG_PC9800
+				if (kanjioverrun) {
+					x++;
+					pos += 2;
+					kanjioverrun = 0;
+				}
+#endif /* CONFIG_PC9800 */
 			}
 			if (decim)
 				insert_char(currcons, 1);
+#ifndef CONFIG_PC9800
 			scr_writew(himask ?
 				     ((attr << 8) & ~himask) + ((tc & 0x100) ? himask : 0) + (tc & 0xff) :
 				     (attr << 8) + tc,
 				   (u16 *) pos);
+#else /* CONFIG_PC9800 */
+			if (realkanji) {
+				tc = ((tc >> 8) & 0xff) | ((tc << 8) & 0xff00); 
+				scr_writew((tc - 0x20) & 0xff7f, (u16 *)pos);
+				scr_writew(attr, (u16 *)pc9800_attr_offset(pos));
+				x ++;
+				pos += 2;
+				scr_writew((tc - 0x20) | 0x80, (u16 *)pos);
+				scr_writew(attr, (u16 *)pc9800_attr_offset(pos));
+			} else {
+				scr_writew(tc & 0x00ff, (u16 *)pos);
+				scr_writew(attr, (u16 *)pc9800_attr_offset(pos));
+			}
+#endif /* !CONFIG_PC9800 */
 			if (DO_UPDATE && draw_x < 0) {
 				draw_x = x;
 				draw_from = pos;
+#ifdef CONFIG_PC9800
+				if ( realkanji ) {
+					draw_x --;
+					draw_from -= 2;
+				}
+#endif
 			}
+#ifndef CONFIG_PC9800
 			if (x == video_num_columns - 1) {
 				need_wrap = decawm;
 				draw_to = pos+2;
@@ -1993,6 +2584,16 @@
 				x++;
 				draw_to = (pos+=2);
 			}
+#else /* CONFIG_PC9800 */
+			if (x >= video_num_columns - 1) {
+				need_wrap = decawm;
+				kanjioverrun = x - video_num_columns + 1;
+				draw_to = pos + 2;
+			} else {
+				x++;
+				draw_to = (pos += 2);
+			}
+#endif /* !CONFIG_PC9800 */
 			continue;
 		}
 		FLUSH
@@ -2139,7 +2740,12 @@
 			if (c == 10 || c == 13)
 				continue;
 		}
+#ifndef CONFIG_PC9800
 		scr_writew((attr << 8) + c, (unsigned short *) pos);
+#else
+		scr_writew( c, (unsigned short *)pos);
+		scr_writew(attr, (unsigned short *)pc9800_attr_offset(pos));
+#endif
 		cnt++;
 		if (myx == video_num_columns - 1) {
 			need_wrap = 1;
@@ -2404,7 +3010,9 @@
 
 static void vc_init(unsigned int currcons, unsigned int rows, unsigned int cols, int do_clear)
 {
+#if !defined CONFIG_PC9800 || defined CONFIG_FB
 	int j, k ;
+#endif
 
 	video_num_columns = cols;
 	video_num_lines = rows;
@@ -2414,16 +3022,32 @@
 	set_origin(currcons);
 	pos = origin;
 	reset_vc(currcons);
+#if !defined CONFIG_PC9800 || defined CONFIG_FB
 	for (j=k=0; j<16; j++) {
 		vc_cons[currcons].d->vc_palette[k++] = default_red[j] ;
 		vc_cons[currcons].d->vc_palette[k++] = default_grn[j] ;
 		vc_cons[currcons].d->vc_palette[k++] = default_blu[j] ;
 	}
+#endif /* !CONFIG_PC9800 || CONFIG_FB */
+#ifndef CONFIG_PC9800
 	def_color       = 0x07;   /* white */
 	ulcolor		= 0x0f;   /* bold white */
 	halfcolor       = 0x08;   /* grey */
+#else
+	def_color	= 0x07;		/* white */
+	def_attr	= 0xE1;
+	ul_attr		= 0x08;		/* underline */
+	half_attr	= 0x00;		/* ignore half color */
+	bold_attr	= 0xC1;		/* yellow */
+#endif
 	init_waitqueue_head(&vt_cons[currcons]->paste_wait);
 	reset_terminal(currcons, do_clear);
+
+#ifdef PC9800_DEBUG
+	printk(KERN_DEBUG __FUNCTION__ ": (#%u) %ux%u, %p+%u\n",
+		cons_num + 1, video_num_columns, video_num_lines,
+		screenbuf, screenbuf_size);
+#endif
 }
 
 /*
@@ -2462,7 +3086,12 @@
 		vt_cons[currcons] = (struct vt_struct *)
 				alloc_bootmem(sizeof(struct vt_struct));
 		visual_init(currcons, 1);
+#if defined CONFIG_PC9800 || defined CONFIG_FB
+		screenbuf
+			= (unsigned short *) alloc_bootmem(screenbuf_size * 2);
+#else
 		screenbuf = (unsigned short *) alloc_bootmem(screenbuf_size);
+#endif
 		kmalloced = 0;
 		vc_init(currcons, video_num_lines, video_num_columns, 
 			currcons || !sw->con_save_screen);
@@ -2536,10 +3165,17 @@
 {
 	unsigned short *p = (unsigned short *) origin;
 	int count = screenbuf_size/2;
+#ifndef CONFIG_PC9800
 	int mask = hi_font_mask | 0xff;
+#endif
 
 	for (; count > 0; count--, p++) {
+#ifdef CONFIG_PC9800
+		scr_writew(video_erase_attr, pc9800_attr_offset(p));
+#else
 		scr_writew((scr_readw(p)&mask) | (video_erase_char&~mask), p);
+#endif
+
 	}
 }
 
@@ -2553,11 +3189,21 @@
 {
 	int i, j = -1;
 	const char *desc;
+#if defined CONFIG_PC9800 && defined CONFIG_FB
+	int need_clear_attr = 0;
+#endif
 
 	desc = csw->con_startup();
 	if (!desc) return;
-	if (deflt)
+	if (deflt) {
+#if defined CONFIG_PC9800 && defined CONFIG_FB
+		need_clear_attr = ((conswitchp == &gdc_con
+				    && csw == &fb_con)
+				   || (conswitchp == &fb_con
+				       && csw == &gdc_con));
+#endif
 		conswitchp = csw;
+	}
 
 	for (i = first; i <= last; i++) {
 		int old_was_color;
@@ -2580,7 +3226,11 @@
 		 * the attributes in the screenbuf will be wrong.  The
 		 * following resets all attributes to something sane.
 		 */
-		if (old_was_color != vc_cons[i].d->vc_can_do_color)
+		if (old_was_color != vc_cons[i].d->vc_can_do_color
+#if defined CONFIG_PC9800 && defined CONFIG_FB
+		    || need_clear_attr
+#endif
+		    )
 			clear_buffer_attributes(i);
 
 		if (IS_VISIBLE)
@@ -2754,7 +3404,9 @@
 	console_blanked = 0;
 	if (console_blank_hook)
 		console_blank_hook(0);
+#if !defined CONFIG_PC9800 || defined CONFIG_FB
 	set_palette(currcons);
+#endif
 	if (sw->con_blank(vc_cons[currcons].d, 0))
 		/* Low-level driver cannot restore -> do it ourselves */
 		update_screen(fg_console);
@@ -2956,11 +3608,15 @@
 u16 screen_glyph(int currcons, int offset)
 {
 	u16 w = scr_readw(screenpos(currcons, offset, 1));
+#ifndef CONFIG_PC9800
 	u16 c = w & 0xff;
 
 	if (w & hi_font_mask)
 		c |= 0x100;
 	return c;
+#else
+	return w;
+#endif /* CONFIG_PC9800 */
 }
 
 /* used by vcs - note the word offset */
@@ -2985,12 +3641,22 @@
 {
 	if ((unsigned long)org == pos && softcursor_original != -1)
 		return softcursor_original;
+#ifndef CONFIG_PC9800
 	return scr_readw(org);
+#else
+	return (scr_readw(org) & 0xff)
+		| ((scr_readw(pc9800_attr_offset(org)) & 0xff) << 8);
+#endif
 }
 
 void vcs_scr_writew(int currcons, u16 val, u16 *org)
 {
+#ifndef CONFIG_PC9800
 	scr_writew(val, org);
+#else
+	scr_writew(val & 0xff, org);
+	scr_writew(val >> 8, pc9800_attr_offset(org));
+#endif
 	if ((unsigned long)org == pos) {
 		softcursor_original = -1;
 		add_softcursor(currcons);
@@ -3019,8 +3685,10 @@
 EXPORT_SYMBOL(default_red);
 EXPORT_SYMBOL(default_grn);
 EXPORT_SYMBOL(default_blu);
+#ifndef CONFIG_PC9800
 EXPORT_SYMBOL(video_font_height);
 EXPORT_SYMBOL(video_scan_lines);
+#endif
 EXPORT_SYMBOL(vc_resize);
 EXPORT_SYMBOL(fg_console);
 EXPORT_SYMBOL(console_blank_hook);
diff -urN linux/drivers/char/vt_ioctl.c linux98/drivers/char/vt_ioctl.c
--- linux/drivers/char/vt_ioctl.c	Sat Oct 12 13:22:14 2002
+++ linux98/drivers/char/vt_ioctl.c	Sat Oct 12 14:18:52 2002
@@ -63,9 +63,11 @@
 asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 #endif
 
+#ifndef CONFIG_PC9800
 unsigned int video_font_height;
 unsigned int default_font_height;
 unsigned int video_scan_lines;
+#endif
 
 /*
  * these are the valid i/o ports we're allowed to change. they map all the
@@ -637,6 +639,17 @@
 		return 0;
 	}
 
+#ifdef CONFIG_PC9800
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
@@ -828,7 +841,9 @@
 		__get_user(clin, &vtconsize->v_clin);
 		__get_user(vcol, &vtconsize->v_vcol);
 		__get_user(ccol, &vtconsize->v_ccol);
+#ifndef CONFIG_PC9800
 		vlin = vlin ? vlin : video_scan_lines;
+#endif
 		if ( clin )
 		  {
 		    if ( ll )
@@ -853,10 +868,12 @@
 		if ( clin > 32 )
 		  return -EINVAL;
 		    
+#ifndef CONFIG_PC9800		    
 		if ( vlin )
 		  video_scan_lines = vlin;
 		if ( clin )
 		  video_font_height = clin;
+#endif
 		
 		return vc_resize_all(ll, cc);
   	}
@@ -1024,8 +1041,10 @@
 	vt_cons[new_console]->vt_mode.frsig = 0;
 	vt_cons[new_console]->vt_pid = -1;
 	vt_cons[new_console]->vt_newvt = -1;
+#ifndef CONFIG_PC9800
 	if (!in_interrupt())    /* Via keyboard.c:SAK() - akpm */
 		reset_palette(new_console) ;
+#endif
 }
 
 /*
diff -urN linux/include/linux/console.h linux98/include/linux/console.h
--- linux/include/linux/console.h	Sat Jul 21 04:52:18 2001
+++ linux98/include/linux/console.h	Fri Aug 17 22:13:42 2001
@@ -48,6 +48,7 @@
 	void	(*con_invert_region)(struct vc_data *, u16 *, int);
 	u16    *(*con_screen_pos)(struct vc_data *, int);
 	unsigned long (*con_getxy)(struct vc_data *, unsigned long, int *, int *);
+	int	(*con_setterm_command)(struct vc_data *);
 };
 
 extern const struct consw *conswitchp;
@@ -55,8 +56,10 @@
 extern const struct consw dummy_con;	/* dummy console buffer */
 extern const struct consw fb_con;	/* frame buffer based console */
 extern const struct consw vga_con;	/* VGA text console */
+extern const struct consw gdc_con;	/* PC-9800 GDC text console */
 extern const struct consw newport_con;	/* SGI Newport console  */
 extern const struct consw prom_con;	/* SPARC PROM console */
+extern const struct consw fb_con_pc98;	/* frame buffer based console for PC-9800 */
 
 void take_over_console(const struct consw *sw, int first, int last, int deflt);
 void give_up_console(const struct consw *sw);
diff -urN linux/include/linux/console_struct.h linux98/include/linux/console_struct.h
--- linux/include/linux/console_struct.h	Wed Jul 17 08:49:22 2002
+++ linux98/include/linux/console_struct.h	Fri Jul 19 11:37:00 2002
@@ -9,6 +9,8 @@
  * to achieve effects such as fast scrolling by changing the origin.
  */
 
+#include <linux/config.h>
+
 #define NPAR 16
 
 struct vc_data {
@@ -19,15 +21,28 @@
 	const struct consw *vc_sw;
 	unsigned short	*vc_screenbuf;		/* In-memory character/attribute buffer */
 	unsigned int	vc_screenbuf_size;
+#if  defined(CONFIG_PC9800) && defined(CONFIG_FB)
+	unsigned short	vc_attr;		/* Current attributes */
+#else
 	unsigned char	vc_attr;		/* Current attributes */
+#endif
 	unsigned char	vc_def_color;		/* Default colors */
 	unsigned char	vc_color;		/* Foreground & background */
 	unsigned char	vc_s_color;		/* Saved foreground & background */
 	unsigned char	vc_ulcolor;		/* Color for underline mode */
 	unsigned char	vc_halfcolor;		/* Color for half intensity mode */
+#ifdef CONFIG_GDC_CONSOLE
+	unsigned char	vc_def_attr;	/* Default attributes */
+	unsigned char	vc_ul_attr;	/* Attribute for underline mode */
+	unsigned char	vc_half_attr;	/* Attribute for half intensity mode */
+	unsigned char	vc_bold_attr;	/* Attribute for bold mode */
+#endif
 	unsigned short	vc_complement_mask;	/* [#] Xor mask for mouse pointer */
 	unsigned short	vc_hi_font_mask;	/* [#] Attribute set for upper 256 chars of font or 0 if not supported */
 	unsigned short	vc_video_erase_char;	/* Background erase character */
+#ifdef CONFIG_PC9800
+	unsigned short	vc_video_erase_attr;	/* Background erase attribute */
+#endif
 	unsigned short	vc_s_complement_mask;	/* Saved mouse pointer mask */
 	unsigned int	vc_x, vc_y;		/* Cursor position */
 	unsigned int	vc_top, vc_bottom;	/* Scrolling region */
@@ -82,6 +97,21 @@
 	struct vc_data **vc_display_fg;		/* [!] Ptr to var holding fg console for this display */
 	unsigned long	vc_uni_pagedir;
 	unsigned long	*vc_uni_pagedir_loc;  /* [!] Location of uni_pagedir variable for this console */
+#ifdef CONFIG_PC9800
+	unsigned char   vc_kanji_char1;
+	unsigned char   vc_kanji_mode;
+	unsigned char   vc_kanji_jis_mode;
+	unsigned char   vc_s_kanji_mode;
+	unsigned char   vc_s_kanji_jis_mode;
+	unsigned int    vc_translate_ex;
+	unsigned char   vc_G0_charset_ex;
+	unsigned char   vc_G1_charset_ex;
+	unsigned char   vc_saved_G0_ex;
+	unsigned char   vc_saved_G1_ex;
+# ifdef CONFIG_FB
+	unsigned short  vc_pc98_addbuf;
+# endif
+#endif /* CONFIG_PC9800 */
 	/* additional information is in vt_kern.h */
 };
 
@@ -105,6 +135,10 @@
 #define CUR_HWMASK	0x0f
 #define CUR_SWMASK	0xfff0
 
+#ifndef CONFIG_PC9800
 #define CUR_DEFAULT CUR_UNDERLINE
+#else
+#define CUR_DEFAULT CUR_BLOCK
+#endif
 
 #define CON_IS_VISIBLE(conp) (*conp->vc_display_fg == conp)
diff -urN linux/include/linux/consolemap.h linux98/include/linux/consolemap.h
--- linux/include/linux/consolemap.h	Wed Dec 30 07:28:37 1998
+++ linux98/include/linux/consolemap.h	Fri Aug 17 22:15:11 2001
@@ -3,10 +3,16 @@
  *
  * Interface between console.c, selection.c  and consolemap.c
  */
+
+#include <linux/config.h>
+
 #define LAT1_MAP 0
 #define GRAF_MAP 1
 #define IBMPC_MAP 2
 #define USER_MAP 3
+#ifdef CONFIG_PC9800
+#define JP_MAP 4
+#endif
 
 struct vc_data;
 
diff -urN linux/include/linux/tty.h linux98/include/linux/tty.h
--- linux/include/linux/tty.h	Thu Jul 25 06:03:28 2002
+++ linux98/include/linux/tty.h	Thu Jul 25 11:17:21 2002
@@ -5,6 +5,8 @@
  * 'tty.h' defines some structures used by tty_io.c and some defines.
  */
 
+#include <linux/config.h>
+
 /*
  * These constants are also useful for user-level apps (e.g., VC
  * resizing).
@@ -123,6 +125,12 @@
 
 #define VIDEO_TYPE_PMAC		0x60	/* PowerMacintosh frame buffer. */
 
+#ifdef CONFIG_PC9800
+#define VIDEO_TYPE_98NORMAL	0xa4	/* NEC PC-9800 normal */
+#define VIDEO_TYPE_9840		0xa5	/* NEC PC-9800 normal 40 lines */
+#define VIDEO_TYPE_98HIRESO	0xa6	/* NEC PC-9800 hireso */
+#endif
+
 /*
  * This character is the same as _POSIX_VDISABLE: it cannot be used as
  * a c_cc[] character, but indicates that a particular special character
diff -urN linux/include/linux/vt.h linux98/include/linux/vt.h
--- linux/include/linux/vt.h	Sun Mar 24 19:09:37 1996
+++ linux98/include/linux/vt.h	Fri Aug 17 22:14:46 2001
@@ -1,6 +1,8 @@
 #ifndef _LINUX_VT_H
 #define _LINUX_VT_H
 
+#include <linux/config.h>
+
 /* 0x56 is 'V', to avoid collision with termios and kd */
 
 #define VT_OPENQRY	0x5600	/* find available vt */
@@ -50,5 +52,8 @@
 #define VT_RESIZEX      0x560A  /* set kernel's idea of screensize + more */
 #define VT_LOCKSWITCH   0x560B  /* disallow vt switching */
 #define VT_UNLOCKSWITCH 0x560C  /* allow vt switching */
+#ifdef CONFIG_PC9800
+#define VT_GDC_RESIZE	0x5698
+#endif
 
 #endif /* _LINUX_VT_H */
diff -urN linux/include/linux/vt_buffer.h linux98/include/linux/vt_buffer.h
--- linux/include/linux/vt_buffer.h	Sat Jul 21 04:53:40 2001
+++ linux98/include/linux/vt_buffer.h	Fri Aug 17 22:15:17 2001
@@ -19,6 +19,12 @@
 #include <asm/vga.h>
 #endif
 
+#ifdef CONFIG_PC9800
+#ifdef CONFIG_GDC_CONSOLE
+#include <asm/gdc.h>
+#endif
+#endif
+
 #ifndef VT_BUF_HAVE_RW
 #define scr_writew(val, addr) (*(addr) = (val))
 #define scr_readw(addr) (*(addr))
