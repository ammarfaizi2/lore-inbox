Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbUDHUjo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 16:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbUDHUhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 16:37:03 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:5605 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262389AbUDHTuQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:50:16 -0400
Date: Thu, 8 Apr 2004 12:49:38 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Patch 9/23 - Bitmaps, Cpumasks and Nodemasks
Message-Id: <20040408124938.43ceeab3.pj@sgi.com>
In-Reply-To: <20040408115050.2c67311a.pj@sgi.com>
References: <20040408115050.2c67311a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P9.cpumask_x86_64_fixup - Remove/recode obsolete cpumask macros from arch x86_64
        Remove by recoding all uses of the obsolete cpumask const,
        coerce and promote macros.

Diffstat Patch_9_of_23:
 arch/x86_64/kernel/io_apic.c   |    2 +-
 arch/x86_64/kernel/pci-gart.c  |    4 ++--
 arch/x86_64/kernel/smp.c       |    2 +-
 include/asm-x86_64/smp.h       |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

Index: 2.6.5.mask/arch/x86_64/kernel/io_apic.c
===================================================================
--- 2.6.5.mask.orig/arch/x86_64/kernel/io_apic.c	2004-04-03 23:37:43.000000000 -0800
+++ 2.6.5.mask/arch/x86_64/kernel/io_apic.c	2004-04-03 23:52:03.000000000 -0800
@@ -1368,7 +1368,7 @@
 	unsigned long flags;
 	unsigned int dest;
 
-	dest = cpu_mask_to_apicid(mk_cpumask_const(mask));
+	dest = cpu_mask_to_apicid(mask);
 
 	/*
 	 * Only the first 8 bits are valid.
Index: 2.6.5.mask/arch/x86_64/kernel/pci-gart.c
===================================================================
--- 2.6.5.mask.orig/arch/x86_64/kernel/pci-gart.c	2004-04-03 23:37:43.000000000 -0800
+++ 2.6.5.mask/arch/x86_64/kernel/pci-gart.c	2004-04-03 23:52:03.000000000 -0800
@@ -149,7 +149,7 @@
 { 
 	unsigned long flags;
 	int bus = dev ? dev->bus->number : -1;
-	cpumask_const_t bus_cpumask = pcibus_to_cpumask(bus);
+	cpumask_t bus_cpumask = pcibus_to_cpumask(bus);
 	int flushed = 0;
 	int i;
 
@@ -159,7 +159,7 @@
 			u32 w;
 			if (!northbridges[i]) 
 				continue;
-			if (bus >= 0 && !(cpu_isset_const(i, bus_cpumask)))
+			if (bus >= 0 && !(cpu_isset(i, bus_cpumask)))
 				continue;
 			pci_write_config_dword(northbridges[i], 0x9c, 
 					       northbridge_flush_word[i] | 1); 
Index: 2.6.5.mask/arch/x86_64/kernel/smp.c
===================================================================
--- 2.6.5.mask.orig/arch/x86_64/kernel/smp.c	2004-04-03 23:37:43.000000000 -0800
+++ 2.6.5.mask/arch/x86_64/kernel/smp.c	2004-04-03 23:52:03.000000000 -0800
@@ -94,7 +94,7 @@
 
 static inline void send_IPI_mask(cpumask_t cpumask, int vector)
 {
-	unsigned long mask = cpus_coerce(cpumask);
+	unsigned long mask = cpus_addr(cpumask)[0];
 	unsigned long cfg;
 	unsigned long flags;
 
Index: 2.6.5.mask/include/asm-x86_64/smp.h
===================================================================
--- 2.6.5.mask.orig/include/asm-x86_64/smp.h	2004-04-03 23:38:16.000000000 -0800
+++ 2.6.5.mask/include/asm-x86_64/smp.h	2004-04-03 23:52:03.000000000 -0800
@@ -95,9 +95,9 @@
 #define TARGET_CPUS 1
 
 #ifndef ASSEMBLY
-static inline unsigned int cpu_mask_to_apicid(cpumask_const_t cpumask)
+static inline unsigned int cpu_mask_to_apicid(cpumask_t cpumask)
 {
-	return cpus_coerce_const(cpumask);
+	return cpus_addr(cpumask)[0];
 }
 #endif
 


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
