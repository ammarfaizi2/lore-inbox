Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWDMC7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWDMC7l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 22:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWDMC7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 22:59:40 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:27853 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932433AbWDMC7k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 22:59:40 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>, ebiederm@xmission.com
Message-Id: <20060413030040.20516.9231.sendpatchset@cherry.local>
Subject: [PATCH] Kexec: Remove order
Date: Thu, 13 Apr 2006 11:59:39 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kexec: Remove order

This patch replaces kexec n-order allocation code with 0-order only.

Almost all kexec allocations are 0-order pages already, with the exception of 
some x86_64 specific code that requests two physically contiguous pages. 

These two physically contiguous pages are easily replaced with two separate
pages. The second page is kept in an architecture specific pointer that is
added to struct kimage.

Using 0-order allocations only greatly simplifies kexec porting work to
the Xen hypervisor.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

The patch has been tested on x86_64. Apply on top of linux-2.6.17-rc1-git5.

 arch/i386/kernel/machine_kexec.c       |    4 -
 arch/powerpc/kernel/machine_kexec_32.c |    2
 arch/ppc/kernel/machine_kexec.c        |    2
 arch/x86_64/kernel/machine_kexec.c     |   37 ++++++++++------
 include/asm-i386/kexec.h               |    2
 include/asm-powerpc/kexec.h            |    2
 include/asm-s390/kexec.h               |    3 -
 include/asm-sh/kexec.h                 |    2
 include/asm-x86_64/kexec.h             |    3 -
 include/linux/kexec.h                  |    8 ---
 kernel/kexec.c                         |   72 ++++++++++++--------------------
 11 files changed, 58 insertions(+), 79 deletions(-)

--- 0001/arch/i386/kernel/machine_kexec.c
+++ work/arch/i386/kernel/machine_kexec.c	2006-04-13 11:31:45.000000000 +0900
@@ -140,8 +140,8 @@ const extern unsigned int relocate_new_k
 /*
  * A architecture hook called to validate the
  * proposed image and prepare the control pages
- * as needed.  The pages for KEXEC_CONTROL_CODE_SIZE
- * have been allocated, but the segments have yet
+ * as needed.  The page for the control code has
+ * been allocated, but the segments have yet
  * been copied into the kernel.
  *
  * Do what every setup is needed on image and the
--- 0001/arch/powerpc/kernel/machine_kexec_32.c
+++ work/arch/powerpc/kernel/machine_kexec_32.c	2006-04-13 11:33:20.000000000 +0900
@@ -51,7 +51,7 @@ void default_machine_kexec(struct kimage
 						relocate_new_kernel_size);
 
 	flush_icache_range(reboot_code_buffer,
-				reboot_code_buffer + KEXEC_CONTROL_CODE_SIZE);
+				reboot_code_buffer + PAGE_SIZE);
 	printk(KERN_INFO "Bye!\n");
 
 	/* now call it */
--- 0001/arch/ppc/kernel/machine_kexec.c
+++ work/arch/ppc/kernel/machine_kexec.c	2006-04-13 11:32:50.000000000 +0900
@@ -108,7 +108,7 @@ void machine_kexec_simple(struct kimage 
 						relocate_new_kernel_size);
 
 	flush_icache_range(reboot_code_buffer,
-				reboot_code_buffer + KEXEC_CONTROL_CODE_SIZE);
+				reboot_code_buffer + PAGE_SIZE);
 	printk(KERN_INFO "Bye!\n");
 
 	/* now call it */
