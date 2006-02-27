Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751290AbWB0MIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbWB0MIQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 07:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWB0MIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 07:08:15 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:14071 "EHLO
	sunrise.pg.gda.pl") by vger.kernel.org with ESMTP id S1751290AbWB0MIO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 07:08:14 -0500
Date: Mon, 27 Feb 2006 13:06:58 +0100
From: Adam Tla/lka <atlka@pg.gda.pl>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH]console compatibility fixes to UTF-8 mode
Message-ID: <20060227120658.GA13378@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Info:

Fixed inconsistent behaviour with linux terminal definition in UTF-8 mode,
and stick more closely to Unicode standard.
Tested on kernel 2.6.15.4 with lat2-sun16 and latarcyrheb-sun16 console fonts.
Should work without problems with previous kernels too.


Description:

Fixed UTF-8 mode so alternate charset modes always work according
to control sequences interpreted in csm_m and do_con_trol functions:
smpch = '\e[11m', rmpch='\e[10m',
smacs = '\x0e' and rmacs = '\x0f' if vt100 translation map for alternate
charset is active which means enacs = '\e)0'
which supports IBM-PC  and VT100 semigraphics compatibility,
and matches the same terminal definition for normal and UTF-8 mode;
malformed UTF sequences represented as sequences of replacement glyphs,
original codes or '?' as a last resort if replacement glyph is undefined
and  UCS-2 code does not fit in 0-127 code range

Signed-off-by: Adam Tla/lka <atlka@pg.gda.pl>

--- /usr/src/linux-2.6.15.4/drivers/char/vt_orig.c	2006-02-27 08:43:57.000000000 +0100
+++ /usr/src/linux-2.6.15.4/drivers/char/vt.c	2006-02-27 09:52:47.000000000 +0100
@@ -63,6 +63,10 @@
  *
  * Removed console_lock, enabled interrupts across all console operations
  * 13 March 2001, Andrew Morton
+ *
+ * Fixed UTF-8 mode so alternate charset modes always work,
+ * added showing replacement glyphs in case of malformed UTF-8 sequences
+ * by Adam Tla/lka <atlka@pg.gda.pl>, Feb 2006
  */
 
 #include <linux/module.h>
@@ -1991,17 +1995,23 @@ static int do_con_write(struct tty_struc
 		/* Do no translation at all in control states */
 		if (vc->vc_state != ESnormal) {
 			tc = c;
-		} else if (vc->vc_utf) {
+		} else if (vc->vc_utf && !vc->vc_disp_ctrl) {
 		    /* Combine UTF-8 into Unicode */
-		    /* Incomplete characters silently ignored */
+		    /* Malformed sequences as replacement glyphs */
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
+				       goto insert_replacement_glyph;
 			} else {
+				vc->vc_npar = 0;
 				if ((c & 0xe0) == 0xc0) {
 				    vc->vc_utf_count = 1;
 				    vc->vc_utf_char = (c & 0x1f);
@@ -2018,12 +2028,13 @@ static int do_con_write(struct tty_struc
 				    vc->vc_utf_count = 5;
 				    vc->vc_utf_char = (c & 0x01);
 				} else
-				    vc->vc_utf_count = 0;
+	    			    goto insert_replacement_glyph;
 				continue;
 			      }
 		    } else {
+		      if (vc->vc_utf_count)
+	  		      goto insert_replacement_glyph;
 		      tc = c;
-		      vc->vc_utf_count = 0;
 		    }
 		} else {	/* no utf */
 		  tc = vc->vc_translate[vc->vc_toggle_meta ? (c | 0x80) : c];
@@ -2040,31 +2051,41 @@ static int do_con_write(struct tty_struc
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
+			if ( tc & ~charmask ) {
+				if ( tc == -4 ) {
                                 /* If we got -4 (not found) then see if we have
                                    defined a replacement character (U+FFFD) */
-                                tc = conv_uni_to_pc(vc, 0xfffd);
+insert_replacement_glyph:
+                                	tc = conv_uni_to_pc(vc, 0xfffd);
 
 				/* One reason for the -4 can be that we just
 				   did a clear_unimap();
 				   try at least to show something. */
-				if (tc == -4)
-				     tc = c;
-                        } else if ( tc == -3 ) {
+					if (tc & ~charmask) {
+						if ( c & ~0x7f )
+							tc = '?';
+						else
+							tc = c;
+					}
+                        	} else if ( tc == -3 ) {
                                 /* Bad hash table -- hope for the best */
-                                tc = c;
-                        }
-			if (tc & ~charmask)
-                                continue; /* Conversion failed */
+					if ( c & ~0x7f )
+						tc = '?';
+					else
+						tc = c;
+                        	} else
+                                	continue; /* nothing to display */
+			}
 
+repeat_replacement_glyph:	
 			if (vc->vc_need_wrap || vc->vc_decim)
 				FLUSH
 			if (vc->vc_need_wrap) {
@@ -2088,6 +2109,15 @@ static int do_con_write(struct tty_struc
 				vc->vc_x++;
 				draw_to = (vc->vc_pos += 2);
 			}
+			if (vc->vc_utf_count) {
+				if (vc->vc_npar) {
+					vc->vc_npar--;
+					goto repeat_replacement_glyph;
+				}
+				vc->vc_utf_count = 0;
+				c = orig;
+				goto rescan_last_byte;
+			}
 			continue;
 		}
 		FLUSH
