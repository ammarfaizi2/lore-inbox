Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264187AbTCXNA3>; Mon, 24 Mar 2003 08:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264188AbTCXNA3>; Mon, 24 Mar 2003 08:00:29 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:17536 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S264187AbTCXNAK>; Mon, 24 Mar 2003 08:00:10 -0500
Date: Mon, 24 Mar 2003 22:10:13 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       James Simmons <jsimmons@infradead.org>
Subject: [PATCH 2.5.65-ac4] Complete support for PC-9800 sub-arch (5/9) kanji console
Message-ID: <20030324131013.GE2508@yuzuki.cinet.co.jp>
References: <20030324130025.GA2465@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030324130025.GA2465@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patch to support NEC PC-9800 subarchitecture
against 2.5.65-ac4. (5/9)

Add japanese kanji character support to PC98 console.

Regards,
Osamu Tomita

diff -Nru linux/drivers/char/console_macros.h linux98/drivers/char/console_macros.h
--- linux/drivers/char/console_macros.h	2003-03-23 21:55:14.000000000 +0900
+++ linux98/drivers/char/console_macros.h	2003-03-24 00:13:03.000000000 +0900
@@ -69,6 +69,16 @@
 #define complement_mask (vc_cons[currcons].d->vc_complement_mask)
 #define s_complement_mask (vc_cons[currcons].d->vc_s_complement_mask)
 #define hi_font_mask	(vc_cons[currcons].d->vc_hi_font_mask)
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
 
 #define vcmode		(vt_cons[currcons]->vc_mode)
 
diff -Nru linux/drivers/char/vt.c linux98/drivers/char/vt.c
--- linux/drivers/char/vt.c	2003-03-23 21:55:14.000000000 +0900
+++ linux98/drivers/char/vt.c	2003-03-24 00:13:03.000000000 +0900
@@ -155,6 +155,10 @@
 static void blank_screen(unsigned long dummy);
 static void gotoxy(int currcons, int new_x, int new_y);
 static void save_cur(int currcons);
+#ifdef CONFIG_KANJI
+static void save_cur_kanji(int currcons);
+static void restore_cur_kanji(int currcons);
+#endif
 static void reset_terminal(int currcons, int do_clear);
 static void con_flush_chars(struct tty_struct *tty);
 static void set_vesa_blanking(unsigned long arg);
@@ -439,6 +443,25 @@
 		do_update_region(currcons, (unsigned long) p, count);
 }
 
+#ifdef CONFIG_KANJI
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
+#endif /* CONFIG_KANJI */
+
 /* used by selection: complement pointer position */
 void complement_pos(int currcons, int offset)
 {
@@ -1103,6 +1126,9 @@
 				translate = set_translate(charset == 0
 						? G0_charset
 						: G1_charset,currcons);
+#ifdef CONFIG_KANJI
+				translate_ex = (charset == 0 ? G0_charset_ex : G1_charset_ex);
+#endif
 				disp_ctrl = 0;
 				toggle_meta = 0;
 				break;
@@ -1111,6 +1137,9 @@
 				  * chars < 32 be displayed as ROM chars.
 				  */
 				translate = set_translate(IBMPC_MAP,currcons);
+#ifdef CONFIG_KANJI
+				translate_ex = 0;
+#endif
 				disp_ctrl = 1;
 				toggle_meta = 0;
 				break;
@@ -1119,6 +1148,9 @@
 				  * high bit before displaying as ROM char.
 				  */
 				translate = set_translate(IBMPC_MAP,currcons);
+#ifdef CONFIG_KANJI
+				translate_ex = 0;
+#endif
 				disp_ctrl = 1;
 				toggle_meta = 1;
 				break;
@@ -1332,6 +1364,22 @@
 		case 14: /* set vesa powerdown interval */
 			vesa_off_interval = ((par[1] < 60) ? par[1] : 60) * 60 * HZ;
 			break;
+#ifdef CONFIG_KANJI
+		case 98:
+			if (par[1] < 10) /* change kanji mode */
+				do_change_kanji_mode(currcons, par[1]); /* 0208 */
+			else if (par[1] == 10) { /* save restore kanji mode */
+				switch (par[2]) {
+				case 1:
+					save_cur_kanji(currcons);
+					break;
+				case 2:
+					restore_cur_kanji(currcons);
+					break;
+				}
+			}
+			break;
+#endif /* CONFIG_KANJI */
 	}
 }
 
@@ -1409,8 +1457,26 @@
 	need_wrap = 0;
 }
 
+#ifdef CONFIG_KANJI
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
+#ifdef CONFIG_KANJI
+	ESsetJIS, ESsetJIS2,
+#endif
 	ESpalette };
 
 /* console_sem is held (except via vc_init()) */
