Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbTLKOMN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 09:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264962AbTLKOMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 09:12:03 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:25275 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S264961AbTLKOLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 09:11:45 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, David Mosberger <davidm@hpl.hp.com>,
       jbarnes@sgi.com, Rusty Russell <rusty@rustcorp.com.au>,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch] quiet down SMP boot messages
References: <yq0fzfr32ib.fsf@wildopensource.com>
From: Jes Sorensen <jes@wildopensource.com>
Date: 11 Dec 2003 09:11:40 -0500
In-Reply-To: <yq0fzfr32ib.fsf@wildopensource.com>
Message-ID: <yq0ad5z30mb.fsf@wildopensource.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jes" == Jes Sorensen <jes@wildopensource.com> writes:

Jes> Hi, I'd like to propose this patch for 2.6.0 or 2.6.1 to quiet
Jes> down some of the excessive boot messages printed for each
Jes> CPU. The patch simply introduces a boot time variable
Jes> 'smpverbose' which users can set if they experience problems and
Jes> want to see the full set of messages.

Hi,

Here is an improved version. Andi suggested that I move the
smp_verbose prototype to include/linux/smp.h and I also nailed another
NULL initializer in init/main.c

Oh and I fixed my b0rked spelling as well - time to look at the screen
when typing ;-)

Cheers,
Jes

diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.0-test11-ia64/arch/ia64/kernel/setup.c linux-2.6.0-test11-ia64/arch/ia64/kernel/setup.c
--- orig/linux-2.6.0-test11-ia64/arch/ia64/kernel/setup.c	Wed Nov 26 12:43:06 2003
+++ linux-2.6.0-test11-ia64/arch/ia64/kernel/setup.c	Thu Dec 11 06:07:56 2003
@@ -516,8 +516,10 @@
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
+++ linux-2.6.0-test11-ia64/arch/ia64/kernel/smpboot.c	Thu Dec 11 06:08:03 2003
@@ -403,7 +403,8 @@
 
 	if (cpu_isset(cpu, cpu_callin_map)) {
 		/* number CPUs logically, starting from 1 (BSP is 0) */
-		printk(KERN_INFO "CPU%d: CPU has booted.\n", cpu);
+		if (smp_verbose)
+			printk(KERN_INFO "CPU %d: CPU has booted.\n", cpu);
 	} else {
 		printk(KERN_ERR "Processor 0x%x/0x%x is stuck.\n", cpu, sapicid);
 		ia64_cpu_to_sapicid[cpu] = -1;
@@ -578,14 +579,17 @@
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
+++ linux-2.6.0-test11-ia64/arch/ia64/sn/kernel/setup.c	Thu Dec 11 06:07:51 2003
@@ -386,8 +386,9 @@
 	cnode = nasid_to_cnodeid(nasid);
 	slice = cpu_physical_id_to_slice(cpuphyid);
 
-	printk("CPU %d: nasid %d, slice %d, cnode %d\n",
-			smp_processor_id(), nasid, slice, cnode);
+	if (smp_verbose)
+		printk("CPU %d: nasid %d, slice %d, cnode %d\n",
+		       smp_processor_id(), nasid, slice, cnode);
 
 	memset(pda, 0, sizeof(pda));
 	pda->p_nodepda = nodepdaindr[cnode];
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.0-test11-ia64/include/linux/smp.h linux-2.6.0-test11-ia64/include/linux/smp.h
--- orig/linux-2.6.0-test11-ia64/include/linux/smp.h	Wed Nov 26 12:44:20 2003
+++ linux-2.6.0-test11-ia64/include/linux/smp.h	Thu Dec 11 05:50:13 2003
@@ -90,6 +90,8 @@
  */
 void smp_prepare_boot_cpu(void);
 
+extern int smp_verbose;
+
 #else /* !SMP */
 
 /*
@@ -106,6 +108,8 @@
 #define cpu_possible(cpu)			({ BUG_ON((cpu) != 0); 1; })
 #define smp_prepare_boot_cpu()			do {} while (0)
 
+#define smp_verbose				0
+
 #endif /* !SMP */
 
 #define get_cpu()		({ preempt_disable(); smp_processor_id(); })
diff -urN -X /usr/people/jes/exclude-linux orig/linux-2.6.0-test11-ia64/init/main.c linux-2.6.0-test11-ia64/init/main.c
--- orig/linux-2.6.0-test11-ia64/init/main.c	Thu Dec 11 04:22:42 2003
+++ linux-2.6.0-test11-ia64/init/main.c	Thu Dec 11 05:51:46 2003
@@ -108,7 +108,7 @@
 
 extern void time_init(void);
 /* Default late time init is NULL. archs can override this later. */
-void (*late_time_init)(void) = NULL;
+void (*late_time_init)(void);
 extern void softirq_init(void);
 
 int rows, cols;
@@ -144,6 +144,18 @@
 
 __setup("maxcpus=", maxcpus);
 
+#ifdef CONFIG_SMP
+/* Default to quiet boots, this can be overridden by the user */
+int smp_verbose;
+static int __init smpverbose(char *str)
+{
+	smp_verbose = 1;
+	return 1;
+}
+
+__setup("smpverbose", smpverbose);
+#endif
+
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
 
@@ -369,13 +381,15 @@
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
+++ linux-2.6.0-test11-ia64/kernel/cpu.c	Thu Dec 11 06:08:11 2003
@@ -14,7 +14,7 @@
 /* This protects CPUs going up and down... */
 DECLARE_MUTEX(cpucontrol);
 
-static struct notifier_block *cpu_chain = NULL;
+static struct notifier_block *cpu_chain;
 
 /* Need to know about CPUs going up/down? */
 int register_cpu_notifier(struct notifier_block *nb)
@@ -55,7 +55,8 @@
 		BUG();
 
 	/* Now call notifier in preparation. */
-	printk("CPU %u IS NOW UP!\n", cpu);
+	if (smp_verbose)
+		printk("CPU %u IS NOW UP!\n", cpu);
 	notifier_call_chain(&cpu_chain, CPU_ONLINE, hcpu);
 
 out_notify:
