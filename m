Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261743AbSJMUHT>; Sun, 13 Oct 2002 16:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261748AbSJMUHT>; Sun, 13 Oct 2002 16:07:19 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:46018 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S261743AbSJMUHK>; Sun, 13 Oct 2002 16:07:10 -0400
Message-ID: <3DA9D3EF.9030000@quark.didntduck.org>
Date: Sun, 13 Oct 2002 16:13:35 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386 __verify_write fixes
Content-Type: multipart/mixed;
 boundary="------------070808050207010002070106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070808050207010002070106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch does a few cleanups/fixes with __verify_write:
- Only comile it when needed.
- Move test for KERNEL_DS out of line.
- The mmap semaphore is needed to access the vma list.
- Use fixmap for the WP test.
- Removes an obsolete comment in fixmap.h

In addion, I've found a possible bug with writes to userspace on real 
386's.  Without holding the mmap semaphore, it is possible to get 
preempted or go to sleep on a page fault, and then have another thread 
mark the page read-only.  A 386 would continue to write to the page when 
the first thread woke up again.  We need to prevent anyone from changing 
the page permissions until we are done writing to userspace.  My 
suggestion is to replace access_ok() with begin_user_{read,write}(), and 
add end_user_{read,write}().  Thoughs?

--
				Brian Gerst

--------------070808050207010002070106
Content-Type: text/plain;
 name="verify_write-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="verify_write-1"

diff -ruN linux-2.5.42/arch/i386/kernel/i386_ksyms.c linux/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.42/arch/i386/kernel/i386_ksyms.c	Fri Oct 11 22:51:08 2002
+++ linux/arch/i386/kernel/i386_ksyms.c	Sat Oct 12 10:42:36 2002
@@ -69,7 +69,9 @@
 #ifdef CONFIG_X86_NUMAQ
 EXPORT_SYMBOL(xquad_portio);
 #endif
+#ifndef CONFIG_X86_WP_WORKS_OK
 EXPORT_SYMBOL(__verify_write);
+#endif
 EXPORT_SYMBOL(dump_thread);
 EXPORT_SYMBOL(dump_fpu);
 EXPORT_SYMBOL(dump_extended_fpu);
diff -ruN linux-2.5.42/arch/i386/mm/fault.c linux/arch/i386/mm/fault.c
--- linux-2.5.42/arch/i386/mm/fault.c	Fri Oct 11 22:51:06 2002
+++ linux/arch/i386/mm/fault.c	Sat Oct 12 11:11:03 2002
@@ -30,17 +30,20 @@
 
 extern int console_loglevel;
 
+#ifndef CONFIG_X86_WP_WORKS_OK
 /*
  * Ugly, ugly, but the goto's result in better assembly..
  */
 int __verify_write(const void * addr, unsigned long size)
 {
+	struct mm_struct *mm = current->mm;
 	struct vm_area_struct * vma;
 	unsigned long start = (unsigned long) addr;
 
-	if (!size)
+	if (!size || segment_eq(get_fs(),KERNEL_DS))
 		return 1;
 
+	down_read(&mm->mmap_sem);
 	vma = find_vma(current->mm, start);
 	if (!vma)
 		goto bad_area;
@@ -80,6 +83,11 @@
 		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;;
 	}
+	/* FIXME:
+	 * We really need to hold mmap_sem over the whole access to
+	 * userspace, else another thread could change permissions.
+	 */
+	up_read(&mm->mmap_sem);
 	return 1;
 
 check_stack:
@@ -89,6 +97,7 @@
 		goto good_area;
 
 bad_area:
+	up_read(&mm->mmap_sem);
 	return 0;
 
 out_of_memory:
@@ -98,6 +107,7 @@
 	}
 	goto bad_area;
 }
+#endif
 
 /*
  * Unlock any spinlocks which will prevent us from getting the
diff -ruN linux-2.5.42/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux-2.5.42/arch/i386/mm/init.c	Sat Oct 12 00:44:41 2002
+++ linux/arch/i386/mm/init.c	Sat Oct 12 10:17:21 2002
@@ -378,15 +378,10 @@
  * This function cannot be __init, since exceptions don't work in that
  * section.
  */
