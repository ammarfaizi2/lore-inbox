Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbVLOVNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVLOVNA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 16:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbVLOVNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 16:13:00 -0500
Received: from amdext3.amd.com ([139.95.251.6]:20182 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S1751087AbVLOVM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 16:12:59 -0500
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Date: Thu, 15 Dec 2005 14:14:23 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org, alan@lxorguk.ukuu.org.uk, info-linux@ldcmail.amd.com
Subject: [PATCH 2/3] Geode LX HW RNG Support
Message-ID: <20051215211423.GF11054@cosmic.amd.com>
References: <20051215211248.GE11054@cosmic.amd.com>
MIME-Version: 1.0
In-Reply-To: <20051215211248.GE11054@cosmic.amd.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FBF03BB21S596517-01-01
Content-Type: multipart/mixed;
 boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Repost - no changes since last posting.


--6zdv2QT/q3FMhpsV
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=rng.patch
Content-Transfer-Encoding: 7bit

GEODE:  Support for the Geodge LX HRNG

This patch adds support to hw_random for the Geode LX HRNG device.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/char/hw_random.c |   66 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 65 insertions(+), 1 deletions(-)

diff --git a/drivers/char/hw_random.c b/drivers/char/hw_random.c
index 6f673d2..4d69e05 100644
--- a/drivers/char/hw_random.c
+++ b/drivers/char/hw_random.c
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

--6zdv2QT/q3FMhpsV--

