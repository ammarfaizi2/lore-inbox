Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263824AbUEMG2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbUEMG2E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 02:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbUEMG2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 02:28:04 -0400
Received: from holomorphy.com ([207.189.100.168]:13756 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263827AbUEMG1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 02:27:38 -0400
Date: Wed, 12 May 2004 23:27:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, Adam Litke <agl@us.ibm.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: More convenient way to grab hugepage memory
Message-ID: <20040513062706.GQ1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Adam Litke <agl@us.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
References: <20040513055520.GF27403@zax> <20040513060639.GN1397@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513060639.GN1397@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2004 at 11:06:39PM -0700, William Lee Irwin III wrote:
> These aren't used anywhere else in your patch; any chance you could
> nuke them?
> Thanks.

Here is a rediff vs. 2.6.6-mm1 (1 reject resolved) with the removal of
the global variables included:


-- wli

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


diff -u wli-2.6.6-mm1/mm/mmap.c wli-2.6.6-mm1/mm/mmap.c
--- wli-2.6.6-mm1/mm/mmap.c	2004-05-12 23:17:22.000000000 -0700
+++ wli-2.6.6-mm1/mm/mmap.c	2004-05-12 23:18:07.000000000 -0700
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/mempolicy.h>
+#include <linux/err.h>
 
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
@@ -528,13 +529,9 @@
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
@@ -546,40 +543,19 @@
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
@@ -776,11 +752,17 @@
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
@@ -789,6 +771,62 @@
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
unchanged:
--- wli-2.6.6-mm1.orig/include/asm-i386/mman.h	2004-05-09 19:32:01.000000000 -0700
+++ wli-2.6.6-mm1/include/asm-i386/mman.h	2004-05-12 23:17:22.000000000 -0700
@@ -16,6 +16,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed by hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
unchanged:
--- wli-2.6.6-mm1.orig/include/asm-ppc64/mman.h	2004-05-09 19:32:28.000000000 -0700
+++ wli-2.6.6-mm1/include/asm-ppc64/mman.h	2004-05-12 23:17:22.000000000 -0700
@@ -26,6 +26,7 @@
 #define MAP_LOCKED	0x80
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 
unchanged:
--- wli-2.6.6-mm1.orig/include/linux/mman.h	2004-05-09 19:32:01.000000000 -0700
+++ wli-2.6.6-mm1/include/linux/mman.h	2004-05-12 23:17:22.000000000 -0700
@@ -58,6 +58,9 @@
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
 	       _calc_vm_trans(flags, MAP_EXECUTABLE, VM_EXECUTABLE) |
+#ifdef CONFIG_HUGETLB_PAGE
+               _calc_vm_trans(flags, MAP_HUGETLB,    VM_HUGETLB   ) |
+#endif
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    );
 }
 
unchanged:
--- wli-2.6.6-mm1.orig/include/asm-sh/mman.h	2004-05-09 19:33:13.000000000 -0700
+++ wli-2.6.6-mm1/include/asm-sh/mman.h	2004-05-12 23:17:22.000000000 -0700
@@ -16,6 +16,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
unchanged:
--- wli-2.6.6-mm1.orig/include/asm-ia64/mman.h	2004-05-09 19:32:37.000000000 -0700
+++ wli-2.6.6-mm1/include/asm-ia64/mman.h	2004-05-12 23:17:22.000000000 -0700
@@ -24,6 +24,7 @@
 
 #define MAP_GROWSDOWN	0x00100		/* stack-like segment */
 #define MAP_GROWSUP	0x00200		/* register stack-like segment */
+#define MAP_HUGETLB	0x00400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x00800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x01000		/* mark it as an executable */
 #define MAP_LOCKED	0x02000		/* pages are locked */
unchanged:
--- wli-2.6.6-mm1.orig/include/asm-sparc64/mman.h	2004-05-09 19:32:29.000000000 -0700
+++ wli-2.6.6-mm1/include/asm-sparc64/mman.h	2004-05-12 23:17:22.000000000 -0700
@@ -24,6 +24,7 @@
 #define _MAP_NEW        0x80000000      /* Binary compatibility is fun... */
 
 #define MAP_GROWSDOWN	0x0200		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 
unchanged:
--- wli-2.6.6-mm1.orig/include/asm-x86_64/mman.h	2004-05-09 19:32:53.000000000 -0700
+++ wli-2.6.6-mm1/include/asm-x86_64/mman.h	2004-05-12 23:17:22.000000000 -0700
@@ -17,6 +17,7 @@
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
unchanged:
--- wli-2.6.6-mm1.orig/include/asm-ppc/mman.h	2004-05-09 19:33:22.000000000 -0700
+++ wli-2.6.6-mm1/include/asm-ppc/mman.h	2004-05-12 23:17:22.000000000 -0700
@@ -19,6 +19,7 @@
 #define MAP_LOCKED	0x80
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
unchanged:
--- wli-2.6.6-mm1.orig/include/asm-alpha/mman.h	2004-05-09 19:31:58.000000000 -0700
+++ wli-2.6.6-mm1/include/asm-alpha/mman.h	2004-05-12 23:17:22.000000000 -0700
@@ -28,6 +28,7 @@
 #define MAP_NORESERVE	0x10000		/* don't check for reservations */
 #define MAP_POPULATE	0x20000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x40000		/* do not block on IO */
