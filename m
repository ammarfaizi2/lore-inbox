Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbSJJBKG>; Wed, 9 Oct 2002 21:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263143AbSJJBKG>; Wed, 9 Oct 2002 21:10:06 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:12275 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263105AbSJJBJ4>;
	Wed, 9 Oct 2002 21:09:56 -0400
Message-ID: <3DA4D3E4.6080401@us.ibm.com>
Date: Wed, 09 Oct 2002 18:12:04 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       LSE <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@zip.com.au>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: [rfc][patch] Memory Binding API v0.3 2.5.41
Content-Type: multipart/mixed;
 boundary="------------050108020400070205010908"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050108020400070205010908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Greetings & Salutations,
	Here's a wonderful patch that I know you're all dying for...  Memory 
Binding!  It works just like CPU Affinity (binding) except that it binds 
a processes memory allocations (just buddy allocator for now) to 
specific memory blocks.
	I've sent this out in the past, but haven't touched it in months.  Since 
the feature freeze is rapidly approaching, I want to get this out there 
again and see if anyone has any interest in it.
	It's a fairly large patch, mostly because it includes a few odds and ends 
that are topology related, and don't strictly belong in this patch, but 
are pre-requisites for it (ie: the [memblk|node]_online_map stuff, and 
some of the cleanups to page_alloc).  I'll probably try and break it up 
into more discrete parts very soon.

[mcd@arrakis src]$ diffstat 
~/patches/api_patches/mem_api/memory_binding_api-v0.3-2.5.41.patch
  arch/i386/kernel/entry.S   |    2 +
  arch/i386/kernel/numaq.c   |    4 ++
  arch/i386/kernel/smpboot.c |    4 ++
  include/asm-i386/smp.h     |   16 ++++++++
  include/asm-i386/unistd.h  |    2 +
  include/linux/init_task.h  |    4 ++
  include/linux/membind.h    |   50 +++++++++++++++++++++++++
  include/linux/mmzone.h     |   23 +++++++++++
  include/linux/sched.h      |    4 ++
  include/linux/smp.h        |    8 +++-
  kernel/sys.c               |   90 
+++++++++++++++++++++++++++++++++++++++++++++
  mm/numa.c                  |    8 ++++
  mm/page_alloc.c            |   67 ++++++++++++---------------------
  13 files changed, 237 insertions(+), 45 deletions(-)

Questions, comments, flames, and indifferent shrugs are all welcome.

btw, It applies (mostly) cleanly to mm1 as well.  The mm/page_alloc.c 
changes fail, but if anyone is interested, they'll clean up easily, and 
I'll send you a patch.

Cheers!

-Matt

--------------050108020400070205010908
Content-Type: text/plain;
 name="memory_binding_api-v0.3-2.5.41.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="memory_binding_api-v0.3-2.5.41.patch"

diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.41-vanilla/arch/i386/kernel/entry.S linux-2.5.41-memory_binding_api/arch/i386/kernel/entry.S
--- linux-2.5.41-vanilla/arch/i386/kernel/entry.S	Mon Oct  7 11:23:58 2002
+++ linux-2.5.41-memory_binding_api/arch/i386/kernel/entry.S	Wed Oct  9 17:54:31 2002
@@ -736,6 +736,8 @@
 	.long sys_alloc_hugepages /* 250 */
 	.long sys_free_hugepages
 	.long sys_exit_group
