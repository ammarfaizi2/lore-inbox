Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315452AbSEBWwo>; Thu, 2 May 2002 18:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSEBWwn>; Thu, 2 May 2002 18:52:43 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:51904 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315452AbSEBWw0>; Thu, 2 May 2002 18:52:26 -0400
Message-ID: <3CD1C283.394FF906@us.ibm.com>
Date: Thu, 02 May 2002 15:49:39 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
CC: mjbligh@us.ibm.com, lse-tech@lists.sourceforge.net, rml@tech9.net,
        efocht@ess.nec.de
Subject: [patch] NUMA API for 2.5.12 (1/4)
Content-Type: multipart/mixed;
 boundary="------------681D7960C835A5BA441C2247"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------681D7960C835A5BA441C2247
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
--------------681D7960C835A5BA441C2247
Content-Type: text/plain; charset=us-ascii;
 name="numa_api-arch_indep-setup-2.5.12.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="numa_api-arch_indep-setup-2.5.12.patch"

diff -Nur linux-2.5.8-vanilla/include/linux/init_task.h linux-2.5.8-api/include/linux/init_task.h
--- linux-2.5.8-vanilla/include/linux/init_task.h	Mon Apr 22 17:20:20 2002
+++ linux-2.5.8-api/include/linux/init_task.h	Fri Apr 26 15:22:52 2002
@@ -59,6 +59,10 @@
     children:		LIST_HEAD_INIT(tsk.children),			\
     sibling:		LIST_HEAD_INIT(tsk.sibling),			\
     thread_group:	LIST_HEAD_INIT(tsk.thread_group),		\
+    numa_restrict:	NEW_NUMA_SET,					\
+    numa_binding:	NEW_NUMA_SET,					\
+    numa_launch_policy:	NEW_NUMA_SET,					\
+    numa_api_lock:	RW_LOCK_UNLOCKED,				\
     wait_chldexit:	__WAIT_QUEUE_HEAD_INITIALIZER(tsk.wait_chldexit),\
     real_timer:		{						\
 	function:		it_real_fn				\
diff -Nur linux-2.5.8-vanilla/include/linux/mmzone.h linux-2.5.8-api/include/linux/mmzone.h
--- linux-2.5.8-vanilla/include/linux/mmzone.h	Mon Apr 22 17:13:25 2002
+++ linux-2.5.8-api/include/linux/mmzone.h	Fri Apr 26 17:15:28 2002
@@ -136,6 +136,7 @@
 	unsigned long node_start_mapnr;
 	unsigned long node_size;
 	int node_id;
+	int memblk_id; /* A unique ID for each memory block (physical contiguous chunk of memory) */
 	struct pglist_data *node_next;
 } pg_data_t;
 
@@ -163,14 +164,15 @@
 #define NODE_MEM_MAP(nid)	mem_map
 #define MAX_NR_NODES		1
 
-#else /* !CONFIG_DISCONTIGMEM */
+#endif /* !CONFIG_DISCONTIGMEM */
 
-#include <asm/mmzone.h>
+#if defined (CONFIG_DISCONTIGMEM) || defined (CONFIG_NUMA_API)
 
+#include <asm/mmzone.h>
 /* page->zone is currently 8 bits ... */
 #define MAX_NR_NODES		(255 / MAX_NR_ZONES)
 
-#endif /* !CONFIG_DISCONTIGMEM */
+#endif /* CONFIG_DISCONTIGMEM || CONFIG_NUMA_API */
 
 #define MAP_ALIGN(x)	((((x) % sizeof(mem_map_t)) == 0) ? (x) : ((x) + \
 		sizeof(mem_map_t) - ((x) % sizeof(mem_map_t))))
