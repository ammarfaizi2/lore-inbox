Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965115AbVKBQNG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965115AbVKBQNG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 11:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbVKBQNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 11:13:05 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:60335 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S965115AbVKBQND
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 11:13:03 -0500
Subject: Re: [PATCH] 2.6.14 patch for supporting madvise(MADV_REMOVE)
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Hugh Dickins <hugh@veritas.com>,
       akpm@osdl.org, dvhltc@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>
In-Reply-To: <20051102014321.GG24051@opteron.random>
References: <1130366995.23729.38.camel@localhost.localdomain>
	 <20051028034616.GA14511@ccure.user-mode-linux.org>
	 <43624F82.6080003@us.ibm.com>
	 <20051028184235.GC8514@ccure.user-mode-linux.org>
	 <1130544201.23729.167.camel@localhost.localdomain>
	 <20051029025119.GA14998@ccure.user-mode-linux.org>
	 <1130788176.24503.19.camel@localhost.localdomain>
	 <20051101000509.GA11847@ccure.user-mode-linux.org>
	 <1130894101.24503.64.camel@localhost.localdomain>
	 <20051102014321.GG24051@opteron.random>
Content-Type: multipart/mixed; boundary="=-/dEn9N1OOOY9beaGFRMI"
Date: Wed, 02 Nov 2005 08:12:37 -0800
Message-Id: <1130947957.24503.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/dEn9N1OOOY9beaGFRMI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Andrew & Andrea,

