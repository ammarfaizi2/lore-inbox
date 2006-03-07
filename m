Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWCGGAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWCGGAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 01:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWCGGAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 01:00:32 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:40636 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751261AbWCGGAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 01:00:31 -0500
Message-ID: <440D211D.9050806@jp.fujitsu.com>
Date: Tue, 07 Mar 2006 14:58:53 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 3/4] PCI legacy I/O port free driver (take5) - Make Intel
 e1000 driver legacy I/O port free
References: <440D1FEC.1070701@jp.fujitsu.com>
In-Reply-To: <440D1FEC.1070701@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes Intel e1000 driver legacy I/O port free.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/net/e1000/e1000.h      |    6 +-
 drivers/net/e1000/e1000_main.c |  117 ++++++++++++++++++++++-------------------
 2 files changed, 68 insertions(+), 55 deletions(-)

Index: linux-2.6.16-rc5-mm2/drivers/net/e1000/e1000.h
===================================================================
--- linux-2.6.16-rc5-mm2.orig/drivers/net/e1000/e1000.h	2006-03-07 14:06:49.000000000 +0900
+++ linux-2.6.16-rc5-mm2/drivers/net/e1000/e1000.h	2006-03-07 14:07:21.000000000 +0900
@@ -77,8 +77,9 @@
 #define BAR_1		1
 #define BAR_5		5
 
-#define INTEL_E1000_ETHERNET_DEVICE(device_id) {\
-	PCI_DEVICE(PCI_VENDOR_ID_INTEL, device_id)}
+#define E1000_NO_IOPORT	(1 << 0)
+#define INTEL_E1000_ETHERNET_DEVICE(device_id, flags) {\
+	PCI_DEVICE(PCI_VENDOR_ID_INTEL, device_id), .driver_data = flags}
 
 struct e1000_adapter;
 
@@ -358,6 +359,7 @@
 #ifdef CONFIG_PCI_MSI
 	boolean_t have_msi;
 #endif
+	int bars;	/* BARs to be enabled */
 };
 
 
Index: linux-2.6.16-rc5-mm2/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.16-rc5-mm2.orig/drivers/net/e1000/e1000_main.c	2006-03-07 14:06:49.000000000 +0900
+++ linux-2.6.16-rc5-mm2/drivers/net/e1000/e1000_main.c	2006-03-07 14:07:21.000000000 +0900
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
@@ -652,7 +652,14 @@
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
@@ -685,6 +692,7 @@
 	adapter->pdev = pdev;
 	adapter->hw.back = adapter;
 	adapter->msg_enable = (1 << debug) - 1;
+	adapter->bars = bars;
 
 	mmio_start = pci_resource_start(pdev, BAR_0);
 	mmio_len = pci_resource_len(pdev, BAR_0);
@@ -695,12 +703,15 @@
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
 
@@ -4642,7 +4653,7 @@
 	if (retval)
 		DPRINTK(PROBE, ERR, "Error in setting power state\n");
 	e1000_pci_restore_state(adapter);
-	ret_val = pci_enable_device(pdev);
+	ret_val = pci_enable_device_bars(pdev, adapter->bars);
 	pci_set_master(pdev);
 
 	retval = pci_enable_wake(pdev, PCI_D3hot, 0);

