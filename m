Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266323AbTAFJMU>; Mon, 6 Jan 2003 04:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266330AbTAFJMU>; Mon, 6 Jan 2003 04:12:20 -0500
Received: from are.twiddle.net ([64.81.246.98]:17800 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S266323AbTAFJMT>;
	Mon, 6 Jan 2003 04:12:19 -0500
Date: Mon, 6 Jan 2003 01:20:42 -0800
From: Richard Henderson <rth@twiddle.net>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [FB PATCH] fix alpha boot oops
Message-ID: <20030106012042.A14616@twiddle.net>
Mail-Followup-To: linux-fbdev-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops in fb_set_cmap caused by palette_cmap.transp uninitialized.
By inspection, fb_blank appears to have the same problem.


r~


===== fbmem.c 1.49 vs edited =====
--- 1.49/drivers/video/fbmem.c	Tue Dec 31 18:08:48 2002
+++ edited/fbmem.c	Mon Jan  6 01:07:03 2003
@@ -386,6 +386,7 @@
 	palette_cmap.red = palette_red;
 	palette_cmap.green = palette_green;
 	palette_cmap.blue = palette_blue;
+	palette_cmap.transp = NULL;
 
 	for (i = 0; i < LINUX_LOGO_COLORS; i += n) {
 		n = LINUX_LOGO_COLORS - i;
@@ -767,6 +768,7 @@
 int
 fb_blank(int blank, struct fb_info *info)
 {	
+	/* ??? Varible sized stack allocation.  */
 	u16 black[info->cmap.len];
 	struct fb_cmap cmap;
 	
@@ -775,8 +777,7 @@
 	if (blank) { 
 		memset(black, 0, info->cmap.len * sizeof(u16));
 		cmap.red = cmap.green = cmap.blue = black;
-		if (info->cmap.transp)
-			cmap.transp = black;
+		cmap.transp = info->cmap.transp ? black : NULL;
 		cmap.start = info->cmap.start;
 		cmap.len = info->cmap.len;
 	} else
