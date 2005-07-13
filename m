Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262643AbVGMNiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbVGMNiW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 09:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVGMNiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 09:38:22 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:9132 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262643AbVGMNiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 09:38:16 -0400
Subject: [PATCH] fix subarchitecture EXPORT_SYMBOL breakage caused by
	i386_ksym reduction
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 09:38:05 -0400
Message-Id: <1121261886.5049.7.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch:

[PATCH] Remove i386_ksyms.c, almost

made files like smp.c do their own EXPORT_SYMBOLS.  This means that all
subarchitectures that override these symbols now have to do the exports
themselves.  This patch adds the exports for voyager (which is the most
affected since it has a separate smp harness).  However, someone should
audit all the other subarchitectures to see if any others got broken.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>

diff --git a/arch/i386/mach-voyager/voyager_basic.c b/arch/i386/mach-voyager/voyager_basic.c
--- a/arch/i386/mach-voyager/voyager_basic.c
+++ b/arch/i386/mach-voyager/voyager_basic.c
@@ -36,6 +36,7 @@
  * Power off function, if any
  */
 void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
 
 int voyager_level = 0;
 
diff --git a/arch/i386/mach-voyager/voyager_smp.c b/arch/i386/mach-voyager/voyager_smp.c
--- a/arch/i386/mach-voyager/voyager_smp.c
+++ b/arch/i386/mach-voyager/voyager_smp.c
@@ -10,6 +10,7 @@
  * the voyager hal to provide the functionality
  */
 #include <linux/config.h>
+#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/kernel_stat.h>
 #include <linux/delay.h>
@@ -40,6 +41,7 @@ static unsigned long cpu_irq_affinity[NR
 /* per CPU data structure (for /proc/cpuinfo et al), visible externally
  * indexed physically */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
+EXPORT_SYMBOL(cpu_data);
 
 /* physical ID of the CPU used to boot the system */
 unsigned char boot_cpu_id;
@@ -72,6 +74,7 @@ static volatile unsigned long smp_invali
 /* Bitmask of currently online CPUs - used by setup.c for
    /proc/cpuinfo, visible externally but still physical */
 cpumask_t cpu_online_map = CPU_MASK_NONE;
+EXPORT_SYMBOL(cpu_online_map);
 
 /* Bitmask of CPUs present in the system - exported by i386_syms.c, used
  * by scheduler but indexed physically */
@@ -238,6 +241,7 @@ static cpumask_t smp_commenced_mask = CP
 /* This is for the new dynamic CPU boot code */
 cpumask_t cpu_callin_map = CPU_MASK_NONE;
 cpumask_t cpu_callout_map = CPU_MASK_NONE;
+EXPORT_SYMBOL(cpu_callout_map);
 
 /* The per processor IRQ masks (these are usually kept in sync) */
 static __u16 vic_irq_mask[NR_CPUS] __cacheline_aligned;
@@ -978,6 +982,7 @@ void flush_tlb_page(struct vm_area_struc
 
 	preempt_enable();
 }
+EXPORT_SYMBOL(flush_tlb_page);
 
 /* enable the requested IRQs */
 static void
@@ -1109,6 +1114,7 @@ smp_call_function (void (*func) (void *i
 
 	return 0;
 }
+EXPORT_SYMBOL(smp_call_function);
 
 /* Sorry about the name.  In an APIC based system, the APICs
  * themselves are programmed to send a timer interrupt.  This is used


