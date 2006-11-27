Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933721AbWK0Vff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933721AbWK0Vff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 16:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933744AbWK0Vff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 16:35:35 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:12242 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S933721AbWK0Vfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 16:35:34 -0500
Message-ID: <456B5A23.4060606@us.ibm.com>
Date: Mon, 27 Nov 2006 15:35:31 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
Reply-To: maynardj@us.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1]OProfile for Cell cleanup patch
Content-Type: multipart/mixed;
 boundary="------------040404040403080201030606"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040404040403080201030606
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------040404040403080201030606
Content-Type: text/plain;
 name="oprof-ppu-cleanup1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oprof-ppu-cleanup1.diff"

This is a clean up patch that includes the following changes:

        -It removes some macro definitions that are only used once
         with the actual code.
        -Some comments were added to clarify the code based on feedback
         from the community.
        -The write_pm_cntrl() and set_count_mode() were passed a structure
         element from a global variable.  The argument was removed so the
         functions now just operate on the global directly.
        -The set_pm_event() function call in the cell_virtual_cntr() routine
         was moved to a for-loop before the for_each_cpu loop

Signed-off-by: Carl Love <carll@us.ibm.com>
Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>

Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/op_model_cell.c
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/oprofile/op_model_cell.c	2006-11-24 11:34:45.048430752 -0600
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/op_model_cell.c	2006-11-27 11:45:00.737473968 -0600
@@ -41,8 +41,12 @@
 #define PPU_CYCLES_EVENT_NUM 1	/*  event number for CYCLES */
 #define CBE_COUNT_ALL_CYCLES 0x42800000	/* PPU cycle event specifier */
 
-#define NUM_THREADS 2
-#define VIRT_CNTR_SW_TIME_NS 100000000	// 0.5 seconds
+#define NUM_THREADS 2         /* number of physical threads in 
+			       * physical processor 
+			       */
+#define NUM_TRACE_BUS_WORDS 4
+#define NUM_INPUT_BUS_WORDS 2
+
 
 struct pmc_cntrl_data {
 	unsigned long vcntr;
@@ -94,14 +98,6 @@
 } pm_regs;
 
 
-#define GET_SUB_UNIT(x) ((x & 0x0000f000) >> 12)
-#define GET_BUS_WORD(x) ((x & 0x000000f0) >> 4)
-#define GET_BUS_TYPE(x) ((x & 0x00000300) >> 8)
-#define GET_POLARITY(x) ((x & 0x00000002) >> 1)
-#define GET_COUNT_CYCLES(x) (x & 0x00000001)
-#define GET_INPUT_CONTROL(x) ((x & 0x00000004) >> 2)
-
-
 static DEFINE_PER_CPU(unsigned long[NR_PHYS_CTRS], pmc_values);
 
 static struct pmc_cntrl_data pmc_cntrl[NUM_THREADS][NR_PHYS_CTRS];
@@ -129,8 +125,8 @@
 
 static u32 ctr_enabled;
 
