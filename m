Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263869AbTEJKOO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 06:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbTEJKOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 06:14:14 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:13548 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S263869AbTEJKN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 06:13:59 -0400
Date: Sat, 10 May 2003 12:26:15 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc2 IDE Modular non-compile
Message-ID: <20030510102615.GB12431@louise.pinerecords.com>
References: <20030509064035.4C6612C014@lists.samba.org> <20030509075319.A10102@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030509075319.A10102@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [hch@infradead.org]
> 
> This is the patch I sent marcelo just after rc1 was released, I gues
> it will still apply..

Christoph, for a fully modular IDE (.config snippet included at the
end of the post) on .21rc2 I need to apply the following patch on top
of the one you have posted.  100% untested.

-- 
Tomas Szepe <szepe@pinerecords.com>

<cut>
diff -urN a/drivers/ide/Config.in b/drivers/ide/Config.in
--- a/drivers/ide/Config.in	2003-05-10 11:27:08.000000000 +0200
+++ b/drivers/ide/Config.in	2003-05-10 12:17:49.000000000 +0200
@@ -27,8 +27,8 @@
 
    comment 'IDE chipset support/bugfixes'
    if [ "$CONFIG_BLK_DEV_IDE" != "n" ]; then
-      dep_bool '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86
-      dep_bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
+      dep_tristate '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86
+      dep_mbool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
       dep_bool '  ISA-PNP EIDE support' CONFIG_BLK_DEV_ISAPNP $CONFIG_ISAPNP
       if [ "$CONFIG_PCI" = "y" ]; then
 	 bool '  PCI IDE chipset support' CONFIG_BLK_DEV_IDEPCI
diff -urN a/drivers/ide/Makefile b/drivers/ide/Makefile
--- a/drivers/ide/Makefile	2003-05-10 11:27:08.000000000 +0200
+++ b/drivers/ide/Makefile	2003-05-10 11:58:22.000000000 +0200
@@ -29,7 +29,7 @@
 
 # Core IDE code - must come before legacy
 
-obj-$(CONFIG_BLK_DEV_IDE)		+= ide-probe.o ide-geometry.o ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-io.o ide-default.o
+obj-$(CONFIG_BLK_DEV_IDE)		+= ide-probe.o ide-geometry.o ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-io.o ide-default.o ide-proc.o
 obj-$(CONFIG_BLK_DEV_IDEDISK)		+= ide-disk.o
 obj-$(CONFIG_BLK_DEV_IDECD)		+= ide-cd.o
 obj-$(CONFIG_BLK_DEV_IDETAPE)		+= ide-tape.o
@@ -43,11 +43,6 @@
 endif
 obj-$(CONFIG_BLK_DEV_ISAPNP)		+= ide-pnp.o
 
-
-ifeq ($(CONFIG_BLK_DEV_IDE),y)
-obj-$(CONFIG_PROC_FS)			+= ide-proc.o
-endif
-
 ifeq ($(CONFIG_BLK_DEV_IDE),y)
   obj-y		+= legacy/idedriver-legacy.o
   obj-y		+= ppc/idedriver-ppc.o
diff -urN a/drivers/ide/ide-dma.c b/drivers/ide/ide-dma.c
--- a/drivers/ide/ide-dma.c	2003-05-10 11:27:03.000000000 +0200
+++ b/drivers/ide/ide-dma.c	2003-05-10 12:06:34.000000000 +0200
@@ -1019,6 +1019,7 @@
 		return ide_release_mmio_dma(hwif);
 	return ide_release_iomio_dma(hwif);
 }
