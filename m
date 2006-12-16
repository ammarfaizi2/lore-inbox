Return-Path: <linux-kernel-owner+w=401wt.eu-S1030774AbWLPIcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030774AbWLPIcq (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 03:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030777AbWLPIcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 03:32:46 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:60959 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030774AbWLPIcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 03:32:45 -0500
Date: Sat, 16 Dec 2006 17:35:48 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, clameter@engr.sgi.com,
       apw@shadowen.org, heiko.carstens@de.ibm.com, bob.picco@hp.com
Subject: [PATCH][2.6.20-rc1-mm1] sparsemem vmem_map optimzed pfn_valid()
 [2/2] for ia64
Message-Id: <20061216173548.7c30ca40.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20061216173136.fbc91fa6.kamezawa.hiroyu@jp.fujitsu.com>
References: <20061216173136.fbc91fa6.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ia64 support for sparsemem vmem_map optimize pfn_valid() patch.

Because ia64 has its own virtual mem_map, we can reuse the same code.
So this patch is simple.

To support optimized pfn_valid() in other arch, you (may) have to modify fault
handler in kernel address space.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 arch/ia64/Kconfig    |    4 ++++
 arch/ia64/mm/fault.c |    4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

Index: devel-2.6.20-rc1-mm1/arch/ia64/Kconfig
===================================================================
--- devel-2.6.20-rc1-mm1.orig/arch/ia64/Kconfig	2006-12-16 14:42:57.000000000 +0900
+++ devel-2.6.20-rc1-mm1/arch/ia64/Kconfig	2006-12-16 14:43:14.000000000 +0900
@@ -353,6 +353,10 @@
 	def_bool y
 	depends on SPARSEMEM_VMEMMAP
 
+config ARCH_SPARSEMEM_VMEMMAP_OPT_PFN_VALID
+	def_bool y
+	depends on SPARSEMEM_VMEMMAP
+
 config ARCH_DISCONTIGMEM_DEFAULT
 	def_bool y if (IA64_SGI_SN2 || IA64_GENERIC || IA64_HP_ZX1 || IA64_HP_ZX1_SWIOTLB)
 	depends on ARCH_DISCONTIGMEM_ENABLE
Index: devel-2.6.20-rc1-mm1/arch/ia64/mm/fault.c
===================================================================
--- devel-2.6.20-rc1-mm1.orig/arch/ia64/mm/fault.c	2006-12-16 14:42:57.000000000 +0900
+++ devel-2.6.20-rc1-mm1/arch/ia64/mm/fault.c	2006-12-16 14:43:40.000000000 +0900
@@ -103,7 +103,7 @@
 	if (in_atomic() || !mm)
 		goto no_context;
 
-#ifdef CONFIG_VIRTUAL_MEM_MAP
+#if defined(CONFIG_VIRTUAL_MEM_MAP) || defined(CONFIG_SPARSEMEM_VMEMMAP_OPT_PFNVALID)
 	/*
 	 * If fault is in region 5 and we are in the kernel, we may already
 	 * have the mmap_sem (pfn_valid macro is called during mmap). There
@@ -211,7 +211,7 @@
 
   bad_area:
 	up_read(&mm->mmap_sem);
-#ifdef CONFIG_VIRTUAL_MEM_MAP
+#if defined(CONFIG_VIRTUAL_MEM_MAP) || defined(CONFIG_SPARSEMEM_VMEMMAP_OPT_PFNVALID)
   bad_area_no_up:
 #endif
 	if ((isr & IA64_ISR_SP)

