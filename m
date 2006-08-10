Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWHJUDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWHJUDt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWHJUDs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:03:48 -0400
Received: from cantor2.suse.de ([195.135.220.15]:62187 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932645AbWHJTgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:50 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [91/145] x86_64: Convert x86-64 to early param
Message-Id: <20060810193648.8EBDC13C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:48 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Instead of hackish manual parsing

Requires earlier i386 patchkit, but also fixes i386 early_printk again.

I removed some obsolete really early parameters which didn't do anything useful.
Also made a few parameters that needed it early (mostly oops printing setup)

Also removed one panic check that wasn't visible without
early console anyways (the early console is now initialized after that
panic)

This cleans up a lot of code.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/apic.c          |   34 +++---
 arch/x86_64/kernel/e820.c          |   53 ++++++++-
 arch/x86_64/kernel/early_printk.c  |   20 +--
 arch/x86_64/kernel/head64.c        |   15 --
 arch/x86_64/kernel/io_apic.c       |   15 +-
 arch/x86_64/kernel/machine_kexec.c |   28 +++++
 arch/x86_64/kernel/pci-dma.c       |    7 -
 arch/x86_64/kernel/setup.c         |  197 +++----------------------------------
 arch/x86_64/kernel/setup64.c       |    8 -
 arch/x86_64/kernel/smpboot.c       |    6 -
 arch/x86_64/kernel/traps.c         |   28 +++--
 arch/x86_64/mm/numa.c              |    9 +
 include/asm-x86_64/apic.h          |    4 
 include/asm-x86_64/e820.h          |    3 
 include/asm-x86_64/pgtable.h       |    1 
 include/asm-x86_64/proto.h         |   10 -
 16 files changed, 162 insertions(+), 276 deletions(-)

Index: linux/arch/x86_64/kernel/early_printk.c
===================================================================
--- linux.orig/arch/x86_64/kernel/early_printk.c
+++ linux/arch/x86_64/kernel/early_printk.c
@@ -215,20 +215,16 @@ void early_printk(const char *fmt, ...)
 
 static int __initdata keep_early;
 
-int __init setup_early_printk(char *opt)
+static int __init setup_early_printk(char *buf)
 {
-	char *space;
-	char buf[256];
+	if (!buf)
+		return 0;
 
 	if (early_console_initialized)
-		return 1;
-
-	strlcpy(buf,opt,sizeof(buf));
-	space = strchr(buf, ' ');
-	if (space)
-		*space = 0;
+		return 0;
+	early_console_initialized = 1;
 
-	if (strstr(buf,"keep"))
+	if (!strcmp(buf,"keep"))
 		keep_early = 1;
 
 	if (!strncmp(buf, "serial", 6)) {
@@ -248,11 +244,12 @@ int __init setup_early_printk(char *opt)
  		early_console = &simnow_console;
  		keep_early = 1;
 	}
-	early_console_initialized = 1;
 	register_console(early_console);
 	return 0;
 }
 
+early_param("earlyprintk", setup_early_printk);
+
 void __init disable_early_printk(void)
 {
 	if (!early_console_initialized || !early_console)
@@ -266,4 +263,3 @@ void __init disable_early_printk(void)
 	}
 }
 
