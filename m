Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316659AbSGYWk0>; Thu, 25 Jul 2002 18:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316649AbSGYWk0>; Thu, 25 Jul 2002 18:40:26 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:21405 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316615AbSGYWkA>;
	Thu, 25 Jul 2002 18:40:00 -0400
Message-ID: <3D407E62.8080707@us.ibm.com>
Date: Thu, 25 Jul 2002 15:40:34 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>, Andrew Morton <akpm@zip.com.au>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Andrea Arcangeli <andrea@suse.de>
Subject: [patch] Memory Binding API v0.2
Content-Type: multipart/mixed;
 boundary="------------020107060409050309080402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020107060409050309080402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is the latest version of the Mem Binding API.  It's a follow-up to the 
patch posted a week or so ago.  It incorporates some changes, and should be a 
bit more efficient, readable, and functional.  Bigger, better, faster, eh?  It 
needs to be patched on top of the Simple binding API that I posted a minute ago..

This API as well as the Simple Binding were both originally part of a NUMA 
Binding API discussed at length on LSE-Tech, and met with approval there.  I 
hope that these can be included in the mainline.

Cheers!

-Matt

--------------020107060409050309080402
Content-Type: text/plain;
 name="mem_api-v0.2-2.5.28.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mem_api-v0.2-2.5.28.patch"

diff -Nur linux-2.5.27-vanilla/arch/i386/config.in linux-2.5.27-api/arch/i386/config.in
--- linux-2.5.27-vanilla/arch/i386/config.in	Wed Jul 24 17:33:41 2002
+++ linux-2.5.27-api/arch/i386/config.in	Wed Jul 24 17:38:34 2002
@@ -168,6 +168,8 @@
    bool 'Multiquad NUMA system' CONFIG_X86_NUMAQ
    if [ "$CONFIG_X86_NUMAQ" = y ]; then
       define_bool CONFIG_MULTIQUAD y
+      bool 'Memory Binding API Support' CONFIG_MEMBIND
+      bool 'NUMA Memory Allocation Support' CONFIG_NUMA
    fi
 fi
 
diff -Nur linux-2.5.27-vanilla/arch/i386/kernel/entry.S linux-2.5.27-api/arch/i386/kernel/entry.S
--- linux-2.5.27-vanilla/arch/i386/kernel/entry.S	Wed Jul 24 17:33:41 2002
+++ linux-2.5.27-api/arch/i386/kernel/entry.S	Wed Jul 24 17:38:34 2002
@@ -754,6 +754,8 @@
 	.long sys_sched_setaffinity
 	.long sys_sched_getaffinity
 	.long sys_check_topology
+	.long sys_mem_setbinding
+	.long sys_mem_getbinding
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -Nur linux-2.5.27-vanilla/include/asm-i386/unistd.h linux-2.5.27-api/include/asm-i386/unistd.h
--- linux-2.5.27-vanilla/include/asm-i386/unistd.h	Wed Jul 24 17:33:41 2002
+++ linux-2.5.27-api/include/asm-i386/unistd.h	Wed Jul 24 17:38:34 2002
@@ -248,6 +248,8 @@
 #define __NR_sched_setaffinity	241
 #define __NR_sched_getaffinity	242
 #define __NR_check_topology	243
+#define __NR_mem_setbinding	244
+#define __NR_mem_getbinding	245
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -Nur linux-2.5.27-vanilla/include/linux/init_task.h linux-2.5.27-api/include/linux/init_task.h
--- linux-2.5.27-vanilla/include/linux/init_task.h	Sat Jul 20 12:11:07 2002
+++ linux-2.5.27-api/include/linux/init_task.h	Wed Jul 24 17:38:34 2002
@@ -59,6 +59,11 @@
     children:		LIST_HEAD_INIT(tsk.children),			\
     sibling:		LIST_HEAD_INIT(tsk.sibling),			\
     thread_group:	LIST_HEAD_INIT(tsk.thread_group),		\
