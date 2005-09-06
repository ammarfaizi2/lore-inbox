Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbVIFD4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbVIFD4f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 23:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbVIFD4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 23:56:35 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:63197 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932199AbVIFD4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 23:56:35 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Magnus Damm <magnus@valinux.co.jp>
Message-Id: <20050906035531.31603.46449.sendpatchset@cherry.local>
Subject: [PATCH] i386: single node SPARSEMEM fix
Date: Tue,  6 Sep 2005 12:56:34 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch for 2.6.13-git5 fixes single node sparsemem support. In the case
when multiple nodes are used, setup_memory() in arch/i386/mm/discontig.c calls
get_memcfg_numa() which calls memory_present(). The single node case with
setup_memory() in arch/i386/kernel/setup.c does not call memory_present()
without this patch, which breaks single node support.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
----

--- from-0006/arch/i386/Kconfig
+++ to-0007/arch/i386/Kconfig	2005-09-06 12:01:45.000000000 +0900
@@ -758,7 +758,6 @@ config NUMA
 	depends on SMP && HIGHMEM64G && (X86_NUMAQ || X86_GENERICARCH || (X86_SUMMIT && ACPI))
 	default n if X86_PC
 	default y if (X86_NUMAQ || X86_SUMMIT)
-	select SPARSEMEM_STATIC
 
 # Need comments to help the hapless user trying to turn on NUMA support
 comment "NUMA (NUMA-Q) requires SMP, 64GB highmem support"
@@ -797,7 +796,8 @@ config ARCH_DISCONTIGMEM_DEFAULT
 
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y
-	depends on NUMA
+	depends on NUMA || (X86_PC && EXPERIMENTAL)
+	select SPARSEMEM_STATIC
 
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
--- from-0006/arch/i386/kernel/setup.c
+++ to-0007/arch/i386/kernel/setup.c	2005-09-06 11:34:07.000000000 +0900
@@ -1127,6 +1127,9 @@ static unsigned long __init setup_memory
 	printk(KERN_NOTICE "%ldMB LOWMEM available.\n",
 			pages_to_mb(max_low_pfn));
 
+#ifdef CONFIG_SPARSEMEM
+	memory_present(0, 0, max_pfn);
+#endif
 	setup_bootmem_allocator();
 
 	return max_low_pfn;