-__setup("earlyprintk=", setup_early_printk);
Index: linux/arch/x86_64/kernel/head64.c
===================================================================
--- linux.orig/arch/x86_64/kernel/head64.c
+++ linux/arch/x86_64/kernel/head64.c
@@ -58,7 +58,6 @@ static void __init copy_bootdata(char *r
 
 void __init x86_64_start_kernel(char * real_mode_data)
 {
-	char *s;
 	int i;
 
 	for (i = 0; i < 256; i++)
@@ -85,19 +84,5 @@ void __init x86_64_start_kernel(char * r
 #ifdef CONFIG_SMP
 	cpu_set(0, cpu_online_map);
 #endif
-	s = strstr(saved_command_line, "earlyprintk=");
-	if (s != NULL)
-		setup_early_printk(strchr(s, '=') + 1);
-#ifdef CONFIG_NUMA
-	s = strstr(saved_command_line, "numa=");
-	if (s != NULL)
-		numa_setup(s+5);
-#endif
-	if (strstr(saved_command_line, "disableapic"))
-		disable_apic = 1;
-	/* You need early console to see that */
-	if (__pa_symbol(&_end) >= KERNEL_TEXT_SIZE)
-		panic("Kernel too big for kernel mapping\n");
-
 	start_kernel();
 }
Index: linux/arch/x86_64/kernel/setup.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup.c
+++ linux/arch/x86_64/kernel/setup.c
@@ -76,11 +76,6 @@ unsigned long mmu_cr4_features;
 
 int acpi_disabled;
 EXPORT_SYMBOL(acpi_disabled);
-#ifdef	CONFIG_ACPI
-extern int __initdata acpi_ht;
-extern acpi_interrupt_flags	acpi_sci_flags;
-int __initdata acpi_force = 0;
-#endif
 
 int acpi_numa __initdata;
 
@@ -276,183 +271,22 @@ static void __init probe_roms(void)
 	}
 }
 
-/* Check for full argument with no trailing characters */
-static int fullarg(char *p, char *arg)
+#ifdef CONFIG_PROC_VMCORE
+/* elfcorehdr= specifies the location of elf core header
+ * stored by the crashed kernel. This option will be passed
+ * by kexec loader to the capture kernel.
+ */
+static int __init setup_elfcorehdr(char *arg)
 {
-	int l = strlen(arg);
-	return !memcmp(p, arg, l) && (p[l] == 0 || isspace(p[l]));
+	char *end;
+	if (!arg)
+		return -EINVAL;
+	elfcorehdr_addr = memparse(arg, &end);
+	return end > arg ? 0 : -EINVAL;
 }
