Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261730AbTCQDCi>; Sun, 16 Mar 2003 22:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261747AbTCQDCi>; Sun, 16 Mar 2003 22:02:38 -0500
Received: from franka.aracnet.com ([216.99.193.44]:58053 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S261730AbTCQDCg>; Sun, 16 Mar 2003 22:02:36 -0500
Date: Sun, 16 Mar 2003 19:13:13 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [PATCH] footguard CONFIG_NUMA
Message-ID: <5580000.1047870793@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from Martin J. Bligh and Dave Hansen

People with ordinary PCs are accidentally turning on NUMA support,
and people with NUMA machines are finding the NUMA option mysteriously
disappearing. This patch sets the defaults to sane things for everyone,
and only allows you to turn on NUMA with both SMP and 64Gb support on
(it's useful for the distros on non-Summit boxes, but not on their UP
kernels ;-)). 

I've also moved it below the highmem options, as it logically depends
on them, so this makes more sense. For those searching for NUMA support
on *real* NUMA machine, Dave has provided some guiding comments to 
show them what they messed up (it's totally non-obvious).
Hopefully this will stop people's recent unfortunate foot-wounds
(I think UP machines were defaulting to NUMA on ... oops).

diff -urpN -X /home/fletch/.diff.exclude 560-kgdb_cleanup/arch/i386/Kconfig 570-numa_protector/arch/i386/Kconfig
--- 560-kgdb_cleanup/arch/i386/Kconfig	Sun Mar 16 13:39:06 2003
+++ 570-numa_protector/arch/i386/Kconfig	Sun Mar 16 18:59:37 2003
@@ -481,21 +481,6 @@ config NR_CPUS
 	  This is purely to save memory - each supported CPU adds
 	  approximately eight kilobytes to the kernel image.
 
-# Common NUMA Features
-config NUMA
-	bool "Numa Memory Allocation Support"
-	depends on (HIGHMEM64G && (X86_NUMAQ || (X86_SUMMIT && ACPI && !ACPI_HT_ONLY))) || X86_PC
-
-config DISCONTIGMEM
-	bool
-	depends on NUMA
-	default y
-
-config HAVE_ARCH_BOOTMEM_NODE
-	bool
-	depends on NUMA
-	default y
-
 config X86_TSC
 	bool
 	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
@@ -721,6 +706,30 @@ config HIGHMEM
 config X86_PAE
 	bool
 	depends on HIGHMEM64G
+	default y
+
+# Common NUMA Features
+config NUMA
+	bool "Numa Memory Allocation Support"
+	depends on SMP && HIGHMEM64G && (X86_PC || X86_NUMAQ || (X86_SUMMIT && ACPI && !ACPI_HT_ONLY))
+	default n if X86_PC
+	default y if (X86_NUMAQ || X86_SUMMIT)
+
+# Need comments to help the hapless user trying to turn on NUMA support
+comment "NUMA (NUMA-Q) requires SMP, 64GB highmem support"
+	depends on X86_NUMAQ && (!HIGHMEM64G || !SMP)
+
+comment "NUMA (Summit) requires SMP, 64GB highmem support, full ACPI"
+	depends on X86_SUMMIT && (!HIGHMEM64G || !ACPI || ACPI_HT_ONLY)
+
+config DISCONTIGMEM
+	bool
+	depends on NUMA
+	default y
+
+config HAVE_ARCH_BOOTMEM_NODE
+	bool
+	depends on NUMA
 	default y
 
 config HIGHPTE

