Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261789AbSIXUrD>; Tue, 24 Sep 2002 16:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261792AbSIXUp7>; Tue, 24 Sep 2002 16:45:59 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:40452
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261796AbSIXUpu>; Tue, 24 Sep 2002 16:45:50 -0400
Subject: [PATCH] per-cpu data preempt-safing
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-ahTzg9joQ0rarf1NgN6v"
Organization: 
Message-Id: <1032900657.1007.93.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1 (Preview Release)
Date: 24 Sep 2002 16:50:58 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ahTzg9joQ0rarf1NgN6v
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Linus,

Attached patch fixes unsafe access to per-CPU data via reordering of
instructions or use of "get_cpu()".

The following files were affected:

 include/linux/brlock.h     |    5 ++++-
 include/linux/netdevice.h  |   12 ++++++++----
 include/linux/page-flags.h |    6 +++---
 mm/highmem.c               |    2 ++
 4 files changed, 17 insertions(+), 8 deletions(-)

Before anyone balks at the brlock.h fix, note this was in the
alternative version of the code which is not used by default.

Patch is against current BK.  Please, apply.

	Robert Love


--=-ahTzg9joQ0rarf1NgN6v
Content-Description: 
Content-Disposition: attachment; filename=bad-smp_processor_id-uses-rml-2.5.38-1.patch
Content-Type: text/x-patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -urN linux-2.5.38/include/linux/brlock.h linux/include/linux/brlock.h
--- linux-2.5.38/include/linux/brlock.h	Sun Sep 22 00:25:06 2002
+++ linux/include/linux/brlock.h	Tue Sep 24 16:24:23 2002
@@ -85,7 +85,8 @@
 	if (idx >= __BR_END)
 		__br_lock_usage_bug();
 
-	read_lock(&__brlock_array[smp_processor_id()][idx]);
+	preempt_disable();
+	_raw_read_lock(&__brlock_array[smp_processor_id()][idx]);
 }
 
 static inline void br_read_unlock (enum brlock_indices idx)
@@ -109,6 +110,7 @@
 	if (idx >= __BR_END)
 		__br_lock_usage_bug();
 
+	preempt_disable();
 	ctr = &__brlock_array[smp_processor_id()][idx];
 	lock = &__br_write_locks[idx].lock;
 again:
@@ -147,6 +149,7 @@
 
 	wmb();
 	(*ctr)--;
+	preempt_enable();
 }
 #endif /* __BRLOCK_USE_ATOMICS */
 
diff -urN linux-2.5.38/include/linux/netdevice.h linux/include/linux/netdevice.h
--- linux-2.5.38/include/linux/netdevice.h	Sun Sep 22 00:25:27 2002
+++ linux/include/linux/netdevice.h	Tue Sep 24 16:24:23 2002
@@ -514,9 +514,10 @@
 {
 	if (!test_and_set_bit(__LINK_STATE_SCHED, &dev->state)) {
 		unsigned long flags;
-		int cpu = smp_processor_id();
+		int cpu;
 
 		local_irq_save(flags);
+		cpu = smp_processor_id();
 		dev->next_sched = softnet_data[cpu].output_queue;
 		softnet_data[cpu].output_queue = dev;
 		cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);
@@ -563,10 +564,11 @@
 static inline void dev_kfree_skb_irq(struct sk_buff *skb)
 {
 	if (atomic_dec_and_test(&skb->users)) {
-		int cpu =smp_processor_id();
+		int cpu;
 		unsigned long flags;
 
 		local_irq_save(flags);
+		cpu = smp_processor_id();
 		skb->next = softnet_data[cpu].completion_queue;
 		softnet_data[cpu].completion_queue = skb;
 		cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);
@@ -726,9 +728,10 @@
 static inline void __netif_rx_schedule(struct net_device *dev)
 {
 	unsigned long flags;
-	int cpu = smp_processor_id();
+	int cpu;
 
 	local_irq_save(flags);
+	cpu = smp_processor_id();
 	dev_hold(dev);
 	list_add_tail(&dev->poll_list, &softnet_data[cpu].poll_list);
 	if (dev->quota < 0)
@@ -754,11 +757,12 @@
 {
 	if (netif_rx_schedule_prep(dev)) {
 		unsigned long flags;
-		int cpu = smp_processor_id();
+		int cpu;
 
 		dev->quota += undo;
 
 		local_irq_save(flags);
+		cpu = smp_processor_id();
 		list_add_tail(&dev->poll_list, &softnet_data[cpu].poll_list);
 		__cpu_raise_softirq(cpu, NET_RX_SOFTIRQ);
 		local_irq_restore(flags);
diff -urN linux-2.5.38/include/linux/page-flags.h linux/include/linux/page-flags.h
--- linux-2.5.38/include/linux/page-flags.h	Sun Sep 22 00:25:16 2002
+++ linux/include/linux/page-flags.h	Tue Sep 24 16:24:23 2002
@@ -86,9 +86,9 @@
 
 #define mod_page_state(member, delta)					\
 	do {								\
-		preempt_disable();					\
-		page_states[smp_processor_id()].member += (delta);	\
-		preempt_enable();					\
+		int cpu = get_cpu();					\
+		page_states[cpu].member += (delta);			\
+		put_cpu();						\
 	} while (0)
 
 #define inc_page_state(member)	mod_page_state(member, 1UL)
diff -urN linux-2.5.38/mm/highmem.c linux/mm/highmem.c
--- linux-2.5.38/mm/highmem.c	Sun Sep 22 00:25:12 2002
+++ linux/mm/highmem.c	Tue Sep 24 16:24:23 2002
@@ -472,6 +472,7 @@
 {
 	int idx, type;
 
+	preempt_disable();
 	for (type = 0; type < KM_TYPE_NR; type++) {
 		idx = type + KM_TYPE_NR*smp_processor_id();
 		if (!pte_none(*(kmap_pte-idx))) {
@@ -479,6 +480,7 @@
 			BUG();
 		}
 	}
+	preempt_enable();
 }
 #endif
 

--=-ahTzg9joQ0rarf1NgN6v--