@@ -1420,9 +1486,18 @@
 	bottom		= video_num_lines;
 	vc_state	= ESnormal;
 	ques		= 0;
+#ifdef CONFIG_KANJI
+	translate	= set_translate(JP_MAP, currcons);
+	translate_ex    = 0;
+	G0_charset      = JP_MAP;
+	G0_charset_ex   = 0;
+	G1_charset      = GRAF_MAP;
+	G1_charset_ex   = 0;
+#else
 	translate	= set_translate(LAT1_MAP,currcons);
 	G0_charset	= LAT1_MAP;
 	G1_charset	= GRAF_MAP;
+#endif
 	charset		= 0;
 	need_wrap	= 0;
 	report_mouse	= 0;
@@ -1464,6 +1539,12 @@
 	bell_pitch = DEFAULT_BELL_PITCH;
 	bell_duration = DEFAULT_BELL_DURATION;
 
+#ifdef CONFIG_KANJI
+	kanji_mode = EUC_CODE;
+	kanji_char1 = 0;
+	kanji_jis_mode = JIS_CODE_ASCII;
+#endif
+
 	gotoxy(currcons,0,0);
 	save_cur(currcons);
 	if (do_clear)
@@ -1506,11 +1587,17 @@
 	case 14:
 		charset = 1;
 		translate = set_translate(G1_charset,currcons);
+#ifdef CONFIG_KANJI
+		translate_ex = G1_charset_ex;
+#endif
 		disp_ctrl = 1;
 		return;
 	case 15:
 		charset = 0;
 		translate = set_translate(G0_charset,currcons);
+#ifdef CONFIG_KANJI
+		translate_ex = G0_charset_ex;
+#endif
 		disp_ctrl = 0;
 		return;
 	case 24: case 26:
@@ -1567,6 +1654,11 @@
 		case ')':
 			vc_state = ESsetG1;
 			return;
+#ifdef CONFIG_KANJI
+		case '$':
+			vc_state = ESsetJIS;
+			return;
+#endif
 		case '#':
 			vc_state = EShash;
 			return;
@@ -1816,8 +1908,25 @@
 			G0_charset = IBMPC_MAP;
 		else if (c == 'K')
 			G0_charset = USER_MAP;
-		if (charset == 0)
+#ifdef CONFIG_KANJI
+		G0_charset_ex = 0;
+		if (c == 'J')
+			G0_charset = JP_MAP;
+		else if (c == 'I'){
+			G0_charset = JP_MAP;
+			G0_charset_ex = 1;
+		}
+#endif /* CONFIG_KANJI */
+		if (charset == 0) {
 			translate = set_translate(G0_charset,currcons);
+#ifdef CONFIG_KANJI
+			translate_ex = G0_charset_ex;
+#endif
+		}
+#ifdef CONFIG_KANJI
+		kanji_jis_mode = JIS_CODE_ASCII;
+		kanji_char1 = 0;
+#endif
 		vc_state = ESnormal;
 		return;
 	case ESsetG1:
@@ -1829,10 +1938,51 @@
 			G1_charset = IBMPC_MAP;
 		else if (c == 'K')
 			G1_charset = USER_MAP;
-		if (charset == 1)
+#ifdef CONFIG_KANJI
+		G1_charset_ex = 0;
+		if (c == 'J')
+			G1_charset = JP_MAP;
+		else if (c == 'I') {
+			G1_charset = JP_MAP;
+			G1_charset_ex = 1;
+		}
+#endif /* CONFIG_KANJI */
+		if (charset == 1) {
 			translate = set_translate(G1_charset,currcons);
+#ifdef CONFIG_KANJI
+			translate_ex = G1_charset_ex;
+#endif
+		}
+#ifdef CONFIG_KANJI
+		kanji_jis_mode = JIS_CODE_ASCII;
+		kanji_char1 = 0;
+#endif
+		vc_state = ESnormal;
+		return;
+#ifdef CONFIG_KANJI
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
 		vc_state = ESnormal;
+		kanji_char1 = 0;
 		return;
+	case ESsetJIS2:
+		if (c == 'D'){
+			kanji_jis_mode = JIS_CODE_90;
+			kanji_char1 = 0;
+		}
+		vc_state = ESnormal;
+		return;
+#endif /* CONIFG_KANJI */
 	default:
 		vc_state = ESnormal;
 	}
@@ -1864,7 +2014,7 @@
 	}
 #endif
 
-	int c, tc, ok, n = 0, draw_x = -1;
+	int c, tc = 0, ok, n = 0, draw_x = -1;
 	unsigned int currcons;
 	unsigned long draw_from = 0, draw_to = 0;
 	struct vt_struct *vt = (struct vt_struct *)tty->driver_data;