+	.long sys_mem_setbinding
+	.long sys_mem_getbinding
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.41-vanilla/arch/i386/kernel/numaq.c linux-2.5.41-memory_binding_api/arch/i386/kernel/numaq.c
--- linux-2.5.41-vanilla/arch/i386/kernel/numaq.c	Mon Oct  7 11:23:33 2002
+++ linux-2.5.41-memory_binding_api/arch/i386/kernel/numaq.c	Wed Oct  9 17:54:16 2002
@@ -52,6 +52,10 @@
 	numnodes = 0;
 	for(node = 0; node < MAX_NUMNODES; node++) {
 		if(scd->quads_present31_0 & (1 << node)) {
+			if (test_and_set_bit(numnodes, &node_online_map)){
+				printk("smp_dump_qct: node alread counted?!?!\n");
+				BUG();
+			}
 			numnodes++;
 			eq = &scd->eq[node];
 			/* Convert to pages */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.41-vanilla/arch/i386/kernel/smpboot.c linux-2.5.41-memory_binding_api/arch/i386/kernel/smpboot.c
--- linux-2.5.41-vanilla/arch/i386/kernel/smpboot.c	Mon Oct  7 11:24:14 2002
+++ linux-2.5.41-memory_binding_api/arch/i386/kernel/smpboot.c	Wed Oct  9 17:54:16 2002
@@ -61,6 +61,10 @@
 
 /* Bitmask of currently online CPUs */
 unsigned long cpu_online_map;
+/* Bitmask of currently online memory blocks */
+unsigned long memblk_online_map = 0UL;
+/* Bitmask of currently online nodes */
+unsigned long node_online_map = 0UL;
 
 static volatile unsigned long cpu_callin_map;
 volatile unsigned long cpu_callout_map;
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.41-vanilla/include/asm-i386/smp.h linux-2.5.41-memory_binding_api/include/asm-i386/smp.h
--- linux-2.5.41-vanilla/include/asm-i386/smp.h	Mon Oct  7 11:23:22 2002
+++ linux-2.5.41-memory_binding_api/include/asm-i386/smp.h	Wed Oct  9 17:54:16 2002
@@ -54,6 +54,8 @@
 extern void smp_alloc_memory(void);
 extern unsigned long phys_cpu_present_map;
 extern unsigned long cpu_online_map;
+extern unsigned long memblk_online_map;
+extern unsigned long node_online_map;
 extern volatile unsigned long smp_invalidate_needed;
 extern int pic_mode;
 extern int smp_num_siblings;
@@ -102,6 +104,20 @@
 	return -1;
 }
 
+#define memblk_online(memblk) (memblk_online_map & (1<<(memblk)))
+ 
+extern inline unsigned int num_online_memblks(void)
+{
+	return hweight32(memblk_online_map);
+}
+
+#define node_online(node) (node_online_map & (1<<(node)))
+ 
+extern inline unsigned int num_online_nodes(void)
+{
+	return hweight32(node_online_map);
+}
+
 static __inline int hard_smp_processor_id(void)
 {
 	/* we don't want to mark this access volatile - bad code generation */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.41-vanilla/include/asm-i386/unistd.h linux-2.5.41-memory_binding_api/include/asm-i386/unistd.h
--- linux-2.5.41-vanilla/include/asm-i386/unistd.h	Mon Oct  7 11:24:44 2002
+++ linux-2.5.41-memory_binding_api/include/asm-i386/unistd.h	Wed Oct  9 17:54:31 2002
@@ -257,6 +257,8 @@
 #define __NR_alloc_hugepages	250
 #define __NR_free_hugepages	251
 #define __NR_exit_group		252
+#define __NR_mem_setbinding	253
+#define __NR_mem_getbinding	254
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.41-vanilla/include/linux/init_task.h linux-2.5.41-memory_binding_api/include/linux/init_task.h
--- linux-2.5.41-vanilla/include/linux/init_task.h	Mon Oct  7 11:23:25 2002
+++ linux-2.5.41-memory_binding_api/include/linux/init_task.h	Wed Oct  9 17:54:08 2002
@@ -76,6 +76,10 @@
 	.children	= LIST_HEAD_INIT(tsk.children),			\
 	.sibling	= LIST_HEAD_INIT(tsk.sibling),			\
 	.group_leader	= &tsk,						\
+	.memblk_binding		= {					\
+		.bitmask	= MEMBLK_NO_BINDING,			\
+		.behavior	= MPOL_STRICT,				\
+	},								\
 	.wait_chldexit	= __WAIT_QUEUE_HEAD_INITIALIZER(tsk.wait_chldexit),\
 	.real_timer	= {						\
 		.function	= it_real_fn				\
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.41-vanilla/include/linux/membind.h linux-2.5.41-memory_binding_api/include/linux/membind.h
--- linux-2.5.41-vanilla/include/linux/membind.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.41-memory_binding_api/include/linux/membind.h	Wed Oct  9 17:54:08 2002
@@ -0,0 +1,50 @@
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
+} memblk_list_t;
+
+
+#define is_valid_memblk_behavior(x) (1) 	/* for now */
+#define is_memblk_subset(x, y) (!(~(x) & (y)))	/* test whether x is a subset of y */
+
+#define MPOL_STRICT	0   /* Memory MUST be allocated according to binding */
+#define MPOL_LOOSE	1   /* Memory will be allocated according to binding, but
+				can fall back to other memory blocks if necessary. */
+#define MPOL_FIRST	2   /* UNUSED FOR NOW */
+#define MPOL_STRIPE	4   /* UNUSED FOR NOW */
+#define MPOL_RR		8   /* UNUSED FOR NOW */
+
+#endif /* _LINUX_MEMBIND_H */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.41-vanilla/include/linux/mmzone.h linux-2.5.41-memory_binding_api/include/linux/mmzone.h
--- linux-2.5.41-vanilla/include/linux/mmzone.h	Mon Oct  7 11:22:55 2002
+++ linux-2.5.41-memory_binding_api/include/linux/mmzone.h	Wed Oct  9 17:54:25 2002
@@ -167,8 +167,9 @@
 	unsigned long node_start_pfn;
 	unsigned long node_size;
 	int node_id;
+	int memblk_id; /* A unique ID for each memory block */
 	struct pglist_data *pgdat_next;
-	wait_queue_head_t       kswapd_wait;
+	wait_queue_head_t kswapd_wait;
 } pg_data_t;
 
 extern int numnodes;
@@ -249,6 +250,26 @@
 #define for_each_zone(zone) \
 	for (zone = pgdat_list->node_zones; zone; zone = next_zone(zone))
 
+/**
+ * for_each_valid_zone - helper macro to iterate over all memory zones 
+ * 	in a zonelist
+ * @zone - pointer to struct zone variable
+ * @zonelist - pointer to struct zonelist variable
+ *
+ * for_each_valid_zone() is basically an easier to read version of this 
+ * piece of code:
+ *
+ * for (i = 0; zonelist->zones[i] != NULL; i++) {
+ * 	struct zone *z = zonelist->zones[i];
+ * 	...
+ * 	}
+ *
+ * Useful for several loops in __alloc_pages.
+ */
+#define for_each_valid_zone(zone, zonelist) 		\
+	for (zone = *zonelist->zones; zone; zone++)	\
+		if (current->memblk_binding.bitmask & (1 << zone->zone_pgdat->memblk_id))
+
 #ifdef CONFIG_NUMA
 #define MAX_NR_MEMBLKS	BITS_PER_LONG /* Max number of Memory Blocks */
 #else /* !CONFIG_NUMA */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.41-vanilla/include/linux/sched.h linux-2.5.41-memory_binding_api/include/linux/sched.h
--- linux-2.5.41-vanilla/include/linux/sched.h	Mon Oct  7 11:23:25 2002
+++ linux-2.5.41-memory_binding_api/include/linux/sched.h	Wed Oct  9 17:54:08 2002
@@ -29,6 +29,7 @@
 #include <linux/compiler.h>
 #include <linux/completion.h>
 #include <linux/pid.h>
+#include <linux/membind.h>
 
 struct exec_domain;
 
@@ -335,6 +336,9 @@
 	/* PID/PID hash table linkage. */
 	struct pid_link pids[PIDTYPE_MAX];
 
+	/* additional Memory Binding stuff */
+	memblk_list_t memblk_binding;
+	
 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
 	int *user_tid;				/* for CLONE_CLEARTID */
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.41-vanilla/include/linux/smp.h linux-2.5.41-memory_binding_api/include/linux/smp.h
--- linux-2.5.41-vanilla/include/linux/smp.h	Mon Oct  7 11:24:39 2002
+++ linux-2.5.41-memory_binding_api/include/linux/smp.h	Wed Oct  9 17:54:16 2002
@@ -94,7 +94,13 @@
 #define cpu_online(cpu)				({ BUG_ON((cpu) != 0); 1; })
 #define num_online_cpus()			1
 #define num_booting_cpus()			1
-#define cpu_possible(cpu)				({ BUG_ON((cpu) != 0); 1; })
+#define cpu_possible(cpu)			({ BUG_ON((cpu) != 0); 1; })
+#define memblk_online_map			1
+#define memblk_online(memblk)			({ BUG_ON((memblk) != 0); 1; })
+#define num_online_memblks()			1
+#define node_online_map				1
+#define node_online(node)			({ BUG_ON((node) != 0); 1; })
+#define num_online_nodes()			1
 
 struct notifier_block;
 
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.41-vanilla/kernel/sys.c linux-2.5.41-memory_binding_api/kernel/sys.c
--- linux-2.5.41-vanilla/kernel/sys.c	Mon Oct  7 11:23:25 2002
+++ linux-2.5.41-memory_binding_api/kernel/sys.c	Wed Oct  9 17:54:31 2002
@@ -1303,6 +1303,96 @@
 	return mask;
 }
     
