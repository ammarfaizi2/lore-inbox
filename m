Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267515AbUHDXiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267515AbUHDXiZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 19:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267512AbUHDXiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 19:38:01 -0400
Received: from ozlabs.org ([203.10.76.45]:59289 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267515AbUHDXgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 19:36:55 -0400
Date: Thu, 5 Aug 2004 09:35:55 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [PATCH] [ppc64] Fix chrp_progress mismerge
Message-ID: <20040804233555.GD30253@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Due to a mismerge, some code in chrp_progress appears twice. While here,
clean up some formatting issues.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/chrp_setup.c~progress-fix arch/ppc64/kernel/chrp_setup.c
--- linux-2.6.8-rc2-mm2/arch/ppc64/kernel/chrp_setup.c~progress-fix	2004-08-04 17:46:44.258756677 -0500
+++ linux-2.6.8-rc2-mm2-anton/arch/ppc64/kernel/chrp_setup.c	2004-08-04 17:46:44.270754770 -0500
@@ -298,8 +298,7 @@ chrp_init(unsigned long r3, unsigned lon
 	       cur_cpu_spec->firmware_features);
 }
 
-void
-chrp_progress(char *s, unsigned short hex)
+void chrp_progress(char *s, unsigned short hex)
 {
 	struct device_node *root;
 	int width, *p;
@@ -313,60 +312,55 @@ chrp_progress(char *s, unsigned short he
 		return;
 
 	if (max_width == 0) {
-		if ( (root = find_path_device("/rtas")) &&
+		if ((root = find_path_device("/rtas")) &&
 		     (p = (unsigned int *)get_property(root,
 						       "ibm,display-line-length",
-						       NULL)) )
+						       NULL)))
 			max_width = *p;
 		else
 			max_width = 0x10;
 		display_character = rtas_token("display-character");
 		set_indicator = rtas_token("set-indicator");
 	}
-	if (display_character == RTAS_UNKNOWN_SERVICE) {
-		/* use hex display */
-		if (set_indicator == RTAS_UNKNOWN_SERVICE)
-			return;
-		rtas_call(set_indicator, 3, 1, NULL, 6, 0, hex);
-		return;
-	}
 
-	if(display_character == RTAS_UNKNOWN_SERVICE) {
+	if (display_character == RTAS_UNKNOWN_SERVICE) {
 		/* use hex display if available */
-		if(set_indicator != RTAS_UNKNOWN_SERVICE)
+		if (set_indicator != RTAS_UNKNOWN_SERVICE)
 			rtas_call(set_indicator, 3, 1, NULL, 6, 0, hex);
 		return;
 	}
 
 	spin_lock(&progress_lock);
 
-	/* Last write ended with newline, but we didn't print it since
+	/*
+	 * Last write ended with newline, but we didn't print it since
 	 * it would just clear the bottom line of output. Print it now
 	 * instead.
 	 *
 	 * If no newline is pending, print a CR to start output at the
 	 * beginning of the line.
 	 */
-	if(pending_newline) {
+	if (pending_newline) {
 		rtas_call(display_character, 1, 1, NULL, '\r');
 		rtas_call(display_character, 1, 1, NULL, '\n');
 		pending_newline = 0;
-	} else
+	} else {
 		rtas_call(display_character, 1, 1, NULL, '\r');
+	}
  
 	width = max_width;
 	os = s;
 	while (*os) {
-		if(*os == '\n' || *os == '\r') {
+		if (*os == '\n' || *os == '\r') {
 			/* Blank to end of line. */
-			while(width-- > 0)
+			while (width-- > 0)
 				rtas_call(display_character, 1, 1, NULL, ' ');
  
 			/* If newline is the last character, save it
 			 * until next call to avoid bumping up the
 			 * display output.
 			 */
-			if(*os == '\n' && !os[1]) {
+			if (*os == '\n' && !os[1]) {
 				pending_newline = 1;
 				spin_unlock(&progress_lock);
 				return;
@@ -374,7 +368,7 @@ chrp_progress(char *s, unsigned short he
  
 			/* RTAS wants CR-LF, not just LF */
  
-			if(*os == '\n') {
+			if (*os == '\n') {
 				rtas_call(display_character, 1, 1, NULL, '\r');
 				rtas_call(display_character, 1, 1, NULL, '\n');
 			} else {
@@ -393,14 +387,14 @@ chrp_progress(char *s, unsigned short he
 		os++;
  
 		/* if we overwrite the screen length */
-		if ( width <= 0 )
-			while ( (*os != 0) && (*os != '\n') && (*os != '\r') )
+		if (width <= 0)
+			while ((*os != 0) && (*os != '\n') && (*os != '\r'))
 				os++;
 	}
  
 	/* Blank to end of line. */
-	while ( width-- > 0 )
-		rtas_call(display_character, 1, 1, NULL, ' ' );
+	while (width-- > 0)
+		rtas_call(display_character, 1, 1, NULL, ' ');
 
 	spin_unlock(&progress_lock);
 }

_
