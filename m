Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264938AbTLKNbM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 08:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264944AbTLKNbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 08:31:12 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:3515 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S264938AbTLKNa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 08:30:56 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, David Mosberger <davidm@hpl.hp.com>,
       jbarnes@sgi.com, Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch] quite down SMP boot messages
From: Jes Sorensen <jes@wildopensource.com>
Date: 11 Dec 2003 08:30:52 -0500
Message-ID: <yq0fzfr32ib.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'd like to propose this patch for 2.6.0 or 2.6.1 to quite down some
of the excessive boot messages printed for each CPU. The patch simply
introduces a boot time variable 'smpverbose' which users can set if
they experience problems and want to see the full set of messages.

Once you hit > 2 CPUs the amount of noise printed per CPU starts
becoming a pain, at 64 CPUs it's turning into a royal pain ....

Oh and I also killed a NULL initializer in kernel/cpu.c - bad Rusty ;-)

Thanks,
Jes

diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.0-test11-ia64/arch/ia64/kernel/setup.c linux-2.6.0-test11-ia64/arch/ia64/kernel/setup.c
--- orig/linux-2.6.0-test11-ia64/arch/ia64/kernel/setup.c	Wed Nov 26 12:43:06 2003
+++ linux-2.6.0-test11-ia64/arch/ia64/kernel/setup.c	Thu Dec 11 04:27:44 2003
@@ -58,6 +58,8 @@
 unsigned long __per_cpu_offset[NR_CPUS];
 #endif
 
+extern int smp_verbose;
+
 DEFINE_PER_CPU(struct cpuinfo_ia64, cpu_info);
 DEFINE_PER_CPU(unsigned long, local_per_cpu_offset);
 DEFINE_PER_CPU(unsigned long, ia64_phys_stacked_size_p8);
@@ -516,8 +518,10 @@
 		impl_va_msb = vm2.pal_vm_info_2_s.impl_va_msb;
 		phys_addr_size = vm1.pal_vm_info_1_s.phys_add_size;
 	}
-	printk(KERN_INFO "CPU %d: %lu virtual and %lu physical address bits\n",
-	       smp_processor_id(), impl_va_msb + 1, phys_addr_size);
+	if (smp_verbose)
+		printk(KERN_INFO "CPU %d: %lu virtual and %lu physical "
+		       "address bits\n", smp_processor_id(),
+		       impl_va_msb + 1, phys_addr_size);
 	c->unimpl_va_mask = ~((7L<<61) | ((1L << (impl_va_msb + 1)) - 1));
 	c->unimpl_pa_mask = ~((1L<<63) | ((1L << phys_addr_size) - 1));
 }
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.0-test11-ia64/arch/ia64/kernel/smpboot.c linux-2.6.0-test11-ia64/arch/ia64/kernel/smpboot.c
--- orig/linux-2.6.0-test11-ia64/arch/ia64/kernel/smpboot.c	Thu Dec 11 04:22:40 2003
+++ linux-2.6.0-test11-ia64/arch/ia64/kernel/smpboot.c	Thu Dec 11 03:58:21 2003
@@ -58,6 +58,8 @@
 #endif
 
 
+extern int smp_verbose;
+
 /*
  * ITC synchronization related stuff:
  */
@@ -403,7 +405,8 @@
 
 	if (cpu_isset(cpu, cpu_callin_map)) {
 		/* number CPUs logically, starting from 1 (BSP is 0) */
-		printk(KERN_INFO "CPU%d: CPU has booted.\n", cpu);
+		if (smp_verbose)
+			printk(KERN_INFO "CPU %d: CPU has booted.\n", cpu);
 	} else {
 		printk(KERN_ERR "Processor 0x%x/0x%x is stuck.\n", cpu, sapicid);
 		ia64_cpu_to_sapicid[cpu] = -1;
@@ -578,14 +581,17 @@
 	if (sapicid == -1)
 		return -EINVAL;
 
-	printk(KERN_INFO "Processor %d/%d is spinning up...\n", sapicid, cpu);
+	if (smp_verbose)
+		printk(KERN_INFO "Processor %d/%d is spinning up...\n",
+		       sapicid, cpu);
 
 	/* Processor goes to start_secondary(), sets online flag */
 	ret = do_boot_cpu(sapicid, cpu);
 	if (ret < 0)
 		return ret;
 
-	printk(KERN_INFO "Processor %d has spun up...\n", cpu);
+	if (smp_verbose)
+		printk(KERN_INFO "Processor %d has spun up...\n", cpu);
 	return 0;
 }
 
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.0-test11-ia64/arch/ia64/sn/kernel/setup.c linux-2.6.0-test11-ia64/arch/ia64/sn/kernel/setup.c
--- orig/linux-2.6.0-test11-ia64/arch/ia64/sn/kernel/setup.c	Thu Dec 11 04:22:40 2003
+++ linux-2.6.0-test11-ia64/arch/ia64/sn/kernel/setup.c	Thu Dec 11 04:35:28 2003
@@ -48,6 +48,8 @@
 #include <asm/sn/sn_sal.h>
 #include <asm/sn/sn2/shub.h>
 