+/**
+ * sys_mem_setbinding - set the memory binding of a process
+ * @pid: pid of the process
+ * @memblks: new bitmask of memory blocks
+ * @behavior: new behavior
+ */
+asmlinkage long sys_mem_setbinding(pid_t pid, unsigned long memblks, 
+				    unsigned int behavior)
+{
+	long ret;
+	struct task_struct *p;
+
+	/*
+	 * Make sure that at least one of the memblks in the 
+	 * new mask is online.
+	 */
+	memblks &= memblk_online_map;
+	if (!memblks)
+		return -EINVAL;
+
+	/* 
+	 * Test to make sure the behavior argument is valid.
+	 */
+	if (!is_valid_memblk_behavior(behavior))
+		return -EINVAL;
+
+	read_lock(&tasklist_lock);
+
+	p = find_process_by_pid(pid);
+	if (!p) {
+		read_unlock(&tasklist_lock);
+		return -ESRCH;
+	}
+
+	get_task_struct(p);
+	read_unlock(&tasklist_lock);
+
+	/*
+	 * The caller must either own the process or have CAP_SYS_NICE.
+	 */
+	ret = -EPERM;
+	if ((current->euid != p->euid) && (current->euid != p->uid) &&
+	     !capable(CAP_SYS_NICE))
+		goto out_unlock;
+
+	ret = 0;
+	current->memblk_binding.bitmask = memblks;
+	current->memblk_binding.behavior = behavior;
+
+out_unlock:
+	put_task_struct(p);
+	return ret;
+}
+
+/**
+ * sys_mem_getbinding - get the memory binding of a process
+ * @pid: pid of the process
+ * @user_bitmask: bitmask of memory blocks
+ * @user_behavior: behavior
+ */
+asmlinkage long sys_mem_getbinding(pid_t pid, unsigned long *user_bitmask, 
+				    unsigned int *user_behavior)
+{
+	long ret;
+	unsigned long bitmask;
+	unsigned int behavior;
+	struct task_struct *p;
+
+	read_lock(&tasklist_lock);
+
+	ret = -ESRCH;
+	p = find_process_by_pid(pid);
+	if (!p)
+		goto out_unlock;
+
+	ret = 0;
+	bitmask = p->memblk_binding.bitmask;
+	behavior = p->memblk_binding.behavior;
+
+out_unlock:
+	read_unlock(&tasklist_lock);
+	if (ret)
+		return ret;
+	if (copy_to_user(user_bitmask, &bitmask, sizeof(unsigned long)))
+		return -EFAULT;
+	if (copy_to_user(user_behavior, &behavior, sizeof(unsigned int)))
+		return -EFAULT;
+	return ret;
+}
+
 asmlinkage long sys_prctl(int option, unsigned long arg2, unsigned long arg3,
 			  unsigned long arg4, unsigned long arg5)
 {
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.41-vanilla/mm/numa.c linux-2.5.41-memory_binding_api/mm/numa.c
--- linux-2.5.41-vanilla/mm/numa.c	Mon Oct  7 11:24:50 2002
+++ linux-2.5.41-memory_binding_api/mm/numa.c	Wed Oct  9 17:54:16 2002
@@ -8,6 +8,7 @@
 #include <linux/bootmem.h>
 #include <linux/mmzone.h>
 #include <linux/spinlock.h>
+#include <linux/membind.h>
 
 int numnodes = 1;	/* Initialized for UMA platforms */
 
@@ -29,6 +30,7 @@
 
 	pgdat = &contig_page_data;
 	contig_page_data.node_id = 0;
+	contig_page_data.memblk_id = 0;
 	contig_page_data.node_start_pfn = node_start_pfn;
 	calculate_totalpages (&contig_page_data, zones_size, zholes_size);
 	if (pmap == (struct page *)0) {
@@ -37,6 +39,7 @@
 	}
 	contig_page_data.node_mem_map = pmap;
 	free_area_init_core(&contig_page_data, zones_size, zholes_size);
+	memblk_online_map = 1UL;
 	mem_map = contig_page_data.node_mem_map;
 }
 
@@ -66,6 +69,7 @@
 	unsigned long size;
 
 	pgdat->node_id = nid;
+	pgdat->memblk_id = __node_to_memblk(nid);
 	pgdat->node_start_pfn = node_start_pfn;
 	calculate_totalpages (pgdat, zones_size, zholes_size);
 	if (pmap == (struct page *)0) {
@@ -74,6 +78,10 @@
 	}
 	pgdat->node_mem_map = pmap;
 	free_area_init_core(pgdat, zones_size, zholes_size);
+	if (test_and_set_bit(num_online_memblks(), &memblk_online_map)){
+		printk("free_area_init_core: memblk alread counted?!?!\n");
+		BUG();
+	}
 
 	/*
 	 * Get space for the valid bitmap.
diff -Nur --exclude-from=/usr/src/.dontdiff linux-2.5.41-vanilla/mm/page_alloc.c linux-2.5.41-memory_binding_api/mm/page_alloc.c
--- linux-2.5.41-vanilla/mm/page_alloc.c	Mon Oct  7 11:23:24 2002
+++ linux-2.5.41-memory_binding_api/mm/page_alloc.c	Wed Oct  9 17:54:25 2002
@@ -318,57 +318,46 @@
 		struct zonelist *zonelist)
 {
 	unsigned long min;
-	struct zone **zones, *classzone;
+	struct zone *classzone, *zone;
 	struct page * page;
-	int freed, i;
+	int freed;
 
 	if (gfp_mask & __GFP_WAIT)
 		might_sleep();
 
-	mod_page_state(pgalloc, 1<<order);
+	mod_page_state(pgalloc, 1UL << order);
 
-	zones = zonelist->zones;  /* the list of zones suitable for gfp_mask */
-	classzone = zones[0]; 
+	classzone = zonelist->zones[0]; 
 	if (classzone == NULL)    /* no zones in the zonelist */
 		return NULL;
 
 	/* Go through the zonelist once, looking for a zone with enough free */
 	min = 1UL << order;
