Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbWGaIZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWGaIZF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 04:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWGaIZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 04:25:04 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:27802
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1750951AbWGaIZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 04:25:03 -0400
Message-ID: <44CDBE5D.8020504@ed-soft.at>
Date: Mon, 31 Jul 2006 10:25:01 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org
Subject: [PATCH 1/3] add-imacfb-docu-and-detection.patch
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch add basic Machine detection to imacfb and
some Ducumentation bits for imacfb.

Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>


diff -uNr linux-2.6.18-rc2/Documentation/fb/imacfb.txt linux-2.6.18-rc2.mactel/Documentation/fb/imacfb.txt
--- linux-2.6.18-rc2/Documentation/fb/imacfb.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.18-rc2.mactel/Documentation/fb/imacfb.txt	2006-07-26 20:54:07.000000000 +0200
@@ -0,0 +1,31 @@
+
+What is imacfb?
+===============
+
+This is a generic EFI platform driver for Intel based Apple computers.
+Imacfb is only for EFI booted Intel Macs.
+
+Supported Hardware
+==================
+
+iMac 17"/20"
+Macbook
+Macbook Pro 15"/17"
+MacMini
+
+How to use it?
+==============
+
+Imacfb does not have any kind of autodetection of your machine.
+You have to add the fillowing kernel parameters in your elilo.conf:
+	Macbook :
+		video=imacfb:macbook
+	MacMini :
+		video=imacfb:mini
+	Macbook Pro 15", iMac 17" :
+		video=imacfb:i17
+	Macbook Pro 17", iMac 20" :
+		video=imacfb:i20
+
+--
+Edgar Hucek <gimli@dark-green.com>
diff -uNr linux-2.6.18-rc2/drivers/video/imacfb.c linux-2.6.18-rc2.mactel/drivers/video/imacfb.c
--- linux-2.6.18-rc2/drivers/video/imacfb.c	2006-07-16 10:38:27.000000000 +0200
+++ linux-2.6.18-rc2.mactel/drivers/video/imacfb.c	2006-07-25 13:53:35.000000000 +0200
@@ -18,6 +18,8 @@
 #include <linux/screen_info.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/dmi.h>
+#include <linux/efi.h>
 
 #include <asm/io.h>
 
@@ -28,7 +30,7 @@
 	M_I20,
 	M_MINI,
 	M_MACBOOK,
-	M_NEW
+	M_UNKNOWN
 } MAC_TYPE;
 
 /* --------------------------------------------------------------------- */
@@ -52,10 +54,36 @@
 };
 
 static int inverse;
-static int model		= M_NEW;
+static int model		= M_UNKNOWN;
 static int manual_height;
 static int manual_width;
 
+static int set_system(struct dmi_system_id *id)
+{
+	printk(KERN_INFO "imacfb: %s detected - set system to %ld\n",
+		id->ident, (long)id->driver_data);
+	
+	model = (long)id->driver_data;
+	
+	return 0;
+}
+
+static struct dmi_system_id __initdata dmi_system_table[] = {
+	{ set_system, "iMac4,1", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"Apple Computer, Inc."),
+	  DMI_MATCH(DMI_BIOS_VERSION,"iMac4,1") }, (void*)M_I17},
+	{ set_system, "MacBookPro1,1", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"Apple Computer, Inc."),
+	  DMI_MATCH(DMI_BIOS_VERSION,"MacBookPro1,1") }, (void*)M_I17},
+	{ set_system, "MacBook1,1", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"Apple Computer, Inc."),
+	  DMI_MATCH(DMI_PRODUCT_NAME,"MacBook1,1")}, (void *)M_MACBOOK},
+	{ set_system, "Macmini1,1", {
+	  DMI_MATCH(DMI_BIOS_VENDOR,"Apple Computer, Inc."),
+	  DMI_MATCH(DMI_PRODUCT_NAME,"Macmini1,1")}, (void *)M_MINI},
+	{},
+};
+
 #define	DEFAULT_FB_MEM	1024*1024*16
 
 /* --------------------------------------------------------------------- */
@@ -149,7 +177,6 @@
 		screen_info.lfb_linelength = 1472 * 4;
 		screen_info.lfb_base = 0x80010000;
 		break;
-	case M_NEW:
 	case M_I20:
 		screen_info.lfb_width = 1680;
 		screen_info.lfb_height = 1050;
@@ -207,6 +234,10 @@
 		size_remap = size_total;
 	imacfb_fix.smem_len = size_remap;
 
+#ifndef __i386__
+	screen_info.imacpm_seg = 0;
+#endif
+
 	if (!request_mem_region(imacfb_fix.smem_start, size_total, "imacfb")) {
 		printk(KERN_WARNING
 		       "imacfb: cannot reserve video memory at 0x%lx\n",
@@ -324,8 +355,16 @@
 	int ret;
 	char *option = NULL;
 
-	/* ignore error return of fb_get_options */
-	fb_get_options("imacfb", &option);
+	if (!efi_enabled)
+		return -ENODEV;
+	if (!dmi_check_system(dmi_system_table))
+		return -ENODEV;
+	if (model == M_UNKNOWN)
+		return -ENODEV;
+
+	if (fb_get_options("imacfb", &option))
+		return -ENODEV;
+
 	imacfb_setup(option);
 	ret = platform_driver_register(&imacfb_driver);
 
diff -uNr linux-2.6.18-rc2/drivers/video/Kconfig linux-2.6.18-rc2.mactel/drivers/video/Kconfig
--- linux-2.6.18-rc2/drivers/video/Kconfig	2006-07-16 10:38:27.000000000 +0200
+++ linux-2.6.18-rc2.mactel/drivers/video/Kconfig	2006-07-25 13:30:55.000000000 +0200
@@ -552,7 +552,7 @@
 
 config FB_IMAC
 	bool "Intel-based Macintosh Framebuffer Support"
-	depends on (FB = y) && X86
+	depends on (FB = y) && X86 && EFI
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT


