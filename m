Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWB0E40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWB0E40 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 23:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWB0E40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 23:56:26 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:23501 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750922AbWB0E4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 23:56:23 -0500
Message-ID: <440285D9.4050700@jp.fujitsu.com>
Date: Mon, 27 Feb 2006 13:53:45 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
CC: Kenji Kaneshige <kaneshige.kenji@soft.fujitsu.com>,
       Andi Kleen <ak@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       benh@kernel.crashing.org
Subject: [PATCH 3/4] PCI legacy I/O port free driver (take 3) - Make Intel
 e1000 driver legacy I/O port free
References: <44028502.4000108@soft.fujitsu.com>
In-Reply-To: <44028502.4000108@soft.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes Intel e1000 driver legacy I/O port free.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/net/e1000/e1000.h      |    5 +
 drivers/net/e1000/e1000_main.c |  109 +++++++++++++++++++++--------------------
 2 files changed, 61 insertions(+), 53 deletions(-)

Index: linux-2.6.16-rc4/drivers/net/e1000/e1000.h
===================================================================
--- linux-2.6.16-rc4.orig/drivers/net/e1000/e1000.h	2006-02-27 13:29:34.000000000 +0900
+++ linux-2.6.16-rc4/drivers/net/e1000/e1000.h	2006-02-27 13:29:45.000000000 +0900
@@ -77,8 +77,9 @@
 #define BAR_1		1
 #define BAR_5		5
 
-#define INTEL_E1000_ETHERNET_DEVICE(device_id) {\
-	PCI_DEVICE(PCI_VENDOR_ID_INTEL, device_id)}
+#define E1000_NO_IOPORT	(1 << 0)
+#define INTEL_E1000_ETHERNET_DEVICE(device_id, flags) {\
+	PCI_DEVICE(PCI_VENDOR_ID_INTEL, device_id), .driver_data = flags}
 
 struct e1000_adapter;
 
Index: linux-2.6.16-rc4/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.16-rc4.orig/drivers/net/e1000/e1000_main.c	2006-02-27 13:29:34.000000000 +0900
+++ linux-2.6.16-rc4/drivers/net/e1000/e1000_main.c	2006-02-27 13:29:45.000000000 +0900
@@ -115,51 +115,51 @@
  *   {PCI_DEVICE(PCI_VENDOR_ID_INTEL, device_id)}
  */
 static struct pci_device_id e1000_pci_tbl[] = {
-	INTEL_E1000_ETHERNET_DEVICE(0x1000),
-	INTEL_E1000_ETHERNET_DEVICE(0x1001),
-	INTEL_E1000_ETHERNET_DEVICE(0x1004),
-	INTEL_E1000_ETHERNET_DEVICE(0x1008),
-	INTEL_E1000_ETHERNET_DEVICE(0x1009),
-	INTEL_E1000_ETHERNET_DEVICE(0x100C),
-	INTEL_E1000_ETHERNET_DEVICE(0x100D),
-	INTEL_E1000_ETHERNET_DEVICE(0x100E),
-	INTEL_E1000_ETHERNET_DEVICE(0x100F),
-	INTEL_E1000_ETHERNET_DEVICE(0x1010),
-	INTEL_E1000_ETHERNET_DEVICE(0x1011),
-	INTEL_E1000_ETHERNET_DEVICE(0x1012),
-	INTEL_E1000_ETHERNET_DEVICE(0x1013),
-	INTEL_E1000_ETHERNET_DEVICE(0x1014),
-	INTEL_E1000_ETHERNET_DEVICE(0x1015),
-	INTEL_E1000_ETHERNET_DEVICE(0x1016),
-	INTEL_E1000_ETHERNET_DEVICE(0x1017),
-	INTEL_E1000_ETHERNET_DEVICE(0x1018),
-	INTEL_E1000_ETHERNET_DEVICE(0x1019),
-	INTEL_E1000_ETHERNET_DEVICE(0x101A),
-	INTEL_E1000_ETHERNET_DEVICE(0x101D),
-	INTEL_E1000_ETHERNET_DEVICE(0x101E),
-	INTEL_E1000_ETHERNET_DEVICE(0x1026),
-	INTEL_E1000_ETHERNET_DEVICE(0x1027),
-	INTEL_E1000_ETHERNET_DEVICE(0x1028),
-	INTEL_E1000_ETHERNET_DEVICE(0x105E),
-	INTEL_E1000_ETHERNET_DEVICE(0x105F),
-	INTEL_E1000_ETHERNET_DEVICE(0x1060),
-	INTEL_E1000_ETHERNET_DEVICE(0x1075),
-	INTEL_E1000_ETHERNET_DEVICE(0x1076),
-	INTEL_E1000_ETHERNET_DEVICE(0x1077),
-	INTEL_E1000_ETHERNET_DEVICE(0x1078),
-	INTEL_E1000_ETHERNET_DEVICE(0x1079),
-	INTEL_E1000_ETHERNET_DEVICE(0x107A),
-	INTEL_E1000_ETHERNET_DEVICE(0x107B),
-	INTEL_E1000_ETHERNET_DEVICE(0x107C),
-	INTEL_E1000_ETHERNET_DEVICE(0x107D),
-	INTEL_E1000_ETHERNET_DEVICE(0x107E),
-	INTEL_E1000_ETHERNET_DEVICE(0x107F),
-	INTEL_E1000_ETHERNET_DEVICE(0x108A),
-	INTEL_E1000_ETHERNET_DEVICE(0x108B),
-	INTEL_E1000_ETHERNET_DEVICE(0x108C),
-	INTEL_E1000_ETHERNET_DEVICE(0x1099),
-	INTEL_E1000_ETHERNET_DEVICE(0x109A),
-	INTEL_E1000_ETHERNET_DEVICE(0x10B5),
+	INTEL_E1000_ETHERNET_DEVICE(0x1000, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1001, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1004, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1008, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1009, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x100C, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x100D, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x100E, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x100F, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1010, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1011, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1012, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1013, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1014, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1015, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1016, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1017, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1018, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1019, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x101A, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x101D, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x101E, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1026, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1027, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1028, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x105E, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x105F, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1060, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1075, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1076, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1077, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1078, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1079, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x107A, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x107B, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x107C, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x107D, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x107E, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x107F, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x108A, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x108B, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x108C, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1099, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x109A, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x10B5, E1000_NO_IOPORT),
 	/* required last entry */
 	{0,}
 };
@@ -666,6 +666,10 @@
 	int i, err, pci_using_dac;
 	uint16_t eeprom_data;
 	uint16_t eeprom_apme_mask = E1000_EEPROM_APME;
+
+	/* See if the device needs I/O port */
+	pdev->no_ioport = !!(ent->driver_data & E1000_NO_IOPORT);
+
 	if ((err = pci_enable_device(pdev)))
 		return err;
 
@@ -709,12 +713,15 @@
 		goto err_ioremap;
 	}
 
-	for (i = BAR_1; i <= BAR_5; i++) {
-		if (pci_resource_len(pdev, i) == 0)
-			continue;
-		if (pci_resource_flags(pdev, i) & IORESOURCE_IO) {
-			adapter->hw.io_base = pci_resource_start(pdev, i);
-			break;
+	if (!(ent->driver_data & E1000_NO_IOPORT)) {
+		for (i = BAR_1; i <= BAR_5; i++) {
+			if (pci_resource_len(pdev, i) == 0)
+				continue;
+			if (pci_resource_flags(pdev, i) & IORESOURCE_IO) {
+				adapter->hw.io_base =
+					pci_resource_start(pdev, i);
+				break;
+			}
 		}
 	}
 

