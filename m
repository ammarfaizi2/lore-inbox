Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWJIE2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWJIE2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 00:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWJIE2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 00:28:43 -0400
Received: from mail01.verismonetworks.com ([164.164.99.228]:50124 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S932232AbWJIE2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 00:28:43 -0400
Subject: [PATCH] arch/i386: ioremap balanced with iounmap
From: Amol Lad <amol@verismonetworks.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 10:02:00 +0530
Message-Id: <1160368320.19143.207.camel@amol.verismonetworks.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ioremap must be balanced by an iounmap and failing to do so can result
in a memory leak.

Tested (compilation only):
- using allmodconfig
- making sure the files are compiling without any warning/error due to
new changes

Signed-off-by: Amol Lad <amol@verismonetworks.com>
---
 cpu/cpufreq/sc520_freq.c |    7 ++++++-
 hpet.c                   |    7 ++++++-
 pci-dma.c                |    4 +++-
 time_hpet.c              |   15 ++++++++++++---
 4 files changed, 27 insertions(+), 6 deletions(-)
---
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/arch/i386/kernel/cpu/cpufreq/sc520_freq.c linux-2.6.19-rc1/arch/i386/kernel/cpu/cpufreq/sc520_freq.c
--- linux-2.6.19-rc1-orig/arch/i386/kernel/cpu/cpufreq/sc520_freq.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.19-rc1/arch/i386/kernel/cpu/cpufreq/sc520_freq.c	2006-10-05 18:25:00.000000000 +0530
@@ -153,6 +153,7 @@ static struct cpufreq_driver sc520_freq_
 static int __init sc520_freq_init(void)
 {
 	struct cpuinfo_x86 *c = cpu_data;
+	int err;
 
 	/* Test if we have the right hardware */
 	if(c->x86_vendor != X86_VENDOR_AMD ||
@@ -166,7 +167,11 @@ static int __init sc520_freq_init(void)
 		return -ENOMEM;
 	}
 
-	return cpufreq_register_driver(&sc520_freq_driver);
+	err = cpufreq_register_driver(&sc520_freq_driver);
+	if (err)
+		iounmap(cpuctl);
+
+	return err;
 }
 

diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/arch/i386/kernel/hpet.c linux-2.6.19-rc1/arch/i386/kernel/hpet.c
--- linux-2.6.19-rc1-orig/arch/i386/kernel/hpet.c	2006-09-21 10:15:25.000000000 +0530
+++ linux-2.6.19-rc1/arch/i386/kernel/hpet.c	2006-10-05 18:32:34.000000000 +0530
@@ -34,6 +34,7 @@ static int __init init_hpet_clocksource(
 	unsigned long hpet_period;
 	void __iomem* hpet_base;
 	u64 tmp;
+	int err;
 
 	if (!is_hpet_enabled())
 		return -ENODEV;
@@ -61,7 +62,11 @@ static int __init init_hpet_clocksource(
 	do_div(tmp, FSEC_PER_NSEC);
 	clocksource_hpet.mult = (u32)tmp;
 
-	return clocksource_register(&clocksource_hpet);
+	err = clocksource_register(&clocksource_hpet);
+	if (err)
+		iounmap(hpet_base);
+
+	return err;
 }
 
 module_init(init_hpet_clocksource);
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/arch/i386/kernel/pci-dma.c linux-2.6.19-rc1/arch/i386/kernel/pci-dma.c
--- linux-2.6.19-rc1-orig/arch/i386/kernel/pci-dma.c	2006-08-24 02:46:33.000000000 +0530
+++ linux-2.6.19-rc1/arch/i386/kernel/pci-dma.c	2006-10-05 18:36:39.000000000 +0530
@@ -75,7 +75,7 @@ EXPORT_SYMBOL(dma_free_coherent);
 int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
 				dma_addr_t device_addr, size_t size, int flags)
 {
-	void __iomem *mem_base;
+	void __iomem *mem_base = NULL;
 	int pages = size >> PAGE_SHIFT;
 	int bitmap_size = (pages + 31)/32;
 
@@ -114,6 +114,8 @@ int dma_declare_coherent_memory(struct d
  free1_out:
 	kfree(dev->dma_mem->bitmap);
  out:
+	if (mem_base)
+		iounmap(mem_base);
 	return 0;
 }
 EXPORT_SYMBOL(dma_declare_coherent_memory);
diff -uprN -X linux-2.6.19-rc1-orig/Documentation/dontdiff linux-2.6.19-rc1-orig/arch/i386/kernel/time_hpet.c linux-2.6.19-rc1/arch/i386/kernel/time_hpet.c
--- linux-2.6.19-rc1-orig/arch/i386/kernel/time_hpet.c	2006-10-05 14:00:38.000000000 +0530
+++ linux-2.6.19-rc1/arch/i386/kernel/time_hpet.c	2006-10-05 18:30:07.000000000 +0530
@@ -132,14 +132,20 @@ int __init hpet_enable(void)
 	 * the single HPET timer for system time.
 	 */
 #ifdef CONFIG_HPET_EMULATE_RTC
-	if (!(id & HPET_ID_NUMBER))
+	if (!(id & HPET_ID_NUMBER)) {
+		iounmap(hpet_virt_address);
+		hpet_virt_address = NULL;
 		return -1;
+	}
 #endif
 

 	hpet_period = hpet_readl(HPET_PERIOD);
-	if ((hpet_period < HPET_MIN_PERIOD) || (hpet_period > HPET_MAX_PERIOD))
+	if ((hpet_period < HPET_MIN_PERIOD) || (hpet_period > HPET_MAX_PERIOD)) {
+		iounmap(hpet_virt_address);
+		hpet_virt_address = NULL;
 		return -1;
+	}
 
 	/*
 	 * 64 bit math
@@ -156,8 +162,11 @@ int __init hpet_enable(void)
 
 	hpet_use_timer = id & HPET_ID_LEGSUP;
 
-	if (hpet_timer_stop_set_go(hpet_tick))
+	if (hpet_timer_stop_set_go(hpet_tick)) {
+		iounmap(hpet_virt_address);
+		hpet_virt_address = NULL;
 		return -1;
+	}
 
 	use_hpet = 1;
 


_______________________________________________
Kernel-janitors mailing list
Kernel-janitors@lists.osdl.org
https://lists.osdl.org/mailman/listinfo/kernel-janitors



