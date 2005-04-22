Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbVDVPDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbVDVPDd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVDVPDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:03:33 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:1703 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261963AbVDVPAU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:00:20 -0400
Date: Fri, 22 Apr 2005 16:59:47 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 3/12] s390: fix memory holes and cleanup setup_arch.
Message-ID: <20050422145947.GC17508@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 3/12] s390: fix memory holes and cleanup setup_arch.

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The memory setup didn't take care of memory holes and this makes
the memory management think there would be more memory available
than there is in reality. That causes the OOM killer to kill
processes even if there is enough memory left that can be written
to the swap space.
The patch fixes this by using free_area_init_node with an array
of memory holes instead of free_area_init. Further the patch cleans
up the code in setup.c by splitting setup_arch into smaller pieces.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/setup.c |  385 ++++++++++++++++++++++++++---------------------
 arch/s390/mm/init.c      |   15 +
 2 files changed, 224 insertions(+), 176 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2005-03-02 08:37:48.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2005-04-22 15:45:00.000000000 +0200
@@ -60,6 +60,8 @@ struct {
 #define CHUNK_READ_WRITE 0
 #define CHUNK_READ_ONLY 1
 volatile int __cpu_logical_map[NR_CPUS]; /* logical cpu to cpu address */
+unsigned long __initdata zholes_size[MAX_NR_ZONES];
+static unsigned long __initdata memory_end;
 
 /*
  * Setup options
@@ -78,11 +80,15 @@ static char command_line[COMMAND_LINE_SI
 
 static struct resource code_resource = {
 	.name  = "Kernel code",
+	.start = (unsigned long) &_text,
+	.end = (unsigned long) &_etext - 1,
 	.flags = IORESOURCE_BUSY | IORESOURCE_MEM,
 };
 
 static struct resource data_resource = {
 	.name = "Kernel data",
+	.start = (unsigned long) &_etext,
+	.end = (unsigned long) &_edata - 1,
 	.flags = IORESOURCE_BUSY | IORESOURCE_MEM,
 };
 
@@ -310,90 +316,50 @@ void machine_power_off(void)
 
 EXPORT_SYMBOL(machine_power_off);
 
-/*
- * Setup function called from init/main.c just after the banner
- * was printed.
- */
-extern char _pstart, _pend, _stext;
-
-void __init setup_arch(char **cmdline_p)
+static void __init
+add_memory_hole(unsigned long start, unsigned long end)
 {
-        unsigned long bootmap_size;
-        unsigned long memory_start, memory_end;
-        char c = ' ', cn, *to = command_line, *from = COMMAND_LINE;
-	unsigned long start_pfn, end_pfn;
-        static unsigned int smptrap=0;
-        unsigned long delay = 0;
-	struct _lowcore *lc;
-	int i;
+	unsigned long dma_pfn = MAX_DMA_ADDRESS >> PAGE_SHIFT;
 
-        if (smptrap)
-                return;
-        smptrap=1;
+	if (end <= dma_pfn)
+		zholes_size[ZONE_DMA] += end - start + 1;
+	else if (start > dma_pfn)
+		zholes_size[ZONE_NORMAL] += end - start + 1;
+	else {
+		zholes_size[ZONE_DMA] += dma_pfn - start + 1;
+		zholes_size[ZONE_NORMAL] += end - dma_pfn;
+	}
+}
 
-        /*
-         * print what head.S has found out about the machine 
-         */
-#ifndef CONFIG_ARCH_S390X
-	printk((MACHINE_IS_VM) ?
-	       "We are running under VM (31 bit mode)\n" :
-	       "We are running native (31 bit mode)\n");
-	printk((MACHINE_HAS_IEEE) ?
-	       "This machine has an IEEE fpu\n" :
-	       "This machine has no IEEE fpu\n");
-#else /* CONFIG_ARCH_S390X */
-	printk((MACHINE_IS_VM) ?
-	       "We are running under VM (64 bit mode)\n" :
-	       "We are running native (64 bit mode)\n");
-#endif /* CONFIG_ARCH_S390X */
+static void __init
+parse_cmdline_early(char **cmdline_p)
+{
+	char c = ' ', cn, *to = command_line, *from = COMMAND_LINE;
+	unsigned long delay = 0;
 
-        ROOT_DEV = Root_RAM0;
-        memory_start = (unsigned long) &_end;    /* fixit if use $CODELO etc*/
-#ifndef CONFIG_ARCH_S390X
-	memory_end = memory_size & ~0x400000UL;  /* align memory end to 4MB */
-        /*
-         * We need some free virtual space to be able to do vmalloc.
-         * On a machine with 2GB memory we make sure that we have at
-         * least 128 MB free space for vmalloc.
-         */
-        if (memory_end > 1920*1024*1024)
-                memory_end = 1920*1024*1024;
-#else /* CONFIG_ARCH_S390X */
-	memory_end = memory_size & ~0x200000UL;  /* detected in head.s */
-#endif /* CONFIG_ARCH_S390X */
-        init_mm.start_code = PAGE_OFFSET;
-        init_mm.end_code = (unsigned long) &_etext;
-        init_mm.end_data = (unsigned long) &_edata;
-        init_mm.brk = (unsigned long) &_end;
-
-	code_resource.start = (unsigned long) &_text;
-	code_resource.end = (unsigned long) &_etext - 1;
-	data_resource.start = (unsigned long) &_etext;
-	data_resource.end = (unsigned long) &_edata - 1;
-
-        /* Save unparsed command line copy for /proc/cmdline */
-        memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
-        saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
-
-        for (;;) {
-                /*
-                 * "mem=XXX[kKmM]" sets memsize 
-                 */
-                if (c == ' ' && strncmp(from, "mem=", 4) == 0) {
-                        memory_end = simple_strtoul(from+4, &from, 0);
-                        if ( *from == 'K' || *from == 'k' ) {
-                                memory_end = memory_end << 10;
-                                from++;
-                        } else if ( *from == 'M' || *from == 'm' ) {
-                                memory_end = memory_end << 20;
-                                from++;
-                        }
-                }
-                /*
-                 * "ipldelay=XXX[sm]" sets ipl delay in seconds or minutes
-                 */
-                if (c == ' ' && strncmp(from, "ipldelay=", 9) == 0) {
-                        delay = simple_strtoul(from+9, &from, 0);
+	/* Save unparsed command line copy for /proc/cmdline */
+	memcpy(saved_command_line, COMMAND_LINE, COMMAND_LINE_SIZE);
+	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+
+	for (;;) {
+		/*
+		 * "mem=XXX[kKmM]" sets memsize
+		 */
+		if (c == ' ' && strncmp(from, "mem=", 4) == 0) {
+			memory_end = simple_strtoul(from+4, &from, 0);
+			if ( *from == 'K' || *from == 'k' ) {
+				memory_end = memory_end << 10;
+				from++;
+			} else if ( *from == 'M' || *from == 'm' ) {
+				memory_end = memory_end << 20;
+				from++;
+			}
+		}
+		/*
+		 * "ipldelay=XXX[sm]" sets ipl delay in seconds or minutes
+		 */
+		if (c == ' ' && strncmp(from, "ipldelay=", 9) == 0) {
+			delay = simple_strtoul(from+9, &from, 0);
 			if (*from == 's' || *from == 'S') {
 				delay = delay*1000000;
 				from++;
@@ -403,24 +369,110 @@ void __init setup_arch(char **cmdline_p)
 			}
 			/* now wait for the requested amount of time */
 			udelay(delay);
-                }
-                cn = *(from++);
-                if (!cn)
-                        break;
-                if (cn == '\n')
-                        cn = ' ';  /* replace newlines with space */
+		}
+		cn = *(from++);
+		if (!cn)
+			break;
+		if (cn == '\n')
+			cn = ' ';  /* replace newlines with space */
 		if (cn == 0x0d)
 			cn = ' ';  /* replace 0x0d with space */
-                if (cn == ' ' && c == ' ')
-                        continue;  /* remove additional spaces */
-                c = cn;
-                if (to - command_line >= COMMAND_LINE_SIZE)
-                        break;
-                *(to++) = c;
-        }
-        if (c == ' ' && to > command_line) to--;
-        *to = '\0';
-        *cmdline_p = command_line;
+		if (cn == ' ' && c == ' ')
+			continue;  /* remove additional spaces */
+		c = cn;
+		if (to - command_line >= COMMAND_LINE_SIZE)
+			break;
+		*(to++) = c;
+	}
+	if (c == ' ' && to > command_line) to--;
+	*to = '\0';
+	*cmdline_p = command_line;
+}
+
+static void __init
+setup_lowcore(void)
+{
+	struct _lowcore *lc;
+	int lc_pages;
+
+	/*
+	 * Setup lowcore for boot cpu
+	 */
+	lc_pages = sizeof(void *) == 8 ? 2 : 1;
+	lc = (struct _lowcore *)
+		__alloc_bootmem(lc_pages * PAGE_SIZE, lc_pages * PAGE_SIZE, 0);
+	memset(lc, 0, lc_pages * PAGE_SIZE);
+	lc->restart_psw.mask = PSW_BASE_BITS;
+	lc->restart_psw.addr =
+		PSW_ADDR_AMODE | (unsigned long) restart_int_handler;
+	lc->external_new_psw.mask = PSW_KERNEL_BITS;
+	lc->external_new_psw.addr =
+		PSW_ADDR_AMODE | (unsigned long) ext_int_handler;
+	lc->svc_new_psw.mask = PSW_KERNEL_BITS | PSW_MASK_IO | PSW_MASK_EXT;
+	lc->svc_new_psw.addr = PSW_ADDR_AMODE | (unsigned long) system_call;
+	lc->program_new_psw.mask = PSW_KERNEL_BITS;
+	lc->program_new_psw.addr =
+		PSW_ADDR_AMODE | (unsigned long)pgm_check_handler;
+	lc->mcck_new_psw.mask = PSW_KERNEL_BITS;
+	lc->mcck_new_psw.addr =
+		PSW_ADDR_AMODE | (unsigned long) mcck_int_handler;
+	lc->io_new_psw.mask = PSW_KERNEL_BITS;
+	lc->io_new_psw.addr = PSW_ADDR_AMODE | (unsigned long) io_int_handler;
+	lc->ipl_device = S390_lowcore.ipl_device;
+	lc->jiffy_timer = -1LL;
+	lc->kernel_stack = ((unsigned long) &init_thread_union) + THREAD_SIZE;
+	lc->async_stack = (unsigned long)
+		__alloc_bootmem(ASYNC_SIZE, ASYNC_SIZE, 0) + ASYNC_SIZE;
+#ifdef CONFIG_CHECK_STACK
+	lc->panic_stack = (unsigned long)
+		__alloc_bootmem(PAGE_SIZE, PAGE_SIZE, 0) + PAGE_SIZE;
+#endif
+	lc->current_task = (unsigned long) init_thread_union.thread_info.task;
+	lc->thread_info = (unsigned long) &init_thread_union;
+#ifdef CONFIG_ARCH_S390X
+	if (MACHINE_HAS_DIAG44)
+		lc->diag44_opcode = 0x83000044;
+	else
+		lc->diag44_opcode = 0x07000700;
+#endif /* CONFIG_ARCH_S390X */
+	set_prefix((u32)(unsigned long) lc);
+}
+
+static void __init
+setup_resources(void)
+{
+	struct resource *res;
+	int i;
+
+	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++) {
+		res = alloc_bootmem_low(sizeof(struct resource));
+		res->flags = IORESOURCE_BUSY | IORESOURCE_MEM;
+		switch (memory_chunk[i].type) {
+		case CHUNK_READ_WRITE:
+			res->name = "System RAM";
+			break;
+		case CHUNK_READ_ONLY:
+			res->name = "System ROM";
+			res->flags |= IORESOURCE_READONLY;
+			break;
+		default:
+			res->name = "reserved";
+		}
+		res->start = memory_chunk[i].addr;
+		res->end = memory_chunk[i].addr +  memory_chunk[i].size - 1;
+		request_resource(&iomem_resource, res);
+		request_resource(res, &code_resource);
+		request_resource(res, &data_resource);
+	}
+}
+
+static void __init
+setup_memory(void)
+{
+        unsigned long bootmap_size;
+	unsigned long start_pfn, end_pfn;
+	unsigned long last_rw_end;
+	int i;
 
 	/*
 	 * partially used pages are not usable - thus
@@ -437,6 +489,8 @@ void __init setup_arch(char **cmdline_p)
 	/*
 	 * Register RAM areas with the bootmem allocator.
 	 */
+	last_rw_end = start_pfn;
+
 	for (i = 0; i < 16 && memory_chunk[i].size > 0; i++) {
 		unsigned long start_chunk, end_chunk;
 
@@ -450,102 +504,91 @@ void __init setup_arch(char **cmdline_p)
 			start_chunk = start_pfn;
 		if (end_chunk > end_pfn)
 			end_chunk = end_pfn;
-		if (start_chunk < end_chunk)
+		if (start_chunk < end_chunk) {
 			free_bootmem(start_chunk << PAGE_SHIFT,
 				     (end_chunk - start_chunk) << PAGE_SHIFT);
+			if (last_rw_end < start_chunk)
+				add_memory_hole(last_rw_end, start_chunk - 1);
+			last_rw_end = end_chunk;
+		}
 	}
 
-        /*
-         * Reserve the bootmem bitmap itself as well. We do this in two
-         * steps (first step was init_bootmem()) because this catches
-         * the (very unlikely) case of us accidentally initializing the
-         * bootmem allocator with an invalid RAM area.
-         */
-        reserve_bootmem(start_pfn << PAGE_SHIFT, bootmap_size);
+	if (last_rw_end < end_pfn - 1)
+		add_memory_hole(last_rw_end, end_pfn - 1);
+
+	/*
+	 * Reserve the bootmem bitmap itself as well. We do this in two
+	 * steps (first step was init_bootmem()) because this catches
+	 * the (very unlikely) case of us accidentally initializing the
+	 * bootmem allocator with an invalid RAM area.
+	 */
+	reserve_bootmem(start_pfn << PAGE_SHIFT, bootmap_size);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-        if (INITRD_START) {
+	if (INITRD_START) {
 		if (INITRD_START + INITRD_SIZE <= memory_end) {
 			reserve_bootmem(INITRD_START, INITRD_SIZE);
 			initrd_start = INITRD_START;
 			initrd_end = initrd_start + INITRD_SIZE;
 		} else {
-                        printk("initrd extends beyond end of memory "
-                               "(0x%08lx > 0x%08lx)\ndisabling initrd\n",
-                               initrd_start + INITRD_SIZE, memory_end);
-                        initrd_start = initrd_end = 0;
+			printk("initrd extends beyond end of memory "
+			       "(0x%08lx > 0x%08lx)\ndisabling initrd\n",
+			       initrd_start + INITRD_SIZE, memory_end);
+			initrd_start = initrd_end = 0;
 		}
-        }
+	}
 #endif
+}
 
