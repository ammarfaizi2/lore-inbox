Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUEFTNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUEFTNS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 15:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbUEFSwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 14:52:45 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:8269 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261928AbUEFStO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 14:49:14 -0400
Date: Thu, 6 May 2004 11:48:32 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matthew Dobson <colpatch@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Joe Korty <joe.korty@ccur.com>,
       Jesse Barnes <jbarnes@sgi.com>
Subject: [PATCH mask 6/15] nonsmp-cpu-present-map
Message-Id: <20040506114832.33657806.pj@sgi.com>
In-Reply-To: <20040506111814.62d1f537.pj@sgi.com>
References: <20040506111814.62d1f537.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build breakage if CONFIG_SMP disabled, in Ashok's cpuhotplog
patches in init/main.c routine fixup_cpu_present_map().

Make cpu_present_map a real map for all configurations,
instead of a constant for non-SMP.  Also move the definition
of cpu_present_map out of kernel/cpu.c into kernel/sched.c,
because cpu.c isn't compiled into non-SMP kernels.

============= include/linux/cpumask.h =============

--- 2.6.6-rc3-mm2-old/include/linux/cpumask.h	2004-05-06 04:22:43.000000000 -0700
+++ 2.6.6-rc3-mm2/include/linux/cpumask.h	2004-05-06 03:30:32.000000000 -0700
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
@@ -27,25 +24,25 @@ extern cpumask_t cpu_present_map;
 
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
 

============= kernel/cpu.c =============

--- 2.6.6-rc3-mm2-old/kernel/cpu.c	2004-05-06 04:22:43.000000000 -0700
+++ 2.6.6-rc3-mm2/kernel/cpu.c	2004-05-06 01:07:27.000000000 -0700
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

============= kernel/sched.c =============

--- 2.6.6-rc3-mm2-old/kernel/sched.c	2004-05-06 04:22:43.000000000 -0700
+++ 2.6.6-rc3-mm2/kernel/sched.c	2004-05-06 03:30:35.000000000 -0700
@@ -3052,6 +3052,16 @@ out_unlock:
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
  * sys_sched_setaffinity - set the cpu affinity of a process
  * @pid: pid of the process


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
