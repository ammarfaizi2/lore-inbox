Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271642AbTGRJjC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 05:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271631AbTGRJi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 05:38:58 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:24559 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S271476AbTGRJaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:30:55 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 6/7][v850]  Add v850 `sim85e2s' port, and cleanup v850e2 code
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030718094539.7D4403702@mcspd15.ucom.lsi.nec.co.jp>
Date: Fri, 18 Jul 2003 18:45:39 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.

This patch adds support for the `sim85e2s' simulation of the NA85E2S
processor implementation.  As part of this, cache-flushing support for
the common v850e2 cache implementation is added.

It also cleans up a bunch of code that was duplicated between different
v850e2 processors.

diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/anna.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/anna.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/anna.c	2002-11-28 10:24:54.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/anna.c	2003-07-16 17:23:42.000000000 +0900
@@ -41,24 +41,30 @@
 
 void __init mach_early_init (void)
 {
-	ANNA_ILBEN  = 0;
-	ANNA_CSC(0) = 0x402F;
-	ANNA_CSC(1) = 0x4000;
-	ANNA_BPC    = 0;
-	ANNA_BSC    = 0xAAAA;
-	ANNA_BEC    = 0;
-	ANNA_BHC    = 0xFFFF;	/* icache all memory, dcache all */
-	ANNA_BCT(0) = 0xB088;
-	ANNA_BCT(1) = 0x0008;
-	ANNA_DWC(0) = 0x0027;
-	ANNA_DWC(1) = 0;
-	ANNA_BCC    = 0x0006;
-	ANNA_ASC    = 0;
-	ANNA_LBS    = 0x0089;
-	ANNA_SCR3   = 0x21A9;
-	ANNA_RFS3   = 0x8121;
+	ANNA_ILBEN    = 0;
 
-	nb85e_intc_disable_irqs ();
+	V850E2_CSC(0) = 0x402F;
+	V850E2_CSC(1) = 0x4000;
+	V850E2_BPC    = 0;
+	V850E2_BSC    = 0xAAAA;
+	V850E2_BEC    = 0;
+
+#if 0
+	V850E2_BHC    = 0xFFFF;	/* icache all memory, dcache all */
+#else
+	V850E2_BHC    = 0;	/* cache no memory */
+#endif
+	V850E2_BCT(0) = 0xB088;
+	V850E2_BCT(1) = 0x0008;
+	V850E2_DWC(0) = 0x0027;
+	V850E2_DWC(1) = 0;
+	V850E2_BCC    = 0x0006;
+	V850E2_ASC    = 0;
+	V850E2_LBS    = 0x0089;
+	V850E2_SCR(3) = 0x21A9;
+	V850E2_RFS(3) = 0x8121;
+
+	v850e_intc_disable_irqs ();
 }
 
 void __init mach_setup (char **cmdline)
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/fpga85e2c.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/fpga85e2c.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/fpga85e2c.c	2002-11-28 10:24:54.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/fpga85e2c.c	2003-07-17 20:25:27.000000000 +0900
@@ -46,7 +46,7 @@
 
 	/* Set bus sizes: CS0 32-bit, CS1 16-bit, CS7 8-bit,
 	   everything else 32-bit.  */
