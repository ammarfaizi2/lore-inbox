Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266004AbTGAGJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 02:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbTGAGJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 02:09:56 -0400
Received: from dp.samba.org ([66.70.73.150]:10889 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266004AbTGAGIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 02:08:53 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Remove "cpu" arg to cpu_raise_softirq().
Date: Tue, 01 Jul 2003 16:08:07 +1000
Message-Id: <20030701062315.5A2492C0B1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please reject if you want renaming as well.

The function cpu_raise_softirq() takes a softirq number, and a cpu number,
but cannot be used with cpu != smp_processor_id(), because there's no
locking around the pending softirq lists.  Since noone does this, remove
that arg.

I didn't change the name, but I dislike the layering:
	raise_softirq(int nr): completely general
	cpu_raise_softirq(int nr): must have interrupts off
	__cpu_raise_softirq(int nr): doesn't wake ksoftirqd

Better would be:
	raise_softirq(int nr): completely general
	__raise_softirq(int nr): must have interrupts off
	__raise_softirq_noksoftirqd(int nr): doesn't wake ksoftirqd

Feedback welcome!
Rusty.

Name: Remove CPU arg from softirq functions
Author: Rusty Russell
Status: Tested on 2.5.73-bk8
Depends: Percpu/ksoftirqd_percpu.patch.gz

D: The function cpu_raise_softirq() takes a softirq number, and a cpu number,
D: but cannot be used with cpu != smp_processor_id(), because there's no
D: locking around the pending softirq lists.  Since noone does this, remove
D: that arg.
D:
D: I didn't change the name, but I dislike the layering:
D:	raise_softirq(int nr): completely general
D:	cpu_raise_softirq(int nr): must have interrupts off
D:	__cpu_raise_softirq(int nr): doesn't wake ksoftirqd

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2637-2.5.73-bk3-softirq_local.pre/drivers/scsi/scsi.c .2637-2.5.73-bk3-softirq_local/drivers/scsi/scsi.c
--- .2637-2.5.73-bk3-softirq_local.pre/drivers/scsi/scsi.c	2003-06-23 10:52:50.000000000 +1000
+++ .2637-2.5.73-bk3-softirq_local/drivers/scsi/scsi.c	2003-06-26 16:04:32.000000000 +1000
@@ -582,7 +582,7 @@ void scsi_done(struct scsi_cmnd *cmd)
 	local_irq_save(flags);
 	cpu = smp_processor_id();
 	list_add_tail(&cmd->eh_entry, &done_q[cpu]);
-	cpu_raise_softirq(cpu, SCSI_SOFTIRQ);
+	cpu_raise_softirq(SCSI_SOFTIRQ);
 	local_irq_restore(flags);
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2637-2.5.73-bk3-softirq_local.pre/include/linux/interrupt.h .2637-2.5.73-bk3-softirq_local/include/linux/interrupt.h
--- .2637-2.5.73-bk3-softirq_local.pre/include/linux/interrupt.h	2003-05-27 15:02:21.000000000 +1000
+++ .2637-2.5.73-bk3-softirq_local/include/linux/interrupt.h	2003-06-26 16:04:32.000000000 +1000
@@ -94,8 +94,8 @@ struct softirq_action
 asmlinkage void do_softirq(void);
 extern void open_softirq(int nr, void (*action)(struct softirq_action*), void *data);
 extern void softirq_init(void);
-#define __cpu_raise_softirq(cpu, nr) do { softirq_pending(cpu) |= 1UL << (nr); } while (0)
-extern void FASTCALL(cpu_raise_softirq(unsigned int cpu, unsigned int nr));
+#define __cpu_raise_softirq(nr) do { local_softirq_pending() |= 1UL << (nr); } while (0)
+extern void FASTCALL(cpu_raise_softirq(unsigned int nr));
 extern void FASTCALL(raise_softirq(unsigned int nr));
 
 #ifndef invoke_softirq
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2637-2.5.73-bk3-softirq_local.pre/include/linux/netdevice.h .2637-2.5.73-bk3-softirq_local/include/linux/netdevice.h
--- .2637-2.5.73-bk3-softirq_local.pre/include/linux/netdevice.h	2003-06-23 10:52:58.000000000 +1000
+++ .2637-2.5.73-bk3-softirq_local/include/linux/netdevice.h	2003-06-26 16:04:32.000000000 +1000
@@ -555,7 +555,7 @@ static inline void __netif_schedule(stru
 		cpu = smp_processor_id();
 		dev->next_sched = softnet_data[cpu].output_queue;
 		softnet_data[cpu].output_queue = dev;
-		cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);
+		cpu_raise_softirq(NET_TX_SOFTIRQ);
 		local_irq_restore(flags);
 	}
 }
