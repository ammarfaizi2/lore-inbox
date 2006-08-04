Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030282AbWHDKMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWHDKMo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 06:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbWHDKMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 06:12:44 -0400
Received: from sunrise.pg.gda.pl ([153.19.40.230]:4236 "EHLO sunrise.pg.gda.pl")
	by vger.kernel.org with ESMTP id S1030282AbWHDKMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 06:12:43 -0400
Message-ID: <44D31E31.70009@pg.gda.pl>
Date: Fri, 04 Aug 2006 12:15:13 +0200
From: =?ISO-8859-2?Q?Adam_Tla=B3ka?= <atlka@pg.gda.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH]console utf-8 mode fixes
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------030009060807060005090402"
X-DCC-URT-Metrics: sunrise 1060; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030009060807060005090402
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit

Description: patch for drivers/char/vt.c

Fixed utf-8 mode so alternate charset modes always work according
to control sequences interpreted in do_con_trol function
preserving backward US-ASCII and VT100 semigraphics compatibility.

Malformed utf-8 sequences are represented as sequences of replacement 
glyphs,original codes or '?' as a last resort.

unicode-xterm, gnome-terminal, kconsole and other terminal emulators
in utf-8 mode respect acsc, enacs, rmacs sequences. Also I found that 
some important system programs (from Debian distro) uses acsc in utf-8 
mode - dselect, aptitude, w3m for example.

Signed-off-by: Adam Tla/lka <atlka@pg.gda.pl>


Regards
-- 
Adam Tla³ka       mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group       - - - ~~~~~~
Computer Center,  Gdañsk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl

--------------030009060807060005090402
Content-Type: text/x-patch;
 name="vt.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vt.c.patch"

--- vt_orig.c	2006-08-03 08:34:40.000000000 +0200
+++ vt.c	2006-08-03 09:12:21.000000000 +0200
@@ -63,6 +63,13 @@
  *
  * Removed console_lock, enabled interrupts across all console operations
  * 13 March 2001, Andrew Morton
+ *
+ * Fixed UTF-8 mode so alternate charset modes always work according
+ * to control sequences interpreted in do_con_trol function
+ * preserving backward VT100 semigraphics compatibility,
+ * malformed UTF sequences represented as sequences of replacement glyphs,
+ * original codes or '?' as a last resort if replacement glyph is undefined
+ * by Adam Tla/lka <atlka@pg.gda.pl>, Aug 2006
  */
 
 #include <linux/module.h>
@@ -1991,17 +1998,23 @@ static int do_con_write(struct tty_struc
 		/* Do no translation at all in control states */
 		if (vc->vc_state != ESnormal) {
 			tc = c;
-		} else if (vc->vc_utf) {
+		} else if (vc->vc_utf && !vc->vc_disp_ctrl) {
 		    /* Combine UTF-8 into Unicode */
-		    /* Incomplete characters silently ignored */
+		    /* Malformed sequences as sequences of replacement glyphs */
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
+					       vc->vc_npar++;
+				   	       continue;
+       				       }
+				       tc = c = vc->vc_utf_char;
+			       } else
+				       goto replacement_glyph;
 			} else {
+				vc->vc_npar = 0;
 				if ((c & 0xe0) == 0xc0) {
 				    vc->vc_utf_count = 1;
 				    vc->vc_utf_char = (c & 0x1f);
@@ -2018,14 +2031,15 @@ static int do_con_write(struct tty_struc
 				    vc->vc_utf_count = 5;
 				    vc->vc_utf_char = (c & 0x01);
 				} else
-				    vc->vc_utf_count = 0;
+	    			    goto replacement_glyph;
 				continue;
 			      }
 		    } else {
+		      if (vc->vc_utf_count)
+	  		      goto replacement_glyph;
 		      tc = c;
-		      vc->vc_utf_count = 0;
 		    }
-		} else {	/* no utf */
+		} else {	/* no utf or alternate charset mode */
 		  tc = vc->vc_translate[vc->vc_toggle_meta ? (c | 0x80) : c];
 		}
 
@@ -2040,31 +2054,33 @@ static int do_con_write(struct tty_struc
                  * direct-to-font zone in UTF-8 mode.
                  */
                 ok = tc && (c >= 32 ||
-			    (!vc->vc_utf && !(((vc->vc_disp_ctrl ? CTRL_ALWAYS
-						: CTRL_ACTION) >> c) & 1)))
+			    !(vc->vc_disp_ctrl ? (CTRL_ALWAYS >> c) & 1 :
+				  vc->vc_utf || ((CTRL_ACTION >> c) & 1)))
 			&& (c != 127 || vc->vc_disp_ctrl)
 			&& (c != 128+27);
 
 		if (vc->vc_state == ESnormal && ok) {
 			/* Now try to find out how to display it */
 			tc = conv_uni_to_pc(vc, tc);
-			if ( tc == -4 ) {
+			if (tc & ~charmask) {
+				if ( tc == -4 ) {
                                 /* If we got -4 (not found) then see if we have
                                    defined a replacement character (U+FFFD) */
-                                tc = conv_uni_to_pc(vc, 0xfffd);
-
-				/* One reason for the -4 can be that we just
-				   did a clear_unimap();
-				   try at least to show something. */
-				if (tc == -4)
-				     tc = c;
-                        } else if ( tc == -3 ) {
-                                /* Bad hash table -- hope for the best */
-                                tc = c;
-                        }
-			if (tc & ~charmask)
-                                continue; /* Conversion failed */
+replacement_glyph:
+                                	tc = conv_uni_to_pc(vc, 0xfffd);
+					if (!(tc & ~charmask))
+						goto display_glyph;
+                        	} else if ( tc != -3 )
+                                	continue; /* nothing to display */
+                                /* no hash table or no replacement -- 
+				 * hope for the best */
+				if ( c & ~charmask )
+					tc = '?';
+				else
+					tc = c;
+			}
 
+display_glyph:	
 			if (vc->vc_need_wrap || vc->vc_decim)
 				FLUSH
 			if (vc->vc_need_wrap) {
@@ -2088,6 +2104,15 @@ static int do_con_write(struct tty_struc
 				vc->vc_x++;
 				draw_to = (vc->vc_pos += 2);
 			}
+			if (vc->vc_utf_count) {
+				if (vc->vc_npar) {
+					vc->vc_npar--;
+					goto display_glyph;
+				}
+				vc->vc_utf_count = 0;
+				c = orig;
+				goto rescan_last_byte;
+			}
 			continue;
 		}
 		FLUSH

--------------030009060807060005090402--
