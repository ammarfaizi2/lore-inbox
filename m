Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965015AbVJEVqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbVJEVqx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 17:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbVJEVqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 17:46:53 -0400
Received: from raq7.e-telcom.com.au ([202.162.77.140]:46486 "EHLO
	raq7.e-telcom.com.au") by vger.kernel.org with ESMTP
	id S965015AbVJEVqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 17:46:53 -0400
Date: Thu, 6 Oct 2005 07:42:49 +1000
From: irrational@poboxes.com
To: adaplas@pol.net, akpm.osdl.org@e-telcom.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] intelfb - extend partial support of i915G to include i915GM
Message-ID: <20051005214249.GG8567@dubious>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch follows on from                                                                                                                     
../akpm/patches/2.6/2.6.11-rc5/2.6.11-rc5-mm1/broken-out/intelfb-add-partial-support-915g-chipset.patch                                   
to add similar partial support for GMA900 within the i915GM chipset.                                                                      
                                                                                                                                          
Signed-off-by: Scott MacKenzie <irrational@poboxes.com> 

-- 
diff -urN linux-2.6.13-org/drivers/video/intelfb/intelfbdrv.c linux-2.6.13/drivers/video/intelfb/intelfbdrv.c
--- linux-2.6.13-org/drivers/video/intelfb/intelfbdrv.c	2005-08-28 23:41:01.000000000 +0000
+++ linux-2.6.13/drivers/video/intelfb/intelfbdrv.c	2005-10-05 07:43:54.000000000 +0000
@@ -1,7 +1,7 @@
 /*
  * intelfb
  *
- * Linux framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G
+ * Linux framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G/915GM
  * integrated graphics chips.
  *
  * Copyright © 2002, 2003 David Dawes <dawes@xfree86.org>
@@ -190,6 +190,7 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_85XGM, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_85XGM },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_865G, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_865G },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_915G, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_915G },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_915GM, PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA << 8, INTELFB_CLASS_MASK, INTEL_915GM },
 	{ 0, }
 };
 
@@ -553,10 +554,11 @@
 	}
 
 	/* Set base addresses. */
-	if (ent->device == PCI_DEVICE_ID_INTEL_915G) {
+	if ((ent->device == PCI_DEVICE_ID_INTEL_915G) ||
+			(ent->device == PCI_DEVICE_ID_INTEL_915GM)) {
 		aperture_bar = 2;
 		mmio_bar = 0;
-		/* Disable HW cursor on 915G (not implemented yet) */
+		/* Disable HW cursor on 915G/M (not implemented yet) */
 		hwcursor = 0;
 	}
 	dinfo->aperture.physical = pci_resource_start(pdev, aperture_bar);
diff -urN linux-2.6.13-org/drivers/video/intelfb/intelfb.h linux-2.6.13/drivers/video/intelfb/intelfb.h
--- linux-2.6.13-org/drivers/video/intelfb/intelfb.h	2005-08-28 23:41:01.000000000 +0000
+++ linux-2.6.13/drivers/video/intelfb/intelfb.h	2005-10-05 07:37:06.000000000 +0000
@@ -10,7 +10,7 @@
 /*** Version/name ***/
 #define INTELFB_VERSION			"0.9.2"
 #define INTELFB_MODULE_NAME		"intelfb"
-#define SUPPORTED_CHIPSETS		"830M/845G/852GM/855GM/865G/915G"
+#define SUPPORTED_CHIPSETS		"830M/845G/852GM/855GM/865G/915G/915GM"
 
 
 /*** Debug/feature defines ***/
@@ -47,6 +47,7 @@
 #define PCI_DEVICE_ID_INTEL_85XGM	0x3582
 #define PCI_DEVICE_ID_INTEL_865G	0x2572
 #define PCI_DEVICE_ID_INTEL_915G	0x2582
+#define PCI_DEVICE_ID_INTEL_915GM	0x2592
 
 /* Size of MMIO region */
 #define INTEL_REG_SIZE			0x80000
@@ -119,7 +120,8 @@
 	INTEL_855GM,
 	INTEL_855GME,
 	INTEL_865G,
-	INTEL_915G
+	INTEL_915G,
+	INTEL_915GM
 };
 
 struct intelfb_hwstate {
diff -urN linux-2.6.13-org/drivers/video/intelfb/intelfbhw.c linux-2.6.13/drivers/video/intelfb/intelfbhw.c
--- linux-2.6.13-org/drivers/video/intelfb/intelfbhw.c	2005-08-28 23:41:01.000000000 +0000
+++ linux-2.6.13/drivers/video/intelfb/intelfbhw.c	2005-10-05 07:39:32.000000000 +0000
@@ -103,6 +103,11 @@
 		*chipset = INTEL_915G;
 		*mobile = 0;
 		return 0;
+	case PCI_DEVICE_ID_INTEL_915GM:
+		*name = "Intel(R) 915GM";
+		*chipset = INTEL_915GM;
+		*mobile = 1;
+		return 0;		
 	default:
 		return 1;
 	}
