Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262260AbVCPGJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbVCPGJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 01:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVCPGJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 01:09:59 -0500
Received: from ozlabs.org ([203.10.76.45]:59811 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262260AbVCPGJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 01:09:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16951.52721.139394.592636@cargo.ozlabs.ibm.com>
Date: Wed, 16 Mar 2005 17:10:57 +1100
From: Paul Mackerras <paulus@samba.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: akpm@osdl.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       anton@samba.org, olof@austin.ibm.com, benh@kernel.crashing.org,
       amodra@bigpond.net.au
Subject: Re: [PATCH 1/2] No-exec support for ppc64
In-Reply-To: <20050315155135.11b942ef.moilanen@austin.ibm.com>
References: <20050308165904.0ce07112.moilanen@austin.ibm.com>
	<20050308170826.13a2299e.moilanen@austin.ibm.com>
	<20050310032213.GB20789@austin.ibm.com>
	<20050310162513.74191caa.moilanen@austin.ibm.com>
	<16949.25552.640180.677985@cargo.ozlabs.ibm.com>
	<20050314155125.68dcff70.moilanen@austin.ibm.com>
	<16950.3484.416343.832453@cargo.ozlabs.ibm.com>
	<20050315155135.11b942ef.moilanen@austin.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jake Moilanen writes:

> It does not work w/o the sys_mprotect.  It will hang in one of the first
> few binaries.

Hmmm, what distro is this with?  I just tried a kernel with the patch
below on a SLES9 install and a Debian install and it came up and ran
just fine in both cases.

Paul.

diff -urN linux-2.5/arch/ppc64/kernel/head.S test/arch/ppc64/kernel/head.S
--- linux-2.5/arch/ppc64/kernel/head.S	2005-03-07 10:46:38.000000000 +1100
+++ test/arch/ppc64/kernel/head.S	2005-03-15 17:14:44.000000000 +1100
@@ -950,11 +950,12 @@
 	 * accessing a userspace segment (even from the kernel). We assume
 	 * kernel addresses always have the high bit set.
 	 */
-	rlwinm	r4,r4,32-23,29,29	/* DSISR_STORE -> _PAGE_RW */
+	rlwinm	r4,r4,32-25+9,31-9,31-9	/* DSISR_STORE -> _PAGE_RW */
 	rotldi	r0,r3,15		/* Move high bit into MSR_PR posn */
 	orc	r0,r12,r0		/* MSR_PR | ~high_bit */
 	rlwimi	r4,r0,32-13,30,30	/* becomes _PAGE_USER access bit */
 	ori	r4,r4,1			/* add _PAGE_PRESENT */
+	rlwimi	r4,r5,22+2,31-2,31-2	/* Set _PAGE_EXEC if trap is 0x400 */
 
 	/*
 	 * On iSeries, we soft-disable interrupts here, then
diff -urN linux-2.5/arch/ppc64/kernel/iSeries_htab.c test/arch/ppc64/kernel/iSeries_htab.c
--- linux-2.5/arch/ppc64/kernel/iSeries_htab.c	2004-09-21 17:22:33.000000000 +1000
+++ test/arch/ppc64/kernel/iSeries_htab.c	2005-03-15 17:15:36.000000000 +1100
@@ -144,6 +144,10 @@
 
 	HvCallHpt_get(&hpte, slot);
 	if ((hpte.dw0.dw0.avpn == avpn) && (hpte.dw0.dw0.v)) {
+		/*
+		 * Hypervisor expects bits as NPPP, which is
+		 * different from how they are mapped in our PP.
+		 */
 		HvCallHpt_setPp(slot, (newpp & 0x3) | ((newpp & 0x4) << 1));
 		iSeries_hunlock(slot);
 		return 0;
diff -urN linux-2.5/arch/ppc64/kernel/iSeries_setup.c test/arch/ppc64/kernel/iSeries_setup.c
--- linux-2.5/arch/ppc64/kernel/iSeries_setup.c	2005-03-07 10:46:38.000000000 +1100
+++ test/arch/ppc64/kernel/iSeries_setup.c	2005-03-15 16:55:05.000000000 +1100
@@ -633,6 +633,10 @@
 		unsigned long vpn = va >> PAGE_SHIFT;
 		unsigned long slot = HvCallHpt_findValid(&hpte, vpn);
 
+		/* Make non-kernel text non-executable */
+		if (!in_kernel_text(ea))
+			mode_rw |= HW_NO_EXEC;
+
 		if (hpte.dw0.dw0.v) {
 			/* HPTE exists, so just bolt it */
 			HvCallHpt_setSwBits(slot, 0x10, 0);
diff -urN linux-2.5/arch/ppc64/kernel/module.c test/arch/ppc64/kernel/module.c
--- linux-2.5/arch/ppc64/kernel/module.c	2004-05-10 21:25:58.000000000 +1000
+++ test/arch/ppc64/kernel/module.c	2005-03-15 16:55:05.000000000 +1100
@@ -102,7 +102,8 @@
 {
 	if (size == 0)
 		return NULL;
-	return vmalloc(size);
+
+	return vmalloc_exec(size);
 }
 
 /* Free memory returned from module_alloc */
diff -urN linux-2.5/arch/ppc64/kernel/pSeries_lpar.c test/arch/ppc64/kernel/pSeries_lpar.c
--- linux-2.5/arch/ppc64/kernel/pSeries_lpar.c	2005-03-07 10:46:38.000000000 +1100
+++ test/arch/ppc64/kernel/pSeries_lpar.c	2005-03-15 16:55:02.000000000 +1100
@@ -470,7 +470,7 @@
 	slot = pSeries_lpar_hpte_find(vpn);
 	BUG_ON(slot == -1);
 
-	flags = newpp & 3;
+	flags = newpp & 7;
 	lpar_rc = plpar_pte_protect(flags, slot, 0);
 
 	BUG_ON(lpar_rc != H_Success);
diff -urN linux-2.5/arch/ppc64/mm/fault.c test/arch/ppc64/mm/fault.c
--- linux-2.5/arch/ppc64/mm/fault.c	2005-01-04 10:49:20.000000000 +1100
+++ test/arch/ppc64/mm/fault.c	2005-03-15 17:13:05.000000000 +1100
@@ -91,8 +91,9 @@
 	struct mm_struct *mm = current->mm;
 	siginfo_t info;
 	unsigned long code = SEGV_MAPERR;
-	unsigned long is_write = error_code & 0x02000000;
+	unsigned long is_write = error_code & DSISR_ISSTORE;
 	unsigned long trap = TRAP(regs);
+ 	unsigned long is_exec = trap == 0x400;
 
 	BUG_ON((trap == 0x380) || (trap == 0x480));
 
@@ -109,7 +110,7 @@
 	if (!user_mode(regs) && (address >= TASK_SIZE))
 		return SIGSEGV;
 
-	if (error_code & 0x00400000) {
+	if (error_code & DSISR_DABRMATCH) {
 		if (notify_die(DIE_DABR_MATCH, "dabr_match", regs, error_code,
 					11, SIGSEGV) == NOTIFY_STOP)
 			return 0;
@@ -199,16 +200,19 @@
 good_area:
 	code = SEGV_ACCERR;
 
+	if (is_exec) {
+		/* protection fault */
+		if (error_code & DSISR_PROTFAULT)
+			goto bad_area;
+		if (!(vma->vm_flags & VM_EXEC))
+			goto bad_area;
 	/* a write */
-	if (is_write) {
+	} else if (is_write) {
 		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
 	/* a read */
 	} else {
-		/* protection fault */
-		if (error_code & 0x08000000)
-			goto bad_area;
-		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
+		if (!(vma->vm_flags & VM_READ))
 			goto bad_area;
 	}
 
@@ -251,6 +255,12 @@
 		return 0;
 	}
 
+	if (trap == 0x400 && (error_code & DSISR_PROTFAULT)
+	    && printk_ratelimit())
+		printk(KERN_CRIT "kernel tried to execute NX-protected"
+		       " page (%lx) - exploit attempt? (uid: %d)\n",
+		       address, current->uid);
+
 	return SIGSEGV;
 
 /*
diff -urN linux-2.5/arch/ppc64/mm/hash_low.S test/arch/ppc64/mm/hash_low.S
--- linux-2.5/arch/ppc64/mm/hash_low.S	2005-01-05 13:48:02.000000000 +1100
+++ test/arch/ppc64/mm/hash_low.S	2005-03-15 16:55:02.000000000 +1100
@@ -89,7 +89,7 @@
 	/* Prepare new PTE value (turn access RW into DIRTY, then
 	 * add BUSY,HASHPTE and ACCESSED)
 	 */
-	rlwinm	r30,r4,5,24,24	/* _PAGE_RW -> _PAGE_DIRTY */
+	rlwinm	r30,r4,32-9+7,31-7,31-7	/* _PAGE_RW -> _PAGE_DIRTY */
 	or	r30,r30,r31
 	ori	r30,r30,_PAGE_BUSY | _PAGE_ACCESSED | _PAGE_HASHPTE
 	/* Write the linux PTE atomically (setting busy) */
@@ -112,11 +112,11 @@
 	rldicl	r5,r5,0,25		/* vsid & 0x0000007fffffffff */
 	rldicl	r0,r3,64-12,48		/* (ea >> 12) & 0xffff */
 	xor	r28,r5,r0
-	
-	/* Convert linux PTE bits into HW equivalents
-	 */
-	andi.	r3,r30,0x1fa		/* Get basic set of flags */
-	rlwinm	r0,r30,32-2+1,30,30	/* _PAGE_RW -> _PAGE_USER (r0) */
+
+	/* Convert linux PTE bits into HW equivalents */
+	andi.	r3,r30,0x1fe		/* Get basic set of flags */
+	xori	r3,r3,HW_NO_EXEC	/* _PAGE_EXEC -> NOEXEC */
+	rlwinm	r0,r30,32-9+1,30,30	/* _PAGE_RW -> _PAGE_USER (r0) */
 	rlwinm	r4,r30,32-7+1,30,30	/* _PAGE_DIRTY -> _PAGE_USER (r4) */
 	and	r0,r0,r4		/* _PAGE_RW & _PAGE_DIRTY -> r0 bit 30 */
 	andc	r0,r30,r0		/* r0 = pte & ~r0 */
diff -urN linux-2.5/arch/ppc64/mm/hash_utils.c test/arch/ppc64/mm/hash_utils.c
--- linux-2.5/arch/ppc64/mm/hash_utils.c	2005-03-07 10:46:38.000000000 +1100
+++ test/arch/ppc64/mm/hash_utils.c	2005-03-15 17:20:35.000000000 +1100
@@ -51,6 +51,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cputable.h>
 #include <asm/abs_addr.h>
+#include <asm/sections.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -95,6 +96,7 @@
 {
 	unsigned long addr;
 	unsigned int step;
+	unsigned long tmp_mode;
 
 	if (large)
 		step = 16*MB;
@@ -112,6 +114,13 @@
 		else
 			vpn = va >> PAGE_SHIFT;
 
+
+		tmp_mode = mode;
+		
+		/* Make non-kernel text non-executable */
+		if (!in_kernel_text(addr))
+			tmp_mode = mode | HW_NO_EXEC;
+
 		hash = hpt_hash(vpn, large);
 
 		hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
@@ -120,12 +129,12 @@
 		if (systemcfg->platform & PLATFORM_LPAR)
 			ret = pSeries_lpar_hpte_insert(hpteg, va,
 				virt_to_abs(addr) >> PAGE_SHIFT,
-				0, mode, 1, large);
+				0, tmp_mode, 1, large);
 		else
 #endif /* CONFIG_PPC_PSERIES */
 			ret = native_hpte_insert(hpteg, va,
 				virt_to_abs(addr) >> PAGE_SHIFT,
-				0, mode, 1, large);
+				0, tmp_mode, 1, large);
 
 		if (ret == -1) {
 			ppc64_terminate_msg(0x20, "create_pte_mapping");
@@ -238,8 +247,6 @@
 {
 	struct page *page;
 
-#define PPC64_HWNOEXEC (1 << 2)
-
 	if (!pfn_valid(pte_pfn(pte)))
 		return pp;
 
@@ -251,7 +258,7 @@
 			__flush_dcache_icache(page_address(page));
 			set_bit(PG_arch_1, &page->flags);
 		} else
-			pp |= PPC64_HWNOEXEC;
+			pp |= HW_NO_EXEC;
 	}
 	return pp;
 }
diff -urN linux-2.5/arch/ppc64/mm/hugetlbpage.c test/arch/ppc64/mm/hugetlbpage.c
--- linux-2.5/arch/ppc64/mm/hugetlbpage.c	2005-03-07 14:01:43.000000000 +1100
+++ test/arch/ppc64/mm/hugetlbpage.c	2005-03-15 17:27:33.000000000 +1100
@@ -782,7 +782,6 @@
 {
 	pte_t *ptep;
 	unsigned long va, vpn;
-	int is_write;
 	pte_t old_pte, new_pte;
 	unsigned long hpteflags, prpn;
 	long slot;
@@ -809,8 +808,7 @@
 	 * Check the user's access rights to the page.  If access should be
 	 * prevented then send the problem up to do_page_fault.
 	 */
-	is_write = access & _PAGE_RW;
-	if (unlikely(is_write && !(pte_val(*ptep) & _PAGE_RW)))
+	if (unlikely(access & ~pte_val(*ptep)))
 		goto out;
 	/*
 	 * At this point, we have a pte (old_pte) which can be used to build
@@ -829,6 +827,8 @@
 	new_pte = old_pte;
 
 	hpteflags = 0x2 | (! (pte_val(new_pte) & _PAGE_RW));
+ 	/* _PAGE_EXEC -> HW_NO_EXEC since it's inverted */
+	hpteflags |= ((pte_val(new_pte) & _PAGE_EXEC) ? 0 : HW_NO_EXEC);
 
 	/* Check if pte already has an hpte (case 2) */
 	if (unlikely(pte_val(old_pte) & _PAGE_HASHPTE)) {
diff -urN linux-2.5/include/asm-ppc64/elf.h test/include/asm-ppc64/elf.h
--- linux-2.5/include/asm-ppc64/elf.h	2005-03-07 10:46:39.000000000 +1100
+++ test/include/asm-ppc64/elf.h	2005-03-15 16:55:02.000000000 +1100
@@ -226,6 +226,13 @@
 	else if (current->personality != PER_LINUX32)		\
 		set_personality(PER_LINUX);			\
 } while (0)
+
+/*
+ * An executable for which elf_read_implies_exec() returns TRUE will
+ * have the READ_IMPLIES_EXEC personality flag set automatically.
+ */
+#define elf_read_implies_exec(ex, have_pt_gnu_stack)	(!(have_pt_gnu_stack))
+
 #endif
 
 /*
diff -urN linux-2.5/include/asm-ppc64/page.h test/include/asm-ppc64/page.h
--- linux-2.5/include/asm-ppc64/page.h	2005-03-07 10:46:39.000000000 +1100
+++ test/include/asm-ppc64/page.h	2005-03-15 16:55:02.000000000 +1100
@@ -235,8 +235,25 @@
 
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
-#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
+#define VM_DATA_DEFAULT_FLAGS32	(VM_READ | VM_WRITE | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
+#define VM_STACK_DEFAULT_FLAGS32 (VM_READ | VM_WRITE | VM_EXEC | \
+				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+
+#define VM_DATA_DEFAULT_FLAGS64	(VM_READ | VM_WRITE | \
+				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+
+#define VM_STACK_DEFAULT_FLAGS64 (VM_READ | VM_WRITE | VM_EXEC | \
+				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+
+#define VM_DATA_DEFAULT_FLAGS \
+	(test_thread_flag(TIF_32BIT) ? \
+	 VM_DATA_DEFAULT_FLAGS32 : VM_DATA_DEFAULT_FLAGS64)
+
+#define VM_STACK_DEFAULT_FLAGS \
+	(test_thread_flag(TIF_32BIT) ? \
+	 VM_STACK_DEFAULT_FLAGS32 : VM_STACK_DEFAULT_FLAGS64)
+
 #endif /* __KERNEL__ */
 #endif /* _PPC64_PAGE_H */
diff -urN linux-2.5/include/asm-ppc64/pgtable.h test/include/asm-ppc64/pgtable.h
--- linux-2.5/include/asm-ppc64/pgtable.h	2005-03-07 14:01:44.000000000 +1100
+++ test/include/asm-ppc64/pgtable.h	2005-03-15 17:41:14.000000000 +1100
@@ -82,14 +82,14 @@
 #define _PAGE_PRESENT	0x0001 /* software: pte contains a translation */
 #define _PAGE_USER	0x0002 /* matches one of the PP bits */
 #define _PAGE_FILE	0x0002 /* (!present only) software: pte holds file offset */
-#define _PAGE_RW	0x0004 /* software: user write access allowed */
+#define _PAGE_EXEC	0x0004 /* No execute on POWER4 and newer (we invert) */
 #define _PAGE_GUARDED	0x0008
 #define _PAGE_COHERENT	0x0010 /* M: enforce memory coherence (SMP systems) */
 #define _PAGE_NO_CACHE	0x0020 /* I: cache inhibit */
 #define _PAGE_WRITETHRU	0x0040 /* W: cache write-through */
 #define _PAGE_DIRTY	0x0080 /* C: page changed */
 #define _PAGE_ACCESSED	0x0100 /* R: page referenced */
-#define _PAGE_EXEC	0x0200 /* software: i-cache coherence required */
+#define _PAGE_RW	0x0200 /* software: user write access allowed */
 #define _PAGE_HASHPTE	0x0400 /* software: pte has an associated HPTE */
 #define _PAGE_BUSY	0x0800 /* software: PTE & hash are busy */ 
 #define _PAGE_SECONDARY 0x8000 /* software: HPTE is in secondary group */
@@ -118,29 +118,38 @@
 #define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_WRENABLE)
 #define PAGE_KERNEL_CI	__pgprot(_PAGE_PRESENT | _PAGE_ACCESSED | \
 			       _PAGE_WRENABLE | _PAGE_NO_CACHE | _PAGE_GUARDED)
+#define PAGE_KERNEL_EXEC __pgprot(_PAGE_BASE | _PAGE_WRENABLE | _PAGE_EXEC)
 
 /*
- * The PowerPC can only do execute protection on a segment (256MB) basis,
- * not on a page basis.  So we consider execute permission the same as read.
+ * This bit in a hardware PTE indicates that the page is *not* executable.
+ */
+#define HW_NO_EXEC	_PAGE_EXEC
+
+/*
+ * POWER4 and newer have per page execute protection, older chips can only
+ * do this on a segment (256MB) basis.
+ *
  * Also, write permissions imply read permissions.
  * This is the closest we can get..
+ *
+ * Note due to the way vm flags are laid out, the bits are XWR
  */
 #define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY_X
+#define __P001	PAGE_READONLY
 #define __P010	PAGE_COPY
 #define __P011	PAGE_COPY_X
 #define __P100	PAGE_READONLY
 #define __P101	PAGE_READONLY_X
-#define __P110	PAGE_COPY
+#define __P110	PAGE_COPY_X
 #define __P111	PAGE_COPY_X
 
 #define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY_X
+#define __S001	PAGE_READONLY
 #define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED_X
-#define __S100	PAGE_READONLY
+#define __S011	PAGE_SHARED
+#define __S100	PAGE_READONLY_X
 #define __S101	PAGE_READONLY_X
-#define __S110	PAGE_SHARED
+#define __S110	PAGE_SHARED_X
 #define __S111	PAGE_SHARED_X
 
 #ifndef __ASSEMBLY__
@@ -438,7 +447,7 @@
 static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry, int dirty)
 {
 	unsigned long bits = pte_val(entry) &
-		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW);
+		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
 	unsigned long old, tmp;
 
 	__asm__ __volatile__(
diff -urN linux-2.5/include/asm-ppc64/processor.h test/include/asm-ppc64/processor.h
--- linux-2.5/include/asm-ppc64/processor.h	2005-03-07 10:46:39.000000000 +1100
+++ test/include/asm-ppc64/processor.h	2005-03-15 17:08:21.000000000 +1100
@@ -173,6 +173,11 @@
 #define	SPRN_DEC	0x016	/* Decrement Register */
 #define	SPRN_DMISS	0x3D0	/* Data TLB Miss Register */
 #define	SPRN_DSISR	0x012	/* Data Storage Interrupt Status Register */
+#define   DSISR_NOHPTE		0x40000000	/* no translation found */
+#define   DSISR_PROTFAULT	0x08000000	/* protection fault */
+#define   DSISR_ISSTORE		0x02000000	/* access was a store */
+#define   DSISR_DABRMATCH	0x00400000	/* hit data breakpoint */
+#define   DSISR_NOSEGMENT	0x00200000	/* STAB/SLB miss */
 #define	SPRN_EAR	0x11A	/* External Address Register */
 #define	SPRN_ESR	0x3D4	/* Exception Syndrome Register */
 #define	  ESR_IMCP	0x80000000	/* Instr. Machine Check - Protection */
diff -urN linux-2.5/include/asm-ppc64/sections.h test/include/asm-ppc64/sections.h
--- linux-2.5/include/asm-ppc64/sections.h	2004-02-12 14:57:14.000000000 +1100
+++ test/include/asm-ppc64/sections.h	2005-03-15 16:55:05.000000000 +1100
@@ -17,4 +17,13 @@
 #define __openfirmware
 #define __openfirmwaredata
 
+
+static inline int in_kernel_text(unsigned long addr)
+{
+	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end)
+		return 1;
+
+	return 0;
+}
+
 #endif
