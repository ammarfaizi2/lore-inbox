Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267545AbUHWIhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267545AbUHWIhl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 04:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267546AbUHWIhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 04:37:41 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:6348 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267545AbUHWIhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 04:37:32 -0400
Date: Mon, 23 Aug 2004 04:41:49 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Nathan Lynch <nathanl@austin.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>
Subject: [PATCH] Hotplug cpu: Fix APIC queued timer vector race #2
In-Reply-To: <1093223788.4888.213.camel@bach>
Message-ID: <Pine.LNX.4.58.0408230435240.27390@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0408210923570.27390@montezuma.fsmlabs.com> 
 <1093145533.4888.106.camel@bach>  <Pine.LNX.4.58.0408221044180.27390@montezuma.fsmlabs.com>
 <1093223788.4888.213.camel@bach>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004, Rusty Russell wrote:

> On Mon, 2004-08-23 at 00:47, Zwane Mwaikambo wrote:
> > On Sun, 22 Aug 2004, Rusty Russell wrote:
> >
> > > On Sun, 2004-08-22 at 00:10, Zwane Mwaikambo wrote:
> > > > Some timer interrupt vectors were queued on the Local APIC and were being
> > > > serviced when we enabled interrupts again in fixup_irqs(), so we need to
> > > > mask the APIC timer, enable interrupts so that any queued interrupts get
> > > > processed whilst the processor is still on the online map and then clear
> > > > ourselves from the online map. 1ms is a nice safe number even under heavy
> > > > interrupt load with higher priority vectors queued. Andrew this is
> > > > the patch i promised, Rusty, i'm not sure if you find
> > > > __attribute__((weak)) offensive...
> > >
> > > It's horrible.  Please move the unsetting of the cpu_online bit into the
> > > arch-specific __cpu_disable() code for each arch, which is consistent
> > > and also simplifies things.

Ok this should be the last one, against 2.6.8.1-mm4.

 arch/i386/kernel/smpboot.c |   21 +++++++++------------
 arch/ia64/kernel/smpboot.c |    3 ++-
 arch/ppc64/kernel/smp.c    |    4 +++-
 arch/s390/kernel/smp.c     |    4 +++-
 kernel/cpu.c               |   21 +++++----------------
 5 files changed, 22 insertions(+), 31 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@linuxpower.ca>

Index: linux-2.6.8.1-mm4/kernel/cpu.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm4/kernel/cpu.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 cpu.c
--- linux-2.6.8.1-mm4/kernel/cpu.c	23 Aug 2004 08:24:54 -0000	1.1.1.1
+++ linux-2.6.8.1-mm4/kernel/cpu.c	23 Aug 2004 08:32:01 -0000
@@ -84,31 +84,20 @@ static int cpu_run_sbin_hotplug(unsigned
 	return call_usermodehelper(argv[0], argv, envp, 0);
 }

-void __attribute__((weak)) __cpu_prep_disable(void)
-{
-}
-
 /* Take this CPU down. */
 static int take_cpu_down(void *unused)
 {
 	int err;

-	/* Prepatory work before clearing the cpu off the online map */
-	__cpu_prep_disable();
-
-	/* Take offline: makes arch_cpu_down somewhat easier. */
-	cpu_clear(smp_processor_id(), cpu_online_map);
-
 	/* Ensure this CPU doesn't handle any more interrupts. */
 	err = __cpu_disable();
 	if (err < 0)
-		cpu_set(smp_processor_id(), cpu_online_map);
-	else
-		/* Force idle task to run as soon as we yield: it should
-		   immediately notice cpu is offline and die quickly. */
-		sched_idle_next();
+		return err;

-	return err;
+	/* Force idle task to run as soon as we yield: it should
+	   immediately notice cpu is offline and die quickly. */
+	sched_idle_next();
+	return 0;
 }

 int cpu_down(unsigned int cpu)
