Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265111AbSJaC21>; Wed, 30 Oct 2002 21:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265112AbSJaC20>; Wed, 30 Oct 2002 21:28:26 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:18623 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265111AbSJaC2K>;
	Wed, 30 Oct 2002 21:28:10 -0500
Message-ID: <3DC095B6.3080404@us.ibm.com>
Date: Wed, 30 Oct 2002 18:30:14 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Patrick Mochel <mochel@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] node_online_map 2.5.45 (5/5)
References: <3DC09475.2040303@us.ibm.com> <3DC094A3.7030903@us.ibm.com> <3DC09515.10701@us.ibm.com> <3DC09561.8090603@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------080101060308010001040006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080101060308010001040006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Matthew Dobson wrote:
> Matthew Dobson wrote:
>> Matthew Dobson wrote:
>>
>>>
>>> Linus,
>>>     This series of patches creates a directory-based Topology in 
>>> sysfs (driverfs).  This includes the per-node meminfo patch you 
>>> wanted, as well as UP/SMP/NUMA topology.
>>>     There were discussions between myself, Andrew, Rusty, and 
>>> Patrick, and these are what we agreed on.
>>>
>>> (1/5) Core sysfs Topology:
>>>     This patch creates the generic structures that are (will be)
>>>     embedded in the per-arch structures.  Also creates calls to
>>>     register these generic structures (CPUs, MemBlks, & Nodes).
>>>
>>>     Note that without arch-specific structures in which to embed
>>>     these structures, and an arch-specific initialization routine,
>>>     these functions/structures remain unused.
>>>
>>> (2/5) i386 sysfs Topology
>>>     This patch creates the i386 specific files/functions/structures
>>>     to implement driverfs Topology.  These structures have the
>>>     generic CPU/MemBlk/Node structures embedded in them.
>>>
>>>     This patch also creates the arch-specific initialization routine
>>>     to instantiate the topology.
>>>
>>> (3/5) per-node (NUMA) meminfo for sysfs Topology
>>>     This patch adds code to DriverFS Topology to expose per-node
>>>     memory statistics.
>>>     This information is exposed via the nodeX/meminfo file.
>>>
>>>     The patch also adds 2 helper functions to gather per-node memory
>>>     info.
>>>
>>> (4/5) memblk_online_map
>>>     This patch creates a memblk_online_map, much like
>>>     cpu_online_map.  It also creates the standard helper functions,
>>>     ie: memblk_online(), num_online_memblks(), memblk_set_online(),
>>>     memblk_set_offline().
>>>
>>>     This is used by driverFS topology to keep track of which memory
>>>     blocks are in the system and online.
>>>
>>> (5/5) node_online_map
>>>     This patch creates a node_online_map, much like cpu_online_map.
>>>     It also creates the standard helper functions, ie:
>>>     node_online(), num_online_nodes(), node_set_online(),
>>>     node_set_offline().
>>>
>>>     This is used by driverFS topology to keep track of which Nodes
>>>     are in the system and online.
>>>
>>> Cheers!
>>>
>>> -Matt

--------------080101060308010001040006
Content-Type: text/plain;
 name="05-node_online_map.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="05-node_online_map.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/arch/i386/kernel/numaq.c linux-2.5.45-node_online_map/arch/i386/kernel/numaq.c
--- linux-2.5.45-base/arch/i386/kernel/numaq.c	Wed Oct 30 16:43:08 2002
+++ linux-2.5.45-node_online_map/arch/i386/kernel/numaq.c	Wed Oct 30 18:03:54 2002
@@ -52,6 +52,7 @@
 	numnodes = 0;
 	for(node = 0; node < MAX_NUMNODES; node++) {
 		if(scd->quads_present31_0 & (1 << node)) {
+			node_set_online(node);
 			numnodes++;
 			eq = &scd->eq[node];
 			/* Convert to pages */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/arch/i386/mach-generic/topology.c linux-2.5.45-node_online_map/arch/i386/mach-generic/topology.c
--- linux-2.5.45-base/arch/i386/mach-generic/topology.c	Wed Oct 30 18:02:17 2002
+++ linux-2.5.45-node_online_map/arch/i386/mach-generic/topology.c	Wed Oct 30 18:03:54 2002
@@ -38,13 +38,11 @@
 struct i386_node node_devices[MAX_NUMNODES];
 struct i386_memblk memblk_devices[MAX_NR_MEMBLKS];
 
-extern int numnodes;
-
 static int __init topology_init(void)
 {
 	int i;
 
-	for (i = 0; i < numnodes; i++)
+	for (i = 0; i < num_online_nodes(); i++)
 		arch_register_node(i);
 	for (i = 0; i < NR_CPUS; i++)
 		if (cpu_possible(i)) arch_register_cpu(i);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/include/linux/mmzone.h linux-2.5.45-node_online_map/include/linux/mmzone.h
--- linux-2.5.45-base/include/linux/mmzone.h	Wed Oct 30 18:02:17 2002
+++ linux-2.5.45-node_online_map/include/linux/mmzone.h	Wed Oct 30 18:03:54 2002
@@ -280,10 +280,25 @@
 #endif /* !CONFIG_DISCONTIGMEM */
 
 
+extern DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
 extern DECLARE_BITMAP(memblk_online_map, MAX_NR_MEMBLKS);
 
 #if defined(CONFIG_DISCONTIGMEM) || defined(CONFIG_NUMA)
 
+#define node_online(node)	test_bit(node, node_online_map)
+#define node_set_online(node)	set_bit(node, node_online_map)
+#define node_set_offline(node)	clear_bit(node, node_online_map)
+static inline unsigned int num_online_nodes(void)
+{
+	int i, num = 0;
+
+	for(i = 0; i < MAX_NUMNODES; i++){
+		if (node_online(i))
+			num++;
+	}
+	return num;
+}
+
 #define memblk_online(memblk)		test_bit(memblk, memblk_online_map)
 #define memblk_set_online(memblk)	set_bit(memblk, memblk_online_map)
 #define memblk_set_offline(memblk)	clear_bit(memblk, memblk_online_map)
@@ -300,6 +315,14 @@
 
 #else /* !CONFIG_DISCONTIGMEM && !CONFIG_NUMA */
 
+#define node_online(node) \
+	({ BUG_ON((node) != 0); test_bit(node, node_online_map); })
+#define node_set_online(node) \
+	({ BUG_ON((node) != 0); set_bit(node, node_online_map); })
+#define node_set_offline(node) \
+	({ BUG_ON((node) != 0); clear_bit(node, node_online_map); })
+#define num_online_nodes()	1
+
 #define memblk_online(memblk) \
 	({ BUG_ON((memblk) != 0); test_bit(memblk, memblk_online_map); })
 #define memblk_set_online(memblk) \
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/mm/page_alloc.c linux-2.5.45-node_online_map/mm/page_alloc.c
--- linux-2.5.45-base/mm/page_alloc.c	Wed Oct 30 18:02:17 2002
+++ linux-2.5.45-node_online_map/mm/page_alloc.c	Wed Oct 30 18:03:54 2002
@@ -31,6 +31,7 @@
 
 #include <asm/topology.h>
 
+DECLARE_BITMAP(node_online_map, MAX_NUMNODES);
 DECLARE_BITMAP(memblk_online_map, MAX_NR_MEMBLKS);
 struct pglist_data *pgdat_list;
 unsigned long totalram_pages;

--------------080101060308010001040006--

