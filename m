Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318077AbSGMAi3>; Fri, 12 Jul 2002 20:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318078AbSGMAi2>; Fri, 12 Jul 2002 20:38:28 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:35749 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318077AbSGMAiR>;
	Fri, 12 Jul 2002 20:38:17 -0400
Message-ID: <3D2F76D2.9050309@us.ibm.com>
Date: Fri, 12 Jul 2002 17:39:46 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Andrew Morton <akpm@zip.com.au>
Subject: [patch] Memory Binding API
Content-Type: multipart/mixed;
 boundary="------------000108060308080408010305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000108060308080408010305
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is a Memory Binding API.  This allows processes to bind themselves to 
particular blocks of memory in a multi-memory block system.  This patch is 
based on top of the Simple Topology API I posted a few moments ago.  The calls 
take a simple bitmask of memblocks.

This is a scaled down version of a full NUMA API I posted several times in the 
past, to a distinct lack of fanfare.  I hope that this smaller patch holds more 
interest to the community...

Enjoy!

-Matt

--------------000108060308080408010305
Content-Type: text/plain;
 name="2.5.25-mem_api.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.5.25-mem_api.patch"

diff -Nur linux-2.5.25-test/arch/i386/config.in linux-2.5.25-api/arch/i386/config.in
--- linux-2.5.25-test/arch/i386/config.in	Fri Jul  5 16:42:20 2002
+++ linux-2.5.25-api/arch/i386/config.in	Fri Jul 12 14:11:40 2002
@@ -165,6 +165,10 @@
    fi
 else
    bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
+   if [ "$CONFIG_MULTIQUAD" = y ]; then
+      bool 'Memory Binding API Support' CONFIG_MEMBIND
+      bool 'IBM/Sequent NUMA-Q Hardware Support' CONFIG_IBMNUMAQ
+   fi
 fi
 
 bool 'Machine Check Exception' CONFIG_X86_MCE
diff -Nur linux-2.5.25-test/include/asm-i386/smp.h linux-2.5.25-api/include/asm-i386/smp.h
--- linux-2.5.25-test/include/asm-i386/smp.h	Fri Jul  5 16:42:02 2002
+++ linux-2.5.25-api/include/asm-i386/smp.h	Fri Jul 12 16:09:16 2002
@@ -55,6 +55,7 @@
 extern void smp_alloc_memory(void);
 extern unsigned long phys_cpu_present_map;
 extern unsigned long cpu_online_map;
+extern unsigned long memblk_online_map;
 extern volatile unsigned long smp_invalidate_needed;
 extern int pic_mode;
 extern int smp_num_siblings;
@@ -99,6 +100,11 @@
 	return hweight32(cpu_online_map);
 }
 
