Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUGBN7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUGBN7s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 09:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264560AbUGBN7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 09:59:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:25769 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264542AbUGBN6f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 09:58:35 -0400
Date: Fri, 2 Jul 2004 10:50:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [patch] i386 nx prefetch fix & cleanups, 2.6.7-mm5
Message-ID: <20040702085023.GA22285@elte.hu>
References: <20040630013824.GA24665@mail.shareable.org> <20040630055041.GA16320@elte.hu> <20040630143850.GF29285@mail.shareable.org> <20040701014818.GE32560@mail.shareable.org> <20040701063237.GA16166@elte.hu> <20040701150430.GB5114@mail.shareable.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20040701150430.GB5114@mail.shareable.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Jamie Lokier <jamie@shareable.org> wrote:

> > +	if (nx_enabled && (error_code & 16))
> > +		printk(KERN_CRIT "kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n", current->uid);
> 
> According to AMD's manual, bit 4 of error_code means the fault was due
> to an instruction fetch.  It doesn't imply that it's an NX-protected
> page: it might be a page not present fault instead.  (The manual
> doesn't spell that out, it just says the bit is set when it's an
> instruction fetch).
> 
> Just so you realise that the above code fragments aren't logically
> equivalent.

i've attached an updated nx-prefetch-fix.patch that properly fixes this. 
I've also attached a delta relative to the previous patch. This patch
will only print the 'possible exploit' warning if the kernel tries to
execute a present page. (hence not printing the message in the quite
common jump-to-address-zero crash case.)

I've test-compiled and test-booted the full patch on 2.6.7-mm5 using the
following x86 kernel configs: SMP+PAE, UP+PAE, SMP+!PAE, UP+!PAE, on an
SMP P3 and an Athlon64 box. I've tested various types of
instruction-fetch related kernel faults on the Athlon64 box, it all
works fine.

The full changelog:

- fix possible prefetch-fault loop on NX page, based on suggestions
  from Jamie Lokier.

- clean up nx feature dependencies

- simplify detection of NX-violations when the kernel executes code

- introduce pte_exec_kern() to simplify the NX logic

- split the definitions out of pgtable-[23]level.h into
  pgtable-[23]level-defs.h, to enable the former to use generic
  pte functions from pgtable.h.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nx-prefetch-fix.patch"


- fix possible prefetch-fault loop on NX page, based on suggestions
  from Jamie Lokier.

- clean up nx feature dependencies

- simplify detection of NX-violations when the kernel executes code

- introduce pte_exec_kern() to simplify the NX logic

- split the definitions out of pgtable-[23]level.h into
  pgtable-[23]level-defs.h, to enable the former to use generic
  pte functions from pgtable.h.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/mm/fault.c.orig	
+++ linux/arch/i386/mm/fault.c	
@@ -188,11 +188,16 @@ static int __is_prefetch(struct pt_regs 
 	return prefetch;
 }
 
-static inline int is_prefetch(struct pt_regs *regs, unsigned long addr)
+static inline int is_prefetch(struct pt_regs *regs, unsigned long addr,
+			      unsigned long error_code)
 {
 	if (unlikely(boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
-		     boot_cpu_data.x86 >= 6))
+		     boot_cpu_data.x86 >= 6)) {
+		/* Catch an obscure case of prefetch inside an NX page. */
+		if (nx_enabled && (error_code & 16))
+			return 0;
 		return __is_prefetch(regs, addr);
+	}
 	return 0;
 } 
 
@@ -374,7 +379,7 @@ bad_area_nosemaphore:
 		 * Valid to do another page fault here because this one came 
 		 * from user space.
 		 */
-		if (is_prefetch(regs, address))
+		if (is_prefetch(regs, address, error_code))
 			return;
 
 		tsk->thread.cr2 = address;
@@ -415,7 +420,7 @@ no_context:
 	 * had been triggered by is_prefetch fixup_exception would have 
 	 * handled it.
 	 */
