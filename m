Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261314AbSIWSeI>; Mon, 23 Sep 2002 14:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261313AbSIWSeI>; Mon, 23 Sep 2002 14:34:08 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:31936 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S261311AbSIWSeA>; Mon, 23 Sep 2002 14:34:00 -0400
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Date: Mon, 23 Sep 2002 20:38:15 +0200
User-Agent: KMail/1.4.1
Cc: LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
References: <200209221245.30798.efocht@ess.nec.de> <70114038.1032681424@[10.10.2.3]>
In-Reply-To: <70114038.1032681424@[10.10.2.3]>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_RFMWAKG9Q7BO71JAI85T"
Message-Id: <200209232038.15039.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_RFMWAKG9Q7BO71JAI85T
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Sunday 22 September 2002 16:57, Martin J. Bligh wrote:
> > There is an alternative idea (we discussed this at OLS with Andrea, m=
aybe
> > you remember): allocate memory from the current node and keep statist=
ics
> > on where it is allocated. Determine the homenode from this (from time=
 to
> > time) and schedule accordingly. This eliminates the initial load
> > balancing and leaves it all to the scheduler, but has the drawback th=
at
> > memory can be somewhat scattered across the nodes. Any comments?
>
> Well, that's a lot simpler. Things should end up running on their home
> node, and thus will allocate pages from their home node, so it should
> be self-re-enforcing. The algorithm for the home node is then implicitl=
y
> worked out from the scheduler itself, and its actions, so it's one less
> set of stuff to write. Would suggest we do this at first, to keep thing=
s
> as simple as possible so you have something mergeable.

OK, sounds encouraging. So here is my first attempt (attached). You'll
have to apply it on top of the two NUMA scheduler patches and hack
SAPICID_TO_PNODE again.

The patch adds a node_mem[NR_NODES] array to each task. When allocating
memory (in rmqueue) and freeing it (in free_pages_ok) the number of
pages is added/subtracted from that array and the homenode is set to
the node having the largest entry. Is there a better place where to put
this in (other than rmqueue/free_pages_ok)?

