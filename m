Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264301AbTDWSyj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 14:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264323AbTDWSyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 14:54:37 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:39483 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264301AbTDWSxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 14:53:21 -0400
Date: Wed, 23 Apr 2003 15:05:29 -0400
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: davej@codemonkey.org.uk
Subject: [PATCH] 2.5.68 intel i855PM AGP support
Message-ID: <20030423150529.C8931@devserv.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Adds i855PM support. Mainly adding a PCI id, unfortunately, requires
renaming the i855GM PCI ids to avoid name conflict. Also renames some
of the i855GM constants from i855PM to i855GM.

Bill

--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.5.68-i855pm.patch"

--- linux-2.5.68/drivers/char/agp/intel-agp.c.foo	2003-04-23 14:32:17.000000000 -0400
+++ linux-2.5.68/drivers/char/agp/intel-agp.c	2003-04-23 15:00:10.800583328 -0400
@@ -1368,12 +1368,18 @@
 		.chipset_setup	= intel_850_setup
 	},
 	{
-		.device_id	= PCI_DEVICE_ID_INTEL_82855_HB,
+		.device_id	= PCI_DEVICE_ID_INTEL_82855PM_HB,
 		.chipset	= INTEL_I855_PM,
 		.chipset_name	= "855PM",
 		.chipset_setup	= intel_845_setup
 	},
 	{
+		.device_id	= PCI_DEVICE_ID_INTEL_82855GM_HB,
+		.chipset	= INTEL_I855_GM,
+		.chipset_name	= "855GM",
+		.chipset_setup	= intel_845_setup
+	},
+	{
 		.device_id	= PCI_DEVICE_ID_INTEL_82860_HB,
 		.chipset	= INTEL_I860,
 		.chipset_name	= "i860",
@@ -1534,16 +1540,16 @@
 		printk(KERN_INFO PFX "Detected an Intel(R) 830M Chipset.\n");
 		agp_bridge->type = INTEL_I810;
 		return intel_i830_setup(i810_dev);
-
-	case PCI_DEVICE_ID_INTEL_82855_HB:
-		i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82855_IG, NULL);
+	     
+	case PCI_DEVICE_ID_INTEL_82855GM_HB:
+		i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82855GM_IG, NULL);
 		if(i810_dev && PCI_FUNC(i810_dev->devfn) != 0)
-			i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82855_IG, i810_dev);
+			i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82855GM_IG, i810_dev);
 
 		if (i810_dev == NULL) {
-			/* Intel 855PM with external graphic card */
+			/* Intel 855GM with external graphic card */
 			/* It will be initialized later */
-			agp_bridge->type = INTEL_I855_PM;
+			agp_bridge->type = INTEL_I855_GM;
 			break;
 		}
 		{
--- linux-2.5.68/include/linux/pci_ids.h.foo	2003-04-23 13:51:03.000000000 -0400
+++ linux-2.5.68/include/linux/pci_ids.h	2003-04-23 14:06:55.000000000 -0400
@@ -1902,10 +1902,11 @@
 #define PCI_DEVICE_ID_INTEL_82845G_IG	0x2562
 #define PCI_DEVICE_ID_INTEL_82865_HB	0x2570
 #define PCI_DEVICE_ID_INTEL_82865_IG	0x2572
+#define PCI_DEVICE_ID_INTEL_82855PM_HB	0x3340
 #define PCI_DEVICE_ID_INTEL_82830_HB	0x3575
 #define PCI_DEVICE_ID_INTEL_82830_CGC	0x3577
-#define PCI_DEVICE_ID_INTEL_82855_HB	0x3580
-#define PCI_DEVICE_ID_INTEL_82855_IG	0x3582
+#define PCI_DEVICE_ID_INTEL_82855GM_HB	0x3580
+#define PCI_DEVICE_ID_INTEL_82855GM_IG	0x3582
 #define PCI_DEVICE_ID_INTEL_80310	0x530d
 #define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
 #define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
--- linux-2.5.68/include/linux/agp_backend.h.foo	2003-04-23 14:35:48.000000000 -0400
+++ linux-2.5.68/include/linux/agp_backend.h	2003-04-23 14:36:03.000000000 -0400
@@ -47,6 +47,7 @@
 	INTEL_I830_M,
 	INTEL_I845_G,
 	INTEL_I855_PM,
+	INTEL_I855_GM,
 	INTEL_I865_G,
 	INTEL_I840,
 	INTEL_I845,

--A6N2fC+uXW/VQSAv--
