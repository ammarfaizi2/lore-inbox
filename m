Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbTGCIE2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 04:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265544AbTGCIE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 04:04:28 -0400
Received: from dp.samba.org ([66.70.73.150]:39810 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265100AbTGCIEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 04:04:11 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] Remove CPU arg from softirq functions, rename.
Date: Thu, 03 Jul 2003 18:10:37 +1000
Message-Id: <20030703081837.A8EF42C09B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The function cpu_raise_softirq() takes a softirq number, and a cpu number,
but cannot be used with cpu != smp_processor_id(), because there's no
locking around the pending softirq lists.  Since noone does this, remove
that arg.

As per Linus' suggestion, names changed:
	raise_softirq(int nr)
	cpu_raise_softirq(int cpu, int nr) -> raise_softirq_irqoff(int nr)
	__cpu_raise_softirq(int cpu, int nr) -> __raise_softirq_irqoff(int nr)

Name: Remove CPU arg from softirq functions
Author: Rusty Russell
Status: Tested on 2.5.74
Depends: Percpu/ksoftirqd_percpu.patch.gz

D: The function cpu_raise_softirq() takes a softirq number, and a cpu number,
D: but cannot be used with cpu != smp_processor_id(), because there's no
D: locking around the pending softirq lists.  Since noone does this, remove
D: that arg.
D:
D: As per Linus' suggestion, names changed:
D:	raise_softirq(int nr)
D:	cpu_raise_softirq(int cpu, int nr) -> raise_softirq_irqoff(int nr)
D:	__cpu_raise_softirq(int cpu, int nr) -> __raise_softirq_irqoff(int nr)

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27352-linux-2.5.73-bk9/drivers/scsi/scsi.c .27352-linux-2.5.73-bk9.updated/drivers/scsi/scsi.c
--- .27352-linux-2.5.73-bk9/drivers/scsi/scsi.c	2003-07-02 10:40:53.000000000 +1000
+++ .27352-linux-2.5.73-bk9.updated/drivers/scsi/scsi.c	2003-07-02 17:19:28.000000000 +1000
@@ -582,7 +582,7 @@ void scsi_done(struct scsi_cmnd *cmd)
 	local_irq_save(flags);
 	cpu = smp_processor_id();
 	list_add_tail(&cmd->eh_entry, &done_q[cpu]);
-	cpu_raise_softirq(cpu, SCSI_SOFTIRQ);
+	raise_softirq_irqoff(SCSI_SOFTIRQ);
 	local_irq_restore(flags);
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27352-linux-2.5.73-bk9/include/linux/interrupt.h .27352-linux-2.5.73-bk9.updated/include/linux/interrupt.h
--- .27352-linux-2.5.73-bk9/include/linux/interrupt.h	2003-05-27 15:02:21.000000000 +1000
+++ .27352-linux-2.5.73-bk9.updated/include/linux/interrupt.h	2003-07-02 17:17:58.000000000 +1000
@@ -94,8 +94,8 @@ struct softirq_action
 asmlinkage void do_softirq(void);
 extern void open_softirq(int nr, void (*action)(struct softirq_action*), void *data);
 extern void softirq_init(void);
-#define __cpu_raise_softirq(cpu, nr) do { softirq_pending(cpu) |= 1UL << (nr); } while (0)
-extern void FASTCALL(cpu_raise_softirq(unsigned int cpu, unsigned int nr));
+#define __raise_softirq_irqoff(nr) do { local_softirq_pending() |= 1UL << (nr); } while (0)
+extern void FASTCALL(raise_softirq_irqoff(unsigned int nr));
 extern void FASTCALL(raise_softirq(unsigned int nr));
 
 #ifndef invoke_softirq
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27352-linux-2.5.73-bk9/include/linux/netdevice.h .27352-linux-2.5.73-bk9.updated/include/linux/netdevice.h
--- .27352-linux-2.5.73-bk9/include/linux/netdevice.h	2003-07-02 10:40:56.000000000 +1000
+++ .27352-linux-2.5.73-bk9.updated/include/linux/netdevice.h	2003-07-02 17:20:08.000000000 +1000
@@ -561,7 +561,7 @@ static inline void __netif_schedule(stru
 		cpu = smp_processor_id();
 		dev->next_sched = softnet_data[cpu].output_queue;
 		softnet_data[cpu].output_queue = dev;
-		cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);
+		raise_softirq_irqoff(NET_TX_SOFTIRQ);
 		local_irq_restore(flags);
 	}
 }
@@ -612,7 +612,7 @@ static inline void dev_kfree_skb_irq(str
 		cpu = smp_processor_id();
 		skb->next = softnet_data[cpu].completion_queue;
 		softnet_data[cpu].completion_queue = skb;
-		cpu_raise_softirq(cpu, NET_TX_SOFTIRQ);
+		raise_softirq_irqoff(NET_TX_SOFTIRQ);
 		local_irq_restore(flags);
 	}
 }
@@ -779,7 +779,7 @@ static inline void __netif_rx_schedule(s
 		dev->quota += dev->weight;
 	else
 		dev->quota = dev->weight;
-	__cpu_raise_softirq(cpu, NET_RX_SOFTIRQ);
+	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
 	local_irq_restore(flags);
 }
 