+    memblk_binding:	{						\
+	bitmask:	MEMBLK_NO_BINDING,				\
+	behavior:	MPOL_STRICT,					\
+	lock:		SPIN_LOCK_UNLOCKED				\
+    },									\
     wait_chldexit:	__WAIT_QUEUE_HEAD_INITIALIZER(tsk.wait_chldexit),\
     real_timer:		{						\
 	function:		it_real_fn				\
diff -Nur linux-2.5.27-vanilla/include/linux/membind.h linux-2.5.27-api/include/linux/membind.h
--- linux-2.5.27-vanilla/include/linux/membind.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.27-api/include/linux/membind.h	Wed Jul 24 17:38:34 2002
@@ -0,0 +1,51 @@
+/*
+ * linux/include/linux/membind.h
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
+#ifndef _LINUX_MEMBIND_H
+#define _LINUX_MEMBIND_H
+
+#include <linux/types.h>
+
+#define MEMBLK_NO_BINDING	(~0UL)
+
+typedef struct memblk_list {
+	unsigned long bitmask;
+	int behavior;
+	spinlock_t lock;
+} memblk_list_t;
+
+
+#define is_valid_memblk_behavior(x) (1) /* for now */
+#define is_memblk_subset(x, y) (!(~(x) & (y)))  /* test whether x is a subset of y */
+
+#define MPOL_STRICT	0   /* Memory MUST be allocated according to binding */
+#define MPOL_LOOSE	1   /* Memory will be allocated according to binding, but
+				can fall back to other memory blocks if necessary. */
+#define MPOL_FIRST	2   /* UNUSED FOR NOW */
+#define MPOL_STRIPE	4   /* UNUSED FOR NOW */
+#define MPOL_RR		8   /* UNUSED FOR NOW */
+
+#endif /* _LINUX_MEMBIND_H */
diff -Nur linux-2.5.27-vanilla/include/linux/mmzone.h linux-2.5.27-api/include/linux/mmzone.h
--- linux-2.5.27-vanilla/include/linux/mmzone.h	Wed Jul 24 17:33:41 2002
+++ linux-2.5.27-api/include/linux/mmzone.h	Wed Jul 24 17:38:34 2002
@@ -138,6 +138,7 @@
 	unsigned long node_start_mapnr;
 	unsigned long node_size;
 	int node_id;
+	int memblk_id; /* A unique ID for each memory block */
 	struct pglist_data *node_next;
 } pg_data_t;
 
diff -Nur linux-2.5.27-vanilla/include/linux/sched.h linux-2.5.27-api/include/linux/sched.h
--- linux-2.5.27-vanilla/include/linux/sched.h	Sat Jul 20 12:11:07 2002
+++ linux-2.5.27-api/include/linux/sched.h	Wed Jul 24 17:38:34 2002
@@ -27,6 +27,7 @@
 #include <linux/securebits.h>
 #include <linux/fs_struct.h>
 #include <linux/compiler.h>
+#include <linux/membind.h>
 
 struct exec_domain;
 
@@ -302,6 +303,9 @@
 	struct task_struct *pidhash_next;
 	struct task_struct **pidhash_pprev;
 
+	/* additional Memory Binding stuff */
+	memblk_list_t memblk_binding;
+	
 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
 
diff -Nur linux-2.5.27-vanilla/kernel/sys.c linux-2.5.27-api/kernel/sys.c
--- linux-2.5.27-vanilla/kernel/sys.c	Wed Jul 24 17:33:41 2002
+++ linux-2.5.27-api/kernel/sys.c	Wed Jul 24 17:38:34 2002
@@ -1263,6 +1263,57 @@
 	return (long)ret;
 }
     
