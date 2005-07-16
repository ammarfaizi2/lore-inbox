Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbVGPORX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbVGPORX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 10:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVGPORS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 10:17:18 -0400
Received: from 64-60-240-146.cust.telepacific.net ([64.60.240.146]:41190 "EHLO
	Netcell.com") by vger.kernel.org with ESMTP id S261622AbVGPORM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 10:17:12 -0400
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dd3a477a1dcd51760fca4c6e4af3a986@netcell.com>
Content-Transfer-Encoding: 7bit
Cc: linux-ide@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
From: Matt Gillette <matt.gillette@netcell.com>
Subject: [PATCH 2.6.13-rc3] Add support for Netcell Revolution to pci-ide generic driver
Date: Sat, 16 Jul 2005 07:17:04 -0700
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.622)
X-OriginalArrivalTime: 16 Jul 2005 14:17:48.0171 (UTC) FILETIME=[248525B0:01C58A11]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Adds support for Netcell Revolution to pci-ide generic 
driver by including it in the list of devices matched. Includes the 
Revolution in the list of simplex devices forced into DMA mode.

Signed-off-by: Matt Gillette <matt.gillette@netcell.com>
-------

diff -purN linux-2.6.13-rc3/drivers/ide/pci/generic.c 
linux/drivers/ide/pci/generic.c
--- linux-2.6.13-rc3/drivers/ide/pci/generic.c	2005-07-14 
18:02:17.000000000 -0700
+++ linux/drivers/ide/pci/generic.c	2005-07-15 15:33:00.000000000 -0700
@@ -173,7 +173,13 @@ static ide_pci_device_t generic_chipsets
  		.channels	= 2,
  		.autodma	= NOAUTODMA,
  		.bootable	= ON_BOARD,
-	}
+	},{	/* 14 */
+		.name		= "Revolution",
+                .init_hwif      = init_hwif_generic,
+                .channels       = 2,
+                .autodma        = AUTODMA,
+                .bootable       = OFF_BOARD,
+        }
  };

  /**
@@ -231,6 +237,7 @@ static struct pci_device_id generic_pci_
  	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO,     
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11},
  	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1,   
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},
  	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2,   
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13},
+	{ PCI_VENDOR_ID_NETCELL,PCI_DEVICE_ID_REVOLUTION,          
PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14},	
  	/* Must come last. If you add entries adjust this table appropriately 
and the init_one code */
  	{ PCI_ANY_ID,		PCI_ANY_ID,			   PCI_ANY_ID, PCI_ANY_ID, 
PCI_CLASS_STORAGE_IDE << 8, 0xFFFFFF00UL, 0},
  	{ 0, },
diff -purN linux-2.6.13-rc3/drivers/ide/setup-pci.c 
linux/drivers/ide/setup-pci.c
--- linux-2.6.13-rc3/drivers/ide/setup-pci.c	2005-07-14 
18:02:17.000000000 -0700
+++ linux/drivers/ide/setup-pci.c	2005-07-15 14:43:26.000000000 -0700
@@ -229,6 +229,7 @@ second_chance_to_dma:
  			case PCI_DEVICE_ID_AMD_VIPER_7409:
  			case PCI_DEVICE_ID_CMD_643:
  			case PCI_DEVICE_ID_SERVERWORKS_CSB5IDE:
+			case PCI_DEVICE_ID_REVOLUTION:
  				simplex_stat = hwif->INB(dma_base + 2);
  				hwif->OUTB((simplex_stat&0x60),(dma_base + 2));
  				simplex_stat = hwif->INB(dma_base + 2);
diff -purN linux-2.6.13-rc3/drivers/pci/pci.ids 
linux/drivers/pci/pci.ids
--- linux-2.6.13-rc3/drivers/pci/pci.ids	2005-07-14 18:02:07.000000000 
-0700
+++ linux/drivers/pci/pci.ids	2005-07-16 06:28:32.000000000 -0700
@@ -7982,7 +7982,7 @@
  		168c 2042  Netgate 5354MP Plus ARIES2 a/b/g MiniPCI Adapter
  	1014  AR5212 802.11abg NIC
  169c  Netcell Corporation
-	0044  SyncRAID SR3000/5000 Series SATA RAID Controllers
+	0044  Revolution Storage Processing Card
  16a5  Tekram Technology Co.,Ltd.
  16ab  Global Sun Technology Inc
  	1100  GL24110P
diff -purN linux-2.6.13-rc3/include/linux/pci_ids.h 
linux/include/linux/pci_ids.h
--- linux-2.6.13-rc3/include/linux/pci_ids.h	2005-07-14 
18:01:56.000000000 -0700
+++ linux/include/linux/pci_ids.h	2005-07-15 14:43:26.000000000 -0700
@@ -2170,6 +2170,9 @@
  #define PCI_VENDOR_ID_SIBYTE		0x166d
  #define PCI_DEVICE_ID_BCM1250_HT	0x0002

+#define PCI_VENDOR_ID_NETCELL		0x169c
+#define PCI_DEVICE_ID_REVOLUTION	0x0044
+
  #define PCI_VENDOR_ID_LINKSYS		0x1737
  #define PCI_DEVICE_ID_LINKSYS_EG1032	0x1032
  #define PCI_DEVICE_ID_LINKSYS_EG1064	0x1064

