Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbUKQQpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbUKQQpa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 11:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262401AbUKQQoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 11:44:38 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:6047 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262404AbUKQQlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 11:41:08 -0500
Date: Wed, 17 Nov 2004 17:40:37 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: loops in get_user_pages() for VM_IO
Message-ID: <20041117164037.GD5114@dualathlon.random>
References: <20041116175328.5e425e01.davem@davemloft.net> <20041116180718.2fa35fbb.davem@davemloft.net> <20041116223338.08bb6701.akpm@osdl.org> <20041117134408.GA5114@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117134408.GA5114@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 02:44:08PM +0100, Andrea Arcangeli wrote:
> this would be the full port against mainline:

while it's not necessary with mlockall (since we walk each vma in
mlock.c before calling make_pages_present), I've to agree having a more
generic implementation of get_user_pages that doesn't stop on VM_IO with
pages = NULL, sounds a nicer API (even if nobody uses that
functionality). Still I'd leave make_pages_present void.  Andrew's patch
had two bugs: it didn't check for "len" underflow and it used vm_start
instead of start to calculated the current page walk under VM_IO, plus
it did the same checks more than once for no good reason.  I also
believe it's broken to have "len" as an int, should be unsigned long
even if it's in page_size units (64bit would overflow with huge user
address space). This is my current status. Comments? (still I don't see
any value in returning any error from make_pages_present, nobody is
checking that anyways, in my tree the only error that could really
happen in find_vma was turned down for some unknown reason by some
random patch, I mean, mlock.c already does all the checks and returns
-ENOMEM if the mlock range is outside vmas, make_pages_present should
just do its job, we're under the mmap sem so nothing can change to
prevent make_pages_present to do its job)

Signed-off-by: Andrea Arcangeli <andrea@novell.com>

Index: linux-2.5/arch/i386/mm/hugetlbpage.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/i386/mm/hugetlbpage.c,v
retrieving revision 1.54
diff -u -p -r1.54 hugetlbpage.c
--- linux-2.5/arch/i386/mm/hugetlbpage.c	26 Oct 2004 01:24:02 -0000	1.54
+++ linux-2.5/arch/i386/mm/hugetlbpage.c	17 Nov 2004 16:35:31 -0000
@@ -94,10 +94,10 @@ nomem:
 int
 follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		    struct page **pages, struct vm_area_struct **vmas,