Here is the updated patch with name change again :(
Hopefully this would be final. (MADV_REMOVE).

BTW, I am not sure if we need to hold i_sem and i_allocsem
all the way ? I wanted to be safe - but this may be overkill ?


+       /* XXX - Do we need both i_sem and i_allocsem all the way ? */
+       down(&inode->i_sem);
+       down_write(&inode->i_alloc_sem);
+       unmap_mapping_range(mapping, offset, (end - offset), 1);
+       truncate_inode_pages_range(mapping, offset, end);
+       inode->i_op->truncate_range(inode, offset, end);
+       up_write(&inode->i_alloc_sem);
+       up(&inode->i_sem);


Thanks,
Badari



--=-/dEn9N1OOOY9beaGFRMI
Content-Disposition: attachment; filename=madvise-remove.patch
Content-Type: text/x-patch; name=madvise-remove.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naurp -X dontdiff linux-2.6.14/include/asm-alpha/mman.h linux-2.6.14.madv/include/asm-alpha/mman.h
--- linux-2.6.14/include/asm-alpha/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-alpha/mman.h	2005-11-02 03:03:55.000000000 -0800
@@ -42,6 +42,7 @@
 #define MADV_WILLNEED	3		/* will need these pages */
 #define	MADV_SPACEAVAIL	5		/* ensure resources are available */
 #define MADV_DONTNEED	6		/* don't need these pages */
+#define MADV_REMOVE	7		/* remove these pages & resources */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff -Naurp -X dontdiff linux-2.6.14/include/asm-arm/mman.h linux-2.6.14.madv/include/asm-arm/mman.h
--- linux-2.6.14/include/asm-arm/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-arm/mman.h	2005-11-02 03:03:55.000000000 -0800
@@ -35,6 +35,7 @@
 #define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
+#define MADV_REMOVE	0x5		/* remove these pages & resources */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff -Naurp -X dontdiff linux-2.6.14/include/asm-arm26/mman.h linux-2.6.14.madv/include/asm-arm26/mman.h
--- linux-2.6.14/include/asm-arm26/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-arm26/mman.h	2005-11-02 03:03:55.000000000 -0800
@@ -35,6 +35,7 @@
 #define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
+#define MADV_REMOVE	0x5		/* remove these pages & resources */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff -Naurp -X dontdiff linux-2.6.14/include/asm-cris/mman.h linux-2.6.14.madv/include/asm-cris/mman.h
--- linux-2.6.14/include/asm-cris/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-cris/mman.h	2005-11-02 03:03:55.000000000 -0800
@@ -37,6 +37,7 @@
 #define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
+#define MADV_REMOVE	0x5		/* remove these pages & resources */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff -Naurp -X dontdiff linux-2.6.14/include/asm-frv/mman.h linux-2.6.14.madv/include/asm-frv/mman.h
--- linux-2.6.14/include/asm-frv/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-frv/mman.h	2005-11-02 03:03:55.000000000 -0800
@@ -35,6 +35,7 @@
 #define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
+#define MADV_REMOVE	0x5		/* remove these pages & resources */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff -Naurp -X dontdiff linux-2.6.14/include/asm-h8300/mman.h linux-2.6.14.madv/include/asm-h8300/mman.h
--- linux-2.6.14/include/asm-h8300/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-h8300/mman.h	2005-11-02 03:03:55.000000000 -0800
@@ -35,6 +35,7 @@
 #define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
+#define MADV_REMOVE	0x5		/* remove these pages & resources */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff -Naurp -X dontdiff linux-2.6.14/include/asm-i386/mman.h linux-2.6.14.madv/include/asm-i386/mman.h
--- linux-2.6.14/include/asm-i386/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-i386/mman.h	2005-11-02 03:03:55.000000000 -0800
@@ -35,6 +35,7 @@
 #define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
+#define MADV_REMOVE	0x5		/* remove these pages & resources */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff -Naurp -X dontdiff linux-2.6.14/include/asm-ia64/mman.h linux-2.6.14.madv/include/asm-ia64/mman.h
--- linux-2.6.14/include/asm-ia64/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-ia64/mman.h	2005-11-02 03:03:55.000000000 -0800
@@ -43,6 +43,7 @@
 #define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
+#define MADV_REMOVE	0x5		/* remove these pages & resources */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff -Naurp -X dontdiff linux-2.6.14/include/asm-m32r/mman.h linux-2.6.14.madv/include/asm-m32r/mman.h
--- linux-2.6.14/include/asm-m32r/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-m32r/mman.h	2005-11-02 03:03:55.000000000 -0800
@@ -37,6 +37,7 @@
 #define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
+#define MADV_REMOVE	0x5		/* remove these pages & resources */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff -Naurp -X dontdiff linux-2.6.14/include/asm-m68k/mman.h linux-2.6.14.madv/include/asm-m68k/mman.h
--- linux-2.6.14/include/asm-m68k/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-m68k/mman.h	2005-11-02 03:03:55.000000000 -0800
@@ -35,6 +35,7 @@
 #define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
+#define MADV_REMOVE	0x5		/* remove these pages & resources */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff -Naurp -X dontdiff linux-2.6.14/include/asm-mips/mman.h linux-2.6.14.madv/include/asm-mips/mman.h
--- linux-2.6.14/include/asm-mips/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-mips/mman.h	2005-11-02 03:03:55.000000000 -0800
@@ -65,6 +65,7 @@
 #define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
+#define MADV_REMOVE	0x5		/* remove these pages & resources */
 
 /* compatibility flags */
 #define MAP_ANON       MAP_ANONYMOUS
diff -Naurp -X dontdiff linux-2.6.14/include/asm-parisc/mman.h linux-2.6.14.madv/include/asm-parisc/mman.h
--- linux-2.6.14/include/asm-parisc/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-parisc/mman.h	2005-11-02 03:12:02.000000000 -0800
@@ -38,6 +38,7 @@
 #define MADV_SPACEAVAIL 5               /* insure that resources are reserved */
 #define MADV_VPS_PURGE  6               /* Purge pages from VM page cache */
 #define MADV_VPS_INHERIT 7              /* Inherit parents page size */
+#define MADV_REMOVE     8		/* remove these pages & resources */
 
 /* The range 12-64 is reserved for page size specification. */
 #define MADV_4K_PAGES   12              /* Use 4K pages  */
diff -Naurp -X dontdiff linux-2.6.14/include/asm-powerpc/mman.h linux-2.6.14.madv/include/asm-powerpc/mman.h
--- linux-2.6.14/include/asm-powerpc/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-powerpc/mman.h	2005-11-02 03:03:55.000000000 -0800
@@ -44,6 +44,7 @@
 #define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
+#define MADV_REMOVE	0x5		/* remove these pages & resources */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff -Naurp -X dontdiff linux-2.6.14/include/asm-s390/mman.h linux-2.6.14.madv/include/asm-s390/mman.h
--- linux-2.6.14/include/asm-s390/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-s390/mman.h	2005-11-02 03:12:13.000000000 -0800
@@ -43,6 +43,7 @@
 #define MADV_SEQUENTIAL        0x2             /* read-ahead aggressively */
 #define MADV_WILLNEED  0x3              /* pre-fault pages */
 #define MADV_DONTNEED  0x4              /* discard these pages */
+#define MADV_REMOVE    0x5		/* remove these pages & resources */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff -Naurp -X dontdiff linux-2.6.14/include/asm-sh/mman.h linux-2.6.14.madv/include/asm-sh/mman.h
--- linux-2.6.14/include/asm-sh/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-sh/mman.h	2005-11-02 03:03:55.000000000 -0800
@@ -35,6 +35,7 @@
 #define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
+#define MADV_REMOVE	0x5		/* remove these pages & resources */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff -Naurp -X dontdiff linux-2.6.14/include/asm-sparc/mman.h linux-2.6.14.madv/include/asm-sparc/mman.h
--- linux-2.6.14/include/asm-sparc/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-sparc/mman.h	2005-11-02 03:04:57.000000000 -0800
@@ -54,6 +54,7 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_FREE	0x5		/* (Solaris) contents can be freed */
+#define MADV_REMOVE	0x6		/* remove these pages & resources */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff -Naurp -X dontdiff linux-2.6.14/include/asm-sparc64/mman.h linux-2.6.14.madv/include/asm-sparc64/mman.h
--- linux-2.6.14/include/asm-sparc64/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-sparc64/mman.h	2005-11-02 03:04:35.000000000 -0800
@@ -54,6 +54,7 @@
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
 #define MADV_FREE	0x5		/* (Solaris) contents can be freed */
+#define MADV_REMOVE	0x6		/* remove these pages & resources */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff -Naurp -X dontdiff linux-2.6.14/include/asm-v850/mman.h linux-2.6.14.madv/include/asm-v850/mman.h
--- linux-2.6.14/include/asm-v850/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-v850/mman.h	2005-11-02 03:03:55.000000000 -0800
@@ -32,6 +32,7 @@
 #define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
+#define MADV_REMOVE	0x5		/* remove these pages & resources */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff -Naurp -X dontdiff linux-2.6.14/include/asm-x86_64/mman.h linux-2.6.14.madv/include/asm-x86_64/mman.h
--- linux-2.6.14/include/asm-x86_64/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-x86_64/mman.h	2005-11-02 03:03:55.000000000 -0800
@@ -36,6 +36,7 @@
 #define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
+#define MADV_REMOVE	0x5		/* remove these pages & resources */
 
 /* compatibility flags */
 #define MAP_ANON	MAP_ANONYMOUS
diff -Naurp -X dontdiff linux-2.6.14/include/asm-xtensa/mman.h linux-2.6.14.madv/include/asm-xtensa/mman.h
--- linux-2.6.14/include/asm-xtensa/mman.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/asm-xtensa/mman.h	2005-11-02 03:03:55.000000000 -0800
@@ -72,6 +72,7 @@
 #define MADV_SEQUENTIAL	0x2		/* read-ahead aggressively */
 #define MADV_WILLNEED	0x3		/* pre-fault pages */
 #define MADV_DONTNEED	0x4		/* discard these pages */
+#define MADV_REMOVE	0x5		/* remove these pages & resources */
 
 /* compatibility flags */
 #define MAP_ANON       MAP_ANONYMOUS
diff -Naurp -X dontdiff linux-2.6.14/include/linux/fs.h linux-2.6.14.madv/include/linux/fs.h
--- linux-2.6.14/include/linux/fs.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/linux/fs.h	2005-11-02 03:03:55.000000000 -0800
@@ -995,6 +995,7 @@ struct inode_operations {
 	ssize_t (*getxattr) (struct dentry *, const char *, void *, size_t);
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
 	int (*removexattr) (struct dentry *, const char *);
+	void (*truncate_range)(struct inode *, loff_t, loff_t);
 };
 
 struct seq_file;
diff -Naurp -X dontdiff linux-2.6.14/include/linux/mm.h linux-2.6.14.madv/include/linux/mm.h
--- linux-2.6.14/include/linux/mm.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/include/linux/mm.h	2005-11-02 03:03:55.000000000 -0800
@@ -704,6 +704,7 @@ static inline void unmap_shared_mapping_
 }
 
 extern int vmtruncate(struct inode * inode, loff_t offset);
+extern int vmtruncate_range(struct inode * inode, loff_t offset, loff_t end);
 extern pud_t *FASTCALL(__pud_alloc(struct mm_struct *mm, pgd_t *pgd, unsigned long address));
 extern pmd_t *FASTCALL(__pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address));
 extern pte_t *FASTCALL(pte_alloc_kernel(struct mm_struct *mm, pmd_t *pmd, unsigned long address));
@@ -865,6 +866,7 @@ extern unsigned long do_brk(unsigned lon
 /* filemap.c */
 extern unsigned long page_unuse(struct page *);
 extern void truncate_inode_pages(struct address_space *, loff_t);
+extern void truncate_inode_pages_range(struct address_space *, loff_t, loff_t);
 
 /* generic vm_area_ops exported for stackable file systems */
 extern struct page *filemap_nopage(struct vm_area_struct *, unsigned long, int *);
diff -Naurp -X dontdiff linux-2.6.14/mm/madvise.c linux-2.6.14.madv/mm/madvise.c
--- linux-2.6.14/mm/madvise.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/mm/madvise.c	2005-11-02 03:03:55.000000000 -0800
@@ -140,6 +140,39 @@ static long madvise_dontneed(struct vm_a
 	return 0;
 }
 
+/*
+ * Application wants to free up the pages and associated backing store. 
+ * This is effectively punching a hole into the middle of a file.
+ *
+ * NOTE: Currently, only shmfs/tmpfs is supported for this operation.
+ * Other filesystems return -ENOSYS.
+ */
+static long madvise_remove(struct vm_area_struct * vma,
+			     unsigned long start, unsigned long end)
+{
+	struct address_space *mapping;
+        loff_t offset, endoff;
+
+	if (vma->vm_flags & (VM_LOCKED|VM_NONLINEAR|VM_HUGETLB)) 
+		return -EINVAL;
+
+	if (!vma->vm_file || !vma->vm_file->f_mapping 
+		|| !vma->vm_file->f_mapping->host) {
+			return -EINVAL;
+	}
+
+	mapping = vma->vm_file->f_mapping;
+	if (mapping == &swapper_space) {
+		return -EINVAL;
+	}
+
+	offset = (loff_t)(start - vma->vm_start) 
+			+ (vma->vm_pgoff << PAGE_SHIFT);
+	endoff = (loff_t)(end - vma->vm_start - 1) 
+			+ (vma->vm_pgoff << PAGE_SHIFT);
+	return  vmtruncate_range(mapping->host, offset, endoff);
+}
+
 static long
 madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
 		unsigned long start, unsigned long end, int behavior)
@@ -152,6 +185,9 @@ madvise_vma(struct vm_area_struct *vma, 
 	case MADV_RANDOM:
 		error = madvise_behavior(vma, prev, start, end, behavior);
 		break;
+	case MADV_REMOVE:
+		error = madvise_remove(vma, start, end);
+		break;
 
 	case MADV_WILLNEED:
 		error = madvise_willneed(vma, prev, start, end);
@@ -190,6 +226,8 @@ madvise_vma(struct vm_area_struct *vma, 
  *		some pages ahead.
  *  MADV_DONTNEED - the application is finished with the given range,
  *		so the kernel can free resources associated with it.
+ *  MADV_REMOVE - the application wants to free up the given range of
+ *		pages and associated backing store.
  *
  * return values:
  *  zero    - success
diff -Naurp -X dontdiff linux-2.6.14/mm/memory.c linux-2.6.14.madv/mm/memory.c
--- linux-2.6.14/mm/memory.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/mm/memory.c	2005-11-02 03:03:55.000000000 -0800
@@ -1597,6 +1597,32 @@ out_busy:
 
 EXPORT_SYMBOL(vmtruncate);
 
+int vmtruncate_range(struct inode * inode, loff_t offset, loff_t end)
+{
+	struct address_space *mapping = inode->i_mapping;
+
+	/*
+	 * If the underlying filesystem is not going to provide 
+	 * a way to truncate a range of blocks (punch a hole) - 
+	 * we should return failure right now.
+	 */
+	if (!inode->i_op || !inode->i_op->truncate_range)
+		return -ENOSYS;
+		
+	/* XXX - Do we need both i_sem and i_allocsem all the way ? */
+	down(&inode->i_sem);
+	down_write(&inode->i_alloc_sem);
+	unmap_mapping_range(mapping, offset, (end - offset), 1);
+	truncate_inode_pages_range(mapping, offset, end);
+	inode->i_op->truncate_range(inode, offset, end);
+	up_write(&inode->i_alloc_sem);
+	up(&inode->i_sem);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(vmtruncate_range);
+
 /* 
  * Primitive swap readahead code. We simply read an aligned block of
  * (1 << page_cluster) entries in the swap area. This method is chosen
diff -Naurp -X dontdiff linux-2.6.14/mm/shmem.c linux-2.6.14.madv/mm/shmem.c
--- linux-2.6.14/mm/shmem.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/mm/shmem.c	2005-11-02 03:03:55.000000000 -0800
@@ -459,7 +459,7 @@ static void shmem_free_pages(struct list
 	} while (next);
 }
 
-static void shmem_truncate(struct inode *inode)
+static void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	unsigned long idx;
@@ -477,18 +477,27 @@ static void shmem_truncate(struct inode 
 	long nr_swaps_freed = 0;
 	int offset;
 	int freed;
+	int punch_hole = 0;
 
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-	idx = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	idx = (start + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
 	if (idx >= info->next_index)
 		return;
 
 	spin_lock(&info->lock);
 	info->flags |= SHMEM_TRUNCATE;
-	limit = info->next_index;
-	info->next_index = idx;
+	if (likely(end == (loff_t) -1)) {
+		limit = info->next_index;
+		info->next_index = idx;
+	} else {
+		limit = (end + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+		if (limit > info->next_index)
+			limit = info->next_index;
+		punch_hole = 1;
+	}
+
 	topdir = info->i_indirect;
-	if (topdir && idx <= SHMEM_NR_DIRECT) {
+	if (topdir && idx <= SHMEM_NR_DIRECT && !punch_hole) {
 		info->i_indirect = NULL;
 		nr_pages_to_free++;
 		list_add(&topdir->lru, &pages_to_free);
@@ -575,11 +584,12 @@ static void shmem_truncate(struct inode 
 			subdir->nr_swapped -= freed;
 			if (offset)
 				spin_unlock(&info->lock);
-			BUG_ON(subdir->nr_swapped > offset);
+			if (!punch_hole)
+				BUG_ON(subdir->nr_swapped > offset);
 		}
 		if (offset)
 			offset = 0;
-		else if (subdir) {
+		else if (subdir && !subdir->nr_swapped) {
 			dir[diroff] = NULL;
 			nr_pages_to_free++;
 			list_add(&subdir->lru, &pages_to_free);
@@ -596,7 +606,7 @@ done2:
 		 * Also, though shmem_getpage checks i_size before adding to
 		 * cache, no recheck after: so fix the narrow window there too.
 		 */
-		truncate_inode_pages(inode->i_mapping, inode->i_size);
+		truncate_inode_pages_range(inode->i_mapping, start, end);
 	}
 
 	spin_lock(&info->lock);
@@ -616,6 +626,11 @@ done2:
 	}
 }
 
