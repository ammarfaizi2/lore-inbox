Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTDUUYw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 16:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTDUUYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 16:24:52 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:49109 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262120AbTDUUYo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 16:24:44 -0400
Message-ID: <3EA4565D.4070302@colorfullife.com>
Date: Mon, 21 Apr 2003 22:36:45 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC, PATCH] fix verify_write for 80386 support
References: <3EA45485.2080500@colorfullife.com>
In-Reply-To: <3EA45485.2080500@colorfullife.com>
Content-Type: multipart/mixed;
 boundary="------------070101090900080901020609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070101090900080901020609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[ 2nd part of the mail, after hitting the send button in the middle of 
the sentence]

The solution is to perform the check for write protection in the actual 
access functions, not during access_ok.

The attached patch does that:
- remove the check from access_ok
- redirect all user space write access into __copy_to_user_ll
- within __copy_to_user_ll: use get_user_pages, and write directly to 
the obtained kernel address.

This fixes all swapout & data corruption bugs, and even removes 26 lines 
from the kernel.

What do you think? The alternative would be to drop support for real 
80386 cpus.

Not tested on a real 80386, I've just replace wp_works_ok with !wp_works_ok.

--
    Manfred


--------------070101090900080901020609
Content-Type: text/plain;
 name="patch-uaccess-386"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-uaccess-386"

 arch/i386/lib/usercopy.c   |   47 ++++++++++++++++++++++++++
 arch/i386/mm/fault.c       |   81 ---------------------------------------------
 include/asm-i386/uaccess.h |   30 +++++++---------
 3 files changed, 61 insertions(+), 97 deletions(-)
// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 68
//  EXTRAVERSION =
--- 2.5/include/asm-i386/uaccess.h	2003-04-20 11:13:45.000000000 +0200
+++ build-2.5/include/asm-i386/uaccess.h	2003-04-20 18:43:38.000000000 +0200
@@ -62,8 +62,6 @@
 		:"1" (addr),"g" ((int)(size)),"g" (current_thread_info()->addr_limit.seg)); \
 	flag; })
 
-#ifdef CONFIG_X86_WP_WORKS_OK
-
 /**
  * access_ok: - Checks if a user space pointer is valid
  * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE.  Note that
@@ -85,14 +83,6 @@
  */
 #define access_ok(type,addr,size) (__range_ok(addr,size) == 0)
 