-
-static __init void parse_cmdline_early (char ** cmdline_p)
-{
-	char c = ' ', *to = command_line, *from = COMMAND_LINE;
-	int len = 0;
-	int userdef = 0;
-
-	for (;;) {
-		if (c != ' ') 
-			goto next_char; 
-
-#ifdef  CONFIG_SMP
-		/*
-		 * If the BIOS enumerates physical processors before logical,
-		 * maxcpus=N at enumeration-time can be used to disable HT.
-		 */
-		else if (!memcmp(from, "maxcpus=", 8)) {
-			extern unsigned int maxcpus;
-
-			maxcpus = simple_strtoul(from + 8, NULL, 0);
-		}
-#endif
-#ifdef CONFIG_ACPI
-		/* "acpi=off" disables both ACPI table parsing and interpreter init */
-		if (fullarg(from,"acpi=off"))
-			disable_acpi();
-
-		if (fullarg(from, "acpi=force")) { 
-			/* add later when we do DMI horrors: */
-			acpi_force = 1;
-			acpi_disabled = 0;
-		}
-
-		/* acpi=ht just means: do ACPI MADT parsing 
-		   at bootup, but don't enable the full ACPI interpreter */
-		if (fullarg(from, "acpi=ht")) { 
-			if (!acpi_force)
-				disable_acpi();
-			acpi_ht = 1; 
-		}
-                else if (fullarg(from, "pci=noacpi")) 
-			acpi_disable_pci();
-		else if (fullarg(from, "acpi=noirq"))
-			acpi_noirq_set();
-
-		else if (fullarg(from, "acpi_sci=edge"))
-			acpi_sci_flags.trigger =  1;
-		else if (fullarg(from, "acpi_sci=level"))
-			acpi_sci_flags.trigger = 3;
-		else if (fullarg(from, "acpi_sci=high"))
-			acpi_sci_flags.polarity = 1;
-		else if (fullarg(from, "acpi_sci=low"))
-			acpi_sci_flags.polarity = 3;
-
-		/* acpi=strict disables out-of-spec workarounds */
-		else if (fullarg(from, "acpi=strict")) {
-			acpi_strict = 1;
-		}
-		else if (fullarg(from, "acpi_skip_timer_override"))
-			acpi_skip_timer_override = 1;
+early_param("elfcorehdr", setup_elfcorehdr);
 #endif
 
-		if (fullarg(from, "disable_timer_pin_1"))
-			disable_timer_pin_1 = 1;
-		if (fullarg(from, "enable_timer_pin_1"))
-			disable_timer_pin_1 = -1;
-
-		if (fullarg(from, "nolapic") || fullarg(from, "disableapic")) {
-			clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
-			disable_apic = 1;
-		}
-
-		if (fullarg(from, "noapic"))
-			skip_ioapic_setup = 1;
-
-		if (fullarg(from,"apic")) {
-			skip_ioapic_setup = 0;
-			ioapic_force = 1;
-		}
-			
-		if (!memcmp(from, "mem=", 4))
-			parse_memopt(from+4, &from); 
-
-		if (!memcmp(from, "memmap=", 7)) {
-			/* exactmap option is for used defined memory */
-			if (!memcmp(from+7, "exactmap", 8)) {
-#ifdef CONFIG_CRASH_DUMP
-				/* If we are doing a crash dump, we
-				 * still need to know the real mem
-				 * size before original memory map is
-				 * reset.
-				 */
-				saved_max_pfn = e820_end_of_ram();
-#endif
-				from += 8+7;
-				end_pfn_map = 0;
-				e820.nr_map = 0;
-				userdef = 1;
-			}
-			else {
-				parse_memmapopt(from+7, &from);
-				userdef = 1;
-			}
-		}
-
-#ifdef CONFIG_NUMA
-		if (!memcmp(from, "numa=", 5))
-			numa_setup(from+5); 
-#endif
-
-		if (!memcmp(from,"iommu=",6)) { 
-			iommu_setup(from+6); 
-		}
-
-		if (fullarg(from,"oops=panic"))
-			panic_on_oops = 1;
-
-		if (!memcmp(from, "noexec=", 7))
-			nonx_setup(from + 7);
-
-#ifdef CONFIG_KEXEC
-		/* crashkernel=size@addr specifies the location to reserve for
-		 * a crash kernel.  By reserving this memory we guarantee
-		 * that linux never set's it up as a DMA target.
-		 * Useful for holding code to do something appropriate
-		 * after a kernel panic.
-		 */
-		else if (!memcmp(from, "crashkernel=", 12)) {
-			unsigned long size, base;
-			size = memparse(from+12, &from);
-			if (*from == '@') {
-				base = memparse(from+1, &from);
-				/* FIXME: Do I want a sanity check
-				 * to validate the memory range?
-				 */
-				crashk_res.start = base;
-				crashk_res.end   = base + size - 1;
-			}
-		}
-#endif
-
-#ifdef CONFIG_PROC_VMCORE
-		/* elfcorehdr= specifies the location of elf core header
-		 * stored by the crashed kernel. This option will be passed
-		 * by kexec loader to the capture kernel.
-		 */
-		else if(!memcmp(from, "elfcorehdr=", 11))
-			elfcorehdr_addr = memparse(from+11, &from);
-#endif
-
-#ifdef CONFIG_HOTPLUG_CPU
-		else if (!memcmp(from, "additional_cpus=", 16))
-			setup_additional_cpus(from+16);
-#endif
-
-	next_char:
-		c = *(from++);
-		if (!c)
-			break;
-		if (COMMAND_LINE_SIZE <= ++len)
-			break;
-		*(to++) = c;
-	}
-	if (userdef) {
-		printk(KERN_INFO "user-defined physical RAM map:\n");
-		e820_print_map("user");
-	}
-	*to = '\0';
-	*cmdline_p = command_line;
-}
-
 #ifndef CONFIG_NUMA
 static void __init
 contig_initmem_init(unsigned long start_pfn, unsigned long end_pfn)
@@ -549,7 +383,12 @@ void __init setup_arch(char **cmdline_p)
 
 	early_identify_cpu(&boot_cpu_data);
 
