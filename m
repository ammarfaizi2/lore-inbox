Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbULABiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbULABiQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 20:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbULABfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 20:35:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:59566 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261157AbULABec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 20:34:32 -0500
Date: Tue, 30 Nov 2004 17:23:54 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: gregkh <greg@kroah.com>, ak@suse.de
Subject: [PATCH] PCI/x86-64: build with PCI=n
Message-Id: <20041130172354.2bd60e89.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix (most of) x64-64 kernel build for CONFIG_PCI=n.  Fixes these 2 errors:

1. arch/x86_64/kernel/built-in.o(.text+0x8186): In function `quirk_intel_irqbalance':
: undefined reference to `raw_pci_ops'

Kconfig change:
2. arch/x86_64/kernel/pci-gart.c:194: error: `pci_bus_type' undeclared (first use in this function)

Still does not fix this one:
drivers/built-in.o(.text+0x3dcd8): In function `pnpacpi_allocated_resource':
: undefined reference to `pcibios_penalize_isa_irq'

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 arch/i386/kernel/quirks.c |    3 ++-
 arch/x86_64/Kconfig       |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff -Naurp ./arch/i386/kernel/quirks.c~config_pci ./arch/i386/kernel/quirks.c
--- ./arch/i386/kernel/quirks.c~config_pci	2004-11-15 10:01:58.430206024 -0800
+++ ./arch/i386/kernel/quirks.c	2004-11-16 11:24:25.204385552 -0800
@@ -1,10 +1,11 @@
 /*
  * This file contains work-arounds for x86 and x86_64 platform bugs.
  */
+#include <linux/config.h>
 #include <linux/pci.h>
 #include <linux/irq.h>
 
-#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_SMP)
+#if defined(CONFIG_X86_IO_APIC) && defined(CONFIG_SMP) && defined(CONFIG_PCI)
 
 void __devinit quirk_intel_irqbalance(struct pci_dev *dev)
 {
diff -Naurp ./arch/x86_64/Kconfig~config_pci ./arch/x86_64/Kconfig
--- ./arch/x86_64/Kconfig~config_pci	2004-11-15 10:01:58.985121664 -0800
+++ ./arch/x86_64/Kconfig	2004-11-16 10:50:00.987194264 -0800
@@ -306,6 +306,7 @@ config NR_CPUS
 
 config GART_IOMMU
 	bool "IOMMU support"
+	depends on PCI
 	help
 	  Support the K8 IOMMU. Needed to run systems with more than 4GB of memory
 	  properly with 32-bit PCI devices that do not support DAC (Double Address


---
