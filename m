Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267484AbUHEEnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267484AbUHEEnD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267486AbUHEEnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:43:03 -0400
Received: from holomorphy.com ([207.189.100.168]:60864 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267484AbUHEEle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:41:34 -0400
Date: Wed, 4 Aug 2004 21:41:30 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [sparc32] [3/13] sun4d cpu_present_map is a cpumask_t
Message-ID: <20040805044130.GU2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040802015527.49088944.akpm@osdl.org> <20040805043817.GS2334@holomorphy.com> <20040805043957.GT2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805043957.GT2334@holomorphy.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2004 at 09:39:57PM -0700, William Lee Irwin III wrote:
> An analysis of the code determined that AP initialization called
> init_idle() no less than three times, 2 out of the three with incorrect
> numbers of arguments. This patch removes the superfluous calls.

cpu_present_map is a cpumask_t. Sweep arch/sparc/kernel/sun4d_smp.c so
that it is treated as such.

Index: mm2-2.6.8-rc2/arch/sparc/kernel/sun4d_smp.c
===================================================================
--- mm2-2.6.8-rc2.orig/arch/sparc/kernel/sun4d_smp.c
+++ mm2-2.6.8-rc2/arch/sparc/kernel/sun4d_smp.c
@@ -43,7 +43,6 @@
 extern void calibrate_delay(void);
 
 extern volatile int smp_processors_ready;
-extern unsigned long cpu_present_map;
 extern int smp_num_cpus;
 static int smp_highest_cpu;
 extern int smp_threads_ready;
@@ -172,12 +171,12 @@
 		current_set[0] = NULL;
 
 	local_irq_enable();
-	cpu_present_map = 0;
+	cpus_clear(cpu_present_map);
 
 	/* XXX This whole thing has to go.  See sparc64. */
 	for (i = 0; !cpu_find_by_instance(i, NULL, &mid); i++)
-		cpu_present_map |= (1<<mid);
-	SMP_PRINTK(("cpu_present_map %08lx\n", cpu_present_map));
+		cpu_set(mid, cpu_present_map);
+	SMP_PRINTK(("cpu_present_map %08lx\n", cpus_addr(cpu_present_map)[0]));
 	for(i=0; i < NR_CPUS; i++)
 		__cpu_number_map[i] = -1;
 	for(i=0; i < NR_CPUS; i++)
@@ -195,7 +194,7 @@
 		if(i == boot_cpu_id)
 			continue;
 
-		if(cpu_present_map & (1 << i)) {
+		if (cpu_isset(i, cpu_present_map)) {
 			extern unsigned long sun4d_cpu_startup;
 			unsigned long *entry = &sun4d_cpu_startup;
 			struct task_struct *p;
@@ -252,19 +251,19 @@
 			}
 		}
 		if(!(cpu_callin_map[i])) {
-			cpu_present_map &= ~(1 << i);
+			cpu_clear(i, cpu_present_map);
 			__cpu_number_map[i] = -1;
 		}
 	}
 	local_flush_cache_all();
 	if(cpucount == 0) {
 		printk("Error: only one Processor found.\n");
-		cpu_present_map = (1 << hard_smp4d_processor_id());
+		cpu_present_map = cpumask_of_cpu(hard_smp4d_processor_id());
 	} else {
 		unsigned long bogosum = 0;
 		
 		for(i = 0; i < NR_CPUS; i++) {
-			if(cpu_present_map & (1 << i)) {
+			if (cpu_isset(i, cpu_present_map)) {
 				bogosum += cpu_data(i).udelay_val;
 				smp_highest_cpu = i;
 			}
@@ -344,12 +343,13 @@
 
 		/* Init receive/complete mapping, plus fire the IPI's off. */
 		{
-			register unsigned long mask;
+			cpumask_t mask;
 			register int i;
 
-			mask = (cpu_present_map & ~(1 << hard_smp4d_processor_id()));
+			mask = cpumask_of_cpu(hard_smp4d_processor_id());
+			cpus_andnot(mask, cpu_present_map, mask);
 			for(i = 0; i <= high; i++) {
-				if(mask & (1 << i)) {
+				if (cpu_isset(i, mask)) {
 					ccall_info.processors_in[i] = 0;
 					ccall_info.processors_out[i] = 0;
 					sun4d_send_ipi(i, IRQ_CROSS_CALL);
