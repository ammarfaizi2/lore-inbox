Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbUKXRZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbUKXRZp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbUKXRZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:25:18 -0500
Received: from smtp-out.hotpop.com ([38.113.3.61]:48086 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S262722AbUKXRQH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:16:07 -0500
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] fbdev: Fix crash if fb_set_var() called before register_framebuffer()
Date: Thu, 25 Nov 2004 01:15:50 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411250115.50895.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The field info->modelist is initialized during register_framebuffer.  This
field is also referred to in fb_set_var().  Thus a call to fb_set_var()
before register_framebuffer() will cause a crash.  A few drivers do this,
notably controlfb.  (This might fix reports of controlfb crashing in
powermacs).

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbmem.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2004-11-23 21:20:13 +08:00
+++ b/drivers/video/fbmem.c	2004-11-25 01:09:22 +08:00
@@ -725,7 +725,10 @@
 			fb_set_cmap(&info->cmap, info);
 
 			fb_var_to_videomode(&mode, &info->var);
-			fb_add_videomode(&mode, &info->modelist);
+
+			if (info->modelist.prev && info->modelist.next &&
+			    !list_empty(&info->modelist))
+				fb_add_videomode(&mode, &info->modelist);
 
 			if (info->flags & FBINFO_MISC_MODECHANGEUSER) {
 				struct fb_event event;