-	BSC = 0x2AA6;
+	V850E2_BSC = 0x2AA6;
 	for (i = 2; i <= 6; i++)
 		CSDEV(i) = 0;	/* 32 bit */
 
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/sim85e2.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/sim85e2.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/sim85e2.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/sim85e2.c	2003-07-15 19:10:21.000000000 +0900
@@ -0,0 +1,211 @@
+/*
+ * arch/v850/kernel/sim85e2.c -- Machine-specific stuff for
+ *	V850E2 RTL simulator
+ *
+ *  Copyright (C) 2002,03  NEC Electronics Corporation
+ *  Copyright (C) 2002,03  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/bootmem.h>
+#include <linux/irq.h>
+
+#include <asm/atomic.h>
+#include <asm/page.h>
+#include <asm/machdep.h>
+
+#include "mach.h"
+
+
+/* There are 4 possible areas we can use:
+
+     IRAM (1MB) is fast for instruction fetches, but slow for data
+     DRAM (1020KB) is fast for data, but slow for instructions
+     ERAM is cached, so should be fast for both insns and data
+     SDRAM is external DRAM, similar to ERAM
+*/
+
+#define INIT_MEMC_FOR_SDRAM
+#define USE_SDRAM_AREA
+#define KERNEL_IN_SDRAM_AREA
+
+#define DCACHE_MODE	V850E2_CACHE_BTSC_DCM_WT
+/*#define DCACHE_MODE	V850E2_CACHE_BTSC_DCM_WB_ALLOC*/
+
+#ifdef USE_SDRAM_AREA
+#define RAM_START 	SDRAM_ADDR
+#define RAM_END		(SDRAM_ADDR + SDRAM_SIZE)
+#else
+/* When we use DRAM, we need to account for the fact that the end of it is
+   used for R0_RAM.  */
+#define RAM_START	DRAM_ADDR
+#define RAM_END		R0_RAM_ADDR
+#endif
+
+
+extern void memcons_setup (void);
+
+
+#ifdef KERNEL_IN_SDRAM_AREA
+#define EARLY_INIT_SECTION_ATTR __attribute__ ((section (".early.text")))
+#else
+#define EARLY_INIT_SECTION_ATTR __init
+#endif
+
+void EARLY_INIT_SECTION_ATTR mach_early_init (void)
+{
+	extern int panic_timeout;
+
+	/* The sim85e2 simulator tracks `undefined' values, so to make
+	   debugging easier, we begin by zeroing out all otherwise
+	   undefined registers.  This is not strictly necessary.
+
+	   The registers we zero are:
+	       Every GPR except:
+	           stack-pointer (r3)
+		   task-pointer (r16)
+		   our return addr (r31)
+	       Every system register (SPR) that we know about except for
+	       the PSW (SPR 5), which we zero except for the
+	       disable-interrupts bit.
+	*/
+
+	/* GPRs */
+	asm volatile ("             mov r0, r1 ; mov r0, r2              ");
+	asm volatile ("mov r0, r4 ; mov r0, r5 ; mov r0, r6 ; mov r0, r7 ");
+	asm volatile ("mov r0, r8 ; mov r0, r9 ; mov r0, r10; mov r0, r11");
+	asm volatile ("mov r0, r12; mov r0, r13; mov r0, r14; mov r0, r15");
+	asm volatile ("             mov r0, r17; mov r0, r18; mov r0, r19");
+	asm volatile ("mov r0, r20; mov r0, r21; mov r0, r22; mov r0, r23");
+	asm volatile ("mov r0, r24; mov r0, r25; mov r0, r26; mov r0, r27");
+	asm volatile ("mov r0, r28; mov r0, r29; mov r0, r30");
+
+	/* SPRs */
+	asm volatile ("ldsr r0, 0;  ldsr r0, 1;  ldsr r0, 2;  ldsr r0, 3");
+	asm volatile ("ldsr r0, 4");
+	asm volatile ("addi 0x20, r0, r1; ldsr r1, 5"); /* PSW */
+	asm volatile ("ldsr r0, 16; ldsr r0, 17; ldsr r0, 18; ldsr r0, 19");
+	asm volatile ("ldsr r0, 20");
+
+
+#ifdef INIT_MEMC_FOR_SDRAM
+	/* Settings for SDRAM controller.  */
+	V850E2_VSWC   = 0x0042;
+	V850E2_BSC    = 0x9286;
+	V850E2_BCT(0) = 0xb000;	/* was: 0 */
+	V850E2_BCT(1) = 0x000b;
+	V850E2_ASC    = 0;
+	V850E2_LBS    = 0xa9aa;	/* was: 0xaaaa */
+	V850E2_LBC(0) = 0;
+	V850E2_LBC(1) = 0;	/* was: 0x3 */
+	V850E2_BCC    = 0;
+	V850E2_RFS(4) = 0x800a;	/* was: 0xf109 */
+	V850E2_SCR(4) = 0x2091;	/* was: 0x20a1 */
+	V850E2_RFS(3) = 0x800c;
+	V850E2_SCR(3) = 0x20a1;
+	V850E2_DWC(0) = 0;
+	V850E2_DWC(1) = 0;
+#endif
+
+#if 0
+#ifdef CONFIG_V850E2_SIM85E2S
+	/* Turn on the caches.  */
+	V850E2_CACHE_BTSC = V850E2_CACHE_BTSC_ICM | DCACHE_MODE;
+	V850E2_BHC  = 0x1010;
+#elif CONFIG_V850E2_SIM85E2C
+	V850E2_CACHE_BTSC |= (V850E2_CACHE_BTSC_ICM | V850E2_CACHE_BTSC_DCM0);
+	V850E2_BUSM_BHC = 0xFFFF;
+#endif
+#else
+	V850E2_BHC  = 0;
+#endif
+
+	/* Don't stop the simulator at `halt' instructions.  */
+	SIM85E2_NOTHAL = 1;
+
+	/* Ensure that the simulator halts on a panic, instead of going
+	   into an infinite loop inside the panic function.  */
+	panic_timeout = -1;
+}
+
+void __init mach_setup (char **cmdline)
+{
+	memcons_setup ();
+}
+
+void mach_get_physical_ram (unsigned long *ram_start, unsigned long *ram_len)
+{
+	*ram_start = RAM_START;
+	*ram_len = RAM_END - RAM_START;
+}
+
+void __init mach_reserve_bootmem ()
+{
+	extern char _root_fs_image_start, _root_fs_image_end;
+	u32 root_fs_image_start = (u32)&_root_fs_image_start;
+	u32 root_fs_image_end = (u32)&_root_fs_image_end;
+
+	/* Reserve the memory used by the root filesystem image if it's
+	   in RAM.  */
+	if (root_fs_image_end > root_fs_image_start
+	    && root_fs_image_start >= RAM_START
+	    && root_fs_image_start < RAM_END)
+		reserve_bootmem (root_fs_image_start,
+				 root_fs_image_end - root_fs_image_start);
+}
+
+void __init mach_sched_init (struct irqaction *timer_action)
+{
+	/* The simulator actually cycles through all interrupts
+	   periodically.  We just pay attention to IRQ0, which gives us
+	   1/64 the rate of the periodic interrupts.  */
+	setup_irq (0, timer_action);
+}
+
+void mach_gettimeofday (struct timespec *tv)
+{
+	tv->tv_sec = 0;
+	tv->tv_nsec = 0;
+}
+
+/* Interrupts */
+
+struct v850e_intc_irq_init irq_inits[] = {
+	{ "IRQ", 0, NUM_MACH_IRQS, 1, 7 },
+	{ 0 }
+};
+struct hw_interrupt_type hw_itypes[1];
+
+/* Initialize interrupts.  */
+void __init mach_init_irqs (void)
+{
+	v850e_intc_init_irq_types (irq_inits, hw_itypes);
+}
+
+
+void machine_halt (void) __attribute__ ((noreturn));
+void machine_halt (void)
+{
+	SIM85E2_SIMFIN = 0;	/* Halt immediately.  */
+	for (;;) {}
+}
+
+void machine_restart (char *__unused)
+{
+	machine_halt ();
+}
+
+void machine_power_off (void)
+{
+	machine_halt ();
+}
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/sim85e2c.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/sim85e2c.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/sim85e2c.c	2002-11-28 10:24:54.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/sim85e2c.c	1970-01-01 09:00:00.000000000 +0900
@@ -1,145 +0,0 @@
-/*
- * arch/v850/kernel/sim85e2c.c -- Machine-specific stuff for
- *	V850E2 RTL simulator
- *
- *  Copyright (C) 2002  NEC Corporation
- *  Copyright (C) 2002  Miles Bader <miles@gnu.org>
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file COPYING in the main directory of this
- * archive for more details.
- *
- * Written by Miles Bader <miles@gnu.org>
- */
-
-#include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/swap.h>
-#include <linux/bootmem.h>
-#include <linux/irq.h>
-
-#include <asm/atomic.h>
-#include <asm/page.h>
-#include <asm/machdep.h>
-
-#include "mach.h"
-
-extern void memcons_setup (void);
-
-
-void __init mach_early_init (void)
-{
-	extern int panic_timeout;
-
-	/* Don't stop the simulator at `halt' instructions.  */
-	NOTHAL = 1;
-
-	/* The sim85e2c simulator tracks `undefined' values, so to make
-	   debugging easier, we begin by zeroing out all otherwise
-	   undefined registers.  This is not strictly necessary.
-
-	   The registers we zero are:
-	       Every GPR except:
-	           stack-pointer (r3)
-		   task-pointer (r16)
-		   our return addr (r31)
-	       Every system register (SPR) that we know about except for
-	       the PSW (SPR 5), which we zero except for the
-	       disable-interrupts bit.
-	*/
-
-	/* GPRs */
-	asm volatile ("             mov r0, r1 ; mov r0, r2              ");
-	asm volatile ("mov r0, r4 ; mov r0, r5 ; mov r0, r6 ; mov r0, r7 ");
-	asm volatile ("mov r0, r8 ; mov r0, r9 ; mov r0, r10; mov r0, r11");
-	asm volatile ("mov r0, r12; mov r0, r13; mov r0, r14; mov r0, r15");
-	asm volatile ("             mov r0, r17; mov r0, r18; mov r0, r19");
-	asm volatile ("mov r0, r20; mov r0, r21; mov r0, r22; mov r0, r23");
-	asm volatile ("mov r0, r24; mov r0, r25; mov r0, r26; mov r0, r27");
-	asm volatile ("mov r0, r28; mov r0, r29; mov r0, r30");
-
-	/* SPRs */
-	asm volatile ("ldsr r0, 0;  ldsr r0, 1;  ldsr r0, 2;  ldsr r0, 3");
-	asm volatile ("ldsr r0, 4");
-	asm volatile ("addi 0x20, r0, r1; ldsr r1, 5"); /* PSW */
-	asm volatile ("ldsr r0, 16; ldsr r0, 17; ldsr r0, 18; ldsr r0, 19");
-	asm volatile ("ldsr r0, 20");
-
-	/* Turn on the caches.  */
-	NA85E2C_CACHE_BTSC
-		|= (NA85E2C_CACHE_BTSC_ICM | NA85E2C_CACHE_BTSC_DCM0);
-	NA85E2C_BUSM_BHC = 0xFFFF;
-
-	/* Ensure that the simulator halts on a panic, instead of going
-	   into an infinite loop inside the panic function.  */
-	panic_timeout = -1;
-}
-
-void __init mach_setup (char **cmdline)
-{
-	memcons_setup ();
-}
-
-void mach_get_physical_ram (unsigned long *ram_start, unsigned long *ram_len)
-{
-	/* There are 3 possible areas we can use:
-	     IRAM (1MB) is fast for instruction fetches, but slow for data
-	     DRAM (1020KB) is fast for data, but slow for instructions
-	     ERAM is cached, so should be fast for both insns and data,
-	          _but_ currently only supports write-through caching, so
-		  writes are slow.
-	   Since there's really no area that's good for general kernel
-	   use, we use DRAM -- it won't be good for user programs
-	   (which will be loaded into kernel allocated memory), but
-	   currently we're more concerned with testing the kernel.  */
-	*ram_start = DRAM_ADDR;
-	*ram_len = R0_RAM_ADDR - DRAM_ADDR;
-}
-
-void __init mach_sched_init (struct irqaction *timer_action)
-{
-	/* The simulator actually cycles through all interrupts
-	   periodically.  We just pay attention to IRQ0, which gives us
-	   1/64 the rate of the periodic interrupts.  */
-	setup_irq (0, timer_action);
-}
-
-void mach_gettimeofday (struct timespec *tv)
-{
-	tv->tv_sec = 0;
-	tv->tv_nsec = 0;
-}
-
-/* Interrupts */
-
-struct nb85e_intc_irq_init irq_inits[] = {
-	{ "IRQ", 0, NUM_MACH_IRQS, 1, 7 },
-	{ 0 }
-};
-struct hw_interrupt_type hw_itypes[1];
-
-/* Initialize interrupts.  */
-void __init mach_init_irqs (void)
-{
-	nb85e_intc_init_irq_types (irq_inits, hw_itypes);
-}
-
-
-void machine_halt (void) __attribute__ ((noreturn));
-void machine_halt (void)
-{
-	SIMFIN = 0;		/* Halt immediately.  */
-	for (;;) {}
-}
-
-void machine_restart (char *__unused)
-{
-	machine_halt ();
-}
-
-void machine_power_off (void)
-{
-	machine_halt ();
-}
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/kernel/v850e2_cache.c linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/v850e2_cache.c
--- linux-2.6.0-test1-moo/arch/v850/kernel/v850e2_cache.c	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/kernel/v850e2_cache.c	2003-07-17 20:25:27.000000000 +0900
@@ -0,0 +1,127 @@
+/*
+ * arch/v850/kernel/v850e2_cache.c -- Cache control for V850E2 cache
+ * 	memories
+ *
+ *  Copyright (C) 2003  NEC Electronics Corporation
+ *  Copyright (C) 2003  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+#include <linux/mm.h>
+
+#include <asm/v850e2_cache.h>
+
+/* Cache operations we can do.  The encoding corresponds directly to the
+   value we need to write into the COPR register.  */
+enum cache_op {
+	OP_SYNC_IF_DIRTY 	   = V850E2_CACHE_COPR_CFC(0), /* 000 */
+	OP_SYNC_IF_VALID 	   = V850E2_CACHE_COPR_CFC(1), /* 001 */
+	OP_SYNC_IF_VALID_AND_CLEAR = V850E2_CACHE_COPR_CFC(3), /* 011 */
+	OP_WAY_CLEAR 		   = V850E2_CACHE_COPR_CFC(4), /* 100 */
+	OP_FILL 		   = V850E2_CACHE_COPR_CFC(5), /* 101 */
+	OP_CLEAR 		   = V850E2_CACHE_COPR_CFC(6), /* 110 */
+	OP_CREATE_DIRTY 	   = V850E2_CACHE_COPR_CFC(7)  /* 111 */
+};
+
+/* Which cache to use.  This encoding also corresponds directly to the
+   value we need to write into the COPR register. */
+enum cache {
+	ICACHE = 0,
+	DCACHE = V850E2_CACHE_COPR_LBSL
+};
+
+/* Returns ADDR rounded down to the beginning of its cache-line.  */
+#define CACHE_LINE_ADDR(addr)  \
+   ((addr) & ~(V850E2_CACHE_LINE_SIZE - 1))
+/* Returns END_ADDR rounded up to the `limit' of its cache-line.  */
+#define CACHE_LINE_END_ADDR(end_addr)  \
+   CACHE_LINE_ADDR(end_addr + (V850E2_CACHE_LINE_SIZE - 1))
+
+
+/* Low-level cache ops.  */
+
+/* Apply cache-op OP to all entries in CACHE.  */
+static inline void cache_op_all (enum cache_op op, enum cache cache)
+{
+	int cmd = op | cache | V850E2_CACHE_COPR_WSLE | V850E2_CACHE_COPR_STRT;
+
+	if (op != OP_WAY_CLEAR) {
+		/* The WAY_CLEAR operation does the whole way, but other
+		   ops take begin-index and count params; we just indicate
+		   the entire cache.  */
+		V850E2_CACHE_CADL = 0;
+		V850E2_CACHE_CADH = 0;
+		V850E2_CACHE_CCNT = V850E2_CACHE_WAY_SIZE - 1;
+	}
+
+	V850E2_CACHE_COPR = cmd | V850E2_CACHE_COPR_WSL(0); /* way 0 */
+	V850E2_CACHE_COPR = cmd | V850E2_CACHE_COPR_WSL(1); /* way 1 */
+	V850E2_CACHE_COPR = cmd | V850E2_CACHE_COPR_WSL(2); /* way 2 */
+	V850E2_CACHE_COPR = cmd | V850E2_CACHE_COPR_WSL(3); /* way 3 */
+}
+
+/* Apply cache-op OP to all entries in CACHE covering addresses ADDR
+   through ADDR+LEN.  */
+static inline void cache_op_range (enum cache_op op, u32 addr, u32 len,
+				   enum cache cache)
+{
+	u32 start = CACHE_LINE_ADDR (addr);
+	u32 end = CACHE_LINE_END_ADDR (addr + len);
+	u32 num_lines = (end - start) >> V850E2_CACHE_LINE_SIZE_BITS;
+
+	V850E2_CACHE_CADL = start & 0xFFFF;
+	V850E2_CACHE_CADH = start >> 16;
+	V850E2_CACHE_CCNT = num_lines - 1;
+
+	V850E2_CACHE_COPR = op | cache | V850E2_CACHE_COPR_STRT;
+}
+
+
+/* High-level ops.  */
+
+static void cache_exec_after_store_all (void)
+{
+	cache_op_all (OP_SYNC_IF_DIRTY, DCACHE);
+	cache_op_all (OP_WAY_CLEAR, ICACHE);
+}
+
+static void cache_exec_after_store_range (u32 start, u32 len)
+{
+	cache_op_range (OP_SYNC_IF_DIRTY, start, len, DCACHE);
+	cache_op_range (OP_CLEAR, start, len, ICACHE);
+}
+
+
+/* Exported functions.  */
+
+void flush_icache (void)
+{
+	cache_exec_after_store_all ();
+}
+
+void flush_icache_range (unsigned long start, unsigned long end)
+{
+	cache_exec_after_store_range (start, end - start);
+}
+
+void flush_icache_page (struct vm_area_struct *vma, struct page *page)
+{
+	cache_exec_after_store_range (page_to_virt (page), PAGE_SIZE);
+}
+
+void flush_icache_user_range (struct vm_area_struct *vma, struct page *page,
+			      unsigned long addr, int len)
+{
+	cache_exec_after_store_range (addr, len);
+}
+
+void flush_cache_sigtramp (unsigned long addr)
+{
+	/* For the exact size, see signal.c, but 16 bytes should be enough.  */
+	cache_exec_after_store_range (addr, 16);
+}
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/sim85e2.ld linux-2.6.0-test1-moo-v850-20030718/arch/v850/sim85e2.ld
--- linux-2.6.0-test1-moo/arch/v850/sim85e2.ld	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/sim85e2.ld	2003-07-15 19:06:35.000000000 +0900
@@ -0,0 +1,44 @@
+/* Linker script for the sim85e2c simulator, which is a verilog simulation of
+   the V850E2 NA85E2C cpu core (CONFIG_V850E2_SIM85E2C).  */
+
+MEMORY {
+	/* 1MB of `instruction RAM', starting at 0.
+	   Instruction fetches are much faster from IRAM than from DRAM.
+	   This should match IRAM_ADDR in "include/asm-v580/sim85e2c.h".    */
+	IRAM		: ORIGIN = 0x00000000, LENGTH = 0x00100000
+
+	/* 1MB of `data RAM', below and contiguous with the I/O space.
+	   Data fetches are much faster from DRAM than from IRAM.
+	   This should match DRAM_ADDR in "include/asm-v580/sim85e2c.h".  */
+	DRAM		: ORIGIN = 0xfff00000, LENGTH = 0x000ff000
+	/* We have to load DRAM at a mirror-address of 0x1ff00000,
+	   because the simulator's preprocessing script isn't smart
+	   enough to deal with the above LMA.  */
+	DRAM_LOAD 	: ORIGIN = 0x1ff00000, LENGTH = 0x000ff000
+
+	/* `external ram' (CS1 area), comes after IRAM.
+	   This should match ERAM_ADDR in "include/asm-v580/sim85e2c.h".  */
+	ERAM		: ORIGIN = 0x00100000, LENGTH = 0x07f00000
+
+	/* Dynamic RAM; uses memory controller.  */
+	/* SDRAM	: ORIGIN = 0x10000000, LENGTH = 0x01000000 */
+	SDRAM		: ORIGIN = 0x10000000, LENGTH = 0x00200000/*use 2MB*/
+}
+
+SECTIONS {
+	.iram : {
+		INTV_CONTENTS
+		*arch/v850/kernel/head.o
+		*(.early.text)
+	} > IRAM
+	.dram : {
+		_memcons_output = . ;
+		. = . + 0x8000 ;
+		_memcons_output_end = . ;
+	} > DRAM
+	.sdram : {
+		/* We stick console output into a buffer here.  */
+		RAMK_KRAM_CONTENTS
+		ROOT_FS_CONTENTS
+	} > SDRAM
+}
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/sim85e2c.ld linux-2.6.0-test1-moo-v850-20030718/arch/v850/sim85e2c.ld
--- linux-2.6.0-test1-moo/arch/v850/sim85e2c.ld	2002-12-24 15:01:07.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/sim85e2c.ld	1970-01-01 09:00:00.000000000 +0900
@@ -1,44 +0,0 @@
-/* Linker script for the sim85e2c simulator, which is a verilog simulation of
-   the V850E2 NA85E2C cpu core (CONFIG_V850E2_SIM85E2C).  */
-
-MEMORY {
-	/* 1MB of `instruction RAM', starting at 0.
-	   Instruction fetches are much faster from IRAM than from DRAM.
-	   This should match IRAM_ADDR in "include/asm-v580/sim85e2c.h".    */
-	IRAM	: ORIGIN = 0x00000000, LENGTH = 0x00100000
-
-	/* 1MB of `data RAM', below and contiguous with the I/O space.
-	   Data fetches are much faster from DRAM than from IRAM.
-	   This should match DRAM_ADDR in "include/asm-v580/sim85e2c.h".  */
-	DRAM	: ORIGIN = 0xfff00000, LENGTH = 0x000ff000
-	/* We have to load DRAM at a mirror-address of 0x1ff00000,
-	   because the simulator's preprocessing script isn't smart
-	   enough to deal with the above LMA.  */
-	DRAM_LOAD : ORIGIN = 0x1ff00000, LENGTH = 0x000ff000
-
-	/* `external ram' (CS1 area), comes after IRAM.
-	   This should match ERAM_ADDR in "include/asm-v580/sim85e2c.h".  */
-	ERAM	: ORIGIN = 0x00100000, LENGTH = 0x07f00000
-}
-
-SECTIONS {
-	.iram : {
-		INTV_CONTENTS
-		TEXT_CONTENTS
-		RAMK_INIT_CONTENTS
-	} > IRAM
-	.data : {
-		__kram_start = . ;
-		DATA_CONTENTS
-		BSS_CONTENTS
-		ROOT_FS_CONTENTS
-
-		/* We stick console output into a buffer here.  */
-		_memcons_output = . ;
-		. = . + 0x8000 ;
-		_memcons_output_end = . ;
-
-		__kram_end = . ;
-		BOOTMAP_CONTENTS
-	} > DRAM  AT> DRAM_LOAD
-}
diff -ruN -X../cludes linux-2.6.0-test1-moo/arch/v850/vmlinux.lds.S linux-2.6.0-test1-moo-v850-20030718/arch/v850/vmlinux.lds.S
--- linux-2.6.0-test1-moo/arch/v850/vmlinux.lds.S	2003-06-23 14:50:13.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/arch/v850/vmlinux.lds.S	2003-07-15 19:06:36.000000000 +0900
@@ -206,8 +208,8 @@
 # include "sim.ld"
 #endif
 
