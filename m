Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTEOBM4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 21:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTEOBM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 21:12:56 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:42881 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263464AbTEOBMr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 21:12:47 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Andrew Theurer <habanero@us.ibm.com>
Reply-To: habanero@us.ibm.com
To: anton@samba.org, colpatch@us.ibm.com,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Dave Hansen <haveblue@us.ibm.com>, Bill Hartner <bhartner@us.ibm.com>,
       Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
Subject: [patch] Re: Bug 619 - sched_best_cpu does not pick best cpu (1/1)
Date: Wed, 14 May 2003 20:29:42 -0500
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <3EB70EEC.9040004@us.ibm.com>
In-Reply-To: <3EB70EEC.9040004@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200305142029.45413.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe this will work for ppc64:

[root@hearse root]#   diffstat patch-nr_cpus_node-ppc64-2.5.69
 arch/ppc64/mm/numa.c         |    6 +++++-
 include/asm-ppc64/mmzone.h   |    1 +
 include/asm-ppc64/topology.h |    5 +++++
 3 files changed, 11 insertions(+), 1 deletion(-)


diff -Naur 2.5.69-bk-5-8-2003-numa/arch/ppc64/mm/numa.c 
2.5.69-bk-5-8-2003-numa-nrcpusnode/arch/ppc64/mm/numa.c
--- 2.5.69-bk-5-8-2003-numa/arch/ppc64/mm/numa.c	2003-05-14 18:11:35.000000000 
-0700
+++ 2.5.69-bk-5-8-2003-numa-nrcpusnode/arch/ppc64/mm/numa.c	2003-05-14 
18:18:06.000000000 -0700
@@ -25,6 +25,7 @@
 int numa_memory_lookup_table[MAX_MEMORY >> MEMORY_INCREMENT_SHIFT] =
 	{ [ 0 ... ((MAX_MEMORY >> MEMORY_INCREMENT_SHIFT) - 1)] = -1};
 unsigned long numa_cpumask_lookup_table[MAX_NUMNODES];
+int nr_cpus_in_node[MAX_NUMNODES] = { [0 ... (MAX_NUMNODES -1)] = 0};
 
 struct pglist_data node_data[MAX_NUMNODES];
 bootmem_data_t plat_node_bdata[MAX_NUMNODES];
@@ -33,7 +34,10 @@
 {
 	dbg("cpu %d maps to domain %d\n", cpu, node);
 	numa_cpu_lookup_table[cpu] = node;
-	numa_cpumask_lookup_table[node] |= 1UL << cpu;
+	if (!(numa_cpumask_lookup_table[node] & 1UL << cpu)) {
+		numa_cpumask_lookup_table[node] |= 1UL << cpu;
+		nr_cpus_in_node[node]++;
+	}
 }
 
 static int __init parse_numa_properties(void)
diff -Naur 2.5.69-bk-5-8-2003-numa/include/asm-ppc64/mmzone.h 
2.5.69-bk-5-8-2003-numa-nrcpusnode/include/asm-ppc64/mmzone.h
--- 2.5.69-bk-5-8-2003-numa/include/asm-ppc64/mmzone.h	2003-04-24 
14:17:14.000000000 -0700
+++ 2.5.69-bk-5-8-2003-numa-nrcpusnode/include/asm-ppc64/mmzone.h	2003-05-14 
18:07:35.000000000 -0700
@@ -21,6 +21,7 @@
 extern int numa_cpu_lookup_table[];
 extern int numa_memory_lookup_table[];
 extern unsigned long numa_cpumask_lookup_table[];
+extern int nr_cpus_in_node[];
 
 #define MAX_MEMORY (1UL << 41)
 /* 256MB regions */
diff -Naur 2.5.69-bk-5-8-2003-numa/include/asm-ppc64/topology.h 
2.5.69-bk-5-8-2003-numa-nrcpusnode/include/asm-ppc64/topology.h
--- 2.5.69-bk-5-8-2003-numa/include/asm-ppc64/topology.h	2003-05-14 
11:03:10.000000000 -0700
+++ 2.5.69-bk-5-8-2003-numa-nrcpusnode/include/asm-ppc64/topology.h	2003-05-14 
18:08:38.000000000 -0700
@@ -6,6 +6,11 @@
 
 #ifdef CONFIG_NUMA
 
+static inline int nr_cpus_node(int node)
+{
+	return nr_cpus_in_node[node];
+}
+
 static inline int cpu_to_node(int cpu)
 {
 	int node;

