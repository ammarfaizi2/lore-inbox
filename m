Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319828AbSIMX1z>; Fri, 13 Sep 2002 19:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319829AbSIMX1z>; Fri, 13 Sep 2002 19:27:55 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:33016 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319828AbSIMX1s>;
	Fri, 13 Sep 2002 19:27:48 -0400
Message-ID: <3D8274D5.6000209@us.ibm.com>
Date: Fri, 13 Sep 2002 16:29:25 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] per-zone^Wnode kswapd process
References: <20020913045938.GG2179@holomorphy.com> <617478427.1031868636@[10.10.2.3]> <3D8232DE.9090000@us.ibm.com> <3D823702.8E29AB4F@digeo.com> <3D8251D6.3060704@us.ibm.com> <3D82566B.EB2939D5@digeo.com> <3D826C25.5050609@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------040304010202040609020303"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040304010202040609020303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

As promised, here is the latest and greatest (heh) topology API patch. 
Should apply cleanly on top of mm3.  As always, comment, criticize, and 
flame away!

Cheers

-Matt

--------------040304010202040609020303
Content-Type: text/plain;
 name="simple_topo-v0.5-in_kernel-2.5.34-mm3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="simple_topo-v0.5-in_kernel-2.5.34-mm3.patch"

diff -Nur linux-2.5.34-mm3/include/asm-alpha/mmzone.h linux-2.5.34-mm3+topo/include/asm-alpha/mmzone.h
--- linux-2.5.34-mm3/include/asm-alpha/mmzone.h	Fri Sep 13 14:58:03 2002
+++ linux-2.5.34-mm3+topo/include/asm-alpha/mmzone.h	Fri Sep 13 14:59:21 2002
@@ -107,15 +107,6 @@
 #ifdef CONFIG_NUMA_SCHED
 #define NODE_SCHEDULE_DATA(nid)	(&((PLAT_NODE_DATA(nid))->schedule_data))
 #endif
-
-#ifdef CONFIG_ALPHA_WILDFIRE
-/* With wildfire assume 4 CPUs per node */
-#define cputonode(cpu)	((cpu) >> 2)
-#else
-#define cputonode(cpu)	0
-#endif /* CONFIG_ALPHA_WILDFIRE */
-
-#define numa_node_id()	cputonode(smp_processor_id())
 #endif /* CONFIG_NUMA */
 
 #endif /* CONFIG_DISCONTIGMEM */
