Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbVHKEyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVHKEyE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 00:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbVHKEyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 00:54:03 -0400
Received: from fsmlabs.com ([168.103.115.128]:2256 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S932255AbVHKEyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 00:54:00 -0400
Date: Wed, 10 Aug 2005 22:59:28 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: [PATCH] i386 boottime for_each_cpu broken
Message-ID: <Pine.LNX.4.61.0508102220070.16483@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

for_each_cpu walks through all processors in cpu_possible_map, which is 
defined as cpu_callout_map on i386 and isn't initialised until all 
processors have been booted. This breaks things which do for_each_cpu 
iterations early during boot. So, define cpu_possible_map as a bitmap with 
NR_CPUS bits populated. This was triggered by a patch i'm working on which 
does alloc_percpu before bringing up secondary processors.

 arch/i386/kernel/smpboot.c           |    1 +
 arch/i386/mach-voyager/voyager_smp.c |    1 +
 include/asm-i386/smp.h               |    2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.13-rc5-mm1/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc5-mm1/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smpboot.c
--- linux-2.6.13-rc5-mm1/arch/i386/kernel/smpboot.c	7 Aug 2005 21:38:03 -0000	1.1.1.1
+++ linux-2.6.13-rc5-mm1/arch/i386/kernel/smpboot.c	11 Aug 2005 04:26:06 -0000
@@ -87,6 +87,7 @@ EXPORT_SYMBOL(cpu_online_map);
 
 cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
+cpumask_t cpu_possible_map = CPU_MASK_ALL;
 EXPORT_SYMBOL(cpu_callout_map);
 static cpumask_t smp_commenced_mask;
 
Index: linux-2.6.13-rc5-mm1/arch/i386/mach-voyager/voyager_smp.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc5-mm1/arch/i386/mach-voyager/voyager_smp.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 voyager_smp.c
--- linux-2.6.13-rc5-mm1/arch/i386/mach-voyager/voyager_smp.c	7 Aug 2005 21:38:04 -0000	1.1.1.1
+++ linux-2.6.13-rc5-mm1/arch/i386/mach-voyager/voyager_smp.c	11 Aug 2005 04:26:29 -0000
@@ -241,6 +241,7 @@ static cpumask_t smp_commenced_mask = CP
 /* This is for the new dynamic CPU boot code */
 cpumask_t cpu_callin_map = CPU_MASK_NONE;
 cpumask_t cpu_callout_map = CPU_MASK_NONE;
+cpumask_t cpu_possible_map = CPU_MASK_ALL;
 EXPORT_SYMBOL(cpu_callout_map);
 
 /* The per processor IRQ masks (these are usually kept in sync) */
Index: linux-2.6.13-rc5-mm1/include/asm-i386/smp.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc5-mm1/include/asm-i386/smp.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smp.h
--- linux-2.6.13-rc5-mm1/include/asm-i386/smp.h	7 Aug 2005 21:38:37 -0000	1.1.1.1
+++ linux-2.6.13-rc5-mm1/include/asm-i386/smp.h	11 Aug 2005 04:25:26 -0000
@@ -59,7 +59,7 @@ extern void cpu_uninit(void);
 
 extern cpumask_t cpu_callout_map;
 extern cpumask_t cpu_callin_map;
-#define cpu_possible_map cpu_callout_map
+extern cpumask_t cpu_possible_map;
 
 /* We don't mark CPUs online until __cpu_up(), so we need another measure */
 static inline int num_booting_cpus(void)
