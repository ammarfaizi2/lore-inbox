Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbTEIKak (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 06:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbTEIKaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 06:30:39 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:13165 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262355AbTEIKag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 06:30:36 -0400
Date: Fri, 9 May 2003 03:43:07 -0700
Message-Id: <200305091043.h49Ah7Z24822@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@digeo.com>
X-Fcc: ~/Mail/linus
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 uaccess to fixmap pages
In-Reply-To: Andrew Morton's message of  Friday, 9 May 2003 02:19:21 -0700 <20030509021921.166f82fc.akpm@digeo.com>
X-Antipastobozoticataclysm: Bariumenemanilow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's an updated version of the patch.  Since the support for 386s without
WP support seems to be gone, I shaved an instruction here and there by not
passing the read/write flag to the helper function.  

Btw, in my build (gcc 3.2-rh, -O2, a $100 processor from last year so the
kernel build is plenty fast) the text size overhead is less than 0.5%,
which is to say 11kb (but my configuration is somewhat minimal so you may
be compiling in many more access_ok calls).


Thanks,
Roland


--- linux-2.5.69-1.1083/include/asm-i386/uaccess.h.orig	Fri May  9 03:07:15 2003
+++ linux-2.5.69-1.1083/include/asm-i386/uaccess.h	Fri May  9 03:25:16 2003
@@ -43,6 +43,7 @@ extern struct movsl_mask {
 #endif
 
 int __verify_write(const void *, unsigned long);
+int FASTCALL(__fixmap_range_ok(unsigned long, unsigned long));
 
 #define __addr_ok(addr) ((unsigned long)(addr) < (current_thread_info()->addr_limit.seg))
 
@@ -81,7 +82,9 @@ int __verify_write(const void *, unsigne
  * checks that the pointer is in the user space range - after calling
  * this function, memory access functions may still return -EFAULT.
  */
-#define access_ok(type,addr,size) (__range_ok(addr,size) == 0)
+#define access_ok(type,addr,size) (__range_ok(addr,size) == 0 || \
+ 				   __fixmap_range_ok((unsigned long)(addr), \
+						     (size)))
 
 /**
  * verify_area: - Obsolete, use access_ok()
--- linux-2.5.69/arch/i386/lib/getuser.S.~1~	Sun May  4 16:52:49 2003
+++ linux-2.5.69-1.1083/arch/i386/lib/getuser.S	Fri May  9 03:24:30 2003
@@ -29,10 +29,13 @@
 __get_user_1:
 	GET_THREAD_INFO(%edx)
 	cmpl TI_ADDR_LIMIT(%edx),%eax
-	jae bad_get_user
+	jae 0f
 1:	movzbl (%eax),%edx
 	xorl %eax,%eax
 	ret
+0:	pushl $1b
+	xorl %edx,%edx
+	jmp get_user_check_fixmap
 
 .align 4
 .globl __get_user_2
@@ -41,10 +44,13 @@ __get_user_2:
 	jc bad_get_user
 	GET_THREAD_INFO(%edx)
 	cmpl TI_ADDR_LIMIT(%edx),%eax
-	jae bad_get_user
+	jae 0f
 2:	movzwl -1(%eax),%edx
 	xorl %eax,%eax
 	ret
+0:	pushl $2b
+	movl $1,%edx
+	jmp get_user_check_fixmap
 
 .align 4
 .globl __get_user_4
@@ -53,10 +59,26 @@ __get_user_4:
 	jc bad_get_user
 	GET_THREAD_INFO(%edx)
 	cmpl TI_ADDR_LIMIT(%edx),%eax
-	jae bad_get_user
+	jae 0f
 3:	movl -3(%eax),%edx
 	xorl %eax,%eax
 	ret
+0:	pushl $3b
+	movl $3,%edx
+/*	jmp get_user_check_fixmap */
+
+get_user_check_fixmap:
+	pushl %eax
+	pushl %ecx
+	subl %edx,%eax	/* undo address bias, %eax = addr */
+	incl %edx	/* bump bias to size, %edx = size */
+	call __fixmap_range_ok
+	testl %eax,%eax
+	popl %ecx
+	popl %eax
+	jz 0f
+	ret
+0:	popl %eax	/* eat return address pushed by __get_user_N */
 
 bad_get_user:
 	xorl %edx,%edx
--- linux-2.5.69/mm/memory.c.~1~	Sun May  4 16:53:14 2003
+++ linux-2.5.69-1.1083/mm/memory.c	Fri May  9 03:23:33 2003
@@ -45,6 +45,7 @@
 #include <linux/pagemap.h>
 #include <linux/vcache.h>
 #include <linux/rmap-locking.h>
+#include <linux/module.h>
 
 #include <asm/pgalloc.h>
 #include <asm/rmap.h>
@@ -669,6 +670,50 @@ static inline struct page *get_page_map(
 }
 
 
+#ifdef FIXADDR_START
+static int fixmap_page_ok(unsigned long addr, int write, struct page **pagep)
+{
+	unsigned long pg = addr & PAGE_MASK;
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+	pgd = pgd_offset_k(pg);
+	if (!pgd)
+		return 0;
+	pmd = pmd_offset(pgd, pg);
+	if (!pmd)
+		return 0;
+	pte = pte_offset_kernel(pmd, pg);
+	if (!pte || !pte_present(*pte) || !pte_user(*pte) ||
+	    !(write ? pte_write(*pte) : pte_read(*pte)))
+		return 0;
+
+	if (pagep) {
+		*pagep = pte_page(*pte);
+		get_page(*pagep);
+	}
+	return 1;
+}
+
+int __fixmap_range_ok(unsigned long addr, unsigned long size)
+{
+	unsigned long limit = addr + size;
+	if (limit < addr)
+		return 0;
+	if (addr < FIXADDR_START || limit > FIXADDR_TOP)
+		return 0;
+	do {
+		if (!fixmap_page_ok(addr, 0, NULL))
+			return 0;
+		addr += PAGE_SIZE;
+	} while (addr < limit);
+	return 1;
+}
+
+EXPORT_SYMBOL(__fixmap_range_ok);
+#endif
+
+
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 		unsigned long start, int len, int write, int force,
 		struct page **pages, struct vm_area_struct **vmas)
@@ -701,24 +746,9 @@ int get_user_pages(struct task_struct *t
 				.vm_page_prot = PAGE_READONLY,
 				.vm_flags = VM_READ | VM_EXEC,
 			};
-			unsigned long pg = start & PAGE_MASK;
-			pgd_t *pgd;
-			pmd_t *pmd;
-			pte_t *pte;
-			pgd = pgd_offset_k(pg);
-			if (!pgd)
-				return i ? : -EFAULT;
-			pmd = pmd_offset(pgd, pg);
-			if (!pmd)
-				return i ? : -EFAULT;
-			pte = pte_offset_kernel(pmd, pg);
-			if (!pte || !pte_present(*pte) || !pte_user(*pte) ||
-			    !(write ? pte_write(*pte) : pte_read(*pte)))
+			if (!fixmap_page_ok(start, write,
+					    pages ? &pages[i] : NULL))
 				return i ? : -EFAULT;
-			if (pages) {
-				pages[i] = pte_page(*pte);
-				get_page(pages[i]);
-			}
 			if (vmas)
 				vmas[i] = &fixmap_vma;
 			i++;
