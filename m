Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966135AbWKTQu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966135AbWKTQu4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 11:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966190AbWKTQu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 11:50:56 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:17320 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S966135AbWKTQuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 11:50:55 -0500
Message-ID: <4561DCE8.20502@us.ibm.com>
Date: Mon, 20 Nov 2006 10:50:48 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
Reply-To: maynardj@us.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1]OProfile for Cell bug fix
Content-Type: multipart/mixed;
 boundary="------------050507000803040707050209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050507000803040707050209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------050507000803040707050209
Content-Type: text/plain;
 name="oprof-ppu-fix1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oprof-ppu-fix1.diff"

Subject: Bug fixes for OProfile for Cell

From: Maynard Johnson <maynardj@us.ibm.com>

This patch contains three crucial fixes: 
	- op_model_cell.c:cell_virtual_cntr: correctly access the per-cpu
	  pmc_values arrays 

	- op_model_cell.c:cell_reg_setup:  initialize _all_ 4 elements of
	  pmc_values with reset_value

	- include/asm-powerpc/cell-pmu.h:  fix broken macro, PM07_CTR_INPUT_MUX

Signed-off-by: Carl Love <carll@us.ibm.com>
Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>

Index: linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/op_model_cell.c
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/arch/powerpc/oprofile/op_model_cell.c	2006-11-20 10:23:38.520401976 -0600
+++ linux-2.6.19-rc6-arnd1+patches/arch/powerpc/oprofile/op_model_cell.c	2006-11-20 10:26:49.912328712 -0600
@@ -102,20 +102,20 @@
 #define GET_INPUT_CONTROL(x) ((x & 0x00000004) >> 2)
 
 
-DEFINE_PER_CPU(unsigned long[NR_PHYS_CTRS], pmc_values);
+static DEFINE_PER_CPU(unsigned long[NR_PHYS_CTRS], pmc_values);
 
-struct pmc_cntrl_data pmc_cntrl[NUM_THREADS][NR_PHYS_CTRS];
+static struct pmc_cntrl_data pmc_cntrl[NUM_THREADS][NR_PHYS_CTRS];
 
 /* Interpetation of hdw_thread:
  * 0 - even virtual cpus 0, 2, 4,...
  * 1 - odd virtual cpus 1, 3, 5, ...
  */
-static u32  hdw_thread;
+static u32 hdw_thread;
 
 static u32 virt_cntr_inter_mask;
 static struct timer_list timer_virt_cntr;
 
-/* pm_signal needs to be glogal since it is initialized in
+/* pm_signal needs to be global since it is initialized in
  * cell_reg_setup at the time when the necessary information
  * is available. 
  */
