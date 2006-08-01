Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932657AbWHALGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbWHALGd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbWHALGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:06:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14557 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932657AbWHALG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:06:26 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 29/33] x86_64: __pa and __pa_symbol address space separation
Date: Tue,  1 Aug 2006 05:03:44 -0600
Message-Id: <11544302462217-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently __pa_symbol is for use with symbols in the kernel address
map and __pa is for use with pointers into the physical memory map.
But the code is implemented so you can usually interchange the two.

__pa which is much more common can be implemented much more cheaply
if it is it doesn't have to worry about any other kernel address
spaces.  This is especially true with a relocatable kernel as
__pa_symbol needs to peform an extra variable read to resolve
the address.

There is a third macro that is added for the vsyscall data
__pa_vsymbol for finding the physical addesses of vsyscall pages.

Most of this patch is simply sorting through the references to
__pa or __pa_symbol and using the proper one.  A little of
it is continuing to use a physical address when we have it
instead of recalculating it several times.

swapper_pgd is now NULL.  leave_mm now uses init_mm.pgd
and init_mm.pgd is initialized at boot (instead of compile time)
to the physmem virtual mapping of init_level4_pgd.  The
physical address changed.

Except for the for EMPTY_ZERO page all of the remaining references
to __pa_symbol appear to be during kernel initialization.  So this
should reduce the cost of __pa in the common case, even on a relocated
kernel.

As this is technically a semantic change we need to be on the lookout
for anything I missed.  But it works for me (tm).

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/i386/kernel/alternative.c |    8 ++++----
 arch/i386/mm/init.c            |   15 ++++++++-------
 arch/x86_64/kernel/setup.c     |    9 +++++----
 arch/x86_64/kernel/smp.c       |    2 +-
 arch/x86_64/kernel/vsyscall.c  |   10 ++++++++--
 arch/x86_64/mm/init.c          |   21 +++++++++++----------
 arch/x86_64/mm/pageattr.c      |   20 +++++++++++---------
 include/asm-x86_64/page.h      |    6 ++----
 include/asm-x86_64/pgtable.h   |    4 ++--
 9 files changed, 52 insertions(+), 43 deletions(-)

