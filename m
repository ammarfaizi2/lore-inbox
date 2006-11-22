Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161869AbWKVIGD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161869AbWKVIGD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 03:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161877AbWKVIGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 03:06:01 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:30359 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1161869AbWKVIF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 03:05:59 -0500
Message-ID: <4564050C.70607@jp.fujitsu.com>
Date: Wed, 22 Nov 2006 17:06:36 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Cc: Greg KH <greg@kroah.com>, Grant Grundler <grundler@parisc-linux.org>,
       Andrew Morton <akpm@osdl.org>, e1000-devel@lists.sourceforge.net,
       linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 4/5] e1000 : Make Intel e1000 driver legacy I/O port free
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes Intel e1000 driver legacy I/O port free.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>

---
 drivers/net/e1000/e1000.h      |    6 +
 drivers/net/e1000/e1000_main.c |  146 ++++++++++++++++++++++-------------------
 2 files changed, 83 insertions(+), 69 deletions(-)

Index: linux-2.6.19-rc6/drivers/net/e1000/e1000.h
===================================================================
--- linux-2.6.19-rc6.orig/drivers/net/e1000/e1000.h
+++ linux-2.6.19-rc6/drivers/net/e1000/e1000.h
@@ -75,8 +75,9 @@
 #define BAR_1		1
 #define BAR_5		5

-#define INTEL_E1000_ETHERNET_DEVICE(device_id) {\
-	PCI_DEVICE(PCI_VENDOR_ID_INTEL, device_id)}
+#define E1000_USE_IOPORT	(1 << 0)
+#define INTEL_E1000_ETHERNET_DEVICE(device_id, flags) {\
+	PCI_DEVICE(PCI_VENDOR_ID_INTEL, device_id), .driver_data = flags}

 struct e1000_adapter;

@@ -342,6 +343,7 @@
 	boolean_t quad_port_a;
 	unsigned long flags;
 	uint32_t eeprom_wol;
+	int bars;		/* BARs to be enabled */
 };

 enum e1000_state_t {
Index: linux-2.6.19-rc6/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.19-rc6.orig/drivers/net/e1000/e1000_main.c
+++ linux-2.6.19-rc6/drivers/net/e1000/e1000_main.c
@@ -47,62 +47,62 @@
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
-	INTEL_E1000_ETHERNET_DEVICE(0x1049),
-	INTEL_E1000_ETHERNET_DEVICE(0x104A),
-	INTEL_E1000_ETHERNET_DEVICE(0x104B),
-	INTEL_E1000_ETHERNET_DEVICE(0x104C),
-	INTEL_E1000_ETHERNET_DEVICE(0x104D),
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
-	INTEL_E1000_ETHERNET_DEVICE(0x10A4),
-	INTEL_E1000_ETHERNET_DEVICE(0x10B5),
-	INTEL_E1000_ETHERNET_DEVICE(0x10B9),
-	INTEL_E1000_ETHERNET_DEVICE(0x10BA),
-	INTEL_E1000_ETHERNET_DEVICE(0x10BB),
+	INTEL_E1000_ETHERNET_DEVICE(0x1000, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1001, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1004, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1008, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1009, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x100C, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x100D, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x100E, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x100F, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1010, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1011, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1012, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1013, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1014, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1015, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1016, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1017, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1018, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1019, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x101A, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x101D, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x101E, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1026, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1027, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1028, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1049, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x104A, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x104B, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x104C, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x104D, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x105E, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x105F, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1060, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1075, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1076, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1077, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1078, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x1079, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x107A, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x107B, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x107C, E1000_USE_IOPORT),
+	INTEL_E1000_ETHERNET_DEVICE(0x107D, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x107E, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x107F, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x108A, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x108B, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x108C, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1096, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1098, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x1099, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x109A, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x10A4, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x10B5, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x10B9, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x10BA, 0),
+	INTEL_E1000_ETHERNET_DEVICE(0x10BB, 0),
 	/* required last entry */
 	{0,}
 };
@@ -735,7 +735,14 @@
 	int i, err, pci_using_dac;
 	uint16_t eeprom_data = 0;
 	uint16_t eeprom_apme_mask = E1000_EEPROM_APME;
-	if ((err = pci_enable_device(pdev)))
+	int bars;
+
+	if (ent->driver_data & E1000_USE_IOPORT)
+		bars = pci_select_bars(pdev, IORESOURCE_MEM | IORESOURCE_IO);
+	else
+		bars = pci_select_bars(pdev, IORESOURCE_MEM);
+
+	if ((err = pci_enable_device_bars(pdev, bars)))
 		return err;

 	if (!(err = pci_set_dma_mask(pdev, DMA_64BIT_MASK)) &&
@@ -750,7 +757,8 @@
 		pci_using_dac = 0;
 	}

-	if ((err = pci_request_regions(pdev, e1000_driver_name)))
+	err = pci_request_selected_regions(pdev, bars, e1000_driver_name);
+	if (err)
 		goto err_pci_reg;

 	pci_set_master(pdev);
@@ -769,6 +777,7 @@
 	adapter->pdev = pdev;
 	adapter->hw.back = adapter;
 	adapter->msg_enable = (1 << debug) - 1;
+	adapter->bars = bars;

 	mmio_start = pci_resource_start(pdev, BAR_0);
 	mmio_len = pci_resource_len(pdev, BAR_0);
@@ -778,12 +787,15 @@
 	if (!adapter->hw.hw_addr)
 		goto err_ioremap;

-	for (i = BAR_1; i <= BAR_5; i++) {
-		if (pci_resource_len(pdev, i) == 0)
-			continue;
-		if (pci_resource_flags(pdev, i) & IORESOURCE_IO) {
-			adapter->hw.io_base = pci_resource_start(pdev, i);
-			break;
+	if (ent->driver_data & E1000_USE_IOPORT) {
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

@@ -1050,7 +1062,7 @@
 err_ioremap:
 	free_netdev(netdev);
 err_alloc_etherdev:
-	pci_release_regions(pdev);
+	pci_release_selected_regions(pdev, bars);
 err_pci_reg:
 err_dma:
 	pci_disable_device(pdev);
@@ -1111,7 +1123,7 @@
 	iounmap(adapter->hw.hw_addr);
 	if (adapter->hw.flash_address)
 		iounmap(adapter->hw.flash_address);
-	pci_release_regions(pdev);
+	pci_release_selected_regions(pdev, adapter->bars);

 	free_netdev(netdev);

@@ -4824,7 +4836,7 @@

 	pci_set_power_state(pdev, PCI_D0);
 	e1000_pci_restore_state(adapter);
-	if ((err = pci_enable_device(pdev))) {
+	if ((err = pci_enable_device_bars(pdev, adapter->bars))) {
 		printk(KERN_ERR "e1000: Cannot enable PCI device from suspend\n");
 		return err;
 	}

