Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbWCaWfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbWCaWfT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 17:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWCaWfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 17:35:19 -0500
Received: from amdext3.amd.com ([139.95.251.6]:30674 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S1751460AbWCaWfS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 17:35:18 -0500
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
Date: Fri, 31 Mar 2006 16:03:09 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: linux-kernel@vger.kernel.org
cc: lm-sensors@lm-sensors.org, info-linux@ldcmail.amd.com, BGardner@Wabtec.com
Subject: [PATCH 2.6] scx200_acb: Use PCI I/O resource when appropriate
Message-ID: <20060331230309.GE17261@cosmic.amd.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 31 Mar 2006 22:34:33.0080 (UTC)
 FILETIME=[4834D780:01C65513]
X-WSS-ID: 683371F31W83332687-01-01
Content-Type: multipart/mixed;
 boundary=1LKvkjL3sHcu1TtY
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

The CS5535 and CS5536 both define the I/O base for the SMBUS device in a 
PCI header.  This patch uses that header for the I/O base rather then 
using the MSR backdoor.

This patch isn't as urgent as the other one, so it can probably take the 
usual trip up through Greg's tree.

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

--1LKvkjL3sHcu1TtY
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline;
 filename=smb-pcifixup.patch
Content-Transfer-Encoding: 7bit

[PATCH] scx200_acb:  Use PCI I/O resource when appropriate

From: Jordan Crouse <jordan.crouse@amd.com>

On the CS5535 and CS5536, the I/O resource is allocated through PCI,
so use that instead of using the MSR backdoor.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/i2c/busses/scx200_acb.c |  114 +++++++++++++++++++++++++++------------
 1 files changed, 78 insertions(+), 36 deletions(-)

diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index e7a2225..454492f 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -33,7 +33,6 @@
 #include <linux/delay.h>
 #include <linux/mutex.h>
 #include <asm/io.h>
-#include <asm/msr.h>
 
 #include <linux/scx200.h>
 
@@ -85,6 +84,10 @@ struct scx200_acb_iface {
 	u8 *ptr;
 	char needs_reset;
 	unsigned len;
+
+	/* PCI device info */
+	struct pci_dev *pdev;
+	int bar;
 };
 
 /* Register Definitions */
@@ -417,7 +420,8 @@ static int scx200_acb_probe(struct scx20
 	return 0;
 }
 
-static int  __init scx200_acb_create(const char *text, int base, int index)
+static int __init scx200_acb_create(char *text, unsigned int base, int index,
+				    struct pci_dev *pdev, int bar)
 {
 	struct scx200_acb_iface *iface;
 	struct i2c_adapter *adapter;
@@ -444,13 +448,31 @@ static int  __init scx200_acb_create(con
 	snprintf(description, sizeof(description), "%s ACCESS.bus [%s]",
 		 text, adapter->name);
 
-	if (request_region(base, 8, description) == 0) {
-		printk(KERN_ERR NAME ": can't allocate io 0x%x-0x%x\n",
-			base, base + 8-1);
-		rc = -EBUSY;
-		goto errout_free;
+	if (pdev != NULL) {
+
+		iface->pdev = pdev;
+		iface->bar = bar;
+
+		pci_enable_device_bars(iface->pdev, 1 << iface->bar);
+
+		if (pci_request_region(iface->pdev, iface->bar, description)) {
+			printk(KERN_ERR NAME ": can't allocate PCI region %d\n",
+			       iface->bar);
+			rc = -EBUSY;
+			goto errout_free;
+		}
+
+		iface->base = pci_resource_start(iface->pdev, iface->bar);
+	} else {
+		if (request_region(base, 8, description) == 0) {
+			printk(KERN_ERR NAME ": can't allocate io 0x%x-0x%x\n",
+			       base, base + 8 - 1);
+			rc = -EBUSY;
+			goto errout_free;
+		}
+
+		iface->base = base;
 	}
-	iface->base = base;
 
 	rc = scx200_acb_probe(iface);
 	if (rc) {
@@ -474,7 +496,11 @@ static int  __init scx200_acb_create(con
 	return 0;
 
  errout_release:
-	release_region(iface->base, 8);
+	if (iface->pdev != NULL)
+		pci_release_region(iface->pdev, iface->bar);
+	else
+		release_region(iface->base, 8);
+
  errout_free:
 	kfree(iface);
  errout:
@@ -487,49 +513,60 @@ static struct pci_device_id scx200[] = {
 	{ },
 };
 
-static struct pci_device_id divil_pci[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_NS,  PCI_DEVICE_ID_NS_CS5535_ISA) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA) },
-	{ } /* NULL entry */
+/* On the CS5535 and CS5536, the SMBUS I/0 base is a PCI resource, so
+   we should allocate that resource through the PCI
+   subsystem. rather then going through the MSR back door.
+*/
+
+static struct {
+	unsigned int vendor;
+	unsigned int device;
+	char *name;
+	int bar;
+} divil_pci[] = {
+	{
+	PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_CS5535_ISA, "CS5535", 0}, {
+	PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CS5536_ISA, "CS5536", 0}
 };
 
-#define MSR_LBAR_SMB		0x5140000B
+#define DIVIL_LENGTH (sizeof(divil_pci) / sizeof(divil_pci[0]))
 
 static int scx200_add_cs553x(void)
 {
-	u32	low, hi;
-	u32	smb_base;
-
-	/* Grab & reserve the SMB I/O range */
-	rdmsr(MSR_LBAR_SMB, low, hi);
+	int dev;
+	struct pci_dev *pdev;
 
-	/* Check the IO mask and whether SMB is enabled */
-	if (hi != 0x0000F001) {
-		printk(KERN_WARNING NAME ": SMBus not enabled\n");
-		return -ENODEV;
+	for (dev = 0; dev < DIVIL_LENGTH; dev++) {
+		pdev =
+		    pci_find_device(divil_pci[dev].vendor,
+				    divil_pci[dev].device, NULL);
+		if (pdev != NULL)
+			break;
 	}
 
-	/* SMBus IO size is 8 bytes */
-	smb_base = low & 0x0000FFF8;
+	if (pdev == NULL)
+		return -ENODEV;
 
-	return scx200_acb_create("CS5535", smb_base, 0);
+	return scx200_acb_create(divil_pci[dev].name, 0, 0, pdev,
+				 divil_pci[dev].bar);
 }
 
 static int __init scx200_acb_init(void)
 {
 	int i;
-	int	rc = -ENODEV;
+	int rc     = -ENODEV;
 
 	pr_debug(NAME ": NatSemi SCx200 ACCESS.bus Driver\n");
 
-	/* Verify that this really is a SCx200 processor */
-	if (pci_dev_present(scx200)) {
-		for (i = 0; i < MAX_DEVICES; ++i) {
-			if (base[i] > 0)
-				rc = scx200_acb_create("SCx200", base[i], i);
-		}
-	} else if (pci_dev_present(divil_pci))
-		rc = scx200_add_cs553x();
+	/* If this is a CS5535 or CS5536, then probe the PCI header */
+
+	if (!pci_dev_present(scx200))
+		return scx200_add_cs553x();
+
+	for (i = 0; i < MAX_DEVICES; ++i) {
+		if (base[i] > 0)
+			rc = scx200_acb_create("SCx200", base[i], i, NULL, 0);
+	}
 
 	return rc;
 }
@@ -544,7 +581,12 @@ static void __exit scx200_acb_cleanup(vo
 		up(&scx200_acb_list_mutex);
 
 		i2c_del_adapter(&iface->adapter);
-		release_region(iface->base, 8);
+
+		if (iface->pdev != NULL)
+			pci_release_region(iface->pdev, iface->bar);
+		else
+			release_region(iface->base, 8);
+
 		kfree(iface);
 		down(&scx200_acb_list_mutex);
 	}

--1LKvkjL3sHcu1TtY--

