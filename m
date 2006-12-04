Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936983AbWLDO7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936983AbWLDO7x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936957AbWLDO4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:56:09 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:6165 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936956AbWLDOze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:55:34 -0500
Date: Mon, 4 Dec 2006 15:55:27 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, geraldsc@de.ibm.com
Subject: [S390] Add dynamic size check for usercopy functions.
Message-ID: <20061204145527.GX32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <geraldsc@de.ibm.com>

[S390] Add dynamic size check for usercopy functions.

Use a wrapper for copy_to/from_user to chose the best usercopy method.
The mvcos instruction is better for sizes greater than 256 bytes, if
mvcos is not available a page table walk is better for sizes greater
than 1024 bytes. Also removed the redundant copy_to/from_user_std_small
functions.

Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/lib/Makefile        |    2 
 arch/s390/lib/uaccess_mvcos.c |   27 +++++--
 arch/s390/lib/uaccess_pt.c    |  153 ++++++++++++++++++++++++++++++++++++++++++
 arch/s390/lib/uaccess_std.c   |   67 ++++--------------
 4 files changed, 190 insertions(+), 59 deletions(-)

diff -urpN linux-2.6/arch/s390/lib/Makefile linux-2.6-patched/arch/s390/lib/Makefile
--- linux-2.6/arch/s390/lib/Makefile	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/lib/Makefile	2006-12-04 14:50:56.000000000 +0100
@@ -4,7 +4,7 @@
 
 EXTRA_AFLAGS := -traditional
 
-lib-y += delay.o string.o uaccess_std.o
+lib-y += delay.o string.o uaccess_std.o uaccess_pt.o
 lib-$(CONFIG_32BIT) += div64.o
 lib-$(CONFIG_64BIT) += uaccess_mvcos.o
 lib-$(CONFIG_SMP) += spinlock.o
diff -urpN linux-2.6/arch/s390/lib/uaccess_mvcos.c linux-2.6-patched/arch/s390/lib/uaccess_mvcos.c
--- linux-2.6/arch/s390/lib/uaccess_mvcos.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/lib/uaccess_mvcos.c	2006-12-04 14:50:56.000000000 +0100
@@ -27,6 +27,9 @@
 #define SLR	"slgr"
 #endif
 
