Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265274AbUFAWcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265274AbUFAWcu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 18:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbUFAWbm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 18:31:42 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13221 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265263AbUFAWaa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 18:30:30 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IDE update [9/10]
Date: Wed, 2 Jun 2004 00:21:36 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406020021.36249.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: remove useless /proc/ide/siimage from siimage.c

It only gives (not mapped in case of MMIO) DMA base addresses.
The same info is given during driver initialization (if BM-DMA is used)
or can be obtained from 'lspci -v' output (if MMIO-DMA is used).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/siimage.c |   80 -----------------
 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/siimage.h |    3 
 2 files changed, 83 deletions(-)

diff -puN drivers/ide/pci/siimage.c~siimage_proc drivers/ide/pci/siimage.c
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/siimage.c~siimage_proc	2004-06-01 20:03:02.767077224 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/siimage.c	2004-06-01 20:03:02.774076160 +0200
@@ -21,7 +21,6 @@
  *	if neccessary
  */
 
-#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -34,15 +33,6 @@
 
 #include "siimage.h"
 
-#if defined(DISPLAY_SIIMAGE_TIMINGS) && defined(CONFIG_PROC_FS)
-#include <linux/proc_fs.h>
-
-static u8 siimage_proc = 0;
-#define SIIMAGE_MAX_DEVS		16
-static struct pci_dev *siimage_devs[SIIMAGE_MAX_DEVS];
-static int n_siimage_devs;
-#endif /* defined(DISPLAY_SIIMAGE_TIMINGS) && defined(CONFIG_PROC_FS) */
-
 /**
  *	pdev_is_sata		-	check if device is SATA
  *	@pdev:	PCI device to check
@@ -121,67 +111,6 @@ static inline unsigned long siimage_seld
 	return base;
 }
 
-#if defined(DISPLAY_SIIMAGE_TIMINGS) && defined(CONFIG_PROC_FS)
-/**
- *	print_siimage_get_info	-	print minimal proc information
- *	@buf: buffer to write into (kernel space)
- *	@dev: PCI device we are describing
- *	@index: Controller number
- *
- *	Print the basic information for the state of the CMD680/SI3112
- *	channel. We don't actually dump a lot of information out for
- *	this controller although we could expand it if we needed.
- */
- 
-static char *print_siimage_get_info (char *buf, struct pci_dev *dev, int index)
-{
-	char *p		= buf;
-	u8 mmio		= (pci_get_drvdata(dev) != NULL) ? 1 : 0;
-	unsigned long bmdma = pci_resource_start(dev, 4);
-	
-	if(mmio)
-		bmdma = pci_resource_start(dev, 5);
-
-	p += sprintf(p, "\nController: %d\n", index);
-	p += sprintf(p, "SiI%x Chipset.\n", dev->device);
-	if (mmio)
-		p += sprintf(p, "MMIO Base 0x%lx\n", bmdma);
-	p += sprintf(p, "%s-DMA Base 0x%lx\n", (mmio)?"MMIO":"BM", bmdma);
-	p += sprintf(p, "%s-DMA Base 0x%lx\n", (mmio)?"MMIO":"BM", bmdma+8);
-	return (char *)p;
-}
-
-/**
- *	siimage_get_info	-	proc callback
- *	@buffer: kernel buffer to complete
- *	@addr: written with base of data to return
- *	offset: seek offset
- *	count: bytes to fill in 
- *
- *	Called when the user reads data from the virtual file for this
- *	controller from /proc
- */
- 
-static int siimage_get_info (char *buffer, char **addr, off_t offset, int count)
-{
-	char *p = buffer;
-	int len;
-	u16 i;
-
-	p += sprintf(p, "\n");
-	for (i = 0; i < n_siimage_devs; i++) {
-		struct pci_dev *dev	= siimage_devs[i];
-		p = print_siimage_get_info(p, dev, i);
-	}
-	/* p - buffer must be less than 4k! */
-	len = (p - buffer) - offset;
-	*addr = buffer + offset;
-	
-	return len > count ? count : len;
-}
-
-#endif	/* defined(DISPLAY_SIIMAGE_TIMINGS) && defined(CONFIG_PROC_FS) */
-
 /**
  *	siimage_ratemask	-	Compute available modes
  *	@drive: IDE drive
@@ -779,15 +708,6 @@ static void proc_reports_siimage (struct
 			case 0x00: printk("== 100\n"); break;
 		}
 	}
-
-#if defined(DISPLAY_SIIMAGE_TIMINGS) && defined(CONFIG_PROC_FS)
-	siimage_devs[n_siimage_devs++] = dev;
-
-	if (!siimage_proc) {
-		siimage_proc = 1;
-		ide_pci_create_host_proc("siimage", siimage_get_info);
-	}
-#endif /* DISPLAY_SIIMAGE_TIMINGS && CONFIG_PROC_FS */
 }
 
 /**
diff -puN drivers/ide/pci/siimage.h~siimage_proc drivers/ide/pci/siimage.h
--- linux-2.6.7-rc2-bk2/drivers/ide/pci/siimage.h~siimage_proc	2004-06-01 20:03:02.770076768 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/pci/siimage.h	2004-06-01 20:03:02.775076008 +0200
@@ -1,14 +1,11 @@
 #ifndef SIIMAGE_H
 #define SIIMAGE_H
 
-#include <linux/config.h>
 #include <linux/pci.h>
 #include <linux/ide.h>
 
 #include <asm/io.h>
 
-#define DISPLAY_SIIMAGE_TIMINGS
-
 #undef SIIMAGE_VIRTUAL_DMAPIO
 #undef SIIMAGE_BUFFERED_TASKFILE
 #undef SIIMAGE_LARGE_DMA

_

