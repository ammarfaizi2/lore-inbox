Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbVFIWiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVFIWiR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 18:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVFIWiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 18:38:17 -0400
Received: from gateway.penguincomputing.com ([64.243.132.186]:23356 "EHLO
	inside.penguincomputing.com") by vger.kernel.org with ESMTP
	id S262491AbVFIWiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 18:38:05 -0400
Message-ID: <42A8C4C1.4030700@penguincomputing.com>
Date: Thu, 09 Jun 2005 15:37:53 -0700
From: Tymm Twillman <ttwillman@penguincomputing.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.31 - nforce chipset timer override bios bug workaround
Content-Type: multipart/mixed;
 boundary="------------020903000201080004000100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020903000201080004000100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

In the 2.4.30/31 kernels there is now a backport from the 2.6 kernels of 
a workaround for buggy timer overrides in the ACPI tables for many 
nvidia chipset based motherboards.  Unfortunately the code for this on 
x86-64 based systems is conditionally compiled in only for non-SMP 
kernels.  This is a patch to remove the conditional and allow the code 
to be compiled in for SMP kernels as well (we've seen a number of SMP 
motherboards which intermittently lock up during boot, and otherwise 
sometimes seem unstable without the workaround).  Patch so far has been 
tested across numerous reboots and several hours uptime.

Also part of this patch is modifications to avoid referencing the 
variable "swiotlb" from pci-gart.c when CONFIG_SWIOTLB is not set; 
without modification, an x86_64 kernel without CONFIG_SWIOTLB set breaks 
during compilation of arch/x86_64/kernel/pci-gart.c.

All small changes & straightforward; don't think there's anything to 
worry about WRT enabling the override workaround code on SMP boxes, 
although I'd appreciate verification from someone more familiar with the 
setup code.

Thanks,

-Tymm

--------------020903000201080004000100
Content-Type: text/x-patch;
 name="linux-2.4.31-nforce-smp-timer-override-plus-swiotlb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.31-nforce-smp-timer-override-plus-swiotlb.patch"

diff -urN linux-2.4.31-vanilla/arch/x86_64/kernel/io_apic.c linux-2.4.31/arch/x86_64/kernel/io_apic.c
--- linux-2.4.31-vanilla/arch/x86_64/kernel/io_apic.c	2005-04-03 18:42:19.000000000 -0700
+++ linux-2.4.31/arch/x86_64/kernel/io_apic.c	2005-06-10 03:12:22.000000000 -0700
@@ -222,7 +222,6 @@
 
 __setup("apic", ioapic_setup);
 
-#ifndef CONFIG_SMP
 #include <asm/pci-direct.h>
 #include <linux/pci_ids.h>
 #include <linux/pci.h>
@@ -279,7 +278,6 @@
 		}
 	}
 } 
-#endif
 
 static int __init ioapic_pirq_setup(char *str)
 {
diff -urN linux-2.4.31-vanilla/arch/x86_64/kernel/pci-gart.c linux-2.4.31/arch/x86_64/kernel/pci-gart.c
--- linux-2.4.31-vanilla/arch/x86_64/kernel/pci-gart.c	2005-05-31 17:56:56.000000000 -0700
+++ linux-2.4.31/arch/x86_64/kernel/pci-gart.c	2005-06-10 04:45:54.000000000 -0700
@@ -155,7 +155,12 @@
 	int i;
 	unsigned long iommu_page;
 
+#ifdef CONFIG_SWIOTLB
 	if (hwdev == NULL || hwdev->dma_mask < 0xffffffff || (no_iommu && !swiotlb))
+#else
+	if (hwdev == NULL || hwdev->dma_mask < 0xffffffff || (no_iommu))
+
+#endif
 		gfp |= GFP_DMA;
 
 	/* 
diff -urN linux-2.4.31-vanilla/arch/x86_64/kernel/setup.c linux-2.4.31/arch/x86_64/kernel/setup.c
--- linux-2.4.31-vanilla/arch/x86_64/kernel/setup.c	2005-04-03 18:42:19.000000000 -0700
+++ linux-2.4.31/arch/x86_64/kernel/setup.c	2005-06-10 04:57:36.000000000 -0700
@@ -51,8 +51,10 @@
 int acpi_disabled;
 EXPORT_SYMBOL(acpi_disabled);
 
+#ifdef CONFIG_SWIOTLB
 int swiotlb;
 EXPORT_SYMBOL(swiotlb);
+#endif
 
 extern	int phys_proc_id[NR_CPUS];
 
@@ -304,7 +306,7 @@
 #endif
 
 	paging_init();
-#if !defined(CONFIG_SMP) && defined(CONFIG_X86_IO_APIC)
+#if defined(CONFIG_X86_IO_APIC)
 	extern void check_ioapic(void);
 	check_ioapic();
 #endif

--------------020903000201080004000100--
