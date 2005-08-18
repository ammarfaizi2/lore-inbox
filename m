Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932488AbVHRV4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488AbVHRV4l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 17:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932487AbVHRV4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 17:56:41 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:8953 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S932484AbVHRV4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 17:56:40 -0400
Date: Thu, 18 Aug 2005 23:37:49 +0200 (CEST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git patches] ide update
Message-ID: <Pine.GSO.4.62.0508182332470.22579@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

3 obvious fixes + support for 2 new controllers
(just new PCI IDs).

Please pull from:
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/bart/ide-2.6.git

diffstat/changelog/patch below
--
Bartlomiej


  drivers/ide/Kconfig           |    1 +
  drivers/ide/ide-floppy.c      |    2 +-
  drivers/ide/pci/generic.c     |    7 +++++++
  drivers/ide/pci/serverworks.c |   23 +++++++++++++++++++++++
  drivers/ide/ppc/pmac.c        |    2 +-
  drivers/ide/setup-pci.c       |    1 +
  include/linux/pci_ids.h       |    6 +++++-
  7 files changed, 39 insertions(+), 3 deletions(-)


commit 84f57fbc724e3b56dc87c37dddac89f82cf75ef6
Author: Narendra Sankar <nsankar@broadcom.com>
Date:   Thu Aug 18 22:30:35 2005 +0200

     [PATCH] serverworks: add support for new southbridge IDE

     BCM5785 (HT1000) is a Opteron Southbridge from Serverworks/Broadcom that
     incorporates a single channel ATA100 IDE controller that is functionally
     identical to the Serverworks CSB6 IDE controller.  This patch adds support
     for the new PCI device ID and also the support for this controller.

     Signed-off-by: Narendra Sankar <nsankar@broadcom.com>
     Acked-by: Jeff Garzik <jgarzik@pobox.com>

commit 2f09a7f4af131bf23c013ead89373deba1c7593c
Author: Matt Gillette <matt.gillette@netcell.com>
Date:   Thu Aug 18 22:27:07 2005 +0200

     [PATCH] ide: add support for Netcell Revolution to pci-ide generic driver

     Adds support for Netcell Revolution to pci-ide generic driver by including
     it in the list of devices matched.  Includes the Revolution in the list of
     simplex devices forced into DMA mode.

     Signed-off-by: Matt Gillette <matt.gillette@netcell.com>
     Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
     Cc: Jeff Garzik <jgarzik@pobox.com>
     Signed-off-by: Andrew Morton <akpm@osdl.org>

commit b07e5eccaf512ae3209beae5cd2e3a27c92c300b
Author: Grant Coady <gcoady@gmail.com>
Date:   Thu Aug 18 22:19:55 2005 +0200

     [PATCH] ide: fix PCI_DEVIEC_ID_APPLE_UNI_N_ATA spelling

     Signed-off-by: Grant Coady <gcoady@gmail.com>

commit 0ac72b351bdf29252e4181b07fa7feed8501b5d2
Author: Juha-Matti Tapio <jmtapio@verkkotelakka.net>
Date:   Thu Aug 18 22:13:44 2005 +0200

     [PATCH] ide: fix the BLK_DEV_IDEDMA_PCI dependency for drivers/ide/ppc/pmac.c

     drivers/ide/ppc/pmac.c uses symbols ide_build_sglist,
     __ide_dma_off_quietly, __ide_dma_on and __ide_dma_timeout when
     CONFIG_BLK_DEV_IDEDMA_PMAC is defined. The declarations for these
     symbols (in ide.h) depend on CONFIG_BLK_DEV_IDEDMA_PCI. There is a
     missing dependency for this in drivers/ide/Kconfig which causes
     drivers/ide/ppc/pmac.c to fail to build if CONFIG_BLK_DEV_IDEDMA_PMAC
     is selected but CONFIG_BLK_DEV_IDEDMA_PCI is not.

     Signed-off-by: Juha-Matti Tapio <jmtapio@verkkotelakka.net>

commit c40d3d38a8f04fff4394c7323db239bce780db60
Author: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Date:   Thu Aug 18 22:09:21 2005 +0200

     [PATCH] ide-floppy: fix IDEFLOPPY_TICKS_DELAY

     * IDEFLOPPY_TICKS_DELAY assumed HZ == 100, fix it
     * increase the delay to 50ms (to match comment in the code)

     Thanks to Manfred Scherer <manfred.scherer.mhm@t-online.de>
     for reporting the problem and testing the patch.



diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -764,6 +764,7 @@ config BLK_DEV_IDE_PMAC_ATA100FIRST
  config BLK_DEV_IDEDMA_PMAC
  	bool "PowerMac IDE DMA support"
  	depends on BLK_DEV_IDE_PMAC
+	select BLK_DEV_IDEDMA_PCI
  	help
  	  This option allows the driver for the built-in IDE controller on
  	  Power Macintoshes and PowerBooks to use DMA (direct memory access)
diff --git a/drivers/ide/ide-floppy.c b/drivers/ide/ide-floppy.c
--- a/drivers/ide/ide-floppy.c
+++ b/drivers/ide/ide-floppy.c
@@ -317,7 +317,7 @@ typedef struct ide_floppy_obj {
  	unsigned long flags;
  } idefloppy_floppy_t;

-#define IDEFLOPPY_TICKS_DELAY	3	/* default delay for ZIP 100 */
+#define IDEFLOPPY_TICKS_DELAY	HZ/20	/* default delay for ZIP 100 (50ms) */

  /*
   *	Floppy flag bits values.
diff --git a/drivers/ide/pci/generic.c b/drivers/ide/pci/generic.c
--- a/drivers/ide/pci/generic.c
+++ b/drivers/ide/pci/generic.c
@@ -173,6 +173,12 @@ static ide_pci_device_t generic_chipsets
  		.channels	= 2,
  		.autodma	= NOAUTODMA,
  		.bootable	= ON_BOARD,
+	},{	/* 14 */
+		.name		= "Revolution",
+		.init_hwif	= init_hwif_generic,
+		.channels	= 2,
+		.autodma	= AUTODMA,
+		.bootable	= OFF_BOARD,
  	}
  };

@@ -231,6 +237,7 @@ static struct pci_device_id generic_pci_
  	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO,     PCI_ANY_ID, PCI_ANY_ID, 0, 0, 11},
  	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_1,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 12},
  	{ PCI_VENDOR_ID_TOSHIBA,PCI_DEVICE_ID_TOSHIBA_PICCOLO_2,   PCI_ANY_ID, PCI_ANY_ID, 0, 0, 13},
+	{ PCI_VENDOR_ID_NETCELL,PCI_DEVICE_ID_REVOLUTION,          PCI_ANY_ID, PCI_ANY_ID, 0, 0, 14},
  	/* Must come last. If you add entries adjust this table appropriately and the init_one code */
  	{ PCI_ANY_ID,		PCI_ANY_ID,			   PCI_ANY_ID, PCI_ANY_ID, PCI_CLASS_STORAGE_IDE << 8, 0xFFFFFF00UL, 0},
  	{ 0, },
