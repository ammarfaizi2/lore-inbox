Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSJNLGv>; Mon, 14 Oct 2002 07:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261584AbSJNLG0>; Mon, 14 Oct 2002 07:06:26 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:23940 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S261602AbSJNLFy>; Mon, 14 Oct 2002 07:05:54 -0400
From: Erich Focht <efocht@ess.nec.de>
Subject: [PATCH] node affine NUMA scheduler 5/5
Date: Mon, 14 Oct 2002 13:10:33 +0200
User-Agent: KMail/1.4.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_LPXYZZW8ZQXUIB05U1RL"
Message-Id: <200210141310.33301.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_LPXYZZW8ZQXUIB05U1RL
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

----------  Resent Message  ----------

Subject: [PATCH] node affine NUMA scheduler 5/5
Date: Fri, 11 Oct 2002 20:00:19 +0200

And finally the last part:
> 05-dynamic_homenode-2.5.39-10.patch :
>        Dynamic homenode selection. When pages are allocated or freed
>        they are tracked. The homenode is recalculated dynamically and
>        set to the node where most of the memory of the task is allocate=
d.

Erich

--------------Boundary-00=_LPXYZZW8ZQXUIB05U1RL
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="05-dynamic_homenode-2.5.39-10.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="05-dynamic_homenode-2.5.39-10.patch"

diff -urNp a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Fri Oct 11 19:32:47 2002
+++ b/include/linux/sched.h	Fri Oct 11 19:43:19 2002
@@ -30,6 +30,7 @@ extern unsigned long event;
 #include <linux/compiler.h>
 #include <linux/completion.h>
 #include <linux/pid.h>
+#include <linux/mmzone.h>
 
 struct exec_domain;
 
@@ -302,6 +303,8 @@ struct task_struct {
 	unsigned long cpus_allowed;
 	unsigned int time_slice, first_time_slice;
 	int node;
+	int node_mem_upd;
+	int node_mem[NR_NODES];
 
 	struct list_head tasks;
 	struct list_head ptrace_children;
@@ -466,11 +469,35 @@ extern void sched_balance_exec(void);
 extern void set_task_node(task_t *p, int node);
 # define homenode_inc(rq,node) (rq)->nr_homenode[node]++
 # define homenode_dec(rq,node) (rq)->nr_homenode[node]--
+extern struct   mm_struct init_mm;
+
+static inline void inc_node_mem(int node, int blocks)
+{
+	/* ignore kernel threads */
+	if (current->active_mm != &init_mm) {
+		current->node_mem[node] += blocks;
+		if (unlikely(node != current->node))
+			current->node_mem_upd = 1;
+	}
+}
+
+static inline void dec_node_mem(int node, int blocks)
+{
+	/* ignore kernel threads */
+	if (current->active_mm != &init_mm) {
+		current->node_mem[node] -= blocks;
+		if (node == current->node)
+			current->node_mem_upd = 1;
+	}
+}
+
 #else
 #define sched_balance_exec() {}
 #define set_task_node(p,n) {}
 # define homenode_inc(rq,node) {}
 # define homenode_dec(rq,node) {}
+#define inc_node_mem(node,blocks) {}
+#define dec_node_mem(node,blocks) {}
 #endif
 extern void sched_migrate_task(task_t *p, int cpu);
 
diff -urNp a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Fri Oct 11 19:35:58 2002
+++ b/kernel/sched.c	Fri Oct 11 19:42:37 2002
@@ -735,6 +735,31 @@ static inline unsigned int double_lock_b
 	return nr_running;
 }
 
+#ifdef CONFIG_NUMA
+/*
+ * Recalculate the homenode of a task after its node_mem[] array
+ * has been changed. The runqueue of the task must be locked!
+ */
+static void upd_node_mem(task_t *p)
+{
+	int homenode, maxblk, n, oldnode;
+
+	p->node_mem_upd = 0;
+	oldnode = homenode = p->node;
+	maxblk=p->node_mem[oldnode];
+	for (n=0; n<numpools; n++) {
+		if (p->node_mem[n] > maxblk) {
+			maxblk = p->node_mem[n];
+			homenode = n;
+		}
+	}
+	if(oldnode != homenode) {
+		p->node = homenode;
+		homenode_dec(task_rq(p), oldnode);
+		homenode_inc(task_rq(p), homenode);
+	}
+}
+#endif
 /*
  * Calculate load of a CPU pool, return it in pool_load, return load
  * of most loaded CPU in cpu_load.
@@ -942,6 +967,8 @@ skip_queue:
 	tmp = list_entry(curr, task_t, run_list);
 
 	if (CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
+		if (unlikely(tmp->node_mem_upd))
+			upd_node_mem(tmp);
 		weight = (jiffies - tmp->sleep_timestamp)/cache_decay_ticks;
 		/* limit weight influence of sleep_time and cache coolness */
 		if (weight >= MAX_CACHE_WEIGHT) weight=MAX_CACHE_WEIGHT-1;
diff -urNp a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Tue Oct  8 15:03:55 2002
+++ b/mm/page_alloc.c	Fri Oct 11 19:42:37 2002
@@ -146,6 +146,7 @@ void __free_pages_ok (struct page *page,
 	}
 	list_add(&(base + page_idx)->list, &area->free_list);
 	spin_unlock_irqrestore(&zone->lock, flags);
+	dec_node_mem(zone->zone_pgdat->node_id, 1<<order);
 out:
 	return;
 }
@@ -222,6 +223,7 @@ static struct page *rmqueue(struct zone 
 			if (bad_range(zone, page))
 				BUG();
 			prep_new_page(page);
+			inc_node_mem(zone->zone_pgdat->node_id, 1<<order);
 			return page;	
 		}
 		curr_order++;

--------------Boundary-00=_LPXYZZW8ZQXUIB05U1RL--