--- 0001/arch/x86_64/kernel/machine_kexec.c
+++ work/arch/x86_64/kernel/machine_kexec.c	2006-04-13 11:26:25.000000000 +0900
@@ -40,7 +40,7 @@ static int init_level3_page(struct kimag
 		struct page *page;
 		pmd_t *level2p;
 
-		page = kimage_alloc_control_pages(image, 0);
+		page = kimage_alloc_control_page(image);
 		if (!page) {
 			result = -ENOMEM;
 			goto out;
@@ -73,7 +73,7 @@ static int init_level4_page(struct kimag
 		struct page *page;
 		pud_t *level3p;
 
-		page = kimage_alloc_control_pages(image, 0);
+		page = kimage_alloc_control_page(image);
 		if (!page) {
 			result = -ENOMEM;
 			goto out;
@@ -154,12 +154,20 @@ const extern unsigned long relocate_new_
 
 int machine_kexec_prepare(struct kimage *image)
 {
-	unsigned long start_pgtable, control_code_buffer;
+	unsigned long start_pgtable, control_code;
+	struct page *page;
 	int result;
 
-	/* Calculate the offsets */
-	start_pgtable = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
-	control_code_buffer = start_pgtable + PAGE_SIZE;
+	page = kimage_alloc_control_page(image);
+	if (!page) {
+		printk(KERN_ERR "Could not allocate start_pgtable\n");
+		return -ENOMEM;
+	}
+
+	image->arch_private = page;
+
+	control_code = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
+	start_pgtable = page_to_pfn(page) << PAGE_SHIFT;
 
 	/* Setup the identity mapped 64bit page table */
 	result = init_pgtable(image, start_pgtable);
@@ -167,7 +175,7 @@ int machine_kexec_prepare(struct kimage 
 		return result;
 
 	/* Place the code in the reboot code buffer */
-	memcpy(__va(control_code_buffer), relocate_new_kernel,
+	memcpy(__va(control_code), relocate_new_kernel,
 						relocate_new_kernel_size);
 
 	return 0;
@@ -185,17 +193,20 @@ void machine_kexec_cleanup(struct kimage
 NORET_TYPE void machine_kexec(struct kimage *image)
 {
 	unsigned long page_list;
-	unsigned long control_code_buffer;
+	unsigned long control_code;
 	unsigned long start_pgtable;
+	struct page *page;
 	relocate_new_kernel_t rnk;
 
+	page = image->arch_private;
+	BUG_ON(!page);
+
 	/* Interrupts aren't acceptable while we reboot */
 	local_irq_disable();
 
-	/* Calculate the offsets */
+	control_code = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
+	start_pgtable = page_to_pfn(page) << PAGE_SHIFT;
 	page_list = image->head;
-	start_pgtable = page_to_pfn(image->control_code_page) << PAGE_SHIFT;
-	control_code_buffer = start_pgtable + PAGE_SIZE;
 
 	/* Set the low half of the page table to my identity mapped
 	 * page table for kexec.  Leave the high half pointing at the
@@ -226,6 +237,6 @@ NORET_TYPE void machine_kexec(struct kim
 	set_gdt(phys_to_virt(0),0);
 	set_idt(phys_to_virt(0),0);
 	/* now call it */
-	rnk = (relocate_new_kernel_t) control_code_buffer;
-	(*rnk)(page_list, control_code_buffer, image->start, start_pgtable);
+	rnk = (relocate_new_kernel_t) control_code;
+	(*rnk)(page_list, control_code, image->start, start_pgtable);
 }
--- 0001/include/asm-i386/kexec.h
+++ work/include/asm-i386/kexec.h	2006-04-13 11:26:25.000000000 +0900
@@ -22,8 +22,6 @@
 /* Maximum address we can use for the control code buffer */
 #define KEXEC_CONTROL_MEMORY_LIMIT TASK_SIZE
 
-#define KEXEC_CONTROL_CODE_SIZE	4096
-
 /* The native architecture */
 #define KEXEC_ARCH KEXEC_ARCH_386
 
--- 0001/include/asm-powerpc/kexec.h
+++ work/include/asm-powerpc/kexec.h	2006-04-13 11:26:25.000000000 +0900
@@ -22,8 +22,6 @@
 #define KEXEC_CONTROL_MEMORY_LIMIT TASK_SIZE
 #endif
 
-#define KEXEC_CONTROL_CODE_SIZE 4096
-
 /* The native architecture */
 #ifdef __powerpc64__
 #define KEXEC_ARCH KEXEC_ARCH_PPC64
--- 0001/include/asm-s390/kexec.h
+++ work/include/asm-s390/kexec.h	2006-04-13 11:26:25.000000000 +0900
@@ -28,9 +28,6 @@
 /* Not more than 2GB */
 #define KEXEC_CONTROL_MEMORY_LIMIT (1<<31)
 
-/* Allocate one page for the pdp and the second for the code */
-#define KEXEC_CONTROL_CODE_SIZE 4096
-
 /* The native architecture */
 #define KEXEC_ARCH KEXEC_ARCH_S390
 
--- 0001/include/asm-sh/kexec.h
+++ work/include/asm-sh/kexec.h	2006-04-13 11:26:25.000000000 +0900
@@ -18,8 +18,6 @@
 /* Maximum address we can use for the control code buffer */
 #define KEXEC_CONTROL_MEMORY_LIMIT TASK_SIZE
 
-#define KEXEC_CONTROL_CODE_SIZE	4096
-
 /* The native architecture */
 #define KEXEC_ARCH KEXEC_ARCH_SH
 
--- 0001/include/asm-x86_64/kexec.h
+++ work/include/asm-x86_64/kexec.h	2006-04-13 11:26:25.000000000 +0900
@@ -21,9 +21,6 @@
 /* Maximum address we can use for the control pages */
 #define KEXEC_CONTROL_MEMORY_LIMIT     (0xFFFFFFFFFFUL)
 
-/* Allocate one page for the pdp and the second for the code */
-#define KEXEC_CONTROL_CODE_SIZE  (4096UL + 4096UL)
-
 /* The native architecture */
 #define KEXEC_ARCH KEXEC_ARCH_X86_64
 
--- 0001/include/linux/kexec.h
+++ work/include/linux/kexec.h	2006-04-13 11:26:25.000000000 +0900
@@ -23,10 +23,6 @@
 #error KEXEC_CONTROL_MEMORY_LIMIT not defined
 #endif
 
-#ifndef KEXEC_CONTROL_CODE_SIZE
-#error KEXEC_CONTROL_CODE_SIZE not defined
-#endif
-
 #ifndef KEXEC_ARCH
 #error KEXEC_ARCH not defined
 #endif
@@ -68,6 +64,7 @@ struct kimage {
 
 	unsigned long start;
 	struct page *control_code_page;
+	void *arch_private;
 
 	unsigned long nr_segments;
 	struct kexec_segment segment[KEXEC_SEGMENT_MAX];
@@ -101,8 +98,7 @@ extern asmlinkage long compat_sys_kexec_
 				struct compat_kexec_segment __user *segments,
 				unsigned long flags);
 #endif
-extern struct page *kimage_alloc_control_pages(struct kimage *image,
-						unsigned int order);
+extern struct page *kimage_alloc_control_page(struct kimage *image);
 extern void crash_kexec(struct pt_regs *);
 int kexec_should_crash(struct task_struct *);
 extern struct kimage *kexec_image;
--- 0001/kernel/kexec.c
+++ work/kernel/kexec.c	2006-04-13 11:42:06.000000000 +0900
@@ -59,10 +59,8 @@ int kexec_should_crash(struct task_struc
  * KEXEC_SOURCE_MEMORY_LIMIT and KEXEC_DEST_MEMORY_LIMIT can be
  * defined more restrictively in <asm/kexec.h>.
  *
- * The code for the transition from the current kernel to the
- * the new kernel is placed in the control_code_buffer, whose size
- * is given by KEXEC_CONTROL_CODE_SIZE.  In the best case only a single
- * page of memory is necessary, but some architectures require more.
+ * The code for the transition from the current kernel to the new kernel
+ * is placed in the control_code_buffer, whose size must be a single page.
  * Because this memory must be identity mapped in the transition from
  * virtual to physical addresses it must live in the range
  * 0 - TASK_SIZE, as only the user space mappings are arbitrarily
@@ -226,8 +224,7 @@ static int kimage_normal_alloc(struct ki
 	 * counted as destination pages.
 	 */
 	result = -ENOMEM;
-	image->control_code_page = kimage_alloc_control_pages(image,
-					   get_order(KEXEC_CONTROL_CODE_SIZE));
+	image->control_code_page = kimage_alloc_control_page(image);
 	if (!image->control_code_page) {
 		printk(KERN_ERR "Could not allocate control_code_buffer\n");
 		goto out;
@@ -295,8 +292,7 @@ static int kimage_crash_alloc(struct kim
 	 * counted as destination pages.
 	 */
 	result = -ENOMEM;
-	image->control_code_page = kimage_alloc_control_pages(image,
-					   get_order(KEXEC_CONTROL_CODE_SIZE));
+	image->control_code_page = kimage_alloc_control_page(image);
 	if (!image->control_code_page) {
 		printk(KERN_ERR "Could not allocate control_code_buffer\n");
 		goto out;
@@ -330,32 +326,23 @@ static int kimage_is_destination_range(s
 	return 0;
 }
 
-static struct page *kimage_alloc_pages(gfp_t gfp_mask, unsigned int order)
+static struct page *kimage_alloc_one_page(gfp_t gfp_mask)
 {
-	struct page *pages;
+	struct page *page;
 
-	pages = alloc_pages(gfp_mask, order);
-	if (pages) {
-		unsigned int count, i;
-		pages->mapping = NULL;
-		set_page_private(pages, order);
-		count = 1 << order;
-		for (i = 0; i < count; i++)
-			SetPageReserved(pages + i);
+	page = alloc_pages(gfp_mask, 0);
+	if (page) {
+		page->mapping = NULL;
+		SetPageReserved(page);
 	}
 
-	return pages;
+	return page;
 }
 
-static void kimage_free_pages(struct page *page)
+static void kimage_free_one_page(struct page *page)
 {
-	unsigned int order, count, i;
-
-	order = page_private(page);
-	count = 1 << order;
-	for (i = 0; i < count; i++)
-		ClearPageReserved(page + i);
-	__free_pages(page, order);
+	ClearPageReserved(page);
+	__free_pages(page, 0);
 }
 
 static void kimage_free_page_list(struct list_head *list)
@@ -367,12 +354,11 @@ static void kimage_free_page_list(struct
 
 		page = list_entry(pos, struct page, lru);
 		list_del(&page->lru);
-		kimage_free_pages(page);
+		kimage_free_one_page(page);
 	}
 }
 
-static struct page *kimage_alloc_normal_control_pages(struct kimage *image,
-							unsigned int order)
+static struct page *kimage_alloc_normal_control_page(struct kimage *image)
 {
 	/* Control pages are special, they are the intermediaries
 	 * that are needed while we copy the rest of the pages
@@ -391,7 +377,7 @@ static struct page *kimage_alloc_normal_
 	struct page *pages;
 	unsigned int count;
 
-	count = 1 << order;
+	count = 1;
 	INIT_LIST_HEAD(&extra_pages);
 
 	/* Loop while I can allocate a page and the page allocated
@@ -400,7 +386,7 @@ static struct page *kimage_alloc_normal_
 	do {
 		unsigned long pfn, epfn, addr, eaddr;
 
-		pages = kimage_alloc_pages(GFP_KERNEL, order);
+		pages = kimage_alloc_one_page(GFP_KERNEL);
 		if (!pages)
 			break;
 		pfn   = page_to_pfn(pages);
@@ -420,7 +406,7 @@ static struct page *kimage_alloc_normal_
 
 		/* Because the page is already in it's destination
 		 * location we will never allocate another page at
-		 * that address.  Therefore kimage_alloc_pages
+		 * that address.  Therefore kimage_alloc_one_page
 		 * will not return it (again) and we don't need
 		 * to give it an entry in image->segment[].
 		 */
@@ -437,8 +423,7 @@ static struct page *kimage_alloc_normal_
 	return pages;
 }
 
-static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
-						      unsigned int order)
+static struct page *kimage_alloc_crash_control_page(struct kimage *image)
 {
 	/* Control pages are special, they are the intermediaries
 	 * that are needed while we copy the rest of the pages
@@ -465,7 +450,7 @@ static struct page *kimage_alloc_crash_c
 	struct page *pages;
 
 	pages = NULL;
-	size = (1 << order) << PAGE_SHIFT;
+	size = 1 << PAGE_SHIFT;
 	hole_start = (image->control_page + (size - 1)) & ~(size - 1);
 	hole_end   = hole_start + size - 1;
 	while (hole_end <= crashk_res.end) {
@@ -501,21 +486,20 @@ static struct page *kimage_alloc_crash_c
 }
 
 
-struct page *kimage_alloc_control_pages(struct kimage *image,
-					 unsigned int order)
+struct page *kimage_alloc_control_page(struct kimage *image)
 {
-	struct page *pages = NULL;
+	struct page *page = NULL;
 
 	switch (image->type) {
 	case KEXEC_TYPE_DEFAULT:
-		pages = kimage_alloc_normal_control_pages(image, order);
+		page = kimage_alloc_normal_control_page(image);
 		break;
 	case KEXEC_TYPE_CRASH:
-		pages = kimage_alloc_crash_control_pages(image, order);
+		page = kimage_alloc_crash_control_page(image);
 		break;
 	}
 
-	return pages;
+	return page;
 }
 
 static int kimage_add_entry(struct kimage *image, kimage_entry_t entry)
@@ -600,7 +584,7 @@ static void kimage_free_entry(kimage_ent
 	struct page *page;
 
 	page = pfn_to_page(entry >> PAGE_SHIFT);
-	kimage_free_pages(page);
+	kimage_free_one_page(page);
 }
 
 static void kimage_free(struct kimage *image)
@@ -697,7 +681,7 @@ static struct page *kimage_alloc_page(st
 		kimage_entry_t *old;
 
 		/* Allocate a page, if we run out of memory give up */
-		page = kimage_alloc_pages(gfp_mask, 0);
+		page = kimage_alloc_one_page(gfp_mask);
 		if (!page)
 			return NULL;
 		/* If the page cannot be used file it away */
