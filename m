Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264082AbTCUUjl>; Fri, 21 Mar 2003 15:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263836AbTCUTFB>; Fri, 21 Mar 2003 14:05:01 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40068
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263833AbTCUS7n>; Fri, 21 Mar 2003 13:59:43 -0500
Date: Fri, 21 Mar 2003 20:14:59 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303212014.h2LKExig026340@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: handle exploding pnpbios
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/arch/i386/kernel/dmi_scan.c linux-2.5.65-ac2/arch/i386/kernel/dmi_scan.c
--- linux-2.5.65/arch/i386/kernel/dmi_scan.c	2003-03-18 16:46:45.000000000 +0000
+++ linux-2.5.65-ac2/arch/i386/kernel/dmi_scan.c	2003-03-21 00:00:01.000000000 +0000
@@ -499,6 +499,19 @@
 	return 0;
 }
 
+/*
+ *	Exploding PnPBIOS. Don't yet know if its the BIOS or us for
+ *	some entries
+ */
+
+static __init int exploding_pnp_bios(struct dmi_blacklist *d)
+{
+	printk(KERN_WARNING "%s detected. Disabling PnPBIOS\n", d->ident);
+	dmi_broken |= BROKEN_PNP_BIOS;
+	return 0;
+}
+
+
 
 /*
  *	Simple "print if true" callback
@@ -687,6 +700,13 @@
 			MATCH(DMI_BIOS_VERSION, "WXPO1Z3"),
 			MATCH(DMI_BIOS_DATE, "10/26/01"), NO_MATCH
 			} },
+			
+	{ exploding_pnp_bios, "Higraded P14H", {	/* BIOSPnP problem */
+			MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
+			MATCH(DMI_BIOS_VERSION, "07.00T"),
+			MATCH(DMI_SYS_VENDOR, "Higraded"),
+			MATCH(DMI_PRODUCT_NAME, "P14H")
+			} },
 
 	/* Machines which have problems handling enabled local APICs */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/pnp/pnpbios/core.c linux-2.5.65-ac2/drivers/pnp/pnpbios/core.c
--- linux-2.5.65/drivers/pnp/pnpbios/core.c	2003-03-03 19:20:10.000000000 +0000
+++ linux-2.5.65-ac2/drivers/pnp/pnpbios/core.c	2003-03-20 18:13:07.000000000 +0000
@@ -969,7 +969,7 @@
 
 	spin_lock_init(&pnp_bios_lock);
 
-	if(pnpbios_disabled) {
+	if(pnpbios_disabled || (dmi_broken & BROKEN_PNP_BIOS)) {
 		printk(KERN_INFO "PnPBIOS: Disabled\n");
 		return -ENODEV;
 	}
