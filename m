Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVCJWlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVCJWlR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 17:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVCJWj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 17:39:56 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:2796 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263312AbVCJWdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 17:33:20 -0500
Date: Thu, 10 Mar 2005 16:25:13 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: akpm@osdl.org
Cc: linuxppc64-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
       anton@samba.org, olof@austin.ibm.com, benh@kernel.crashing.org
Subject: Re: [PATCH 1/2] No-exec support for ppc64
Message-Id: <20050310162513.74191caa.moilanen@austin.ibm.com>
In-Reply-To: <20050310032213.GB20789@austin.ibm.com>
References: <20050308165904.0ce07112.moilanen@austin.ibm.com>
	<20050308170826.13a2299e.moilanen@austin.ibm.com>
	<20050310032213.GB20789@austin.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Mar 2005 21:22:13 -0600
olof@austin.ibm.com (Olof Johansson) wrote:

> On Tue, Mar 08, 2005 at 05:08:26PM -0600, Jake Moilanen wrote:
> > No-exec base and user space support for PPC64.  
> 
> Hi, a couple of comments below.
> 

Here's the revised user & base support for no-exec on ppc64 with Olof
and Ben's comments.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

---

 linux-2.6-bk-moilanen/arch/ppc64/kernel/head.S         |    5 +
 linux-2.6-bk-moilanen/arch/ppc64/kernel/iSeries_htab.c |    4 +
 linux-2.6-bk-moilanen/arch/ppc64/kernel/pSeries_lpar.c |    2 
 linux-2.6-bk-moilanen/arch/ppc64/mm/fault.c            |   14 +++--
 linux-2.6-bk-moilanen/arch/ppc64/mm/hash_low.S         |   12 ++--
 linux-2.6-bk-moilanen/arch/ppc64/mm/hugetlbpage.c      |   10 +++
 linux-2.6-bk-moilanen/fs/binfmt_elf.c                  |    2 
 linux-2.6-bk-moilanen/include/asm-ppc64/elf.h          |    7 ++
 linux-2.6-bk-moilanen/include/asm-ppc64/page.h         |   19 ++++++-
 linux-2.6-bk-moilanen/include/asm-ppc64/pgtable.h      |   46 +++++++++--------
 10 files changed, 85 insertions(+), 36 deletions(-)

diff -puN arch/ppc64/kernel/head.S~nx-user-ppc64 arch/ppc64/kernel/head.S
--- linux-2.6-bk/arch/ppc64/kernel/head.S~nx-user-ppc64	2005-03-08 16:08:54 -06:00
+++ linux-2.6-bk-moilanen/arch/ppc64/kernel/head.S	2005-03-08 16:08:54 -06:00
@@ -36,6 +36,7 @@
 #include <asm/offsets.h>
 #include <asm/bug.h>
 #include <asm/cputable.h>
+#include <asm/pgtable.h>	
 #include <asm/setup.h>
 
 #ifdef CONFIG_PPC_ISERIES
@@ -950,11 +951,11 @@ END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
 	 * accessing a userspace segment (even from the kernel). We assume
 	 * kernel addresses always have the high bit set.
 	 */
-	rlwinm	r4,r4,32-23,29,29	/* DSISR_STORE -> _PAGE_RW */
+	rlwinm	r4,r4,32-25+9,31-9,31-9	/* DSISR_STORE -> _PAGE_RW */
 	rotldi	r0,r3,15		/* Move high bit into MSR_PR posn */
 	orc	r0,r12,r0		/* MSR_PR | ~high_bit */
 	rlwimi	r4,r0,32-13,30,30	/* becomes _PAGE_USER access bit */
-	ori	r4,r4,1			/* add _PAGE_PRESENT */
+	rlwimi	r4,r5,22+2,31-2,31-2	/* Set _PAGE_EXEC if trap is 0x400 */
 
 	/*
 	 * On iSeries, we soft-disable interrupts here, then
diff -puN arch/ppc64/kernel/iSeries_htab.c~nx-user-ppc64 arch/ppc64/kernel/iSeries_htab.c
--- linux-2.6-bk/arch/ppc64/kernel/iSeries_htab.c~nx-user-ppc64	2005-03-08 16:08:54 -06:00
+++ linux-2.6-bk-moilanen/arch/ppc64/kernel/iSeries_htab.c	2005-03-08 16:08:54 -06:00
@@ -144,6 +144,10 @@ static long iSeries_hpte_updatepp(unsign
 
 	HvCallHpt_get(&hpte, slot);
 	if ((hpte.dw0.dw0.avpn == avpn) && (hpte.dw0.dw0.v)) {
+		/*
+		 * Hypervisor expects bit's as NPPP, which is
+		 * different from how they are mapped in our PP.
+		 */
 		HvCallHpt_setPp(slot, (newpp & 0x3) | ((newpp & 0x4) << 1));
 		iSeries_hunlock(slot);
 		return 0;
