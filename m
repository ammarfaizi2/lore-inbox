Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263636AbUDMXyG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 19:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263814AbUDMXyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 19:54:06 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:14087 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S263636AbUDMXyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 19:54:02 -0400
From: "Art Haas" <ahaas@airmail.net>
Date: Tue, 13 Apr 2004 17:33:02 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove variable-sized stack in drivers/char/fbmem.c
Message-ID: <20040413223302.GF23640@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch replaces the variably sized stack with a kmalloc()
invocation. A brief search around the code suggests that memory
allocation as this function was doing is unusual.

Art Haas

===== drivers/video/fbmem.c 1.96 vs edited =====
--- 1.96/drivers/video/fbmem.c	Mon Apr 12 12:55:32 2004
+++ edited/drivers/video/fbmem.c	Tue Apr 13 16:53:38 2004
@@ -980,21 +980,29 @@
 int
 fb_blank(struct fb_info *info, int blank)
 {	
-	/* ??? Variable sized stack allocation.  */
-	u16 black[info->cmap.len];
+	int res;
+	size_t size;
+	u16 * black = NULL;
 	struct fb_cmap cmap;
 	
 	if (info->fbops->fb_blank && !info->fbops->fb_blank(blank, info))
 		return 0;
 	if (blank) { 
-		memset(black, 0, info->cmap.len * sizeof(u16));
+		size = info->cmap.len * sizeof(*black);
+		black = kmalloc(size, GFP_KERNEL);
+		if (!black)
+			return -ENOMEM;
+		memset(black, 0, size);
 		cmap.red = cmap.green = cmap.blue = black;
 		cmap.transp = info->cmap.transp ? black : NULL;
 		cmap.start = info->cmap.start;
 		cmap.len = info->cmap.len;
 	} else
 		cmap = info->cmap;
-	return fb_set_cmap(&cmap, 1, info);
+	res = fb_set_cmap(&cmap, 1, info);
+	if (black)
+		kfree(black);
+	return res;
 }
 
 static int 
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
