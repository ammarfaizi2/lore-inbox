Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316877AbSFKHMz>; Tue, 11 Jun 2002 03:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316878AbSFKHMy>; Tue, 11 Jun 2002 03:12:54 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:42914 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S316877AbSFKHMk>; Tue, 11 Jun 2002 03:12:40 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, k-suganuma@mvj.biglobe.ne.jp,
        paulus@samba.org, davidm@hpl.hp.com
Subject: [PATCH] 2.5.21 x86,ia64,ppc Nonlinear CPU support
Date: Tue, 11 Jun 2002 17:12:21 +1000
Message-Id: <E17HfpF-0005I0-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After the previous patch, this makes x86, ia64 and PPC compile again.
And boot (at least Kimio assured me that ia64 boots 8).

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: x86 Support for Non-linear CPU Numbers Patch 
Author: Rusty Russell
Status: Tested on 2.5.21
Depends: Hotcpu/nonlinear-cpus.patch.gz

D: This patch fixes up x86 for non-linear CPU numbers.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/i386/kernel/apic.c working-2.5.15-nonlinear-i386/arch/i386/kernel/apic.c
--- linux-2.5.15/arch/i386/kernel/apic.c	Mon Apr 29 16:00:17 2002
+++ working-2.5.15-nonlinear-i386/arch/i386/kernel/apic.c	Mon May 20 17:51:16 2002
@@ -813,10 +813,10 @@
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/i386/kernel/apm.c working-2.5.15-nonlinear-i386/arch/i386/kernel/apm.c
--- linux-2.5.15/arch/i386/kernel/apm.c	Mon Apr 29 16:00:17 2002
+++ working-2.5.15-nonlinear-i386/arch/i386/kernel/apm.c	Mon May 20 17:53:54 2002
@@ -898,7 +898,7 @@
 	 */
 #ifdef CONFIG_SMP
 	/* Some bioses don't like being called from CPU != 0 */
