Return-Path: <linux-kernel-owner+w=401wt.eu-S1751124AbXANFiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbXANFiD (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 00:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbXANFiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 00:38:03 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59189 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130AbXANFiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 00:38:00 -0500
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-Fcc: ~/Mail/linus
In-Reply-To: Roland McGrath's message of  Saturday, 13 January 2007 21:31:39 -0800 <20070114053140.351701800E5@magilla.sf.frob.com>
Subject: [PATCH 10/11] x86_64 ia32 vDSO: use install_special_mapping
X-Windows: the art of incompetence.
Message-Id: <20070114053726.75FFF1800E5@magilla.sf.frob.com>
Date: Sat, 13 Jan 2007 21:37:26 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch uses install_special_mapping for the ia32 vDSO setup,
consolidating duplicated code.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/x86_64/ia32/syscall32.c |   75 ++++++++++++------------------------------
 include/asm-x86_64/proto.h   |    1 -
 2 files changed, 21 insertions(+), 55 deletions(-)

diff --git a/arch/x86_64/ia32/syscall32.c b/arch/x86_64/ia32/syscall32.c
index 59f1fa1..3939f10 100644  
--- a/arch/x86_64/ia32/syscall32.c
+++ b/arch/x86_64/ia32/syscall32.c
@@ -18,68 +18,34 @@ extern unsigned char syscall32_syscall[]
 extern unsigned char syscall32_sysenter[], syscall32_sysenter_end[];
 extern int sysctl_vsyscall32;
 
-char *syscall32_page; 
+static struct page *syscall32_pages[1];
 static int use_sysenter = -1;
 
-static struct page *
-syscall32_nopage(struct vm_area_struct *vma, unsigned long adr, int *type)
-{
-	struct page *p = virt_to_page(adr - vma->vm_start + syscall32_page);
-	get_page(p);
-	return p;
-}
-
-/* Prevent VMA merging */
-static void syscall32_vma_close(struct vm_area_struct *vma)
-{
-}
-
-static struct vm_operations_struct syscall32_vm_ops = {
-	.close = syscall32_vma_close,
-	.nopage = syscall32_nopage,
-};
-
 struct linux_binprm;
 
 /* Setup a VMA at program startup for the vsyscall page */
 int syscall32_setup_pages(struct linux_binprm *bprm, int exstack)
 {
-	int npages = (VSYSCALL32_END - VSYSCALL32_BASE) >> PAGE_SHIFT;
-	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
 	int ret;
 
-	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
-	if (!vma)
-		return -ENOMEM;
-
-	memset(vma, 0, sizeof(struct vm_area_struct));
-	/* Could randomize here */
-	vma->vm_start = VSYSCALL32_BASE;
-	vma->vm_end = VSYSCALL32_END;
-	/* MAYWRITE to allow gdb to COW and set breakpoints */
-	vma->vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC|VM_MAYWRITE;
+	down_write(&mm->mmap_sem);
 	/*
+	 * MAYWRITE to allow gdb to COW and set breakpoints
+	 *
 	 * Make sure the vDSO gets into every core dump.
 	 * Dumping its contents makes post-mortem fully interpretable later
 	 * without matching up the same kernel and hardware config to see
 	 * what PC values meant.
 	 */
-	vma->vm_flags |= VM_ALWAYSDUMP;
-	vma->vm_flags |= mm->def_flags;
-	vma->vm_page_prot = protection_map[vma->vm_flags & 7];
-	vma->vm_ops = &syscall32_vm_ops;
-	vma->vm_mm = mm;
-
-	down_write(&mm->mmap_sem);
-	if ((ret = insert_vm_struct(mm, vma))) {
-		up_write(&mm->mmap_sem);
-		kmem_cache_free(vm_area_cachep, vma);
-		return ret;
-	}
-	mm->total_vm += npages;
+	/* Could randomize here */
+	ret = install_special_mapping(mm, VSYSCALL32_BASE, PAGE_SIZE,
+				      VM_READ|VM_EXEC|
+				      VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
+				      VM_ALWAYSDUMP,
+				      syscall32_pages);
 	up_write(&mm->mmap_sem);
-	return 0;
+	return ret;
 }
 
 const char *arch_vma_name(struct vm_area_struct *vma)
@@ -92,9 +58,10 @@ const char *arch_vma_name(struct vm_area
 
 static int __init init_syscall32(void)
 { 
-	syscall32_page = (void *)get_zeroed_page(GFP_KERNEL); 
+	char *syscall32_page = (void *)get_zeroed_page(GFP_KERNEL);
 	if (!syscall32_page) 
 		panic("Cannot allocate syscall32 page"); 
+	syscall32_pages[0] = virt_to_page(syscall32_page);
  	if (use_sysenter > 0) {
  		memcpy(syscall32_page, syscall32_sysenter,
  		       syscall32_sysenter_end - syscall32_sysenter);
diff --git a/include/asm-x86_64/proto.h b/include/asm-x86_64/proto.h
index 6d324b8..a6d2ff5 100644  
--- a/include/asm-x86_64/proto.h
+++ b/include/asm-x86_64/proto.h
@@ -81,7 +81,6 @@ extern void swap_low_mappings(void);
 extern void __show_regs(struct pt_regs * regs);
 extern void show_regs(struct pt_regs * regs);
 
-extern char *syscall32_page;
 extern void syscall32_cpu_init(void);
 
 extern void setup_node_bootmem(int nodeid, unsigned long start, unsigned long end);