-static unsigned char trace_bus[4];
-static unsigned char input_bus[2];
+static unsigned char trace_bus[NUM_TRACE_BUS_WORDS];
+static unsigned char input_bus[NUM_INPUT_BUS_WORDS];
 
 /*
  * Firmware interface functions
@@ -221,24 +217,32 @@
 		pm_regs.pm07_cntrl[ctr] = 0;
 	}
 
-	bus_word = GET_BUS_WORD(unit_mask);
-	bus_type = GET_BUS_TYPE(unit_mask);
-	count_cycles = GET_COUNT_CYCLES(unit_mask);
-	polarity = GET_POLARITY(unit_mask);
-	input_control = GET_INPUT_CONTROL(unit_mask);
+	bus_word = (unit_mask & 0x000000f0) >> 4;
+	bus_type = (unit_mask & 0x00000300) >> 8;
+	count_cycles = unit_mask & 0x00000001;
+	polarity = (unit_mask & 0x00000002) >> 1;
+	input_control = (unit_mask & 0x00000004) >> 2;
 	signal_bit = (event % 100);
 
 	p = &(pm_signal[ctr]);
 
 	p->signal_group = event / 100;
 	p->bus_word = bus_word;
-	p->sub_unit = unit_mask & 0x0000f000;
+	p->sub_unit = (unit_mask & 0x0000f000) >> 12;
 
 	pm_regs.pm07_cntrl[ctr] = 0;
-	pm_regs.pm07_cntrl[ctr] |= PM07_CTR_COUNT_CYCLES(count_cycles);
-	pm_regs.pm07_cntrl[ctr] |= PM07_CTR_POLARITY(polarity);
-	pm_regs.pm07_cntrl[ctr] |= PM07_CTR_INPUT_CONTROL(input_control);
-
+	pm_regs.pm07_cntrl[ctr] |= (count_cycles & 1) << 23;
+	pm_regs.pm07_cntrl[ctr] |= (polarity & 1) << 24;
+	pm_regs.pm07_cntrl[ctr] |= (input_control & 1) << 25;
+
+	/* Some of the islands signal selection is based on 64 bit words.
+	 * The debug bus words are 32 bits, the input words to the performance
+	 * counters are defined as 32 bits.  Need to convert the 64 bit island
+	 * specification to the appropriate 32 input bit and bus word for the
+	 * performance counter event selection.  See the CELL Performance
+	 * monitoring signals manual and the Perf cntr hardware descriptions
+	 * for the details.
+	 */
 	if (input_control == 0) {
 		if (signal_bit > 31) {
 			signal_bit -= 32;
@@ -253,18 +257,18 @@
 		if ((bus_type == 1) && p->signal_group >= 50)
 			bus_type = 0;
 
-		pm_regs.pm07_cntrl[ctr] |= PM07_CTR_INPUT_MUX(signal_bit);
+		pm_regs.pm07_cntrl[ctr] |= (signal_bit & 0x3F) << 26;
 	} else {
 		pm_regs.pm07_cntrl[ctr] = 0;
 		p->bit = signal_bit;
 	}
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < NUM_TRACE_BUS_WORDS; i++) {
 		if (bus_word & (1 << i)) {
 			pm_regs.debug_bus_control |=
 			    (bus_type << (31 - (2 * i) + 1));
 
-			for (j = 0; j < 2; j++) {
+			for (j = 0; j < NUM_INPUT_BUS_WORDS; j++) {
 				if (input_bus[j] == 0xff) {
 					input_bus[j] = i;
 					pm_regs.group_control |=
@@ -278,52 +282,58 @@
 	;
 }
 
-static void write_pm_cntrl(int cpu, struct pm_cntrl *pm_cntrl)
+static void write_pm_cntrl(int cpu)
 {
-	/* Oprofile will use 32 bit counters, set bits 7:10 to 0 */
+	/* Oprofile will use 32 bit counters, set bits 7:10 to 0 
+	 * pmregs.pm_cntrl is a global
+	 */
+        
 	u32 val = 0;
-	if (pm_cntrl->enable == 1)
+	if (pm_regs.pm_cntrl.enable == 1)
 		val |= CBE_PM_ENABLE_PERF_MON;
 
-	if (pm_cntrl->stop_at_max == 1)
+	if (pm_regs.pm_cntrl.stop_at_max == 1)
 		val |= CBE_PM_STOP_AT_MAX;
 
-	if (pm_cntrl->trace_mode == 1)
-		val |= CBE_PM_TRACE_MODE_SET(pm_cntrl->trace_mode);
+	if (pm_regs.pm_cntrl.trace_mode == 1)
+		val |= CBE_PM_TRACE_MODE_SET(pm_regs.pm_cntrl.trace_mode);
 
-	if (pm_cntrl->freeze == 1)
+	if (pm_regs.pm_cntrl.freeze == 1)
 		val |= CBE_PM_FREEZE_ALL_CTRS;
 
 	/* Routine set_count_mode must be called previously to set
 	 * the count mode based on the user selection of user and kernel.
 	 */
-	val |= CBE_PM_COUNT_MODE_SET(pm_cntrl->count_mode);
+	val |= CBE_PM_COUNT_MODE_SET(pm_regs.pm_cntrl.count_mode);
 	cbe_write_pm(cpu, pm_control, val);
 }
 
 static inline void
-set_count_mode(u32 kernel, u32 user, struct pm_cntrl *pm_cntrl)
+set_count_mode(u32 kernel, u32 user)
 {
 	/* The user must specify user and kernel if they want them. If
-	 *  neither is specified, OProfile will count in hypervisor mode
+	 *  neither is specified, OProfile will count in hypervisor mode.
+	 *  pm_regs.pm_cntrl is a global
 	 */
 	if (kernel) {
 		if (user)
-			pm_cntrl->count_mode = CBE_COUNT_ALL_MODES;
+			pm_regs.pm_cntrl.count_mode = CBE_COUNT_ALL_MODES;
 		else
-			pm_cntrl->count_mode = CBE_COUNT_SUPERVISOR_MODE;
+			pm_regs.pm_cntrl.count_mode = 
+				CBE_COUNT_SUPERVISOR_MODE;
 	} else {
 		if (user)
-			pm_cntrl->count_mode = CBE_COUNT_PROBLEM_MODE;
+			pm_regs.pm_cntrl.count_mode = CBE_COUNT_PROBLEM_MODE;
 		else
-			pm_cntrl->count_mode = CBE_COUNT_HYPERVISOR_MODE;
+			pm_regs.pm_cntrl.count_mode = 
+				CBE_COUNT_HYPERVISOR_MODE;
 	}
 }
 
 static inline void enable_ctr(u32 cpu, u32 ctr, u32 * pm07_cntrl)
 {
 
-	pm07_cntrl[ctr] |= PM07_CTR_ENABLE(1);
+	pm07_cntrl[ctr] |= CBE_PM_CTR_ENABLE;
 	cbe_write_pm07_control(cpu, ctr, pm07_cntrl[ctr]);
 }
 
@@ -365,6 +375,14 @@
 	hdw_thread = 1 ^ hdw_thread;
 	next_hdw_thread = hdw_thread;
 
+	for (i = 0; i < num_counters; i++)
+		/* There are some per thread events.  Must do the
+		* set event, for the thread that is being started
+		*/
+		set_pm_event(i,
+			pmc_cntrl[next_hdw_thread][i].evnts,
+			pmc_cntrl[next_hdw_thread][i].masks);
+
 	/* The following is done only once per each node, but       
 	 * we need cpu #, not node #, to pass to the cbe_xxx functions.
 	 */
@@ -385,12 +403,13 @@
 			    == 0xFFFFFFFF) 
 				/* If the cntr value is 0xffffffff, we must
 				 * reset that to 0xfffffff0 when the current
-				 * thread is restarted.  This will generate a new
-				 * interrupt and make sure that we never restore
-				 * the counters to the max value.  If the counters
-				 * were restored to the max value, they do not
-				 * increment and no interrupts are generated.  Hence
-				 * no more samples will be collected on that cpu.
+				 * thread is restarted.  This will generate a 
+				 * new interrupt and make sure that we never 
+				 * restore the counters to the max value.  If 
+				 * the counters were restored to the max value,
+				 * they do not increment and no interrupts are
+				 * generated.  Hence no more samples will be 
+				 * collected on that cpu.
 				 */
 				cbe_write_ctr(cpu, i, 0xFFFFFFF0);
 			else
@@ -410,9 +429,6 @@
 				 * Must do the set event, enable_cntr
 				 * for each cpu. 
 				 */
-				set_pm_event(i,
-				     pmc_cntrl[next_hdw_thread][i].evnts,
-				     pmc_cntrl[next_hdw_thread][i].masks);
 				enable_ctr(cpu, i,
 					   pm_regs.pm07_cntrl);
 			} else {
@@ -465,8 +481,7 @@
 	pm_regs.pm_cntrl.trace_mode = 0;
 	pm_regs.pm_cntrl.freeze = 1;
 
-	set_count_mode(sys->enable_kernel, sys->enable_user,
-		       &pm_regs.pm_cntrl);
+	set_count_mode(sys->enable_kernel, sys->enable_user);
 
 	/* Setup the thread 0 events */
 	for (i = 0; i < num_ctrs; ++i) {
@@ -498,10 +513,10 @@
 		pmc_cntrl[1][i].vcntr = i;
 	}
 
-	for (i = 0; i < 4; i++)
+	for (i = 0; i < NUM_INPUT_BUS_WORDS; i++)
 		trace_bus[i] = 0xff;
 
-	for (i = 0; i < 2; i++)
+	for (i = 0; i < NUM_INPUT_BUS_WORDS; i++)
 		input_bus[i] = 0xff;
 
 	/* Our counters count up, and "count" refers to
@@ -560,7 +575,7 @@
 	cbe_write_pm(cpu, pm_start_stop, 0);
 	cbe_write_pm(cpu, group_control, pm_regs.group_control);
 	cbe_write_pm(cpu, debug_bus_control, pm_regs.debug_bus_control);
-	write_pm_cntrl(cpu, &pm_regs.pm_cntrl);
+	write_pm_cntrl(cpu);
 
 	for (i = 0; i < num_counters; ++i) {
 		if (ctr_enabled & (1 << i)) {
@@ -602,7 +617,7 @@
 			}
 		}
 
-		cbe_clear_pm_interrupts(cpu);
+		cbe_get_and_clear_pm_interrupts(cpu);
 		cbe_enable_pm_interrupts(cpu, hdw_thread, interrupt_mask);
 		cbe_enable_pm(cpu);
 	}
@@ -672,7 +687,7 @@
 
 	cbe_disable_pm(cpu);
 
-	interrupt_mask = cbe_clear_pm_interrupts(cpu);
+	interrupt_mask = cbe_get_and_clear_pm_interrupts(cpu);
 
 	/* If the interrupt mask has been cleared, then the virt cntr
 	 * has cleared the interrupt.  When the thread that generated
Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/pmu.c
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/platforms/cell/pmu.c	2006-11-24 11:34:44.880456288 -0600
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/platforms/cell/pmu.c	2006-11-27 11:45:00.739473664 -0600
@@ -345,18 +345,12 @@
  * Enabling/disabling interrupts for the entire performance monitoring unit.
  */
 
-u32 cbe_query_pm_interrupts(u32 cpu)
-{
-	return cbe_read_pm(cpu, pm_status);
-}
-EXPORT_SYMBOL_GPL(cbe_query_pm_interrupts);
-
-u32 cbe_clear_pm_interrupts(u32 cpu)
+u32 cbe_get_and_clear_pm_interrupts(u32 cpu)
 {
 	/* Reading pm_status clears the interrupt bits. */
-	return cbe_query_pm_interrupts(cpu);
+	return cbe_read_pm(cpu, pm_status);
 }
-EXPORT_SYMBOL_GPL(cbe_clear_pm_interrupts);
+EXPORT_SYMBOL_GPL(cbe_get_and_clear_pm_interrupts);
 
 void cbe_enable_pm_interrupts(u32 cpu, u32 thread, u32 mask)
 {
@@ -371,7 +365,7 @@
 
 void cbe_disable_pm_interrupts(u32 cpu)
 {
-	cbe_clear_pm_interrupts(cpu);
+	cbe_get_and_clear_pm_interrupts(cpu);
 	cbe_write_pm(cpu, pm_status, 0);
 }
 EXPORT_SYMBOL_GPL(cbe_disable_pm_interrupts);
Index: linux-2.6.19-rc6-arnd1+patches/include/asm-powerpc/cell-pmu.h
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/include/asm-powerpc/cell-pmu.h	2006-11-24 11:34:52.744459720 -0600
+++ linux-2.6.19-rc6-arnd1+patches/include/asm-powerpc/cell-pmu.h	2006-11-27 11:45:22.987553552 -0600
@@ -89,8 +89,7 @@
 
 extern void cbe_enable_pm_interrupts(u32 cpu, u32 thread, u32 mask);
 extern void cbe_disable_pm_interrupts(u32 cpu);
-extern u32  cbe_query_pm_interrupts(u32 cpu);
-extern u32  cbe_clear_pm_interrupts(u32 cpu);
+extern u32  cbe_get_and_clear_pm_interrupts(u32 cpu);
 extern void cbe_sync_irq(int node);
 
 /* Utility functions, macros */
@@ -103,11 +102,4 @@
 #define CBE_COUNT_PROBLEM_MODE          2
 #define CBE_COUNT_ALL_MODES             3
 
-/* Macros for the pm07_control registers. */
-#define PM07_CTR_INPUT_MUX(x)                    (((x) & 0x3F) << 26) 
-#define PM07_CTR_INPUT_CONTROL(x)                (((x) & 1) << 25)
-#define PM07_CTR_POLARITY(x)                     (((x) & 1) << 24)
-#define PM07_CTR_COUNT_CYCLES(x)                 (((x) & 1) << 23)
-#define PM07_CTR_ENABLE(x)                       (((x) & 1) << 22)
-
 #endif /* __ASM_CELL_PMU_H__ */

--------------040404040403080201030606--

