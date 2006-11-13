Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755196AbWKMQxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196AbWKMQxp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755208AbWKMQxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:53:44 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:8864 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1755196AbWKMQxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:53:43 -0500
Date: Mon, 13 Nov 2006 11:46:05 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com
Subject: [RFC] [PATCH 12/16] x86_64: Remove the identity mapping as early as possible
Message-ID: <20061113164605.GM17429@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061113162135.GA17429@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113162135.GA17429@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



With the rewrite of the SMP trampoline and the early page
allocator there is nothing that needs identity mapped pages,
once we start executing C code.

So add zap_identity_mappings into head64.c and remove
zap_low_mappings() from much later in the code.  The functions
 are subtly different thus the name change.

This also kills boot_level4_pgt which was from an earlier
attempt to move the identity mappings as early as possible,
and is now no longer needed.  Essentially I have replaced
boot_level4_pgt with trampoline_level4_pgt in trampoline.S

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/head.S    |   39 ++++++++++++++-------------------------
 arch/x86_64/kernel/head64.c  |   16 ++++++++++------
 arch/x86_64/kernel/setup.c   |    2 --
 arch/x86_64/kernel/setup64.c |    1 -
 arch/x86_64/mm/init.c        |   24 ------------------------
 include/asm-x86_64/pgtable.h |    1 -
 include/asm-x86_64/proto.h   |    2 --
 7 files changed, 24 insertions(+), 61 deletions(-)

diff -puN arch/x86_64/kernel/head64.c~x86_64-Remove-the-identity-mapping-as-early-as-possible arch/x86_64/kernel/head64.c
--- linux-2.6.19-rc5-reloc/arch/x86_64/kernel/head64.c~x86_64-Remove-the-identity-mapping-as-early-as-possible	2006-11-09 23:04:38.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/kernel/head64.c	2006-11-09 23:04:38.000000000 -0500
@@ -18,8 +18,16 @@
 #include <asm/setup.h>
 #include <asm/desc.h>
 #include <asm/pgtable.h>
+#include <asm/tlbflush.h>
 #include <asm/sections.h>
 
+static void __init zap_identity_mappings(void)
+{
+	pgd_t *pgd = pgd_offset_k(0UL);
+	pgd_clear(pgd);
+	__flush_tlb();
+}
+
 /* Don't add a printk in there. printk relies on the PDA which is not initialized 
    yet. */
 static void __init clear_bss(void)
