Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263722AbUDVHa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbUDVHa3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263735AbUDVH3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:29:51 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:9543 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263722AbUDVHXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:23:14 -0400
Date: Thu, 22 Apr 2004 00:07:36 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: [Patch 10 of 17] cpumask v4 - Recode obsolete cpumask macros - arch
 ppc64
Message-Id: <20040422000736.6be545a2.pj@sgi.com>
In-Reply-To: <20040421232247.22ffe1f2.pj@sgi.com>
References: <20040421232247.22ffe1f2.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mask10-cpumask-ppc64-fixup - Remove/recode obsolete cpumask macros from arch ppc64
        Remove by recoding all uses of the obsolete cpumask const,
        coerce and promote macros.

Diffstat Patch_8_of_23:
 open_pic.c                     |    8 ++++----
 rtasd.c                        |    6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

Index: 2.6.5.mask/arch/ppc64/kernel/open_pic.c
===================================================================
--- 2.6.5.mask.orig/arch/ppc64/kernel/open_pic.c	2004-04-03 23:37:42.000000000 -0800
+++ 2.6.5.mask/arch/ppc64/kernel/open_pic.c	2004-04-03 23:51:59.000000000 -0800
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
Index: 2.6.5.mask/arch/ppc64/kernel/rtasd.c
===================================================================
--- 2.6.5.mask.orig/arch/ppc64/kernel/rtasd.c	2004-04-03 23:37:42.000000000 -0800
+++ 2.6.5.mask/arch/ppc64/kernel/rtasd.c	2004-04-03 23:51:59.000000000 -0800
@@ -411,7 +411,7 @@
 	}
 
 	lock_cpu_hotplug();
-	cpu = first_cpu_const(mk_cpumask_const(cpu_online_map));
+	cpu = first_cpu(cpu_online_map);
 	for (;;) {
 		set_cpus_allowed(current, cpumask_of_cpu(cpu));
 		do_event_scan(event_scan);
@@ -425,9 +425,9 @@
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
