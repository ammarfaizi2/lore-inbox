Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264743AbSJ3QzY>; Wed, 30 Oct 2002 11:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264746AbSJ3QzY>; Wed, 30 Oct 2002 11:55:24 -0500
Received: from skunk.directfb.org ([212.84.236.169]:37568 "EHLO
	skunk.directfb.org") by vger.kernel.org with ESMTP
	id <S264743AbSJ3QzQ>; Wed, 30 Oct 2002 11:55:16 -0500
Date: Wed, 30 Oct 2002 18:01:35 +0100
From: Denis Oliver Kropp <dok@directfb.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.44 - neofb-0.4 (sorry, wrong attachment)
Message-ID: <20021030170135.GA29486@skunk.convergence.de>
Reply-To: Denis Oliver Kropp <dok@directfb.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline


I'm sorry, the last mail had the wrong attachment.


Changes:

- Toshiba Libretto support
- allow modes larger than LCD size if LCD is disabled
- keep BIOS settings if internal/external display haven't been enabled explicitly

  (all changes by Thomas J. Moore <dark@mama.indstate.edu>)


-- 
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

                            Convergence GmbH

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="linux-2.5.44-neofb-0.4.patch"

diff -Naur linux-2.5.44/drivers/char/toshiba.c linux-2.5.44-neofb-0.4/drivers/char/toshiba.c
--- linux-2.5.44/drivers/char/toshiba.c	2002-10-19 06:02:31.000000000 +0200
+++ linux-2.5.44-neofb-0.4/drivers/char/toshiba.c	2002-10-30 17:03:24.000000000 +0100
@@ -210,7 +210,7 @@
 /*
  * Put the laptop into System Management Mode
  */
-static int tosh_smm(SMMRegisters *regs)
+int tosh_smm(SMMRegisters *regs)
 {
 	int eax;
 
diff -Naur linux-2.5.44/drivers/video/neofb.c linux-2.5.44-neofb-0.4/drivers/video/neofb.c
--- linux-2.5.44/drivers/video/neofb.c	2002-10-19 06:02:00.000000000 +0200
+++ linux-2.5.44-neofb-0.4/drivers/video/neofb.c	2002-10-30 18:00:00.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/video/neofb.c -- NeoMagic Framebuffer Driver
  *
- * Copyright (c) 2001  Denis Oliver Kropp <dok@convergence.de>
+ * Copyright (c) 2001-2002  Denis Oliver Kropp <dok@directfb.org>
  *
  *
  * Card specific code is based on XFree86's neomagic driver.
@@ -11,6 +11,13 @@
  * Public License.  See the file COPYING in the main directory of this
  * archive for more details.
  *
+ *
+ * 0.4
+ *  - Toshiba Libretto support, allow modes larger than LCD size if
+ *    LCD is disabled, keep BIOS settings if internal/external display
+ *    haven't been enabled explicitly
+ *                          (Thomas J. Moore <dark@mama.indstate.edu>)
+ *
  * 0.3.3
  *  - Porting over to new fbdev api. (jsimmons)
  *  
@@ -56,6 +63,10 @@
 #include <linux/fb.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#ifdef CONFIG_TOSHIBA
+#include <linux/toshiba.h>
+extern int tosh_smm(SMMRegisters *regs);
+#endif
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -70,7 +81,7 @@
 #include <video/fbcon.h>
 #include <video/neomagic.h>
 
-#define NEOFB_VERSION "0.3.3"
+#define NEOFB_VERSION "0.4"
 
 struct neofb_par default_par;
 
@@ -79,6 +90,7 @@
 static int disabled = 0;
 static int internal = 0;
 static int external = 0;
+static int libretto = 0;
 static int nostretch = 0;
 static int nopciburst = 0;
 
@@ -94,6 +106,8 @@
 MODULE_PARM_DESC(internal, "Enable output on internal LCD Display.");
 MODULE_PARM(external, "i");
 MODULE_PARM_DESC(external, "Enable output on external CRT.");
+MODULE_PARM(libretto, "i");
+MODULE_PARM_DESC(libretto, "Force Libretto 100/110 800x480 LCD.");
 MODULE_PARM(nostretch, "i");
 MODULE_PARM_DESC(nostretch,
 		 "Disable stretching of modes smaller than LCD.");
@@ -551,8 +565,9 @@
 	timings.sync = var->sync;
 
 	/* Is the mode larger than the LCD panel? */
-	if ((var->xres > par->NeoPanelWidth) ||
-	    (var->yres > par->NeoPanelHeight)) {
+	if (par->internal_display &&
+            ((var->xres > par->NeoPanelWidth) ||
+	     (var->yres > par->NeoPanelHeight))) {
 		printk(KERN_INFO
 		       "Mode (%dx%d) larger than the LCD panel (%dx%d)\n",
 		       var->xres, var->yres, par->NeoPanelWidth,
@@ -561,23 +576,27 @@
 	}
 
 	/* Is the mode one of the acceptable sizes? */
-	switch (var->xres) {
-	case 1280:
-		if (var->yres == 1024)
-			mode_ok = 1;
-		break;
-	case 1024:
-		if (var->yres == 768)
-			mode_ok = 1;
-		break;
-	case 800:
-		if (var->yres == 600)
-			mode_ok = 1;
-		break;
-	case 640:
-		if (var->yres == 480)
-			mode_ok = 1;
-		break;
+	if (!par->internal_display)
+		mode_ok = 1;
+	else {
+		switch (var->xres) {
+		case 1280:
+			if (var->yres == 1024)
+				mode_ok = 1;
+			break;
+		case 1024:
+			if (var->yres == 768)
+				mode_ok = 1;
+			break;
+		case 800:
+			if (var->yres == (par->libretto ? 480 : 600))
+				mode_ok = 1;
+			break;
+		case 640:
+			if (var->yres == 480)
+				mode_ok = 1;
+			break;
+		}
 	}
 
 	if (!mode_ok) {
@@ -1261,6 +1280,17 @@
 
 	switch (blank) {
 	case 4:		/* powerdown - both sync lines down */
+#ifdef CONFIG_TOSHIBA
+		/* attempt to turn off backlight on toshiba; also turns off external */
+		{
+			SMMRegisters regs;
+
+			regs.eax = 0xff00; /* HCI_SET */
+			regs.ebx = 0x0002; /* HCI_BACKLIGHT */
+			regs.ecx = 0x0000; /* HCI_DISABLE */
+			tosh_smm(&regs);
+		}
+#endif
 		break;
 	case 3:		/* hsync off */
 		break;
@@ -1269,6 +1299,17 @@
 	case 1:		/* just software blanking of screen */
 		break;
 	default:		/* case 0, or anything else: unblank */
+#ifdef CONFIG_TOSHIBA
+		/* attempt to re-enable backlight/external on toshiba */
+		{
+			SMMRegisters regs;
+
+			regs.eax = 0xff00; /* HCI_SET */
+			regs.ebx = 0x0002; /* HCI_BACKLIGHT */
+			regs.ecx = 0x0001; /* HCI_ENABLE */
+			tosh_smm(&regs);
+		}
+#endif
 		break;
 	}
 	return 0;
@@ -1437,6 +1478,24 @@
 	vmode:		FB_VMODE_NONINTERLACED
 };
 
+static struct fb_var_screeninfo __devinitdata neofb_var800x480x8 = {
+	accel_flags:    FB_ACCELF_TEXT,
+	xres:           800,
+	yres:           480,
+	xres_virtual:   800,
+	yres_virtual:   30000,
+	bits_per_pixel: 8,
+	pixclock:       25000,
+	left_margin:    88,
+	right_margin:   40,
+	upper_margin:   23,
+	lower_margin:   1,
+	hsync_len:      128,
+	vsync_len:      4,
+	sync:           FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	vmode:          FB_VMODE_NONINTERLACED
+};
+
 static struct fb_var_screeninfo __devinitdata neofb_var1024x768x8 = {
 	accel_flags:	FB_ACCELF_TEXT,
 	xres:		1024,
@@ -1609,6 +1668,13 @@
 	VGAwGR(0x09, 0x26);
 	type = VGArGR(0x21);
 	display = VGArGR(0x20);
+	if (!par->internal_display && !par->external_display) {
+		par->internal_display = display & 2 || !(display & 3) ? 1 : 0;
+		par->external_display = display & 1;
+		printk (KERN_INFO "Autodetected %s display\n",
+			par->internal_display && par->external_display ? "simultaneous" :
+			par->internal_display ? "internal" : "external");
+	}
 
 	/* Determine panel width -- used in NeoValidMode. */
 	w = VGArGR(0x20);
@@ -1621,8 +1687,8 @@
 		break;
 	case 0x01:
 		par->NeoPanelWidth = 800;
-		par->NeoPanelHeight = 600;
-		neofb_var = &neofb_var800x600x8;
+		par->NeoPanelHeight = par->libretto ? 480 : 600;
+		neofb_var = par->libretto ? &neofb_var800x480x8 : &neofb_var800x600x8;
 		break;
 	case 0x02:
 		par->NeoPanelWidth = 1024;
@@ -1638,7 +1704,7 @@
 		break;
 #else
 		printk(KERN_ERR
-		       "neofb: Only 640x480, 800x600 and 1024x768 panels are currently supported\n");
+		       "neofb: Only 640x480, 800x600/480 and 1024x768 panels are currently supported\n");
 		return -1;
 #endif
 	default:
@@ -1766,14 +1832,10 @@
 
 	par->pci_burst = !nopciburst;
 	par->lcd_stretch = !nostretch;
+	par->libretto = libretto;
 
-	if (!internal && !external) {
-		par->internal_display = 1;
-		par->external_display = 0;
-	} else {
-		par->internal_display = internal;
-		par->external_display = external;
-	}
+	par->internal_display = internal;
+	par->external_display = external;
 
 	switch (info->fix.accel) {
 	case FB_ACCEL_NEOMAGIC_NM2070:
@@ -2036,6 +2098,8 @@
 			nostretch = 1;
 		if (!strncmp(this_opt, "nopciburst", 10))
 			nopciburst = 1;
+		if (!strncmp(this_opt, "libretto", 8))
+			libretto = 1;
 	}
 
 	return 0;
diff -Naur linux-2.5.44/include/video/neomagic.h linux-2.5.44-neofb-0.4/include/video/neomagic.h
--- linux-2.5.44/include/video/neomagic.h	2002-10-19 06:01:48.000000000 +0200
+++ linux-2.5.44-neofb-0.4/include/video/neomagic.h	2002-10-30 17:50:44.000000000 +0100
@@ -176,6 +176,7 @@
   int lcd_stretch;
   int internal_display;
   int external_display;
+  int libretto;
 };
 
 typedef struct {

--oyUTqETQ0mS9luUI--
