Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423144AbWCXFmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423144AbWCXFmE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 00:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423149AbWCXFmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 00:42:04 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:34968 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1423148AbWCXFmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 00:42:01 -0500
Message-ID: <442384EA.60606@jp.fujitsu.com>
Date: Fri, 24 Mar 2006 14:34:34 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 2.6.16-mm1 3/4] PCI legacy I/O port free driver (take 6) -
 Make Intel e1000 driver legacy I/O port free
References: <442382F1.2050300@jp.fujitsu.com>
In-Reply-To: <442382F1.2050300@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes Intel e1000 driver legacy I/O port free.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/net/e1000/e1000.h      |    6 +-
 drivers/net/e1000/e1000_main.c |  123 ++++++++++++++++++++++-------------------
 2 files changed, 71 insertions(+), 58 deletions(-)

Index: linux-2.6.16-mm1/drivers/net/e1000/e1000.h
===================================================================
--- linux-2.6.16-mm1.orig/drivers/net/e1000/e1000.h	2006-03-23 20:04:06.000000000 +0900
+++ linux-2.6.16-mm1/drivers/net/e1000/e1000.h	2006-03-23 20:04:13.000000000 +0900
@@ -77,8 +77,9 @@
 #define BAR_1		1
 #define BAR_5		5
 
-#define INTEL_E1000_ETHERNET_DEVICE(device_id) {\
-	PCI_DEVICE(PCI_VENDOR_ID_INTEL, device_id)}
+#define E1000_NO_IOPORT	(1 << 0)
+#define INTEL_E1000_ETHERNET_DEVICE(device_id, flags) {\
+	PCI_DEVICE(PCI_VENDOR_ID_INTEL, device_id), .driver_data = flags}
 
 struct e1000_adapter;
 
@@ -338,6 +339,7 @@
 #ifdef NETIF_F_TSO
 	boolean_t tso_force;
 #endif
+	int bars;	/* BARs to be enabled */
 };
 
 
Index: linux-2.6.16-mm1/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.16-mm1.orig/drivers/net/e1000/e1000_main.c	2006-03-23 20:04:06.000000000 +0900
+++ linux-2.6.16-mm1/drivers/net/e1000/e1000_main.c	2006-03-23 20:04:13.000000000 +0900
@@ -86,54 +86,54 @@
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
-	INTEL_E1000_ETHERNET_DEVICE(0x1096),
-	INTEL_E1000_ETHERNET_DEVICE(0x1098),
-	INTEL_E1000_ETHERNET_DEVICE(0x1099),
-	INTEL_E1000_ETHERNET_DEVICE(0x109A),
-	INTEL_E1000_ETHERNET_DEVICE(0x10B5),
-	INTEL_E1000_ETHERNET_DEVICE(0x10B9),
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
+	INTEL_E1000_ETHERNET_DEVICE(0x1096, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1098, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1099, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x109A, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x10B5, E1000_NO_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x10B9, 0),
 	/* required last entry */
 	{0,}
 };
@@ -619,7 +619,14 @@
 	int i, err, pci_using_dac;
 	uint16_t eeprom_data;
 	uint16_t eeprom_apme_mask = E1000_EEPROM_APME;
-	if ((err = pci_enable_device(pdev)))
+	int bars;
+
+	if (ent->driver_data & E1000_NO_IOPORT)
+		bars = pci_select_bars(pdev, IORESOURCE_MEM);
+	else
+		bars = pci_select_bars(pdev, IORESOURCE_MEM | IORESOURCE_IO);
+
+	if ((err = pci_enable_device_bars(pdev, bars)))
 		return err;
 
 	if (!(err = pci_set_dma_mask(pdev, DMA_64BIT_MASK))) {
@@ -652,6 +659,7 @@
 	adapter->pdev = pdev;
 	adapter->hw.back = adapter;
 	adapter->msg_enable = (1 << debug) - 1;
+	adapter->bars = bars;
 
 	mmio_start = pci_resource_start(pdev, BAR_0);
 	mmio_len = pci_resource_len(pdev, BAR_0);
@@ -662,12 +670,15 @@
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
 
@@ -4575,7 +4586,7 @@
 	if (retval)
 		DPRINTK(PROBE, ERR, "Error in setting power state\n");
 	e1000_pci_restore_state(adapter);
-	ret_val = pci_enable_device(pdev);
+	ret_val = pci_enable_device_bars(pdev, adapter->bars);
 	pci_set_master(pdev);
 
 	retval = pci_enable_wake(pdev, PCI_D3hot, 0);

