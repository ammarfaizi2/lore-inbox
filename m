Return-Path: <linux-kernel-owner+w=401wt.eu-S1751129AbXANFhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbXANFhF (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 00:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbXANFhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 00:37:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58976 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751123AbXANFhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 00:37:01 -0500
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-Fcc: ~/Mail/linus
In-Reply-To: Roland McGrath's message of  Saturday, 13 January 2007 21:31:39 -0800 <20070114053140.351701800E5@magilla.sf.frob.com>
Subject: [PATCH 9/11] i386 vDSO: use install_special_mapping
X-Antipastobozoticataclysm: Bariumenemanilow
Message-Id: <20070114053657.10F031800E5@magilla.sf.frob.com>
Date: Sat, 13 Jan 2007 21:36:57 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch uses install_special_mapping for the i386 vDSO setup,
consolidating duplicated code.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/i386/kernel/sysenter.c |   53 +++++++++----------------------------------
 1 files changed, 11 insertions(+), 42 deletions(-)

diff --git a/arch/i386/kernel/sysenter.c b/arch/i386/kernel/sysenter.c
index 5da7442..bc882a2 100644  
--- a/arch/i386/kernel/sysenter.c
+++ b/arch/i386/kernel/sysenter.c
@@ -70,11 +70,12 @@ void enable_sep_cpu(void)
  */
 extern const char vsyscall_int80_start, vsyscall_int80_end;
 extern const char vsyscall_sysenter_start, vsyscall_sysenter_end;
-static void *syscall_page;
+static struct page *syscall_pages[1];
 
 int __init sysenter_setup(void)
 {
-	syscall_page = (void *)get_zeroed_page(GFP_ATOMIC);
+	void *syscall_page = (void *)get_zeroed_page(GFP_ATOMIC);
+	syscall_pages[0] = virt_to_page(syscall_page);
 
 #ifdef CONFIG_COMPAT_VDSO
 	__set_fixmap(FIX_VDSO, __pa(syscall_page), PAGE_READONLY);
@@ -96,31 +97,12 @@ int __init sysenter_setup(void)
 }
 
 #ifndef CONFIG_COMPAT_VDSO
-static struct page *syscall_nopage(struct vm_area_struct *vma,
-				unsigned long adr, int *type)
-{
-	struct page *p = virt_to_page(adr - vma->vm_start + syscall_page);
-	get_page(p);
-	return p;
-}
-
-/* Prevent VMA merging */
-static void syscall_vma_close(struct vm_area_struct *vma)
-{
-}
-
-static struct vm_operations_struct syscall_vm_ops = {
-	.close = syscall_vma_close,
-	.nopage = syscall_nopage,
-};
-
 /* Defined in vsyscall-sysenter.S */
 extern void SYSENTER_RETURN;
 
 /* Setup a VMA at program startup for the vsyscall page */
 int arch_setup_additional_pages(struct linux_binprm *bprm, int exstack)
 {
-	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
 	unsigned long addr;
 	int ret;
@@ -132,38 +114,25 @@ int arch_setup_additional_pages(struct l
 		goto up_fail;
 	}
 
-	vma = kmem_cache_zalloc(vm_area_cachep, GFP_KERNEL);
-	if (!vma) {
-		ret = -ENOMEM;
-		goto up_fail;
-	}
-
-	vma->vm_start = addr;
-	vma->vm_end = addr + PAGE_SIZE;
-	/* MAYWRITE to allow gdb to COW and set breakpoints */
-	vma->vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC|VM_MAYWRITE;
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
-	vma->vm_ops = &syscall_vm_ops;
-	vma->vm_mm = mm;
-
-	ret = insert_vm_struct(mm, vma);
-	if (unlikely(ret)) {
-		kmem_cache_free(vm_area_cachep, vma);
+	ret = install_special_mapping(mm, addr, PAGE_SIZE,
+				      VM_READ|VM_EXEC|
+				      VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
+				      VM_ALWAYSDUMP,
+				      syscall_pages);
+	if (ret)
 		goto up_fail;
-	}
 
 	current->mm->context.vdso = (void *)addr;
 	current_thread_info()->sysenter_return =
 				    (void *)VDSO_SYM(&SYSENTER_RETURN);
-	mm->total_vm++;
 up_fail:
 	up_write(&mm->mmap_sem);
 	return ret;