+EXPORT_SYMBOL(ide_release_dma);
 
 int ide_allocate_dma_engine (ide_hwif_t *hwif)
 {
diff -urN a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2003-05-10 11:27:03.000000000 +0200
+++ b/drivers/ide/ide-io.c	2003-05-10 12:00:36.000000000 +0200
@@ -895,6 +895,7 @@
 {
 	ide_do_request(q->queuedata, IDE_NO_IRQ);
 }
+EXPORT_SYMBOL(do_ide_request);
 
 /*
  * un-busy the hwgroup etc, and clear any pending DMA status. we want to
diff -urN a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2003-05-10 11:27:03.000000000 +0200
+++ b/drivers/ide/ide.c	2003-05-10 12:05:44.000000000 +0200
@@ -188,6 +188,7 @@
  */
 ide_module_t *ide_chipsets;
 ide_module_t *ide_modules;
+EXPORT_SYMBOL(ide_modules);
 ide_module_t *ide_probe;
 
 /*
@@ -597,6 +598,7 @@
 	{ "capacity",	S_IFREG|S_IRUGO,	proc_ide_read_capacity,	NULL },
 	{ NULL, 0, NULL, NULL }
 };
+EXPORT_SYMBOL(generic_subdriver_entries);
 #endif
 
 
@@ -1178,6 +1180,7 @@
 	}
 	return setting;
 }
+EXPORT_SYMBOL(ide_find_setting_by_name);
 
 /**
  *	auto_remove_settings	-	remove driver specific settings
@@ -1238,6 +1241,7 @@
 	}
 	return val;
 }
+EXPORT_SYMBOL(ide_read_setting);
 
 int ide_spin_wait_hwgroup (ide_drive_t *drive)
 {
@@ -1411,6 +1415,7 @@
 		ide_add_setting(drive,	"ide-scsi",		SETTING_RW,					-1,		HDIO_SET_IDE_SCSI,		TYPE_BYTE,	0,	1,				1,		1,		&drive->scsi,			ide_atapi_to_scsi);
 #endif		
 }
+EXPORT_SYMBOL(ide_add_generic_settings);
 
 /*
  * Delay for *at least* 50ms.  As we don't know how much time is left
diff -urN a/drivers/ide/setup-pci.c b/drivers/ide/setup-pci.c
--- a/drivers/ide/setup-pci.c	2003-05-10 11:27:03.000000000 +0200
+++ b/drivers/ide/setup-pci.c	2003-05-10 12:14:35.000000000 +0200
@@ -830,3 +830,4 @@
 		pci_register_driver(d);
 	}
 }
+EXPORT_SYMBOL(ide_scan_pcibus);
<cut>

CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=m
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=m
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=m
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# IDE chipset support/bugfixes
CONFIG_BLK_DEV_CMD640=m
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
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA100=m
CONFIG_BLK_DEV_AEC62XX=m
CONFIG_BLK_DEV_ALI15X3=m
# CONFIG_WDC_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=m
# CONFIG_AMD74XX_OVERRIDE is not set
CONFIG_BLK_DEV_CMD64X=m
CONFIG_BLK_DEV_TRIFLEX=m
CONFIG_BLK_DEV_CY82C693=m
CONFIG_BLK_DEV_CS5530=m
CONFIG_BLK_DEV_HPT34X=m
# CONFIG_HPT34X_AUTODMA is not set
CONFIG_BLK_DEV_HPT366=m
CONFIG_BLK_DEV_PIIX=m
CONFIG_BLK_DEV_NS87415=m
CONFIG_BLK_DEV_OPTI621=m
CONFIG_BLK_DEV_PDC202XX_OLD=m
# CONFIG_PDC202XX_BURST is not set
CONFIG_BLK_DEV_PDC202XX_NEW=m
# CONFIG_PDC202XX_FORCE is not set
CONFIG_BLK_DEV_RZ1000=m
CONFIG_BLK_DEV_SC1200=m
CONFIG_BLK_DEV_SVWKS=m
CONFIG_BLK_DEV_SIIMAGE=m
CONFIG_BLK_DEV_SIS5513=m
CONFIG_BLK_DEV_SLC90E66=m
CONFIG_BLK_DEV_TRM290=m
CONFIG_BLK_DEV_VIA82CXXX=m
# CONFIG_IDE_CHIPSETS is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_PDC202XX=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_BLK_DEV_ATARAID=m
CONFIG_BLK_DEV_ATARAID_PDC=m
CONFIG_BLK_DEV_ATARAID_HPT=m
CONFIG_BLK_DEV_ATARAID_SII=m
