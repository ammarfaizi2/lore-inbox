Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbTHaABv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 20:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTHaABv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 20:01:51 -0400
Received: from modemcable009.53-202-24.mtl.mc.videotron.ca ([24.202.53.9]:23170
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262433AbTHaABs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 20:01:48 -0400
Date: Sat, 30 Aug 2003 20:01:36 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Andi Kleen <ak@suse.de>
Subject: [PATCH][2.6-mm] x86/64 topology cpumask fixes
Message-ID: <Pine.LNX.4.53.0308301957500.16584@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  CC      arch/x86_64/kernel/asm-offsets.s
In file included from include/linux/topology.h:35,
                 from include/linux/mmzone.h:301,
                 from include/linux/gfp.h:4,
                 from include/linux/slab.h:15,
                 from include/linux/percpu.h:4,
                 from include/linux/sched.h:31,
                 from arch/x86_64/kernel/asm-offsets.c:7:
include/asm/topology.h:13: conflicting types for `cpu_online_map'
include/asm/smp.h:39: previous declaration of `cpu_online_map'
include/asm/topology.h: In function `pcibus_to_cpumask':
include/asm/topology.h:24: invalid operands to binary &
In file included from include/linux/mmzone.h:301,
                 from include/linux/gfp.h:4,
                 from include/linux/slab.h:15,
                 from include/linux/percpu.h:4,
                 from include/linux/sched.h:31,
                 from arch/x86_64/kernel/asm-offsets.c:7:
include/linux/topology.h: In function `__next_node_with_cpus':
include/linux/topology.h:50: incompatible types in assignment
make[1]: *** [arch/x86_64/kernel/asm-offsets.s] Error 1
make: *** [arch/x86_64/kernel/asm-offsets.s] Error 2

Index: linux-2.6.0-test4-mm4-x86_64/include/asm-x86_64/topology.h
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test4-mm4/include/asm-x86_64/topology.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 topology.h
--- linux-2.6.0-test4-mm4-x86_64/include/asm-x86_64/topology.h	30 Aug 2003 23:32:01 -0000	1.1.1.1
+++ linux-2.6.0-test4-mm4-x86_64/include/asm-x86_64/topology.h	30 Aug 2003 23:56:28 -0000
@@ -10,18 +10,21 @@
 /* Map the K8 CPU local memory controllers to a simple 1:1 CPU:NODE topology */
 
 extern int fake_node;
-extern unsigned long cpu_online_map;
+extern cpumask_t cpu_online_map;
 
 #define cpu_to_node(cpu)		(fake_node ? 0 : (cpu))
-#define memblk_to_node(memblk) 	(fake_node ? 0 : (memblk))
+#define memblk_to_node(memblk)		(fake_node ? 0 : (memblk))
 #define parent_node(node)		(node)
-#define node_to_first_cpu(node) 	(fake_node ? 0 : (node))
-#define node_to_cpu_mask(node)	(fake_node ? cpu_online_map : (1UL << (node)))
+#define node_to_first_cpu(node)		(fake_node ? 0 : (node))
+#define node_to_cpu_mask(node)		(fake_node ? cpu_online_map : cpumask_of_cpu(node))
 #define node_to_memblk(node)		(node)
 
-static inline unsigned long pcibus_to_cpumask(int bus)
+static inline cpumask_t pcibus_to_cpumask(int bus)
 {
-	return mp_bus_to_cpumask[bus] & cpu_online_map;
+	cpumask_t mask;
+
+	cpus_and(mask, mp_bus_to_cpumask[bus], cpu_online_map);
+	return mask;
 }
 
 #define NODE_BALANCE_RATE 30	/* CHECKME */ 
