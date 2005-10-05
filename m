Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030233AbVJEQno@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbVJEQno (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030238AbVJEQnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:43:43 -0400
Received: from amdext4.amd.com ([163.181.251.6]:61405 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1030233AbVJEQnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:43:42 -0400
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Date: Wed, 5 Oct 2005 11:01:12 -0600
From: "Jordan Crouse" <jordan.crouse@AMD.com>
To: linux-kernel@vger.kernel.org
cc: info-linux@ldcmail.amd.com
Subject: [PATCH 4/5] AMD Geode GX/LX support V2
Message-ID: <20051005170112.GD24950@cosmic.amd.com>
References: <20051005164626.GA25189@cosmic.amd.com>
MIME-Version: 1.0
In-Reply-To: <20051005164626.GA25189@cosmic.amd.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6F5ADD322RW1847403-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch for the AMD LX RNG device.  Changelog:

- Remove defines, style cleanups (Vladis Kletnieks, Alan Cox, Andi Kleen)
- Replace pointer derefrences with readl (Vladis, Alan and Andi again)
- Add asserts to protect against NULL dereferences (Vladis)


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
  
@@ -95,6 +100,11 @@ static unsigned int via_data_present (vo
 static u32 via_data_read (void);
 #endif
 
+static int __init geode_init(struct pci_dev *dev);
+static void geode_cleanup(void);
+static unsigned int geode_data_present (void);
+static u32 geode_data_read (void);
+
 struct rng_operations {
 	int (*init) (struct pci_dev *dev);
 	void (*cleanup) (void);
@@ -122,6 +132,7 @@ enum {
 	rng_hw_intel,
 	rng_hw_amd,
 	rng_hw_via,
+	rng_hw_geode,
 };
 
 static struct rng_operations rng_vendor_ops[] = {
@@ -139,6 +150,9 @@ static struct rng_operations rng_vendor_
 	/* rng_hw_via */
 	{ via_init, via_cleanup, via_data_present, via_data_read, 1 },
 #endif
+
+	/* rng_hw_geode */
+	{ geode_init, geode_cleanup, geode_data_present, geode_data_read, 4 }
 };
 
 /*
@@ -159,6 +173,9 @@ static struct pci_device_id rng_pci_tbl[
 	{ 0x8086, 0x244e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
 	{ 0x8086, 0x245e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_intel },
 
+	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_LX_AES,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, rng_hw_geode },
+
 	{ 0, },	/* terminate list */
 };
 MODULE_DEVICE_TABLE (pci, rng_pci_tbl);
@@ -460,6 +477,53 @@ static void via_cleanup(void)
 }
 #endif
 
+/***********************************************************************
+ *
+ * AMD Geode RNG operations
+ *
+ */
+
+static void __iomem *geode_rng_base = NULL;
+
+#define GEODE_RNG_DATA_REG   0x50
+#define GEODE_RNG_STATUS_REG 0x54
+
+static u32 geode_data_read(void)
+{
+	u32 val;
+	assert(geode_rng_base != NULL);
+	val = readl(geode_rng_base + GEODE_RNG_DATA_REG);
+	return val;
+}
+
+static unsigned int geode_data_present(void)
+{
+	u32 val;
+	assert(geode_rng_base != NULL);
+	val = readl(geode_rng_base + GEODE_RNG_STATUS_REG);
+	return val;
+}
+
+static void geode_cleanup(void)
+{
+	iounmap(geode_rng_base);
+  	geode_rng_base = NULL;
+}
+
+static int geode_init(struct pci_dev *dev)
+{
+	unsigned long rng_base = pci_resource_start(dev, 0);
+	if (rng_base == NULL) return 1;
+
+	geode_rng_base = ioremap(rng_base, 0x58);
+
+	if (geode_rng_base == NULL) {
+		printk(KERN_ERR PFX "Cannot ioremap RNG memory\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
 
 /***********************************************************************
  *
@@ -574,7 +638,7 @@ static int __init rng_init (void)
 
 	DPRINTK ("ENTER\n");
 
-	/* Probe for Intel, AMD RNGs */
+	/* Probe for Intel, AMD, Geode RNGs */
 	for_each_pci_dev(pdev) {
 		ent = pci_match_id(rng_pci_tbl, pdev);
 		if (ent) {