diff -Nur linux-2.5.34-mm3/include/asm-alpha/topology.h linux-2.5.34-mm3+topo/include/asm-alpha/topology.h
--- linux-2.5.34-mm3/include/asm-alpha/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.34-mm3+topo/include/asm-alpha/topology.h	Fri Sep 13 14:59:21 2002
@@ -0,0 +1,14 @@
+#ifndef _ASM_ALPHA_TOPOLOGY_H
+#define _ASM_ALPHA_TOPOLOGY_H
+
+#ifdef CONFIG_NUMA
+#ifdef CONFIG_ALPHA_WILDFIRE
+/* With wildfire assume 4 CPUs per node */
+#define __cpu_to_node(cpu)	((cpu) >> 2)
+#endif /* CONFIG_ALPHA_WILDFIRE */
+#endif /* CONFIG_NUMA */
+
+/* Get the rest of the topology definitions */
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_ALPHA_TOPOLOGY_H */
diff -Nur linux-2.5.34-mm3/include/asm-arm/topology.h linux-2.5.34-mm3+topo/include/asm-arm/topology.h
--- linux-2.5.34-mm3/include/asm-arm/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.34-mm3+topo/include/asm-arm/topology.h	Fri Sep 13 14:59:21 2002
@@ -0,0 +1,6 @@
+#ifndef _ASM_ARM_TOPOLOGY_H
+#define _ASM_ARM_TOPOLOGY_H
+
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_ARM_TOPOLOGY_H */
diff -Nur linux-2.5.34-mm3/include/asm-cris/topology.h linux-2.5.34-mm3+topo/include/asm-cris/topology.h
--- linux-2.5.34-mm3/include/asm-cris/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.34-mm3+topo/include/asm-cris/topology.h	Fri Sep 13 14:59:21 2002
@@ -0,0 +1,6 @@
+#ifndef _ASM_CRIS_TOPOLOGY_H
+#define _ASM_CRIS_TOPOLOGY_H
+
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_CRIS_TOPOLOGY_H */
diff -Nur linux-2.5.34-mm3/include/asm-generic/topology.h linux-2.5.34-mm3+topo/include/asm-generic/topology.h
--- linux-2.5.34-mm3/include/asm-generic/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.34-mm3+topo/include/asm-generic/topology.h	Fri Sep 13 14:59:21 2002
@@ -0,0 +1,51 @@
+/*
+ * linux/include/asm-generic/topology.h
+ *
+ * Written by: Matthew Dobson, IBM Corporation
+ *
+ * Copyright (C) 2002, IBM Corp.
+ *
+ * All rights reserved.          
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <colpatch@us.ibm.com>
+ */
+#ifndef _ASM_GENERIC_TOPOLOGY_H
+#define _ASM_GENERIC_TOPOLOGY_H
+
+/* Other architectures wishing to use this simple topology API should fill
+   in the below functions as appropriate in their own <asm/topology.h> file. */
+#ifndef __cpu_to_node
+#define __cpu_to_node(cpu)		(0)
+#endif
+#ifndef __memblk_to_node
+#define __memblk_to_node(memblk)		(0)
+#endif
+#ifndef __parent_node
+#define __parent_node(nid)		(0)
+#endif
+#ifndef __node_to_first_cpu
+#define __node_to_first_cpu(node)	(0)
+#endif
+#ifndef __node_to_cpu_mask
+#define __node_to_cpu_mask(node)		(cpu_online_map)
+#endif
+#ifndef __node_to_memblk
+#define __node_to_memblk(node)		(0)
+#endif
+
+#endif /* _ASM_GENERIC_TOPOLOGY_H */
diff -Nur linux-2.5.34-mm3/include/asm-i386/topology.h linux-2.5.34-mm3+topo/include/asm-i386/topology.h
--- linux-2.5.34-mm3/include/asm-i386/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.34-mm3+topo/include/asm-i386/topology.h	Fri Sep 13 14:59:21 2002
@@ -0,0 +1,92 @@
+/*
+ * linux/include/asm-i386/topology.h
+ *
+ * Written by: Matthew Dobson, IBM Corporation
+ *
+ * Copyright (C) 2002, IBM Corp.
+ *
+ * All rights reserved.          
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to <colpatch@us.ibm.com>
+ */
+#ifndef _ASM_I386_TOPOLOGY_H
+#define _ASM_I386_TOPOLOGY_H
+
+#ifdef CONFIG_X86_NUMAQ
+
+#include <asm/smpboot.h>
+
+/* Returns the number of the node containing CPU 'cpu' */
+#define __cpu_to_node(cpu) (cpu_to_logical_apicid(cpu) >> 4)
+
+/* Returns the number of the node containing MemBlk 'memblk' */
+#define __memblk_to_node(memblk) (memblk)
+
+/* Returns the number of the node containing Node 'nid'.  This architecture is flat, 
+   so it is a pretty simple function! */
+#define __parent_node(nid) (nid)
+
+/* Returns the number of the first CPU on Node 'node'.
+ * This should be changed to a set of cached values
+ * but this will do for now.
+ */
+static inline int __node_to_first_cpu(int node)
+{
+	int i, cpu, logical_apicid = node << 4;
+
+	for(i = 1; i < 16; i <<= 1)
+		/* check to see if the cpu is in the system */
+		if ((cpu = logical_apicid_to_cpu(logical_apicid | i)) >= 0)
+			/* if yes, return it to caller */
+			return cpu;
+
+	return 0;
+}
+
+/* Returns a bitmask of CPUs on Node 'node'.
+ * This should be changed to a set of cached bitmasks
+ * but this will do for now.
+ */
+static inline unsigned long __node_to_cpu_mask(int node)
+{
+	int i, cpu, logical_apicid = node << 4;
+	unsigned long mask;
+
+	for(i = 1; i < 16; i <<= 1)
+		/* check to see if the cpu is in the system */
+		if ((cpu = logical_apicid_to_cpu(logical_apicid | i)) >= 0)
+			/* if yes, add to bitmask */
+			mask |= 1 << cpu;
+
+	return mask;
+}
+
+/* Returns the number of the first MemBlk on Node 'node' */
+#define __node_to_memblk(node) (node)
+
+#else /* !CONFIG_X86_NUMAQ */
+/*
+ * Other i386 platforms should define their own version of the 
+ * above macros here.
+ */
+
+#include <asm-generic/topology.h>
+
+#endif /* CONFIG_X86_NUMAQ */
+
+#endif /* _ASM_I386_TOPOLOGY_H */
diff -Nur linux-2.5.34-mm3/include/asm-ia64/topology.h linux-2.5.34-mm3+topo/include/asm-ia64/topology.h
--- linux-2.5.34-mm3/include/asm-ia64/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.34-mm3+topo/include/asm-ia64/topology.h	Fri Sep 13 14:59:21 2002
@@ -0,0 +1,6 @@
+#ifndef _ASM_IA64_TOPOLOGY_H
+#define _ASM_IA64_TOPOLOGY_H
+
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_IA64_TOPOLOGY_H */
diff -Nur linux-2.5.34-mm3/include/asm-m68k/topology.h linux-2.5.34-mm3+topo/include/asm-m68k/topology.h
--- linux-2.5.34-mm3/include/asm-m68k/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.34-mm3+topo/include/asm-m68k/topology.h	Fri Sep 13 14:59:21 2002
@@ -0,0 +1,6 @@
+#ifndef _ASM_M68K_TOPOLOGY_H
+#define _ASM_M68K_TOPOLOGY_H
+
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_M68K_TOPOLOGY_H */
diff -Nur linux-2.5.34-mm3/include/asm-mips/topology.h linux-2.5.34-mm3+topo/include/asm-mips/topology.h
--- linux-2.5.34-mm3/include/asm-mips/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.34-mm3+topo/include/asm-mips/topology.h	Fri Sep 13 14:59:21 2002
@@ -0,0 +1,6 @@
+#ifndef _ASM_MIPS_TOPOLOGY_H
+#define _ASM_MIPS_TOPOLOGY_H
+
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_MIPS_TOPOLOGY_H */
diff -Nur linux-2.5.34-mm3/include/asm-mips64/mmzone.h linux-2.5.34-mm3+topo/include/asm-mips64/mmzone.h
--- linux-2.5.34-mm3/include/asm-mips64/mmzone.h	Fri Sep 13 14:58:03 2002
+++ linux-2.5.34-mm3+topo/include/asm-mips64/mmzone.h	Fri Sep 13 14:59:21 2002
@@ -28,8 +28,6 @@
 #define PLAT_NODE_DATA_LOCALNR(p, n) \
 		(((p) >> PAGE_SHIFT) - PLAT_NODE_DATA(n)->gendata.node_start_pfn)
 
