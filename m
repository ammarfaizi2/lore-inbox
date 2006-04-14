Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWDNCtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWDNCtP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 22:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWDNCtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 22:49:15 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:17292 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751214AbWDNCtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 22:49:15 -0400
From: Magnus Damm <magnus@valinux.co.jp>
To: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Cc: Magnus Damm <magnus@valinux.co.jp>, ebiederm@xmission.com
Message-Id: <20060414025017.15979.43301.sendpatchset@cherry.local>
Subject: [PATCH] Kexec: Remove order for x86_64
Date: Fri, 14 Apr 2006 11:49:13 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kexec: Remove order for x86_64

This patch converts the x86_64 specific kexec code to 0-order allocations.
Instead of having two contiguous pages at image->control_code_page we now 
allocate two 0-order pages. One page is pointed to by image->control_code_page
and the other page is pointed to by the new member image->arch_private.

The main purpose of this modification is to simplify Xen porting work.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

The patch has been tested on x86_64. Apply on top of linux-2.6.17-rc1-git8.

 arch/x86_64/kernel/machine_kexec.c |   33 ++++++++++++++++++++++-----------
 include/asm-x86_64/kexec.h         |    3 +--
 include/linux/kexec.h              |    1 +
 3 files changed, 24 insertions(+), 13 deletions(-)

--- 0001/arch/x86_64/kernel/machine_kexec.c
+++ work/arch/x86_64/kernel/machine_kexec.c	2006-04-14 11:25:25.000000000 +0900
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
+	page = kimage_alloc_control_pages(image, 0);
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
--- 0001/include/asm-x86_64/kexec.h
+++ work/include/asm-x86_64/kexec.h	2006-04-14 11:25:25.000000000 +0900
@@ -21,8 +21,7 @@
 /* Maximum address we can use for the control pages */
 #define KEXEC_CONTROL_MEMORY_LIMIT     (0xFFFFFFFFFFUL)
 
-/* Allocate one page for the pdp and the second for the code */
-#define KEXEC_CONTROL_CODE_SIZE  (4096UL + 4096UL)
+#define KEXEC_CONTROL_CODE_SIZE 4096
 
 /* The native architecture */
 #define KEXEC_ARCH KEXEC_ARCH_X86_64
--- 0001/include/linux/kexec.h
+++ work/include/linux/kexec.h	2006-04-14 11:25:25.000000000 +0900
@@ -68,6 +68,7 @@ struct kimage {
 
 	unsigned long start;
 	struct page *control_code_page;
+	void *arch_private;
 
 	unsigned long nr_segments;
 	struct kexec_segment segment[KEXEC_SEGMENT_MAX];
