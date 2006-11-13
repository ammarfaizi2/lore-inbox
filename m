Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755208AbWKMQyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208AbWKMQyq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754972AbWKMQyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:54:23 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:57504 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1755210AbWKMQyJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:54:09 -0500
Date: Mon, 13 Nov 2006 11:47:21 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com
Subject: [RFC] [PATCH 13/16] x86_64: __pa and __pa_symbol address space separation
Message-ID: <20061113164721.GN17429@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061113162135.GA17429@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113162135.GA17429@in.ibm.com>
User-Agent: Mutt/1.5.11
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
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/kernel/alternative.c     |    8 ++++----
 arch/i386/mm/init.c                |   15 ++++++++-------
 arch/x86_64/kernel/machine_kexec.c |   14 +++++++-------
 arch/x86_64/kernel/setup.c         |    9 +++++----
 arch/x86_64/kernel/smp.c           |    2 +-
 arch/x86_64/kernel/vsyscall.c      |   10 ++++++++--
 arch/x86_64/mm/init.c              |   21 +++++++++++----------
 arch/x86_64/mm/pageattr.c          |   17 ++++++++++-------
 include/asm-x86_64/page.h          |    6 ++----
 include/asm-x86_64/pgtable.h       |    4 ++--
 10 files changed, 58 insertions(+), 48 deletions(-)

diff -puN arch/i386/kernel/alternative.c~x86_64-__pa-and-__pa_symbol-address-space-separation arch/i386/kernel/alternative.c
--- linux-2.6.19-rc5-reloc/arch/i386/kernel/alternative.c~x86_64-__pa-and-__pa_symbol-address-space-separation	2006-11-09 23:05:12.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/i386/kernel/alternative.c	2006-11-09 23:05:12.000000000 -0500
@@ -348,8 +348,8 @@ void __init alternative_instructions(voi
 	if (no_replacement) {
 		printk(KERN_INFO "(SMP-)alternatives turned off\n");
 		free_init_pages("SMP alternatives",
-				(unsigned long)__smp_alt_begin,
-				(unsigned long)__smp_alt_end);
+				__pa_symbol(&__smp_alt_begin),
+				__pa_symbol(&__smp_alt_end));
 		return;
 	}
 
