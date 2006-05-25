Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWEYCjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWEYCjg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 22:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWEYCjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 22:39:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63894 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964815AbWEYCjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 22:39:35 -0400
To: Magnus Damm <magnus@valinux.co.jp>
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Fastboot] [PATCH 02/03] kexec: Avoid overwriting the current
 pgd (V2, i386)
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	<20060524044242.14219.50618.sendpatchset@cherry.local>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 24 May 2006 20:38:36 -0600
In-Reply-To: <20060524044242.14219.50618.sendpatchset@cherry.local> (Magnus
 Damm's message of "Wed, 24 May 2006 13:40:41 +0900 (JST)")
Message-ID: <m11wuiu8ur.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm <magnus@valinux.co.jp> writes:

> --===============18843918423041384==
>
> kexec: Avoid overwriting the current pgd (V2, i386)
>
> This patch upgrades the i386-specific kexec code to avoid overwriting the
> current pgd. Overwriting the current pgd is bad when CONFIG_CRASH_DUMP is used
> to start a secondary kernel that dumps the memory of the previous kernel.
>
> The code introduces a new set of page tables called "page_table_a". These
> tables are used to provide an executable identity mapping without overwriting
> the current pgd. This updated version of the patch fixes a PAE bug and moves
> the segment handling code into the reloacte_kernel.S.
>
> Signed-off-by: Magnus Damm <magnus@valinux.co.jp>

So the overall approach of just mapping the control code buffer in a page
table both physically and virtually appears sound.

However the implementation can stand some more refinement.

> ---
>
>  The patch has been tested with regular kexec and CONFIG_CRASH_DUMP.
>  Both PAE and non-PAE configurations work well.
>  Applies on top of 2.6.16 and 2.6.17-rc4.
>
>  arch/i386/kernel/machine_kexec.c   |  230 ++++++++++++++----------------------
>  arch/i386/kernel/relocate_kernel.S |   92 ++++++++++++++
>  include/asm-i386/kexec.h           |   12 +
>  3 files changed, 192 insertions(+), 142 deletions(-)
>
> --- 0001/arch/i386/kernel/machine_kexec.c
> +++ work/arch/i386/kernel/machine_kexec.c 2006-05-22 15:57:50.000000000 +0900
> @@ -2,6 +2,10 @@
>   * machine_kexec.c - handle transition of Linux booting another kernel
>   * Copyright (C) 2002-2005 Eric Biederman  <ebiederm@xmission.com>
>   *
> + * 2006-05-19 Magnus Damm <damm@opensource.se>:
> + * - rewrote identity map code to avoid overwriting current pgd
> + * - moved segment handling code into relocate_kernel.S

If you give the right justification for this I could be presuaded to see that
it is sane.  But it is a completely different issue and should be treated
as such.

> + *
>   * This source code is licensed under the GNU General Public License,
>   * Version 2.  See the file COPYING for more details.
>   */
> @@ -19,123 +23,73 @@
>  #include <asm/desc.h>
>  #include <asm/system.h>
>  
> -#define PAGE_ALIGNED __attribute__ ((__aligned__(PAGE_SIZE)))
> -
> -#define L0_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
> -#define L1_ATTR (_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
> -#define L2_ATTR (_PAGE_PRESENT)
> -
> -#define LEVEL0_SIZE (1UL << 12UL)
> +typedef asmlinkage NORET_TYPE void (*relocate_new_kernel_t)(
> +					unsigned long indirection_page,
> +					unsigned long reboot_code_buffer,
> +					unsigned long start_address,
> +					unsigned long page_table_a,
> +					unsigned long has_pae) ATTRIB_NORET;
>  
> -#ifndef CONFIG_X86_PAE
> -#define LEVEL1_SIZE (1UL << 22UL)
> -static u32 pgtable_level1[1024] PAGE_ALIGNED;
> +const extern unsigned char relocate_new_kernel[];
> +extern void relocate_new_kernel_end(void);
> +const extern unsigned int relocate_new_kernel_size;
>  
> -static void identity_map_page(unsigned long address)
> +static int allocate_page_table_a(struct kimage *image)
>  {
> -	unsigned long level1_index, level2_index;
> -	u32 *pgtable_level2;
> -
> -	/* Find the current page table */
> -	pgtable_level2 = __va(read_cr3());
> +	struct kimage_arch *arch = &image->arch_data;
> +	struct page *page;
> +	int k = sizeof(arch->page_table_a) / sizeof(arch->page_table_a[0]);
> +
> +	for (; k > 0; k--) {
> +		page = kimage_alloc_control_pages(image, 0);
> +		if (!page)
> +			return -ENOMEM;
> +
> +		clear_page(page_address(page));
> +		arch->page_table_a[k - 1] = page;
> +	}
>  
> -	/* Find the indexes of the physical address to identity map */
> -	level1_index = (address % LEVEL1_SIZE)/LEVEL0_SIZE;
> -	level2_index = address / LEVEL1_SIZE;
> -
> -	/* Identity map the page table entry */
> -	pgtable_level1[level1_index] = address | L0_ATTR;
> -	pgtable_level2[level2_index] = __pa(pgtable_level1) | L1_ATTR;
> -
> -	/* Flush the tlb so the new mapping takes effect.
> -	 * Global tlb entries are not flushed but that is not an issue.
> -	 */
> -	load_cr3(pgtable_level2);
> +	return 0;
>  }
>  
> -#else
> -#define LEVEL1_SIZE (1UL << 21UL)
> -#define LEVEL2_SIZE (1UL << 30UL)
> -static u64 pgtable_level1[512] PAGE_ALIGNED;
> -static u64 pgtable_level2[512] PAGE_ALIGNED;
> -
> -static void identity_map_page(unsigned long address)
> -{
> -	unsigned long level1_index, level2_index, level3_index;
> -	u64 *pgtable_level3;
> +/* workaround for include/asm-i386/pgtable-3level.h */
>  
> -	/* Find the current page table */
> -	pgtable_level3 = __va(read_cr3());
> -
> -	/* Find the indexes of the physical address to identity map */
> -	level1_index = (address % LEVEL1_SIZE)/LEVEL0_SIZE;
> -	level2_index = (address % LEVEL2_SIZE)/LEVEL1_SIZE;
> -	level3_index = address / LEVEL2_SIZE;
> -
> -	/* Identity map the page table entry */
> -	pgtable_level1[level1_index] = address | L0_ATTR;
> -	pgtable_level2[level2_index] = __pa(pgtable_level1) | L1_ATTR;
> -	set_64bit(&pgtable_level3[level3_index],
> -					       __pa(pgtable_level2) | L2_ATTR);
> -
> -	/* Flush the tlb so the new mapping takes effect.
> -	 * Global tlb entries are not flushed but that is not an issue.
> -	 */
> -	load_cr3(pgtable_level3);
> -}
> +#ifdef CONFIG_X86_PAE
> +#undef pgd_present
> +#define pgd_present(pgd) (pgd_val(pgd) & _PAGE_PRESENT)
> +#define _PGD_ATTR _PAGE_PRESENT
> +#else
> +#define _PGD_ATTR _KERNPG_TABLE
>  #endif

Ok.  This is just horrible.  Please don't use helper functions that are not
appropriate for the task.  There is a reason I defined my own helper macros.

> -static void set_idt(void *newidt, __u16 limit)
> -{
> -	struct Xgt_desc_struct curidt;
> -
> -	/* ia32 supports unaliged loads & stores */
> -	curidt.size    = limit;
> -	curidt.address = (unsigned long)newidt;
> -
> -	load_idt(&curidt);
> -};

Gratuitous code removal that makes the code less accessible, to other programmers.
The code is already barely comprehensible.

> +#define pa_page(page) __pa(page_address(page))
>  
> -
> -static void set_gdt(void *newgdt, __u16 limit)
> +static int create_mapping(struct page *root, struct page **pages, 
> +			  unsigned long va, unsigned long pa)
>  {
> -	struct Xgt_desc_struct curgdt;
> -
> -	/* ia32 supports unaligned loads & stores */
> -	curgdt.size    = limit;
> -	curgdt.address = (unsigned long)newgdt;
> +	pgd_t *pgd;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +	pte_t *pte;
> +	int k = 0;
>  
> -	load_gdt(&curgdt);
> -};
> +	pgd = (pgd_t *)page_address(root) + pgd_index(va);
> +	if (!pgd_present(*pgd))
> +		set_pgd(pgd, __pgd(pa_page(pages[k++]) | _PGD_ATTR));
>  
> -static void load_segments(void)
> -{
> -#define __STR(X) #X
> -#define STR(X) __STR(X)
> +	pud = pud_offset(pgd, va);
> +	if (!pud_present(*pud))
> +		set_pud(pud, __pud(pa_page(pages[k++]) | _KERNPG_TABLE));
>  
> -	__asm__ __volatile__ (
> -		"\tljmp $"STR(__KERNEL_CS)",$1f\n"
> -		"\t1:\n"
> -		"\tmovl $"STR(__KERNEL_DS)",%%eax\n"
> -		"\tmovl %%eax,%%ds\n"
> -		"\tmovl %%eax,%%es\n"
> -		"\tmovl %%eax,%%fs\n"
> -		"\tmovl %%eax,%%gs\n"
> -		"\tmovl %%eax,%%ss\n"
> -		::: "eax", "memory");
> -#undef STR
> -#undef __STR
> -}
> +	pmd = pmd_offset(pud, va);
> +	if (!pmd_present(*pmd))
> +		set_pmd(pmd, __pmd(pa_page(pages[k++]) | _KERNPG_TABLE));
>  
> -typedef asmlinkage NORET_TYPE void (*relocate_new_kernel_t)(
> -					unsigned long indirection_page,
> -					unsigned long reboot_code_buffer,
> -					unsigned long start_address,
> -					unsigned int has_pae) ATTRIB_NORET;
> +	pte = (pte_t *)page_address(pmd_page(*pmd)) + pte_index(va);
> +	set_pte(pte, __pte(pa | _PAGE_KERNEL_EXEC));
>  
> -const extern unsigned char relocate_new_kernel[];
> -extern void relocate_new_kernel_end(void);
> -const extern unsigned int relocate_new_kernel_size;
> +	return k;
> +}
>  
>  /*
>   * A architecture hook called to validate the
> @@ -147,11 +101,38 @@ const extern unsigned int relocate_new_k
>   * Do what every setup is needed on image and the
>   * reboot code buffer to allow us to avoid allocations
>   * later.
> - *
> - * Currently nothing.
>   */
>  int machine_kexec_prepare(struct kimage *image)
>  {
> +	void *control_page;
> +	unsigned long pa;
> +	int k;
> +
> +	memset(&image->arch_data, 0, sizeof(image->arch_data));
> +
> +	k = allocate_page_table_a(image);
> +	if (k)
> +		return k;
> +
> +	/* fill in control_page with assembly code */
> +
> +	control_page = page_address(image->control_code_page);
> +	memcpy(control_page, relocate_new_kernel, relocate_new_kernel_size);
> +
> +	/* map the control_page at the virtual address of relocate_kernel.S */
> +
> +	pa = __pa(control_page);
> +
> +	k = create_mapping(image->arch_data.page_table_a[0], 
> +			   &image->arch_data.page_table_a[1],
> +			   (unsigned long)relocate_new_kernel, pa);
> +
> +	/* identity map the control_page */
> +
> +	create_mapping(image->arch_data.page_table_a[0], 
> +		       &image->arch_data.page_table_a[k + 1],
> +		       pa, pa);
> +
>  	return 0;
>  }
>  
> @@ -170,45 +151,16 @@ void machine_kexec_cleanup(struct kimage
>  NORET_TYPE void machine_kexec(struct kimage *image)
>  {
>  	unsigned long page_list;
> -	unsigned long reboot_code_buffer;
> -
> +	unsigned long control_code;
> +	unsigned long page_table_a;
>  	relocate_new_kernel_t rnk;
>  
> -	/* Interrupts aren't acceptable while we reboot */
> -	local_irq_disable();
> -
> -	/* Compute some offsets */
> -	reboot_code_buffer = page_to_pfn(image->control_code_page)
> -								<< PAGE_SHIFT;
>  	page_list = image->head;
> -
> -	/* Set up an identity mapping for the reboot_code_buffer */
> -	identity_map_page(reboot_code_buffer);
> -
> -	/* copy it out */
> -	memcpy((void *)reboot_code_buffer, relocate_new_kernel,
> -						relocate_new_kernel_size);
> -
> -	/* The segment registers are funny things, they are
> -	 * automatically loaded from a table, in memory wherever you
> -	 * set them to a specific selector, but this table is never
> -	 * accessed again you set the segment to a different selector.
> -	 *
> -	 * The more common model is are caches where the behide
> -	 * the scenes work is done, but is also dropped at arbitrary
> -	 * times.
> -	 *
> -	 * I take advantage of this here by force loading the
> -	 * segments, before I zap the gdt with an invalid value.
> -	 */
> -	load_segments();
> -	/* The gdt & idt are now invalid.
> -	 * If you want to load them you must set up your own idt & gdt.
> -	 */
> -	set_gdt(phys_to_virt(0),0);
> -	set_idt(phys_to_virt(0),0);
> +	control_code = __pa(page_address(image->control_code_page));
> +	page_table_a = __pa(page_address(image->arch_data.page_table_a[0]));

These are the wrong helper functions.  You deleted code that properly computes
the address in a portable and future safe fashion. 
i.e. page_to_pfn(image->control_coe_page) << PAGE_SHIFT.

Although it is probably best to both of these if we want to be very safe
at kdump time.

>  	/* now call it */
> -	rnk = (relocate_new_kernel_t) reboot_code_buffer;
> -	(*rnk)(page_list, reboot_code_buffer, image->start, cpu_has_pae);
> +	rnk = (relocate_new_kernel_t) relocate_new_kernel;
> +	(*rnk)(page_list, control_code, image->start, 
> +	       page_table_a, (unsigned long)cpu_has_pae);
>  }
> --- 0001/arch/i386/kernel/relocate_kernel.S
> +++ work/arch/i386/kernel/relocate_kernel.S 2006-05-22 12:55:37.000000000 +0900
> @@ -2,12 +2,20 @@
>   * relocate_kernel.S - put the kernel image in place to boot
>   * Copyright (C) 2002-2004 Eric Biederman  <ebiederm@xmission.com>
>   *
> + * 2006-05-19 Magnus Damm <damm@opensource.se>:
> + * - moved segment handling code from machine_kexec.c
> + * - gdt tables stolen from arch/i386/boot/setup.S
> + *
>   * This source code is licensed under the GNU General Public License,
>   * Version 2.  See the file COPYING for more details.
>   */
>  
>  #include <linux/linkage.h>
> +#include <asm/page.h>
>  
> +.text
> +.align (1 << PAGE_SHIFT)
> +	

How does this new alignment help.

>  	/*
>  	 * Must be relocatable PIC code callable as a C function, that once
>  	 * it starts can not use the previous processes stack.
> @@ -18,18 +26,68 @@ relocate_new_kernel:
>  	movl  4(%esp), %ebx /* page_list */
>  	movl  8(%esp), %ebp /* reboot_code_buffer */
>  	movl  12(%esp), %edx /* start address */
> -	movl  16(%esp), %ecx /* cpu_has_pae */
> +	movl  16(%esp), %edi /* page_table_a */
> +	movl  20(%esp), %ecx /* cpu_has_pae */
>  
>  	/* zero out flags, and disable interrupts */
>  	pushl $0
>  	popfl
>  
> +	/* switch to page_table_a */
> +	movl	%edi, %eax
> +	movl	%eax, %cr3
> +
> +	/* setup idt */
> +
> +	movl	%ebp, %eax
> +	addl	$(idt_48 - relocate_new_kernel), %eax
> +	lidtl	(%eax)
> +
> +	/* setup gdt */
> +
> +	movl	%ebp, %eax
> +	addl	$(gdt - relocate_new_kernel), %eax
> +	movl	%ebp, %esi
> +	addl	$((gdt_48 - relocate_new_kernel) + 2), %esi
> +	movl	%eax, (%esi)
> +	
> +	movl	%ebp, %eax
> +	addl	$(gdt_48 - relocate_new_kernel), %eax
> +	lgdtl	(%eax)
> +
> +	/* setup data segment registers */
> +	
> +	mov	$(gdt_ds - gdt), %eax
> +	mov	%eax, %ds
> +	mov	%eax, %es
> +	mov	%eax, %fs
> +	mov	%eax, %gs
> +	mov	%eax, %ss
> +
>  	/* set a new stack at the bottom of our page... */
>  	lea   4096(%ebp), %esp
>  
> +	/* load new code segment */
> +
> +	movl	%ebp, %esi
> +	xorl	%eax, %eax
> +	pushl	%eax
> +	pushl	%esi
> +	pushl	%eax
> +	
> +	movl	$(gdt_cs - gdt), %eax
> +	pushl	%eax
> +	
> +	movl	%ebp, %eax
> +	addl	$(identity_mapped - relocate_new_kernel),%eax
> +	pushl	%eax
> +	iretl
> +
> +identity_mapped:	
> +
>  	/* store the parameters back on the stack */
>  	pushl   %edx /* store the start address */
> -
> +	

This is a gratuitous addition of white space.

>  	/* Set cr0 to a known state:
>  	 * 31 0 == Paging disabled
>  	 * 18 0 == Alignment check disabled
> @@ -113,6 +171,36 @@ relocate_new_kernel:
>  	xorl    %edi, %edi
>  	xorl    %ebp, %ebp
>  	ret
> +
> +	.align	16
> +gdt:
> +	.fill	1,8,0
> +
> +gdt_cs:	
> +	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
> +	.word	0				# base address = 0
> +	.word	0x9A00				# code read/exec
> +	.word	0x00CF				# granularity = 4096, 386
> +						#  (+5th nibble of limit)
> +gdt_ds:
> +	.word	0xFFFF				# 4Gb - (0x100000*0x1000 = 4Gb)
> +	.word	0				# base address = 0
> +	.word	0x9200				# data read/write
> +	.word	0x00CF				# granularity = 4096, 386
> +						#  (+5th nibble of limit)
> +gdt_end:
> +	.align	4
> +	
> +	.word	0				# alignment byte
> +idt_48:
> +	.word	0				# idt limit = 0
> +	.word	0, 0				# idt base = 0L
> +
> +	.word	0				# alignment byte
> +gdt_48:
> +	.word	gdt_end - gdt - 1		# gdt limit
> +	.word	0, 0				# gdt base (filled in later)
> +	
>  relocate_new_kernel_end:
>  
>  	.globl relocate_new_kernel_size
> --- 0002/include/asm-i386/kexec.h
> +++ work/include/asm-i386/kexec.h	2006-05-22 12:55:38.000000000 +0900
> @@ -29,7 +29,17 @@
>  
>  #define MAX_NOTE_BYTES 1024
>  
> -struct kimage_arch {};
> +struct kimage_arch {
> +       /* page_table_a[] holds enough pages to create a new page table
> +        * that maps the control page twice..
> +        */
> +
> +#if defined(CONFIG_X86_PAE)
> +       struct page *page_table_a[5]; /* (2 * pte) + (2 * pmd) + pgd */
> +#else
> +       struct page *page_table_a[3]; /* (2 * pte) + pgd */
> +#endif

This is ridiculous.  You only need one pointer to the top of the page
table.  Don't take 5.  Plus a struct page is not the way you need the
data so please just store the physical address you need.


> +};
>  
>  /* CPU does not save ss and esp on stack if execution is already
>   * running in kernel mode at the time of NMI occurrence. This code
>
> --===============18843918423041384==
> Content-Type: text/plain; charset="iso-8859-1"
> MIME-Version: 1.0
> Content-Transfer-Encoding: quoted-printable
> Content-Disposition: inline
>
> _______________________________________________
> fastboot mailing list
> fastboot@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/fastboot
>
> --===============18843918423041384==--
