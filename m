Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263799AbUEMF4K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263799AbUEMF4K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 01:56:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbUEMF4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 01:56:00 -0400
Received: from ozlabs.org ([203.10.76.45]:34538 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263788AbUEMFzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 01:55:43 -0400
Date: Thu, 13 May 2004 15:55:20 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Adam Litke <agl@us.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: More convenient way to grab hugepage memory
Message-ID: <20040513055520.GF27403@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Adam Litke <agl@us.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

At present, getting a block of (quasi-) anonymous memory mapping with
hugepages is a slightly convoluted process, involving creating a dummy
file in a hugetlbfs filesystem.  In particular that means finding
where such a filesystem is mounted, for which there is no standard
mechanism.  Getting hugepage SysV shm segments is easier, just requing
the SHM_HUGETLB flag.  This patch adds an analagous MAP_HUGETLB mmap()
flag to easily request that a block of anonymous memory come from
hugepages.

[The MAP_HUGETLB flag has the side effect that MAP_SHARED semantics
will apply, even if MAP_PRIVATE is specific - but that's no different
to explicitly mapping hugetlbfs].

Index: working-2.6/include/asm-i386/mman.h
===================================================================
--- working-2.6.orig/include/asm-i386/mman.h	2003-10-03 11:24:48.000000000 +1000
+++ working-2.6/include/asm-i386/mman.h	2004-04-27 13:40:01.058286584 +1000
@@ -16,6 +16,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed by hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-ppc64/mman.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/mman.h	2003-10-01 11:47:33.000000000 +1000
+++ working-2.6/include/asm-ppc64/mman.h	2004-04-27 13:40:01.058286584 +1000
@@ -26,6 +26,7 @@
 #define MAP_LOCKED	0x80
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 
Index: working-2.6/include/linux/mman.h
===================================================================
--- working-2.6.orig/include/linux/mman.h	2003-10-07 10:31:58.000000000 +1000
+++ working-2.6/include/linux/mman.h	2004-04-27 13:40:01.059286432 +1000
@@ -58,6 +58,9 @@
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
 	       _calc_vm_trans(flags, MAP_EXECUTABLE, VM_EXECUTABLE) |
+#ifdef CONFIG_HUGETLB_PAGE
+               _calc_vm_trans(flags, MAP_HUGETLB,    VM_HUGETLB   ) |
+#endif
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    );
 }
 
Index: working-2.6/include/asm-sh/mman.h
===================================================================
--- working-2.6.orig/include/asm-sh/mman.h	2003-10-01 11:47:40.000000000 +1000
+++ working-2.6/include/asm-sh/mman.h	2004-04-27 13:40:01.059286432 +1000
@@ -16,6 +16,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-ia64/mman.h
===================================================================
--- working-2.6.orig/include/asm-ia64/mman.h	2004-01-28 10:55:18.000000000 +1100
+++ working-2.6/include/asm-ia64/mman.h	2004-04-27 13:40:01.059286432 +1000
@@ -24,6 +24,7 @@
 
 #define MAP_GROWSDOWN	0x00100		/* stack-like segment */
 #define MAP_GROWSUP	0x00200		/* register stack-like segment */
+#define MAP_HUGETLB	0x00400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x00800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x01000		/* mark it as an executable */
 #define MAP_LOCKED	0x02000		/* pages are locked */
Index: working-2.6/include/asm-sparc64/mman.h
===================================================================
--- working-2.6.orig/include/asm-sparc64/mman.h	2003-10-01 11:47:45.000000000 +1000
+++ working-2.6/include/asm-sparc64/mman.h	2004-04-27 13:40:01.060286280 +1000
@@ -24,6 +24,7 @@
 #define _MAP_NEW        0x80000000      /* Binary compatibility is fun... */
 
 #define MAP_GROWSDOWN	0x0200		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 
Index: working-2.6/include/asm-x86_64/mman.h
===================================================================
--- working-2.6.orig/include/asm-x86_64/mman.h	2003-10-01 11:47:50.000000000 +1000
+++ working-2.6/include/asm-x86_64/mman.h	2004-04-27 13:40:01.061286128 +1000
@@ -17,6 +17,7 @@
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-ppc/mman.h
===================================================================
--- working-2.6.orig/include/asm-ppc/mman.h	2003-10-01 11:47:28.000000000 +1000
+++ working-2.6/include/asm-ppc/mman.h	2004-04-27 14:01:47.067366688 +1000
@@ -19,6 +19,7 @@
 #define MAP_LOCKED	0x80
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
Index: working-2.6/include/asm-alpha/mman.h
===================================================================
--- working-2.6.orig/include/asm-alpha/mman.h	2004-04-27 13:41:24.845329144 +1000
+++ working-2.6/include/asm-alpha/mman.h	2004-04-27 13:59:08.242417392 +1000
@@ -28,6 +28,7 @@
 #define MAP_NORESERVE	0x10000		/* don't check for reservations */
 #define MAP_POPULATE	0x20000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x40000		/* do not block on IO */
