Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSEBWx4>; Thu, 2 May 2002 18:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315457AbSEBWxz>; Thu, 2 May 2002 18:53:55 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:60352 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315454AbSEBWwr>; Thu, 2 May 2002 18:52:47 -0400
Message-ID: <3CD1C29A.5AEF7BC9@us.ibm.com>
Date: Thu, 02 May 2002 15:50:02 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
CC: mjbligh@us.ibm.com, lse-tech@lists.sourceforge.net, rml@tech9.net,
        efocht@ess.nec.de
Subject: [patch] NUMA API for 2.5.12 (2/4)
Content-Type: multipart/mixed;
 boundary="------------E7BE2DE7D514C5CA1AA3737C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E7BE2DE7D514C5CA1AA3737C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ok all,
	I'm going to go ahead and assume (hope) that the no response on the last
posting was because the patch was really large.  We'll try this again with 4
smaller patches and see what happens.

	This patch implements the NUMA API specified at:
http://lse.sourceforge.net/numa/numa_api.html for the 2.5.12 version of the
kernel.  The API implements such features as binding processes to CPUs
(similar to Robert Love's recent patch), binding to memory blocks, setting
launch policies for processes, and rudimentary topology features.  The patch
is currently used via a prctl() interface with a possible /proc interface in
the future.  I also have a syscall version if that is preferred.

	Again, this is a slightly cleaned-up, and (more) bite-sized version of the
previous patch sent out...

Enjoy, and please send me any comments on the patch, or the API it implements!

-Matt
colpatch@us.ibm.com
--------------E7BE2DE7D514C5CA1AA3737C
Content-Type: text/plain; charset=us-ascii;
 name="numa_api-arch_indep-impl-2.5.12.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="numa_api-arch_indep-impl-2.5.12.patch"

diff -Nur linux-2.5.8-vanilla/kernel/Makefile linux-2.5.8-api/kernel/Makefile
--- linux-2.5.8-vanilla/kernel/Makefile	Sun Apr 14 12:18:47 2002
+++ linux-2.5.8-api/kernel/Makefile	Mon Apr 22 15:35:16 2002
@@ -15,7 +15,7 @@
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o numa.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -Nur linux-2.5.8-vanilla/kernel/fork.c linux-2.5.8-api/kernel/fork.c
--- linux-2.5.8-vanilla/kernel/fork.c	Sun Apr 14 12:18:45 2002
+++ linux-2.5.8-api/kernel/fork.c	Tue Apr 23 14:49:29 2002
@@ -707,6 +707,20 @@
 		spin_lock_init(&p->sigmask_lock);
 	}
 #endif
+	if (!null_restrict(&p->numa_launch_policy)){
+		p->numa_binding = p->numa_launch_policy;
+		p->cpus_allowed = p->numa_binding.cpus.list & p->numa_restrict.cpus.list;
+		if (!(p->cpus_allowed & cpu_online_map))
+			BUG();
+		if (p->cpus_allowed & (1UL << smp_processor_id()))
+			p->thread_info->cpu = smp_processor_id();
+		else
+			p->thread_info->cpu = __ffs(p->cpus_allowed & cpu_online_map);
+	} else
+		p->thread_info->cpu = smp_processor_id();
+	numa_set_init(&p->numa_launch_policy);
+	rwlock_init(&p->numa_api_lock);
+
 	p->array = NULL;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = jiffies;