-	parse_cmdline_early(cmdline_p);
+	strlcpy(command_line, saved_command_line, COMMAND_LINE_SIZE);
+	*cmdline_p = command_line;
+
+	parse_early_param();
+
+	finish_e820_parsing();
 
 	/*
 	 * partially used pages are not usable - thus
Index: linux/arch/x86_64/mm/numa.c
===================================================================
--- linux.orig/arch/x86_64/mm/numa.c
+++ linux/arch/x86_64/mm/numa.c
@@ -348,9 +348,10 @@ void __init paging_init(void)
 	}
 } 
 
-/* [numa=off] */
-__init int numa_setup(char *opt) 
+static __init int numa_setup(char *opt)
 { 
+	if (!opt)
+		return -EINVAL;
 	if (!strncmp(opt,"off",3))
 		numa_off = 1;
 #ifdef CONFIG_NUMA_EMU
@@ -366,9 +367,11 @@ __init int numa_setup(char *opt) 
 	if (!strncmp(opt,"hotadd=", 7))
 		hotadd_percent = simple_strtoul(opt+7, NULL, 10);
 #endif
-	return 1;
+	return 0;
 } 
 
+early_param("numa", numa_setup);
+
 /*
  * Setup early cpu_to_node.
  *
Index: linux/include/asm-x86_64/proto.h
===================================================================
--- linux.orig/include/asm-x86_64/proto.h
+++ linux/include/asm-x86_64/proto.h
@@ -53,9 +53,6 @@ extern int nohpet;
 extern unsigned long vxtime_hz;
 extern void time_init_gtod(void);
 
-extern int numa_setup(char *opt);
-
-extern int setup_early_printk(char *); 
 extern void early_printk(const char *fmt, ...) __attribute__((format(printf,1,2)));
 
 extern void early_identify_cpu(struct cpuinfo_x86 *c);
@@ -104,13 +101,7 @@ extern void select_idle_routine(const st
 extern unsigned long table_start, table_end;
 
 extern int exception_trace;
-extern int using_apic_timer;
-extern int disable_apic;
 extern unsigned cpu_khz;
-extern int ioapic_force;
-extern int skip_ioapic_setup;
-extern int acpi_ht;
-extern int acpi_disabled;
 
 extern void no_iommu_init(void);
 extern int force_iommu, no_iommu;
@@ -132,7 +123,6 @@ extern int fix_aperture;
 
 extern int reboot_force;
 extern int notsc_setup(char *);
-extern int setup_additional_cpus(char *);
 
 extern void smp_local_timer_interrupt(struct pt_regs * regs);
 
Index: linux/arch/x86_64/kernel/apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/apic.c
+++ linux/arch/x86_64/kernel/apic.c
@@ -36,6 +36,7 @@
 #include <asm/idle.h>
 #include <asm/proto.h>
 #include <asm/timex.h>
+#include <asm/apic.h>
 
 int apic_verbosity;
 int apic_runs_main_timer;
@@ -546,18 +547,24 @@ static void apic_pm_activate(void) { }
 
 static int __init apic_set_verbosity(char *str)
 {
+	if (str == NULL)  {
+		skip_ioapic_setup = 0;
+		ioapic_force = 1;
+		return 0;
+	}
 	if (strcmp("debug", str) == 0)
 		apic_verbosity = APIC_DEBUG;
 	else if (strcmp("verbose", str) == 0)
 		apic_verbosity = APIC_VERBOSE;
-	else
+	else {
 		printk(KERN_WARNING "APIC Verbosity level %s not recognised"
-				" use apic=verbose or apic=debug", str);
+				" use apic=verbose or apic=debug\n", str);
+		return -EINVAL;
+	}
 
-	return 1;
+	return 0;
 }
-
-__setup("apic=", apic_set_verbosity);
+early_param("apic", apic_set_verbosity);
 
 /*
  * Detect and enable local APICs on non-SMP boards.
@@ -1078,14 +1085,17 @@ int __init APIC_init_uniprocessor (void)
 static __init int setup_disableapic(char *str) 
 { 
 	disable_apic = 1;
-	return 1;
-} 
+	clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
+	return 0;
+}
+early_param("disableapic", setup_disableapic);
 
+/* same as disableapic, for compatibility */
 static __init int setup_nolapic(char *str) 
 { 
-	disable_apic = 1;
-	return 1;
+	return setup_disableapic(str);
 } 
