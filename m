Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264148AbTDOW44 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 18:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264149AbTDOW44 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 18:56:56 -0400
Received: from holomorphy.com ([66.224.33.161]:6280 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264148AbTDOW4e 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 18:56:34 -0400
Date: Tue, 15 Apr 2003 16:08:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [cpumask_t 3/3] ia64 changes for 2.5.67-bk6
Message-ID: <20030415230803.GJ706@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20030415225036.GE12487@holomorphy.com> <20030415225843.GI706@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030415225843.GI706@holomorphy.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 15, 2003 at 03:58:43PM -0700, William Lee Irwin III wrote:
> i386 changes for extended cpu masks. Basically force various things

ia64 changes for extended cpu masks. Written by Martin Hicks, with
some porting between 2.5.67 virgin and 2.5.67-bk6 by me (i.e. blame me
for mistakes in perfmon.c and palinfo.c, the rest is his fault =).

The same principles as i386 hold, though without quite as much cruft
to work around since it's a 64-bit arch and the interrupt controller
wasn't lobotomized at birth (or so it seems at first glance...).


diff -urpN linux-2.5.67-bk6/arch/ia64/kernel/iosapic.c cpu-2.5.67-bk6-1/arch/ia64/kernel/iosapic.c
--- linux-2.5.67-bk6/arch/ia64/kernel/iosapic.c	2003-04-07 10:31:18.000000000 -0700
+++ cpu-2.5.67-bk6-1/arch/ia64/kernel/iosapic.c	2003-04-15 14:39:36.000000000 -0700
@@ -274,7 +274,7 @@ unmask_irq (unsigned int irq)
 
 
 static void
-iosapic_set_affinity (unsigned int irq, unsigned long mask)
+iosapic_set_affinity (unsigned int irq, unsigned long arg)
 {
 #ifdef CONFIG_SMP
 	unsigned long flags;
@@ -283,16 +283,19 @@ iosapic_set_affinity (unsigned int irq, 
 	char *addr;
 	int redir = (irq & IA64_IRQ_REDIRECTED) ? 1 : 0;
 	ia64_vector vec;
+	cpumask_t tmp, mask = *(cpumask_t *)arg;
 
 	irq &= (~IA64_IRQ_REDIRECTED);
 	vec = irq_to_vector(irq);
 
-	mask &= cpu_online_map;
+	cpus_and(mask, mask, cpu_online_map);
 
-	if (!mask || vec >= IA64_NUM_VECTORS)
+	if (cpus_empty(mask) || vec >= IA64_NUM_VECTORS)
 		return;
 
-	dest = cpu_physical_id(ffz(~mask));
+	tmp = mask;
+	cpus_complement(tmp);
+	dest = cpu_physical_id(first_cpu(tmp));
 
 	rte_index = iosapic_intr_info[vec].rte_index;
 	addr = iosapic_intr_info[vec].addr;
diff -urpN linux-2.5.67-bk6/arch/ia64/kernel/irq.c cpu-2.5.67-bk6-1/arch/ia64/kernel/irq.c
--- linux-2.5.67-bk6/arch/ia64/kernel/irq.c	2003-04-07 10:32:28.000000000 -0700
+++ cpu-2.5.67-bk6-1/arch/ia64/kernel/irq.c	2003-04-15 14:39:36.000000000 -0700
@@ -806,12 +806,13 @@ int setup_irq(unsigned int irq, struct i
 static struct proc_dir_entry * root_irq_dir;
 static struct proc_dir_entry * irq_dir [NR_IRQS];
 
-#define HEX_DIGITS 8
+#define HEX_DIGITS (2*sizeof(cpumask_t))
 
-static int parse_hex_value (const char *buffer, unsigned long count, unsigned long *ret)
+static int parse_hex_value (const char *buffer, unsigned long count, 
+			    cpumask_t *ret)
 {
 	unsigned char hexnum [HEX_DIGITS];
-	unsigned long value;
+	cpumask_t value = CPU_MASK_NONE;
 	int i;
 
 	if (!count)
@@ -825,10 +826,9 @@ static int parse_hex_value (const char *
 	 * Parse the first 8 characters as a hex string, any non-hex char
 	 * is end-of-string. '00e1', 'e1', '00E1', 'E1' are all the same.
 	 */
-	value = 0;
-
 	for (i = 0; i < count; i++) {
 		unsigned int c = hexnum[i];
+		int k;
 
 		switch (c) {
 			case '0' ... '9': c -= '0'; break;
@@ -837,7 +837,10 @@ static int parse_hex_value (const char *
 		default:
 			goto out;
 		}
-		value = (value << 4) | c;
+		bitmap_shift_left(&cpus_coerce(value), &cpus_coerce(value), 4, NR_CPUS);
+		for (k = 0; k < 4; ++k) 
+			if (test_bit(k, (unsigned long *)&c))
+				cpu_set(k, value);
 	}
 out:
 	*ret = value;
@@ -848,12 +851,15 @@ out:
 
 static struct proc_dir_entry * smp_affinity_entry [NR_IRQS];
 
-static unsigned long irq_affinity [NR_IRQS] = { [0 ... NR_IRQS-1] = ~0UL };
+static cpumask_t irq_affinity [NR_IRQS] = { [0 ... NR_IRQS-1] = CPU_MASK_ALL };
+
 static char irq_redir [NR_IRQS]; // = { [0 ... NR_IRQS-1] = 1 };
 
 void set_irq_affinity_info (unsigned int irq, int hwid, int redir)
 {
-	unsigned long mask = 1UL<<cpu_logical_id(hwid);
+	cpumask_t mask = CPU_MASK_NONE;
+
+	cpu_set(cpu_logical_id(hwid), mask);
 
 	if (irq < NR_IRQS) {
 		irq_affinity[irq] = mask;
@@ -864,10 +870,17 @@ void set_irq_affinity_info (unsigned int
 static int irq_affinity_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
+	int k, len;
 	if (count < HEX_DIGITS+3)
 		return -EINVAL;
-	return sprintf (page, "%s%08lx\n", irq_redir[(unsigned long)data] ? "r " : "",
-			irq_affinity[(unsigned long)data]);
+
+	len = 0;
+	for (k = 0; k < CPU_ARRAY_SIZE; ++k) {
+		int j = sprintf(page, "%08lx\n", irq_affinity[(long)data].mask[k]);
+		len +=j;
+		page +=j;
+	}
+	return len;
 }
 
 static int irq_affinity_write_proc (struct file *file, const char *buffer,
@@ -875,7 +888,7 @@ static int irq_affinity_write_proc (stru
 {
 	unsigned int irq = (unsigned long) data;
 	int full_count = count, err;
-	unsigned long new_value;
+	cpumask_t new_value, tmp;
 	const char *buf = buffer;
 	int redir;
 
@@ -898,10 +911,12 @@ static int irq_affinity_write_proc (stru
 	 * way to make the system unusable accidentally :-) At least
 	 * one online CPU still has to be targeted.
 	 */
-	if (!(new_value & cpu_online_map))
+	cpus_and(tmp, new_value, cpu_online_map);
+	if (cpus_empty(tmp))
 		return -EINVAL;
 
-	irq_desc(irq)->handler->set_affinity(irq | (redir? IA64_IRQ_REDIRECTED : 0), new_value);
+	irq_desc(irq)->handler->set_affinity(irq | (redir? IA64_IRQ_REDIRECTED : 0), 
+					     (unsigned int)&new_value);
 
 	return full_count;
 }
@@ -911,18 +926,25 @@ static int irq_affinity_write_proc (stru
 static int prof_cpu_mask_read_proc (char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	unsigned long *mask = (unsigned long *) data;
+	cpumask_t *mask = (cpumask_t *)data;
+	int k, len = 0;
+
 	if (count < HEX_DIGITS+1)
 		return -EINVAL;
-	return sprintf (page, "%08lx\n", *mask);
+	for (k = 0; k < CPU_ARRAY_SIZE; ++k) {
+		int j = sprintf(page, "%08lx\n", mask->mask[k]);
+		len += j;
+		page += j;
+	}
+	return len;
 }
 
 static int prof_cpu_mask_write_proc (struct file *file, const char *buffer,
 					unsigned long count, void *data)
 {
-	unsigned long *mask = (unsigned long *) data;
-	int full_count = count, err;
-	unsigned long new_value;
+	cpumask_t *mask = (cpumask_t *)data;
+	unsigned long full_count = count, err;
+	cpumask_t new_value;
 
 	err = parse_hex_value(buffer, count, &new_value);
 	if (err)
@@ -965,7 +987,7 @@ static void register_irq_proc (unsigned 
 #endif
 }
 
-unsigned long prof_cpu_mask = -1;
+cpumask_t prof_cpu_mask = CPU_MASK_ALL;
 
 void init_irq_proc (void)
 {
diff -urpN linux-2.5.67-bk6/arch/ia64/kernel/perfmon.c cpu-2.5.67-bk6-1/arch/ia64/kernel/perfmon.c
--- linux-2.5.67-bk6/arch/ia64/kernel/perfmon.c	2003-04-15 14:37:52.000000000 -0700
+++ cpu-2.5.67-bk6-1/arch/ia64/kernel/perfmon.c	2003-04-15 15:15:52.000000000 -0700
@@ -265,7 +265,7 @@ typedef struct pfm_context {
 	pfm_counter_t		ctx_soft_pmds[IA64_NUM_PMD_REGS]; /* XXX: size should be dynamic */
 
 	u64			ctx_saved_psr;		/* copy of psr used for lazy ctxsw */
-	unsigned long		ctx_saved_cpus_allowed;	/* copy of the task cpus_allowed (system wide) */
+	cpumask_t		ctx_saved_cpus_allowed;	/* copy of the task cpus_allowed (system wide) */
 	unsigned int		ctx_cpu;		/* CPU used by system wide session */
 
 	atomic_t		ctx_last_cpu;		/* CPU id of current or last CPU used */
@@ -909,9 +909,9 @@ error_kmalloc:
 }
 
 static int
-pfm_reserve_session(struct task_struct *task, int is_syswide, unsigned long cpu_mask)
+pfm_reserve_session(struct task_struct *task, int is_syswide, cpumask_t cpu_mask)
 {
-	unsigned long m, undo_mask;
+	cpumask_t m, undo_mask;
 	unsigned int n, i;
 
 	/*
@@ -929,18 +929,20 @@ pfm_reserve_session(struct task_struct *
 			goto abort;
 		}
 
-		m = cpu_mask; undo_mask = 0UL; n = 0;
+		m = cpu_mask;
+		cpus_clear(undo_mask);
+		n = 0;
 		DBprintk(("cpu_mask=0x%lx\n", cpu_mask));
-		for(i=0; m; i++, m>>=1) {
+		for(i = 0; !cpus_empty(m); i++, cpus_shift_right(m, m, 1)) {
 
-			if ((m & 0x1) == 0UL) continue;
+			if (!cpu_isset(0, m)) continue;
 
 			if (pfm_sessions.pfs_sys_session[i]) goto undo;
 
 			DBprintk(("reserving CPU%d currently on CPU%d\n", i, smp_processor_id()));
 
 			pfm_sessions.pfs_sys_session[i] = task;
-			undo_mask |= 1UL << i;
+			cpu_set(i, undo_mask);
 			n++;
 		}
 		pfm_sessions.pfs_sys_sessions += n;
@@ -957,7 +959,7 @@ undo:
 	DBprintk(("system wide not possible, conflicting session [%d] on CPU%d\n",
   		pfm_sessions.pfs_sys_session[i]->pid, i));
 
-	for(i=0; undo_mask; i++, undo_mask >>=1) {
+	for(i=0; !cpus_empty(undo_mask); i++, cpus_shift_right(undo_mask, undo_mask, 1)) {
 		pfm_sessions.pfs_sys_session[i] = NULL;
 	}
 abort:
@@ -968,10 +970,10 @@ abort:
 }
 
 static int
-pfm_unreserve_session(struct task_struct *task, int is_syswide, unsigned long cpu_mask)
+pfm_unreserve_session(struct task_struct *task, int is_syswide, cpumask_t cpu_mask)
 {
 	pfm_context_t *ctx;
-	unsigned long m;
+	cpumask_t m;
 	unsigned int n, i;
 
 	ctx = task ? task->thread.pfm_context : NULL;
@@ -981,19 +983,11 @@ pfm_unreserve_session(struct task_struct
 	 */
 	LOCK_PFS();
 
-	DBprintk(("[%d] sys_sessions=%u task_sessions=%u dbregs=%u syswide=%d cpu_mask=0x%lx\n",
-		task->pid,
-		pfm_sessions.pfs_sys_sessions,
-		pfm_sessions.pfs_task_sessions,
-		pfm_sessions.pfs_sys_use_dbregs,
-		is_syswide,
-		cpu_mask));
-
 
 	if (is_syswide) {
 		m = cpu_mask; n = 0;
-		for(i=0; m; i++, m>>=1) {
-			if ((m & 0x1) == 0UL) continue;
+		for(i=0; !cpus_empty(m); i++, cpus_shift_right(m, m, 1)) {
+			if (cpu_isset(0, m)) continue;
 			pfm_sessions.pfs_sys_session[i] = NULL;
 			n++;
 		}
@@ -1040,6 +1034,7 @@ static int
 pfx_is_sane(struct task_struct *task, pfarg_context_t *pfx)
 {
 	unsigned long smpl_pmds = pfx->ctx_smpl_regs[0];
+	cpumask_t tmp;
 	int ctx_flags;
 	int cpu;
 
@@ -1058,7 +1053,6 @@ pfx_is_sane(struct task_struct *task, pf
 	}
 
 	if (ctx_flags & PFM_FL_SYSTEM_WIDE) {
-		DBprintk(("cpu_mask=0x%lx\n", pfx->ctx_cpu_mask));
 		/*
 		 * cannot block in this mode 
 		 */
@@ -1069,24 +1063,25 @@ pfx_is_sane(struct task_struct *task, pf
 		/*
 		 * must only have one bit set in the CPU mask
 		 */
-		if (hweight64(pfx->ctx_cpu_mask) != 1UL) {
+		if (cpus_weight(pfx->ctx_cpu_mask) != 1UL) {
 			DBprintk(("invalid CPU mask specified\n"));
 			return -EINVAL;
 		}
 		/*
 		 * and it must be a valid CPU
 		 */
-		cpu = ffz(~pfx->ctx_cpu_mask);
-		if (cpu_online(cpu) == 0) {
+		tmp = pfx->ctx_cpu_mask;
+		cpus_complement(tmp);
+		cpu = first_cpu(tmp);
+		if (!cpu_online(cpu)) {
 			DBprintk(("CPU%d is not online\n", cpu));
 			return -EINVAL;
 		}
 		/*
 		 * check for pre-existing pinning, if conflicting reject
 		 */
-		if (task->cpus_allowed != ~0UL && (task->cpus_allowed & (1UL<<cpu)) == 0) {
-			DBprintk(("[%d] pinned on 0x%lx, mask for CPU%d \n", task->pid, 
-				task->cpus_allowed, cpu));
+		if (cpus_weight(task->cpus_allowed) != NR_CPUS &&
+		    !cpu_isset(cpu, task->cpus_allowed)) {
 			return -EINVAL;
 		}
 
@@ -1125,6 +1120,7 @@ pfm_context_create(struct task_struct *t
 	int ret;
 	int ctx_flags;
 	pid_t notify_pid;
+	cpumask_t tmpmask;
 
 	/* a context has already been defined */
 	if (ctx) return -EBUSY;
@@ -1238,7 +1234,9 @@ pfm_context_create(struct task_struct *t
 	ctx->ctx_fl_protected = 0;
 
 	/* for system wide mode only (only 1 bit set) */
-	ctx->ctx_cpu = ffz(~tmp.ctx_cpu_mask);
+	tmpmask = tmp.ctx_cpu_mask;
+	cpus_complement(tmpmask);
+	ctx->ctx_cpu = first_cpu(tmpmask);
 
 	atomic_set(&ctx->ctx_last_cpu,-1); /* SMP only, means no CPU */
 
@@ -1268,7 +1266,6 @@ pfm_context_create(struct task_struct *t
 	if (ctx->ctx_fl_system) {
 		ctx->ctx_saved_cpus_allowed = task->cpus_allowed;
 		set_cpus_allowed(task, tmp.ctx_cpu_mask);
-		DBprintk(("[%d] rescheduled allowed=0x%lx\n", task->pid, task->cpus_allowed));
 	}
 
 	return 0;
@@ -3148,7 +3145,7 @@ pfm_proc_info(char *page)
 	p += sprintf(p, "ovfl_mask              : 0x%lx\n", pmu_conf.ovfl_val);
 
 	for(i=0; i < NR_CPUS; i++) {
-		if (cpu_online(i) == 0) continue;
+		if (!cpu_online(i)) continue;
 		p += sprintf(p, "CPU%-2d overflow intrs   : %lu\n", i, pfm_stats[i].pfm_ovfl_intr_count);
 		p += sprintf(p, "CPU%-2d spurious intrs   : %lu\n", i, pfm_stats[i].pfm_spurious_ovfl_intr_count);
 		p += sprintf(p, "CPU%-2d recorded samples : %lu\n", i, pfm_stats[i].pfm_recorded_samples_count);
@@ -3779,15 +3776,9 @@ pfm_inherit(struct task_struct *task, st
 	/*
 	 * clear cpu pinning restriction for child
 	 */
-	if (ctx->ctx_fl_system) {
+	if (ctx->ctx_fl_system)
 		set_cpus_allowed(task, ctx->ctx_saved_cpus_allowed);
 
-	 	DBprintk(("setting cpus_allowed for [%d] to 0x%lx from 0x%lx\n", 
-			task->pid,
-			ctx->ctx_saved_cpus_allowed, 
-			current->cpus_allowed));
-	}
-
 	/*
 	 * takes care of easiest case first
 	 */
@@ -3934,6 +3925,7 @@ void
 pfm_context_exit(struct task_struct *task)
 {
 	pfm_context_t *ctx = task->thread.pfm_context;
+	cpumask_t mask = CPU_MASK_NONE;
 
 	/*
 	 * check sampling buffer
@@ -4033,7 +4025,8 @@ pfm_context_exit(struct task_struct *tas
 	UNLOCK_CTX(ctx);
 	preempt_enable();
 
-	pfm_unreserve_session(task, ctx->ctx_fl_system, 1UL << ctx->ctx_cpu);
+	cpu_set(ctx->ctx_cpu, mask);
+	pfm_unreserve_session(task, ctx->ctx_fl_system, mask);
 
 	if (ctx->ctx_fl_system) {
 		/*
diff -urpN linux-2.5.67-bk6/arch/ia64/kernel/setup.c cpu-2.5.67-bk6-1/arch/ia64/kernel/setup.c
--- linux-2.5.67-bk6/arch/ia64/kernel/setup.c	2003-04-07 10:30:43.000000000 -0700
+++ cpu-2.5.67-bk6-1/arch/ia64/kernel/setup.c	2003-04-15 14:39:40.000000000 -0700
@@ -541,7 +541,7 @@ static void *
 c_start (struct seq_file *m, loff_t *pos)
 {
 #ifdef CONFIG_SMP
-	while (*pos < NR_CPUS && !(cpu_online_map & (1UL << *pos)))
+	while (*pos < NR_CPUS && !cpu_isset(*pos, cpu_online_map))
 		++*pos;
 #endif
 	return *pos < NR_CPUS ? cpu_data(*pos) : NULL;
diff -urpN linux-2.5.67-bk6/arch/ia64/kernel/smp.c cpu-2.5.67-bk6-1/arch/ia64/kernel/smp.c
--- linux-2.5.67-bk6/arch/ia64/kernel/smp.c	2003-04-07 10:32:58.000000000 -0700
+++ cpu-2.5.67-bk6-1/arch/ia64/kernel/smp.c	2003-04-15 14:39:40.000000000 -0700
@@ -81,7 +81,7 @@ stop_this_cpu (void)
 	/*
 	 * Remove this CPU:
 	 */
-	clear_bit(smp_processor_id(), &cpu_online_map);
+	cpu_clear(smp_processor_id(), cpu_online_map);
 	max_xtp();
 	local_irq_disable();
 	cpu_halt();
diff -urpN linux-2.5.67-bk6/arch/ia64/kernel/smpboot.c cpu-2.5.67-bk6-1/arch/ia64/kernel/smpboot.c
--- linux-2.5.67-bk6/arch/ia64/kernel/smpboot.c	2003-04-15 14:37:52.000000000 -0700
+++ cpu-2.5.67-bk6-1/arch/ia64/kernel/smpboot.c	2003-04-15 14:39:40.000000000 -0700
@@ -79,13 +79,13 @@ int cpucount;
 task_t *task_for_booting_cpu;
 
 /* Bitmask of currently online CPUs */
-volatile unsigned long cpu_online_map;
-unsigned long phys_cpu_present_map;
+volatile cpumask_t cpu_online_map;
+cpumask_t phys_cpu_present_map;
 
 /* which logical CPU number maps to which CPU (physical APIC ID) */
 volatile int ia64_cpu_to_sapicid[NR_CPUS];
 
-static volatile unsigned long cpu_callin_map;
+static volatile cpumask_t cpu_callin_map;
 
 struct smp_boot_data smp_boot_data __initdata;
 
@@ -271,7 +271,7 @@ smp_callin (void)
 	cpuid = smp_processor_id();
 	phys_id = hard_smp_processor_id();
 
-	if (test_and_set_bit(cpuid, &cpu_online_map)) {
+	if (cpu_test_and_set(cpuid, cpu_online_map)) {
 		printk(KERN_ERR "huh, phys CPU#0x%x, CPU#0x%x already present??\n",
 		       phys_id, cpuid);
 		BUG();
@@ -313,7 +313,7 @@ smp_callin (void)
 	/*
 	 * Allow the master to continue.
 	 */
-	set_bit(cpuid, &cpu_callin_map);
+	cpu_set(cpuid, cpu_callin_map);
 	Dprintk("Stack on CPU %d at about %p\n",cpuid, &cpuid);
 }
 
@@ -376,19 +376,19 @@ do_boot_cpu (int sapicid, int cpu)
 	 */
 	Dprintk("Waiting on callin_map ...");
 	for (timeout = 0; timeout < 100000; timeout++) {
-		if (test_bit(cpu, &cpu_callin_map))
+		if (cpu_isset(cpu, cpu_callin_map))
 			break;  /* It has booted */
 		udelay(100);
 	}
 	Dprintk("\n");
 
-	if (test_bit(cpu, &cpu_callin_map)) {
+	if (cpu_isset(cpu, cpu_callin_map)) {
 		/* number CPUs logically, starting from 1 (BSP is 0) */
 		printk(KERN_INFO "CPU%d: CPU has booted.\n", cpu);
 	} else {
 		printk(KERN_ERR "Processor 0x%x/0x%x is stuck.\n", cpu, sapicid);
 		ia64_cpu_to_sapicid[cpu] = -1;
-		clear_bit(cpu, &cpu_online_map);  /* was set in smp_callin() */
+		cpu_clear(cpu, cpu_online_map);  /* was set in smp_callin() */
 		return -EINVAL;
 	}
 	return 0;
@@ -418,13 +418,14 @@ smp_build_cpu_map (void)
 		ia64_cpu_to_sapicid[cpu] = -1;
 
 	ia64_cpu_to_sapicid[0] = boot_cpu_id;
-	phys_cpu_present_map = 1;
+	cpus_clear(phys_cpu_present_map);
+	cpu_set(1, phys_cpu_present_map);
 
 	for (cpu = 1, i = 0; i < smp_boot_data.cpu_count; i++) {
 		sapicid = smp_boot_data.cpu_phys_id[i];
 		if (sapicid == -1 || sapicid == boot_cpu_id)
 			continue;
-		phys_cpu_present_map |= (1 << cpu);
+		cpu_set(cpu, phys_cpu_present_map);
 		ia64_cpu_to_sapicid[cpu] = sapicid;
 		cpu++;
 	}
@@ -435,7 +436,7 @@ smp_build_cpu_map (void)
 /* on which node is each logical CPU (one cacheline even for 64 CPUs) */
 volatile char cpu_to_node_map[NR_CPUS] __cacheline_aligned;
 /* which logical CPUs are on which nodes */
-volatile unsigned long node_to_cpu_mask[MAX_NUMNODES] __cacheline_aligned;
+volatile cpumask_t node_to_cpu_mask[MAX_NUMNODES] __cacheline_aligned;
 
 /*
  * Build cpu to node mapping and initialize the per node cpu masks.
@@ -446,7 +447,7 @@ build_cpu_to_node_map (void)
 	int cpu, i, node;
 
 	for(node=0; node<MAX_NUMNODES; node++)
-		node_to_cpu_mask[node] = 0;
+		cpus_clear(node_to_cpu_mask[node]);
 	for(cpu = 0; cpu < NR_CPUS; ++cpu) {
 		/*
 		 * All Itanium NUMA platforms I know use ACPI, so maybe we
@@ -464,7 +465,7 @@ build_cpu_to_node_map (void)
 #endif
 		cpu_to_node_map[cpu] = node;
 		if (node >= 0)
-			node_to_cpu_mask[node] |= (1UL << cpu);
+			cpu_set(cpu, node_to_cpu_mask[node]);
 	}
 }
 
@@ -487,8 +488,8 @@ smp_prepare_cpus (unsigned int max_cpus)
 	/*
 	 * We have the boot CPU online for sure.
 	 */
-	set_bit(0, &cpu_online_map);
-	set_bit(0, &cpu_callin_map);
+	cpu_set(0, cpu_online_map);
+	cpu_set(0, cpu_callin_map);
 
 	local_cpu_data->loops_per_jiffy = loops_per_jiffy;
 	ia64_cpu_to_sapicid[0] = boot_cpu_id;
@@ -503,15 +504,18 @@ smp_prepare_cpus (unsigned int max_cpus)
 	 */
 	if (!max_cpus) {
 		printk(KERN_INFO "SMP mode deactivated.\n");
-		cpu_online_map = phys_cpu_present_map = 1;
+		cpus_clear(cpu_online_map);
+		cpus_clear(phys_cpu_present_map);
+		cpu_set(1, cpu_online_map);
+		cpu_set(1, phys_cpu_present_map);
 		return;
 	}
 }
 
 void __devinit smp_prepare_boot_cpu(void)
 {
-	set_bit(smp_processor_id(), &cpu_online_map);
-	set_bit(smp_processor_id(), &cpu_callin_map);
+	cpu_set(smp_processor_id(), cpu_online_map);
+	cpu_set(smp_processor_id(), cpu_callin_map);
 }
 
 void
diff -urpN linux-2.5.67-bk6/arch/ia64/kernel/time.c cpu-2.5.67-bk6-1/arch/ia64/kernel/time.c
--- linux-2.5.67-bk6/arch/ia64/kernel/time.c	2003-04-15 14:37:52.000000000 -0700
+++ cpu-2.5.67-bk6-1/arch/ia64/kernel/time.c	2003-04-15 14:39:40.000000000 -0700
@@ -38,13 +38,13 @@ unsigned long last_cli_ip;
 static void
 do_profile (unsigned long ip)
 {
-	extern unsigned long prof_cpu_mask;
+	extern cpumask_t prof_cpu_mask;
 	extern char _stext;
 
 	if (!prof_buffer)
 		return;
 
-	if (!((1UL << smp_processor_id()) & prof_cpu_mask))
+	if (!cpu_isset(smp_processor_id(), prof_cpu_mask))
 		return;
 
 	ip -= (unsigned long) &_stext;
diff -urpN linux-2.5.67-bk6/include/asm-ia64/perfmon.h cpu-2.5.67-bk6-1/include/asm-ia64/perfmon.h
--- linux-2.5.67-bk6/include/asm-ia64/perfmon.h	2003-04-07 10:31:45.000000000 -0700
+++ cpu-2.5.67-bk6-1/include/asm-ia64/perfmon.h	2003-04-15 14:39:40.000000000 -0700
@@ -71,7 +71,7 @@ typedef struct {
 	int	      ctx_flags;	/* noblock/block, inherit flags */
 	void	      *ctx_smpl_vaddr;	/* returns address of BTB buffer */
 
-	unsigned long ctx_cpu_mask;	/* on which CPU to enable perfmon (systemwide) */
+	cpumask_t     ctx_cpu_mask;	/* on which CPU to enable perfmon (systemwide) */
 
 	unsigned long reserved[8];	/* for future use */
 } pfarg_context_t;
diff -urpN linux-2.5.67-bk6/include/asm-ia64/smp.h cpu-2.5.67-bk6-1/include/asm-ia64/smp.h
--- linux-2.5.67-bk6/include/asm-ia64/smp.h	2003-04-15 14:38:01.000000000 -0700
+++ cpu-2.5.67-bk6-1/include/asm-ia64/smp.h	2003-04-15 14:39:40.000000000 -0700
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/threads.h>
 #include <linux/kernel.h>
+#include <linux/cpumask.h>
 
 #include <asm/bitops.h>
 #include <asm/io.h>
@@ -37,8 +38,8 @@ extern struct smp_boot_data {
 
 extern char no_int_routing __initdata;
 
-extern unsigned long phys_cpu_present_map;
-extern volatile unsigned long cpu_online_map;
+extern cpumask_t phys_cpu_present_map;
+extern volatile cpumask_t cpu_online_map;
 extern unsigned long ipi_base_addr;
 extern unsigned char smp_int_redirect;
 
@@ -47,23 +48,6 @@ extern volatile int ia64_cpu_to_sapicid[
 
 extern unsigned long ap_wakeup_vector;
 
-#define cpu_possible(cpu)	(phys_cpu_present_map & (1UL << (cpu)))
-#define cpu_online(cpu)		(cpu_online_map & (1UL << (cpu)))
-
-static inline unsigned int
-num_online_cpus (void)
-{
-	return hweight64(cpu_online_map);
-}
-
-static inline int
-any_online_cpu (unsigned int mask)
-{
-	if (mask & cpu_online_map)
-		return __ffs(mask & cpu_online_map);
-	return -1;
-}
-
 /*
  * Function to map hard smp processor id to logical id.  Slow, so don't use this in
  * performance-critical code.