-	for (i = 0; i < 16 && memory_chunk[i].size > 0; i++) {
-		struct resource *res;
-
-		res = alloc_bootmem_low(sizeof(struct resource));
-		res->flags = IORESOURCE_BUSY | IORESOURCE_MEM;
-
-		switch (memory_chunk[i].type) {
-		case CHUNK_READ_WRITE:
-			res->name = "System RAM";
-			break;
-		case CHUNK_READ_ONLY:
-			res->name = "System ROM";
-			res->flags |= IORESOURCE_READONLY;
-			break;
-		default:
-			res->name = "reserved";
-		}
-		res->start = memory_chunk[i].addr;
-		res->end = memory_chunk[i].addr +  memory_chunk[i].size - 1;
-		request_resource(&iomem_resource, res);
-		request_resource(res, &code_resource);
-		request_resource(res, &data_resource);
-	}
+/*
+ * Setup function called from init/main.c just after the banner
+ * was printed.
+ */
 
+void __init
+setup_arch(char **cmdline_p)
+{
         /*
-         * Setup lowcore for boot cpu
+         * print what head.S has found out about the machine
          */
 #ifndef CONFIG_ARCH_S390X
-	lc = (struct _lowcore *) __alloc_bootmem(PAGE_SIZE, PAGE_SIZE, 0);
-	memset(lc, 0, PAGE_SIZE);
+	printk((MACHINE_IS_VM) ?
+	       "We are running under VM (31 bit mode)\n" :
+	       "We are running native (31 bit mode)\n");
+	printk((MACHINE_HAS_IEEE) ?
+	       "This machine has an IEEE fpu\n" :
+	       "This machine has no IEEE fpu\n");
 #else /* CONFIG_ARCH_S390X */
-	lc = (struct _lowcore *) __alloc_bootmem(2*PAGE_SIZE, 2*PAGE_SIZE, 0);
-	memset(lc, 0, 2*PAGE_SIZE);
+	printk((MACHINE_IS_VM) ?
+	       "We are running under VM (64 bit mode)\n" :
+	       "We are running native (64 bit mode)\n");
 #endif /* CONFIG_ARCH_S390X */
-	lc->restart_psw.mask = PSW_BASE_BITS;
-	lc->restart_psw.addr =
-		PSW_ADDR_AMODE | (unsigned long) restart_int_handler;
-	lc->external_new_psw.mask = PSW_KERNEL_BITS;
-	lc->external_new_psw.addr =
-		PSW_ADDR_AMODE | (unsigned long) ext_int_handler;
-	lc->svc_new_psw.mask = PSW_KERNEL_BITS | PSW_MASK_IO | PSW_MASK_EXT;
-	lc->svc_new_psw.addr = PSW_ADDR_AMODE | (unsigned long) system_call;
-	lc->program_new_psw.mask = PSW_KERNEL_BITS;
-	lc->program_new_psw.addr =
-		PSW_ADDR_AMODE | (unsigned long)pgm_check_handler;
-	lc->mcck_new_psw.mask = PSW_KERNEL_BITS;
-	lc->mcck_new_psw.addr =
-		PSW_ADDR_AMODE | (unsigned long) mcck_int_handler;
-	lc->io_new_psw.mask = PSW_KERNEL_BITS;
-	lc->io_new_psw.addr = PSW_ADDR_AMODE | (unsigned long) io_int_handler;
-	lc->ipl_device = S390_lowcore.ipl_device;
-	lc->jiffy_timer = -1LL;
-	lc->kernel_stack = ((unsigned long) &init_thread_union) + THREAD_SIZE;
-	lc->async_stack = (unsigned long)
-		__alloc_bootmem(ASYNC_SIZE, ASYNC_SIZE, 0) + ASYNC_SIZE;
-#ifdef CONFIG_CHECK_STACK
-	lc->panic_stack = (unsigned long)
-		__alloc_bootmem(PAGE_SIZE, PAGE_SIZE, 0) + PAGE_SIZE;
-#endif
-	lc->current_task = (unsigned long) init_thread_union.thread_info.task;
-	lc->thread_info = (unsigned long) &init_thread_union;
-#ifdef CONFIG_ARCH_S390X
-	if (MACHINE_HAS_DIAG44)
-		lc->diag44_opcode = 0x83000044;
-	else
-		lc->diag44_opcode = 0x07000700;
+
+        ROOT_DEV = Root_RAM0;
+#ifndef CONFIG_ARCH_S390X
+	memory_end = memory_size & ~0x400000UL;  /* align memory end to 4MB */
+        /*
+         * We need some free virtual space to be able to do vmalloc.
+         * On a machine with 2GB memory we make sure that we have at
+         * least 128 MB free space for vmalloc.
+         */
+        if (memory_end > 1920*1024*1024)
+                memory_end = 1920*1024*1024;
+#else /* CONFIG_ARCH_S390X */
+	memory_end = memory_size & ~0x200000UL;  /* detected in head.s */
 #endif /* CONFIG_ARCH_S390X */
-	set_prefix((u32)(unsigned long) lc);
+
+	init_mm.start_code = PAGE_OFFSET;
+	init_mm.end_code = (unsigned long) &_etext;
+	init_mm.end_data = (unsigned long) &_edata;
+	init_mm.brk = (unsigned long) &_end;
+
+	parse_cmdline_early(cmdline_p);
+
+	setup_memory();
+	setup_resources();
+	setup_lowcore();
+
         cpu_init();
         __cpu_logical_map[0] = S390_lowcore.cpu_data.cpu_addr;
 
diff -urpN linux-2.6/arch/s390/mm/init.c linux-2.6-patched/arch/s390/mm/init.c
--- linux-2.6/arch/s390/mm/init.c	2005-04-22 15:44:44.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/init.c	2005-04-22 15:45:00.000000000 +0200
@@ -101,6 +101,7 @@ extern unsigned long _end;
 extern unsigned long __init_begin;
 extern unsigned long __init_end;
 
+extern unsigned long __initdata zholes_size[];
 /*
  * paging_init() sets up the page tables
  */
@@ -163,10 +164,13 @@ void __init paging_init(void)
         local_flush_tlb();
 
 	{
-		unsigned long zones_size[MAX_NR_ZONES] = { 0, 0, 0};
+		unsigned long zones_size[MAX_NR_ZONES];
 
+		memset(zones_size, 0, sizeof(zones_size));
 		zones_size[ZONE_DMA] = max_low_pfn;
-		free_area_init(zones_size);
+		free_area_init_node(0, &contig_page_data, zones_size,
+				    __pa(PAGE_OFFSET) >> PAGE_SHIFT,
+				    zholes_size);
 	}
         return;
 }
@@ -184,9 +188,10 @@ void __init paging_init(void)
           _KERN_REGION_TABLE;
 	static const int ssm_mask = 0x04000000L;
 
-	unsigned long zones_size[MAX_NR_ZONES] = {0, 0, 0};
+	unsigned long zones_size[MAX_NR_ZONES];
 	unsigned long dma_pfn, high_pfn;
 
+	memset(zones_size, 0, sizeof(zones_size));
 	dma_pfn = MAX_DMA_ADDRESS >> PAGE_SHIFT;
 	high_pfn = max_low_pfn;
 
@@ -198,8 +203,8 @@ void __init paging_init(void)
 	}
 
 	/* Initialize mem_map[].  */
-	free_area_init(zones_size);
-
+	free_area_init_node(0, &contig_page_data, zones_size,
+			    __pa(PAGE_OFFSET) >> PAGE_SHIFT, zholes_size);
 
 	/*
 	 * map whole physical memory to virtual memory (identity mapping) 
