Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVC1AZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVC1AZb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 19:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVC1AZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 19:25:31 -0500
Received: from gate.crashing.org ([63.228.1.57]:8137 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261632AbVC1AZS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 19:25:18 -0500
Subject: [PATCH] radeonfb: Fix mode setting on CRT monitors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 10:24:56 +1000
Message-Id: <1111969496.5409.40.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Current radeonfb is a bit "anal" about accepting CRT modes, it basically only
accepts modes that have the exact resolution, which tends to break with fbcon
on console switches as it provides "approximate" modes. This patch fixes it
by having the driver chose the closest possible mode instead of looking for
an exact match.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- linux-work.orig/drivers/video/aty/radeon_monitor.c	2005-03-11 16:54:25.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_monitor.c	2005-03-11 16:58:04.000000000 +1100
@@ -903,7 +903,7 @@
  */
 
 /*
- * This is used when looking for modes. We assign a "goodness" value
+ * This is used when looking for modes. We assign a "distance" value
  * to a mode in the modedb depending how "close" it is from what we
  * are looking for.
  * Currently, we don't compare that much, we could do better but
@@ -912,13 +912,11 @@
 static int radeon_compare_modes(const struct fb_var_screeninfo *var,
 				const struct fb_videomode *mode)
 {
-	int goodness = 0;
+	int distance = 0;
 
-	if (var->yres == mode->yres)
-		goodness += 10;
-	if (var->xres == mode->xres)
-		goodness += 9;
-	return goodness;
+	distance = mode->yres - var->yres;
+	distance += (mode->xres - var->xres)/2;
+	return distance;
 }
 
 /*
@@ -940,7 +938,7 @@
 	const struct fb_videomode	*db = vesa_modes;
 	int				i, dbsize = 34;
 	int				has_rmx, native_db = 0;
-	int				goodness = 0;
+	int				distance = INT_MAX;
 	const struct fb_videomode	*candidate = NULL;
 
 	/* Start with a copy of the requested mode */
@@ -976,19 +974,19 @@
 	/* Now look for a mode in the database */
 	while (db) {
 		for (i = 0; i < dbsize; i++) {
-			int g;
+			int d;
 
 			if (db[i].yres < src->yres)
 				continue;	
 			if (db[i].xres < src->xres)
 				continue;
-			g = radeon_compare_modes(src, &db[i]);
+			d = radeon_compare_modes(src, &db[i]);
 			/* If the new mode is at least as good as the previous one,
 			 * then it's our new candidate
 			 */
-			if (g >= goodness) {
+			if (d < distance) {
 				candidate = &db[i];
-				goodness = g;
+				distance = d;
 			}
 		}
 		db = NULL;

-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

