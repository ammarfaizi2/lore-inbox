Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbUC2MQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbUC2MQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:16:39 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:56502 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262846AbUC2MNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:13:55 -0500
Date: Mon, 29 Mar 2004 04:13:08 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com, akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com,
       colpatch@us.ibm.com
Subject: [PATCH] mask ADT: remove obsolete cpumask macros - x86_64 [6/22]
Message-Id: <20040329041308.3431df98.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_6_of_22 - Remove/recode obsolete cpumask macros from arch x86_64
        Remove by recoding all uses of the obsolete cpumask const,
        coerce and promote macros.

diffstat Patch_6_of_22:
 arch/x86_64/kernel/io_apic.c  |    2 +-
 arch/x86_64/kernel/pci-gart.c |    4 ++--
 arch/x86_64/kernel/smp.c      |    2 +-
 include/asm-x86_64/smp.h      |    4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1711  -> 1.1712 
#	include/asm-x86_64/smp.h	1.16    -> 1.17   
#	arch/x86_64/kernel/smp.c	1.18    -> 1.19   
#	arch/x86_64/kernel/pci-gart.c	1.29    -> 1.30   
#	arch/x86_64/kernel/io_apic.c	1.20    -> 1.21   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/28	pj@sgi.com	1.1712
# Remove arch x86_64 use of obsolete cpumask const, coerce and promote macros.
# --------------------------------------------
#
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
+	unsigned long mask = cpus_raw(cpumask)[0];
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
+	return cpus_raw(cpumask)[0];
 }
 #endif
 


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