+extern size_t copy_from_user_std(size_t, const void __user *, void *);
+extern size_t copy_to_user_std(size_t, void __user *, const void *);
+
 size_t copy_from_user_mvcos(size_t size, const void __user *ptr, void *x)
 {
 	register unsigned long reg0 asm("0") = 0x81UL;
@@ -66,6 +69,13 @@ size_t copy_from_user_mvcos(size_t size,
 	return size;
 }
 
+size_t copy_from_user_mvcos_check(size_t size, const void __user *ptr, void *x)
+{
+	if (size <= 256)
+		return copy_from_user_std(size, ptr, x);
+	return copy_from_user_mvcos(size, ptr, x);
+}
+
 size_t copy_to_user_mvcos(size_t size, void __user *ptr, const void *x)
 {
 	register unsigned long reg0 asm("0") = 0x810000UL;
@@ -95,6 +105,13 @@ size_t copy_to_user_mvcos(size_t size, v
 	return size;
 }
 
+size_t copy_to_user_mvcos_check(size_t size, void __user *ptr, const void *x)
+{
+	if (size <= 256)
+		return copy_to_user_std(size, ptr, x);
+	return copy_to_user_mvcos(size, ptr, x);
+}
+
 size_t copy_in_user_mvcos(size_t size, void __user *to, const void __user *from)
 {
 	register unsigned long reg0 asm("0") = 0x810081UL;
@@ -145,18 +162,16 @@ size_t clear_user_mvcos(size_t size, voi
 	return size;
 }
 
-extern size_t copy_from_user_std_small(size_t, const void __user *, void *);
-extern size_t copy_to_user_std_small(size_t, void __user *, const void *);
 extern size_t strnlen_user_std(size_t, const char __user *);
 extern size_t strncpy_from_user_std(size_t, const char __user *, char *);
 extern int futex_atomic_op(int, int __user *, int, int *);
 extern int futex_atomic_cmpxchg(int __user *, int, int);
 
 struct uaccess_ops uaccess_mvcos = {
-	.copy_from_user = copy_from_user_mvcos,
-	.copy_from_user_small = copy_from_user_std_small,
-	.copy_to_user = copy_to_user_mvcos,
-	.copy_to_user_small = copy_to_user_std_small,
+	.copy_from_user = copy_from_user_mvcos_check,
+	.copy_from_user_small = copy_from_user_std,
+	.copy_to_user = copy_to_user_mvcos_check,
+	.copy_to_user_small = copy_to_user_std,
 	.copy_in_user = copy_in_user_mvcos,
 	.clear_user = clear_user_mvcos,
 	.strnlen_user = strnlen_user_std,
diff -urpN linux-2.6/arch/s390/lib/uaccess_pt.c linux-2.6-patched/arch/s390/lib/uaccess_pt.c
--- linux-2.6/arch/s390/lib/uaccess_pt.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/lib/uaccess_pt.c	2006-12-04 14:50:56.000000000 +0100
@@ -0,0 +1,153 @@
+/*
+ *  arch/s390/lib/uaccess_pt.c
+ *
+ *  User access functions based on page table walks.
+ *
+ *    Copyright IBM Corp. 2006
+ *    Author(s): Gerald Schaefer (gerald.schaefer@de.ibm.com)
+ */
+
+#include <linux/errno.h>
+#include <asm/uaccess.h>
+#include <linux/mm.h>
+#include <asm/futex.h>
+
+static inline int __handle_fault(struct mm_struct *mm, unsigned long address,
+				 int write_access)
+{
+	struct vm_area_struct *vma;
+	int ret = -EFAULT;
+
+	down_read(&mm->mmap_sem);
+	vma = find_vma(mm, address);
+	if (unlikely(!vma))
+		goto out;
+	if (unlikely(vma->vm_start > address)) {
+		if (!(vma->vm_flags & VM_GROWSDOWN))
+			goto out;
+		if (expand_stack(vma, address))
+			goto out;
+	}
+
+	if (!write_access) {
+		/* page not present, check vm flags */
+		if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
+			goto out;
+	} else {
+		if (!(vma->vm_flags & VM_WRITE))
+			goto out;
+	}
+
+survive:
+	switch (handle_mm_fault(mm, vma, address, write_access)) {
+	case VM_FAULT_MINOR:
+		current->min_flt++;
+		break;
+	case VM_FAULT_MAJOR:
+		current->maj_flt++;
+		break;
+	case VM_FAULT_SIGBUS:
+		goto out_sigbus;
+	case VM_FAULT_OOM:
+		goto out_of_memory;
+	default:
+		BUG();
+	}
+	ret = 0;
+out:
+	up_read(&mm->mmap_sem);
+	return ret;
+
+out_of_memory:
+	up_read(&mm->mmap_sem);
+	if (current->pid == 1) {
+		yield();
+		goto survive;
+	}
+	printk("VM: killing process %s\n", current->comm);
+	return ret;
+
+out_sigbus:
+	up_read(&mm->mmap_sem);
+	current->thread.prot_addr = address;
+	current->thread.trap_no = 0x11;
+	force_sig(SIGBUS, current);
+	return ret;
+}
+
+static inline size_t __user_copy_pt(unsigned long uaddr, void *kptr,
+				    size_t n, int write_user)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long offset, pfn, done, size;
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+	void *from, *to;
+
+	done = 0;
+retry:
+	spin_lock(&mm->page_table_lock);
+	do {
+		pgd = pgd_offset(mm, uaddr);
+		if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
+			goto fault;
+
+		pmd = pmd_offset(pgd, uaddr);
+		if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
+			goto fault;
+
+		pte = pte_offset_map(pmd, uaddr);
+		if (!pte || !pte_present(*pte) ||
+		    (write_user && !pte_write(*pte)))
+			goto fault;
+
+		pfn = pte_pfn(*pte);
+		if (!pfn_valid(pfn))
+			goto out;
+
+		offset = uaddr & (PAGE_SIZE - 1);
+		size = min(n - done, PAGE_SIZE - offset);
+		if (write_user) {
+			to = (void *)((pfn << PAGE_SHIFT) + offset);
+			from = kptr + done;
+		} else {
+			from = (void *)((pfn << PAGE_SHIFT) + offset);
+			to = kptr + done;
+		}
+		memcpy(to, from, size);
+		done += size;
+		uaddr += size;
+	} while (done < n);
+out:
+	spin_unlock(&mm->page_table_lock);
+	return n - done;
+fault:
+	spin_unlock(&mm->page_table_lock);
+	if (__handle_fault(mm, uaddr, write_user))
+		return n - done;
+	goto retry;
+}
+
+size_t copy_from_user_pt(size_t n, const void __user *from, void *to)
+{
+	size_t rc;
+
+	if (segment_eq(get_fs(), KERNEL_DS)) {
+		memcpy(to, (void __kernel __force *) from, n);
+		return 0;
+	}
+	rc = __user_copy_pt((unsigned long) from, to, n, 0);
+	if (unlikely(rc))
+		memset(to + n - rc, 0, rc);
+	return rc;
+}
+
+size_t copy_to_user_pt(size_t n, void __user *to, const void *from)
+{
+	if (segment_eq(get_fs(), KERNEL_DS)) {
+		memcpy((void __kernel __force *) to, from, n);
+		return 0;
+	}
+	return __user_copy_pt((unsigned long) to, (void *) from, n, 1);
+}
diff -urpN linux-2.6/arch/s390/lib/uaccess_std.c linux-2.6-patched/arch/s390/lib/uaccess_std.c
--- linux-2.6/arch/s390/lib/uaccess_std.c	2006-11-29 22:57:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/lib/uaccess_std.c	2006-12-04 14:50:56.000000000 +0100
@@ -28,6 +28,9 @@
 #define SLR	"slgr"
 #endif
 
+extern size_t copy_from_user_pt(size_t n, const void __user *from, void *to);
+extern size_t copy_to_user_pt(size_t n, void __user *to, const void *from);
+
 size_t copy_from_user_std(size_t size, const void __user *ptr, void *x)
 {
 	unsigned long tmp1, tmp2;
@@ -69,34 +72,11 @@ size_t copy_from_user_std(size_t size, c
 	return size;
 }
 
-size_t copy_from_user_std_small(size_t size, const void __user *ptr, void *x)
+size_t copy_from_user_std_check(size_t size, const void __user *ptr, void *x)
 {
-	unsigned long tmp1, tmp2;
-
-	tmp1 = 0UL;
-	asm volatile(
-		"0: mvcp  0(%0,%2),0(%1),%3\n"
-		"  "SLR"  %0,%0\n"
-		"   j     5f\n"
-		"1: la    %4,255(%1)\n" /* %4 = ptr + 255 */
-		"  "LHI"  %3,-4096\n"
-		"   nr    %4,%3\n"	/* %4 = (ptr + 255) & -4096 */
-		"  "SLR"  %4,%1\n"
-		"  "CLR"  %0,%4\n"	/* copy crosses next page boundary? */
-		"   jnh   5f\n"
-		"2: mvcp  0(%4,%2),0(%1),%3\n"
-		"  "SLR"  %0,%4\n"
-		"  "ALR"  %2,%4\n"
-		"3:"LHI"  %4,-1\n"
-		"  "ALR"  %4,%0\n"	/* copy remaining size, subtract 1 */
-		"   bras  %3,4f\n"
-		"   xc    0(1,%2),0(%2)\n"
-		"4: ex    %4,0(%3)\n"
-		"5:\n"
-		EX_TABLE(0b,1b) EX_TABLE(2b,3b)
-		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
-		: : "cc", "memory");
-	return size;
+	if (size <= 1024)
+		return copy_from_user_std(size, ptr, x);
+	return copy_from_user_pt(size, ptr, x);
 }
 
 size_t copy_to_user_std(size_t size, void __user *ptr, const void *x)
@@ -130,28 +110,11 @@ size_t copy_to_user_std(size_t size, voi
 	return size;
 }
 
-size_t copy_to_user_std_small(size_t size, void __user *ptr, const void *x)
+size_t copy_to_user_std_check(size_t size, void __user *ptr, const void *x)
 {
-	unsigned long tmp1, tmp2;
-
-	tmp1 = 0UL;
-	asm volatile(
-		"0: mvcs  0(%0,%1),0(%2),%3\n"
-		"  "SLR"  %0,%0\n"
-		"   j     3f\n"
-		"1: la    %4,255(%1)\n" /* ptr + 255 */
-		"  "LHI"  %3,-4096\n"
-		"   nr    %4,%3\n"	/* (ptr + 255) & -4096UL */
-		"  "SLR"  %4,%1\n"
-		"  "CLR"  %0,%4\n"	/* copy crosses next page boundary? */
-		"   jnh   3f\n"
-		"2: mvcs  0(%4,%1),0(%2),%3\n"
-		"  "SLR"  %0,%4\n"
-		"3:\n"
-		EX_TABLE(0b,1b) EX_TABLE(2b,3b)
-		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
-		: : "cc", "memory");
-	return size;
+	if (size <= 1024)
+		return copy_to_user_std(size, ptr, x);
+	return copy_to_user_pt(size, ptr, x);
 }
 
 size_t copy_in_user_std(size_t size, void __user *to, const void __user *from)
@@ -343,10 +306,10 @@ int futex_atomic_cmpxchg(int __user *uad
 }
 
 struct uaccess_ops uaccess_std = {
-	.copy_from_user = copy_from_user_std,
-	.copy_from_user_small = copy_from_user_std_small,
-	.copy_to_user = copy_to_user_std,
-	.copy_to_user_small = copy_to_user_std_small,
+	.copy_from_user = copy_from_user_std_check,
+	.copy_from_user_small = copy_from_user_std,
+	.copy_to_user = copy_to_user_std_check,
+	.copy_to_user_small = copy_to_user_std,
 	.copy_in_user = copy_in_user_std,
 	.clear_user = clear_user_std,
 	.strnlen_user = strnlen_user_std,
