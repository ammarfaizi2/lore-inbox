Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263626AbUIOM5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbUIOM5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 08:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUIOMzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 08:55:53 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:51335 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263626AbUIOMyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 08:54:14 -0400
Date: Wed, 15 Sep 2004 18:24:22 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, fastboot@osdl.org
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, mbligh@aracnet.com,
       ebiederm@xmission.com, litke@us.ibm.com
Subject: Re: [PATCH][3/6]Routines for copying the dump pages
Message-ID: <20040915125422.GD15450@in.ibm.com>
Reply-To: hari@in.ibm.com
References: <20040915125041.GA15450@in.ibm.com> <20040915125145.GB15450@in.ibm.com> <20040915125322.GC15450@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="JWEK1jqKZ6MHAcjA"
Content-Disposition: inline
In-Reply-To: <20040915125322.GC15450@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Regards, Hari
-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore

--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kd-copy-269rc1-mm5.patch"



This patch provides the interfaces necessary to read the dump contents,
treating it as a high memory device.

Signed off by Hariprasad Nellitheertha <hari@in.ibm.com>


---

 linux-2.6.9-rc1-hari/arch/i386/mm/highmem.c     |   18 +++++++++++++
 linux-2.6.9-rc1-hari/include/asm-i386/highmem.h |    1 
 linux-2.6.9-rc1-hari/include/linux/highmem.h    |   31 ++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff -puN arch/i386/mm/highmem.c~kd-copy-269rc1-mm5 arch/i386/mm/highmem.c
--- linux-2.6.9-rc1/arch/i386/mm/highmem.c~kd-copy-269rc1-mm5	2004-09-15 17:36:33.000000000 +0530
+++ linux-2.6.9-rc1-hari/arch/i386/mm/highmem.c	2004-09-15 17:36:33.000000000 +0530
@@ -74,6 +74,24 @@ void kunmap_atomic(void *kvaddr, enum km
 	preempt_check_resched();
 }
 
+/* This is the same as kmap_atomic() but can map memory that doesn't
+ * have a struct page associated with it.
+ */
+void *kmap_atomic_pfn(unsigned long pfn, enum km_type type)
+{
+        enum fixed_addresses idx;
+        unsigned long vaddr;
+
+        inc_preempt_count();
+
+        idx = type + KM_TYPE_NR*smp_processor_id();
+        vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+        set_pte(kmap_pte-idx, pfn_pte(pfn, kmap_prot));
+        __flush_tlb_one(vaddr);
+
+        return (void*) vaddr;
+}
+
 struct page *kmap_atomic_to_page(void *ptr)
 {
 	unsigned long idx, vaddr = (unsigned long)ptr;
diff -puN include/asm-i386/highmem.h~kd-copy-269rc1-mm5 include/asm-i386/highmem.h
--- linux-2.6.9-rc1/include/asm-i386/highmem.h~kd-copy-269rc1-mm5	2004-09-15 17:36:33.000000000 +0530
+++ linux-2.6.9-rc1-hari/include/asm-i386/highmem.h	2004-09-15 17:36:33.000000000 +0530
@@ -61,6 +61,7 @@ void *kmap(struct page *page);
 void kunmap(struct page *page);
 void *kmap_atomic(struct page *page, enum km_type type);
 void kunmap_atomic(void *kvaddr, enum km_type type);
+void *kmap_atomic_pfn(unsigned long pfn, enum km_type type);
 struct page *kmap_atomic_to_page(void *ptr);
 
 #define flush_cache_kmaps()	do { } while (0)
diff -puN include/linux/highmem.h~kd-copy-269rc1-mm5 include/linux/highmem.h
--- linux-2.6.9-rc1/include/linux/highmem.h~kd-copy-269rc1-mm5	2004-09-15 17:36:33.000000000 +0530
+++ linux-2.6.9-rc1-hari/include/linux/highmem.h	2004-09-15 17:36:33.000000000 +0530
@@ -6,6 +6,7 @@
 #include <linux/mm.h>
 
 #include <asm/cacheflush.h>
+#include <asm/uaccess.h>
 
 #ifdef CONFIG_HIGHMEM
 
@@ -30,6 +31,7 @@ static inline void *kmap(struct page *pa
 
 #define kmap_atomic(page, idx)		page_address(page)
 #define kunmap_atomic(addr, idx)	do { } while (0)
+#define kmap_atomic_pfn(pfn, idx)	page_address(pfn_to_page(pfn))
 #define kmap_atomic_to_page(ptr)	virt_to_page(ptr)
 
 #endif /* CONFIG_HIGHMEM */
@@ -86,4 +88,33 @@ static inline void copy_highpage(struct 
 	kunmap_atomic(vto, KM_USER1);
 }
 
+/*
+ * Copy a page from "oldmem". For this page, there is no pte mapped
+ * in the current kernel. We stitch up a pte, similar to kmap_atomic.
+ */
+static inline ssize_t copy_oldmem_page(unsigned long pfn,
+			char *buf, size_t csize, int userbuf)
+{
+        void *page, *vaddr;
+
+        if (!csize)
+                return 0;
+
+        page = kmalloc(PAGE_SIZE, GFP_KERNEL);
+
+        vaddr = kmap_atomic_pfn(pfn, KM_PTE0);
+        copy_page(page, vaddr);
+        kunmap_atomic(vaddr, KM_PTE0);
+
+        if (userbuf) {
+                if (copy_to_user(buf, page, csize)) {
+                        kfree(page);
+                        return -EFAULT;
+                }
+        } else
+                memcpy(buf, page, csize);
+        kfree(page);
+
+        return 0;
+}
 #endif /* _LINUX_HIGHMEM_H */

_

--JWEK1jqKZ6MHAcjA--