-		    unsigned long *position, int *length, int i)
+		    unsigned long *position, unsigned long *length, int i)
 {
 	unsigned long vpfn, vaddr = *position;
-	int remainder = *length;
+	unsigned long remainder = *length;
 
 	WARN_ON(!is_vm_hugetlb_page(vma));
 
Index: linux-2.5/arch/ia64/mm/hugetlbpage.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/ia64/mm/hugetlbpage.c,v
retrieving revision 1.31
diff -u -p -r1.31 hugetlbpage.c
--- linux-2.5/arch/ia64/mm/hugetlbpage.c	30 Jun 2004 02:26:38 -0000	1.31
+++ linux-2.5/arch/ia64/mm/hugetlbpage.c	17 Nov 2004 16:35:23 -0000
@@ -119,12 +119,12 @@ nomem:
 int
 follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		    struct page **pages, struct vm_area_struct **vmas,
-		    unsigned long *st, int *length, int i)
+		    unsigned long *st, unsigned long *length, int i)
 {
 	pte_t *ptep, pte;
 	unsigned long start = *st;
 	unsigned long pstart;
-	int len = *length;
+	unsigned long len = *length;
 	struct page *page;
 
 	do {
Index: linux-2.5/arch/ppc64/mm/hugetlbpage.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/ppc64/mm/hugetlbpage.c,v
retrieving revision 1.35
diff -u -p -r1.35 hugetlbpage.c
--- linux-2.5/arch/ppc64/mm/hugetlbpage.c	28 Oct 2004 15:19:52 -0000	1.35
+++ linux-2.5/arch/ppc64/mm/hugetlbpage.c	17 Nov 2004 16:36:47 -0000
@@ -325,10 +325,10 @@ int copy_hugetlb_page_range(struct mm_st
 int
 follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 		    struct page **pages, struct vm_area_struct **vmas,
-		    unsigned long *position, int *length, int i)
+		    unsigned long *position, unsigned long *length, int i)
 {
 	unsigned long vpfn, vaddr = *position;
-	int remainder = *length;
+	unsigned long remainder = *length;
 
 	WARN_ON(!is_vm_hugetlb_page(vma));
 
Index: linux-2.5/arch/sh/mm/hugetlbpage.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/sh/mm/hugetlbpage.c,v
retrieving revision 1.10
diff -u -p -r1.10 hugetlbpage.c
--- linux-2.5/arch/sh/mm/hugetlbpage.c	10 May 2004 21:08:49 -0000	1.10
+++ linux-2.5/arch/sh/mm/hugetlbpage.c	17 Nov 2004 16:34:57 -0000
@@ -126,10 +126,10 @@ nomem:
 
 int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			struct page **pages, struct vm_area_struct **vmas,
-			unsigned long *position, int *length, int i)
+			unsigned long *position, unsigned long *length, int i)
 {
 	unsigned long vaddr = *position;
-	int remainder = *length;
+	unsigned long remainder = *length;
 
 	WARN_ON(!is_vm_hugetlb_page(vma));
 
Index: linux-2.5/arch/sh64/mm/hugetlbpage.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/sh64/mm/hugetlbpage.c,v
retrieving revision 1.2
diff -u -p -r1.2 hugetlbpage.c
--- linux-2.5/arch/sh64/mm/hugetlbpage.c	30 Jun 2004 02:18:58 -0000	1.2
+++ linux-2.5/arch/sh64/mm/hugetlbpage.c	17 Nov 2004 16:34:41 -0000
@@ -126,10 +126,10 @@ nomem:
 
 int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			struct page **pages, struct vm_area_struct **vmas,
-			unsigned long *position, int *length, int i)
+			unsigned long *position, unsigned long *length, int i)
 {
 	unsigned long vaddr = *position;
-	int remainder = *length;
+	unsigned long remainder = *length;
 
 	WARN_ON(!is_vm_hugetlb_page(vma));
 
Index: linux-2.5/arch/sparc64/mm/hugetlbpage.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/arch/sparc64/mm/hugetlbpage.c,v
retrieving revision 1.24
diff -u -p -r1.24 hugetlbpage.c
--- linux-2.5/arch/sparc64/mm/hugetlbpage.c	10 May 2004 21:08:49 -0000	1.24
+++ linux-2.5/arch/sparc64/mm/hugetlbpage.c	17 Nov 2004 16:34:36 -0000
@@ -123,10 +123,10 @@ nomem:
 
 int follow_hugetlb_page(struct mm_struct *mm, struct vm_area_struct *vma,
 			struct page **pages, struct vm_area_struct **vmas,
-			unsigned long *position, int *length, int i)
+			unsigned long *position, unsigned long *length, int i)
 {
 	unsigned long vaddr = *position;
-	int remainder = *length;
+	unsigned long remainder = *length;
 
 	WARN_ON(!is_vm_hugetlb_page(vma));
 
Index: linux-2.5/include/linux/hugetlb.h
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/include/linux/hugetlb.h,v
retrieving revision 1.33
diff -u -p -r1.33 hugetlb.h
--- linux-2.5/include/linux/hugetlb.h	8 Aug 2004 06:43:47 -0000	1.33
+++ linux-2.5/include/linux/hugetlb.h	17 Nov 2004 16:32:13 -0000
@@ -14,7 +14,7 @@ static inline int is_vm_hugetlb_page(str
 
 int hugetlb_sysctl_handler(struct ctl_table *, int, struct file *, void __user *, size_t *, loff_t *);
 int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
-int follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *, struct page **, struct vm_area_struct **, unsigned long *, int *, int);
+int follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *, struct page **, struct vm_area_struct **, unsigned long *, unsigned long *, int);
 void zap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 void unmap_hugepage_range(struct vm_area_struct *, unsigned long, unsigned long);
 int hugetlb_prefault(struct address_space *, struct vm_area_struct *);
Index: linux-2.5/include/linux/mm.h
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/include/linux/mm.h,v
retrieving revision 1.195
diff -u -p -r1.195 mm.h
--- linux-2.5/include/linux/mm.h	14 Nov 2004 04:35:49 -0000	1.195
+++ linux-2.5/include/linux/mm.h	17 Nov 2004 16:16:50 -0000
@@ -587,12 +587,12 @@ extern pte_t *FASTCALL(pte_alloc_map(str
 extern int install_page(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, struct page *page, pgprot_t prot);
 extern int install_file_pte(struct mm_struct *mm, struct vm_area_struct *vma, unsigned long addr, unsigned long pgoff, pgprot_t prot);
 extern int handle_mm_fault(struct mm_struct *mm,struct vm_area_struct *vma, unsigned long address, int write_access);
-extern int make_pages_present(unsigned long addr, unsigned long end);
+extern void make_pages_present(unsigned long addr, unsigned long end);
 extern int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, int len, int write);
 void install_arg_page(struct vm_area_struct *, struct page *, unsigned long);
 
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
-		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas);
+		   unsigned long nr_pages, int write, int force, struct page **pages, struct vm_area_struct **vmas);
 
 int __set_page_dirty_buffers(struct page *page);
 int __set_page_dirty_nobuffers(struct page *page);
