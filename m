Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266825AbUH3FGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbUH3FGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 01:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267186AbUH3FGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 01:06:41 -0400
Received: from ozlabs.org ([203.10.76.45]:49842 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266825AbUH3FF5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 01:05:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16690.46469.181420.509398@cargo.ozlabs.ibm.com>
Date: Mon, 30 Aug 2004 15:05:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: nathanl@austin.ibm.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 (1/3) Rework PPC64 cpu map setup
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move all cpu map initializations to one place (except for the online
map -- cpus mark themselves online as they come up).  This sets up
cpu_possible_map early enough that we can use num_possible_cpus for
allocating irqstacks instead of NR_CPUS.  Hopefully this should also
help set the stage for kexec.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc64/kernel/prom.c akpm/arch/ppc64/kernel/prom.c
--- linux-2.5/arch/ppc64/kernel/prom.c	2004-08-24 07:22:47.000000000 +1000
+++ akpm/arch/ppc64/kernel/prom.c	2004-08-30 14:51:01.437354816 +1000
@@ -939,20 +939,11 @@
 			prom_getprop(node, "reg", &reg, sizeof(reg));
 			lpaca[cpuid].hw_cpu_id = reg;
 
-#ifdef CONFIG_SMP
-			cpu_set(cpuid, RELOC(cpu_possible_map));
-			cpu_set(cpuid, RELOC(cpu_present_map));
-			if (reg == 0)
-				cpu_set(cpuid, RELOC(cpu_online_map));
-#endif /* CONFIG_SMP */
 			cpuid++;
 		}
 		return;
 	}
 
-	/* Initially, we must have one active CPU. */
-	_systemcfg->processorCount = 1;
-
 	prom_debug("prom_hold_cpus: start...\n");
 	prom_debug("    1) spinloop       = 0x%x\n", (unsigned long)spinloop);
 	prom_debug("    1) *spinloop      = 0x%x\n", *spinloop);
@@ -1038,23 +1029,13 @@
 				 * even if we never start it. */
 				if (cpuid >= NR_CPUS)
 					goto next;
-#ifdef CONFIG_SMP
-				/* Set the number of active processors. */
-				_systemcfg->processorCount++;
-				cpu_set(cpuid, RELOC(cpu_possible_map));
-				cpu_set(cpuid, RELOC(cpu_present_map));
-#endif
 			} else {
 				prom_printf("... failed: %x\n", *acknowledge);
 			}
 		}
 #ifdef CONFIG_SMP
-		else {
+		else
 			prom_printf("%x : booting  cpu %s\n", cpuid, path);
-			cpu_set(cpuid, RELOC(cpu_possible_map));
-			cpu_set(cpuid, RELOC(cpu_online_map));
-			cpu_set(cpuid, RELOC(cpu_present_map));
-		}
 #endif
 next:
 #ifdef CONFIG_SMP
@@ -1067,9 +1048,6 @@
 			prom_printf("%x : preparing thread ... ",
 				    interrupt_server[i]);
 			if (_naca->smt_state) {
-				cpu_set(cpuid, RELOC(cpu_present_map));
-				cpu_set(cpuid, RELOC(cpu_possible_map));
-				_systemcfg->processorCount++;
 				prom_printf("available\n");
 			} else {
 				prom_printf("not available\n");
@@ -1099,11 +1077,7 @@
 						pir & 0x3ff;
 				}
 			}
-/* 			cpu_set(i+1, cpu_online_map); */
-			cpu_set(i+1, RELOC(cpu_possible_map));
-			cpu_set(i+1, RELOC(cpu_present_map));
 		}
-		_systemcfg->processorCount *= 2;
 	} else {
 		prom_printf("Processor is not HMT capable\n");
 	}
diff -urN linux-2.5/arch/ppc64/kernel/setup.c akpm/arch/ppc64/kernel/setup.c
--- linux-2.5/arch/ppc64/kernel/setup.c	2004-08-24 07:22:47.000000000 +1000
+++ akpm/arch/ppc64/kernel/setup.c	2004-08-30 14:51:01.430355880 +1000
@@ -155,6 +155,94 @@
 	early_console_initialized = 0;
 }
 