+extern inline unsigned int num_online_memblks(void)
+{
+	return hweight32(memblk_online_map);
+}
+
 extern inline int any_online_cpu(unsigned int mask)
 {
 	if (mask & cpu_online_map)
diff -Nur linux-2.5.25-test/include/linux/init_task.h linux-2.5.25-api/include/linux/init_task.h
--- linux-2.5.25-test/include/linux/init_task.h	Fri Jul  5 16:42:04 2002
+++ linux-2.5.25-api/include/linux/init_task.h	Fri Jul 12 16:32:19 2002
@@ -59,6 +59,7 @@
     children:		LIST_HEAD_INIT(tsk.children),			\
     sibling:		LIST_HEAD_INIT(tsk.sibling),			\
     thread_group:	LIST_HEAD_INIT(tsk.thread_group),		\
+    memblk_binding:	{ MEMBLK_NO_BINDING, MPOL_STRICT },		\
     wait_chldexit:	__WAIT_QUEUE_HEAD_INITIALIZER(tsk.wait_chldexit),\
     real_timer:		{						\
 	function:		it_real_fn				\
diff -Nur linux-2.5.25-test/include/linux/membind.h linux-2.5.25-api/include/linux/membind.h
--- linux-2.5.25-test/include/linux/membind.h	Fri Jul 12 16:53:46 2002
+++ linux-2.5.25-api/include/linux/membind.h	Fri Jul 12 16:31:30 2002
@@ -27,6 +27,35 @@
 #ifndef _LINUX_MEMBIND_H_
 #define _LINUX_MEMBIND_H_
 
+#include <linux/types.h>
+
+#ifdef CONFIG_MEMBIND
+#define NR_MEMBLKS	32 /* Max number of Memory Blocks */
+#else
+#define NR_MEMBLKS	1
+#endif
+
+typedef unsigned long		memblk_bitmask_t;
+#define MEMBLK_NO_BINDING	((memblk_bitmask_t) 0) /* A '0' means use the memblk
+							  and a '1' means *don't* */
+
+#define MPOL_STRICT	0   /* Memory MUST be allocated according to binding */
+#define MPOL_LOOSE	1   /* Memory will be allocated according to binding, 
+				but can fall back to other memory blocks if necessary. */
+#define MPOL_FIRST	2   /* UNUSED FOR NOW */
+#define MPOL_STRIPE	4   /* UNUSED FOR NOW */
+#define MPOL_RR		8   /* UNUSED FOR NOW */
+
+
+typedef struct memblk_list {
+	memblk_bitmask_t bitmask;
+	int behavior;
+	rwlock_t lock;
+} memblk_list_t;
+
+
+int set_memblk_binding(memblk_bitmask_t, int);
+memblk_bitmask_t get_memblk_binding(void);
 int cpu_to_node(int);
 int memblk_to_node(int);
 int node_to_node(int);
diff -Nur linux-2.5.25-test/include/linux/mmzone.h linux-2.5.25-api/include/linux/mmzone.h
--- linux-2.5.25-test/include/linux/mmzone.h	Fri Jul  5 16:42:02 2002
+++ linux-2.5.25-api/include/linux/mmzone.h	Thu Jul 11 14:00:12 2002
@@ -136,6 +136,7 @@
 	unsigned long node_start_mapnr;
 	unsigned long node_size;
 	int node_id;
+	int memblk_id; /* A unique ID for each memory block */
 	struct pglist_data *node_next;
 } pg_data_t;
 
@@ -169,14 +170,15 @@
 #define NODE_MEM_MAP(nid)	mem_map
 #define MAX_NR_NODES		1
 
-#else /* !CONFIG_DISCONTIGMEM */
+#endif /* !CONFIG_DISCONTIGMEM */
 
-#include <asm/mmzone.h>
+#if defined (CONFIG_DISCONTIGMEM) || defined (CONFIG_MEMBIND)
 
+#include <asm/mmzone.h>
 /* page->zone is currently 8 bits ... */
 #define MAX_NR_NODES		(255 / MAX_NR_ZONES)
 
-#endif /* !CONFIG_DISCONTIGMEM */
+#endif /* CONFIG_DISCONTIGMEM || CONFIG_MEMBIND */
 
 #define MAP_ALIGN(x)	((((x) % sizeof(struct page)) == 0) ? (x) : ((x) + \
 		sizeof(struct page) - ((x) % sizeof(struct page))))
diff -Nur linux-2.5.25-test/include/linux/prctl.h linux-2.5.25-api/include/linux/prctl.h
--- linux-2.5.25-test/include/linux/prctl.h	Fri Jul 12 16:53:46 2002
+++ linux-2.5.25-api/include/linux/prctl.h	Wed Jul 10 13:58:17 2002
@@ -26,6 +26,10 @@
 # define PR_FPEMU_NOPRINT	1	/* silently emulate fp operations accesses */
 # define PR_FPEMU_SIGFPE	2	/* don't emulate fp operations, send SIGFPE instead */
 
+/* Get/Set MemBlk Binding */
+#define PR_SET_MEMBLK_BINDING	11
+#define PR_GET_MEMBLK_BINDING	12
+
 /* Get CPU/Node */
 #define PR_GET_CURR_CPU		13
 #define PR_GET_CURR_NODE    	14
diff -Nur linux-2.5.25-test/include/linux/sched.h linux-2.5.25-api/include/linux/sched.h
--- linux-2.5.25-test/include/linux/sched.h	Fri Jul  5 16:42:04 2002
+++ linux-2.5.25-api/include/linux/sched.h	Wed Jul 10 13:43:48 2002
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
 