Index: linux-2.5/mm/memory.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/mm/memory.c,v
retrieving revision 1.191
diff -u -p -r1.191 memory.c
--- linux-2.5/mm/memory.c	16 Nov 2004 03:53:40 -0000	1.191
+++ linux-2.5/mm/memory.c	17 Nov 2004 16:25:26 -0000
@@ -713,7 +713,7 @@ untouched_anonymous_page(struct mm_struc
 
 
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
-		unsigned long start, int len, int write, int force,
+		unsigned long start, unsigned long nr_pages, int write, int force,
 		struct page **pages, struct vm_area_struct **vmas)
 {
 	int i;
@@ -757,17 +757,35 @@ int get_user_pages(struct task_struct *t
 				vmas[i] = gate_vma;
 			i++;
 			start += PAGE_SIZE;
-			len--;
+			nr_pages--;
 			continue;
 		}
 
-		if (!vma || (pages && (vma->vm_flags & VM_IO))
-				|| !(flags & vma->vm_flags))
+		if (!vma || !(flags & vma->vm_flags))
 			return i ? : -EFAULT;
 
+		if (unlikely(vma->vm_flags & VM_IO)) {
+			unsigned long this_page_walk;
+
+			if (pages)
+				return i ? : -EFAULT;
+
+			/*
+			 * If 'pages' is NULL, we'll silenty skip over all VM_IO
+			 * vmas without returning errors.
+			 */
+			this_page_walk = (vma->vm_end - start) >> PAGE_SHIFT;
+			if (this_page_walk > nr_pages)
+				this_page_walk = nr_pages;
+			start = vma->vm_end;
+			nr_pages -= this_page_walk;
+			i += this_page_walk;
+			continue;
+		}
+
 		if (is_vm_hugetlb_page(vma)) {
 			i = follow_hugetlb_page(mm, vma, pages, vmas,
-						&start, &len, i);
+						&start, &nr_pages, i);
 			continue;
 		}
 		spin_lock(&mm->page_table_lock);
@@ -829,10 +847,10 @@ int get_user_pages(struct task_struct *t
 				vmas[i] = vma;
 			i++;
 			start += PAGE_SIZE;
-			len--;
-		} while(len && start < vma->vm_end);
+			nr_pages--;
+		} while(nr_pages && start < vma->vm_end);
 		spin_unlock(&mm->page_table_lock);
-	} while(len);
+	} while(nr_pages);
 out:
 	return i;
 }
@@ -1754,25 +1772,23 @@ out:
 	return pmd_offset(pgd, address);
 }
 
-int make_pages_present(unsigned long addr, unsigned long end)
+void make_pages_present(unsigned long addr, unsigned long end)
 {
-	int ret, len, write;
+	unsigned long len;
+	int write;
 	struct vm_area_struct * vma;
 
 	vma = find_vma(current->mm, addr);
 	if (!vma)
-		return -1;
+		return;
 	write = (vma->vm_flags & VM_WRITE) != 0;
 	if (addr >= end)
 		BUG();
 	if (end > vma->vm_end)
 		BUG();
 	len = (end+PAGE_SIZE-1)/PAGE_SIZE-addr/PAGE_SIZE;
-	ret = get_user_pages(current, current->mm, addr,
-			len, write, 0, NULL, NULL);
-	if (ret < 0)
-		return ret;
-	return ret == len ? 0 : -1;
+	get_user_pages(current, current->mm, addr,
+		       len, write, 0, NULL, NULL);
 }
 
 /* 
Index: linux-2.5/mm/mlock.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/mm/mlock.c,v
retrieving revision 1.16
diff -u -p -r1.16 mlock.c
--- linux-2.5/mm/mlock.c	19 Oct 2004 05:54:02 -0000	1.16
+++ linux-2.5/mm/mlock.c	17 Nov 2004 13:42:26 -0000
@@ -47,7 +47,7 @@ static int mlock_fixup(struct vm_area_st
 	pages = (end - start) >> PAGE_SHIFT;
 	if (newflags & VM_LOCKED) {
 		pages = -pages;
-		ret = make_pages_present(start, end);
+		make_pages_present(start, end);
 	}
 
 	vma->vm_mm->locked_vm -= pages;
