Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSF2PMP>; Sat, 29 Jun 2002 11:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312962AbSF2PMO>; Sat, 29 Jun 2002 11:12:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4876 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S310190AbSF2PMN>;
	Sat, 29 Jun 2002 11:12:13 -0400
Date: Sat, 29 Jun 2002 16:14:36 +0100
From: Matthew Wilcox <willy@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Potential efficiency improvement to softirqs
Message-ID: <20020629161436.C927@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I notice that none of the current softirq routines use the data element
passed to them.  I'm having trouble thinking how the `data' element
could actually be useful.  However, both net_rx_action and net_tx_action
need to know the result of smp_processor_id which is already calculated
in do_softirq.  The softscsi patch I'm working on also needs to know it.

How would people feel about a patch along the following lines (untested,
copied & pasted so it definitely won't apply, etc, etc):

diff -urNX dontdiff linux-2.5.24/include/linux/interrupt.h linux-2.5.24-scsi/inc
lude/linux/interrupt.h
--- linux-2.5.24/include/linux/interrupt.h      Sat Jun 29 06:16:40 2002
+++ linux-2.5.24-scsi/include/linux/interrupt.h Sat Jun 29 09:09:43 2002
@@ -66,12 +67,11 @@
 
 struct softirq_action
 {
-       void    (*action)(struct softirq_action *);
-       void    *data;
+       void    (*action)(int cpu);
 };
 
 asmlinkage void do_softirq(void);
-extern void open_softirq(int nr, void (*action)(struct softirq_action*), void *
data);
+extern void open_softirq(int nr, void (*action)(int cpu));
 extern void softirq_init(void);
 #define __cpu_raise_softirq(cpu, nr) do { softirq_pending(cpu) |= 1UL << (nr); 
} while (0)
 extern void FASTCALL(cpu_raise_softirq(unsigned int cpu, unsigned int nr));
diff -urNX dontdiff linux-2.5.24/kernel/softirq.c linux-2.5.24-scsi/kernel/softi
rq.c
--- linux-2.5.24/kernel/softirq.c       Thu Jun 20 16:53:47 2002
+++ linux-2.5.24-scsi/kernel/softirq.c  Sat Jun 29 09:09:22 2002
@@ -61,7 +61,7 @@
 
 asmlinkage void do_softirq()
 {
-       unsigned long cpu;
+       int cpu;
        __u32 pending;
        long flags;
        __u32 mask;
@@ -89,7 +89,7 @@
 
                do {
                        if (pending & 1)
-                               h->action(h);
+                               h->action(cpu);
                        h++;
                        pending >>= 1;
                } while (pending);
@@ -139,9 +139,8 @@
        local_irq_restore(flags);
 }
 
-void open_softirq(int nr, void (*action)(struct softirq_action*), void *data)
+void open_softirq(int nr, void (*action)(int cpu))
 {
-       softirq_vec[nr].data = data;
        softirq_vec[nr].action = action;
 }
 
@@ -179,7 +178,7 @@
        local_irq_restore(flags);
 }
 
-static void tasklet_action(struct softirq_action *a)
+static void tasklet_action(int cpu)
 {
        struct tasklet_struct *list;
 
@@ -212,7 +211,7 @@
        }
 }
 
-static void tasklet_hi_action(struct softirq_action *a)
+static void tasklet_hi_action(int cpu)
 {
        struct tasklet_struct *list;
 
@@ -331,8 +330,8 @@
        for (i=0; i<32; i++)
                tasklet_init(bh_task_vec+i, bh_action, i);
 
-       open_softirq(TASKLET_SOFTIRQ, tasklet_action, NULL);
-       open_softirq(HI_SOFTIRQ, tasklet_hi_action, NULL);
+       open_softirq(TASKLET_SOFTIRQ, tasklet_action);
+       open_softirq(HI_SOFTIRQ, tasklet_hi_action);
 }
 
 void __run_task_queue(task_queue *list)
diff -urNX dontdiff linux-2.5.24/net/core/dev.c linux-2.5.24-scsi/net/core/dev.c
--- linux-2.5.24/net/core/dev.c Thu Jun 20 16:53:53 2002
+++ linux-2.5.24-scsi/net/core/dev.c    Sat Jun 29 09:10:38 2002
@@ -1333,10 +1333,8 @@
                skb->dev = dev->master;
 }
 
-static void net_tx_action(struct softirq_action *h)
+static void net_tx_action(int cpu)
 {
-       int cpu = smp_processor_id();
-
        if (softnet_data[cpu].completion_queue) {
                struct sk_buff *clist;
 
@@ -1573,9 +1571,8 @@
        return 0;
 }
 
-static void net_rx_action(struct softirq_action *h)
+static void net_rx_action(int this_cpu)
 {
-       int this_cpu = smp_processor_id();
        struct softnet_data *queue = &softnet_data[this_cpu];
        unsigned long start_time = jiffies;
        int budget = netdev_max_backlog;
@@ -2816,8 +2813,8 @@
 
        dev_boot_phase = 0;
 
-       open_softirq(NET_TX_SOFTIRQ, net_tx_action, NULL);
-       open_softirq(NET_RX_SOFTIRQ, net_rx_action, NULL);
+       open_softirq(NET_TX_SOFTIRQ, net_tx_action);
+       open_softirq(NET_RX_SOFTIRQ, net_rx_action);
 
        dst_init();
        dev_mcast_init();


-- 
Revolutions do not require corporate support.
