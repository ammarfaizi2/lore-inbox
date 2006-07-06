Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbWGFAVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbWGFAVI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 20:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbWGFAVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 20:21:08 -0400
Received: from aun.it.uu.se ([130.238.12.36]:16018 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S965088AbWGFAVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 20:21:06 -0400
Date: Thu, 6 Jul 2006 02:20:53 +0200 (MEST)
Message-Id: <200607060020.k660Krv1009111@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: davem@davemloft.net
Subject: [PATCH 2.6.17 sparc64] 32-bit compat for Mach64 framebuffer
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To: davem@davemloft.net
Subject: [PATCH 2.6.17 sparc64] 32-bit compat for Mach64 framebuffer
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

In recent sparc64 kernels, starting a 32-bit mode X server on
a machine with a Mach64 framebuffer (CONFIG_FB_ATY_CT=y) like
an Ultra5, results in the kernel complaining:

ioctl32(X:1977): Unknown cmd fd(6) cmd(40584606){00} arg(ef8dd6d8) on /dev/fb0
ioctl32(X:1977): Unknown cmd fd(6) cmd(40184600){00} arg(ef8dd6e0) on /dev/fb0

That's FBIOGTYPE and FBIOGATTR. These errors occur because
kernel 2.6.15-rc2 changed the way sparc64 handles SPARC-specific
framebuffer ioctls from 32-bit processes: before 2.6.15-rc2
arch/sparc64/kernel/ioctl32.c handled them for all devices,
but 2.6.15-rc2 dropped that support and changed SPARC-only
framebuffer drivers like ffb.c to set up ->compat_ioctl methods
pointing to sbusfb_compat_ioctl in drivers/video/sbuslib.c.
However, drivers for framebuffers like the Mach64 that can exist
on both SPARCs and non-SPARCs were not adjusted, so in sparc64
kernels SPARC-specific framebuffer ioctls on Mach64 devices are
no longer accepted from 32-bit mode processes. Hence the errors.

The fix is to make atyfb_base.c set up a ->compat_ioctl pointing
to sbusfb_compat_ioctl when running in a sparc64 kernel with
compatibility for sparc32 user-space, and to compile and link
sbuslib.o with the frambuffer driver.

A complication is that sbuslib.c doesn't compile on non-SPARC
machines, so we must be careful to only enable it in the case
described above. That's why the patch puts an ugly "if" statement
in the Makefile.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

--- linux-2.6.17/drivers/video/Makefile.~1~	2006-07-05 21:47:50.000000000 +0200
+++ linux-2.6.17/drivers/video/Makefile	2006-07-05 22:19:00.000000000 +0200
@@ -32,6 +32,9 @@ obj-$(CONFIG_FB_MATROX)		  += matrox/
 obj-$(CONFIG_FB_RIVA)		  += riva/ vgastate.o
 obj-$(CONFIG_FB_NVIDIA)		  += nvidia/
 obj-$(CONFIG_FB_ATY)		  += aty/ macmodes.o
+ifeq ($(CONFIG_SPARC64)-$(CONFIG_COMPAT),y-y)
+  obj-$(CONFIG_FB_ATY)		  += sbuslib.o
+endif
 obj-$(CONFIG_FB_ATY128)		  += aty/ macmodes.o
 obj-$(CONFIG_FB_RADEON)		  += aty/
 obj-$(CONFIG_FB_SIS)		  += sis/
--- linux-2.6.17/drivers/video/aty/atyfb_base.c.~1~	2006-07-05 21:47:50.000000000 +0200
+++ linux-2.6.17/drivers/video/aty/atyfb_base.c	2006-07-05 22:26:04.000000000 +0200
@@ -82,6 +82,9 @@
 #ifdef __sparc__
 #include <asm/pbm.h>
 #include <asm/fbio.h>
+#if defined(CONFIG_SPARC64) && defined(CONFIG_COMPAT)
+#include "../sbuslib.h"
+#endif
 #endif
 
 #ifdef CONFIG_ADB_PMU
@@ -298,6 +301,9 @@ static struct fb_ops atyfb_ops = {
 	.fb_pan_display	= atyfb_pan_display,
 	.fb_blank	= atyfb_blank,
 	.fb_ioctl	= atyfb_ioctl,
+#if defined(CONFIG_SPARC64) && defined(CONFIG_COMPAT)
+	.fb_compat_ioctl = sbusfb_compat_ioctl,
+#endif
 	.fb_fillrect	= atyfb_fillrect,
 	.fb_copyarea	= atyfb_copyarea,
 	.fb_imageblit	= atyfb_imageblit,
