Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbUKXBZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbUKXBZH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 20:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbUKXBYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 20:24:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:54738 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261665AbUKXBTE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 20:19:04 -0500
Date: Tue, 23 Nov 2004 17:23:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: hugh@veritas.com, chrisw@osdl.org, torvalds@osdl.org, tony.luck@intel.com,
       schwidefsky@de.ibm.com, ak@suse.de, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [PATCH 1/2] setup_arg_pages can insert overlapping vma
Message-Id: <20041123172309.60d9e9c1.akpm@osdl.org>
In-Reply-To: <894E37DECA393E4D9374E0ACBBE7427013C9AB@pdsmsx402.ccr.corp.intel.com>
References: <894E37DECA393E4D9374E0ACBBE7427013C9AB@pdsmsx402.ccr.corp.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Zou, Nanhai" <nanhai.zou@intel.com> wrote:
>
> I think ia64 ia32
> subsystem is not vulnerable to this kind of overlapping vm problem,
> because it does not support a.out binary format, 
> X84_64 is vulnerable to this. 

Martin, Andi and Tony: could we please get a 2.6.10 ack on this from you?

Thanks.

(It sounds like s390 needs more work?)

From: "Zou, Nanhai" <nanhai.zou@intel.com>

IA64 is also vulnerable to the huge-vma-in-executable bug in 64 bit elf
support, it just insert a vma of zero page without checking overlap, so user
can construct a elf with section begin from 0x0 to trigger this BUGON().

I attach a testcase to trigger this bug I don't know what about s390.

However, I think it's safe to check overlap before we actually insert a vma
into vma list.  And I also feel check vma overlap everywhere is unnecessary,
because invert_vm_struct will check it again, so the check is duplicated. 
It's better to have invert_vm_struct return a value then let caller check if
it successes.  Here is a patch against 2.6.10.rc2-mm3 I have tested it on
i386, x86_64 and ia64 machines.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Zou Nan hai <Nanhai.zou@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/ia64/ia32/binfmt_elf32.c  |   26 +++++++++++++++++++++-----
 25-akpm/arch/ia64/mm/init.c            |   16 ++++++++++++++--
 25-akpm/arch/s390/kernel/compat_exec.c |    8 ++++++--
 25-akpm/arch/x86_64/ia32/ia32_binfmt.c |    8 ++++++--
 25-akpm/fs/exec.c                      |    9 +++------
 25-akpm/include/linux/mm.h             |    2 +-
 25-akpm/mm/mmap.c                      |    5 +++--
 7 files changed, 54 insertions(+), 20 deletions(-)

diff -puN arch/ia64/ia32/binfmt_elf32.c~ia64-overlapping-vma-fix arch/ia64/ia32/binfmt_elf32.c
--- 25/arch/ia64/ia32/binfmt_elf32.c~ia64-overlapping-vma-fix	Tue Nov 23 17:21:30 2004
+++ 25-akpm/arch/ia64/ia32/binfmt_elf32.c	Tue Nov 23 17:21:30 2004
@@ -100,7 +100,11 @@ ia64_elf32_init (struct pt_regs *regs)
 		vma->vm_ops = &ia32_shared_page_vm_ops;
 		down_write(&current->mm->mmap_sem);
 		{
-			insert_vm_struct(current->mm, vma);
+			if (insert_vm_struct(current->mm, vma)) {
+				kmem_cache_free(vm_area_cachep, vma);
+				up_write(&current->mm->mmap_sem);
+				return;
+			}
 		}
 		up_write(&current->mm->mmap_sem);
 	}
@@ -123,7 +127,11 @@ ia64_elf32_init (struct pt_regs *regs)
 		vma->vm_ops = &ia32_gate_page_vm_ops;
 		down_write(&current->mm->mmap_sem);
 		{
-			insert_vm_struct(current->mm, vma);
+			if (insert_vm_struct(current->mm, vma)) {
+				kmem_cache_free(vm_area_cachep, vma);
+				up_write(&current->mm->mmap_sem);
+				return;
+			}
 		}
 		up_write(&current->mm->mmap_sem);
 	}
@@ -142,7 +150,11 @@ ia64_elf32_init (struct pt_regs *regs)
 		vma->vm_flags = VM_READ|VM_WRITE|VM_MAYREAD|VM_MAYWRITE;
 		down_write(&current->mm->mmap_sem);
 		{
-			insert_vm_struct(current->mm, vma);
+			if (insert_vm_struct(current->mm, vma)) {
+				kmem_cache_free(vm_area_cachep, vma);
+				up_write(&current->mm->mmap_sem);
+				return;
+			}
 		}
 		up_write(&current->mm->mmap_sem);
 	}