diff -puN arch/ppc64/kernel/pSeries_lpar.c~nx-user-ppc64 arch/ppc64/kernel/pSeries_lpar.c
--- linux-2.6-bk/arch/ppc64/kernel/pSeries_lpar.c~nx-user-ppc64	2005-03-08 16:08:54 -06:00
+++ linux-2.6-bk-moilanen/arch/ppc64/kernel/pSeries_lpar.c	2005-03-08 16:08:54 -06:00
@@ -470,7 +470,7 @@ static void pSeries_lpar_hpte_updatebolt
 	slot = pSeries_lpar_hpte_find(vpn);
 	BUG_ON(slot == -1);
 
-	flags = newpp & 3;
+	flags = newpp & 7;
 	lpar_rc = plpar_pte_protect(flags, slot, 0);
 
 	BUG_ON(lpar_rc != H_Success);
diff -puN arch/ppc64/mm/fault.c~nx-user-ppc64 arch/ppc64/mm/fault.c
--- linux-2.6-bk/arch/ppc64/mm/fault.c~nx-user-ppc64	2005-03-08 16:08:54 -06:00
+++ linux-2.6-bk-moilanen/arch/ppc64/mm/fault.c	2005-03-10 16:14:45 -06:00
@@ -93,6 +93,7 @@ int do_page_fault(struct pt_regs *regs, 
 	unsigned long code = SEGV_MAPERR;
 	unsigned long is_write = error_code & 0x02000000;
 	unsigned long trap = TRAP(regs);
+ 	unsigned long is_exec = trap == 0x400;	
 
 	BUG_ON((trap == 0x380) || (trap == 0x480));
 
@@ -199,16 +200,19 @@ int do_page_fault(struct pt_regs *regs, 
 good_area:
 	code = SEGV_ACCERR;
 
+	if (is_exec) {
+		/* protection fault */
+		if (error_code & 0x08000000) 
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
 
diff -puN arch/ppc64/mm/hash_low.S~nx-user-ppc64 arch/ppc64/mm/hash_low.S
--- linux-2.6-bk/arch/ppc64/mm/hash_low.S~nx-user-ppc64	2005-03-08 16:08:54 -06:00
+++ linux-2.6-bk-moilanen/arch/ppc64/mm/hash_low.S	2005-03-08 16:08:54 -06:00
@@ -89,7 +89,7 @@ _GLOBAL(__hash_page)
 	/* Prepare new PTE value (turn access RW into DIRTY, then
 	 * add BUSY,HASHPTE and ACCESSED)
 	 */
-	rlwinm	r30,r4,5,24,24	/* _PAGE_RW -> _PAGE_DIRTY */
+	rlwinm	r30,r4,32-9+7,31-7,31-7	/* _PAGE_RW -> _PAGE_DIRTY */
 	or	r30,r30,r31
 	ori	r30,r30,_PAGE_BUSY | _PAGE_ACCESSED | _PAGE_HASHPTE
 	/* Write the linux PTE atomically (setting busy) */
@@ -112,11 +112,11 @@ _GLOBAL(__hash_page)
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
diff -puN arch/ppc64/mm/hugetlbpage.c~nx-user-ppc64 arch/ppc64/mm/hugetlbpage.c
--- linux-2.6-bk/arch/ppc64/mm/hugetlbpage.c~nx-user-ppc64	2005-03-08 16:08:54 -06:00
+++ linux-2.6-bk-moilanen/arch/ppc64/mm/hugetlbpage.c	2005-03-10 13:46:08 -06:00
@@ -796,6 +796,9 @@ int hash_huge_page(struct mm_struct *mm,
 	va = (vsid << 28) | (ea & 0x0fffffff);
 	vpn = va >> HPAGE_SHIFT;
 
+	if (unlikely((access & _PAGE_EXEC) && !(pte_val(*ptep) & _PAGE_EXEC)))
+		goto out;
+
 	/*
 	 * If no pte found or not present, send the problem up to
 	 * do_page_fault
@@ -828,7 +831,12 @@ int hash_huge_page(struct mm_struct *mm,
 	old_pte = *ptep;
 	new_pte = old_pte;
 
-	hpteflags = 0x2 | (! (pte_val(new_pte) & _PAGE_RW));
+ 	hpteflags = (pte_val(new_pte) & _PAGE_RW) |
+ 		(!(pte_val(new_pte) & _PAGE_RW)) |
+		_PAGE_USER;
+
+ 	/* _PAGE_EXEC -> HW_NO_EXEC since it's inverted */
+	hpteflags |= ((pte_val(new_pte) & _PAGE_EXEC) ? 0 : HW_NO_EXEC);
 
 	/* Check if pte already has an hpte (case 2) */
 	if (unlikely(pte_val(old_pte) & _PAGE_HASHPTE)) {
diff -puN fs/binfmt_elf.c~nx-user-ppc64 fs/binfmt_elf.c
--- linux-2.6-bk/fs/binfmt_elf.c~nx-user-ppc64	2005-03-08 16:08:54 -06:00
+++ linux-2.6-bk-moilanen/fs/binfmt_elf.c	2005-03-08 16:08:54 -06:00
@@ -99,6 +99,8 @@ static int set_brk(unsigned long start, 
 		up_write(&current->mm->mmap_sem);
 		if (BAD_ADDR(addr))
 			return addr;
+
+  		sys_mprotect(start, end-start, PROT_READ|PROT_WRITE|PROT_EXEC);
 	}
 	current->mm->start_brk = current->mm->brk = end;
 	return 0;
diff -puN include/asm-ppc64/elf.h~nx-user-ppc64 include/asm-ppc64/elf.h
--- linux-2.6-bk/include/asm-ppc64/elf.h~nx-user-ppc64	2005-03-08 16:08:54 -06:00
+++ linux-2.6-bk-moilanen/include/asm-ppc64/elf.h	2005-03-08 16:23:37 -06:00
@@ -226,6 +226,13 @@ do {								\
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
diff -puN include/asm-ppc64/page.h~nx-user-ppc64 include/asm-ppc64/page.h
--- linux-2.6-bk/include/asm-ppc64/page.h~nx-user-ppc64	2005-03-08 16:08:54 -06:00
+++ linux-2.6-bk-moilanen/include/asm-ppc64/page.h	2005-03-08 16:08:54 -06:00
@@ -235,8 +235,25 @@ extern u64 ppc64_pft_size;		/* Log 2 of 
 
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
 
-#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
+#define VM_DATA_DEFAULT_FLAGS32	(VM_READ | VM_WRITE | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+
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
 
 #endif /* __KERNEL__ */
 #endif /* _PPC64_PAGE_H */
diff -puN include/asm-ppc64/pgtable.h~nx-user-ppc64 include/asm-ppc64/pgtable.h
--- linux-2.6-bk/include/asm-ppc64/pgtable.h~nx-user-ppc64	2005-03-08 16:08:54 -06:00
+++ linux-2.6-bk-moilanen/include/asm-ppc64/pgtable.h	2005-03-10 16:14:45 -06:00
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
@@ -100,7 +100,8 @@
 /* PAGE_MASK gives the right answer below, but only by accident */
 /* It should be preserving the high 48 bits and then specifically */
 /* preserving _PAGE_SECONDARY | _PAGE_GROUP_IX */
-#define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_HPTEFLAGS)
+#define _PAGE_CHG_MASK (_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | _PAGE_WRITETHRU | \
+ 			_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_HPTEFLAGS | PAGE_MASK)
 
 #define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_COHERENT)
 
@@ -116,31 +117,38 @@
 #define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
 #define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
 #define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_WRENABLE)
-#define PAGE_KERNEL_CI	__pgprot(_PAGE_PRESENT | _PAGE_ACCESSED | \
-			       _PAGE_WRENABLE | _PAGE_NO_CACHE | _PAGE_GUARDED)
+
+#define HW_NO_EXEC	_PAGE_EXEC /* This is used when the bit is
+				    * inverted, even though it's the
+				    * same value, hopefully it will be
+				    * clearer in the code what is
+				    * going on. */
 
 /*
- * The PowerPC can only do execute protection on a segment (256MB) basis,
- * not on a page basis.  So we consider execute permission the same as read.
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
-#define __P011	PAGE_COPY_X
-#define __P100	PAGE_READONLY
+#define __P011	PAGE_COPY
+#define __P100	PAGE_READONLY_X
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
@@ -197,7 +205,8 @@ void hugetlb_mm_free_pgd(struct mm_struc
 })
 
 #define pte_modify(_pte, newprot) \
-  (__pte((pte_val(_pte) & _PAGE_CHG_MASK) | pgprot_val(newprot)))
+	(__pte((pte_val(_pte) & _PAGE_CHG_MASK) | \
+	       (pgprot_val(newprot) & ~_PAGE_CHG_MASK)))
 
 #define pte_none(pte)		((pte_val(pte) & ~_PAGE_HPTEFLAGS) == 0)
 #define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
@@ -266,9 +275,6 @@ static inline int pte_young(pte_t pte) {
 static inline int pte_file(pte_t pte) { return pte_val(pte) & _PAGE_FILE;}
 static inline int pte_huge(pte_t pte) { return pte_val(pte) & _PAGE_HUGE;}
 
-static inline void pte_uncache(pte_t pte) { pte_val(pte) |= _PAGE_NO_CACHE; }
-static inline void pte_cache(pte_t pte)   { pte_val(pte) &= ~_PAGE_NO_CACHE; }
-
 static inline pte_t pte_rdprotect(pte_t pte) {
 	pte_val(pte) &= ~_PAGE_USER; return pte; }
 static inline pte_t pte_exprotect(pte_t pte) {
@@ -438,7 +444,7 @@ static inline void set_pte_at(struct mm_
 static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry, int dirty)
 {
 	unsigned long bits = pte_val(entry) &
-		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW);
+		(_PAGE_DIRTY | _PAGE_ACCESSED | _PAGE_RW | _PAGE_EXEC);
 	unsigned long old, tmp;
 
 	__asm__ __volatile__(

_