+extern int smp_verbose;
+
 DEFINE_PER_CPU(struct pda_s, pda_percpu);
 
 #define pxm_to_nasid(pxm) (((pxm)<<1) | (get_nasid() & ~0x1ff))
@@ -386,8 +388,9 @@
 	cnode = nasid_to_cnodeid(nasid);
 	slice = cpu_physical_id_to_slice(cpuphyid);
 
-	printk("CPU %d: nasid %d, slice %d, cnode %d\n",
-			smp_processor_id(), nasid, slice, cnode);
+	if (smp_verbose)
+		printk("CPU %d: nasid %d, slice %d, cnode %d\n",
+		       smp_processor_id(), nasid, slice, cnode);
 
 	memset(pda, 0, sizeof(pda));
 	pda->p_nodepda = nodepdaindr[cnode];
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.0-test11-ia64/init/main.c linux-2.6.0-test11-ia64/init/main.c
--- orig/linux-2.6.0-test11-ia64/init/main.c	Thu Dec 11 04:22:42 2003
+++ linux-2.6.0-test11-ia64/init/main.c	Thu Dec 11 05:19:19 2003
@@ -118,6 +118,9 @@
 /* Setup configured maximum number of CPUs to activate */
 static unsigned int max_cpus = NR_CPUS;
 
+/* Default to quiet boots, this can be overridden by the user */
+int smp_verbose;
+
 /*
  * Setup routine for controlling SMP activation
  *
@@ -144,6 +147,14 @@
 
 __setup("maxcpus=", maxcpus);
 
+static int __init smpverbose(char *str)
+{
+	smp_verbose = 1;
+	return 1;
+}
+
+__setup("smpverbose", smpverbose);
+
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
 
@@ -369,13 +380,15 @@
 		if (num_online_cpus() >= max_cpus)
 			break;
 		if (cpu_possible(i) && !cpu_online(i)) {
-			printk("Bringing up %i\n", i);
+			if (smp_verbose)
+				printk("Bringing up %i\n", i);
 			cpu_up(i);
 		}
 	}
 
 	/* Any cleanup work */
-	printk("CPUS done %u\n", max_cpus);
+	if (smp_verbose)
+		printk("CPUS done %u\n", max_cpus);
 	smp_cpus_done(max_cpus);
 #if 0
 	/* Get other processors into their bootup holding patterns. */
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.0-test11-ia64/kernel/cpu.c linux-2.6.0-test11-ia64/kernel/cpu.c
--- orig/linux-2.6.0-test11-ia64/kernel/cpu.c	Wed Nov 26 12:45:31 2003
+++ linux-2.6.0-test11-ia64/kernel/cpu.c	Thu Dec 11 03:51:21 2003
@@ -14,7 +14,9 @@
 /* This protects CPUs going up and down... */
 DECLARE_MUTEX(cpucontrol);
 
-static struct notifier_block *cpu_chain = NULL;
+static struct notifier_block *cpu_chain;
+
+extern int smp_verbose;
 
 /* Need to know about CPUs going up/down? */
 int register_cpu_notifier(struct notifier_block *nb)
@@ -55,7 +57,8 @@
 		BUG();
 
 	/* Now call notifier in preparation. */
-	printk("CPU %u IS NOW UP!\n", cpu);
+	if (smp_verbose)
+		printk("CPU %u IS NOW UP!\n", cpu);
 	notifier_call_chain(&cpu_chain, CPU_ONLINE, hcpu);
 
 out_notify:
