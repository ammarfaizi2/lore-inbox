Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264231AbUGSLBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbUGSLBW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jul 2004 07:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUGSLBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jul 2004 07:01:22 -0400
Received: from math.ut.ee ([193.40.5.125]:18941 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S264231AbUGSLBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jul 2004 07:01:17 -0400
Date: Mon, 19 Jul 2004 14:01:16 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [2.4 PATCH] problems with modular and nonmodular ide mix
Message-ID: <Pine.GSO.4.44.0407191332150.14892-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to figure out an unresolved modules symbol on PPC
(2.4.27-BK): init_cmd640_vlb(). This is used in ide.c and defined in
pci/cmd640.c. It appears that nothing from drivers/ide/pci is compiled
at all - make traverses the directory but nothing gets compiled.
Relevant part of .config is below.

So at least sl82c105 and cmd640 should get compiled but don't.

I suspected that since IDE is modular, only drivers configured as
modules are compiled but not static ones. I set sl82c105 to M and it was
compiled.

So the problem is that cmd640 can only be compiled in statically but not
into modular IDE. What about the patch below to fix this? It builds
and loads fine here, but it only fixes an obscure configuration.

CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDISK_STROKE=y
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_IDE_TASK_IOCTL=y
#
# IDE chipset support/bugfixes
#
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
# CONFIG_BLK_DEV_ISAPNP is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
# CONFIG_BLK_DEV_ADMA100 is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_ATIIXP is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX_OLD is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_BLK_DEV_PDC202XX_NEW is not set
# CONFIG_BLK_DEV_RZ1000 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIIMAGE is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_BLK_DEV_SL82C105=y
# CONFIG_BLK_DEV_IDE_PMAC is not set
# CONFIG_BLK_DEV_IDE_PMAC_ATA100FIRST is not set
# CONFIG_BLK_DEV_IDEDMA_PMAC is not set
# CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO is not set
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set
# CONFIG_BLK_DEV_ATARAID_MEDLEY is not set
# CONFIG_BLK_DEV_ATARAID_SII is not set

===== drivers/ide/Config.in 1.41 vs edited =====
--- 1.41/drivers/ide/Config.in	2004-05-22 23:30:37 +03:00
+++ edited/drivers/ide/Config.in	2004-07-19 13:58:33 +03:00
@@ -27,8 +27,10 @@

    comment 'IDE chipset support/bugfixes'
    if [ "$CONFIG_BLK_DEV_IDE" != "n" ]; then
-      dep_bool '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86
-      dep_bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
+      dep_tristate '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86
+      if [ "$CONFIG_BLK_DEV_CMD640" != "n" ]; then
+         bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED
+      fi
       dep_bool '  ISA-PNP EIDE support' CONFIG_BLK_DEV_ISAPNP $CONFIG_ISAPNP
       if [ "$CONFIG_PCI" = "y" ]; then
 	 bool '  PCI IDE chipset support' CONFIG_BLK_DEV_IDEPCI

-- 
Meelis Roos (mroos@linux.ee)