diff -Nur linux-2.5.25-test/include/linux/smp.h linux-2.5.25-api/include/linux/smp.h
--- linux-2.5.25-test/include/linux/smp.h	Fri Jul  5 16:42:28 2002
+++ linux-2.5.25-api/include/linux/smp.h	Wed Jul 10 13:43:48 2002
@@ -86,6 +86,7 @@
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
+#define memblk_online_map			1
 #define cpu_online_map				1
 #define cpu_online(cpu)				1
 #define num_online_cpus()			1
diff -Nur linux-2.5.25-test/kernel/Makefile linux-2.5.25-api/kernel/Makefile
--- linux-2.5.25-test/kernel/Makefile	Fri Jul  5 16:42:18 2002
+++ linux-2.5.25-api/kernel/Makefile	Wed Jul 10 13:43:48 2002
@@ -15,7 +15,7 @@
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
-	    signal.o sys.o kmod.o context.o futex.o platform.o
+	    signal.o sys.o kmod.o context.o futex.o platform.o membind.o
 
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
diff -Nur linux-2.5.25-test/kernel/membind.c linux-2.5.25-api/kernel/membind.c
--- linux-2.5.25-test/kernel/membind.c	Fri Jul 12 16:53:46 2002
+++ linux-2.5.25-api/kernel/membind.c	Fri Jul 12 16:13:17 2002
@@ -33,9 +33,70 @@
 #include <linux/errno.h>
 #include <linux/smp.h>
 
+#define is_valid_memblk_behavior(x) (1)
+
+#define is_memblk_subset(x, y) (!(~(x) & (y)))  /* test whether x is a subset of y */
+
 extern unsigned long memblk_online_map;
 
 /*
+ * set_memblk_binding(): Sets up a new MemBlk Binding
+ */
+int set_memblk_binding(memblk_bitmask_t memblks, int behavior)
+{
+	int ret;
+	unsigned long flags;
+
+	ret = -ENODEV;
+	/* Make sure that at least one of the memblks in the new binding set is online. */
+	if (!(memblks & memblk_online_map))
+		goto out;
+
+	read_lock_irqsave(&current->memblk_binding.lock, flags);
+
+	ret = -EPERM;
+	/* If the new binding expands upon the old binding, the caller
+	   must have CAP_SYS_NICE. */
+	if ((!is_memblk_subset(memblks, current->memblk_binding.bitmask)) &&
+	    (!capable(CAP_SYS_NICE)))
+		goto out_unlock;
+	read_unlock_irqrestore(&current->memblk_binding.lock, flags);
+
+	ret = -EINVAL;
+	// Test to make sure the behavior argument is valid.
+	if (!is_valid_memblk_behavior(behavior))
+		goto out;
+
+	write_lock_irqsave(&current->memblk_binding.lock, flags);
+	current->memblk_binding.bitmask = memblks;
+	current->memblk_binding.behavior = behavior;
+	write_unlock_irqrestore(&current->memblk_binding.lock, flags);
+
+	ret = 0;
+	goto out;
+
+ out_unlock:
+	read_unlock_irqrestore(&current->memblk_binding.lock, flags);
+ out:
+	return ret;
+}
+
+/*
+ * get_memblk_binding(): Returns the current MemBlk Binding
+ */
+inline memblk_bitmask_t get_memblk_binding(void)
+{
+	unsigned long flags;
+	memblk_bitmask_t memblk_binding;
+
+	read_lock_irqsave(&current->memblk_binding.lock, flags);
+	memblk_binding = current->memblk_binding.bitmask;
+	read_unlock_irqrestore(&current->memblk_binding.lock, flags);
+
+	return memblk_binding;
+}
+
+/*
  * cpu_to_node(cpu): Returns the number of the most specific Node 
  * containing CPU 'cpu'.
  */
diff -Nur linux-2.5.25-test/kernel/sys.c linux-2.5.25-api/kernel/sys.c
--- linux-2.5.25-test/kernel/sys.c	Fri Jul 12 16:53:46 2002
+++ linux-2.5.25-api/kernel/sys.c	Fri Jul 12 16:11:16 2002
@@ -1292,6 +1292,12 @@
 			}
 			current->keep_capabilities = arg2;
 			break;
