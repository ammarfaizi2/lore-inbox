Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQKJM3E>; Fri, 10 Nov 2000 07:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129990AbQKJM2y>; Fri, 10 Nov 2000 07:28:54 -0500
Received: from vulcan.datanet.hu ([194.149.0.156]:63572 "EHLO relay.datanet.hu")
	by vger.kernel.org with ESMTP id <S129325AbQKJM2u>;
	Fri, 10 Nov 2000 07:28:50 -0500
From: "Bakonyi Ferenc" <fero@drama.obuda.kando.hu>
Organization: Datakart Geodzia KFT.
To: Ani Joshi <ajoshi@shell.unixbox.com>,
        Jindrich Makovicka <jmakovicka_jr@volny.cz>
Date: Fri, 10 Nov 2000 13:27:14 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: [PATCH] rivafb 0.7.2 weird colors (15bpp)
CC: linux-nvidia@lists.surfsouth.com, linux-fbdev@vuser.vu.union.edu,
        linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail for Win32 (v3.01d)
Message-Id: <E13uDH5-00009p-00@aleph0.datakart.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Please test this patch on TNT/TNT2 in 15bpp mode. It fixes some 
typos, and should correct the weird colors in 15bpp mode.

Regards:
	Ferenc Bakonyi

-------- cut here -------------
--- vanilla/linux/drivers/video/riva/fbdev.c	Mon Oct 16 23:40:54 2000
+++ linux/drivers/video/riva/fbdev.c	Thu Nov  9 20:56:58 2000
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/video/rivafb.c - nVidia RIVA 128/TNT/TNT2 fb driver
+ * linux/drivers/video/fbdev.c - nVidia RIVA 128/TNT/TNT2 fb driver
  *
  * Maintained by Ani Joshi <ajoshi@shell.unixbox.com>
  *
@@ -17,12 +17,12 @@
  * KGI code provided the basis for state storage, init, and mode switching.
  *
  * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file README.legal in the main directory of this archive
+ * License.  See the file COPYING in the main directory of this archive
  * for more details.
  */
 
 /* version number of this driver */
-#define RIVAFB_VERSION "0.7.2"
+#define RIVAFB_VERSION "0.7.3"
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -311,7 +311,7 @@
 
 /**
  * riva_set_dispsw
- * @rivainfo: pointer to internal driver struct for a given Riva card
+ * @rinfo: pointer to internal driver struct for a given Riva card
  *
  * DESCRIPTION:
  * Sets up console Low level operations depending on the current? color depth
@@ -514,14 +514,14 @@
 	rinfo->ctrl_base = ioremap (rinfo->ctrl_base_phys,
 				    rinfo->base0_region_size);
 	if (!rinfo->ctrl_base) {
-		printk (KERN_ERR PFX "cannot ioremap ctrl base\n");
+		printk (KERN_ERR PFX "cannot ioremap MMIO base\n");
 		goto err_out_free_base1;
 	}
 	
 	rinfo->fb_base = ioremap (rinfo->fb_base_phys,
 				  rinfo->base1_region_size);
 	if (!rinfo->fb_base) {
-		printk (KERN_ERR PFX "cannot ioremap ctrl base\n");
+		printk (KERN_ERR PFX "cannot ioremap FB base\n");
 		goto err_out_iounmap_ctrl;
 	}
 	
@@ -539,7 +539,7 @@
 	switch (rinfo->riva.Architecture) {
 	case 3:
 		rinfo->riva.PRAMIN =
-		    (unsigned *) (rinfo->ctrl_base + 0x00C00000);
+		    (unsigned *) (rinfo->fb_base + 0x00C00000);
 		break;
 	case 4:
 	case 5:
@@ -584,7 +584,8 @@
 
 	pci_set_drvdata (pd, rinfo);
 
-	printk ("PCI Riva NV%d framebuffer ver %s (%s, %dMB @ 0x%lX)\n",
+	printk (KERN_INFO PFX
+		"PCI Riva NV%d framebuffer ver %s (%s, %dMB @ 0x%lX)\n",
 		rinfo->riva.Architecture,
 		RIVAFB_VERSION,
 		rinfo->drvr_name,
@@ -859,7 +860,7 @@
 		v.blue.offset = 0;
 #endif
 		v.red.length = 5;
-		v.green.length = 6;
+		v.green.length = 5;
 		v.blue.length = 5;
 		break;
 #endif
@@ -1046,7 +1047,7 @@
 /**
  * rivafb_pan_display
  * @var: standard kernel fb changeable data
- * @par: riva-specific hardware info about current video mode
+ * @con:
  * @info: pointer to rivafb_info object containing info for current riva board
  *
  * DESCRIPTION:
@@ -1292,7 +1293,7 @@
 {
 	struct rivafb_info *rivainfo = (struct rivafb_info *) info;
 
-	if (regno > 255)
+	if (regno >= riva_get_cmap_len(&rivainfo->currcon_display->var))
 		return 1;
 
 	*red = rivainfo->palette[regno].red;
@@ -1341,10 +1342,15 @@
 	assert (rivainfo != NULL);
 	assert (rivainfo->currcon_display != NULL);
 
-	if (regno > 255)
+	p = rivainfo->currcon_display;
+
+	if (regno >= riva_get_cmap_len(&p->var))
 		return -EINVAL;
 
-	p = rivainfo->currcon_display;
+	rivainfo->palette[regno].red = red;
+	rivainfo->palette[regno].green = green;
+	rivainfo->palette[regno].blue = blue;
+
 	if (p->var.grayscale) {
 		/* gray = 0.30*R + 0.59*G + 0.11*B */
 		red = green = blue =
@@ -1361,27 +1367,14 @@
 		break;
 	}
 
-#ifdef FBCON_HAS_CFB8
 	switch (p->var.bits_per_pixel) {
+#ifdef FBCON_HAS_CFB8
 	case 8:
 		/* "transparent" stuff is completely ignored. */
 		riva_wclut (regno, red >> shift, green >> shift, blue >> shift);
 		break;
-	default:
-		/* do nothing */
-		break;
-	}
 #endif				/* FBCON_HAS_CFB8 */
 
-	rivainfo->palette[regno].red = red;
-	rivainfo->palette[regno].green = green;
-	rivainfo->palette[regno].blue = blue;
-
-	if (regno >= 16)
-		return 0;
-
-	switch (p->var.bits_per_pixel) {
-
 #ifdef FBCON_HAS_CFB16
 	case 16:
 		assert (regno < 16);
@@ -1392,8 +1385,8 @@
 		    ((green & 0xf800) << 2) | ((blue & 0xf800) >> 3);
 #else
 		rivainfo->con_cmap.cfb16[regno] =
-		    ((red & 0xf800) >> 0) |
-		    ((green & 0xf800) >> 5) | ((blue & 0xf800) >> 11);
+		    ((red & 0xf800) >> 1) |
+		    ((green & 0xf800) >> 6) | ((blue & 0xf800) >> 11);
 #endif
 		break;
 #endif				/* FBCON_HAS_CFB16 */
-------- cut here -------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
