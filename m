Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267692AbTASV1W>; Sun, 19 Jan 2003 16:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267694AbTASV1W>; Sun, 19 Jan 2003 16:27:22 -0500
Received: from holomorphy.com ([66.224.33.161]:64903 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267692AbTASV0z>;
	Sun, 19 Jan 2003 16:26:55 -0500
Date: Sun, 19 Jan 2003 13:35:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpumask_t
Message-ID: <20030119213524.GH780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20020808.073630.37512884.davem@redhat.com> <20020809080517.E4BE5443C@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020809080517.E4BE5443C@lists.samba.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> It worked because you cast the thing to (unsigned long *) in every
>> bitops.  We either:
>> 1) shouldn't need to do that, meaning cpumask_t must be a long
>>    or array or longs

On Fri, Aug 09, 2002 at 04:04:12PM +1000, Rusty Russell wrote:
> Yes, this is the other way.  It's probably neater to just make it
> completely generic and explicit.
> 
In message <20020808.073630.37512884.davem@redhat.com> you write:
>> 2) you need to abstract away bitops on cpumask_t so that one
>>    _really_ could make cpumask_t a struct with things other
>>    than the mask itself inside, so cpumask_test, cpumask_add,
>>    cpumask_remove or however you'd like to name them

On Fri, Aug 09, 2002 at 04:04:12PM +1000, Rusty Russell wrote:
> Naah, if I make it that flexible you'll do some godawful Sparc64 hack
> just to be different 8)

I just don't want this to die. Here's a stab at bringing it a little
closer to up-to-date. I wasn't very careful but it's probably not much
more than 3-4 hours to reconstitute from scratch if worse comes to worse.
OTOH this is some really crusty stuff.


Resurrect cpumask_t or something on that order.
Compiletested with CONFIG_X86_NUMAQ only.

 arch/i386/kernel/apic.c                 |    3 
 arch/i386/kernel/cpu/proc.c             |    2 
 arch/i386/kernel/io_apic.c              |   70 +++++++++------
 arch/i386/kernel/irq.c                  |   35 +++++--
 arch/i386/kernel/ldt.c                  |   12 +-
 arch/i386/kernel/mpparse.c              |    6 -
 arch/i386/kernel/reboot.c               |    2 
 arch/i386/kernel/smp.c                  |   67 ++++++++------
 arch/i386/kernel/smpboot.c              |   70 +++++++--------
 drivers/base/node.c                     |    8 +
 include/asm-i386/mach-numaq/mach_apic.h |   24 +++--
 include/asm-i386/mach-numaq/mach_ipi.h  |    9 +
 include/asm-i386/mmu_context.h          |    9 -
 include/asm-i386/mpspec.h               |    2 
 include/asm-i386/smp.h                  |   29 +-----
 include/asm-i386/topology.h             |    9 +
 include/linux/bitmap.h                  |  148 ++++++++++++++++++++++++++++++++
 include/linux/cpumask.h                 |   51 +++++++++++
 include/linux/init_task.h               |    2 
 include/linux/irq.h                     |    2 
 include/linux/node.h                    |    2 
 include/linux/rcupdate.h                |    4 
 include/linux/sched.h                   |    6 -
 include/linux/types.h                   |    6 -
 kernel/fork.c                           |    2 
 kernel/module.c                         |    9 +
 kernel/rcupdate.c                       |   12 +-
 kernel/sched.c                          |   61 +++++++------
 kernel/softirq.c                        |    7 -
 kernel/workqueue.c                      |    4 
 30 files changed, 467 insertions(+), 206 deletions(-)


diff -urpN mm1-2.5.59/arch/i386/kernel/apic.c cpu-2.5.59-1/arch/i386/kernel/apic.c
--- mm1-2.5.59/arch/i386/kernel/apic.c	2003-01-16 18:23:00.000000000 -0800
+++ cpu-2.5.59-1/arch/i386/kernel/apic.c	2003-01-19 12:45:40.000000000 -0800
@@ -1138,7 +1138,8 @@ int __init APIC_init_uniprocessor (void)
 
 	connect_bsp_APIC();
 
-	phys_cpu_present_map = 1;
+	bitmap_clear(phys_cpu_present_map.mask, NR_CPUS);
+	cpu_set(0, phys_cpu_present_map);
 	apic_write_around(APIC_ID, boot_cpu_physical_apicid);
 
 	apic_pm_init2();
