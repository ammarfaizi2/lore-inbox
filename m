Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262887AbUC2MS4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbUC2MRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:17:45 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:60086 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262850AbUC2MN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:13:57 -0500
Date: Mon, 29 Mar 2004 04:13:03 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: mbligh@aracnet.com, akpm@osdl.org, wli@holomorphy.com, haveblue@us.ibm.com,
       colpatch@us.ibm.com
Subject: [PATCH] mask ADT: remove obsolete cpumask macros - ppc64 [5/22]
Message-Id: <20040329041303.205afc95.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_5_of_22 - Remove/recode obsolete cpumask macros from arch ppc64
        Remove by recoding all uses of the obsolete cpumask const,
        coerce and promote macros.

diffstat Patch_5_of_22:
 open_pic.c |    8 ++++----
 rtasd.c    |    6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1710  -> 1.1711 
#	arch/ppc64/kernel/rtasd.c	1.17    -> 1.18   
#	arch/ppc64/kernel/open_pic.c	1.21    -> 1.22   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/28	pj@sgi.com	1.1711
# Remove arch ppc64 use of obsolete cpumask const, coerce and promote macros.
# --------------------------------------------
#
diff -Nru a/arch/ppc64/kernel/open_pic.c b/arch/ppc64/kernel/open_pic.c
--- a/arch/ppc64/kernel/open_pic.c	Mon Mar 29 01:03:34 2004
+++ b/arch/ppc64/kernel/open_pic.c	Mon Mar 29 01:03:34 2004
@@ -592,7 +592,7 @@
 void openpic_init_processor(u_int cpumask)
 {
 	openpic_write(&OpenPIC->Global.Processor_Initialization,
-		      physmask(cpumask & cpus_coerce(cpu_online_map)));
+		      physmask(cpumask & cpus_raw(cpu_online_map)[0]));
 }
 
 #ifdef CONFIG_SMP
@@ -626,7 +626,7 @@
 	CHECK_THIS_CPU;
 	check_arg_ipi(ipi);
 	openpic_write(&OpenPIC->THIS_CPU.IPI_Dispatch(ipi),
-		      physmask(cpumask & cpus_coerce(cpu_online_map)));
+		      physmask(cpumask & cpus_raw(cpu_online_map)[0]));
 }
 
 void openpic_request_IPIs(void)
@@ -712,7 +712,7 @@
 {
 	check_arg_timer(timer);
 	openpic_write(&OpenPIC->Global.Timer[timer].Destination,
-		      physmask(cpumask & cpus_coerce(cpu_online_map)));
+		      physmask(cpumask & cpus_raw(cpu_online_map)[0]));
 }
 
 
@@ -837,7 +837,7 @@
 	cpumask_t tmp;
 
 	cpus_and(tmp, cpumask, cpu_online_map);
-	openpic_mapirq(irq_nr - open_pic_irq_offset, physmask(cpus_coerce(tmp)));
+	openpic_mapirq(irq_nr - open_pic_irq_offset, physmask(cpus_raw(tmp)[0]));
 }
 
 #ifdef CONFIG_SMP
diff -Nru a/arch/ppc64/kernel/rtasd.c b/arch/ppc64/kernel/rtasd.c
--- a/arch/ppc64/kernel/rtasd.c	Mon Mar 29 01:03:34 2004
+++ b/arch/ppc64/kernel/rtasd.c	Mon Mar 29 01:03:34 2004
@@ -413,7 +413,7 @@
 	}
 
 	lock_cpu_hotplug();
-	cpu = first_cpu_const(mk_cpumask_const(cpu_online_map));
+	cpu = first_cpu(cpu_online_map);
 	for (;;) {
 		set_cpus_allowed(current, cpumask_of_cpu(cpu));
 		do_event_scan(event_scan);
@@ -427,9 +427,9 @@
 		schedule_timeout((HZ*60/rtas_event_scan_rate) / 2);
 		lock_cpu_hotplug();
 
-		cpu = next_cpu_const(cpu, mk_cpumask_const(cpu_online_map));
+		cpu = next_cpu(cpu, cpu_online_map);
 		if (cpu == NR_CPUS)
-			cpu = first_cpu_const(mk_cpumask_const(cpu_online_map));
+			cpu = first_cpu(cpu_online_map);
 	}
 
 error_vfree:


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
