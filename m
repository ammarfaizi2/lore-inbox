Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVADTbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVADTbR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 14:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVADTbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 14:31:16 -0500
Received: from mail16c2.megamailservers.com ([216.251.41.136]:49375 "EHLO
	mail16c2") by vger.kernel.org with ESMTP id S261815AbVADTDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 14:03:15 -0500
X-Authenticated-User: jiri.gaisler.com
Message-ID: <41DAE8A3.5050507@gaisler.com>
Date: Tue, 04 Jan 2005 20:04:03 +0100
From: Jiri Gaisler <jiri@gaisler.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: sparclinux@vger.kernel.org
CC: linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: [2/7] LEON SPARC V8 processor support for linux-2.6.10
Content-Type: multipart/mixed;
 boundary="------------050104090608080304020203"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050104090608080304020203
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

linux-2.6.10: Kernel patches:

[2/7] diff2.6.10_arch_sparc.diff:         diff for arch/sparc

--------------050104090608080304020203
Content-Type: text/plain;
 name="diff2.6.10_arch_sparc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff2.6.10_arch_sparc.diff"

diff -Naur ../linux-2.6.10/arch/sparc/Kconfig linux-2.6.10/arch/sparc/Kconfig
--- ../linux-2.6.10/arch/sparc/Kconfig	2004-12-24 22:33:47.000000000 +0100
+++ linux-2.6.10/arch/sparc/Kconfig	2005-01-03 17:58:06.000000000 +0100
@@ -223,6 +223,25 @@
 	  a kernel compiled with this option will run only on sun4.
 	  (And the current version will probably work only on sun4/330.)
 
+config LEON
+	bool "Running on SoC 'Leon', the open source sparc VHDL model"
+	help
+	  Say Y here if you want to run linux on the Leon System-on-a-Chip
+	  platform. For information go to www.gaisler.com. Download the VHDL 
+	  source and use the instruction level Leon sparc-simulator "tsim" which 
+	  is free for private use. 
+
+if LEON
+
+config LEON_3
+	bool "Running on grlib's Leon3 "
+	help
+	  Say Y here if you are running on a Leon3 from grlib
+	  (download from www.gaisler.com). 
+
+endif
+
+          
 if !SUN4
 
 config PCI
diff -Naur ../linux-2.6.10/arch/sparc/kernel/Makefile linux-2.6.10/arch/sparc/kernel/Makefile
--- ../linux-2.6.10/arch/sparc/kernel/Makefile	2004-12-24 22:35:27.000000000 +0100
+++ linux-2.6.10/arch/sparc/kernel/Makefile	2005-01-03 11:36:33.000000000 +0100
@@ -6,7 +6,7 @@
 
 EXTRA_AFLAGS	:= -ansi
 
-IRQ_OBJS := irq.o sun4m_irq.o sun4c_irq.o sun4d_irq.o
+IRQ_OBJS := irq.o sun4m_irq.o sun4c_irq.o sun4d_irq.o leon_irq.o
 obj-y    := entry.o wof.o wuf.o etrap.o rtrap.o traps.o $(IRQ_OBJS) \
 	    process.o signal.o ioport.o setup.o idprom.o \
 	    sys_sparc.o sunos_asm.o systbls.o \
diff -Naur ../linux-2.6.10/arch/sparc/kernel/auxio.c linux-2.6.10/arch/sparc/kernel/auxio.c
--- ../linux-2.6.10/arch/sparc/kernel/auxio.c	2004-12-24 22:35:23.000000000 +0100
+++ linux-2.6.10/arch/sparc/kernel/auxio.c	2005-01-03 11:36:33.000000000 +0100
@@ -29,6 +29,7 @@
 	switch (sparc_cpu_model) {
 	case sun4d:
 	case sun4:
+	case sparc_leon:
 		return;
 	default:
 		break;
diff -Naur ../linux-2.6.10/arch/sparc/kernel/cpu.c linux-2.6.10/arch/sparc/kernel/cpu.c
--- ../linux-2.6.10/arch/sparc/kernel/cpu.c	2004-12-24 22:35:25.000000000 +0100
+++ linux-2.6.10/arch/sparc/kernel/cpu.c	2005-01-03 11:36:33.000000000 +0100
@@ -73,6 +73,9 @@
   { 5, 6, "reserved"},
   { 5, 7, "No FPU"},
   { 9, 3, "Fujitsu or Weitek on-chip FPU"},
+  /* Leon */
+  { 0xf, 0, "Meiko FPU"},
+  { 0xf, 1, "GRFPU"},
 };
 
 #define NSPARCFPU  (sizeof(linux_sparc_fpu)/sizeof(struct cpu_fp_info))
@@ -117,7 +120,9 @@
   { 0xc, 0, "UNKNOWN CPU-VENDOR/TYPE"},
   { 0xd, 0, "UNKNOWN CPU-VENDOR/TYPE"},
   { 0xe, 0, "UNKNOWN CPU-VENDOR/TYPE"},
-  { 0xf, 0, "UNKNOWN CPU-VENDOR/TYPE"},
+  /* Leon */
+  { 0xf, 2, "Gaisler Research - Leon2 SoC"},
+  { 0xf, 3, "Gaisler Research - Leon3 SoC"},
 };
 
 #define NSPARCCHIPS  (sizeof(linux_sparc_chips)/sizeof(struct cpu_iu_info))
