Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315661AbSEIIzl>; Thu, 9 May 2002 04:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315663AbSEIIzk>; Thu, 9 May 2002 04:55:40 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:63753 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315661AbSEIIz3>; Thu, 9 May 2002 04:55:29 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Hotplug CPU prep V: x86 non-linear CPU numbers
Date: Thu, 09 May 2002 18:58:48 +1000
Message-Id: <E175jlA-0003X3-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And these are the x86 changes...

Name: x86 Support for Non-linear CPU Numbers Patch 
Author: Rusty Russell
Depends: Hotcpu/nonlinear-cpus.patch.gz

D: This patch fixes up x86 for non-linear CPU numbers.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.9/arch/i386/kernel/apic.c working-2.5.9-nonlinear-cpu/arch/i386/kernel/apic.c
--- linux-2.5.9/arch/i386/kernel/apic.c	Mon Apr 15 11:47:10 2002
+++ working-2.5.9-nonlinear-cpu/arch/i386/kernel/apic.c	Wed Apr 24 15:31:05 2002
@@ -800,10 +800,10 @@
 	 * IRQ APIC event being in synchron with the APIC clock we
 	 * introduce an interrupt skew to spread out timer events.
 	 *
-	 * The number of slices within a 'big' timeslice is smp_num_cpus+1
+	 * The number of slices within a 'big' timeslice is NR_CPUS+1
 	 */
 
-	slice = clocks / (smp_num_cpus+1);
+	slice = clocks / (NR_CPUS+1);
 	printk("cpu: %d, clocks: %d, slice: %d\n", smp_processor_id(), clocks, slice);
 
 	/*
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.9/arch/i386/kernel/apm.c working-2.5.9-nonlinear-cpu/arch/i386/kernel/apm.c
--- linux-2.5.9/arch/i386/kernel/apm.c	Thu Mar 21 14:14:38 2002
+++ working-2.5.9-nonlinear-cpu/arch/i386/kernel/apm.c	Wed Apr 24 15:29:41 2002
@@ -394,11 +394,7 @@
 #endif
 static int			debug;
 static int			apm_disabled = -1;
-#ifdef CONFIG_SMP
-static int			power_off;
-#else
 static int			power_off = 1;
-#endif
 #ifdef CONFIG_APM_REAL_MODE_POWER_OFF
 static int			realmode_power_off = 1;
 #else
@@ -898,7 +894,7 @@
 	 */
 #ifdef CONFIG_SMP
 	/* Some bioses don't like being called from CPU != 0 */