@@ -190,7 +202,7 @@ ia32_setup_arg_pages (struct linux_binpr
 	unsigned long stack_base;
 	struct vm_area_struct *mpnt;
 	struct mm_struct *mm = current->mm;
-	int i;
+	int i, ret;
 
 	stack_base = IA32_STACK_TOP - MAX_ARG_PAGES*PAGE_SIZE;
 	mm->arg_start = bprm->p + stack_base;
@@ -225,7 +237,11 @@ ia32_setup_arg_pages (struct linux_binpr
 			mpnt->vm_flags = VM_STACK_FLAGS;
 		mpnt->vm_page_prot = (mpnt->vm_flags & VM_EXEC)?
 					PAGE_COPY_EXEC: PAGE_COPY;
-		insert_vm_struct(current->mm, mpnt);
+		if ((ret = insert_vm_struct(current->mm, mpnt))) {
+			up_write(&current->mm->mmap_sem);
+			kmem_cache_free(vm_area_cachep, mpnt);
+			return ret;
+		}
 		current->mm->stack_vm = current->mm->total_vm = vma_pages(mpnt);
 	}
 
diff -puN arch/ia64/mm/init.c~ia64-overlapping-vma-fix arch/ia64/mm/init.c
--- 25/arch/ia64/mm/init.c~ia64-overlapping-vma-fix	Tue Nov 23 17:21:30 2004
+++ 25-akpm/arch/ia64/mm/init.c	Tue Nov 23 17:21:30 2004
@@ -131,7 +131,13 @@ ia64_init_addr_space (void)
 		vma->vm_end = vma->vm_start + PAGE_SIZE;
 		vma->vm_page_prot = protection_map[VM_DATA_DEFAULT_FLAGS & 0x7];
 		vma->vm_flags = VM_DATA_DEFAULT_FLAGS | VM_GROWSUP;
-		insert_vm_struct(current->mm, vma);
+		down_write(&current->mm->mmap_sem);
+		if (insert_vm_struct(current->mm, vma)) {
+			up_write(&current->mm->mmap_sem);
+			kmem_cache_free(vm_area_cachep, vma);
+			return;
+		}
+		up_write(&current->mm->mmap_sem);
 	}
 
 	/* map NaT-page at address zero to speed up speculative dereferencing of NULL: */
@@ -143,7 +149,13 @@ ia64_init_addr_space (void)
 			vma->vm_end = PAGE_SIZE;
 			vma->vm_page_prot = __pgprot(pgprot_val(PAGE_READONLY) | _PAGE_MA_NAT);
 			vma->vm_flags = VM_READ | VM_MAYREAD | VM_IO | VM_RESERVED;
-			insert_vm_struct(current->mm, vma);
+			down_write(&current->mm->mmap_sem);
+			if (insert_vm_struct(current->mm, vma)) {
+				up_write(&current->mm->mmap_sem);
+				kmem_cache_free(vm_area_cachep, vma);
+				return;
+			}
+			up_write(&current->mm->mmap_sem);
 		}
 	}
 }