-#ifdef CONFIG_V850E2_SIM85E2C
-# include "sim85e2c.ld"
+#ifdef CONFIG_V850E2_SIM85E2
+# include "sim85e2.ld"
 #endif
 
 #ifdef CONFIG_V850E2_FPGA85E2C
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/anna.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/anna.h
--- linux-2.6.0-test1-moo/include/asm-v850/anna.h	2002-11-28 10:25:08.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/anna.h	2003-07-17 20:25:27.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/anna.h -- Anna V850E2 evaluation cpu chip/board
  *
- *  Copyright (C) 2001,2002  NEC Corporation
- *  Copyright (C) 2001,2002  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -14,8 +14,9 @@
 #ifndef __V850_ANNA_H__
 #define __V850_ANNA_H__
 
+#include <asm/v850e2.h>		/* Based on V850E2 core.  */
+
 
-#define CPU_ARCH 	"v850e2"
 #define CPU_MODEL	"v850e2/anna"
 #define CPU_MODEL_LONG	"NEC V850E2/Anna"
 #define PLATFORM	"anna"
@@ -48,30 +49,6 @@
 
 
 /* Anna specific control registers.  */
-#define ANNA_CSC_ADDR(n)		(0xFFFFF060 + (n) * 2)
-#define ANNA_CSC(n)			(*(volatile u16 *)ANNA_CSC_ADDR(n))
-#define ANNA_BPC_ADDR			0xFFFFF064
-#define ANNA_BPC			(*(volatile u16 *)ANNA_BPC_ADDR)
-#define ANNA_BSC_ADDR			0xFFFFF066
-#define ANNA_BSC			(*(volatile u16 *)ANNA_BSC_ADDR)
-#define ANNA_BEC_ADDR			0xFFFFF068
-#define ANNA_BEC			(*(volatile u16 *)ANNA_BEC_ADDR)
-#define ANNA_BHC_ADDR			0xFFFFF06A
-#define ANNA_BHC			(*(volatile u16 *)ANNA_BHC_ADDR)
-#define ANNA_BCT_ADDR(n)		(0xFFFFF480 + (n) * 2)
-#define ANNA_BCT(n)			(*(volatile u16 *)ANNA_BCT_ADDR(n))
-#define ANNA_DWC_ADDR(n)		(0xFFFFF484 + (n) * 2)
-#define ANNA_DWC(n)			(*(volatile u16 *)ANNA_DWC_ADDR(n))
-#define ANNA_BCC_ADDR			0xFFFFF488
-#define ANNA_BCC			(*(volatile u16 *)ANNA_BCC_ADDR)
-#define ANNA_ASC_ADDR			0xFFFFF48A
-#define ANNA_ASC			(*(volatile u16 *)ANNA_ASC_ADDR)
-#define ANNA_LBS_ADDR			0xFFFFF48E
-#define ANNA_LBS			(*(volatile u16 *)ANNA_LBS_ADDR)
-#define ANNA_SCR3_ADDR			0xFFFFF4AC
-#define ANNA_SCR3			(*(volatile u16 *)ANNA_SCR3_ADDR)
-#define ANNA_RFS3_ADDR			0xFFFFF4AE
-#define ANNA_RFS3			(*(volatile u16 *)ANNA_RFS3_ADDR)
 #define ANNA_ILBEN_ADDR			0xFFFFF7F2
 #define ANNA_ILBEN			(*(volatile u16 *)ANNA_ILBEN_ADDR)
 