-	while (cpu_number_map(smp_processor_id()) != 0) {
+	while (smp_processor_id() != 0) {
 		kernel_thread(apm_magic, NULL,
 			CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
 		schedule();
@@ -1585,7 +1581,7 @@
 
 	p = buf;
 
-	if ((smp_num_cpus == 1) &&
+	if ((num_online_cpus() == 1) &&
 	    !(error = apm_get_power_status(&bx, &cx, &dx))) {
 		ac_line_status = (bx >> 8) & 0xff;
 		battery_status = bx & 0xff;
@@ -1715,7 +1711,7 @@
 		}
 	}
 
-	if (debug && (smp_num_cpus == 1)) {
+	if (debug && (num_online_cpus() == 1)) {
 		error = apm_get_power_status(&bx, &cx, &dx);
 		if (error)
 			printk(KERN_INFO "apm: power status not available\n");
@@ -1759,7 +1755,7 @@
 		pm_power_off = apm_power_off;
 	register_sysrq_key('o', &sysrq_poweroff_op);
 
-	if (smp_num_cpus == 1) {
+	if (num_online_cpus() == 1) {
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
 		console_blank_hook = apm_console_blank;
 #endif
@@ -1902,10 +1898,6 @@
 		printk(KERN_NOTICE "apm: disabled on user request.\n");
 		return -ENODEV;
 	}
-	if ((smp_num_cpus > 1) && !power_off) {
-		printk(KERN_NOTICE "apm: disabled - APM is not SMP safe.\n");
-		return -ENODEV;
-	}
 	if (PM_IS_ACTIVE()) {
 		printk(KERN_NOTICE "apm: overridden by ACPI.\n");
 		return -ENODEV;
@@ -1955,12 +1947,6 @@
 		SET_MODULE_OWNER(apm_proc);
 
 	kernel_thread(apm, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
-
-	if (smp_num_cpus > 1) {
-		printk(KERN_NOTICE
-		   "apm: disabled - APM is not SMP safe (power off active).\n");
-		return 0;
-	}
 
 	misc_register(&apm_device);
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.9/arch/i386/kernel/bluesmoke.c working-2.5.9-nonlinear-cpu/arch/i386/kernel/bluesmoke.c
--- linux-2.5.9/arch/i386/kernel/bluesmoke.c	Tue Apr 23 11:39:32 2002
+++ working-2.5.9-nonlinear-cpu/arch/i386/kernel/bluesmoke.c	Wed Apr 24 15:29:41 2002
@@ -260,7 +260,9 @@
 {
 	int i;
 
-	for (i=0; i<smp_num_cpus; i++) {
+	for (i=0; i<NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
 		if (i == smp_processor_id())
 			mce_checkregs(i);
 		else
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.9/arch/i386/kernel/i386_ksyms.c working-2.5.9-nonlinear-cpu/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.9/arch/i386/kernel/i386_ksyms.c	Mon Apr 15 11:47:10 2002
+++ working-2.5.9-nonlinear-cpu/arch/i386/kernel/i386_ksyms.c	Wed Apr 24 15:29:41 2002
@@ -127,7 +127,6 @@
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_data);
 EXPORT_SYMBOL(kernel_flag);
-EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL_NOVERS(__write_lock_failed);
 EXPORT_SYMBOL_NOVERS(__read_lock_failed);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.9/arch/i386/kernel/io_apic.c working-2.5.9-nonlinear-cpu/arch/i386/kernel/io_apic.c
--- linux-2.5.9/arch/i386/kernel/io_apic.c	Tue Apr 23 11:39:32 2002
+++ working-2.5.9-nonlinear-cpu/arch/i386/kernel/io_apic.c	Wed Apr 24 15:34:29 2002
@@ -230,14 +230,14 @@
 inside:
 		if (direction == 1) {
 			cpu++;
-			if (cpu >= smp_num_cpus)
+			if (cpu >= NR_CPUS)
 				cpu = 0;
 		} else {
 			cpu--;
 			if (cpu == -1)
-				cpu = smp_num_cpus-1;
+				cpu = NR_CPUS-1;
 		}
-	} while (!IRQ_ALLOWED(cpu,allowed_mask) ||
+	} while (!cpu_online(cpu) || !IRQ_ALLOWED(cpu,allowed_mask) ||
 			(search_idle && !IDLE_ENOUGH(cpu,now)));
 
 	return cpu;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.9/arch/i386/kernel/irq.c working-2.5.9-nonlinear-cpu/arch/i386/kernel/irq.c
--- linux-2.5.9/arch/i386/kernel/irq.c	Tue Apr 23 11:39:32 2002
+++ working-2.5.9-nonlinear-cpu/arch/i386/kernel/irq.c	Wed Apr 24 15:29:41 2002
@@ -138,8 +138,9 @@
 	struct irqaction * action;
 
 	seq_printf(p, "           ");
-	for (j=0; j<smp_num_cpus; j++)
-		seq_printf(p, "CPU%d       ",j);
+	for (j=0; j<NR_CPUS; j++)
+		if (cpu_online(j))
+			p += sprintf(p, "CPU%d       ",j);
 	seq_putc(p, '\n');
 
 	for (i = 0 ; i < NR_IRQS ; i++) {
@@ -150,9 +151,10 @@
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-		for (j = 0; j < smp_num_cpus; j++)
-			seq_printf(p, "%10u ",
-				kstat.irqs[cpu_logical_map(j)][i]);
+		for (j = 0; j < NR_CPUS; j++)
+			if (cpu_online(j))
+				p += sprintf(p, "%10u ",
+					     kstat.irqs[j][i]);
 #endif
 		seq_printf(p, " %14s", irq_desc[i].handler->typename);
 		seq_printf(p, "  %s", action->name);
@@ -162,13 +164,15 @@
 		seq_putc(p, '\n');
 	}
 	seq_printf(p, "NMI: ");
-	for (j = 0; j < smp_num_cpus; j++)
-		seq_printf(p, "%10u ", nmi_count(cpu_logical_map(j)));
+	for (j = 0; j < NR_CPUS; j++)
+		if (cpu_online(j))
+			p += sprintf(p, "%10u ", nmi_count(j));
 	seq_putc(p, '\n');
 #if CONFIG_X86_LOCAL_APIC
 	seq_printf(p, "LOC: ");
-	for (j = 0; j < smp_num_cpus; j++)
-		seq_printf(p, "%10u ", apic_timer_irqs[cpu_logical_map(j)]);
+	for (j = 0; j < NR_CPUS; j++)
+		if (cpu_online(j))
+			p += sprintf(p, "%10u ", apic_timer_irqs[j]);
 	seq_putc(p, '\n');
 #endif
 	seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
@@ -198,14 +202,14 @@
 
 	printk("\n%s, CPU %d:\n", str, cpu);
 	printk("irq:  %d [",irqs_running());
-	for(i=0;i < smp_num_cpus;i++)
+	for(i=0;i < NR_CPUS;i++)
 		printk(" %d",local_irq_count(i));
 	printk(" ]\nbh:   %d [",spin_is_locked(&global_bh_lock) ? 1 : 0);
-	for(i=0;i < smp_num_cpus;i++)
+	for(i=0;i < NR_CPUS;i++)
 		printk(" %d",local_bh_count(i));
 
 	printk(" ]\nStack dumps:");
-	for(i = 0; i < smp_num_cpus; i++) {
+	for(i = 0; i < NR_CPUS; i++) {
 		unsigned long esp;
 		if (i == cpu)
 			continue;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.9/arch/i386/kernel/microcode.c working-2.5.9-nonlinear-cpu/arch/i386/kernel/microcode.c
--- linux-2.5.9/arch/i386/kernel/microcode.c	Tue Apr 23 11:39:32 2002
+++ working-2.5.9-nonlinear-cpu/arch/i386/kernel/microcode.c	Wed Apr 24 15:29:41 2002
@@ -188,7 +188,7 @@
 	}
 	do_update_one(NULL);
 
-	for (i=0; i<smp_num_cpus; i++) {
+	for (i=0; i<NR_CPUS; i++) {
 		err = update_req[i].err;
 		error += err;
 		if (!err) {
@@ -343,8 +343,8 @@
 	}
 	down_write(&microcode_rwsem);
 	if (!mc_applied) {
-		mc_applied = kmalloc(smp_num_cpus*sizeof(struct microcode),
-				GFP_KERNEL);
+		mc_applied = kmalloc(NR_CPUS*sizeof(struct microcode),
+				     GFP_KERNEL);
 		if (!mc_applied) {
 			up_write(&microcode_rwsem);
 			printk(KERN_ERR "microcode: out of memory for saved microcode\n");
@@ -368,7 +368,7 @@
 		ret = -EIO;
 		goto out_fsize;
 	} else {
-		mc_fsize = smp_num_cpus * sizeof(struct microcode);
+		mc_fsize = NR_CPUS * sizeof(struct microcode);
 		ret = (ssize_t)len;
 	}
 out_fsize:
@@ -386,7 +386,7 @@
 		case MICROCODE_IOCFREE:
 			down_write(&microcode_rwsem);
 			if (mc_applied) {
-				int bytes = smp_num_cpus * sizeof(struct microcode);
+				int bytes = NR_CPUS * sizeof(struct microcode);
 
 				devfs_set_file_size(devfs_handle, 0);
 				kfree(mc_applied);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.9/arch/i386/kernel/mtrr.c working-2.5.9-nonlinear-cpu/arch/i386/kernel/mtrr.c
--- linux-2.5.9/arch/i386/kernel/mtrr.c	Mon Apr 15 11:47:10 2002
+++ working-2.5.9-nonlinear-cpu/arch/i386/kernel/mtrr.c	Wed Apr 24 15:29:41 2002
@@ -1055,7 +1055,7 @@
     wait_barrier_cache_disable = TRUE;
     wait_barrier_execute = TRUE;
     wait_barrier_cache_enable = TRUE;
-    atomic_set (&undone_count, smp_num_cpus - 1);
+    atomic_set (&undone_count, num_online_cpus() - 1);
     /*  Start the ball rolling on other CPUs  */
     if (smp_call_function (ipi_handler, &data, 1, 0) != 0)
 	panic ("mtrr: timed out waiting for other CPUs\n");
@@ -1064,14 +1064,14 @@
     /*  Wait for all other CPUs to flush and disable their caches  */
     while (atomic_read (&undone_count) > 0) { rep_nop(); barrier(); }
     /* Set up for completion wait and then release other CPUs to change MTRRs*/
-    atomic_set (&undone_count, smp_num_cpus - 1);
+    atomic_set (&undone_count, num_online_cpus() - 1);
     wait_barrier_cache_disable = FALSE;
     set_mtrr_cache_disable (&ctxt);
 
     /*  Wait for all other CPUs to flush and disable their caches  */
     while (atomic_read (&undone_count) > 0) { rep_nop(); barrier(); }
     /* Set up for completion wait and then release other CPUs to change MTRRs*/
-    atomic_set (&undone_count, smp_num_cpus - 1);
+    atomic_set (&undone_count, num_online_cpus() - 1);
     wait_barrier_execute = FALSE;
     (*set_mtrr_up) (reg, base, size, type, FALSE);
     /*  Now wait for other CPUs to complete the function  */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.9/arch/i386/kernel/nmi.c working-2.5.9-nonlinear-cpu/arch/i386/kernel/nmi.c
--- linux-2.5.9/arch/i386/kernel/nmi.c	Mon Apr 15 11:47:10 2002
+++ working-2.5.9-nonlinear-cpu/arch/i386/kernel/nmi.c	Wed Apr 24 15:29:41 2002
@@ -81,8 +81,9 @@
 	sti();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
-	for (j = 0; j < smp_num_cpus; j++) {
-		cpu = cpu_logical_map(j);
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (!cpu_online(cpu))
+			continue;
 		if (nmi_count(cpu) - tmp[cpu].__nmi_count <= 5) {
 			printk("CPU#%d: NMI appears to be stuck!\n", cpu);
 			return -1;
@@ -330,7 +331,7 @@
 	 * Just reset the alert counters, (other CPUs might be
 	 * spinning on locks we hold):
 	 */
-	for (i = 0; i < smp_num_cpus; i++)
+	for (i = 0; i < NR_CPUS; i++)
 		alert_counter[i] = 0;
 }
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.9/arch/i386/kernel/smp.c working-2.5.9-nonlinear-cpu/arch/i386/kernel/smp.c
--- linux-2.5.9/arch/i386/kernel/smp.c	Mon Apr 15 11:47:10 2002
+++ working-2.5.9-nonlinear-cpu/arch/i386/kernel/smp.c	Wed Apr 24 15:29:41 2002
@@ -247,18 +247,16 @@
 	 * we get an APIC send error if we try to broadcast.
 	 * thus we have to avoid sending IPIs in this case.
 	 */
-	if (!(smp_num_cpus > 1))
+	if (!(num_online_cpus() > 1))
 		return;
 
 	if (clustered_apic_mode) {
 		// Pointless. Use send_IPI_mask to do this instead
 		int cpu;
 
-		if (smp_num_cpus > 1) {
-			for (cpu = 0; cpu < smp_num_cpus; ++cpu) {
-				if (cpu != smp_processor_id())
-					send_IPI_mask(1 << cpu, vector);
-			}
+		for (cpu = 0; cpu < NR_CPUS; ++cpu) {
+			if (cpu_online(cpu) && cpu != smp_processor_id())
+				send_IPI_mask(1 << cpu, vector);
 		}
 	} else {
 		__send_IPI_shortcut(APIC_DEST_ALLBUT, vector);
@@ -272,7 +270,9 @@
 		// Pointless. Use send_IPI_mask to do this instead
 		int cpu;
 
-		for (cpu = 0; cpu < smp_num_cpus; ++cpu) {
+		for (cpu = 0; cpu < NR_CPUS; ++cpu) {
+			if (!cpu_online(cpu))
+				continue;
 			send_IPI_mask(1 << cpu, vector);
 		}
 	} else {
@@ -544,7 +544,7 @@
  */
 {
 	struct call_data_struct data;
-	int cpus = smp_num_cpus-1;
+	int cpus = num_online_cpus()-1;
 
 	if (!cpus)
 		return 0;
@@ -594,7 +594,6 @@
 void smp_send_stop(void)
 {
 	smp_call_function(stop_this_cpu, NULL, 1, 0);
-	smp_num_cpus = 1;
 
 	__cli();
 	disable_local_APIC();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.9/arch/i386/kernel/smpboot.c working-2.5.9-nonlinear-cpu/arch/i386/kernel/smpboot.c
--- linux-2.5.9/arch/i386/kernel/smpboot.c	Mon Apr 15 11:47:10 2002
+++ working-2.5.9-nonlinear-cpu/arch/i386/kernel/smpboot.c	Wed Apr 24 15:31:35 2002
@@ -56,9 +56,6 @@
 /* Setup configured maximum number of CPUs to activate */
 static int max_cpus = -1;
 
-/* Total count of live CPUs */
-int smp_num_cpus = 1;
-
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
 int __initdata phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
@@ -287,7 +284,8 @@
 		/*
 		 * all APs synchronize but they loop on '== num_cpus'
 		 */
-		while (atomic_read(&tsc_count_start) != smp_num_cpus-1) mb();
+		while (atomic_read(&tsc_count_start) != num_online_cpus()-1)
+			mb();
 		atomic_set(&tsc_count_stop, 0);
 		wmb();
 		/*
@@ -305,21 +303,26 @@
 		/*
 		 * Wait for all APs to leave the synchronization point:
 		 */
-		while (atomic_read(&tsc_count_stop) != smp_num_cpus-1) mb();
+		while (atomic_read(&tsc_count_stop) != num_online_cpus()-1)
+			mb();
 		atomic_set(&tsc_count_start, 0);
 		wmb();
 		atomic_inc(&tsc_count_stop);
 	}
 
 	sum = 0;
-	for (i = 0; i < smp_num_cpus; i++) {
-		t0 = tsc_values[i];
-		sum += t0;
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i)) {
+			t0 = tsc_values[i];
+			sum += t0;
+		}
 	}
-	avg = div64(sum, smp_num_cpus);
+	avg = div64(sum, num_online_cpus());
 
 	sum = 0;
-	for (i = 0; i < smp_num_cpus; i++) {
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
 		delta = tsc_values[i] - avg;
 		if (delta < 0)
 			delta = -delta;
@@ -351,7 +354,7 @@
 	int i;
 
 	/*
-	 * smp_num_cpus is not necessarily known at the time
+	 * num_online_cpus is not necessarily known at the time
 	 * this gets called, so we first wait for the BP to
 	 * finish SMP initialization:
 	 */
@@ -359,14 +362,15 @@
 
 	for (i = 0; i < NR_LOOPS; i++) {
 		atomic_inc(&tsc_count_start);
-		while (atomic_read(&tsc_count_start) != smp_num_cpus) mb();
+		while (atomic_read(&tsc_count_start) != num_online_cpus())
+			mb();
 
 		rdtscll(tsc_values[smp_processor_id()]);
 		if (i == NR_LOOPS-1)
 			write_tsc(0, 0);
 
 		atomic_inc(&tsc_count_stop);
-		while (atomic_read(&tsc_count_stop) != smp_num_cpus) mb();
+		while (atomic_read(&tsc_count_stop) != num_online_cpus()) mb();
 	}
 }
 #undef NR_LOOPS
@@ -1068,7 +1072,6 @@
 		io_apic_irqs = 0;
 #endif
 		cpu_online_map = phys_cpu_present_map = 1;
-		smp_num_cpus = 1;
 		if (APIC_init_uniprocessor())
 			printk(KERN_NOTICE "Local APIC not detected."
 					   " Using dummy APIC emulation.\n");
@@ -1099,7 +1102,6 @@
 		io_apic_irqs = 0;
 #endif
 		cpu_online_map = phys_cpu_present_map = 1;
-		smp_num_cpus = 1;
 		goto smp_done;
 	}
 
@@ -1115,7 +1117,6 @@
 		io_apic_irqs = 0;
 #endif
 		cpu_online_map = phys_cpu_present_map = 1;
-		smp_num_cpus = 1;
 		goto smp_done;
 	}
 
@@ -1196,7 +1197,6 @@
 			(bogosum/(5000/HZ))%100);
 		Dprintk("Before bogocount - setting activated=1.\n");
 	}
-	smp_num_cpus = cpucount + 1;
 
 	if (smp_b_stepping)
 		printk(KERN_WARNING "WARNING: SMP operation may be unreliable with B stepping processors.\n");
@@ -1211,11 +1211,12 @@
 		for (cpu = 0; cpu < NR_CPUS; cpu++)
 			cpu_sibling_map[cpu] = NO_PROC_ID;
 		
-		for (cpu = 0; cpu < smp_num_cpus; cpu++) {
+		for (cpu = 0; cpu < NR_CPUS; cpu++) {
 			int 	i;
-			
-			for (i = 0; i < smp_num_cpus; i++) {
-				if (i == cpu)
+			if (!cpu_online(cpu)) continue;
+
+			for (i = 0; i < NR_CPUS; i++) {
+				if (i == cpu || !cpu_online(i))
 					continue;
 				if (phys_proc_id[cpu] == phys_proc_id[i]) {
 					cpu_sibling_map[cpu] = i;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.9/include/asm-i386/hardirq.h working-2.5.9-nonlinear-cpu/include/asm-i386/hardirq.h
--- linux-2.5.9/include/asm-i386/hardirq.h	Wed Apr 24 15:27:50 2002
+++ working-2.5.9-nonlinear-cpu/include/asm-i386/hardirq.h	Wed Apr 24 15:56:55 2002
@@ -51,7 +51,7 @@
 {
 	int i;
 
-	for (i = 0; i < smp_num_cpus; i++)
+	for (i = 0; i < NR_CPUS; i++)
 		if (local_irq_count(i))
 			return 1;
 	return 0;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.9/include/asm-i386/smp.h working-2.5.9-nonlinear-cpu/include/asm-i386/smp.h
--- linux-2.5.9/include/asm-i386/smp.h	Wed Apr 24 15:27:50 2002
+++ working-2.5.9-nonlinear-cpu/include/asm-i386/smp.h	Wed Apr 24 15:56:55 2002
@@ -69,20 +69,6 @@
 extern void zap_low_mappings (void);
 
 /*
- * On x86 all CPUs are mapped 1:1 to the APIC space.
- * This simplifies scheduling and IPI sending and
- * compresses data structures.
- */
-static inline int cpu_logical_map(int cpu)
-{
-	return cpu;
-}
-static inline int cpu_number_map(int cpu)
-{
-	return cpu;
-}
-
-/*
  * Some lowlevel functions might want to know about
  * the real APIC ID <-> CPU # mapping.
  */
@@ -104,9 +90,23 @@
  * from the initial startup. We map APIC_BASE very early in page_setup(),
  * so this is correct in the x86 case.
  */
-
 #define smp_processor_id() (current_thread_info()->cpu)
 
+#define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
+
+extern inline unsigned int num_online_cpus(void)
+{
+	return hweight32(cpu_online_map);
+}
+
+extern inline int any_online_cpu(unsigned int mask)
+{
+	if (mask & cpu_online_map)
+		return __ffs(mask & cpu_online_map);
+
+	return -1;
+}
+
 static __inline int hard_smp_processor_id(void)
 {
 	/* we don't want to mark this access volatile - bad code generation */
@@ -119,6 +119,15 @@
 	return GET_APIC_LOGICAL_ID(*(unsigned long *)(APIC_BASE+APIC_LDR));
 }
 
+static inline int cpu_possible(unsigned int cpu)
+{
+	return phys_cpu_present_map & (1 << cpu);
+}
+
+/* Upping and downing of CPUs */
+extern int __cpu_disable(void);
+extern void __cpu_die(unsigned int cpu);
+extern int __cpu_up(unsigned int cpu);
 #endif /* !__ASSEMBLY__ */
 
 #define NO_PROC_ID		0xFF		/* No processor magic marker */

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