@@ -134,10 +139,14 @@
 
 	psr_impl = ((get_psr()>>28)&0xf);
 	psr_vers = ((get_psr()>>24)&0xf);
+#ifdef CONFIG_LEON
+	psr_impl = 0xf;	/* hardcoded ids for older models/simulators */
+	psr_vers = 2;
+#endif
 
 	psr = get_psr();
 	put_psr(psr | PSR_EF);
-	fpu_vers = ((get_fsr()>>17)&0x7);
+	fpu_vers = (get_psr() & PSR_EF) ? ((get_fsr()>>17)&0x7) : 7;
 	put_psr(psr);
 
 	for(i = 0; i<NSPARCCHIPS; i++) {
diff -Naur ../linux-2.6.10/arch/sparc/kernel/head.S linux-2.6.10/arch/sparc/kernel/head.S
--- ../linux-2.6.10/arch/sparc/kernel/head.S	2004-12-24 22:34:26.000000000 +0100
+++ linux-2.6.10/arch/sparc/kernel/head.S	2005-01-03 11:36:33.000000000 +0100
@@ -835,6 +835,8 @@
 
 		cmp	%l1, ' '
 		be	1f
+		 cmp	%l1, '2'		! leon2 or compatible
+		be	1f
 		 cmp	%l1, 'c'
 		be	1f
 		 cmp	%l1, 'm'
@@ -857,6 +859,8 @@
 		be	sun4m_init
 		 cmp	%l1, 'd'		! Let us see how the beast will die
 		be	sun4d_init
+		 cmp	%l1, '2'		! leon2 or compatible
+		be	sun4c_continue_boot
 		 nop
 
 		/* Jump into mmu context zero. */
diff -Naur ../linux-2.6.10/arch/sparc/kernel/idprom.c linux-2.6.10/arch/sparc/kernel/idprom.c
--- ../linux-2.6.10/arch/sparc/kernel/idprom.c	2004-12-24 22:34:26.000000000 +0100
+++ linux-2.6.10/arch/sparc/kernel/idprom.c	2005-01-03 11:36:33.000000000 +0100
@@ -31,6 +31,8 @@
 { "Sun 4/200 Series", (SM_SUN4 | SM_4_260) },
 { "Sun 4/300 Series", (SM_SUN4 | SM_4_330) },
 { "Sun 4/400 Series", (SM_SUN4 | SM_4_470) },
+/* Now Leon */
+{ "Leon2 System-on-a-Chip", (M_LEON2 | M_LEON2_SOC) },
 /* Now, Sun4c's */
 { "Sun4c SparcStation 1", (SM_SUN4C | SM_4C_SS1) },
 { "Sun4c SparcStation IPC", (SM_SUN4C | SM_4C_IPC) },
diff -Naur ../linux-2.6.10/arch/sparc/kernel/irq.c linux-2.6.10/arch/sparc/kernel/irq.c
--- ../linux-2.6.10/arch/sparc/kernel/irq.c	2004-12-24 22:33:50.000000000 +0100
+++ linux-2.6.10/arch/sparc/kernel/irq.c	2005-01-03 11:36:33.000000000 +0100
@@ -579,6 +579,7 @@
 	extern void sun4c_init_IRQ( void );
 	extern void sun4m_init_IRQ( void );
 	extern void sun4d_init_IRQ( void );
+	extern void leon_init_IRQ(void);
 
 	switch(sparc_cpu_model) {
 	case sun4c:
@@ -586,6 +587,10 @@
 		sun4c_init_IRQ();
 		break;
 
+	case sparc_leon:
+		leon_init_IRQ();
+		break;
+
 	case sun4m:
 #ifdef CONFIG_PCI
 		pcic_probe();
diff -Naur ../linux-2.6.10/arch/sparc/kernel/leon_irq.c linux-2.6.10/arch/sparc/kernel/leon_irq.c
--- ../linux-2.6.10/arch/sparc/kernel/leon_irq.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/arch/sparc/kernel/leon_irq.c	2005-01-03 15:54:16.000000000 +0100
@@ -0,0 +1,223 @@
+/* 
+ * irq handling for Leon2/3
+ * Copyright (C) 2004 Konrad Eisele (eiselekd@web.de), Gaisler Research
+ * Copyright (C) 2004 Stefan Holst (mail@s-holst.de), Uni-Stuttgart
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <asm/pgtsrmmu.h>
+#include <asm/leon.h>
+#include <asm/sbus.h> /* for struct sbus_bus, warning suppress */
+#include <asm/timer.h>
+
+/* scaled down to timer to 1Mhz, used in sparc/kernel/leon_irq.c */
+#define CLOCK_TIMER_SCALAR 25
+
+#ifdef CONFIG_LEON_3
+extern volatile LEON3_IrqCtrl_Regs_Map *LEON3_IrqCtrl_Regs; /* drivers/amba/amba.c:amba_init() */
+extern volatile LEON3_GpTimer_Regs_Map *LEON3_GpTimer_Regs;
+extern unsigned long LEON3_GpTimer_Irq; /* drivers/amba.c:amba_init() */
+#undef LEON_IMASK
+#define LEON_IMASK ((&LEON3_IrqCtrl_Regs ->mask[0]))
+#endif
+
+static inline unsigned long get_irqmask(unsigned int irq)
+{
+	unsigned long mask;
+	if (!irq || irq > 0xf) {
+		printk("leon_get_irqmask: false irq number\n");
+		mask = 0;
+	} else {
+		mask = LEON_HARD_INT(irq);
+	}
+	return mask;
+}
+
+void leon_disable_irq(unsigned int irq_nr)
+{
+	unsigned long mask, flags;
+	mask = get_irqmask(irq_nr) & LEON_IRQMASK_R;
+	save_and_cli(flags);
+#ifdef CONFIG_LEON_3
+	LEON3_BYPASS_STORE_PA(LEON_IMASK, (LEON3_BYPASS_LOAD_PA(LEON_IMASK) & ~(mask)));
+#else
+	LEON_REGSTORE_PA(LEON_IMASK, (LEON_REGLOAD_PA(LEON_IMASK) & ~(mask)));
+#endif
+	restore_flags(flags);
+}
+
+void leon_enable_irq(unsigned int irq_nr)
+{
+	unsigned long mask, flags;
+	mask = get_irqmask(irq_nr) & LEON_IRQMASK_R;
+	save_and_cli(flags); 
+#ifdef CONFIG_LEON_3
+	LEON3_BYPASS_STORE_PA(LEON_IMASK, (LEON3_BYPASS_LOAD_PA(LEON_IMASK) | (mask)));
+#else
+	LEON_REGSTORE_PA(LEON_IMASK, (LEON_REGLOAD_PA(LEON_IMASK) | (mask)));
+#endif
+	restore_flags(flags);
+}
+
+/* We assume the caller is local cli()'d when these are called, or else
+ * very bizarre behavior will result. */
+void leon_disable_pil_irq(unsigned int pil)
+{
+	unsigned long mask = get_irqmask(pil);
+#ifdef CONFIG_LEON_3
+	LEON3_BYPASS_STORE_PA(LEON_IMASK, LEON3_BYPASS_LOAD_PA(LEON_IMASK) & ~(mask));
+#else
+	LEON_REGSTORE_PA(LEON_IMASK, LEON_REGLOAD_PA(LEON_IMASK) & ~(mask));
+#endif
+}
+
+void leon_enable_pil_irq(unsigned int pil)
+{
+	unsigned long mask = get_irqmask(pil);
+#ifdef CONFIG_LEON_3
+	LEON3_BYPASS_STORE_PA(LEON_IMASK, LEON3_BYPASS_LOAD_PA(LEON_IMASK) | (mask));
+#else
+	LEON_REGSTORE_PA(LEON_IMASK, LEON_REGLOAD_PA(LEON_IMASK) | (mask));
+#endif
+}
+
+int leondebug_irq_disable;
+int leon_debug_irqout;
+static int dummy_master_l10_counter;
+static int dummy_master_l10_limit;
+
+
+
+/* called by time_init():timer.c */
+void __init leon_init_timers (irqreturn_t (*counter_fn)(int, void *, struct pt_regs *))
+{
+	int irq;
+
+	leondebug_irq_disable = 0;
+	leon_debug_irqout = 0;
+
+#ifdef CONFIG_LEON_3
+        if (LEON3_GpTimer_Regs && LEON3_IrqCtrl_Regs) {
+          //regs -> timerctrl1 = 0;
+          //regs -> timercnt1 = 0;
+          //regs -> timerload1 = (((1000000/100) - 1));
+          LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs ->e[0].val,0);
+          LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs ->e[0].rld,(((1000000/100) - 1)));
+          LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs ->e[0].ctrl,0);
+        } else {
+          while(1) printk("No Timer/irqctrl found\n");
+        }
+#else
+	LEON_REGSTORE_PA(LEON_TCTRL0, 0);
+	LEON_REGSTORE_PA(LEON_TCNT0, 0);
+	LEON_REGSTORE_PA(LEON_TRLD0, (((1000000/HZ) - 1)));
+#endif
+
+	printk("Todo: init master_l10_counter\r\n");
+	master_l10_counter = &dummy_master_l10_counter;
+	master_l10_limit = &dummy_master_l10_limit;
+	dummy_master_l10_counter = 0;
+	dummy_master_l10_limit = 0;
+	
+#ifdef CONFIG_LEON_3
+	irq = request_irq(LEON3_GpTimer_Irq,
+			  counter_fn,
+			  (SA_INTERRUPT | SA_STATIC_ALLOC),
+			  "timer", NULL);
+#else
+	irq = request_irq(LEON_INTERRUPT_TIMER1,
+			  counter_fn,
+			  (SA_INTERRUPT | SA_STATIC_ALLOC),
+			  "timer", NULL);
+#endif
+
+	if (irq) {
+		printk("leon_time_init: unable to attach IRQ%d\n",LEON_INTERRUPT_TIMER1);
+		prom_halt();
+	}	
+
+#ifdef CONFIG_LEON_3
+        LEON3_BYPASS_STORE_PA(&LEON3_GpTimer_Regs ->e[0].ctrl,
+          LEON3_GPTIMER_EN |
+          LEON3_GPTIMER_RL |
+          LEON3_GPTIMER_LD |
+          LEON3_GPTIMER_IRQEN);
+#else
+	/* enable, load reload into counter, set automatic reload */
+	LEON_REGSTORE_PA(LEON_TCTRL0, 0x7);
+#endif
+}
+
+void leon_clear_clock_irq(void)
+{
+}
+
+void leon_clear_profile_irq(int cpu)
+{
+	BUG();
+}
+
+void leon_load_profile_irq(int cpu, unsigned int limit)
+{
+	BUG();
+}
+
+unsigned int leon_sbint_to_irq(struct sbus_dev *sdev, unsigned int sbint)
+{
+	BUG();
+	return 0;
+}
+
+static char *leon_irq_itoa(unsigned int irq)
+{
+	static char buff[16];
+	sprintf(buff, "%d", irq);
+	return buff;
+}
+
+#ifdef CONFIG_SMP
+static void leon_set_cpu_int(int cpu, int level)
+{
+	printk("Not implemented\n");
+	BUG();
+}
+
+static void leon_clear_ipi(int cpu, int level)
+{
+}
+
+static void leon_set_udt(int cpu)
+{
+}
+#endif
+
+void __init leon_init_IRQ(void)
+{
+	sparc_init_timers = leon_init_timers;
+
+	BTFIXUPSET_CALL(sbint_to_irq, leon_sbint_to_irq, BTFIXUPCALL_NORM);
+
+	BTFIXUPSET_CALL(enable_irq, leon_enable_irq, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(disable_irq, leon_disable_irq, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(enable_pil_irq, leon_enable_irq, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(disable_pil_irq, leon_disable_irq, BTFIXUPCALL_NORM);
+
+	BTFIXUPSET_CALL(clear_clock_irq, leon_clear_clock_irq, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(clear_profile_irq, leon_clear_profile_irq, BTFIXUPCALL_NOP);
+	BTFIXUPSET_CALL(load_profile_irq, leon_load_profile_irq, BTFIXUPCALL_NOP);
+	BTFIXUPSET_CALL(__irq_itoa, leon_irq_itoa, BTFIXUPCALL_NORM);
+
+#ifdef CONFIG_SMP
+	BTFIXUPSET_CALL(set_cpu_int, leon_set_cpu_int, BTFIXUPCALL_NOP);
+	BTFIXUPSET_CALL(clear_cpu_int, leon_clear_ipi, BTFIXUPCALL_NOP);
+	BTFIXUPSET_CALL(set_irq_udt, leon_set_udt, BTFIXUPCALL_NOP);
+#endif
+
+}
diff -Naur ../linux-2.6.10/arch/sparc/kernel/setup.c linux-2.6.10/arch/sparc/kernel/setup.c
--- ../linux-2.6.10/arch/sparc/kernel/setup.c	2004-12-24 22:33:49.000000000 +0100
+++ linux-2.6.10/arch/sparc/kernel/setup.c	2005-01-03 16:33:28.000000000 +0100
@@ -257,6 +257,13 @@
 	int i;
 	unsigned long highest_paddr;
 
+#ifdef CONFIG_LEON_3
+	amba_init();
+#ifdef CONFIG_GRLIB_GAISLER_APBUART
+	console_print_LEON("Booting Linux\n");
+#endif
+#endif
+
 	sparc_ttable = (struct tt_entry *) &start;
 
 	/* Initialize PROM console and command line. */
@@ -272,6 +279,7 @@
 	if(!strcmp(&cputypval,"sun4d")) { sparc_cpu_model=sun4d; }
 	if(!strcmp(&cputypval,"sun4e")) { sparc_cpu_model=sun4e; }
 	if(!strcmp(&cputypval,"sun4u")) { sparc_cpu_model=sun4u; }
+	if(!strcmp(&cputypval,"leon2")) { sparc_cpu_model=sparc_leon; }
 
 #ifdef CONFIG_SUN4
 	if (sparc_cpu_model != sun4) {
@@ -279,6 +287,13 @@
 		prom_halt();
 	}
 #endif
+#if defined(CONFIG_LEON) || defined(CONFIG_LEON_3)
+	/* FIXME: psr ids, asi codes, min nocache pages */
+	if (sparc_cpu_model != sparc_leon) {
+		prom_printf("This kernel is for Leon architecture only.\n");
+		prom_halt();
+	}
+#endif
 	printk("ARCH: ");
 	switch(sparc_cpu_model) {
 	case sun4:
@@ -299,6 +314,9 @@
 	case sun4u:
 		printk("SUN4U\n");
 		break;
+	case sparc_leon:
+		printk("LEON\n");
+		break;
 	default:
 		printk("UNKNOWN!\n");
 		break;
@@ -309,6 +327,10 @@
 #elif defined(CONFIG_PROM_CONSOLE)
 	conswitchp = &prom_con;
 #endif
+#ifdef CONFIG_LEON_3
+        amba_prinf_config(); 
+#endif
+
 	boot_flags_init(*cmdline_p);
 
 	idprom_init();
diff -Naur ../linux-2.6.10/arch/sparc/kernel/time.c linux-2.6.10/arch/sparc/kernel/time.c
--- ../linux-2.6.10/arch/sparc/kernel/time.c	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6.10/arch/sparc/kernel/time.c	2005-01-03 16:21:54.000000000 +0100
@@ -43,6 +43,7 @@
 #include <asm/sun4paddr.h>
 #include <asm/page.h>
 #include <asm/pcic.h>
+#include <asm/leon.h>
 
 extern unsigned long wall_jiffies;
 
@@ -300,6 +301,9 @@
 	case sun4d:
 		node = prom_getchild(bootbus = prom_searchsiblings(prom_getchild(cpuunit = prom_searchsiblings(node, "cpu-unit")), "bootbus"));
 		break;
+	case sparc_leon:
+		node = 0;
+		return;
 	default:
 		prom_printf("CLOCK: Unsupported architecture!\n");
 		prom_halt();
@@ -384,6 +388,11 @@
 		clock_probe();
 
 	sparc_init_timers(timer_interrupt);
+
+	if (sparc_cpu_model == sparc_leon) {
+		local_irq_enable();
+		return;
+	}
 	
 #ifdef CONFIG_SUN4
 	if(idprom->id_machtype == (SM_SUN4 | SM_4_330)) {
@@ -458,8 +467,25 @@
 	sbus_time_init();
 }
 
+#ifdef CONFIG_LEON_3
+extern volatile LEON3_IrqCtrl_Regs_Map *LEON3_IrqCtrl_Regs; /* drivers/amba/amba.c:amba_init() */
+extern volatile LEON3_GpTimer_Regs_Map *LEON3_GpTimer_Regs;
+extern unsigned long LEON3_GpTimer_Irq; /* drivers/amba.c:amba_init() */
+#endif
+
 extern __inline__ unsigned long do_gettimeoffset(void)
 {
+	if (sparc_cpu_model == sparc_leon)
+#if defined(CONFIG_LEON) || defined(CONFIG_LEON_3)
+#ifdef CONFIG_LEON_3
+		return ((LEON_REGLOAD_PA(&LEON3_GpTimer_Regs ->e[0].rld)&LEON_TCNT0_MASK) - 
+			(LEON_REGLOAD_PA(&LEON3_GpTimer_Regs ->e[0].val)&LEON_TCNT0_MASK)) >> 2;
+#else
+		return ((LEON_REGLOAD_PA(LEON_TRLD0)&LEON_TCNT0_MASK) - 
+			(LEON_REGLOAD_PA(LEON_TCNT0)&LEON_TCNT0_MASK)) >> 2;
+#endif
+#endif
+
 	return (*master_l10_counter >> 10) & 0x1fffff;
 }
 
diff -Naur ../linux-2.6.10/arch/sparc/kernel/traps.c linux-2.6.10/arch/sparc/kernel/traps.c
--- ../linux-2.6.10/arch/sparc/kernel/traps.c	2004-12-24 22:34:49.000000000 +0100
+++ linux-2.6.10/arch/sparc/kernel/traps.c	2005-01-03 16:32:30.000000000 +0100
@@ -26,6 +26,9 @@
 #include <asm/kdebug.h>
 #include <asm/unistd.h>
 #include <asm/traps.h>
+#if defined(CONFIG_LEON) || defined(CONFIG_LEON_3)
+#include <asm/leon.h>
+#endif
 
 /* #define TRAP_DEBUG */
 
diff -Naur ../linux-2.6.10/arch/sparc/mm/Makefile linux-2.6.10/arch/sparc/mm/Makefile
--- ../linux-2.6.10/arch/sparc/mm/Makefile	2004-12-24 22:35:01.000000000 +0100
+++ linux-2.6.10/arch/sparc/mm/Makefile	2005-01-03 11:36:33.000000000 +0100
@@ -21,3 +21,7 @@
 else
 obj-y   += sun4c.o
 endif
+
+ifdef CONFIG_LEON
+obj-y   += leon.o
+endif
diff -Naur ../linux-2.6.10/arch/sparc/mm/init.c linux-2.6.10/arch/sparc/mm/init.c
--- ../linux-2.6.10/arch/sparc/mm/init.c	2004-12-24 22:34:32.000000000 +0100
+++ linux-2.6.10/arch/sparc/mm/init.c	2005-01-03 16:04:37.000000000 +0100
@@ -32,6 +32,7 @@
 #include <asm/vaddrs.h>
 #include <asm/pgalloc.h>	/* bug in asm-generic/tlb.h: check_pgt_cache */
 #include <asm/tlb.h>
+#include <asm/leon.h>
 
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 
@@ -324,6 +325,7 @@
 		break;
 	case sun4m:
 	case sun4d:
+	case sparc_leon:
 		srmmu_paging_init();
 		sparc_unmapped_base = 0x50000000;
 		BTFIXUPSET_SETHI(sparc_unmapped_base, 0x50000000);
@@ -335,6 +337,19 @@
 		prom_halt();
 	};
 
+
+#ifdef CONFIG_OPEN_ETH
+	if (sparc_cpu_model == sparc_leon) {
+		/* until driver/net/open_eth.c is rewritten to access ethermac core's
+		* registers with asi BYPASS, using sun's DVMA_VADDR range */
+		void srmmu_allocate_ptable_skeleton(unsigned long start, unsigned long end);
+		
+		srmmu_allocate_ptable_skeleton(DVMA_VADDR, DVMA_END);
+		sparc_mapiorange (0,0xb0000000,LEON_VA_ETHERMAC, PAGE_SIZE);
+
+	}
+#endif
+
 	/* Initialize the protection map with non-constant, MMU dependent values. */
 	protection_map[0] = PAGE_NONE;
 	protection_map[1] = PAGE_READONLY;
diff -Naur ../linux-2.6.10/arch/sparc/mm/leon.c linux-2.6.10/arch/sparc/mm/leon.c
--- ../linux-2.6.10/arch/sparc/mm/leon.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.10/arch/sparc/mm/leon.c	2005-01-03 15:48:15.000000000 +0100
@@ -0,0 +1,168 @@
+/* 
+ * do srmmu probe in software
+ * Copyright (C) 2004 Konrad Eisele (eiselekd@web.de), Gaisler Research 
+ */
+ 
+#include <linux/config.h>
+#include <linux/mm.h>
+#include <asm/asi.h>
+#include <asm/leon.h>
+
+#define PFN(x) ((x) >> PAGE_SHIFT)
+extern unsigned long last_valid_pfn;
+
+/* max_mapnr not initialized yet */
+#define _pfn_valid(pfn)	((pfn < last_valid_pfn) && (pfn >= PFN(phys_base)))
+
+int srmmu_swprobe_trace = 0;
+unsigned long srmmu_swprobe(unsigned long vaddr, unsigned long *paddr) {
+      
+  unsigned long ctxtbl;
+  unsigned long pgd,pmd,ped;
+  unsigned long ptr;
+  unsigned long lvl, pte, paddrbase;
+  unsigned long ctx;
+  unsigned long paddr_calc;
+  
+  paddrbase = 0;
+  
+  if (srmmu_swprobe_trace) {
+    printk("swprobe: trace on\n");
+  }
+    
+  if (!(ctxtbl = srmmu_get_ctable_ptr())) {
+    if (srmmu_swprobe_trace) {
+      printk("swprobe: srmmu_get_ctable_ptr returned 0=>0\n");
+    }
+    return 0;
+  }
+  if (!_pfn_valid(PFN(ctxtbl))) {
+    if (srmmu_swprobe_trace) {
+      printk("swprobe: !_pfn_valid(%x)=>0\n",PFN(ctxtbl));
+    }
+    return 0;
+  }
+  
+  ctx = srmmu_get_context();
+  if (srmmu_swprobe_trace) {
+    printk("swprobe:  --- ctx (%x) ---\n",ctx);
+  }
+      
+  pgd = LEON_BYPASS_LOAD_PA(ctxtbl+(ctx*4));
+  
+  if (((pgd&SRMMU_ET_MASK) == SRMMU_ET_PTE)) {
+    if (srmmu_swprobe_trace) {
+      printk("swprobe: pgd is entry level 3\n",pgd);
+    }
+    lvl = 3;
+    pte = pgd;
+    paddrbase = pgd & SRMMU_PTE_PMASK;
+    goto ready;
+  }
+  if (((pgd&SRMMU_ET_MASK) != SRMMU_ET_PTD)) {
+    if (srmmu_swprobe_trace) {
+      printk("swprobe: pgd is invalid => 0\n",pgd);
+    }
+    return 0;
+  }
+
+  if (srmmu_swprobe_trace) {
+    printk("swprobe:  --- pgd (%x) ---\n",pgd);
+  }
+  
+  ptr = (pgd & SRMMU_PTD_PMASK) << 4;  
+  ptr += (((vaddr & 0xff000000)>>24)*4);
+  if (!_pfn_valid(PFN(ptr))) {
+    return 0;
+  }
+  
+  pmd = LEON_BYPASS_LOAD_PA(ptr);
+  if (((pmd&SRMMU_ET_MASK) == SRMMU_ET_PTE)) {
+    if (srmmu_swprobe_trace) {
+      printk("swprobe: pmd is entry level 2\n",pgd);
+    }
+    lvl = 2;    
+    pte = pmd;
+    paddrbase = pmd & SRMMU_PTE_PMASK;
+    goto ready;
+  }
+  if (((pmd&SRMMU_ET_MASK) != SRMMU_ET_PTD)) {
+    if (srmmu_swprobe_trace) {
+      printk("swprobe: pmd is invalid => 0\n",pgd);
+    }
+    return 0;
+  }
+
+  if (srmmu_swprobe_trace) {
+    printk("swprobe:  --- pmd (%x) ---\n",pmd);
+  }
+  
+  ptr = (pmd & SRMMU_PTD_PMASK) << 4;  
+  ptr += (((vaddr & 0x00fc0000)>>18)*4);
+  if (!_pfn_valid(PFN(ptr))){
+    if (srmmu_swprobe_trace) {
+      printk("swprobe: !_pfn_valid(%x)=>0\n",PFN(ptr));
+    }
+    return 0;
+  }
+  
+  ped = LEON_BYPASS_LOAD_PA(ptr);
+  
+  if (((ped&SRMMU_ET_MASK) == SRMMU_ET_PTE)) {
+    if (srmmu_swprobe_trace) {
+      printk("swprobe: ped is entry level 1\n",pgd);
+    }
+    lvl = 1;    
+    pte = ped;
+    paddrbase = ped & SRMMU_PTE_PMASK;
+    goto ready;
+  }
+  if (((ped&SRMMU_ET_MASK) != SRMMU_ET_PTD)) {
+    if (srmmu_swprobe_trace) {
+      printk("swprobe: ped is invalid => 0\n",pgd);
+    }
+    return 0;
+  }
+
+  if (srmmu_swprobe_trace) {
+    printk("swprobe:  --- ped (%x) ---\n",ped);
+  }
+  
+  ptr = (ped & SRMMU_PTD_PMASK) << 4;  
+  ptr += (((vaddr & 0x0003f000)>>12)*4);
+  if (!_pfn_valid(PFN(ptr)))
+    return 0;
+  
+  ptr = LEON_BYPASS_LOAD_PA(ptr);
+  if (((ptr&SRMMU_ET_MASK) == SRMMU_ET_PTE)) {
+    if (srmmu_swprobe_trace) {
+      printk("swprobe: ptr is entry level 0\n",pgd);
+    }
+    lvl = 0;
+    pte = ptr;
+    paddrbase = ptr & SRMMU_PTE_PMASK;
+    goto ready;
+  }
+  if (srmmu_swprobe_trace) {
+    printk("swprobe: ptr is invalid => 0\n",pgd);
+  }
+  return 0;      
+  
+ ready:
+  switch (lvl) {
+  case 0: paddr_calc = (vaddr & 0x00000fff) | ((pte&~0xff)<<4); break;
+  case 1: paddr_calc = (vaddr & 0x0003ffff) | ((pte&~0xff)<<4); break;
+  case 2: paddr_calc = (vaddr & 0x00ffffff) | ((pte&~0xff)<<4); break;
+  default:
+  case 3: paddr_calc =  vaddr; break;
+  }
+  if (srmmu_swprobe_trace) {
+    printk("swprobe: padde %x\n",paddr_calc);
+  }
+  if (paddr) {
+    *paddr = paddr_calc;
+  }
+  return paddrbase;
+}
+
+
diff -Naur ../linux-2.6.10/arch/sparc/mm/loadmmu.c linux-2.6.10/arch/sparc/mm/loadmmu.c
--- ../linux-2.6.10/arch/sparc/mm/loadmmu.c	2004-12-24 22:35:00.000000000 +0100
+++ linux-2.6.10/arch/sparc/mm/loadmmu.c	2005-01-03 11:36:33.000000000 +0100
@@ -36,6 +36,7 @@
 		break;
 	case sun4m:
 	case sun4d:
+	case sparc_leon:
 		ld_mmu_srmmu();
 		break;
 	default:
diff -Naur ../linux-2.6.10/arch/sparc/mm/srmmu.c linux-2.6.10/arch/sparc/mm/srmmu.c
--- ../linux-2.6.10/arch/sparc/mm/srmmu.c	2004-12-24 22:34:58.000000000 +0100
+++ linux-2.6.10/arch/sparc/mm/srmmu.c	2005-01-03 16:26:56.000000000 +0100
@@ -6,6 +6,7 @@
  * Copyright (C) 1996 Eddie C. Dost    (ecd@skynet.be)
  * Copyright (C) 1997,1998 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  * Copyright (C) 1999,2000 Anton Blanchard (anton@samba.org)
+ * Copyright (C) 2004 Konrad Eisele (eiselekd@web.de), Gaisler Research
  */
 
 #include <linux/config.h>
@@ -48,6 +49,7 @@
 #include <asm/tsunami.h>
 #include <asm/swift.h>
 #include <asm/turbosparc.h>
+#include <asm/leon.h>
 
 #include <asm/btfixup.h>
 
@@ -568,6 +570,13 @@
 	if (is_hypersparc)
 		hyper_flush_whole_icache();
 
+#if (defined CONFIG_LEON || defined CONFIG_LEON_3)
+
+	flush_tlb_mm(0);
+	leon_flush_cache_all();
+	
+#endif
+
 	srmmu_set_context(mm->context);
 }
 
@@ -1287,7 +1296,11 @@
 
 	srmmu_nocache_calcsize();
 	srmmu_nocache_init();
-        srmmu_inherit_prom_mappings(0xfe400000,(LINUX_OPPROM_ENDVM-PAGE_SIZE));
+	if (sparc_cpu_model == sparc_leon) {
+        	leon_inherit_prom_mappings(0xfe400000,(LINUX_OPPROM_ENDVM-PAGE_SIZE));
+	} else {
+        	srmmu_inherit_prom_mappings(0xfe400000,(LINUX_OPPROM_ENDVM-PAGE_SIZE));
+	}
 	map_kernel();
 
 	/* ctx table has to be physically aligned to its size */
@@ -1981,6 +1994,133 @@
 	poke_srmmu = poke_viking;
 }
 
+void __init leon_inherit_prom_mappings(unsigned long start,unsigned long end)
+{
+	pgd_t *pgdp;
+	pmd_t *pmdp;
+	pte_t *ptep;
+	int what = 0; /* 0 = normal-pte, 1 = pmd-level pte, 2 = pgd-level pte */
+	unsigned long prompte;
+
+	while(start <= end) {
+		if (start == 0)
+			break; /* probably wrap around */
+		if(start == 0xfef00000)
+			start = KADB_DEBUGGER_BEGVM;
+		if(!(prompte = srmmu_swprobe(start,0))) {
+			start += PAGE_SIZE;
+			continue;
+		}
+    
+		/* A red snapper, see what it really is. */
+		what = 0;
+    
+		if(!(start & ~(SRMMU_REAL_PMD_MASK))) {
+			if(srmmu_swprobe((start-PAGE_SIZE) + SRMMU_REAL_PMD_SIZE, 0) == prompte)
+				what = 1;
+		}
+    
+		if(!(start & ~(SRMMU_PGDIR_MASK))) {
+			if(srmmu_swprobe((start-PAGE_SIZE) + SRMMU_PGDIR_SIZE, 0) ==
+			   prompte)
+				what = 2;
+		}
+    
+		pgdp = pgd_offset_k(start);
+		if(what == 2) {
+			*(pgd_t *)__nocache_fix(pgdp) = __pgd(prompte);
+			start += SRMMU_PGDIR_SIZE;
+			continue;
+		}
+		if(srmmu_pgd_none(*(pgd_t *)__nocache_fix(pgdp))) {
+			pmdp = (pmd_t *)__srmmu_get_nocache(SRMMU_PMD_TABLE_SIZE, SRMMU_PMD_TABLE_SIZE);
+			if (pmdp == NULL)
+				early_pgtable_allocfail("pmd");
+			memset(__nocache_fix(pmdp), 0, SRMMU_PMD_TABLE_SIZE);
+			srmmu_pgd_set(__nocache_fix(pgdp), pmdp);
+		}
+		pmdp = srmmu_pmd_offset(__nocache_fix(pgdp), start);
+		if(srmmu_pmd_none(*(pmd_t *)__nocache_fix(pmdp))) {
+			ptep = (pte_t *) __srmmu_get_nocache(PTE_SIZE,
+			    PTE_SIZE);
+			if (ptep == NULL)
+				early_pgtable_allocfail("pte");
+			memset(__nocache_fix(ptep), 0, PTE_SIZE);
+			srmmu_pmd_set(__nocache_fix(pmdp), ptep);
+		}
+		if(what == 1) {
+			/*
+			 * We bend the rule where all 16 PTPs in a pmd_t point
+			 * inside the same PTE page, and we leak a perfectly
+			 * good hardware PTE piece. Alternatives seem worse.
+			 */
+			unsigned int x;	/* Index of HW PMD in soft cluster */
+			x = (start >> PMD_SHIFT) & 15;
+			*(unsigned long *)__nocache_fix(&pmdp->pmdv[x]) = prompte;
+			start += SRMMU_REAL_PMD_SIZE;
+			continue;
+		}
+		ptep = srmmu_pte_offset(__nocache_fix(pmdp), start);
+		*(pte_t *)__nocache_fix(ptep) = __pte(prompte);
+		start += PAGE_SIZE;
+	}
+}
+ 
+void leon_flush_cache_all (void)
+{ 
+#if defined( CONFIG_LEON) || defined(CONFIG_LEON_3)
+#ifdef CONFIG_LEON_3
+        __asm__ __volatile__(" flush "); //iflush 
+	__asm__ __volatile__("sta %%g0, [%%g0] %0\n\t": :
+			     "i" (ASI_LEON_DFLUSH) : "memory");
+#else 
+	__asm__ __volatile__("sta %%g0, [%%g0] %0\n\t": :
+			     "i" (ASI_LEON_IFLUSH) : "memory");
+	__asm__ __volatile__("sta %%g0, [%%g0] %0\n\t": :
+			     "i" (ASI_LEON_DFLUSH) : "memory");
+#endif
+#endif
+}
+
+void leon_flush_tlb_all (void)
+{
+#if defined( CONFIG_LEON) || defined(CONFIG_LEON_3)
+	leon_flush_cache_all();
+	__asm__ __volatile__("sta %%g0, [%0] %1\n\t": :
+			     "r" (0x400),
+			     "i" (ASI_LEON_MMUFLUSH) : "memory");
+#endif
+}
+
+static void __init poke_leonsparc(void)
+{
+}
+
+static void __init init_leon(void) {
+
+	srmmu_name = "Leon2";
+
+	BTFIXUPSET_CALL(flush_cache_all, leon_flush_cache_all, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_cache_mm, leon_flush_cache_all, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_cache_page, leon_flush_cache_all, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_cache_range, leon_flush_cache_all, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_page_for_dma, leon_flush_cache_all, BTFIXUPCALL_NORM);
+  
+	BTFIXUPSET_CALL(flush_tlb_all, leon_flush_tlb_all, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_tlb_mm, leon_flush_tlb_all, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_tlb_page, leon_flush_tlb_all, BTFIXUPCALL_NORM);
+	BTFIXUPSET_CALL(flush_tlb_range, leon_flush_tlb_all, BTFIXUPCALL_NORM);
+  
+	BTFIXUPSET_CALL(__flush_page_to_ram, leon_flush_cache_all, BTFIXUPCALL_NOP);
+	BTFIXUPSET_CALL(flush_sig_insns, leon_flush_cache_all, BTFIXUPCALL_NOP);
+	
+	poke_srmmu = poke_leonsparc;
+	
+	srmmu_cache_pagetables = 0;
+}
+
+
+
 /* Probe for the srmmu chip version. */
 static void __init get_srmmu_type(void)
 {
@@ -1990,11 +2130,20 @@
 	srmmu_modtype = SRMMU_INVAL_MOD;
 	hwbug_bitmask = 0;
 
-	mreg = srmmu_get_mmureg(); psr = get_psr();
+	mreg = srmmu_get_mmureg();
+	psr = get_psr();
 	mod_typ = (mreg & 0xf0000000) >> 28;
 	mod_rev = (mreg & 0x0f000000) >> 24;
 	psr_typ = (psr >> 28) & 0xf;
 	psr_vers = (psr >> 24) & 0xf;
+#ifdef CONFIG_LEON
+	psr_typ = 0xf;	/* hardcoded ids for older models/simulators */
+	psr_vers = 2;
+#endif
+	if(psr_typ == 0xf) {
+		init_leon();
+		return;
+	}
 
 	/* First, check for HyperSparc or Cypress. */
 	if(mod_typ == 1) {

--------------050104090608080304020203--