+static void shmem_truncate(struct inode *inode)
+{
+	shmem_truncate_range(inode, inode->i_size, (loff_t)-1);
+}
+
 static int shmem_notify_change(struct dentry *dentry, struct iattr *attr)
 {
 	struct inode *inode = dentry->d_inode;
@@ -2083,6 +2098,7 @@ static struct file_operations shmem_file
 static struct inode_operations shmem_inode_operations = {
 	.truncate	= shmem_truncate,
 	.setattr	= shmem_notify_change,
+	.truncate_range	= shmem_truncate_range,
 };
 
 static struct inode_operations shmem_dir_inode_operations = {
diff -Naurp -X dontdiff linux-2.6.14/mm/truncate.c linux-2.6.14.madv/mm/truncate.c
--- linux-2.6.14/mm/truncate.c	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.14.madv/mm/truncate.c	2005-11-02 03:03:55.000000000 -0800
@@ -91,12 +91,15 @@ invalidate_complete_page(struct address_
 }
 
 /**
- * truncate_inode_pages - truncate *all* the pages from an offset
+ * truncate_inode_pages - truncate range of pages specified by start and
+ * end byte offsets
  * @mapping: mapping to truncate
  * @lstart: offset from which to truncate
+ * @lend: offset to which to truncate
  *
- * Truncate the page cache at a set offset, removing the pages that are beyond
- * that offset (and zeroing out partial pages).
+ * Truncate the page cache, removing the pages that are between
+ * specified offsets (and zeroing out partial page
+ * (if lstart is not page aligned)).
  *
  * Truncate takes two passes - the first pass is nonblocking.  It will not
  * block on page locks and it will not block on writeback.  The second pass
@@ -110,12 +113,12 @@ invalidate_complete_page(struct address_
  * We pass down the cache-hot hint to the page freeing code.  Even if the
  * mapping is large, it is probably the case that the final pages are the most
  * recently touched, and freeing happens in ascending file offset order.
- *
- * Called under (and serialised by) inode->i_sem.
  */
-void truncate_inode_pages(struct address_space *mapping, loff_t lstart)
+void truncate_inode_pages_range(struct address_space *mapping,
+				loff_t lstart, loff_t lend)
 {
 	const pgoff_t start = (lstart + PAGE_CACHE_SIZE-1) >> PAGE_CACHE_SHIFT;
+	pgoff_t end;
 	const unsigned partial = lstart & (PAGE_CACHE_SIZE - 1);
 	struct pagevec pvec;
 	pgoff_t next;
@@ -124,13 +127,22 @@ void truncate_inode_pages(struct address
 	if (mapping->nrpages == 0)
 		return;
 
+	BUG_ON((lend & (PAGE_CACHE_SIZE - 1)) != (PAGE_CACHE_SIZE - 1));
+	end = (lend  >> PAGE_CACHE_SHIFT);
+
 	pagevec_init(&pvec, 0);
 	next = start;
-	while (pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
+	while (next <= end &&
+	       pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 			pgoff_t page_index = page->index;
 
+			if (page_index > end) {
+				next = page_index;
+				break;
+			}
+
 			if (page_index > next)
 				next = page_index;
 			next++;
@@ -166,9 +178,15 @@ void truncate_inode_pages(struct address
 			next = start;
 			continue;
 		}
+		if (pvec.pages[0]->index > end) {
+			pagevec_release(&pvec);
+			break;
+		}
 		for (i = 0; i < pagevec_count(&pvec); i++) {
 			struct page *page = pvec.pages[i];
 
+			if (page->index > end)
+				break;
 			lock_page(page);
 			wait_on_page_writeback(page);
 			if (page->index > next)
@@ -180,7 +198,19 @@ void truncate_inode_pages(struct address
 		pagevec_release(&pvec);
 	}
 }
+EXPORT_SYMBOL(truncate_inode_pages_range);
 
+/**
+ * truncate_inode_pages - truncate *all* the pages from an offset
+ * @mapping: mapping to truncate
+ * @lstart: offset from which to truncate
+ *
+ * Called under (and serialised by) inode->i_sem.
+ */
+void truncate_inode_pages(struct address_space *mapping, loff_t lstart)
+{
+	truncate_inode_pages_range(mapping, lstart, (loff_t)-1);
+}
 EXPORT_SYMBOL(truncate_inode_pages);
 
 /**

--=-/dEn9N1OOOY9beaGFRMI--

