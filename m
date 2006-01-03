Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965113AbWACXae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbWACXae (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbWACX3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:29:54 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36504 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965101AbWACX3l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:29:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 39/41] m68k: fix macfb init
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1Etvb2-0003Pu-QE@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:29:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135379495 -0500

To be used by module_init() function should return int; same for functions
that have "return -ENODEV;" in them, actually ;-)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
(cherry picked from fc7dce1052e33568ffbdc847abf26beb7f685081 commit)

---

 drivers/video/macfb.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

cdddc53bc6ba2d45aa0fb58d429751e8e8979012
diff --git a/drivers/video/macfb.c b/drivers/video/macfb.c
index cfc748e..e6cbd9d 100644
--- a/drivers/video/macfb.c
+++ b/drivers/video/macfb.c
@@ -609,18 +609,19 @@ void __init macfb_setup(char *options)
 	}
 }
 
-void __init macfb_init(void)
+static int __init macfb_init(void)
 {
 	int video_cmap_len, video_is_nubus = 0;
 	struct nubus_dev* ndev = NULL;
 	char *option = NULL;
+	int err;
 
 	if (fb_get_options("macfb", &option))
 		return -ENODEV;
 	macfb_setup(option);
 
 	if (!MACH_IS_MAC) 
-		return;
+		return -ENODEV;
 
 	/* There can only be one internal video controller anyway so
 	   we're not too worried about this */
@@ -958,11 +959,11 @@ void __init macfb_init(void)
 
 	fb_alloc_cmap(&fb_info.cmap, video_cmap_len, 0);
 	
-	if (register_framebuffer(&fb_info) < 0)
-		return;
-
-	printk("fb%d: %s frame buffer device\n",
-	       fb_info.node, fb_info.fix.id);
+	err = register_framebuffer(&fb_info);
+	if (!err)
+		printk("fb%d: %s frame buffer device\n",
+		       fb_info.node, fb_info.fix.id);
+	return err;
 }
 
 module_init(macfb_init);
-- 
0.99.9.GIT

