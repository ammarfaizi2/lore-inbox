Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263232AbUDAV5Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263231AbUDAV0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:26:46 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:19763 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263182AbUDAVMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:12:51 -0500
Date: Thu, 1 Apr 2004 13:11:59 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: [Patch 9/23] mask v2 - Remove x86_64 obsolete cpumask ops
Message-Id: <20040401131159.000f3a4c.pj@sgi.com>
In-Reply-To: <20040401122802.23521599.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_9_of_23 - Remove/recode obsolete cpumask macros from arch x86_64
        Remove by recoding all uses of the obsolete cpumask const,
        coerce and promote macros.

Diffstat Patch_9_of_23:
 arch/x86_64/kernel/io_apic.c   |    2 +-
 arch/x86_64/kernel/pci-gart.c  |    4 ++--
 arch/x86_64/kernel/smp.c       |    2 +-
 include/asm-x86_64/smp.h       |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

===================================================================
diff -Nru a/arch/x86_64/kernel/io_apic.c b/arch/x86_64/kernel/io_apic.c
--- a/arch/x86_64/kernel/io_apic.c	Mon Mar 29 01:03:36 2004
+++ b/arch/x86_64/kernel/io_apic.c	Mon Mar 29 01:03:36 2004
@@ -1368,7 +1368,7 @@
 	unsigned long flags;
 	unsigned int dest;
 
-	dest = cpu_mask_to_apicid(mk_cpumask_const(mask));
+	dest = cpu_mask_to_apicid(mask);
 
 	/*
 	 * Only the first 8 bits are valid.
diff -Nru a/arch/x86_64/kernel/pci-gart.c b/arch/x86_64/kernel/pci-gart.c
--- a/arch/x86_64/kernel/pci-gart.c	Mon Mar 29 01:03:36 2004
+++ b/arch/x86_64/kernel/pci-gart.c	Mon Mar 29 01:03:36 2004
@@ -134,7 +134,7 @@
 { 
 	unsigned long flags;
 	int bus = dev ? dev->bus->number : -1;
-	cpumask_const_t bus_cpumask = pcibus_to_cpumask(bus);
+	cpumask_t bus_cpumask = pcibus_to_cpumask(bus);
 	int flushed = 0;
 	int i;
 
@@ -144,7 +144,7 @@
 			u32 w;
 			if (!northbridges[i]) 
 				continue;
-			if (bus >= 0 && !(cpu_isset_const(i, bus_cpumask)))
+			if (bus >= 0 && !(cpu_isset(i, bus_cpumask)))
 				continue;
 			pci_write_config_dword(northbridges[i], 0x9c, 
 					       northbridge_flush_word[i] | 1); 
diff -Nru a/arch/x86_64/kernel/smp.c b/arch/x86_64/kernel/smp.c
--- a/arch/x86_64/kernel/smp.c	Mon Mar 29 01:03:36 2004
+++ b/arch/x86_64/kernel/smp.c	Mon Mar 29 01:03:36 2004
@@ -94,7 +94,7 @@
 
 static inline void send_IPI_mask(cpumask_t cpumask, int vector)
 {
-	unsigned long mask = cpus_coerce(cpumask);
+	unsigned long mask = cpus_addr(cpumask)[0];
 	unsigned long cfg;
 	unsigned long flags;
 
diff -Nru a/include/asm-x86_64/smp.h b/include/asm-x86_64/smp.h
--- a/include/asm-x86_64/smp.h	Mon Mar 29 01:03:36 2004
+++ b/include/asm-x86_64/smp.h	Mon Mar 29 01:03:36 2004
@@ -86,9 +86,9 @@
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
