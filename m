Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbUJXVlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbUJXVlz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 17:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbUJXVlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 17:41:55 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:27547 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S261594AbUJXVlw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 17:41:52 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] fbdev: Fix software blanking code
Date: Mon, 25 Oct 2004 05:48:59 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410250549.02808.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The code in fbmem.c:fb_blank() is broken.  For drivers without an fb_blank
hook, an FBIO_BLANK ioctl will produce wrong colors or will segfault.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 fbmem.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2004-10-17 15:03:25 +08:00
+++ b/drivers/video/fbmem.c	2004-10-25 05:45:24 +08:00
@@ -750,18 +750,20 @@
 	
 	if (info->fbops->fb_blank && !info->fbops->fb_blank(blank, info))
 		return 0;
+
+	cmap = info->cmap;
+
 	if (blank) { 
 		black = kmalloc(sizeof(u16) * info->cmap.len, GFP_KERNEL);
-		if (!black) {
+		if (black) {
 			memset(black, 0, info->cmap.len * sizeof(u16));
 			cmap.red = cmap.green = cmap.blue = black;
 			cmap.transp = info->cmap.transp ? black : NULL;
 			cmap.start = info->cmap.start;
 			cmap.len = info->cmap.len;
 		}
-	} else
-		cmap = info->cmap;
-
+	}
+
 	err = fb_set_cmap(&cmap, info);
 	kfree(black);
 