@@ -1921,48 +2071,151 @@
 		hide_cursor(currcons);
 
 	while (!tty->stopped && count) {
+		int realkanji = 0;
+		int kanjioverrun = 0;
 		c = *buf;
 		buf++;
 		n++;
 		count--;
 
-		if (utf) {
-		    /* Combine UTF-8 into Unicode */
-		    /* Incomplete characters silently ignored */
-		    if(c > 0x7f) {
-			if (utf_count > 0 && (c & 0xc0) == 0x80) {
-				utf_char = (utf_char << 6) | (c & 0x3f);
-				utf_count--;
-				if (utf_count == 0)
-				    tc = c = utf_char;
-				else continue;
-			} else {
-				if ((c & 0xe0) == 0xc0) {
-				    utf_count = 1;
-				    utf_char = (c & 0x1f);
-				} else if ((c & 0xf0) == 0xe0) {
-				    utf_count = 2;
-				    utf_char = (c & 0x0f);
-				} else if ((c & 0xf8) == 0xf0) {
-				    utf_count = 3;
-				    utf_char = (c & 0x07);
-				} else if ((c & 0xfc) == 0xf8) {
-				    utf_count = 4;
-				    utf_char = (c & 0x03);
-				} else if ((c & 0xfe) == 0xfc) {
-				    utf_count = 5;
-				    utf_char = (c & 0x01);
-				} else
-				    utf_count = 0;
-				continue;
-			      }
-		    } else {
-		      tc = c;
-		      utf_count = 0;
-		    }
-		} else {	/* no utf */
-		  tc = translate[toggle_meta ? (c|0x80) : c];
-		}
+#ifdef CONFIG_KANJI
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
+                        } else if (0xA1 <= c && c <= 0xDF) {
+							tc = (unsigned int)translations[JP_MAP][c];
+							goto hankana_skip;
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
+							goto hankana_skip;
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
+#endif /* CONFIG_KANJI */
+		if (!realkanji) {
+			if (utf) {
+			    /* Combine UTF-8 into Unicode */
+			    /* Incomplete characters silently ignored */
+			    if(c > 0x7f) {
+				if (utf_count > 0 && (c & 0xc0) == 0x80) {
+					utf_char = (utf_char << 6) | (c & 0x3f);
+					utf_count--;
+					if (utf_count == 0)
+					    tc = c = utf_char;
+					else continue;
+				} else {
+					if ((c & 0xe0) == 0xc0) {
+					    utf_count = 1;
+					    utf_char = (c & 0x1f);
+					} else if ((c & 0xf0) == 0xe0) {
+					    utf_count = 2;
+					    utf_char = (c & 0x0f);
+					} else if ((c & 0xf8) == 0xf0) {
+					    utf_count = 3;
+					    utf_char = (c & 0x07);
+					} else if ((c & 0xfc) == 0xf8) {
+					    utf_count = 4;
+					    utf_char = (c & 0x03);
+					} else if ((c & 0xfe) == 0xfc) {
+					    utf_count = 5;
+					    utf_char = (c & 0x01);
+					} else
+					    utf_count = 0;
+					continue;
+				      }
+			    } else {
+			      tc = c;
+			      utf_count = 0;
+			    }
+			} else {	/* no utf */
+#ifdef CONFIG_KANJI
+			  tc = translate[(toggle_meta || translate_ex) ? (c | 0x80) : c];
+#else
+			  tc = translate[toggle_meta ? (c|0x80) : c];
+#endif
+			}
+		} /* if (!realkanji) */
+#ifdef CONFIG_KANJI
+	hankana_skip:
+#endif
 
                 /* If the original code was a control character we
                  * only allow a glyph to be displayed if the code is
@@ -1979,43 +2232,71 @@
                                          : CTRL_ACTION) >> c) & 1)))
                         && (c != 127 || disp_ctrl)
 			&& (c != 128+27);
+                ok |= realkanji;
 
 		if (vc_state == ESnormal && ok) {
-			/* Now try to find out how to display it */
-			tc = conv_uni_to_pc(vc_cons[currcons].d, tc);
-			if ( tc == -4 ) {
+			if (!realkanji) {
+				/* Now try to find out how to display it */
+				tc = conv_uni_to_pc(vc_cons[currcons].d, tc);
+				if ( tc == -4 ) {
                                 /* If we got -4 (not found) then see if we have
                                    defined a replacement character (U+FFFD) */
-                                tc = conv_uni_to_pc(vc_cons[currcons].d, 0xfffd);
+       	                         tc = conv_uni_to_pc(vc_cons[currcons].d, 0xfffd);
 
 				/* One reason for the -4 can be that we just
 				   did a clear_unimap();
 				   try at least to show something. */
-				if (tc == -4)
-				     tc = c;
-                        } else if ( tc == -3 ) {
+					if (tc == -4)
+					     tc = c;
+				} else if ( tc == -3 ) {
                                 /* Bad hash table -- hope for the best */
-                                tc = c;
-                        }
-			if (tc & ~charmask)
-                                continue; /* Conversion failed */
+					tc = c;
+				}
+				if (tc & ~charmask)
+					continue; /* Conversion failed */
+			} /* !realkanji */
 
 			if (need_wrap || decim)
 				FLUSH
 			if (need_wrap) {
 				cr(currcons);
 				lf(currcons);
+				if (kanjioverrun) {
+					x++;
+					pos += 2;
+					kanjioverrun = 0;
+				}
 			}
 			if (decim)
 				insert_char(currcons, 1);
+#ifndef CONFIG_KANJI
 			scr_writew(himask ?
 				     ((attr << 8) & ~himask) + ((tc & 0x100) ? himask : 0) + (tc & 0xff) :
 				     (attr << 8) + tc,
 				   (u16 *) pos);
+#else /* CONFIG_KANJI */
+			if (realkanji) {
+				tc = ((tc >> 8) & 0xff) | ((tc << 8) & 0xff00); 
+				*((u16 *)pos) = (tc - 0x20) & 0xff7f;
+				*(pc9800_attr_offset((u16 *)pos)) = attr;
+				x ++;
+				pos += 2;
+				*((u16 *)pos) = (tc - 0x20) | 0x80;
+				*(pc9800_attr_offset((u16 *)pos)) = attr;
+			} else {
+				*((u16 *)pos) = tc & 0x00ff;
+				*(pc9800_attr_offset((u16 *)pos)) = attr;
+			}
+#endif /* !CONFIG_KANJI */
 			if (DO_UPDATE && draw_x < 0) {
 				draw_x = x;
 				draw_from = pos;
+				if (realkanji) {
+					draw_x --;
+					draw_from -= 2;
+				}
 			}
+#ifndef CONFIG_KANJI
 			if (x == video_num_columns - 1) {
 				need_wrap = decawm;
 				draw_to = pos+2;
@@ -2023,6 +2304,16 @@
 				x++;
 				draw_to = (pos+=2);
 			}
+#else /* CONFIG_KANJI */
+			if (x >= video_num_columns - 1) {
+				need_wrap = decawm;
+				kanjioverrun = x - video_num_columns + 1;
+				draw_to = pos + 2;
+			} else {
+				x++;
+				draw_to = (pos += 2);
+			}
+#endif /* !CONFIG_KANJI */
 			continue;
 		}
 		FLUSH
