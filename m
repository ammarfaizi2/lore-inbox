Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWGHAGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWGHAGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWGHAFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:05:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:17858 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750770AbWGHAFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:05:43 -0400
Date: Fri, 7 Jul 2006 17:05:32 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Bligh <mbligh@google.com>, Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Andi Kleen <ak@suse.de>
Message-Id: <20060708000532.3829.13046.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
References: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 6/8] i386 without ZONE_DMA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386: Optional ZONE_DMA

ZONE_DMA depends on GENERIC_ISA_DMA. We allow the user to configure
GENERIC_ISA_DMA. If it is switched off then we buid a kernel without
ZONE_DMA.

Note that this patch is incomplete: All device drivers that use GENERIC_ISA_DMA
need to depend on it. This was not tested for i386 NUMA and other miscalleneous
configuration. But it works on my desktop (dual core Pentium).

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/arch/i386/kernel/setup.c
===================================================================
--- linux-2.6.17-mm6.orig/arch/i386/kernel/setup.c	2006-07-07 09:01:12.000000000 -0700
+++ linux-2.6.17-mm6/arch/i386/kernel/setup.c	2006-07-07 16:21:53.000000000 -0700
@@ -1207,15 +1207,19 @@ void __init zone_sizes_init(void)
 	max_dma = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
 	low = max_low_pfn;
 
+#ifdef CONFIG_ZONE_DMA
 	if (low < max_dma)
 		zones_size[ZONE_DMA] = low;
 	else {
 		zones_size[ZONE_DMA] = max_dma;
 		zones_size[ZONE_NORMAL] = low - max_dma;
+	}
+#else
+	zones_size[ZONE_NORMAL] = low;
+#endif
 #ifdef CONFIG_HIGHMEM
-		zones_size[ZONE_HIGHMEM] = highend_pfn - low;
+	zones_size[ZONE_HIGHMEM] = highend_pfn - low;
 #endif
-	}
 	free_area_init(zones_size);
 }
 #else
Index: linux-2.6.17-mm6/arch/i386/Kconfig
===================================================================
--- linux-2.6.17-mm6.orig/arch/i386/Kconfig	2006-07-07 16:15:10.000000000 -0700
+++ linux-2.6.17-mm6/arch/i386/Kconfig	2006-07-07 16:18:57.000000000 -0700
@@ -41,10 +41,6 @@ config MMU
 config SBUS
 	bool
 
-config GENERIC_ISA_DMA
-	bool
-	default y
-
 config GENERIC_IOMAP
 	bool
 	default y
@@ -344,6 +340,15 @@ config VM86
           XFree86 to initialize some video cards via BIOS. Disabling this
           option saves about 6k.
 
+config GENERIC_ISA_DMA
+	bool "ISA DMA zone (to support ISA legacy DMA)"
+	default y
+	help
+	  If DMA for ISA boards needs to be supported then this option
+	  needs to be enabled. An additional DMA zone for <16MB memory
+	  will be created and memory below 16MB will be used for those
+	  devices.
+
 config TOSHIBA
 	tristate "Toshiba Laptop support"
 	---help---
Index: linux-2.6.17-mm6/arch/i386/kernel/Makefile
===================================================================
--- linux-2.6.17-mm6.orig/arch/i386/kernel/Makefile	2006-07-07 16:16:19.000000000 -0700
+++ linux-2.6.17-mm6/arch/i386/kernel/Makefile	2006-07-07 16:17:16.000000000 -0700
@@ -7,8 +7,9 @@ extra-y := head.o init_task.o vmlinux.ld
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o bootflag.o \
-		quirks.o i8237.o topology.o alternative.o i8253.o tsc.o
+		quirks.o topology.o alternative.o i8253.o tsc.o
 
+obj-$(CONFIG_GENERIC_ISA_DMA)	+= i8237.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-y				+= cpu/
 obj-y				+= acpi/