diff -Nur linux-2.5.8-vanilla/kernel/numa.c linux-2.5.8-api/kernel/numa.c
--- linux-2.5.8-vanilla/kernel/numa.c	Wed Dec 31 16:00:00 1969
+++ linux-2.5.8-api/kernel/numa.c	Mon Apr 29 11:21:27 2002
@@ -0,0 +1,378 @@
+/*
+ * linux/kernel/numa.c
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
+#include <linux/numa.h>
+#include <linux/mmzone.h>
+#include <linux/errno.h>
+#include <linux/smp.h>
+
+
+#define is_valid_cpu_behavior(x)    (x == CPU_BIND_STRICT)
+#define is_valid_memblk_behavior(x) (((x & 0x7) == MPOL_STRICT) || ((x & 0x7) == MPOL_LOOSE))
+
+#define is_numa_subset(x, y) (!((x) & ~(y)))  /* test whether x is a subset of y */
+
+
+extern int nummemblks;
+extern unsigned long memblk_online_map;
+
+/*
+ * set_restricted_cpus(): Sets up a new CPU Restriction Set
+ */
+int set_restricted_cpus(numa_bitmap_t cpus, numa_set_t *numamap)
+{
+	int ret;
+	unsigned long flags;
+	numa_bitmap_t cpu_binding;
+
+	ret = -ENODEV;
+	/* Make sure that at least one of the cpus in the new restriction set is online. */
+	if (!(cpus & cpu_online_map))
+		goto out;
+
+	read_lock_irqsave(&current->numa_api_lock, flags);
+	cpu_binding = current->numa_binding.cpus.list;
+	/* If there is a binding, at least one of the bound cpus must be valid in the 
+	   new restriction set. */
+	if ((!null_restrict(&current->numa_binding)) &&
+	    (!(cpu_binding & cpus)))
+		goto out_unlock;
+
+	ret = -EPERM;
+	/* If the new restriction expands upon the old restriction, the caller must 
+	   have CAP_SYS_NICE. */
+	if ((!is_numa_subset(cpus, current->numa_restrict.cpus.list)) &&
+	    (!capable(CAP_SYS_NICE)))
+		goto out_unlock;
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	write_lock_irqsave(&current->numa_api_lock, flags);
+	current->numa_restrict.cpus.list = cpus;
+	write_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	/* Set cpus_allowed to the current binding masked against the new list of allowed cpus. */
+	set_cpus_allowed(current, cpu_binding & cpus);
+	ret = 0;
+	goto out;
+
+ out_unlock:
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+ out:
+	return ret;
+}
+
+/*
+ * set_restricted_memblks(): Sets up a new MemBlk Restriction Set
+ */
+int set_restricted_memblks(numa_bitmap_t memblks, numa_set_t *numamap)
+{
+	int ret;
+	unsigned long flags;
+
+	ret = -ENODEV;
+	/* Make sure that at least one of the memblks in the new restriction set is online. */
+	if (!(memblks & memblk_online_map))
+		goto out;
+
+	read_lock_irqsave(&current->numa_api_lock, flags);
+	/* If there is a binding, at least one of the bound memblks must be valid in the 
+	   new restriction set. */
+	if ((!null_restrict(&current->numa_binding)) &&
+	    (!(current->numa_binding.memblks.list & memblks)))
+		goto out_unlock;
+
+	ret = -EPERM;
+	/* If the new restriction expands upon the old restriction, the caller
+	   must have CAP_SYS_NICE. */
+	if ((!is_numa_subset(memblks, current->numa_restrict.memblks.list)) &&
+	    (!capable(CAP_SYS_NICE)))
+		goto out_unlock;
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	write_lock_irqsave(&current->numa_api_lock, flags);
+	current->numa_restrict.memblks.list = memblks;
+	write_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	ret = 0;
+	goto out;
+
+ out_unlock:
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+ out:
+	return ret;
+}
+
+/*
+ * get_restricted_cpus(): Returns the current CPU Restriction Set
+ */
+inline numa_bitmap_t get_restricted_cpus(void)
+{
+	unsigned long flags;
+	numa_bitmap_t cpu_restriction;
+
+	read_lock_irqsave(&current->numa_api_lock, flags);
+	cpu_restriction = current->numa_restrict.cpus.list;
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	return cpu_restriction;
+}
+
+/*
+ * get_restricted_memblks(): Returns the current MemBlk Restriction Set
+ */
+inline numa_bitmap_t get_restricted_memblks(void)
+{
+	unsigned long flags;
+	numa_bitmap_t memblk_restriction;
+
+	read_lock_irqsave(&current->numa_api_lock, flags);
+	memblk_restriction = current->numa_restrict.memblks.list;
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	return memblk_restriction;
+}
+
+/*
+ * cpu_to_node(cpu): Returns the number of the most specific Node 
+ * containing CPU 'cpu'.
+ */
+inline int cpu_to_node(int cpu)
+{
+	if (cpu == -1)     /* return highest numbered node */
+		return (numnodes - 1);
+
+	if ((cpu < 0) || (cpu >= NR_CPUS) ||
+	    (!(cpu_online_map & (1 << cpu))))   /* invalid cpu # */
+		return -ENODEV;
+
+	return _cpu_to_node(cpu_logical_map(cpu));
+}
+
+/*
+ * memblk_to_node(memblk): Returns the number of the most specific Node 
+ * containing Memory Block 'memblk'.
+ */
+inline int memblk_to_node(int memblk)
+{
+	if (memblk == -1)  /* return highest numbered node */
+		return (numnodes - 1);
+
+	if ((memblk < 0) || (memblk >= NR_MEMBLKS) ||
+	    (!(memblk_online_map & (1 << memblk))))   /* invalid memblk # */
+		return -ENODEV;
+
+	return _memblk_to_node(memblk);
+}
+
+/*
+ * node_to_node(nid): Returns the number of the of the most specific Node that
+ * encompasses Node 'nid'.  Some may call this the parent Node of 'nid'.
+ */
+int node_to_node(int nid)
+{
+	if ((nid < 0) || (nid >= numnodes))   /* invalid node # */
+		return -ENODEV;
+
+	return _node_to_node(nid);
+}
+
+/*
+ * node_to_cpu(nid): Returns the lowest numbered CPU on Node 'nid'
+ */
+inline int node_to_cpu(int nid)
+{
+	if (nid == -1)  /* return highest numbered cpu */
+		return (smp_num_cpus - 1);
+
+	if ((nid < 0) || (nid >= numnodes))   /* invalid node # */
+		return -ENODEV;
+
+	return _node_to_cpu(nid);
+}
+
+/*
+ * node_to_memblk(nid): Returns the lowest numbered MemBlk on Node 'nid'
+ */
+inline int node_to_memblk(int nid)
+{
+	if (nid == -1)  /* return highest numbered memblk */
+		return (nummemblks - 1);
+
+	if ((nid < 0) || (nid >= numnodes))   /* invalid node # */
+		return -ENODEV;
+
+	return _node_to_memblk(nid);
+}
+
+/*
+ * get_cpu(): Returns the currently executing CPU number.
+ * For now, this has only mild usefulness, as this information could
+ * change on the return from syscall (which automatically calls schedule()).
+ * Due to this, the data could be stale by the time it gets back to the user.
+ * It will have to do, until a better method is found.
+ */
+inline int get_cpu(void)
+{
+	return smp_processor_id();
+}
+
+/*
+ * get_node(): Returns the number of the Node containing 
+ * the currently executing CPU.  Subject to the same caveat
+ * as the get_cpu() call.
+ */
+inline int get_node(void)
+{
+	return cpu_to_node(get_cpu());
+}
+
+/*
+ * bind_to_cpu(): Sets up a new CPU Binding
+ */
+int bind_to_cpu(numa_bitmap_t cpus, int behavior)
+{
+	int ret;
+	unsigned long flags;
+	numa_bitmap_t cpu_restriction;
+
+	read_lock_irqsave(&current->numa_api_lock, flags);
+	ret = -ENODEV;
+	/* Make sure that at least one of the cpus in the new binding is online, AND
+	   in the current restriction set. */
+	if (!(cpus & cpu_online_map & current->numa_restrict.cpus.list))
+		goto out_unlock;
+	cpu_restriction = current->numa_restrict.cpus.list;
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	ret = -EINVAL;
+	/* Test to make sure the behavior argument is valid. */
+	if (!is_valid_cpu_behavior(behavior))
+		goto out;
+
+	write_lock_irqsave(&current->numa_api_lock, flags);
+	current->numa_binding.cpus.list = cpus;
+	current->numa_binding.cpus.behavior = behavior;
+	write_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	/* Set cpus_allowed to the new binding masked against the current list of allowed cpus. */
+	set_cpus_allowed(current, cpus & cpu_restriction);
+	ret = 0;
+	goto out;
+
+ out_unlock:
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+ out:
+	return ret;
+}
+
+/*
+ * bind_to_memblk(): Sets up a new MemBlk Binding
+ */
+int bind_to_memblk(numa_bitmap_t memblks, int behavior)
+{
+	int ret;
+	unsigned long flags;
+
+	read_lock_irqsave(&current->numa_api_lock, flags);
+	ret = -ENODEV;
+	/* Make sure that at least one of the memblks in the new binding is online, AND
+	   in the current restriction set. */
+	if (!(memblks & memblk_online_map & current->numa_restrict.memblks.list))
+		goto out_unlock;
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	ret = -EINVAL;
+	/* Test to make sure the behavior argument is valid. */
+	if (!is_valid_memblk_behavior(behavior))
+		goto out;
+
+	write_lock_irqsave(&current->numa_api_lock, flags);
+	current->numa_binding.memblks.list = memblks;
+	current->numa_binding.memblks.behavior = behavior;
+	write_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	ret = 0;
+	goto out;
+
+ out_unlock:
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+ out:
+	return ret;
+}
+
+/*
+ * bind_memory(): Will eventually set up a memory binding for a specific chunk of memory.
+ * Specifically, the chunk starting at 'start' through 'len' bytes.  As of now, it doesn't
+ * *quite* do that. ;)
+ */
+inline int bind_memory(unsigned long start, size_t len, numa_bitmap_t memblks, int behavior)
+{
+	return -ENOTSUPP;
+}
+
+/*
+ * set_launch_policy(): Sets up a new Launch Policy for current process
+ */
+int set_launch_policy(numa_bitmap_t cpus, int cpu_behavior, 
+		       numa_bitmap_t memblks, int memblk_behavior)
+{
+	int ret;
+	unsigned long flags;
+
+	read_lock_irqsave(&current->numa_api_lock, flags);
+	ret = -ENODEV;
+	/* Make sure that at least one of the cpus and one of the memblks in the new 
+	   binding are online, AND in the current restriction set. */
+	if ((!(cpus & cpu_online_map & current->numa_restrict.cpus.list)) ||
+	    (!(memblks & memblk_online_map & current->numa_restrict.memblks.list)))
+		goto out_unlock;
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	ret = -EINVAL;
+	/* Test to make sure the behavior arguments are valid. */
+	if ((!is_valid_cpu_behavior(cpu_behavior)) || 
+	    (!is_valid_memblk_behavior(memblk_behavior)))
+		goto out;
+
+	write_lock_irqsave(&current->numa_api_lock, flags);
+	current->numa_launch_policy.cpus.list = cpus;
+	current->numa_launch_policy.cpus.behavior = cpu_behavior;
+	current->numa_launch_policy.memblks.list = memblks;
+	current->numa_launch_policy.memblks.behavior = memblk_behavior;
+	write_unlock_irqrestore(&current->numa_api_lock, flags);
+
+	ret = 0;
+	goto out;
+
+ out_unlock:
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+ out:
+	return ret;
+}
diff -Nur linux-2.5.8-vanilla/mm/numa.c linux-2.5.8-api/mm/numa.c
--- linux-2.5.8-vanilla/mm/numa.c	Sun Apr 14 12:18:49 2002
+++ linux-2.5.8-api/mm/numa.c	Wed Apr 24 11:26:18 2002
@@ -8,8 +8,11 @@
 #include <linux/bootmem.h>
 #include <linux/mmzone.h>
 #include <linux/spinlock.h>
