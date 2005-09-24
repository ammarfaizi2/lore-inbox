Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbVIXA3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVIXA3h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 20:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbVIXA3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 20:29:36 -0400
Received: from fmr24.intel.com ([143.183.121.16]:33452 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750936AbVIXA3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 20:29:36 -0400
Date: Fri, 23 Sep 2005 17:28:55 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, suresh.b.siddha@intel.com, discuss@x86-64.org
Subject: Re: init and zap low address mappings on demand for cpu hotplug
Message-ID: <20050923172855.D12631@unix-os.sc.intel.com>
References: <20050921135731.B14439@unix-os.sc.intel.com> <20050922094818.GB79762@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050922094818.GB79762@muc.de>; from ak@muc.de on Thu, Sep 22, 2005 at 11:48:18AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 11:48:18AM +0200, Andi Kleen wrote:
> On Wed, Sep 21, 2005 at 01:57:31PM -0700, Ashok Raj wrote:
> > Hi,
> > 
> > to simplyfy cpu hotplug we didnt zap low mem address since we would require
> > them post boot to bringup a new cpu. This caused bad effects when 
> > Suresh was testing some new code. More below.
> 
> This seems racy - how do you prevent udev running on another
> CPU while another CPU boots? I suspect you need additional locks
> to plug this race. Or use a fresh mm cloned from init_mm mm to do the 
> CPU bootup.  
> 
> I don't like zap_low_first_time - it shouldn't be needed. In general
> people have been complaining on i386 and x86-64 that we don't
> unmap NULL early, so we don't catch bugs that happen on other 
> architectures. 
> 
> Using a fresh mm for smp bootup would solve this nicely - one could
> zap init_mm really early after entering from head.S and then
> only ever undo it in private mms for smp bootup.

One of my initial recommendation to fix the race was to use non-global mappings
for low identity mappings. As you also bringup the issue of zapping low mappings
very early, how about the appended patch? If it is Ok with you, I will
do a similar one for i386.

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
+++ linux-2.6.14-rc1.hot/arch/i386/kernel/acpi/boot.c	2005-09-23 10:31:28.105584432 -0700
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
+++ linux-2.6.14-rc1.hot/arch/x86_64/kernel/head.S	2005-09-22 19:09:36.995151320 -0700
@@ -70,7 +70,7 @@ startup_32:
 	movl	%eax, %cr4
 
 	/* Setup early boot stage 4 level pagetables */
-	movl	$(init_level4_pgt - __START_KERNEL_map), %eax
+	movl	$(boot_level4_pgt - __START_KERNEL_map), %eax
 	movl	%eax, %cr3
 
 	/* Setup EFER (Extended Feature Enable Register) */
@@ -113,7 +113,7 @@ startup_64:
 	movq	%rax, %cr4
 
 	/* Setup early boot stage 4 level pagetables. */
-	movq	$(init_level4_pgt - __START_KERNEL_map), %rax
+	movq	$(boot_level4_pgt - __START_KERNEL_map), %rax
 	movq	%rax, %cr3
 
 	/* Check if nx is implemented */
@@ -247,7 +247,7 @@ ENTRY(_stext)
 	 * 2Mbyte large pages provided by PAE mode)
 	 */
 .org 0x1000
-ENTRY(init_level4_pgt)
+ENTRY(boot_level4_pgt)
 	.quad	0x0000000000002007 + __PHYSICAL_START	/* -> level3_ident_pgt */
 	.fill	255,8,0
 	.quad	0x000000000000a007 + __PHYSICAL_START
diff -Npru linux-2.6.14-rc1/arch/x86_64/kernel/head64.c linux-2.6.14-rc1.hot/arch/x86_64/kernel/head64.c
--- linux-2.6.14-rc1/arch/x86_64/kernel/head64.c	2005-09-23 16:14:40.327090928 -0700
+++ linux-2.6.14-rc1.hot/arch/x86_64/kernel/head64.c	2005-09-23 14:52:50.576486472 -0700
@@ -19,6 +19,7 @@
 #include <asm/bootsetup.h>
 #include <asm/setup.h>
 #include <asm/desc.h>
+#include <asm/pgtable.h>
 
 /* Don't add a printk in there. printk relies on the PDA which is not initialized 
    yet. */
@@ -76,6 +77,7 @@ static void __init setup_boot_cpu_data(v
 }
 
 extern char _end[];
+pgd_t init_level4_pgt[PTRS_PER_PGD];
 
 void __init x86_64_start_kernel(char * real_mode_data)
 {
@@ -86,6 +88,13 @@ void __init x86_64_start_kernel(char * r
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
+++ linux-2.6.14-rc1.hot/arch/x86_64/kernel/setup.c	2005-09-23 16:11:14.567371160 -0700
@@ -571,6 +571,8 @@ void __init setup_arch(char **cmdline_p)
 
 	init_memory_mapping(0, (end_pfn_map << PAGE_SHIFT));
 
+	zap_low_mappings(0);
+
 #ifdef CONFIG_ACPI
 	/*
 	 * Initialize the ACPI boot-time table parser (gets the RSDP and SDT).
diff -Npru linux-2.6.14-rc1/arch/x86_64/kernel/setup64.c linux-2.6.14-rc1.hot/arch/x86_64/kernel/setup64.c
--- linux-2.6.14-rc1/arch/x86_64/kernel/setup64.c	2005-09-23 16:14:40.328090776 -0700
+++ linux-2.6.14-rc1.hot/arch/x86_64/kernel/setup64.c	2005-09-23 11:21:58.385911800 -0700
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
+++ linux-2.6.14-rc1.hot/arch/x86_64/kernel/smpboot.c	2005-09-23 11:13:10.729127824 -0700
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
+++ linux-2.6.14-rc1.hot/arch/x86_64/mm/init.c	2005-09-23 16:45:41.477153112 -0700
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
+++ linux-2.6.14-rc1.hot/include/asm-x86_64/pgtable.h	2005-09-22 12:10:36.673061208 -0700
@@ -16,6 +16,7 @@ extern pud_t level3_physmem_pgt[512];
 extern pud_t level3_ident_pgt[512];
 extern pmd_t level2_kernel_pgt[512];
 extern pgd_t init_level4_pgt[];
+extern pgd_t boot_level4_pgt[];
 extern unsigned long __supported_pte_mask;
 
 #define swapper_pg_dir init_level4_pgt
diff -Npru linux-2.6.14-rc1/include/asm-x86_64/smp.h linux-2.6.14-rc1.hot/include/asm-x86_64/smp.h
--- linux-2.6.14-rc1/include/asm-x86_64/smp.h	2005-09-23 16:14:40.330090472 -0700
+++ linux-2.6.14-rc1.hot/include/asm-x86_64/smp.h	2005-09-23 11:22:55.218271968 -0700
@@ -47,7 +47,7 @@ extern void lock_ipi_call_lock(void);
 extern void unlock_ipi_call_lock(void);
 extern int smp_num_siblings;
 extern void smp_send_reschedule(int cpu);
-extern void zap_low_mappings(void);
+extern void zap_low_mappings(int cpu);
 void smp_stop_cpu(void);
 extern int smp_call_function_single(int cpuid, void (*func) (void *info),
 				void *info, int retry, int wait);
