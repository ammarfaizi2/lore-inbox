Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265231AbSJWVDF>; Wed, 23 Oct 2002 17:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265233AbSJWVDF>; Wed, 23 Oct 2002 17:03:05 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:20655 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265231AbSJWVCy>;
	Wed, 23 Oct 2002 17:02:54 -0400
Message-ID: <3DB70F01.9050906@us.ibm.com>
Date: Wed, 23 Oct 2002 14:05:05 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: colpatch@us.ibm.com
CC: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@osdl.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [patch] (4/5) create memblk_online_map 2.5.44
References: <2699066091.1035310557@[10.10.2.3]> <Pine.LNX.4.44.0210221824430.983-100000@cherise.pdx.osdl.net> <3DB5FCC5.E54808E@digeo.com> <3DB70CDD.8080506@us.ibm.com> <3DB70DC1.204@us.ibm.com> <3DB70E67.9040704@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------030604010505050205060801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030604010505050205060801
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Create and use memblk_online_map.

This patch creates a memblk_online_map, much like cpu_online_map.  It 
also creates the standard helper functions, ie: memblk_online(), 
num_online_memblks(), memblk_set_online(), memblk_set_offline().

This is used by driverFS topology to keep track of which memory blocks 
are in the system and online.

Cheers!

-Matt

--------------030604010505050205060801
Content-Type: text/plain;
 name="03-memblk_online_map.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="03-memblk_online_map.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-base/arch/i386/mach-generic/topology.c linux-2.5.44-memblk_online_map/arch/i386/mach-generic/topology.c
--- linux-2.5.44-base/arch/i386/mach-generic/topology.c	Wed Oct 23 12:07:47 2002
+++ linux-2.5.44-memblk_online_map/arch/i386/mach-generic/topology.c	Wed Oct 23 12:13:31 2002
@@ -48,7 +48,7 @@
 		arch_register_node(i);
 	for (i = 0; i < num_online_cpus(); i++)
 		arch_register_cpu(i);
-	for (i = 0; i < numnodes; i++)
+	for (i = 0; i < num_online_memblks(); i++)
 		arch_register_memblk(i);
 	return 0;
 }
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-base/include/linux/mmzone.h linux-2.5.44-memblk_online_map/include/linux/mmzone.h
--- linux-2.5.44-base/include/linux/mmzone.h	Fri Oct 18 21:01:08 2002
+++ linux-2.5.44-memblk_online_map/include/linux/mmzone.h	Wed Oct 23 12:13:31 2002
@@ -262,6 +262,38 @@
 
 #endif /* !CONFIG_DISCONTIGMEM */
 
+
+extern DECLARE_BITMAP(memblk_online_map, MAX_NR_MEMBLKS);
+
+#if defined(CONFIG_DISCONTIGMEM) || defined(CONFIG_NUMA)
+
+#define memblk_online(memblk)		test_bit(memblk, memblk_online_map)
+#define memblk_set_online(memblk)	set_bit(memblk, memblk_online_map)
+#define memblk_set_offline(memblk)	clear_bit(memblk, memblk_online_map)
+static inline unsigned int num_online_memblks(void)
+{
+	int i, num = 0;
+
+	for(i = 0; i < MAX_NR_MEMBLKS; i++){
+		if (memblk_online(i))
+			num++;
+	}
+	return num;
+}
+
+#else /* !CONFIG_DISCONTIGMEM && !CONFIG_NUMA */
+
+#define memblk_online(memblk) \
+	({ BUG_ON((memblk) != 0); test_bit(memblk, memblk_online_map); })
+#define memblk_set_online(memblk) \
+	({ BUG_ON((memblk) != 0); set_bit(memblk, memblk_online_map); })
+#define memblk_set_offline(memblk) \
+	({ BUG_ON((memblk) != 0); clear_bit(memblk, memblk_online_map); })
+#define num_online_memblks()		1
+
+#endif /* CONFIG_DISCONTIGMEM || CONFIG_NUMA */
+
+
 #define MAP_ALIGN(x)	((((x) % sizeof(struct page)) == 0) ? (x) : ((x) + \
 		sizeof(struct page) - ((x) % sizeof(struct page))))
 
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.44-base/mm/page_alloc.c linux-2.5.44-memblk_online_map/mm/page_alloc.c
--- linux-2.5.44-base/mm/page_alloc.c	Wed Oct 23 12:10:57 2002
+++ linux-2.5.44-memblk_online_map/mm/page_alloc.c	Wed Oct 23 12:13:31 2002
@@ -26,6 +26,9 @@
 #include <linux/blkdev.h>
 #include <linux/slab.h>
 
+#include <asm/topology.h>
+
+DECLARE_BITMAP(memblk_online_map, MAX_NR_MEMBLKS);
 struct pglist_data *pgdat_list;
 unsigned long totalram_pages;
 unsigned long totalhigh_pages;
@@ -1039,6 +1042,7 @@
 	pgdat->node_mem_map = node_mem_map;
 
 	free_area_init_core(pgdat, zones_size, zholes_size);
+	memblk_set_online(__node_to_memblk(nid));
 
 	calculate_zone_bitmap(pgdat, zones_size);
 }

--------------030604010505050205060801--