+#if !defined(CONFIG_PPC_ISERIES) && defined(CONFIG_SMP)
+/**
+ * setup_cpu_maps - initialize the following cpu maps:
+ *                  cpu_possible_map
+ *                  cpu_present_map
+ *                  cpu_sibling_map
+ *
+ * Having the possible map set up early allows us to restrict allocations
+ * of things like irqstacks to num_possible_cpus() rather than NR_CPUS.
+ *
+ * We do not initialize the online map here; cpus set their own bits in
+ * cpu_online_map as they come up.
+ *
+ * This function is valid only for Open Firmware systems.  finish_device_tree
+ * must be called before using this.
+ */
+static void __init setup_cpu_maps(void)
+{
+	struct device_node *dn = NULL;
+	int cpu = 0;
+
+	while ((dn = of_find_node_by_type(dn, "cpu")) && cpu < NR_CPUS) {
+		u32 *intserv;
+		int j, len = sizeof(u32), nthreads;
+
+		intserv = (u32 *)get_property(dn, "ibm,ppc-interrupt-server#s",
+					      &len);
+		nthreads = len / sizeof(u32);
+
+		for (j = 0; j < nthreads && cpu < NR_CPUS; j++) {
+			cpu_set(cpu, cpu_possible_map);
+			cpu_set(cpu, cpu_present_map);
+			cpu++;
+		}
+	}
+
+	/*
+	 * On pSeries LPAR, we need to know how many cpus
+	 * could possibly be added to this partition.
+	 */
+	if (systemcfg->platform == PLATFORM_PSERIES_LPAR &&
+				(dn = of_find_node_by_path("/rtas"))) {
+		int num_addr_cell, num_size_cell, maxcpus;
+		unsigned int *ireg;
+
+		num_addr_cell = prom_n_addr_cells(dn);
+		num_size_cell = prom_n_size_cells(dn);
+
+		ireg = (unsigned int *)
+			get_property(dn, "ibm,lrdr-capacity", NULL);
+
+		if (!ireg)
+			goto out;
+
+		maxcpus = ireg[num_addr_cell + num_size_cell];
+
+		/* Double maxcpus for processors which have SMT capability */
+		if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+			maxcpus *= 2;
+
+		if (maxcpus > NR_CPUS) {
+			printk(KERN_WARNING
+			       "Partition configured for %d cpus, "
+			       "operating system maximum is %d.\n",
+			       maxcpus, NR_CPUS);
+			maxcpus = NR_CPUS;
+		} else
+			printk(KERN_INFO "Partition configured for %d cpus.\n",
+			       maxcpus);
+
+		for (cpu = 0; cpu < maxcpus; cpu++)
+			cpu_set(cpu, cpu_possible_map);
+	out:
+		of_node_put(dn);
+	}
+
+	/*
+	 * Do the sibling map; assume only two threads per processor.
+	 */
+	for_each_cpu(cpu) {
+		cpu_set(cpu, cpu_sibling_map[cpu]);
+		if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+			cpu_set(cpu ^ 0x1, cpu_sibling_map[cpu]);
+	}
+
+	systemcfg->processorCount = num_present_cpus();
+}
+#endif /* !defined(CONFIG_PPC_ISERIES) && defined(CONFIG_SMP) */
 /*
  * Do some initial setup of the system.  The parameters are those which 
  * were passed in from the bootloader.
@@ -220,6 +308,13 @@
 	}
 #endif /* CONFIG_BOOTX_TEXT */
 
+#ifdef CONFIG_PPC_PMAC
+	if (systemcfg->platform == PLATFORM_POWERMAC) {
+		finish_device_tree();
+		pmac_init(r3, r4, r5, r6, r7);
+	}
+#endif /* CONFIG_PPC_PMAC */
+
 #ifdef CONFIG_PPC_PSERIES
 	if (systemcfg->platform & PLATFORM_PSERIES) {
 		early_console_initialized = 1;
@@ -227,31 +322,32 @@
 		__irq_offset_value = NUM_ISA_INTERRUPTS;
 		finish_device_tree();
 		chrp_init(r3, r4, r5, r6, r7);
+	}
+#endif /* CONFIG_PPC_PSERIES */
 
 #ifdef CONFIG_SMP