@@ -805,7 +805,7 @@ static inline int netif_rx_reschedule(st
 		local_irq_save(flags);
 		cpu = smp_processor_id();
 		list_add_tail(&dev->poll_list, &softnet_data[cpu].poll_list);
-		__cpu_raise_softirq(cpu, NET_RX_SOFTIRQ);
+		__raise_softirq_irqoff(NET_RX_SOFTIRQ);
 		local_irq_restore(flags);
 		return 1;
 	}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27352-linux-2.5.73-bk9/kernel/ksyms.c .27352-linux-2.5.73-bk9.updated/kernel/ksyms.c
--- .27352-linux-2.5.73-bk9/kernel/ksyms.c	2003-07-02 10:40:57.000000000 +1000
+++ .27352-linux-2.5.73-bk9.updated/kernel/ksyms.c	2003-07-02 17:20:26.000000000 +1000
@@ -586,7 +586,7 @@ EXPORT_SYMBOL(tasklet_kill);
 EXPORT_SYMBOL(do_softirq);
 EXPORT_SYMBOL(raise_softirq);
 EXPORT_SYMBOL(open_softirq);
-EXPORT_SYMBOL(cpu_raise_softirq);
+EXPORT_SYMBOL(raise_softirq_irqoff);
 EXPORT_SYMBOL(__tasklet_schedule);
 EXPORT_SYMBOL(__tasklet_hi_schedule);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27352-linux-2.5.73-bk9/kernel/softirq.c .27352-linux-2.5.73-bk9.updated/kernel/softirq.c
--- .27352-linux-2.5.73-bk9/kernel/softirq.c	2003-07-02 17:17:27.000000000 +1000
+++ .27352-linux-2.5.73-bk9.updated/kernel/softirq.c	2003-07-02 17:21:08.000000000 +1000
@@ -121,9 +121,9 @@ EXPORT_SYMBOL(local_bh_enable);
 /*
  * This function must run with irqs disabled!
  */
-inline void cpu_raise_softirq(unsigned int cpu, unsigned int nr)
+inline void raise_softirq_irqoff(unsigned int nr)
 {
-	__cpu_raise_softirq(cpu, nr);
+	__raise_softirq_irqoff(nr);
 
 	/*
 	 * If we're in an interrupt or softirq, we're done
@@ -143,7 +143,7 @@ void raise_softirq(unsigned int nr)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	cpu_raise_softirq(smp_processor_id(), nr);
+	raise_softirq_irqoff(nr);
 	local_irq_restore(flags);
 }
 
@@ -172,7 +172,7 @@ void __tasklet_schedule(struct tasklet_s
 	local_irq_save(flags);
 	t->next = __get_cpu_var(tasklet_vec).list;
 	__get_cpu_var(tasklet_vec).list = t;
-	cpu_raise_softirq(smp_processor_id(), TASKLET_SOFTIRQ);
+	raise_softirq_irqoff(TASKLET_SOFTIRQ);
 	local_irq_restore(flags);
 }
 
@@ -183,7 +183,7 @@ void __tasklet_hi_schedule(struct taskle
 	local_irq_save(flags);
 	t->next = __get_cpu_var(tasklet_hi_vec).list;
 	__get_cpu_var(tasklet_hi_vec).list = t;
-	cpu_raise_softirq(smp_processor_id(), HI_SOFTIRQ);
+	raise_softirq_irqoff(HI_SOFTIRQ);
 	local_irq_restore(flags);
 }
 
@@ -215,7 +215,7 @@ static void tasklet_action(struct softir
 		local_irq_disable();
 		t->next = __get_cpu_var(tasklet_vec).list;
 		__get_cpu_var(tasklet_vec).list = t;
-		__cpu_raise_softirq(smp_processor_id(), TASKLET_SOFTIRQ);
+		__raise_softirq_irqoff(TASKLET_SOFTIRQ);
 		local_irq_enable();
 	}
 }
@@ -248,7 +248,7 @@ static void tasklet_hi_action(struct sof
 		local_irq_disable();
 		t->next = __get_cpu_var(tasklet_hi_vec).list;
 		__get_cpu_var(tasklet_hi_vec).list = t;
-		__cpu_raise_softirq(smp_processor_id(), HI_SOFTIRQ);
+		__raise_softirq_irqoff(HI_SOFTIRQ);
 		local_irq_enable();
 	}
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .27352-linux-2.5.73-bk9/net/core/dev.c .27352-linux-2.5.73-bk9.updated/net/core/dev.c
--- .27352-linux-2.5.73-bk9/net/core/dev.c	2003-07-02 10:40:57.000000000 +1000
+++ .27352-linux-2.5.73-bk9.updated/net/core/dev.c	2003-07-02 17:21:11.000000000 +1000
@@ -1712,7 +1712,7 @@ out:
 
 softnet_break:
 	netdev_rx_stat[this_cpu].time_squeeze++;
-	__cpu_raise_softirq(this_cpu, NET_RX_SOFTIRQ);
+	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
 	goto out;
 }
 

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
