Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965004AbWEBVr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWEBVr7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 17:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWEBVr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 17:47:59 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:39653 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S964996AbWEBVr4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 17:47:56 -0400
Date: Tue, 2 May 2006 23:44:32 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: David Vrabel <dvrabel@cantab.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net
Subject: [PATCH 1/2] ipg: sanitize the pci device table
Message-ID: <20060502214432.GB26357@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.58.0604281458110.19801@sbz-30.cs.Helsinki.FI> <1146306567.1642.3.camel@localhost> <20060429122119.GA22160@fargo> <1146342905.11271.3.camel@localhost> <1146389171.11524.1.camel@localhost> <44554ADE.8030200@cantab.net> <4455F1D8.5030102@cantab.net> <1146506939.23931.2.camel@localhost> <20060501231206.GD7419@electric-eye.fr.zoreil.com> <Pine.LNX.4.58.0605020945010.4066@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0605020945010.4066@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- vendor id belong to include/linux/pci_id.h ;
- the pci table does not include all the devices in nics_supported ;
- qualify the pci table as __devinitdata ;
- kill 50 LOC.

Signed-off-by: Francois Romieu <romieu@fr.zoreil.com>

---

 drivers/net/ipg.c       |   46 ++++++--------------------------
 drivers/net/ipg.h       |   67 +++++++++++------------------------------------
 include/linux/pci_ids.h |    2 +
 3 files changed, 27 insertions(+), 88 deletions(-)

aa5b322a6f91ca12a580dfa7022fca1a088b4abd
diff --git a/drivers/net/ipg.c b/drivers/net/ipg.c
index 393b617..ea7c1f8 100644
--- a/drivers/net/ipg.c
+++ b/drivers/net/ipg.c
@@ -32,40 +32,14 @@ MODULE_DESCRIPTION("IC Plus IP1000 Gigab
 		   DrvVer);
 MODULE_LICENSE("GPL");
 
-static struct pci_device_id ipg_pci_tbl[] = {
-	{PCI_VENDOR_ID_ICPLUS,
-	 PCI_DEVICE_ID_IP1000,
-	 PCI_ANY_ID,
-	 PCI_ANY_ID,
-	 0x020000,
-	 0xFFFFFF,
-	 0},
-
-	{PCI_VENDOR_ID_SUNDANCE,
-	 PCI_DEVICE_ID_SUNDANCE_ST2021,
-	 PCI_ANY_ID,
-	 PCI_ANY_ID,
-	 0x020000,
-	 0xFFFFFF,
-	 1},
-
-	{PCI_VENDOR_ID_SUNDANCE,
-	 PCI_DEVICE_ID_TAMARACK_TC9020_9021,
-	 PCI_ANY_ID,
-	 PCI_ANY_ID,
-	 0x020000,
-	 0xFFFFFF,
-	 2},
-
-	{PCI_VENDOR_ID_DLINK,
-	 PCI_DEVICE_ID_DLINK_1002,
-	 PCI_ANY_ID,
-	 PCI_ANY_ID,
-	 0x020000,
-	 0xFFFFFF,
-	 3},
-
-	{0,}
+static struct pci_device_id ipg_pci_tbl[] __devinitdata = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_SUNDANCE,	0x1023), 0, 0, 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SUNDANCE,	0x2021), 0, 0, 1 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_SUNDANCE,	0x1021), 0, 0, 2 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK,	0x9021), 0, 0, 3 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK,	0x4000), 0, 0, 4 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_DLINK,	0x4020), 0, 0, 5 },
+	{ 0, }
 };
 
 MODULE_DEVICE_TABLE(pci, ipg_pci_tbl);
