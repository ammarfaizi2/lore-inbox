Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264020AbTCUWb7>; Fri, 21 Mar 2003 17:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263984AbTCUW1a>; Fri, 21 Mar 2003 17:27:30 -0500
Received: from galileo.bork.org ([66.11.174.148]:19722 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id <S263969AbTCUW0T>;
	Fri, 21 Mar 2003 17:26:19 -0500
Date: Fri, 21 Mar 2003 17:37:17 -0500
From: Martin Hicks <mort@wildopensource.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] Generic way to control display of debug printk's
Message-ID: <20030321223717.GA1241@bork.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

It seems to me that a generic way to dynamically control the printing
of certain messages to the console during kernel boot is required.
Systems that really need this are large SMP systems or NUMA machines
with a large number of nodes.  The number of messages that appear 
per-node or per-cpu is huge in these machines.

I've created a small macro called printk_verbose() and a kernel command
line option to decide if these messages should be printed.  The
command line option is:

printk_verbose=no  or =yes

To deal with the very early messages, which are printed before the
kernel command line is processed, i've added a config option to set
whether printk_verbose is turned on by default.

The attached patch implements printk_verbose, and changes certain
printk's to printk_verbose.  The ones that I changed were just to
illustrate my envisioned use of the facility.  Specifically, I tried to
suppress the per-cpu, and per-node memory messages as well as the very
verbose IO APIC debug output.  If some of these printk->printk_verbose
changes are deemed inappropriate that's fine.

Patch is against latest 2.5 bk and only effects x86 pc-compatible 
for now.

Any comments?
mh

-- 
Wild Open Source Inc.                  mort@wildopensource.com



# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1187  -> 1.1188 
#	include/linux/kernel.h	1.34    -> 1.35   
#	arch/i386/kernel/cpu/common.c	1.20    -> 1.21   
#	     mm/page_alloc.c	1.148   -> 1.149  
#	   arch/i386/Kconfig	1.49    -> 1.50   
#	arch/i386/kernel/cpu/intel.c	1.16    -> 1.17   
#	arch/i386/kernel/io_apic.c	1.58    -> 1.59   
#	arch/i386/kernel/smpboot.c	1.54    -> 1.55   
#	arch/i386/kernel/cpu/mcheck/p6.c	1.1     -> 1.2    
#	     kernel/printk.c	1.23    -> 1.24   
#	include/asm-i386/mach-default/mach_apic.h	1.22    -> 1.23   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/21	mort@plato.i.bork.org	1.1188
# Adds a new option called PRINTK_VERBOSE.  This option allows certain printk's
# to be marked as purely extra debug info by using printk_verbose().
# This is useful for quieting certain boot messages that are not
# terribly important, except while debugging.  This is especially true
# on large SMP systems, where each processor or node prints out large
# quantities of debug info.
# --------------------------------------------
#
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Fri Mar 21 17:23:15 2003
+++ b/arch/i386/Kconfig	Fri Mar 21 17:23:15 2003
@@ -1525,6 +1525,25 @@
 	  If you don't debug the kernel, you can say N, but we may not be able
 	  to solve problems without frame pointers.
 
+config PRINTK_VERBOSE
+        bool "Verbose printk during kernel bootup"
+        help
+          If you say Y here you will be able to control how verbose certain
+          early boot messages are with a kernel command line option.  All
+          but the earliest messages can be controlled with this option.
+          If you don't need a lot of early debug info about CPUs and memory
+          say N here.  This is especially helpful on large SMP systems.
+
+config PRINTK_VERBOSE_DEFAULT
+        bool "Turn verbose printk on by default"
+        depends on PRINTK_VERBOSE
+        help
+          The earliest messages that are controlled by PRINTK_VERBOSE cannot
+          be switched on and off with a kernel command line option.  Saying
+          Y to this option turns verbose printk on by default for the earliest
+          stages of the kernel.  The command line option can be used to turn
+          verbose printk off for the later stages of the boot.
+
 config X86_EXTRA_IRQS
 	bool
 	depends on X86_LOCAL_APIC || X86_VOYAGER
