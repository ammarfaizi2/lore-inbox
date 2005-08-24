Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbVHXSmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbVHXSmP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 14:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbVHXSmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 14:42:15 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:61702 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751382AbVHXSmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 14:42:14 -0400
Date: Wed, 24 Aug 2005 11:42:09 -0700
Message-Id: <200508241842.j7OIg9TE001882@zach-dev.vmware.com>
Subject: [PATCH 2/5] Add subarch mmu queue flush hook
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Virtualization Mailing List <virtualization@lists.osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Chris Wright <chrisw@osdl.org>
To: Martin Bligh <mbligh@mbligh.org>
To: Pratap Subrahmanyam <pratap@vmware.com>
To: Christopher Li <chrisl@vmware.com>
To: Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 24 Aug 2005 18:42:10.0109 (UTC) FILETIME=[89150ED0:01C5A8DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add one more MMU hook to the sub-arch layer.

update_mmu_cache() - already defined.  This is conveniently used to indicate
NP->P transitions which should be reflected in an external TLB, and serves
to indicate all points where the page tables must be synchronized.  Required
for lazy updates in shadow mode.

There is only one case where an extra flush is needed, in the i386 specific
page fault handler.  Flushes for NP->P transitions must already be maintained
in the arch independent code because of the external TLB on Sparc.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.13/arch/i386/mm/fault.c
===================================================================
--- linux-2.6.13.orig/arch/i386/mm/fault.c	2005-08-24 09:30:53.000000000 -0700
+++ linux-2.6.13/arch/i386/mm/fault.c	2005-08-24 09:43:27.000000000 -0700
@@ -562,6 +562,15 @@ vmalloc_fault:
 		pte_k = pte_offset_kernel(pmd_k, address);
 		if (!pte_present(*pte_k))
 			goto no_context;
+
+		/*
+		 * We have just updated this root with a copy of the kernel
+		 * pmd.  To return without flushing would introduce a fault
+		 * loop if running on a hypervisor which uses queued page
+		 * table updates.
+		 */
+		update_mmu_cache(vma, address, pte_k);
+
 		return;
 	}
 }
Index: linux-2.6.13/include/asm-i386/pgtable.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/pgtable.h	2005-08-24 09:30:53.000000000 -0700
+++ linux-2.6.13/include/asm-i386/pgtable.h	2005-08-24 09:43:27.000000000 -0700
@@ -416,18 +416,6 @@ extern void noexec_setup(const char *str
 #define pte_unmap_nested(pte) do { } while (0)
 #endif
 
-/*
- * The i386 doesn't have any external MMU info: the kernel page
- * tables contain all the necessary information.
- *
- * Also, we only update the dirty/accessed state if we set
- * the dirty bit by hand in the kernel, since the hardware
- * will do the accessed bit for us, and we don't want to
- * race with other CPU's that might be updating the dirty
- * bit at the same time.
- */
-#define update_mmu_cache(vma,address,pte) do { } while (0)
-
 #endif /* !__ASSEMBLY__ */
 
 #ifdef CONFIG_FLATMEM
Index: linux-2.6.13/include/asm-i386/mach-default/pgtable-ops.h
===================================================================
--- linux-2.6.13.orig/include/asm-i386/mach-default/pgtable-ops.h	2005-08-24 09:30:53.000000000 -0700
+++ linux-2.6.13/include/asm-i386/mach-default/pgtable-ops.h	2005-08-24 09:43:27.000000000 -0700
@@ -40,4 +40,16 @@ static inline void clone_pgd_range(pgd_t
        memcpy(dst, src, count * sizeof(pgd_t));
 }
 
+/*
+ * The i386 doesn't have any external MMU info: the kernel page
+ * tables contain all the necessary information.
+ *
+ * Also, we only update the dirty/accessed state if we set
+ * the dirty bit by hand in the kernel, since the hardware
+ * will do the accessed bit for us, and we don't want to
+ * race with other CPU's that might be updating the dirty
+ * bit at the same time.
+ */
+#define update_mmu_cache(vma,address,pte) do { } while (0)
+
 #endif /* _PGTABLE_OPS_H */
