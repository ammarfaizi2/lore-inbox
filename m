Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265229AbSJWVA0>; Wed, 23 Oct 2002 17:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265231AbSJWVA0>; Wed, 23 Oct 2002 17:00:26 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:6371 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265229AbSJWVAV>;
	Wed, 23 Oct 2002 17:00:21 -0400
Message-ID: <3DB70E67.9040704@us.ibm.com>
Date: Wed, 23 Oct 2002 14:02:31 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Patrick Mochel <mochel@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [patch] (3/5) NUMA meminfo for driverfs Topology 2.5.44
References: <2699066091.1035310557@[10.10.2.3]> <Pine.LNX.4.44.0210221824430.983-100000@cherise.pdx.osdl.net> <3DB5FCC5.E54808E@digeo.com> <3DB70CDD.8080506@us.ibm.com> <3DB70DC1.204@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------070707000305020700020604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070707000305020700020604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Create nodeX/meminfo files for DriverFS Topology.

This patch adds code to DriverFS Topology to expose per-node memory 
statistics.
This information is exposed via: cat nodeX/meminfo

The patch also adds 2 helper functions to gather per-node memory info.

Cheers!

-Matt

--------------070707000305020700020604
Content-Type: text/plain;
 name="02-meminfo_addition.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="02-meminfo_addition.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-base/drivers/base/node.c linux-2.5.44-meminfo_addition/drivers/base/node.c
--- linux-2.5.44-base/drivers/base/node.c	Wed Oct 23 12:01:20 2002
+++ linux-2.5.44-meminfo_addition/drivers/base/node.c	Wed Oct 23 12:10:57 2002
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
@@ -54,6 +82,7 @@
 	node->sysroot.dev.bus = &system_bus_type;
 	if (!sys_register_root(&node->sysroot)){
 		device_create_file(&node->sysroot.dev, &dev_attr_cpumap);
+		device_create_file(&node->sysroot.dev, &dev_attr_meminfo);
 	}
 }
 
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-base/include/linux/mm.h linux-2.5.44-meminfo_addition/include/linux/mm.h
--- linux-2.5.44-base/include/linux/mm.h	Fri Oct 18 21:01:08 2002
+++ linux-2.5.44-meminfo_addition/include/linux/mm.h	Wed Oct 23 12:10:57 2002
@@ -450,6 +450,9 @@
 extern void mem_init(void);
 extern void show_mem(void);
 extern void si_meminfo(struct sysinfo * val);
+#ifdef CONFIG_NUMA
+extern void si_meminfo_node(struct sysinfo *val, int nid);
+#endif
 extern void swapin_readahead(swp_entry_t);
 
 extern int can_share_swap_page(struct page *);
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-base/include/linux/swap.h linux-2.5.44-meminfo_addition/include/linux/swap.h
--- linux-2.5.44-base/include/linux/swap.h	Fri Oct 18 21:01:08 2002
+++ linux-2.5.44-meminfo_addition/include/linux/swap.h	Wed Oct 23 12:10:57 2002
@@ -131,6 +131,9 @@
 extern unsigned long totalram_pages;
 extern unsigned long totalhigh_pages;
 extern unsigned int nr_free_pages(void);
+#ifdef CONFIG_NUMA
+extern unsigned int nr_free_pages_pgdat(pg_data_t *pgdat);
+#endif
 extern unsigned int nr_free_buffer_pages(void);
 extern unsigned int nr_free_pagecache_pages(void);
 
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-base/mm/page_alloc.c linux-2.5.44-meminfo_addition/mm/page_alloc.c
--- linux-2.5.44-base/mm/page_alloc.c	Fri Oct 18 21:01:09 2002
+++ linux-2.5.44-meminfo_addition/mm/page_alloc.c	Wed Oct 23 12:10:57 2002
@@ -504,6 +504,18 @@
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
@@ -631,6 +643,19 @@
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

--------------070707000305020700020604--

