Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264140AbTDOWrg (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 18:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264142AbTDOWrg 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 18:47:36 -0400
Received: from holomorphy.com ([66.224.33.161]:1928 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264140AbTDOWrP 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 18:47:15 -0400
Date: Tue, 15 Apr 2003 15:58:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [cpumask_t 2/3] i386 changes for 2.5.67-bk6
Message-ID: <20030415225843.GI706@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030415225036.GE12487@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030415225036.GE12487@holomorphy.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 03:50:36PM -0700, William Lee Irwin III wrote:
> Core changes for extended cpu masks. Basically use a machine word

i386 changes for extended cpu masks. Basically force various things
that can possibly be used with NR_CPUS > BITS_PER_LONG in arch/i386
to pass typechecking and use the cpumask_t data type. For things that
simply can't be used with the larger systems, I use the cpus_coerce()
escape hatch to avoid things getting awkward.

Changes made only for flat logical tinySMP boxen and NUMA-Q; voyager
and "other" (not sure what "bigsmp" refers to) kind of got left out
since I don't really know my way around their code and I don't have
any systems of their kind to testboot on.


diff -urpN linux-2.5.67-bk6/arch/i386/kernel/apic.c cpu-2.5.67-bk6-1/arch/i386/kernel/apic.c
--- linux-2.5.67-bk6/arch/i386/kernel/apic.c	2003-04-07 10:33:02.000000000 -0700
+++ cpu-2.5.67-bk6-1/arch/i386/kernel/apic.c	2003-04-15 14:39:36.000000000 -0700
@@ -1136,7 +1136,8 @@ int __init APIC_init_uniprocessor (void)
 
 	connect_bsp_APIC();
 
-	phys_cpu_present_map = 1 << boot_cpu_physical_apicid;
+	cpus_clear(phys_cpu_present_map);
+	cpu_set(boot_cpu_physical_apicid, phys_cpu_present_map);
 
 	setup_local_APIC();
 
diff -urpN linux-2.5.67-bk6/arch/i386/kernel/cpu/proc.c cpu-2.5.67-bk6-1/arch/i386/kernel/cpu/proc.c
--- linux-2.5.67-bk6/arch/i386/kernel/cpu/proc.c	2003-04-07 10:32:29.000000000 -0700
+++ cpu-2.5.67-bk6-1/arch/i386/kernel/cpu/proc.c	2003-04-15 14:39:36.000000000 -0700
@@ -60,7 +60,7 @@ static int show_cpuinfo(struct seq_file 
 	int fpu_exception;
 
 #ifdef CONFIG_SMP
-	if (!(cpu_online_map & (1<<n)))
+	if (!cpu_online(n))
 		return 0;
 #endif
 	seq_printf(m, "processor\t: %d\n"
diff -urpN linux-2.5.67-bk6/arch/i386/kernel/io_apic.c cpu-2.5.67-bk6-1/arch/i386/kernel/io_apic.c
--- linux-2.5.67-bk6/arch/i386/kernel/io_apic.c	2003-04-15 14:37:51.000000000 -0700
+++ cpu-2.5.67-bk6-1/arch/i386/kernel/io_apic.c	2003-04-15 14:39:36.000000000 -0700
@@ -240,22 +240,22 @@ static void clear_IO_APIC (void)
 			clear_IO_APIC_pin(apic, pin);
 }
 
-static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
+static void set_ioapic_affinity (unsigned int irq, unsigned long dest)
 {
-	unsigned long flags;
+	unsigned long flags, regval = dest;
 	int pin;
 	struct irq_pin_list *entry = irq_2_pin + irq;
 
 	/*
 	 * Only the first 8 bits are valid.
 	 */
-	mask = mask << 24;
+	regval <<= 24;
 	spin_lock_irqsave(&ioapic_lock, flags);
 	for (;;) {
 		pin = entry->pin;
 		if (pin == -1)
 			break;
-		io_apic_write(entry->apic, 0x10 + 1 + pin*2, mask);
+		io_apic_write(entry->apic, 0x10 + 1 + pin*2, regval);
 		if (!entry->next)
 			break;
 		entry = irq_2_pin + entry->next;
@@ -277,7 +277,7 @@ static void set_ioapic_affinity (unsigne
 #  define Dprintk(x...) 
 # endif
 
-extern unsigned long irq_affinity[NR_IRQS];
+extern cpumask_t irq_affinity[NR_IRQS];
 
 static int __cacheline_aligned pending_irq_balance_apicid[NR_IRQS];
 static int irqbalance_disabled = NO_BALANCE_IRQ;
@@ -296,8 +296,7 @@ struct irq_cpu_info {
 #define IDLE_ENOUGH(cpu,now) \
 		(idle_cpu(cpu) && ((now) - irq_stat[(cpu)].idle_timestamp > 1))
 
-#define IRQ_ALLOWED(cpu,allowed_mask) \
-		((1 << cpu) & (allowed_mask))
+#define IRQ_ALLOWED(cpu, allowed_mask)	cpu_isset(cpu, allowed_mask)
 
 #define CPU_TO_PACKAGEINDEX(i) \
 		((physical_balance && i > cpu_sibling_map[i]) ? cpu_sibling_map[i] : i)
@@ -309,7 +308,7 @@ struct irq_cpu_info {
 
 long balanced_irq_interval = MAX_BALANCED_IRQ_INTERVAL;
 
-static unsigned long move(int curr_cpu, unsigned long allowed_mask,
+static unsigned long move(int curr_cpu, cpumask_t allowed_mask,
 			unsigned long now, int direction)
 {
 	int search_idle = 1;
@@ -339,13 +338,13 @@ inside:
 static inline void balance_irq(int cpu, int irq)
 {
 	unsigned long now = jiffies;
-	unsigned long allowed_mask;
+	cpumask_t allowed_mask;
 	unsigned int new_cpu;
 		
 	if (irqbalance_disabled)
 		return;
 
-	allowed_mask = cpu_online_map & irq_affinity[irq];
+	cpus_and(allowed_mask, cpu_online_map, irq_affinity[irq]);
 	new_cpu = move(cpu, allowed_mask, now, 1);
 	if (cpu != new_cpu) {
 		irq_desc_t *desc = irq_desc + irq;
@@ -388,8 +387,7 @@ static void do_irq_balance(void)
 	int tmp_loaded, first_attempt = 1;
 	unsigned long tmp_cpu_irq;
 	unsigned long imbalance = 0;
-	unsigned long allowed_mask;
-	unsigned long target_cpu_mask;
+	cpumask_t allowed_mask, target_cpu_mask, tmp;
 
 	for (i = 0; i < NR_CPUS; i++) {
 		int package_index;
@@ -538,10 +536,12 @@ tryanotherirq:
 					CPU_IRQ(cpu_sibling_map[min_loaded]))
 		min_loaded = cpu_sibling_map[min_loaded];
 
-	allowed_mask = cpu_online_map & irq_affinity[selected_irq];
-	target_cpu_mask = 1 << min_loaded;
+	cpus_and(allowed_mask, cpu_online_map, irq_affinity[selected_irq]);
+	cpus_clear(target_cpu_mask);
+	cpu_set(min_loaded, target_cpu_mask);
+	cpus_and(tmp, target_cpu_mask, allowed_mask);
 
-	if (target_cpu_mask & allowed_mask) {
+	if (!cpus_empty(tmp)) {
 		irq_desc_t *desc = irq_desc + selected_irq;
 		unsigned long flags;
 
@@ -601,12 +601,14 @@ static int __init balanced_irq_init(void
 {
 	int i;
 	struct cpuinfo_x86 *c;
+	cpumask_t tmp;
 
-        c = &boot_cpu_data;
+	cpus_shift_right(tmp, cpu_online_map, 2);
+	c = &boot_cpu_data;
 	if (irqbalance_disabled)
 		return 0;
 	
-	 /* disable irqbalance completely if there is only one processor online */
+	/* disable irqbalance completely if there is only one processor online */
 	if (num_online_cpus() < 2) {
 		irqbalance_disabled = 1;
 		return 0;
@@ -615,7 +617,7 @@ static int __init balanced_irq_init(void
 	 * Enable physical balance only if more than 1 physical processor
 	 * is present
 	 */
-	if (smp_num_siblings > 1 && cpu_online_map >> 2)
+	if (smp_num_siblings > 1 && !cpus_empty(tmp))
 		physical_balance = 1;
 
 	for (i = 0; i < NR_CPUS; i++) {
@@ -1570,6 +1572,10 @@ static void __init setup_ioapic_ids_from
 		/* This gets done during IOAPIC enumeration for ACPI. */
 		return;
 
+	/*
+	 * This is broken; anything with a real cpu count has to
+	 * circumvent this idiocy regardless.
+	 */
 	phys_id_present_map = ioapic_phys_id_map(phys_cpu_present_map);
 
 	/*
@@ -1597,8 +1603,9 @@ static void __init setup_ioapic_ids_from
 		 * system must have a unique ID or we get lots of nice
 		 * 'stuck on smp_invalidate_needed IPI wait' messages.
 		 */
-		if (check_apicid_used(phys_id_present_map,
-					mp_ioapics[apic].mpc_apicid)) {
+
+		/* MAJOR BRAINDAMAGE */
+		if (phys_id_present_map & (1UL << mp_ioapics[apic].mpc_apicid)) {
 			printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",
 				apic, mp_ioapics[apic].mpc_apicid);
 			for (i = 0; i < 0xf; i++)
@@ -2197,7 +2204,7 @@ int __init io_apic_get_unique_id (int io
 	 */
 
 	if (!apic_id_map)
-		apic_id_map = phys_cpu_present_map;
+		apic_id_map = ioapic_phys_id_map(phys_cpu_present_map);
 
 	spin_lock_irqsave(&ioapic_lock, flags);
 	*(int *)&reg_00 = io_apic_read(ioapic, 0);
diff -urpN linux-2.5.67-bk6/arch/i386/kernel/irq.c cpu-2.5.67-bk6-1/arch/i386/kernel/irq.c
--- linux-2.5.67-bk6/arch/i386/kernel/irq.c	2003-04-07 10:30:39.000000000 -0700
+++ cpu-2.5.67-bk6-1/arch/i386/kernel/irq.c	2003-04-15 14:39:36.000000000 -0700
@@ -42,9 +42,10 @@
 #include <asm/pgalloc.h>
 #include <asm/delay.h>
 #include <asm/desc.h>
+#include <asm/mpspec.h>
 #include <asm/irq.h>
 
-
+#include "mach_apic.h"
 
 /*
  * Linux has a controller-independent x86 interrupt architecture.
@@ -799,13 +800,13 @@ int setup_irq(unsigned int irq, struct i
 static struct proc_dir_entry * root_irq_dir;
 static struct proc_dir_entry * irq_dir [NR_IRQS];
 
-#define HEX_DIGITS 8
+#define HEX_DIGITS (2*sizeof(cpumask_t))
 
 static unsigned int parse_hex_value (const char *buffer,
-		unsigned long count, unsigned long *ret)
+		unsigned long count, cpumask_t *ret)
 {
 	unsigned char hexnum [HEX_DIGITS];
-	unsigned long value;
+	cpumask_t value = CPU_MASK_NONE;
 	int i;
 
 	if (!count)
@@ -819,10 +820,10 @@ static unsigned int parse_hex_value (con
 	 * Parse the first 8 characters as a hex string, any non-hex char
 	 * is end-of-string. '00e1', 'e1', '00E1', 'E1' are all the same.
 	 */
-	value = 0;
 
 	for (i = 0; i < count; i++) {
 		unsigned int c = hexnum[i];
+		int k;
 
 		switch (c) {
 			case '0' ... '9': c -= '0'; break;
@@ -831,7 +832,10 @@ static unsigned int parse_hex_value (con
 		default:
 			goto out;
 		}
-		value = (value << 4) | c;
+		cpus_shift_left(value, value, 4);
+		for (k = 0; k < 4; ++k)
+			if (test_bit(k, (unsigned long *)&c))
+				cpu_set(k, value);
 	}
 out:
 	*ret = value;
@@ -842,20 +846,31 @@ out:
 
 static struct proc_dir_entry * smp_affinity_entry [NR_IRQS];
 
-unsigned long irq_affinity [NR_IRQS] = { [0 ... NR_IRQS-1] = ~0UL };
+cpumask_t irq_affinity [NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };
 static int irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
+	int k, len;
+	cpumask_t tmp = irq_affinity[(long)data];
+
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
-	return sprintf (page, "%08lx\n", irq_affinity[(long)data]);
+
+	len = 0;
+	for (k = 0; k < sizeof(cpumask_t)/sizeof(unsigned long); ++k) {
+		int j = sprintf (page, "%08lx\n", cpus_coerce(tmp));
+		cpus_shift_right(tmp, tmp, BITS_PER_LONG);
+		len  += j;
+		page += j;
+	}
+	return len;
 }
 
 static int irq_affinity_write_proc (struct file *file, const char *buffer,
 					unsigned long count, void *data)
 {
 	int irq = (long) data, full_count = count, err;
-	unsigned long new_value;
+	cpumask_t new_value, tmp;
 
 	if (!irq_desc[irq].handler->set_affinity)
 		return -EIO;
@@ -867,11 +882,12 @@ static int irq_affinity_write_proc (stru
 	 * way to make the system unusable accidentally :-) At least
 	 * one online CPU still has to be targeted.
 	 */
-	if (!(new_value & cpu_online_map))
+	cpus_and(tmp, new_value, cpu_online_map);
+	if (cpus_empty(tmp))
 		return -EINVAL;
 
 	irq_affinity[irq] = new_value;
-	irq_desc[irq].handler->set_affinity(irq, new_value);
+	irq_desc[irq].handler->set_affinity(irq, cpu_to_logical_apicid(first_cpu(new_value)));
 
 	return full_count;
 }
@@ -890,8 +906,9 @@ static int prof_cpu_mask_read_proc (char
 static int prof_cpu_mask_write_proc (struct file *file, const char *buffer,
 					unsigned long count, void *data)
 {
-	unsigned long *mask = (unsigned long *) data, full_count = count, err;
-	unsigned long new_value;
+	cpumask_t *mask = (cpumask_t *)data;
+	unsigned long full_count = count, err;
+	cpumask_t new_value;
 
 	err = parse_hex_value(buffer, count, &new_value);
 	if (err)
diff -urpN linux-2.5.67-bk6/arch/i386/kernel/ldt.c cpu-2.5.67-bk6-1/arch/i386/kernel/ldt.c
--- linux-2.5.67-bk6/arch/i386/kernel/ldt.c	2003-04-07 10:32:15.000000000 -0700
+++ cpu-2.5.67-bk6-1/arch/i386/kernel/ldt.c	2003-04-15 14:39:36.000000000 -0700
@@ -56,9 +56,11 @@ static int alloc_ldt(mm_context_t *pc, i
 
 	if (reload) {
 #ifdef CONFIG_SMP
+		cpumask_t tmp = CPU_MASK_NONE;
 		preempt_disable();
+		cpu_set(smp_processor_id(), tmp);
 		load_LDT(pc);
-		if (current->mm->cpu_vm_mask != (1 << smp_processor_id()))
+		if (!cpu_isset(smp_processor_id(), current->mm->cpu_vm_mask))
 			smp_call_function(flush_ldt, 0, 1, 1);
 		preempt_enable();
 #else
diff -urpN linux-2.5.67-bk6/arch/i386/kernel/mpparse.c cpu-2.5.67-bk6-1/arch/i386/kernel/mpparse.c
--- linux-2.5.67-bk6/arch/i386/kernel/mpparse.c	2003-04-07 10:31:00.000000000 -0700
+++ cpu-2.5.67-bk6-1/arch/i386/kernel/mpparse.c	2003-04-15 14:39:36.000000000 -0700
@@ -70,7 +70,7 @@ unsigned int boot_cpu_logical_apicid = -
 static unsigned int __initdata num_processors;
 
 /* Bitmask of physically existing CPUs */
-unsigned long phys_cpu_present_map;
+cpumask_t phys_cpu_present_map;
 
 int x86_summit = 0;
 u8 bios_cpu_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
@@ -106,6 +106,7 @@ static struct mpc_config_translation *tr
 void __init MP_processor_info (struct mpc_config_processor *m)
 {
  	int ver, apicid;
+	cpumask_t tmp;
  	
 	if (!(m->mpc_cpuflag & CPU_ENABLED))
 		return;
@@ -176,7 +177,8 @@ void __init MP_processor_info (struct mp
 	}
 	ver = m->mpc_apicver;
 
-	phys_cpu_present_map |= apicid_to_cpu_present(apicid);
+	tmp = apicid_to_cpu_present(apicid);
+	cpus_or(phys_cpu_present_map, phys_cpu_present_map, tmp);
 	
 	/*
 	 * Validate version
diff -urpN linux-2.5.67-bk6/arch/i386/kernel/reboot.c cpu-2.5.67-bk6-1/arch/i386/kernel/reboot.c
--- linux-2.5.67-bk6/arch/i386/kernel/reboot.c	2003-04-07 10:30:59.000000000 -0700
+++ cpu-2.5.67-bk6-1/arch/i386/kernel/reboot.c	2003-04-15 14:39:36.000000000 -0700
@@ -226,7 +226,7 @@ void machine_restart(char * __unused)
 		   if its not, default to the BSP */
 		if ((reboot_cpu == -1) ||  
 		      (reboot_cpu > (NR_CPUS -1))  || 
-		      !(phys_cpu_present_map & (1<<cpuid))) 
+		      !(cpu_isset(cpuid, phys_cpu_present_map)))
 			reboot_cpu = boot_cpu_physical_apicid;
 
 		reboot_smp = 0;  /* use this as a flag to only go through this once*/
diff -urpN linux-2.5.67-bk6/arch/i386/kernel/smp.c cpu-2.5.67-bk6-1/arch/i386/kernel/smp.c
--- linux-2.5.67-bk6/arch/i386/kernel/smp.c	2003-04-07 10:30:40.000000000 -0700
+++ cpu-2.5.67-bk6-1/arch/i386/kernel/smp.c	2003-04-15 14:39:36.000000000 -0700
@@ -155,10 +155,14 @@ void send_IPI_self(int vector)
 	__send_IPI_shortcut(APIC_DEST_SELF, vector);
 }
 
-static inline void send_IPI_mask_bitmask(int mask, int vector)
+/*
+ * This is only used on smaller machines.
+ */
+static inline void send_IPI_mask_bitmask(cpumask_t cpumask, int vector)
 {
 	unsigned long cfg;
 	unsigned long flags;
+	unsigned long mask = cpus_coerce(cpumask);
 
 	local_irq_save(flags);
 		
@@ -186,10 +190,10 @@ static inline void send_IPI_mask_bitmask
 	local_irq_restore(flags);
 }
 
-static inline void send_IPI_mask_sequence(int mask, int vector)
+static inline void send_IPI_mask_sequence(cpumask_t mask, int vector)
 {
 	unsigned long cfg, flags;
-	unsigned int query_cpu, query_mask;
+	unsigned int query_cpu;
 
 	/*
 	 * Hack. The clustered APIC addressing mode doesn't allow us to send 
@@ -200,8 +204,7 @@ static inline void send_IPI_mask_sequenc
 	local_irq_save(flags);
 
 	for (query_cpu = 0; query_cpu < NR_CPUS; ++query_cpu) {
-		query_mask = 1 << query_cpu;
-		if (query_mask & mask) {
+		if (cpu_isset(query_cpu, mask)) {
 		
 			/*
 			 * Wait for idle.
@@ -238,7 +241,7 @@ static inline void send_IPI_mask_sequenc
  *	Optimizations Manfred Spraul <manfred@colorfullife.com>
  */
 
-static volatile unsigned long flush_cpumask;
+static volatile cpumask_t flush_cpumask;
 static struct mm_struct * flush_mm;
 static unsigned long flush_va;
 static spinlock_t tlbstate_lock = SPIN_LOCK_UNLOCKED;
@@ -255,7 +258,7 @@ static inline void leave_mm (unsigned lo
 {
 	if (cpu_tlbstate[cpu].state == TLBSTATE_OK)
 		BUG();
-	clear_bit(cpu, &cpu_tlbstate[cpu].active_mm->cpu_vm_mask);
+	cpu_clear(cpu, cpu_tlbstate[cpu].active_mm->cpu_vm_mask);
 	load_cr3(swapper_pg_dir);
 }
 
@@ -311,7 +314,7 @@ asmlinkage void smp_invalidate_interrupt
 
 	cpu = get_cpu();
 
-	if (!test_bit(cpu, &flush_cpumask))
+	if (!cpu_isset(cpu, flush_cpumask))
 		goto out;
 		/* 
 		 * This was a BUG() but until someone can quote me the
@@ -332,15 +335,17 @@ asmlinkage void smp_invalidate_interrupt
 			leave_mm(cpu);
 	}
 	ack_APIC_irq();
-	clear_bit(cpu, &flush_cpumask);
-
+	smp_mb__before_clear_bit();
+	cpu_clear(cpu, flush_cpumask);
+	smp_mb__after_clear_bit();
 out:
 	put_cpu_no_resched();
 }
 
-static void flush_tlb_others (unsigned long cpumask, struct mm_struct *mm,
+static void flush_tlb_others(cpumask_t cpumask, struct mm_struct *mm,
 						unsigned long va)
 {
+	cpumask_t tmp;
 	/*
 	 * A couple of (to be removed) sanity checks:
 	 *
@@ -348,14 +353,12 @@ static void flush_tlb_others (unsigned l
 	 * - current CPU must not be in mask
 	 * - mask must exist :)
 	 */
-	if (!cpumask)
-		BUG();
-	if ((cpumask & cpu_online_map) != cpumask)
-		BUG();
-	if (cpumask & (1 << smp_processor_id()))
-		BUG();
-	if (!mm)
-		BUG();
+	BUG_ON(cpus_empty(cpumask));
+
+	cpus_and(tmp, cpumask, cpu_online_map);
+	BUG_ON(!cpus_equal(cpumask, tmp));
+	BUG_ON(cpu_isset(smp_processor_id(), cpumask));
+	BUG_ON(!mm);
 
 	/*
 	 * i'm not happy about this global shared spinlock in the
@@ -367,15 +370,21 @@ static void flush_tlb_others (unsigned l
 	
 	flush_mm = mm;
 	flush_va = va;
-	atomic_set_mask(cpumask, &flush_cpumask);
+	/*
+	 * Probably introduced a bug here. This was:
+	 * atomic_set_mask(cpumask, &flush_cpumask);
+	 */
+	flush_cpumask = cpumask;
+	mb();
 	/*
 	 * We have to send the IPI only to
 	 * CPUs affected.
 	 */
 	send_IPI_mask(cpumask, INVALIDATE_TLB_VECTOR);
 
-	while (flush_cpumask)
-		/* nothing. lockup detection does not belong here */;
+	while (!cpus_empty(flush_cpumask))
+		/* nothing. lockup detection does not belong here */
+		mb();
 
 	flush_mm = NULL;
 	flush_va = 0;
@@ -385,23 +394,25 @@ static void flush_tlb_others (unsigned l
 void flush_tlb_current_task(void)
 {
 	struct mm_struct *mm = current->mm;
-	unsigned long cpu_mask;
+	cpumask_t cpu_mask;
 
 	preempt_disable();
-	cpu_mask = mm->cpu_vm_mask & ~(1UL << smp_processor_id());
+	cpu_mask = mm->cpu_vm_mask;
+	cpu_clear(smp_processor_id(), cpu_mask);
 
 	local_flush_tlb();
-	if (cpu_mask)
+	if (!cpus_empty(cpu_mask))
 		flush_tlb_others(cpu_mask, mm, FLUSH_ALL);
 	preempt_enable();
 }
 
 void flush_tlb_mm (struct mm_struct * mm)
 {
-	unsigned long cpu_mask;
+	cpumask_t cpu_mask;
 
 	preempt_disable();
-	cpu_mask = mm->cpu_vm_mask & ~(1UL << smp_processor_id());
+	cpu_mask = mm->cpu_vm_mask;
+	cpu_clear(smp_processor_id(), cpu_mask);
 
 	if (current->active_mm == mm) {
 		if (current->mm)
@@ -409,7 +420,7 @@ void flush_tlb_mm (struct mm_struct * mm
 		else
 			leave_mm(smp_processor_id());
 	}
-	if (cpu_mask)
+	if (!cpus_empty(cpu_mask))
 		flush_tlb_others(cpu_mask, mm, FLUSH_ALL);
 
 	preempt_enable();
@@ -418,10 +429,11 @@ void flush_tlb_mm (struct mm_struct * mm
 void flush_tlb_page(struct vm_area_struct * vma, unsigned long va)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long cpu_mask;
+	cpumask_t cpu_mask;
 
 	preempt_disable();
-	cpu_mask = mm->cpu_vm_mask & ~(1UL << smp_processor_id());
+	cpu_mask = mm->cpu_vm_mask;
+	cpu_clear(smp_processor_id(), cpu_mask);
 
 	if (current->active_mm == mm) {
 		if(current->mm)
@@ -430,7 +442,7 @@ void flush_tlb_page(struct vm_area_struc
 		 	leave_mm(smp_processor_id());
 	}
 
-	if (cpu_mask)
+	if (!cpus_empty(cpu_mask))
 		flush_tlb_others(cpu_mask, mm, va);
 
 	preempt_enable();
@@ -457,7 +469,9 @@ void flush_tlb_all(void)
  */
 void smp_send_reschedule(int cpu)
 {
-	send_IPI_mask(1 << cpu, RESCHEDULE_VECTOR);
+	cpumask_t cpumask = CPU_MASK_NONE;
+	cpu_set(cpu, cpumask);
+	send_IPI_mask(cpumask, RESCHEDULE_VECTOR);
 }
 
 /*
@@ -544,7 +558,7 @@ static void stop_this_cpu (void * dummy)
 	/*
 	 * Remove this CPU:
 	 */
-	clear_bit(smp_processor_id(), &cpu_online_map);
+	cpu_clear(smp_processor_id(), cpu_online_map);
 	local_irq_disable();
 	disable_local_APIC();
 	if (cpu_data[smp_processor_id()].hlt_works_ok)
diff -urpN linux-2.5.67-bk6/arch/i386/kernel/smpboot.c cpu-2.5.67-bk6-1/arch/i386/kernel/smpboot.c
--- linux-2.5.67-bk6/arch/i386/kernel/smpboot.c	2003-04-15 14:37:51.000000000 -0700
+++ cpu-2.5.67-bk6-1/arch/i386/kernel/smpboot.c	2003-04-15 14:39:36.000000000 -0700
@@ -62,11 +62,11 @@ int smp_num_siblings = 1;
 int phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
 
 /* Bitmask of currently online CPUs */
-unsigned long cpu_online_map;
+cpumask_t cpu_online_map;
 
-static volatile unsigned long cpu_callin_map;
-volatile unsigned long cpu_callout_map;
-static unsigned long smp_commenced_mask;
+static volatile cpumask_t cpu_callin_map;
+volatile cpumask_t cpu_callout_map;
+static cpumask_t smp_commenced_mask;
 
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
@@ -268,7 +268,7 @@ static void __init synchronize_tsc_bp (v
 
 	sum = 0;
 	for (i = 0; i < NR_CPUS; i++) {
-		if (test_bit(i, &cpu_callout_map)) {
+		if (cpu_isset(i, cpu_callout_map)) {
 			t0 = tsc_values[i];
 			sum += t0;
 		}
@@ -277,7 +277,7 @@ static void __init synchronize_tsc_bp (v
 
 	sum = 0;
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!test_bit(i, &cpu_callout_map))
+		if (!cpu_isset(i, cpu_callout_map))
 			continue;
 		delta = tsc_values[i] - avg;
 		if (delta < 0)
@@ -353,7 +353,7 @@ void __init smp_callin(void)
 	 */
 	phys_id = GET_APIC_ID(apic_read(APIC_ID));
 	cpuid = smp_processor_id();
-	if (test_bit(cpuid, &cpu_callin_map)) {
+	if (cpu_isset(cpuid, cpu_callin_map)) {
 		printk("huh, phys CPU#%d, CPU#%d already present??\n",
 					phys_id, cpuid);
 		BUG();
@@ -376,7 +376,7 @@ void __init smp_callin(void)
 		/*
 		 * Has the boot CPU finished it's STARTUP sequence?
 		 */
-		if (test_bit(cpuid, &cpu_callout_map))
+		if (cpu_isset(cpuid, cpu_callout_map))
 			break;
 		rep_nop();
 	}
@@ -417,7 +417,7 @@ void __init smp_callin(void)
 	/*
 	 * Allow the master to continue.
 	 */
-	set_bit(cpuid, &cpu_callin_map);
+	cpu_set(cpuid, cpu_callin_map);
 
 	/*
 	 *      Synchronize the TSC with the BP
@@ -442,7 +442,7 @@ int __init start_secondary(void *unused)
 	 */
 	cpu_init();
 	smp_callin();
-	while (!test_bit(smp_processor_id(), &smp_commenced_mask))
+	while (!cpu_isset(smp_processor_id(), smp_commenced_mask))
 		rep_nop();
 	setup_secondary_APIC_clock();
 	if (nmi_watchdog == NMI_IO_APIC) {
@@ -456,7 +456,7 @@ int __init start_secondary(void *unused)
 	 * the local TLBs too.
 	 */
 	local_flush_tlb();
-	set_bit(smp_processor_id(), &cpu_online_map);
+	cpu_set(smp_processor_id(), cpu_online_map);
 	wmb();
 	return cpu_idle();
 }
@@ -499,8 +499,8 @@ static struct task_struct * __init fork_
 #ifdef CONFIG_NUMA
 
 /* which logical CPUs are on which nodes */
-volatile unsigned long node_2_cpu_mask[MAX_NR_NODES] = 
-						{ [0 ... MAX_NR_NODES-1] = 0 };
+volatile cpumask_t node_2_cpu_mask[MAX_NR_NODES] = 
+				{ [0 ... MAX_NR_NODES-1] = CPU_MASK_NONE };
 /* which node each logical CPU is on */
 volatile int cpu_2_node[NR_CPUS] = { [0 ... NR_CPUS-1] = 0 };
 
@@ -508,7 +508,7 @@ volatile int cpu_2_node[NR_CPUS] = { [0 
 static inline void map_cpu_to_node(int cpu, int node)
 {
 	printk("Mapping cpu %d to node %d\n", cpu, node);
-	node_2_cpu_mask[node] |= (1 << cpu);
+	cpu_set(cpu, node_2_cpu_mask[node]);
 	cpu_2_node[cpu] = node;
 }
 
@@ -519,7 +519,7 @@ static inline void unmap_cpu_to_node(int
 
 	printk("Unmapping cpu %d from all nodes\n", cpu);
 	for (node = 0; node < MAX_NR_NODES; node ++)
-		node_2_cpu_mask[node] &= ~(1 << cpu);
+		cpu_clear(cpu, node_2_cpu_mask[node]);
 	cpu_2_node[cpu] = -1;
 }
 #else /* !CONFIG_NUMA */
@@ -770,7 +770,7 @@ wakeup_secondary_cpu(int phys_apicid, un
 }
 #endif	/* WAKE_SECONDARY_VIA_INIT */
 
-extern unsigned long cpu_initialized;
+extern cpumask_t cpu_initialized;
 
 static int __init do_boot_cpu(int apicid)
 /*
@@ -835,19 +835,19 @@ static int __init do_boot_cpu(int apicid
 		 * allow APs to start initializing.
 		 */
 		Dprintk("Before Callout %d.\n", cpu);
-		set_bit(cpu, &cpu_callout_map);
+		cpu_set(cpu, cpu_callout_map);
 		Dprintk("After Callout %d.\n", cpu);
 
 		/*
 		 * Wait 5s total for a response
 		 */
 		for (timeout = 0; timeout < 50000; timeout++) {
-			if (test_bit(cpu, &cpu_callin_map))
+			if (cpu_isset(cpu, cpu_callin_map))
 				break;	/* It has booted */
 			udelay(100);
 		}
 
-		if (test_bit(cpu, &cpu_callin_map)) {
+		if (cpu_isset(cpu, cpu_callin_map)) {
 			/* number CPUs logically, starting from 1 (BSP is 0) */
 			Dprintk("OK.\n");
 			printk("CPU%d: ", cpu);
@@ -868,8 +868,8 @@ static int __init do_boot_cpu(int apicid
 	if (boot_error) {
 		/* Try to put things back the way they were before ... */
 		unmap_cpu_to_logical_apicid(cpu);
-		clear_bit(cpu, &cpu_callout_map); /* was set here (do_boot_cpu()) */
-		clear_bit(cpu, &cpu_initialized); /* was set by cpu_init() */
+		cpu_clear(cpu, cpu_callout_map); /* was set here (do_boot_cpu()) */
+		cpu_clear(cpu, cpu_initialized); /* was set by cpu_init() */
 		cpucount--;
 	}
 
@@ -956,7 +956,8 @@ static void __init smp_boot_cpus(unsigne
 	if (!smp_found_config) {
 		printk(KERN_NOTICE "SMP motherboard not detected.\n");
 		smpboot_clear_io_apic_irqs();
-		phys_cpu_present_map = 1;
+		cpus_clear(phys_cpu_present_map);
+		cpu_set(1, phys_cpu_present_map);
 		if (APIC_init_uniprocessor())
 			printk(KERN_NOTICE "Local APIC not detected."
 					   " Using dummy APIC emulation.\n");
@@ -972,7 +973,7 @@ static void __init smp_boot_cpus(unsigne
 	if (!check_phys_apicid_present(boot_cpu_physical_apicid)) {
 		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
 				boot_cpu_physical_apicid);
-		phys_cpu_present_map |= (1 << hard_smp_processor_id());
+		cpu_set(hard_smp_processor_id(), phys_cpu_present_map);
 	}
 
 	/*
@@ -983,7 +984,8 @@ static void __init smp_boot_cpus(unsigne
 			boot_cpu_physical_apicid);
 		printk(KERN_ERR "... forcing use of dummy APIC emulation. (tell your hw vendor)\n");
 		smpboot_clear_io_apic_irqs();
-		phys_cpu_present_map = 1;
+		cpus_clear(phys_cpu_present_map);
+		cpu_set(1, phys_cpu_present_map);
 		return;
 	}
 
@@ -996,7 +998,7 @@ static void __init smp_boot_cpus(unsigne
 		smp_found_config = 0;
 		printk(KERN_INFO "SMP mode deactivated, forcing use of dummy APIC emulation.\n");
 		smpboot_clear_io_apic_irqs();
-		phys_cpu_present_map = 1;
+		cpus_clear(phys_cpu_present_map);
 		return;
 	}
 
@@ -1051,7 +1053,7 @@ static void __init smp_boot_cpus(unsigne
 	} else {
 		unsigned long bogosum = 0;
 		for (cpu = 0; cpu < NR_CPUS; cpu++)
-			if (cpu_callout_map & (1<<cpu))
+			if (cpu_isset(cpu, cpu_callout_map))
 				bogosum += cpu_data[cpu].loops_per_jiffy;
 		printk(KERN_INFO "Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
 			cpucount+1,
@@ -1083,10 +1085,10 @@ static void __init smp_boot_cpus(unsigne
 		
 		for (cpu = 0; cpu < NR_CPUS; cpu++) {
 			int 	i;
-			if (!test_bit(cpu, &cpu_callout_map)) continue;
+			if (!cpu_isset(cpu, cpu_callout_map)) continue;
 
 			for (i = 0; i < NR_CPUS; i++) {
-				if (i == cpu || !test_bit(i, &cpu_callout_map))
+				if (i == cpu || !cpu_isset(i, cpu_callout_map))
 					continue;
 				if (phys_proc_id[cpu] == phys_proc_id[i]) {
 					cpu_sibling_map[cpu] = i;
@@ -1121,28 +1123,28 @@ void __init smp_prepare_cpus(unsigned in
 
 void __devinit smp_prepare_boot_cpu(void)
 {
-	set_bit(smp_processor_id(), &cpu_online_map);
-	set_bit(smp_processor_id(), &cpu_callout_map);
+	cpu_set(smp_processor_id(), cpu_online_map);
+	cpu_set(smp_processor_id(), cpu_callout_map);
 }
 
 int __devinit __cpu_up(unsigned int cpu)
 {
 	/* This only works at boot for x86.  See "rewrite" above. */
-	if (test_bit(cpu, &smp_commenced_mask)) {
+	if (cpu_isset(cpu, smp_commenced_mask)) {
 		local_irq_enable();
 		return -ENOSYS;
 	}
 
 	/* In case one didn't come up */
-	if (!test_bit(cpu, &cpu_callin_map)) {
+	if (!cpu_isset(cpu, cpu_callin_map)) {
 		local_irq_enable();
 		return -EIO;
 	}
 
 	local_irq_enable();
 	/* Unleash the CPU! */
-	set_bit(cpu, &smp_commenced_mask);
-	while (!test_bit(cpu, &cpu_online_map))
+	cpu_set(cpu, smp_commenced_mask);
+	while (!cpu_isset(cpu, cpu_online_map))
 		mb();
 	return 0;
 }
diff -urpN linux-2.5.67-bk6/include/asm-i386/highmem.h cpu-2.5.67-bk6-1/include/asm-i386/highmem.h
--- linux-2.5.67-bk6/include/asm-i386/highmem.h	2003-04-07 10:30:41.000000000 -0700
+++ cpu-2.5.67-bk6-1/include/asm-i386/highmem.h	2003-04-15 14:39:40.000000000 -0700
@@ -22,6 +22,7 @@
 
 #include <linux/config.h>
 #include <linux/interrupt.h>
+#include <linux/threads.h>
 #include <asm/kmap_types.h>
 #include <asm/tlbflush.h>
 
@@ -39,7 +40,12 @@ extern void kmap_init(void);
  * easily, subsequent pte tables have to be allocated in one physical
  * chunk of RAM.
  */
+#if NR_CPUS <= 32
 #define PKMAP_BASE (0xff800000UL)
+#else
+#define PKMAP_BASE (0xff600000UL)
+#endif
+
 #ifdef CONFIG_X86_PAE
 #define LAST_PKMAP 512
 #else
diff -urpN linux-2.5.67-bk6/include/asm-i386/mach-default/mach_apic.h cpu-2.5.67-bk6-1/include/asm-i386/mach-default/mach_apic.h
--- linux-2.5.67-bk6/include/asm-i386/mach-default/mach_apic.h	2003-04-07 10:33:02.000000000 -0700
+++ cpu-2.5.67-bk6-1/include/asm-i386/mach-default/mach_apic.h	2003-04-15 14:39:40.000000000 -0700
@@ -3,8 +3,12 @@
 
 #define APIC_DFR_VALUE	(APIC_DFR_FLAT)
 
+/*
+ * Flat mode can't support large numbers of cpus.
+ * The first word of cpu_online_map should cover us.
+ */
 #ifdef CONFIG_SMP
- #define TARGET_CPUS (cpu_online_map)
+ #define TARGET_CPUS cpus_coerce(cpu_online_map)
 #else
  #define TARGET_CPUS 0x01
 #endif
@@ -17,12 +21,13 @@
 
 #define APIC_BROADCAST_ID      0x0F
 #define check_apicid_used(bitmap, apicid) (bitmap & (1 << apicid))
-#define check_apicid_present(bit) (phys_cpu_present_map & (1 << bit))
+#define check_apicid_present(bit) cpu_isset(bit, phys_cpu_present_map)
 
+#if defined(CONFIG_X86_LOCAL_APIC) || defined(CONFIG_X86_UP_APIC)
 static inline int apic_id_registered(void)
 {
-	return (test_bit(GET_APIC_ID(apic_read(APIC_ID)), 
-						&phys_cpu_present_map));
+	return cpu_isset(GET_APIC_ID(apic_read(APIC_ID)),
+				phys_cpu_present_map);
 }
 
 /*
@@ -41,10 +46,14 @@ static inline void init_apic_ldr(void)
 	val |= SET_APIC_LOGICAL_ID(1UL << smp_processor_id());
 	apic_write_around(APIC_LDR, val);
 }
+#endif
 
-static inline ulong ioapic_phys_id_map(ulong phys_map)
+/*
+ * Only small machines use this APIC mode.
+ */
+static inline unsigned long ioapic_phys_id_map(cpumask_t phys_map)
 {
-	return phys_map;
+	return cpus_coerce(phys_map);
 }
 
 static inline void clustered_apic_check(void)
@@ -74,9 +83,12 @@ static inline int cpu_present_to_apicid(
 	return  mps_cpu;
 }
 
-static inline unsigned long apicid_to_cpu_present(int phys_apicid)
+static inline cpumask_t apicid_to_cpu_present(int phys_apicid)
 {
-	return (1ul << phys_apicid);
+	cpumask_t mask;
+	cpus_clear(mask);
+	cpu_set(phys_apicid, mask);
+	return mask;
 }
 
 static inline int mpc_apic_id(struct mpc_config_processor *m, 
@@ -96,7 +108,7 @@ static inline void setup_portio_remap(vo
 
 static inline int check_phys_apicid_present(int boot_cpu_physical_apicid)
 {
-	return test_bit(boot_cpu_physical_apicid, &phys_cpu_present_map);
+	return cpu_isset(boot_cpu_physical_apicid, phys_cpu_present_map);
 }
 
 #endif /* __ASM_MACH_APIC_H */
diff -urpN linux-2.5.67-bk6/include/asm-i386/mach-default/mach_ipi.h cpu-2.5.67-bk6-1/include/asm-i386/mach-default/mach_ipi.h
--- linux-2.5.67-bk6/include/asm-i386/mach-default/mach_ipi.h	2003-04-07 10:32:30.000000000 -0700
+++ cpu-2.5.67-bk6-1/include/asm-i386/mach-default/mach_ipi.h	2003-04-15 14:39:40.000000000 -0700
@@ -1,10 +1,10 @@
 #ifndef __ASM_MACH_IPI_H
 #define __ASM_MACH_IPI_H
 
-static inline void send_IPI_mask_bitmask(int mask, int vector);
+static inline void send_IPI_mask_bitmask(cpumask_t cpumask, int vector);
 static inline void __send_IPI_shortcut(unsigned int shortcut, int vector);
 
-static inline void send_IPI_mask(int mask, int vector)
+static inline void send_IPI_mask(cpumask_t mask, int vector)
 {
 	send_IPI_mask_bitmask(mask, vector);
 }
diff -urpN linux-2.5.67-bk6/include/asm-i386/mach-numaq/mach_apic.h cpu-2.5.67-bk6-1/include/asm-i386/mach-numaq/mach_apic.h
--- linux-2.5.67-bk6/include/asm-i386/mach-numaq/mach_apic.h	2003-04-07 10:31:08.000000000 -0700
+++ cpu-2.5.67-bk6-1/include/asm-i386/mach-numaq/mach_apic.h	2003-04-15 14:39:40.000000000 -0700
@@ -12,12 +12,12 @@
 #define INT_DEST_MODE 0     /* physical delivery on LOCAL quad */
  
 #define APIC_BROADCAST_ID      0x0F
-#define check_apicid_used(bitmap, apicid) ((bitmap) & (1 << (apicid)))
-#define check_apicid_present(bit) (phys_cpu_present_map & (1 << bit))
+#define check_apicid_used(bitmap, apicid) cpu_isset(apicid, bitmap)
+#define check_apicid_present(bit)	cpu_isset(bit, phys_cpu_present_map)
 
 static inline int apic_id_registered(void)
 {
-	return (1);
+	return 1;
 }
 
 static inline void init_apic_ldr(void)
@@ -40,10 +40,10 @@ static inline int multi_timer_check(int 
 	return (apic != 0 && irq == 0);
 }
 
-static inline ulong ioapic_phys_id_map(ulong phys_map)
+static inline unsigned long ioapic_phys_id_map(cpumask_t phys_map)
 {
 	/* We don't have a good way to do this yet - hack */
-	return 0xf;
+	return 0xFUL;
 }
 
 /* Mapping from cpu number to logical apicid */
@@ -68,9 +68,14 @@ static inline int apicid_to_node(int log
 	return (logical_apicid >> 4);
 }
 
-static inline unsigned long apicid_to_cpu_present(int logical_apicid)
+static inline cpumask_t apicid_to_cpu_present(int logical_apicid)
 {
-	return ( (logical_apicid&0xf) << (4*apicid_to_node(logical_apicid)) );
+	cpumask_t mask = CPU_MASK_NONE;
+	int node = apicid_to_node(logical_apicid);
+	int cpu = __ffs(logical_apicid & 0xf);
+
+	cpu_set(cpu + 4*node, mask);
+	return mask;
 }
 
 static inline int mpc_apic_id(struct mpc_config_processor *m, 
diff -urpN linux-2.5.67-bk6/include/asm-i386/mach-numaq/mach_ipi.h cpu-2.5.67-bk6-1/include/asm-i386/mach-numaq/mach_ipi.h
--- linux-2.5.67-bk6/include/asm-i386/mach-numaq/mach_ipi.h	2003-04-07 10:32:17.000000000 -0700
+++ cpu-2.5.67-bk6-1/include/asm-i386/mach-numaq/mach_ipi.h	2003-04-15 14:39:40.000000000 -0700
@@ -1,18 +1,19 @@
 #ifndef __ASM_MACH_IPI_H
 #define __ASM_MACH_IPI_H
 
-static inline void send_IPI_mask_sequence(int mask, int vector);
+static inline void send_IPI_mask_sequence(cpumask_t, int vector);
 
-static inline void send_IPI_mask(int mask, int vector)
+static inline void send_IPI_mask(cpumask_t mask, int vector)
 {
 	send_IPI_mask_sequence(mask, vector);
 }
 
 static inline void send_IPI_allbutself(int vector)
 {
-	unsigned long mask = cpu_online_map & ~(1 << smp_processor_id());
+	cpumask_t mask = cpu_online_map;
+	cpu_clear(smp_processor_id(), mask);
 
-	if (mask)
+	if (!cpus_empty(mask))
 		send_IPI_mask(mask, vector);
 }
 
diff -urpN linux-2.5.67-bk6/include/asm-i386/mmu_context.h cpu-2.5.67-bk6-1/include/asm-i386/mmu_context.h
--- linux-2.5.67-bk6/include/asm-i386/mmu_context.h	2003-04-07 10:30:33.000000000 -0700
+++ cpu-2.5.67-bk6-1/include/asm-i386/mmu_context.h	2003-04-15 14:39:40.000000000 -0700
@@ -26,12 +26,12 @@ static inline void switch_mm(struct mm_s
 {
 	if (likely(prev != next)) {
 		/* stop flush ipis for the previous mm */
-		clear_bit(cpu, &prev->cpu_vm_mask);
+		cpu_clear(cpu, prev->cpu_vm_mask);
 #ifdef CONFIG_SMP
 		cpu_tlbstate[cpu].state = TLBSTATE_OK;
 		cpu_tlbstate[cpu].active_mm = next;
 #endif
-		set_bit(cpu, &next->cpu_vm_mask);
+		cpu_set(cpu, next->cpu_vm_mask);
 
 		/* Re-load page tables */
 		load_cr3(next->pgd);
@@ -45,9 +45,8 @@ static inline void switch_mm(struct mm_s
 #ifdef CONFIG_SMP
 	else {
 		cpu_tlbstate[cpu].state = TLBSTATE_OK;
-		if (cpu_tlbstate[cpu].active_mm != next)
-			BUG();
-		if (!test_and_set_bit(cpu, &next->cpu_vm_mask)) {
+		BUG_ON(cpu_tlbstate[cpu].active_mm != next);
+		if (!cpu_test_and_set(cpu, next->cpu_vm_mask)) {
 			/* We were in lazy tlb mode and leave_mm disabled 
 			 * tlb flush IPI delivery. We must reload %cr3.
 			 */
diff -urpN linux-2.5.67-bk6/include/asm-i386/mpspec.h cpu-2.5.67-bk6-1/include/asm-i386/mpspec.h
--- linux-2.5.67-bk6/include/asm-i386/mpspec.h	2003-04-07 10:30:33.000000000 -0700
+++ cpu-2.5.67-bk6-1/include/asm-i386/mpspec.h	2003-04-15 14:39:40.000000000 -0700
@@ -1,6 +1,8 @@
 #ifndef __ASM_MPSPEC_H
 #define __ASM_MPSPEC_H
 
+#include <linux/cpumask.h>
+
 /*
  * Structure definitions for SMP machines following the
  * Intel Multiprocessing Specification 1.1 and 1.4.
@@ -206,7 +208,7 @@ extern int quad_local_to_mp_bus_id [NR_C
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
 
 extern unsigned int boot_cpu_physical_apicid;
-extern unsigned long phys_cpu_present_map;
+extern cpumask_t phys_cpu_present_map;
 extern int smp_found_config;
 extern void find_smp_config (void);
 extern void get_smp_config (void);
diff -urpN linux-2.5.67-bk6/include/asm-i386/numaq.h cpu-2.5.67-bk6-1/include/asm-i386/numaq.h
--- linux-2.5.67-bk6/include/asm-i386/numaq.h	2003-04-07 10:31:42.000000000 -0700
+++ cpu-2.5.67-bk6-1/include/asm-i386/numaq.h	2003-04-15 14:39:40.000000000 -0700
@@ -28,7 +28,7 @@
 
 #ifdef CONFIG_X86_NUMAQ
 
-#define MAX_NUMNODES		8
+#define MAX_NUMNODES		16
 extern void get_memcfg_numaq(void);
 #define get_memcfg_numa() get_memcfg_numaq()
 
@@ -159,7 +159,7 @@ struct sys_cfg_data {
 
 static inline unsigned long *get_zholes_size(int nid)
 {
-	return 0;
+	return NULL;
 }
 #endif /* CONFIG_X86_NUMAQ */
 #endif /* NUMAQ_H */
diff -urpN linux-2.5.67-bk6/include/asm-i386/smp.h cpu-2.5.67-bk6-1/include/asm-i386/smp.h
--- linux-2.5.67-bk6/include/asm-i386/smp.h	2003-04-07 10:31:47.000000000 -0700
+++ cpu-2.5.67-bk6-1/include/asm-i386/smp.h	2003-04-15 14:39:40.000000000 -0700
@@ -8,6 +8,7 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/threads.h>
+#include <linux/cpumask.h>
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -31,8 +32,8 @@
  */
  
 extern void smp_alloc_memory(void);
-extern unsigned long phys_cpu_present_map;
-extern unsigned long cpu_online_map;
+extern cpumask_t phys_cpu_present_map;
+extern cpumask_t cpu_online_map;
 extern volatile unsigned long smp_invalidate_needed;
 extern int pic_mode;
 extern int smp_num_siblings;
@@ -55,37 +56,19 @@ extern void zap_low_mappings (void);
  */
 #define smp_processor_id() (current_thread_info()->cpu)
 
-extern volatile unsigned long cpu_callout_map;
+extern volatile cpumask_t cpu_callout_map;
 
-#define cpu_possible(cpu) (cpu_callout_map & (1<<(cpu)))
-#define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
-
-#define for_each_cpu(cpu, mask) \
-	for(mask = cpu_online_map; \
-	    cpu = __ffs(mask), mask != 0; \
-	    mask &= ~(1<<cpu))
-
-extern inline unsigned int num_online_cpus(void)
-{
-	return hweight32(cpu_online_map);
-}
+#define cpu_possible(cpu) cpu_isset(cpu, cpu_callout_map)
 
 /* We don't mark CPUs online until __cpu_up(), so we need another measure */
 static inline int num_booting_cpus(void)
 {
-	return hweight32(cpu_callout_map);
+	return cpus_weight(cpu_callout_map);
 }
 
 extern void map_cpu_to_logical_apicid(void);
 extern void unmap_cpu_to_logical_apicid(int cpu);
 
-extern inline int any_online_cpu(unsigned int mask)
-{
-	if (mask & cpu_online_map)
-		return __ffs(mask & cpu_online_map);
-
-	return -1;
-}
 #ifdef CONFIG_X86_LOCAL_APIC
 static __inline int hard_smp_processor_id(void)
 {
diff -urpN linux-2.5.67-bk6/include/asm-i386/topology.h cpu-2.5.67-bk6-1/include/asm-i386/topology.h
--- linux-2.5.67-bk6/include/asm-i386/topology.h	2003-04-07 10:30:44.000000000 -0700
+++ cpu-2.5.67-bk6-1/include/asm-i386/topology.h	2003-04-15 14:39:40.000000000 -0700
@@ -31,8 +31,10 @@
 
 #include <asm/mpspec.h>
 
+#include <linux/cpumask.h>
+
 /* Mappings between logical cpu number and node number */
-extern volatile unsigned long node_2_cpu_mask[];
+extern volatile cpumask_t node_2_cpu_mask[];
 extern volatile int cpu_2_node[];
 
 /* Returns the number of the node containing CPU 'cpu' */
@@ -49,7 +51,7 @@ static inline int cpu_to_node(int cpu)
 #define parent_node(node) (node)
 
 /* Returns a bitmask of CPUs on Node 'node'. */
-static inline unsigned long node_to_cpumask(int node)
+static inline cpumask_t node_to_cpumask(int node)
 {
 	return node_2_cpu_mask[node];
 }
@@ -57,14 +59,15 @@ static inline unsigned long node_to_cpum
 /* Returns the number of the first CPU on Node 'node'. */
 static inline int node_to_first_cpu(int node)
 { 
-	return __ffs(node_to_cpumask(node));
+	cpumask_t mask = node_to_cpumask(node);
+	return first_cpu(mask);
 }
 
 /* Returns the number of the first MemBlk on Node 'node' */
 #define node_to_memblk(node) (node)
 
 /* Returns the number of the node containing PCI bus 'bus' */
-static inline unsigned long pcibus_to_cpumask(int bus)
+static inline cpumask_t pcibus_to_cpumask(int bus)
 {
 	return node_to_cpumask(mp_bus_id_to_node[bus]);
 }
