Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261443AbSIXWLe>; Tue, 24 Sep 2002 18:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261837AbSIXWLe>; Tue, 24 Sep 2002 18:11:34 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:41175 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261443AbSIXWLb>;
	Tue, 24 Sep 2002 18:11:31 -0400
Message-ID: <3D90E39C.5020107@us.ibm.com>
Date: Tue, 24 Sep 2002 15:13:48 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Anton Blanchard <anton@samba.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: [patch] linux-2.5.38-mm2 cleanups
Content-Type: multipart/mixed;
 boundary="------------090803070503090200000103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090803070503090200000103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,
	Here are a couple of cleanups for the 2.5.38-mm2 tree.

Anton,
	I cc'd you, because the patch also moves the __cpu_to_node() function 
from mmzone.h into topology.h, where it really belongs (as long as the 
in-kernel topology stuff is there).  If there's some reason that 
shouldn't be done, please yell at me! ;)

Changelog:
	This patch cleans up a couple of braindamaged things I was doing with 
<asm-generic/topology.h> and moves a ppc64 topology function from 
mmzone.h into topology.h.

Cheers!

-Matt

--------------090803070503090200000103
Content-Type: text/plain;
 name="2.5.38-mm2_fixup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.5.38-mm2_fixup.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.38-mm2/include/asm-alpha/topology.h linux-2.5.38-mm2_fixes/include/asm-alpha/topology.h
--- linux-2.5.38-mm2/include/asm-alpha/topology.h	Tue Sep 24 10:41:22 2002
+++ linux-2.5.38-mm2_fixes/include/asm-alpha/topology.h	Tue Sep 24 11:16:59 2002
@@ -4,11 +4,18 @@
 #ifdef CONFIG_NUMA
 #ifdef CONFIG_ALPHA_WILDFIRE
 /* With wildfire assume 4 CPUs per node */
-#define __cpu_to_node(cpu)	((cpu) >> 2)
+#define __cpu_to_node(cpu)		((cpu) >> 2)
 #endif /* CONFIG_ALPHA_WILDFIRE */
 #endif /* CONFIG_NUMA */
 
-/* Get the rest of the topology definitions */
-#include <asm-generic/topology.h>
+#if !defined(CONFIG_NUMA) || !defined(CONFIG_ALPHA_WILDFIRE)
+#define __cpu_to_node(cpu)		(0)
+#endif /* !CONFIG_NUMA || !CONFIG_ALPHA_WILDFIRE */
+
+#define __memblk_to_node(memblk)	(0)
+#define __parent_node(nid)		(0)
+#define __node_to_first_cpu(node)	(0)
+#define __node_to_cpu_mask(node)	(cpu_online_map)
+#define __node_to_memblk(node)		(0)
 
 #endif /* _ASM_ALPHA_TOPOLOGY_H */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.38-mm2/include/asm-generic/topology.h linux-2.5.38-mm2_fixes/include/asm-generic/topology.h
--- linux-2.5.38-mm2/include/asm-generic/topology.h	Tue Sep 24 10:41:22 2002
+++ linux-2.5.38-mm2_fixes/include/asm-generic/topology.h	Tue Sep 24 11:00:30 2002
@@ -33,7 +33,7 @@
 #define __cpu_to_node(cpu)		(0)
 #endif
 #ifndef __memblk_to_node
-#define __memblk_to_node(memblk)		(0)
+#define __memblk_to_node(memblk)	(0)
 #endif
 #ifndef __parent_node
 #define __parent_node(nid)		(0)
@@ -42,7 +42,7 @@
 #define __node_to_first_cpu(node)	(0)
 #endif
 #ifndef __node_to_cpu_mask
-#define __node_to_cpu_mask(node)		(cpu_online_map)
+#define __node_to_cpu_mask(node)	(cpu_online_map)
 #endif
 #ifndef __node_to_memblk
 #define __node_to_memblk(node)		(0)
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.38-mm2/include/asm-i386/mmzone.h linux-2.5.38-mm2_fixes/include/asm-i386/mmzone.h
--- linux-2.5.38-mm2/include/asm-i386/mmzone.h	Tue Sep 24 10:41:22 2002
+++ linux-2.5.38-mm2_fixes/include/asm-i386/mmzone.h	Tue Sep 24 10:51:30 2002
@@ -14,9 +14,6 @@
 #include <asm/numaq.h>
 #else
 #define pfn_to_nid(pfn)		(0)