- 	if (is_prefetch(regs, address))
+ 	if (is_prefetch(regs, address, error_code))
  		return;
 
 /*
@@ -432,18 +437,11 @@ no_context:
 	bust_spinlocks(1);
 
 #ifdef CONFIG_X86_PAE
-	{
-		pgd_t *pgd;
-		pmd_t *pmd;
-
+	if (error_code & 16) {
+		pte_t *pte = lookup_address(address);
 
-
-		pgd = init_mm.pgd + pgd_index(address);
-		if (pgd_present(*pgd)) {
-			pmd = pmd_offset(pgd, address);
-			if (pmd_val(*pmd) & _PAGE_NX)
-				printk(KERN_CRIT "kernel tried to access NX-protected page - exploit attempt? (uid: %d)\n", current->uid);
-		}
+		if (pte && pte_present(*pte) && !pte_exec_kernel(*pte))
+			printk(KERN_CRIT "kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n", current->uid);
 	}
 #endif
 	if (address < PAGE_SIZE)
@@ -498,7 +496,7 @@ do_sigbus:
 		goto no_context;
 
 	/* User space => ok to do another page fault */
-	if (is_prefetch(regs, address))
+	if (is_prefetch(regs, address, error_code))
 		return;
 
 	tsk->thread.cr2 = address;
--- linux/arch/i386/mm/init.c.orig	
+++ linux/arch/i386/mm/init.c	
@@ -437,7 +437,7 @@ static int __init noexec_setup(char *str
 __setup("noexec=", noexec_setup);
 
 #ifdef CONFIG_X86_PAE
-static int use_nx = 0;
+int nx_enabled = 0;
 
 static void __init set_nx(void)
 {
@@ -449,7 +449,7 @@ static void __init set_nx(void)
 			rdmsr(MSR_EFER, l, h);
 			l |= EFER_NX;
 			wrmsr(MSR_EFER, l, h);
-			use_nx = 1;
+			nx_enabled = 1;
 			__supported_pte_mask |= _PAGE_NX;
 		}
 	}
