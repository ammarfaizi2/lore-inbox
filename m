Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbUDAVWQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbUDAVUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:20:36 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:14388 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263192AbUDAVNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:13:18 -0500
Date: Thu, 1 Apr 2004 13:11:53 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: [Patch 8/23] mask v2 - Remove ppc64 obsolete cpumask ops
Message-Id: <20040401131153.07ff8268.pj@sgi.com>
In-Reply-To: <20040401122802.23521599.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_8_of_23 - Remove/recode obsolete cpumask macros from arch ppc64
        Remove by recoding all uses of the obsolete cpumask const,
        coerce and promote macros.

Diffstat Patch_8_of_23:
 open_pic.c                     |    8 ++++----
 rtasd.c                        |    6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

===================================================================
diff -Nru a/arch/ppc64/kernel/open_pic.c b/arch/ppc64/kernel/open_pic.c
--- a/arch/ppc64/kernel/open_pic.c	Mon Mar 29 01:03:34 2004
+++ b/arch/ppc64/kernel/open_pic.c	Mon Mar 29 01:03:34 2004
@@ -592,7 +592,7 @@
 void openpic_init_processor(u_int cpumask)
 {
 	openpic_write(&OpenPIC->Global.Processor_Initialization,
-		      physmask(cpumask & cpus_coerce(cpu_online_map)));
+		      physmask(cpumask & cpus_addr(cpu_online_map)[0]));
 }
 
 #ifdef CONFIG_SMP
@@ -626,7 +626,7 @@
 	CHECK_THIS_CPU;
 	check_arg_ipi(ipi);
 	openpic_write(&OpenPIC->THIS_CPU.IPI_Dispatch(ipi),
-		      physmask(cpumask & cpus_coerce(cpu_online_map)));
+		      physmask(cpumask & cpus_addr(cpu_online_map)[0]));
 }
 
 void openpic_request_IPIs(void)
@@ -712,7 +712,7 @@
 {
 	check_arg_timer(timer);
 	openpic_write(&OpenPIC->Global.Timer[timer].Destination,
-		      physmask(cpumask & cpus_coerce(cpu_online_map)));
+		      physmask(cpumask & cpus_addr(cpu_online_map)[0]));
 }
 
 
@@ -837,7 +837,7 @@
 	cpumask_t tmp;
 
 	cpus_and(tmp, cpumask, cpu_online_map);
-	openpic_mapirq(irq_nr - open_pic_irq_offset, physmask(cpus_coerce(tmp)));
+	openpic_mapirq(irq_nr - open_pic_irq_offset, physmask(cpus_addr(tmp)[0]));
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