-	for (i = 0; zones[i] != NULL; i++) {
-		struct zone *z = zones[i];
-
+	for_each_valid_zone(zone, zonelist) {
 		/* the incremental min is allegedly to discourage fallback */
-		min += z->pages_low;
-		if (z->free_pages > min || z->free_pages >= z->pages_high) {
-			page = rmqueue(z, order);
-			if (page)
+		min += zone->pages_low;
+		if (zone->free_pages > min || zone->free_pages >= zone->pages_high)
+			if (page = rmqueue(zone, order))
 				return page;
-		}
 	}
 
 	/* we're somewhat low on memory, failed to find what we needed */
-	for (i = 0; zones[i] != NULL; i++) {
-		struct zone *z = zones[i];
-		if (z->free_pages <= z->pages_low &&
-		    waitqueue_active(&z->zone_pgdat->kswapd_wait))
-			wake_up_interruptible(&z->zone_pgdat->kswapd_wait);
+	for_each_valid_zone(zone, zonelist) {
+		if (zone->free_pages <= zone->pages_low &&
+		    waitqueue_active(&zone->zone_pgdat->kswapd_wait))
+			wake_up_interruptible(&zone->zone_pgdat->kswapd_wait);
 	}
 
 	/* Go through the zonelist again, taking __GFP_HIGH into account */
 	min = 1UL << order;
-	for (i = 0; zones[i] != NULL; i++) {
-		unsigned long local_min;
-		struct zone *z = zones[i];
-
-		local_min = z->pages_min;
+	for_each_valid_zone(zone, zonelist) {
 		if (gfp_mask & __GFP_HIGH)
-			local_min >>= 2;
-		min += local_min;
-		if (z->free_pages > min || z->free_pages >= z->pages_high) {
-			page = rmqueue(z, order);
-			if (page)
+			min += zone->pages_min >> 2;
+		else
+			min += zone->pages_min;
+		if (zone->free_pages > min || zone->free_pages >= zone->pages_high)
+			if (page = rmqueue(zone, order))
 				return page;
-		}
 	}
 
 	/* here we're in the low on memory slow path */
@@ -376,13 +365,9 @@
 rebalance:
 	if (current->flags & (PF_MEMALLOC | PF_MEMDIE)) {
 		/* go through the zonelist yet again, ignoring mins */
-		for (i = 0; zones[i] != NULL; i++) {
-			struct zone *z = zones[i];
-
-			page = rmqueue(z, order);
-			if (page)
+		for_each_valid_zone(zone, zonelist)
+			if (page = rmqueue(zone, order))
 				return page;
-		}
 nopage:
 		if (!(current->flags & PF_NOWARN)) {
 			printk("%s: page allocation failure."
@@ -403,15 +388,11 @@
 
 	/* go through the zonelist yet one more time */
 	min = 1UL << order;
-	for (i = 0; zones[i] != NULL; i++) {
-		struct zone *z = zones[i];
-
-		min += z->pages_min;
-		if (z->free_pages > min || z->free_pages >= z->pages_high) {
-			page = rmqueue(z, order);
-			if (page)
+	for_each_valid_zone(zone, zonelist) {
+		min += zone->pages_min;
+		if (zone->free_pages > min || zone->free_pages >= zone->pages_high)
+			if (page = rmqueue(zone, order))
 				return page;
-		}
 	}
 
 	/* Don't let big-order allocations loop */

--------------050108020400070205010908--

