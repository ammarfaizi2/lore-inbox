Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265923AbUFITv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265923AbUFITv4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 15:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265919AbUFITvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 15:51:55 -0400
Received: from holomorphy.com ([207.189.100.168]:48262 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265884AbUFITvC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 15:51:02 -0400
Date: Wed, 9 Jun 2004 12:50:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Cc: linux-alpha@vger.kernel.org
Subject: Re: 2.6.7-rc3-mm1
Message-ID: <20040609195057.GY1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org
References: <20040609015001.31d249ca.akpm@osdl.org> <20040609175910.GS1444@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040609175910.GS1444@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 10:59:10AM -0700, William Lee Irwin III wrote:
> Last time I tested this on sparc64 (the only current user of ->mask) it
> appeared to work. The following patch makes irqaction's ->mask a cpumask
> as it was intended to be and wraps up the rest of the sweep. Only struct
> irqaction is usefully greppable, so there may be some assignments to
> ->mask missing still. This removes more code than it adds.
> Compiletested i386 and sparc64, runtime tested on sparc64 in a prior
> incarnation. vs. 2.6.7-rc3-mm1

The cpumask patches broke alpha's build, even without the irqaction
patch, largely centering around cpu_possible_map. Atop irqaction.patch:


Index: mm1-2.6.7-rc3/include/asm-alpha/smp.h
===================================================================
--- mm1-2.6.7-rc3.orig/include/asm-alpha/smp.h	2004-06-07 12:15:11.000000000 -0700
+++ mm1-2.6.7-rc3/include/asm-alpha/smp.h	2004-06-09 14:19:58.000000000 -0700
@@ -50,9 +50,7 @@
 extern int smp_num_cpus;
 #define cpu_possible_map	cpu_present_mask
 
-#define cpu_online(cpu)		cpu_isset(cpu, cpu_online_map)
-
-extern int smp_call_function_on_cpu(void (*func) (void *info), void *info,int retry, int wait, unsigned long cpu);
+int smp_call_function_on_cpu(void (*func) (void *info), void *info,int retry, int wait, cpumask_t cpu);
 
 #else /* CONFIG_SMP */
 
Index: mm1-2.6.7-rc3/arch/alpha/kernel/irq.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/alpha/kernel/irq.c	2004-06-09 13:40:11.000000000 -0700
+++ mm1-2.6.7-rc3/arch/alpha/kernel/irq.c	2004-06-09 14:29:16.000000000 -0700
@@ -227,7 +227,7 @@
 #ifdef CONFIG_SMP 
 static struct proc_dir_entry * smp_affinity_entry[NR_IRQS];
 static char irq_user_affinity[NR_IRQS];
-static unsigned long irq_affinity[NR_IRQS] = { [0 ... NR_IRQS-1] = ~0UL };
+static cpumask_t irq_affinity[NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };
 
 static void
 select_smp_affinity(int irq)
@@ -238,16 +238,14 @@
 	if (! irq_desc[irq].handler->set_affinity || irq_user_affinity[irq])
 		return;
 
-	while (((cpu_present_mask >> cpu) & 1) == 0)
+	while (!cpu_possible(cpu))
 		cpu = (cpu < (NR_CPUS-1) ? cpu + 1 : 0);
 	last_cpu = cpu;
 
-	irq_affinity[irq] = 1UL << cpu;
-	irq_desc[irq].handler->set_affinity(irq, 1UL << cpu);
+	irq_affinity[irq] = cpumask_of_cpu(cpu);
+	irq_desc[irq].handler->set_affinity(irq, cpumask_of_cpu(cpu));
 }
 
-#define HEX_DIGITS 16
-
 static int
 irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
@@ -259,67 +257,28 @@
 	return len;
 }
 