diff -Nru a/arch/i386/kernel/cpu/common.c b/arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	Fri Mar 21 17:23:15 2003
+++ b/arch/i386/kernel/cpu/common.c	Fri Mar 21 17:23:15 2003
@@ -83,7 +83,7 @@
 
 	if (n >= 0x80000005) {
 		cpuid(0x80000005, &dummy, &dummy, &ecx, &edx);
-		printk(KERN_INFO "CPU: L1 I Cache: %dK (%d bytes/line), D cache %dK (%d bytes/line)\n",
+		printk_verbose(KERN_INFO "CPU: L1 I Cache: %dK (%d bytes/line), D cache %dK (%d bytes/line)\n",
 			edx>>24, edx&0xFF, ecx>>24, ecx&0xFF);
 		c->x86_cache_size=(ecx>>24)+(edx>>24);	
 	}
@@ -107,7 +107,7 @@
 
 	c->x86_cache_size = l2size;
 
-	printk(KERN_INFO "CPU: L2 Cache: %dK (%d bytes/line)\n",
+	printk_verbose(KERN_INFO "CPU: L2 Cache: %dK (%d bytes/line)\n",
 	       l2size, ecx & 0xFF);
 }
 
@@ -337,7 +337,7 @@
 
 	/* Now the feature flags better reflect actual CPU features! */
 
-	printk(KERN_DEBUG "CPU:     After generic, caps: %08lx %08lx %08lx %08lx\n",
+	printk_verbose(KERN_DEBUG "CPU:     After generic, caps: %08lx %08lx %08lx %08lx\n",
 	       c->x86_capability[0],
 	       c->x86_capability[1],
 	       c->x86_capability[2],
@@ -382,17 +382,17 @@
 		vendor = c->x86_vendor_id;
 
 	if (vendor && strncmp(c->x86_model_id, vendor, strlen(vendor)))
-		printk("%s ", vendor);
+		printk_verbose("%s ", vendor);
 
 	if (!c->x86_model_id[0])
-		printk("%d86", c->x86);
+		printk_verbose("%d86", c->x86);
 	else
-		printk("%s", c->x86_model_id);
+		printk_verbose("%s", c->x86_model_id);
 
 	if (c->x86_mask || c->cpuid_level >= 0) 
-		printk(" stepping %02x\n", c->x86_mask);
+		printk_verbose(" stepping %02x\n", c->x86_mask);
 	else
-		printk("\n");
+		printk_verbose("\n");
 }
 
 unsigned long cpu_initialized __initdata = 0;
diff -Nru a/arch/i386/kernel/cpu/intel.c b/arch/i386/kernel/cpu/intel.c
--- a/arch/i386/kernel/cpu/intel.c	Fri Mar 21 17:23:15 2003
+++ b/arch/i386/kernel/cpu/intel.c	Fri Mar 21 17:23:15 2003
@@ -134,8 +134,8 @@
 	if ((c->x86 == 15) && (c->x86_model == 1) && (c->x86_mask == 1)) {
 		rdmsr (MSR_IA32_MISC_ENABLE, lo, hi);
 		if ((lo & (1<<9)) == 0) {
-			printk (KERN_INFO "CPU: C0 stepping P4 Xeon detected.\n");
-			printk (KERN_INFO "CPU: Disabling hardware prefetching (Errata 037)\n");
+			printk_verbose(KERN_INFO "CPU: C0 stepping P4 Xeon detected.\n");
+			printk_verbose(KERN_INFO "CPU: Disabling hardware prefetching (Errata 037)\n");
 			lo |= (1<<9);	/* Disable hw prefetching */
 			wrmsr (MSR_IA32_MISC_ENABLE, lo, hi);
 		}
diff -Nru a/arch/i386/kernel/cpu/mcheck/p6.c b/arch/i386/kernel/cpu/mcheck/p6.c
--- a/arch/i386/kernel/cpu/mcheck/p6.c	Fri Mar 21 17:23:15 2003
+++ b/arch/i386/kernel/cpu/mcheck/p6.c	Fri Mar 21 17:23:15 2003
@@ -95,7 +95,7 @@
 	machine_check_vector = intel_machine_check;
 	wmb();
 
-	printk (KERN_INFO "Intel machine check architecture supported.\n");
+	printk_verbose(KERN_INFO "Intel machine check architecture supported.\n");
 	rdmsr (MSR_IA32_MCG_CAP, l, h);
 	if (l & (1<<8))	/* Control register present ? */
 		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
@@ -108,6 +108,6 @@
 	}
 
 	set_in_cr4 (X86_CR4_MCE);
-	printk (KERN_INFO "Intel machine check reporting enabled on CPU#%d.\n",
+	printk_verbose(KERN_INFO "Intel machine check reporting enabled on CPU#%d.\n",
 		smp_processor_id());
 }
diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Fri Mar 21 17:23:15 2003
+++ b/arch/i386/kernel/io_apic.c	Fri Mar 21 17:23:15 2003
@@ -1278,16 +1278,16 @@
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	printk("\n");
-	printk(KERN_DEBUG "IO APIC #%d......\n", mp_ioapics[apic].mpc_apicid);
-	printk(KERN_DEBUG ".... register #00: %08X\n", *(int *)&reg_00);
-	printk(KERN_DEBUG ".......    : physical APIC id: %02X\n", reg_00.ID);
-	printk(KERN_DEBUG ".......    : Delivery Type: %X\n", reg_00.delivery_type);
-	printk(KERN_DEBUG ".......    : LTS          : %X\n", reg_00.LTS);
+	printk_verbose(KERN_DEBUG "IO APIC #%d......\n", mp_ioapics[apic].mpc_apicid);
+	printk_verbose(KERN_DEBUG ".... register #00: %08X\n", *(int *)&reg_00);
+	printk_verbose(KERN_DEBUG ".......    : physical APIC id: %02X\n", reg_00.ID);
+	printk_verbose(KERN_DEBUG ".......    : Delivery Type: %X\n", reg_00.delivery_type);
+	printk_verbose(KERN_DEBUG ".......    : LTS          : %X\n", reg_00.LTS);
 	if (reg_00.__reserved_0 || reg_00.__reserved_1 || reg_00.__reserved_2)
 		UNEXPECTED_IO_APIC();
 
-	printk(KERN_DEBUG ".... register #01: %08X\n", *(int *)&reg_01);
-	printk(KERN_DEBUG ".......     : max redirection entries: %04X\n", reg_01.entries);
+	printk_verbose(KERN_DEBUG ".... register #01: %08X\n", *(int *)&reg_01);
+	printk_verbose(KERN_DEBUG ".......     : max redirection entries: %04X\n", reg_01.entries);
 	if (	(reg_01.entries != 0x0f) && /* older (Neptune) boards */
 		(reg_01.entries != 0x17) && /* typical ISA+PCI boards */
 		(reg_01.entries != 0x1b) && /* Compaq Proliant boards */
@@ -1298,8 +1298,8 @@
 	)
 		UNEXPECTED_IO_APIC();
 
-	printk(KERN_DEBUG ".......     : PRQ implemented: %X\n", reg_01.PRQ);
-	printk(KERN_DEBUG ".......     : IO APIC version: %04X\n", reg_01.version);
+	printk_verbose(KERN_DEBUG ".......     : PRQ implemented: %X\n", reg_01.PRQ);
+	printk_verbose(KERN_DEBUG ".......     : IO APIC version: %04X\n", reg_01.version);
 	if (	(reg_01.version != 0x01) && /* 82489DX IO-APICs */
 		(reg_01.version != 0x10) && /* oldest IO-APICs */
 		(reg_01.version != 0x11) && /* Pentium/Pro IO-APICs */
@@ -1311,15 +1311,15 @@
 		UNEXPECTED_IO_APIC();
 
 	if (reg_01.version >= 0x10) {
-		printk(KERN_DEBUG ".... register #02: %08X\n", *(int *)&reg_02);
-		printk(KERN_DEBUG ".......     : arbitration: %02X\n", reg_02.arbitration);
+		printk_verbose(KERN_DEBUG ".... register #02: %08X\n", *(int *)&reg_02);
+		printk_verbose(KERN_DEBUG ".......     : arbitration: %02X\n", reg_02.arbitration);
 		if (reg_02.__reserved_1 || reg_02.__reserved_2)
 			UNEXPECTED_IO_APIC();
 	}
 
-	printk(KERN_DEBUG ".... IRQ redirection table:\n");
+	printk_verbose(KERN_DEBUG ".... IRQ redirection table:\n");
 
-	printk(KERN_DEBUG " NR Log Phy Mask Trig IRR Pol"
+	printk_verbose(KERN_DEBUG " NR Log Phy Mask Trig IRR Pol"
 			  " Stat Dest Deli Vect:   \n");
 
 	for (i = 0; i <= reg_01.entries; i++) {
@@ -1330,13 +1330,13 @@
 		*(((int *)&entry)+1) = io_apic_read(apic, 0x11+i*2);
 		spin_unlock_irqrestore(&ioapic_lock, flags);
 
-		printk(KERN_DEBUG " %02x %03X %02X  ",
+		printk_verbose(KERN_DEBUG " %02x %03X %02X  ",
 			i,
 			entry.dest.logical.logical_dest,
 			entry.dest.physical.physical_dest
 		);
 
-		printk("%1d    %1d    %1d   %1d   %1d    %1d    %1d    %02X\n",
+		printk_verbose("%1d    %1d    %1d   %1d   %1d    %1d    %1d    %02X\n",
 			entry.mask,
 			entry.trigger,
 			entry.irr,
@@ -1348,19 +1348,19 @@
 		);
 	}
 	}
-	printk(KERN_DEBUG "IRQ to pin mappings:\n");
+	printk_verbose(KERN_DEBUG "IRQ to pin mappings:\n");
 	for (i = 0; i < NR_IRQS; i++) {
 		struct irq_pin_list *entry = irq_2_pin + i;
 		if (entry->pin < 0)
 			continue;
-		printk(KERN_DEBUG "IRQ%d ", i);
+		printk_verbose(KERN_DEBUG "IRQ%d ", i);
 		for (;;) {
-			printk("-> %d:%d", entry->apic, entry->pin);
+			printk_verbose("-> %d:%d", entry->apic, entry->pin);
 			if (!entry->next)
 				break;
 			entry = irq_2_pin + entry->next;
 		}
-		printk("\n");
+		printk_verbose("\n");
 	}
 
 	printk(KERN_INFO ".................................... done.\n");
diff -Nru a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
--- a/arch/i386/kernel/smpboot.c	Fri Mar 21 17:23:15 2003
+++ b/arch/i386/kernel/smpboot.c	Fri Mar 21 17:23:15 2003
@@ -856,7 +856,7 @@
 		if (test_bit(cpu, &cpu_callin_map)) {
 			/* number CPUs logically, starting from 1 (BSP is 0) */
 			Dprintk("OK.\n");
-			printk("CPU%d: ", cpu);
+			printk_verbose("CPU%d: ", cpu);
 			print_cpu_info(&cpu_data[cpu]);
 			Dprintk("CPU has booted.\n");
 		} else {
diff -Nru a/include/asm-i386/mach-default/mach_apic.h b/include/asm-i386/mach-default/mach_apic.h
--- a/include/asm-i386/mach-default/mach_apic.h	Fri Mar 21 17:23:15 2003
+++ b/include/asm-i386/mach-default/mach_apic.h	Fri Mar 21 17:23:15 2003
@@ -82,7 +82,7 @@
 static inline int mpc_apic_id(struct mpc_config_processor *m, 
 			struct mpc_config_translation *translation_record)
 {
-	printk("Processor #%d %ld:%ld APIC version %d\n",
+	printk_verbose("Processor #%d %ld:%ld APIC version %d\n",
 			m->mpc_apicid,
 			(m->mpc_cpufeature & CPU_FAMILY_MASK) >> 8,
 			(m->mpc_cpufeature & CPU_MODEL_MASK) >> 4,
diff -Nru a/include/linux/kernel.h b/include/linux/kernel.h
--- a/include/linux/kernel.h	Fri Mar 21 17:23:15 2003
+++ b/include/linux/kernel.h	Fri Mar 21 17:23:15 2003
@@ -91,6 +91,16 @@
 asmlinkage int printk(const char * fmt, ...)
 	__attribute__ ((format (printf, 1, 2)));
 
+extern int printk_verbose_flag;
+#ifdef CONFIG_PRINTK_VERBOSE
+# define printk_verbose(args...) do { \
+        if (printk_verbose_flag) \
+                printk(args); \
+} while (0)
+#else
+# define printk_verbose(args...)
+#endif
+
 static inline void console_silent(void)
 {
 	console_loglevel = 0;
diff -Nru a/kernel/printk.c b/kernel/printk.c
--- a/kernel/printk.c	Fri Mar 21 17:23:15 2003
+++ b/kernel/printk.c	Fri Mar 21 17:23:15 2003
@@ -51,6 +51,12 @@
 	DEFAULT_CONSOLE_LOGLEVEL,	/* default_console_loglevel */
 };
 
+#ifdef CONFIG_PRINTK_VERBOSE_DEFAULT
+int printk_verbose_flag = 1;
+#else
+int printk_verbose_flag = 0;
+#endif
+
 int oops_in_progress;
 
 /*
@@ -140,6 +146,20 @@
 }
 
 __setup("console=", console_setup);
+
+/*
+ * Check if we want to do verbose printk messages during kernel boot.
+ * Called from init/main.c during parse_options.
+ */
+static void __init printk_verbose_setup(char *str)
+{
+        if (!strncmp(str, "yes", 3))
+                printk_verbose_flag = 1;
+        if (!strncmp(str, "no", 2))
+                printk_verbose_flag = 0;
+}
+
+__setup("printk_verbose=", printk_verbose_setup);
 
 /*
  * Commands to do_syslog:
diff -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Fri Mar 21 17:23:15 2003
+++ b/mm/page_alloc.c	Fri Mar 21 17:23:15 2003
@@ -1125,7 +1125,7 @@
 	if (zholes_size)
 		for (i = 0; i < MAX_NR_ZONES; i++)
 			realtotalpages -= zholes_size[i];
-	printk("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
+	printk_verbose("On node %d totalpages: %lu\n", pgdat->node_id, realtotalpages);
 }
 
 /*
@@ -1214,7 +1214,7 @@
 			pcp->batch = 1 * batch;
 			INIT_LIST_HEAD(&pcp->list);
 		}
-		printk("  %s zone: %lu pages, LIFO batch:%lu\n",
+		printk_verbose("  %s zone: %lu pages, LIFO batch:%lu\n",
 				zone_names[j], realsize, batch);
 		INIT_LIST_HEAD(&zone->active_list);
 		INIT_LIST_HEAD(&zone->inactive_list);