diff -puN arch/s390/kernel/compat_exec.c~ia64-overlapping-vma-fix arch/s390/kernel/compat_exec.c
--- 25/arch/s390/kernel/compat_exec.c~ia64-overlapping-vma-fix	Tue Nov 23 17:21:30 2004
+++ 25-akpm/arch/s390/kernel/compat_exec.c	Tue Nov 23 17:21:30 2004
@@ -39,7 +39,7 @@ int setup_arg_pages32(struct linux_binpr
 	unsigned long stack_base;
 	struct vm_area_struct *mpnt;
 	struct mm_struct *mm = current->mm;
-	int i;
+	int i, ret;
 
 	stack_base = STACK_TOP - MAX_ARG_PAGES*PAGE_SIZE;
 	mm->arg_start = bprm->p + stack_base;
@@ -68,7 +68,11 @@ int setup_arg_pages32(struct linux_binpr
 		/* executable stack setting would be applied here */
 		mpnt->vm_page_prot = PAGE_COPY;
 		mpnt->vm_flags = VM_STACK_FLAGS;
-		insert_vm_struct(mm, mpnt);
+		if ((ret = insert_vm_struct(mm, mpnt))) {
+			up_write(&mm->mmap_sem);
+			kmem_cache_free(vm_area_cachep, mpnt);
+			return ret;
+		}
 		mm->stack_vm = mm->total_vm = vma_pages(mpnt);
 	} 
 
diff -puN arch/x86_64/ia32/ia32_binfmt.c~ia64-overlapping-vma-fix arch/x86_64/ia32/ia32_binfmt.c
--- 25/arch/x86_64/ia32/ia32_binfmt.c~ia64-overlapping-vma-fix	Tue Nov 23 17:21:30 2004
+++ 25-akpm/arch/x86_64/ia32/ia32_binfmt.c	Tue Nov 23 17:21:30 2004
@@ -334,7 +334,7 @@ int setup_arg_pages(struct linux_binprm 
 	unsigned long stack_base;
 	struct vm_area_struct *mpnt;
 	struct mm_struct *mm = current->mm;
-	int i;
+	int i, ret;
 
 	stack_base = IA32_STACK_TOP - MAX_ARG_PAGES * PAGE_SIZE;
 	mm->arg_start = bprm->p + stack_base;
@@ -368,7 +368,11 @@ int setup_arg_pages(struct linux_binprm 
 			mpnt->vm_flags = VM_STACK_FLAGS;
  		mpnt->vm_page_prot = (mpnt->vm_flags & VM_EXEC) ? 
  			PAGE_COPY_EXEC : PAGE_COPY;
-		insert_vm_struct(mm, mpnt);
+		if ((ret = insert_vm_struct(mm, mpnt))) {
+			up_write(&mm->mmap_sem);
+			kmem_cache_free(vm_area_cachep, mpnt);
+			return ret;
+		}
 		mm->stack_vm = mm->total_vm = vma_pages(mpnt);
 	} 
 
diff -puN fs/exec.c~ia64-overlapping-vma-fix fs/exec.c
--- 25/fs/exec.c~ia64-overlapping-vma-fix	Tue Nov 23 17:21:30 2004
+++ 25-akpm/fs/exec.c	Tue Nov 23 17:21:30 2004
@@ -342,7 +342,7 @@ int setup_arg_pages(struct linux_binprm 
 	unsigned long stack_base;
 	struct vm_area_struct *mpnt;
 	struct mm_struct *mm = current->mm;
-	int i;
+	int i, ret;
 	long arg_size;
 
 #ifdef CONFIG_STACK_GROWSUP
@@ -413,7 +413,6 @@ int setup_arg_pages(struct linux_binprm 
 
 	down_write(&mm->mmap_sem);
 	{
-		struct vm_area_struct *vma;
 		mpnt->vm_mm = mm;
 #ifdef CONFIG_STACK_GROWSUP
 		mpnt->vm_start = stack_base;
@@ -434,13 +433,11 @@ int setup_arg_pages(struct linux_binprm 
 			mpnt->vm_flags = VM_STACK_FLAGS;
 		mpnt->vm_flags |= mm->def_flags;
 		mpnt->vm_page_prot = protection_map[mpnt->vm_flags & 0x7];
-		vma = find_vma(mm, mpnt->vm_start);
-		if (vma) {
+		if ((ret = insert_vm_struct(mm, mpnt))) {
 			up_write(&mm->mmap_sem);
 			kmem_cache_free(vm_area_cachep, mpnt);
-			return -ENOMEM;
+			return ret;
 		}
-		insert_vm_struct(mm, mpnt);
 		mm->stack_vm = mm->total_vm = vma_pages(mpnt);
 	}
 
diff -puN include/linux/mm.h~ia64-overlapping-vma-fix include/linux/mm.h
--- 25/include/linux/mm.h~ia64-overlapping-vma-fix	Tue Nov 23 17:21:30 2004
+++ 25-akpm/include/linux/mm.h	Tue Nov 23 17:21:30 2004
@@ -675,7 +675,7 @@ extern struct vm_area_struct *vma_merge(
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
 extern int split_vma(struct mm_struct *,
 	struct vm_area_struct *, unsigned long addr, int new_below);
-extern void insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
+extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void __vma_link_rb(struct mm_struct *, struct vm_area_struct *,
 	struct rb_node **, struct rb_node *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
diff -puN mm/mmap.c~ia64-overlapping-vma-fix mm/mmap.c
--- 25/mm/mmap.c~ia64-overlapping-vma-fix	Tue Nov 23 17:21:30 2004
+++ 25-akpm/mm/mmap.c	Tue Nov 23 17:21:30 2004
@@ -1871,7 +1871,7 @@ void exit_mmap(struct mm_struct *mm)
  * and into the inode's i_mmap tree.  If vm_file is non-NULL
  * then i_mmap_lock is taken here.
  */
-void insert_vm_struct(struct mm_struct * mm, struct vm_area_struct * vma)
+int insert_vm_struct(struct mm_struct * mm, struct vm_area_struct * vma)
 {
 	struct vm_area_struct * __vma, * prev;
 	struct rb_node ** rb_link, * rb_parent;
@@ -1894,8 +1894,9 @@ void insert_vm_struct(struct mm_struct *
 	}
 	__vma = find_vma_prepare(mm,vma->vm_start,&prev,&rb_link,&rb_parent);
 	if (__vma && __vma->vm_start < vma->vm_end)
-		BUG();
+		return -ENOMEM;
 	vma_link(mm, vma, prev, rb_link, rb_parent);
+	return 0;
 }
 
 /*
_