@@ -85,9 +62,6 @@
 #define ANNA_PORT_PM(n)			(*(volatile u8 *)ANNA_PORT_PM_ADDR(n))
 
 
-/* NB85E-style interrupt system.  */
-#include <asm/nb85e_intc.h>
-
 /* Hardware-specific interrupt numbers (in the kernel IRQ namespace).  */
 #define IRQ_INTP(n)	(n)	/* Pnnn (pin) interrupts 0-15 */
 #define IRQ_INTP_NUM	16
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/fpga85e2c.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/fpga85e2c.h
--- linux-2.6.0-test1-moo/include/asm-v850/fpga85e2c.h	2002-11-28 10:25:08.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/fpga85e2c.h	2003-07-17 20:25:27.000000000 +0900
@@ -15,11 +15,10 @@
 #ifndef __V850_FPGA85E2C_H__
 #define __V850_FPGA85E2C_H__
 
-
+#include <asm/v850e2.h>
 #include <asm/clinkage.h>
 
 
-#define CPU_ARCH 	"v850e2"
 #define CPU_MODEL	"v850e2/fpga85e2c"
 #define CPU_MODEL_LONG	"NEC V850E2/NA85E2C"
 #define PLATFORM	"fpga85e2c"
@@ -42,27 +41,6 @@
 #define CSDEV_ADDR(n)		(0xFFE80110 + 2*(n))
 #define CSDEV(n)		(*(volatile unsigned char *)CSDEV_ADDR (n))
 