+#define MAP_HUGETLB	0x80000		/* Backed with hugetlb pages */
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_SYNC		2		/* synchronous memory sync */
Index: working-2.6/include/asm-arm/mman.h
===================================================================
--- working-2.6.orig/include/asm-arm/mman.h	2004-04-27 13:41:49.445317984 +1000
+++ working-2.6/include/asm-arm/mman.h	2004-04-27 13:59:22.106305584 +1000
@@ -16,6 +16,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-arm26/mman.h
===================================================================
--- working-2.6.orig/include/asm-arm26/mman.h	2003-10-01 11:47:01.000000000 +1000
+++ working-2.6/include/asm-arm26/mman.h	2004-04-27 13:59:38.194390184 +1000
@@ -16,6 +16,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-cris/mman.h
===================================================================
--- working-2.6.orig/include/asm-cris/mman.h	2003-10-01 11:47:02.000000000 +1000
+++ working-2.6/include/asm-cris/mman.h	2004-04-27 13:59:49.690373160 +1000
@@ -18,6 +18,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-h8300/mman.h
===================================================================
--- working-2.6.orig/include/asm-h8300/mman.h	2003-10-01 11:47:05.000000000 +1000
+++ working-2.6/include/asm-h8300/mman.h	2004-04-27 14:00:01.026380304 +1000
@@ -15,6 +15,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-m68k/mman.h
===================================================================
--- working-2.6.orig/include/asm-m68k/mman.h	2003-10-01 11:47:14.000000000 +1000
+++ working-2.6/include/asm-m68k/mman.h	2004-04-27 14:00:13.418360392 +1000
@@ -16,6 +16,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-mips/mman.h
===================================================================
--- working-2.6.orig/include/asm-mips/mman.h	2003-10-01 11:47:19.000000000 +1000
+++ working-2.6/include/asm-mips/mman.h	2004-04-27 14:01:02.499353552 +1000
@@ -38,6 +38,7 @@
 #define MAP_AUTORSRV	0x100		/* Logical swap reserved on demand */
 
 /* These are linux-specific */
+#define MAP_HUGETLB	0x0200		/* Backed with hugetlb pages */
 #define MAP_NORESERVE	0x0400		/* don't check for reservations */
 #define MAP_ANONYMOUS	0x0800		/* don't use a file */
 #define MAP_GROWSDOWN	0x1000		/* stack-like segment */
Index: working-2.6/include/asm-parisc/mman.h
===================================================================
--- working-2.6.orig/include/asm-parisc/mman.h	2004-04-27 14:01:27.187327864 +1000
+++ working-2.6/include/asm-parisc/mman.h	2004-04-27 14:01:33.227341696 +1000
@@ -15,6 +15,7 @@
 #define MAP_FIXED	0x04		/* Interpret addr exactly */
 #define MAP_ANONYMOUS	0x10		/* don't use a file */
 
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-s390/mman.h
===================================================================
--- working-2.6.orig/include/asm-s390/mman.h	2003-10-01 11:47:38.000000000 +1000
+++ working-2.6/include/asm-s390/mman.h	2004-04-27 14:02:16.636399000 +1000
@@ -24,6 +24,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/include/asm-sparc/mman.h
===================================================================
--- working-2.6.orig/include/asm-sparc/mman.h	2003-10-01 11:47:43.000000000 +1000
+++ working-2.6/include/asm-sparc/mman.h	2004-04-27 14:02:47.172415328 +1000
@@ -24,6 +24,7 @@
 #define _MAP_NEW        0x80000000      /* Binary compatibility is fun... */
 
 #define MAP_GROWSDOWN	0x0200		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 
Index: working-2.6/include/asm-v850/mman.h
===================================================================
--- working-2.6.orig/include/asm-v850/mman.h	2003-10-01 11:47:49.000000000 +1000
+++ working-2.6/include/asm-v850/mman.h	2004-04-27 14:03:19.989353704 +1000
@@ -15,6 +15,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
Index: working-2.6/mm/mmap.c
===================================================================
--- working-2.6.orig/mm/mmap.c	2004-04-20 10:50:09.000000000 +1000
+++ working-2.6/mm/mmap.c	2004-04-27 13:40:01.062285976 +1000
@@ -21,6 +21,7 @@
 #include <linux/profile.h>
 #include <linux/module.h>
 #include <linux/mount.h>
+#include <linux/err.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -62,6 +63,9 @@
 EXPORT_SYMBOL(sysctl_max_map_count);
 EXPORT_SYMBOL(vm_committed_space);
 
