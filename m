Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263821AbUDFNly (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 09:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263830AbUDFNlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 09:41:53 -0400
Received: from ns.suse.de ([195.135.220.2]:60063 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263821AbUDFNkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 09:40:35 -0400
Date: Tue, 6 Apr 2004 15:37:13 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] NUMA API for Linux 5/ Add VMA hooks for policy
Message-Id: <20040406153713.52a64a26.ak@suse.de>
In-Reply-To: <20040406153322.5d6e986e.ak@suse.de>
References: <20040406153322.5d6e986e.ak@suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


NUMA API adds a policy to each VMA. During VMA creattion, merging and 
splitting these policies must be handled properly. This patch adds
the calls to this. 

It is a nop when CONFIG_NUMA is not defined.

diff -u linux-2.6.5-numa/arch/ia64/ia32/binfmt_elf32.c-o linux-2.6.5-numa/arch/ia64/ia32/binfmt_elf32.c
--- linux-2.6.5-numa/arch/ia64/ia32/binfmt_elf32.c-o	1970-01-01 01:12:51.000000000 +0100
+++ linux-2.6.5-numa/arch/ia64/ia32/binfmt_elf32.c	2004-04-06 13:36:12.000000000 +0200
@@ -104,6 +104,7 @@
 		vma->vm_pgoff = 0;
 		vma->vm_file = NULL;
 		vma->vm_private_data = NULL;
+		mpol_set_vma_default(vma);
 		down_write(&current->mm->mmap_sem);
 		{
 			insert_vm_struct(current->mm, vma);
@@ -184,6 +185,7 @@
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
 		mpnt->vm_private_data = 0;
+		mpol_set_vma_default(mpnt);
 		insert_vm_struct(current->mm, mpnt);
 		current->mm->total_vm = (mpnt->vm_end - mpnt->vm_start) >> PAGE_SHIFT;
 	}
diff -u linux-2.6.5-numa/arch/ia64/kernel/perfmon.c-o linux-2.6.5-numa/arch/ia64/kernel/perfmon.c
--- linux-2.6.5-numa/arch/ia64/kernel/perfmon.c-o	1970-01-01 01:12:51.000000000 +0100
+++ linux-2.6.5-numa/arch/ia64/kernel/perfmon.c	2004-04-06 13:36:12.000000000 +0200
@@ -2273,6 +2273,7 @@
 	vma->vm_ops	     = &pfm_vm_ops;
 	vma->vm_pgoff	     = 0;
 	vma->vm_file	     = NULL;
+	mpol_set_vma_default(vma);
 	vma->vm_private_data = ctx;	/* information needed by the pfm_vm_close() function */
 
 	/*
diff -u linux-2.6.5-numa/arch/ia64/mm/init.c-o linux-2.6.5-numa/arch/ia64/mm/init.c
--- linux-2.6.5-numa/arch/ia64/mm/init.c-o	2004-04-06 13:12:00.000000000 +0200
+++ linux-2.6.5-numa/arch/ia64/mm/init.c	2004-04-06 13:36:12.000000000 +0200
@@ -131,6 +131,7 @@
 		vma->vm_pgoff = 0;
 		vma->vm_file = NULL;
 		vma->vm_private_data = NULL;
+		mpol_set_vma_default(vma);
 		insert_vm_struct(current->mm, vma);
 	}
 
@@ -143,6 +144,7 @@
 			vma->vm_end = PAGE_SIZE;
 			vma->vm_page_prot = __pgprot(pgprot_val(PAGE_READONLY) | _PAGE_MA_NAT);
 			vma->vm_flags = VM_READ | VM_MAYREAD | VM_IO | VM_RESERVED;
+			mpol_set_vma_default(vma);
 			insert_vm_struct(current->mm, vma);
 		}
 	}
diff -u linux-2.6.5-numa/arch/m68k/atari/stram.c-o linux-2.6.5-numa/arch/m68k/atari/stram.c
--- linux-2.6.5-numa/arch/m68k/atari/stram.c-o	2004-03-21 21:12:07.000000000 +0100
+++ linux-2.6.5-numa/arch/m68k/atari/stram.c	2004-04-06 13:36:12.000000000 +0200
@@ -752,7 +752,7 @@
 			/* Get a page for the entry, using the existing
 			   swap cache page if there is one.  Otherwise,
 			   get a clean page and read the swap into it. */
-			page = read_swap_cache_async(entry);
+			page = read_swap_cache_async(entry, NULL, 0);
 			if (!page) {
 				swap_free(entry);
 				return -ENOMEM;
diff -u linux-2.6.5-numa/arch/s390/kernel/compat_exec.c-o linux-2.6.5-numa/arch/s390/kernel/compat_exec.c
--- linux-2.6.5-numa/arch/s390/kernel/compat_exec.c-o	2004-03-21 21:12:11.000000000 +0100
+++ linux-2.6.5-numa/arch/s390/kernel/compat_exec.c	2004-04-06 13:36:12.000000000 +0200
@@ -71,6 +71,7 @@
 		mpnt->vm_ops = NULL;
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
+		mpol_set_vma_default(mpnt);
 		INIT_LIST_HEAD(&mpnt->shared);
 		mpnt->vm_private_data = (void *) 0;
 		insert_vm_struct(mm, mpnt);
diff -u linux-2.6.5-numa/arch/x86_64/ia32/ia32_binfmt.c-o linux-2.6.5-numa/arch/x86_64/ia32/ia32_binfmt.c
--- linux-2.6.5-numa/arch/x86_64/ia32/ia32_binfmt.c-o	2004-04-06 13:12:04.000000000 +0200
+++ linux-2.6.5-numa/arch/x86_64/ia32/ia32_binfmt.c	2004-04-06 13:36:12.000000000 +0200
@@ -360,6 +360,7 @@
 		mpnt->vm_ops = NULL;
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
+		mpol_set_vma_default(mpnt);
 		INIT_LIST_HEAD(&mpnt->shared);
 		mpnt->vm_private_data = (void *) 0;
 		insert_vm_struct(mm, mpnt);
diff -u linux-2.6.5-numa/fs/exec.c-o linux-2.6.5-numa/fs/exec.c
--- linux-2.6.5-numa/fs/exec.c-o	1970-01-01 01:12:51.000000000 +0100
+++ linux-2.6.5-numa/fs/exec.c	2004-04-06 13:36:12.000000000 +0200
@@ -430,6 +430,7 @@
 		mpnt->vm_ops = NULL;
 		mpnt->vm_pgoff = 0;
 		mpnt->vm_file = NULL;
+		mpol_set_vma_default(mpnt);
 		INIT_LIST_HEAD(&mpnt->shared);
 		mpnt->vm_private_data = (void *) 0;
 		insert_vm_struct(mm, mpnt);
diff -u linux-2.6.5-numa/kernel/exit.c-o linux-2.6.5-numa/kernel/exit.c
--- linux-2.6.5-numa/kernel/exit.c-o	2004-04-06 13:12:24.000000000 +0200
+++ linux-2.6.5-numa/kernel/exit.c	2004-04-06 13:36:12.000000000 +0200
@@ -779,6 +779,7 @@
 	exit_namespace(tsk);
 	exit_itimers(tsk);
 	exit_thread();
+	mpol_free(tsk->mempolicy);
 
 	if (tsk->leader)
 		disassociate_ctty(1);
diff -u linux-2.6.5-numa/kernel/fork.c-o linux-2.6.5-numa/kernel/fork.c
--- linux-2.6.5-numa/kernel/fork.c-o	1970-01-01 01:12:51.000000000 +0100
+++ linux-2.6.5-numa/kernel/fork.c	2004-04-06 13:36:12.000000000 +0200
@@ -268,6 +268,7 @@
 	struct rb_node **rb_link, *rb_parent;
 	int retval;
 	unsigned long charge = 0;
+	struct mempolicy *pol;
 
 	down_write(&oldmm->mmap_sem);
 	flush_cache_mm(current->mm);
@@ -309,6 +310,11 @@
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
@@ -355,6 +361,8 @@
 	flush_tlb_mm(current->mm);
 	up_write(&oldmm->mmap_sem);
 	return retval;
+fail_nomem_policy: 
+	kmem_cache_free(vm_area_cachep, tmp);
 fail_nomem:
 	retval = -ENOMEM;
 fail:
@@ -946,9 +954,16 @@
 	p->security = NULL;
 	p->io_context = NULL;
 
+	p->mempolicy = mpol_copy(p->mempolicy);
+	if (IS_ERR(p->mempolicy)) { 
+		retval = PTR_ERR(p->mempolicy);
+		p->mempolicy = NULL;
+		goto bad_fork_cleanup;
+	}	
+	
 	retval = -ENOMEM;
 	if ((retval = security_task_alloc(p)))
-		goto bad_fork_cleanup;
+		goto bad_fork_cleanup_policy;
 	/* copy all the process information */
 	if ((retval = copy_semundo(clone_flags, p)))
 		goto bad_fork_cleanup_security;
@@ -1088,6 +1103,8 @@
 	exit_sem(p);
 bad_fork_cleanup_security:
 	security_task_free(p);
+bad_fork_cleanup_policy:
+	mpol_free(p->mempolicy);
 bad_fork_cleanup:
 	if (p->pid > 0)
 		free_pidmap(p->pid);
diff -u linux-2.6.5-numa/mm/mmap.c-o linux-2.6.5-numa/mm/mmap.c
--- linux-2.6.5-numa/mm/mmap.c-o	2004-04-06 13:12:24.000000000 +0200
+++ linux-2.6.5-numa/mm/mmap.c	2004-04-06 13:36:12.000000000 +0200
@@ -388,7 +388,8 @@
 static int vma_merge(struct mm_struct *mm, struct vm_area_struct *prev,
 			struct rb_node *rb_parent, unsigned long addr, 
 			unsigned long end, unsigned long vm_flags,
-			struct file *file, unsigned long pgoff)
+		     	struct file *file, unsigned long pgoff,
+		        struct mempolicy *policy) 
 {
 	spinlock_t *lock = &mm->page_table_lock;
 	struct inode *inode = file ? file->f_dentry->d_inode : NULL;
@@ -412,6 +413,7 @@
 	 * Can it merge with the predecessor?
 	 */
 	if (prev->vm_end == addr &&
+ 		        mpol_equal(vma_policy(prev), policy) && 
 			is_mergeable_vma(prev, file, vm_flags) &&
 			can_vma_merge_after(prev, vm_flags, file, pgoff)) {
 		struct vm_area_struct *next;
@@ -430,6 +432,7 @@
 		 */
 		next = prev->vm_next;
 		if (next && prev->vm_end == next->vm_start &&
+		    		vma_mpol_equal(prev, next) &&
 				can_vma_merge_before(next, vm_flags, file,
 					pgoff, (end - addr) >> PAGE_SHIFT)) {
 			prev->vm_end = next->vm_end;
@@ -442,6 +445,7 @@
 				fput(file);
 
 			mm->map_count--;
+			mpol_free(vma_policy(next));
 			kmem_cache_free(vm_area_cachep, next);
 			return 1;
 		}
@@ -457,6 +461,8 @@
 	prev = prev->vm_next;
 	if (prev) {
  merge_next:
+ 		if (!mpol_equal(policy, vma_policy(prev)))
+  			return 0;
 		if (!can_vma_merge_before(prev, vm_flags, file,
 				pgoff, (end - addr) >> PAGE_SHIFT))
 			return 0;
@@ -633,7 +639,7 @@
 	/* Can we just expand an old anonymous mapping? */
 	if (!file && !(vm_flags & VM_SHARED) && rb_parent)
 		if (vma_merge(mm, prev, rb_parent, addr, addr + len,
-					vm_flags, NULL, 0))
+					vm_flags, NULL, pgoff, NULL))
 			goto out;
 
 	/*
@@ -656,6 +662,7 @@
 	vma->vm_file = NULL;
 	vma->vm_private_data = NULL;
 	vma->vm_next = NULL;
+	mpol_set_vma_default(vma);
 	INIT_LIST_HEAD(&vma->shared);
 
 	if (file) {
@@ -695,7 +702,9 @@
 	addr = vma->vm_start;
 
 	if (!file || !rb_parent || !vma_merge(mm, prev, rb_parent, addr,
-				addr + len, vma->vm_flags, file, pgoff)) {
+					      vma->vm_end, 
+					      vma->vm_flags, file, pgoff,
+					      vma_policy(vma))) {
 		vma_link(mm, vma, prev, rb_link, rb_parent);
 		if (correct_wcount)
 			atomic_inc(&inode->i_writecount);
@@ -705,6 +714,7 @@
 				atomic_inc(&inode->i_writecount);
 			fput(file);
 		}
+		mpol_free(vma_policy(vma));
 		kmem_cache_free(vm_area_cachep, vma);
 	}
 out:	
@@ -1120,6 +1130,7 @@
 
 	remove_shared_vm_struct(area);
 
+	mpol_free(vma_policy(area));
 	if (area->vm_ops && area->vm_ops->close)
 		area->vm_ops->close(area);
 	if (area->vm_file)
@@ -1202,6 +1213,7 @@
 int split_vma(struct mm_struct * mm, struct vm_area_struct * vma,
 	      unsigned long addr, int new_below)
 {
+	struct mempolicy *pol;
 	struct vm_area_struct *new;
 	struct address_space *mapping = NULL;
 
@@ -1224,6 +1236,13 @@
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
 
@@ -1393,7 +1412,7 @@
 
 	/* Can we just expand an old anonymous mapping? */
 	if (rb_parent && vma_merge(mm, prev, rb_parent, addr, addr + len,
-					flags, NULL, 0))
+					flags, NULL, 0, NULL))
 		goto out;
 
 	/*
@@ -1414,6 +1433,7 @@
 	vma->vm_pgoff = 0;
 	vma->vm_file = NULL;
 	vma->vm_private_data = NULL;
+	mpol_set_vma_default(vma);
 	INIT_LIST_HEAD(&vma->shared);
 
 	vma_link(mm, vma, prev, rb_link, rb_parent);
@@ -1474,6 +1494,7 @@
 		}
 		if (vma->vm_file)
 			fput(vma->vm_file);
+		mpol_free(vma_policy(vma));
 		kmem_cache_free(vm_area_cachep, vma);
 		vma = next;
 	}
diff -u linux-2.6.5-numa/mm/mprotect.c-o linux-2.6.5-numa/mm/mprotect.c
--- linux-2.6.5-numa/mm/mprotect.c-o	2004-04-06 13:12:24.000000000 +0200
+++ linux-2.6.5-numa/mm/mprotect.c	2004-04-06 13:36:12.000000000 +0200
@@ -124,6 +124,8 @@
 		return 0;
 	if (vma->vm_file || (vma->vm_flags & VM_SHARED))
 		return 0;
+	if (!vma_mpol_equal(vma, prev))
+		return 0;
 
 	/*
 	 * If the whole area changes to the protection of the previous one
@@ -135,6 +137,7 @@
 		__vma_unlink(mm, vma, prev);
 		spin_unlock(&mm->page_table_lock);
 
+		mpol_free(vma_policy(vma));
 		kmem_cache_free(vm_area_cachep, vma);
 		mm->map_count--;
 		return 1;
@@ -317,12 +320,14 @@
 
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
diff -u linux-2.6.5-numa/mm/mremap.c-o linux-2.6.5-numa/mm/mremap.c
--- linux-2.6.5-numa/mm/mremap.c-o	2004-03-21 21:12:13.000000000 +0100
+++ linux-2.6.5-numa/mm/mremap.c	2004-04-06 13:36:12.000000000 +0200
@@ -199,6 +199,7 @@
 	next = find_vma_prev(mm, new_addr, &prev);
 	if (next) {
 		if (prev && prev->vm_end == new_addr &&
+		    mpol_equal(vma_policy(prev), vma_policy(next)) &&
 		    can_vma_merge(prev, vma->vm_flags) && !vma->vm_file &&
 					!(vma->vm_flags & VM_SHARED)) {
 			spin_lock(&mm->page_table_lock);
@@ -208,6 +209,7 @@
 			if (next != prev->vm_next)
 				BUG();
 			if (prev->vm_end == next->vm_start &&
+			                vma_mpol_equal(next, prev) && 
 					can_vma_merge(next, prev->vm_flags)) {
 				spin_lock(&mm->page_table_lock);
 				prev->vm_end = next->vm_end;
@@ -216,10 +218,12 @@
 				if (vma == next)
 					vma = prev;
 				mm->map_count--;
+				mpol_free(vma_policy(next));
 				kmem_cache_free(vm_area_cachep, next);
 			}
 		} else if (next->vm_start == new_addr + new_len &&
 			  	can_vma_merge(next, vma->vm_flags) &&
+			        vma_mpol_equal(next, vma) &&
 				!vma->vm_file && !(vma->vm_flags & VM_SHARED)) {
 			spin_lock(&mm->page_table_lock);
 			next->vm_start = new_addr;
@@ -229,6 +233,7 @@
 	} else {
 		prev = find_vma(mm, new_addr-1);
 		if (prev && prev->vm_end == new_addr &&
+		    vma_mpol_equal(prev, vma) &&
 		    can_vma_merge(prev, vma->vm_flags) && !vma->vm_file &&
 				!(vma->vm_flags & VM_SHARED)) {
 			spin_lock(&mm->page_table_lock);
@@ -250,7 +255,12 @@
 		unsigned long vm_locked = vma->vm_flags & VM_LOCKED;
 
 		if (allocated_vma) {
+			struct mempolicy *pol;
 			*new_vma = *vma;
+			pol = mpol_copy(vma_policy(new_vma));
+			if (IS_ERR(pol))
+				goto out_vma;
+			vma_set_policy(new_vma, pol);	
 			INIT_LIST_HEAD(&new_vma->shared);
 			new_vma->vm_start = new_addr;
 			new_vma->vm_end = new_addr+new_len;
@@ -291,6 +301,7 @@
 		}
 		return new_addr;
 	}
+ out_vma:
 	if (allocated_vma)
 		kmem_cache_free(vm_area_cachep, new_vma);
  out:
