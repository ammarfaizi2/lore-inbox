Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268184AbTB1VfN>; Fri, 28 Feb 2003 16:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268141AbTB1Vej>; Fri, 28 Feb 2003 16:34:39 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:61694 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268190AbTB1Vc7>; Fri, 28 Feb 2003 16:32:59 -0500
Date: Fri, 28 Feb 2003 13:34:03 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, colpatch@us.ibm.com
Subject: [PATCH] 4/7 provide pcibus_to_cpumask from topology
Message-ID: <361360000.1046468043@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch from Matthew Dobson

Just provides a pcibus_to_cpumask function in the topology infrastructure
to access the pre-existing array.


diff -urpN -X /home/fletch/.diff.exclude 012-pfn_to_nid/include/asm-generic/topology.h 013-pcibus_to_cpumask/include/asm-generic/topology.h
--- 012-pfn_to_nid/include/asm-generic/topology.h	Thu Feb 13 11:08:13 2003
+++ 013-pcibus_to_cpumask/include/asm-generic/topology.h	Fri Feb 28 08:05:35 2003
@@ -47,6 +47,9 @@
 #ifndef node_to_memblk
 #define node_to_memblk(node)	(0)
 #endif
+#ifndef pcibus_to_cpumask
+#define pcibus_to_cpumask(bus)	(cpu_online_map)
+#endif
 
 /* Cross-node load balancing interval. */
 #ifndef NODE_BALANCE_RATE
diff -urpN -X /home/fletch/.diff.exclude 012-pfn_to_nid/include/asm-i386/topology.h 013-pcibus_to_cpumask/include/asm-i386/topology.h
--- 012-pfn_to_nid/include/asm-i386/topology.h	Thu Feb 13 11:08:13 2003
+++ 013-pcibus_to_cpumask/include/asm-i386/topology.h	Fri Feb 28 08:05:35 2003
@@ -29,6 +29,8 @@
 
 #ifdef CONFIG_NUMA
 
+#include <asm/mpspec.h>
+
 /* Mappings between logical cpu number and node number */
 extern volatile unsigned long node_2_cpu_mask[];
 extern volatile int cpu_2_node[];
@@ -60,6 +62,12 @@ static inline int node_to_first_cpu(int 
 
 /* Returns the number of the first MemBlk on Node 'node' */
 #define node_to_memblk(node) (node)
+
+/* Returns the number of the node containing PCI bus 'bus' */
+static inline unsigned long pcibus_to_cpumask(int bus)
+{
+	return node_to_cpumask(mp_bus_id_to_node[bus]);
+}
 
 /* Cross-node load balancing interval. */
 #define NODE_BALANCE_RATE 100

