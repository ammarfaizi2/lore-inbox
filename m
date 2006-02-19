Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWBSKQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWBSKQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 05:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWBSKQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 05:16:28 -0500
Received: from sunrise.pg.gda.pl ([153.19.40.230]:5281 "EHLO sunrise.pg.gda.pl")
	by vger.kernel.org with ESMTP id S932382AbWBSKQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 05:16:27 -0500
Date: Sun, 19 Feb 2006 11:15:12 +0100
From: Adam Tla/lka <atlka@pg.gda.pl>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Cc: torvalds@osdl.org, bug-ncurses@gnu.org,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]console:UTF-8 mode compatibility fixes
Message-ID: <20060219101512.GB862@sunrise.pg.gda.pl>
References: <20060217233333.GA5208@sunrise.pg.gda.pl> <43F72C7A.8010709@ums.usu.ru> <43F8054E.1000805@ums.usu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F8054E.1000805@ums.usu.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 10:42:38AM +0500, Alexander E. Patrakov wrote:
> Sorry, that my non-true statement was due to the less-than-perfect 
> description of the patch. After patching, this produces a horizontal line:
> 
> echo -e '\x0eqqqq\x0f'
> 
> So please correct the description and the first (comment) hunk of the 
> patch, so that it doesn't mention "smacs" and similar words with meaning 
> that may vary, and so that it mentions the exact control codes.
> 

Ok, you are right.
Here is the corrected description and the new patch:

Fixed UTF-8 mode so alternate charset modes always work according
to control sequences interpreted in do_con_trol function:
smacs = '\x0e', rmacs = '\x0f' if vt100 translation map for alternate
charset is active which means enacs = '\e)0' which preserves
backward US-ASCII and VT100 semigraphics compatibility,
malformed UTF sequences represented as sequences of replacement glyphs
or original codes if replacement glyph is undefined
Signed-off-by: Adam Tla/lka <atlka@pg.gda.pl>

--- drivers/char/vt_orig.c	2006-02-13 11:33:54.000000000 +0100
+++ drivers/char/vt.c	2006-02-19 10:59:27.000000000 +0100
@@ -63,6 +63,15 @@
  *
  * Removed console_lock, enabled interrupts across all console operations
  * 13 March 2001, Andrew Morton
+ *
+ * Fixed UTF-8 mode so alternate charset modes always work according
+ * to control sequences interpreted in do_con_trol function:
+ * smacs = '\x0e', rmacs = '\x0f' if vt100 translation map for alternate
+ * charset is active which means enacs = '\e)0'
+ * preserving backward US-ASCII and VT100 semigraphics compatibility,
+ * malformed UTF sequences represented as sequences of replacement glyphs
+ * or original codes if replacement glyph is undefined
+ * by Adam Tla/lka <atlka@pg.gda.pl>, Feb 2006
  */
 
 #include <linux/module.h>
@@ -1991,17 +2000,26 @@ static int do_con_write(struct tty_struc
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
@@ -2018,12 +2036,16 @@ static int do_con_write(struct tty_struc
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
@@ -2040,8 +2062,8 @@ static int do_con_write(struct tty_struc
                  * direct-to-font zone in UTF-8 mode.
                  */
                 ok = tc && (c >= 32 ||
-			    (!vc->vc_utf && !(((vc->vc_disp_ctrl ? CTRL_ALWAYS
-						: CTRL_ACTION) >> c) & 1)))
+			    !(vc->vc_disp_ctrl ? (CTRL_ALWAYS >> c) & 1 :
+				  vc->vc_utf || ((CTRL_ACTION >> c) & 1)))
 			&& (c != 127 || vc->vc_disp_ctrl)
 			&& (c != 128+27);
 
@@ -2051,6 +2073,7 @@ static int do_con_write(struct tty_struc
 			if ( tc == -4 ) {
                                 /* If we got -4 (not found) then see if we have
                                    defined a replacement character (U+FFFD) */
+insert_replacement_glyph:
                                 tc = conv_uni_to_pc(vc, 0xfffd);
 
 				/* One reason for the -4 can be that we just
@@ -2063,7 +2086,7 @@ static int do_con_write(struct tty_struc
                                 tc = c;
                         }
 			if (tc & ~charmask)
-                                continue; /* Conversion failed */
+				goto check_malformed_sequence;
 
 			if (vc->vc_need_wrap || vc->vc_decim)
 				FLUSH
@@ -2088,6 +2111,16 @@ static int do_con_write(struct tty_struc
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
