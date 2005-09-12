Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbVILQoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbVILQoO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 12:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbVILQoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 12:44:13 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:20286 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932085AbVILQoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 12:44:13 -0400
Message-ID: <4325B188.10404@sw.ru>
Date: Mon, 12 Sep 2005 20:49:12 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, xemul@sw.ru
Subject: [PATCH] error path in setup_arg_pages() misses vm_unacct_memory()
Content-Type: multipart/mixed;
 boundary="------------060209080807050209010000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060209080807050209010000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

[PATCH] error path in setup_arg_pages() misses vm_unacct_memory()

This patch fixes error path in setup_arg_pages() functions, since it 
misses vm_unacct_memory() after successful call of 
security_vm_enough_memory(). Also it cleans up error path.

Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
Signed-Off-By: Kirill Korotaev <dev@sw.ru>

Kirill
P.S. against 2.6.13

--------------060209080807050209010000
Content-Type: text/plain;
 name="diff-ms-unacct-error-20050912"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-ms-unacct-error-20050912"

--- linux-2.6.13.1/arch/ia64/ia32/binfmt_elf32.c.accterr	2005-09-12 13:59:50.000000000 +0400
+++ linux-2.6.13.1/arch/ia64/ia32/binfmt_elf32.c	2005-09-12 15:10:16.000000000 +0400
@@ -199,7 +199,7 @@
 int
 ia32_setup_arg_pages (struct linux_binprm *bprm, int executable_stack)
 {
-	unsigned long stack_base;
+	unsigned long stack_base, vm_end, vm_start;
 	struct vm_area_struct *mpnt;
 	struct mm_struct *mm = current->mm;
 	int i, ret;
@@ -212,23 +212,24 @@
 		bprm->loader += stack_base;
 	bprm->exec += stack_base;
 
+	ret = -ENOMEM;
 	mpnt = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (!mpnt)
-		return -ENOMEM;
+		goto out;
 
-	if (security_vm_enough_memory((IA32_STACK_TOP - (PAGE_MASK & (unsigned long) bprm->p))
-				      >> PAGE_SHIFT)) {
-		kmem_cache_free(vm_area_cachep, mpnt);
-		return -ENOMEM;
-	}
+	vm_end = IA32_STACK_TOP;
+	vm_start = PAGE_MASK & (unsigned long)bprm->p;
+
+	if (security_vm_enough_memory((vm_end - vm_start) >> PAGE_SHIFT))
+		goto out_free;
 
 	memset(mpnt, 0, sizeof(*mpnt));
 
 	down_write(&current->mm->mmap_sem);
 	{
 		mpnt->vm_mm = current->mm;
-		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
-		mpnt->vm_end = IA32_STACK_TOP;
+		mpnt->vm_start = vm_start;
+		mpnt->vm_end = vm_end;
 		if (executable_stack == EXSTACK_ENABLE_X)
 			mpnt->vm_flags = VM_STACK_FLAGS |  VM_EXEC;
 		else if (executable_stack == EXSTACK_DISABLE_X)
@@ -237,11 +238,8 @@
 			mpnt->vm_flags = VM_STACK_FLAGS;
 		mpnt->vm_page_prot = (mpnt->vm_flags & VM_EXEC)?
 					PAGE_COPY_EXEC: PAGE_COPY;
-		if ((ret = insert_vm_struct(current->mm, mpnt))) {
-			up_write(&current->mm->mmap_sem);
-			kmem_cache_free(vm_area_cachep, mpnt);
-			return ret;
-		}
+		if ((ret = insert_vm_struct(current->mm, mpnt)))
+			goto out_up;
 		current->mm->stack_vm = current->mm->total_vm = vma_pages(mpnt);
 	}
 
@@ -260,6 +258,14 @@
 	current->thread.ppl = ia32_init_pp_list();
 
 	return 0;
+
+out_up:
+	up_write(&current->mm->mmap_sem);
+	vm_unacct_memory((vm_end - vm_start) >> PAGE_SHIFT);
+out_free:
+	kmem_cache_free(vm_area_cachep, mpnt);
+out:
+	return ret;
 }
 
 static void
