Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUDDGRO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 01:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUDDGRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 01:17:14 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:53894 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262208AbUDDGRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 01:17:07 -0500
Date: Sat, 3 Apr 2004 22:16:41 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: [Patch 24a/23] mask v2 - UP fix, faster mask_of_bit, MASK_ALL*
 names
Message-Id: <20040403221641.646351a0.pj@sgi.com>
In-Reply-To: <20040401122802.23521599.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces 24/23.  Patch 24/23 was fouled up beyond all recall.

This patch 24a/23 applies after the 23 mask v2 patches 1/23 - 23/23,
based on the 2.6.4 Linux kernel.

It closely follows some excellent suggestions from Matthew.

1) It corrects a build error for UP (1 CPU, no SMP).
   Real cpu_online_map and cpu_possible_map data words are
   needed, so that cpumask_of_cpu() will evalutate correctly
   when in used in contexts requiring a real lvalue, as in
   sys_sched_getaffinity().

2) Since the MASK_ALL* implementation alternatives (for the
   single long and multiple long cases) are split across the
   base mask.h file and the derived cpumask.h/nodemask.h files,
   rename them to MASK_ALL_SINGLE_LONG/MASK_ALL_MULTIPLE_LONG,
   as suggested by Matthew, for code clarity.

3) Optimize the single word flavor of mask_of_bit (resulting
   in better code on small systems for cpumask_of_cpu).

The mask.h header is once again (still, if you don't count 24/23) usable
in its own right.

Diffstat:
 include/linux/cpumask.h  |   11 ++++-------
 include/linux/mask.h     |   12 ++++++++----
 include/linux/nodemask.h |    4 ++--
 kernel/sched.c           |    5 +++++
 4 files changed, 19 insertions(+), 13 deletions(-)

diff -Naur Apr01/include/linux/cpumask.h Apr03/include/linux/cpumask.h
--- Apr01/include/linux/cpumask.h	2004-04-03 19:51:42.000000000 -0800
+++ Apr03/include/linux/cpumask.h	2004-04-03 19:41:04.000000000 -0800
@@ -92,9 +92,9 @@
 #define next_cpu(cpu, mask)	     mask_next((cpu), (mask), NR_CPUS)
 #define cpumask_of_cpu(cpu)	     mask_of_bit((cpu), _unused_cpumask_arg_)
 #if NR_CPUS <= BITS_PER_LONG
-#define CPU_MASK_ALL		     MASK_ALL1(NR_CPUS)
+#define CPU_MASK_ALL		     MASK_ALL_SINGLE_LONG(NR_CPUS)
 #else
-#define CPU_MASK_ALL		     MASK_ALL2(NR_CPUS)
+#define CPU_MASK_ALL		     MASK_ALL_MULTIPLE_LONG(NR_CPUS)
 #endif
 #define CPU_MASK_NONE		     MASK_NONE(NR_CPUS)
 #define cpus_addr(mask)		     mask_addr(mask)
@@ -108,11 +108,11 @@
  * on them manage all (possible) and online cpus.
  */
 
-#ifdef CONFIG_SMP
-
 extern cpumask_t cpu_online_map;
 extern cpumask_t cpu_possible_map;
 
+#ifdef CONFIG_SMP
+
 #define num_online_cpus()	     cpus_weight(cpu_online_map)
 #define num_possible_cpus()	     cpus_weight(cpu_possible_map)
 #define cpu_online(cpu)		     cpu_isset((cpu), cpu_online_map)
@@ -134,9 +134,6 @@
 
 #else /* !CONFIG_SMP */
 
-#define	cpu_online_map		     cpumask_of_cpu(0)
-#define	cpu_possible_map	     cpumask_of_cpu(0)
-
 #define num_online_cpus()	     1
 #define num_possible_cpus()	     1
 #define cpu_online(cpu)		     ({ BUG_ON((cpu) != 0); 1; })
diff -Naur Apr01/include/linux/mask.h Apr03/include/linux/mask.h
--- Apr01/include/linux/mask.h	2004-04-03 19:51:41.000000000 -0800
+++ Apr03/include/linux/mask.h	2004-04-03 20:21:19.000000000 -0800
@@ -334,19 +334,23 @@
 #define mask_of_bit(bit, T)						\
 ({									\
 	typeof(T) m;							\
-	mask_clearall(m, 8*sizeof(m));					\
-	mask_setbit((bit), m);						\
+	if (sizeof(m) == sizeof(unsigned long))				\
+		m._m[0] = 1UL<<(bit);					\
+	else {								\
+		mask_clearall(m, 8*sizeof(m));				\
+		mask_setbit((bit), m);					\
+	}								\
 	m;								\
 })
 
 /* Use if nbits <= BITS_PER_LONG */
-#define MASK_ALL1(nbits)						\
+#define MASK_ALL_SINGLE_LONG(nbits)					\
 { {									\
 	[BITS_TO_LONGS(nbits)-1] = MASK_LAST_WORD(nbits)		\
 } }
 
 /* Use if nbits > BITS_PER_LONG */
-#define MASK_ALL2(nbits)						\
+#define MASK_ALL_MULTIPLE_LONG(nbits)					\
 { {									\
 	[0 ... BITS_TO_LONGS(nbits)-2] = ~0UL,				\
 	[BITS_TO_LONGS(nbits)-1] = MASK_LAST_WORD(nbits)		\
diff -Naur Apr01/include/linux/nodemask.h Apr03/include/linux/nodemask.h
--- Apr01/include/linux/nodemask.h	2004-04-03 19:51:42.000000000 -0800
+++ Apr03/include/linux/nodemask.h	2004-04-03 19:41:04.000000000 -0800
@@ -93,9 +93,9 @@
 #define nodemask_of_node(node)		\
 			mask_of_bit((node), _unused_nodemask_arg_)
 #if MAX_NUMNODES <= BITS_PER_LONG
-#define NODE_MASK_ALL			MASK_ALL1(MAX_NUMNODES)
+#define NODE_MASK_ALL			MASK_ALL_SINGLE_LONG(MAX_NUMNODES)
 #else
-#define NODE_MASK_ALL			MASK_ALL2(MAX_NUMNODES)
+#define NODE_MASK_ALL			MASK_ALL_MULTIPLE_LONG(MAX_NUMNODES)
 #endif
 #define NODE_MASK_NONE			MASK_NONE(MAX_NUMNODES)
 #define nodes_addr(mask)			mask_addr(mask)
diff -Naur Apr01/kernel/sched.c Apr03/kernel/sched.c
--- Apr01/kernel/sched.c	2004-04-03 19:51:42.000000000 -0800
+++ Apr03/kernel/sched.c	2004-04-03 19:41:05.000000000 -0800
@@ -2340,6 +2340,11 @@
 	return retval;
 }
 
+#ifndef CONFIG_SMP
+cpumask_t cpu_online_map = CPU_MASK_ALL;
+cpumask_t cpu_possible_map = CPU_MASK_ALL;
+#endif
+
 /**
  * sys_sched_getaffinity - get the cpu affinity of a process
  * @pid: pid of the process


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
