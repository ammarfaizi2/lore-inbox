Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265477AbUGNOpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265477AbUGNOpC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267422AbUGNOLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:11:22 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:6588 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267412AbUGNOEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:04:31 -0400
Date: Wed, 14 Jul 2004 23:04:16 +0900 (JST)
Message-Id: <20040714.230416.32732986.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Cc: linux-mm@kvack.org
Subject: [PATCH] memory hotremoval for linux-2.6.7 [6/16]
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040714.224138.95803956.taka@valinux.co.jp>
References: <20040714.224138.95803956.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


$Id: va-aio.patch,v 1.11 2004/06/17 08:19:45 iwamoto Exp $

--- linux-2.6.7.ORG/arch/i386/kernel/sys_i386.c.orig	2004-06-17 16:20:02.000000000 +0900
+++ linux-2.6.7/arch/i386/kernel/sys_i386.c	2004-06-17 16:20:12.000000000 +0900
@@ -70,7 +70,7 @@ asmlinkage long sys_mmap2(unsigned long 
 	unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long pgoff)
 {
-	return do_mmap2(addr, len, prot, flags, fd, pgoff);
+	return do_mmap2(addr, len, prot, flags & ~MAP_IMMOVABLE, fd, pgoff);
 }
 
 /*
@@ -101,7 +101,8 @@ asmlinkage int old_mmap(struct mmap_arg_
 	if (a.offset & ~PAGE_MASK)
 		goto out;
 
-	err = do_mmap2(a.addr, a.len, a.prot, a.flags, a.fd, a.offset >> PAGE_SHIFT);
+	err = do_mmap2(a.addr, a.len, a.prot, a.flags & ~MAP_IMMOVABLE,
+	    a.fd, a.offset >> PAGE_SHIFT);
 out:
 	return err;
 }
--- linux-2.6.7.ORG/fs/aio.c	2004-06-17 16:20:02.000000000 +0900
+++ linux-2.6.7/fs/aio.c	2004-06-17 16:20:12.000000000 +0900
@@ -130,7 +130,8 @@ static int aio_setup_ring(struct kioctx 
 	dprintk("attempting mmap of %lu bytes\n", info->mmap_size);
 	down_write(&ctx->mm->mmap_sem);
 	info->mmap_base = do_mmap(NULL, 0, info->mmap_size, 
-				  PROT_READ|PROT_WRITE, MAP_ANON|MAP_PRIVATE,
+				  PROT_READ|PROT_WRITE,
+				  MAP_ANON|MAP_PRIVATE|MAP_IMMOVABLE,
 				  0);
 	if (IS_ERR((void *)info->mmap_base)) {
 		up_write(&ctx->mm->mmap_sem);
--- linux-2.6.7.ORG/include/asm-i386/mman.h	2004-06-17 16:20:02.000000000 +0900
+++ linux-2.6.7/include/asm-i386/mman.h	2004-06-17 16:20:12.000000000 +0900
@@ -22,6 +22,7 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_IMMOVABLE	0x20000
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
--- linux-2.6.7.ORG/include/asm-ia64/mman.h	2004-06-17 16:20:02.000000000 +0900
+++ linux-2.6.7/include/asm-ia64/mman.h	2004-06-17 16:20:12.000000000 +0900
@@ -30,6 +30,7 @@
 #define MAP_NORESERVE	0x04000		/* don't check for reservations */
 #define MAP_POPULATE	0x08000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_IMMOVABLE	0x20000
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
--- linux-2.6.7.ORG/include/linux/mm.h	2004-06-17 16:20:02.000000000 +0900
+++ linux-2.6.7/include/linux/mm.h	2004-06-17 16:20:12.000000000 +0900
@@ -134,6 +134,7 @@ struct vm_area_struct {
 #define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
+#define VM_IMMOVABLE	0x01000000	/* Don't place in hot removable area */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
--- linux-2.6.7.ORG/include/linux/mman.h	2004-06-17 16:20:02.000000000 +0900
+++ linux-2.6.7/include/linux/mman.h	2004-06-17 16:20:12.000000000 +0900
@@ -58,7 +58,11 @@ calc_vm_flag_bits(unsigned long flags)
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
 	       _calc_vm_trans(flags, MAP_EXECUTABLE, VM_EXECUTABLE) |
-	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    );
+	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    )
+#ifdef CONFIG_MEMHOTPLUG
+	     | _calc_vm_trans(flags, MAP_IMMOVABLE,  VM_IMMOVABLE )
+#endif
+		;
 }
 
 #endif /* _LINUX_MMAN_H */
--- linux-2.6.7.ORG/kernel/fork.c	2004-06-17 16:20:02.000000000 +0900
+++ linux-2.6.7/kernel/fork.c	2004-06-17 16:20:12.000000000 +0900
@@ -321,6 +321,9 @@ static inline int dup_mmap(struct mm_str
 			goto fail_nomem_policy;
 		vma_set_policy(tmp, pol);
 		tmp->vm_flags &= ~VM_LOCKED;
+#ifdef CONFIG_MEMHOTPLUG
+		tmp->vm_flags &= ~VM_IMMOVABLE;
+#endif
 		tmp->vm_mm = mm;
 		tmp->vm_next = NULL;
 		anon_vma_link(tmp);
--- linux-2.6.7.ORG/mm/memory.c	2004-06-17 16:20:02.000000000 +0900
+++ linux-2.6.7/mm/memory.c	2004-06-17 16:20:12.000000000 +0900
@@ -1069,7 +1069,13 @@ static int do_wp_page(struct mm_struct *
 
 	if (unlikely(anon_vma_prepare(vma)))
 		goto no_new_page;
-	new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
+#ifdef CONFIG_MEMHOTPLUG
+	if (vma->vm_flags & VM_IMMOVABLE)
+		new_page = alloc_page_vma(GFP_USER | __GFP_HIGHMEM,
+		    vma, address);
+	else
+#endif
+		new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 	if (!new_page)
 		goto no_new_page;
 	copy_cow_page(old_page,new_page,address);
@@ -1412,6 +1418,12 @@ do_anonymous_page(struct mm_struct *mm, 
 
 		if (unlikely(anon_vma_prepare(vma)))
 			goto no_mem;
+#ifdef CONFIG_MEMHOTPLUG
+		if (vma->vm_flags & VM_IMMOVABLE)
+			page = alloc_page_vma(GFP_USER | __GFP_HIGHMEM,
+			    vma, addr);
+		else
+#endif
 		page = alloc_page_vma(GFP_HIGHUSER, vma, addr);
 		if (!page)
 			goto no_mem;

