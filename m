Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVBBCsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVBBCsj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 21:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVBBCrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 21:47:17 -0500
Received: from [211.58.254.17] ([211.58.254.17]:33929 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262220AbVBBCqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:46:17 -0500
Date: Wed, 2 Feb 2005 11:46:11 +0900
From: Tejun Heo <tj@home-tj.org>
To: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2 04/29] ide: cleanup piix
Message-ID: <20050202024611.GE621@htj.dyndns.org>
References: <20050202024017.GA621@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202024017.GA621@htj.dyndns.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 04_ide_cleanup_piix.patch
> 
> 	In drivers/ide/pci/piix.[hc], init_setup_piix() is defined and
> 	used but only one init_setup function is defined and no
> 	demultiplexing is done using init_setup callback.  As other
> 	drivers call ide_setup_pci_device() directly in such cases,
> 	this patch removes init_setup_piix() and makes piix_init_one()
> 	call ide_setup_pci_device() directly.


Signed-off-by: Tejun Heo <tj@home-tj.org>                                       

Index: linux-ide-export/drivers/ide/pci/piix.c
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/piix.c	2005-02-02 10:27:16.255142809 +0900
+++ linux-ide-export/drivers/ide/pci/piix.c	2005-02-02 10:28:02.317669535 +0900
@@ -531,20 +531,6 @@ static void __devinit init_hwif_piix(ide
 }
 
 /**
- *	init_setup_piix		-	callback for IDE initialize
- *	@dev: PIIX PCI device
- *	@d: IDE pci info
- *
- *	Enable the xp fixup for the PIIX controller and then perform
- *	a standard ide PCI setup
- */
-
-static int __devinit init_setup_piix(struct pci_dev *dev, ide_pci_device_t *d)
-{
-	return ide_setup_pci_device(dev, d);
-}
-
-/**
  *	piix_init_one	-	called when a PIIX is found
  *	@dev: the piix device
  *	@id: the matching pci id
@@ -557,7 +543,7 @@ static int __devinit piix_init_one(struc
 {
 	ide_pci_device_t *d = &piix_pci_info[id->driver_data];
 
-	return d->init_setup(dev, d);
+	return ide_setup_pci_device(dev, d);
 }
 
 /**
Index: linux-ide-export/drivers/ide/pci/piix.h
===================================================================
--- linux-ide-export.orig/drivers/ide/pci/piix.h	2005-02-02 10:27:16.255142809 +0900
+++ linux-ide-export/drivers/ide/pci/piix.h	2005-02-02 10:28:02.317669535 +0900
@@ -5,14 +5,12 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 
-static int init_setup_piix(struct pci_dev *, ide_pci_device_t *);
 static unsigned int __devinit init_chipset_piix(struct pci_dev *, const char *);
 static void init_hwif_piix(ide_hwif_t *);
 
 #define DECLARE_PIIX_DEV(name_str) \
 	{						\
 		.name		= name_str,		\
-		.init_setup	= init_setup_piix,	\
 		.init_chipset	= init_chipset_piix,	\
 		.init_hwif	= init_hwif_piix,	\
 		.channels	= 2,			\
@@ -32,7 +30,6 @@ static ide_pci_device_t piix_pci_info[] 
 
 	{	/* 2 */
 		.name		= "MPIIX",
-		.init_setup	= init_setup_piix,
 		.init_hwif	= init_hwif_piix,
 		.channels	= 2,
 		.autodma	= NODMA,