@@ -470,7 +470,7 @@ int __init set_kernel_exec(unsigned long
 	pte = lookup_address(vaddr);
 	BUG_ON(!pte);
 
-	if (pte_val(*pte) & _PAGE_NX)
+	if (!pte_exec_kernel(*pte))
 		ret = 0;
 
 	if (enable)
@@ -495,7 +495,7 @@ void __init paging_init(void)
 {
 #ifdef CONFIG_X86_PAE
 	set_nx();
-	if (use_nx)
+	if (nx_enabled)
 		printk("NX (Execute Disable) protection: active\n");
 #endif
 
--- linux/include/asm-i386/page.h.orig	
+++ linux/include/asm-i386/page.h	
@@ -41,6 +41,7 @@
  */
 #ifdef CONFIG_X86_PAE
 extern unsigned long long __supported_pte_mask;
+extern int nx_enabled;
 typedef struct { unsigned long pte_low, pte_high; } pte_t;
 typedef struct { unsigned long long pmd; } pmd_t;
 typedef struct { unsigned long long pgd; } pgd_t;
@@ -48,6 +49,7 @@ typedef struct { unsigned long long pgpr
 #define pte_val(x)	((x).pte_low | ((unsigned long long)(x).pte_high << 32))
 #define HPAGE_SHIFT	21
 #else
+#define nx_enabled 0
 typedef struct { unsigned long pte_low; } pte_t;
 typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pgd; } pgd_t;
--- linux/include/asm-i386/pgtable.h.orig	
+++ linux/include/asm-i386/pgtable.h	
@@ -43,19 +43,15 @@ void pgd_dtor(void *, kmem_cache_t *, un
 void pgtable_cache_init(void);
 void paging_init(void);
 
-#endif /* !__ASSEMBLY__ */
-
 /*
  * The Linux x86 paging architecture is 'compile-time dual-mode', it
  * implements both the traditional 2-level x86 page tables and the
  * newer 3-level PAE-mode page tables.
  */
-#ifndef __ASSEMBLY__
 #ifdef CONFIG_X86_PAE
-# include <asm/pgtable-3level.h>
+# include <asm/pgtable-3level-defs.h>
 #else
-# include <asm/pgtable-2level.h>
-#endif
+# include <asm/pgtable-2level-defs.h>
 #endif
 
 #define PMD_SIZE	(1UL << PMD_SHIFT)
@@ -73,8 +69,6 @@ void paging_init(void);
 #define BOOT_USER_PGD_PTRS (__PAGE_OFFSET >> TWOLEVEL_PGDIR_SHIFT)
 #define BOOT_KERNEL_PGD_PTRS (1024-BOOT_USER_PGD_PTRS)
 
-
-#ifndef __ASSEMBLY__
 /* Just any arbitrary offset to the start of the vmalloc VM area: the
  * current 8MB value just means that there will be a 8MB "hole" after the
  * physical memory until the kernel virtual memory starts.  That means that
@@ -223,7 +217,6 @@ extern unsigned long pg0[];
  */
 static inline int pte_user(pte_t pte)		{ return (pte).pte_low & _PAGE_USER; }
 static inline int pte_read(pte_t pte)		{ return (pte).pte_low & _PAGE_USER; }
-static inline int pte_exec(pte_t pte)		{ return (pte).pte_low & _PAGE_USER; }
 static inline int pte_dirty(pte_t pte)		{ return (pte).pte_low & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)		{ return (pte).pte_low & _PAGE_ACCESSED; }
 static inline int pte_write(pte_t pte)		{ return (pte).pte_low & _PAGE_RW; }
@@ -244,6 +237,12 @@ static inline pte_t pte_mkdirty(pte_t pt
 static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte_low |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
 
+#ifdef CONFIG_X86_PAE
+# include <asm/pgtable-3level.h>
+#else
+# include <asm/pgtable-2level.h>
+#endif
+
 static inline int ptep_test_and_clear_dirty(pte_t *ptep)
 {
 	if (!pte_dirty(*ptep))
--- linux/include/asm-i386/pgtable-2level.h.orig	
+++ linux/include/asm-i386/pgtable-2level.h	
@@ -1,22 +1,6 @@
 #ifndef _I386_PGTABLE_2LEVEL_H
 #define _I386_PGTABLE_2LEVEL_H
 
-/*
- * traditional i386 two-level paging structure:
- */
-
-#define PGDIR_SHIFT	22
-#define PTRS_PER_PGD	1024
-
-/*
- * the i386 is two-level, so we don't really have any
- * PMD directory physically.
- */
-#define PMD_SHIFT	22
-#define PTRS_PER_PMD	1
-
-#define PTRS_PER_PTE	1024
-
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, (e).pte_low)
 #define pmd_ERROR(e) \
@@ -64,6 +48,22 @@ static inline pmd_t * pmd_offset(pgd_t *
 #define pfn_pmd(pfn, prot)	__pmd(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
 /*
+ * All present user pages are user-executable:
+ */
+static inline int pte_exec(pte_t pte)
+{
+	return pte_user(pte);
+}
+
+/*
+ * All present pages are kernel-executable:
+ */
+static inline int pte_exec_kernel(pte_t pte)
+{
+	return 1;
+}
+
+/*
  * Bits 0, 6 and 7 are taken, split up the 29 bits of offset
  * into this range:
  */
--- linux/include/asm-i386/pgtable-3level.h.orig	
+++ linux/include/asm-i386/pgtable-3level.h	
@@ -8,24 +8,6 @@
  * Copyright (C) 1999 Ingo Molnar <mingo@redhat.com>
  */
 
-/*
- * PGDIR_SHIFT determines what a top-level page table entry can map
- */
-#define PGDIR_SHIFT	30
-#define PTRS_PER_PGD	4
-
-/*
- * PMD_SHIFT determines the size of the area a middle-level
- * page table can map
- */
-#define PMD_SHIFT	21
-#define PTRS_PER_PMD	512
-
-/*
- * entries per page directory level
- */
-#define PTRS_PER_PTE	512
-
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %p(%08lx%08lx).\n", __FILE__, __LINE__, &(e), (e).pte_high, (e).pte_low)
 #define pmd_ERROR(e) \
@@ -37,6 +19,29 @@ static inline int pgd_none(pgd_t pgd)		{
 static inline int pgd_bad(pgd_t pgd)		{ return 0; }
 static inline int pgd_present(pgd_t pgd)	{ return 1; }
 
+/*
+ * Is the pte executable?
+ */
+static inline int pte_x(pte_t pte)
+{
+	return !(pte_val(pte) & _PAGE_NX);
+}
+
+/*
+ * All present user-pages with !NX bit are user-executable:
+ */
+static inline int pte_exec(pte_t pte)
+{
+	return pte_user(pte) && pte_x(pte);
+}
+/*
+ * All present pages with !NX bit are kernel-executable:
+ */
+static inline int pte_exec_kernel(pte_t pte)
+{
+	return pte_x(pte);
+}
+
 /* Rules for using set_pte: the pte being assigned *must* be
  * either not present or in a state where the hardware will
  * not attempt to update the pte.  In places where this is
--- linux/include/asm-i386/pgtable-3level-defs.h.orig	
+++ linux/include/asm-i386/pgtable-3level-defs.h	
@@ -0,0 +1,22 @@
+#ifndef _I386_PGTABLE_3LEVEL_DEFS_H
+#define _I386_PGTABLE_3LEVEL_DEFS_H
+
+/*
+ * PGDIR_SHIFT determines what a top-level page table entry can map
+ */
+#define PGDIR_SHIFT	30
+#define PTRS_PER_PGD	4
+
+/*
+ * PMD_SHIFT determines the size of the area a middle-level
+ * page table can map
+ */
+#define PMD_SHIFT	21
+#define PTRS_PER_PMD	512
+
+/*
+ * entries per page directory level
+ */
+#define PTRS_PER_PTE	512
+
+#endif /* _I386_PGTABLE_3LEVEL_DEFS_H */
--- linux/include/asm-i386/pgtable-2level-defs.h.orig	
+++ linux/include/asm-i386/pgtable-2level-defs.h	
@@ -0,0 +1,20 @@
+#ifndef _I386_PGTABLE_2LEVEL_DEFS_H
+#define _I386_PGTABLE_2LEVEL_DEFS_H
+
+/*
+ * traditional i386 two-level paging structure:
+ */
+
+#define PGDIR_SHIFT	22
+#define PTRS_PER_PGD	1024
+
+/*
+ * the i386 is two-level, so we don't really have any
+ * PMD directory physically.
+ */
+#define PMD_SHIFT	22
+#define PTRS_PER_PMD	1
+
+#define PTRS_PER_PTE	1024
+
+#endif /* _I386_PGTABLE_2LEVEL_DEFS_H */

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nx-prefetch-fix-update.patch"


- introduce pte_exec_kern() to simplify the NX logic

- split the definitions out of pgtable-[23]level.h into
  pgtable-[23]level-defs.h, to enable the former to use generic
  pte functions from pgtable.h.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/mm/fault.c	
+++ linux/arch/i386/mm/fault.c	
@@ -436,8 +436,14 @@ no_context:
 
 	bust_spinlocks(1);
 
-	if (nx_enabled && (error_code & 16))
-		printk(KERN_CRIT "kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n", current->uid);
+#ifdef CONFIG_X86_PAE
+	if (error_code & 16) {
+		pte_t *pte = lookup_address(address);
+
+		if (pte && pte_present(*pte) && !pte_exec_kernel(*pte))
+			printk(KERN_CRIT "kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n", current->uid);
+	}
+#endif
 	if (address < PAGE_SIZE)
 		printk(KERN_ALERT "Unable to handle kernel NULL pointer dereference");
 	else
--- linux/arch/i386/mm/init.c	
+++ linux/arch/i386/mm/init.c	
@@ -470,7 +470,7 @@ int __init set_kernel_exec(unsigned long
 	pte = lookup_address(vaddr);
 	BUG_ON(!pte);
 
-	if (pte_val(*pte) & _PAGE_NX)
+	if (!pte_exec_kernel(*pte))
 		ret = 0;
 
 	if (enable)
--- linux/include/asm-i386/pgtable-2level-defs.h	
+++ linux/include/asm-i386/pgtable-2level-defs.h	
@@ -0,0 +1,20 @@
+#ifndef _I386_PGTABLE_2LEVEL_DEFS_H
+#define _I386_PGTABLE_2LEVEL_DEFS_H
+
+/*
+ * traditional i386 two-level paging structure:
+ */
+
+#define PGDIR_SHIFT	22
+#define PTRS_PER_PGD	1024
+
+/*
+ * the i386 is two-level, so we don't really have any
+ * PMD directory physically.
+ */
+#define PMD_SHIFT	22
+#define PTRS_PER_PMD	1
+
+#define PTRS_PER_PTE	1024
+
+#endif /* _I386_PGTABLE_2LEVEL_DEFS_H */
--- linux/include/asm-i386/pgtable-2level.h	
+++ linux/include/asm-i386/pgtable-2level.h	
@@ -1,22 +1,6 @@
 #ifndef _I386_PGTABLE_2LEVEL_H
 #define _I386_PGTABLE_2LEVEL_H
 
-/*
- * traditional i386 two-level paging structure:
- */
-
-#define PGDIR_SHIFT	22
-#define PTRS_PER_PGD	1024
-
-/*
- * the i386 is two-level, so we don't really have any
- * PMD directory physically.
- */
-#define PMD_SHIFT	22
-#define PTRS_PER_PMD	1
-
-#define PTRS_PER_PTE	1024
-
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, (e).pte_low)
 #define pmd_ERROR(e) \
@@ -64,6 +48,22 @@ static inline pmd_t * pmd_offset(pgd_t *
 #define pfn_pmd(pfn, prot)	__pmd(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
 /*
+ * All present user pages are user-executable:
+ */
+static inline int pte_exec(pte_t pte)
+{
+	return pte_user(pte);
+}
+
+/*
+ * All present pages are kernel-executable:
+ */
+static inline int pte_exec_kernel(pte_t pte)
+{
+	return 1;
+}
+
+/*
  * Bits 0, 6 and 7 are taken, split up the 29 bits of offset
  * into this range:
  */
--- linux/include/asm-i386/pgtable-3level-defs.h	
+++ linux/include/asm-i386/pgtable-3level-defs.h	
@@ -0,0 +1,22 @@
+#ifndef _I386_PGTABLE_3LEVEL_DEFS_H
+#define _I386_PGTABLE_3LEVEL_DEFS_H
+
+/*
+ * PGDIR_SHIFT determines what a top-level page table entry can map
+ */
+#define PGDIR_SHIFT	30
+#define PTRS_PER_PGD	4
+
+/*
+ * PMD_SHIFT determines the size of the area a middle-level
+ * page table can map
+ */
+#define PMD_SHIFT	21
+#define PTRS_PER_PMD	512
+
+/*
+ * entries per page directory level
+ */
+#define PTRS_PER_PTE	512
+
+#endif /* _I386_PGTABLE_3LEVEL_DEFS_H */
--- linux/include/asm-i386/pgtable-3level.h	
+++ linux/include/asm-i386/pgtable-3level.h	
@@ -8,24 +8,6 @@
  * Copyright (C) 1999 Ingo Molnar <mingo@redhat.com>
  */
 
-/*
- * PGDIR_SHIFT determines what a top-level page table entry can map
- */
-#define PGDIR_SHIFT	30
-#define PTRS_PER_PGD	4
-
-/*
- * PMD_SHIFT determines the size of the area a middle-level
- * page table can map
- */
-#define PMD_SHIFT	21
-#define PTRS_PER_PMD	512
-
-/*
- * entries per page directory level
- */
-#define PTRS_PER_PTE	512
-
 #define pte_ERROR(e) \
 	printk("%s:%d: bad pte %p(%08lx%08lx).\n", __FILE__, __LINE__, &(e), (e).pte_high, (e).pte_low)
 #define pmd_ERROR(e) \
@@ -37,6 +19,29 @@ static inline int pgd_none(pgd_t pgd)		{
 static inline int pgd_bad(pgd_t pgd)		{ return 0; }
 static inline int pgd_present(pgd_t pgd)	{ return 1; }
 
+/*
+ * Is the pte executable?
+ */
+static inline int pte_x(pte_t pte)
+{
+	return !(pte_val(pte) & _PAGE_NX);
+}
+
+/*
+ * All present user-pages with !NX bit are user-executable:
+ */
+static inline int pte_exec(pte_t pte)
+{
+	return pte_user(pte) && pte_x(pte);
+}
+/*
+ * All present pages with !NX bit are kernel-executable:
+ */
+static inline int pte_exec_kernel(pte_t pte)
+{
+	return pte_x(pte);
+}
+
 /* Rules for using set_pte: the pte being assigned *must* be
  * either not present or in a state where the hardware will
  * not attempt to update the pte.  In places where this is
--- linux/include/asm-i386/pgtable.h	
+++ linux/include/asm-i386/pgtable.h	
@@ -43,19 +43,15 @@ void pgd_dtor(void *, kmem_cache_t *, un
 void pgtable_cache_init(void);
 void paging_init(void);
 
-#endif /* !__ASSEMBLY__ */
-
 /*
  * The Linux x86 paging architecture is 'compile-time dual-mode', it
  * implements both the traditional 2-level x86 page tables and the
  * newer 3-level PAE-mode page tables.
  */
-#ifndef __ASSEMBLY__
 #ifdef CONFIG_X86_PAE
-# include <asm/pgtable-3level.h>
+# include <asm/pgtable-3level-defs.h>
 #else
-# include <asm/pgtable-2level.h>
-#endif
+# include <asm/pgtable-2level-defs.h>
 #endif
 
 #define PMD_SIZE	(1UL << PMD_SHIFT)
@@ -73,8 +69,6 @@ void paging_init(void);
 #define BOOT_USER_PGD_PTRS (__PAGE_OFFSET >> TWOLEVEL_PGDIR_SHIFT)
 #define BOOT_KERNEL_PGD_PTRS (1024-BOOT_USER_PGD_PTRS)
 
-
-#ifndef __ASSEMBLY__
 /* Just any arbitrary offset to the start of the vmalloc VM area: the
  * current 8MB value just means that there will be a 8MB "hole" after the
  * physical memory until the kernel virtual memory starts.  That means that
@@ -223,7 +217,6 @@ extern unsigned long pg0[];
  */
 static inline int pte_user(pte_t pte)		{ return (pte).pte_low & _PAGE_USER; }
 static inline int pte_read(pte_t pte)		{ return (pte).pte_low & _PAGE_USER; }
-static inline int pte_exec(pte_t pte)		{ return (pte).pte_low & _PAGE_USER; }
 static inline int pte_dirty(pte_t pte)		{ return (pte).pte_low & _PAGE_DIRTY; }
 static inline int pte_young(pte_t pte)		{ return (pte).pte_low & _PAGE_ACCESSED; }
 static inline int pte_write(pte_t pte)		{ return (pte).pte_low & _PAGE_RW; }
@@ -244,6 +237,12 @@ static inline pte_t pte_mkdirty(pte_t pt
 static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte_low |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
 
+#ifdef CONFIG_X86_PAE
+# include <asm/pgtable-3level.h>
+#else
+# include <asm/pgtable-2level.h>
+#endif
+
 static inline int ptep_test_and_clear_dirty(pte_t *ptep)
 {
 	if (!pte_dirty(*ptep))

--PNTmBPCT7hxwcZjr--
