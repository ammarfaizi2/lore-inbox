Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265108AbSJaC0N>; Wed, 30 Oct 2002 21:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265109AbSJaC0N>; Wed, 30 Oct 2002 21:26:13 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:14782 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265108AbSJaCZ3>;
	Wed, 30 Oct 2002 21:25:29 -0500
Message-ID: <3DC09515.10701@us.ibm.com>
Date: Wed, 30 Oct 2002 18:27:33 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: colpatch@us.ibm.com
CC: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Patrick Mochel <mochel@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] per-node (NUMA) meminfo for sysfs Topology 2.5.45 (3/5)
References: <3DC09475.2040303@us.ibm.com> <3DC094A3.7030903@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------090200060800060205030300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090200060800060205030300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Matthew Dobson wrote:
>
> Linus,
>     This series of patches creates a directory-based Topology in sysfs 
> (driverfs).  This includes the per-node meminfo patch you wanted, as 
> well as UP/SMP/NUMA topology.
>     There were discussions between myself, Andrew, Rusty, and Patrick, 
> and these are what we agreed on.
>
> (1/5) Core sysfs Topology:
>     This patch creates the generic structures that are (will be)
>     embedded in the per-arch structures.  Also creates calls to
>     register these generic structures (CPUs, MemBlks, & Nodes).
>
>     Note that without arch-specific structures in which to embed
>     these structures, and an arch-specific initialization routine,
>     these functions/structures remain unused.
>
> (2/5) i386 sysfs Topology
>     This patch creates the i386 specific files/functions/structures
>     to implement driverfs Topology.  These structures have the
>     generic CPU/MemBlk/Node structures embedded in them.
>
>     This patch also creates the arch-specific initialization routine
>     to instantiate the topology.
>
> (3/5) per-node (NUMA) meminfo for sysfs Topology
>     This patch adds code to DriverFS Topology to expose per-node
>     memory statistics.
>     This information is exposed via the nodeX/meminfo file.
>
>     The patch also adds 2 helper functions to gather per-node memory
>     info.
>
> (4/5) memblk_online_map
>     This patch creates a memblk_online_map, much like
>     cpu_online_map.  It also creates the standard helper functions,
>     ie: memblk_online(), num_online_memblks(), memblk_set_online(),
>     memblk_set_offline().
>
>     This is used by driverFS topology to keep track of which memory
>     blocks are in the system and online.
>
> (5/5) node_online_map
>     This patch creates a node_online_map, much like cpu_online_map.
>     It also creates the standard helper functions, ie:
>     node_online(), num_online_nodes(), node_set_online(),
>     node_set_offline().
>
>     This is used by driverFS topology to keep track of which Nodes
>     are in the system and online.
>
> Cheers!
>
> -Matt

--------------090200060800060205030300
Content-Type: text/plain;
 name="03-meminfo_additions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="03-meminfo_additions.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/drivers/base/node.c linux-2.5.45-meminfo_additions/drivers/base/node.c
--- linux-2.5.45-base/drivers/base/node.c	Wed Oct 30 18:00:55 2002
+++ linux-2.5.45-meminfo_additions/drivers/base/node.c	Wed Oct 30 18:00:24 2002
@@ -35,6 +35,34 @@
 }
 static DEVICE_ATTR(cpumap,S_IRUGO,node_read_cpumap,NULL);
 
