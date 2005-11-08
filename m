Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965616AbVKHAZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965616AbVKHAZw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 19:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965629AbVKHAZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 19:25:52 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:37016 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965616AbVKHAZv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 19:25:51 -0500
Date: Mon, 7 Nov 2005 16:25:48 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: [PATCH 1/4] revised Memory Add Fixes for ppc64
Message-ID: <20051108002548.GF5821@w-mikek2.ibm.com>
References: <20051104231552.GA25545@w-mikek2.ibm.com> <20051104231800.GB25545@w-mikek2.ibm.com> <1131149070.29195.41.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131149070.29195.41.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 11:04:30AM +1100, Benjamin Herrenschmidt wrote:
> This patch will have to be slightly reworked on top of the 64k pages
> one. It should be trivial though.

Here is a new version of the patch on top of 64k page support (actually
2.6.14-git10).  One filename also changed due to more merge changes.

Add the create_section_mapping() routine to create hptes for memory
sections dynamically added after system boot.

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr linux-2.6.14-git10/arch/powerpc/mm/hash_utils_64.c linux-2.6.14-git10.work/arch/powerpc/mm/hash_utils_64.c
--- linux-2.6.14-git10/arch/powerpc/mm/hash_utils_64.c	2005-11-08 00:04:15.784924264 +0000
+++ linux-2.6.14-git10.work/arch/powerpc/mm/hash_utils_64.c	2005-11-08 00:06:46.992964608 +0000
@@ -385,6 +385,15 @@ static unsigned long __init htab_get_tab
 	return pteg_count << 7;
 }
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+void create_section_mapping(unsigned long start, unsigned long end)
+{
+		BUG_ON(htab_bolt_mapping(start, end, start,
+			_PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT | PP_RWXX,
+			mmu_linear_psize));
+}
+#endif /* CONFIG_MEMORY_HOTPLUG */
+
 void __init htab_initialize(void)
 {
 	unsigned long table, htab_size_bytes;
diff -Naupr linux-2.6.14-git10/arch/powerpc/mm/mem.c linux-2.6.14-git10.work/arch/powerpc/mm/mem.c
--- linux-2.6.14-git10/arch/powerpc/mm/mem.c	2005-11-08 00:04:15.798922136 +0000
+++ linux-2.6.14-git10.work/arch/powerpc/mm/mem.c	2005-11-08 00:06:46.993964456 +0000
@@ -127,6 +127,9 @@ int __devinit add_memory(u64 start, u64 
 	unsigned long start_pfn = start >> PAGE_SHIFT;
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 
+	start += KERNELBASE;
+	create_section_mapping(start, start + size);
+
 	/* this should work for most non-highmem platforms */
 	zone = pgdata->node_zones;
 
diff -Naupr linux-2.6.14-git10/include/asm-powerpc/sparsemem.h linux-2.6.14-git10.work/include/asm-powerpc/sparsemem.h
--- linux-2.6.14-git10/include/asm-powerpc/sparsemem.h	2005-11-08 00:04:28.486988472 +0000
+++ linux-2.6.14-git10.work/include/asm-powerpc/sparsemem.h	2005-11-08 00:07:39.138891344 +0000
@@ -11,6 +11,10 @@
 #define MAX_PHYSADDR_BITS       38
 #define MAX_PHYSMEM_BITS        36
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+extern void create_section_mapping(unsigned long start, unsigned long end);
+#endif /* CONFIG_MEMORY_HOTPLUG */
+
 #endif /* CONFIG_SPARSEMEM */
 
 #endif /* _ASM_POWERPC_SPARSEMEM_H */