diff --git a/drivers/ide/pci/serverworks.c b/drivers/ide/pci/serverworks.c
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -21,6 +21,9 @@
   *
   *   CSB6: `Champion South Bridge' IDE Interface (optional: third channel)
   *
+ *   HT1000: AKA BCM5785 - Hypertransport Southbridge for Opteron systems. IDE
+ *   controller same as the CSB6. Single channel ATA100 only.
+ *
   * Documentation:
   *	Available under NDA only. Errata info very hard to get.
   *
@@ -71,6 +74,8 @@ static u8 svwks_ratemask (ide_drive_t *d
  	if (!svwks_revision)
  		pci_read_config_byte(dev, PCI_REVISION_ID, &svwks_revision);

+	if (dev->device == PCI_DEVICE_ID_SERVERWORKS_HT1000IDE)
+		return 2;
  	if (dev->device == PCI_DEVICE_ID_SERVERWORKS_OSB4IDE) {
  		u32 reg = 0;
  		if (isa_dev)
@@ -109,6 +114,7 @@ static u8 svwks_csb_check (struct pci_de
  		case PCI_DEVICE_ID_SERVERWORKS_CSB5IDE:
  		case PCI_DEVICE_ID_SERVERWORKS_CSB6IDE:
  		case PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2:
+		case PCI_DEVICE_ID_SERVERWORKS_HT1000IDE:
  			return 1;
  		default:
  			break;
@@ -438,6 +444,13 @@ static unsigned int __devinit init_chips
  			btr |= (svwks_revision >= SVWKS_CSB5_REVISION_NEW) ? 0x3 : 0x2;
  		pci_write_config_byte(dev, 0x5A, btr);
  	}
+	/* Setup HT1000 SouthBridge Controller - Single Channel Only */
+	else if (dev->device == PCI_DEVICE_ID_SERVERWORKS_HT1000IDE) {
+		pci_read_config_byte(dev, 0x5A, &btr);
+		btr &= ~0x40;
+		btr |= 0x3;
+		pci_write_config_byte(dev, 0x5A, btr);
+	}

  	return (dev->irq) ? dev->irq : 0;
  }
@@ -629,6 +642,15 @@ static ide_pci_device_t serverworks_chip
  		.channels	= 1,	/* 2 */
  		.autodma	= AUTODMA,
  		.bootable	= ON_BOARD,
+	},{	/* 4 */
+		.name		= "SvrWks HT1000",
+		.init_setup	= init_setup_svwks,
+		.init_chipset	= init_chipset_svwks,
+		.init_hwif	= init_hwif_svwks,
+		.init_dma	= init_dma_svwks,
+		.channels	= 1,	/* 2 */
+		.autodma	= AUTODMA,
+		.bootable	= ON_BOARD,
  	}
  };

@@ -653,6 +675,7 @@ static struct pci_device_id svwks_pci_tb
  	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 1},
  	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 2},
  	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 3},
+	{ PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_HT1000IDE, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 4},
  	{ 0, },
  };
  MODULE_DEVICE_TABLE(pci, svwks_pci_tbl);
diff --git a/drivers/ide/ppc/pmac.c b/drivers/ide/ppc/pmac.c
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -1664,7 +1664,7 @@ static struct macio_driver pmac_ide_maci
  };

  static struct pci_device_id pmac_ide_pci_match[] = {
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVIEC_ID_APPLE_UNI_N_ATA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_UNI_N_ATA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
  	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_IPID_ATA100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
  	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_K2_ATA100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
  	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_SH_ATA,
diff --git a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
--- a/drivers/ide/setup-pci.c
+++ b/drivers/ide/setup-pci.c
@@ -229,6 +229,7 @@ second_chance_to_dma:
  			case PCI_DEVICE_ID_AMD_VIPER_7409:
  			case PCI_DEVICE_ID_CMD_643:
  			case PCI_DEVICE_ID_SERVERWORKS_CSB5IDE:
+			case PCI_DEVICE_ID_REVOLUTION:
  				simplex_stat = hwif->INB(dma_base + 2);
  				hwif->OUTB((simplex_stat&0x60),(dma_base + 2));
  				simplex_stat = hwif->INB(dma_base + 2);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -881,7 +881,7 @@
  #define PCI_DEVICE_ID_APPLE_UNI_N_PCI15	0x002e
  #define PCI_DEVICE_ID_APPLE_UNI_N_FW2	0x0030
  #define PCI_DEVICE_ID_APPLE_UNI_N_GMAC2	0x0032
-#define PCI_DEVIEC_ID_APPLE_UNI_N_ATA	0x0033
+#define PCI_DEVICE_ID_APPLE_UNI_N_ATA	0x0033
  #define PCI_DEVICE_ID_APPLE_UNI_N_AGP2	0x0034
  #define PCI_DEVICE_ID_APPLE_IPID_ATA100	0x003b
  #define PCI_DEVICE_ID_APPLE_KEYLARGO_I	0x003e
@@ -1580,6 +1580,7 @@
  #define PCI_DEVICE_ID_SERVERWORKS_OSB4IDE 0x0211
  #define PCI_DEVICE_ID_SERVERWORKS_CSB5IDE 0x0212
  #define PCI_DEVICE_ID_SERVERWORKS_CSB6IDE 0x0213
+#define PCI_DEVICE_ID_SERVERWORKS_HT1000IDE 0x0214
  #define PCI_DEVICE_ID_SERVERWORKS_CSB6IDE2 0x0217
  #define PCI_DEVICE_ID_SERVERWORKS_OSB4USB 0x0220
  #define PCI_DEVICE_ID_SERVERWORKS_CSB5USB PCI_DEVICE_ID_SERVERWORKS_OSB4USB
@@ -2184,6 +2185,9 @@
  #define PCI_VENDOR_ID_SIBYTE		0x166d
  #define PCI_DEVICE_ID_BCM1250_HT	0x0002

+#define PCI_VENDOR_ID_NETCELL		0x169c
+#define PCI_DEVICE_ID_REVOLUTION	0x0044
+
  #define PCI_VENDOR_ID_LINKSYS		0x1737
  #define PCI_DEVICE_ID_LINKSYS_EG1032	0x1032
  #define PCI_DEVICE_ID_LINKSYS_EG1064	0x1064
