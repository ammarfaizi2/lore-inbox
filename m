Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030214AbWFAQQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWFAQQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 12:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbWFAQQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 12:16:34 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:12293 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1030214AbWFAQQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 12:16:33 -0400
Date: Thu, 1 Jun 2006 20:16:19 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: earny@net4u.de, list-lkml@net4u.de, linux-kernel@vger.kernel.org,
       Richard Henderson <rth@twiddle.net>
Subject: Re: ALPHA 2.6.17-rc5 AIC7###: does not boot
Message-ID: <20060601201619.A978@jurassic.park.msu.ru>
References: <200605301834.19795.list-lkml@net4u.de> <20060531154648.53539006.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060531154648.53539006.akpm@osdl.org>; from akpm@osdl.org on Wed, May 31, 2006 at 03:46:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2006 at 03:46:48PM -0700, Andrew Morton wrote:
> But I don't recall us making any changes in the Alpha interrupt-management
> code post-2.6.16.  Perhaps it was PCI changes which introduced this
> regression.

No. It looks like SMP is screwed up again. And some interrupts don't work
as they get routed to inactive CPU.

Ernst, please try this patch.

Ivan.

--- 2.6.17-rc5/arch/alpha/kernel/alpha_ksyms.c	Thu Jun  1 18:11:41 2006
+++ linux/arch/alpha/kernel/alpha_ksyms.c	Thu Jun  1 18:13:38 2006
@@ -182,7 +182,6 @@ EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(smp_call_function);
 EXPORT_SYMBOL(smp_call_function_on_cpu);
 EXPORT_SYMBOL(_atomic_dec_and_lock);
-EXPORT_SYMBOL(cpu_present_mask);
 #endif /* CONFIG_SMP */
 
 /*
--- 2.6.17-rc5/arch/alpha/kernel/smp.c	Thu Jun  1 18:11:41 2006
+++ linux/arch/alpha/kernel/smp.c	Thu Jun  1 18:18:44 2006
@@ -68,7 +68,6 @@ enum ipi_message_type {
 static int smp_secondary_alive __initdata = 0;
 
 /* Which cpus ids came online.  */
-cpumask_t cpu_present_mask;
 cpumask_t cpu_online_map;
 
 EXPORT_SYMBOL(cpu_online_map);
@@ -439,7 +438,7 @@ setup_smp(void)
 			if ((cpu->flags & 0x1cc) == 0x1cc) {
 				smp_num_probed++;
 				/* Assume here that "whami" == index */
-				cpu_set(i, cpu_present_mask);
+				cpu_set(i, cpu_present_map);
 				cpu->pal_revision = boot_cpu_palrev;
 			}
 
@@ -450,11 +449,10 @@ setup_smp(void)
 		}
 	} else {
 		smp_num_probed = 1;
-		cpu_set(boot_cpuid, cpu_present_mask);
 	}
 
-	printk(KERN_INFO "SMP: %d CPUs probed -- cpu_present_mask = %lx\n",
-	       smp_num_probed, cpu_possible_map.bits[0]);
+	printk(KERN_INFO "SMP: %d CPUs probed -- cpu_present_map = %lx\n",
+	       smp_num_probed, cpu_present_map.bits[0]);
 }
 
 /*
@@ -473,7 +471,7 @@ smp_prepare_cpus(unsigned int max_cpus)
 
 	/* Nothing to do on a UP box, or when told not to.  */
 	if (smp_num_probed == 1 || max_cpus == 0) {
-		cpu_present_mask = cpumask_of_cpu(boot_cpuid);
+		cpu_present_map = cpumask_of_cpu(boot_cpuid);
 		printk(KERN_INFO "SMP mode deactivated.\n");
 		return;
 	}
@@ -486,10 +484,6 @@ smp_prepare_cpus(unsigned int max_cpus)
 void __devinit
 smp_prepare_boot_cpu(void)
 {
-	/*
-	 * Mark the boot cpu (current cpu) as online
-	 */ 
-	cpu_set(smp_processor_id(), cpu_online_map);
 }
 
 int __devinit
--- 2.6.17-rc5/arch/alpha/kernel/process.c	Mon Mar 20 08:53:29 2006
+++ linux/arch/alpha/kernel/process.c	Thu Jun  1 18:13:38 2006
@@ -94,7 +94,7 @@ common_shutdown_1(void *generic_ptr)
 	if (cpuid != boot_cpuid) {
 		flags |= 0x00040000UL; /* "remain halted" */
 		*pflags = flags;
-		clear_bit(cpuid, &cpu_present_mask);
+		cpu_clear(cpuid, cpu_present_map);
 		halt();
 	}
 #endif
@@ -120,8 +120,8 @@ common_shutdown_1(void *generic_ptr)
 
 #ifdef CONFIG_SMP
 	/* Wait for the secondaries to halt. */
-	cpu_clear(boot_cpuid, cpu_possible_map);
-	while (cpus_weight(cpu_possible_map))
+	cpu_clear(boot_cpuid, cpu_present_map);
+	while (cpus_weight(cpu_present_map))
 		barrier();
 #endif
 
--- 2.6.17-rc5/arch/alpha/kernel/sys_titan.c	Mon Mar 20 08:53:29 2006
+++ linux/arch/alpha/kernel/sys_titan.c	Thu Jun  1 18:13:38 2006
@@ -66,7 +66,7 @@ titan_update_irq_hw(unsigned long mask)
 	register int bcpu = boot_cpuid;
 
 #ifdef CONFIG_SMP
-	cpumask_t cpm = cpu_present_mask;
+	cpumask_t cpm = cpu_present_map;
 	volatile unsigned long *dim0, *dim1, *dim2, *dim3;
 	unsigned long mask0, mask1, mask2, mask3, dummy;
 
--- 2.6.17-rc5/include/asm-alpha/smp.h	Mon Mar 20 08:53:29 2006
+++ linux/include/asm-alpha/smp.h	Thu Jun  1 18:13:38 2006
@@ -45,10 +45,8 @@ extern struct cpuinfo_alpha cpu_data[NR_
 #define hard_smp_processor_id()	__hard_smp_processor_id()
 #define raw_smp_processor_id()	(current_thread_info()->cpu)
 
-extern cpumask_t cpu_present_mask;
-extern cpumask_t cpu_online_map;
 extern int smp_num_cpus;
-#define cpu_possible_map	cpu_present_mask
+#define cpu_possible_map	cpu_present_map
 
 int smp_call_function_on_cpu(void (*func) (void *info), void *info,int retry, int wait, cpumask_t cpu);
 