diff -Nru linux-2.5.65-bk4/drivers/video/console/Kconfig linux98-2.5.65-bk4/drivers/video/console/Kconfig
--- linux-2.5.65-bk4/drivers/video/console/Kconfig	2003-03-23 21:55:14.000000000 +0900
+++ linux98-2.5.65-bk4/drivers/video/console/Kconfig	2003-03-24 00:18:45.000000000 +0900
@@ -109,6 +109,10 @@
 	bool "Enable 32-bit access to text video RAM"
 	depends on GDC_CONSOLE
 
+config KANJI
+	bool "Japanese Kanji support"
+	depends on X86_PC9800
+
 config DUMMY_CONSOLE
 	bool
 	depends on PROM_CONSOLE!=y || VGA_CONSOLE!=y || SGI_NEWPORT_CONSOLE!=y 
diff -Nru linux/include/linux/console_struct.h linux98/include/linux/console_struct.h
--- linux/include/linux/console_struct.h	2003-03-23 22:22:05.000000000 +0900
+++ linux98/include/linux/console_struct.h	2003-03-24 00:13:03.000000000 +0900
@@ -94,6 +94,18 @@
 	struct vc_data **vc_display_fg;		/* [!] Ptr to var holding fg console for this display */
 	unsigned long	vc_uni_pagedir;
 	unsigned long	*vc_uni_pagedir_loc;  /* [!] Location of uni_pagedir variable for this console */
+#ifdef CONFIG_KANJI
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
+#endif /* CONFIG_KANJI */
 	/* additional information is in vt_kern.h */
 };
 
diff -Nru linux/include/linux/consolemap.h linux98/include/linux/consolemap.h
--- linux/include/linux/consolemap.h	Sat Oct 19 13:02:34 2002
+++ linux98/include/linux/consolemap.h	Mon Oct 21 14:19:31 2002
@@ -7,6 +7,7 @@
 #define GRAF_MAP 1
 #define IBMPC_MAP 2
 #define USER_MAP 3
+#define JP_MAP 4
 
 struct vc_data;
 
