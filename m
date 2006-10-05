Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750698AbWJETFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750698AbWJETFP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 15:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWJETFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 15:05:15 -0400
Received: from ns1.suse.de ([195.135.220.2]:16006 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750698AbWJETFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 15:05:11 -0400
From: Andi Kleen <ak@suse.de>
To: Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.18-mm2 boot failure on x86-64
Date: Thu, 5 Oct 2006 21:05:00 +0200
User-Agent: KMail/1.9.3
Cc: Badari Pulavarty <pbadari@us.ibm.com>, Martin Bligh <mbligh@mbligh.org>,
       vgoyal@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       kmannth@us.ibm.com, Andy Whitcroft <apw@shadowen.org>
References: <20060928014623.ccc9b885.akpm@osdl.org> <200610052027.02208.ak@suse.de> <1160074263.29690.23.camel@flooterbu>
In-Reply-To: <1160074263.29690.23.camel@flooterbu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610052105.00359.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2006 20:51, Steve Fox wrote:
> On Thu, 2006-10-05 at 20:27 +0200, Andi Kleen wrote:
> 
> > I guess we need to track when it gets corrupted. Can you send the full
> > boot log with this patch applied?
> 
> Here she blows!

Can you please try it again with this patch to narrow it down further?

-Andi

Index: linux-2.6.19-rc1-hack/init/main.c
===================================================================
--- linux-2.6.19-rc1-hack.orig/init/main.c
+++ linux-2.6.19-rc1-hack/init/main.c
@@ -75,6 +75,9 @@
 
 static int init(void *);
 
+extern void bugcheck(char *, int);
+#define CHECK bugcheck(__FILE__, __LINE__)
+
 extern void init_IRQ(void);
 extern void fork_init(unsigned long);
 extern void mca_init(void);
@@ -480,6 +483,8 @@ asmlinkage void __init start_kernel(void
 	char * command_line;
 	extern struct kernel_param __start___param[], __stop___param[];
 
+	CHECK;
+
 	smp_setup_processor_id();
 
 	/*
@@ -502,7 +507,9 @@ asmlinkage void __init start_kernel(void
 	page_address_init();
 	printk(KERN_NOTICE);
 	printk(linux_banner);
+	CHECK;
 	setup_arch(&command_line);
+	CHECK;
 	setup_per_cpu_areas();
 	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
 
@@ -517,6 +524,7 @@ asmlinkage void __init start_kernel(void
 	 * fragile until we cpu_idle() for the first time.
 	 */
 	preempt_disable();
+	CHECK;
 	build_all_zonelists();
 	page_alloc_init();
 	printk(KERN_NOTICE "Kernel command line: %s\n", saved_command_line);
@@ -525,6 +533,7 @@ asmlinkage void __init start_kernel(void
 		   __stop___param - __start___param,
 		   &unknown_bootoption);
 	sort_main_extable();
+	CHECK;
 	trap_init();
 	rcu_init();
 	init_IRQ();
@@ -533,8 +542,10 @@ asmlinkage void __init start_kernel(void
 	hrtimers_init();
 	softirq_init();
 	timekeeping_init();
+	CHECK;
 	time_init();
 	profile_init();
+	CHECK;
 	if (!irqs_disabled())
 		printk("start_kernel(): bug: interrupts were enabled early\n");
 	early_boot_irqs_on();
@@ -568,7 +579,9 @@ asmlinkage void __init start_kernel(void
 #endif
 	vfs_caches_init_early();
 	cpuset_init_early();
+	CHECK;
 	mem_init();
+	CHECK;
 	kmem_cache_init();
 	setup_per_cpu_pageset();
 	numa_policy_init();
@@ -577,6 +590,7 @@ asmlinkage void __init start_kernel(void
 	calibrate_delay();
 	pidmap_init();
 	pgtable_cache_init();
+	CHECK;
 	prio_tree_init();
 	anon_vma_init();
 #ifdef CONFIG_X86
@@ -586,12 +600,14 @@ asmlinkage void __init start_kernel(void
 	fork_init(num_physpages);
 	proc_caches_init();
 	buffer_init();
+	CHECK;
 	unnamed_dev_init();
 	key_init();
 	security_init();
 	vfs_caches_init(num_physpages);
 	radix_tree_init();
 	signals_init();
+	CHECK;
 	/* rootfs populating might need page-writeback */
 	page_writeback_init();
 #ifdef CONFIG_PROC_FS
@@ -599,6 +615,7 @@ asmlinkage void __init start_kernel(void
 #endif
 	cpuset_init();
 	taskstats_init_early();
+	CHECK;
 	delayacct_init();
 
 	check_bugs();
@@ -609,7 +626,7 @@ asmlinkage void __init start_kernel(void
 	rest_init();
 }
 
-static int __initdata initcall_debug;
+static int __initdata initcall_debug = 1;
 
 static int __init initcall_debug_setup(char *str)
 {
@@ -639,7 +656,11 @@ static void __init do_initcalls(void)
 			printk("\n");
 		}
 
+		CHECK;
+
 		result = (*call)();
+		
+		CHECK;
 
 		if (result && result != -ENODEV && initcall_debug) {
 			sprintf(msgbuf, "error code %d", result);
@@ -725,21 +746,32 @@ static int init(void * unused)
 
 	smp_prepare_cpus(max_cpus);
 
+	CHECK;
+
 	do_pre_smp_initcalls();
 
 	smp_init();
+
+	CHECK;
+
 	sched_init_smp();
 
 	cpuset_init_smp();
 
+	CHECK;
+
 	/*
 	 * Do this before initcalls, because some drivers want to access
 	 * firmware files.
 	 */
 	populate_rootfs();
 
+	CHECK;
+
 	do_basic_setup();
 
+	CHECK;
+
 	/*
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
Index: linux-2.6.19-rc1-hack/net/xfrm/xfrm_policy.c
===================================================================
--- linux-2.6.19-rc1-hack.orig/net/xfrm/xfrm_policy.c
+++ linux-2.6.19-rc1-hack/net/xfrm/xfrm_policy.c
@@ -39,6 +39,16 @@ EXPORT_SYMBOL(xfrm_policy_count);
 static DEFINE_RWLOCK(xfrm_policy_afinfo_lock);
 static struct xfrm_policy_afinfo *xfrm_policy_afinfo[NPROTO];
 
+void bugcheck(char *where, int line)
+{
+	int i;
+	for (i = 0; i < NPROTO; i++)
+		if (xfrm_policy_afinfo[i] == (void *)-1UL) {
+			panic("afinfo corrupted at %s:%d\n",where,line);
+			return;
+		}
+}
+
 static kmem_cache_t *xfrm_dst_cache __read_mostly;
 
 static struct work_struct xfrm_policy_gc_work;
Index: linux-2.6.19-rc1-hack/arch/x86_64/kernel/setup.c
===================================================================
--- linux-2.6.19-rc1-hack.orig/arch/x86_64/kernel/setup.c
+++ linux-2.6.19-rc1-hack/arch/x86_64/kernel/setup.c
@@ -65,6 +65,12 @@
 #include <asm/sections.h>
 #include <asm/dmi.h>
 
+
+
+extern void bugcheck(char *, int);
+#define CHECK bugcheck(__FILE__, __LINE__)
+
+
 /*
  * Machine setup..
  */
@@ -351,14 +357,22 @@ void __init setup_arch(char **cmdline_p)
 	saved_video_mode = SAVED_VIDEO_MODE;
 	bootloader_type = LOADER_TYPE;
 
+	CHECK;
+
 #ifdef CONFIG_BLK_DEV_RAM
 	rd_image_start = RAMDISK_FLAGS & RAMDISK_IMAGE_START_MASK;
 	rd_prompt = ((RAMDISK_FLAGS & RAMDISK_PROMPT_FLAG) != 0);
 	rd_doload = ((RAMDISK_FLAGS & RAMDISK_LOAD_FLAG) != 0);
 #endif
+
+	CHECK;
+
 	setup_memory_region();
+	CHECK;
 	copy_edd();
 
+	CHECK;
+
 	if (!MOUNT_ROOT_RDONLY)
 		root_mountflags &= ~MS_RDONLY;
 	init_mm.start_code = (unsigned long) &_text;
@@ -373,14 +387,25 @@ void __init setup_arch(char **cmdline_p)
 
 	early_identify_cpu(&boot_cpu_data);
 
+	CHECK;
+
+
 	strlcpy(command_line, saved_command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 
+	CHECK;
+
+
 	parse_early_param();
 
+	CHECK;
+
 	finish_e820_parsing();
+	CHECK;
 
 	e820_register_active_regions(0, 0, -1UL);
+	CHECK;
+
 	/*
 	 * partially used pages are not usable - thus
 	 * we are rounding upwards:
@@ -389,14 +414,19 @@ void __init setup_arch(char **cmdline_p)
 	num_physpages = end_pfn;
 
 	check_efer();
+	CHECK;
 
 	discover_ebda();
+	CHECK;
 
 	init_memory_mapping(0, (end_pfn_map << PAGE_SHIFT));
+	CHECK;
 
 	dmi_scan_machine();
+	CHECK;
 
 	zap_low_mappings(0);
+	CHECK;
 
 #ifdef CONFIG_ACPI
 	/*
@@ -405,6 +435,7 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	acpi_boot_table_init();
 #endif
+	CHECK;
 
 	/* How many end-of-memory variables you have, grandma! */
 	max_low_pfn = end_pfn;
@@ -413,6 +444,7 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Remove active ranges so rediscovery with NUMA-awareness happens */
 	remove_all_active_ranges();
+	CHECK;
 
 #ifdef CONFIG_ACPI_NUMA
 	/*
@@ -420,20 +452,24 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	acpi_numa_init();
 #endif
+	CHECK;
 
 #ifdef CONFIG_NUMA
 	numa_initmem_init(0, end_pfn); 
 #else
 	contig_initmem_init(0, end_pfn);
 #endif
+	CHECK;
 
 	/* Reserve direct mapping */
 	reserve_bootmem_generic(table_start << PAGE_SHIFT, 
 				(table_end - table_start) << PAGE_SHIFT);
+	CHECK;
 
 	/* reserve kernel */
 	reserve_bootmem_generic(__pa_symbol(&_text),
 				__pa_symbol(&_end) - __pa_symbol(&_text));
+	CHECK;
 
 	/*
 	 * reserve physical page 0 - it's a special BIOS page on many boxes,
@@ -444,6 +480,7 @@ void __init setup_arch(char **cmdline_p)
 	/* reserve ebda region */
 	if (ebda_addr)
 		reserve_bootmem_generic(ebda_addr, ebda_size);
+	CHECK;
 
 #ifdef CONFIG_SMP
 	/*
@@ -456,6 +493,7 @@ void __init setup_arch(char **cmdline_p)
 	/* Reserve SMP trampoline */
 	reserve_bootmem_generic(SMP_TRAMPOLINE_BASE, PAGE_SIZE);
 #endif
+	CHECK;
 
 #ifdef CONFIG_ACPI_SLEEP
        /*
@@ -463,10 +501,14 @@ void __init setup_arch(char **cmdline_p)
         */
        acpi_reserve_bootmem();
 #endif
+	CHECK;
+
 	/*
 	 * Find and reserve possible boot-time SMP configuration:
 	 */
 	find_smp_config();
+	CHECK;
+
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (LOADER_TYPE && INITRD_START) {
 		if (INITRD_START + INITRD_SIZE <= (end_pfn << PAGE_SHIFT)) {
@@ -484,18 +526,23 @@ void __init setup_arch(char **cmdline_p)
 		}
 	}
 #endif
+	CHECK;
+
 #ifdef CONFIG_KEXEC
 	if (crashk_res.start != crashk_res.end) {
 		reserve_bootmem_generic(crashk_res.start,
 			crashk_res.end - crashk_res.start + 1);
 	}
 #endif
+	CHECK;
 
 	paging_init();
+	CHECK;
 
 #ifdef CONFIG_PCI
 	early_quirks();
 #endif
+	CHECK;
 
 	/*
 	 * set this early, so we dont allocate cpu0
@@ -509,25 +556,36 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	acpi_boot_init();
 #endif
+	CHECK;
 
 	init_cpu_to_node();
+	CHECK;
 
 	/*
 	 * get boot-time SMP configuration:
 	 */
 	if (smp_found_config)
 		get_smp_config();
+	CHECK;
+
 	init_apic_mappings();
+	CHECK;
 
 	/*
 	 * Request address space for all standard RAM and ROM resources
 	 * and also for regions reported as reserved by the e820.
 	 */
 	probe_roms();
+	CHECK;
+
 	e820_reserve_resources(); 
+	CHECK;
+
 	e820_mark_nosave_regions();
+	CHECK;
 
 	request_resource(&iomem_resource, &video_ram_resource);
+	CHECK;
 
 	{
 	unsigned i;
@@ -535,8 +593,10 @@ void __init setup_arch(char **cmdline_p)
 	for (i = 0; i < ARRAY_SIZE(standard_io_resources); i++)
 		request_resource(&ioport_resource, &standard_io_resources[i]);
 	}
+	CHECK;
 
 	e820_setup_gap();
+	CHECK;
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
