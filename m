Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbVBLD3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbVBLD3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 22:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVBLD0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 22:26:42 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24490 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262384AbVBLD0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 22:26:02 -0500
Date: Fri, 11 Feb 2005 19:25:42 -0800 (PST)
From: Ray Bryant <raybry@sgi.com>
To: Hirokazu Takahashi <taka@valinux.co.jp>, Hugh DIckins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcello@cyclades.com>
Cc: Ray Bryant <raybry@sgi.com>, Ray Bryant <raybry@austin.rr.com>,
       linux-mm <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-Id: <20050212032542.18524.34091.43861@tomahawk.engr.sgi.com>
In-Reply-To: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com>
Subject: [RFC 2.6.11-rc2-mm2 1/7] mm: manual page migration -- cleanup 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes some remaining Memory HOTPLUG specific code
from the page migration patch.  I have sent Dave Hansen the -R
version of this patch so that this code can be added back 
later at the start of the Memory HOTPLUG patches themselves.

In particular, this patchremoves VM_IMMOVABLE and MAP_IMMOVABLE.

Signed-off-by: Ray Bryant <raybry@sgi.com>

Index: linux-2.6.10-mm1-page-migration/kernel/fork.c
===================================================================
--- linux-2.6.10-mm1-page-migration.orig/kernel/fork.c	2005-01-10 08:46:51.000000000 -0800
+++ linux-2.6.10-mm1-page-migration/kernel/fork.c	2005-01-10 09:14:03.000000000 -0800
@@ -211,7 +211,7 @@ static inline int dup_mmap(struct mm_str
 		if (IS_ERR(pol))
 			goto fail_nomem_policy;
 		vma_set_policy(tmp, pol);
-		tmp->vm_flags &= ~(VM_LOCKED|VM_IMMOVABLE);
+		tmp->vm_flags &= ~(VM_LOCKED);
 		tmp->vm_mm = mm;
 		tmp->vm_next = NULL;
 		anon_vma_link(tmp);
Index: linux-2.6.10-mm1-page-migration/include/linux/mm.h
===================================================================
--- linux-2.6.10-mm1-page-migration.orig/include/linux/mm.h	2005-01-10 08:46:51.000000000 -0800
+++ linux-2.6.10-mm1-page-migration/include/linux/mm.h	2005-01-10 09:14:04.000000000 -0800
@@ -164,7 +164,6 @@ extern unsigned int kobjsize(const void 
 #define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
-#define VM_IMMOVABLE	0x01000000	/* Don't place in hot removable area */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
 #define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
Index: linux-2.6.10-mm1-page-migration/include/linux/mman.h
===================================================================
--- linux-2.6.10-mm1-page-migration.orig/include/linux/mman.h	2005-01-10 08:46:51.000000000 -0800
+++ linux-2.6.10-mm1-page-migration/include/linux/mman.h	2005-01-10 10:05:54.000000000 -0800
@@ -61,8 +61,7 @@ calc_vm_flag_bits(unsigned long flags)
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
 	       _calc_vm_trans(flags, MAP_EXECUTABLE, VM_EXECUTABLE) |
-	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
-	       _calc_vm_trans(flags, MAP_IMMOVABLE,  VM_IMMOVABLE );
+	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    );
 }
 
 #endif /* _LINUX_MMAN_H */
Index: linux-2.6.10-mm1-page-migration/arch/i386/kernel/sys_i386.c
===================================================================
--- linux-2.6.10-mm1-page-migration.orig/arch/i386/kernel/sys_i386.c	2005-01-10 08:46:51.000000000 -0800
+++ linux-2.6.10-mm1-page-migration/arch/i386/kernel/sys_i386.c	2005-01-10 09:14:04.000000000 -0800
@@ -70,7 +70,7 @@ asmlinkage long sys_mmap2(unsigned long 
 	unsigned long prot, unsigned long flags,
 	unsigned long fd, unsigned long pgoff)
 {
-	return do_mmap2(addr, len, prot, flags & ~MAP_IMMOVABLE, fd, pgoff);
+	return do_mmap2(addr, len, prot, flags, fd, pgoff);
 }
 
 /*
@@ -101,7 +101,7 @@ asmlinkage int old_mmap(struct mmap_arg_
 	if (a.offset & ~PAGE_MASK)
 		goto out;
 
-	err = do_mmap2(a.addr, a.len, a.prot, a.flags & ~MAP_IMMOVABLE,
+	err = do_mmap2(a.addr, a.len, a.prot, a.flags,
 	    a.fd, a.offset >> PAGE_SHIFT);
 out:
 	return err;
Index: linux-2.6.10-mm1-page-migration/include/asm-ppc64/mman.h
===================================================================
--- linux-2.6.10-mm1-page-migration.orig/include/asm-ppc64/mman.h	2005-01-10 08:46:51.000000000 -0800
+++ linux-2.6.10-mm1-page-migration/include/asm-ppc64/mman.h	2005-01-10 09:14:04.000000000 -0800
@@ -38,7 +38,6 @@
 
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_IMMOVABLE	0x20000
 
 #define MADV_NORMAL	0x0		/* default page-in behavior */
 #define MADV_RANDOM	0x1		/* page-in minimum required */
Index: linux-2.6.10-mm1-page-migration/include/asm-i386/mman.h
===================================================================
--- linux-2.6.10-mm1-page-migration.orig/include/asm-i386/mman.h	2005-01-10 08:46:51.000000000 -0800
+++ linux-2.6.10-mm1-page-migration/include/asm-i386/mman.h	2005-01-10 09:14:04.000000000 -0800
@@ -22,7 +22,6 @@
 #define MAP_NORESERVE	0x4000		/* don't check for reservations */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_IMMOVABLE	0x20000
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
Index: linux-2.6.10-mm1-page-migration/fs/aio.c
===================================================================
--- linux-2.6.10-mm1-page-migration.orig/fs/aio.c	2005-01-10 08:46:51.000000000 -0800
+++ linux-2.6.10-mm1-page-migration/fs/aio.c	2005-01-10 09:14:04.000000000 -0800
@@ -134,7 +134,7 @@ static int aio_setup_ring(struct kioctx 
 	down_write(&ctx->mm->mmap_sem);
 	info->mmap_base = do_mmap(NULL, 0, info->mmap_size, 
 				  PROT_READ|PROT_WRITE,
-				  MAP_ANON|MAP_PRIVATE|MAP_IMMOVABLE,
+				  MAP_ANON|MAP_PRIVATE,
 				  0);
 	if (IS_ERR((void *)info->mmap_base)) {
 		up_write(&ctx->mm->mmap_sem);
Index: linux-2.6.10-mm1-page-migration/include/asm-ia64/mman.h
===================================================================
--- linux-2.6.10-mm1-page-migration.orig/include/asm-ia64/mman.h	2005-01-10 08:46:51.000000000 -0800
+++ linux-2.6.10-mm1-page-migration/include/asm-ia64/mman.h	2005-01-10 09:14:04.000000000 -0800
@@ -30,7 +30,6 @@
 #define MAP_NORESERVE	0x04000		/* don't check for reservations */
 #define MAP_POPULATE	0x08000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
-#define MAP_IMMOVABLE	0x20000
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */

-- 
Best Regards,
Ray
-----------------------------------------------
Ray Bryant                       raybry@sgi.com
The box said: "Requires Windows 98 or better",
           so I installed Linux.
-----------------------------------------------