@@ -178,7 +178,7 @@
 {
 	int ret;
 	int j;
-        struct pm_signal pm_signal_local[NR_PHYS_CTRS];
+	struct pm_signal pm_signal_local[NR_PHYS_CTRS];
 
 	for (j = 0; j < count; j++) {
 		/* fw expects physical cpu # */
@@ -278,7 +278,7 @@
 	;
 }
 
-static void write_pm_cntrl(int cpu, struct pm_cntrl * pm_cntrl)
+static void write_pm_cntrl(int cpu, struct pm_cntrl *pm_cntrl)
 {
 	/* Oprofile will use 32 bit counters, set bits 7:10 to 0 */
 	u32 val = 0;
@@ -328,36 +328,48 @@
 }
 
 /*
- * Oprofile setup functions
+ * Oprofile is expected to collect data on all CPUs simultaneously.
+ * However, there is one set of performance counters per node.  There are
+ * two hardware threads or virtual CPUs on each node.  Hence, OProfile must
+ * multiplex in time the performance counter collection on the two virtual
+ * CPUs.  The multiplexing of the performance counters is done by this
+ * virtual counter routine.
+ *
+ * The pmc_values used below is defined as 'per-cpu' but its use is
+ * more akin to 'per-node'.  We need to store two sets of counter
+ * values per node -- one for the previous run and one for the next.
+ * The per-cpu[NR_PHYS_CTRS] gives us the storage we need.  Each odd/even
+ * pair of per-cpu arrays is used for storing the previous and next
+ * pmc values for a given node.  
+ * NOTE: We use the per-cpu variable to improve cache performance.
  */
 static void cell_virtual_cntr(unsigned long data)
 {
 	/* This routine will alternate loading the virtual counters for
 	 * virtual CPUs
 	 */
-	int i, cntr_offset_prev, cntr_offset_next, num_enabled;
+	int i, prev_hdw_thread, next_hdw_thread;
 	u32 cpu;
 	unsigned long flags;
 
 	/* Make sure that the interrupt_hander and 
 	 * the virt counter are not both playing with
-	 * the counters on the same node.  */
+	 * the counters on the same node.  
+	 */
 
 	spin_lock_irqsave(&virt_cntr_lock, flags);
 
-        /* cntr offset for the cntrs that were running */
-	cntr_offset_prev = num_counters *  hdw_thread;	
+	prev_hdw_thread = hdw_thread;
 
-        /* switch the cpu handling the interrupts */
-	hdw_thread = 1 ^  hdw_thread;
+	/* switch the cpu handling the interrupts */
+	hdw_thread = 1 ^ hdw_thread;
+	next_hdw_thread = hdw_thread;
 
-	/* cntr offset for the cntrs to start */
-	cntr_offset_next = num_counters *  hdw_thread;
 	/* The following is done only once per each node, but       
 	 * we need cpu #, not node #, to pass to the cbe_xxx functions.
 	 */
 	for_each_online_cpu(cpu) {
- 		if (cbe_get_hw_thread_id(cpu))
+		if (cbe_get_hw_thread_id(cpu))
 			continue;
 
 		/* stop counters, save counter values, restore counts
@@ -366,55 +378,57 @@
 		cbe_disable_pm(cpu);
 		cbe_disable_pm_interrupts(cpu);
 		for (i = 0; i < num_counters; i++) {
-			per_cpu(pmc_values, cpu)[i + cntr_offset_prev]
-				= cbe_read_ctr(cpu, i);
+			per_cpu(pmc_values, cpu + prev_hdw_thread)[i]
+			    = cbe_read_ctr(cpu, i);
 
-			if (per_cpu(pmc_values, cpu)[i+cntr_offset_next] == \
-			    0xFFFFFFFF) 
-                        /* If the cntr value is 0xffffffff, we must
-                         * reset that to 0xfffffff0 when the current
-                         * thread is restarted.  This will generate a new
-                         * interrupt and make sure that we never restore
-                         * the counters to the max value.  If the counters
-                         * were restored to the max value, they do not
-                         * increment and no interrupts are generated.  Hence
-                         * no more samples will be collected on that cpu.
-                         */
+			if (per_cpu(pmc_values, cpu + next_hdw_thread)[i]
+			    == 0xFFFFFFFF) 
+				/* If the cntr value is 0xffffffff, we must
+				 * reset that to 0xfffffff0 when the current
+				 * thread is restarted.  This will generate a new
+				 * interrupt and make sure that we never restore
+				 * the counters to the max value.  If the counters
+				 * were restored to the max value, they do not
+				 * increment and no interrupts are generated.  Hence
+				 * no more samples will be collected on that cpu.
+				 */
 				cbe_write_ctr(cpu, i, 0xFFFFFFF0);
 			else
 				cbe_write_ctr(cpu, i,
-					      per_cpu(pmc_values, 
-						      cpu)[i+cntr_offset_next]);
+					      per_cpu(pmc_values,
+						      cpu +
+						      next_hdw_thread)[i]);
 		}
 
 		/* Switch to the other thread. Change the interrupt
 		 * and control regs to be scheduled on the CPU
 		 * corresponding to the thread to execute.
 		 */
-		num_enabled = 0;
-
 		for (i = 0; i < num_counters; i++) {
-			if (pmc_cntrl[hdw_thread][i+cntr_offset_next].enabled) {
-				set_pm_event(num_enabled,
-					     pmc_cntrl[hdw_thread][i].enabled,
-					     pmc_cntrl[hdw_thread][i].masks);
-
-				num_enabled++;
-				ctr_enabled |= (1 << i);
+			if (pmc_cntrl[next_hdw_thread][i].enabled) {
+				/* There are some per thread events.
+				 * Must do the set event, enable_cntr
+				 * for each cpu. 
+				 */
+				set_pm_event(i,
+				     pmc_cntrl[next_hdw_thread][i].evnts,
+				     pmc_cntrl[next_hdw_thread][i].masks);
+				enable_ctr(cpu, i,
+					   pm_regs.pm07_cntrl);
+			} else {
+				cbe_write_pm07_control(cpu, i, 0);
 			}
 		}
 
 		/* Enable interrupts on the CPU thread that is starting */
-		cbe_enable_pm_interrupts(cpu, hdw_thread,
+		cbe_enable_pm_interrupts(cpu, next_hdw_thread,
 					 virt_cntr_inter_mask);
 		cbe_enable_pm(cpu);
 	}
 
 	spin_unlock_irqrestore(&virt_cntr_lock, flags);
 
-	mod_timer(&timer_virt_cntr, jiffies + HZ/10);
-
-	return;
+	mod_timer(&timer_virt_cntr, jiffies + HZ / 10);
 }
 
 static void start_virt_cntrs(void)
@@ -422,7 +436,7 @@
 	init_timer(&timer_virt_cntr);
 	timer_virt_cntr.function = cell_virtual_cntr;
 	timer_virt_cntr.data = 0UL;
-	timer_virt_cntr.expires = jiffies + HZ/10;
+	timer_virt_cntr.expires = jiffies + HZ / 10;
 	add_timer(&timer_virt_cntr);
 }
 
