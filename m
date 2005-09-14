Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbVINFbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbVINFbG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 01:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbVINFbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 01:31:06 -0400
Received: from gold.veritas.com ([143.127.12.110]:61020 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S965003AbVINFbD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 01:31:03 -0400
Date: Wed, 14 Sep 2005 06:13:02 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Kirill Korotaev <dev@sw.ru>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, xemul@sw.ru
Subject: Re: [PATCH] error path in setup_arg_pages() misses vm_unacct_memory()
In-Reply-To: <Pine.LNX.4.61.0509131217200.7040@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0509140605320.3433@goblin.wat.veritas.com>
References: <4325B188.10404@sw.ru> <20050912132352.6d3a0e3a.akpm@osdl.org>
 <Pine.LNX.4.61.0509131217200.7040@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 14 Sep 2005 05:31:03.0397 (UTC) FILETIME=[7F645950:01C5B8ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005, Hugh Dickins wrote:
> On Mon, 12 Sep 2005, Andrew Morton wrote:
> > 
> > Patch looks OK to me.  Hugh, could you please double-check sometime?
> 
> It's a good find, and the patch looks correct to me, so far as it goes.
> But I think it's the wrong patch, and incomplete: it can be done more
> appropriately, more simply and more completely in insert_vm_struct itself.
> I'll post a replacement patch (or admit I'm wrong) in a little while.

Many thanks, Andrew, for confirming that ppc64 does indeed leak into
Committed_AS, as it looked to me.  Here's my version of Pavel/Kirill's
patches: sorry if it seems "weird" to Kirill, perhaps we need to change
the name of insert_vm_struct too; but it seems safer and easier to get
right this way.  And I prefer deleting code to adding it...


Pavel Emelianov and Kirill Korotaev observe that fs and arch users of
security_vm_enough_memory tend to forget to vm_unacct_memory when a
failure occurs further down (typically in setup_arg_pages variants).

These are all users of insert_vm_struct, and that reservation will only
be unaccounted on exit if the vma is marked VM_ACCOUNT: which in some
cases it is (hidden inside VM_STACK_FLAGS) and in some cases it isn't.

So x86_64 32-bit and ppc64 vDSO ELFs have been leaking memory into
Committed_AS each time they're run.  But don't add VM_ACCOUNT to them,
it's inappropriate to reserve against the very unlikely case that gdb
be used to COW a vDSO page - we ought to do something about that in
do_wp_page, but there are yet other inconsistencies to be resolved.

The safe and economical way to fix this is to let insert_vm_struct do
the security_vm_enough_memory check when it finds VM_ACCOUNT is set.

And the MIPS irix_brk has been calling security_vm_enough_memory before
calling do_brk which repeats it, doubly accounting and so also leaking.
Remove that, and all the fs and arch calls to security_vm_enough_memory:
give it a less misleading name later on.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 arch/ia64/ia32/binfmt_elf32.c  |    6 ------
 arch/mips/kernel/sysirix.c     |    9 ++-------
 arch/ppc64/kernel/vdso.c       |   15 +++++++++------
 arch/x86_64/ia32/ia32_binfmt.c |    5 -----
 arch/x86_64/ia32/syscall32.c   |    6 +-----
 fs/exec.c                      |    5 -----
 mm/mmap.c                      |    3 +++
 7 files changed, 15 insertions(+), 34 deletions(-)

--- 2.6.14-rc1/arch/ia64/ia32/binfmt_elf32.c	2005-03-02 07:39:16.000000000 +0000
+++ linux/arch/ia64/ia32/binfmt_elf32.c	2005-09-13 17:58:28.000000000 +0100
@@ -216,12 +216,6 @@ ia32_setup_arg_pages (struct linux_binpr
 	if (!mpnt)
 		return -ENOMEM;
 
-	if (security_vm_enough_memory((IA32_STACK_TOP - (PAGE_MASK & (unsigned long) bprm->p))
-				      >> PAGE_SHIFT)) {
-		kmem_cache_free(vm_area_cachep, mpnt);
-		return -ENOMEM;
-	}
-
 	memset(mpnt, 0, sizeof(*mpnt));
 
 	down_write(&current->mm->mmap_sem);
--- 2.6.14-rc1/arch/mips/kernel/sysirix.c	2005-09-13 15:22:15.000000000 +0100
+++ linux/arch/mips/kernel/sysirix.c	2005-09-13 18:51:43.000000000 +0100
@@ -581,18 +581,13 @@ asmlinkage int irix_brk(unsigned long br
 	}
 
 	/*
-	 * Check if we have enough memory..
+	 * Ok, looks good - let it rip.
 	 */
-	if (security_vm_enough_memory((newbrk-oldbrk) >> PAGE_SHIFT)) {
+	if (do_brk(oldbrk, newbrk-oldbrk) != oldbrk) {
 		ret = -ENOMEM;
 		goto out;
 	}
-
-	/*
-	 * Ok, looks good - let it rip.
-	 */
 	mm->brk = brk;
-	do_brk(oldbrk, newbrk-oldbrk);
 	ret = 0;
 
 out:
--- 2.6.14-rc1/arch/ppc64/kernel/vdso.c	2005-06-17 20:48:29.000000000 +0100
+++ linux/arch/ppc64/kernel/vdso.c	2005-09-13 20:50:02.000000000 +0100
@@ -224,10 +224,7 @@ int arch_setup_additional_pages(struct l
 	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (vma == NULL)
 		return -ENOMEM;
-	if (security_vm_enough_memory(vdso_pages)) {
-		kmem_cache_free(vm_area_cachep, vma);
-		return -ENOMEM;
-	}
+
 	memset(vma, 0, sizeof(*vma));
 
 	/*
@@ -237,8 +234,10 @@ int arch_setup_additional_pages(struct l
 	 */
 	vdso_base = get_unmapped_area(NULL, vdso_base,
 				      vdso_pages << PAGE_SHIFT, 0, 0);
-	if (vdso_base & ~PAGE_MASK)
+	if (vdso_base & ~PAGE_MASK) {
+		kmem_cache_free(vm_area_cachep, vma);
 		return (int)vdso_base;
+	}
 
 	current->thread.vdso_base = vdso_base;
 
@@ -266,7 +265,11 @@ int arch_setup_additional_pages(struct l
 	vma->vm_ops = &vdso_vmops;
 
 	down_write(&mm->mmap_sem);
-	insert_vm_struct(mm, vma);
+	if (insert_vm_struct(mm, vma)) {
+		up_write(&mm->mmap_sem);
+		kmem_cache_free(vm_area_cachep, vma);
+		return -ENOMEM;
+	}
 	mm->total_vm += (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 	up_write(&mm->mmap_sem);
 
--- 2.6.14-rc1/arch/x86_64/ia32/ia32_binfmt.c	2005-08-29 00:41:01.000000000 +0100
+++ linux/arch/x86_64/ia32/ia32_binfmt.c	2005-09-13 18:05:20.000000000 +0100
@@ -353,11 +353,6 @@ int setup_arg_pages(struct linux_binprm 
 	mpnt = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (!mpnt) 
 		return -ENOMEM; 
-	
-	if (security_vm_enough_memory((IA32_STACK_TOP - (PAGE_MASK & (unsigned long) bprm->p))>>PAGE_SHIFT)) {
-		kmem_cache_free(vm_area_cachep, mpnt);
-		return -ENOMEM;
-	}
 
 	memset(mpnt, 0, sizeof(*mpnt));
 
--- 2.6.14-rc1/arch/x86_64/ia32/syscall32.c	2005-08-29 00:41:01.000000000 +0100
+++ linux/arch/x86_64/ia32/syscall32.c	2005-09-13 18:53:32.000000000 +0100
@@ -52,17 +52,13 @@ int syscall32_setup_pages(struct linux_b
 	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (!vma)
 		return -ENOMEM;
-	if (security_vm_enough_memory(npages)) {
-		kmem_cache_free(vm_area_cachep, vma);
-		return -ENOMEM;
-	}
 
 	memset(vma, 0, sizeof(struct vm_area_struct));
 	/* Could randomize here */
 	vma->vm_start = VSYSCALL32_BASE;
 	vma->vm_end = VSYSCALL32_END;
 	/* MAYWRITE to allow gdb to COW and set breakpoints */
-	vma->vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC|VM_MAYEXEC|VM_MAYWRITE;
+	vma->vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC|VM_MAYWRITE;
 	vma->vm_flags |= mm->def_flags;
 	vma->vm_page_prot = protection_map[vma->vm_flags & 7];
 	vma->vm_ops = &syscall32_vm_ops;
--- 2.6.14-rc1/fs/exec.c	2005-09-13 15:22:37.000000000 +0100
+++ linux/fs/exec.c	2005-09-13 17:50:46.000000000 +0100
@@ -421,11 +421,6 @@ int setup_arg_pages(struct linux_binprm 
 	if (!mpnt)
 		return -ENOMEM;
 
-	if (security_vm_enough_memory(arg_size >> PAGE_SHIFT)) {
-		kmem_cache_free(vm_area_cachep, mpnt);
-		return -ENOMEM;
-	}
-
 	memset(mpnt, 0, sizeof(*mpnt));
 
 	down_write(&mm->mmap_sem);
--- 2.6.14-rc1/mm/mmap.c	2005-09-13 15:22:47.000000000 +0100
+++ linux/mm/mmap.c	2005-09-13 18:59:59.000000000 +0100
@@ -1993,6 +1993,9 @@ int insert_vm_struct(struct mm_struct * 
 	__vma = find_vma_prepare(mm,vma->vm_start,&prev,&rb_link,&rb_parent);
 	if (__vma && __vma->vm_start < vma->vm_end)
 		return -ENOMEM;
+	if ((vma->vm_flags & VM_ACCOUNT) &&
+	     security_vm_enough_memory(vma_pages(vma)))
+		return -ENOMEM;
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 	return 0;
 }
