Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750952AbVKDXSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbVKDXSF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbVKDXSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:18:04 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:39297 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750952AbVKDXSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:18:02 -0500
Date: Fri, 4 Nov 2005 15:18:00 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: [PATCH 1/4] Memory Add Fixes for ppc64
Message-ID: <20051104231800.GB25545@w-mikek2.ibm.com>
References: <20051104231552.GA25545@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051104231552.GA25545@w-mikek2.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add the create_section_mapping() routine to create hptes for memory
sections dynamically added after system boot.

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr linux-2.6.14-git7/arch/powerpc/mm/hash_utils_64.c linux-2.6.14-git7.work/arch/powerpc/mm/hash_utils_64.c
--- linux-2.6.14-git7/arch/powerpc/mm/hash_utils_64.c	2005-11-04 21:21:05.000000000 +0000
+++ linux-2.6.14-git7.work/arch/powerpc/mm/hash_utils_64.c	2005-11-04 22:05:06.000000000 +0000
@@ -176,6 +176,15 @@ static unsigned long get_hashtable_size(
 	return pteg_count << 7;
 }
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+void create_section_mapping(unsigned long start, unsigned long end)
+{
+	create_pte_mapping(start, end,
+		_PAGE_ACCESSED | _PAGE_COHERENT | PP_RWXX,
+		cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE ? 1 : 0);
+}
+#endif /* CONFIG_MEMORY_HOTPLUG */
+
 void __init htab_initialize(void)
 {
 	unsigned long table, htab_size_bytes;
diff -Naupr linux-2.6.14-git7/arch/powerpc/mm/mem.c linux-2.6.14-git7.work/arch/powerpc/mm/mem.c
--- linux-2.6.14-git7/arch/powerpc/mm/mem.c	2005-11-04 21:21:05.000000000 +0000
+++ linux-2.6.14-git7.work/arch/powerpc/mm/mem.c	2005-11-04 22:05:06.000000000 +0000
@@ -124,6 +124,9 @@ int __devinit add_memory(u64 start, u64 
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
+	start += KERNELBASE;
+	create_section_mapping(start, start + size);
+
 	/* this should work for most non-highmem platforms */
 	zone = pgdata->node_zones;
 
diff -Naupr linux-2.6.14-git7/include/asm-ppc64/sparsemem.h linux-2.6.14-git7.work/include/asm-ppc64/sparsemem.h
--- linux-2.6.14-git7/include/asm-ppc64/sparsemem.h	2005-10-28 00:02:08.000000000 +0000
+++ linux-2.6.14-git7.work/include/asm-ppc64/sparsemem.h	2005-11-04 22:05:06.000000000 +0000
@@ -11,6 +11,10 @@
 #define MAX_PHYSADDR_BITS       38
 #define MAX_PHYSMEM_BITS        36
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+extern void create_section_mapping(unsigned long start, unsigned long end);
+#endif /* CONFIG_MEMORY_HOTPLUG */
+
 #endif /* CONFIG_SPARSEMEM */
 
 #endif /* _ASM_PPC64_SPARSEMEM_H */
