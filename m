Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVBBCoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVBBCoL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 21:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVBBCoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 21:44:11 -0500
Received: from [211.58.254.17] ([211.58.254.17]:17289 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262215AbVBBCnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:43:55 -0500
Date: Wed, 2 Feb 2005 11:43:53 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 01/29] ide: remove adma100
Message-ID: <20050202024353.GB621@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 01_ide_remove_adma100.patch
> 
> 	Removes drivers/ide/pci/adma100.[hc].  The driver isn't
> 	compilable (missing functions) and no Kconfig actually enables
> 	CONFIG_BLK_DEV_ADMA100.


Signed-off-by: Tejun Heo <tj@home-tj.org>                                       

Index: linux-ide-export/drivers/ide/pci/Makefile
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/Makefile	2005-02-02 10:27:16.466108583 +0900
+++ linux-ide-export/drivers/ide/pci/Makefile	2005-02-02 10:28:01.257841491 +0900
@@ -1,5 +1,4 @@
 
-obj-$(CONFIG_BLK_DEV_ADMA100)		+= adma100.o
 obj-$(CONFIG_BLK_DEV_AEC62XX)		+= aec62xx.o
 obj-$(CONFIG_BLK_DEV_ALI15X3)		+= alim15x3.o
 obj-$(CONFIG_BLK_DEV_AMD74XX)		+= amd74xx.o
Index: linux-ide-export/drivers/ide/pci/adma100.c
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/adma100.c	2005-02-02 10:27:16.466108583 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,30 +0,0 @@
-/*
- *  linux/drivers/ide/pci/adma100.c -- basic support for Pacific Digital ADMA-100 boards
- *
- *     Created 09 Apr 2002 by Mark Lord
- *
- *  This file is subject to the terms and conditions of the GNU General Public
- *  License.  See the file COPYING in the main directory of this archive for
- *  more details.
- */
-
-#include <linux/mm.h>
-#include <linux/blkdev.h>
-#include <linux/hdreg.h>
-#include <linux/ide.h>
-#include <linux/init.h>
-#include <linux/pci.h>
-#include <asm/io.h>
-
-void __init ide_init_adma100 (ide_hwif_t *hwif)
-{
-	unsigned long  phy_admctl = pci_resource_start(hwif->pci_dev, 4) + 0x80 + (hwif->channel * 0x20);
-	void *v_admctl;
-
-	hwif->autodma = 0;		// not compatible with normal IDE DMA transfers
-	hwif->dma_base = 0;		// disable DMA completely
-	hwif->io_ports[IDE_CONTROL_OFFSET] += 4;	// chip needs offset of 6 instead of 2
-	v_admctl = ioremap_nocache(phy_admctl, 1024);	// map config regs, so we can turn on drive IRQs
-	*((unsigned short *)v_admctl) &= 3;		// enable aIEN; preserve PIO mode
-	iounmap(v_admctl);				// all done; unmap config regs
-}
Index: linux-ide-export/drivers/ide/pci/adma100.h
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/adma100.h	2005-02-02 10:27:16.466108583 +0900
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,28 +0,0 @@
-#ifndef ADMA_100_H
-#define ADMA_100_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-extern void init_setup_pdcadma(struct pci_dev *, ide_pci_device_t *);
-extern unsigned int init_chipset_pdcadma(struct pci_dev *, const char *);
-extern void init_hwif_pdcadma(ide_hwif_t *);
-extern void init_dma_pdcadma(ide_hwif_t *, unsigned long);
-
-static ide_pci_device_t pdcadma_chipsets[] __devinitdata = {
-	{
-		.vendor		= PCI_VENDOR_ID_PDC,
-		.device		= PCI_DEVICE_ID_PDC_1841,
-		.name		= "ADMA100",
-		.init_setup	= init_setup_pdcadma,
-		.init_chipset	= init_chipset_pdcadma,
-		.init_hwif	= init_hwif_pdcadma,
-		.init_dma	= init_dma_pdcadma,
-		.channels	= 2,
-		.autodma	= NODMA,
-		.bootable	= OFF_BOARD,
-	}
-}
-
-#endif /* ADMA_100_H */
