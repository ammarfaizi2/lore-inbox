Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267939AbUIJDyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267939AbUIJDyW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 23:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267999AbUIJDyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 23:54:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:38862 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S267939AbUIJDyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 23:54:20 -0400
Subject: [PATCH] ppc/ppc64: fix offb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1094788395.2578.116.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 10 Sep 2004 13:53:16 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent fbdev changes broke something quite fundamental on ppc, which
is the way offb works. It's a "fallback" driver that is to be used when
no other driver picked up the video, or when "forced" via the video=ofonly
command line option.

The recent changes completely broke that (which is a pretty important
behaviour on ppc since we still have some models regulary with video
cards that don't work properly with the kernel drivers, like some nVidias
or some older stuffs).

This patch moves offb to the end of the Makefile, so at least the behaviour
of taking over as a "fallback" is restored (the current kernel will have
offb take control of the framebuffer before any fbdev has a chance to do
it, which breaks everything).

Apparently, the entire support for "video=ofonly" was removed though,
that NEEDS to be restored in some way, though i'm not yet sure what is
the best path to that yet, I have to look more deeply at the new code.

Ben.

===== drivers/video/Makefile 1.104 vs edited =====
--- 1.104/drivers/video/Makefile	2004-09-08 16:33:07 +10:00
+++ edited/drivers/video/Makefile	2004-09-10 13:33:04 +10:00
@@ -13,7 +13,6 @@
 obj-$(CONFIG_PPC)                 += macmodes.o
 endif
 
-obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o
 obj-$(CONFIG_FB_ARMCLCD)	  += amba-clcd.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_ACORN)            += acornfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_AMIGA)            += amifb.o c2p.o
@@ -94,3 +93,4 @@
 	                             cfbimgblt.o vgastate.o
 obj-$(CONFIG_FB_VESA)             += vesafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_VIRTUAL)          += vfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
+obj-$(CONFIG_FB_OF)               += offb.o cfbfillrect.o cfbimgblt.o cfbcopyarea.o