diff -Nur linux-2.5.8-vanilla/include/linux/numa.h linux-2.5.8-api/include/linux/numa.h
--- linux-2.5.8-vanilla/include/linux/numa.h	Wed Dec 31 16:00:00 1969
+++ linux-2.5.8-api/include/linux/numa.h	Mon Apr 29 11:03:20 2002
@@ -0,0 +1,76 @@
+/*
+ * linux/include/linux/numa.h
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
+#ifndef _LINUX_NUMA_H_
+#define _LINUX_NUMA_H_
+
+#include <linux/types.h>
+
+#ifdef CONFIG_NUMA
+#define NR_MEMBLKS	32 /* Max number of Memory Blocks */
+#else
+#define NR_MEMBLKS	1
+#endif
+
+typedef unsigned long		numa_bitmap_t;
+#define NUMA_BITMAP_NONE	(~((numa_bitmap_t) 0))
+
+#define CPU_BIND_STRICT	0
+
+#define MPOL_FIRST	1   /* UNUSED FOR NOW */
+#define MPOL_STRIPE	2   /* UNUSED FOR NOW */
+#define MPOL_RR		4   /* UNUSED FOR NOW */
+#define MPOL_STRICT	8   /* Memory MUST be allocated according to binding */
+#define MPOL_LOOSE	16  /* Memory must try to be allocated according to binding first, 
+			       and can fall back to restriction if necessary */
+
+
+typedef struct numa_list {
+	numa_bitmap_t list;
+	int behavior;
+} numa_list_t;
+
+typedef struct numa_set {
+	numa_list_t cpus;
+	numa_list_t memblks;
+} numa_set_t;
+
+
+/* Initializes a numa_set_t to be an empty set. */
+#define numa_set_init(x) do { (x)->cpus.list = NUMA_BITMAP_NONE;\
+				(x)->memblks.list = NUMA_BITMAP_NONE;\
+				(x)->cpus.behavior = CPU_BIND_STRICT;\
+				(x)->memblks.behavior = MPOL_STRICT; } while(0)
+
+/* Assignment initializer for a numa_set_t to be an empty set */
+#define NEW_NUMA_SET { {NUMA_BITMAP_NONE, CPU_BIND_STRICT}, \
+		       {NUMA_BITMAP_NONE, MPOL_STRICT} }
+
+/* Tests whether a numa_set_t represents an empty restriction (ie: all 1's.  All cpus/memblks allowed.) */
+#define null_restrict(x) (((x)->cpus.list == NUMA_BITMAP_NONE) && \
+				((x)->memblks.list == NUMA_BITMAP_NONE))
+
+#endif /* _LINUX_NUMA_H_ */
diff -Nur linux-2.5.8-vanilla/include/linux/sched.h linux-2.5.8-api/include/linux/sched.h
--- linux-2.5.8-vanilla/include/linux/sched.h	Mon Apr 22 17:13:27 2002
+++ linux-2.5.8-api/include/linux/sched.h	Fri Apr 26 15:14:15 2002
@@ -28,6 +28,7 @@
 #include <linux/securebits.h>
 #include <linux/fs_struct.h>
 #include <linux/compiler.h>
+#include <linux/numa.h>
 
 struct exec_domain;
 
@@ -286,6 +287,12 @@
 	struct task_struct *pidhash_next;
 	struct task_struct **pidhash_pprev;
 
+	/* additional NUMA stuff */
+	numa_set_t numa_restrict;
+	numa_set_t numa_binding;
+	numa_set_t numa_launch_policy;
+	rwlock_t  numa_api_lock;	/* protects the preceding 3 structs */
+	
 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
 
diff -Nur linux-2.5.8-vanilla/include/linux/smp.h linux-2.5.8-api/include/linux/smp.h
--- linux-2.5.8-vanilla/include/linux/smp.h	Mon Apr 22 17:13:25 2002
+++ linux-2.5.8-api/include/linux/smp.h	Fri Apr 26 15:14:15 2002
@@ -90,6 +90,7 @@
 #define cpu_number_map(cpu)			0
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 #define cpu_online_map				1
+#define memblk_online_map			1
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
 #define __per_cpu_data
diff -Nur linux-2.5.8-vanilla/kernel/sched.c linux-2.5.8-api/kernel/sched.c
--- linux-2.5.8-vanilla/kernel/sched.c	Mon Apr 22 13:17:43 2002
+++ linux-2.5.8-api/kernel/sched.c	Mon Apr 22 15:35:16 2002
@@ -357,7 +357,7 @@
 	runqueue_t *rq;
 
 	preempt_disable();
-	rq = this_rq();
+	rq = task_rq(p);
 	spin_lock_irq(&rq->lock);
 
 	p->state = TASK_RUNNING;
@@ -371,7 +371,6 @@
 		p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
 		p->prio = effective_prio(p);
 	}
-	p->thread_info->cpu = smp_processor_id();
 	activate_task(p, rq);
 
 	spin_unlock_irq(&rq->lock);
@@ -1662,8 +1661,7 @@
 	migration_req_t req;
 	runqueue_t *rq;
 
-	new_mask &= cpu_online_map;
-	if (!new_mask)
+	if (!(new_mask & cpu_online_map))
 		BUG();
 
 	preempt_disable();

--------------681D7960C835A5BA441C2247--