+#include <linux/numa.h>
 
 int numnodes = 1;	/* Initialized for UMA platforms */
+int nummemblks = 0;
+unsigned long memblk_online_map = 0UL;  /* Similar to cpu_online_map, but for memory blocks */
 
 static bootmem_data_t contig_bootmem_data;
 pg_data_t contig_page_data = { bdata: &contig_bootmem_data };
@@ -27,6 +30,10 @@
 {
 	free_area_init_core(0, &contig_page_data, &mem_map, zones_size, 
 				zone_start_paddr, zholes_size, pmap);
+	contig_page_data.node_id = 0;
+	contig_page_data.memblk_id = 0;
+	nummemblks = 1;
+	memblk_online_map = 1UL;
 }
 
 #endif /* !CONFIG_DISCONTIGMEM */
@@ -71,6 +78,11 @@
 	free_area_init_core(nid, pgdat, &discard, zones_size, zone_start_paddr,
 					zholes_size, pmap);
 	pgdat->node_id = nid;
+	pgdat->memblk_id = nummemblks;
+	if (test_and_set_bit(nummemblks++, &memblk_online_map)){
+		printk("memblk alread counted?!?!\n");
+		BUG();
+	}
 
 	/*
 	 * Get space for the valid bitmap.
@@ -88,6 +100,8 @@
 	return __alloc_pages(gfp_mask, order, pgdat->node_zonelists + (gfp_mask & GFP_ZONEMASK));
 }
 
+#ifdef CONFIG_NUMA
+
 /*
  * This can be refined. Currently, tries to do round robin, instead
  * should do concentratic circle search, starting from current node.
@@ -96,35 +110,84 @@
 {
 	struct page *ret = 0;
 	pg_data_t *start, *temp;
-#ifndef CONFIG_NUMA
+	int search_twice = 0;
+	numa_bitmap_t memblk_bitmask, memblk_bitmask2;
 	unsigned long flags;
-	static pg_data_t *next = 0;
-#endif
 
 	if (order >= MAX_ORDER)
 		return NULL;
-#ifdef CONFIG_NUMA
+
+	read_lock_irqsave(&current->numa_api_lock, flags);
+	if (null_restrict(&current->numa_binding))
+		/* if there is no binding, only search the restriction set */
+		memblk_bitmask = current->numa_restrict.memblks.list;
+	else {
+		/* if there is a binding, search it */
+		memblk_bitmask = current->numa_binding.memblks.list;
+		if (current->numa_binding.memblks.behavior == MPOL_LOOSE){
+			/* and if it is a loose binding, remember to search
+			   the restriction if we come up empty */
+                        search_twice = 1;
+			/* no need to search the memblks in the binding again,
+			   so we'll mask them out. */
+			memblk_bitmask2 = current->numa_restrict.memblks.list & ~memblk_bitmask;
+		}
+	}
+	read_unlock_irqrestore(&current->numa_api_lock, flags);
+
+search_through_memblks: 
 	temp = NODE_DATA(numa_node_id());
