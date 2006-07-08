Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWGHAGB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWGHAGB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWGHAF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:05:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:16578 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750773AbWGHAFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:05:40 -0400
Date: Fri, 7 Jul 2006 17:05:27 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Martin Bligh <mbligh@google.com>, Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20060708000527.3829.58852.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
References: <20060708000501.3829.25578.sendpatchset@schroedinger.engr.sgi.com>
Subject: [RFC 5/8] x86_64 without ZONE_DMA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86_64: ZONE_DMA/ZONE_DMA32 optional

Allow the use to specify CONFIG_ZONE_DMA32 and CONFIG_ZONE_DMA (via
CONFIG_GENERIC_ISA_DMA).

Not that this is incomplete. What really needs to occur is that
devices using ISA DMA need to depend on ZONE_DMA.

I am also not sure if this works for all configuration. Works fine
on my desktop x86_64 system with a single zone.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.17-mm6/arch/x86_64/mm/init.c
===================================================================
--- linux-2.6.17-mm6.orig/arch/x86_64/mm/init.c	2006-07-07 01:13:06.000000000 -0700
+++ linux-2.6.17-mm6/arch/x86_64/mm/init.c	2006-07-07 01:13:14.000000000 -0700
@@ -413,15 +413,18 @@
 
  	for (i = 0; i < MAX_NR_ZONES; i++)
  		z[i] = 0;
-
+#ifdef CONFIG_ZONE_DMA
  	if (start_pfn < MAX_DMA_PFN)
  		z[ZONE_DMA] = MAX_DMA_PFN - start_pfn;
+#endif
+#ifdef CONFIG_ZONE_DMA32
  	if (start_pfn < MAX_DMA32_PFN) {
  		unsigned long dma32_pfn = MAX_DMA32_PFN;
  		if (dma32_pfn > end_pfn)
  			dma32_pfn = end_pfn;
  		z[ZONE_DMA32] = dma32_pfn - start_pfn;
  	}
+#endif
  	z[ZONE_NORMAL] = end_pfn - start_pfn;
 
  	/* Remove lower zones from higher ones. */
@@ -444,14 +447,14 @@
 	for (i = 0; i < MAX_NR_ZONES; i++)
 		h[i] += (z[i] * sizeof(struct page)) / PAGE_SIZE;
 
-	/* The 16MB DMA zone has the kernel and other misc mappings.
+	/* The first zone has the kernel and other misc mappings.
  	   Account them too */
-	if (h[ZONE_DMA]) {
-		h[ZONE_DMA] += dma_reserve;
-		if (h[ZONE_DMA] >= z[ZONE_DMA]) {
+	if (h[0]) {
+		h[0] += dma_reserve;
+		if (h[0] >= z[0]) {
 			printk(KERN_WARNING
-				"Kernel too large and filling up ZONE_DMA?\n");
-			h[ZONE_DMA] = z[ZONE_DMA];
+				"Kernel too large and filling up first zone?\n");
+			h[0] = z[0];
 		}
 	}
 }
Index: linux-2.6.17-mm6/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.17-mm6.orig/arch/x86_64/Kconfig	2006-07-07 01:13:08.000000000 -0700
+++ linux-2.6.17-mm6/arch/x86_64/Kconfig	2006-07-07 01:13:14.000000000 -0700
@@ -24,10 +24,6 @@
 	bool
 	default y
 
-config ZONE_DMA32
-	bool
-	default y
-
 config LOCKDEP_SUPPORT
 	bool
 	default y
@@ -73,10 +69,6 @@
 	bool
 	default y
 
-config GENERIC_ISA_DMA
-	bool
-	default y
-
 config GENERIC_IOMAP
 	bool
 	default y
@@ -247,6 +239,23 @@
 
 	  See <file:Documentation/mtrr.txt> for more information.
 
+config ZONE_DMA32
+	bool "32 Bit DMA Zone (only needed if memory >4GB)"
+	default y
+	help
+	  Some x64 configurations have 32 bit DMA controllers that cannot
+	  write to all of memory. If you have one of these and you have RAM
+	  beyond the 4GB boundary then enable this option.
+
+config GENERIC_ISA_DMA
+	bool "ISA DMA zone (to support ISA legacy DMA)"
+	default y
+	help
+	  If DMA for ISA boards needs to be supported then this option
+	  needs to be enabled. An additional DMA zone for <16MB memory
+	  will be created and memory below 16MB will be used for those
+	  devices.
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
Index: linux-2.6.17-mm6/arch/x86_64/kernel/Makefile
===================================================================
--- linux-2.6.17-mm6.orig/arch/x86_64/kernel/Makefile	2006-07-07 01:13:22.000000000 -0700
+++ linux-2.6.17-mm6/arch/x86_64/kernel/Makefile	2006-07-07 01:13:47.000000000 -0700
@@ -7,9 +7,10 @@
 obj-y	:= process.o signal.o entry.o traps.o irq.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_x86_64.o \
 		x8664_ksyms.o i387.o syscall.o vsyscall.o \
-		setup64.o bootflag.o e820.o reboot.o quirks.o i8237.o \
+		setup64.o bootflag.o e820.o reboot.o quirks.o \
 		pci-dma.o pci-nommu.o alternative.o
 
+obj-$(CONFIG_GENERIC_ISA_DMA)	+= i8237.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_X86_MCE)         += mce.o
 obj-$(CONFIG_X86_MCE_INTEL)	+= mce_intel.o