-static unsigned int
-parse_hex_value (const char __user *buffer,
-		 unsigned long count, unsigned long *ret)
-{
-	unsigned char hexnum [HEX_DIGITS];
-	unsigned long value;
-	unsigned long i;
-
-	if (!count)
-		return -EINVAL;
-	if (count > HEX_DIGITS)
-		count = HEX_DIGITS;
-	if (copy_from_user(hexnum, buffer, count))
-		return -EFAULT;
-
-	/*
-	 * Parse the first 8 characters as a hex string, any non-hex char
-	 * is end-of-string. '00e1', 'e1', '00E1', 'E1' are all the same.
-	 */
-	value = 0;
-
-	for (i = 0; i < count; i++) {
-		unsigned int c = hexnum[i];
-
-		switch (c) {
-			case '0' ... '9': c -= '0'; break;
-			case 'a' ... 'f': c -= 'a'-10; break;
-			case 'A' ... 'F': c -= 'A'-10; break;
-		default:
-			goto out;
-		}
-		value = (value << 4) | c;
-	}
-out:
-	*ret = value;
-	return 0;
-}
-
 static int
 irq_affinity_write_proc(struct file *file, const char __user *buffer,
 			unsigned long count, void *data)
 {
 	int irq = (long) data, full_count = count, err;
-	unsigned long new_value;
+	cpumask_t new_value;
 
 	if (!irq_desc[irq].handler->set_affinity)
 		return -EIO;
 
-	err = parse_hex_value(buffer, count, &new_value);
+	err = cpumask_parse(buffer, count, new_value);
 
 	/* The special value 0 means release control of the
 	   affinity to kernel.  */
-	if (new_value == 0) {
+	cpus_and(new_value, new_value, cpu_online_map);
+	if (cpus_empty(new_value)) {
 		irq_user_affinity[irq] = 0;
 		select_smp_affinity(irq);
 	}
 	/* Do not allow disabling IRQs completely - it's a too easy
 	   way to make the system unusable accidentally :-) At least
 	   one online CPU still has to be targeted.  */
-	else if (!(new_value & cpu_present_mask))
-		return -EINVAL;
 	else {
 		irq_affinity[irq] = new_value;
 		irq_user_affinity[irq] = 1;
@@ -344,10 +303,10 @@
 prof_cpu_mask_write_proc(struct file *file, const char __user *buffer,
 			 unsigned long count, void *data)
 {
-	unsigned long *mask = (unsigned long *) data, full_count = count, err;
-	unsigned long new_value;
+	unsigned long full_count = count, err;
+	cpumask_t new_value, *mask = (cpumask_t *)data;
 
-	err = parse_hex_value(buffer, count, &new_value);
+	err = cpumask_parse(buffer, count, new_value);
 	if (err)
 		return err;
 
Index: mm1-2.6.7-rc3/arch/alpha/kernel/process.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/alpha/kernel/process.c	2004-06-07 12:14:58.000000000 -0700
+++ mm1-2.6.7-rc3/arch/alpha/kernel/process.c	2004-06-09 13:51:37.000000000 -0700
@@ -119,8 +119,8 @@
 
 #ifdef CONFIG_SMP
 	/* Wait for the secondaries to halt. */
-	clear_bit(boot_cpuid, &cpu_present_mask);
-	while (cpu_present_mask)
+	cpu_clear(boot_cpuid, cpu_possible_map);
+	while (cpus_weight(cpu_possible_map))
 		barrier();
 #endif
 
Index: mm1-2.6.7-rc3/arch/alpha/kernel/smp.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/alpha/kernel/smp.c	2004-06-07 12:14:02.000000000 -0700
+++ mm1-2.6.7-rc3/arch/alpha/kernel/smp.c	2004-06-09 14:32:40.000000000 -0700
@@ -68,7 +68,7 @@
 static int smp_secondary_alive __initdata = 0;
 
 /* Which cpus ids came online.  */
-unsigned long cpu_present_mask;
+cpumask_t cpu_present_mask;
 cpumask_t cpu_online_map;
 
 EXPORT_SYMBOL(cpu_online_map);
@@ -522,7 +522,7 @@
 		smp_num_probed = 1;
 		hwrpb_cpu_present_mask = (1UL << boot_cpuid);
 	}
-	cpu_present_mask = 1UL << boot_cpuid;
+	cpu_present_mask = cpumask_of_cpu(boot_cpuid);
 
 	printk(KERN_INFO "SMP: %d CPUs probed -- cpu_present_mask = %lx\n",
 	       smp_num_probed, hwrpb_cpu_present_mask);
@@ -547,7 +547,7 @@
 
 	/* Nothing to do on a UP box, or when told not to.  */
 	if (smp_num_probed == 1 || max_cpus == 0) {
-		cpu_present_mask = 1UL << boot_cpuid;
+		cpu_present_mask = cpumask_of_cpu(boot_cpuid);
 		printk(KERN_INFO "SMP mode deactivated.\n");
 		return;
 	}
@@ -562,7 +562,7 @@
 		if (((hwrpb_cpu_present_mask >> i) & 1) == 0)
 			continue;
 
-		cpu_present_mask |= 1UL << i;
+		cpu_set(i, cpu_possible_map);
 		cpu_count++;
 	}
 
@@ -597,7 +597,7 @@
 		if (cpu_online(cpu))
 			bogosum += cpu_data[cpu].loops_per_jiffy;
 	
-	printk(KERN_INFO "SMP: Total of %ld processors activated "
+	printk(KERN_INFO "SMP: Total of %d processors activated "
 	       "(%lu.%02lu BogoMIPS).\n",
 	       num_online_cpus(), 
 	       (bogosum + 2500) / (500000/HZ),
@@ -638,23 +638,17 @@
 
 
 static void
-send_ipi_message(unsigned long to_whom, enum ipi_message_type operation)
+send_ipi_message(cpumask_t to_whom, enum ipi_message_type operation)
 {
-	unsigned long i, set, n;
+	int i;
 
 	mb();
-	for (i = to_whom; i ; i &= ~set) {
-		set = i & -i;
-		n = __ffs(set);
-		set_bit(operation, &ipi_data[n].bits);
-	}
+	for_each_cpu_mask(i, to_whom)
+		set_bit(operation, &ipi_data[i].bits);
 
 	mb();
-	for (i = to_whom; i ; i &= ~set) {
-		set = i & -i;
-		n = __ffs(set);
-		wripir(n);
-	}
+	for_each_cpu_mask(i, to_whom)
+		wripir(i);
 }
 
 /* Structure and data for smp_call_function.  This is designed to 
@@ -784,13 +778,14 @@
 		printk(KERN_WARNING
 		       "smp_send_reschedule: Sending IPI to self.\n");
 #endif
-	send_ipi_message(1UL << cpu, IPI_RESCHEDULE);
+	send_ipi_message(cpumask_of_cpu(cpu), IPI_RESCHEDULE);
 }
 
 void
 smp_send_stop(void)
 {
-	unsigned long to_whom = cpu_present_mask & ~(1UL << smp_processor_id());
+	cpumask_t to_whom = cpu_possible_map;
+	cpu_clear(smp_processor_id(), to_whom);
 #ifdef DEBUG_IPI_MSG
 	if (hard_smp_processor_id() != boot_cpu_id)
 		printk(KERN_WARNING "smp_send_stop: Not on boot cpu.\n");
@@ -814,7 +809,7 @@
 
 int
 smp_call_function_on_cpu (void (*func) (void *info), void *info, int retry,
-			  int wait, unsigned long to_whom)
+			  int wait, cpumask_t to_whom)
 {
 	struct smp_call_struct data;
 	unsigned long timeout;
@@ -827,8 +822,8 @@
 	data.info = info;
 	data.wait = wait;
 
-	to_whom &= ~(1L << smp_processor_id());
-	num_cpus_to_call = hweight64(to_whom);
+	cpu_clear(smp_processor_id(), to_whom);
+	num_cpus_to_call = cpus_weight(to_whom);
 
 	atomic_set(&data.unstarted_count, num_cpus_to_call);
 	atomic_set(&data.unfinished_count, num_cpus_to_call);
Index: mm1-2.6.7-rc3/arch/alpha/kernel/setup.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/alpha/kernel/setup.c	2004-06-09 13:39:28.000000000 -0700
+++ mm1-2.6.7-rc3/arch/alpha/kernel/setup.c	2004-06-09 14:30:48.000000000 -0700
@@ -1245,9 +1245,9 @@
 		       platform_string(), nr_processors);
 
 #ifdef CONFIG_SMP
-	seq_printf(f, "cpus active\t\t: %ld\n"
+	seq_printf(f, "cpus active\t\t: %d\n"
 		      "cpu active mask\t\t: %016lx\n",
-		       num_online_cpus(), cpu_present_mask);
+		       num_online_cpus(), cpus_addr(cpu_possible_map)[0]);
 #endif
 
 	show_cache_size (f, "L1 Icache", alpha_l1i_cacheshape);
Index: mm1-2.6.7-rc3/arch/alpha/kernel/sys_dp264.c
===================================================================
--- mm1-2.6.7-rc3.orig/arch/alpha/kernel/sys_dp264.c	2004-06-07 12:14:01.000000000 -0700
+++ mm1-2.6.7-rc3/arch/alpha/kernel/sys_dp264.c	2004-06-09 14:41:07.000000000 -0700
@@ -53,7 +53,6 @@
 	register int bcpu = boot_cpuid;
 
 #ifdef CONFIG_SMP
-	register unsigned long cpm = cpu_present_mask;
 	volatile unsigned long *dim0, *dim1, *dim2, *dim3;
 	unsigned long mask0, mask1, mask2, mask3, dummy;
 
@@ -72,10 +71,10 @@
 	dim1 = &cchip->dim1.csr;
 	dim2 = &cchip->dim2.csr;
 	dim3 = &cchip->dim3.csr;
-	if ((cpm & 1) == 0) dim0 = &dummy;
-	if ((cpm & 2) == 0) dim1 = &dummy;
-	if ((cpm & 4) == 0) dim2 = &dummy;
-	if ((cpm & 8) == 0) dim3 = &dummy;
+	if (cpu_possible(0)) dim0 = &dummy;
+	if (cpu_possible(1)) dim1 = &dummy;
+	if (cpu_possible(2)) dim2 = &dummy;
+	if (cpu_possible(3)) dim3 = &dummy;
 
 	*dim0 = mask0;
 	*dim1 = mask1;
@@ -164,13 +163,13 @@
 }
 
 static void
-cpu_set_irq_affinity(unsigned int irq, unsigned long affinity)
+cpu_set_irq_affinity(unsigned int irq, cpumask_t affinity)
 {
 	int cpu;
 
 	for (cpu = 0; cpu < 4; cpu++) {
 		unsigned long aff = cpu_irq_affinity[cpu];
-		if (affinity & (1UL << cpu))
+		if (cpu_isset(cpu, affinity))
 			aff |= 1UL << irq;
 		else
 			aff &= ~(1UL << irq);
@@ -179,7 +178,7 @@
 }
 
 static void
-dp264_set_affinity(unsigned int irq, unsigned long affinity)
+dp264_set_affinity(unsigned int irq, cpumask_t affinity)
 { 
 	spin_lock(&dp264_irq_lock);
 	cpu_set_irq_affinity(irq, affinity);
@@ -188,7 +187,7 @@
 }
 
 static void
-clipper_set_affinity(unsigned int irq, unsigned long affinity)
+clipper_set_affinity(unsigned int irq, cpumask_t affinity)
 { 
 	spin_lock(&dp264_irq_lock);
 	cpu_set_irq_affinity(irq - 16, affinity);