@@ -606,7 +606,7 @@ static inline void dev_kfree_skb_irq(str
 		cpu = smp_processor_id();
 		skb->next = softnet_data[cpu].completion_queue;
 		softnet_data[cpu].completion_queue = skb;
-		cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);
+		cpu_raise_softirq(NET_TX_SOFTIRQ);
 		local_irq_restore(flags);
 	}
 }
@@ -773,7 +773,7 @@ static inline void __netif_rx_schedule(s
 		dev->quota += dev->weight;
 	else
 		dev->quota = dev->weight;
-	__cpu_raise_softirq(cpu, NET_RX_SOFTIRQ);
+	__cpu_raise_softirq(NET_RX_SOFTIRQ);
 	local_irq_restore(flags);
 }
 
@@ -799,7 +799,7 @@ static inline int netif_rx_reschedule(st
 		local_irq_save(flags);
 		cpu = smp_processor_id();
 		list_add_tail(&dev->poll_list, &softnet_data[cpu].poll_list);
-		__cpu_raise_softirq(cpu, NET_RX_SOFTIRQ);
+		__cpu_raise_softirq(NET_RX_SOFTIRQ);
 		local_irq_restore(flags);
 		return 1;
 	}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2637-2.5.73-bk3-softirq_local.pre/kernel/softirq.c .2637-2.5.73-bk3-softirq_local/kernel/softirq.c
--- .2637-2.5.73-bk3-softirq_local.pre/kernel/softirq.c	2003-06-26 16:04:32.000000000 +1000
+++ .2637-2.5.73-bk3-softirq_local/kernel/softirq.c	2003-06-26 16:04:32.000000000 +1000
@@ -121,9 +121,9 @@ EXPORT_SYMBOL(local_bh_enable);
 /*
  * This function must run with irqs disabled!
  */
-inline void cpu_raise_softirq(unsigned int cpu, unsigned int nr)
+inline void cpu_raise_softirq(unsigned int nr)
 {
-	__cpu_raise_softirq(cpu, nr);
+	__cpu_raise_softirq(nr);
 
 	/*
 	 * If we're in an interrupt or softirq, we're done
@@ -143,7 +143,7 @@ void raise_softirq(unsigned int nr)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	cpu_raise_softirq(smp_processor_id(), nr);
+	cpu_raise_softirq(nr);
 	local_irq_restore(flags);
 }
 
@@ -172,7 +172,7 @@ void __tasklet_schedule(struct tasklet_s
 	local_irq_save(flags);
 	t->next = __get_cpu_var(tasklet_vec).list;
 	__get_cpu_var(tasklet_vec).list = t;
-	cpu_raise_softirq(smp_processor_id(), TASKLET_SOFTIRQ);
+	cpu_raise_softirq(TASKLET_SOFTIRQ);
 	local_irq_restore(flags);
 }
 
@@ -183,7 +183,7 @@ void __tasklet_hi_schedule(struct taskle
 	local_irq_save(flags);
 	t->next = __get_cpu_var(tasklet_hi_vec).list;
 	__get_cpu_var(tasklet_hi_vec).list = t;
-	cpu_raise_softirq(smp_processor_id(), HI_SOFTIRQ);
+	cpu_raise_softirq(HI_SOFTIRQ);
 	local_irq_restore(flags);
 }
 
@@ -215,7 +215,7 @@ static void tasklet_action(struct softir
 		local_irq_disable();
 		t->next = __get_cpu_var(tasklet_vec).list;
 		__get_cpu_var(tasklet_vec).list = t;
-		__cpu_raise_softirq(smp_processor_id(), TASKLET_SOFTIRQ);
+		__cpu_raise_softirq(TASKLET_SOFTIRQ);
 		local_irq_enable();
 	}
 }
@@ -248,7 +248,7 @@ static void tasklet_hi_action(struct sof
 		local_irq_disable();
 		t->next = __get_cpu_var(tasklet_hi_vec).list;
 		__get_cpu_var(tasklet_hi_vec).list = t;
-		__cpu_raise_softirq(smp_processor_id(), HI_SOFTIRQ);
+		__cpu_raise_softirq(HI_SOFTIRQ);
 		local_irq_enable();
 	}
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .2637-2.5.73-bk3-softirq_local.pre/net/core/dev.c .2637-2.5.73-bk3-softirq_local/net/core/dev.c
--- .2637-2.5.73-bk3-softirq_local.pre/net/core/dev.c	2003-06-23 10:52:59.000000000 +1000
+++ .2637-2.5.73-bk3-softirq_local/net/core/dev.c	2003-06-26 16:04:32.000000000 +1000
@@ -1712,7 +1712,7 @@ out:
 
 softnet_break:
 	netdev_rx_stat[this_cpu].time_squeeze++;
-	__cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
+	__cpu_raise_softirq(NET_RX_SOFTIRQ);
 	goto out;
 }
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
