Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbUAYAMf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 19:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbUAYAMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 19:12:35 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:4224
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261733AbUAYAM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 19:12:29 -0500
Date: Sat, 24 Jan 2004 19:10:47 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: [PATCH][2.6-mm] Fix CONFIG_SMT oops on UP
In-Reply-To: <20040124153910.2421e35a.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0401241907120.643@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0401241303070.26103@montezuma.fsmlabs.com>
 <20040124153910.2421e35a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Jan 2004, Andrew Morton wrote:

> Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
> >
> > +	cpu_sibling_map[0] = CPU_MASK_NONE;
>
> alas, this will not compile with NR_CPUS > 4*BITS_PER_LONG because this:
>
> 	#define CPU_MASK_NONE   { {[0 ... CPU_ARRAY_SIZE-1] =  0UL} }
>
> is not a suitable rhs - it can only be used for initalisers.  Fixing this
> would be appreciated.
>
> Meanwhile, I'll use cpus_clear() in there.

There was actually other breakage too, so how about;

Index: linux-2.6.2-rc1-mm2/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.2-rc1-mm2/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smpboot.c
--- linux-2.6.2-rc1-mm2/arch/i386/kernel/smpboot.c	23 Jan 2004 22:22:46 -0000	1.1.1.1
+++ linux-2.6.2-rc1-mm2/arch/i386/kernel/smpboot.c	24 Jan 2004 18:46:41 -0000
@@ -951,6 +951,8 @@ static void __init smp_boot_cpus(unsigne

 	current_thread_info()->cpu = 0;
 	smp_tune_scheduling();
+	cpus_clear(cpu_sibling_map[0]);
+	cpu_set(0, cpu_sibling_map[0]);

 	/*
 	 * If we couldn't find an SMP configuration at boot time,
@@ -1083,7 +1085,7 @@ static void __init smp_boot_cpus(unsigne
 	 * efficiently.
 	 */
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
-		cpu_sibling_map[cpu] = CPU_MASK_NONE;
+		cpus_clear(cpu_sibling_map[cpu]);

 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		int siblings = 0;
@@ -1273,7 +1275,7 @@ __init void arch_init_sched_domains(void
 		for_each_cpu_mask(j, cpu_domain->span) {
 			struct sched_group *cpu = &sched_group_cpus[j];

-			cpu->cpumask = CPU_MASK_NONE;
+			cpus_clear(cpu->cpumask);
 			cpu_set(j, cpu->cpumask);

 			if (!first_cpu)