-#else
-
-#define access_ok(type,addr,size) ( (__range_ok(addr,size) == 0) && \
-			 ((type) == VERIFY_READ || boot_cpu_data.wp_works_ok || \
-			  __verify_write((void *)(addr),(size))))
-
-#endif
-
 /**
  * verify_area: - Obsolete, use access_ok()
  * @type: Type of access: %VERIFY_READ or %VERIFY_WRITE
@@ -191,14 +181,8 @@
 	__ret_gu;							\
 })
 
-extern void __put_user_1(void);
-extern void __put_user_2(void);
-extern void __put_user_4(void);
-extern void __put_user_8(void);
-
 extern void __put_user_bad(void);
 
-
 /**
  * put_user: - Write a simple value into user space.
  * @x:   Value to copy to user space.
@@ -299,6 +283,8 @@
 		: "=r"(err)					\
 		: "A" (x), "r" (addr), "i"(-EFAULT), "0"(err))
 
+#ifdef CONFIG_X86_WP_WORKS_OK
+
 #define __put_user_size(x,ptr,size,retval,errret)			\
 do {									\
 	retval = 0;							\
@@ -311,6 +297,18 @@
 	}								\
 } while (0)
 
+#else
+
+#define __put_user_size(x,ptr,size,retval,errret)			\
+do {									\
+	__typeof__(*(ptr)) __pus_tmp = x;				\
+	retval = 0;							\
+									\
+	if(unlikely(__copy_to_user_ll(ptr, &__pus_tmp, size) != 0))	\
+		retval = errret;					\
+} while (0)
+
+#endif
 struct __large_struct { unsigned long buf[100]; };
 #define __m(x) (*(struct __large_struct *)(x))
 
--- 2.5/arch/i386/mm/fault.c	2003-04-20 11:19:13.000000000 +0200
+++ build-2.5/arch/i386/mm/fault.c	2003-04-20 16:18:16.000000000 +0200
@@ -29,87 +29,6 @@
 
 extern void die(const char *,struct pt_regs *,long);
 
-#ifndef CONFIG_X86_WP_WORKS_OK
-/*
- * Ugly, ugly, but the goto's result in better assembly..
- */
-int __verify_write(const void * addr, unsigned long size)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct * vma;
-	unsigned long start = (unsigned long) addr;
-
-	if (!size || segment_eq(get_fs(),KERNEL_DS))
-		return 1;
-
-	down_read(&mm->mmap_sem);
-	vma = find_vma(current->mm, start);
-	if (!vma)
-		goto bad_area;
-	if (vma->vm_start > start)
-		goto check_stack;
-
-good_area:
-	if (!(vma->vm_flags & VM_WRITE))
-		goto bad_area;
-	size--;
-	size += start & ~PAGE_MASK;
-	size >>= PAGE_SHIFT;
-	start &= PAGE_MASK;
-
-	for (;;) {
-	survive:
-		switch (handle_mm_fault(current->mm, vma, start, 1)) {
-			case VM_FAULT_SIGBUS:
-				goto bad_area;
-			case VM_FAULT_OOM:
-				goto out_of_memory;
-			case VM_FAULT_MINOR:
-			case VM_FAULT_MAJOR:
-				break;
-			default:
-				BUG();
-		}
-		if (!size)
-			break;
-		size--;
-		start += PAGE_SIZE;
-		if (start < vma->vm_end)
-			continue;
-		vma = vma->vm_next;
-		if (!vma || vma->vm_start != start)
-			goto bad_area;
-		if (!(vma->vm_flags & VM_WRITE))
-			goto bad_area;;
-	}
-	/*
-	 * We really need to hold mmap_sem over the whole access to
-	 * userspace, else another thread could change permissions.
-	 * This is unfixable, so don't use i386-class machines for
-	 * critical servers.
-	 */
-	up_read(&mm->mmap_sem);
-	return 1;
-
-check_stack:
-	if (!(vma->vm_flags & VM_GROWSDOWN))
-		goto bad_area;
-	if (expand_stack(vma, start) == 0)
-		goto good_area;
-
-bad_area:
-	up_read(&mm->mmap_sem);
-	return 0;
-
-out_of_memory:
-	if (current->pid == 1) {
-		yield();
-		goto survive;
-	}
-	goto bad_area;
-}
-#endif
-
 /*
  * Unlock any spinlocks which will prevent us from getting the
  * message out 
--- 2.5/arch/i386/lib/usercopy.c	2003-03-25 17:49:34.000000000 +0100
+++ build-2.5/arch/i386/lib/usercopy.c	2003-04-20 19:45:51.000000000 +0200
@@ -6,6 +6,8 @@
  * Copyright 1997 Linus Torvalds
  */
 #include <linux/config.h>
+#include <linux/mm.h>
+#include <linux/highmem.h>
 #include <asm/uaccess.h>
 #include <asm/mmx.h>
 
@@ -483,6 +485,51 @@
 
 unsigned long __copy_to_user_ll(void *to, const void *from, unsigned long n)
 {
+#ifndef CONFIG_X86_WP_WORKS_OK
+	if (unlikely(boot_cpu_data.wp_works_ok == 0) && ((unsigned long )to) < TASK_SIZE) {
+		/* 
+		 * CPU does not honor the WP bit when writing
+		 * from supervisory mode, and due to preemption or SMP,
+		 * the page tables can change at any time.
+		 * Do it manually.	Manfred <manfred@colorfullife.com>
+		 */
+		while (n) {
+		      	unsigned long offset = ((unsigned long)to)%PAGE_SIZE;
+			unsigned long len = PAGE_SIZE - offset;
+			int retval;
+			struct page *pg;
+			void *maddr;
+			
+			if (len > n)
+				len = n;
+
+survive:
+			down_read(&current->mm->mmap_sem);
+			retval = get_user_pages(current, current->mm,
+					(unsigned long )to, 1, 1, 0, &pg, NULL);
+			up_read(&current->mm->mmap_sem);
+
+			if (retval == -ENOMEM && current->pid == 1) {
+				yield();
+				goto survive;
+			}
+
+			if (retval != 1)
+		       		break;
+
+			maddr = kmap(pg);
+			memcpy(maddr + offset, from, len);
+			kunmap(pg);
+			set_page_dirty_lock(pg);
+			put_page(pg);
+
+			from += len;
+			to += len;
+			n -= len;
+		}
+		return n;
+	}
+#endif
 	if (movsl_is_ok(to, from, n))
 		__copy_user(to, from, n);
 	else

--------------070101090900080901020609--

