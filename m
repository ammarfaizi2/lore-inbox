Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVCNDX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVCNDX2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 22:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVCNDX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 22:23:27 -0500
Received: from ozlabs.org ([203.10.76.45]:21122 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262060AbVCNDXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 22:23:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16949.955.2292.852845@cargo.ozlabs.ibm.com>
Date: Mon, 14 Mar 2005 14:23:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: ntl@pobox.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 rtasd shouldn't hold cpucontrol while sleeping
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Nathan Lynch <ntl@pobox.com>.

The rtasd thread should not hold the cpucontrol semaphore while
sleeping between event scans in its first pass; it needlessly delays
boot by one second per cpu when CONFIG_HOTPLUG_CPU=y.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

--- linux-2.6.11.orig/arch/ppc64/kernel/rtasd.c	2005-02-20 02:08:49.000000000 +0000
+++ linux-2.6.11/arch/ppc64/kernel/rtasd.c	2005-02-20 18:13:54.000000000 +0000
@@ -400,10 +400,33 @@
 	} while(error == 0);
 }
 
+static void do_event_scan_all_cpus(long delay)
+{
+	int cpu;
+
+	lock_cpu_hotplug();
+	cpu = first_cpu(cpu_online_map);
+	for (;;) {
+		set_cpus_allowed(current, cpumask_of_cpu(cpu));
+		do_event_scan(rtas_token("event-scan"));
+		set_cpus_allowed(current, CPU_MASK_ALL);
+
+		/* Drop hotplug lock, and sleep for the specified delay */
+		unlock_cpu_hotplug();
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(delay);
+		lock_cpu_hotplug();
+
+		cpu = next_cpu(cpu, cpu_online_map);
+		if (cpu == NR_CPUS)
+			break;
+	}
+	unlock_cpu_hotplug();
+}
+
 static int rtasd(void *unused)
 {
 	unsigned int err_type;
-	int cpu = 0;
 	int event_scan = rtas_token("event-scan");
 	int rc;
 
@@ -437,17 +460,7 @@
 	}
 
 	/* First pass. */
-	lock_cpu_hotplug();
-	for_each_online_cpu(cpu) {
-		DEBUG("scheduling on %d\n", cpu);
-		set_cpus_allowed(current, cpumask_of_cpu(cpu));
-		DEBUG("watchdog scheduled on cpu %d\n", smp_processor_id());
-
-		do_event_scan(event_scan);
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ);
-	}
-	unlock_cpu_hotplug();
+	do_event_scan_all_cpus(HZ);
 
 	if (surveillance_timeout != -1) {
 		DEBUG("enabling surveillance\n");
@@ -455,25 +468,11 @@
 		DEBUG("surveillance enabled\n");
 	}
 
-	lock_cpu_hotplug();
-	cpu = first_cpu(cpu_online_map);
-	for (;;) {
-		set_cpus_allowed(current, cpumask_of_cpu(cpu));
-		do_event_scan(event_scan);
-		set_cpus_allowed(current, CPU_MASK_ALL);
-
-		/* Drop hotplug lock, and sleep for a bit (at least
-		 * one second since some machines have problems if we
-		 * call event-scan too quickly). */
-		unlock_cpu_hotplug();
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout((HZ*60/rtas_event_scan_rate) / 2);
-		lock_cpu_hotplug();
-
-		cpu = next_cpu(cpu, cpu_online_map);
-		if (cpu == NR_CPUS)
-			cpu = first_cpu(cpu_online_map);
-	}
+	/* Delay should be at least one second since some
+	 * machines have problems if we call event-scan too
+	 * quickly. */
+	for (;;)
+		do_event_scan_all_cpus((HZ*60/rtas_event_scan_rate) / 2);
 
 error:
 	/* Should delete proc entries */