+		case PR_SET_MEMBLK_BINDING:
+			error = (long) set_memblk_binding((memblk_bitmask_t)arg2, (int)arg3);
+			break;
+		case PR_GET_MEMBLK_BINDING:
+			error = (long) get_memblk_binding();
+			break;
 		case PR_GET_CURR_CPU:
 			error = (long) get_curr_cpu();
 			break;
diff -Nur linux-2.5.25-test/mm/numa.c linux-2.5.25-api/mm/numa.c
--- linux-2.5.25-test/mm/numa.c	Fri Jul  5 16:42:20 2002
+++ linux-2.5.25-api/mm/numa.c	Fri Jul 12 16:35:19 2002
@@ -8,8 +8,10 @@
 #include <linux/bootmem.h>
 #include <linux/mmzone.h>
 #include <linux/spinlock.h>
+#include <linux/membind.h>
 
 int numnodes = 1;	/* Initialized for UMA platforms */
+unsigned long memblk_online_map = 0UL;  /* Similar to cpu_online_map, but for memory blocks */
 
 static bootmem_data_t contig_bootmem_data;
 pg_data_t contig_page_data = { bdata: &contig_bootmem_data };
@@ -27,6 +29,9 @@
 {
 	free_area_init_core(0, &contig_page_data, &mem_map, zones_size, 
 				zone_start_paddr, zholes_size, pmap);
+	contig_page_data.node_id = 0;
+	contig_page_data.memblk_id = 0;
+	memblk_online_map = 1UL;
 }
 
 #endif /* !CONFIG_DISCONTIGMEM */
@@ -71,6 +76,11 @@
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
@@ -88,6 +98,8 @@
 	return __alloc_pages(gfp_mask, order, pgdat->node_zonelists + (gfp_mask & GFP_ZONEMASK));
 }
 
+#ifdef CONFIG_NUMA
+
 /*
  * This can be refined. Currently, tries to do round robin, instead
  * should do concentratic circle search, starting from current node.
@@ -96,30 +110,66 @@
 {
 	struct page *ret = 0;
 	pg_data_t *start, *temp;
-#ifndef CONFIG_NUMA
+	int search_twice = 0;
+	memblk_bitmask_t memblk_bitmask;
 	unsigned long flags;
-	static pg_data_t *next = 0;
-#endif
 
 	if (order >= MAX_ORDER)
 		return NULL;
-#ifdef CONFIG_NUMA
+
+	read_lock_irqsave(&current->memblk_binding.lock, flags);
+	memblk_bitmask = current->memblk_binding.bitmask;
+	/* if it is a loose binding, remember to search other memblks */
+	if ((current->memblk_binding.behavior == MPOL_LOOSE) &&
+	    (current->memblk_binding.bitmask != MEMBLK_NO_BINDING))
+		 search_twice = 1;
+	read_unlock_irqrestore(&current->memblk_api_lock, flags);
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
+		if (!(memblk_bitmask & (1 << temp->memblk_id)))
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
+		memblk_bitmask = ~memblk_bitmask;
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
@@ -127,4 +179,6 @@
 	return(0);
 }
 
+#endif /* CONFIG_NUMA */
+
 #endif /* CONFIG_DISCONTIGMEM */
diff -Nur linux-2.5.25-test/mm/page_alloc.c linux-2.5.25-api/mm/page_alloc.c
--- linux-2.5.25-test/mm/page_alloc.c	Fri Jul  5 16:42:03 2002
+++ linux-2.5.25-api/mm/page_alloc.c	Fri Jul 12 16:00:40 2002
@@ -41,6 +41,8 @@
 static int zone_balance_min[MAX_NR_ZONES] __initdata = { 20 , 20, 20, };
 static int zone_balance_max[MAX_NR_ZONES] __initdata = { 255 , 255, 255, };
 
+extern unsigned long memblk_online_map;
+
 /*
  * Temporary debugging check for pages not lying within a given zone.
  */
@@ -921,6 +923,9 @@
 void __init free_area_init(unsigned long *zones_size)
 {
 	free_area_init_core(0, &contig_page_data, &mem_map, zones_size, 0, 0, 0);
+	contig_page_data.node_id = 0;
+	contig_page_data.memblk_id = 0;
+	memblk_online_map = 1UL;
 }
 
 static int __init setup_mem_frac(char *str)

--------------000108060308080408010305--

