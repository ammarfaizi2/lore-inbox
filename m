Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262270AbTEIBuo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 21:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbTEIBuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 21:50:44 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:57569 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262270AbTEIBuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 21:50:40 -0400
Date: Thu, 8 May 2003 19:03:12 -0700
Message-Id: <200305090203.h4923CM11039@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
X-Fcc: ~/Mail/linus
Subject: [PATCH] i386 uaccess to fixmap pages
X-Shopping-List: (1) Quaking combustion bag lunches
   (2) Didactic perspiration
   (3) Hilarious distenders
   (4) Heterogeneous coolants
   (5) Lucky reticent Ritz Cracker Crumbs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.5.69 makes uaccess (i.e., access_ok and get/put_user)
to user-accessible fixmap addresses on x86 work.  This is the last missing
piece in restoring the invariant that all kinds of special kernel access
"to user process virtual addresses" do in fact permit exactly all the same
access to all the same addresses that normal loads and stores in the user
process can do.

This is not only a hypothetical concern.  glibc's dynamic linker uses
direct pointers into mapped DSO images for strings such as symbol names and
library soname strings.  When using the vsyscall DSO, these pointers are in
the fixmap area.  To minimize copying and stack use, the dynamic linker
writes debugging messages using writev, where the %s for a string like a
symbol name will be an iovec pointing directly into the mapped image.  In
2.5.69, all such writevs referring to strings in the vsyscall DSO image
fail with EFAULT, and the expected output is elided or mangled.

This patch modifies pervasively used code like access_ok and get_user, so
it looks scary and performance-problematical.  However, the new code is
only in the paths leading to EFAULT, the straight-through code paths should
wholly be unchanged.  So in fact it should not have any performance impact.

I have tested this a fair bit, using system calls like writev and using a
contrivance to test get_user for 1, 2, and 4 byte sizes.  The essential
code that decides what is ok is the same code in my get_user_pages change
that already went in.  This patch pulls most of that code out into a
private function shared by get_user_pages and the new __fixmap_access_ok.

I changed the get_user assembly code only for completeness.  Pragmatically
speaking, that part of the patch can probably be left out without harm.  I
can't off hand think of a real-world case in which someone will need 1/2/4
byte get_user to work with fixmap addresses.  System calls taking
strings/buffers like write are what really matter.


Thanks,
Roland



--- linux-2.5.69/include/asm-i386/uaccess.h.~1~	Sun May  4 16:53:02 2003
+++ linux-2.5.69/include/asm-i386/uaccess.h	Wed May  7 17:20:13 2003
@@ -62,6 +62,8 @@ int __verify_write(const void *, unsigne
 		:"1" (addr),"g" ((int)(size)),"g" (current_thread_info()->addr_limit.seg)); \
 	flag; })
 
+extern int FASTCALL(__fixmap_access_ok(unsigned long, unsigned long, int));
+
 #ifdef CONFIG_X86_WP_WORKS_OK
 
 /**
@@ -83,13 +85,16 @@ int __verify_write(const void *, unsigne
  * checks that the pointer is in the user space range - after calling
  * this function, memory access functions may still return -EFAULT.
  */
-#define access_ok(type,addr,size) (__range_ok(addr,size) == 0)
+#define access_ok(type,addr,size) (__range_ok(addr,size) == 0 || \
+				   __fixmap_access_ok((unsigned long)(addr), \
+						      (size), (type)))
 
 #else
 
-#define access_ok(type,addr,size) ( (__range_ok(addr,size) == 0) && \
+#define access_ok(type,addr,size) ((__range_ok(addr,size) == 0) ? \
 			 ((type) == VERIFY_READ || boot_cpu_data.wp_works_ok || \
-			  __verify_write((void *)(addr),(size))))
+			  __verify_write((void *)(addr),(size))) : \
+			  __fixmap_access_ok((unsigned long)(addr),size,type))
 
 #endif
 
@@ -191,10 +196,6 @@ extern void __get_user_4(void);
 	__ret_gu;							\
 })
 
-extern void __put_user_1(void);
-extern void __put_user_2(void);
-extern void __put_user_4(void);
-extern void __put_user_8(void);
 
 extern void __put_user_bad(void);
 
--- linux-2.5.69/arch/i386/lib/getuser.S.~1~	Sun May  4 16:52:49 2003
+++ linux-2.5.69/arch/i386/lib/getuser.S	Wed May  7 17:34:47 2003
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
@@ -53,10 +59,27 @@ __get_user_4:
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
+	xorl %ecx,%ecx	/* VERIFY_READ == 0 */
+	call __fixmap_access_ok
+	testl %eax,%eax
+	popl %ecx
+	popl %eax
+	jz 0f
+	ret
+0:	popl %eax	/* eat return address pushed by __get_user_N */
 
 bad_get_user:
 	xorl %edx,%edx
--- linux-2.5.69/mm/memory.c.~1~	Sun May  4 16:53:14 2003
+++ linux-2.5.69/mm/memory.c	Thu May  8 15:56:16 2003
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
+int __fixmap_access_ok(unsigned long addr, unsigned long size, int type)
+{
+	unsigned long limit = addr + size;
+	if (limit < addr)
+		return 0;
+	if (addr < FIXADDR_START || limit > FIXADDR_TOP)
+		return 0;
+	do {
+		if (!fixmap_page_ok(addr, type == VERIFY_WRITE, NULL))
+			return 0;
+		addr += PAGE_SIZE;
+	} while (addr < limit);
+	return 1;
+}
+
+EXPORT_SYMBOL(__fixmap_access_ok);
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
