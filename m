Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129509AbQJaLpp>; Tue, 31 Oct 2000 06:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129522AbQJaLpg>; Tue, 31 Oct 2000 06:45:36 -0500
Received: from Cantor.suse.de ([194.112.123.193]:63498 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129509AbQJaLpW>;
	Tue, 31 Oct 2000 06:45:22 -0500
Date: Tue, 31 Oct 2000 12:43:18 +0100
From: Andi Kleen <ak@suse.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Separate CPU detection from setup_arch
Message-ID: <20001031124318.A28998@gruyere.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hallo Linus,

The following patch separates the CPU detection and BIOS interface stuff
in arch/i386/kernel/setup.c from the actual CPU init. This makes it a bit
easier to share code with the x86-64 port [we want to share all the CPU
detection and e820 code, but the cpu init has to be separated] 
The patch looks big, but it is basically only cut'n'paste work and should 
have no functional changes on i386.

Could you apply it ?  Against 2.4.0test10pre7 


Thanks,


-Andi



--- arch/i386/kernel/setup.c-CPUINIT	Tue Oct 24 10:45:20 2000
+++ arch/i386/kernel/setup.c	Tue Oct 31 12:30:16 2000
@@ -61,13 +61,9 @@
  * This file handles the architecture-dependent parts of initialization
  */
 
-#include <linux/errno.h>
-#include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/stddef.h>
-#include <linux/unistd.h>
-#include <linux/ptrace.h>
 #include <linux/malloc.h>
 #include <linux/user.h>
 #include <linux/a.out.h>
@@ -76,14 +72,9 @@
 #include <linux/delay.h>
 #include <linux/config.h>
 #include <linux/init.h>
-#include <linux/apm_bios.h>
-#ifdef CONFIG_BLK_DEV_RAM
-#include <linux/blk.h>
-#endif
 #include <linux/highmem.h>
 #include <linux/bootmem.h>
 #include <asm/processor.h>
-#include <linux/console.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 #include <asm/io.h>
@@ -95,6 +86,8 @@
 #include <asm/dma.h>
 #include <asm/mpspec.h>
 #include <asm/mmu_context.h>
+#include <asm/setup.h>
+
 /*
  * Machine setup..
  */
@@ -102,6 +95,9 @@
 char ignore_irq13;		/* set if exception 16 works */
 struct cpuinfo_x86 boot_cpu_data = { 0, 0, 0, 0, -1, 1, 0, 0, -1 };
 
+extern char _text, _etext, _edata, _end;
+
+
 unsigned long mmu_cr4_features;
 
 /*
@@ -119,26 +115,10 @@
 /*
  * Setup options
  */
-struct drive_info_struct { char dummy[32]; } drive_info;
-struct screen_info screen_info;
-struct apm_bios_info apm_bios_info;
-struct sys_desc_table_struct {
-	unsigned short length;
-	unsigned char table[0];
-};
 
 struct e820map e820;
 
-unsigned char aux_device_present;
 
-#ifdef CONFIG_BLK_DEV_RAM
-extern int rd_doload;		/* 1 = load ramdisk, 0 = don't load */
-extern int rd_prompt;		/* 1 = prompt for ramdisk, 0 = don't prompt */
-extern int rd_image_start;	/* starting block # of image */
-#endif
-
-extern int root_mountflags;
-extern char _text, _etext, _edata, _end;
 extern unsigned long cpu_khz;
 
 static int disable_x86_serial_nr __initdata = 1;
@@ -296,7 +276,6 @@
 	}
 #endif
 
-
 static char command_line[COMMAND_LINE_SIZE];
        char saved_command_line[COMMAND_LINE_SIZE];
 
@@ -520,7 +499,7 @@
 } /* setup_memory_region */
 
 
-static inline void parse_mem_cmdline (char ** cmdline_p)
+void __init parse_mem_cmdline (char ** cmdline_p)
 {
 	char c = ' ', *to = command_line, *from = COMMAND_LINE;
 	int len = 0;
@@ -590,262 +569,6 @@
 	}
 }
 