+#define K(x) ((x) << (PAGE_SHIFT - 10))
+static ssize_t node_read_meminfo(struct device * dev, char * buf, size_t count, loff_t off)
+{
+	struct sys_root *node = to_root(dev);
+	int nid = node->id;
+	struct sysinfo i;
+	si_meminfo_node(&i, nid);
+	return off ? 0 : sprintf(buf, "\n"
+			"Node %d MemTotal:     %8lu kB\n"
+			"Node %d MemFree:      %8lu kB\n"
+			"Node %d MemUsed:      %8lu kB\n"
+			"Node %d HighTotal:    %8lu kB\n"
+			"Node %d HighFree:     %8lu kB\n"
+			"Node %d LowTotal:     %8lu kB\n"
+			"Node %d LowFree:      %8lu kB\n",
+			nid, K(i.totalram),
+			nid, K(i.freeram),
+			nid, K(i.totalram-i.freeram),
+			nid, K(i.totalhigh),
+			nid, K(i.freehigh),
+			nid, K(i.totalram-i.totalhigh),
+			nid, K(i.freeram-i.freehigh));
+
+	return 0;
+}
+#undef K 
+static DEVICE_ATTR(meminfo,S_IRUGO,node_read_meminfo,NULL);
+
 
 /*
  * register_node - Setup a driverfs device for a node.
@@ -57,6 +85,7 @@
 	error = sys_register_root(&node->sysroot);
 	if (!error){
 		device_create_file(&node->sysroot.dev, &dev_attr_cpumap);
+		device_create_file(&node->sysroot.dev, &dev_attr_meminfo);
 	}
 	return error;
 }
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/include/linux/mm.h linux-2.5.45-meminfo_additions/include/linux/mm.h
--- linux-2.5.45-base/include/linux/mm.h	Wed Oct 30 16:41:39 2002
+++ linux-2.5.45-meminfo_additions/include/linux/mm.h	Wed Oct 30 17:56:28 2002
@@ -449,6 +449,9 @@
 extern void mem_init(void);
 extern void show_mem(void);
 extern void si_meminfo(struct sysinfo * val);
+#ifdef CONFIG_NUMA
+extern void si_meminfo_node(struct sysinfo *val, int nid);
+#endif
 extern void swapin_readahead(swp_entry_t);
 
 extern int can_share_swap_page(struct page *);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/include/linux/swap.h linux-2.5.45-meminfo_additions/include/linux/swap.h
--- linux-2.5.45-base/include/linux/swap.h	Wed Oct 30 16:41:37 2002
+++ linux-2.5.45-meminfo_additions/include/linux/swap.h	Wed Oct 30 17:56:28 2002
@@ -131,6 +131,9 @@
 extern unsigned long totalram_pages;
 extern unsigned long totalhigh_pages;
 extern unsigned int nr_free_pages(void);
+#ifdef CONFIG_NUMA
+extern unsigned int nr_free_pages_pgdat(pg_data_t *pgdat);
+#endif
 extern unsigned int nr_free_buffer_pages(void);
 extern unsigned int nr_free_pagecache_pages(void);
 
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.45-base/mm/page_alloc.c linux-2.5.45-meminfo_additions/mm/page_alloc.c
--- linux-2.5.45-base/mm/page_alloc.c	Wed Oct 30 16:41:51 2002
+++ linux-2.5.45-meminfo_additions/mm/page_alloc.c	Wed Oct 30 17:56:28 2002
@@ -594,6 +594,18 @@
 	return pages;
 }
 
+#ifdef CONFIG_NUMA
+unsigned int nr_free_pages_pgdat(pg_data_t *pgdat)
+{
+	unsigned int i, sum = 0;
+
+	for (i = 0; i < MAX_NR_ZONES; i++)
+		sum += pgdat->node_zones[i].free_pages;
+
+	return sum;
+}
+#endif
+
 static unsigned int nr_free_zone_pages(int offset)
 {
 	pg_data_t *pgdat;
@@ -721,6 +733,19 @@
 	val->mem_unit = PAGE_SIZE;
 }
 
+#ifdef CONFIG_NUMA
+void si_meminfo_node(struct sysinfo *val, int nid)
+{
+	pg_data_t *pgdat = NODE_DATA(nid);
+
+	val->totalram = pgdat->node_size;
+	val->freeram = nr_free_pages_pgdat(pgdat);
+	val->totalhigh = pgdat->node_zones[ZONE_HIGHMEM].spanned_pages;
+	val->freehigh = pgdat->node_zones[ZONE_HIGHMEM].free_pages;
+	val->mem_unit = PAGE_SIZE;
+}
+#endif
+
 #define K(x) ((x) << (PAGE_SHIFT-10))
 
 /*

--------------090200060800060205030300--

