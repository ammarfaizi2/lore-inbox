Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266952AbTBQIFm>; Mon, 17 Feb 2003 03:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbTBQIE7>; Mon, 17 Feb 2003 03:04:59 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:20894
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S266938AbTBQIEj>; Mon, 17 Feb 2003 03:04:39 -0500
Date: Mon, 17 Feb 2003 03:13:10 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH][RFC] RCU callback offload queue
Message-ID: <Pine.LNX.4.50.0302170230230.18087-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following is based on discussions with Dipankar earlier.

This patch is an attempt at providing a facility for cpu hotplug so that 
we can offload cpus without blocking callbacks. At present it executes in the 
CPU_DEAD path so we can access the dead cpu's RCU_cur/nxtlist lockless. 
One other thing to note is that we currently rarely would be able to use 
this on i386 due to the way we park an offline cpu. It goes offline by 
entering a branch in the idle thread, disabling interrupts and polling a 
variable. Therefore by the time we have reached the CPU_DEAD notifiers 
that cpu has entered a number of quiescent states and cleared any/all of 
it's callbacks. There however is the time window between stopping 
scheduling and disabling interrupts where we could end up queueing 
addition callbacks thus necessitating this code.

The implimentation is based on a global queue which is flushed a callback 
at a time by cpus in the rcu processing path, each cpu fetching a 
callback, enqueueing it and proceeding.

Index: linux-2.5.61-trojan/kernel/rcupdate.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.61/kernel/rcupdate.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 rcupdate.c
--- linux-2.5.61-trojan/kernel/rcupdate.c	15 Feb 2003 12:32:44 -0000	1.1.1.1
+++ linux-2.5.61-trojan/kernel/rcupdate.c	16 Feb 2003 19:35:20 -0000
@@ -50,6 +50,15 @@
 	  .maxbatch = 1, .rcu_cpu_mask = 0 };
 DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
 
+/* slack queue used for offloading callbacks e.g. in the case of a cpu going offline */
+static struct rcu_global_queue_s {
+	spinlock_t lock;
+	struct list_head list;
+} rcu_global_queue = {
+	.lock = SPIN_LOCK_UNLOCKED,
+	.list = { &(rcu_global_queue.list), &(rcu_global_queue.list) }
+};
+
 /* Fake initialization required by compiler */
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
 #define RCU_tasklet(cpu) (per_cpu(rcu_tasklet, cpu))
@@ -170,6 +179,17 @@
 	}
 
 	local_irq_disable();
+	
+	/* pick up any pending global callbacks. This is rarely used
+	 * so lock contention is fine. Each cpu picks one callback and it's
+	 * ok if we miss one since someone else can pick it up */
+	if (unlikely(!list_empty(&rcu_global_queue.list))) {
+		spin_lock(&rcu_global_queue.lock);
+		if (!list_empty(&rcu_global_queue.list))
+			list_move_tail(&rcu_global_queue.list, &RCU_nxtlist(cpu));
+		spin_unlock(&rcu_global_queue.lock);
+	}
+	
 	if (!list_empty(&RCU_nxtlist(cpu)) && list_empty(&RCU_curlist(cpu))) {
 		list_splice(&RCU_nxtlist(cpu), &RCU_curlist(cpu));
 		INIT_LIST_HEAD(&RCU_nxtlist(cpu));
@@ -207,6 +227,49 @@
 	INIT_LIST_HEAD(&RCU_curlist(cpu));
 }
 
+/* warning! helper for rcu_offline_cpu. do not use elsewhere without reviewing
+ * locking requirements, the list it's pulling from has to belong to a cpu
+ * which is dead and hence not processing interrupts.
+ */
+static void rcu_move_batch(struct list_head *list)
+{
+	struct list_head *entry;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rcu_global_queue.lock, flags);
+	while (!list_empty(list)) {
+		entry = list->next;
+		list_del(entry);
+		list_add_tail(entry, &rcu_global_queue.list);
+	}
+	spin_unlock_irqrestore(&rcu_global_queue.lock, flags);
+}
+
+static void rcu_offline_cpu(int cpu)
+{
+	/* if the cpu going offline owns the grace period
+	 * we can block indefinitely waiting for it, so flush
+	 * it here
+	 */
+	spin_lock_irq(&rcu_ctrlblk.mutex);
+	if (RCU_batch(cpu) == rcu_ctrlblk.curbatch) {
+		rcu_ctrlblk.curbatch++;
+		rcu_start_batch(rcu_ctrlblk.maxbatch);
+	}
+	spin_unlock_irq(&rcu_ctrlblk.mutex);
+
+	rcu_move_batch(&RCU_curlist(cpu));
+	rcu_move_batch(&RCU_nxtlist(cpu));
+	
+	BUG_ON(!list_empty(&RCU_curlist(cpu)));
+	BUG_ON(!list_empty(&RCU_nxtlist(cpu)));
+
+	tasklet_kill(&RCU_tasklet(cpu));
+        list_del_init(&RCU_curlist(cpu));
+        list_del_init(&RCU_nxtlist(cpu));
+       	memset(&per_cpu(rcu_data, cpu), 0, sizeof(struct rcu_data));
+}
+
 static int __devinit rcu_cpu_notify(struct notifier_block *self, 
 				unsigned long action, void *hcpu)
 {
@@ -215,7 +278,9 @@
 	case CPU_UP_PREPARE:
 		rcu_online_cpu(cpu);
 		break;
-	/* Space reserved for CPU_OFFLINE :) */
+	case CPU_DEAD:
+                rcu_offline_cpu(cpu);
+                break;
 	default:
 		break;
 	}