+int mmap_use_hugepages = 0;
+int mmap_hugepages_map_sz = 256;
+
 /*
  * Requires inode->i_mapping->i_shared_sem
  */
@@ -476,13 +480,9 @@
 	return NULL;
 }
 
-/*
- * The caller must hold down_write(current->mm->mmap_sem).
- */
-
-unsigned long do_mmap_pgoff(struct file * file, unsigned long addr,
-			unsigned long len, unsigned long prot,
-			unsigned long flags, unsigned long pgoff)
+static inline unsigned long __do_mmap_pgoff(struct file * file, unsigned long addr,
+					    unsigned long len, unsigned long prot,
+					    unsigned long flags, unsigned long pgoff)
 {
 	struct mm_struct * mm = current->mm;
 	struct vm_area_struct * vma, * prev;
@@ -494,40 +494,19 @@
 	int accountable = 1;
 	unsigned long charged = 0;
 
-	if (file) {
-		if (is_file_hugepages(file))
-			accountable = 0;
-
-		if (!file->f_op || !file->f_op->mmap)
-			return -ENODEV;
-
-		if ((prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
-			return -EPERM;
-	}
-
-	if (!len)
-		return addr;
-
-	/* Careful about overflows.. */
-	len = PAGE_ALIGN(len);
-	if (!len || len > TASK_SIZE)
-		return -EINVAL;
-
-	/* offset overflow? */
-	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
-		return -EINVAL;
-
-	/* Too many mappings? */
-	if (mm->map_count > sysctl_max_map_count)
-		return -ENOMEM;
-
-	/* Obtain the address to map to. we verify (or select) it and ensure
-	 * that it represents a valid section of the address space.
+	/* Obtain the address to map to. we verify (or select) it and
+	 * ensure that it represents a valid section of the address
+	 * space.  VM_HUGETLB will never appear in vm_flags when
+	 * CONFIG_HUGETLB is unset.
 	 */
 	addr = get_unmapped_area(file, addr, len, pgoff, flags);
 	if (addr & ~PAGE_MASK)
 		return addr;
 
+	/* Huge pages aren't accounted for here */
+	if (file && is_file_hugepages(file))
+		accountable = 0;
+
 	/* Do simple checking here so the lower-level routines won't have
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
@@ -724,11 +703,17 @@
 unmap_and_free_vma:
 	if (correct_wcount)
 		atomic_inc(&inode->i_writecount);
-	vma->vm_file = NULL;
-	fput(file);
 
-	/* Undo any partial mapping done by a device driver. */
+	/*
+	 * Undo any partial mapping done by a device driver.  
+	 * hugetlb wants to know the vma's file etc. so nuke  
+	 * the file afterward.                                
+	 */                                                   
 	zap_page_range(vma, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
+
+	if (file)
+		fput(vma->vm_file); 
+
 free_vma:
 	kmem_cache_free(vm_area_cachep, vma);
 unacct_error:
@@ -737,6 +722,62 @@
 	return error;
 }
 
+/*
+ * The caller must hold down_write(current->mm->mmap_sem).
+ */
+
+unsigned long do_mmap_pgoff(struct file * file, unsigned long addr,
+			unsigned long len, unsigned long prot,
+			unsigned long flags, unsigned long pgoff)
+{
+	struct file *hugetlb_file = NULL;
+	unsigned long result;
+
+	if (file) {
+		if ((flags & MAP_HUGETLB) && !is_file_hugepages(file))
+			return -EINVAL;
+
+		if (!file->f_op || !file->f_op->mmap)
+			return -ENODEV;
+
+		if ((prot & PROT_EXEC) && (file->f_vfsmnt->mnt_flags & MNT_NOEXEC))
+			return -EPERM;
+	}
+
+	if (!len)
+		return addr;
+
+	/* Careful about overflows.. */
+	len = PAGE_ALIGN(len);
+	if (!len || len > TASK_SIZE)
+		return -EINVAL;
+
+	/* offset overflow? */
+	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
+		return -EINVAL;
+
+	/* Too many mappings? */
+	if (current->mm->map_count > sysctl_max_map_count)
+		return -ENOMEM;
+
+	/* Create an implicit hugetlb file if necessary */
+	if (!file && (flags & MAP_HUGETLB)) {
+		file = hugetlb_file = hugetlb_zero_setup(len);
+		if (IS_ERR(file))
+			return PTR_ERR(file);
+	}
+
+	result = __do_mmap_pgoff(file, addr, len, prot, flags, pgoff);
+
+	/* Drop reference to implicit hugetlb file, it's already been
+	 * "gotten" in __do_mmap_pgoff in case of success
+	 */
+	if (hugetlb_file)
+		fput(hugetlb_file);
+
+	return result;
+}
+
 EXPORT_SYMBOL(do_mmap_pgoff);
 
 /* Get an address range which is currently unmapped.

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