-static int do_test_wp_bit(unsigned long vaddr);
+static int do_test_wp_bit(void);
 
 void __init test_wp_bit(void)
 {
-	const unsigned long vaddr = PAGE_OFFSET;
-	pgd_t *pgd;
-	pmd_t *pmd;
-	pte_t *pte, old_pte;
-
 	if (cpu_has_pse) {
 		/* Ok, all PSE-capable CPUs are definitely handling the WP bit right. */
 		boot_cpu_data.wp_works_ok = 1;
@@ -395,17 +390,10 @@
 
 	printk("Checking if this processor honours the WP bit even in supervisor mode... ");
 
-	pgd = swapper_pg_dir + __pgd_offset(vaddr);
-	pmd = pmd_offset(pgd, vaddr);
-	pte = pte_offset_kernel(pmd, vaddr);
-	old_pte = *pte;
-	*pte = pfn_pte(0, PAGE_READONLY);
-	local_flush_tlb();
-
-	boot_cpu_data.wp_works_ok = do_test_wp_bit(vaddr);
-
-	*pte = old_pte;
-	local_flush_tlb();
+	/* Any page-aligned address will do, the test is non-destructive */
+	__set_fixmap(FIX_WP_TEST, __pa(&swapper_pg_dir), PAGE_READONLY);
+	boot_cpu_data.wp_works_ok = do_test_wp_bit();
+	clear_fixmap(FIX_WP_TEST);
 
 	if (!boot_cpu_data.wp_works_ok) {
 		printk("No.\n");
@@ -550,7 +538,7 @@
 #endif
 
 /* Put this after the callers, so that it cannot be inlined */
-static int do_test_wp_bit(unsigned long vaddr)
+static int do_test_wp_bit(void)
 {
 	char tmp_reg;
 	int flag;
@@ -564,7 +552,7 @@
 		"	.align 4	\n"
 		"	.long 1b,2b	\n"
 		".previous		\n"
-		:"=m" (*(char *) vaddr),
+		:"=m" (*(char *)fix_to_virt(FIX_WP_TEST)),
 		 "=q" (tmp_reg),
 		 "=r" (flag)
 		:"2" (1)
diff -ruN linux-2.5.42/arch/i386/mm/ioremap.c linux/arch/i386/mm/ioremap.c
--- linux-2.5.42/arch/i386/mm/ioremap.c	Sun Sep 15 22:18:24 2002
+++ linux/arch/i386/mm/ioremap.c	Sat Oct 12 10:17:21 2002
@@ -289,7 +289,7 @@
 
 	idx = FIX_BTMAP_BEGIN;
 	while (nrpages > 0) {
-		__set_fixmap(idx, 0, __pgprot(0));
+		clear_fixmap(idx);
 		--idx;
 		--nrpages;
 	}
diff -ruN linux-2.5.42/include/asm-i386/fixmap.h linux/include/asm-i386/fixmap.h
--- linux-2.5.42/include/asm-i386/fixmap.h	Sat Oct 12 00:44:45 2002
+++ linux/include/asm-i386/fixmap.h	Sat Oct 12 10:17:21 2002
@@ -27,7 +27,7 @@
  * Here we define all the compile-time 'special' virtual
  * addresses. The point is to have a constant address at
  * compile time, but to set the physical address only
- * in the boot process. We allocate these special  addresses
+ * in the boot process. We allocate these special addresses
  * from the end of virtual memory (0xfffff000) backwards.
  * Also this lets us do fail-safe vmalloc(), we
  * can guarantee that these special addresses and
@@ -41,13 +41,6 @@
  * TLB entries of such buffers will not be flushed across
  * task switches.
  */
-
-/*
- * on UP currently we will have no trace of the fixmap mechanizm,
- * no page table allocations, etc. This might change in the
- * future, say framebuffers for the console driver(s) could be
- * fix-mapped?
- */
 enum fixed_addresses {
 #ifdef CONFIG_X86_LOCAL_APIC
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
@@ -81,6 +74,7 @@
 #define NR_FIX_BTMAPS	16
 	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
 	FIX_BTMAP_BEGIN = FIX_BTMAP_END + NR_FIX_BTMAPS - 1,
+	FIX_WP_TEST,
 	__end_of_fixed_addresses
 };
 
@@ -94,6 +88,10 @@
  */
 #define set_fixmap_nocache(idx, phys) \
 		__set_fixmap(idx, phys, PAGE_KERNEL_NOCACHE)
+
+#define clear_fixmap(idx) \
+		__set_fixmap(idx, 0, __pgprot(0))
+
 /*
  * used by vmalloc.c.
  *
diff -ruN linux-2.5.42/include/asm-i386/uaccess.h linux/include/asm-i386/uaccess.h
--- linux-2.5.42/include/asm-i386/uaccess.h	Sun Sep 15 22:18:21 2002
+++ linux/include/asm-i386/uaccess.h	Sat Oct 12 10:18:15 2002
@@ -55,7 +55,6 @@
 
 #define access_ok(type,addr,size) ( (__range_ok(addr,size) == 0) && \
 			 ((type) == VERIFY_READ || boot_cpu_data.wp_works_ok || \
-			 segment_eq(get_fs(),KERNEL_DS) || \
 			  __verify_write((void *)(addr),(size))))
 
 #endif

--------------070808050207010002070106--