-		/* Start secondary threads on SMT systems; primary threads
-		 * are already in the running state.
-		 */
-		for_each_present_cpu(i) {
-			if (query_cpu_stopped
-			    (get_hard_smp_processor_id(i)) == 0) {
-				printk("%16.16x : starting thread\n", i);
-				rtas_call(rtas_token("start-cpu"), 3, 1, &ret,
-					  get_hard_smp_processor_id(i), 
-					  (u32)*((unsigned long *)pseries_secondary_smp_init),
-					  i);
-			}
+#ifndef CONFIG_PPC_ISERIES
+	/*
+	 * iSeries has already initialized the cpu maps at this point.
+	 */
+	setup_cpu_maps();
+#endif /* CONFIG_PPC_ISERIES */
+
+#ifdef CONFIG_PPC_PSERIES
+	/* Start secondary threads on SMT systems; primary threads
+	 * are already in the running state.
+	 */
+	for_each_present_cpu(i) {
+		if (query_cpu_stopped(get_hard_smp_processor_id(i)) == 0) {
+			printk("%16.16x : starting thread\n", i);
+			rtas_call(rtas_token("start-cpu"), 3, 1, &ret,
+				  get_hard_smp_processor_id(i),
+				  (u32)*((unsigned long *)pseries_secondary_smp_init),
+				  i);
 		}
-#endif /* CONFIG_SMP */
 	}
 #endif /* CONFIG_PPC_PSERIES */
-
-#ifdef CONFIG_PPC_PMAC
-	if (systemcfg->platform == PLATFORM_POWERMAC) {
-		finish_device_tree();
-		pmac_init(r3, r4, r5, r6, r7);
-	}
-#endif /* CONFIG_PPC_PMAC */
+#endif /* CONFIG_SMP */
 
 #if defined(CONFIG_HOTPLUG_CPU) &&  !defined(CONFIG_PPC_PMAC)
 	rtas_stop_self_args.token = rtas_token("stop-self");
diff -urN linux-2.5/arch/ppc64/kernel/smp.c akpm/arch/ppc64/kernel/smp.c
--- linux-2.5/arch/ppc64/kernel/smp.c	2004-08-30 10:55:36.000000000 +1000
+++ akpm/arch/ppc64/kernel/smp.c	2004-08-30 14:51:01.441354208 +1000
@@ -401,56 +401,11 @@
 	}
 	return 1;
 }
-
-static inline void look_for_more_cpus(void)
-{
-	int num_addr_cell, num_size_cell, len, i, maxcpus;
-	struct device_node *np;
-	unsigned int *ireg;
-
-	/* Find the property which will tell us about how many CPUs
-	 * we're allowed to have. */
-	if ((np = find_path_device("/rtas")) == NULL) {
-		printk(KERN_ERR "Could not find /rtas in device tree!");
-		return;
-	}
-	num_addr_cell = prom_n_addr_cells(np);
-	num_size_cell = prom_n_size_cells(np);
-
-	ireg = (unsigned int *)get_property(np, "ibm,lrdr-capacity", &len);
-	if (ireg == NULL) {
-		/* FIXME: make sure not marked as lrdr_capable() */
-		return;
-	}
-
-	maxcpus = ireg[num_addr_cell + num_size_cell];
-
-	/* Double maxcpus for processors which have SMT capability */
-	if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
-		maxcpus *= 2;
-
-
-	if (maxcpus > NR_CPUS) {
-		printk(KERN_WARNING
-		       "Partition configured for %d cpus, "
-		       "operating system maximum is %d.\n", maxcpus, NR_CPUS);
-		maxcpus = NR_CPUS;
-	} else
-		printk(KERN_INFO "Partition configured for %d cpus.\n",
-		       maxcpus);
-
-	/* Make those cpus (which might appear later) possible too. */
-	for (i = 0; i < maxcpus; i++)
-		cpu_set(i, cpu_possible_map);
-}
 #else /* ... CONFIG_HOTPLUG_CPU */
 static inline int __devinit smp_startup_cpu(unsigned int lcpu)
 {
 	return 1;
 }
-static inline void look_for_more_cpus(void)
-{
-}
 #endif /* CONFIG_HOTPLUG_CPU */
 
 static void smp_pSeries_kick_cpu(int nr)
@@ -832,8 +787,6 @@
 	 */
 	do_gtod.tb_orig_stamp = tb_last_stamp;
 	systemcfg->tb_orig_stamp = tb_last_stamp;
-
-	look_for_more_cpus();
 #endif
 
 	max_cpus = smp_ops->probe();
@@ -846,19 +799,12 @@
 	for_each_cpu(cpu)
 		if (cpu != boot_cpuid)
 			smp_create_idle(cpu);
-
-	for_each_cpu(cpu) {
-		cpu_set(cpu, cpu_sibling_map[cpu]);
-		if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
-			cpu_set(cpu ^ 0x1, cpu_sibling_map[cpu]);
-	}
 }
 
 void __devinit smp_prepare_boot_cpu(void)
 {
 	BUG_ON(smp_processor_id() != boot_cpuid);
 
-	/* cpu_possible is set up in prom.c */
 	cpu_set(boot_cpuid, cpu_online_map);
 
 	paca[boot_cpuid].__current = current;