-/* The BSC register controls bus-sizing.  Each memory area CSn uses a pair
-   of bits N*2 and N*2+1, where 00 means an 8-bit bus size, 01 16-bit, and
-   10 32-bit.  */
-#define BSC_ADDR		0xFFFFF066
-#define BSC			(*(volatile unsigned short *)BSC_ADDR)
-
-#define DWC_ADDR(n)		(0xFFFFF484 + 2*(n))
-#define DWC(n)			(*(volatile unsigned short *)DWC_ADDR (n))
-
-#define ASC_ADDR		0xFFFFF48A
-#define ASC			(*(volatile unsigned short *)ASC_ADDR)
-
-#define BTSC_ADDR		0xFFFFF070
-#define BTSC			(*(volatile unsigned short *)BTSC_ADDR)
-
-#define BHC_ADDR		0xFFFFF06A
-#define BHC			(*(volatile unsigned short *)BHC_ADDR)
-
-
-/* NB85E-style interrupt system.  */
-#include <asm/nb85e_intc.h>
 
 /* Timer interrupts 0-3, interrupt at intervals from CLK/4096 to CLK/16384.  */
 #define IRQ_RPU(n)		(60 + (n))
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/machdep.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/machdep.h
--- linux-2.6.0-test1-moo/include/asm-v850/machdep.h	2002-11-28 10:25:08.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/machdep.h	2003-07-15 19:06:37.000000000 +0900
@@ -45,6 +51,9 @@
 #ifdef CONFIG_V850E2_SIM85E2C
 #include <asm/sim85e2c.h>
 #endif