+early_param("nolapic", setup_nolapic);
 
 static __init int setup_noapictimer(char *str) 
 { 
@@ -1118,11 +1128,5 @@ static __init int setup_apicpmtimer(char
 }
 __setup("apicpmtimer", setup_apicpmtimer);
 
-/* dummy parsing: see setup.c */
-
-__setup("disableapic", setup_disableapic); 
-__setup("nolapic", setup_nolapic);  /* same as disableapic, for compatibility */
-
 __setup("noapictimer", setup_noapictimer); 
 
-/* no "lapic" flag - we only use the lapic when the BIOS tells us so. */
Index: linux/arch/x86_64/kernel/e820.c
===================================================================
--- linux.orig/arch/x86_64/kernel/e820.c
+++ linux/arch/x86_64/kernel/e820.c
@@ -592,31 +592,64 @@ void __init setup_memory_region(void)
 	e820_print_map(who);
 }
 
-void __init parse_memopt(char *p, char **from) 
-{ 
-	end_user_pfn = memparse(p, from);
+static int __init parse_memopt(char *p)
+{
+	if (!p)
+		return -EINVAL;
+	end_user_pfn = memparse(p, &p);
 	end_user_pfn >>= PAGE_SHIFT;	
+	return 0;
 } 
+early_param("mem", parse_memopt);
+
+static int userdef __initdata;
 
-void __init parse_memmapopt(char *p, char **from)
+static int __init parse_memmap_opt(char *p)
 {
+	char *oldp;
 	unsigned long long start_at, mem_size;
 
-	mem_size = memparse(p, from);
-	p = *from;
+	if (!strcmp(p, "exactmap")) {
+#ifdef CONFIG_CRASH_DUMP
+		/* If we are doing a crash dump, we
+		 * still need to know the real mem
+		 * size before original memory map is
+		 * reset.
+		 */
+		saved_max_pfn = e820_end_of_ram();
+#endif
+		end_pfn_map = 0;
+		e820.nr_map = 0;
+		userdef = 1;
+		return 0;
+	}
+
+	oldp = p;
+	mem_size = memparse(p, &p);
+	if (p == oldp)
+		return -EINVAL;
 	if (*p == '@') {
-		start_at = memparse(p+1, from);
+		start_at = memparse(p+1, &p);
 		add_memory_region(start_at, mem_size, E820_RAM);
 	} else if (*p == '#') {
-		start_at = memparse(p+1, from);
+		start_at = memparse(p+1, &p);
 		add_memory_region(start_at, mem_size, E820_ACPI);
 	} else if (*p == '$') {
-		start_at = memparse(p+1, from);
+		start_at = memparse(p+1, &p);
 		add_memory_region(start_at, mem_size, E820_RESERVED);
 	} else {
 		end_user_pfn = (mem_size >> PAGE_SHIFT);
 	}
-	p = *from;
+	return *p == '\0' ? 0 : -EINVAL;
+}
+early_param("memmap", parse_memmap_opt);
+
+void finish_e820_parsing(void)
+{
+	if (userdef) {
+		printk(KERN_INFO "user-defined physical RAM map:\n");
+		e820_print_map("user");
+	}
 }
 
 unsigned long pci_mem_start = 0xaeedbabe;
Index: linux/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/io_apic.c
+++ linux/arch/x86_64/kernel/io_apic.c
@@ -48,7 +48,7 @@ int sis_apic_bug; /* not actually suppor
 
 static int no_timer_check;
 
-int disable_timer_pin_1 __initdata;
+static int disable_timer_pin_1 __initdata;
 
 int timer_over_8254 __initdata = 0;
 
@@ -253,18 +253,17 @@ int ioapic_force;
 static int __init disable_ioapic_setup(char *str)
 {
 	skip_ioapic_setup = 1;
-	return 1;
+	return 0;
 }
+early_param("noapic", disable_ioapic_setup);
 
-static int __init enable_ioapic_setup(char *str)
+/* Actually the next is obsolete, but keep it for paranoid reasons -AK */
+static int __init disable_timer_pin_setup(char *arg)
 {
-	ioapic_force = 1;
-	skip_ioapic_setup = 0;
+	disable_timer_pin_1 = 1;
 	return 1;
 }
-
-__setup("noapic", disable_ioapic_setup);
-__setup("apic", enable_ioapic_setup);
+__setup("disable_timer_pin_1", disable_timer_pin_setup);
 
 static int __init setup_disable_8254_timer(char *s)
 {
Index: linux/arch/x86_64/kernel/pci-dma.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-dma.c
+++ linux/arch/x86_64/kernel/pci-dma.c
@@ -274,6 +274,9 @@ __init int iommu_setup(char *p)
 {
     iommu_merge = 1;
 
+	if (!p)
+		return -EINVAL;
+
     while (*p) {
 	    if (!strncmp(p,"off",3))
 		    no_iommu = 1;
@@ -320,9 +323,9 @@ __init int iommu_setup(char *p)
 	    if (*p == ',')
 		    ++p;
     }
-    return 1;
+    return 0;
 }
-__setup("iommu=", iommu_setup);
+early_param("iommu", iommu_setup);
 
 void __init pci_iommu_alloc(void)
 {
Index: linux/arch/x86_64/kernel/setup64.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup64.c
+++ linux/arch/x86_64/kernel/setup64.c
@@ -46,8 +46,10 @@ Control non executable mappings for 64bi
 on	Enable(default)
 off	Disable
 */ 
-int __init nonx_setup(char *str)
+static int __init nonx_setup(char *str)
 {
+	if (!str)
+		return -EINVAL;
 	if (!strncmp(str, "on", 2)) {
                 __supported_pte_mask |= _PAGE_NX; 
  		do_not_nx = 0; 
@@ -55,9 +57,9 @@ int __init nonx_setup(char *str)
 		do_not_nx = 1;
 		__supported_pte_mask &= ~_PAGE_NX;
         }
-	return 1;
+	return 0;
 } 
-__setup("noexec=", nonx_setup);	/* parsed early actually */
+early_param("noexec", nonx_setup);
 
 int force_personality32 = 0; 
 
Index: linux/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux.orig/arch/x86_64/kernel/smpboot.c
+++ linux/arch/x86_64/kernel/smpboot.c
@@ -1270,11 +1270,11 @@ void __cpu_die(unsigned int cpu)
  	printk(KERN_ERR "CPU %u didn't die...\n", cpu);
 }
 
-__init int setup_additional_cpus(char *s)
+static __init int setup_additional_cpus(char *s)
 {
-	return get_option(&s, &additional_cpus);
+	return s && get_option(&s, &additional_cpus) ? 0 : -EINVAL;
 }
-__setup("additional_cpus=", setup_additional_cpus);
+early_param("additional_cpus", setup_additional_cpus);
 
 #else /* ... !CONFIG_HOTPLUG_CPU */
 
Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -1114,24 +1114,29 @@ void __init trap_init(void)
 	cpu_init();
 }
 
-
-/* Actual parsing is done early in setup.c. */
-static int __init oops_dummy(char *s)
+static int __init oops_setup(char *s)
 { 
-	panic_on_oops = 1;
-	return 1;
+	if (!s)
+		return -EINVAL;
+	if (!strcmp(s, "panic"))
+		panic_on_oops = 1;
+	return 0;
 } 
-__setup("oops=", oops_dummy); 
+early_param("oops", oops_setup);
 
 static int __init kstack_setup(char *s)
 {
+	if (!s)
+		return -EINVAL;
 	kstack_depth_to_print = simple_strtoul(s,NULL,0);
-	return 1;
+	return 0;
 }
-__setup("kstack=", kstack_setup);
+early_param("kstack", kstack_setup);
 
 static int __init call_trace_setup(char *s)
 {
+	if (!s)
+		return -EINVAL;
 	if (strcmp(s, "old") == 0)
 		call_trace = -1;
 	else if (strcmp(s, "both") == 0)
@@ -1140,6 +1145,9 @@ static int __init call_trace_setup(char 
 		call_trace = 1;
 	else if (strcmp(s, "new") == 0)
 		call_trace = 2;
-	return 1;
+	return 0;
 }
-__setup("call_trace=", call_trace_setup);
+early_param("call_trace", call_trace_setup);
+
+
+
Index: linux/include/asm-x86_64/e820.h
===================================================================
--- linux.orig/include/asm-x86_64/e820.h
+++ linux/include/asm-x86_64/e820.h
@@ -55,8 +55,7 @@ extern void e820_setup_gap(void);
 extern unsigned long e820_hole_size(unsigned long start_pfn,
 				    unsigned long end_pfn);
 
-extern void __init parse_memopt(char *p, char **end);
-extern void __init parse_memmapopt(char *p, char **end);
+extern void finish_e820_parsing(void);
 
 extern struct e820map e820;
 
Index: linux/include/asm-x86_64/pgtable.h
===================================================================
--- linux.orig/include/asm-x86_64/pgtable.h
+++ linux/include/asm-x86_64/pgtable.h
@@ -21,7 +21,6 @@ extern unsigned long __supported_pte_mas
 
 #define swapper_pg_dir init_level4_pgt
 
-extern int nonx_setup(char *str);
 extern void paging_init(void);
 extern void clear_kernel_mapping(unsigned long addr, unsigned long size);
 
Index: linux/include/asm-x86_64/apic.h
===================================================================
--- linux.orig/include/asm-x86_64/apic.h
+++ linux/include/asm-x86_64/apic.h
@@ -17,6 +17,7 @@
 
 extern int apic_verbosity;
 extern int apic_runs_main_timer;
+extern int ioapic_force;
 
 /*
  * Define the default level of output to be very little
@@ -93,9 +94,6 @@ extern void setup_APIC_extened_lvt(unsig
 #define K8_APIC_EXT_INT_MSG_EXT 0x7
 #define K8_APIC_EXT_LVT_ENTRY_THRESHOLD    0
 
-extern int disable_timer_pin_1;
-
-
 void smp_send_timer_broadcast_ipi(void);
 void switch_APIC_timer_to_ipi(void *cpumask);
 void switch_ipi_to_APIC_timer(void *cpumask);
Index: linux/arch/x86_64/kernel/machine_kexec.c
===================================================================
--- linux.orig/arch/x86_64/kernel/machine_kexec.c
+++ linux/arch/x86_64/kernel/machine_kexec.c
@@ -226,3 +226,31 @@ NORET_TYPE void machine_kexec(struct kim
 	rnk = (relocate_new_kernel_t) control_code_buffer;
 	(*rnk)(page_list, control_code_buffer, image->start, start_pgtable);
 }
+
+/* crashkernel=size@addr specifies the location to reserve for
+ * a crash kernel.  By reserving this memory we guarantee
+ * that linux never set's it up as a DMA target.
+ * Useful for holding code to do something appropriate
+ * after a kernel panic.
+ */
+static int __init setup_crashkernel(char *arg)
+{
+	unsigned long size, base;
+	char *p;
+	if (!arg)
+		return -EINVAL;
+	size = memparse(arg, &p);
+	if (arg == p)
+		return -EINVAL;
+	if (*p == '@') {
+		base = memparse(p+1, &p);
+		/* FIXME: Do I want a sanity check to validate the
+		 * memory range?  Yes you do, but it's too early for
+		 * e820 -AK */
+		crashk_res.start = base;
+		crashk_res.end   = base + size - 1;
+	}
+	return 0;
+}
+early_param("crashkernel", setup_crashkernel);
+
