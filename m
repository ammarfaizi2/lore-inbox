Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261650AbVASH5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261650AbVASH5e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 02:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVASHzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 02:55:50 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52159 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261630AbVASHdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 02:33:23 -0500
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 27/29] crashdump-routines-for-copying-dump-pages
Date: Wed, 19 Jan 2005 0:31:37 -0700
Message-ID: <crashdump-routines-for-copying-dump-pages-1106119897713@ebiederm.dsl.xmission.com>
X-Mailer: patch-bomb.pl@ebiederm.dsl.xmission.com
In-Reply-To: <crashdump-memory-preserving-reboot-using-kexec-11061198972518@ebiederm.dsl.xmission.com>
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
	<x86-local-apic-fix-11061198972413@ebiederm.dsl.xmission.com>
	<x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>
	<x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<x86-64-i8259-shutdown-11061198973969@ebiederm.dsl.xmission.com>
	<x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
	<x86-64-apic-virtwire-on-shutdown-11061198973345@ebiederm.dsl.xmission.com>
	<vmlinux-fix-physical-addrs-11061198973860@ebiederm.dsl.xmission.com>
	<x86-vmlinux-fix-physical-addrs-11061198971192@ebiederm.dsl.xmission.com>
	<x86-64-vmlinux-fix-physical-addrs-11061198972723@ebiederm.dsl.xmission.com>
	<x86-64-entry64-1106119897218@ebiederm.dsl.xmission.com>
	<x86-config-kernel-start-1106119897152@ebiederm.dsl.xmission.com>
	<x86-64-config-kernel-start-11061198972987@ebiederm.dsl.xmission.com>
	<kexec-kexec-generic-11061198974111@ebiederm.dsl.xmission.com>
	<x86-machine-shutdown-1106119897775@ebiederm.dsl.xmission.com>
	<x86-kexec-11061198971773@ebiederm.dsl.xmission.com>
	<x86-crashkernel-1106119897532@ebiederm.dsl.xmission.com>
	<x86-64-machine-shutdown-11061198972282@ebiederm.dsl.xmission.com>
	<x86-64-kexec-11061198973999@ebiederm.dsl.xmission.com>
	<x86-64-crashkernel-11061198971876@ebiederm.dsl.xmission.com>
	<kexec-ppc-support-11061198973302@ebiederm.dsl.xmission.com>
	<x86-crash-shutdown-nmi-shootdown-11061198973234@ebiederm.dsl.xmission.com>
	<x86-crash-shutdown-snapshot-registers-11061198972173@ebiederm.dsl.xmission.com>
	<x86-crash-shutdown-apic-shutdown-11061198971134@ebiederm.dsl.xmission.com>
	<crashdump-documentation-11061198972662@ebiederm.dsl.xmission.com>
	<crashdump-memory-preserving-reboot-using-kexec-11061198972518@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kernel/crash.c has been renamed kernel/crash_dump.c to clarify it's purpose.

From: Hariprasad Nellitheertha <hari@in.ibm.com>

This patch provides the interfaces necessary to read the dump contents,
treating it as a high memory device.

Signed off by Hariprasad Nellitheertha <hari@in.ibm.com>

Signed-off-by: Eric Biederman <ebiederm@xmission.com>
---

 arch/i386/mm/highmem.c     |   18 ++++++++++++++++++
 include/asm-i386/highmem.h |    1 +
 include/linux/highmem.h    |    1 +
 kernel/crash_dump.c        |   33 +++++++++++++++++++++++++++++++++
 4 files changed, 53 insertions(+)

diff -uNr linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/arch/i386/mm/highmem.c linux-2.6.11-rc1-mm1-nokexec-crashdump-routines-for-copying-dump-pages/arch/i386/mm/highmem.c
--- linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/arch/i386/mm/highmem.c	Fri Jan 14 04:32:22 2005
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-routines-for-copying-dump-pages/arch/i386/mm/highmem.c	Tue Jan 18 23:16:41 2005
@@ -74,6 +74,24 @@
 	preempt_check_resched();
 }
 