+/*
+ * sys_mem_setbinding(): Sets up a new MemBlk Binding
+ */
+asmlinkage long sys_mem_setbinding(unsigned long memblks, int behavior)
+{
+	long ret;
+	unsigned long flags;
+	struct task_struct *curr = current;
+
+	ret = -ENODEV;
+	/* Make sure that at least one of the memblks in the new binding set is online. */
+	if (!(memblks & memblk_online_map))
+		goto out;
+
+	ret = -EINVAL;
+	/* Test to make sure the behavior argument is valid. */
+	if (!is_valid_memblk_behavior(behavior))
+		goto out;
+
+	ret = -EPERM;
+	spin_lock_irqsave(&curr->memblk_binding.lock, flags);
+	/* If the new binding expands upon the old binding, the caller
+	   must have CAP_SYS_NICE. */
+	if (is_memblk_subset(memblks, curr->memblk_binding.bitmask) ||
+	    capable(CAP_SYS_NICE)){
+		curr->memblk_binding.bitmask = memblks;
+		curr->memblk_binding.behavior = behavior;
+		ret = 0;
+	}
+	spin_unlock_irqrestore(&curr->memblk_binding.lock, flags);
+
+ out:
+	return ret;
+}
+
+/*
+ * sys_mem_getbinding(): Returns the current MemBlk Binding
+ */
+asmlinkage long sys_mem_getbinding(void)
+{
+	long flags;
+	unsigned long memblk_binding;
+	struct task_struct *curr = current;
+
+	spin_lock_irqsave(&curr->memblk_binding.lock, flags);
+	memblk_binding = curr->memblk_binding.bitmask;
+	spin_unlock_irqrestore(&curr->memblk_binding.lock, flags);
+
+	return memblk_binding;
+}
+
 asmlinkage long sys_prctl(int option, unsigned long arg2, unsigned long arg3,
 			  unsigned long arg4, unsigned long arg5)
 {
diff -Nur linux-2.5.27-vanilla/mm/numa.c linux-2.5.27-api/mm/numa.c
--- linux-2.5.27-vanilla/mm/numa.c	Sat Jul 20 12:11:12 2002
+++ linux-2.5.27-api/mm/numa.c	Wed Jul 24 17:38:34 2002
@@ -8,6 +8,7 @@
 #include <linux/bootmem.h>
 #include <linux/mmzone.h>
 #include <linux/spinlock.h>
+#include <linux/membind.h>
 
 int numnodes = 1;	/* Initialized for UMA platforms */
 
@@ -27,6 +28,9 @@
 {
 	free_area_init_core(0, &contig_page_data, &mem_map, zones_size, 
 				zone_start_paddr, zholes_size, pmap);
+	contig_page_data.node_id = 0;
+	contig_page_data.memblk_id = 0;
+	memblk_online_map = 1UL;
 }
 
 #endif /* !CONFIG_DISCONTIGMEM */
@@ -71,6 +75,11 @@
 	free_area_init_core(nid, pgdat, &discard, zones_size, zone_start_paddr,
 					zholes_size, pmap);
 	pgdat->node_id = nid;
+	pgdat->memblk_id = num_online_memblks();
+	if (test_and_set_bit(num_online_memblks() + 1, &memblk_online_map)){
+		printk("memblk alread counted?!?!\n");
+		BUG();
+	}
 
 	/*
 	 * Get space for the valid bitmap.
@@ -88,6 +97,8 @@
 	return __alloc_pages(gfp_mask, order, pgdat->node_zonelists + (gfp_mask & GFP_ZONEMASK));
 }
 
+#ifdef CONFIG_NUMA
+
 /*
  * This can be refined. Currently, tries to do round robin, instead
  * should do concentratic circle search, starting from current node.
@@ -96,23 +107,67 @@
 {
 	struct page *ret = 0;
 	pg_data_t *start, *temp;
-#ifndef CONFIG_NUMA
+	int search_twice = 0;
+	unsigned long memblk_mask;
+	struct task_struct *curr = current;
 	unsigned long flags;
-	static pg_data_t *next = 0;
-#endif
 
 	if (order >= MAX_ORDER)
 		return NULL;
-#ifdef CONFIG_NUMA
+
+	spin_lock_irqsave(&curr->memblk_binding.lock, flags);
+	memblk_mask = curr->memblk_binding.bitmask;
+	/* if it is a loose binding, remember to search other memblks */
+	if ((curr->memblk_binding.behavior == MPOL_LOOSE) &&
+	    (curr->memblk_binding.bitmask != MEMBLK_NO_BINDING))
+		 search_twice = 1;
+	spin_unlock_irqrestore(&curr->memblk_binding.lock, flags);
+
+search_through_memblks: 
 	temp = NODE_DATA(numa_node_id());
-#else
-	spin_lock_irqsave(&node_lock, flags);
+	start = temp;
+	while (temp) {
+		if (memblk_mask & (1 << temp->memblk_id))
+			if ((ret = alloc_pages_pgdat(temp, gfp_mask, order)))
+				return(ret);
+		temp = temp->node_next;
+	}
+	temp = pgdat_list;
+	while (temp != start) {
+		if (!(memblk_mask & (1 << temp->memblk_id)))
+			if ((ret = alloc_pages_pgdat(temp, gfp_mask, order)))
+				return(ret);
+		temp = temp->node_next;
+	}
+
+	if (search_twice) {
+		/* 
+		 * If we failed to find a "preferred" memblk, try again 
+		 * looking for anything we haven't checked yet.
+		 */
+		search_twice = 0; /* no infinite loops, please */
+		memblk_mask = ~memblk_mask;
+		goto search_through_memblks;
+	}
+	return(0);
+}
+
+#else /* !CONFIG_NUMA */
+
+struct page * _alloc_pages(unsigned int gfp_mask, unsigned int order)
+{
+	struct page *ret = 0;
+	pg_data_t *start, *temp;
+	static pg_data_t *next = 0;
+	unsigned long flags;
+
+	if (order >= MAX_ORDER)
+		return NULL;
+
 	if (!next) next = pgdat_list;
-	temp = next;
+	temp = start = next;
 	next = next->node_next;
-	spin_unlock_irqrestore(&node_lock, flags);
-#endif
-	start = temp;
+
 	while (temp) {
 		if ((ret = alloc_pages_pgdat(temp, gfp_mask, order)))
 			return(ret);
@@ -127,4 +182,6 @@
 	return(0);
 }
 
+#endif /* CONFIG_NUMA */
+
 #endif /* CONFIG_DISCONTIGMEM */
diff -Nur linux-2.5.27-vanilla/mm/page_alloc.c linux-2.5.27-api/mm/page_alloc.c
--- linux-2.5.27-vanilla/mm/page_alloc.c	Sat Jul 20 12:11:07 2002
+++ linux-2.5.27-api/mm/page_alloc.c	Wed Jul 24 17:38:34 2002
@@ -42,6 +42,8 @@
 static int zone_balance_min[MAX_NR_ZONES] __initdata = { 20 , 20, 20, };
 static int zone_balance_max[MAX_NR_ZONES] __initdata = { 255 , 255, 255, };
 
+extern unsigned long memblk_online_map;
+
 /*
  * Temporary debugging check for pages not lying within a given zone.
  */
@@ -927,6 +929,9 @@
 void __init free_area_init(unsigned long *zones_size)
 {
 	free_area_init_core(0, &contig_page_data, &mem_map, zones_size, 0, 0, 0);
+	contig_page_data.node_id = 0;
+	contig_page_data.memblk_id = 0;
+	memblk_online_map = 1UL;
 }
 
 static int __init setup_mem_frac(char *str)

--------------020107060409050309080402--