+#ifdef CONFIG_V850E2_SIM85E2S
+#include <asm/sim85e2s.h>
+#endif
 #ifdef CONFIG_V850E2_FPGA85E2C
 #include <asm/fpga85e2c.h>
 #endif
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/sim85e2.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/sim85e2.h
--- linux-2.6.0-test1-moo/include/asm-v850/sim85e2.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/sim85e2.h	2003-07-17 20:25:27.000000000 +0900
@@ -0,0 +1,79 @@
+/*
+ * include/asm-v850/sim85e2.h -- Machine-dependent defs for
+ *	V850E2 RTL simulator
+ *
+ *  Copyright (C) 2002,03  NEC Electronics Corporation
+ *  Copyright (C) 2002,03  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+#ifndef __V850_SIM85E2_H__
+#define __V850_SIM85E2_H__
+
+
+#include <asm/v850e2.h>		/* Based on V850E2 core.  */
+
+
+/* Various memory areas supported by the simulator.
+   These should match the corresponding definitions in the linker script.  */
+
+/* `instruction RAM'; instruction fetches are much faster from IRAM than
+   from DRAM.  */
+#define IRAM_ADDR		0
+#define IRAM_SIZE		0x00100000 /* 1MB */
+/* `data RAM', below and contiguous with the I/O space.
+   Data fetches are much faster from DRAM than from IRAM.  */
+#define DRAM_ADDR		0xfff00000
+#define DRAM_SIZE		0x000ff000 /* 1020KB */
+/* `external ram'.  Unlike the above RAM areas, this memory is cached,
+   so both instruction and data fetches should be (mostly) fast --
+   however, currently only write-through caching is supported, so writes
+   to ERAM will be slow.  */
+#define ERAM_ADDR		0x00100000
+#define ERAM_SIZE		0x07f00000 /* 127MB (max) */
+/* Dynamic RAM; uses memory controller.  */
+#define SDRAM_ADDR		0x10000000
+#if 0
+#define SDRAM_SIZE		0x01000000 /* 16MB */
+#else
+#define SDRAM_SIZE		0x00200000 /* Only use 2MB for testing */
+#endif
+
+
+/* Simulator specific control registers.  */
+/* NOTHAL controls whether the simulator will stop at a `halt' insn.  */
+#define SIM85E2_NOTHAL_ADDR	0xffffff22
+#define SIM85E2_NOTHAL		(*(volatile u8 *)SIM85E2_NOTHAL_ADDR)
+/* The simulator will stop N cycles after N is written to SIMFIN.  */
+#define SIM85E2_SIMFIN_ADDR	0xffffff24
+#define SIM85E2_SIMFIN		(*(volatile u16 *)SIM85E2_SIMFIN_ADDR)
+
+
+/* For <asm/irq.h> */
+#define NUM_CPU_IRQS		64
+
+
+/* For <asm/page.h> */
+#define PAGE_OFFSET		SDRAM_ADDR
+
+
+/* For <asm/entry.h> */
+/* `R0 RAM', used for a few miscellaneous variables that must be accessible
+   using a load instruction relative to R0.  The sim85e2 simulator
+   actually puts 1020K of RAM from FFF00000 to FFFFF000, so we arbitarily
+   choose a small portion at the end of that.  */
+#define R0_RAM_ADDR		0xFFFFE000
+
+
+/* For <asm/param.h> */
+#ifndef HZ
+#define HZ			24	/* Minimum supported frequency.  */
+#endif
+
+
+#endif /* __V850_SIM85E2_H__ */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/sim85e2c.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/sim85e2c.h
--- linux-2.6.0-test1-moo/include/asm-v850/sim85e2c.h	2002-11-28 10:25:08.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/sim85e2c.h	2003-07-15 19:20:23.000000000 +0900
@@ -15,78 +15,12 @@
 #ifndef __V850_SIM85E2C_H__
 #define __V850_SIM85E2C_H__
 
+/* Use generic sim85e2 settings, other than the various names.  */
+#include <asm/sim85e2.h>
 
-#define CPU_ARCH 	"v850e2"
 #define CPU_MODEL	"v850e2"
 #define CPU_MODEL_LONG	"NEC V850E2"
 #define PLATFORM	"sim85e2c"
 #define PLATFORM_LONG	"SIM85E2C V850E2 simulator"
 