--- linux-2.6.13.1/arch/x86_64/ia32/ia32_binfmt.c.accterr	2005-09-12 14:00:30.000000000 +0400
+++ linux-2.6.13.1/arch/x86_64/ia32/ia32_binfmt.c	2005-09-12 15:18:45.000000000 +0400
@@ -337,7 +337,7 @@
 
 int setup_arg_pages(struct linux_binprm *bprm, unsigned long stack_top, int executable_stack)
 {
-	unsigned long stack_base;
+	unsigned long stack_base, vm_end, vm_start;
 	struct vm_area_struct *mpnt;
 	struct mm_struct *mm = current->mm;
 	int i, ret;
@@ -350,22 +350,24 @@
 		bprm->loader += stack_base;
 	bprm->exec += stack_base;
 
+	ret = -ENOMEM;
 	mpnt = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
-	if (!mpnt) 
-		return -ENOMEM; 
+	if (!mpnt)
+		goto out;
+
+	vm_end = IA32_STACK_TOP;
+	vm_start = PAGE_MASK & (unsigned long)bprm->p;
 	
-	if (security_vm_enough_memory((IA32_STACK_TOP - (PAGE_MASK & (unsigned long) bprm->p))>>PAGE_SHIFT)) {
-		kmem_cache_free(vm_area_cachep, mpnt);
-		return -ENOMEM;
-	}
+	if (security_vm_enough_memory((vm_end - vm_start)>>PAGE_SHIFT))
+		goto out_free;
 
 	memset(mpnt, 0, sizeof(*mpnt));
 
 	down_write(&mm->mmap_sem);
 	{
 		mpnt->vm_mm = mm;
-		mpnt->vm_start = PAGE_MASK & (unsigned long) bprm->p;
-		mpnt->vm_end = IA32_STACK_TOP;
+		mpnt->vm_start = vm_start;
+		mpnt->vm_end = vm_end;
 		if (executable_stack == EXSTACK_ENABLE_X)
 			mpnt->vm_flags = VM_STACK_FLAGS |  VM_EXEC;
 		else if (executable_stack == EXSTACK_DISABLE_X)
@@ -374,11 +376,8 @@
 			mpnt->vm_flags = VM_STACK_FLAGS;
  		mpnt->vm_page_prot = (mpnt->vm_flags & VM_EXEC) ? 
  			PAGE_COPY_EXEC : PAGE_COPY;
-		if ((ret = insert_vm_struct(mm, mpnt))) {
-			up_write(&mm->mmap_sem);
-			kmem_cache_free(vm_area_cachep, mpnt);
-			return ret;
-		}
+		if ((ret = insert_vm_struct(mm, mpnt)))
+			goto out_up;
 		mm->stack_vm = mm->total_vm = vma_pages(mpnt);
 	} 
 
@@ -393,6 +392,14 @@
 	up_write(&mm->mmap_sem);
 	
 	return 0;
+
+out_up:
+	up_write(&mm->mmap_sem);
+	vm_unacct_memory((vm_end - vm_start) >> PAGE_SHIFT);
+out_free:
+	kmem_cache_free(vm_area_cachep, mpnt);
+out:
+	return ret;
 }
 
 static unsigned long
--- linux-2.6.13.1/arch/x86_64/ia32/syscall32.c.accterr	2005-09-12 14:00:29.000000000 +0400
+++ linux-2.6.13.1/arch/x86_64/ia32/syscall32.c	2005-09-12 15:23:07.000000000 +0400
@@ -10,6 +10,7 @@
 #include <linux/init.h>
 #include <linux/stringify.h>
 #include <linux/security.h>
+#include <linux/mman.h>
 #include <asm/proto.h>
 #include <asm/tlbflush.h>
 #include <asm/ia32_unistd.h>
@@ -49,13 +50,12 @@
 	struct mm_struct *mm = current->mm;
 	int ret;
 
+	ret = -ENOMEM;
 	vma = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (!vma)
-		return -ENOMEM;
-	if (security_vm_enough_memory(npages)) {
-		kmem_cache_free(vm_area_cachep, vma);
-		return -ENOMEM;
-	}
+		goto out;
+	if (security_vm_enough_memory(npages))
+		goto out_free;
 
 	memset(vma, 0, sizeof(struct vm_area_struct));
 	/* Could randomize here */
@@ -69,14 +69,19 @@
 	vma->vm_mm = mm;
 
 	down_write(&mm->mmap_sem);
-	if ((ret = insert_vm_struct(mm, vma))) {
-		up_write(&mm->mmap_sem);
-		kmem_cache_free(vm_area_cachep, vma);
-		return ret;
-	}
+	if ((ret = insert_vm_struct(mm, vma)))
+		goto out_up;
 	mm->total_vm += npages;
 	up_write(&mm->mmap_sem);
 	return 0;
+
+out_up:
+	up_write(&mm->mmap_sem);
+	vm_unacct_memory(npages);
+out_free:
+	kmem_cache_free(vm_area_cachep, vma);
+out:
+	return ret;
 }
 
 static int __init init_syscall32(void)
--- linux-2.6.13.1/fs/exec.c.accterr	2005-09-12 14:01:43.000000000 +0400
+++ linux-2.6.13.1/fs/exec.c	2005-09-12 15:20:38.000000000 +0400
@@ -417,14 +417,13 @@
 		bprm->loader += stack_base;
 	bprm->exec += stack_base;
 
+	ret = -ENOMEM;
 	mpnt = kmem_cache_alloc(vm_area_cachep, SLAB_KERNEL);
 	if (!mpnt)
-		return -ENOMEM;
+		goto out;
 
-	if (security_vm_enough_memory(arg_size >> PAGE_SHIFT)) {
-		kmem_cache_free(vm_area_cachep, mpnt);
-		return -ENOMEM;
-	}
+	if (security_vm_enough_memory(arg_size >> PAGE_SHIFT))
+		goto out_free;
 
 	memset(mpnt, 0, sizeof(*mpnt));
 
@@ -449,11 +448,8 @@
 			mpnt->vm_flags = VM_STACK_FLAGS;
 		mpnt->vm_flags |= mm->def_flags;
 		mpnt->vm_page_prot = protection_map[mpnt->vm_flags & 0x7];
-		if ((ret = insert_vm_struct(mm, mpnt))) {
-			up_write(&mm->mmap_sem);
-			kmem_cache_free(vm_area_cachep, mpnt);
-			return ret;
-		}
+		if ((ret = insert_vm_struct(mm, mpnt)))
+			goto out_up;
 		mm->stack_vm = mm->total_vm = vma_pages(mpnt);
 	}
 
@@ -468,6 +464,14 @@
 	up_write(&mm->mmap_sem);
 	
 	return 0;
+
+out_up:
+	up_write(&mm->mmap_sem);
+	vm_unacct_memory(arg_size >> PAGE_SHIFT);
+out_free:
+	kmem_cache_free(vm_area_cachep, mpnt);
+out:
+	return ret;
 }
 
 EXPORT_SYMBOL(setup_arg_pages);

--------------060209080807050209010000--

