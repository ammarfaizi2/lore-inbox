Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbVI0X0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVI0X0H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 19:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbVI0X0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 19:26:06 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:18642 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751148AbVI0X0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 19:26:05 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH][Fix] Fix Bug #4959 (take 2)
Date: Wed, 28 Sep 2005 01:26:26 +0200
User-Agent: KMail/1.8.2
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
References: <200509241936.12214.rjw@sisk.pl> <200509272300.37197.rjw@sisk.pl> <20050927210821.GF2040@elf.ucw.cz>
In-Reply-To: <20050927210821.GF2040@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509280126.26701.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 27 of September 2005 23:08, Pavel Machek wrote:
> Hi!
> 
]-- snip --[ 
> > > > The following patch fixes Bug #4959.  For this purpose it creates temporary
> > > > page translation tables including the kernel mapping (reused) and the direct
> > > > mapping (created from scratch) and makes swsusp switch to these tables
> > > > right before the image is restored.
> > > 
> > > Why do you need *two* mappings? Should not just kernel mapping be enough?
> > 
> > The kernel mapping is for the kernel text.  The direct mapping maps the physical
> > RAM linearly to the set of virtual addresses starting at
> > PAGE_OFFSET.
> 
> Could not you just add phys_to_virt at some strategic place? 

No, I need both, but the original kernel mapping is safe, so I don't care (I just point to
it from the temporary PGD).

> > > Why? Reserve ten pages for them... static char resume_page_tables[10*PAGE_SIZE] does not
> > > sound that bad.
> > 
> > That will allow us to suspend if there's no more that 8GB of RAM in the box.
> > Is it acceptable?
> 
> I'd say so.
> 
> > > > Moreover, such a code would have to be executed on every boot and the
> > > > temporary page tables would always be present in memory.
> > > 
> > > Yep, but I do not see that as a big problem.
> > 
> > OK
> > 
> > I can reserve the static buffer (10 pages) in suspend.c and mark it as nosave.
> > The code that creates the mappings can stay in suspend.c either except it
> > won't need to call get_usable_page() and free_eaten_memory() any more
> > (__next_page() can be changed to get pages from the static buffer instead
> > of allocating them).  The code can also be simplified a bit, as we assume that
> > there will be only one PGD entry in the direct mapping.
> > 
> > If that sounds good to you, please confirm.
> 
> 8GB limit seems good to me -- as long as it makes code significantly
> simpler. It would be nice if it was <20 lines.

It is more than that, but it seems to be quite simple anyway.

The new patch follows.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Index: linux-2.6.14-rc2-git6/arch/x86_64/kernel/suspend.c
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/x86_64/kernel/suspend.c	2005-09-28 00:47:43.000000000 +0200
+++ linux-2.6.14-rc2-git6/arch/x86_64/kernel/suspend.c	2005-09-28 01:05:08.000000000 +0200
@@ -11,6 +11,21 @@
 #include <linux/smp.h>
 #include <linux/suspend.h>
 #include <asm/proto.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+#define MAX_RESUME_PUD_ENTRIES	8
+#define MAX_RESUME_RAM_SIZE	(MAX_RESUME_PUD_ENTRIES * PTRS_PER_PMD * PMD_SIZE)
+
+int arch_prepare_suspend(void)
+{
+	if (MAX_RESUME_RAM_SIZE < (end_pfn << PAGE_SHIFT)) {
+		printk(KERN_ERR "Too much RAM for suspend (%lu), max. allowed: %lu",
+			end_pfn << PAGE_SHIFT, MAX_RESUME_RAM_SIZE);
+		return -ENOMEM;
+	}
+	return 0;
+}
 
 struct saved_context saved_context;
 
@@ -140,4 +155,62 @@
 
 }
 
+/* Defined in arch/x86_64/kernel/suspend_asm.S */
+int restore_image(void);
+
+/* References to section boundaries */
+extern const void __nosave_begin, __nosave_end;
 