-
-/* Various memory areas supported by the simulator.
-   These should match the corresponding definitions in the linker script.  */
-
-/* `instruction RAM'; instruction fetches are much faster from IRAM than
-   from DRAM.  */
-#define IRAM_ADDR		0
-#define IRAM_SIZE		0x00100000 /* 1MB */
-/* `data RAM', below and contiguous with the I/O space.
-   Data fetches are much faster from DRAM than from IRAM.  */
-#define DRAM_ADDR		0xfff00000
-#define DRAM_SIZE		0x000ff000 /* 1020KB */
-/* `external ram'.  Unlike the above RAM areas, this memory is cached,
-   so both instruction and data fetches should be (mostly) fast --
-   however, currently only write-through caching is supported, so writes
-   to ERAM will be slow.  */
-#define ERAM_ADDR		0x00100000
-#define ERAM_SIZE		0x07f00000 /* 127MB (max) */
-
-
-/* CPU core control registers; these should be expanded and moved into
-   separate header files when we support some other processors based on
-   the same E2 core.  */
-/* Bus Transaction Control Register */
-#define NA85E2C_CACHE_BTSC_ADDR	0xfffff070
-#define NA85E2C_CACHE_BTSC 	(*(volatile unsigned short *)NA85E2C_CACHE_BTSC_ADDR)
-#define NA85E2C_CACHE_BTSC_ICM	0x1 /* icache enable */
-#define NA85E2C_CACHE_BTSC_DCM0	0x4 /* dcache enable, bit 0 */
-#define NA85E2C_CACHE_BTSC_DCM1	0x8 /* dcache enable, bit 1 */
-/* Cache Configuration Register */
-#define NA85E2C_BUSM_BHC_ADDR	0xfffff06a
-#define NA85E2C_BUSM_BHC	(*(volatile unsigned short *)NA85E2C_BUSM_BHC_ADDR)
-
-/* Simulator specific control registers.  */
-/* NOTHAL controls whether the simulator will stop at a `halt' insn.  */
-#define NOTHAL_ADDR		0xffffff22
-#define NOTHAL			(*(volatile unsigned char *)NOTHAL_ADDR)
-/* The simulator will stop N cycles after N is written to SIMFIN.  */
-#define SIMFIN_ADDR		0xffffff24
-#define SIMFIN			(*(volatile unsigned short *)SIMFIN_ADDR)
-
-
-/* The simulator has an nb85e-style interrupt system.  */
-#include <asm/nb85e_intc.h>
-
-/* For <asm/irq.h> */
-#define NUM_CPU_IRQS		64
-
-
-/* For <asm/page.h> */
-#define PAGE_OFFSET		DRAM_ADDR
-
-
-/* For <asm/entry.h> */
-/* `R0 RAM', used for a few miscellaneous variables that must be accessible
-   using a load instruction relative to R0.  The sim85e2c simulator
-   actually puts 1020K of RAM from FFF00000 to FFFFF000, so we arbitarily
-   choose a small portion at the end of that.  */
-#define R0_RAM_ADDR		0xFFFFE000
-
-
-/* For <asm/param.h> */
-#ifndef HZ
-#define HZ			24	/* Minimum supported frequency.  */
-#endif
-
-
 #endif /* __V850_SIM85E2C_H__ */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/sim85e2s.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/sim85e2s.h
