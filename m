Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264715AbUEEQG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264715AbUEEQG1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 12:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264717AbUEEQG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 12:06:27 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:2717 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264715AbUEEQGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 12:06:01 -0400
Date: Wed, 5 May 2004 09:05:31 -0700
From: Paul Jackson <pj@sgi.com>
To: Andi Kleen <ak@suse.de>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] NUMA API for Linux 5/ Add VMA hooks for policy
Message-Id: <20040505090531.51ad5c89.pj@sgi.com>
In-Reply-To: <20040406153713.52a64a26.ak@suse.de>
References: <20040406153322.5d6e986e.ak@suse.de>
	<20040406153713.52a64a26.ak@suse.de>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch doesn't build for ia64 sn2_defconfig.

The build fails with link complaints of:

arch/ia64/kernel/built-in.o(.text+0x10862): In function `pfm_smpl_buffer_alloc':
: undefined reference to `mpol_set_vma_default'
arch/ia64/mm/built-in.o(.text+0x412): In function `ia64_init_addr_space':
: undefined reference to `mpol_set_vma_default'
arch/ia64/mm/built-in.o(.text+0x522): In function `ia64_init_addr_space':
: undefined reference to `mpol_set_vma_default'
arch/ia64/ia32/built-in.o(.text+0x1f432): In function `ia64_elf32_init':
: undefined reference to `mpol_set_vma_default'
arch/ia64/ia32/built-in.o(.text+0x1f982): In function `ia32_setup_arg_pages':
: undefined reference to `mpol_set_vma_default'
kernel/built-in.o(.text+0x162b2): In function `do_exit':
: undefined reference to `mpol_free'
make: *** [.tmp_vmlinux1] Error 1

Presumably this is because the following mpol_set_vma_default() and
mpol_free() macro calls are added, but the mempolicy.h header providing
the defines for these macros is not included:

arch/ia64/ia32/binfmt_elf32.c:          mpol_set_vma_default(vma);
arch/ia64/ia32/binfmt_elf32.c:          mpol_set_vma_default(mpnt);
arch/ia64/kernel/perfmon.c:     mpol_set_vma_default(vma);
arch/ia64/mm/init.c:            mpol_set_vma_default(vma);
arch/ia64/mm/init.c:                    mpol_set_vma_default(vma);
kernel/exit.c:  mpol_free(tsk->mempolicy);

Looks like you should do something equivalent to adding:

  #include <linux/mempolicy.h>

to the files:

  arch/ia64/ia32/binfmt_elf32.c
  arch/ia64/kernel/perfmon.c
  arch/ia64/mm/init.c
  kernel/exit.c

The following, based off the numa-api-vma-policy-hooks patch in Andrew's
latest 2.6.6-rc3-mm2, includes these additional includes, and builds
successfully:

================================ snip ================================

From: Andi Kleen <ak@suse.de>

NUMA API adds a policy to each VMA.  During VMA creattion, merging and
splitting these policies must be handled properly.  This patch adds the calls
to this.  

It is a nop when CONFIG_NUMA is not defined.
DESC
numa-api-vma-policy-hooks fix
EDESC

mm/mmap.c: In function `copy_vma':
mm/mmap.c:1531: structure has no member named `vm_policy'


Index: 2.6.6-rc3-mm2-bitmapv5/arch/ia64/ia32/binfmt_elf32.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/arch/ia64/ia32/binfmt_elf32.c	2004-05-05 07:38:11.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/arch/ia64/ia32/binfmt_elf32.c	2004-05-05 08:48:27.000000000 -0700
@@ -13,6 +13,7 @@
 
 #include <linux/types.h>
 #include <linux/mm.h>
+#include <linux/mempolicy.h>
 #include <linux/security.h>
 
 #include <asm/param.h>
@@ -104,6 +105,7 @@
 		vma->vm_pgoff = 0;
 		vma->vm_file = NULL;
 		vma->vm_private_data = NULL;
+		mpol_set_vma_default(vma);
 		down_write(&current->mm->mmap_sem);
 		{
 			insert_vm_struct(current->mm, vma);
@@ -190,6 +192,7 @@
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
 		mpnt->vm_private_data = 0;
+		mpol_set_vma_default(mpnt);
 		insert_vm_struct(current->mm, mpnt);
 		current->mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
 	}
Index: 2.6.6-rc3-mm2-bitmapv5/arch/ia64/kernel/perfmon.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/arch/ia64/kernel/perfmon.c	2004-05-05 07:38:11.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/arch/ia64/kernel/perfmon.c	2004-05-05 08:48:38.000000000 -0700
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
+#include <linux/mempolicy.h>
 #include <linux/sysctl.h>
 #include <linux/list.h>
 #include <linux/file.h>
