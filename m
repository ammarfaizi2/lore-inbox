Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261431AbSJAA6J>; Mon, 30 Sep 2002 20:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261433AbSJAA6J>; Mon, 30 Sep 2002 20:58:09 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:18588 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261431AbSJAA6F>; Mon, 30 Sep 2002 20:58:05 -0400
Message-ID: <3D98F3AD.2030607@us.ibm.com>
Date: Mon, 30 Sep 2002 18:00:29 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mochel <mochel@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [rfc][patch] driverfs multi-node(board) patch [1/2]
Content-Type: multipart/mixed;
 boundary="------------020108090706080104070500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020108090706080104070500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patrick,
	Here's the pre-reqs to my patch.  I put in a memblk_online_map (just like 
cpu_online_map) and associated functions (memblk_online(), etc).
	Also there's a include/linux/topology.h that has some wrappers for the 
in-kernel macros.  Just does bound checking, etc.

	This patch sits on top of 2.5.39-mm1 (which includes my in-kernel 
topology API).  The *real* driverfs additions will sit on top of this 
patch...  Coming momentarily...

Cheers!

-Matt

--------------020108090706080104070500
Content-Type: text/plain;
 name="driverfs-pre_req-2.5.39.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="driverfs-pre_req-2.5.39.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.39-vanilla/arch/i386/kernel/smpboot.c linux-2.5.39-driverfs_pre-reqs/arch/i386/kernel/smpboot.c
--- linux-2.5.39-vanilla/arch/i386/kernel/smpboot.c	Fri Sep 27 14:49:54 2002
+++ linux-2.5.39-driverfs_pre-reqs/arch/i386/kernel/smpboot.c	Mon Sep 30 15:57:51 2002
@@ -62,6 +62,9 @@
 /* Bitmask of currently online CPUs */
 unsigned long cpu_online_map;
 
+/* Bitmask of currently online memory blocks */
+unsigned long memblk_online_map = 0UL;
+
 static volatile unsigned long cpu_callin_map;
 volatile unsigned long cpu_callout_map;
 static unsigned long smp_commenced_mask;
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.39-vanilla/drivers/base/core.c linux-2.5.39-driverfs_pre-reqs/drivers/base/core.c
--- linux-2.5.39-vanilla/drivers/base/core.c	Fri Sep 27 14:49:03 2002
+++ linux-2.5.39-driverfs_pre-reqs/drivers/base/core.c	Mon Sep 30 15:57:44 2002
@@ -68,7 +68,7 @@
 }
 
 /**
- * device_attach - try to associated device with a driver
+ * do_device_attach - try to associate device with a driver
  * @drv:	current driver to try
  * @data:	device in disguise
  *
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.39-vanilla/include/asm-i386/smp.h linux-2.5.39-driverfs_pre-reqs/include/asm-i386/smp.h
--- linux-2.5.39-vanilla/include/asm-i386/smp.h	Fri Sep 27 14:49:02 2002
+++ linux-2.5.39-driverfs_pre-reqs/include/asm-i386/smp.h	Mon Sep 30 15:57:51 2002
@@ -54,6 +54,7 @@
 extern void smp_alloc_memory(void);
 extern unsigned long phys_cpu_present_map;
 extern unsigned long cpu_online_map;
+extern unsigned long memblk_online_map;
 extern volatile unsigned long smp_invalidate_needed;
 extern int pic_mode;
 extern int smp_num_siblings;
@@ -102,6 +103,13 @@
 	return -1;
 }
 
+#define memblk_online(memblk) (memblk_online_map & (1<<(memblk)))
+ 
+extern inline unsigned int num_online_memblks(void)
+{
+	return hweight32(memblk_online_map);
+}
+
 static __inline int hard_smp_processor_id(void)
 {
 	/* we don't want to mark this access volatile - bad code generation */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.39-vanilla/include/linux/smp.h linux-2.5.39-driverfs_pre-reqs/include/linux/smp.h
--- linux-2.5.39-vanilla/include/linux/smp.h	Fri Sep 27 14:50:17 2002
+++ linux-2.5.39-driverfs_pre-reqs/include/linux/smp.h	Mon Sep 30 15:57:51 2002
@@ -94,7 +94,10 @@
 #define cpu_online(cpu)				({ BUG_ON((cpu) != 0); 1; })
 #define num_online_cpus()			1
 #define num_booting_cpus()			1