--- linux-2.6.0-test1-moo/include/asm-v850/sim85e2s.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/sim85e2s.h	2003-07-15 19:06:36.000000000 +0900
@@ -0,0 +1,28 @@
+/*
+ * include/asm-v850/sim85e2s.h -- Machine-dependent defs for
+ *	V850E2 RTL simulator
+ *
+ *  Copyright (C) 2003  NEC Electronics Corporation
+ *  Copyright (C) 2003  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+#ifndef __V850_SIM85E2S_H__
+#define __V850_SIM85E2S_H__
+
+#include <asm/sim85e2.h>	/* Use generic sim85e2 settings.  */
+#if 0
+#include <asm/v850e2_cache.h>	/* + cache */
+#endif
+
+#define CPU_MODEL	"v850e2"
+#define CPU_MODEL_LONG	"NEC V850E2"
+#define PLATFORM	"sim85e2s"
+#define PLATFORM_LONG	"SIM85E2S V850E2 simulator"
+
+#endif /* __V850_SIM85E2S_H__ */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/v850e2.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e2.h
--- linux-2.6.0-test1-moo/include/asm-v850/v850e2.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e2.h	2003-07-17 20:25:27.000000000 +0900
@@ -0,0 +1,69 @@
+/*
+ * include/asm-v850/v850e2.h -- Machine-dependent defs for V850E2 CPUs
+ *
+ *  Copyright (C) 2002,03  NEC Electronics Corporation
+ *  Copyright (C) 2002,03  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+#ifndef __V850_V850E2_H__
+#define __V850_V850E2_H__
+
+#include <asm/v850e_intc.h>	/* v850e-style interrupt system.  */
+
+
+#define CPU_ARCH "v850e2"
+
+
+/* Control registers.  */
+
+/* Chip area select control */ 
+#define V850E2_CSC_ADDR(n)	(0xFFFFF060 + (n) * 2)
+#define V850E2_CSC(n)		(*(volatile u16 *)V850E2_CSC_ADDR(n))
+/* I/O area select control */
+#define V850E2_BPC_ADDR		0xFFFFF064
+#define V850E2_BPC		(*(volatile u16 *)V850E2_BPC_ADDR)
+/* Bus size configuration */
+#define V850E2_BSC_ADDR		0xFFFFF066
+#define V850E2_BSC		(*(volatile u16 *)V850E2_BSC_ADDR)
+/* Endian configuration */
+#define V850E2_BEC_ADDR		0xFFFFF068
+#define V850E2_BEC		(*(volatile u16 *)V850E2_BEC_ADDR)
+/* Cache configuration */
+#define V850E2_BHC_ADDR		0xFFFFF06A
+#define V850E2_BHC		(*(volatile u16 *)V850E2_BHC_ADDR)
+/* NPB strobe-wait configuration */
+#define V850E2_VSWC_ADDR	0xFFFFF06E
+#define V850E2_VSWC		(*(volatile u16 *)V850E2_VSWC_ADDR)
+/* Bus cycle type */
+#define V850E2_BCT_ADDR(n)	(0xFFFFF480 + (n) * 2)
+#define V850E2_BCT(n)		(*(volatile u16 *)V850E2_BCT_ADDR(n))
+/* Data wait control */
+#define V850E2_DWC_ADDR(n)	(0xFFFFF484 + (n) * 2)
+#define V850E2_DWC(n)		(*(volatile u16 *)V850E2_DWC_ADDR(n))
+/* Bus cycle control */
+#define V850E2_BCC_ADDR		0xFFFFF488
+#define V850E2_BCC		(*(volatile u16 *)V850E2_BCC_ADDR)
+/* Address wait control */
+#define V850E2_ASC_ADDR		0xFFFFF48A
+#define V850E2_ASC		(*(volatile u16 *)V850E2_ASC_ADDR)
+/* Local bus sizing control */
+#define V850E2_LBS_ADDR		0xFFFFF48E
+#define V850E2_LBS		(*(volatile u16 *)V850E2_LBS_ADDR)
+/* Line buffer control */
+#define V850E2_LBC_ADDR(n)	(0xFFFFF490 + (n) * 2)
+#define V850E2_LBC(n)		(*(volatile u16 *)V850E2_LBC_ADDR(n))
+/* SDRAM configuration */
+#define V850E2_SCR_ADDR(n)	(0xFFFFF4A0 + (n) * 4)
+#define V850E2_SCR(n)		(*(volatile u16 *)V850E2_SCR_ADDR(n))
+/* SDRAM refresh cycle control */
+#define V850E2_RFS_ADDR(n)	(0xFFFFF4A2 + (n) * 4)
+#define V850E2_RFS(n)		(*(volatile u16 *)V850E2_RFS_ADDR(n))
+
+
+#endif /* __V850_V850E2_H__ */
diff -ruN -X../cludes linux-2.6.0-test1-moo/include/asm-v850/v850e2_cache.h linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e2_cache.h
--- linux-2.6.0-test1-moo/include/asm-v850/v850e2_cache.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.0-test1-moo-v850-20030718/include/asm-v850/v850e2_cache.h	2003-07-17 20:25:27.000000000 +0900
@@ -0,0 +1,74 @@
+/*
+ * include/asm-v850/v850e2_cache_cache.h -- Cache control for V850E2
+ * 	cache memories
+ *
+ *  Copyright (C) 2003  NEC Electronics Corporation
+ *  Copyright (C) 2003  Miles Bader <miles@gnu.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.
+ *
+ * Written by Miles Bader <miles@gnu.org>
+ */
+
+#ifndef __V850_V850E2_CACHE_H__
+#define __V850_V850E2_CACHE_H__
+
+#include <asm/types.h>
+
+
+/* Cache control registers.  */
+
+/* Bus Transaction Control */
+#define V850E2_CACHE_BTSC_ADDR	0xFFFFF070
+#define V850E2_CACHE_BTSC 	(*(volatile u16 *)V850E2_CACHE_BTSC_ADDR)
+#define V850E2_CACHE_BTSC_ICM	0x0001 /* icache enable */
+#define V850E2_CACHE_BTSC_DCM0	0x0004 /* dcache enable, bit 0 */
+#define V850E2_CACHE_BTSC_DCM1	0x0008 /* dcache enable, bit 1 */
+#define V850E2_CACHE_BTSC_DCM_WT		      /* write-through */ \
+			V850E2_CACHE_BTSC_DCM0
+#ifdef CONFIG_V850E2_V850E2S
+# define V850E2_CACHE_BTSC_DCM_WB_NO_ALLOC    /* write-back, non-alloc */ \
+			V850E2_CACHE_BTSC_DCM1	
+# define V850E2_CACHE_BTSC_DCM_WB_ALLOC	      /* write-back, non-alloc */ \
+			(V850E2_CACHE_BTSC_DCM1 | V850E2_CACHE_BTSC_DCM0)
+# define V850E2_CACHE_BTSC_ISEQ	0x0010 /* icache `address sequence mode' */
+# define V850E2_CACHE_BTSC_DSEQ	0x0020 /* dcache `address sequence mode' */
+# define V850E2_CACHE_BTSC_IRFC	0x0030
+# define V850E2_CACHE_BTSC_ILCD	0x4000
+# define V850E2_CACHE_BTSC_VABE	0x8000
+#endif /* CONFIG_V850E2_V850E2S */
+
+/* Cache operation start address register (low-bits).  */
+#define V850E2_CACHE_CADL_ADDR	0xFFFFF074
+#define V850E2_CACHE_CADL 	(*(volatile u16 *)V850E2_CACHE_CADL_ADDR)
+/* Cache operation start address register (high-bits).  */
+#define V850E2_CACHE_CADH_ADDR	0xFFFFF076
+#define V850E2_CACHE_CADH 	(*(volatile u16 *)V850E2_CACHE_CADH_ADDR)
+/* Cache operation count register.  */
+#define V850E2_CACHE_CCNT_ADDR	0xFFFFF078
+#define V850E2_CACHE_CCNT 	(*(volatile u16 *)V850E2_CACHE_CCNT_ADDR)
+/* Cache operation specification register.  */
+#define V850E2_CACHE_COPR_ADDR	0xFFFFF07A
+#define V850E2_CACHE_COPR 	(*(volatile u16 *)V850E2_CACHE_COPR_ADDR)
+#define V850E2_CACHE_COPR_STRT	0x0001 /* start cache operation */
+#define V850E2_CACHE_COPR_LBSL	0x0100 /* 0 = icache, 1 = dcache */
+#define V850E2_CACHE_COPR_WSLE	0x0200 /* operate on cache way */
+#define V850E2_CACHE_COPR_WSL(way) ((way) * 0x0400) /* way select */
+#define V850E2_CACHE_COPR_CFC(op)  ((op)  * 0x1000) /* cache function code */
+
+
+/* Size of a cache line in bytes.  */
+#define V850E2_CACHE_LINE_SIZE_BITS	4
+#define V850E2_CACHE_LINE_SIZE		(1 << V850E2_CACHE_LINE_SIZE_BITS)
+
+/* The size of each cache `way' in lines.  */
+#define V850E2_CACHE_WAY_SIZE		256
+
+
+/* For <asm/cache.h> */
+#define L1_CACHE_BYTES			V850E2_CACHE_LINE_SIZE
+
+
+#endif /* __V850_V850E2_CACHE_H__ */