@@ -378,8 +378,8 @@ void __init alternative_instructions(voi
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
diff -puN arch/i386/mm/init.c~x86_64-__pa-and-__pa_symbol-address-space-separation arch/i386/mm/init.c
--- linux-2.6.19-rc5-reloc/arch/i386/mm/init.c~x86_64-__pa-and-__pa_symbol-address-space-separation	2006-11-09 23:05:12.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/i386/mm/init.c	2006-11-09 23:05:12.000000000 -0500
@@ -778,10 +778,11 @@ void free_init_pages(char *what, unsigne
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
@@ -790,14 +791,14 @@ void free_init_pages(char *what, unsigne
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
 
diff -puN arch/x86_64/kernel/machine_kexec.c~x86_64-__pa-and-__pa_symbol-address-space-separation arch/x86_64/kernel/machine_kexec.c
--- linux-2.6.19-rc5-reloc/arch/x86_64/kernel/machine_kexec.c~x86_64-__pa-and-__pa_symbol-address-space-separation	2006-11-09 23:05:12.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/kernel/machine_kexec.c	2006-11-09 23:05:12.000000000 -0500
@@ -191,19 +191,19 @@ NORET_TYPE void machine_kexec(struct kim
 
 	page_list[PA_CONTROL_PAGE] = __pa(control_page);
 	page_list[VA_CONTROL_PAGE] = (unsigned long)relocate_kernel;
-	page_list[PA_PGD] = __pa(kexec_pgd);
+	page_list[PA_PGD] = __pa_symbol(&kexec_pgd);
 	page_list[VA_PGD] = (unsigned long)kexec_pgd;
-	page_list[PA_PUD_0] = __pa(kexec_pud0);
+	page_list[PA_PUD_0] = __pa_symbol(&kexec_pud0);
 	page_list[VA_PUD_0] = (unsigned long)kexec_pud0;
-	page_list[PA_PMD_0] = __pa(kexec_pmd0);
+	page_list[PA_PMD_0] = __pa_symbol(&kexec_pmd0);
 	page_list[VA_PMD_0] = (unsigned long)kexec_pmd0;
-	page_list[PA_PTE_0] = __pa(kexec_pte0);
+	page_list[PA_PTE_0] = __pa_symbol(&kexec_pte0);
 	page_list[VA_PTE_0] = (unsigned long)kexec_pte0;
-	page_list[PA_PUD_1] = __pa(kexec_pud1);
+	page_list[PA_PUD_1] = __pa_symbol(&kexec_pud1);
 	page_list[VA_PUD_1] = (unsigned long)kexec_pud1;
-	page_list[PA_PMD_1] = __pa(kexec_pmd1);
+	page_list[PA_PMD_1] = __pa_symbol(&kexec_pmd1);
 	page_list[VA_PMD_1] = (unsigned long)kexec_pmd1;
-	page_list[PA_PTE_1] = __pa(kexec_pte1);
+	page_list[PA_PTE_1] = __pa_symbol(&kexec_pte1);
 	page_list[VA_PTE_1] = (unsigned long)kexec_pte1;
 
 	page_list[PA_TABLE_PAGE] =
diff -puN arch/x86_64/kernel/setup.c~x86_64-__pa-and-__pa_symbol-address-space-separation arch/x86_64/kernel/setup.c
--- linux-2.6.19-rc5-reloc/arch/x86_64/kernel/setup.c~x86_64-__pa-and-__pa_symbol-address-space-separation	2006-11-09 23:05:12.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/kernel/setup.c	2006-11-09 23:05:12.000000000 -0500
@@ -365,11 +365,12 @@ void __init setup_arch(char **cmdline_p)
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
 
 	early_identify_cpu(&boot_cpu_data);
 
diff -puN arch/x86_64/kernel/smp.c~x86_64-__pa-and-__pa_symbol-address-space-separation arch/x86_64/kernel/smp.c
--- linux-2.6.19-rc5-reloc/arch/x86_64/kernel/smp.c~x86_64-__pa-and-__pa_symbol-address-space-separation	2006-11-09 23:05:12.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/kernel/smp.c	2006-11-09 23:05:12.000000000 -0500
@@ -76,7 +76,7 @@ static inline void leave_mm(int cpu)
 	if (read_pda(mmu_state) == TLBSTATE_OK)
 		BUG();
 	cpu_clear(cpu, read_pda(active_mm)->cpu_vm_mask);
-	load_cr3(swapper_pg_dir);
+	load_cr3(init_mm.pgd);
 }
 
 /*
diff -puN arch/x86_64/kernel/vsyscall.c~x86_64-__pa-and-__pa_symbol-address-space-separation arch/x86_64/kernel/vsyscall.c
--- linux-2.6.19-rc5-reloc/arch/x86_64/kernel/vsyscall.c~x86_64-__pa-and-__pa_symbol-address-space-separation	2006-11-09 23:05:12.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/kernel/vsyscall.c	2006-11-09 23:05:12.000000000 -0500
@@ -46,6 +46,12 @@ int __vgetcpu_mode __section_vgetcpu_mod
 
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
@@ -198,10 +204,10 @@ static int vsyscall_sysctl_change(ctl_ta
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
diff -puN arch/x86_64/mm/init.c~x86_64-__pa-and-__pa_symbol-address-space-separation arch/x86_64/mm/init.c
--- linux-2.6.19-rc5-reloc/arch/x86_64/mm/init.c~x86_64-__pa-and-__pa_symbol-address-space-separation	2006-11-09 23:05:12.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/mm/init.c	2006-11-09 23:05:12.000000000 -0500
@@ -572,11 +572,11 @@ void free_init_pages(char *what, unsigne
 
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
@@ -586,17 +586,18 @@ void free_initmem(void)
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
@@ -615,7 +616,7 @@ void mark_rodata_ro(void)
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
-	free_init_pages("initrd memory", start, end);
+	free_init_pages("initrd memory", __pa(start), __pa(end));
 }
 #endif
 
diff -puN arch/x86_64/mm/pageattr.c~x86_64-__pa-and-__pa_symbol-address-space-separation arch/x86_64/mm/pageattr.c
--- linux-2.6.19-rc5-reloc/arch/x86_64/mm/pageattr.c~x86_64-__pa-and-__pa_symbol-address-space-separation	2006-11-09 23:05:12.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/mm/pageattr.c	2006-11-09 23:05:12.000000000 -0500
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
@@ -108,7 +107,8 @@ static void revert_page(unsigned long ad
 	BUG_ON(pud_none(*pud));
 	pmd = pmd_offset(pud, address);
 	BUG_ON(pmd_val(*pmd) & _PAGE_PSE);
-	large_pte = mk_pte_phys(__pa(address) & LARGE_PAGE_MASK, ref_prot);
+	large_pte = mk_pte_phys((pfn << PAGE_SHIFT) & LARGE_PAGE_MASK,
+					ref_prot);
 	large_pte = pte_mkhuge(large_pte);
 	set_pte((pte_t *)pmd, large_pte);
 }      
@@ -133,7 +133,8 @@ __change_page_attr(unsigned long address
  			 */
 			struct page *split;
 			ref_prot2 = pte_pgprot(pte_clrhuge(*kpte));
-			split = split_large_page(address, prot, ref_prot2);
+			split = split_large_page(pfn << PAGE_SHIFT, prot,
+							ref_prot2);
 			if (!split)
 				return -ENOMEM;
 			set_pte(kpte, mk_pte(split, ref_prot2));
@@ -152,7 +153,7 @@ __change_page_attr(unsigned long address
 
 	if (page_private(kpte_page) == 0) {
 		save_page(kpte_page);
-		revert_page(address, ref_prot);
+		revert_page(address, pfn, ref_prot);
  	}
 	return 0;
 } 
@@ -172,6 +173,7 @@ __change_page_attr(unsigned long address
  */
 int change_page_attr_addr(unsigned long address, int numpages, pgprot_t prot)
 {
+	unsigned long phys_base_pfn = __pa_symbol(__START_KERNEL_map) >> PAGE_SHIFT;
 	int err = 0; 
 	int i; 
 
@@ -184,10 +186,11 @@ int change_page_attr_addr(unsigned long 
 			break; 
 		/* Handle kernel mapping too which aliases part of the
 		 * lowmem */
-		if (__pa(address) < KERNEL_TEXT_SIZE) {
+		if ((pfn >= phys_base_pfn) &&
+			((pfn - phys_base_pfn) < (KERNEL_TEXT_SIZE >> PAGE_SHIFT))) {
 			unsigned long addr2;
 			pgprot_t prot2;
-			addr2 = __START_KERNEL_map + __pa(address);
+			addr2 = __START_KERNEL_map + ((pfn - phys_base_pfn) << PAGE_SHIFT);
 			/* Make sure the kernel mappings stay executable */
 			prot2 = pte_pgprot(pte_mkexec(pfn_pte(0, prot)));
 			err = __change_page_attr(addr2, pfn, prot2,
diff -puN include/asm-x86_64/page.h~x86_64-__pa-and-__pa_symbol-address-space-separation include/asm-x86_64/page.h
--- linux-2.6.19-rc5-reloc/include/asm-x86_64/page.h~x86_64-__pa-and-__pa_symbol-address-space-separation	2006-11-09 23:05:12.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/include/asm-x86_64/page.h	2006-11-09 23:05:12.000000000 -0500
@@ -102,17 +102,15 @@ typedef struct { unsigned long pgprot; }
 
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
diff -puN include/asm-x86_64/pgtable.h~x86_64-__pa-and-__pa_symbol-address-space-separation include/asm-x86_64/pgtable.h
--- linux-2.6.19-rc5-reloc/include/asm-x86_64/pgtable.h~x86_64-__pa-and-__pa_symbol-address-space-separation	2006-11-09 23:05:12.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/include/asm-x86_64/pgtable.h	2006-11-09 23:05:12.000000000 -0500
@@ -20,7 +20,7 @@ extern pmd_t level2_kernel_pgt[512];
 extern pgd_t init_level4_pgt[];
 extern unsigned long __supported_pte_mask;
 
-#define swapper_pg_dir init_level4_pgt
+#define swapper_pg_dir ((pgd_t *)NULL)
 
 extern void paging_init(void);
 extern void clear_kernel_mapping(unsigned long addr, unsigned long size);
@@ -30,7 +30,7 @@ extern void clear_kernel_mapping(unsigne
  * for zero-mapped memory areas etc..
  */
 extern unsigned long empty_zero_page[PAGE_SIZE/sizeof(unsigned long)];
-#define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
+#define ZERO_PAGE(vaddr) (pfn_to_page(__pa_symbol(&empty_zero_page) >> PAGE_SHIFT))
 
 #endif /* !__ASSEMBLY__ */
 
_