diff --git a/arch/i386/kernel/alternative.c b/arch/i386/kernel/alternative.c
index 28ab806..e573263 100644
--- a/arch/i386/kernel/alternative.c
+++ b/arch/i386/kernel/alternative.c
@@ -347,8 +347,8 @@ void __init alternative_instructions(voi
 	if (no_replacement) {
 		printk(KERN_INFO "(SMP-)alternatives turned off\n");
 		free_init_pages("SMP alternatives",
-				(unsigned long)__smp_alt_begin,
-				(unsigned long)__smp_alt_end);
+				__pa_symbol(&__smp_alt_begin),
+				__pa_symbol(&__smp_alt_end));
 		return;
 	}
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
@@ -375,8 +375,8 @@ #ifdef CONFIG_SMP
 						_text, _etext);
 		}
 		free_init_pages("SMP alternatives",
-				(unsigned long)__smp_alt_begin,
-				(unsigned long)__smp_alt_end);
+				__pa_symbol(&__smp_alt_begin),
+				__pa_symbol(&__smp_alt_end));
 	} else {
 		alternatives_smp_save(__smp_alt_instructions,
 				      __smp_alt_instructions_end);
diff --git a/arch/i386/mm/init.c b/arch/i386/mm/init.c
index 89e8486..8dbbb09 100644
--- a/arch/i386/mm/init.c
+++ b/arch/i386/mm/init.c
@@ -750,10 +750,11 @@ void free_init_pages(char *what, unsigne
 	unsigned long addr;
 
 	for (addr = begin; addr < end; addr += PAGE_SIZE) {
-		ClearPageReserved(virt_to_page(addr));
-		init_page_count(virt_to_page(addr));
-		memset((void *)addr, POISON_FREE_INITMEM, PAGE_SIZE);
-		free_page(addr);
+		struct page *page = pfn_to_page(addr >> PAGE_SHIFT);
+		ClearPageReserved(page);
+		init_page_count(page);
+		memset(page_address(page), POISON_FREE_INITMEM, PAGE_SIZE);
+		__free_page(page);
 		totalram_pages++;
 	}
 	printk(KERN_INFO "Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
@@ -762,14 +763,14 @@ void free_init_pages(char *what, unsigne
 void free_initmem(void)
 {
 	free_init_pages("unused kernel memory",
-			(unsigned long)(&__init_begin),
-			(unsigned long)(&__init_end));
+			__pa_symbol(&__init_begin),
+			__pa_symbol(&__init_end));
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
-	free_init_pages("initrd memory", start, end);
+	free_init_pages("initrd memory", __pa(start), __pa(end));
 }
 #endif
 
diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
index 7225f61..44a40e6 100644
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -543,11 +543,12 @@ #endif
 	init_mm.end_code = (unsigned long) &_etext;
 	init_mm.end_data = (unsigned long) &_edata;
 	init_mm.brk = (unsigned long) &_end;
+	init_mm.pgd = __va(__pa_symbol(&init_level4_pgt));
 
-	code_resource.start = virt_to_phys(&_text);
-	code_resource.end = virt_to_phys(&_etext)-1;
-	data_resource.start = virt_to_phys(&_etext);
-	data_resource.end = virt_to_phys(&_edata)-1;
+	code_resource.start = __pa_symbol(&_text);
+	code_resource.end = __pa_symbol(&_etext)-1;
+	data_resource.start = __pa_symbol(&_etext);
+	data_resource.end = __pa_symbol(&_edata)-1;
 
 	parse_cmdline_early(cmdline_p);
 
diff --git a/arch/x86_64/kernel/smp.c b/arch/x86_64/kernel/smp.c
index 5a1c0a3..5a54066 100644
--- a/arch/x86_64/kernel/smp.c
+++ b/arch/x86_64/kernel/smp.c
@@ -76,7 +76,7 @@ static inline void leave_mm(int cpu)
 	if (read_pda(mmu_state) == TLBSTATE_OK)
 		BUG();
 	cpu_clear(cpu, read_pda(active_mm)->cpu_vm_mask);
-	load_cr3(swapper_pg_dir);
+	load_cr3(init_mm.pgd);
 }
 
 /*
diff --git a/arch/x86_64/kernel/vsyscall.c b/arch/x86_64/kernel/vsyscall.c
index f603037..2e48407 100644
--- a/arch/x86_64/kernel/vsyscall.c
+++ b/arch/x86_64/kernel/vsyscall.c
@@ -41,6 +41,12 @@ seqlock_t __xtime_lock __section_xtime_l
 
 #include <asm/unistd.h>
 
+#define __pa_vsymbol(x)			\
+	({unsigned long v;  		\
+	extern char __vsyscall_0; 	\
+	  asm("" : "=r" (v) : "0" (x)); \
+	  ((v - VSYSCALL_FIRST_PAGE) + __pa_symbol(&__vsyscall_0)); })
+
 static __always_inline void timeval_normalize(struct timeval * tv)
 {
 	time_t __sec;
@@ -155,10 +161,10 @@ static int vsyscall_sysctl_change(ctl_ta
 		return ret;
 	/* gcc has some trouble with __va(__pa()), so just do it this
 	   way. */
-	map1 = ioremap(__pa_symbol(&vsysc1), 2);
+	map1 = ioremap(__pa_vsymbol(&vsysc1), 2);
 	if (!map1)
 		return -ENOMEM;
-	map2 = ioremap(__pa_symbol(&vsysc2), 2);
+	map2 = ioremap(__pa_vsymbol(&vsysc2), 2);
 	if (!map2) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/arch/x86_64/mm/init.c b/arch/x86_64/mm/init.c
index 149f363..5db93b9 100644
--- a/arch/x86_64/mm/init.c
+++ b/arch/x86_64/mm/init.c
@@ -663,11 +663,11 @@ void free_init_pages(char *what, unsigne
 
 	printk(KERN_INFO "Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
 	for (addr = begin; addr < end; addr += PAGE_SIZE) {
-		ClearPageReserved(virt_to_page(addr));
-		init_page_count(virt_to_page(addr));
-		memset((void *)(addr & ~(PAGE_SIZE-1)),
-			POISON_FREE_INITMEM, PAGE_SIZE);
-		free_page(addr);
+		struct page *page = pfn_to_page(addr >> PAGE_SHIFT);
+		ClearPageReserved(page);
+		init_page_count(page);
+		memset(page_address(page), POISON_FREE_INITMEM, PAGE_SIZE);
+		__free_page(page);
 		totalram_pages++;
 	}
 }
@@ -677,17 +677,18 @@ void free_initmem(void)
 	memset(__initdata_begin, POISON_FREE_INITDATA,
 		__initdata_end - __initdata_begin);
 	free_init_pages("unused kernel memory",
-			(unsigned long)(&__init_begin),
-			(unsigned long)(&__init_end));
+			__pa_symbol(&__init_begin),
+			__pa_symbol(&__init_end));
 }
 
 #ifdef CONFIG_DEBUG_RODATA
 
 void mark_rodata_ro(void)
 {
-	unsigned long addr = (unsigned long)__start_rodata;
+	unsigned long addr = (unsigned long)__va(__pa_symbol(&__start_rodata));
+	unsigned long end  = (unsigned long)__va(__pa_symbol(&__end_rodata));
 
-	for (; addr < (unsigned long)__end_rodata; addr += PAGE_SIZE)
+	for (; addr < end; addr += PAGE_SIZE)
 		change_page_attr_addr(addr, 1, PAGE_KERNEL_RO);
 
 	printk ("Write protecting the kernel read-only data: %luk\n",
@@ -706,7 +707,7 @@ #endif
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
-	free_init_pages("initrd memory", start, end);
+	free_init_pages("initrd memory", __pa(start), __pa(end));
 }
 #endif
 
diff --git a/arch/x86_64/mm/pageattr.c b/arch/x86_64/mm/pageattr.c
index 2685b1f..9d6196d 100644
--- a/arch/x86_64/mm/pageattr.c
+++ b/arch/x86_64/mm/pageattr.c
@@ -51,7 +51,6 @@ static struct page *split_large_page(uns
 	SetPagePrivate(base);
 	page_private(base) = 0;
 
-	address = __pa(address);
 	addr = address & LARGE_PAGE_MASK; 
 	pbase = (pte_t *)page_address(base);
 	for (i = 0; i < PTRS_PER_PTE; i++, addr += PAGE_SIZE) {
@@ -95,7 +94,7 @@ static inline void save_page(struct page
  * No more special protections in this 2/4MB area - revert to a
  * large page again. 
  */
-static void revert_page(unsigned long address, pgprot_t ref_prot)
+static void revert_page(unsigned long address, unsigned long pfn, pgprot_t ref_prot)
 {
 	pgd_t *pgd;
 	pud_t *pud;
@@ -109,7 +108,7 @@ static void revert_page(unsigned long ad
 	pmd = pmd_offset(pud, address);
 	BUG_ON(pmd_val(*pmd) & _PAGE_PSE);
 	pgprot_val(ref_prot) |= _PAGE_PSE;
-	large_pte = mk_pte_phys(__pa(address) & LARGE_PAGE_MASK, ref_prot);
+	large_pte = mk_pte_phys((pfn << PAGE_SHIFT) & LARGE_PAGE_MASK, ref_prot);
 	set_pte((pte_t *)pmd, large_pte);
 }      
 
@@ -137,7 +136,7 @@ __change_page_attr(unsigned long address
 			struct page *split;
 			ref_prot2 = __pgprot(pgprot_val(pte_pgprot(*lookup_address(address))) & ~(1<<_PAGE_BIT_PSE));
 
-			split = split_large_page(address, prot, ref_prot2);
+			split = split_large_page(pfn << PAGE_SHIFT, prot, ref_prot2);
 			if (!split)
 				return -ENOMEM;
 			set_pte(kpte,mk_pte(split, ref_prot2));
@@ -156,7 +155,7 @@ __change_page_attr(unsigned long address
 
 	if (page_private(kpte_page) == 0) {
 		save_page(kpte_page);
-		revert_page(address, ref_prot);
+		revert_page(address, pfn, ref_prot);
  	}
 	return 0;
 } 
@@ -176,6 +175,7 @@ __change_page_attr(unsigned long address
  */
 int change_page_attr_addr(unsigned long address, int numpages, pgprot_t prot)
 {
+	unsigned long phys_base_pfn = __pa_symbol(__START_KERNEL_map) >> PAGE_SHIFT;
 	int err = 0; 
 	int i; 
 
@@ -188,14 +188,16 @@ int change_page_attr_addr(unsigned long 
 			break; 
 		/* Handle kernel mapping too which aliases part of the
 		 * lowmem */
-		if (__pa(address) < KERNEL_TEXT_SIZE) {
+		if ((pfn >= phys_base_pfn) &&
+			((pfn - phys_base_pfn) < (KERNEL_TEXT_SIZE >> PAGE_SHIFT)))
+		{
 			unsigned long addr2;
 			pgprot_t prot2 = prot;
-			addr2 = __START_KERNEL_map + __pa(address);
+			addr2 = __START_KERNEL_map + ((pfn - phys_base_pfn) << PAGE_SHIFT);
  			pgprot_val(prot2) &= ~_PAGE_NX;
 			err = __change_page_attr(addr2, pfn, prot2, PAGE_KERNEL_EXEC);
-		} 
-	} 	
+		}
+	}
 	up_write(&init_mm.mmap_sem); 
 	return err;
 }
diff --git a/include/asm-x86_64/page.h b/include/asm-x86_64/page.h
index f030260..37f95ca 100644
--- a/include/asm-x86_64/page.h
+++ b/include/asm-x86_64/page.h
@@ -102,17 +102,15 @@ #define PAGE_OFFSET		__PAGE_OFFSET
 
 /* Note: __pa(&symbol_visible_to_c) should be always replaced with __pa_symbol.
    Otherwise you risk miscompilation. */ 
-#define __pa(x)			(((unsigned long)(x)>=__START_KERNEL_map)?(unsigned long)(x) - (unsigned long)__START_KERNEL_map:(unsigned long)(x) - PAGE_OFFSET)
+#define __pa(x)			((unsigned long)(x) - PAGE_OFFSET)
 /* __pa_symbol should be used for C visible symbols.
    This seems to be the official gcc blessed way to do such arithmetic. */ 
 #define __pa_symbol(x)		\
 	({unsigned long v;  \
 	  asm("" : "=r" (v) : "0" (x)); \
-	  __pa(v); })
+	  (v - __START_KERNEL_map); })
 
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
-#define __boot_va(x)		__va(x)
-#define __boot_pa(x)		__pa(x)
 #ifdef CONFIG_FLATMEM
 #define pfn_valid(pfn)		((pfn) < end_pfn)
 #endif
diff --git a/include/asm-x86_64/pgtable.h b/include/asm-x86_64/pgtable.h
index d0816fb..fa43712 100644
--- a/include/asm-x86_64/pgtable.h
+++ b/include/asm-x86_64/pgtable.h
@@ -20,7 +20,7 @@ extern pmd_t level2_kernel_pgt[512];
 extern pgd_t init_level4_pgt[];
 extern unsigned long __supported_pte_mask;
 
-#define swapper_pg_dir init_level4_pgt
+#define swapper_pg_dir ((pgd_t *)NULL)
 
 extern int nonx_setup(char *str);
 extern void paging_init(void);
@@ -33,7 +33,7 @@ extern unsigned long pgkern_mask;
  * for zero-mapped memory areas etc..
  */
 extern unsigned long empty_zero_page[PAGE_SIZE/sizeof(unsigned long)];
-#define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
+#define ZERO_PAGE(vaddr) (pfn_to_page(__pa_symbol(&empty_zero_page) >> PAGE_SHIFT))
 
 #endif /* !__ASSEMBLY__ */
 
-- 
1.4.2.rc2.g5209e

