Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262087AbVAOEOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262087AbVAOEOE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 23:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262091AbVAOEOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 23:14:04 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:4288 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262116AbVAOEM5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 23:12:57 -0500
Date: Sat, 15 Jan 2005 05:12:56 +0100
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org
Cc: manpreet@fabric7.com, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i386/x86-64: Fix SMP NMI watchdog race
Message-ID: <20050115041256.GE13525@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix SMP race in NMI watchdog on i386/x86-64

Fix a long standing SMP Setup race in the NMI watchdog. The
watchdog would tick from very early and check if all CPUs
increase their timer interrupts. For that it would check
the cpu_online_map. Now if a CPU took too long to boot 
the watchdog would trigger prematurely because the CPU
didn't increase its timer count yet.

Fix is to check cpu_callin_map instead of cpu_online_map
because the first is only set when a CPU started its timer
interrupt. 

I fixed it on i386 and x86-64. 

Description of the problem from Manpreet Singh. Thanks.

Cc: manpreet@fabric7.com
Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/include/asm-x86_64/smp.h
===================================================================
--- linux.orig/include/asm-x86_64/smp.h	2005-01-14 10:12:26.%N +0100
+++ linux/include/asm-x86_64/smp.h	2005-01-14 10:22:57.%N +0100
@@ -59,6 +59,7 @@
  */
 
 extern cpumask_t cpu_callout_map;
+extern cpumask_t cpu_callin_map;
 #define cpu_possible_map cpu_callout_map
 
 static inline int num_booting_cpus(void)
Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c	2004-10-19 01:55:01.%N +0200
+++ linux/arch/i386/kernel/nmi.c	2005-01-14 10:22:57.%N +0100
@@ -117,7 +117,7 @@
 	/* FIXME: Only boot CPU is online at this stage.  Check CPUs
            as they come up. */
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (!cpu_online(cpu))
+		if (!cpu_isset(cpu, cpu_callin_map))
 			continue;
 		if (nmi_count(cpu) - prev_nmi_count[cpu] <= 5) {
 			printk("CPU#%d: NMI appears to be stuck!\n", cpu);
Index: linux/arch/i386/kernel/smpboot.c
===================================================================
--- linux.orig/arch/i386/kernel/smpboot.c	2005-01-14 10:22:53.%N +0100
+++ linux/arch/i386/kernel/smpboot.c	2005-01-14 10:22:57.%N +0100
@@ -67,7 +67,7 @@
 /* bitmap of online cpus */
 cpumask_t cpu_online_map;
 
-static cpumask_t cpu_callin_map;
+cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
 static cpumask_t smp_commenced_mask;
 
Index: linux/arch/x86_64/kernel/nmi.c
===================================================================
--- linux.orig/arch/x86_64/kernel/nmi.c	2005-01-04 12:12:39.%N +0100
+++ linux/arch/x86_64/kernel/nmi.c	2005-01-14 10:22:57.%N +0100
@@ -130,7 +130,9 @@
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		if (!cpu_online(cpu))
+		/* Check cpu_callin_map here because that is set
+		   after the timer is started. */
+		if (!cpu_isset(cpu, cpu_callin_map))
 			continue;
 		if (cpu_pda[cpu].__nmi_count - counts[cpu] <= 5) {
 			printk("CPU#%d: NMI appears to be stuck (%d)!\n", 
Index: linux/include/asm-i386/smp.h
===================================================================
--- linux.orig/include/asm-i386/smp.h	2005-01-14 10:12:25.%N +0100
+++ linux/include/asm-i386/smp.h	2005-01-14 10:22:57.%N +0100
@@ -53,6 +53,7 @@
 #define __smp_processor_id() (current_thread_info()->cpu)
 
 extern cpumask_t cpu_callout_map;
+extern cpumask_t cpu_callin_map;
 #define cpu_possible_map cpu_callout_map
 
 /* We don't mark CPUs online until __cpu_up(), so we need another measure */
Index: linux/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux.orig/arch/x86_64/kernel/smpboot.c	2005-01-14 10:22:53.%N +0100
+++ linux/arch/x86_64/kernel/smpboot.c	2005-01-14 10:22:57.%N +0100
@@ -64,7 +64,7 @@
 /* Bitmask of currently online CPUs */
 cpumask_t cpu_online_map;
 
-static cpumask_t cpu_callin_map;
+cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
 static cpumask_t smp_commenced_mask;
 
