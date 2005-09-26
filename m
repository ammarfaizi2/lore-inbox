Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbVIZXUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbVIZXUd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 19:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVIZXUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 19:20:33 -0400
Received: from fmr21.intel.com ([143.183.121.13]:18922 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932524AbVIZXUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 19:20:32 -0400
Date: Mon, 26 Sep 2005 16:19:51 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, discuss@x86-64.org
Subject: Re: init and zap low address mappings on demand for cpu hotplug
Message-ID: <20050926161951.A6640@unix-os.sc.intel.com>
References: <20050921135731.B14439@unix-os.sc.intel.com> <20050922094818.GB79762@muc.de> <20050923172855.D12631@unix-os.sc.intel.com> <20050926065856.GA99750@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050926065856.GA99750@muc.de>; from ak@muc.de on Mon, Sep 26, 2005 at 08:58:56AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 08:58:56AM +0200, Andi Kleen wrote:
> Looks good. Thanks Suresh. The boot page tables should be marked __initdata
> now, but that can be done in an follow on patch.

Appended new complete patch. Andrew, please apply.

> i386 should probably get similar treatment.

Will do it sometime soon.

--
low address mappings are not zapped after boot as they are required later for 
cpu hotplug. These identity mapped low address mappings cause corruption 
when udev process is spawned early in boot. Since these low mappings 
are mapped global, cr3 writes (during context switches to udev process) 
will not flush these identity low mappings. These low mappings will be 
used by the kernel when it writes into the udev/hotplug user space, 
thereby corrupting kernel memory.

Andi Kleen also brought up another point. We should zap these low mappings, 
as soon as possible, so that we can catch kernel bugs more effectively.

This patch introduces boot_level4_pgt, which will always have low identity
addresses mapped. Druing boot, all the processors will use this as their
level4 pgt. On BP, we will switch to init_level4_pgt as soon as we enter
C code and  zap the low mappings as soon as we are done with the usage of 
identity low mapped addresses. On AP's we will zap the low mappings as 
soon as we jump to C code.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>

diff -Npru linux-2.6.14-rc1/arch/i386/kernel/acpi/boot.c linux-2.6.14-rc1.hot/arch/i386/kernel/acpi/boot.c
--- linux-2.6.14-rc1/arch/i386/kernel/acpi/boot.c	2005-09-23 16:14:40.326091080 -0700
+++ linux-2.6.14-rc1.hot/arch/i386/kernel/acpi/boot.c	2005-09-26 14:49:16.606625368 -0700
@@ -544,7 +544,7 @@ acpi_scan_rsdp(unsigned long start, unsi
 	 * RSDP signature.
 	 */
 	for (offset = 0; offset < length; offset += 16) {
-		if (strncmp((char *)(start + offset), "RSD PTR ", sig_len))
+		if (strncmp((char *)(__va(start) + offset), "RSD PTR ", sig_len))
 			continue;
 		return (start + offset);
 	}
diff -Npru linux-2.6.14-rc1/arch/x86_64/kernel/head.S linux-2.6.14-rc1.hot/arch/x86_64/kernel/head.S
--- linux-2.6.14-rc1/arch/x86_64/kernel/head.S	2005-09-23 16:14:40.327090928 -0700
+++ linux-2.6.14-rc1.hot/arch/x86_64/kernel/head.S	2005-09-26 15:30:20.645034592 -0700
@@ -12,6 +12,7 @@
 
 #include <linux/linkage.h>
 #include <linux/threads.h>
+#include <linux/init.h>
 #include <asm/desc.h>
 #include <asm/segment.h>
 #include <asm/page.h>
@@ -70,7 +71,7 @@ startup_32:
 	movl	%eax, %cr4
 
 	/* Setup early boot stage 4 level pagetables */
-	movl	$(init_level4_pgt - __START_KERNEL_map), %eax
+	movl	$(boot_level4_pgt - __START_KERNEL_map), %eax
 	movl	%eax, %cr3
 
 	/* Setup EFER (Extended Feature Enable Register) */
@@ -113,7 +114,7 @@ startup_64:
 	movq	%rax, %cr4
 
 	/* Setup early boot stage 4 level pagetables. */
-	movq	$(init_level4_pgt - __START_KERNEL_map), %rax
+	movq	$(boot_level4_pgt - __START_KERNEL_map), %rax
 	movq	%rax, %cr3
 
 	/* Check if nx is implemented */
@@ -240,20 +241,10 @@ ljumpvector:
 ENTRY(stext)
 ENTRY(_stext)
 
-	/*
-	 * This default setting generates an ident mapping at address 0x100000
-	 * and a mapping for the kernel that precisely maps virtual address
-	 * 0xffffffff80000000 to physical address 0x000000. (always using
-	 * 2Mbyte large pages provided by PAE mode)
-	 */
 .org 0x1000
 ENTRY(init_level4_pgt)
-	.quad	0x0000000000002007 + __PHYSICAL_START	/* -> level3_ident_pgt */
-	.fill	255,8,0
-	.quad	0x000000000000a007 + __PHYSICAL_START
-	.fill	254,8,0
-	/* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
-	.quad	0x0000000000003007 + __PHYSICAL_START	/* -> level3_kernel_pgt */
+	/* This gets initialized in x86_64_start_kernel */
+	.fill	512,8,0
 
 .org 0x2000
 ENTRY(level3_ident_pgt)
@@ -350,6 +341,24 @@ ENTRY(wakeup_level4_pgt)
 	.quad	0x0000000000003007 + __PHYSICAL_START	/* -> level3_kernel_pgt */
 #endif
 
+#ifndef CONFIG_HOTPLUG_CPU
+	__INITDATA
+#endif
+	/*
+	 * This default setting generates an ident mapping at address 0x100000
+	 * and a mapping for the kernel that precisely maps virtual address
+	 * 0xffffffff80000000 to physical address 0x000000. (always using
+	 * 2Mbyte large pages provided by PAE mode)
+	 */
+	.align PAGE_SIZE
+ENTRY(boot_level4_pgt)
+	.quad	0x0000000000002007 + __PHYSICAL_START	/* -> level3_ident_pgt */
+	.fill	255,8,0
+	.quad	0x000000000000a007 + __PHYSICAL_START
+	.fill	254,8,0
+	/* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
+	.quad	0x0000000000003007 + __PHYSICAL_START	/* -> level3_kernel_pgt */
+
 	.data
 
 	.align 16
diff -Npru linux-2.6.14-rc1/arch/x86_64/kernel/head64.c linux-2.6.14-rc1.hot/arch/x86_64/kernel/head64.c
--- linux-2.6.14-rc1/arch/x86_64/kernel/head64.c	2005-09-23 16:14:40.327090928 -0700
+++ linux-2.6.14-rc1.hot/arch/x86_64/kernel/head64.c	2005-09-26 14:52:31.678969864 -0700
@@ -19,6 +19,7 @@
 #include <asm/bootsetup.h>
 #include <asm/setup.h>
 #include <asm/desc.h>
+#include <asm/pgtable.h>
 
 /* Don't add a printk in there. printk relies on the PDA which is not initialized 
    yet. */
@@ -86,6 +87,13 @@ void __init x86_64_start_kernel(char * r
 		set_intr_gate(i, early_idt_handler);
 	asm volatile("lidt %0" :: "m" (idt_descr));
 	clear_bss();
+
+	/*
+	 * switch to init_level4_pgt from boot_level4_pgt
+	 */
+	memcpy(init_level4_pgt, boot_level4_pgt, PTRS_PER_PGD*sizeof(pgd_t));
+	asm volatile("movq %0,%%cr3" :: "r" (__pa_symbol(&init_level4_pgt)));
+
 	pda_init(0);
 	copy_bootdata(real_mode_data);
 #ifdef CONFIG_SMP
diff -Npru linux-2.6.14-rc1/arch/x86_64/kernel/setup.c linux-2.6.14-rc1.hot/arch/x86_64/kernel/setup.c
--- linux-2.6.14-rc1/arch/x86_64/kernel/setup.c	2005-09-23 16:14:40.328090776 -0700
+++ linux-2.6.14-rc1.hot/arch/x86_64/kernel/setup.c	2005-09-26 14:49:16.607625216 -0700
@@ -571,6 +571,8 @@ void __init setup_arch(char **cmdline_p)
 
 	init_memory_mapping(0, (end_pfn_map << PAGE_SHIFT));
 
+	zap_low_mappings(0);
+
 #ifdef CONFIG_ACPI
 	/*
 	 * Initialize the ACPI boot-time table parser (gets the RSDP and SDT).
diff -Npru linux-2.6.14-rc1/arch/x86_64/kernel/setup64.c linux-2.6.14-rc1.hot/arch/x86_64/kernel/setup64.c
--- linux-2.6.14-rc1/arch/x86_64/kernel/setup64.c	2005-09-23 16:14:40.328090776 -0700
+++ linux-2.6.14-rc1.hot/arch/x86_64/kernel/setup64.c	2005-09-26 14:49:16.608625064 -0700
@@ -137,7 +137,6 @@ void pda_init(int cpu)
 			panic("cannot allocate irqstack for cpu %d", cpu); 
 	}
 
-	asm volatile("movq %0,%%cr3" :: "r" (__pa_symbol(&init_level4_pgt)));
 
 	pda->irqstackptr += IRQSTACKSIZE-64;
 } 
@@ -193,6 +192,7 @@ void __cpuinit cpu_init (void)
 	/* CPU 0 is initialised in head64.c */
 	if (cpu != 0) {
 		pda_init(cpu);
+		zap_low_mappings(cpu);
 	} else 
 		estacks = boot_exception_stacks; 
 
diff -Npru linux-2.6.14-rc1/arch/x86_64/kernel/smpboot.c linux-2.6.14-rc1.hot/arch/x86_64/kernel/smpboot.c
--- linux-2.6.14-rc1/arch/x86_64/kernel/smpboot.c	2005-09-23 16:14:40.329090624 -0700
+++ linux-2.6.14-rc1.hot/arch/x86_64/kernel/smpboot.c	2005-09-26 14:49:16.608625064 -0700
@@ -1067,9 +1067,6 @@ int __cpuinit __cpu_up(unsigned int cpu)
  */
 void __init smp_cpus_done(unsigned int max_cpus)
 {
-#ifndef CONFIG_HOTPLUG_CPU
-	zap_low_mappings();
-#endif
 	smp_cleanup_boot();
 
 #ifdef CONFIG_X86_IO_APIC
diff -Npru linux-2.6.14-rc1/arch/x86_64/mm/init.c linux-2.6.14-rc1.hot/arch/x86_64/mm/init.c
--- linux-2.6.14-rc1/arch/x86_64/mm/init.c	2005-09-23 16:14:40.329090624 -0700
+++ linux-2.6.14-rc1.hot/arch/x86_64/mm/init.c	2005-09-26 14:49:16.609624912 -0700
@@ -310,12 +310,19 @@ void __init init_memory_mapping(unsigned
 
 extern struct x8664_pda cpu_pda[NR_CPUS];
 
-/* Assumes all CPUs still execute in init_mm */
-void zap_low_mappings(void)
+void __cpuinit zap_low_mappings(int cpu)
 {
-	pgd_t *pgd = pgd_offset_k(0UL);
-	pgd_clear(pgd);
-	flush_tlb_all();
+	if (cpu == 0) {
+		pgd_t *pgd = pgd_offset_k(0UL);
+		pgd_clear(pgd);
+	} else {
+		/*
+		 * For AP's, zap the low identity mappings by changing the cr3
+		 * to init_level4_pgt and doing local flush tlb all
+		 */
+		asm volatile("movq %0,%%cr3" :: "r" (__pa_symbol(&init_level4_pgt)));
+	}
+	__flush_tlb_all();
 }
 
 #ifndef CONFIG_NUMA
@@ -438,14 +445,13 @@ void __init mem_init(void)
 		datasize >> 10,
 		initsize >> 10);
 
+#ifdef CONFIG_SMP
 	/*
-	 * Subtle. SMP is doing its boot stuff late (because it has to
-	 * fork idle threads) - but it also needs low mappings for the
-	 * protected-mode entry to work. We zap these entries only after
-	 * the WP-bit has been tested.
+	 * Sync boot_level4_pgt mappings with the init_level4_pgt
+	 * except for the low identity mappings which are already zapped
+	 * in init_level4_pgt. This sync-up is essential for AP's bringup
 	 */
-#ifndef CONFIG_SMP
-	zap_low_mappings();
+	memcpy(boot_level4_pgt+1, init_level4_pgt+1, (PTRS_PER_PGD-1)*sizeof(pgd_t));
 #endif
 }
 
diff -Npru linux-2.6.14-rc1/include/asm-x86_64/pgtable.h linux-2.6.14-rc1.hot/include/asm-x86_64/pgtable.h
--- linux-2.6.14-rc1/include/asm-x86_64/pgtable.h	2005-09-23 16:14:40.330090472 -0700
+++ linux-2.6.14-rc1.hot/include/asm-x86_64/pgtable.h	2005-09-26 14:49:16.609624912 -0700
@@ -16,6 +16,7 @@ extern pud_t level3_physmem_pgt[512];
 extern pud_t level3_ident_pgt[512];
 extern pmd_t level2_kernel_pgt[512];
 extern pgd_t init_level4_pgt[];
+extern pgd_t boot_level4_pgt[];
 extern unsigned long __supported_pte_mask;
 
 #define swapper_pg_dir init_level4_pgt
diff -Npru linux-2.6.14-rc1/include/asm-x86_64/smp.h linux-2.6.14-rc1.hot/include/asm-x86_64/smp.h
--- linux-2.6.14-rc1/include/asm-x86_64/smp.h	2005-09-23 16:14:40.330090472 -0700
+++ linux-2.6.14-rc1.hot/include/asm-x86_64/smp.h	2005-09-26 14:49:16.610624760 -0700
@@ -47,7 +47,7 @@ extern void lock_ipi_call_lock(void);
 extern void unlock_ipi_call_lock(void);
 extern int smp_num_siblings;
 extern void smp_send_reschedule(int cpu);
-extern void zap_low_mappings(void);
+extern void zap_low_mappings(int cpu);
 void smp_stop_cpu(void);
 extern int smp_call_function_single(int cpuid, void (*func) (void *info),
 				void *info, int retry, int wait);
