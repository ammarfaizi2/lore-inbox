Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbUFPP2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbUFPP2g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 11:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbUFPP2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 11:28:36 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:5567 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S262648AbUFPP2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 11:28:32 -0400
From: Carsten Rietzschel <cr7@os.inf.tu-dresden.de>
To: davej@codemonkey.org.uk
Subject: PATCH - via_agp.c: VP3 souldn't work /  "Detected VIA %s chipset" fails (kernel 2.6.7)
Date: Wed, 16 Jun 2004 17:32:23 +0200
User-Agent: KMail/1.6.52
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Organization: TU Dresden - Operating System Group 
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HgG0A8RIs+uXDew"
Message-Id: <200406161732.23630.cr7@os.inf.tu-dresden.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_HgG0A8RIs+uXDew
Content-Type: text/plain;
  charset="us-ascii";
  boundary=""
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

the AGP-driver should not work for Apollo VP3, cause it's not listed in 
struct pci_device_id list in the fresh kernel 2.6.7.

So it also displays "Detected VIA %s chipset" wrong for every VIA chipset.

The reason for both is, in 
	static struct pci_device_id agp_via_pci_table[]
the line
       ID(PCI_DEVICE_ID_VIA_82C597_0),
is missing.

The source code has an comment:
/* must be the same order as name table above */
but it doesn't match.

The attached patch:
- adds ID(PCI_DEVICE_ID_VIA_82C597_0) to pci_device_id agp_via_pci_table[]
- it compares the correct number of entries in both tables in init-function
  (agp_via_pci_table vs. via_agp_device_ids), if it doesn't match in prints a 
  warning 
  <--- this is not neccessary, but  just to be sure :)
 
Regards,
Carsten

--Boundary-00=_HgG0A8RIs+uXDew
Content-Type: text/x-diff;
  charset="us-ascii";
  name="via-agp-verbose.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="via-agp-verbose.patch"

diff -uprN linux-2.6.7-org/drivers/char/agp/via-agp.c linux-2.6.7/drivers/char/agp/via-agp.c
--- linux-2.6.7-org/drivers/char/agp/via-agp.c	2004-06-16 13:26:03.000000000 +0200
+++ linux-2.6.7/drivers/char/agp/via-agp.c	2004-06-16 17:10:47.000000000 +0200
@@ -351,6 +351,7 @@ static struct agp_device_ids via_agp_dev
 
 	{ }, /* dummy final entry, always present */
 };
+#define AGP_VIA_DEVICE_ELEMENTS (sizeof(via_agp_device_ids)/sizeof(via_agp_device_ids[0]))
 
 
 /*
@@ -434,6 +435,7 @@ static struct pci_device_id agp_via_pci_
 	.subvendor	= PCI_ANY_ID,			\
 	.subdevice	= PCI_ANY_ID,			\
 	}
+	ID(PCI_DEVICE_ID_VIA_82C597_0),
 	ID(PCI_DEVICE_ID_VIA_82C598_0),
 	ID(PCI_DEVICE_ID_VIA_8501_0),
 	ID(PCI_DEVICE_ID_VIA_8601_0),
@@ -459,10 +461,12 @@ static struct pci_device_id agp_via_pci_
 	ID(PCI_DEVICE_ID_VIA_PX8X0_0),	
 	{ }
 };
+#define AGP_VIA_PCI_ELEMENTS (sizeof(agp_via_pci_table)/sizeof(agp_via_pci_table[0]))
 
 MODULE_DEVICE_TABLE(pci, agp_via_pci_table);
 
 
+
 static struct pci_driver agp_via_pci_driver = {
 	.name		= "agpgart-via",
 	.id_table	= agp_via_pci_table,
@@ -473,6 +477,8 @@ static struct pci_driver agp_via_pci_dri
 
 static int __init agp_via_init(void)
 {
+        if(AGP_VIA_DEVICE_ELEMENTS != AGP_VIA_PCI_ELEMENTS)
+	    printk (KERN_INFO PFX "Warning: sizeof device and pci elements don't match. Please send a bug report.\n");
 	return pci_module_init(&agp_via_pci_driver);
 }
 

--Boundary-00=_HgG0A8RIs+uXDew--