-#else
-	spin_lock_irqsave(&node_lock, flags);
-	if (!next) next = pgdat_list;
-	temp = next;
-	next = next->node_next;
-	spin_unlock_irqrestore(&node_lock, flags);
-#endif
 	start = temp;
 	while (temp) {
-		if ((ret = alloc_pages_pgdat(temp, gfp_mask, order)))
-			return(ret);
+		if (memblk_bitmask & (1 << temp->memblk_id))
+			if ((ret = alloc_pages_pgdat(temp, gfp_mask, order)))
+				return(ret);
 		temp = temp->node_next;
 	}
 	temp = pgdat_list;
 	while (temp != start) {
+		if (memblk_bitmask & (1 << temp->memblk_id))
+			if ((ret = alloc_pages_pgdat(temp, gfp_mask, order)))
+				return(ret);
+		temp = temp->node_next;
+	}
+
+	if (search_twice) {
+		/* 
+		 * If we failed to find a "preferred" memblk, try again 
+		 * looking for anything that's allowed (in restrict), but
+		 * skip those memblks we've already looked at
+		 */
+		search_twice = 0; /* no infinite loops, please */
+		memblk_bitmask = memblk_bitmask2;
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
+	pg_data_t *temp;
+	unsigned long flags;
+
+	if (order >= MAX_ORDER)
+		return NULL;
+
+	spin_lock_irqsave(&node_lock, flags);
+	temp = pgdat_list;
+	spin_unlock_irqrestore(&node_lock, flags);
+
+	while (temp) {
 		if ((ret = alloc_pages_pgdat(temp, gfp_mask, order)))
 			return(ret);
 		temp = temp->node_next;
 	}
 	return(0);
 }
