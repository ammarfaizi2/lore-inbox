Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264758AbSJ3QuI>; Wed, 30 Oct 2002 11:50:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264760AbSJ3QuI>; Wed, 30 Oct 2002 11:50:08 -0500
Received: from skunk.directfb.org ([212.84.236.169]:30144 "EHLO
	skunk.directfb.org") by vger.kernel.org with ESMTP
	id <S264758AbSJ3QuD>; Wed, 30 Oct 2002 11:50:03 -0500
Date: Wed, 30 Oct 2002 17:56:21 +0100
From: Denis Oliver Kropp <dok@directfb.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.44 - neofb-0.4
Message-ID: <20021030165621.GA28352@skunk.convergence.de>
Reply-To: Denis Oliver Kropp <dok@directfb.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline


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

--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="linux-2.4.20-rc1-neofb-0.4.patch"

diff -Naur linux-2.4.20-rc1/drivers/char/toshiba.c linux-2.4.20-rc1-neofb-0.4/drivers/char/toshiba.c
--- linux-2.4.20-rc1/drivers/char/toshiba.c	2002-10-30 15:21:32.000000000 +0100
+++ linux-2.4.20-rc1-neofb-0.4/drivers/char/toshiba.c	2002-10-30 15:45:15.000000000 +0100
@@ -217,7 +217,7 @@
 /*
  * Put the laptop into System Management Mode
  */
-static int tosh_smm(SMMRegisters *regs)
+int tosh_smm(SMMRegisters *regs)
 {
 	int eax;
 
diff -Naur linux-2.4.20-rc1/drivers/video/neofb.c linux-2.4.20-rc1-neofb-0.4/drivers/video/neofb.c
--- linux-2.4.20-rc1/drivers/video/neofb.c	2002-10-30 15:20:39.000000000 +0100
+++ linux-2.4.20-rc1-neofb-0.4/drivers/video/neofb.c	2002-10-30 15:49:30.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/video/neofb.c -- NeoMagic Framebuffer Driver
  *
- * Copyright (c) 2001  Denis Oliver Kropp <dok@convergence.de>
+ * Copyright (c) 2001-2002  Denis Oliver Kropp <dok@directfb.org>
  *
  *
  * Card specific code is based on XFree86's neomagic driver.
@@ -12,6 +12,12 @@
  * archive for more details.
  *
  *
+ * 0.4
+ *  - Toshiba Libretto support, allow modes larger than LCD size if
+ *    LCD is disabled, keep BIOS settings if internal/external display
+ *    haven't been enabled explicitly
+ *                          (Thomas J. Moore <dark@mama.indstate.edu>)
+ *
  * 0.3.2
  *  - got rid of all floating point (dok)
  *
@@ -54,6 +60,10 @@
 #include <linux/fb.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#ifdef CONFIG_TOSHIBA
+#include <linux/toshiba.h>
+extern int tosh_smm(SMMRegisters *regs);
+#endif
 
 #include <asm/io.h>
 #include <asm/irq.h>
@@ -74,13 +84,14 @@
 #include "neofb.h"
 
 
-#define NEOFB_VERSION "0.3.2"
+#define NEOFB_VERSION "0.4"
 
 /* --------------------------------------------------------------------- */
 
 static int disabled   = 0;
 static int internal   = 0;
 static int external   = 0;
+static int libretto   = 0;
 static int nostretch  = 0;
 static int nopciburst = 0;
 
@@ -96,6 +107,8 @@
 MODULE_PARM_DESC(internal, "Enable output on internal LCD Display.");
 MODULE_PARM(external, "i");
 MODULE_PARM_DESC(external, "Enable output on external CRT.");
+MODULE_PARM(libretto, "i");
+MODULE_PARM_DESC(libretto, "Force Libretto 100/110 800x480 LCD.");
 MODULE_PARM(nostretch, "i");
 MODULE_PARM_DESC(nostretch, "Disable stretching of modes smaller than LCD.");
 MODULE_PARM(nopciburst, "i");
@@ -1074,7 +1087,8 @@
     return -EINVAL;
 
   /* Is the mode larger than the LCD panel? */
-  if ((var->xres > info->NeoPanelWidth) ||
+  if (info->internal_display &&
+      (var->xres > info->NeoPanelWidth) ||
       (var->yres > info->NeoPanelHeight))
     {
       printk (KERN_INFO "Mode (%dx%d) larger than the LCD panel (%dx%d)\n",
@@ -1086,7 +1100,9 @@
     }
 
   /* Is the mode one of the acceptable sizes? */
-  switch (var->xres)
+  if(!info->internal_display)
+     mode_ok = 1;
+  else switch (var->xres)
     {
     case 1280:
       if (var->yres == 1024)
@@ -1097,7 +1113,7 @@
 	mode_ok = 1;
       break;
     case  800:
-      if (var->yres == 600)
+      if (var->yres == (libretto ? 480 : 600))
 	mode_ok = 1;
       break;
     case  640:
@@ -1695,6 +1711,17 @@
   switch (blank)
     {
     case 4:	/* powerdown - both sync lines down */
+#ifdef CONFIG_TOSHIBA
+       /* attempt to turn off backlight on toshiba; also turns off external */
+      {
+	 SMMRegisters regs;
+
+	 regs.eax = 0xff00; /* HCI_SET */
+	 regs.ebx = 0x0002; /* HCI_BACKLIGHT */
+	 regs.ecx = 0x0000; /* HCI_DISABLE */
+	 tosh_smm(&regs);
+      }
+#endif
       break;	
     case 3:	/* hsync off */
       break;	
@@ -1703,6 +1730,17 @@
     case 1:	/* just software blanking of screen */
       break;
     default: /* case 0, or anything else: unblank */
+#ifdef CONFIG_TOSHIBA
+       /* attempt to re-enable backlight/external on toshiba */
+      {
+	 SMMRegisters regs;
+
+	 regs.eax = 0xff00; /* HCI_SET */
+	 regs.ebx = 0x0002; /* HCI_BACKLIGHT */
+	 regs.ecx = 0x0001; /* HCI_ENABLE */
+	 tosh_smm(&regs);
+      }
+#endif
       break;
     }
 }
@@ -1782,6 +1820,24 @@
 	vmode:		FB_VMODE_NONINTERLACED
 };
 
+static struct fb_var_screeninfo __devinitdata neofb_var800x480x8 = {
+	accel_flags:	FB_ACCELF_TEXT,
+	xres:		800,
+	yres:		480,
+	xres_virtual:   800,
+	yres_virtual:   30000,
+	bits_per_pixel: 8,
+	pixclock:	25000,
+	left_margin:	88,
+	right_margin:	40,
+	upper_margin:	23,
+	lower_margin:	1,
+	hsync_len:	128,
+	vsync_len:	4,
+	sync:		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+	vmode:		FB_VMODE_NONINTERLACED
+};
+
 static struct fb_var_screeninfo __devinitdata neofb_var1024x768x8 = {
 	accel_flags:	FB_ACCELF_TEXT,
 	xres:		1024,
@@ -1948,6 +2004,14 @@
   VGAwGR(0x09,0x26);
   type = VGArGR(0x21);
   display = VGArGR(0x20);
+  if (!info->internal_display && !info->external_display)
+    {
+      info->internal_display = display & 2 || !(display & 3) ? 1 : 0;
+      info->external_display = display & 1;
+      printk (KERN_INFO "Autodetected %s display\n",
+	      info->internal_display && info->external_display ? "simultaneous" :
+	      info->internal_display ? "internal" : "external");
+    }
     
   /* Determine panel width -- used in NeoValidMode. */
   w = VGArGR(0x20);
@@ -1961,8 +2025,8 @@
       break;
     case 0x01:
       info->NeoPanelWidth  = 800;
-      info->NeoPanelHeight = 600;
-      neofb_var = &neofb_var800x600x8;
+       info->NeoPanelHeight = info->libretto ? 480 : 600;
+      neofb_var = info->libretto ? &neofb_var800x480x8 : &neofb_var800x600x8;
       break;
     case 0x02:
       info->NeoPanelWidth  = 1024;
@@ -1977,7 +2041,7 @@
       neofb_var = &neofb_var1280x1024x8;
       break;
 #else
-      printk (KERN_ERR "neofb: Only 640x480, 800x600 and 1024x768 panels are currently supported\n");
+      printk (KERN_ERR "neofb: Only 640x480, 800x600/480 and 1024x768 panels are currently supported\n");
       return -1;
 #endif
     default:
@@ -2103,17 +2167,10 @@
 
   info->pci_burst   = !nopciburst;
   info->lcd_stretch = !nostretch;
+  info->libretto    = libretto;
 
-  if (!internal && !external)
-    {
-      info->internal_display = 1;
-      info->external_display = 0;
-    }
-  else
-    {
-      info->internal_display = internal;
-      info->external_display = external;
-    }
+  info->internal_display = internal;
+  info->external_display = external;
 
   switch (info->accel)
     {
@@ -2377,6 +2434,8 @@
 	nostretch = 1;
       if (!strncmp(this_opt, "nopciburst", 10))
 	nopciburst = 1;
+      if (!strncmp(this_opt, "libretto", 8))
+	libretto = 1;
     }
 
   return 0;
diff -Naur linux-2.4.20-rc1/drivers/video/neofb.h linux-2.4.20-rc1-neofb-0.4/drivers/video/neofb.h
--- linux-2.4.20-rc1/drivers/video/neofb.h	2002-10-30 15:20:39.000000000 +0100
+++ linux-2.4.20-rc1-neofb-0.4/drivers/video/neofb.h	2002-10-30 15:45:17.000000000 +0100
@@ -154,6 +154,7 @@
   int lcd_stretch;
   int internal_display;
   int external_display;
+  int libretto;
 
   struct {
     u16 red, green, blue, transp;

--nFreZHaLTZJo0R7j--