-#define cpu_possible(cpu)				({ BUG_ON((cpu) != 0); 1; })
+#define cpu_possible(cpu)			({ BUG_ON((cpu) != 0); 1; })
+#define memblk_online_map			1
+#define memblk_online(memblk)			({ BUG_ON((memblk) != 0); 1; })
+#define num_online_memblks()			1
 
 struct notifier_block;
 
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.39-vanilla/include/linux/topology.h linux-2.5.39-driverfs_pre-reqs/include/linux/topology.h
--- linux-2.5.39-vanilla/include/linux/topology.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.39-driverfs_pre-reqs/include/linux/topology.h	Mon Sep 30 15:57:48 2002
@@ -0,0 +1,155 @@
+/*
+ * linux/include/linux/topology.h
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
+#include <linux/kernel.h>
+#include <linux/unistd.h>
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+#include <linux/mmzone.h>
+
+#include <asm/topology.h>
+
+extern int numnodes;
+
+/*
+ * cpu_to_node(cpu): Returns the number of the most specific Node 
+ * containing CPU 'cpu'.
+ */
+static inline int cpu_to_node(int cpu)
+{
+	int node;
+
+	if (cpu == -1)     /* returns highest numbered node */
+		return (numnodes - 1);
+
+	if ((cpu < 0) || (cpu >= NR_CPUS) || (!cpu_online(cpu)) || 
+	    ((node = __cpu_to_node(cpu)) < 0))  /* invalid cpu */
+		return -ENODEV;
+
+	return node;
+}
+
+/*
+ * memblk_to_node(memblk): Returns the number of the most specific Node 
+ * containing Memory Block 'memblk'.
+ */
+static inline int memblk_to_node(int memblk)
+{
+	int node;
+
+	if (memblk == -1)  /* return highest numbered node */
+		return (numnodes - 1);
+
+	if ((memblk < 0) || (memblk >= MAX_NR_MEMBLKS) || (!memblk_online(memblk)) || 
+	    ((node = __memblk_to_node(memblk)) < 0))  /* invalid memblk # */
+		return -ENODEV;
+
+	return node;
+}
+
+/*
+ * parent_node(node): Returns the number of the of the most specific Node that
+ * encompasses Node 'node'.  Some may call this the parent Node of 'node'.
+ */
+static inline int parent_node(int node)
+{
+	if ((node < 0) || (node >= MAX_NR_NODES))  /* invalid node # */
+		return -ENODEV;
+
+	return __parent_node(node);
+}
+
+/*
+ * node_to_first_cpu(node): Returns the lowest numbered CPU on Node 'node'
+ */
+static inline int node_to_first_cpu(int node)
+{
+	int cpu;
+
+	if (node == -1)  /* return highest numbered cpu */
+		return (num_online_cpus() - 1);
+
+	if ((node < 0) || (node >= MAX_NR_NODES) ||
+	    ((cpu = __node_to_first_cpu(node)) < 0))  /* invalid node # */
+		return -ENODEV;
+
+	return cpu;
+}
+
+/*
+ * node_to_cpu_mask(node): Returns a bitmask of CPUs on Node 'node'
+ */
+static inline unsigned long node_to_cpu_mask(int node)
+{
+	if (node == -1)  /* return highest numbered cpu */
+		return (num_online_cpus() - 1);
+
+	if ((node < 0) || (node >= MAX_NR_NODES))  /* invalid node # */
+		return -ENODEV;
+
+	return __node_to_cpu_mask(node);
+}
+
+/*
+ * node_to_memblk(node): Returns the lowest numbered MemBlk on Node 'node'
+ */
+static inline int node_to_memblk(int node)
+{
+	int memblk;
+
+	if (node == -1)  /* return highest numbered memblk */
+		return (num_online_memblks() - 1);
+
+	if ((node < 0) || (node >= MAX_NR_NODES) ||
+	    ((memblk = __node_to_memblk(node)) < 0))  /* invalid node # */
+		return -ENODEV;
+
+	return memblk;
+}
+
+/*
+ * get_curr_cpu(): Returns the currently executing CPU number.
+ * For now, this has only mild usefulness, as this information could
+ * change on the return from syscall (which automatically calls schedule()).
+ * Due to this, the data could be stale by the time it gets back to the user.
+ * It will have to do, until a better method is found.
+ */
+static inline int get_curr_cpu(void)
+{
+	return smp_processor_id();
+}
+
+/*
+ * get_curr_node(): Returns the number of the Node containing 
+ * the currently executing CPU.  Subject to the same caveat
+ * as the get_curr_cpu() call.
+ */
+static inline int get_curr_node(void)
+{
+	return cpu_to_node(get_curr_cpu());
+}
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.39-vanilla/mm/numa.c linux-2.5.39-driverfs_pre-reqs/mm/numa.c
--- linux-2.5.39-vanilla/mm/numa.c	Fri Sep 27 14:50:29 2002
+++ linux-2.5.39-driverfs_pre-reqs/mm/numa.c	Mon Sep 30 15:57:51 2002
@@ -37,6 +37,7 @@
 	}
 	contig_page_data.node_mem_map = pmap;
 	free_area_init_core(&contig_page_data, zones_size, zholes_size);
+	memblk_online_map = 1UL;
 	mem_map = contig_page_data.node_mem_map;
 }
 
@@ -74,6 +75,10 @@
 	}
 	pgdat->node_mem_map = pmap;
 	free_area_init_core(pgdat, zones_size, zholes_size);
+	if (test_and_set_bit(num_online_memblks(), &memblk_online_map)){
+		printk("free_area_init_core: memblk alread counted?!?!\n");
+		BUG();
+	}
 
 	/*
 	 * Get space for the valid bitmap.

--------------020108090706080104070500--