@@ -2308,6 +2309,7 @@
 	vma->vm_ops	     = NULL;
 	vma->vm_pgoff	     = 0;
 	vma->vm_file	     = NULL;
+	mpol_set_vma_default(vma);
 	vma->vm_private_data = NULL; 
 
 	/*
Index: 2.6.6-rc3-mm2-bitmapv5/arch/ia64/mm/init.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/arch/ia64/mm/init.c	2004-05-05 07:38:11.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/arch/ia64/mm/init.c	2004-05-05 08:48:48.000000000 -0700
@@ -12,6 +12,7 @@
 #include <linux/efi.h>
 #include <linux/elf.h>
 #include <linux/mm.h>
+#include <linux/mempolicy.h>
 #include <linux/mmzone.h>
 #include <linux/module.h>
 #include <linux/personality.h>
@@ -132,6 +133,7 @@
 		vma->vm_pgoff = 0;
 		vma->vm_file = NULL;
 		vma->vm_private_data = NULL;
+		mpol_set_vma_default(vma);
 		insert_vm_struct(current->mm, vma);
 	}
 
@@ -144,6 +146,7 @@
 			vma->vm_end = PAGE_SIZE;
 			vma->vm_page_prot = __pgprot(pgprot_val(PAGE_READONLY) | _PAGE_MA_NAT);
 			vma->vm_flags = VM_READ | VM_MAYREAD | VM_IO | VM_RESERVED;
+			mpol_set_vma_default(vma);
 			insert_vm_struct(current->mm, vma);
 		}
 	}
Index: 2.6.6-rc3-mm2-bitmapv5/arch/m68k/atari/stram.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/arch/m68k/atari/stram.c	2004-05-05 07:38:12.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/arch/m68k/atari/stram.c	2004-05-05 07:40:14.000000000 -0700
@@ -752,7 +752,7 @@
 			/* Get a page for the entry, using the existing
 			   swap cache page if there is one.  Otherwise,
 			   get a clean page and read the swap into it. */
