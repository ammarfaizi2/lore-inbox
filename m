Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264192AbUEHWAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUEHWAv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264193AbUEHWAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:00:51 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:50568 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S264192AbUEHWAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 18:00:22 -0400
Date: Sat, 8 May 2004 23:00:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 27 memset 0 vma
In-Reply-To: <Pine.LNX.4.44.0405082250570.26569-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0405082259150.26569-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're NULLifying more and more fields when initializing a vma
(mpol_set_vma_default does that too, if configured to do anything).
Now use memset to avoid specifying fields, and save a little code too.

(Yes, I realize anon_vma will want to set vm_pgoff non-0, but I think
that will be better handled at the core, since anon vm_pgoff is
negotiable up until an anon_vma is actually assigned.)

 arch/ia64/ia32/binfmt_elf32.c |   10 ++--------
 arch/ia64/kernel/perfmon.c    |    7 ++-----
 arch/ia64/mm/init.c           |    7 +------
 fs/exec.c                     |    7 ++-----
 mm/mmap.c                     |   17 +++++------------
 5 files changed, 12 insertions(+), 36 deletions(-)

--- rmap26/arch/ia64/ia32/binfmt_elf32.c	2004-05-08 20:54:54.347237808 +0100
+++ rmap27/arch/ia64/ia32/binfmt_elf32.c	2004-05-08 20:55:05.446550456 +0100
@@ -73,15 +73,13 @@ ia64_elf32_init (struct pt_regs *regs)
 	 */
 	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (vma) {
+		memset(vma, 0, sizeof(*vma));
 		vma->vm_mm = current->mm;
 		vma->vm_start = IA32_GDT_OFFSET;
 		vma->vm_end = vma->vm_start + PAGE_SIZE;
 		vma->vm_page_prot = PAGE_SHARED;
 		vma->vm_flags = VM_READ|VM_MAYREAD;
 		vma->vm_ops = &ia32_shared_page_vm_ops;
-		vma->vm_pgoff = 0;
-		vma->vm_file = NULL;
-		vma->vm_private_data = NULL;
 		down_write(&current->mm->mmap_sem);
 		{
 			insert_vm_struct(current->mm, vma);
@@ -95,16 +93,12 @@ ia64_elf32_init (struct pt_regs *regs)
 	 */
 	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (vma) {
+		memset(vma, 0, sizeof(*vma));
 		vma->vm_mm = current->mm;
 		vma->vm_start = IA32_LDT_OFFSET;
 		vma->vm_end = vma->vm_start + PAGE_ALIGN(IA32_LDT_ENTRIES*IA32_LDT_ENTRY_SIZE);
 		vma->vm_page_prot = PAGE_SHARED;
 		vma->vm_flags = VM_READ|VM_WRITE|VM_MAYREAD|VM_MAYWRITE;
-		vma->vm_ops = NULL;
-		vma->vm_pgoff = 0;
-		vma->vm_file = NULL;
-		vma->vm_private_data = NULL;
-		mpol_set_vma_default(vma);
 		down_write(&current->mm->mmap_sem);
 		{
 			insert_vm_struct(current->mm, vma);
--- rmap26/arch/ia64/kernel/perfmon.c	2004-05-05 13:29:08.000000000 +0100
+++ rmap27/arch/ia64/kernel/perfmon.c	2004-05-08 20:55:05.453549392 +0100
@@ -2295,6 +2295,8 @@ pfm_smpl_buffer_alloc(struct task_struct
 		DPRINT(("Cannot allocate vma\n"));
 		goto error_kmem;
 	}
+	memset(vma, 0, sizeof(*vma));
+
 	/*
 	 * partially initialize the vma for the sampling buffer
 	 *
@@ -2305,11 +2307,6 @@ pfm_smpl_buffer_alloc(struct task_struct
 	vma->vm_mm	     = mm;
 	vma->vm_flags	     = VM_READ| VM_MAYREAD |VM_RESERVED;
 	vma->vm_page_prot    = PAGE_READONLY; /* XXX may need to change */
-	vma->vm_ops	     = NULL;
-	vma->vm_pgoff	     = 0;
-	vma->vm_file	     = NULL;
-	mpol_set_vma_default(vma);
-	vma->vm_private_data = NULL; 
 
 	/*
 	 * Now we have everything we need and we can initialize
--- rmap26/arch/ia64/mm/init.c	2004-05-08 20:54:54.349237504 +0100
+++ rmap27/arch/ia64/mm/init.c	2004-05-08 20:55:05.456548936 +0100
@@ -123,16 +123,12 @@ ia64_init_addr_space (void)
 	 */
 	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (vma) {
+		memset(vma, 0, sizeof(*vma));
 		vma->vm_mm = current->mm;
 		vma->vm_start = current->thread.rbs_bot & PAGE_MASK;
 		vma->vm_end = vma->vm_start + PAGE_SIZE;
 		vma->vm_page_prot = protection_map[VM_DATA_DEFAULT_FLAGS & 0x7];
 		vma->vm_flags = VM_READ|VM_WRITE|VM_MAYREAD|VM_MAYWRITE|VM_GROWSUP;
-		vma->vm_ops = NULL;
-		vma->vm_pgoff = 0;
-		vma->vm_file = NULL;
-		vma->vm_private_data = NULL;
-		mpol_set_vma_default(vma);
 		insert_vm_struct(current->mm, vma);
 	}
 
@@ -145,7 +141,6 @@ ia64_init_addr_space (void)
 			vma->vm_end = PAGE_SIZE;
 			vma->vm_page_prot = __pgprot(pgprot_val(PAGE_READONLY) | _PAGE_MA_NAT);
 			vma->vm_flags = VM_READ | VM_MAYREAD | VM_IO | VM_RESERVED;
-			mpol_set_vma_default(vma);
 			insert_vm_struct(current->mm, vma);
 		}
 	}
--- rmap26/fs/exec.c	2004-05-08 20:54:54.354236744 +0100
+++ rmap27/fs/exec.c	2004-05-08 20:55:05.458548632 +0100
@@ -406,6 +406,8 @@ int __setup_arg_pages(struct linux_binpr
 		return -ENOMEM;
 	}
 
+	memset(mpnt, 0, sizeof(*mpnt));
+
 	down_write(&mm->mmap_sem);
 	{
 		mpnt->vm_mm = mm;
@@ -419,11 +421,6 @@ int __setup_arg_pages(struct linux_binpr
 #endif
 		mpnt->vm_flags = vm_stack_flags;
 		mpnt->vm_page_prot = protection_map[mpnt->vm_flags & 0x7];
-		mpnt->vm_ops = NULL;
-		mpnt->vm_pgoff = 0;
-		mpnt->vm_file = NULL;
-		mpol_set_vma_default(mpnt);
-		mpnt->vm_private_data = (void *) 0;
 		insert_vm_struct(mm, mpnt);
 		mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
 	}
--- rmap26/mm/mmap.c	2004-05-05 13:29:10.000000000 +0100
+++ rmap27/mm/mmap.c	2004-05-08 20:55:05.460548328 +0100
@@ -688,21 +688,18 @@ munmap_back:
 	 * not unmapped, but the maps are removed from the list.
 	 */
 	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
-	error = -ENOMEM;
-	if (!vma)
+	if (!vma) {
+		error = -ENOMEM;
 		goto unacct_error;
+	}
+	memset(vma, 0, sizeof(*vma));
 
 	vma->vm_mm = mm;
 	vma->vm_start = addr;
 	vma->vm_end = addr + len;
 	vma->vm_flags = vm_flags;
 	vma->vm_page_prot = protection_map[vm_flags & 0x0f];
-	vma->vm_ops = NULL;
 	vma->vm_pgoff = pgoff;
-	vma->vm_file = NULL;
-	vma->vm_private_data = NULL;
-	vma->vm_next = NULL;
-	mpol_set_vma_default(vma);
 
 	if (file) {
 		error = -EINVAL;
@@ -1446,17 +1443,13 @@ unsigned long do_brk(unsigned long addr,
 		vm_unacct_memory(len >> PAGE_SHIFT);
 		return -ENOMEM;
 	}
+	memset(vma, 0, sizeof(*vma));
 
 	vma->vm_mm = mm;
 	vma->vm_start = addr;
 	vma->vm_end = addr + len;
 	vma->vm_flags = flags;
 	vma->vm_page_prot = protection_map[flags & 0x0f];
-	vma->vm_ops = NULL;
-	vma->vm_pgoff = 0;
-	vma->vm_file = NULL;
-	vma->vm_private_data = NULL;
-	mpol_set_vma_default(vma);
 	vma_link(mm, vma, prev, rb_link, rb_parent);
 out:
 	mm->total_vm += len >> PAGE_SHIFT;