+pgd_t resume_level4_pgt[PTRS_PER_PGD] __nosavedata;
+pud_t resume_level3_pgt[PTRS_PER_PUD] __nosavedata;
+pmd_t resume_level2_pgt[MAX_RESUME_PUD_ENTRIES*PTRS_PER_PMD] __nosavedata;
+
+static void phys_pud_init(pud_t *pud, unsigned long end)
+{
+	long i, j;
+	pmd_t *pmd = resume_level2_pgt;
+
+	for (i = 0; i < PTRS_PER_PUD; pud++, i++) {
+		unsigned long paddr;
+
+		paddr = i*PUD_SIZE;
+		if (paddr >= end) {
+			for (; i < PTRS_PER_PUD; i++, pud++)
+				set_pud(pud, __pud(0));
+			break;
+		}
+
+		set_pud(pud, __pud(__pa(pmd) | _KERNPG_TABLE));
+		for (j = 0; j < PTRS_PER_PMD; pmd++, j++, paddr += PMD_SIZE) {
+			unsigned long pe;
+
+			if (paddr >= end) {
+				for (; j < PTRS_PER_PMD; j++, pmd++)
+					set_pmd(pmd,  __pmd(0));
+				break;
+			}
+			pe = _PAGE_NX|_PAGE_PSE | _KERNPG_TABLE | _PAGE_GLOBAL | paddr;
+			pe &= __supported_pte_mask;
+			set_pmd(pmd, __pmd(pe));
+		}
+	}
+}
+
+static void set_up_temporary_mappings(void)
+{
+	/* It is safe to reuse the original kernel mapping */
+	set_pgd(resume_level4_pgt + pgd_index(__START_KERNEL_map),
+		init_level4_pgt[pgd_index(__START_KERNEL_map)]);
+
+	/* Set up the direct mapping from scratch */
+	phys_pud_init(resume_level3_pgt, end_pfn << PAGE_SHIFT);
+	set_pgd(resume_level4_pgt + pgd_index(PAGE_OFFSET),
+		mk_kernel_pgd(__pa(resume_level3_pgt)));
+}
+
+int swsusp_arch_resume(void)
+{
+	set_up_temporary_mappings();
+	restore_image();
+	return 0;
+}
Index: linux-2.6.14-rc2-git6/arch/x86_64/kernel/suspend_asm.S
===================================================================
--- linux-2.6.14-rc2-git6.orig/arch/x86_64/kernel/suspend_asm.S	2005-09-28 00:47:43.000000000 +0200
+++ linux-2.6.14-rc2-git6/arch/x86_64/kernel/suspend_asm.S	2005-09-28 00:48:09.000000000 +0200
@@ -39,12 +39,12 @@
 	call swsusp_save
 	ret
 
-ENTRY(swsusp_arch_resume)
-	/* set up cr3 */	
-	leaq	init_level4_pgt(%rip),%rax
-	subq	$__START_KERNEL_map,%rax
-	movq	%rax,%cr3
-
+ENTRY(restore_image)
+	/* switch to temporary page tables */
+	leaq	resume_level4_pgt(%rip), %rax
+	subq	$__START_KERNEL_map, %rax
+	movq	%rax, %cr3
+	/* Flush TLB */
 	movq	mmu_cr4_features(%rip), %rax
 	movq	%rax, %rdx
 	andq	$~(1<<7), %rdx	# PGE
@@ -69,6 +69,10 @@
 	movq	pbe_next(%rdx), %rdx
 	jmp	loop
 done:
+	/* go back to the original page tables */
+	leaq	init_level4_pgt(%rip), %rax
+	subq	$__START_KERNEL_map, %rax
+	movq	%rax, %cr3
 	/* Flush TLB, including "global" things (vmalloc) */
 	movq	mmu_cr4_features(%rip), %rax
 	movq	%rax, %rdx
Index: linux-2.6.14-rc2-git6/include/asm-x86_64/suspend.h
===================================================================
--- linux-2.6.14-rc2-git6.orig/include/asm-x86_64/suspend.h	2005-09-28 00:47:43.000000000 +0200
+++ linux-2.6.14-rc2-git6/include/asm-x86_64/suspend.h	2005-09-28 00:48:09.000000000 +0200
@@ -6,11 +6,7 @@
 #include <asm/desc.h>
 #include <asm/i387.h>
 
-static inline int
-arch_prepare_suspend(void)
-{
-	return 0;
-}
+extern int arch_prepare_suspend(void);
 
 /* Image of the saved processor state. If you touch this, fix acpi_wakeup.S. */
 struct saved_context {