+/* This is the same as kmap_atomic() but can map memory that doesn't
+ * have a struct page associated with it.
+ */
+void *kmap_atomic_pfn(unsigned long pfn, enum km_type type)
+{
+	enum fixed_addresses idx;
+	unsigned long vaddr;
+
+	inc_preempt_count();
+
+	idx = type + KM_TYPE_NR*smp_processor_id();
+	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+	set_pte(kmap_pte-idx, pfn_pte(pfn, kmap_prot));
+	__flush_tlb_one(vaddr);
+
+	return (void*) vaddr;
+}
+
 struct page *kmap_atomic_to_page(char *ptr)
 {
 	unsigned long idx, vaddr = (unsigned long)ptr;
diff -uNr linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/include/asm-i386/highmem.h linux-2.6.11-rc1-mm1-nokexec-crashdump-routines-for-copying-dump-pages/include/asm-i386/highmem.h
--- linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/include/asm-i386/highmem.h	Fri Jan 14 04:32:27 2005
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-routines-for-copying-dump-pages/include/asm-i386/highmem.h	Tue Jan 18 23:16:41 2005
@@ -72,6 +72,7 @@
 void kunmap(struct page *page);
 char *kmap_atomic(struct page *page, enum km_type type);
 void kunmap_atomic(char *kvaddr, enum km_type type);
+void *kmap_atomic_pfn(unsigned long pfn, enum km_type type);
 struct page *kmap_atomic_to_page(char *ptr);
 
 #define flush_cache_kmaps()	do { } while (0)
diff -uNr linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/include/linux/highmem.h linux-2.6.11-rc1-mm1-nokexec-crashdump-routines-for-copying-dump-pages/include/linux/highmem.h
--- linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/include/linux/highmem.h	Fri Jan 14 04:32:27 2005
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-routines-for-copying-dump-pages/include/linux/highmem.h	Tue Jan 18 23:16:41 2005
@@ -28,6 +28,7 @@
 
 #define kmap_atomic(page, idx)	 ((char *)page_address(page))
 #define kunmap_atomic(addr, idx) do { char *p = addr; (void)p; } while (0)
+#define kmap_atomic_pfn(pfn, idx)	page_address(pfn_to_page(pfn))
 #define kmap_atomic_to_page(ptr) virt_to_page(ptr)
 
 #endif /* CONFIG_HIGHMEM */
diff -uNr linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/kernel/crash_dump.c linux-2.6.11-rc1-mm1-nokexec-crashdump-routines-for-copying-dump-pages/kernel/crash_dump.c
--- linux-2.6.11-rc1-mm1-nokexec-crashdump-memory-preserving-reboot-using-kexec/kernel/crash_dump.c	Tue Jan 18 23:16:24 2005
+++ linux-2.6.11-rc1-mm1-nokexec-crashdump-routines-for-copying-dump-pages/kernel/crash_dump.c	Tue Jan 18 23:16:41 2005
@@ -8,6 +8,39 @@
 #include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/proc_fs.h>
+#include <linux/bootmem.h>
+#include <linux/highmem.h>
+#include <linux/crash_dump.h>
+
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
+/*
+ * Copy a page from "oldmem". For this page, there is no pte mapped
+ * in the current kernel. We stitch up a pte, similar to kmap_atomic.
+ */
+ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
+				size_t csize, int userbuf)
+{
+	void *page, *vaddr;
+
+	if (!csize)
+		return 0;
+
+	page = kmalloc(PAGE_SIZE, GFP_KERNEL);
+
+	vaddr = kmap_atomic_pfn(pfn, KM_PTE0);
+	copy_page(page, vaddr);
+	kunmap_atomic(vaddr, KM_PTE0);
+
+	if (userbuf) {
+		if (copy_to_user(buf, page, csize)) {
+			kfree(page);
+			return -EFAULT;
+		}
+	} else
+		memcpy(buf, page, csize);
+	kfree(page);
+
+	return 0;
+}
