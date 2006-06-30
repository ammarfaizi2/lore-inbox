Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWF3JFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWF3JFk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 05:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWF3JFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 05:05:39 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:27456 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751495AbWF3JFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 05:05:38 -0400
Date: Fri, 30 Jun 2006 11:04:32 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: [patch 2/2] s390: put sys_call_table into .rodata section and write protect it
Message-ID: <20060630090432.GB9457@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Put s390's syscall tables into .rodata section and write protect this section
to prevent misuse of it. Suggested by Arjan van de Ven <arjan@infradead.org>.

Cc: Arjan van de Ven <arjan@infradead.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/entry.S   |    9 ++++++---
 arch/s390/kernel/entry64.S |    1 +
 arch/s390/mm/init.c        |   35 +++++++++++++++++++++--------------
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index aa8b52c..abd21ca 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -229,8 +229,9 @@ sysc_do_svc:
 sysc_nr_ok:
 	mvc	SP_ARGS(4,%r15),SP_R7(%r15)
 sysc_do_restart:
+	l	%r8,BASED(.Lsysc_table)
 	tm	__TI_flags+3(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
-        l       %r8,sys_call_table-system_call(%r7,%r13) # get system call addr.
+	l	%r8,0(%r7,%r8)	  # get system call addr.
         bnz     BASED(sysc_tracesys)
         basr    %r14,%r8          # call sys_xxxx
         st      %r2,SP_R2(%r15)   # store return value (change R2 on stack)
@@ -331,9 +332,10 @@ sysc_tracesys:
 	basr	%r14,%r1
 	clc	SP_R2(4,%r15),BASED(.Lnr_syscalls)
 	bnl	BASED(sysc_tracenogo)
+	l	%r8,BASED(.Lsysc_table)
 	l	%r7,SP_R2(%r15)        # strace might have changed the 
 	sll	%r7,2                  #  system call
-	l	%r8,sys_call_table-system_call(%r7,%r13)
+	l	%r8,0(%r7,%r8)
 sysc_tracego:
 	lm	%r3,%r6,SP_R3(%r15)
 	l	%r2,SP_ORIG_R2(%r15)
@@ -1010,6 +1012,7 @@ #endif
 .Ltrace:       .long  syscall_trace
 .Lvfork:       .long  sys_vfork
 .Lschedtail:   .long  schedule_tail
+.Lsysc_table:  .long  sys_call_table
 
 .Lcritical_start:
                .long  __critical_start + 0x80000000
@@ -1018,8 +1021,8 @@ #endif
 .Lcleanup_critical:
                .long  cleanup_critical
 
+	       .section .rodata, "a"
 #define SYSCALL(esa,esame,emu)	.long esa
 sys_call_table:
 #include "syscalls.S"
 #undef SYSCALL
-
diff --git a/arch/s390/kernel/entry64.S b/arch/s390/kernel/entry64.S
index f3222a1..3c6f679 100644
--- a/arch/s390/kernel/entry64.S
+++ b/arch/s390/kernel/entry64.S
@@ -992,6 +992,7 @@ #endif
 .Lcritical_end:
                .quad  __critical_end
 
+	       .section .rodata, "a"
 #define SYSCALL(esa,esame,emu)	.long esame
 sys_call_table:
 #include "syscalls.S"
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index a055894..225b38e 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -24,6 +24,7 @@ #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/bootmem.h>
+#include <linux/pfn.h>
 
 #include <asm/processor.h>
 #include <asm/system.h>
@@ -34,6 +35,7 @@ #include <asm/dma.h>
 #include <asm/lowcore.h>
 #include <asm/tlb.h>
 #include <asm/tlbflush.h>
+#include <asm/sections.h>
 
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
@@ -90,17 +92,6 @@ void show_mem(void)
         printk("%d pages swap cached\n",cached);
 }
 
-/* References to section boundaries */
-
-extern unsigned long _text;
-extern unsigned long _etext;
-extern unsigned long _edata;
-extern unsigned long __bss_start;
-extern unsigned long _end;
-
-extern unsigned long __init_begin;
-extern unsigned long __init_end;
-
 extern unsigned long __initdata zholes_size[];
 /*
  * paging_init() sets up the page tables
@@ -117,6 +108,10 @@ void __init paging_init(void)
         unsigned long pfn = 0;
         unsigned long pgdir_k = (__pa(swapper_pg_dir) & PAGE_MASK) | _KERNSEG_TABLE;
         static const int ssm_mask = 0x04000000L;
+	unsigned long ro_start_pfn, ro_end_pfn;
+
+	ro_start_pfn = PFN_DOWN((unsigned long)&__start_rodata);
+	ro_end_pfn = PFN_UP((unsigned long)&__end_rodata);
 
 	/* unmap whole virtual address space */
 	
@@ -144,7 +139,10 @@ void __init paging_init(void)
                 pg_dir++;
 
                 for (tmp = 0 ; tmp < PTRS_PER_PTE ; tmp++,pg_table++) {
-                        pte = pfn_pte(pfn, PAGE_KERNEL);
+			if (pfn >= ro_start_pfn && pfn < ro_end_pfn)
+				pte = pfn_pte(pfn, __pgprot(_PAGE_RO));
+			else
+				pte = pfn_pte(pfn, PAGE_KERNEL);
                         if (pfn >= max_low_pfn)
                                 pte_clear(&init_mm, 0, &pte);
                         set_pte(pg_table, pte);
@@ -176,6 +174,7 @@ void __init paging_init(void)
 }
 
 #else /* CONFIG_64BIT */
+
 void __init paging_init(void)
 {
         pgd_t * pg_dir;
@@ -187,13 +186,15 @@ void __init paging_init(void)
         unsigned long pgdir_k = (__pa(swapper_pg_dir) & PAGE_MASK) |
           _KERN_REGION_TABLE;
 	static const int ssm_mask = 0x04000000L;
-
 	unsigned long zones_size[MAX_NR_ZONES];
 	unsigned long dma_pfn, high_pfn;
+	unsigned long ro_start_pfn, ro_end_pfn;
 
 	memset(zones_size, 0, sizeof(zones_size));
 	dma_pfn = MAX_DMA_ADDRESS >> PAGE_SHIFT;
 	high_pfn = max_low_pfn;
+	ro_start_pfn = PFN_DOWN((unsigned long)&__start_rodata);
+	ro_end_pfn = PFN_UP((unsigned long)&__end_rodata);
 
 	if (dma_pfn > high_pfn)
 		zones_size[ZONE_DMA] = high_pfn;
@@ -232,7 +233,10 @@ void __init paging_init(void)
                         pmd_populate_kernel(&init_mm, pm_dir, pt_dir);
 	
                         for (k = 0 ; k < PTRS_PER_PTE ; k++,pt_dir++) {
-                                pte = pfn_pte(pfn, PAGE_KERNEL);
+				if (pfn >= ro_start_pfn && pfn < ro_end_pfn)
+					pte = pfn_pte(pfn, __pgprot(_PAGE_RO));
+				else
+					pte = pfn_pte(pfn, PAGE_KERNEL);
                                 if (pfn >= max_low_pfn) {
                                         pte_clear(&init_mm, 0, &pte); 
                                         continue;
@@ -283,6 +287,9 @@ void __init mem_init(void)
                 reservedpages << (PAGE_SHIFT-10),
                 datasize >>10,
                 initsize >> 10);
+	printk("Write protected kernel read-only data: %#lx - %#lx\n",
+	       (unsigned long)&__start_rodata,
+	       PFN_ALIGN((unsigned long)&__end_rodata) - 1);
 }
 
 void free_initmem(void)