-#define numa_node_id()	cputocnode(current->processor)
-
 #ifdef CONFIG_DISCONTIGMEM
 
 /*
diff -Nur linux-2.5.34-mm3/include/asm-mips64/topology.h linux-2.5.34-mm3+topo/include/asm-mips64/topology.h
--- linux-2.5.34-mm3/include/asm-mips64/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.34-mm3+topo/include/asm-mips64/topology.h	Fri Sep 13 14:59:21 2002
@@ -0,0 +1,11 @@
+#ifndef _ASM_MIPS64_TOPOLOGY_H
+#define _ASM_MIPS64_TOPOLOGY_H
+
+#include <asm/mmzone.h>
+
+#define __cpu_to_node(cpu)		(cputocnode(cpu))
+
+/* Get the rest of the topology definitions */
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_MIPS64_TOPOLOGY_H */
diff -Nur linux-2.5.34-mm3/include/asm-parisc/topology.h linux-2.5.34-mm3+topo/include/asm-parisc/topology.h
--- linux-2.5.34-mm3/include/asm-parisc/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.34-mm3+topo/include/asm-parisc/topology.h	Fri Sep 13 14:59:21 2002
@@ -0,0 +1,6 @@
+#ifndef _ASM_PARISC_TOPOLOGY_H
+#define _ASM_PARISC_TOPOLOGY_H
+
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_PARISC_TOPOLOGY_H */
diff -Nur linux-2.5.34-mm3/include/asm-ppc/topology.h linux-2.5.34-mm3+topo/include/asm-ppc/topology.h
--- linux-2.5.34-mm3/include/asm-ppc/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.34-mm3+topo/include/asm-ppc/topology.h	Fri Sep 13 14:59:21 2002
@@ -0,0 +1,6 @@
+#ifndef _ASM_PPC_TOPOLOGY_H
+#define _ASM_PPC_TOPOLOGY_H
+
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_PPC_TOPOLOGY_H */
diff -Nur linux-2.5.34-mm3/include/asm-ppc64/mmzone.h linux-2.5.34-mm3+topo/include/asm-ppc64/mmzone.h
--- linux-2.5.34-mm3/include/asm-ppc64/mmzone.h	Fri Sep 13 14:58:03 2002
+++ linux-2.5.34-mm3+topo/include/asm-ppc64/mmzone.h	Fri Sep 13 14:59:21 2002
@@ -82,13 +82,5 @@
 	(ADDR_TO_MAPBASE(kaddr) + LOCAL_MAP_NR(kaddr)); \
 })
 
