Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161134AbWHALIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbWHALIp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWHALHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:07:05 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17629 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932629AbWHALGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:06:40 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 28/33] x86_64: Remove the identity mapping as early as possible.
Date: Tue,  1 Aug 2006 05:03:43 -0600
Message-Id: <11544302462613-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
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
---
 arch/x86_64/kernel/head.S    |   34 ++++++++++++++--------------------
 arch/x86_64/kernel/head64.c  |   16 ++++++++++------
 arch/x86_64/kernel/setup.c   |    2 --
 arch/x86_64/kernel/setup64.c |    1 -
 arch/x86_64/mm/init.c        |   24 ------------------------
 include/asm-x86_64/pgtable.h |    1 -
 include/asm-x86_64/proto.h   |    2 --
 7 files changed, 24 insertions(+), 56 deletions(-)

diff --git a/arch/x86_64/kernel/head.S b/arch/x86_64/kernel/head.S
index a624586..b0b5618 100644
--- a/arch/x86_64/kernel/head.S
+++ b/arch/x86_64/kernel/head.S
@@ -73,7 +73,7 @@ startup_32:
 	movl	%eax, %cr4
 
 	/* Setup early boot stage 4 level pagetables */
-	movl	$(boot_level4_pgt - __START_KERNEL_map), %eax
+	movl	$(init_level4_pgt - __START_KERNEL_map), %eax
 	movl	%eax, %cr3
 
 	/* Setup EFER (Extended Feature Enable Register) */
@@ -117,7 +117,7 @@ ENTRY(secondary_startup_64)
 	movq	%rax, %cr4
 
 	/* Setup early boot stage 4 level pagetables. */
-	movq	$(boot_level4_pgt - __START_KERNEL_map), %rax
+	movq	$(init_level4_pgt - __START_KERNEL_map), %rax
 	movq	%rax, %cr3
 
 	/* Check if nx is implemented */
@@ -264,9 +264,19 @@ #define PMDS(START, PERM, COUNT)		\
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
@@ -301,22 +311,6 @@ #undef NEXT_PAGE
 #ifndef CONFIG_HOTPLUG_CPU
 	__INITDATA
 #endif
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
 
 	.align 16
 	.globl cpu_gdt_descr
diff --git a/arch/x86_64/kernel/head64.c b/arch/x86_64/kernel/head64.c
index defef4e..99d4463 100644
--- a/arch/x86_64/kernel/head64.c
+++ b/arch/x86_64/kernel/head64.c
@@ -18,8 +18,16 @@ #include <asm/bootsetup.h>
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
@@ -78,6 +86,8 @@ void __init x86_64_start_kernel(char * r
 	char *s;
 	int i;
 
+	/* Make NULL pointers segfault */
+	zap_identity_mappings();
 	for (i = 0; i < 256; i++)
 		set_intr_gate(i, early_idt_handler);
 	asm volatile("lidt %0" :: "m" (idt_descr));
@@ -88,12 +98,6 @@ void __init x86_64_start_kernel(char * r
 	 */
 	lockdep_init();
 
-	/*
-	 * switch to init_level4_pgt from boot_level4_pgt
-	 */
-	memcpy(init_level4_pgt, boot_level4_pgt, PTRS_PER_PGD*sizeof(pgd_t));
-	asm volatile("movq %0,%%cr3" :: "r" (__pa_symbol(&init_level4_pgt)));
-
  	for (i = 0; i < NR_CPUS; i++)
  		cpu_pda(i) = &boot_cpu_pda[i];
 
diff --git a/arch/x86_64/kernel/setup.c b/arch/x86_64/kernel/setup.c
index 21840ca..7225f61 100644
--- a/arch/x86_64/kernel/setup.c
+++ b/arch/x86_64/kernel/setup.c
@@ -568,8 +568,6 @@ #endif
 
 	dmi_scan_machine();
 
-	zap_low_mappings(0);
-
 #ifdef CONFIG_ACPI
 	/*
 	 * Initialize the ACPI boot-time table parser (gets the RSDP and SDT).
diff --git a/arch/x86_64/kernel/setup64.c b/arch/x86_64/kernel/setup64.c
index 6fe58a6..a1f3aed 100644
--- a/arch/x86_64/kernel/setup64.c
+++ b/arch/x86_64/kernel/setup64.c
@@ -197,7 +197,6 @@ void __cpuinit cpu_init (void)
 	/* CPU 0 is initialised in head64.c */
 	if (cpu != 0) {
 		pda_init(cpu);
-		zap_low_mappings(cpu);
 	} else 
 		estacks = boot_exception_stacks; 
 
diff --git a/arch/x86_64/mm/init.c b/arch/x86_64/mm/init.c
index b46566a..149f363 100644
--- a/arch/x86_64/mm/init.c
+++ b/arch/x86_64/mm/init.c
@@ -332,21 +332,6 @@ void __init init_memory_mapping(unsigned
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
 /* Compute zone sizes for the DMA and DMA32 zones in a node. */
 __init void
 size_zones(unsigned long *z, unsigned long *h,
@@ -667,15 +652,6 @@ #endif
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
diff --git a/include/asm-x86_64/pgtable.h b/include/asm-x86_64/pgtable.h
index 5528e8b..d0816fb 100644
--- a/include/asm-x86_64/pgtable.h
+++ b/include/asm-x86_64/pgtable.h
@@ -18,7 +18,6 @@ extern pud_t level3_kernel_pgt[512];
 extern pud_t level3_ident_pgt[512];
 extern pmd_t level2_kernel_pgt[512];
 extern pgd_t init_level4_pgt[];
-extern pgd_t boot_level4_pgt[];
 extern unsigned long __supported_pte_mask;
 
 #define swapper_pg_dir init_level4_pgt
diff --git a/include/asm-x86_64/proto.h b/include/asm-x86_64/proto.h
index 038fe1f..978ea43 100644
--- a/include/asm-x86_64/proto.h
+++ b/include/asm-x86_64/proto.h
@@ -11,8 +11,6 @@ struct pt_regs;
 extern void start_kernel(void);
 extern void pda_init(int); 
 
-extern void zap_low_mappings(int cpu);
-
 extern void early_idt_handler(void);
 
 extern void mcheck_init(struct cpuinfo_x86 *c);
-- 
1.4.2.rc2.g5209e