+
+#endif /* CONFIG_NUMA */
 
 #endif /* CONFIG_DISCONTIGMEM */
diff -Nur linux-2.5.8-vanilla/mm/page_alloc.c linux-2.5.8-api/mm/page_alloc.c
--- linux-2.5.8-vanilla/mm/page_alloc.c	Sun Apr 14 12:18:44 2002
+++ linux-2.5.8-api/mm/page_alloc.c	Mon Apr 22 15:35:16 2002
@@ -39,6 +39,9 @@
 static int zone_balance_min[MAX_NR_ZONES] __initdata = { 20 , 20, 20, };
 static int zone_balance_max[MAX_NR_ZONES] __initdata = { 255 , 255, 255, };
 
+extern int nummemblks;
+extern unsigned long memblk_online_map;
+
 /*
  * Free_page() adds the page to the free lists. This is optimized for
  * fast normal cases (no error jumps taken normally).
@@ -936,6 +939,10 @@
 void __init free_area_init(unsigned long *zones_size)
 {
 	free_area_init_core(0, &contig_page_data, &mem_map, zones_size, 0, 0, 0);
+	contig_page_data.node_id = 0;
+	contig_page_data.memblk_id = 0;
+	nummemblks = 1;
+	memblk_online_map = 1UL;
 }
 
 static int __init setup_mem_frac(char *str)

--------------E7BE2DE7D514C5CA1AA3737C--