I have two problems with this approach:
1: Freeing memory is quite expensive, as it currently involves finding th=
e
maximum of the array node_mem[].
2: I have no idea how tasks sharing the mm structure will behave. I'd
like them to run on different nodes (that's why node_mem is not in mm),
but they could (legally) free pages which they did not allocate and
have wrong values in node_mem[].

Comments?

Regards,
Erich

--------------Boundary-00=_RFMWAKG9Q7BO71JAI85T
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="node_affine_dyn-2.5.37.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="node_affine_dyn-2.5.37.patch"

diff -urNp 2.5.37-node-affine/fs/exec.c 2.5.37-node-affine-v2/fs/exec.c
--- 2.5.37-node-affine/fs/exec.c	Sun Sep 22 11:13:59 2002
+++ 2.5.37-node-affine-v2/fs/exec.c	Mon Sep 23 18:56:43 2002
@@ -995,9 +995,6 @@ int do_execve(char * filename, char ** a
 	int retval;
 	int i;
 
-	if (current->node_policy == NODPOL_EXEC)
-		sched_balance_exec();
-
 	file = open_exec(filename);
 
 	retval = PTR_ERR(file);
diff -urNp 2.5.37-node-affine/include/asm-i386/mmzone.h 2.5.37-node-affine-v2/include/asm-i386/mmzone.h
--- 2.5.37-node-affine/include/asm-i386/mmzone.h	Sun Sep 22 11:13:59 2002
+++ 2.5.37-node-affine-v2/include/asm-i386/mmzone.h	Mon Sep 23 19:27:09 2002
@@ -20,11 +20,7 @@
 #endif /* CONFIG_X86_NUMAQ */
 
 #ifdef CONFIG_NUMA
-#ifdef CONFIG_NUMA_SCHED
-#define numa_node_id() (current->node)
-#else
 #define numa_node_id() _cpu_to_node(smp_processor_id())
-#endif
 #endif /* CONFIG_NUMA */
 
 extern struct pglist_data *node_data[];
diff -urNp 2.5.37-node-affine/include/linux/prctl.h 2.5.37-node-affine-v2/include/linux/prctl.h
--- 2.5.37-node-affine/include/linux/prctl.h	Sun Sep 22 11:13:59 2002
+++ 2.5.37-node-affine-v2/include/linux/prctl.h	Mon Sep 23 18:57:29 2002
@@ -37,7 +37,5 @@
 /* Get/set node for node-affine scheduling */
 #define PR_GET_NODE       16
 #define PR_SET_NODE       17
-#define PR_GET_NODPOL     18
-#define PR_SET_NODPOL     19
 
 #endif /* _LINUX_PRCTL_H */
diff -urNp 2.5.37-node-affine/include/linux/sched.h 2.5.37-node-affine-v2/include/linux/sched.h
--- 2.5.37-node-affine/include/linux/sched.h	Sun Sep 22 11:13:59 2002
+++ 2.5.37-node-affine-v2/include/linux/sched.h	Mon Sep 23 19:04:55 2002
@@ -160,13 +160,13 @@ extern void update_one_process(struct ta
 extern void scheduler_tick(int user_tick, int system);
 extern unsigned long cache_decay_ticks;
 #ifdef CONFIG_NUMA_SCHED
-extern void sched_balance_exec(void);
-extern void sched_balance_fork(task_t *p);
 extern void set_task_node(task_t *p, int node);
+extern void inc_node_mem(int node, int blocks);
+extern void dec_node_mem(int node, int blocks);
 #else
-#define sched_balance_exec() {}
-#define sched_balance_fork(p) {}
 #define set_task_node(p,n) {}
+#define inc_node_mem(node,blocks) {}
+#define dec_node_mem(node,blocks) {}
 #endif
 extern void sched_migrate_task(task_t *p, int cpu);
 
@@ -303,7 +303,7 @@ struct task_struct {
 	unsigned long cpus_allowed;
 	unsigned int time_slice, first_time_slice;
 	int node;
-	int node_policy;
+	int node_mem[NR_NODES];
 
 	struct list_head tasks;
 	struct list_head ptrace_children;
diff -urNp 2.5.37-node-affine/kernel/fork.c 2.5.37-node-affine-v2/kernel/fork.c
--- 2.5.37-node-affine/kernel/fork.c	Sun Sep 22 11:13:59 2002
+++ 2.5.37-node-affine-v2/kernel/fork.c	Mon Sep 23 18:56:19 2002
@@ -701,9 +701,6 @@ static struct task_struct *copy_process(
 #ifdef CONFIG_SMP
 	{
 		int i;
-		if (p->node_policy == NODPOL_FORK_ALL ||
-		    (p->node_policy == NODPOL_FORK && !(clone_flags & CLONE_VM)))
-				sched_balance_fork(p);
 
 		/* ?? should we just memset this ?? */
 		for(i = 0; i < NR_CPUS; i++)
diff -urNp 2.5.37-node-affine/kernel/sched.c 2.5.37-node-affine-v2/kernel/sched.c
--- 2.5.37-node-affine/kernel/sched.c	Sun Sep 22 11:13:59 2002
+++ 2.5.37-node-affine-v2/kernel/sched.c	Mon Sep 23 19:08:41 2002
@@ -2019,103 +2019,59 @@ void show_state(void)
 	read_unlock(&tasklist_lock);
 }
 
-/* used as counter for round-robin node-scheduling */
-static atomic_t sched_node=ATOMIC_INIT(0);
+#ifdef CONFIG_NUMA_SCHED
 
-/*
- * Find the least loaded CPU on the current node of the task.
- */
-static int sched_best_cpu(struct task_struct *p)
+void inc_node_mem(int node, int blocks)
 {
-	int n, cpu, load, best_cpu = task_cpu(p);
-	
-	load = 1000000;
-	for (n = pool_ptr[p->node]; n < pool_ptr[p->node+1]; n++) {
-		cpu = pool_cpus[n];
-		if (!(p->cpus_allowed & (1UL << cpu) & cpu_online_map))
-			continue;
-		if (cpu_rq(cpu)->nr_running < load) {
-			best_cpu = cpu;
-			load = cpu_rq(cpu)->nr_running;
+	int homenode;
+	unsigned long flags;
+	runqueue_t *rq;
+
+	/* ignore kernel threads */
+	if (current->active_mm == &init_mm)
+		return;
+	homenode = current->node;
+	current->node_mem[node] += blocks;
+	if (unlikely(node != homenode))
+		if(current->node_mem[node] >= current->node_mem[homenode]) {
+			rq = task_rq_lock(current, &flags);
+			HOMENODE_DEC(rq, homenode);
+			HOMENODE_INC(rq, node);
+			task_rq_unlock(rq, &flags);
 		}
-	}
-	return best_cpu;
 }
 
-/*
- * Find the node with fewest tasks assigned to it. Don't bother about the
- * current load of the nodes, the load balancer should take care.
- * The argument  flag  gives some options for initial load balancing:
- *    flag = 0:  don't count own task (when balancing at do_exec())
- *    flag = 1:  count own task (when balancing at do_fork())
- */
-static int sched_best_node(struct task_struct *p, int flag)
+void dec_node_mem(int node, int blocks)
 {
-	int n, best_node=0, min_load, pool_load, min_pool=p->node;
-	int pool, load[NR_NODES];
-	unsigned long mask = p->cpus_allowed & cpu_online_map;
-
-	do {
-		best_node = atomic_inc_return(&sched_node) % numpools;
-	} while (!(pool_mask[best_node] & mask));
-
-	for (pool = 0; pool < numpools; pool++)
-		load[pool] = 0;
-
-	for (n = 0; n < NR_CPUS; n++) {
-		if (!cpu_online(n)) continue;
-#if 1
-		for (pool = 0; pool < numpools; pool++)
-			load[pool] += cpu_rq(n)->nr_homenode[pool];
-#else
-		load[CPU_TO_NODE(n)] += cpu_rq(n)->nr_running;
-#endif
-	}
-
-	/* don't count own process, this one will be moved */
-	if (!flag)
-		--load[p->node];
-
-	min_load = 100000000;
-	for (n = 0; n < numpools; n++) {
-		pool = (best_node + n) % numpools;
-		pool_load = (100*load[pool])/pool_nr_cpus[pool];
-		if ((pool_load < min_load) && (pool_mask[pool] & mask)) {
-			min_load = pool_load;
-			min_pool = pool;
+	int homenode, n;
+	unsigned long flags, maxblk;
+	runqueue_t *rq;
+
+	/* ignore kernel threads */
+	if (current->active_mm == &init_mm)
+		return;
+	homenode = current->node;
+	current->node_mem[node] -= blocks;
+	if (current->node_mem[node] < 0)
+		current->node_mem[node] = 0;
+	if (node == homenode) {
+		maxblk=current->node_mem[node];
+		for (n=0; n<numpools; n++) {
+			if (current->node_mem[n] > maxblk) {
+				maxblk = current->node_mem[n];
+				homenode = n;
+			}
 		}
-	}
-	atomic_set(&sched_node, min_pool);
-	return min_pool;
-}
-
-void sched_balance_exec(void)
-{
-	int new_cpu, new_node;
-
-	while (atomic_read(&pool_lock))
-		cpu_relax();
-	if (numpools > 1) {
-		new_node = sched_best_node(current, 0);
-		if (new_node != current->node) {
-			set_task_node(current, new_node);
+		if(node != homenode) {
+			current->node = homenode;
+			rq = task_rq_lock(current, &flags);
+			HOMENODE_DEC(rq, node);
+			HOMENODE_INC(rq, homenode);
+			task_rq_unlock(rq, &flags);
 		}
 	}
-	new_cpu = sched_best_cpu(current);
-	if (new_cpu != smp_processor_id())
-		sched_migrate_task(current, new_cpu);
-}
-
-void sched_balance_fork(task_t *p)
-{
-	while (atomic_read(&pool_lock))
-		cpu_relax();
-	if (numpools > 1)
-		p->node = sched_best_node(p, 1);
-	set_task_cpu(p, sched_best_cpu(p));
 }
 
-#ifdef CONFIG_NUMA_SCHED
 void pools_info(void)
 {
 	int i, j;
diff -urNp 2.5.37-node-affine/kernel/sys.c 2.5.37-node-affine-v2/kernel/sys.c
--- 2.5.37-node-affine/kernel/sys.c	Sun Sep 22 11:13:59 2002
+++ 2.5.37-node-affine-v2/kernel/sys.c	Mon Sep 23 18:57:13 2002
@@ -1400,34 +1400,6 @@ asmlinkage long sys_prctl(int option, un
 			read_unlock(&tasklist_lock);
 			break;
 
-		case PR_GET_NODPOL:
-			pid = (int) arg3;
-			read_lock(&tasklist_lock);
-			child = find_task_by_pid(pid);
-			if (child) {
-				error = put_user(child->node_policy,(int *)arg2);
-			} else {
-				printk("prctl: could not find pid %d\n",pid);
-				error = -EINVAL;
-			}
-			read_unlock(&tasklist_lock);
-			break;
-		case PR_SET_NODPOL:
-			pid = (int) arg3;
-			read_lock(&tasklist_lock);
-			child = find_task_by_pid(pid);
-			if (child) {
-				if (child->uid == current->uid || \
-				    current->uid == 0) {
-					printk("setting node policy of process %d to %d\n",pid,(int)arg2);
-					child->node_policy = (int) arg2;
-				}
-			} else {
-				printk("prctl: could not find pid %d\n",pid);
-				error = -EINVAL;
-			}
-			read_unlock(&tasklist_lock);
-			break;
 		default:
 			error = -EINVAL;
 			break;
diff -urNp 2.5.37-node-affine/mm/page_alloc.c 2.5.37-node-affine-v2/mm/page_alloc.c
--- 2.5.37-node-affine/mm/page_alloc.c	Fri Sep 20 17:20:15 2002
+++ 2.5.37-node-affine-v2/mm/page_alloc.c	Mon Sep 23 18:02:22 2002
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

--------------Boundary-00=_RFMWAKG9Q7BO71JAI85T--

