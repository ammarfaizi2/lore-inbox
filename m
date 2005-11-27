Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750968AbVK0KAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbVK0KAL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 05:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbVK0KAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 05:00:11 -0500
Received: from fsmlabs.com ([168.103.115.128]:13468 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1750968AbVK0KAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 05:00:09 -0500
X-ASG-Debug-ID: 1133085602-4846-4-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Sun, 27 Nov 2005 02:05:45 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Raj, Ashok" <ashok.raj@intel.com>,
       Stephen Hemminger <shemminger@osdl.org>
X-ASG-Orig-Subj: [PATCH] i386/x86_64: Don't IPI to offline cpus on shutdown
Subject: [PATCH] i386/x86_64: Don't IPI to offline cpus on shutdown
Message-ID: <Pine.LNX.4.61.0511270115020.20046@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.5613
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=5203

There is a small race during SMP shutdown between the processor issuing 
the shutdown and the other processors clearing themselves off the 
cpu_online_map as they do this without using the normal cpu offline 
synchronisation. To avoid this we should wait for all the other processors 
to clear their corresponding bits and then proceed. This way we can safely 
make the cpu_online test in smp_send_reschedule, it's safe during normal 
runtime as smp_send_reschedule is called with a lock held / preemption 
disabled.

Signed-off-by: Zwane Mwaikambo <zwane@arm.linux.org.uk>

 arch/i386/kernel/smp.c   |   12 +++++++++---
 arch/x86_64/kernel/smp.c |   12 +++++++++++-
 2 files changed, 20 insertions(+), 4 deletions(-)

diff -r 2c0d5afbfb94 arch/i386/kernel/smp.c
--- a/arch/i386/kernel/smp.c	Fri Nov 25 17:42:19 2005
+++ b/arch/i386/kernel/smp.c	Sun Nov 27 02:00:59 2005
@@ -164,7 +164,6 @@
 	unsigned long flags;
 
 	local_irq_save(flags);
-	WARN_ON(mask & ~cpus_addr(cpu_online_map)[0]);
 	/*
 	 * Wait for idle.
 	 */
@@ -476,8 +475,8 @@
  */
 void smp_send_reschedule(int cpu)
 {
-	WARN_ON(cpu_is_offline(cpu));
-	send_IPI_mask(cpumask_of_cpu(cpu), RESCHEDULE_VECTOR);
+	if (likely(cpu_online(cpu)))
+		send_IPI_mask(cpumask_of_cpu(cpu), RESCHEDULE_VECTOR);
 }
 
 /*
@@ -585,7 +584,14 @@
 
 void smp_send_stop(void)
 {
+	cpumask_t mask;
+
+	mask = cpumask_of_cpu(smp_processor_id());
 	smp_call_function(stop_this_cpu, NULL, 1, 0);
+
+	/* Wait for other cpus to halt */
+	while (!cpus_equal(mask, cpu_online_map))
+		cpu_relax();
 
 	local_irq_disable();
 	disable_local_APIC();
diff -r 2c0d5afbfb94 arch/x86_64/kernel/smp.c
--- a/arch/x86_64/kernel/smp.c	Fri Nov 25 17:42:19 2005
+++ b/arch/x86_64/kernel/smp.c	Sun Nov 27 02:00:59 2005
@@ -293,7 +293,8 @@
 
 void smp_send_reschedule(int cpu)
 {
-	send_IPI_mask(cpumask_of_cpu(cpu), RESCHEDULE_VECTOR);
+	if (likely(cpu_online(cpu)))
+		send_IPI_mask(cpumask_of_cpu(cpu), RESCHEDULE_VECTOR);
 }
 
 /*
@@ -470,6 +471,8 @@
 void smp_send_stop(void)
 {
 	int nolock = 0;
+	cpumask_t mask;
+
 	if (reboot_force)
 		return;
 	/* Don't deadlock on the call lock in panic */
@@ -477,7 +480,14 @@
 		/* ignore locking because we have paniced anyways */
 		nolock = 1;
 	}
+
+	mask = cpumask_of_cpu(smp_processor_id());
 	__smp_call_function(smp_really_stop_cpu, NULL, 0, 0);
+
+	/* wait for the other cpus to halt */
+	while (!cpus_equal(mask, cpu_online_map))
+		cpu_relax();
+
 	if (!nolock)
 		spin_unlock(&call_lock);
 
