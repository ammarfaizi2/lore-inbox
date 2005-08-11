Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVHKRis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVHKRis (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 13:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVHKRis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 13:38:48 -0400
Received: from fsmlabs.com ([168.103.115.128]:25729 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S932308AbVHKRir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 13:38:47 -0400
Date: Thu, 11 Aug 2005 11:44:42 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>
Subject: Re: [PATCH] i386 boottime for_each_cpu broken
In-Reply-To: <20050811105409.GI8974@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0508111021160.14504@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0508102220070.16483@montezuma.fsmlabs.com>
 <20050811105409.GI8974@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2005, Andi Kleen wrote:

> On Wed, Aug 10, 2005 at 10:59:28PM -0600, Zwane Mwaikambo wrote:
> > for_each_cpu walks through all processors in cpu_possible_map, which is 
> > defined as cpu_callout_map on i386 and isn't initialised until all 
> > processors have been booted. This breaks things which do for_each_cpu 
> > iterations early during boot. So, define cpu_possible_map as a bitmap with 
> > NR_CPUS bits populated. This was triggered by a patch i'm working on which 
> > does alloc_percpu before bringing up secondary processors.
> 
> Better is to initialize it in mpparse.c. That is what x86-64 is doing now.

Good idea, here is an updated version, i left Voyager alone as i have no 
way of testing it.

 arch/i386/kernel/mpparse.c           |    8 +++++++-
 arch/i386/kernel/smpboot.c           |    1 +
 arch/i386/mach-voyager/voyager_smp.c |    1 +
 include/asm-i386/smp.h               |    2 +-
 4 files changed, 10 insertions(+), 2 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

Index: linux-2.6.13-rc5-mm1/arch/i386/kernel/mpparse.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc5-mm1/arch/i386/kernel/mpparse.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 mpparse.c
--- linux-2.6.13-rc5-mm1/arch/i386/kernel/mpparse.c	7 Aug 2005 21:38:03 -0000	1.1.1.1
+++ linux-2.6.13-rc5-mm1/arch/i386/kernel/mpparse.c	11 Aug 2005 17:37:23 -0000
@@ -122,7 +122,7 @@ static int MP_valid_apicid(int apicid, i
 
 static void __init MP_processor_info (struct mpc_config_processor *m)
 {
- 	int ver, apicid;
+ 	int ver, apicid, cpu, found_bsp = 0;
 	physid_mask_t tmp;
  	
 	if (!(m->mpc_cpuflag & CPU_ENABLED))
@@ -181,6 +181,7 @@ static void __init MP_processor_info (st
 	if (m->mpc_cpuflag & CPU_BOOTPROCESSOR) {
 		Dprintk("    Bootup CPU\n");
 		boot_cpu_physical_apicid = m->mpc_apicid;
+		found_bsp = 1;
 	}
 
 	if (num_processors >= NR_CPUS) {
@@ -204,6 +205,11 @@ static void __init MP_processor_info (st
 		return;
 	}
 
+	if (found_bsp)
+		cpu = 0;
+	else
+		cpu = num_processors - 1;
+	cpu_set(cpu, cpu_possible_map);
 	tmp = apicid_to_cpu_present(apicid);
 	physids_or(phys_cpu_present_map, phys_cpu_present_map, tmp);
 	
Index: linux-2.6.13-rc5-mm1/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc5-mm1/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smpboot.c
--- linux-2.6.13-rc5-mm1/arch/i386/kernel/smpboot.c	7 Aug 2005 21:38:03 -0000	1.1.1.1
+++ linux-2.6.13-rc5-mm1/arch/i386/kernel/smpboot.c	11 Aug 2005 17:07:44 -0000
@@ -87,6 +87,7 @@ EXPORT_SYMBOL(cpu_online_map);
 
 cpumask_t cpu_callin_map;
 cpumask_t cpu_callout_map;
+cpumask_t cpu_possible_map;
 EXPORT_SYMBOL(cpu_callout_map);
 static cpumask_t smp_commenced_mask;
 
Index: linux-2.6.13-rc5-mm1/arch/i386/mach-voyager/voyager_smp.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.13-rc5-mm1/arch/i386/mach-voyager/voyager_smp.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 voyager_smp.c
--- linux-2.6.13-rc5-mm1/arch/i386/mach-voyager/voyager_smp.c	7 Aug 2005 21:38:04 -0000	1.1.1.1
+++ linux-2.6.13-rc5-mm1/arch/i386/mach-voyager/voyager_smp.c	11 Aug 2005 17:40:30 -0000
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