@@ -2961,9 +2935,7 @@ static int __devinit ipg_probe(struct pc
 	if (rc < 0)
 		goto out;
 
-	printk(KERN_INFO "%s found.\n", nics_supported[i].NICname);
-	printk(KERN_INFO "Bus %x Slot %x\n",
-	       pdev->bus->number, PCI_SLOT(pdev->devfn));
+	printk(KERN_INFO "%s: %s\n", pci_name(pdev), nics_supported[i].name);
 
 	pci_set_master(pdev);
 
diff --git a/drivers/net/ipg.h b/drivers/net/ipg.h
index ae3424a..03bc6f1 100644
--- a/drivers/net/ipg.h
+++ b/drivers/net/ipg.h
@@ -589,34 +589,6 @@ #define IPG_RI_RXDMAWAIT_TIME           
  *	Tune
  */
 
-#ifndef PCI_VENDOR_ID_ICPLUS
-#  define       PCI_VENDOR_ID_ICPLUS            0x13F0
-#endif
-#ifndef PCI_DEVICE_ID_IP1000
-#  define       PCI_DEVICE_ID_IP1000		    0x1023
-#endif
-#ifndef PCI_VENDOR_ID_SUNDANCE
-#  define       PCI_VENDOR_ID_SUNDANCE          0x13F0
-#endif
-#ifndef PCI_DEVICE_ID_SUNDANCE_IPG
-#  define       PCI_DEVICE_ID_SUNDANCE_ST2021   0x2021
-#endif
-#ifndef PCI_DEVICE_ID_TAMARACK_TC9020_9021_ALT
-#  define       PCI_DEVICE_ID_TAMARACK_TC9020_9021_ALT 0x9021
-#endif
-#ifndef PCI_DEVICE_ID_TAMARACK_TC9020_9021
-#  define       PCI_DEVICE_ID_TAMARACK_TC9020_9021 0x1021
-#endif
-#ifndef PCI_VENDOR_ID_DLINK
-#  define       PCI_VENDOR_ID_DLINK             0x1186
-#endif
-#ifndef PCI_DEVICE_ID_DLINK_1002
-#  define       PCI_DEVICE_ID_DLINK_1002        0x4000
-#endif
-#ifndef PCI_DEVICE_ID_DLINK_IP1000A
-#  define PCI_DEVICE_ID_DLINK_IP1000A		0x4020
-#endif
-
 /* Miscellaneous Constants. */
 #define   TRUE  1
 #define   FALSE 0
@@ -990,32 +962,25 @@ #endif
 };
 
 struct nic_id {
-	char *NICname;
-	int vendorid;
-	int deviceid;
+	char *name;
+	u32 vendor;
+	u32 device;
 };
 
 struct nic_id nics_supported[] = {
-	{"IC PLUS IP1000 1000/100/10 based NIC",
-	 PCI_VENDOR_ID_ICPLUS,
-	 PCI_DEVICE_ID_IP1000},
-	{"Sundance Technology ST2021 based NIC",
-	 PCI_VENDOR_ID_SUNDANCE,
-	 PCI_DEVICE_ID_SUNDANCE_ST2021},
-	{"Tamarack Microelectronics TC9020/9021 based NIC",
-	 PCI_VENDOR_ID_SUNDANCE,
-	 PCI_DEVICE_ID_TAMARACK_TC9020_9021},
-	{"Tamarack Microelectronics TC9020/9021 based NIC",
-	 PCI_VENDOR_ID_SUNDANCE,
-	 PCI_DEVICE_ID_TAMARACK_TC9020_9021_ALT},
-	{"D-Link NIC",
-	 PCI_VENDOR_ID_DLINK,
-	 PCI_DEVICE_ID_DLINK_1002},
-	{"D-Link NIC IP1000A",
-	 PCI_VENDOR_ID_DLINK,
-	 PCI_DEVICE_ID_DLINK_IP1000A},
-
-	{"N/A", 0xFFFF, 0}
+	{ "IC PLUS IP1000 1000/100/10 based NIC",
+		PCI_VENDOR_ID_SUNDANCE,	0x1023 },
+	{ "Sundance Technology ST2021 based NIC",
+		PCI_VENDOR_ID_SUNDANCE,	0x2021 },
+	{ "Tamarack Microelectronics TC9020/9021 based NIC",
+		PCI_VENDOR_ID_SUNDANCE, 0x1021 },
+	{ "Tamarack Microelectronics TC9020/9021 based NIC",
+		PCI_VENDOR_ID_SUNDANCE, 0x9021 },
+	{ "D-Link NIC",
+		PCI_VENDOR_ID_DLINK,	0x4000 },
+	{ "D-Link NIC IP1000A",
+		PCI_VENDOR_ID_DLINK,	0x4020 },
+	{ NULL, 0xffff, 0 }
 };
 
 //variable record -- index by leading revision/length
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d6fe048..b772f2b 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -1788,6 +1788,8 @@ #define PCI_DEVICE_ID_IOMEGA_BUZ	0x4231
 #define PCI_VENDOR_ID_ABOCOM		0x13D1
 #define PCI_DEVICE_ID_ABOCOM_2BD1       0x2BD1
 
+#define PCI_VENDOR_ID_SUNDANCE		0x13f0
+
 #define PCI_VENDOR_ID_CMEDIA		0x13f6
 #define PCI_DEVICE_ID_CMEDIA_CM8338A	0x0100
 #define PCI_DEVICE_ID_CMEDIA_CM8338B	0x0101
-- 
1.3.1