Index: linux-2.6.8.1-mm4/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm4/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smpboot.c
--- linux-2.6.8.1-mm4/arch/i386/kernel/smpboot.c	23 Aug 2004 08:23:22 -0000	1.1.1.1
+++ linux-2.6.8.1-mm4/arch/i386/kernel/smpboot.c	23 Aug 2004 08:32:01 -0000
@@ -1159,18 +1159,6 @@ static int __devinit cpu_enable(unsigned
 	return 0;
 }

-void __cpu_prep_disable(void)
-{
-	/* We enable the timer again on the exit path of the death loop */
-	if (smp_processor_id() != 0) {
-		disable_APIC_timer();
-		/* Allow any queued timer interrupts to get serviced */
-		local_irq_enable();
-		mdelay(1);
-		local_irq_disable();
-	}
-}
-
 int __cpu_disable(void)
 {
 	/*
@@ -1184,6 +1172,15 @@ int __cpu_disable(void)
 	if (smp_processor_id() == 0)
 		return -EBUSY;

+	/* We enable the timer again on the exit path of the death loop */
+	disable_APIC_timer();
+	/* Allow any queued timer interrupts to get serviced */
+	local_irq_enable();
+	mdelay(1);
+	local_irq_disable();
+
+	/* It's now safe to remove this processor from the online map */
+	cpu_clear(smp_processor_id(), cpu_online_map);
 	fixup_irqs();
 	return 0;
 }
Index: linux-2.6.8.1-mm4/arch/ia64/kernel/smpboot.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm4/arch/ia64/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smpboot.c
--- linux-2.6.8.1-mm4/arch/ia64/kernel/smpboot.c	23 Aug 2004 08:23:31 -0000	1.1.1.1
+++ linux-2.6.8.1-mm4/arch/ia64/kernel/smpboot.c	23 Aug 2004 08:32:01 -0000
@@ -591,9 +591,10 @@ int __cpu_disable(void)
 	if (cpu == 0)
 		return -EBUSY;

+	cpu_clear(cpu, cpu_online_map);
 	fixup_irqs();
 	local_flush_tlb_all();
-	printk ("Disabled cpu %u\n", smp_processor_id());
+	printk("Disabled cpu %u\n", cpu);
 	return 0;
 }

Index: linux-2.6.8.1-mm4/arch/ppc64/kernel/smp.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm4/arch/ppc64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smp.c
--- linux-2.6.8.1-mm4/arch/ppc64/kernel/smp.c	23 Aug 2004 08:23:34 -0000	1.1.1.1
+++ linux-2.6.8.1-mm4/arch/ppc64/kernel/smp.c	23 Aug 2004 08:32:01 -0000
@@ -254,11 +254,13 @@ int __cpu_disable(void)
 {
 	/* FIXME: go put this in a header somewhere */
 	extern void xics_migrate_irqs_away(void);
+	int cpu = smp_processor_id();

+	cpu_clear(cpu, cpu_online_map);
 	systemcfg->processorCount--;

 	/*fix boot_cpuid here*/
-	if (smp_processor_id() == boot_cpuid)
+	if (cpu == boot_cpuid)
 		boot_cpuid = any_online_cpu(cpu_online_map);

 	/* FIXME: abstract this to not be platform specific later on */
Index: linux-2.6.8.1-mm4/arch/s390/kernel/smp.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm4/arch/s390/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smp.c
--- linux-2.6.8.1-mm4/arch/s390/kernel/smp.c	23 Aug 2004 08:23:39 -0000	1.1.1.1
+++ linux-2.6.8.1-mm4/arch/s390/kernel/smp.c	23 Aug 2004 08:32:01 -0000
@@ -682,13 +682,15 @@ __cpu_disable(void)
 {
 	unsigned long flags;
 	ec_creg_mask_parms cr_parms;
+	int cpu = smp_processor_id();

 	spin_lock_irqsave(&smp_reserve_lock, flags);
-	if (smp_cpu_reserved[smp_processor_id()] != 0) {
+	if (smp_cpu_reserved[cpu] != 0) {
 		spin_unlock_irqrestore(&smp_reserve_lock, flags);
 		return -EBUSY;
 	}

+	cpu_clear(cpu, cpu_online_map);
 	/* disable all external interrupts */

 	cr_parms.start_ctl = 0;
