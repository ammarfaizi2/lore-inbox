Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031622AbWLEVeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031622AbWLEVeT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031627AbWLEVeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:34:19 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45864 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031622AbWLEVeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:34:18 -0500
Date: Tue, 5 Dec 2006 21:34:16 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Yu Luming <luming.yu@gmail.com>,
       Miguel Ojeda Sandonis <maxextreme@gmail.com>
Subject: Re: -mm merge plans for 2.6.20
In-Reply-To: <20061205122057.c2b617f4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612052131410.14114@pentafluge.infradead.org>
References: <20061204204024.2401148d.akpm@osdl.org>
 <Pine.LNX.4.64.0612051538280.15711@pentafluge.infradead.org>
 <20061205100140.24888a96.akpm@osdl.org> <Pine.LNX.4.64.0612051822140.7917@pentafluge.infradead.org>
 <20061205114310.e85d4c7e.akpm@osdl.org> <Pine.LNX.4.64.0612051946280.14114@pentafluge.infradead.org>
 <20061205122057.c2b617f4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Ug. Kconfig in drivers/video has all the above drivers enable the 
> > backlight only if PMAC_BACKLIGHT is set.
> 
> erp, I grepped for CONFIG_foo and not foo.  Again.
> 
> > The problem is backlight
> > is after the framebuffer. We should move the backlight menu before
> > the framebuffer configuration.
> 
> OK.  Can you do a patch sometime please?

Here you go. This patch places the backlight before the framebuffers. You
will now be able to select using the backlight with various framebuffer 
drivers.

Signed-off:	James Simmons <jsimmons@infradead.org>

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 7a43020..40f6bea 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -4,20 +4,9 @@
 
 menu "Graphics support"
 
-config FIRMWARE_EDID
-       bool "Enable firmware EDID"
-       default y
-       ---help---
-         This enables access to the EDID transferred from the firmware.
-	 On the i386, this is from the Video BIOS. Enable this if DDC/I2C
-	 transfers do not work for your driver and if you are using
-	 nvidiafb, i810fb or savagefb.
-
-	 In general, choosing Y for this option is safe.  If you
-	 experience extremely long delays while booting before you get
-	 something on your display, try setting this to N.  Matrox cards in
-	 combination with certain motherboards and monitors are known to
-	 suffer from this problem.
+if SYSFS
+	source "drivers/video/backlight/Kconfig"
+endif
 
 config FB
 	tristate "Support for frame buffer devices"
@@ -53,6 +42,22 @@ config FB
 	  (e.g. an accelerated X server) and that are not frame buffer
 	  device-aware may cause unexpected results. If unsure, say N.
 
+config FIRMWARE_EDID
+       bool "Enable firmware EDID"
+       depends on FB
+       default n 
+       ---help---
+         This enables access to the EDID transferred from the firmware.
+	 On the i386, this is from the Video BIOS. Enable this if DDC/I2C
+	 transfers do not work for your driver and if you are using
+	 nvidiafb, i810fb or savagefb.
+
+	 In general, choosing Y for this option is safe.  If you
+	 experience extremely long delays while booting before you get
+	 something on your display, try setting this to N.  Matrox cards in
+	 combination with certain motherboards and monitors are known to
+	 suffer from this problem.
+
 config FB_DDC
        tristate
        depends on FB && I2C && I2C_ALGOBIT
@@ -90,13 +95,6 @@ config FB_MACMODES
        depends on FB
        default n
 
-config FB_BACKLIGHT
-	bool
-	depends on FB
-	select BACKLIGHT_LCD_SUPPORT
-	select BACKLIGHT_CLASS_DEVICE
-	default n
-
 config FB_MODE_HELPERS
         bool "Enable Video Mode Handling Helpers"
         depends on FB
@@ -126,6 +124,9 @@ config FB_TILEBLITTING
 	 This is particularly important to one driver, matroxfb.  If
 	 unsure, say N.
 
+comment "Frambuffer hardware drivers"
+	depends on FB
+
 config FB_CIRRUS
 	tristate "Cirrus Logic support"
 	depends on FB && (ZORRO || PCI)
@@ -728,8 +729,7 @@ config FB_NVIDIA_I2C
 
 config FB_NVIDIA_BACKLIGHT
 	bool "Support for backlight control"
-	depends on FB_NVIDIA && PMAC_BACKLIGHT
-	select FB_BACKLIGHT
+	depends on FB_NVIDIA && BACKLIGHT_CLASS_DEVICE
 	default y
 	help
 	  Say Y here if you want to control the backlight of your display.
@@ -775,8 +775,7 @@ config FB_RIVA_DEBUG
 
 config FB_RIVA_BACKLIGHT
 	bool "Support for backlight control"
-	depends on FB_RIVA && PMAC_BACKLIGHT
-	select FB_BACKLIGHT
+	depends on FB_RIVA && BACKLIGHT_CLASS_DEVICE
 	default y
 	help
 	  Say Y here if you want to control the backlight of your display.
@@ -1049,8 +1048,7 @@ config FB_RADEON_I2C
 
 config FB_RADEON_BACKLIGHT
 	bool "Support for backlight control"
-	depends on FB_RADEON && PMAC_BACKLIGHT
-	select FB_BACKLIGHT
+	depends on FB_RADEON && BACKLIGHT_CLASS_DEVICE 
 	default y
 	help
 	  Say Y here if you want to control the backlight of your display.
@@ -1081,8 +1079,7 @@ config FB_ATY128
 
 config FB_ATY128_BACKLIGHT
 	bool "Support for backlight control"
-	depends on FB_ATY128 && PMAC_BACKLIGHT
-	select FB_BACKLIGHT
+	depends on FB_ATY128 && BACKLIGHT_CLASS_DEVICE 
 	default y
 	help
 	  Say Y here if you want to control the backlight of your display.
@@ -1131,8 +1128,7 @@ config FB_ATY_GX
 
 config FB_ATY_BACKLIGHT
 	bool "Support for backlight control"
-	depends on FB_ATY && PMAC_BACKLIGHT
-	select FB_BACKLIGHT
+	depends on FB_ATY && BACKLIGHT_CLASS_DEVICE 
 	default y
 	help
 	  Say Y here if you want to control the backlight of your display.
@@ -1632,6 +1628,7 @@ config FB_VIRTUAL
 	  the vfb_enable=1 option.
 
 	  If unsure, say N.
+
 if VT
 	source "drivers/video/console/Kconfig"
 endif
@@ -1640,9 +1637,5 @@ if FB || SGI_NEWPORT_CONSOLE
 	source "drivers/video/logo/Kconfig"
 endif
 
-if SYSFS
-	source "drivers/video/backlight/Kconfig"
-endif
-
 endmenu
 
 
