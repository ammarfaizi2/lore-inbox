Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVC1OFC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVC1OFC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 09:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVC1Nkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 08:40:45 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:41403 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261783AbVC1N1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 08:27:15 -0500
Subject: [RFC/PATCH 10/17][Kdump] Routines for copying dump pages
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       fastboot <fastboot@lists.osdl.org>
Content-Type: multipart/mixed; boundary="=-twJOe+ONIDYgQnP6ymPR"
Date: Mon, 28 Mar 2005 18:57:12 +0530
Message-Id: <1112016432.4001.81.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-twJOe+ONIDYgQnP6ymPR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-twJOe+ONIDYgQnP6ymPR
Content-Disposition: attachment; filename=crashdump-routines-for-copying-dump-pages.patch
Content-Type: message/rfc822; name=crashdump-routines-for-copying-dump-pages.patch

From: 
Date: Mon, 28 Mar 2005 17:45:11 +0530
Subject: No Subject
Message-Id: <1112012111.4001.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

From: "Vivek Goyal" <vgoyal@in.ibm.com>

o Moved architecture independent crash_dump.c and crash_dump.h file creation
  code from crashdump-memory-preserving-reboot-using-kexec.patch to here. This
  makes more logical sense.

From: "Eric W. Biederman" <ebiederm@xmission.com>

kernel/crash.c has been renamed kernel/crash_dump.c to clarify it's purpose.

From: Hariprasad Nellitheertha <hari@in.ibm.com>

This patch provides the interfaces necessary to read the dump contents,
treating it as a high memory device.

Signed off by Hariprasad Nellitheertha <hari@in.ibm.com>
Signed-off-by: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.12-rc1-mm1-1M-root/arch/i386/mm/highmem.c     |   18 ++++++
 linux-2.6.12-rc1-mm1-1M-root/include/asm-i386/highmem.h |    1 
 linux-2.6.12-rc1-mm1-1M-root/include/linux/crash_dump.h |   12 ++++
 linux-2.6.12-rc1-mm1-1M-root/include/linux/highmem.h    |    1 
 linux-2.6.12-rc1-mm1-1M-root/kernel/Makefile            |    1 
 linux-2.6.12-rc1-mm1-1M-root/kernel/crash_dump.c        |   46 ++++++++++++++++
 6 files changed, 79 insertions(+)

diff -puN arch/i386/mm/highmem.c~crashdump-routines-for-copying-dump-pages arch/i386/mm/highmem.c
--- linux-2.6.12-rc1-mm1-1M/arch/i386/mm/highmem.c~crashdump-routines-for-copying-dump-pages	2005-03-22 16:14:37.000000000 +0530
+++ linux-2.6.12-rc1-mm1-1M-root/arch/i386/mm/highmem.c	2005-03-22 16:14:37.000000000 +0530
@@ -74,6 +74,24 @@ void kunmap_atomic(void *kvaddr, enum km
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
 struct page *kmap_atomic_to_page(void *ptr)
 {
 	unsigned long idx, vaddr = (unsigned long)ptr;
diff -puN include/asm-i386/highmem.h~crashdump-routines-for-copying-dump-pages include/asm-i386/highmem.h
--- linux-2.6.12-rc1-mm1-1M/include/asm-i386/highmem.h~crashdump-routines-for-copying-dump-pages	2005-03-22 16:14:37.000000000 +0530
+++ linux-2.6.12-rc1-mm1-1M-root/include/asm-i386/highmem.h	2005-03-22 16:14:37.000000000 +0530
@@ -70,6 +70,7 @@ void *kmap(struct page *page);
 void kunmap(struct page *page);
 void *kmap_atomic(struct page *page, enum km_type type);
 void kunmap_atomic(void *kvaddr, enum km_type type);
+void *kmap_atomic_pfn(unsigned long pfn, enum km_type type);
 struct page *kmap_atomic_to_page(void *ptr);
 
 #define flush_cache_kmaps()	do { } while (0)
diff -puN /dev/null include/linux/crash_dump.h
--- /dev/null	2004-02-24 02:32:56.000000000 +0530
+++ linux-2.6.12-rc1-mm1-1M-root/include/linux/crash_dump.h	2005-03-22 16:14:37.000000000 +0530
@@ -0,0 +1,12 @@
+#ifndef LINUX_CRASH_DUMP_H
+#define LINUX_CRASH_DUMP_H
+
+#ifdef CONFIG_CRASH_DUMP
+#include <linux/kexec.h>
+#include <linux/smp_lock.h>
+#include <linux/device.h>
+#include <linux/proc_fs.h>
+
+extern ssize_t copy_oldmem_page(unsigned long, char *, size_t, int);
+#endif /* CONFIG_CRASH_DUMP */
+#endif /* LINUX_CRASHDUMP_H */
diff -puN include/linux/highmem.h~crashdump-routines-for-copying-dump-pages include/linux/highmem.h
--- linux-2.6.12-rc1-mm1-1M/include/linux/highmem.h~crashdump-routines-for-copying-dump-pages	2005-03-22 16:14:37.000000000 +0530
+++ linux-2.6.12-rc1-mm1-1M-root/include/linux/highmem.h	2005-03-22 16:14:37.000000000 +0530
@@ -28,6 +28,7 @@ static inline void *kmap(struct page *pa
 
 #define kmap_atomic(page, idx)		page_address(page)
 #define kunmap_atomic(addr, idx)	do { } while (0)
+#define kmap_atomic_pfn(pfn, idx)	page_address(pfn_to_page(pfn))
 #define kmap_atomic_to_page(ptr)	virt_to_page(ptr)
 
 #endif /* CONFIG_HIGHMEM */
diff -puN /dev/null kernel/crash_dump.c
--- /dev/null	2004-02-24 02:32:56.000000000 +0530
+++ linux-2.6.12-rc1-mm1-1M-root/kernel/crash_dump.c	2005-03-22 16:14:37.000000000 +0530
@@ -0,0 +1,46 @@
+/*
+ *	kernel/crash_dump.c - Memory preserving reboot related code.
+ *
+ *	Created by: Hariprasad Nellitheertha (hari@in.ibm.com)
+ *	Copyright (C) IBM Corporation, 2004. All rights reserved
+ */
+
+#include <linux/smp_lock.h>
+#include <linux/errno.h>
+#include <linux/proc_fs.h>
+#include <linux/bootmem.h>
+#include <linux/highmem.h>
+#include <linux/crash_dump.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
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
diff -puN kernel/Makefile~crashdump-routines-for-copying-dump-pages kernel/Makefile
--- linux-2.6.12-rc1-mm1-1M/kernel/Makefile~crashdump-routines-for-copying-dump-pages	2005-03-22 16:14:37.000000000 +0530
+++ linux-2.6.12-rc1-mm1-1M-root/kernel/Makefile	2005-03-22 16:14:37.000000000 +0530
@@ -29,6 +29,7 @@ obj-$(CONFIG_KPROBES) += kprobes.o
 obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_DETECT_SOFTLOCKUP) += softlockup.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
+obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 
 ifneq ($(CONFIG_IA64),y)
_

--=-twJOe+ONIDYgQnP6ymPR--

