Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268194AbUHQMJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268194AbUHQMJi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 08:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268193AbUHQMJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 08:09:37 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:53404 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S268194AbUHQMI1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 08:08:27 -0400
Date: Tue, 17 Aug 2004 17:38:09 +0530
From: Hariprasad Nellitheertha <hari@in.ibm.com>
To: linux-kernel@vger.kernel.org, fastboot@osdl.org
Cc: akpm@osdl.org, Suparna Bhattacharya <suparna@in.ibm.com>,
       mbligh@aracnet.com, litke@us.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH][3/6]Interface for copying the dump pages
Message-ID: <20040817120809.GD3916@in.ibm.com>
Reply-To: hari@in.ibm.com
References: <20040817120239.GA3916@in.ibm.com> <20040817120531.GB3916@in.ibm.com> <20040817120717.GC3916@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
In-Reply-To: <20040817120717.GC3916@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Regards, Hari
-- 
Hariprasad Nellitheertha
Linux Technology Center
India Software Labs
IBM India, Bangalore

--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kd-copy-268.patch"



This patch provides the interfaces necessary to read the dump contents,
treating it as a high memory device.

Signed off by Hariprasad Nellitheertha <hari@in.ibm.com>


---

 linux-2.6.8.1-hari/arch/i386/mm/highmem.c     |   18 ++++++++++
 linux-2.6.8.1-hari/drivers/char/mem.c         |   44 ++++++++++++++++++++++++++
 linux-2.6.8.1-hari/include/asm-i386/highmem.h |    1 
 linux-2.6.8.1-hari/include/linux/highmem.h    |    1 
 4 files changed, 64 insertions(+)

diff -puN arch/i386/mm/highmem.c~kd-copy-268 arch/i386/mm/highmem.c
--- linux-2.6.8.1/arch/i386/mm/highmem.c~kd-copy-268	2004-08-17 17:06:21.000000000 +0530
+++ linux-2.6.8.1-hari/arch/i386/mm/highmem.c	2004-08-17 17:06:27.000000000 +0530
@@ -74,6 +74,24 @@ void kunmap_atomic(void *kvaddr, enum km
 	preempt_check_resched();
 }
 
+/* This is the same as kmap_atomic but takes in a pfn instead of a
+ * struct page.
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
diff -puN drivers/char/mem.c~kd-copy-268 drivers/char/mem.c
--- linux-2.6.8.1/drivers/char/mem.c~kd-copy-268	2004-08-17 17:06:21.000000000 +0530
+++ linux-2.6.8.1-hari/drivers/char/mem.c	2004-08-17 17:06:27.000000000 +0530
@@ -23,9 +23,13 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/ptrace.h>
 #include <linux/device.h>
+#include <linux/bootmem.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
+#include <asm/tlbflush.h>
+#include <asm/crash_dump.h>
+#include <asm/highmem.h>
 
 #ifdef CONFIG_IA64
 # include <linux/efi.h>
@@ -38,6 +42,8 @@ extern void fbmem_init(void);
 extern void tapechar_init(void);
 #endif
 
+ssize_t copy_hmem_page(unsigned long, char *, size_t, int);
+
 /*
  * Architectures vary in how they handle caching for addresses
  * outside of main memory.
@@ -219,6 +225,44 @@ static int mmap_mem(struct file * file, 
 	return 0;
 }
 
+/*
+ * Copy a page from "highmem". For this page, there is no pte mapped
+ * in the current kernel. We stitch up a pte, similar to kmap_atomic.
+ */
+ssize_t copy_hmem_page(unsigned long pfn, char *buf, size_t csize, int userbuf)
+{
+	void *page, *vaddr;
+
+	if (!csize)
+		return 0;
+
+	if (pfn == -1) {
+		/* Give them a zeroed page */
+		if (userbuf) {
+			if (clear_user(buf, csize))
+				return -EFAULT;
+		} else
+			memset(buf, 0, csize);
+	} else {
+		page = kmalloc(PAGE_SIZE, GFP_KERNEL);
+
+		vaddr = kmap_atomic_pfn(pfn, KM_PTE0);
+		copy_page(page, vaddr);
+		kunmap_atomic(vaddr, KM_PTE0);
+
+		if (userbuf) {
+			if (copy_to_user(buf, page, csize)) {
+				kfree(page);
+				return -EFAULT;
+			}
+		} else
+			memcpy(buf, page, csize);
+		kfree(page);
+	}
+
+	return 0;
+}
+
 extern long vread(char *buf, char *addr, unsigned long count);
 extern long vwrite(char *buf, char *addr, unsigned long count);
 
diff -puN include/asm-i386/highmem.h~kd-copy-268 include/asm-i386/highmem.h
--- linux-2.6.8.1/include/asm-i386/highmem.h~kd-copy-268	2004-08-17 17:06:21.000000000 +0530
+++ linux-2.6.8.1-hari/include/asm-i386/highmem.h	2004-08-17 17:06:27.000000000 +0530
@@ -61,6 +61,7 @@ void *kmap(struct page *page);
 void kunmap(struct page *page);
 void *kmap_atomic(struct page *page, enum km_type type);
 void kunmap_atomic(void *kvaddr, enum km_type type);
+void *kmap_atomic_pfn(unsigned long pfn, enum km_type type);
 struct page *kmap_atomic_to_page(void *ptr);
 
 #define flush_cache_kmaps()	do { } while (0)
diff -puN include/linux/highmem.h~kd-copy-268 include/linux/highmem.h
--- linux-2.6.8.1/include/linux/highmem.h~kd-copy-268	2004-08-17 17:06:21.000000000 +0530
+++ linux-2.6.8.1-hari/include/linux/highmem.h	2004-08-17 17:06:27.000000000 +0530
@@ -30,6 +30,7 @@ static inline void *kmap(struct page *pa
 
 #define kmap_atomic(page, idx)		page_address(page)
 #define kunmap_atomic(addr, idx)	do { } while (0)
+#define kmap_atomic_pfn(pfn, idx)	page_address(pfn_to_page(pfn))
 #define kmap_atomic_to_page(ptr)	virt_to_page(ptr)
 
 #endif /* CONFIG_HIGHMEM */

_

--NU0Ex4SbNnrxsi6C--
