Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965152AbVHPJNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965152AbVHPJNX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 05:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbVHPJNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 05:13:23 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:26566 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S965152AbVHPJNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 05:13:22 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.13-rc6] MODULE_DEVICE_TABLE for cpqfcTS driver
Date: Tue, 16 Aug 2005 11:11:33 +0200
User-Agent: KMail/1.8.2
Cc: linux-scsi@vger.kernel.org, James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Bolke de Bruin <bdbruin@aub.nl>
References: <200508051202.07091@bilbo.math.uni-mannheim.de> <200508091806.45341@bilbo.math.uni-mannheim.de> <200508161111.08070@bilbo.math.uni-mannheim.de>
In-Reply-To: <200508161111.08070@bilbo.math.uni-mannheim.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508161111.35431@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpqfcTSinit has a static array of PCI device and vendor ids supported by the 
driver. Sounds familiar, doesn't it? Use pci_device_id as type for the 
entries of this array and declare the array as MODULE_DEVICE_TABLE. Also use 
pci_get_device() instead of pci_find_device() and remove some superfluos 
defines for device scanning.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- a/drivers/scsi/cpqfcTSstructs.h	2005-08-14 10:56:41.000000000 +0200
+++ b/drivers/scsi/cpqfcTSstructs.h	2005-08-14 10:57:32.000000000 +0200
@@ -95,12 +95,6 @@
 
 #define DEV_NAME "cpqfcTS"
 
-struct SupportedPCIcards
-{
-  __u16 vendor_id;
-  __u16 device_id;
-};
-			 
 // nn:nn denotes bit field
                             // TachyonHeader struct def.
                             // the fields shared with ODB
--- a/drivers/scsi/cpqfcTSinit.c	2005-08-14 14:20:40.000000000 +0200
+++ b/drivers/scsi/cpqfcTSinit.c	2005-08-14 14:25:33.000000000 +0200
@@ -264,18 +264,14 @@ static void launch_FCworker_thread(struc
  * Agilent XL2 
  * HP Tachyon
  */
-#define HBA_TYPES 3
-
-#ifndef PCI_DEVICE_ID_COMPAQ_
-#define PCI_DEVICE_ID_COMPAQ_TACHYON	0xa0fc
-#endif
-
-static struct SupportedPCIcards cpqfc_boards[] __initdata = {
-	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_TACHYON},
-	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_TACHLITE},
-	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_TACHYON},
+static struct pci_device_id cpqfc_boards[] __initdata = {
+	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_TACHYON, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_TACHLITE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_TACHYON, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{0, }
 };
 
+MODULE_DEVICE_TABLE(pci, cpqfc_boards);
 
 int cpqfcTS_detect(Scsi_Host_Template *ScsiHostTemplate)
 {
@@ -294,14 +290,9 @@ int cpqfcTS_detect(Scsi_Host_Template *S
   ScsiHostTemplate->proc_name = "cpqfcTS";
 #endif
 
-  for( i=0; i < HBA_TYPES; i++)
-  {
-    // look for all HBAs of each type
-
-    while((PciDev = pci_find_device(cpqfc_boards[i].vendor_id,
-				    cpqfc_boards[i].device_id, PciDev)))
-    {
-
+  for(i = 0; cpqfc_boards[i]; i++) {
+    while((PciDev = pci_get_device(cpqfc_boards[i].vendor,
+				    cpqfc_boards[i].device, PciDev))) {
       if (pci_enable_device(PciDev)) {
 	printk(KERN_ERR
 		"cpqfc: can't enable PCI device at %s\n", pci_name(PciDev));
