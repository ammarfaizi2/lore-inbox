Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267251AbUHVOnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267251AbUHVOnS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 10:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267291AbUHVOnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 10:43:17 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:51704 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267251AbUHVOnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 10:43:12 -0400
Date: Sun, 22 Aug 2004 10:47:25 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Nathan Lynch <nathanl@austin.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: [PATCH][2.6] Hotplug cpu: Fix APIC queued timer vector race
In-Reply-To: <1093145533.4888.106.camel@bach>
Message-ID: <Pine.LNX.4.58.0408221044180.27390@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0408210923570.27390@montezuma.fsmlabs.com>
 <1093145533.4888.106.camel@bach>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004, Rusty Russell wrote:

> On Sun, 2004-08-22 at 00:10, Zwane Mwaikambo wrote:
> > Some timer interrupt vectors were queued on the Local APIC and were being
> > serviced when we enabled interrupts again in fixup_irqs(), so we need to
> > mask the APIC timer, enable interrupts so that any queued interrupts get
> > processed whilst the processor is still on the online map and then clear
> > ourselves from the online map. 1ms is a nice safe number even under heavy
> > interrupt load with higher priority vectors queued. Andrew this is
> > the patch i promised, Rusty, i'm not sure if you find
> > __attribute__((weak)) offensive...
>
> It's horrible.  Please move the unsetting of the cpu_online bit into the
> arch-specific __cpu_disable() code for each arch, which is consistent
> and also simplifies things.

Alright this should do it then;

Thanks

Signed-off-by: Zwane Mwaikambo <zwane@linuxpower.ca>

 arch/i386/kernel/smpboot.c |   10 ++++++++--
 arch/ia64/kernel/smpboot.c |    1 +
 arch/ppc64/kernel/smp.c    |    4 +++-
 arch/s390/kernel/smp.c     |    4 +++-
 kernel/cpu.c               |    3 ---
 5 files changed, 15 insertions(+), 7 deletions(-)

Index: linux-2.6.8.1-mm2/kernel/cpu.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm2/kernel/cpu.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 cpu.c
--- linux-2.6.8.1-mm2/kernel/cpu.c	19 Aug 2004 20:52:08 -0000	1.1.1.1
+++ linux-2.6.8.1-mm2/kernel/cpu.c	22 Aug 2004 14:28:17 -0000
@@ -89,9 +89,6 @@ static int take_cpu_down(void *unused)
 {
 	int err;

-	/* Take offline: makes arch_cpu_down somewhat easier. */
-	cpu_clear(smp_processor_id(), cpu_online_map);
-
 	/* Ensure this CPU doesn't handle any more interrupts. */
 	err = __cpu_disable();
 	if (err < 0)
Index: linux-2.6.8.1-mm2/arch/i386/kernel/smpboot.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm2/arch/i386/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smpboot.c
--- linux-2.6.8.1-mm2/arch/i386/kernel/smpboot.c	19 Aug 2004 20:51:36 -0000	1.1.1.1
+++ linux-2.6.8.1-mm2/arch/i386/kernel/smpboot.c	22 Aug 2004 14:30:04 -0000
@@ -1172,10 +1172,16 @@ int __cpu_disable(void)
 	if (smp_processor_id() == 0)
 		return -EBUSY;

-	fixup_irqs();
-
 	/* We enable the timer again on the exit path of the death loop */
 	disable_APIC_timer();
+	/* Allow any queued timer interrupts to get serviced */
+	local_irq_enable();
+	mdelay(1);
+	local_irq_disable();
+
+	/* It's now safe to remove this processor from the online map */
+	cpu_clear(smp_processor_id(), cpu_online_map);
+	fixup_irqs();
 	return 0;
 }

Index: linux-2.6.8.1-mm2/arch/ia64/kernel/smpboot.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm2/arch/ia64/kernel/smpboot.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smpboot.c
--- linux-2.6.8.1-mm2/arch/ia64/kernel/smpboot.c	19 Aug 2004 20:51:37 -0000	1.1.1.1
+++ linux-2.6.8.1-mm2/arch/ia64/kernel/smpboot.c	22 Aug 2004 14:32:22 -0000
@@ -591,6 +591,7 @@ int __cpu_disable(void)
 	if (cpu == 0)
 		return -EBUSY;

+	cpu_clear(cpu, cpu_online_map);
 	fixup_irqs();
 	local_flush_tlb_all();
 	printk ("Disabled cpu %u\n", smp_processor_id());
Index: linux-2.6.8.1-mm2/arch/ppc64/kernel/smp.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm2/arch/ppc64/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smp.c
--- linux-2.6.8.1-mm2/arch/ppc64/kernel/smp.c	19 Aug 2004 20:51:50 -0000	1.1.1.1
+++ linux-2.6.8.1-mm2/arch/ppc64/kernel/smp.c	22 Aug 2004 14:39:31 -0000
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
Index: linux-2.6.8.1-mm2/arch/s390/kernel/smp.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.8.1-mm2/arch/s390/kernel/smp.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 smp.c
--- linux-2.6.8.1-mm2/arch/s390/kernel/smp.c	19 Aug 2004 20:51:50 -0000	1.1.1.1
+++ linux-2.6.8.1-mm2/arch/s390/kernel/smp.c	22 Aug 2004 14:39:13 -0000
@@ -682,9 +682,11 @@ __cpu_disable(void)
 {
 	unsigned long flags;
 	ec_creg_mask_parms cr_parms;
+	int cpu = smp_processor_id();

+	cpu_clear(cpu, cpu_online_map);
 	spin_lock_irqsave(&smp_reserve_lock, flags);
-	if (smp_cpu_reserved[smp_processor_id()] != 0) {
+	if (smp_cpu_reserved[cpu] != 0) {
 		spin_unlock_irqrestore(&smp_reserve_lock, flags);
 		return -EBUSY;
 	}
