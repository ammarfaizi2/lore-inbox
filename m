Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261941AbVDVEJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261941AbVDVEJn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 00:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbVDVEJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 00:09:42 -0400
Received: from mail03.powweb.com ([66.152.97.36]:25099 "EHLO mail03.powweb.com")
	by vger.kernel.org with ESMTP id S261941AbVDVEJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 00:09:38 -0400
From: Richard Drummond <evilrich@rcdrummond.net>
Organization: Private
To: linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] Better PLL frequency matching for tdfxfb driver
Date: Thu, 21 Apr 2005 22:58:00 -0500
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200504212258.00570.evilrich@rcdrummond.net>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_IZHaCqkOpSzY1nK"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_IZHaCqkOpSzY1nK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached is a patch against 2.6.11.7 which improves the PLL frequency matching 
in the tdfxfb driver. Instead of requiring 64260 iterations to obtain the 
closest supported PLL frequency, this code does it with the same degree of 
accuracy in at most 768 iterations.

Signed-off-by: Richard Drummond <evilrich@rcdrummond.net>

--Boundary-00=_IZHaCqkOpSzY1nK
Content-Type: text/x-diff;
  charset="us-ascii";
  name="tdfxfb_pll_fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="tdfxfb_pll_fix.diff"

--- drivers/video/tdfxfb.c_orig	2005-04-20 15:04:23.000000000 -0500
+++ drivers/video/tdfxfb.c	2005-04-21 09:26:18.000000000 -0500
@@ -320,30 +320,40 @@
 
 static u32 do_calc_pll(int freq, int* freq_out) 
 {
-	int m, n, k, best_m, best_n, best_k, f_cur, best_error;
+	int m, n, k, best_m, best_n, best_k, best_error;
 	int fref = 14318;
   
-	/* this really could be done with more intelligence --
-	   255*63*4 = 64260 iterations is silly */
 	best_error = freq;
 	best_n = best_m = best_k = 0;
-	for (n = 1; n < 256; n++) {
-		for (m = 1; m < 64; m++) {
-			for (k = 0; k < 4; k++) {
-				f_cur = fref*(n + 2)/(m + 2)/(1 << k);
-				if (abs(f_cur - freq) < best_error) {
-					best_error = abs(f_cur-freq);
-					best_n = n;
-					best_m = m;
-					best_k = k;
-				}
+   
+	for (k = 3; k >= 0; k--) {	
+		for (m = 63; m >= 0; m--) {
+			/* Estimate value of n that produces target frequency with current m and k */
+			int n_estimated = (freq * (m + 2) * (1 << k) / fref) - 2;
+	     
+			/* Search neighborhood of estimated n */
+			for (n = max(0, n_estimated - 1); n <= min(255, n_estimated + 1); n++) {
+				/* Calculate PLL freqency with current m, k and estimated n */
+				int f     = fref * (n + 2) / (m + 2) / (1 << k);
+				int error = abs (f - freq);
+		  
+				/* If this is the closest we've come to the target frequency
+				 * then remember n, m and k */
+				if (error  < best_error) {
+					best_error = error;
+					best_n     = n;
+					best_m     = m;
+					best_k     = k;
+				}  
 			}
 		}
 	}
+   
 	n = best_n;
 	m = best_m;
 	k = best_k;
 	*freq_out = fref*(n + 2)/(m + 2)/(1 << k);
+   
 	return (n << 8) | (m << 2) | k;
 }
 

--Boundary-00=_IZHaCqkOpSzY1nK--