-#ifdef CONFIG_NUMA
-
-/* XXX grab this from the device tree - Anton */
-#define cputonode(cpu)	((cpu) >> CPU_SHIFT_BITS)
-
-#define numa_node_id()	cputonode(smp_processor_id())
-
-#endif /* CONFIG_NUMA */
 #endif /* CONFIG_DISCONTIGMEM */
 #endif /* _ASM_MMZONE_H_ */
diff -Nur linux-2.5.34-mm3/include/asm-ppc64/topology.h linux-2.5.34-mm3+topo/include/asm-ppc64/topology.h
--- linux-2.5.34-mm3/include/asm-ppc64/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.34-mm3+topo/include/asm-ppc64/topology.h	Fri Sep 13 14:59:21 2002
@@ -0,0 +1,14 @@
+#ifndef _ASM_PPC64_TOPOLOGY_H
+#define _ASM_PPC64_TOPOLOGY_H
+
+#include <asm/mmzone.h>
+
+#ifdef CONFIG_NUMA
+/* XXX grab this from the device tree - Anton */
+#define __cpu_to_node(cpu)	((cpu) >> CPU_SHIFT_BITS)
+#endif /* CONFIG_NUMA */
+
+/* Get the rest of the topology definitions */
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_PPC64_TOPOLOGY_H */
diff -Nur linux-2.5.34-mm3/include/asm-s390/topology.h linux-2.5.34-mm3+topo/include/asm-s390/topology.h
--- linux-2.5.34-mm3/include/asm-s390/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.34-mm3+topo/include/asm-s390/topology.h	Fri Sep 13 14:59:21 2002
@@ -0,0 +1,6 @@
+#ifndef _ASM_S390_TOPOLOGY_H
+#define _ASM_S390_TOPOLOGY_H
+
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_S390_TOPOLOGY_H */
diff -Nur linux-2.5.34-mm3/include/asm-s390x/topology.h linux-2.5.34-mm3+topo/include/asm-s390x/topology.h
--- linux-2.5.34-mm3/include/asm-s390x/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.34-mm3+topo/include/asm-s390x/topology.h	Fri Sep 13 14:59:21 2002
@@ -0,0 +1,6 @@
+#ifndef _ASM_S390X_TOPOLOGY_H
+#define _ASM_S390X_TOPOLOGY_H
+
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_S390X_TOPOLOGY_H */
diff -Nur linux-2.5.34-mm3/include/asm-sh/topology.h linux-2.5.34-mm3+topo/include/asm-sh/topology.h
--- linux-2.5.34-mm3/include/asm-sh/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.34-mm3+topo/include/asm-sh/topology.h	Fri Sep 13 14:59:21 2002
@@ -0,0 +1,6 @@
+#ifndef _ASM_SH_TOPOLOGY_H
+#define _ASM_SH_TOPOLOGY_H
+
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_SH_TOPOLOGY_H */
diff -Nur linux-2.5.34-mm3/include/asm-sparc/topology.h linux-2.5.34-mm3+topo/include/asm-sparc/topology.h
--- linux-2.5.34-mm3/include/asm-sparc/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.34-mm3+topo/include/asm-sparc/topology.h	Fri Sep 13 14:59:21 2002
@@ -0,0 +1,6 @@
+#ifndef _ASM_SPARC_TOPOLOGY_H
+#define _ASM_SPARC_TOPOLOGY_H
+
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_SPARC_TOPOLOGY_H */
diff -Nur linux-2.5.34-mm3/include/asm-sparc64/topology.h linux-2.5.34-mm3+topo/include/asm-sparc64/topology.h
--- linux-2.5.34-mm3/include/asm-sparc64/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.34-mm3+topo/include/asm-sparc64/topology.h	Fri Sep 13 14:59:21 2002
@@ -0,0 +1,6 @@
+#ifndef _ASM_SPARC64_TOPOLOGY_H
+#define _ASM_SPARC64_TOPOLOGY_H
+
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_SPARC64_TOPOLOGY_H */
diff -Nur linux-2.5.34-mm3/include/asm-x86_64/topology.h linux-2.5.34-mm3+topo/include/asm-x86_64/topology.h
--- linux-2.5.34-mm3/include/asm-x86_64/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.34-mm3+topo/include/asm-x86_64/topology.h	Fri Sep 13 14:59:21 2002
@@ -0,0 +1,6 @@
+#ifndef _ASM_X86_64_TOPOLOGY_H
+#define _ASM_X86_64_TOPOLOGY_H
+
+#include <asm-generic/topology.h>
+
+#endif /* _ASM_X86_64_TOPOLOGY_H */
diff -Nur linux-2.5.34-mm3/include/linux/mmzone.h linux-2.5.34-mm3+topo/include/linux/mmzone.h
--- linux-2.5.34-mm3/include/linux/mmzone.h	Fri Sep 13 14:58:04 2002
+++ linux-2.5.34-mm3+topo/include/linux/mmzone.h	Fri Sep 13 14:59:21 2002
@@ -248,13 +248,23 @@
 #define for_each_zone(zone) \
 	for (zone = pgdat_list->node_zones; zone; zone = next_zone(zone))
 
+#ifdef CONFIG_NUMA
+#define MAX_NR_MEMBLKS	BITS_PER_LONG /* Max number of Memory Blocks */
+#else /* !CONFIG_NUMA */
+#define MAX_NR_MEMBLKS	1
+#endif /* CONFIG_NUMA */
+
+#include <asm/topology.h>
+/* Returns the number of the current Node. */
+#define numa_node_id()		(__cpu_to_node(smp_processor_id()))
+
 #ifndef CONFIG_DISCONTIGMEM
 
 #define NODE_DATA(nid)		(&contig_page_data)
 #define NODE_MEM_MAP(nid)	mem_map
 #define MAX_NR_NODES		1
 
-#else /* !CONFIG_DISCONTIGMEM */
+#else /* CONFIG_DISCONTIGMEM */
 
 #include <asm/mmzone.h>
 

--------------040304010202040609020303--