@@ -431,8 +445,7 @@
 cell_reg_setup(struct op_counter_config *ctr,
 	       struct op_system_config *sys, int num_ctrs)
 {
-	int i, j;
-	int num_enabled = 0;
+	int i, j, cpu;
 
 	pm_rtas_token = rtas_token("ibm,cbe-perftools");
 	if (pm_rtas_token == RTAS_UNKNOWN_SERVICE) {
@@ -471,7 +484,6 @@
 	 * equivalent thread 1 event.
 	 */
 	for (i = 0; i < num_ctrs; ++i) {
-
 		if ((ctr[i].event >= 2100) && (ctr[i].event <= 2111))
 			pmc_cntrl[1][i].evnts = ctr[i].event + 19;
 		else if (ctr[i].event == 2203)
@@ -500,18 +512,23 @@
 	 */
 	for (i = 0; i < num_counters; ++i) {
 		/* start with virtual counter set 0 */
-
 		if (pmc_cntrl[0][i].enabled) {
 			/* Using 32bit counters, reset max - count */
 			reset_value[i] = 0xFFFFFFFF - ctr[i].count;
-			set_pm_event(num_enabled,
+			set_pm_event(i,
 				     pmc_cntrl[0][i].evnts,
 				     pmc_cntrl[0][i].masks);
-			num_enabled++;
-			ctr_enabled |= (1 << i);
+
+			/* global, used by cell_cpu_setup */
+			ctr_enabled |= (1 << i); 
 		}
 	}
 
+	/* initialize the previous counts for the virtual cntrs */
+	for_each_online_cpu(cpu) 
+		for (i = 0; i < num_counters; ++i) {
+			per_cpu(pmc_values, cpu)[i] = reset_value[i];
+		}
 out:
 	;
 }
@@ -577,7 +594,8 @@
 			if (ctr_enabled & (1 << i)) {
 				cbe_write_ctr(cpu, i, reset_value[i]);
 				enable_ctr(cpu, i, pm_regs.pm07_cntrl);
-				interrupt_mask |= CBE_PM_CTR_OVERFLOW_INTR(i);
+				interrupt_mask |=
+				    CBE_PM_CTR_OVERFLOW_INTR(i);
 			} else {
 				/* Disable counter */
 				cbe_write_pm07_control(cpu, i, 0);
@@ -591,14 +609,14 @@
 
 	virt_cntr_inter_mask = interrupt_mask;
 	oprofile_running = 1;
-        smp_wmb();
+	smp_wmb();
 
 	/* NOTE: start_virt_cntrs will result in cell_virtual_cntr() being
 	 * executed which manipulates the PMU.  We start the "virtual counter"
 	 * here so that we do not need to synchronize access to the PMU in
 	 * the above for-loop.
-	 */ 
-        start_virt_cntrs();
+	 */
+	start_virt_cntrs();
 }
 
 static void cell_global_stop(void)
@@ -609,7 +627,6 @@
 	 * There is one performance monitor per node, so we 
 	 * only need to perform this function once per node.
 	 */
-	
 	del_timer_sync(&timer_virt_cntr);
 	oprofile_running = 0;
 	smp_wmb();
@@ -644,9 +661,10 @@
 
 	/* Need to make sure the interrupt handler and the virt counter
 	 * routine are not running at the same time. See the 
-	 * cell_virtual_cntr() routine for additional comments. */
+	 * cell_virtual_cntr() routine for additional comments.
+	 */
 	spin_lock_irqsave(&virt_cntr_lock, flags);
-	
+
 	/* Need to disable and reenable the performance counters
 	 * to get the desired behavior from the hardware.  This
 	 * is hardware specific.  
@@ -667,8 +685,8 @@
 		is_kernel = is_kernel_addr(pc);
 
 		for (i = 0; i < num_counters; ++i) {
-			if ((interrupt_mask & CBE_PM_CTR_OVERFLOW_INTR(i)) &&
-			    ctr[i].enabled) {
+			if ((interrupt_mask & CBE_PM_CTR_OVERFLOW_INTR(i))
+			    && ctr[i].enabled) {
 				oprofile_add_pc(pc, is_kernel, i);
 				cbe_write_ctr(cpu, i, reset_value[i]);
 			}
@@ -676,8 +694,13 @@
 
 		/* The counters were frozen by the interrupt.
 		 * Reenable the interrupt and restart the counters.
+		 * If there was a race between the interrupt handler and 
+		 * the virtual counter routine.  The virutal counter 
+		 * routine may have cleared the interrupts.  Hence must
+		 * use the virt_cntr_inter_mask to re-enable the interrupts.
 		 */
-		cbe_enable_pm_interrupts(cpu, hdw_thread, interrupt_mask);
+		cbe_enable_pm_interrupts(cpu, hdw_thread, 
+					 virt_cntr_inter_mask);
 
 		/* The writes to the various performance counters only writes
 		 * to a latch.  The new values (interrupt setting bits, reset
Index: linux-2.6.19-rc6-arnd1+patches/include/asm-powerpc/cell-pmu.h
===================================================================
--- linux-2.6.19-rc6-arnd1+patches.orig/include/asm-powerpc/cell-pmu.h	2006-11-20 10:23:38.524401368 -0600
+++ linux-2.6.19-rc6-arnd1+patches/include/asm-powerpc/cell-pmu.h	2006-11-20 10:26:49.914328408 -0600
@@ -104,7 +104,7 @@
 #define CBE_COUNT_ALL_MODES             3
 
 /* Macros for the pm07_control registers. */
-#define PM07_CTR_INPUT_MUX(x)                    ((((x) & 1) << 26) & 0x3f)
+#define PM07_CTR_INPUT_MUX(x)                    (((x) & 0x3F) << 26) 
 #define PM07_CTR_INPUT_CONTROL(x)                (((x) & 1) << 25)
 #define PM07_CTR_POLARITY(x)                     (((x) & 1) << 24)
 #define PM07_CTR_COUNT_CYCLES(x)                 (((x) & 1) << 23)

--------------050507000803040707050209--

