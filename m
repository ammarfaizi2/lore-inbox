Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUHBVq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUHBVq1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 17:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUHBVq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 17:46:27 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:18561 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263761AbUHBVqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 17:46:23 -0400
Subject: Re: [PATCH] Create cpu_sibling_map for PPC64
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, LKML <linux-kernel@vger.kernel.org>,
       LSE Tech <lse-tech@lists.sourceforge.net>,
       Nathan Lynch <nathanl@austin.ibm.com>
In-Reply-To: <20040731214512.36123c10.akpm@osdl.org>
References: <1091049554.19459.33.camel@arrakis>
	 <20040731214512.36123c10.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1091483158.4415.52.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 02 Aug 2004 14:45:59 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 21:45, Andrew Morton wrote:
> Matthew Dobson <colpatch@us.ibm.com> wrote:
> >
> > In light of some proposed changes in the sched_domains code, I coded up
> >  this little ditty that simply creates and populates a cpu_sibling_map
> >  for PPC64 machines.
> 
> err, did you compile it?

Ok...  beyond not compiling it, I must have had my brain turned off when
I pushed the patch forward from 2.6.7-mm? to 2.6.8-rc2-mm1, because
cpu_sibling_map[] is already there, although only conditionally defined
for CONFIG_SCHED_SMT.  Talking to PPC developers at OLS, I think
cpu_sibling_map[] has (or more properly, will have) uses outside
sched_domains and thus deserves an unconditional definition.  Here's a
patch to change that.

[mcd@arrakis source]$ diffstat
~/linux/patches/ppc64-cpu_sibling_map.patch
 arch/ppc64/kernel/smp.c |    7 +------
 include/asm-ppc64/smp.h |    4 +---
 2 files changed, 2 insertions(+), 9 deletions(-)

-Matt


diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.8-rc2-mm1/arch/ppc64/kernel/smp.c linux-2.6.8-rc2-mm1+ppc64-cpu_sibling_map/arch/ppc64/kernel/smp.c
--- linux-2.6.8-rc2-mm1/arch/ppc64/kernel/smp.c	2004-07-28 10:50:29.000000000 -0700
+++ linux-2.6.8-rc2-mm1+ppc64-cpu_sibling_map/arch/ppc64/kernel/smp.c	2004-08-02 14:27:18.000000000 -0700
@@ -55,15 +55,13 @@
 #include <asm/rtas.h>
 
 int smp_threads_ready;
-#ifdef CONFIG_SCHED_SMT
-cpumask_t cpu_sibling_map[NR_CPUS];
-#endif
 unsigned long cache_decay_ticks;
 
 cpumask_t cpu_possible_map = CPU_MASK_NONE;
 cpumask_t cpu_online_map = CPU_MASK_NONE;
 cpumask_t cpu_available_map = CPU_MASK_NONE;
 cpumask_t cpu_present_at_boot = CPU_MASK_NONE;
+cpumask_t cpu_sibling_map[NR_CPUS] = { [0 ... NR_CPUS-1] = CPU_MASK_NONE };
 
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(cpu_possible_map);
@@ -448,14 +446,11 @@ static inline void look_for_more_cpus(vo
 	for (i = 0; i < maxcpus; i++)
 		cpu_set(i, cpu_possible_map);
 
-#ifdef CONFIG_SCHED_SMT
-	memset(cpu_sibling_map, 0, sizeof(cpu_sibling_map));
 	for_each_cpu(i) {
 		cpu_set(i, cpu_sibling_map[i]);
 		if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
 			cpu_set(i^1, cpu_sibling_map[i]);
 	}
-#endif
 }
 #else /* ... CONFIG_HOTPLUG_CPU */
 static inline int __devinit smp_startup_cpu(unsigned int lcpu)
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.8-rc2-mm1/include/asm-ppc64/smp.h linux-2.6.8-rc2-mm1+ppc64-cpu_sibling_map/include/asm-ppc64/smp.h
--- linux-2.6.8-rc2-mm1/include/asm-ppc64/smp.h	2004-07-28 10:50:50.000000000 -0700
+++ linux-2.6.8-rc2-mm1+ppc64-cpu_sibling_map/include/asm-ppc64/smp.h	2004-08-02 14:24:43.000000000 -0700
@@ -49,6 +49,7 @@ extern cpumask_t cpu_present_at_boot;
 extern cpumask_t cpu_online_map;
 extern cpumask_t cpu_possible_map;
 extern cpumask_t cpu_available_map;
+extern cpumask_t cpu_sibling_map[NR_CPUS];
 
 #define cpu_present_at_boot(cpu) cpu_isset(cpu, cpu_present_at_boot)
 #define cpu_available(cpu)       cpu_isset(cpu, cpu_available_map) 
@@ -73,9 +74,6 @@ void smp_init_pSeries(void);
 extern int __cpu_disable(void);
 extern void __cpu_die(unsigned int cpu);
 extern void cpu_die(void) __attribute__((noreturn));
-#ifdef CONFIG_SCHED_SMT
-extern cpumask_t cpu_sibling_map[NR_CPUS];
-#endif
 #endif /* !(CONFIG_SMP) */
 
 #define get_hard_smp_processor_id(CPU) (paca[(CPU)].hw_cpu_id)


