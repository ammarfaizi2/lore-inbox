Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262793AbUKRRo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbUKRRo1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbUKRRnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:43:35 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:33981 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262804AbUKRRkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:40:21 -0500
Date: Thu, 18 Nov 2004 17:39:59 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Chris Wright <chrisw@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Tony Luck <tony.luck@intel.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, Andi Kleen <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] setup_arg_pages can insert overlapping vma
In-Reply-To: <20041116151937.E2357@build.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0411181720550.2971-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004, Chris Wright wrote:
> Florian Heinz built an a.out binary that could map bss from 0x0 to
> 0xc0000000, and setup_arg_pages() would BUG() in insert_vma_struct
> because the arg pages overlapped.  This just checks before inserting,
> and bails out if it would overlap.

Chris, shouldn't your patch also cover the setup_arg_pages clones for
32-bit support on 64-bit architectures, with something - uncompiled,
untested - like the below?  I'm not sure how necessary the additional
vma->vm_start < mpnt->vm_end test is, but suspect ia64 might need it.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.10-rc2-bk2/arch/ia64/ia32/binfmt_elf32.c	2004-10-18 22:57:03.000000000 +0100
+++ linux/arch/ia64/ia32/binfmt_elf32.c	2004-11-18 17:17:57.000000000 +0000
@@ -214,6 +214,8 @@ ia32_setup_arg_pages (struct linux_binpr
 
 	down_write(&current->mm->mmap_sem);
 	{
+		struct vm_area_struct *vma;
+
 		mpnt->vm_mm = current->mm;
 		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
 		mpnt->vm_end = IA32_STACK_TOP;
@@ -225,6 +227,12 @@ ia32_setup_arg_pages (struct linux_binpr
 			mpnt->vm_flags = VM_STACK_FLAGS;
 		mpnt->vm_page_prot = (mpnt->vm_flags & VM_EXEC)?
 					PAGE_COPY_EXEC: PAGE_COPY;
+		vma = find_vma(current->mm, mpnt->vm_start);
+		if (vma && vma->vm_start < mpnt->vm_end) {
+			up_write(&current->mm->mmap_sem);
+			kmem_cache_free(vm_area_cachep, mpnt);
+			return -ENOMEM;
+		}
 		insert_vm_struct(current->mm, mpnt);
 		current->mm->stack_vm = current->mm->total_vm = vma_pages(mpnt);
 	}
--- 2.6.10-rc2-bk2/arch/s390/kernel/compat_exec.c	2004-10-18 22:56:50.000000000 +0100
+++ linux/arch/s390/kernel/compat_exec.c	2004-11-18 17:17:57.000000000 +0000
@@ -62,12 +62,20 @@ int setup_arg_pages32(struct linux_binpr
 
 	down_write(&mm->mmap_sem);
 	{
+		struct vm_area_struct *vma;
+
 		mpnt->vm_mm = mm;
 		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
 		mpnt->vm_end = STACK_TOP;
 		/* executable stack setting would be applied here */
 		mpnt->vm_page_prot = PAGE_COPY;
 		mpnt->vm_flags = VM_STACK_FLAGS;
+		vma = find_vma(mm, mpnt->vm_start);
+		if (vma && vma->vm_start < mpnt->vm_end) {
+			up_write(&mm->mmap_sem);
+			kmem_cache_free(vm_area_cachep, mpnt);
+			return -ENOMEM;
+		}
 		insert_vm_struct(mm, mpnt);
 		mm->stack_vm = mm->total_vm = vma_pages(mpnt);
 	} 
--- 2.6.10-rc2-bk2/arch/x86_64/ia32/ia32_binfmt.c	2004-11-15 16:20:34.000000000 +0000
+++ linux/arch/x86_64/ia32/ia32_binfmt.c	2004-11-18 17:17:57.000000000 +0000
@@ -357,6 +357,8 @@ int setup_arg_pages(struct linux_binprm 
 
 	down_write(&mm->mmap_sem);
 	{
+		struct vm_area_struct *vma;
+
 		mpnt->vm_mm = mm;
 		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
 		mpnt->vm_end = IA32_STACK_TOP;
@@ -368,6 +370,12 @@ int setup_arg_pages(struct linux_binprm 
 			mpnt->vm_flags = VM_STACK_FLAGS;
  		mpnt->vm_page_prot = (mpnt->vm_flags & VM_EXEC) ? 
  			PAGE_COPY_EXEC : PAGE_COPY;
+		vma = find_vma(mm, mpnt->vm_start);
+		if (vma && vma->vm_start < mpnt->vm_end) {
+			up_write(&mm->mmap_sem);
+			kmem_cache_free(vm_area_cachep, mpnt);
+			return -ENOMEM;
+		}
 		insert_vm_struct(mm, mpnt);
 		mm->stack_vm = mm->total_vm = vma_pages(mpnt);
 	} 

