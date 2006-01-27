Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422654AbWA0WwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbWA0WwI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbWA0Wvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:51:47 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:35489 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1422656AbWA0Wvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:51:38 -0500
Date: Sat, 28 Jan 2006 00:51:37 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/11] sh: Cleanup struct sh_cpuinfo for clock framework changes.
Message-ID: <20060127225137.GE30816@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060127224919.GA30816@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127224919.GA30816@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the clock framework changes have been integrated, the manual
clock accounting that was done in sh_cpuinfo can be dropped.

Also correct a bug with running past the end of the CPU flags when
there's a mismatch between the added flags and printed ones.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sh/kernel/setup.c     |   38 +++++++++++++++-----------------------
 include/asm-sh/processor.h |   36 +++++++++++++++---------------------
 2 files changed, 30 insertions(+), 44 deletions(-)

3e717e73a0c3ab7cbb26725b39b5ab1429cae266
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 036050b..0f1fbe7 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -22,10 +22,10 @@
 #include <linux/cpu.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
-#include <asm/io_generic.h>
 #include <asm/sections.h>
 #include <asm/irq.h>
 #include <asm/setup.h>
+#include <asm/clock.h>
 
 #ifdef CONFIG_SH_KGDB
 #include <asm/kgdb.h>
@@ -41,7 +41,7 @@ extern void * __rd_start, * __rd_end;
  * This value will be used at the very early stage of serial setup.
  * The bigger value means no problem.
  */
-struct sh_cpuinfo boot_cpu_data = { CPU_SH_NONE, 0, 10000000, };
+struct sh_cpuinfo boot_cpu_data = { CPU_SH_NONE, 10000000, };
 struct screen_info screen_info;
 
 #if defined(CONFIG_SH_UNKNOWN)
@@ -273,10 +273,10 @@ void __init setup_arch(char **cmdline_p)
 	init_mm.end_data = (unsigned long) _edata;
 	init_mm.brk = (unsigned long) _end;
 
-	code_resource.start = virt_to_bus(_text);
-	code_resource.end = virt_to_bus(_etext)-1;
-	data_resource.start = virt_to_bus(_etext);
-	data_resource.end = virt_to_bus(_edata)-1;
+	code_resource.start = (unsigned long)virt_to_phys(_text);
+	code_resource.end = (unsigned long)virt_to_phys(_etext)-1;
+	data_resource.start = (unsigned long)virt_to_phys(_etext);
+	data_resource.end = (unsigned long)virt_to_phys(_edata)-1;
 
 	sh_mv_setup(cmdline_p);
 
@@ -435,6 +435,9 @@ static const char *cpu_name[] = {
 	[CPU_ST40GX1]	= "ST40GX1",
 	[CPU_SH4_202]	= "SH4-202",
 	[CPU_SH4_501]	= "SH4-501",
+	[CPU_SH7770]	= "SH7770",
+	[CPU_SH7780]	= "SH7780",
+	[CPU_SH7781]	= "SH7781",
 	[CPU_SH_NONE]	= "Unknown"
 };
 
@@ -445,7 +448,7 @@ const char *get_cpu_subtype(void)
 
 #ifdef CONFIG_PROC_FS
 static const char *cpu_flags[] = {
-	"none", "fpu", "p2flush", "mmuassoc", "dsp", "perfctr",
+	"none", "fpu", "p2flush", "mmuassoc", "dsp", "perfctr", "ptea", NULL
 };
 
 static void show_cpuflags(struct seq_file *m)
@@ -459,7 +462,7 @@ static void show_cpuflags(struct seq_fil
 		return;
 	}
 
-	for (i = 0; i < cpu_data->flags; i++)
+	for (i = 0; cpu_flags[i]; i++)
 		if ((cpu_data->flags & (1 << i)))
 			seq_printf(m, " %s", cpu_flags[i+1]);
 
