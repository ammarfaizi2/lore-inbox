Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267945AbUIIWC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267945AbUIIWC0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 18:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267598AbUIIVt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:49:57 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:49054 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267393AbUIIVeM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:34:12 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 3/7] fbdev: Initialize i810fb after agpgart
Date: Fri, 10 Sep 2004 05:34:41 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409100534.41705.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch places 'video/i810/' after 'char/' in drivers/Makefile.  This
order change makes it unnecessary for i810fb to explicitly call
agp_intel_init().  This is untested, as I don't have any i810 hardware
anymore, but I believe it will work.  If it does, the ugly 'early
initialization hack' in drivers/char/agp/intel-agp.c:agp_intel_init() can be
removed (haven't done it yet).

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 Makefile               |    4 ++++
 video/Makefile         |    5 ++---
 video/i810/i810_main.c |    5 -----
 3 files changed, 6 insertions(+), 8 deletions(-)

diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/Makefile linux-2.6.9-rc1-mm4/drivers/Makefile
--- linux-2.6.9-rc1-mm4-orig/drivers/Makefile	2004-09-07 21:25:43.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/Makefile	2004-09-07 21:39:14.292973224 +0800
@@ -16,6 +16,10 @@ obj-$(CONFIG_PNP)		+= pnp/
 # char/ comes before serial/ etc so that the VT console is the boot-time
 # default.
 obj-y				+= char/
+
+# i810fb depends on char/agp/
+obj-$(CONFIG_FB_I810)           += video/i810/
+
 # we also need input/serio early so serio bus is initialized by the time
 # serial drivers start registering their serio ports
 obj-$(CONFIG_SERIO)		+= input/serio/
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/i810/i810_main.c linux-2.6.9-rc1-mm4/drivers/video/i810/i810_main.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/i810/i810_main.c	2004-09-07 21:18:34.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/i810/i810_main.c	2004-09-07 21:45:07.644255664 +0800
@@ -1991,11 +1991,6 @@ int __init i810fb_init(void)
 {
 	i810fb_setup(fb_get_options("i810fb"));
 
-	if (agp_intel_init()) {
-		printk("i810fb_init: cannot initialize intel agpgart\n");
-		return -ENODEV;
-	}
-
 	if (pci_register_driver(&i810fb_driver) > 0)
 		return 0;
 	pci_unregister_driver(&i810fb_driver);
diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/Makefile linux-2.6.9-rc1-mm4/drivers/video/Makefile
--- linux-2.6.9-rc1-mm4-orig/drivers/video/Makefile	2004-09-07 21:18:34.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/Makefile	2004-09-07 21:39:11.383415544 +0800
@@ -62,9 +62,8 @@ obj-$(CONFIG_FB_SIS)		  += sis/ cfbcopya
 obj-$(CONFIG_FB_ATY)		  += aty/ cfbcopyarea.o cfbfillrect.o cfbimgblt.o
 obj-$(CONFIG_FB_ATY128)		  += aty/ cfbcopyarea.o cfbfillrect.o cfbimgblt.o
 obj-$(CONFIG_FB_RADEON)		  += aty/ cfbcopyarea.o cfbfillrect.o cfbimgblt.o
-obj-$(CONFIG_FB_I810)             += i810/ cfbfillrect.o cfbcopyarea.o \
-	                             cfbimgblt.o vgastate.o
-
+obj-$(CONFIG_FB_I810)             += cfbcopyarea.o cfbfillrect.o cfbimgblt.o \
+				     vgastate.o
 obj-$(CONFIG_FB_SUN3)             += sun3fb.o
 obj-$(CONFIG_FB_HGA)              += hgafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_SA1100)           += sa1100fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 


