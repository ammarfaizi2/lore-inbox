Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030478AbWBNGK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbWBNGK6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030479AbWBNGK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:10:58 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:16548 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030478AbWBNGK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:10:57 -0500
Message-ID: <43F173FD.4070401@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 15:09:01 +0900
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
CC: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [RFC][PATCH 3/4] PCI legacy I/O port free driver - Make Intel e1000
 driver legacy I/O port free
References: <43F172BA.1020405@jp.fujitsu.com>
In-Reply-To: <43F172BA.1020405@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes e1000 driver pci legacy free.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

 drivers/net/e1000/e1000_main.c |   34 ++++++++++++++++++++++++++++------
 1 files changed, 28 insertions(+), 6 deletions(-)

Index: linux-2.6.16-rc3/drivers/net/e1000/e1000_main.c
===================================================================
--- linux-2.6.16-rc3.orig/drivers/net/e1000/e1000_main.c	2006-02-14 12:25:08.000000000 +0900
+++ linux-2.6.16-rc3/drivers/net/e1000/e1000_main.c	2006-02-14 12:28:06.000000000 +0900
@@ -642,6 +642,18 @@
 	}
 }
 
+static inline int need_io_port(struct pci_dev *pdev)
+{
+	switch (pdev->device) {
+	case 0x1008: case 0x1009: case 0x100c: case 0x100d: case 0x100e:
+	case 0x1015: case 0x1016: case 0x1017: case 0x101e: case 0x100f:
+	case 0x1011: case 0x1010: case 0x1012: case 0x101d: case 0x1013:
+	case 0x1018: case 0x1078: case 0x1076: case 0x107c: case 0x1077:
+		return 1;
+	}
+	return 0;
+}
+
 /**
  * e1000_probe - Device Initialization Routine
  * @pdev: PCI device information struct
@@ -666,6 +678,11 @@
 	int i, err, pci_using_dac;
 	uint16_t eeprom_data;
 	uint16_t eeprom_apme_mask = E1000_EEPROM_APME;
+	int need_io = need_io_port(pdev);
+
+	if (!need_io)
+		pci_set_bar_mask_by_resource(pdev, IORESOURCE_MEM);
+
 	if ((err = pci_enable_device(pdev)))
 		return err;
 
@@ -709,12 +726,15 @@
 		goto err_ioremap;
 	}
 
-	for (i = BAR_1; i <= BAR_5; i++) {
-		if (pci_resource_len(pdev, i) == 0)
-			continue;
-		if (pci_resource_flags(pdev, i) & IORESOURCE_IO) {
-			adapter->hw.io_base = pci_resource_start(pdev, i);
-			break;
+	if (need_io) {
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
 
@@ -4683,6 +4703,8 @@
 	if (retval)
 		DPRINTK(PROBE, ERR, "Error in setting power state\n");
 	e1000_pci_restore_state(adapter);
+	if (!need_io_port(pdev))
+		pci_set_bar_mask_by_resource(pdev, IORESOURCE_MEM);
 	ret_val = pci_enable_device(pdev);
 	pci_set_master(pdev);
 