@@ -472,7 +475,8 @@ static void show_cacheinfo(struct seq_fi
 
 	cache_size = info.ways * info.sets * info.linesz;
 
-	seq_printf(m, "%s size\t: %dKiB\n", type, cache_size >> 10);
+	seq_printf(m, "%s size\t: %2dKiB (%d-way)\n",
+		   type, cache_size >> 10, info.ways);
 }
 
 /*
@@ -511,21 +515,9 @@ static int show_cpuinfo(struct seq_file 
 		     boot_cpu_data.loops_per_jiffy/(500000/HZ),
 		     (boot_cpu_data.loops_per_jiffy/(5000/HZ)) % 100);
 
-#define PRINT_CLOCK(name, value) \
-	seq_printf(m, name " clock\t: %d.%02dMHz\n", \
-		     ((value) / 1000000), ((value) % 1000000)/10000)
-	
-	PRINT_CLOCK("cpu", boot_cpu_data.cpu_clock);
-	PRINT_CLOCK("bus", boot_cpu_data.bus_clock);
-#ifdef CONFIG_CPU_SUBTYPE_ST40STB1
-	PRINT_CLOCK("memory", boot_cpu_data.memory_clock);
-#endif
-	PRINT_CLOCK("module", boot_cpu_data.module_clock);
-
-	return 0;
+	return show_clocks(m);
 }
 
-
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
 	return *pos < NR_CPUS ? cpu_data + *pos : NULL;
@@ -596,7 +588,7 @@ static int __init kgdb_parse_options(cha
 		options += map->namelen + 1;
 
 		options = (*options == ',') ? options+1 : options;
-		
+
 		/* Read optional parameters (baud/parity/bits) */
 		baud = simple_strtoul(options, &options, 10);
 		if (baud != 0) {
diff --git a/include/asm-sh/processor.h b/include/asm-sh/processor.h
index c490479..fa5bd2d 100644
--- a/include/asm-sh/processor.h
+++ b/include/asm-sh/processor.h
@@ -12,7 +12,6 @@
 #include <asm/page.h>
 #include <asm/types.h>
 #include <asm/cache.h>
-#include <linux/threads.h>
 #include <asm/ptrace.h>
 
 /*
@@ -30,7 +29,7 @@
  *  CPU type and hardware bug flags. Kept separately for each CPU.
  *
  *  Each one of these also needs a CONFIG_CPU_SUBTYPE_xxx entry
- *  in arch/sh/Kconfig, as well as an entry in arch/sh/kernel/setup.c
+ *  in arch/sh/mm/Kconfig, as well as an entry in arch/sh/kernel/setup.c
  *  for parsing the subtype in get_cpu_subtype().
  */
 enum cpu_type {
@@ -44,7 +43,7 @@ enum cpu_type {
 	/* SH-4 types */
 	CPU_SH7750, CPU_SH7750S, CPU_SH7750R, CPU_SH7751, CPU_SH7751R,
 	CPU_SH7760, CPU_ST40RA, CPU_ST40GX1, CPU_SH4_202, CPU_SH4_501,
-	CPU_SH73180,
+	CPU_SH73180, CPU_SH7770, CPU_SH7780, CPU_SH7781,
 
 	/* Unknown subtype */
 	CPU_SH_NONE
@@ -52,14 +51,8 @@ enum cpu_type {
 
 struct sh_cpuinfo {
 	enum cpu_type type;
-	char	hard_math;
 	unsigned long loops_per_jiffy;
 
-	unsigned int cpu_clock, master_clock, bus_clock, module_clock;
-#ifdef CONFIG_CPU_SUBTYPE_ST40STB1
-	unsigned int memory_clock;
-#endif
-
 	struct cache_info icache;
 	struct cache_info dcache;
 
@@ -131,7 +124,7 @@ union sh_fpu_union {
 	struct sh_fpu_soft_struct soft;
 };
 
-/* 
+/*
  * Processor flags
  */
 
@@ -140,6 +133,7 @@ union sh_fpu_union {
 #define CPU_HAS_MMU_PAGE_ASSOC	0x0004	/* SH3: TLB way selection bit support */
 #define CPU_HAS_DSP		0x0008	/* SH-DSP: DSP support */
 #define CPU_HAS_PERF_COUNTER	0x0010	/* Hardware performance counters */
+#define CPU_HAS_PTEA		0x0020	/* PTEA register */
 
 struct thread_struct {
 	unsigned long sp;
@@ -160,10 +154,10 @@ extern int ubc_usercnt;
 #define INIT_THREAD  {						\
 	sizeof(init_stack) + (long) &init_stack, /* sp */	\
 	0,					 /* pc */	\
-	0, 0, 							\
-	0, 							\
-	0, 							\
-	{{{0,}},} 				/* fpu state */	\
+	0, 0,							\
+	0,							\
+	0,							\
+	{{{0,}},}				/* fpu state */	\
 }
 
 /*
@@ -171,7 +165,7 @@ extern int ubc_usercnt;
  */
 #define start_thread(regs, new_pc, new_sp)	 \
 	set_fs(USER_DS);			 \
-	regs->pr = 0;   		 	 \
+	regs->pr = 0;				 \
 	regs->sr = SR_FD;	/* User mode. */ \
 	regs->pc = new_pc;			 \
 	regs->regs[15] = new_sp
@@ -239,16 +233,16 @@ extern void save_fpu(struct task_struct 
 #define save_fpu(tsk)	do { } while (0)
 #endif
 
-#define unlazy_fpu(tsk, regs) do { 				\
+#define unlazy_fpu(tsk, regs) do {			\
 	if (test_tsk_thread_flag(tsk, TIF_USEDFPU)) {	\
-		save_fpu(tsk, regs); 				\
+		save_fpu(tsk, regs);			\
 	}						\
 } while (0)
 
-#define clear_fpu(tsk, regs) do { 					\
-	if (test_tsk_thread_flag(tsk, TIF_USEDFPU)) { 		\
-		clear_tsk_thread_flag(tsk, TIF_USEDFPU); 	\
-		release_fpu(regs);					\
+#define clear_fpu(tsk, regs) do {				\
+	if (test_tsk_thread_flag(tsk, TIF_USEDFPU)) {		\
+		clear_tsk_thread_flag(tsk, TIF_USEDFPU);	\
+		release_fpu(regs);				\
 	}							\
 } while (0)
 