-	while (cpu_number_map(smp_processor_id()) != 0) {
+	while (smp_processor_id() != 0) {
 		kernel_thread(apm_magic, NULL,
 			CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
 		schedule();
@@ -1585,7 +1585,7 @@
 
 	p = buf;
 
-	if ((smp_num_cpus == 1) &&
+	if ((num_online_cpus() == 1) &&
 	    !(error = apm_get_power_status(&bx, &cx, &dx))) {
 		ac_line_status = (bx >> 8) & 0xff;
 		battery_status = bx & 0xff;
@@ -1715,7 +1715,7 @@
 		}
 	}
 
-	if (debug && (smp_num_cpus == 1)) {
+	if (debug && (num_online_cpus() == 1)) {
 		error = apm_get_power_status(&bx, &cx, &dx);
 		if (error)
 			printk(KERN_INFO "apm: power status not available\n");
@@ -1759,7 +1759,7 @@
 		pm_power_off = apm_power_off;
 	register_sysrq_key('o', &sysrq_poweroff_op);
 
-	if (smp_num_cpus == 1) {
+	if (num_online_cpus() == 1) {
 #if defined(CONFIG_APM_DISPLAY_BLANK) && defined(CONFIG_VT)
 		console_blank_hook = apm_console_blank;
 #endif
@@ -1902,7 +1902,9 @@
 		printk(KERN_NOTICE "apm: disabled on user request.\n");
 		return -ENODEV;
 	}
-	if ((smp_num_cpus > 1) && !power_off) {
+	/* FIXME: When boot code changes, this will need to be
+           deactivated when/if a CPU comes up --RR */
+	if ((num_online_cpus() > 1) && !power_off) {
 		printk(KERN_NOTICE "apm: disabled - APM is not SMP safe.\n");
 		return -ENODEV;
 	}
@@ -1956,7 +1958,9 @@
 
 	kernel_thread(apm, NULL, CLONE_FS | CLONE_FILES | CLONE_SIGHAND | SIGCHLD);
 
-	if (smp_num_cpus > 1) {
+	/* FIXME: When boot code changes, this will need to be
+           deactivated when/if a CPU comes up --RR */
+	if (num_online_cpus() > 1) {
 		printk(KERN_NOTICE
 		   "apm: disabled - APM is not SMP safe (power off active).\n");
 		return 0;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/i386/kernel/bluesmoke.c working-2.5.15-nonlinear-i386/arch/i386/kernel/bluesmoke.c
--- linux-2.5.15/arch/i386/kernel/bluesmoke.c	Mon Apr 29 16:00:17 2002
+++ working-2.5.15-nonlinear-i386/arch/i386/kernel/bluesmoke.c	Mon May 20 17:51:16 2002
@@ -246,7 +246,9 @@
 {
 	unsigned int i;
 
-	for (i=0; i<smp_num_cpus; i++) {
+	for (i=0; i<NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
 		if (i == smp_processor_id())
 			mce_checkregs(&i);
 		else
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/i386/kernel/i386_ksyms.c working-2.5.15-nonlinear-i386/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.15/arch/i386/kernel/i386_ksyms.c	Mon Apr 15 11:47:10 2002
+++ working-2.5.15-nonlinear-i386/arch/i386/kernel/i386_ksyms.c	Mon May 20 17:51:16 2002
@@ -127,7 +127,6 @@
 #ifdef CONFIG_SMP
 EXPORT_SYMBOL(cpu_data);
 EXPORT_SYMBOL(kernel_flag);
-EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL_NOVERS(__write_lock_failed);
 EXPORT_SYMBOL_NOVERS(__read_lock_failed);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/i386/kernel/io_apic.c working-2.5.15-nonlinear-i386/arch/i386/kernel/io_apic.c
--- linux-2.5.15/arch/i386/kernel/io_apic.c	Tue Apr 23 11:39:32 2002
+++ working-2.5.15-nonlinear-i386/arch/i386/kernel/io_apic.c	Mon May 20 17:51:16 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/i386/kernel/irq.c working-2.5.15-nonlinear-i386/arch/i386/kernel/irq.c
--- linux-2.5.15/arch/i386/kernel/irq.c	Tue Apr 23 11:39:32 2002
+++ working-2.5.15-nonlinear-i386/arch/i386/kernel/irq.c	Mon May 20 17:51:16 2002
@@ -138,8 +138,9 @@
 	struct irqaction * action;
 
 	seq_printf(p, "           ");
-	for (j=0; j<smp_num_cpus; j++)
-		seq_printf(p, "CPU%d       ",j);
+	for (j=0; j<NR_CPUS; j++)
+		if (cpu_online(j))
+			p += seq_printf(p, "CPU%d       ",j);
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
+				p += seq_printf(p, "%10u ",
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
+			p += seq_printf(p, "%10u ", nmi_count(j));
 	seq_putc(p, '\n');
 #if CONFIG_X86_LOCAL_APIC
 	seq_printf(p, "LOC: ");
-	for (j = 0; j < smp_num_cpus; j++)
-		seq_printf(p, "%10u ", apic_timer_irqs[cpu_logical_map(j)]);
+	for (j = 0; j < NR_CPUS; j++)
+		if (cpu_online(j))
+			p += seq_printf(p, "%10u ", apic_timer_irqs[j]);
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/i386/kernel/microcode.c working-2.5.15-nonlinear-i386/arch/i386/kernel/microcode.c
--- linux-2.5.15/arch/i386/kernel/microcode.c	Mon May  6 11:11:51 2002
+++ working-2.5.15-nonlinear-i386/arch/i386/kernel/microcode.c	Mon May 20 17:51:16 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/i386/kernel/mtrr.c working-2.5.15-nonlinear-i386/arch/i386/kernel/mtrr.c
--- linux-2.5.15/arch/i386/kernel/mtrr.c	Mon May 13 12:00:30 2002
+++ working-2.5.15-nonlinear-i386/arch/i386/kernel/mtrr.c	Mon May 20 17:51:16 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/i386/kernel/nmi.c working-2.5.15-nonlinear-i386/arch/i386/kernel/nmi.c
--- linux-2.5.15/arch/i386/kernel/nmi.c	Mon Apr 15 11:47:10 2002
+++ working-2.5.15-nonlinear-i386/arch/i386/kernel/nmi.c	Mon May 20 17:51:16 2002
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
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/i386/kernel/smp.c working-2.5.15-nonlinear-i386/arch/i386/kernel/smp.c
--- linux-2.5.15/arch/i386/kernel/smp.c	Mon Apr 15 11:47:10 2002
+++ working-2.5.15-nonlinear-i386/arch/i386/kernel/smp.c	Mon May 20 17:51:17 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/arch/i386/kernel/smpboot.c working-2.5.15-nonlinear-i386/arch/i386/kernel/smpboot.c
--- linux-2.5.15/arch/i386/kernel/smpboot.c	Mon Apr 15 11:47:10 2002
+++ working-2.5.15-nonlinear-i386/arch/i386/kernel/smpboot.c	Mon May 20 17:51:17 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/include/asm-i386/hardirq.h working-2.5.15-nonlinear-i386/include/asm-i386/hardirq.h
--- linux-2.5.15/include/asm-i386/hardirq.h	Tue Apr 23 11:39:38 2002
+++ working-2.5.15-nonlinear-i386/include/asm-i386/hardirq.h	Mon May 20 17:51:17 2002
@@ -51,7 +51,7 @@
 {
 	int i;
 
-	for (i = 0; i < smp_num_cpus; i++)
+	for (i = 0; i < NR_CPUS; i++)
 		if (local_irq_count(i))
 			return 1;
 	return 0;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.15/include/asm-i386/smp.h working-2.5.15-nonlinear-i386/include/asm-i386/smp.h
--- linux-2.5.15/include/asm-i386/smp.h	Wed Feb 20 17:56:40 2002
+++ working-2.5.15-nonlinear-i386/include/asm-i386/smp.h	Mon May 20 17:51:17 2002
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

Name: PPC Support for Non-linear CPU Numbers Patch 
Author: Rusty Russell
Status: Tested on 2.5.15 PPC
Depends: Hotcpu/nonlinear-cpus.patch.gz

D: This patch fixes up PPC for non-linear CPU numbers.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-smp/arch/ppc/kernel/irq.c working-ppc-2.5-pre-hotcpu/arch/ppc/kernel/irq.c
--- working-ppc-2.5-smp/arch/ppc/kernel/irq.c	Fri Feb 15 22:21:09 2002
+++ working-ppc-2.5-pre-hotcpu/arch/ppc/kernel/irq.c	Thu May 23 19:55:01 2002
@@ -370,8 +370,9 @@
 	struct irqaction * action;
 
 	seq_puts(p, "           ");
-	for (j=0; j<smp_num_cpus; j++)
-		seq_printf(p, "CPU%d       ", j);
+	for (j=0; j<NR_CPUS; j++)
+		if (cpu_online(j))
+			seq_printf(p, "CPU%d       ", j);
 	seq_putc(p, '\n');
 
 	for (i = 0 ; i < NR_IRQS ; i++) {
@@ -380,9 +381,10 @@
 			continue;
 		seq_printf(p, "%3d: ", i);		
 #ifdef CONFIG_SMP
-		for (j = 0; j < smp_num_cpus; j++)
-			seq_printf(p, "%10u ",
-				   kstat.irqs[cpu_logical_map(j)][i]);
+		for (j = 0; j < NR_CPUS; j++)
+			if (cpu_online(j))
+				seq_printf(p, "%10u ",
+					   kstat.irqs[j][i]);
 #else		
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #endif /* CONFIG_SMP */
@@ -399,8 +401,9 @@
 #ifdef CONFIG_TAU_INT
 	if (tau_initialized){
 		seq_puts(p, "TAU: ");
-		for (j = 0; j < smp_num_cpus; j++)
-			seq_printf(p, "%10u ", tau_interrupts(j));
+		for (j = 0; j < NR_CPUS; j++)
+			if (cpu_online(j))
+				seq_printf(p, "%10u ", tau_interrupts(j));
 		seq_puts(p, "  PowerPC             Thermal Assist (cpu temp)\n");
 	}
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-smp/arch/ppc/kernel/open_pic.c working-ppc-2.5-pre-hotcpu/arch/ppc/kernel/open_pic.c
--- working-ppc-2.5-smp/arch/ppc/kernel/open_pic.c	Mon May 13 08:54:21 2002
+++ working-ppc-2.5-pre-hotcpu/arch/ppc/kernel/open_pic.c	Thu May 23 18:23:50 2002
@@ -519,8 +519,9 @@
 	int i;
 	u32 mask = 0;
 
-	for (i = 0; i < smp_num_cpus; ++i, cpumask >>= 1)
-		mask |= (cpumask & 1) << smp_hw_index[i];
+	for (i = 0; i < NR_CPUS; ++i, cpumask >>= 1)
+		if (cpu_online(i))
+			mask |= (cpumask & 1) << smp_hw_index[i];
 	return mask;
 }
 #else
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-smp/arch/ppc/kernel/ppc_ksyms.c working-ppc-2.5-pre-hotcpu/arch/ppc/kernel/ppc_ksyms.c
--- working-ppc-2.5-smp/arch/ppc/kernel/ppc_ksyms.c	Thu May  9 20:19:54 2002
+++ working-ppc-2.5-pre-hotcpu/arch/ppc/kernel/ppc_ksyms.c	Thu May 23 15:31:25 2002
@@ -228,7 +228,6 @@
 #endif
 EXPORT_SYMBOL(smp_call_function);
 EXPORT_SYMBOL(smp_hw_index);
-EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(synchronize_irq);
 #endif
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-smp/arch/ppc/kernel/setup.c working-ppc-2.5-pre-hotcpu/arch/ppc/kernel/setup.c
--- working-ppc-2.5-smp/arch/ppc/kernel/setup.c	Thu May  9 20:19:54 2002
+++ working-ppc-2.5-pre-hotcpu/arch/ppc/kernel/setup.c	Thu May 23 15:33:44 2002
@@ -146,8 +146,8 @@
 		/* Show summary information */
 #ifdef CONFIG_SMP
 		unsigned long bogosum = 0;
-		for (i = 0; i < smp_num_cpus; ++i)
-			if (cpu_online_map & (1 << i))
+		for (i = 0; i < NR_CPUS; ++i)
+			if (cpu_online(i))
 				bogosum += cpu_data[i].loops_per_jiffy;
 		seq_printf(m, "total bogomips\t: %lu.%02lu\n",
 			   bogosum/(500000/HZ), bogosum/(5000/HZ) % 100);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-smp/arch/ppc/kernel/smp.c working-ppc-2.5-pre-hotcpu/arch/ppc/kernel/smp.c
--- working-ppc-2.5-smp/arch/ppc/kernel/smp.c	Wed Apr 10 22:07:21 2002
+++ working-ppc-2.5-pre-hotcpu/arch/ppc/kernel/smp.c	Thu May 23 18:23:00 2002
@@ -42,7 +42,6 @@
 
 int smp_threads_ready;
 volatile int smp_commenced;
-int smp_num_cpus = 1;
 int smp_tb_synchronized;
 struct cpuinfo_PPC cpu_data[NR_CPUS];
 struct klock_info_struct klock_info = { KLOCK_CLEAR, 0 };
@@ -68,7 +67,6 @@
 int start_secondary(void *);
 extern int cpu_idle(void *unused);
 void smp_call_function_interrupt(void);
-void smp_message_pass(int target, int msg, unsigned long data, int wait);
 static int __smp_call_function(void (*func) (void *info), void *info,
 			       int wait, int target);
 
@@ -174,7 +172,6 @@
 void smp_send_stop(void)
 {
 	smp_call_function(stop_this_cpu, NULL, 1, 0);
-	smp_num_cpus = 1;
 }
 
 /*
@@ -212,7 +209,9 @@
  * hardware interrupt handler, you may call it from a bottom half handler.
  */
 {
-	if (smp_num_cpus <= 1)
+	/* FIXME: get cpu lock with hotplug cpus, or change this to
+           bitmask. --RR */
+	if (num_online_cpus() <= 1)
 		return 0;
 	return __smp_call_function(func, info, wait, MSG_ALL_BUT_SELF);
 }
@@ -226,9 +225,9 @@
 	int ncpus = 1;
 
 	if (target == MSG_ALL_BUT_SELF)
-		ncpus = smp_num_cpus - 1;
+		ncpus = num_online_cpus() - 1;
 	else if (target == MSG_ALL)
-		ncpus = smp_num_cpus;
+		ncpus = num_online_cpus();
 
 	data.func = func;
 	data.info = info;
@@ -298,7 +297,6 @@
 	struct task_struct *p;
 
 	printk("Entering SMP Mode...\n");
-	smp_num_cpus = 1;
         smp_store_cpu_info(0);
 	cpu_online_map = 1UL;
 
@@ -377,7 +375,6 @@
 			sprintf(buf, "found cpu %d", i);
 			if (ppc_md.progress) ppc_md.progress(buf, 0x350+i);
 			printk("Processor %d found.\n", i);
-			smp_num_cpus++;
 		} else {
 			char buf[32];
 			sprintf(buf, "didn't find cpu %d", i);
@@ -389,7 +386,8 @@
 	/* Setup CPU 0 last (important) */
 	smp_ops->setup_cpu(0);
 	
-	if (smp_num_cpus < 2)
+	/* FIXME: Not with hotplug CPUS --RR */
+	if (num_online_cpus() < 2)
 		smp_tb_synchronized = 1;
 }
 
@@ -415,7 +413,7 @@
 	for (pass = 2; pass < 2+PASSES; pass++){
 		if (cpu == 0){
 			mb();
-			for (i = j = 1; i < smp_num_cpus; i++, j++){
+			for (i = j = 1; i < NR_CPUS; i++, j++){
 				/* skip stuck cpus */
 				while (!cpu_callin_map[j])
 					++j;
@@ -489,7 +487,8 @@
 	 *
 	 * NOTE2: this code doesn't seem to work on > 2 cpus. -- paulus/BenH
 	 */
-	if (!smp_tb_synchronized && smp_num_cpus == 2) {
+	/* FIXME: This doesn't work with hotplug CPUs --RR */
+	if (!smp_tb_synchronized && num_online_cpus() == 2) {
 		unsigned long flags;
 		__save_and_cli(flags);	
 		smp_software_tb_sync(0);
@@ -503,24 +502,18 @@
 	
         smp_store_cpu_info(cpu);
 	set_dec(tb_ticks_per_jiffy);
+	/* Set online before we acknowledge. */
+	set_bit(cpu, &cpu_online_map);
+	wmb();
 	cpu_callin_map[cpu] = 1;
 
 	smp_ops->setup_cpu(cpu);
 
-	/*
-	 * This cpu is now "online".  Only set them online
-	 * before they enter the loop below since write access
-	 * to the below variable is _not_ guaranteed to be
-	 * atomic.
-	 *   -- Cort <cort@fsmlabs.com>
-	 */
-	cpu_online_map |= 1UL << smp_processor_id();
-	
 	while (!smp_commenced)
 		barrier();
 
 	/* see smp_commence for more info */
-	if (!smp_tb_synchronized && smp_num_cpus == 2) {
+	if (!smp_tb_synchronized && num_online_cpus() == 2) {
 		smp_software_tb_sync(cpu);
 	}
 	__sti();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-smp/arch/ppc/platforms/chrp_smp.c working-ppc-2.5-pre-hotcpu/arch/ppc/platforms/chrp_smp.c
--- working-ppc-2.5-smp/arch/ppc/platforms/chrp_smp.c	Sun Feb 10 22:41:24 2002
+++ working-ppc-2.5-pre-hotcpu/arch/ppc/platforms/chrp_smp.c	Thu May 23 16:04:30 2002
@@ -63,9 +63,10 @@
 	static atomic_t ready = ATOMIC_INIT(1);
 	static volatile int frozen = 0;
 
+	/* FIXME: Hotplug cpu breaks all this --RR */
 	if (cpu_nr == 0) {
 		/* wait for all the others */
-		while (atomic_read(&ready) < smp_num_cpus)
+		while (atomic_read(&ready) < num_online_cpus())
 			barrier();
 		atomic_set(&ready, 1);
 		/* freeze the timebase */
@@ -75,7 +76,7 @@
 		/* XXX assumes this is not a 601 */
 		set_tb(0, 0);
 		last_jiffy_stamp(0) = 0;
-		while (atomic_read(&ready) < smp_num_cpus)
+		while (atomic_read(&ready) < num_online_cpus())
 			barrier();
 		/* thaw the timebase again */
 		call_rtas("thaw-time-base", 0, 1, NULL);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-smp/arch/ppc/platforms/iSeries_smp.c working-ppc-2.5-pre-hotcpu/arch/ppc/platforms/iSeries_smp.c
--- working-ppc-2.5-smp/arch/ppc/platforms/iSeries_smp.c	Sun Feb 10 22:22:35 2002
+++ working-ppc-2.5-pre-hotcpu/arch/ppc/platforms/iSeries_smp.c	Thu May 23 16:05:09 2002
@@ -50,7 +50,7 @@
 	int cpu = smp_processor_id();
 	int msg;
 
-	if ( smp_num_cpus < 2 )
+	if ( num_online_cpus() < 2 )
 		return;
 
 	for ( msg = 0; msg < 4; ++msg )
@@ -62,7 +62,10 @@
 static void smp_iSeries_message_pass(int target, int msg, unsigned long data, int wait)
 {
 	int i;
-	for (i = 0; i < smp_num_cpus; ++i) {
+	for (i = 0; i < NR_CPUS; ++i) {
+		if (!cpu_online(i))
+			continue;
+
 		if ( (target == MSG_ALL) ||
 			(target == i) ||
 			((target == MSG_ALL_BUT_SELF) && (i != smp_processor_id())) ) {
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-smp/arch/ppc/platforms/pmac_smp.c working-ppc-2.5-pre-hotcpu/arch/ppc/platforms/pmac_smp.c
--- working-ppc-2.5-smp/arch/ppc/platforms/pmac_smp.c	Thu May  9 20:19:54 2002
+++ working-ppc-2.5-pre-hotcpu/arch/ppc/platforms/pmac_smp.c	Thu May 23 16:06:11 2002
@@ -282,7 +282,7 @@
 	/* clear interrupt */
 	psurge_clr_ipi(cpu);
 
-	if (smp_num_cpus < 2)
+	if (num_online_cpus() < 2)
 		return;
 
 	/* make sure there is a message there */
@@ -302,10 +302,12 @@
 {
 	int i;
 
-	if (smp_num_cpus < 2)
+	if (num_online_cpus() < 2)
 		return;
 
-	for (i = 0; i < smp_num_cpus; i++) {
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
 		if (target == MSG_ALL
 		    || (target == MSG_ALL_BUT_SELF && i != smp_processor_id())
 		    || target == i) {
@@ -497,7 +499,7 @@
 {
 
 	if (cpu_nr == 0) {
-		if (smp_num_cpus < 2)
+		if (num_online_cpus() < 2)
 			return;
 		/* reset the entry point so if we get another intr we won't
 		 * try to startup again */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-smp/include/asm-ppc/hardirq.h working-ppc-2.5-pre-hotcpu/include/asm-ppc/hardirq.h
--- working-ppc-2.5-smp/include/asm-ppc/hardirq.h	Thu May  9 20:19:54 2002
+++ working-ppc-2.5-pre-hotcpu/include/asm-ppc/hardirq.h	Thu May 23 18:03:30 2002
@@ -56,7 +56,7 @@
 {
 	int i;
 
-	for (i = 0; i < smp_num_cpus; i++)
+	for (i = 0; i < NR_CPUS; i++)
 		if (local_irq_count(i))
 			return 1;
 		return 0;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-ppc-2.5-smp/include/asm-ppc/smp.h working-ppc-2.5-pre-hotcpu/include/asm-ppc/smp.h
--- working-ppc-2.5-smp/include/asm-ppc/smp.h	Fri Feb 15 22:21:09 2002
+++ working-ppc-2.5-pre-hotcpu/include/asm-ppc/smp.h	Thu May 23 18:03:18 2002
@@ -15,6 +15,7 @@
 
 #include <linux/config.h>
 #include <linux/kernel.h>
+#include <linux/bitops.h>
 
 #ifdef CONFIG_SMP
 
@@ -44,11 +45,22 @@
 #define NO_PROC_ID		0xFF            /* No processor magic marker */
 #define PROC_CHANGE_PENALTY	20
 
-/* 1 to 1 mapping on PPC -- Cort */
-#define cpu_logical_map(cpu) (cpu)
-#define cpu_number_map(x) (x)
-
 #define smp_processor_id() (current_thread_info()->cpu)
+
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
 
 extern int smp_hw_index[];
 #define hard_smp_processor_id() (smp_hw_index[smp_processor_id()])

Name: ia64 Support for Non-linear CPU Numbers Patch 
Author: Kimio Suganuma
Status: Tested on 2.5.14
Depends: Hotcpu/nonlinear-cpus.patch.gz

D: This patch fixes up ia64 for non-linear CPU numbers.

diff -Nur linux-2.5.10-base/arch/ia64/kernel/ia64_ksyms.c linux-2.5.10-new/arch/ia64/kernel/ia64_ksyms.c
--- linux-2.5.10-base/arch/ia64/kernel/ia64_ksyms.c	Wed May  8 17:51:03 2002
+++ linux-2.5.10-new/arch/ia64/kernel/ia64_ksyms.c	Wed May  8 17:58:55 2002
@@ -85,9 +85,6 @@
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(ia64_cpu_to_sapicid);
 
-#include <linux/smp.h>
-EXPORT_SYMBOL(smp_num_cpus);
-
 #include <asm/smplock.h>
 EXPORT_SYMBOL(kernel_flag);
 
diff -Nur linux-2.5.10-base/arch/ia64/kernel/iosapic.c linux-2.5.10-new/arch/ia64/kernel/iosapic.c
--- linux-2.5.10-base/arch/ia64/kernel/iosapic.c	Wed May  8 17:51:03 2002
+++ linux-2.5.10-new/arch/ia64/kernel/iosapic.c	Wed May  8 17:58:55 2002
@@ -254,7 +254,7 @@
 	char *addr;
 	int redir = (irq & (1<<31)) ? 1 : 0;
 
-	mask &= (1UL << smp_num_cpus) - 1;
+	mask &= cpu_online_map;
 
 	if (!mask || irq >= IA64_NUM_VECTORS)
 		return;
@@ -757,9 +757,8 @@
 
 					set_rte(vector, cpu_physical_id(cpu_index) & 0xffff);
 
-					cpu_index++;
-					if (cpu_index >= smp_num_cpus)
-						cpu_index = 0;
+					for (cpu_index++; !cpu_online(cpu_index % NR_CPUS); cpu_index++);
+                                        cpu_index %= NR_CPUS;
 				} else {
 					/*
 					 * Direct the interrupt vector to the current cpu,
diff -Nur linux-2.5.10-base/arch/ia64/kernel/irq.c linux-2.5.10-new/arch/ia64/kernel/irq.c
--- linux-2.5.10-base/arch/ia64/kernel/irq.c	Wed May  8 17:51:03 2002
+++ linux-2.5.10-new/arch/ia64/kernel/irq.c	Wed May  8 17:58:55 2002
@@ -156,8 +156,9 @@
 	irq_desc_t *idesc;
 
 	seq_puts(p, "           ");
-	for (j=0; j<smp_num_cpus; j++)
-		seq_printf(p, "CPU%d       ",j);
+	for (j=0; j<NR_CPUS; j++)
+		if (cpu_online(j))
+			seq_printf(p, "CPU%d       ",j);
 	seq_putc(p, '\n');
 
 	for (i = 0 ; i < NR_IRQS ; i++) {
@@ -169,9 +170,9 @@
 #ifndef CONFIG_SMP
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #else
-		for (j = 0; j < smp_num_cpus; j++)
-			seq_printf(p, "%10u ",
-				kstat.irqs[cpu_logical_map(j)][i]);
+		for (j = 0; j < NR_CPUS; j++)
+			if (cpu_online(j))
+				seq_printf(p, "%10u ", kstat.irqs[j][i]);
 #endif
 		seq_printf(p, " %14s", idesc->handler->typename);
 		seq_printf(p, "  %s", action->name);
@@ -181,15 +182,15 @@
 		seq_putc(p, '\n');
 	}
 	seq_puts(p, "NMI: ");
-	for (j = 0; j < smp_num_cpus; j++)
-		seq_printf(p, "%10u ",
-			nmi_count(cpu_logical_map(j)));
+	for (j = 0; j < NR_CPUS; j++)
+		if (cpu_online(j))
+			seq_printf(p, "%10u ", nmi_count(j));
 	seq_putc(p, '\n');
 #if defined(CONFIG_SMP) && defined(CONFIG_X86)
 	seq_puts(p, "LOC: ");
-	for (j = 0; j < smp_num_cpus; j++)
-		seq_printf(p, "%10u ",
-			apic_timer_irqs[cpu_logical_map(j)]);
+	for (j = 0; j < NR_CPUS; j++)
+		if (cpu_online(j))
+			seq_printf(p, "%10u ", apic_timer_irqs[j]);
 	seq_putc(p, '\n');
 #endif
 	seq_printf(p, "ERR: %10u\n", atomic_read(&irq_err_count));
@@ -218,10 +219,10 @@
 
 	printk("\n%s, CPU %d:\n", str, cpu);
 	printk("irq:  %d [",irqs_running());
-	for(i=0;i < smp_num_cpus;i++)
+	for(i=0;i < NR_CPUS;i++)
 		printk(" %d",irq_count(i));
 	printk(" ]\nbh:   %d [",spin_is_locked(&global_bh_lock) ? 1 : 0);
-	for(i=0;i < smp_num_cpus;i++)
+	for(i=0;i < NR_CPUS;i++)
 		printk(" %d",bh_count(i));
 
 	printk(" ]\nStack dumps:");
@@ -233,7 +234,7 @@
 	 * idea.
 	 */
 #elif defined(CONFIG_X86)
-	for(i=0;i< smp_num_cpus;i++) {
+	for(i=0;i< NR_CPUS;i++) {
 		unsigned long esp;
 		if(i==cpu)
 			continue;
diff -Nur linux-2.5.10-base/arch/ia64/kernel/mca.c linux-2.5.10-new/arch/ia64/kernel/mca.c
--- linux-2.5.10-base/arch/ia64/kernel/mca.c	Wed May  8 17:51:03 2002
+++ linux-2.5.10-new/arch/ia64/kernel/mca.c	Wed May  8 17:58:55 2002
@@ -604,9 +604,12 @@
 	int cpu;
 
 	/* Clear the Rendez checkin flag for all cpus */
-	for(cpu = 0; cpu < smp_num_cpus; cpu++)
+	for(cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (!cpu_online(cpu))
+			continue;
 		if (ia64_mc_info.imi_rendez_checkin[cpu] == IA64_MCA_RENDEZ_CHECKIN_DONE)
 			ia64_mca_wakeup(cpu);
+	}
 
 }
 
diff -Nur linux-2.5.10-base/arch/ia64/kernel/perfmon.c linux-2.5.10-new/arch/ia64/kernel/perfmon.c
--- linux-2.5.10-base/arch/ia64/kernel/perfmon.c	Wed May  8 17:51:03 2002
+++ linux-2.5.10-new/arch/ia64/kernel/perfmon.c	Wed May  8 17:58:55 2002
@@ -805,7 +805,7 @@
 		 * and it must be a valid CPU
 		 */
 		cpu = ffs(pfx->ctx_cpu_mask);
-		if (cpu > smp_num_cpus) {
+		if (!cpu_online(cpu)) {
 			DBprintk(("CPU%d is not online\n", cpu));
 			return -EINVAL;
 		}
diff -Nur linux-2.5.10-base/arch/ia64/kernel/smp.c linux-2.5.10-new/arch/ia64/kernel/smp.c
--- linux-2.5.10-base/arch/ia64/kernel/smp.c	Wed May  8 17:51:03 2002
+++ linux-2.5.10-new/arch/ia64/kernel/smp.c	Wed May  8 17:58:55 2002
@@ -168,8 +168,8 @@
 {
 	int i;
 
-	for (i = 0; i < smp_num_cpus; i++) {
-		if (i != smp_processor_id())
+	for (i = 0; i < NR_CPUS; i++) {
+		if (cpu_online(i) && i != smp_processor_id())
 			send_IPI_single(i, op);
 	}
 }
@@ -179,8 +179,9 @@
 {
 	int i;
 
-	for (i = 0; i < smp_num_cpus; i++)
-		send_IPI_single(i, op);
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_online(i))
+			send_IPI_single(i, op);
 }
 
 static inline void
@@ -205,8 +206,8 @@
 {
 	int i;
 
-	for (i = 0; i < smp_num_cpus; i++)
-		if (i != smp_processor_id())
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_online(i) && i != smp_processor_id())
 			smp_send_reschedule(i);
 }
 
@@ -290,7 +291,7 @@
 smp_call_function (void (*func) (void *info), void *info, int nonatomic, int wait)
 {
 	struct call_data_struct data;
-	int cpus = smp_num_cpus-1;
+	int cpus = num_online_cpus()-1;
 
 	if (!cpus)
 		return 0;
@@ -339,7 +340,6 @@
 smp_send_stop (void)
 {
 	send_IPI_allbutself(IPI_CPU_STOP);
-	smp_num_cpus = 1;
 }
 
 int __init
diff -Nur linux-2.5.10-base/arch/ia64/kernel/smpboot.c linux-2.5.10-new/arch/ia64/kernel/smpboot.c
--- linux-2.5.10-base/arch/ia64/kernel/smpboot.c	Wed May  8 17:51:03 2002
+++ linux-2.5.10-new/arch/ia64/kernel/smpboot.c	Wed May  8 17:58:55 2002
@@ -76,9 +76,6 @@
 /* Setup configured maximum number of CPUs to activate */
 static int max_cpus = -1;
 
-/* Total count of live CPUs */
-int smp_num_cpus = 1;
-
 /* Bitmask of currently online CPUs */
 volatile unsigned long cpu_online_map;
 
@@ -508,7 +505,6 @@
 	if (!max_cpus || (max_cpus < -1)) {
 		printk(KERN_INFO "SMP mode deactivated.\n");
 		cpu_online_map =  1;
-		smp_num_cpus = 1;
 		goto smp_done;
 	}
 	if (max_cpus != -1)
@@ -538,8 +534,6 @@
 				printk("phys CPU#%d not responding - cannot use it.\n", cpu);
 		}
 
-		smp_num_cpus = cpucount + 1;
-
 		/*
 		 * Allow the user to impress friends.
 		 */
@@ -584,6 +578,5 @@
 		printk("SMP: Can't set SAL AP Boot Rendezvous: %s\n     Forcing UP mode\n",
 		       ia64_sal_strerror(sal_ret));
 		max_cpus = 0;
-		smp_num_cpus = 1;
 	}
 }
diff -Nur linux-2.5.10-base/arch/ia64/sn/io/sgi_io_init.c linux-2.5.10-new/arch/ia64/sn/io/sgi_io_init.c
--- linux-2.5.10-base/arch/ia64/sn/io/sgi_io_init.c	Wed May  8 17:51:01 2002
+++ linux-2.5.10-new/arch/ia64/sn/io/sgi_io_init.c	Wed May  8 18:00:13 2002
@@ -255,7 +255,7 @@
 	cnodeid_t	cnode;
 	cpuid_t		cpu;
 
-	for (cpu = 0; cpu < smp_num_cpus; cpu++) {
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		/* Skip holes in CPU space */
 		if (cpu_enabled(cpu)) {
 			init_platform_pda(cpu);
diff -Nur linux-2.5.10-base/arch/ia64/sn/io/sn1/ml_SN_intr.c linux-2.5.10-new/arch/ia64/sn/io/sn1/ml_SN_intr.c
--- linux-2.5.10-base/arch/ia64/sn/io/sn1/ml_SN_intr.c	Wed May  8 17:51:01 2002
+++ linux-2.5.10-new/arch/ia64/sn/io/sn1/ml_SN_intr.c	Wed May  8 18:01:28 2002
@@ -987,12 +987,13 @@
 	char subnode_done[NUM_SUBNODES];
 
 	// cpu = cnodetocpu(cnode);
-	for (cpu = 0; cpu < smp_num_cpus; cpu++) {
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (!cpu_online(cpu)) continue;
 		if (cpuid_to_cnodeid(cpu) == cnode) {
 			break;
 		}
 	}
-	if (cpu == smp_num_cpus) cpu = CPU_NONE;
+	if (cpu == NR_CPUS) cpu = CPU_NONE;
 	if (cpu == CPU_NONE) {
 		printk("Node %d has no CPUs", cnode);
 		return;
@@ -1001,7 +1002,7 @@
 	for (i=0; i<NUM_SUBNODES; i++)
 		subnode_done[i] = 0;
 
-	for (; cpu<smp_num_cpus && cpu_enabled(cpu) && cpuid_to_cnodeid(cpu) == cnode; cpu++) {
+	for (; cpu<NR_CPUS && cpu_enabled(cpu) && cpuid_to_cnodeid(cpu) == cnode; cpu++) {
 		int which_subnode = cpuid_to_subnode(cpu);
 		if (subnode_done[which_subnode])
 			continue;
diff -Nur linux-2.5.10-base/arch/ia64/sn/kernel/llsc4.c linux-2.5.10-new/arch/ia64/sn/kernel/llsc4.c
--- linux-2.5.10-base/arch/ia64/sn/kernel/llsc4.c	Wed May  8 17:51:02 2002
+++ linux-2.5.10-new/arch/ia64/sn/kernel/llsc4.c	Wed May  8 18:03:40 2002
@@ -1005,14 +1005,15 @@
 
 	printk("Testing cross interrupts\n");
 	
-	while (control_cpu != smp_num_cpus) {
-		if (mycpu == cpu_logical_map(control_cpu)) {
-			for (cpu=0; cpu<smp_num_cpus; cpu++) {
-				printk("Sending interrupt from %d to %d\n", mycpu, cpu_logical_map(cpu));
+	while (control_cpu != NR_CPUS) {
+		if (mycpu == control_cpu) {
+			for (cpu=0; cpu<NR_CPUS; cpu++) {
+				if (!cpu_online(cpu)) continue;
+				printk("Sending interrupt from %d to %d\n", mycpu, cpu);
 				udelay(IS_RUNNING_ON_SIMULATOR ? 10000 : 400000);
-				smp_send_reschedule(cpu_logical_map(cpu));
+				smp_send_reschedule(cpu);
 				udelay(IS_RUNNING_ON_SIMULATOR ? 10000 : 400000);
-				smp_send_reschedule(cpu_logical_map(cpu));
+				smp_send_reschedule(cpu);
 				udelay(IS_RUNNING_ON_SIMULATOR ? 10000 : 400000);
 			}
 			control_cpu++;
@@ -1021,7 +1022,7 @@
 
 	zzzprint_resched = 1;
 
-	if (mycpu == cpu_logical_map(smp_num_cpus-1)) {
+	if (mycpu == NR_CPUS-1) {
 		printk("\nTight loop of cpu %d sending ints to cpu 0 (every 100 us)\n", mycpu);
 		udelay(IS_RUNNING_ON_SIMULATOR ? 1000 : 1000000);
 		__cli();
diff -Nur linux-2.5.10-base/arch/ia64/sn/kernel/setup.c linux-2.5.10-new/arch/ia64/sn/kernel/setup.c
--- linux-2.5.10-base/arch/ia64/sn/kernel/setup.c	Wed May  8 17:51:02 2002
+++ linux-2.5.10-new/arch/ia64/sn/kernel/setup.c	Wed May  8 18:05:27 2002
@@ -426,11 +426,13 @@
 cnodeid_to_cpuid(int cnode) {
 	int cpu;
 
-	for (cpu = 0; cpu < smp_num_cpus; cpu++)
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (!cpu_online(cpu)) continue;
 		if (cpuid_to_cnodeid(cpu) == cnode)
 			break;
+	}
 
-	if (cpu == smp_num_cpus) 
+	if (cpu == NR_CPUS) 
 		cpu = -1;
 
 	return cpu;
diff -Nur linux-2.5.10-base/arch/ia64/sn/kernel/sn1/sn1_smp.c linux-2.5.10-new/arch/ia64/sn/kernel/sn1/sn1_smp.c
--- linux-2.5.10-base/arch/ia64/sn/kernel/sn1/sn1_smp.c	Wed May  8 17:51:02 2002
+++ linux-2.5.10-new/arch/ia64/sn/kernel/sn1/sn1_smp.c	Wed May  8 18:06:38 2002
@@ -203,7 +203,7 @@
 	int		backlog = 0;
 #endif
 
-	if (smp_num_cpus == 1) {
+	if (num_online_cpus() == 1) {
 		sn1_ptc_l_range(start, end, nbits);
 		return;
 	}
@@ -302,7 +302,7 @@
 	params->end = end;
 	params->nbits = nbits;
 	params->rid = (unsigned int) ia64_get_rr(start);
-	atomic_set(&params->unfinished_count, smp_num_cpus);
+	atomic_set(&params->unfinished_count, num_online_cpus());
 
 	/* The atomic_set above can hit memory *after* the update
 	 * to ptcParamsEmpty below, which opens a timing window
@@ -425,7 +425,7 @@
 {
 	if (!ia64_ptc_domain_info)  {
 		printk("SMP: Can't find PTC domain info. Forcing UP mode\n");
-		smp_num_cpus = 1;
+		cpu_online_map = 1;
 		return;
 	}
 
diff -Nur linux-2.5.10-base/include/asm-ia64/hardirq.h linux-2.5.10-new/include/asm-ia64/hardirq.h
--- linux-2.5.10-base/include/asm-ia64/hardirq.h	Wed May  8 17:50:34 2002
+++ linux-2.5.10-new/include/asm-ia64/hardirq.h	Wed May  8 17:58:55 2002
@@ -58,7 +58,7 @@
 {
 	int i;
 
-	for (i = 0; i < smp_num_cpus; i++)
+	for (i = 0; i < NR_CPUS; i++)
 		if (irq_count(i))
 			return 1;
 	return 0;
diff -Nur linux-2.5.10-base/include/asm-ia64/smp.h linux-2.5.10-new/include/asm-ia64/smp.h
--- linux-2.5.10-base/include/asm-ia64/smp.h	Wed May  8 17:50:34 2002
+++ linux-2.5.10-new/include/asm-ia64/smp.h	Wed May  8 17:58:55 2002
@@ -39,15 +39,26 @@
 extern volatile unsigned long cpu_online_map;
 extern unsigned long ipi_base_addr;
 extern unsigned char smp_int_redirect;
-extern int smp_num_cpus;
 
 extern volatile int ia64_cpu_to_sapicid[];
 #define cpu_physical_id(i)	ia64_cpu_to_sapicid[i]
-#define cpu_number_map(i)	(i)
-#define cpu_logical_map(i)	(i)
 
 extern unsigned long ap_wakeup_vector;
 
+#define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
+extern inline unsigned int num_online_cpus(void)
+{
+	return hweight64(cpu_online_map);
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
 /*
  * Function to map hard smp processor id to logical id.  Slow, so
  * don't use this in performance-critical code.
@@ -57,7 +68,7 @@
 {
 	int i;
 
-	for (i = 0; i < smp_num_cpus; ++i)
+	for (i = 0; i < NR_CPUS; ++i)
 		if (cpu_physical_id(i) == (__u32) cpuid)
 			break;
 	return i;
@@ -108,6 +119,11 @@
 	return lid.f.id << 8 | lid.f.eid;
 }
 
+/* Upping and downing of CPUs */
+extern int __cpu_disable(void);
+extern void __cpu_die(unsigned int cpu);
+extern int __cpu_up(unsigned int cpu);
+
 #define NO_PROC_ID		0xffffffff	/* no processor magic marker */
 
 extern void __init init_smp_config (void);