-#ifdef CONFIG_NUMA
-#define _cpu_to_node(cpu) 0
-#endif /* CONFIG_NUMA */
 #endif /* CONFIG_X86_NUMAQ */
 
 extern struct pglist_data *node_data[];
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.38-mm2/include/asm-i386/numaq.h linux-2.5.38-mm2_fixes/include/asm-i386/numaq.h
--- linux-2.5.38-mm2/include/asm-i386/numaq.h	Sat Sep 21 21:25:11 2002
+++ linux-2.5.38-mm2_fixes/include/asm-i386/numaq.h	Tue Sep 24 10:52:09 2002
@@ -41,9 +41,6 @@
 #define pfn_to_pgdat(pfn) NODE_DATA(pfn_to_nid(pfn))
 #define PHYSADDR_TO_NID(pa) pfn_to_nid(pa >> PAGE_SHIFT)
 #define MAX_NUMNODES		8
-#ifdef CONFIG_NUMA
-#define _cpu_to_node(cpu) (cpu_to_logical_apicid(cpu) >> 4)
-#endif /* CONFIG_NUMA */
 extern int pfn_to_nid(unsigned long);
 extern void get_memcfg_numaq(void);
 #define get_memcfg_numa() get_memcfg_numaq()
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.38-mm2/include/asm-mips64/topology.h linux-2.5.38-mm2_fixes/include/asm-mips64/topology.h
--- linux-2.5.38-mm2/include/asm-mips64/topology.h	Tue Sep 24 10:41:22 2002
+++ linux-2.5.38-mm2_fixes/include/asm-mips64/topology.h	Tue Sep 24 11:09:57 2002
@@ -4,8 +4,10 @@
 #include <asm/mmzone.h>
 
 #define __cpu_to_node(cpu)		(cputocnode(cpu))
-
-/* Get the rest of the topology definitions */
-#include <asm-generic/topology.h>
+#define __memblk_to_node(memblk)	(0)
+#define __parent_node(nid)		(0)
+#define __node_to_first_cpu(node)	(0)
+#define __node_to_cpu_mask(node)	(cpu_online_map)
+#define __node_to_memblk(node)		(0)
 
 #endif /* _ASM_MIPS64_TOPOLOGY_H */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.38-mm2/include/asm-ppc64/mmzone.h linux-2.5.38-mm2_fixes/include/asm-ppc64/mmzone.h
--- linux-2.5.38-mm2/include/asm-ppc64/mmzone.h	Tue Sep 24 10:41:22 2002
+++ linux-2.5.38-mm2_fixes/include/asm-ppc64/mmzone.h	Tue Sep 24 10:50:56 2002
@@ -56,24 +56,6 @@
 #define node_size(nid)		(NODE_DATA(nid)->node_size)
 #define node_localnr(pfn, nid)	((pfn) - NODE_DATA(nid)->node_start_pfn)
 
-#ifdef CONFIG_NUMA
-
-static inline int __cpu_to_node(int cpu)
-{
-	int node;
-
-	node = numa_cpu_lookup_table[cpu];
-
-#ifdef DEBUG_NUMA
-	if (node == -1)
-		BUG();
-#endif
-
-	return node;
-}
-
-#endif /* CONFIG_NUMA */
-
 /*
  * Following are macros that each numa implmentation must define.
  */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.38-mm2/include/asm-ppc64/topology.h linux-2.5.38-mm2_fixes/include/asm-ppc64/topology.h
--- linux-2.5.38-mm2/include/asm-ppc64/topology.h	Tue Sep 24 10:41:22 2002
+++ linux-2.5.38-mm2_fixes/include/asm-ppc64/topology.h	Tue Sep 24 11:18:15 2002
@@ -4,11 +4,31 @@
 #include <asm/mmzone.h>
 
 #ifdef CONFIG_NUMA
-/* XXX grab this from the device tree - Anton */
-#define __cpu_to_node(cpu)	((cpu) >> CPU_SHIFT_BITS)
+
+static inline int __cpu_to_node(int cpu)
+{
+	int node;
+
+	node = numa_cpu_lookup_table[cpu];
+
+#ifdef DEBUG_NUMA
+	if (node == -1)
+		BUG();
+#endif
+
+	return node;
+}
+
+#else /* !CONFIG_NUMA */
+
+#define __cpu_to_node(cpu)		(0)
+
 #endif /* CONFIG_NUMA */
 
-/* Get the rest of the topology definitions */
-#include <asm-generic/topology.h>
+#define __memblk_to_node(memblk)	(0)
+#define __parent_node(nid)		(0)
+#define __node_to_first_cpu(node)	(0)
+#define __node_to_cpu_mask(node)	(cpu_online_map)
+#define __node_to_memblk(node)		(0)
 
 #endif /* _ASM_PPC64_TOPOLOGY_H */

--------------090803070503090200000103--

