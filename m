Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWBRWge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWBRWge (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 17:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWBRWge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 17:36:34 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:44973 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP id S932246AbWBRWge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 17:36:34 -0500
Date: Sat, 18 Feb 2006 23:35:24 +0100
From: Adam Tla/lka <atlka@pg.gda.pl>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH]console:UTF-8 mode compatibility fixes
Message-ID: <20060218223524.GA15834@sunrise.pg.gda.pl>
References: <20060217233333.GA5208@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217233333.GA5208@sunrise.pg.gda.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch applies to 2.6.15.3 kernel sources to drivers/char/vt.c file.
It should work with other versions too.

Changed console behaviour so in UTF-8 mode vt100 alternate character
sequences work as described in terminfo/termcap linux terminal definition.
Programs can use vt100 control seqences - smacs, rmacs and acsc  characters
in UTF-8 mode in the same way as in normal mode so one definition is always
valid - current behaviour make these seqences not working in UTF-8 mode.

Added reporting malformed UTF-8 seqences as replacement glyphs.
I think that terminal should always display something rather then ignoring
these kind of data as it does now. Also it sticks to Unicode standards
saying that every wrong byte should be reported. It is more human readable
too in case of Latin subsets including ASCII chars.

It's the second version with original codes used in case when there is no replacement
glyph defined. So all scanned bytes are remembered. Anyway it could be used
in the future if we implement screen buffer as UCS-2 plus attributes
so copying from it in UTF-8 mode will always work properly.

Signed-off-by: Adam Tla/lka <atlka@pg.gda.pl>

---

--- drivers/char/vt_orig.c	2006-02-13 11:33:54.000000000 +0100
+++ drivers/char/vt.c	2006-02-18 23:18:50.000000000 +0100
@@ -63,6 +63,13 @@
  *
  * Removed console_lock, enabled interrupts across all console operations
  * 13 March 2001, Andrew Morton
+ *
+ * Fixed UTF-8 mode so alternate charset modes always work without need
+ * of different linux terminal definition for normal and UTF-8 modes
+ * preserving backward US-ASCII and VT100 semigraphics compatibility,
+ * malformed UTF sequences represented as sequences of replacement glyphs
+ * or original codes if replacement glyph is undefined
+ * by Adam Tla/lka <atlka@pg.gda.pl>, Feb 2006
  */
 
 #include <linux/module.h>
@@ -1991,17 +1998,26 @@ static int do_con_write(struct tty_struc
 		/* Do no translation at all in control states */
 		if (vc->vc_state != ESnormal) {
 			tc = c;
-		} else if (vc->vc_utf) {
+		} else if (vc->vc_utf && !vc->vc_disp_ctrl) {
 		    /* Combine UTF-8 into Unicode */
-		    /* Incomplete characters silently ignored */
+		    /* Malformed sequence represented as replacement glyphs */
+rescan_last_byte:
 		    if(c > 0x7f) {
-			if (vc->vc_utf_count > 0 && (c & 0xc0) == 0x80) {
-				vc->vc_utf_char = (vc->vc_utf_char << 6) | (c & 0x3f);
-				vc->vc_utf_count--;
-				if (vc->vc_utf_count == 0)
-				    tc = c = vc->vc_utf_char;
-				else continue;
+			if (vc->vc_utf_count) {
+			       if ((c & 0xc0) == 0x80) {
+				       vc->vc_utf_char = (vc->vc_utf_char << 6) | (c & 0x3f);
+       				       if (--vc->vc_utf_count) {
+					       vc->vc_par[vc->vc_utf_count] = c;
+					       vc->vc_npar++;
+				   	       continue;
+       				       }
+				       tc = c = vc->vc_utf_char;
+			       } else {
+				       c = vc->vc_par[vc->vc_utf_count + vc->vc_npar];
+				       goto insert_replacement_glyph;
+			       }
 			} else {
+				vc->vc_npar = 0;
 				if ((c & 0xe0) == 0xc0) {
 				    vc->vc_utf_count = 1;
 				    vc->vc_utf_char = (c & 0x1f);
@@ -2018,12 +2034,16 @@ static int do_con_write(struct tty_struc
 				    vc->vc_utf_count = 5;
 				    vc->vc_utf_char = (c & 0x01);
 				} else
-				    vc->vc_utf_count = 0;
+	    			    goto insert_replacement_glyph;
+				vc->vc_par[vc->vc_utf_count] = c;
 				continue;
 			      }
 		    } else {
+		      if (vc->vc_utf_count) {
+			      c = vc->vc_par[vc->vc_utf_count + vc->vc_npar];
+	  		      goto insert_replacement_glyph;
+		      }
 		      tc = c;
-		      vc->vc_utf_count = 0;
 		    }
 		} else {	/* no utf */
 		  tc = vc->vc_translate[vc->vc_toggle_meta ? (c | 0x80) : c];
@@ -2040,8 +2060,8 @@ static int do_con_write(struct tty_struc
                  * direct-to-font zone in UTF-8 mode.
                  */
                 ok = tc && (c >= 32 ||
-			    (!vc->vc_utf && !(((vc->vc_disp_ctrl ? CTRL_ALWAYS
-						: CTRL_ACTION) >> c) & 1)))
+			    !(vc->vc_disp_ctrl ? (CTRL_ALWAYS >> c) & 1 :
+				  vc->vc_utf || ((CTRL_ACTION >> c) & 1)))
 			&& (c != 127 || vc->vc_disp_ctrl)
 			&& (c != 128+27);
 
@@ -2051,6 +2071,7 @@ static int do_con_write(struct tty_struc
 			if ( tc == -4 ) {
                                 /* If we got -4 (not found) then see if we have
                                    defined a replacement character (U+FFFD) */
+insert_replacement_glyph:
                                 tc = conv_uni_to_pc(vc, 0xfffd);
 
 				/* One reason for the -4 can be that we just
@@ -2063,7 +2084,7 @@ static int do_con_write(struct tty_struc
                                 tc = c;
                         }
 			if (tc & ~charmask)
-                                continue; /* Conversion failed */
+				goto check_malformed_sequence;
 
 			if (vc->vc_need_wrap || vc->vc_decim)
 				FLUSH
@@ -2088,6 +2109,16 @@ static int do_con_write(struct tty_struc
 				vc->vc_x++;
 				draw_to = (vc->vc_pos += 2);
 			}
+check_malformed_sequence:
+			if (vc->vc_utf_count) {
+				if (vc->vc_npar) {
+					c = vc->vc_par[vc->vc_utf_count + --vc->vc_npar];
+					goto insert_replacement_glyph;
+				}
+				vc->vc_utf_count = 0;
+				c = orig;
+				goto rescan_last_byte;
+			}
 			continue;
 		}
 		FLUSH