-			page = read_swap_cache_async(entry);
+			page = read_swap_cache_async(entry, NULL, 0);
 			if (!page) {
 				swap_free(entry);
 				return -ENOMEM;
Index: 2.6.6-rc3-mm2-bitmapv5/arch/s390/kernel/compat_exec.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/arch/s390/kernel/compat_exec.c	2004-05-05 07:38:14.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/arch/s390/kernel/compat_exec.c	2004-05-05 08:45:17.000000000 -0700
@@ -72,6 +72,7 @@
 		mpnt->vm_ops = NULL;
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
+		mpol_set_vma_default(mpnt);
 		INIT_LIST_HEAD(&mpnt->shared);
 		mpnt->vm_private_data = (void *) 0;
 		insert_vm_struct(mm, mpnt);
Index: 2.6.6-rc3-mm2-bitmapv5/arch/x86_64/ia32/ia32_binfmt.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/arch/x86_64/ia32/ia32_binfmt.c	2004-05-05 07:38:17.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/arch/x86_64/ia32/ia32_binfmt.c	2004-05-05 08:45:17.000000000 -0700
@@ -365,6 +365,7 @@
 		mpnt->vm_ops = NULL;
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
+		mpol_set_vma_default(mpnt);
 		INIT_LIST_HEAD(&mpnt->shared);
 		mpnt->vm_private_data = (void *) 0;
 		insert_vm_struct(mm, mpnt);
Index: 2.6.6-rc3-mm2-bitmapv5/fs/exec.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/fs/exec.c	2004-05-05 07:40:13.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/fs/exec.c	2004-05-05 08:45:18.000000000 -0700
@@ -427,6 +427,7 @@
 		mpnt->vm_ops = NULL;
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
+		mpol_set_vma_default(mpnt);
 		INIT_LIST_HEAD(&mpnt->shared);
 		mpnt->vm_private_data = (void *) 0;
 		insert_vm_struct(mm, mpnt);
Index: 2.6.6-rc3-mm2-bitmapv5/kernel/exit.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/kernel/exit.c	2004-05-05 07:38:41.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/kernel/exit.c	2004-05-05 08:49:02.000000000 -0700
@@ -6,6 +6,7 @@
 
 #include <linux/config.h>
 #include <linux/mm.h>
+#include <linux/mempolicy.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/smp_lock.h>
@@ -790,6 +791,7 @@
 	__exit_fs(tsk);
 	exit_namespace(tsk);
 	exit_thread();
+	mpol_free(tsk->mempolicy);
 
 	if (tsk->signal->leader)
 		disassociate_ctty(1);
Index: 2.6.6-rc3-mm2-bitmapv5/kernel/fork.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/kernel/fork.c	2004-05-05 07:40:13.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/kernel/fork.c	2004-05-05 08:45:18.000000000 -0700
@@ -270,6 +270,7 @@
 	struct rb_node **rb_link, *rb_parent;
 	int retval;
 	unsigned long charge = 0;
+	struct mempolicy *pol;
 
 	down_write(&oldmm->mmap_sem);
 	flush_cache_mm(current->mm);
@@ -311,6 +312,11 @@
 		if (!tmp)
 			goto fail_nomem;
 		*tmp = *mpnt;
+		pol = mpol_copy(vma_policy(mpnt));
+		retval = PTR_ERR(pol);
+		if (IS_ERR(pol))
+			goto fail_nomem_policy;
+		vma_set_policy(tmp, pol);
 		tmp->vm_flags &= ~VM_LOCKED;
 		tmp->vm_mm = mm;
 		tmp->vm_next = NULL;
@@ -357,6 +363,8 @@
 	flush_tlb_mm(current->mm);
 	up_write(&oldmm->mmap_sem);
 	return retval;
+fail_nomem_policy:
+	kmem_cache_free(vm_area_cachep, tmp);
 fail_nomem:
 	retval = -ENOMEM;
 fail:
@@ -963,10 +971,16 @@
 	p->security = NULL;
 	p->io_context = NULL;
 	p->audit_context = NULL;
+ 	p->mempolicy = mpol_copy(p->mempolicy);
+ 	if (IS_ERR(p->mempolicy)) {
+ 		retval = PTR_ERR(p->mempolicy);
+ 		p->mempolicy = NULL;
+ 		goto bad_fork_cleanup;
+ 	}
 
 	retval = -ENOMEM;
 	if ((retval = security_task_alloc(p)))
-		goto bad_fork_cleanup;
+		goto bad_fork_cleanup_policy;
 	if ((retval = audit_alloc(p)))
 		goto bad_fork_cleanup_security;
 	/* copy all the process information */
@@ -1112,6 +1126,8 @@
 	audit_free(p);
 bad_fork_cleanup_security:
 	security_task_free(p);
+bad_fork_cleanup_policy:
+	mpol_free(p->mempolicy);
 bad_fork_cleanup:
 	if (p->pid > 0)
 		free_pidmap(p->pid);
Index: 2.6.6-rc3-mm2-bitmapv5/mm/mmap.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/mm/mmap.c	2004-05-05 07:40:14.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/mm/mmap.c	2004-05-05 08:45:18.000000000 -0700
@@ -387,7 +387,8 @@
 			struct vm_area_struct *prev,
 			struct rb_node *rb_parent, unsigned long addr, 
 			unsigned long end, unsigned long vm_flags,
-			struct file *file, unsigned long pgoff)
+		     	struct file *file, unsigned long pgoff,
+		        struct mempolicy *policy)
 {
 	spinlock_t *lock = &mm->page_table_lock;
 	struct inode *inode = file ? file->f_dentry->d_inode : NULL;
@@ -411,6 +412,7 @@
 	 * Can it merge with the predecessor?
 	 */
 	if (prev->vm_end == addr &&
+  		        mpol_equal(vma_policy(prev), policy) &&
 			can_vma_merge_after(prev, vm_flags, file, pgoff)) {
 		struct vm_area_struct *next;
 		int need_up = 0;
@@ -428,6 +430,7 @@
 		 */
 		next = prev->vm_next;
 		if (next && prev->vm_end == next->vm_start &&
+		    		vma_mpol_equal(prev, next) &&
 				can_vma_merge_before(next, vm_flags, file,
 					pgoff, (end - addr) >> PAGE_SHIFT)) {
 			prev->vm_end = next->vm_end;
@@ -440,6 +443,7 @@
 				fput(file);
 
 			mm->map_count--;
+			mpol_free(vma_policy(next));
 			kmem_cache_free(vm_area_cachep, next);
 			return prev;
 		}
@@ -455,6 +459,8 @@
 	prev = prev->vm_next;
 	if (prev) {
  merge_next:
+ 		if (!mpol_equal(policy, vma_policy(prev)))
+  			return 0;
 		if (!can_vma_merge_before(prev, vm_flags, file,
 				pgoff, (end - addr) >> PAGE_SHIFT))
 			return NULL;
@@ -631,7 +637,7 @@
 	/* Can we just expand an old anonymous mapping? */
 	if (!file && !(vm_flags & VM_SHARED) && rb_parent)
 		if (vma_merge(mm, prev, rb_parent, addr, addr + len,
-					vm_flags, NULL, 0))
+					vm_flags, NULL, pgoff, NULL))
 			goto out;
 
 	/*
@@ -654,6 +660,7 @@
 	vma->vm_file = NULL;
 	vma->vm_private_data = NULL;
 	vma->vm_next = NULL;
+	mpol_set_vma_default(vma);
 	INIT_LIST_HEAD(&vma->shared);
 
 	if (file) {
@@ -693,7 +700,9 @@
 	addr = vma->vm_start;
 
 	if (!file || !rb_parent || !vma_merge(mm, prev, rb_parent, addr,
-				addr + len, vma->vm_flags, file, pgoff)) {
+					      vma->vm_end,
+					      vma->vm_flags, file, pgoff,
+					      vma_policy(vma))) {
 		vma_link(mm, vma, prev, rb_link, rb_parent);
 		if (correct_wcount)
 			atomic_inc(&inode->i_writecount);
@@ -703,6 +712,7 @@
 				atomic_inc(&inode->i_writecount);
 			fput(file);
 		}
+		mpol_free(vma_policy(vma));
 		kmem_cache_free(vm_area_cachep, vma);
 	}
 out:	
@@ -1118,6 +1128,7 @@
 
 	remove_shared_vm_struct(area);
 
+	mpol_free(vma_policy(area));
 	if (area->vm_ops && area->vm_ops->close)
 		area->vm_ops->close(area);
 	if (area->vm_file)
@@ -1200,6 +1211,7 @@
 int split_vma(struct mm_struct * mm, struct vm_area_struct * vma,
 	      unsigned long addr, int new_below)
 {
+	struct mempolicy *pol;
 	struct vm_area_struct *new;
 	struct address_space *mapping = NULL;
 
@@ -1222,6 +1234,13 @@
 		new->vm_pgoff += ((addr - vma->vm_start) >> PAGE_SHIFT);
 	}
 
+	pol = mpol_copy(vma_policy(vma));
+	if (IS_ERR(pol)) {
+		kmem_cache_free(vm_area_cachep, new);
+		return PTR_ERR(pol);
+	}
+	vma_set_policy(new, pol);
+
 	if (new->vm_file)
 		get_file(new->vm_file);
 
@@ -1391,7 +1410,7 @@
 
 	/* Can we just expand an old anonymous mapping? */
 	if (rb_parent && vma_merge(mm, prev, rb_parent, addr, addr + len,
-					flags, NULL, 0))
+					flags, NULL, 0, NULL))
 		goto out;
 
 	/*
@@ -1412,6 +1431,7 @@
 	vma->vm_pgoff = 0;
 	vma->vm_file = NULL;
 	vma->vm_private_data = NULL;
+	mpol_set_vma_default(vma);
 	INIT_LIST_HEAD(&vma->shared);
 
 	vma_link(mm, vma, prev, rb_link, rb_parent);
@@ -1472,6 +1492,7 @@
 		}
 		if (vma->vm_file)
 			fput(vma->vm_file);
+		mpol_free(vma_policy(vma));
 		kmem_cache_free(vm_area_cachep, vma);
 		vma = next;
 	}
@@ -1508,7 +1529,7 @@
 
 	find_vma_prepare(mm, addr, &prev, &rb_link, &rb_parent);
 	new_vma = vma_merge(mm, prev, rb_parent, addr, addr + len,
-			vma->vm_flags, vma->vm_file, pgoff);
+			vma->vm_flags, vma->vm_file, pgoff, vma_policy(vma));
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
Index: 2.6.6-rc3-mm2-bitmapv5/mm/mprotect.c
===================================================================
--- 2.6.6-rc3-mm2-bitmapv5.orig/mm/mprotect.c	2004-05-05 07:38:42.000000000 -0700
+++ 2.6.6-rc3-mm2-bitmapv5/mm/mprotect.c	2004-05-05 08:45:18.000000000 -0700
@@ -125,6 +125,8 @@
 		return 0;
 	if (vma->vm_file || (vma->vm_flags & VM_SHARED))
 		return 0;
+	if (!vma_mpol_equal(vma, prev))
+		return 0;
 
 	/*
 	 * If the whole area changes to the protection of the previous one
@@ -136,6 +138,7 @@
 		__vma_unlink(mm, vma, prev);
 		spin_unlock(&mm->page_table_lock);
 
+		mpol_free(vma_policy(vma));
 		kmem_cache_free(vm_area_cachep, vma);
 		mm->map_count--;
 		return 1;
@@ -318,12 +321,14 @@
 
 	if (next && prev->vm_end == next->vm_start &&
 			can_vma_merge(next, prev->vm_flags) &&
+	    	vma_mpol_equal(prev, next) &&
 			!prev->vm_file && !(prev->vm_flags & VM_SHARED)) {
 		spin_lock(&prev->vm_mm->page_table_lock);
 		prev->vm_end = next->vm_end;
 		__vma_unlink(prev->vm_mm, next, prev);
 		spin_unlock(&prev->vm_mm->page_table_lock);
 
+		mpol_free(vma_policy(next));
 		kmem_cache_free(vm_area_cachep, next);
 		prev->vm_mm->map_count--;
 	}


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
