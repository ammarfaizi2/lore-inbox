Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263515AbTJWJak (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 05:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263517AbTJWJak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 05:30:40 -0400
Received: from main.gmane.org ([80.91.224.249]:63723 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263515AbTJWJa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 05:30:27 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Holger Schurig <h.schurig@mn-logistik.de>
Subject: [PATCH] frame buffer EDID always included (was [FBDEV UPDATE] Newer patch.)
Date: Thu, 23 Oct 2003 09:08:37 +0200
Message-ID: <bn7upl$agi$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2615268.VqfzN2knGY"
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2615268.VqfzN2knGY
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit

James Simmons wrote:

> This patch is a few fixes and I added back in functionality for switching
> the video mode for fbcon via fbset again.

Hi James !

I'm using Linux on an embedded device with the PXA 250 processor. Those
embedded devices (Sharp Zaurus, Compaq IPaq, M&N Ramses, whatever) usually
use an LCD display, the CPU-built-in LCD controller and some fixed LCD with
320x240 or so.

So, no one would ever use fbset to change resolutions. And no monitor would
answer EDID requests. On Linux 2.6-test I found that the framebuffer code
includes lots of display settings and the EDID query code. Does this patch
look fine to you?  Or did I miss something important for other
architectures?

--nextPart2615268.VqfzN2knGY
Content-Type: text/x-diff; name="small-nomodedb.patch"
Content-Transfer-Encoding: 8Bit
Content-Disposition: attachment; filename="small-nomodedb.patch"

>From Holger Schurig: some embedded devices don't drive a normal CRT, but an
digitally connected LCD panel. In this case, we don't need the EDID code and
no mode line database.

This disables the feature if CONFIG_PXA_FB or CONFIG_SA1100_FB is defined.

#
# Patch managed by http://www.mn-logistik.de/unsupported/pxa250/patcher
#

--- linux-2.6/drivers/video/Kconfig~small-nomodedb
+++ linux-2.6/drivers/video/Kconfig
@@ -38,6 +38,14 @@
 	  (e.g. an accelerated X server) and that are not frame buffer
 	  device-aware may cause unexpected results. If unsure, say N.
 
+config FB_MODES
+	bool
+	default y if FB && (!(FB_PXA || FB_SA1110))
+	---help---
+	  Some embedded devices don't drive a normal CRT, but an digitally
+	  connected LCD panel. In this case, we don't need the EDID code and
+	  no mode line database.
+
 config FB_CIRRUS
 	tristate "Cirrus Logic support"
 	depends on FB && (AMIGA || PCI) && BROKEN
--- linux-2.6/drivers/video/Makefile~small-nomodedb
+++ linux-2.6/drivers/video/Makefile
@@ -7,7 +7,8 @@
 obj-$(CONFIG_VT)		  += console/
 obj-$(CONFIG_LOGO)		  += logo/
 
-obj-$(CONFIG_FB)                  += fbmem.o fbmon.o fbcmap.o modedb.o softcursor.o
+obj-$(CONFIG_FB)                  += fbmem.o fbcmap.o softcursor.o
+obj-$(CONFIG_FB_MODES)              += fbmon.o modedb.o
 # Only include macmodes.o if we have FB support and are PPC
 ifeq ($(CONFIG_FB),y)
 obj-$(CONFIG_PPC)                 += macmodes.o
--- linux-2.6/drivers/video/fbmem.c~small-nomodedb
+++ linux-2.6/drivers/video/fbmem.c
@@ -385,7 +385,9 @@
 #define NUM_FB_DRIVERS	(sizeof(fb_drivers)/sizeof(*fb_drivers))
 #define FBPIXMAPSIZE	8192
 
+#ifdef CONFIG_FB_MODES
 extern const char *global_mode_option;
+#endif
 
 static initcall_t pref_init_funcs[FB_MAX];
 static int num_pref_init_funcs __initdata = 0;
@@ -1365,7 +1367,9 @@
 	 * If we get here no fb was specified.
 	 * We consider the argument to be a global video mode option.
 	 */
+#ifdef CONFIG_FB_MODES
 	global_mode_option = options;
+#endif
 	return 0;
 }
 

--nextPart2615268.VqfzN2knGY--