-void __init setup_arch(char **cmdline_p)
-{
-	unsigned long bootmap_size;
-	unsigned long start_pfn, max_pfn, max_low_pfn;
-	int i;
-
-#ifdef CONFIG_VISWS
-	visws_get_board_type_and_rev();
-#endif
-
- 	ROOT_DEV = to_kdev_t(ORIG_ROOT_DEV);
- 	drive_info = DRIVE_INFO;
- 	screen_info = SCREEN_INFO;
-	apm_bios_info = APM_BIOS_INFO;
-	if( SYS_DESC_TABLE.length != 0 ) {
-		MCA_bus = SYS_DESC_TABLE.table[3] &0x2;
-		machine_id = SYS_DESC_TABLE.table[0];
-		machine_submodel_id = SYS_DESC_TABLE.table[1];
-		BIOS_revision = SYS_DESC_TABLE.table[2];
-	}
-	aux_device_present = AUX_DEVICE_INFO;
-
-#ifdef CONFIG_BLK_DEV_RAM
-	rd_image_start = RAMDISK_FLAGS & RAMDISK_IMAGE_START_MASK;
-	rd_prompt = ((RAMDISK_FLAGS & RAMDISK_PROMPT_FLAG) != 0);
-	rd_doload = ((RAMDISK_FLAGS & RAMDISK_LOAD_FLAG) != 0);
-#endif
-	setup_memory_region();
-
-	if (!MOUNT_ROOT_RDONLY)
-		root_mountflags &= ~MS_RDONLY;
-	init_mm.start_code = (unsigned long) &_text;
-	init_mm.end_code = (unsigned long) &_etext;
-	init_mm.end_data = (unsigned long) &_edata;
-	init_mm.brk = (unsigned long) &_end;
-
-	code_resource.start = virt_to_bus(&_text);
-	code_resource.end = virt_to_bus(&_etext)-1;
-	data_resource.start = virt_to_bus(&_etext);
-	data_resource.end = virt_to_bus(&_edata)-1;
-
-	parse_mem_cmdline(cmdline_p);
-
-#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
-#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
-#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
-
-/*
- * 128MB for vmalloc and initrd
- */
-#define VMALLOC_RESERVE	(unsigned long)(128 << 20)
-#define MAXMEM		(unsigned long)(-PAGE_OFFSET-VMALLOC_RESERVE)
-#define MAXMEM_PFN	PFN_DOWN(MAXMEM)
-#define MAX_NONPAE_PFN	(1 << 20)
-
-	/*
-	 * partially used pages are not usable - thus
-	 * we are rounding upwards:
-	 */
-	start_pfn = PFN_UP(__pa(&_end));
-
-	/*
-	 * Find the highest page frame number we have available
-	 */
-	max_pfn = 0;
-	for (i = 0; i < e820.nr_map; i++) {
-		unsigned long start, end;
-		/* RAM? */
-		if (e820.map[i].type != E820_RAM)
-			continue;
-		start = PFN_UP(e820.map[i].addr);
-		end = PFN_DOWN(e820.map[i].addr + e820.map[i].size);
-		if (start >= end)
-			continue;
-		if (end > max_pfn)
-			max_pfn = end;
-	}
-
-	/*
-	 * Determine low and high memory ranges:
-	 */
-	max_low_pfn = max_pfn;
-	if (max_low_pfn > MAXMEM_PFN) {
-		max_low_pfn = MAXMEM_PFN;
-#ifndef CONFIG_HIGHMEM
-		/* Maximum memory usable is what is directly addressable */
-		printk(KERN_WARNING "Warning only %ldMB will be used.\n",
-					MAXMEM>>20);
-		if (max_pfn > MAX_NONPAE_PFN)
-			printk(KERN_WARNING "Use a PAE enabled kernel.\n");
-		else
-			printk(KERN_WARNING "Use a HIGHMEM enabled kernel.\n");
-#else /* !CONFIG_HIGHMEM */
-#ifndef CONFIG_X86_PAE
-		if (max_pfn > MAX_NONPAE_PFN) {
-			max_pfn = MAX_NONPAE_PFN;
-			printk(KERN_WARNING "Warning only 4GB will be used.\n");
-			printk(KERN_WARNING "Use a PAE enabled kernel.\n");
-		}
-#endif /* !CONFIG_X86_PAE */
-#endif /* !CONFIG_HIGHMEM */
-	}
-
-#ifdef CONFIG_HIGHMEM
-	highstart_pfn = highend_pfn = max_pfn;
-	if (max_pfn > MAXMEM_PFN) {
-		highstart_pfn = MAXMEM_PFN;
-		printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
-			pages_to_mb(highend_pfn - highstart_pfn));
-	}
-#endif
-	/*
-	 * Initialize the boot-time allocator (with low memory only):
-	 */
-	bootmap_size = init_bootmem(start_pfn, max_low_pfn);
-
-	/*
-	 * Register fully available low RAM pages with the bootmem allocator.
-	 */
-	for (i = 0; i < e820.nr_map; i++) {
-		unsigned long curr_pfn, last_pfn, size;
- 		/*
-		 * Reserve usable low memory
-		 */
-		if (e820.map[i].type != E820_RAM)
-			continue;
-		/*
-		 * We are rounding up the start address of usable memory:
-		 */
-		curr_pfn = PFN_UP(e820.map[i].addr);
-		if (curr_pfn >= max_low_pfn)
-			continue;
-		/*
-		 * ... and at the end of the usable range downwards:
-		 */
-		last_pfn = PFN_DOWN(e820.map[i].addr + e820.map[i].size);
-
-		if (last_pfn > max_low_pfn)
-			last_pfn = max_low_pfn;
-
-		/*
-		 * .. finally, did all the rounding and playing
-		 * around just make the area go away?
-		 */
-		if (last_pfn <= curr_pfn)
-			continue;
-
-		size = last_pfn - curr_pfn;
-		free_bootmem(PFN_PHYS(curr_pfn), PFN_PHYS(size));
-	}
-	/*
-	 * Reserve the bootmem bitmap itself as well. We do this in two
-	 * steps (first step was init_bootmem()) because this catches
-	 * the (very unlikely) case of us accidentally initializing the
-	 * bootmem allocator with an invalid RAM area.
-	 */
-	reserve_bootmem(HIGH_MEMORY, (PFN_PHYS(start_pfn) +
-			 bootmap_size + PAGE_SIZE-1) - (HIGH_MEMORY));
-
-	/*
-	 * reserve physical page 0 - it's a special BIOS page on many boxes,
-	 * enabling clean reboots, SMP operation, laptop functions.
-	 */
-	reserve_bootmem(0, PAGE_SIZE);
-
-#ifdef CONFIG_SMP
-	/*
-	 * But first pinch a few for the stack/trampoline stuff
-	 * FIXME: Don't need the extra page at 4K, but need to fix
-	 * trampoline before removing it. (see the GDT stuff)
-	 */
-	reserve_bootmem(PAGE_SIZE, PAGE_SIZE);
-	smp_alloc_memory(); /* AP processor realmode stacks in low memory*/
-#endif
-
-#ifdef CONFIG_X86_IO_APIC
-	/*
-	 * Find and reserve possible boot-time SMP configuration:
-	 */
-	find_smp_config();
-#endif
-	paging_init();
-#ifdef CONFIG_X86_IO_APIC
-	/*
-	 * get boot-time SMP configuration:
-	 */
-	if (smp_found_config)
-		get_smp_config();
-#endif
-#ifdef CONFIG_X86_LOCAL_APIC
-	init_apic_mappings();
-#endif
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	if (LOADER_TYPE && INITRD_START) {
-		if (INITRD_START + INITRD_SIZE <= (max_low_pfn << PAGE_SHIFT)) {
-			reserve_bootmem(INITRD_START, INITRD_SIZE);
-			initrd_start =
-				INITRD_START ? INITRD_START + PAGE_OFFSET : 0;
-			initrd_end = initrd_start+INITRD_SIZE;
-		}
-		else {
-			printk("initrd extends beyond end of memory "
-			    "(0x%08lx > 0x%08lx)\ndisabling initrd\n",
-			    INITRD_START + INITRD_SIZE,
-			    max_low_pfn << PAGE_SHIFT);
-			initrd_start = 0;
-		}
-	}
-#endif
-
-	/*
-	 * Request address space for all standard RAM and ROM resources
-	 * and also for regions reported as reserved by the e820.
-	 */
-	probe_roms();
-	for (i = 0; i < e820.nr_map; i++) {
-		struct resource *res;
-		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
-			continue;
-		res = alloc_bootmem_low(sizeof(struct resource));
-		switch (e820.map[i].type) {
-		case E820_RAM:	res->name = "System RAM"; break;
-		case E820_ACPI:	res->name = "ACPI Tables"; break;
-		case E820_NVS:	res->name = "ACPI Non-volatile Storage"; break;
-		default:	res->name = "reserved";
-		}
-		res->start = e820.map[i].addr;
-		res->end = res->start + e820.map[i].size - 1;
-		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-		request_resource(&iomem_resource, res);
-		if (e820.map[i].type == E820_RAM) {
-			/*
-			 *  We dont't know which RAM region contains kernel data,
-			 *  so we try it repeatedly and let the resource manager
-			 *  test it.
-			 */
-			request_resource(res, &code_resource);
-			request_resource(res, &data_resource);
-		}
-	}
-	request_resource(&iomem_resource, &vram_resource);
-
-	/* request I/O space for devices used on all i[345]86 PCs */
-	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
-		request_resource(&ioport_resource, standard_io_resources+i);
-
-#ifdef CONFIG_VT
-#if defined(CONFIG_VGA_CONSOLE)
-	conswitchp = &vga_con;
-#elif defined(CONFIG_DUMMY_CONSOLE)
-	conswitchp = &dummy_con;
-#endif
-#endif
-}
-
 static int __init get_model_name(struct cpuinfo_x86 *c)
 {
 	unsigned int n, dummy, *v;
@@ -1800,72 +1523,57 @@
 __setup("notsc", tsc_setup);
 #endif
 
-static unsigned long cpu_initialized __initdata = 0;
 
-/*
- * cpu_init() initializes state that is per-CPU. Some data is already
- * initialized (naturally) in the bootstrap process, such as the GDT
- * and IDT. We reload them nevertheless, this function acts as a
- * 'CPU state barrier', nothing should get across.
- */
-void __init cpu_init (void)
+/* reserve memory areas from the E820 map */ 
+static void __init reserve_820(void)
 {
-	int nr = smp_processor_id();
-	struct tss_struct * t = &init_tss[nr];
+	int i; 
 
-	if (test_and_set_bit(nr, &cpu_initialized)) {
-		printk("CPU#%d already initialized!\n", nr);
-		for (;;) __sti();
-	}
-	printk("Initializing CPU#%d\n", nr);
-
-	if (cpu_has_vme || cpu_has_tsc || cpu_has_de)
-		clear_in_cr4(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
-#ifndef CONFIG_X86_TSC
-	if (tsc_disable && cpu_has_tsc) {
-		printk("Disabling TSC...\n");
-		boot_cpu_data.x86_capability &= ~X86_FEATURE_TSC;
-		set_in_cr4(X86_CR4_TSD);
+	for (i = 0; i < e820.nr_map; i++) {
+		struct resource *res;
+		if (e820.map[i].addr + e820.map[i].size > 0x100000000ULL)
+			continue;
+		res = alloc_bootmem_low(sizeof(struct resource));
+		switch (e820.map[i].type) {
+		case E820_RAM:	res->name = "System RAM"; break;
+		case E820_ACPI:	res->name = "ACPI Tables"; break;
+		case E820_NVS:	res->name = "ACPI Non-volatile Storage"; break;
+		default:	res->name = "reserved";
+		}
+		res->start = e820.map[i].addr;
+		res->end = res->start + e820.map[i].size - 1;
+		res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+		request_resource(&iomem_resource, res);
+		if (e820.map[i].type == E820_RAM) {
+			/*
+			 *  We dont't know which RAM region contains kernel data,
+			 *  so we try it repeatedly and let the resource manager
+			 *  test it.
+			 */
+			request_resource(res, &code_resource);
+			request_resource(res, &data_resource);
+		}
 	}
-#endif
-
-	__asm__ __volatile__("lgdt %0": "=m" (gdt_descr));
-	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
-
-	/*
-	 * Delete NT
-	 */
-	__asm__("pushfl ; andl $0xffffbfff,(%esp) ; popfl");
-
-	/*
-	 * set up and load the per-CPU TSS and LDT
-	 */
-	atomic_inc(&init_mm.mm_count);
-	current->active_mm = &init_mm;
-	if(current->mm)
-		BUG();
-	enter_lazy_tlb(&init_mm, current, nr);
-
-	t->esp0 = current->thread.esp0;
-	set_tss_desc(nr,t);
-	gdt_table[__TSS(nr)].b &= 0xfffffdff;
-	load_TR(nr);
-	load_LDT(&init_mm);
-
-	/*
-	 * Clear all 6 debug registers:
-	 */
+}
 
-#define CD(register) __asm__("movl %0,%%db" #register ::"r"(0) );
+/* Reserve IO areas */ 
+void __init request_pc(void) 
+{ 
+	int i; 
 
-	CD(0); CD(1); CD(2); CD(3); /* no db4 and db5 */; CD(6); CD(7);
+	probe_roms();
+	reserve_820();       
+	request_resource(&iomem_resource, &vram_resource);
 
-#undef CD
+	/* request I/O space for devices used on all i[345]86 PCs */
+	for (i = 0; i < STANDARD_IO_RESOURCES; i++)
+		request_resource(&ioport_resource, standard_io_resources+i);
+} 
 
-	/*
-	 * Force FPU initialization:
-	 */
-	current->flags &= ~PF_USEDFPU;
-	current->used_math = 0;
-	stts();
-}
+void __init code_resource_init(void)
+{ 
+	code_resource.start = virt_to_bus(&_text);
+	code_resource.end = virt_to_bus(&_etext)-1;
+	data_resource.start = virt_to_bus(&_etext);
+	data_resource.end = virt_to_bus(&_edata)-1;
+} 
--- arch/i386/kernel/Makefile-CPUINIT	Tue Oct 24 10:45:20 2000
+++ arch/i386/kernel/Makefile	Tue Oct 31 11:43:35 2000
@@ -18,7 +18,7 @@
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
-		pci-dma.o i386_ksyms.o i387.o bluesmoke.o
+		pci-dma.o i386_ksyms.o i387.o bluesmoke.o cpuinit.o
 
 
 ifdef CONFIG_PCI
--- arch/i386/kernel/cpuinit.c-CPUINIT	Sat Jul 29 14:48:15 2000
+++ arch/i386/kernel/cpuinit.c	Tue Oct 31 12:26:08 2000
@@ -0,0 +1,339 @@
+/*
+ *  linux/arch/i386/kernel/cpuinit.c
+ *
+ *  Copyright (C) 1995  Linus Torvalds
+ *  
+ *  Split from arch/i386/kernel/setup.c in 2000/10 by Andi Kleen.
+ *  See setup.c for revision history. 
+ */
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/config.h>
+#include <asm/setup.h>
+#ifdef CONFIG_BLK_DEV_RAM
+#include <linux/blk.h>
+#endif
+#include <linux/unistd.h>
+#include <linux/ptrace.h>
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/smp.h>
+#include <asm/cobalt.h>
+#include <asm/msr.h>
+#include <asm/desc.h>
+#include <asm/e820.h>
+#include <asm/dma.h>
+#include <asm/mpspec.h>
+#include <asm/mmu_context.h>
+#include <asm/processor.h>
+#include <linux/console.h>
+#include <linux/highmem.h>
+#include <linux/bootmem.h>
+
+#ifdef CONFIG_BLK_DEV_RAM
+extern int rd_doload;		/* 1 = load ramdisk, 0 = don't load */
+extern int rd_prompt;		/* 1 = prompt for ramdisk, 0 = don't prompt */
+extern int rd_image_start;	/* starting block # of image */
+#endif
+
+extern int root_mountflags;
+extern char _text, _etext, _edata, _end;
+
+static unsigned long cpu_initialized __initdata = 0;
+
+struct drive_info_struct drive_info;
+struct screen_info screen_info;
+struct apm_bios_info apm_bios_info;
+unsigned char aux_device_present;
+
+void __init setup_arch(char **cmdline_p)
+{
+	unsigned long bootmap_size;
+	unsigned long start_pfn, max_pfn, max_low_pfn;
+	int i;
+
+#ifdef CONFIG_VISWS
+	visws_get_board_type_and_rev();
+#endif
+
+ 	ROOT_DEV = to_kdev_t(ORIG_ROOT_DEV);
+ 	drive_info = DRIVE_INFO;
+ 	screen_info = SCREEN_INFO;
+	apm_bios_info = APM_BIOS_INFO;
+	if( SYS_DESC_TABLE.length != 0 ) {
+		MCA_bus = SYS_DESC_TABLE.table[3] &0x2;
+		machine_id = SYS_DESC_TABLE.table[0];
+		machine_submodel_id = SYS_DESC_TABLE.table[1];
+		BIOS_revision = SYS_DESC_TABLE.table[2];
+	}
+	aux_device_present = AUX_DEVICE_INFO;
+
+#ifdef CONFIG_BLK_DEV_RAM
+	rd_image_start = RAMDISK_FLAGS & RAMDISK_IMAGE_START_MASK;
+	rd_prompt = ((RAMDISK_FLAGS & RAMDISK_PROMPT_FLAG) != 0);
+	rd_doload = ((RAMDISK_FLAGS & RAMDISK_LOAD_FLAG) != 0);
+#endif
+	setup_memory_region();
+
+	if (!MOUNT_ROOT_RDONLY)
+		root_mountflags &= ~MS_RDONLY;
+	init_mm.start_code = (unsigned long) &_text;
+	init_mm.end_code = (unsigned long) &_etext;
+	init_mm.end_data = (unsigned long) &_edata;
+	init_mm.brk = (unsigned long) &_end;
+
+	code_resource_init(); 
+
+	parse_mem_cmdline(cmdline_p);
+
+#define PFN_UP(x)	(((x) + PAGE_SIZE-1) >> PAGE_SHIFT)
+#define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
+#define PFN_PHYS(x)	((x) << PAGE_SHIFT)
+
+/*
+ * 128MB for vmalloc and initrd
+ */
+#define VMALLOC_RESERVE	(unsigned long)(128 << 20)
+#define MAXMEM		(unsigned long)(-PAGE_OFFSET-VMALLOC_RESERVE)
+#define MAXMEM_PFN	PFN_DOWN(MAXMEM)
+#define MAX_NONPAE_PFN	(1 << 20)
+
+	/*
+	 * partially used pages are not usable - thus
+	 * we are rounding upwards:
+	 */
+	start_pfn = PFN_UP(__pa(&_end));
+
+	/*
+	 * Find the highest page frame number we have available
+	 */
+	max_pfn = 0;
+	for (i = 0; i < e820.nr_map; i++) {
+		unsigned long start, end;
+		/* RAM? */
+		if (e820.map[i].type != E820_RAM)
+			continue;
+		start = PFN_UP(e820.map[i].addr);
+		end = PFN_DOWN(e820.map[i].addr + e820.map[i].size);
+		if (start >= end)
+			continue;
+		if (end > max_pfn)
+			max_pfn = end;
+	}
+
+	/*
+	 * Determine low and high memory ranges:
+	 */
+	max_low_pfn = max_pfn;
+	if (max_low_pfn > MAXMEM_PFN) {
+		max_low_pfn = MAXMEM_PFN;
+#ifndef CONFIG_HIGHMEM
+		/* Maximum memory usable is what is directly addressable */
+		printk(KERN_WARNING "Warning only %ldMB will be used.\n",
+					MAXMEM>>20);
+		if (max_pfn > MAX_NONPAE_PFN)
+			printk(KERN_WARNING "Use a PAE enabled kernel.\n");
+		else
+			printk(KERN_WARNING "Use a HIGHMEM enabled kernel.\n");
+#else /* !CONFIG_HIGHMEM */
+#ifndef CONFIG_X86_PAE
+		if (max_pfn > MAX_NONPAE_PFN) {
+			max_pfn = MAX_NONPAE_PFN;
+			printk(KERN_WARNING "Warning only 4GB will be used.\n");
+			printk(KERN_WARNING "Use a PAE enabled kernel.\n");
+		}
+#endif /* !CONFIG_X86_PAE */
+#endif /* !CONFIG_HIGHMEM */
+	}
+
+#ifdef CONFIG_HIGHMEM
+	highstart_pfn = highend_pfn = max_pfn;
+	if (max_pfn > MAXMEM_PFN) {
+		highstart_pfn = MAXMEM_PFN;
+		printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
+			pages_to_mb(highend_pfn - highstart_pfn));
+	}
+#endif
+	/*
+	 * Initialize the boot-time allocator (with low memory only):
+	 */
+	bootmap_size = init_bootmem(start_pfn, max_low_pfn);
+
+	/*
+	 * Register fully available low RAM pages with the bootmem allocator.
+	 */
+	for (i = 0; i < e820.nr_map; i++) {
+		unsigned long curr_pfn, last_pfn, size;
+ 		/*
+		 * Reserve usable low memory
+		 */
+		if (e820.map[i].type != E820_RAM)
+			continue;
+		/*
+		 * We are rounding up the start address of usable memory:
+		 */
+		curr_pfn = PFN_UP(e820.map[i].addr);
+		if (curr_pfn >= max_low_pfn)
+			continue;
+		/*
+		 * ... and at the end of the usable range downwards:
+		 */
+		last_pfn = PFN_DOWN(e820.map[i].addr + e820.map[i].size);
+
+		if (last_pfn > max_low_pfn)
+			last_pfn = max_low_pfn;
+
+		/*
+		 * .. finally, did all the rounding and playing
+		 * around just make the area go away?
+		 */
+		if (last_pfn <= curr_pfn)
+			continue;
+
+		size = last_pfn - curr_pfn;
+		free_bootmem(PFN_PHYS(curr_pfn), PFN_PHYS(size));
+	}
+	/*
+	 * Reserve the bootmem bitmap itself as well. We do this in two
+	 * steps (first step was init_bootmem()) because this catches
+	 * the (very unlikely) case of us accidentally initializing the
+	 * bootmem allocator with an invalid RAM area.
+	 */
+	reserve_bootmem(HIGH_MEMORY, (PFN_PHYS(start_pfn) +
+			 bootmap_size + PAGE_SIZE-1) - (HIGH_MEMORY));
+
+	/*
+	 * reserve physical page 0 - it's a special BIOS page on many boxes,
+	 * enabling clean reboots, SMP operation, laptop functions.
+	 */
+	reserve_bootmem(0, PAGE_SIZE);
+
+#ifdef CONFIG_SMP
+	/*
+	 * But first pinch a few for the stack/trampoline stuff
+	 * FIXME: Don't need the extra page at 4K, but need to fix
+	 * trampoline before removing it. (see the GDT stuff)
+	 */
+	reserve_bootmem(PAGE_SIZE, PAGE_SIZE);
+	smp_alloc_memory(); /* AP processor realmode stacks in low memory*/
+#endif
+
+#ifdef CONFIG_X86_IO_APIC
+	/*
+	 * Find and reserve possible boot-time SMP configuration:
+	 */
+	find_smp_config();
+#endif
+	paging_init();
+#ifdef CONFIG_X86_IO_APIC
+	/*
+	 * get boot-time SMP configuration:
+	 */
+	if (smp_found_config)
+		get_smp_config();
+#endif
+#ifdef CONFIG_X86_LOCAL_APIC
+	init_apic_mappings();
+#endif
+
+#ifdef CONFIG_BLK_DEV_INITRD
+	if (LOADER_TYPE && INITRD_START) {
+		if (INITRD_START + INITRD_SIZE <= (max_low_pfn << PAGE_SHIFT)) {
+			reserve_bootmem(INITRD_START, INITRD_SIZE);
+			initrd_start =
+				INITRD_START ? INITRD_START + PAGE_OFFSET : 0;
+			initrd_end = initrd_start+INITRD_SIZE;
+		}
+		else {
+			printk("initrd extends beyond end of memory "
+			    "(0x%08lx > 0x%08lx)\ndisabling initrd\n",
+			    INITRD_START + INITRD_SIZE,
+			    max_low_pfn << PAGE_SHIFT);
+			initrd_start = 0;
+		}
+	}
+#endif
+
+	/*
+	 * Request address space for all standard RAM and ROM resources
+	 * and also for regions reported as reserved by the e820.
+	 */
+	request_pc(); 
+
+#ifdef CONFIG_VT
+#if defined(CONFIG_VGA_CONSOLE)
+	conswitchp = &vga_con;
+#elif defined(CONFIG_DUMMY_CONSOLE)
+	conswitchp = &dummy_con;
+#endif
+#endif
+}
+
+/*
+ * cpu_init() initializes state that is per-CPU. Some data is already
+ * initialized (naturally) in the bootstrap process, such as the GDT
+ * and IDT. We reload them nevertheless, this function acts as a
+ * 'CPU state barrier', nothing should get across.
+ */
+void __init cpu_init (void)
+{
+	int nr = smp_processor_id();
+	struct tss_struct * t = &init_tss[nr];
+
+	if (test_and_set_bit(nr, &cpu_initialized)) {
+		printk("CPU#%d already initialized!\n", nr);
+		for (;;) __sti();
+	}
+	printk("Initializing CPU#%d\n", nr);
+
+	if (cpu_has_vme || cpu_has_tsc || cpu_has_de)
+		clear_in_cr4(X86_CR4_VME|X86_CR4_PVI|X86_CR4_TSD|X86_CR4_DE);
+#ifndef CONFIG_X86_TSC
+	if (tsc_disable && cpu_has_tsc) {
+		printk("Disabling TSC...\n");
+		boot_cpu_data.x86_capability &= ~X86_FEATURE_TSC;
+		set_in_cr4(X86_CR4_TSD);
+	}
+#endif
+
+	__asm__ __volatile__("lgdt %0": "=m" (gdt_descr));
+	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
+
+	/*
+	 * Delete NT
+	 */
+	__asm__("pushfl ; andl $0xffffbfff,(%esp) ; popfl");
+
+	/*
+	 * set up and load the per-CPU TSS and LDT
+	 */
+	atomic_inc(&init_mm.mm_count);
+	current->active_mm = &init_mm;
+	if(current->mm)
+		BUG();
+	enter_lazy_tlb(&init_mm, current, nr);
+
+	t->esp0 = current->thread.esp0;
+	set_tss_desc(nr,t);
+	gdt_table[__TSS(nr)].b &= 0xfffffdff;
+	load_TR(nr);
+	load_LDT(&init_mm);
+
+	/*
+	 * Clear all 6 debug registers:
+	 */
+
+#define CD(register) __asm__("movl %0,%%db" #register ::"r"(0) );
+
+	CD(0); CD(1); CD(2); CD(3); /* no db4 and db5 */; CD(6); CD(7);
+
+#undef CD
+
+	/*
+	 * Force FPU initialization:
+	 */
+	current->flags &= ~PF_USEDFPU;
+	current->used_math = 0;
+	stts();
+}
+
--- include/asm-i386/setup.h-CPUINIT	Wed Dec 15 16:50:17 1999
+++ include/asm-i386/setup.h	Tue Oct 31 12:27:53 2000
@@ -1,10 +1,50 @@
+#ifndef _i386_SETUP_H
+#define _i386_SETUP_H
+
+#include <linux/apm_bios.h>
+
+struct sys_desc_table_struct {
+	unsigned short length;
+	unsigned char table[0];
+};
+
+struct drive_info_struct { 
+	char dummy[32]; 
+}; 
+
+extern struct e820map e820;
+
 /*
- *	Just a place holder. We don't want to have to test x86 before
- *	we include stuff
+ * This is set up by the setup-routine at boot-time
  */
+#define PARAM	((unsigned char *)empty_zero_page)
+#define SCREEN_INFO (*(struct screen_info *) (PARAM+0))
+#define EXT_MEM_K (*(unsigned short *) (PARAM+2))
+#define ALT_MEM_K (*(unsigned long *) (PARAM+0x1e0))
+#define E820_MAP_NR (*(char*) (PARAM+E820NR))
+#define E820_MAP    ((struct e820entry *) (PARAM+E820MAP))
+#define APM_BIOS_INFO (*(struct apm_bios_info *) (PARAM+0x40))
+#define DRIVE_INFO (*(struct drive_info_struct *) (PARAM+0x80))
+#define SYS_DESC_TABLE (*(struct sys_desc_table_struct*)(PARAM+0xa0))
+#define MOUNT_ROOT_RDONLY (*(unsigned short *) (PARAM+0x1F2))
+#define RAMDISK_FLAGS (*(unsigned short *) (PARAM+0x1F8))
+#define ORIG_ROOT_DEV (*(unsigned short *) (PARAM+0x1FC))
+#define AUX_DEVICE_INFO (*(unsigned char *) (PARAM+0x1FF))
+#define LOADER_TYPE (*(unsigned char *) (PARAM+0x210))
+#define KERNEL_START (*(unsigned long *) (PARAM+0x214))
+#define INITRD_START (*(unsigned long *) (PARAM+0x218))
+#define INITRD_SIZE (*(unsigned long *) (PARAM+0x21c))
+#define COMMAND_LINE ((char *) (PARAM+2048))
+#define COMMAND_LINE_SIZE 256
 
-#ifndef _i386_SETUP_H
-#define _i386_SETUP_H
+#define RAMDISK_IMAGE_START_MASK  	0x07FF
+#define RAMDISK_PROMPT_FLAG		0x8000
+#define RAMDISK_LOAD_FLAG		0x4000	
 
+extern void visws_get_board_type_and_rev(void); 
+extern void setup_memory_region(void);
+extern void parse_mem_cmdline(char **);
+extern void request_pc(void); 
+extern void code_resource_init(void); 
 
 #endif /* _i386_SETUP_H */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