@@ -56,6 +64,8 @@ void __init x86_64_start_kernel(char * r
 {
 	int i;
 
+	/* Make NULL pointers segfault */
+	zap_identity_mappings();
 	for (i = 0; i < 256; i++)
 		set_intr_gate(i, early_idt_handler);
 	asm volatile("lidt %0" :: "m" (idt_descr));
@@ -63,12 +73,6 @@ void __init x86_64_start_kernel(char * r
 
 	early_printk("Kernel alive\n");
 
-	/*
-	 * switch to init_level4_pgt from boot_level4_pgt
-	 */
-	memcpy(init_level4_pgt, boot_level4_pgt, PTRS_PER_PGD*sizeof(pgd_t));
-	asm volatile("movq %0,%%cr3" :: "r" (__pa_symbol(&init_level4_pgt)));
-
  	for (i = 0; i < NR_CPUS; i++)
  		cpu_pda(i) = &boot_cpu_pda[i];
 
diff -puN arch/x86_64/kernel/head.S~x86_64-Remove-the-identity-mapping-as-early-as-possible arch/x86_64/kernel/head.S
--- linux-2.6.19-rc5-reloc/arch/x86_64/kernel/head.S~x86_64-Remove-the-identity-mapping-as-early-as-possible	2006-11-09 23:04:38.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/kernel/head.S	2006-11-09 23:04:38.000000000 -0500
@@ -71,7 +71,7 @@ startup_32:
 	movl	%eax, %cr4
 
 	/* Setup early boot stage 4 level pagetables */
-	movl	$(boot_level4_pgt - __START_KERNEL_map), %eax
+	movl	$(init_level4_pgt - __START_KERNEL_map), %eax
 	movl	%eax, %cr3
 
 	/* Setup EFER (Extended Feature Enable Register) */
@@ -115,7 +115,7 @@ ENTRY(secondary_startup_64)
 	movq	%rax, %cr4
 
 	/* Setup early boot stage 4 level pagetables. */
-	movq	$(boot_level4_pgt - __START_KERNEL_map), %rax
+	movq	$(init_level4_pgt - __START_KERNEL_map), %rax
 	movq	%rax, %cr3
 
 	/* Check if nx is implemented */
@@ -266,9 +266,19 @@ ENTRY(name)
 	i = i + 1 ;				\
 	.endr
 
+	/*
+	 * This default setting generates an ident mapping at address 0x100000
+	 * and a mapping for the kernel that precisely maps virtual address
+	 * 0xffffffff80000000 to physical address 0x000000. (always using
+	 * 2Mbyte large pages provided by PAE mode)
+	 */
 NEXT_PAGE(init_level4_pgt)
-	/* This gets initialized in x86_64_start_kernel */
-	.fill	512,8,0
+	.quad	level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE
+	.fill	257,8,0
+	.quad	level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE
+	.fill	252,8,0
+	/* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
+	.quad	level3_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE
 
 NEXT_PAGE(level3_ident_pgt)
 	.quad	level2_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE
@@ -299,27 +309,6 @@ NEXT_PAGE(level2_kernel_pgt)
 #undef NEXT_PAGE
 
 	.data
-
-#ifndef CONFIG_HOTPLUG_CPU
-	__INITDATA
-#endif
-	/*
-	 * This default setting generates an ident mapping at address 0x100000
-	 * and a mapping for the kernel that precisely maps virtual address
-	 * 0xffffffff80000000 to physical address 0x000000. (always using
-	 * 2Mbyte large pages provided by PAE mode)
-	 */
-	.align PAGE_SIZE
-ENTRY(boot_level4_pgt)
-	.quad	level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE
-	.fill	257,8,0
-	.quad	level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE
-	.fill	252,8,0
-	/* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
-	.quad	level3_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE
-
-	.data
-
 	.align 16
 	.globl cpu_gdt_descr
 cpu_gdt_descr:
diff -puN arch/x86_64/kernel/setup64.c~x86_64-Remove-the-identity-mapping-as-early-as-possible arch/x86_64/kernel/setup64.c
--- linux-2.6.19-rc5-reloc/arch/x86_64/kernel/setup64.c~x86_64-Remove-the-identity-mapping-as-early-as-possible	2006-11-09 23:04:38.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/kernel/setup64.c	2006-11-09 23:04:38.000000000 -0500
@@ -202,7 +202,6 @@ void __cpuinit cpu_init (void)
 	/* CPU 0 is initialised in head64.c */
 	if (cpu != 0) {
 		pda_init(cpu);
-		zap_low_mappings(cpu);
 	} else 
 		estacks = boot_exception_stacks; 
 
diff -puN arch/x86_64/kernel/setup.c~x86_64-Remove-the-identity-mapping-as-early-as-possible arch/x86_64/kernel/setup.c
--- linux-2.6.19-rc5-reloc/arch/x86_64/kernel/setup.c~x86_64-Remove-the-identity-mapping-as-early-as-possible	2006-11-09 23:04:38.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/kernel/setup.c	2006-11-09 23:04:38.000000000 -0500
@@ -396,8 +396,6 @@ void __init setup_arch(char **cmdline_p)
 
 	dmi_scan_machine();
 
-	zap_low_mappings(0);
-
 #ifdef CONFIG_ACPI
 	/*
 	 * Initialize the ACPI boot-time table parser (gets the RSDP and SDT).
diff -puN arch/x86_64/mm/init.c~x86_64-Remove-the-identity-mapping-as-early-as-possible arch/x86_64/mm/init.c
--- linux-2.6.19-rc5-reloc/arch/x86_64/mm/init.c~x86_64-Remove-the-identity-mapping-as-early-as-possible	2006-11-09 23:04:38.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/mm/init.c	2006-11-09 23:04:38.000000000 -0500
@@ -378,21 +378,6 @@ void __meminit init_memory_mapping(unsig
 	__flush_tlb_all();
 }
 
-void __cpuinit zap_low_mappings(int cpu)
-{
-	if (cpu == 0) {
-		pgd_t *pgd = pgd_offset_k(0UL);
-		pgd_clear(pgd);
-	} else {
-		/*
-		 * For AP's, zap the low identity mappings by changing the cr3
-		 * to init_level4_pgt and doing local flush tlb all
-		 */
-		asm volatile("movq %0,%%cr3" :: "r" (__pa_symbol(&init_level4_pgt)));
-	}
-	__flush_tlb_all();
-}
-
 #ifndef CONFIG_NUMA
 void __init paging_init(void)
 {
@@ -576,15 +561,6 @@ void __init mem_init(void)
 		reservedpages << (PAGE_SHIFT-10),
 		datasize >> 10,
 		initsize >> 10);
-
-#ifdef CONFIG_SMP
-	/*
-	 * Sync boot_level4_pgt mappings with the init_level4_pgt
-	 * except for the low identity mappings which are already zapped
-	 * in init_level4_pgt. This sync-up is essential for AP's bringup
-	 */
-	memcpy(boot_level4_pgt+1, init_level4_pgt+1, (PTRS_PER_PGD-1)*sizeof(pgd_t));
-#endif
 }
 
 void free_init_pages(char *what, unsigned long begin, unsigned long end)
diff -puN include/asm-x86_64/pgtable.h~x86_64-Remove-the-identity-mapping-as-early-as-possible include/asm-x86_64/pgtable.h
--- linux-2.6.19-rc5-reloc/include/asm-x86_64/pgtable.h~x86_64-Remove-the-identity-mapping-as-early-as-possible	2006-11-09 23:04:38.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/include/asm-x86_64/pgtable.h	2006-11-09 23:04:38.000000000 -0500
@@ -18,7 +18,6 @@ extern pud_t level3_kernel_pgt[512];
 extern pud_t level3_ident_pgt[512];
 extern pmd_t level2_kernel_pgt[512];
 extern pgd_t init_level4_pgt[];
-extern pgd_t boot_level4_pgt[];
 extern unsigned long __supported_pte_mask;
 
 #define swapper_pg_dir init_level4_pgt
diff -puN include/asm-x86_64/proto.h~x86_64-Remove-the-identity-mapping-as-early-as-possible include/asm-x86_64/proto.h
--- linux-2.6.19-rc5-reloc/include/asm-x86_64/proto.h~x86_64-Remove-the-identity-mapping-as-early-as-possible	2006-11-09 23:04:38.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/include/asm-x86_64/proto.h	2006-11-09 23:04:38.000000000 -0500
@@ -11,8 +11,6 @@ struct pt_regs;
 extern void start_kernel(void);
 extern void pda_init(int); 
 
-extern void zap_low_mappings(int cpu);
-
 extern void early_idt_handler(void);
 
 extern void mcheck_init(struct cpuinfo_x86 *c);
_
