Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135216AbRASRE3>; Fri, 19 Jan 2001 12:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135501AbRASREU>; Fri, 19 Jan 2001 12:04:20 -0500
Received: from wsa-245.sibintek.net ([213.128.193.245]:32481 "EHLO
	ixcelerator.com") by vger.kernel.org with ESMTP id <S135216AbRASREK>;
	Fri, 19 Jan 2001 12:04:10 -0500
Date: Fri, 19 Jan 2001 19:59:41 +0300
From: "Vladimir V. Klenov" <maple@ixcelerator.com>
To: linux-kernel@vger.kernel.org
Subject: missing check after kmalloc in drivers/video/sbus.c and not only
Message-ID: <20010119195941.A28566@ixcelerator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

kernel is 2.4.1-pre8

missing check after kmalloc in drivers/video/sbus.c, possible memory leak
in case of sbusfb_init_fb() failure, unnesesary compare (memset to area 
before).
best explanation is a patch, look:

--- drivers/video/sbusfb.c.orig	Fri Jan 19 19:14:22 2001
+++ drivers/video/sbusfb.c	Fri Jan 19 19:56:20 2001
@@ -1070,8 +1070,14 @@
 	fb->cursor.hwsize.fbx = 32;
 	fb->cursor.hwsize.fby = 32;
 	
-	if (depth > 1 && !fb->color_map)
+	if (depth > 1) {
 		fb->color_map = kmalloc(256 * 3, GFP_ATOMIC);
+		if(!fb->color_map) {
+			prom_printf("sbusfb: could not allocate memory for color map\n");
+			kfree(fb);
+			return;
+		}
+	}
 		
 	switch(fbtype) {
 #ifdef CONFIG_FB_CREATOR
@@ -1110,6 +1116,7 @@
 	}
 	
 	if (!p) {
+		kfree(fb->color_map);
 		kfree(fb);
 		return;
 	}
@@ -1147,6 +1154,7 @@
 	sbusfb_set_var(var, -1, &fb->info);
 
 	if (register_framebuffer(&fb->info) < 0) {
+		kfree(fb->color_map);
 		kfree(fb);
 		return;
 	}


					SY, Vladimir

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
