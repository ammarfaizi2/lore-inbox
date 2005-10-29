Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbVJ2ACw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbVJ2ACw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 20:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVJ2ACw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 20:02:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:55003 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750850AbVJ2ACv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 20:02:51 -0400
Subject: Re: PPC32 - No IDE/ATA devices on new PowerBook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org
In-Reply-To: <05700451-DD42-4BBE-9DB2-8705B88548BF@comcast.net>
References: <15DF6933-2475-439D-BE0A-DC232B92FDB7@comcast.net>
	 <1130540164.29054.130.camel@gaston>
	 <05700451-DD42-4BBE-9DB2-8705B88548BF@comcast.net>
Content-Type: text/plain
Date: Sat, 29 Oct 2005 10:02:20 +1000
Message-Id: <1130544140.29054.144.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-28 at 19:24 -0400, Parag Warudkar wrote:

> Thanks. I tried 2.4 kernel and to my surprise it detected the IDE/ATA  
> controller! (Although it balked out with errors - read past the end  
> of the device or something...).

2.4 used the device-tree exclusively for probing IDE on pmac, while 2.6
uses PCI probing when it's a PCI device. The device-tree method tend to
work even when we don't have the PCI ID, but it's dangerous: the driver
doesn't know the details of the timings for this chip revision etc...
and thus may well do crap. I wouldn't try too much with 2.4.

Can you try this patch ? If you don't have a way to build a patched
kernel, you may find somebody on linuxppc-dev list who can do it for
you.

Index: linux-work/drivers/ide/ppc/pmac.c
===================================================================
--- linux-work.orig/drivers/ide/ppc/pmac.c	2005-09-22 14:06:32.000000000 +1000
+++ linux-work/drivers/ide/ppc/pmac.c	2005-10-29 10:00:03.000000000 +1000
@@ -1664,11 +1664,16 @@
 };
 
 static struct pci_device_id pmac_ide_pci_match[] = {
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_UNI_N_ATA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_IPID_ATA100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
-	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_K2_ATA100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_UNI_N_ATA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_IPID_ATA100,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_K2_ATA100,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_SH_ATA,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_IPIDD2_ATA,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 };
 
 static struct pci_driver pmac_ide_pci_driver = {
Index: linux-work/include/linux/pci_ids.h
===================================================================
--- linux-work.orig/include/linux/pci_ids.h	2005-10-06 09:59:14.000000000 +1000
+++ linux-work/include/linux/pci_ids.h	2005-10-29 09:59:06.000000000 +1000
@@ -912,6 +912,7 @@
 #define PCI_DEVICE_ID_APPLE_SH_FW       0x0052
 #define PCI_DEVICE_ID_APPLE_U3L_AGP	0x0058
 #define PCI_DEVICE_ID_APPLE_U3H_AGP	0x0059
+#define PCI_DEVICE_ID_APPLE_IPIDD2_ATA  0x0069
 #define PCI_DEVICE_ID_APPLE_TIGON3	0x1645
 
 #define PCI_VENDOR_ID_YAMAHA		0x1073




