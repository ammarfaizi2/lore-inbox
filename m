Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265680AbUFCRsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265680AbUFCRsF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264225AbUFCR2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:28:14 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:17883 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264344AbUFCRKg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:10:36 -0400
Date: Thu, 3 Jun 2004 10:05:59 -0700
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, Ashok Raj <ashok.raj@intel.com>,
       Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Joe Korty <joe.korty@ccur.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Mikael Pettersson <mikpe@csd.uu.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Paul Jackson <pj@sgi.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Simon Derr <Simon.Derr@bull.net>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [PATCH] cpumask 1/10 cpu_present_map real even on non-smp
Message-Id: <20040603100559.32c6db27.pj@sgi.com>
In-Reply-To: <20040603094339.03ddfd42.pj@sgi.com>
References: <20040603094339.03ddfd42.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpumask 1/10 cpu_present_map real even on non-smp

	This patch makes cpu_present_map a real map for all
	configurations, instead of a constant for non-SMP.
	It also moves the definition of cpu_present_map out of
	kernel/cpu.c into kernel/sched.c, because cpu.c isn't
	compiled into non-SMP kernels.
	
	The pattern is that each of the possible, present and
	online cpu maps are actual kernel global cpumask_t
	variables, for all configurations.  They are documented
	in include/linux/cpumask.h.  Some of the UP (NR_CPUS=1)
	code cheats, and hardcodes the assumption that the single
	bit position of these maps is always set, as an optimization.


 include/linux/cpumask.h |   13 +++++--------
 kernel/cpu.c            |    8 --------
 kernel/sched.c          |   10 ++++++++++
 3 files changed, 15 insertions(+), 16 deletions(-)

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.7-rc2-mm2/include/linux/cpumask.h
===================================================================
--- 2.6.7-rc2-mm2.orig/include/linux/cpumask.h	2004-06-03 05:39:37.000000000 -0700
+++ 2.6.7-rc2-mm2/include/linux/cpumask.h	2004-06-03 05:56:00.000000000 -0700
@@ -10,15 +10,12 @@
 
 extern cpumask_t cpu_online_map;
 extern cpumask_t cpu_possible_map;
-extern cpumask_t cpu_present_map;
 
 #define num_online_cpus()		cpus_weight(cpu_online_map)
 #define num_possible_cpus()		cpus_weight(cpu_possible_map)
-#define num_present_cpus()		cpus_weight(cpu_present_map)
 
 #define cpu_online(cpu)			cpu_isset(cpu, cpu_online_map)
 #define cpu_possible(cpu)		cpu_isset(cpu, cpu_possible_map)
-#define cpu_present(cpu)		cpu_isset(cpu, cpu_present_map)
 
 #define for_each_cpu_mask(cpu, mask)					\
 	for (cpu = first_cpu_const(mk_cpumask_const(mask));		\
@@ -27,25 +24,25 @@
 
 #define for_each_cpu(cpu) for_each_cpu_mask(cpu, cpu_possible_map)
 #define for_each_online_cpu(cpu) for_each_cpu_mask(cpu, cpu_online_map)
-#define for_each_present_cpu(cpu) for_each_cpu_mask(cpu, cpu_present_map)
 #else
 #define	cpu_online_map			cpumask_of_cpu(0)
 #define	cpu_possible_map		cpumask_of_cpu(0)
-#define	cpu_present_map			cpumask_of_cpu(0)
 
 #define num_online_cpus()		1
 #define num_possible_cpus()		1
-#define num_present_cpus()		1
 
 #define cpu_online(cpu)			({ BUG_ON((cpu) != 0); 1; })
 #define cpu_possible(cpu)		({ BUG_ON((cpu) != 0); 1; })
-#define cpu_present(cpu)		({ BUG_ON((cpu) != 0); 1; })
 
 #define for_each_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
 #define for_each_online_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
-#define for_each_present_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
 #endif
 
+extern cpumask_t cpu_present_map;
+#define num_present_cpus()		cpus_weight(cpu_present_map)
+#define cpu_present(cpu)		cpu_isset(cpu, cpu_present_map)
+#define for_each_present_cpu(cpu) for_each_cpu_mask(cpu, cpu_present_map)
+
 #define cpumask_scnprintf(buf, buflen, map)				\
 	bitmap_scnprintf(buf, buflen, cpus_addr(map), NR_CPUS)
 
Index: 2.6.7-rc2-mm2/kernel/cpu.c
===================================================================
--- 2.6.7-rc2-mm2.orig/kernel/cpu.c	2004-06-03 05:39:46.000000000 -0700
+++ 2.6.7-rc2-mm2/kernel/cpu.c	2004-06-03 05:56:00.000000000 -0700
@@ -20,14 +20,6 @@
 DECLARE_MUTEX(cpucontrol);
 
 static struct notifier_block *cpu_chain;
-/*
- * Represents all cpu's present in the system
- * In systems capable of hotplug, this map could dynamically grow
- * as new cpu's are detected in the system via any platform specific
- * method, such as ACPI for e.g.
- */
-cpumask_t	cpu_present_map;
-EXPORT_SYMBOL(cpu_present_map);
 
 /* Need to know about CPUs going up/down? */
 int register_cpu_notifier(struct notifier_block *nb)
Index: 2.6.7-rc2-mm2/kernel/sched.c
===================================================================
--- 2.6.7-rc2-mm2.orig/kernel/sched.c	2004-06-03 05:46:32.000000000 -0700
+++ 2.6.7-rc2-mm2/kernel/sched.c	2004-06-03 05:56:00.000000000 -0700
@@ -3109,6 +3109,16 @@
 	return retval;
 }
 
+/*
+ * Represents all cpu's present in the system
+ * In systems capable of hotplug, this map could dynamically grow
+ * as new cpu's are detected in the system via any platform specific
+ * method, such as ACPI for e.g.
+ */
+
+cpumask_t cpu_present_map;
+EXPORT_SYMBOL(cpu_present_map);
+
 /**
  * sys_sched_getaffinity - get the cpu affinity of a process
  * @pid: pid of the process


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
