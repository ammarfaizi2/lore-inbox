Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269007AbUICOZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269007AbUICOZb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 10:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269003AbUICOZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 10:25:29 -0400
Received: from ms002msg.fastwebnet.it ([213.140.2.52]:21909 "EHLO
	ms002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S268989AbUICOZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 10:25:04 -0400
From: Paolo Ornati <ornati@fastwebnet.it>
Subject: [PATCH] tdfxfb linkage fix v2.0 (the previous one is broken)
Date: Fri, 3 Sep 2004 16:27:28 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409031627.28190.ornati@fastwebnet.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch I've sent to fix tdfx frame buffer linkage is broken because it
can leads to linking errors like this one:

  LD      drivers/video/built-in.o
drivers/video/tdfxfb_lib.o(.text+0x13e0): In function `cfb_copyarea':
: multiple definition of `cfb_copyarea'
drivers/video/cfbcopyarea.o(.text+0x6e0): first defined here
drivers/video/tdfxfb_lib.o(.text+0x7c0): In function `bitfill32_rev':
: multiple definition of `bitfill32_rev'
drivers/video/cfbfillrect.o(.text+0x200): first defined here
drivers/video/tdfxfb_lib.o(.text+0x690): In function `bitfill':
: multiple definition of `bitfill'
drivers/video/cfbfillrect.o(.text+0xd0): first defined here
drivers/video/tdfxfb_lib.o(.text+0x8b0): In function `bitfill_rev':
: multiple definition of `bitfill_rev'
drivers/video/cfbfillrect.o(.text+0x2f0): first defined here
drivers/video/tdfxfb_lib.o(.text+0x5c0): In function `bitfill32':
: multiple definition of `bitfill32'
drivers/video/cfbfillrect.o(.text+0x0): first defined here
drivers/video/tdfxfb_lib.o(.text+0x0): In function `cfb_imageblit':
: multiple definition of `cfb_imageblit'
drivers/video/cfbimgblt.o(.text+0x0): first defined here
drivers/video/tdfxfb_lib.o(.text+0x9f0): In function `cfb_fillrect':
: multiple definition of `cfb_fillrect'
drivers/video/cfbfillrect.o(.text+0x430): first defined here
make[1]: *** [drivers/video/built-in.o] Error 1
make: *** [drivers/video/] Error 2


This patch really fixes tdfxfb linkage, please apply:

--- linux-mm/drivers/video/Makefile.orig	2004-09-03 15:25:08.527030328 +0200
+++ linux-mm/drivers/video/Makefile	2004-09-03 15:26:57.106523736 +0200
@@ -34,10 +34,9 @@ obj-$(CONFIG_FB_CYBER)            += cyb
 obj-$(CONFIG_FB_CYBER2000)        += cyber2000fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_GBE)              += gbefb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_SGIVW)            += sgivwfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_3DFX)             += tdfxfb.o tdfxfb_lib.o
-tdfxfb_lib-y                      := cfbimgblt.o
+obj-$(CONFIG_FB_3DFX)             += tdfxfb.o cfbimgblt.o
 ifneq ($(CONFIG_FB_3DFX_ACCEL),y)
-tdfxfb_lib-y                      += cfbfillrect.o cfbcopyarea.o
+obj-$(CONFIG_FB_3DFX)             += cfbfillrect.o cfbcopyarea.o
 endif
 obj-$(CONFIG_FB_MAC)              += macfb.o macmodes.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_HP300)            += hpfb.o cfbfillrect.o cfbimgblt.o


-- 
	Paolo Ornati
	Gentoo Linux (kernel 2.6.8-gentoo-r3)
