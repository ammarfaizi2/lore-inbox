Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751261AbWECWfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWECWfl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 18:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWECWfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 18:35:41 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:60906 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S1751261AbWECWfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 18:35:41 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.17-rc3-mm1 breaks AGP on amd64 boxes in 32 bit mode
Date: Thu, 4 May 2006 00:33:33 +0200
User-Agent: KMail/1.9.1
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605040033.33579.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.17-rc3-mm1 breaks AGP on amd64 boxes in 32 bit mode - a change in the 
related Kconfig file forces the agp-amd64 module to be built only on x86_64, 
simply reverting that bit introduces unresolved symbols k8_nb_ids and 
k8_northbridges (defined but not exported).

Signed-off-by: Bernhard Rosenkraenzer <bero@arklinux.org>
---
diff -urNp linux-2.6.16/drivers/char/agp/Kconfig 
linux-2.6.16-driworx/drivers/char/agp/Kconfig
--- linux-2.6.16/drivers/char/agp/Kconfig	2006-05-02 23:30:35.000000000 +0200
+++ linux-2.6.16-driworx/drivers/char/agp/Kconfig	2006-05-02 
22:57:48.000000000 +0200
@@ -56,7 +56,7 @@ config AGP_AMD
 
 config AGP_AMD64
 	tristate "AMD Opteron/Athlon64 on-CPU GART support" if !GART_IOMMU
-	depends on AGP && X86_64
+	depends on AGP && X86
 	default y if GART_IOMMU
 	help
 	  This option gives you AGP support for the GLX component of
--- linux-2.6.16/arch/x86_64/kernel/k8.c.ark	2006-05-03 21:37:35.000000000 
+0200
+++ linux-2.6.16-driworx/arch/x86_64/kernel/k8.c	2006-05-03 21:38:10.000000000 
+0200
@@ -20,8 +20,10 @@ struct pci_device_id k8_nb_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x1203) },
 	{}
 };
+EXPORT_SYMBOL_GPL(k8_nb_ids); // for amd64-agp
 
 struct pci_dev **k8_northbridges;
+EXPORT_SYMBOL_GPL(k8_northbridges); // for amd64-agp
 
 static struct pci_dev *next_k8_northbridge(struct pci_dev *dev)
 {
