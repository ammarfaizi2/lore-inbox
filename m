Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbVJCRpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbVJCRpI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 13:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932485AbVJCRpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 13:45:08 -0400
Received: from amdext4.amd.com ([163.181.251.6]:43705 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S932315AbVJCRpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 13:45:06 -0400
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Date: Mon, 3 Oct 2005 12:02:00 -0600
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
cc: info-linux@ldcmail.amd.com
Subject: [PATCH 6/7] AMD Geode GX/LX support
Message-ID: <20051003180200.GH29264@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F5FB19C2RW1376369-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the hardware RNG device on the Geode LX
processor.  As a side note, the LX processor also includes a hardware
AES encryption engine, support for which is not included here because
I'm not one to increase the kernel source size if it doesn't need to be.
If the list believes that this support is interesting to the mainstream
kernel, I will push that up as well.  Please apply against 
linux-2.6.13-rc2-mm2.

Signed off by:  Jordan Crouse (jordan.crouse@amd.com)

Index: linux-2.6.14-rc2-mm2/drivers/char/hw_random.c
===================================================================
--- linux-2.6.14-rc2-mm2.orig/drivers/char/hw_random.c
+++ linux-2.6.14-rc2-mm2/drivers/char/hw_random.c
@@ -1,4 +1,9 @@
 /*
+        Added support for the AMD Geode LX RNG
+	(c) Copyright 2004-2005 Advanced Micro Devices, Inc.
+
+	derived from
+
  	Hardware driver for the Intel/AMD/VIA Random Number Generators (RNG)
 	(c) Copyright 2003 Red Hat Inc <jgarzik@redhat.com>
  
@@ -95,6 +100,13 @@ static unsigned int via_data_present (vo
 static u32 via_data_read (void);
 #endif
 
+#ifdef CONFIG_MGEODE_LX
+static int __init geode_init(struct pci_dev *dev);
+static void geode_cleanup(void);
+static unsigned int geode_data_present (void);
+static u32 geode_data_read (void);
+#endif
+
 struct rng_operations {
 	int (*init) (struct pci_dev *dev);
 	void (*cleanup) (void);
@@ -122,6 +134,9 @@ enum {
 	rng_hw_intel,
 	rng_hw_amd,
 	rng_hw_via,
+#ifdef CONFIG_MGEODE_LX
+	rng_hw_geode,
+#endif
 };
 
 static struct rng_operations rng_vendor_ops[] = {
@@ -139,6 +154,11 @@ static struct rng_operations rng_vendor_
 	/* rng_hw_via */
 	{ via_init, via_cleanup, via_data_present, via_data_read, 1 },
 #endif
+
+#ifdef CONFIG_MGEODE_LX
+	/* rng_hw_geode */
+	{ geode_init, geode_cleanup, geode_data_present, geode_data_read, 4 }
+#endif
 };
 
 /*
@@ -159,6 +179,10 @@ static struct pci_device_id rng_pci_tbl[
 	{ 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
 	{ 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
 
+#ifdef CONFIG_MGEODE_LX
+	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LX_AES,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_geode },
+#endif
 	{ 0, },	/* terminate list */
 };
 MODULE_DEVICE_TABLE (pci, rng_pci_tbl);
@@ -460,6 +484,54 @@ static void via_cleanup(void)
 }
 #endif
 
+#ifdef CONFIG_MGEODE_LX
+
+/***********************************************************************
+ *
+ * AMD Geode RNG operations
+ *
+ */
+
+static void __iomem *geode_rng_base = 0x0;
+
+#define GEODE_RNG_DATA_REG   0x50
+#define GEODE_RNG_STATUS_REG 0x54
+
+static u32 geode_data_read(void) {
+	u32 val;
+
+	val = *((u32 *) (geode_rng_base + GEODE_RNG_DATA_REG));
+	return val;
+}
+
+static unsigned int geode_data_present(void) {
+	u32 val;
+
+	val = *((u32 *) (geode_rng_base + GEODE_RNG_STATUS_REG));
+	return val;
+}
+
+static void geode_cleanup(void) {
+	iounmap(geode_rng_base);
+  	geode_rng_base = NULL;
+}
+
+static int geode_init(struct pci_dev *dev) {
+	u32 rng_base = pci_resource_start(dev, 0);
+	if (!rng_base) return 1;
+
+	geode_rng_base = ioremap(rng_base, 0x58);
+
+	if (geode_rng_base == NULL) {
+		printk(KERN_ERR PFX "Cannot ioremap RNG memory\n");
+		return -EBUSY;
+	}
+
+	printk(KERN_INFO PFX "Geode RNG registers at %p\n", geode_rng_base);
+	return 0;
+}
+
+#endif
 
 /***********************************************************************
  *
@@ -574,7 +646,7 @@ static int __init rng_init (void)
 
 	DPRINTK ("ENTER\n");
 
-	/* Probe for Intel, AMD RNGs */
+	/* Probe for Intel, AMD, Geode RNGs */
 	for_each_pci_dev(pdev) {
 		ent = pci_match_id(rng_pci_tbl, pdev);
 		if (ent) {