+#define MAP_HUGETLB	0x80000		/* Backed with hugetlb pages */
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_SYNC		2		/* synchronous memory sync */
unchanged:
--- wli-2.6.6-mm1.orig/include/asm-arm/mman.h	2004-05-09 19:32:27.000000000 -0700
+++ wli-2.6.6-mm1/include/asm-arm/mman.h	2004-05-12 23:17:22.000000000 -0700
@@ -16,6 +16,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
unchanged:
--- wli-2.6.6-mm1.orig/include/asm-arm26/mman.h	2004-05-09 19:31:59.000000000 -0700
+++ wli-2.6.6-mm1/include/asm-arm26/mman.h	2004-05-12 23:17:22.000000000 -0700
@@ -16,6 +16,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
unchanged:
--- wli-2.6.6-mm1.orig/include/asm-cris/mman.h	2004-05-09 19:33:20.000000000 -0700
+++ wli-2.6.6-mm1/include/asm-cris/mman.h	2004-05-12 23:17:22.000000000 -0700
@@ -18,6 +18,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
unchanged:
--- wli-2.6.6-mm1.orig/include/asm-h8300/mman.h	2004-05-09 19:32:38.000000000 -0700
+++ wli-2.6.6-mm1/include/asm-h8300/mman.h	2004-05-12 23:17:22.000000000 -0700
@@ -15,6 +15,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
unchanged:
--- wli-2.6.6-mm1.orig/include/asm-m68k/mman.h	2004-05-09 19:32:01.000000000 -0700
+++ wli-2.6.6-mm1/include/asm-m68k/mman.h	2004-05-12 23:17:22.000000000 -0700
@@ -16,6 +16,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
unchanged:
--- wli-2.6.6-mm1.orig/include/asm-mips/mman.h	2004-05-09 19:32:27.000000000 -0700
+++ wli-2.6.6-mm1/include/asm-mips/mman.h	2004-05-12 23:17:22.000000000 -0700
@@ -38,6 +38,7 @@
 #define MAP_AUTORSRV	0x100		/* Logical swap reserved on demand */
 
 /* These are linux-specific */
+#define MAP_HUGETLB	0x0200		/* Backed with hugetlb pages */
 #define MAP_NORESERVE	0x0400		/* don't check for reservations */
 #define MAP_ANONYMOUS	0x0800		/* don't use a file */
 #define MAP_GROWSDOWN	0x1000		/* stack-like segment */
unchanged:
--- wli-2.6.6-mm1.orig/include/asm-parisc/mman.h	2004-05-09 19:32:52.000000000 -0700
+++ wli-2.6.6-mm1/include/asm-parisc/mman.h	2004-05-12 23:17:22.000000000 -0700
@@ -15,6 +15,7 @@
 #define MAP_FIXED	0x04		/* Interpret addr exactly */
 #define MAP_ANONYMOUS	0x10		/* don't use a file */
 
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
unchanged:
--- wli-2.6.6-mm1.orig/include/asm-s390/mman.h	2004-05-09 19:32:00.000000000 -0700
+++ wli-2.6.6-mm1/include/asm-s390/mman.h	2004-05-12 23:17:22.000000000 -0700
@@ -24,6 +24,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
unchanged:
--- wli-2.6.6-mm1.orig/include/asm-sparc/mman.h	2004-05-09 19:33:20.000000000 -0700
+++ wli-2.6.6-mm1/include/asm-sparc/mman.h	2004-05-12 23:17:22.000000000 -0700
@@ -24,6 +24,7 @@
 #define _MAP_NEW        0x80000000      /* Binary compatibility is fun... */
 
 #define MAP_GROWSDOWN	0x0200		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 
unchanged:
--- wli-2.6.6-mm1.orig/include/asm-v850/mman.h	2004-05-09 19:33:13.000000000 -0700
+++ wli-2.6.6-mm1/include/asm-v850/mman.h	2004-05-12 23:17:22.000000000 -0700
@@ -15,6 +15,7 @@
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
 
 #define MAP_GROWSDOWN	0x0100		/* stack-like segment */
+#define MAP_HUGETLB	0x0400		/* Backed with hugetlb pages */
 #define MAP_DENYWRITE	0x0800		/* ETXTBSY */
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_LOCKED	0x2000		/* pages are locked */