diff -urpN mm1-2.5.59/arch/i386/kernel/cpu/proc.c cpu-2.5.59-1/arch/i386/kernel/cpu/proc.c
--- mm1-2.5.59/arch/i386/kernel/cpu/proc.c	2003-01-16 18:22:42.000000000 -0800
+++ cpu-2.5.59-1/arch/i386/kernel/cpu/proc.c	2003-01-19 11:28:26.000000000 -0800
@@ -47,7 +47,7 @@ static int show_cpuinfo(struct seq_file 
 	int fpu_exception;
 
 #ifdef CONFIG_SMP
-	if (!(cpu_online_map & (1<<n)))
+	if (!cpu_isset(n, cpu_online_map))
 		return 0;
 #endif
 	seq_printf(m, "processor\t: %d\n"
diff -urpN mm1-2.5.59/arch/i386/kernel/io_apic.c cpu-2.5.59-1/arch/i386/kernel/io_apic.c
--- mm1-2.5.59/arch/i386/kernel/io_apic.c	2003-01-17 01:04:43.000000000 -0800
+++ cpu-2.5.59-1/arch/i386/kernel/io_apic.c	2003-01-19 13:01:29.000000000 -0800
@@ -194,18 +194,27 @@ static void clear_IO_APIC (void)
 			clear_IO_APIC_pin(apic, pin);
 }
 
-static void set_ioapic_affinity (unsigned int irq, unsigned long mask)
+#if NR_CPUS <= 32
+static void set_ioapic_affinity (unsigned int irq, cpumask_t mask)
 {
 	unsigned long flags;
+	unsigned long regval = mask.mask[0];
 
 	/*
 	 * Only the first 8 bits are valid.
 	 */
-	mask = mask << 24;
+	regval <<= 24;
 	spin_lock_irqsave(&ioapic_lock, flags);
-	__DO_ACTION(1, = mask, )
+	__DO_ACTION(1, = regval, )
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
+#else
+/*
+ * I give up. This FPOS still doesn't understand the difference between
+ * an APIC destination and some retarded cpu bitmask.
+ */
+static void set_ioapic_affinity(unsigned int irq, cpumask_t mask) { }
+#endif
 
 #if defined(CONFIG_SMP)
 # include <asm/processor.h>	/* kernel_thread() */
@@ -221,8 +230,8 @@ static void set_ioapic_affinity (unsigne
 #  define Dprintk(x...) 
 # endif
 
-extern unsigned long irq_affinity [NR_IRQS];
-unsigned long __cacheline_aligned irq_balance_mask [NR_IRQS];
+extern cpumask_t irq_affinity [NR_IRQS];
+cpumask_t __cacheline_aligned irq_balance_mask [NR_IRQS];
 static int irqbalance_disabled __initdata = 0;
 static int physical_balance = 0;
 
@@ -239,8 +248,7 @@ struct irq_cpu_info {
 #define IDLE_ENOUGH(cpu,now) \
 		(idle_cpu(cpu) && ((now) - irq_stat[(cpu)].idle_timestamp > 1))
 
-#define IRQ_ALLOWED(cpu,allowed_mask) \
-		((1 << cpu) & (allowed_mask))
+#define IRQ_ALLOWED(cpu, allowed_mask)	cpu_isset(cpu, allowed_mask)
 
 #define CPU_TO_PACKAGEINDEX(i) \
 		((physical_balance && i > cpu_sibling_map[i]) ? cpu_sibling_map[i] : i)
@@ -284,8 +292,7 @@ static void do_irq_balance(void)
 	int tmp_loaded, first_attempt = 1;
 	unsigned long tmp_cpu_irq;
 	unsigned long imbalance = 0;
-	unsigned long allowed_mask;
-	unsigned long target_cpu_mask;
+	cpumask_t allowed_mask, target_cpu_mask, tmp;
 
 	for (i = 0; i < NR_CPUS; i++) {
 		int package_index;
@@ -433,10 +440,12 @@ tryanotherirq:
 	if (physical_balance && (CPU_IRQ(min_loaded) >> 1) > CPU_IRQ(cpu_sibling_map[min_loaded]))
 		min_loaded = cpu_sibling_map[min_loaded];
 
-	allowed_mask = cpu_online_map & irq_affinity[selected_irq];
-	target_cpu_mask = 1 << min_loaded;
+	cpus_and(allowed_mask, cpu_online_map, irq_affinity[selected_irq]);
+	bitmap_clear(target_cpu_mask.mask, BITS_PER_LONG);
+	cpu_set(min_loaded, target_cpu_mask);
+	cpus_and(tmp, target_cpu_mask, allowed_mask);
 
-	if (target_cpu_mask & allowed_mask) {
+	if (any_online_cpu(tmp) >= NR_CPUS) {
 		irq_desc_t *desc = irq_desc + selected_irq;
 		Dprintk("irq = %d moved to cpu = %d\n", selected_irq, min_loaded);
 		/* mark for change destination */
@@ -460,7 +469,7 @@ not_worth_the_effort:
 	return;
 }
 
-static unsigned long move(int curr_cpu, unsigned long allowed_mask, unsigned long now, int direction)
+static unsigned long move(int curr_cpu, cpumask_t allowed_mask, unsigned long now, int direction)
 {
 	int search_idle = 1;
 	int cpu = curr_cpu;
@@ -489,18 +498,19 @@ inside:
 static inline void balance_irq (int cpu, int irq)
 {
 	unsigned long now = jiffies;
-	unsigned long allowed_mask;
+	cpumask_t allowed_mask;
 	unsigned int new_cpu;
 		
 	if (no_balance_irq)
 		return;
 
-	allowed_mask = cpu_online_map & irq_affinity[irq];
+	cpus_and(allowed_mask, cpu_online_map, irq_affinity[irq]);
 	new_cpu = move(cpu, allowed_mask, now, 1);
 	if (cpu != new_cpu) {
 		irq_desc_t *desc = irq_desc + irq;
 		spin_lock(&desc->lock);
-		irq_balance_mask[irq] = cpu_to_logical_apicid(new_cpu);
+		bitmap_clear(irq_balance_mask[irq].mask, NR_CPUS);
+		cpu_set(new_cpu, irq_balance_mask[irq]);
 		spin_unlock(&desc->lock);
 	}
 }
@@ -515,8 +525,10 @@ int balanced_irq(void *unused)
 	sprintf(current->comm, "balanced_irq");
 	
 	/* push everything to CPU 0 to give us a starting point.  */
-	for (i = 0 ; i < NR_IRQS ; i++)
-		irq_balance_mask[i] = 1 << 0;
+	for (i = 0 ; i < NR_IRQS ; i++) {
+		bitmap_clear(irq_balance_mask[i].mask, NR_CPUS);
+		cpu_set(0, irq_balance_mask[i]);
+	}
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		time_remaining = schedule_timeout(time_remaining);
@@ -533,11 +545,14 @@ static int __init balanced_irq_init(void
 {
 	int i;
 	struct cpuinfo_x86 *c;
+	cpumask_t tmp;
+
+	bitmap_shift_right(tmp.mask, cpu_online_map.mask, 2, NR_CPUS);
         c = &boot_cpu_data;
 	if (irqbalance_disabled)
 		return 0;
 	/* Enable physical balance only if more than 1 physical processor is present */
-	if (smp_num_siblings > 1 && cpu_online_map >> 2)
+	if (smp_num_siblings > 1 && any_online_cpu(tmp) < NR_CPUS)
 		physical_balance = 1;
 
 	for (i = 0; i < NR_CPUS; i++) {
@@ -576,14 +591,14 @@ static int __init irqbalance_disable(cha
 
 __setup("noirqbalance", irqbalance_disable);
 
-static void set_ioapic_affinity (unsigned int irq, unsigned long mask);
+static void set_ioapic_affinity (unsigned int irq, cpumask_t mask);
 
 static inline void move_irq(int irq)
 {
 	/* note - we hold the desc->lock */
-	if (unlikely(irq_balance_mask[irq])) {
+	if (unlikely(any_online_cpu(irq_balance_mask[irq]) < NR_CPUS)) {
 		set_ioapic_affinity(irq, irq_balance_mask[irq]);
-		irq_balance_mask[irq] = 0;
+		bitmap_clear(irq_balance_mask[irq].mask, NR_CPUS);
 	}
 }
 
@@ -1451,7 +1466,11 @@ static void __init setup_ioapic_ids_from
 		/* This gets done during IOAPIC enumeration for ACPI. */
 		return;
 
-	phys_id_present_map = ioapic_phys_id_map(phys_cpu_present_map);
+	/*
+	 * This is broken; anything with a real cpu count has to
+	 * circumvent this idiocy regardless.
+	 */
+	phys_id_present_map = ioapic_phys_id_map(phys_cpu_present_map).mask[0];
 
 	/*
 	 * Set the IOAPIC ID to the value stored in the MPC table.
@@ -1478,8 +1497,9 @@ static void __init setup_ioapic_ids_from
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
diff -urpN mm1-2.5.59/arch/i386/kernel/irq.c cpu-2.5.59-1/arch/i386/kernel/irq.c
--- mm1-2.5.59/arch/i386/kernel/irq.c	2003-01-17 01:04:43.000000000 -0800
+++ cpu-2.5.59-1/arch/i386/kernel/irq.c	2003-01-19 13:27:24.000000000 -0800
@@ -793,13 +793,13 @@ int setup_irq(unsigned int irq, struct i
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
@@ -813,10 +813,10 @@ static unsigned int parse_hex_value (con
 	 * Parse the first 8 characters as a hex string, any non-hex char
 	 * is end-of-string. '00e1', 'e1', '00E1', 'E1' are all the same.
 	 */
-	value = 0;
 
 	for (i = 0; i < count; i++) {
 		unsigned int c = hexnum[i];
+		int k;
 
 		switch (c) {
 			case '0' ... '9': c -= '0'; break;
@@ -825,7 +825,10 @@ static unsigned int parse_hex_value (con
 		default:
 			goto out;
 		}
-		value = (value << 4) | c;
+		bitmap_shift_left(value.mask, value.mask, 4, NR_CPUS);
+		for (k = 0; k < 4; ++k)
+			if (test_bit(k, (unsigned long *)&c))
+				cpu_set(k, value);
 	}
 out:
 	*ret = value;
@@ -836,20 +839,28 @@ out:
 
 static struct proc_dir_entry * smp_affinity_entry [NR_IRQS];
 
-unsigned long irq_affinity [NR_IRQS] = { [0 ... NR_IRQS-1] = ~0UL };
+cpumask_t irq_affinity [NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };
 static int irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
+	int k, len;
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
-	return sprintf (page, "%08lx\n", irq_affinity[(long)data]);
+
+	len = 0;
+	for (k = 0; k < CPU_ARRAY_SIZE; ++k) {
+		int j = sprintf (page, "%08lx\n", irq_affinity[(long)data].mask[k]);
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
@@ -861,7 +872,8 @@ static int irq_affinity_write_proc (stru
 	 * way to make the system unusable accidentally :-) At least
 	 * one online CPU still has to be targeted.
 	 */
-	if (!(new_value & cpu_online_map))
+	cpus_and(tmp, new_value, cpu_online_map);
+	if (!any_online_cpu(tmp))
 		return -EINVAL;
 
 	irq_affinity[irq] = new_value;
@@ -884,8 +896,9 @@ static int prof_cpu_mask_read_proc (char
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
diff -urpN mm1-2.5.59/arch/i386/kernel/ldt.c cpu-2.5.59-1/arch/i386/kernel/ldt.c
--- mm1-2.5.59/arch/i386/kernel/ldt.c	2003-01-16 18:22:24.000000000 -0800
+++ cpu-2.5.59-1/arch/i386/kernel/ldt.c	2003-01-19 12:09:24.000000000 -0800
@@ -57,10 +57,14 @@ static int alloc_ldt(mm_context_t *pc, i
 	if (reload) {
 		load_LDT(pc);
 #ifdef CONFIG_SMP
-		preempt_disable();
-		if (current->mm->cpu_vm_mask != (1 << smp_processor_id()))
-			smp_call_function(flush_ldt, 0, 1, 1);
-		preempt_enable();
+		{
+			cpumask_t tmp = CPU_MASK_NONE;
+			preempt_disable();
+			cpu_set(smp_processor_id(), tmp);
+			if (!cpus_equal(current->mm->cpu_vm_mask, tmp))
+				smp_call_function(flush_ldt, 0, 1, 1);
+			preempt_enable();
+		}
 #endif
 	}
 	if (oldsize) {
diff -urpN mm1-2.5.59/arch/i386/kernel/mpparse.c cpu-2.5.59-1/arch/i386/kernel/mpparse.c
--- mm1-2.5.59/arch/i386/kernel/mpparse.c	2003-01-16 18:21:50.000000000 -0800
+++ cpu-2.5.59-1/arch/i386/kernel/mpparse.c	2003-01-19 12:12:18.000000000 -0800
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
diff -urpN mm1-2.5.59/arch/i386/kernel/reboot.c cpu-2.5.59-1/arch/i386/kernel/reboot.c
--- mm1-2.5.59/arch/i386/kernel/reboot.c	2003-01-16 18:21:49.000000000 -0800
+++ cpu-2.5.59-1/arch/i386/kernel/reboot.c	2003-01-19 12:09:48.000000000 -0800
@@ -234,7 +234,7 @@ void machine_restart(char * __unused)
 		   if its not, default to the BSP */
 		if ((reboot_cpu == -1) ||  
 		      (reboot_cpu > (NR_CPUS -1))  || 
-		      !(phys_cpu_present_map & (1<<cpuid))) 
+		      !(cpu_isset(cpuid, phys_cpu_present_map)))
 			reboot_cpu = boot_cpu_physical_apicid;
 
 		reboot_smp = 0;  /* use this as a flag to only go through this once*/
diff -urpN mm1-2.5.59/arch/i386/kernel/smp.c cpu-2.5.59-1/arch/i386/kernel/smp.c
--- mm1-2.5.59/arch/i386/kernel/smp.c	2003-01-17 01:04:43.000000000 -0800
+++ cpu-2.5.59-1/arch/i386/kernel/smp.c	2003-01-19 12:23:52.000000000 -0800
@@ -186,10 +186,10 @@ static inline void send_IPI_mask_bitmask
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
@@ -200,8 +200,7 @@ static inline void send_IPI_mask_sequenc
 	local_irq_save(flags);
 
 	for (query_cpu = 0; query_cpu < NR_CPUS; ++query_cpu) {
-		query_mask = 1 << query_cpu;
-		if (query_mask & mask) {
+		if (cpu_isset(query_cpu, mask)) {
 		
 			/*
 			 * Wait for idle.
@@ -238,7 +237,7 @@ static inline void send_IPI_mask_sequenc
  *	Optimizations Manfred Spraul <manfred@colorfullife.com>
  */
 
-static volatile unsigned long flush_cpumask;
+static volatile cpumask_t flush_cpumask;
 static struct mm_struct * flush_mm;
 static unsigned long flush_va;
 static spinlock_t tlbstate_lock = SPIN_LOCK_UNLOCKED;
@@ -255,7 +254,7 @@ static inline void leave_mm (unsigned lo
 {
 	if (cpu_tlbstate[cpu].state == TLBSTATE_OK)
 		BUG();
-	clear_bit(cpu, &cpu_tlbstate[cpu].active_mm->cpu_vm_mask);
+	cpu_clear(cpu, cpu_tlbstate[cpu].active_mm->cpu_vm_mask);
 	load_cr3(swapper_pg_dir);
 }
 
@@ -311,7 +310,7 @@ asmlinkage void smp_invalidate_interrupt
 
 	cpu = get_cpu();
 
-	if (!test_bit(cpu, &flush_cpumask))
+	if (!cpu_isset(cpu, flush_cpumask))
 		goto out;
 		/* 
 		 * This was a BUG() but until someone can quote me the
@@ -332,15 +331,16 @@ asmlinkage void smp_invalidate_interrupt
 			leave_mm(cpu);
 	}
 	ack_APIC_irq();
-	clear_bit(cpu, &flush_cpumask);
+	cpu_clear(cpu, flush_cpumask);
 
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
@@ -348,14 +348,12 @@ static void flush_tlb_others (unsigned l
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
+	BUG_ON(any_online_cpu(cpumask) >= NR_CPUS);
+
+	cpus_and(tmp, cpumask, cpu_online_map);
+	BUG_ON(!cpus_equal(cpumask, tmp));
+	BUG_ON(cpu_isset(smp_processor_id(), cpumask));
+	BUG_ON(!mm);
 
 	/*
 	 * i'm not happy about this global shared spinlock in the
@@ -367,14 +365,18 @@ static void flush_tlb_others (unsigned l
 	
 	flush_mm = mm;
 	flush_va = va;
-	atomic_set_mask(cpumask, &flush_cpumask);
+	/*
+	 * Probably introduced a bug here. This was:
+	 * atomic_set_mask(cpumask, &flush_cpumask);
+	 */
+	flush_cpumask = cpumask;
 	/*
 	 * We have to send the IPI only to
 	 * CPUs affected.
 	 */
 	send_IPI_mask(cpumask, INVALIDATE_TLB_VECTOR);
 
-	while (flush_cpumask)
+	while (any_online_cpu(flush_cpumask) < NR_CPUS)
 		/* nothing. lockup detection does not belong here */;
 
 	flush_mm = NULL;
@@ -385,23 +387,25 @@ static void flush_tlb_others (unsigned l
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
+	if (any_online_cpu(cpu_mask) < NR_CPUS)
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
@@ -409,7 +413,7 @@ void flush_tlb_mm (struct mm_struct * mm
 		else
 			leave_mm(smp_processor_id());
 	}
-	if (cpu_mask)
+	if (any_online_cpu(cpu_mask) < NR_CPUS)
 		flush_tlb_others(cpu_mask, mm, FLUSH_ALL);
 
 	preempt_enable();
@@ -418,10 +422,11 @@ void flush_tlb_mm (struct mm_struct * mm
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
@@ -430,7 +435,7 @@ void flush_tlb_page(struct vm_area_struc
 		 	leave_mm(smp_processor_id());
 	}
 
-	if (cpu_mask)
+	if (any_online_cpu(cpu_mask) < NR_CPUS)
 		flush_tlb_others(cpu_mask, mm, va);
 
 	preempt_enable();
@@ -464,7 +469,9 @@ void flush_tlb_all(void)
  */
 void smp_send_reschedule(int cpu)
 {
-	send_IPI_mask(1 << cpu, RESCHEDULE_VECTOR);
+	cpumask_t cpumask = CPU_MASK_NONE;
+	cpu_set(cpu, cpumask);
+	send_IPI_mask(cpumask, RESCHEDULE_VECTOR);
 }
 
 /*
@@ -572,7 +579,7 @@ static void stop_this_cpu (void * dummy)
 	/*
 	 * Remove this CPU:
 	 */
-	clear_bit(smp_processor_id(), &cpu_online_map);
+	cpu_clear(smp_processor_id(), cpu_online_map);
 	local_irq_disable();
 	disable_local_APIC();
 	if (cpu_data[smp_processor_id()].hlt_works_ok)
diff -urpN mm1-2.5.59/arch/i386/kernel/smpboot.c cpu-2.5.59-1/arch/i386/kernel/smpboot.c
--- mm1-2.5.59/arch/i386/kernel/smpboot.c	2003-01-16 18:22:09.000000000 -0800
+++ cpu-2.5.59-1/arch/i386/kernel/smpboot.c	2003-01-19 13:07:06.000000000 -0800
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
@@ -270,7 +270,7 @@ static void __init synchronize_tsc_bp (v
 
 	sum = 0;
 	for (i = 0; i < NR_CPUS; i++) {
-		if (test_bit(i, &cpu_callout_map)) {
+		if (cpu_isset(i, cpu_callout_map)) {
 			t0 = tsc_values[i];
 			sum += t0;
 		}
@@ -279,7 +279,7 @@ static void __init synchronize_tsc_bp (v
 
 	sum = 0;
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!test_bit(i, &cpu_callout_map))
+		if (!cpu_isset(i, cpu_callout_map))
 			continue;
 		delta = tsc_values[i] - avg;
 		if (delta < 0)
@@ -355,7 +355,7 @@ void __init smp_callin(void)
 	 */
 	phys_id = GET_APIC_ID(apic_read(APIC_ID));
 	cpuid = smp_processor_id();
-	if (test_bit(cpuid, &cpu_callin_map)) {
+	if (cpu_isset(cpuid, cpu_callin_map)) {
 		printk("huh, phys CPU#%d, CPU#%d already present??\n",
 					phys_id, cpuid);
 		BUG();
@@ -378,7 +378,7 @@ void __init smp_callin(void)
 		/*
 		 * Has the boot CPU finished it's STARTUP sequence?
 		 */
-		if (test_bit(cpuid, &cpu_callout_map))
+		if (cpu_isset(cpuid, cpu_callout_map))
 			break;
 		rep_nop();
 	}
@@ -419,7 +419,7 @@ void __init smp_callin(void)
 	/*
 	 * Allow the master to continue.
 	 */
-	set_bit(cpuid, &cpu_callin_map);
+	cpu_set(cpuid, cpu_callin_map);
 
 	/*
 	 *      Synchronize the TSC with the BP
@@ -444,7 +444,7 @@ int __init start_secondary(void *unused)
 	 */
 	cpu_init();
 	smp_callin();
-	while (!test_bit(smp_processor_id(), &smp_commenced_mask))
+	while (!cpu_isset(smp_processor_id(), smp_commenced_mask))
 		rep_nop();
 	setup_secondary_APIC_clock();
 	if (nmi_watchdog == NMI_IO_APIC) {
@@ -458,7 +458,7 @@ int __init start_secondary(void *unused)
 	 * the local TLBs too.
 	 */
 	local_flush_tlb();
-	set_bit(smp_processor_id(), &cpu_online_map);
+	cpu_set(smp_processor_id(), cpu_online_map);
 	wmb();
 	return cpu_idle();
 }
@@ -501,8 +501,8 @@ static struct task_struct * __init fork_
 #ifdef CONFIG_NUMA
 
 /* which logical CPUs are on which nodes */
-volatile unsigned long node_2_cpu_mask[MAX_NR_NODES] = 
-						{ [0 ... MAX_NR_NODES-1] = 0 };
+volatile cpumask_t node_2_cpu_mask[MAX_NR_NODES] = 
+				{ [0 ... MAX_NR_NODES-1] = CPU_MASK_NONE };
 /* which node each logical CPU is on */
 volatile int cpu_2_node[NR_CPUS] = { [0 ... NR_CPUS-1] = 0 };
 
@@ -510,7 +510,7 @@ volatile int cpu_2_node[NR_CPUS] = { [0 
 static inline void map_cpu_to_node(int cpu, int node)
 {
 	printk("Mapping cpu %d to node %d\n", cpu, node);
-	node_2_cpu_mask[node] |= (1 << cpu);
+	cpu_set(cpu, node_2_cpu_mask[node]);
 	cpu_2_node[cpu] = node;
 }
 
@@ -521,7 +521,7 @@ static inline void unmap_cpu_to_node(int
 
 	printk("Unmapping cpu %d from all nodes\n", cpu);
 	for (node = 0; node < MAX_NR_NODES; node ++)
-		node_2_cpu_mask[node] &= ~(1 << cpu);
+		cpu_clear(cpu, node_2_cpu_mask[node]);
 	cpu_2_node[cpu] = -1;
 }
 #else /* !CONFIG_NUMA */
@@ -772,7 +772,7 @@ wakeup_secondary_cpu(int phys_apicid, un
 }
 #endif	/* WAKE_SECONDARY_VIA_INIT */
 
-extern unsigned long cpu_initialized;
+extern cpumask_t cpu_initialized;
 
 static int __init do_boot_cpu(int apicid)
 /*
@@ -843,19 +843,19 @@ static int __init do_boot_cpu(int apicid
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
@@ -876,8 +876,8 @@ static int __init do_boot_cpu(int apicid
 	if (boot_error) {
 		/* Try to put things back the way they were before ... */
 		unmap_cpu_to_logical_apicid(cpu);
-		clear_bit(cpu, &cpu_callout_map); /* was set here (do_boot_cpu()) */
-		clear_bit(cpu, &cpu_initialized); /* was set by cpu_init() */
+		cpu_clear(cpu, cpu_callout_map); /* was set here (do_boot_cpu()) */
+		cpu_clear(cpu, cpu_initialized); /* was set by cpu_init() */
 		cpucount--;
 	}
 
@@ -979,7 +979,8 @@ static void __init smp_boot_cpus(unsigne
 	if (!smp_found_config) {
 		printk(KERN_NOTICE "SMP motherboard not detected.\n");
 		smpboot_clear_io_apic_irqs();
-		phys_cpu_present_map = 1;
+		bitmap_clear(phys_cpu_present_map.mask, NR_CPUS);
+		cpu_set(1, phys_cpu_present_map);
 		if (APIC_init_uniprocessor())
 			printk(KERN_NOTICE "Local APIC not detected."
 					   " Using dummy APIC emulation.\n");
@@ -994,7 +995,7 @@ static void __init smp_boot_cpus(unsigne
 	if (!check_phys_apicid_present(boot_cpu_physical_apicid)) {
 		printk("weird, boot CPU (#%d) not listed by the BIOS.\n",
 				boot_cpu_physical_apicid);
-		phys_cpu_present_map |= (1 << hard_smp_processor_id());
+		cpu_set(hard_smp_processor_id(), phys_cpu_present_map);
 	}
 
 	/*
@@ -1005,7 +1006,8 @@ static void __init smp_boot_cpus(unsigne
 			boot_cpu_physical_apicid);
 		printk(KERN_ERR "... forcing use of dummy APIC emulation. (tell your hw vendor)\n");
 		smpboot_clear_io_apic_irqs();
-		phys_cpu_present_map = 1;
+		bitmap_clear(phys_cpu_present_map.mask, NR_CPUS);
+		cpu_set(1, phys_cpu_present_map);
 		return;
 	}
 
@@ -1018,7 +1020,7 @@ static void __init smp_boot_cpus(unsigne
 		smp_found_config = 0;
 		printk(KERN_INFO "SMP mode deactivated, forcing use of dummy APIC emulation.\n");
 		smpboot_clear_io_apic_irqs();
-		phys_cpu_present_map = 1;
+		bitmap_clear(phys_cpu_present_map.mask, NR_CPUS);
 		return;
 	}
 
@@ -1073,7 +1075,7 @@ static void __init smp_boot_cpus(unsigne
 	} else {
 		unsigned long bogosum = 0;
 		for (cpu = 0; cpu < NR_CPUS; cpu++)
-			if (cpu_callout_map & (1<<cpu))
+			if (cpu_isset(cpu, cpu_callout_map))
 				bogosum += cpu_data[cpu].loops_per_jiffy;
 		printk(KERN_INFO "Total of %d processors activated (%lu.%02lu BogoMIPS).\n",
 			cpucount+1,
@@ -1096,10 +1098,10 @@ static void __init smp_boot_cpus(unsigne
 		
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
@@ -1134,28 +1136,28 @@ void __init smp_prepare_cpus(unsigned in
 
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
diff -urpN mm1-2.5.59/drivers/base/node.c cpu-2.5.59-1/drivers/base/node.c
--- mm1-2.5.59/drivers/base/node.c	2003-01-16 18:21:40.000000000 -0800
+++ cpu-2.5.59-1/drivers/base/node.c	2003-01-19 13:26:52.000000000 -0800
@@ -31,7 +31,13 @@ struct device_driver node_driver = {
 static ssize_t node_read_cpumap(struct device * dev, char * buf)
 {
 	struct node *node_dev = to_node(to_root(dev));
-        return sprintf(buf,"%lx\n",node_dev->cpumap);
+	int k, len = 0;
+	for (k = 0; k < CPU_ARRAY_SIZE; ++k) {
+        	int j = sprintf(buf,"%lx\n",node_dev->cpumap.mask[k]);
+		len += j;
+		buf += j;
+	}
+	return len;
 }
 static DEVICE_ATTR(cpumap,S_IRUGO,node_read_cpumap,NULL);
 
diff -urpN mm1-2.5.59/include/asm-i386/mach-numaq/mach_apic.h cpu-2.5.59-1/include/asm-i386/mach-numaq/mach_apic.h
--- mm1-2.5.59/include/asm-i386/mach-numaq/mach_apic.h	2003-01-16 18:22:04.000000000 -0800
+++ cpu-2.5.59-1/include/asm-i386/mach-numaq/mach_apic.h	2003-01-19 12:50:49.000000000 -0800
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
@@ -40,10 +40,15 @@ static inline int multi_timer_check(int 
 	return (apic != 0 && irq == 0);
 }
 
-static inline ulong ioapic_phys_id_map(ulong phys_map)
+static inline cpumask_t ioapic_phys_id_map(cpumask_t phys_map)
 {
 	/* We don't have a good way to do this yet - hack */
-	return 0xf;
+	cpumask_t mask;
+	cpu_set(0, mask);
+	cpu_set(1, mask);
+	cpu_set(2, mask);
+	cpu_set(3, mask);
+	return mask;
 }
 
 /* Mapping from cpu number to logical apicid */
@@ -68,9 +73,14 @@ static inline int apicid_to_node(int log
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
 
 static inline int mpc_apic_id(struct mpc_config_processor *m, int quad)
diff -urpN mm1-2.5.59/include/asm-i386/mach-numaq/mach_ipi.h cpu-2.5.59-1/include/asm-i386/mach-numaq/mach_ipi.h
--- mm1-2.5.59/include/asm-i386/mach-numaq/mach_ipi.h	2003-01-16 18:22:27.000000000 -0800
+++ cpu-2.5.59-1/include/asm-i386/mach-numaq/mach_ipi.h	2003-01-19 12:10:10.000000000 -0800
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
+	if (any_online_cpu(mask) < NR_CPUS)
 		send_IPI_mask(mask, vector);
 }
 
diff -urpN mm1-2.5.59/include/asm-i386/mmu_context.h cpu-2.5.59-1/include/asm-i386/mmu_context.h
--- mm1-2.5.59/include/asm-i386/mmu_context.h	2003-01-16 18:21:33.000000000 -0800
+++ cpu-2.5.59-1/include/asm-i386/mmu_context.h	2003-01-19 11:50:42.000000000 -0800
@@ -30,12 +30,12 @@ static inline void switch_mm(struct mm_s
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
@@ -49,9 +49,8 @@ static inline void switch_mm(struct mm_s
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
diff -urpN mm1-2.5.59/include/asm-i386/mpspec.h cpu-2.5.59-1/include/asm-i386/mpspec.h
--- mm1-2.5.59/include/asm-i386/mpspec.h	2003-01-16 18:21:33.000000000 -0800
+++ cpu-2.5.59-1/include/asm-i386/mpspec.h	2003-01-19 10:08:15.000000000 -0800
@@ -206,7 +206,7 @@ extern int quad_local_to_mp_bus_id [NR_C
 extern int mp_bus_id_to_pci_bus [MAX_MP_BUSSES];
 
 extern unsigned int boot_cpu_physical_apicid;
-extern unsigned long phys_cpu_present_map;
+extern cpumask_t phys_cpu_present_map;
 extern int smp_found_config;
 extern void find_smp_config (void);
 extern void get_smp_config (void);
diff -urpN mm1-2.5.59/include/asm-i386/smp.h cpu-2.5.59-1/include/asm-i386/smp.h
--- mm1-2.5.59/include/asm-i386/smp.h	2003-01-16 18:22:18.000000000 -0800
+++ cpu-2.5.59-1/include/asm-i386/smp.h	2003-01-19 10:14:55.000000000 -0800
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
+#define cpu_possible(cpu) test_bit(cpu, cpu_callout_map.mask)
 
 /* We don't mark CPUs online until __cpu_up(), so we need another measure */
 static inline int num_booting_cpus(void)
 {
-	return hweight32(cpu_callout_map);
+	return bitmap_weight((unsigned long *)cpu_callout_map.mask, NR_CPUS);
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
diff -urpN mm1-2.5.59/include/asm-i386/topology.h cpu-2.5.59-1/include/asm-i386/topology.h
--- mm1-2.5.59/include/asm-i386/topology.h	2003-01-16 18:21:41.000000000 -0800
+++ cpu-2.5.59-1/include/asm-i386/topology.h	2003-01-19 13:09:24.000000000 -0800
@@ -29,8 +29,10 @@
 
 #ifdef CONFIG_NUMA
 
+#include <linux/cpumask.h>
+
 /* Mappings between logical cpu number and node number */
-extern volatile unsigned long node_2_cpu_mask[];
+extern volatile cpumask_t node_2_cpu_mask[];
 extern volatile int cpu_2_node[];
 
 /* Returns the number of the node containing CPU 'cpu' */
@@ -47,7 +49,7 @@ static inline int __cpu_to_node(int cpu)
 #define __parent_node(node) (node)
 
 /* Returns a bitmask of CPUs on Node 'node'. */
-static inline unsigned long __node_to_cpu_mask(int node)
+static inline cpumask_t __node_to_cpu_mask(int node)
 {
 	return node_2_cpu_mask[node];
 }
@@ -55,7 +57,8 @@ static inline unsigned long __node_to_cp
 /* Returns the number of the first CPU on Node 'node'. */
 static inline int __node_to_first_cpu(int node)
 { 
-	return __ffs(__node_to_cpu_mask(node));
+	cpumask_t mask = __node_to_cpu_mask(node);
+	return first_cpu(mask);
 }
 
 /* Returns the number of the first MemBlk on Node 'node' */
diff -urpN mm1-2.5.59/include/linux/bitmap.h cpu-2.5.59-1/include/linux/bitmap.h
--- mm1-2.5.59/include/linux/bitmap.h	1969-12-31 16:00:00.000000000 -0800
+++ cpu-2.5.59-1/include/linux/bitmap.h	2003-01-19 11:11:21.000000000 -0800
@@ -0,0 +1,148 @@
+#ifndef __LINUX_BITMAP_H
+#define __LINUX_BITMAP_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/bitops.h>
+
+#define DECLARE_BITMAP(name,bits) \
+	unsigned long name[((bits)+BITS_PER_LONG-1)/BITS_PER_LONG]
+#define CLEAR_BITMAP(name,bits) \
+	memset(name, 0, ((bits)+BITS_PER_LONG-1)/8)
+
+static inline int bitmap_empty(unsigned long *bitmap, int bits)
+{
+	int k;
+	for (k = 0; k < bits/BITS_PER_LONG; ++k)
+		if (bitmap[k])
+			return 0;
+
+	if (bits % BITS_PER_LONG)
+		return (bitmap[k+1] & (~0UL >> (bits % BITS_PER_LONG))) == 0;
+
+	return 1;
+}
+
+static inline int bitmap_full(unsigned long *bitmap, int bits)
+{
+	int k;
+	for (k = 0; k < bits/BITS_PER_LONG; ++k)
+		if (~bitmap[k])
+			return 0;
+
+	if (bits % BITS_PER_LONG)
+		return (~bitmap[k+1] & (~0UL >> (bits % BITS_PER_LONG))) == 0;
+
+	return 1;
+}
+
+static inline int bitmap_equal(unsigned long *bitmap1, unsigned long *bitmap2, int bits)
+{
+	int k;
+	for (k = 0; k < bits/BITS_PER_LONG; ++k)
+		if (bitmap1[k] != bitmap2[k])
+			return 0;
+
+	if (bits % BITS_PER_LONG) {
+		unsigned long mask = ~0UL >> (bits % BITS_PER_LONG);
+		return (bitmap1[k+1] & mask) == (bitmap2[k+1] & mask);
+	}
+	return 1;
+}
+
+static inline void bitmap_complement(unsigned long *bitmap, int bits)
+{
+	int k;
+
+	for (k = 0; k < (bits+BITS_PER_LONG-1)/BITS_PER_LONG; ++k)
+		bitmap[k] = ~bitmap[k];
+}
+
+static inline void bitmap_clear(unsigned long *bitmap, int bits)
+{
+	CLEAR_BITMAP(bitmap, bits);
+}
+
+static inline void bitmap_fill(unsigned long *bitmap, int bits)
+{
+	memset(bitmap, 0xf, (bits+BITS_PER_LONG/8-1)/8);
+}
+
+static inline void bitmap_copy(unsigned long *dst, unsigned long *src, int bits)
+{
+	memcpy(dst, src, (bits+BITS_PER_LONG/8-1)/8);
+}
+
+static inline void bitmap_shift_left(unsigned long *,unsigned long *,int,int);
+static inline void bitmap_shift_right(unsigned long *dst, unsigned long *src, int shift, int bits)
+{
+	int k;
+	DECLARE_BITMAP(__shr_tmp, bits);
+
+	bitmap_clear(__shr_tmp, bits);
+	for (k = 0; k < bits - shift; ++k)
+		if (test_bit(k + shift, src))
+			set_bit(k, __shr_tmp);
+	bitmap_copy(dst, __shr_tmp, bits);
+}
+
+static inline void bitmap_shift_left(unsigned long *dst, unsigned long *src, int shift, int bits)
+{
+	int k;
+	DECLARE_BITMAP(__shl_tmp, bits);
+
+	bitmap_clear(__shl_tmp, bits);
+	for (k = bits; k >= shift; --k)
+		if (test_bit(k - shift, src))
+			set_bit(k, __shl_tmp);
+	bitmap_copy(dst, __shl_tmp, bits);
+}
+
+static inline void bitmap_and(unsigned long *dst, unsigned long *bitmap1, unsigned long *bitmap2, int bits)
+{
+	int k;
+
+	for (k = 0; k < (bits+BITS_PER_LONG-1)/BITS_PER_LONG; ++k)
+		dst[k] = bitmap1[k] & bitmap2[k];
+}
+
+static inline void bitmap_or(unsigned long *dst, unsigned long *bitmap1, unsigned long *bitmap2, int bits)
+{
+	int k;
+
+	for (k = 0; k < (bits+BITS_PER_LONG-1)/BITS_PER_LONG; ++k)
+		dst[k] = bitmap1[k] | bitmap2[k];
+}
+
+#if BITS_PER_LONG == 32
+static inline int bitmap_weight(unsigned long *bitmap, int bits)
+{
+	int k, w = 0;
+
+	for (k = 0; k < bits/BITS_PER_LONG; ++k)
+		w += hweight32(bitmap[k]);
+
+	if (bits % BITS_PER_LONG)
+		w += hweight32(bitmap[k] & (~0UL >> (bits % BITS_PER_LONG)));
+
+	return w;
+}
+#elif BITS_PER_LONG == 64
+static inline int bitmap_weight(unsigned long *bitmap, int bits)
+{
+	int k, w = 0;
+	u32 *map = (u32 *)bitmap;
+
+	for (k = 0; k < bits/32; ++k)
+		w += hweight32(map[k]);
+
+	if (bits % 32)
+		w += hweight32(map[k] & (~0UL >> (bits % 32)));
+
+	return w;
+}
+#endif
+
+#endif
+
+#endif /* __LINUX_BITMAP_H */
diff -urpN mm1-2.5.59/include/linux/cpumask.h cpu-2.5.59-1/include/linux/cpumask.h
--- mm1-2.5.59/include/linux/cpumask.h	1969-12-31 16:00:00.000000000 -0800
+++ cpu-2.5.59-1/include/linux/cpumask.h	2003-01-19 11:53:27.000000000 -0800
@@ -0,0 +1,51 @@
+#ifndef __LINUX_CPUMASK_H
+#define __LINUX_CPUMASK_H
+
+#include <linux/bitmap.h>
+
+#define CPU_ARRAY_SIZE		((NR_CPUS + BITS_PER_LONG - 1)/BITS_PER_LONG)
+
+struct cpumask
+{
+	unsigned long mask[(NR_CPUS+BITS_PER_LONG-1)/BITS_PER_LONG];
+};
+
+typedef struct cpumask cpumask_t;
+
+extern cpumask_t cpu_online_map;
+
+#define cpu_online(cpu)		test_bit(cpu, cpu_online_map.mask)
+#define num_online_cpus()	bitmap_weight(cpu_online_map.mask, NR_CPUS)
+#define any_online_cpu(map)	find_first_zero_bit((map).mask, NR_CPUS)
+
+#define cpu_set(cpu, map)		set_bit(cpu, (map).mask)
+#define cpu_clear(cpu, map)		clear_bit(cpu, (map).mask)
+#define cpu_isset(cpu, map)		test_bit(cpu, (map).mask)
+#define cpu_test_and_set(cpu, map)	test_and_set_bit(cpu, (map).mask)
+
+#define cpus_and(dst,src1,src2)	bitmap_and((dst).mask,(src1).mask, (src2).mask, NR_CPUS)
+#define cpus_or(dst,src1,src2)	bitmap_or((dst).mask, (src1).mask, (src2).mask, NR_CPUS)
+#define cpus_equal(map1, map2)	bitmap_equal((map1).mask, (map2).mask, NR_CPUS)
+#define first_cpu(map)		find_first_zero_bit((map).mask, NR_CPUS)
+#define next_cpu(cpu, map)	find_next_zero_bit((map).mask, NR_CPUS, cpu)
+
+static inline int next_online_cpu(int cpu, cpumask_t map)
+{
+	do
+		cpu = next_cpu(cpu, map);
+	while (cpu < NR_CPUS && !cpu_online(cpu));
+	return cpu;
+}
+
+#define for_each_cpu(cpu, map)						\
+	for (cpu = first_cpu(map); cpu < NR_CPUS; cpu = next_cpu(cpu,map))
+#define for_each_online_cpu(cpu, map)					\
+	for (cpu = first_cpu(map); cpu < NR_CPUS; cpu = next_online_cpu(cpu,map))
+
+/*
+ * um, these need to be usable as static initializers
+ */
+#define CPU_MASK_ALL	{ {[0 ... CPU_ARRAY_SIZE-1] = ~0UL} }
+#define CPU_MASK_NONE	{ {[0 ... CPU_ARRAY_SIZE-1] =  0UL} }
+
+#endif /* __LINUX_CPUMASK_H */
diff -urpN mm1-2.5.59/include/linux/init_task.h cpu-2.5.59-1/include/linux/init_task.h
--- mm1-2.5.59/include/linux/init_task.h	2003-01-16 18:21:38.000000000 -0800
+++ cpu-2.5.59-1/include/linux/init_task.h	2003-01-19 13:14:33.000000000 -0800
@@ -63,7 +63,7 @@
 	.prio		= MAX_PRIO-20,					\
 	.static_prio	= MAX_PRIO-20,					\
 	.policy		= SCHED_NORMAL,					\
-	.cpus_allowed	= ~0UL,						\
+	.cpus_allowed	= CPU_MASK_ALL,					\
 	.mm		= NULL,						\
 	.active_mm	= &init_mm,					\
 	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\
diff -urpN mm1-2.5.59/include/linux/irq.h cpu-2.5.59-1/include/linux/irq.h
--- mm1-2.5.59/include/linux/irq.h	2003-01-16 18:22:04.000000000 -0800
+++ cpu-2.5.59-1/include/linux/irq.h	2003-01-19 10:18:01.000000000 -0800
@@ -44,7 +44,7 @@ struct hw_interrupt_type {
 	void (*disable)(unsigned int irq);
 	void (*ack)(unsigned int irq);
 	void (*end)(unsigned int irq);
-	void (*set_affinity)(unsigned int irq, unsigned long mask);
+	void (*set_affinity)(unsigned int irq, cpumask_t mask);
 };
 
 typedef struct hw_interrupt_type  hw_irq_controller;
diff -urpN mm1-2.5.59/include/linux/node.h cpu-2.5.59-1/include/linux/node.h
--- mm1-2.5.59/include/linux/node.h	2003-01-16 18:22:44.000000000 -0800
+++ cpu-2.5.59-1/include/linux/node.h	2003-01-19 13:17:49.000000000 -0800
@@ -22,7 +22,7 @@
 #include <linux/device.h>
 
 struct node {
-	unsigned long cpumap;	/* Bitmap of CPUs on the Node */
+	cpumask_t cpumap;	/* Bitmap of CPUs on the Node */
 	struct sys_root sysroot;
 };
 
diff -urpN mm1-2.5.59/include/linux/rcupdate.h cpu-2.5.59-1/include/linux/rcupdate.h
--- mm1-2.5.59/include/linux/rcupdate.h	2003-01-16 18:21:47.000000000 -0800
+++ cpu-2.5.59-1/include/linux/rcupdate.h	2003-01-19 12:14:16.000000000 -0800
@@ -67,7 +67,7 @@ struct rcu_ctrlblk {
 	spinlock_t	mutex;		/* Guard this struct                  */
 	long		curbatch;	/* Current batch number.	      */
 	long		maxbatch;	/* Max requested batch number.        */
-	unsigned long	rcu_cpu_mask; 	/* CPUs that need to switch in order  */
+	cpumask_t	rcu_cpu_mask; 	/* CPUs that need to switch in order  */
 					/* for current batch to proceed.      */
 };
 
@@ -114,7 +114,7 @@ static inline int rcu_pending(int cpu) 
 	     rcu_batch_before(RCU_batch(cpu), rcu_ctrlblk.curbatch)) ||
 	    (list_empty(&RCU_curlist(cpu)) &&
 			 !list_empty(&RCU_nxtlist(cpu))) ||
-	    test_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask))
+	    cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask))
 		return 1;
 	else
 		return 0;
diff -urpN mm1-2.5.59/include/linux/sched.h cpu-2.5.59-1/include/linux/sched.h
--- mm1-2.5.59/include/linux/sched.h	2003-01-17 01:04:43.000000000 -0800
+++ cpu-2.5.59-1/include/linux/sched.h	2003-01-19 12:58:17.000000000 -0800
@@ -199,7 +199,7 @@ struct mm_struct {
 	unsigned long arg_start, arg_end, env_start, env_end;
 	unsigned long rss, total_vm, locked_vm;
 	unsigned long def_flags;
-	unsigned long cpu_vm_mask;
+	cpumask_t cpu_vm_mask;
 	unsigned long swap_address;
 
 	unsigned dumpable:1;
@@ -298,7 +298,7 @@ struct task_struct {
 	unsigned long sleep_timestamp;
 
 	unsigned long policy;
-	unsigned long cpus_allowed;
+	cpumask_t cpus_allowed;
 	unsigned int time_slice, first_time_slice;
 
 	struct list_head tasks;
@@ -444,7 +444,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PT_TRACE_EXEC	0x00000080
 
 #if CONFIG_SMP
-extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
+extern void set_cpus_allowed(task_t *p, cpumask_t new_mask);
 #else
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
diff -urpN mm1-2.5.59/include/linux/types.h cpu-2.5.59-1/include/linux/types.h
--- mm1-2.5.59/include/linux/types.h	2003-01-16 18:22:41.000000000 -0800
+++ cpu-2.5.59-1/include/linux/types.h	2003-01-19 09:57:27.000000000 -0800
@@ -3,15 +3,11 @@
 
 #ifdef	__KERNEL__
 #include <linux/config.h>
-
-#define DECLARE_BITMAP(name,bits) \
-	unsigned long name[((bits)+BITS_PER_LONG-1)/BITS_PER_LONG]
-#define CLEAR_BITMAP(name,bits) \
-	memset(name, 0, ((bits)+BITS_PER_LONG-1)/8)
 #endif
 
 #include <linux/posix_types.h>
 #include <asm/types.h>
+#include <linux/bitmap.h>
 
 #ifndef __KERNEL_STRICT_NAMES
 
diff -urpN mm1-2.5.59/kernel/fork.c cpu-2.5.59-1/kernel/fork.c
--- mm1-2.5.59/kernel/fork.c	2003-01-16 18:21:38.000000000 -0800
+++ cpu-2.5.59-1/kernel/fork.c	2003-01-19 12:30:54.000000000 -0800
@@ -235,7 +235,7 @@ static inline int dup_mmap(struct mm_str
 	mm->free_area_cache = TASK_UNMAPPED_BASE;
 	mm->map_count = 0;
 	mm->rss = 0;
-	mm->cpu_vm_mask = 0;
+	bitmap_clear(mm->cpu_vm_mask.mask, NR_CPUS);
 	pprev = &mm->mmap;
 
 	/*
diff -urpN mm1-2.5.59/kernel/module.c cpu-2.5.59-1/kernel/module.c
--- mm1-2.5.59/kernel/module.c	2003-01-16 18:22:25.000000000 -0800
+++ cpu-2.5.59-1/kernel/module.c	2003-01-19 13:25:28.000000000 -0800
@@ -220,6 +220,7 @@ static int stopref(void *cpu)
 {
 	int irqs_disabled = 0;
 	int prepared = 0;
+	cpumask_t allowed_mask = CPU_MASK_NONE;
 
 	sprintf(current->comm, "kmodule%lu\n", (unsigned long)cpu);
 
@@ -228,7 +229,8 @@ static int stopref(void *cpu)
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO-1 };
 	setscheduler(current->pid, SCHED_FIFO, &param);
 #endif
-	set_cpus_allowed(current, 1UL << (unsigned long)cpu);
+	cpu_set((int)cpu, allowed_mask);
+	set_cpus_allowed(current, allowed_mask);
 
 	/* Ack: we are alive */
 	atomic_inc(&stopref_thread_ack);
@@ -281,7 +283,7 @@ static void stopref_set_state(enum stopr
 static int stop_refcounts(void)
 {
 	unsigned int i, cpu;
-	unsigned long old_allowed;
+	cpumask_t old_allowed, allowed_mask = CPU_MASK_NONE;
 	int ret = 0;
 
 	/* One thread per cpu.  We'll do our own. */
@@ -289,7 +291,8 @@ static int stop_refcounts(void)
 
 	/* FIXME: racy with set_cpus_allowed. */
 	old_allowed = current->cpus_allowed;
-	set_cpus_allowed(current, 1UL << (unsigned long)cpu);
+	cpu_set(cpu, allowed_mask);
+	set_cpus_allowed(current, allowed_mask);
 
 	atomic_set(&stopref_thread_ack, 0);
 	stopref_num_threads = 0;
diff -urpN mm1-2.5.59/kernel/rcupdate.c cpu-2.5.59-1/kernel/rcupdate.c
--- mm1-2.5.59/kernel/rcupdate.c	2003-01-16 18:21:34.000000000 -0800
+++ cpu-2.5.59-1/kernel/rcupdate.c	2003-01-19 12:26:01.000000000 -0800
@@ -47,7 +47,7 @@
 /* Definition for rcupdate control block. */
 struct rcu_ctrlblk rcu_ctrlblk = 
 	{ .mutex = SPIN_LOCK_UNLOCKED, .curbatch = 1, 
-	  .maxbatch = 1, .rcu_cpu_mask = 0 };
+	  .maxbatch = 1, .rcu_cpu_mask = CPU_MASK_NONE };
 DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
 
 /* Fake initialization required by compiler */
@@ -106,7 +106,7 @@ static void rcu_start_batch(long newbatc
 		rcu_ctrlblk.maxbatch = newbatch;
 	}
 	if (rcu_batch_before(rcu_ctrlblk.maxbatch, rcu_ctrlblk.curbatch) ||
-	    (rcu_ctrlblk.rcu_cpu_mask != 0)) {
+	    (any_online_cpu(rcu_ctrlblk.rcu_cpu_mask) < NR_CPUS)) {
 		return;
 	}
 	rcu_ctrlblk.rcu_cpu_mask = cpu_online_map;
@@ -121,7 +121,7 @@ static void rcu_check_quiescent_state(vo
 {
 	int cpu = smp_processor_id();
 
-	if (!test_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask)) {
+	if (!cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask)) {
 		return;
 	}
 
@@ -139,13 +139,13 @@ static void rcu_check_quiescent_state(vo
 	}
 
 	spin_lock(&rcu_ctrlblk.mutex);
-	if (!test_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask)) {
+	if (!cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask)) {
 		spin_unlock(&rcu_ctrlblk.mutex);
 		return;
 	}
-	clear_bit(cpu, &rcu_ctrlblk.rcu_cpu_mask);
+	cpu_clear(cpu, rcu_ctrlblk.rcu_cpu_mask);
 	RCU_last_qsctr(cpu) = RCU_QSCTR_INVALID;
-	if (rcu_ctrlblk.rcu_cpu_mask != 0) {
+	if (any_online_cpu(rcu_ctrlblk.rcu_cpu_mask) < NR_CPUS) {
 		spin_unlock(&rcu_ctrlblk.mutex);
 		return;
 	}
diff -urpN mm1-2.5.59/kernel/sched.c cpu-2.5.59-1/kernel/sched.c
--- mm1-2.5.59/kernel/sched.c	2003-01-17 01:04:43.000000000 -0800
+++ cpu-2.5.59-1/kernel/sched.c	2003-01-19 13:22:07.000000000 -0800
@@ -478,7 +478,7 @@ repeat_lock_task:
 		 */
 		if (unlikely(sync && !task_running(rq, p) &&
 			(task_cpu(p) != smp_processor_id()) &&
-			(p->cpus_allowed & (1UL << smp_processor_id())))) {
+			cpu_isset(smp_processor_id(), p->cpus_allowed))) {
 
 			set_task_cpu(p, smp_processor_id());
 			task_rq_unlock(rq, &flags);
@@ -693,13 +693,14 @@ static inline void double_rq_unlock(runq
  */
 static void sched_migrate_task(task_t *p, int dest_cpu)
 {
-	unsigned long old_mask;
+	cpumask_t old_mask, new_mask = CPU_MASK_NONE;
 
 	old_mask = p->cpus_allowed;
-	if (!(old_mask & (1UL << dest_cpu)))
+	if (!cpu_isset(dest_cpu, old_mask))
 		return;
 	/* force the process onto the specified CPU */
-	set_cpus_allowed(p, 1UL << dest_cpu);
+	cpu_set(dest_cpu, new_mask);
+	set_cpus_allowed(p, new_mask);
 
 	/* restore the cpus allowed mask */
 	set_cpus_allowed(p, old_mask);
@@ -712,7 +713,7 @@ static void sched_migrate_task(task_t *p
 static int sched_best_cpu(struct task_struct *p)
 {
 	int i, minload, load, best_cpu, node = 0;
-	unsigned long cpumask;
+	cpumask_t cpumask;
 
 	best_cpu = task_cpu(p);
 	if (cpu_rq(best_cpu)->nr_running <= 2)
@@ -730,7 +731,7 @@ static int sched_best_cpu(struct task_st
 	minload = 10000000;
 	cpumask = __node_to_cpu_mask(node);
 	for (i = 0; i < NR_CPUS; ++i) {
-		if (!(cpumask & (1UL << i)))
+		if (!cpu_isset(i, cpumask))
 			continue;
 		if (cpu_rq(i)->nr_running < minload) {
 			best_cpu = i;
@@ -778,7 +779,7 @@ static int find_busiest_node(int this_no
 	return node;
 }
 
-static inline unsigned long cpus_to_balance(int this_cpu, runqueue_t *this_rq)
+static inline cpumask_t cpus_to_balance(int this_cpu, runqueue_t *this_rq)
 {
 	int this_node = __cpu_to_node(this_cpu);
 	/*
@@ -788,15 +789,18 @@ static inline unsigned long cpus_to_bala
 	if (++(this_rq->nr_balanced) == NODE_BALANCE_RATE) {
 		int node = find_busiest_node(this_node);
 		this_rq->nr_balanced = 0;
-		if (node >= 0)
-			return (__node_to_cpu_mask(node) | (1UL << this_cpu));
+		if (node >= 0) {
+			cpumask_t node_mask = __node_to_cpu_mask(node);
+			cpu_set(this_cpu, node_mask);
+			return node_mask;
+		}
 	}
 	return __node_to_cpu_mask(this_node);
 }
 
 #else /* !CONFIG_NUMA */
 
-static inline unsigned long cpus_to_balance(int this_cpu, runqueue_t *this_rq)
+static inline cpumask_t cpus_to_balance(int this_cpu, runqueue_t *this_rq)
 {
 	return cpu_online_map;
 }
@@ -833,7 +837,7 @@ static inline unsigned int double_lock_b
 /*
  * find_busiest_queue - find the busiest runqueue among the cpus in cpumask.
  */
-static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance, unsigned long cpumask)
+static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance, cpumask_t cpumask)
 {
 	int nr_running, load, max_load, i;
 	runqueue_t *busiest, *rq_src;
@@ -868,7 +872,7 @@ static inline runqueue_t *find_busiest_q
 	busiest = NULL;
 	max_load = 1;
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!((1UL << i) & cpumask))
+		if (!cpu_isset(i, cpumask))
 			continue;
 
 		rq_src = cpu_rq(i);
@@ -990,7 +994,7 @@ skip_queue:
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
 	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
 		!task_running(rq, p) &&					\
-			((p)->cpus_allowed & (1UL << (this_cpu))))
+			(cpu_isset(this_cpu, (p)->cpus_allowed)))
 
 	curr = curr->prev;
 
@@ -1805,7 +1809,7 @@ out_unlock:
 asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
 				      unsigned long *user_mask_ptr)
 {
-	unsigned long new_mask;
+	cpumask_t new_mask;
 	int retval;
 	task_t *p;
 
@@ -1815,8 +1819,8 @@ asmlinkage int sys_sched_setaffinity(pid
 	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
 		return -EFAULT;
 
-	new_mask &= cpu_online_map;
-	if (!new_mask)
+	cpus_and(new_mask, new_mask, cpu_online_map);
+	if (any_online_cpu(new_mask) >= NR_CPUS)
 		return -EINVAL;
 
 	read_lock(&tasklist_lock);
@@ -1858,7 +1862,7 @@ asmlinkage int sys_sched_getaffinity(pid
 				      unsigned long *user_mask_ptr)
 {
 	unsigned int real_len;
-	unsigned long mask;
+	cpumask_t mask;
 	int retval;
 	task_t *p;
 
@@ -1874,7 +1878,7 @@ asmlinkage int sys_sched_getaffinity(pid
 		goto out_unlock;
 
 	retval = 0;
-	mask = p->cpus_allowed & cpu_online_map;
+	cpus_and(mask, p->cpus_allowed, cpu_online_map);
 
 out_unlock:
 	read_unlock(&tasklist_lock);
@@ -2222,16 +2226,15 @@ typedef struct {
  * task must not exit() & deallocate itself prematurely.  The
  * call is not atomic; no spinlocks may be held.
  */
-void set_cpus_allowed(task_t *p, unsigned long new_mask)
+void set_cpus_allowed(task_t *p, cpumask_t new_mask)
 {
 	unsigned long flags;
 	migration_req_t req;
 	runqueue_t *rq;
 
 #if 0 /* FIXME: Grab cpu_lock, return error on this case. --RR */
-	new_mask &= cpu_online_map;
-	if (!new_mask)
-		BUG();
+	cpus_and(new_mask, new_mask, cpu_online_map);
+	BUG_ON(any_online_cpu(new_mask) >= NR_CPUS);
 #endif
 
 	rq = task_rq_lock(p, &flags);
@@ -2240,7 +2243,7 @@ void set_cpus_allowed(task_t *p, unsigne
 	 * Can the task run on the task's current CPU? If not then
 	 * migrate the thread off to a proper CPU.
 	 */
-	if (new_mask & (1UL << task_cpu(p))) {
+	if (cpu_isset(task_cpu(p), new_mask)) {
 		task_rq_unlock(rq, &flags);
 		return;
 	}
@@ -2249,7 +2252,7 @@ void set_cpus_allowed(task_t *p, unsigne
 	 * it is sufficient to simply update the task's cpu field.
 	 */
 	if (!p->array && !task_running(rq, p)) {
-		set_task_cpu(p, __ffs(p->cpus_allowed));
+		set_task_cpu(p, first_cpu(p->cpus_allowed));
 		task_rq_unlock(rq, &flags);
 		return;
 	}
@@ -2273,6 +2276,7 @@ static int migration_thread(void * data)
 	int cpu = (long) data;
 	runqueue_t *rq;
 	int ret;
+	cpumask_t allowed_mask = CPU_MASK_NONE;
 
 	daemonize();
 	sigfillset(&current->blocked);
@@ -2282,7 +2286,8 @@ static int migration_thread(void * data)
 	 * Either we are running on the right CPU, or there's a
 	 * a migration thread on the target CPU, guaranteed.
 	 */
-	set_cpus_allowed(current, 1UL << cpu);
+	cpu_set(cpu, allowed_mask);
+	set_cpus_allowed(current, allowed_mask);
 
 	ret = setscheduler(0, SCHED_FIFO, &param);
 
@@ -2312,7 +2317,11 @@ static int migration_thread(void * data)
 		spin_unlock_irqrestore(&rq->lock, flags);
 
 		p = req->task;
-		cpu_dest = __ffs(p->cpus_allowed & cpu_online_map);
+		{
+			cpumask_t tmp;
+			cpus_and(tmp, p->cpus_allowed, cpu_online_map);
+			cpu_dest = first_cpu(tmp);
+		}
 		rq_dest = cpu_rq(cpu_dest);
 repeat:
 		cpu_src = task_cpu(p);
diff -urpN mm1-2.5.59/kernel/softirq.c cpu-2.5.59-1/kernel/softirq.c
--- mm1-2.5.59/kernel/softirq.c	2003-01-16 18:21:47.000000000 -0800
+++ cpu-2.5.59-1/kernel/softirq.c	2003-01-19 13:02:18.000000000 -0800
@@ -299,6 +299,7 @@ void __init softirq_init()
 static int ksoftirqd(void * __bind_cpu)
 {
 	int cpu = (int) (long) __bind_cpu;
+	cpumask_t allowed_mask = CPU_MASK_NONE;
 
 	daemonize();
 	set_user_nice(current, 19);
@@ -306,9 +307,9 @@ static int ksoftirqd(void * __bind_cpu)
 	sigfillset(&current->blocked);
 
 	/* Migrate to the right CPU */
-	set_cpus_allowed(current, 1UL << cpu);
-	if (smp_processor_id() != cpu)
-		BUG();
+	cpu_set(cpu, allowed_mask);
+	set_cpus_allowed(current, allowed_mask);
+	BUG_ON(smp_processor_id() != cpu);
 
 	sprintf(current->comm, "ksoftirqd/%d", cpu);
 
diff -urpN mm1-2.5.59/kernel/workqueue.c cpu-2.5.59-1/kernel/workqueue.c
--- mm1-2.5.59/kernel/workqueue.c	2003-01-17 01:04:43.000000000 -0800
+++ cpu-2.5.59-1/kernel/workqueue.c	2003-01-19 13:02:50.000000000 -0800
@@ -171,6 +171,7 @@ static int worker_thread(void *__startup
 	int cpu = cwq - cwq->wq->cpu_wq;
 	DECLARE_WAITQUEUE(wait, current);
 	struct k_sigaction sa;
+	cpumask_t allowed_mask = CPU_MASK_NONE;
 
 	daemonize();
 	sprintf(current->comm, "%s/%d", startup->name, cpu);
@@ -178,7 +179,8 @@ static int worker_thread(void *__startup
 	cwq->thread = current;
 
 	set_user_nice(current, -10);
-	set_cpus_allowed(current, 1UL << cpu);
+	cpu_set(cpu, allowed_mask);
+	set_cpus_allowed(current, allowed_mask);
 
 	spin_lock_irq(&current->sig->siglock);
 	siginitsetinv(&current->blocked, sigmask(SIGCHLD));
