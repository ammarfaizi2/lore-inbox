Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317950AbSHDQXS>; Sun, 4 Aug 2002 12:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317960AbSHDQXS>; Sun, 4 Aug 2002 12:23:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1028 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317950AbSHDQXQ>;
	Sun, 4 Aug 2002 12:23:16 -0400
Date: Sun, 4 Aug 2002 17:26:50 +0100
From: Matthew Wilcox <willy@debian.org>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: softirq parameters
Message-ID: <20020804172650.N24631@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


what do you guys think about this patch?  nobody's using the data argument
to the softirq routines, but most of the routines want to know which
CPU they're running on.

also, we have:

static struct softirq_action softirq_vec[32] __cacheline_aligned_in_smp;

and i rather wonder why we cache-align them.  they only get initialised at
startup (kernel or module init), so this cacheline must be in shared state.

diff -urpNX dontdiff linux-2.5.30/drivers/scsi/scsi.c linux-2.5.30-willy/drivers/scsi/scsi.c
--- linux-2.5.30/drivers/scsi/scsi.c	2002-07-06 07:21:00.000000000 -0600
+++ linux-2.5.30-willy/drivers/scsi/scsi.c	2002-08-04 08:26:13.000000000 -0600
@@ -1192,9 +1192,8 @@ void scsi_done(Scsi_Cmnd * SCpnt)
  * interrupt latency, stack depth, and reentrancy of the low-level
  * drivers.
  */
-static void scsi_softirq(struct softirq_action *h)
+static void scsi_softirq(int cpu)
 {
-	int cpu = smp_processor_id();
 	struct softscsi_data *queue = &softscsi_data[cpu];
 
 	while (queue->head) {
@@ -2567,7 +2566,7 @@ static int __init init_scsi(void)
 	bus_register(&scsi_driverfs_bus_type);
 
 	/* Where we handle work queued by scsi_done */
-	open_softirq(SCSI_SOFTIRQ, scsi_softirq, NULL);
+	open_softirq(SCSI_SOFTIRQ, scsi_softirq);
 
 	return 0;
 }
diff -urpNX dontdiff linux-2.5.30/include/linux/interrupt.h linux-2.5.30-willy/include/linux/interrupt.h
--- linux-2.5.30/include/linux/interrupt.h	2002-07-27 12:09:21.000000000 -0600
+++ linux-2.5.30-willy/include/linux/interrupt.h	2002-07-27 12:12:52.000000000 -0600
@@ -77,12 +77,11 @@ enum
 
 struct softirq_action
 {
-	void	(*action)(struct softirq_action *);
-	void	*data;
+	void	(*action)(int cpu);
 };
 
 asmlinkage void do_softirq(void);
-extern void open_softirq(int nr, void (*action)(struct softirq_action*), void *data);
+extern void open_softirq(int nr, void (*action)(int cpu));
 extern void softirq_init(void);
 #define __cpu_raise_softirq(cpu, nr) do { softirq_pending(cpu) |= 1UL << (nr); } while (0)
 extern void FASTCALL(cpu_raise_softirq(unsigned int cpu, unsigned int nr));
diff -urpNX dontdiff linux-2.5.30/kernel/softirq.c linux-2.5.30-willy/kernel/softirq.c
--- linux-2.5.30/kernel/softirq.c	2002-08-02 05:44:53.000000000 -0600
+++ linux-2.5.30-willy/kernel/softirq.c	2002-08-02 05:45:35.000000000 -0600
@@ -86,7 +86,7 @@ restart:
 
 		do {
 			if (pending & 1)
-				h->action(h);
+				h->action(cpu);
 			h++;
 			pending >>= 1;
 		} while (pending);
@@ -136,9 +136,8 @@ void raise_softirq(unsigned int nr)
 	local_irq_restore(flags);
 }
 
-void open_softirq(int nr, void (*action)(struct softirq_action*), void *data)
+void open_softirq(int nr, void (*action)(int cpu))
 {
-	softirq_vec[nr].data = data;
 	softirq_vec[nr].action = action;
 }
 
@@ -176,7 +175,7 @@ void __tasklet_hi_schedule(struct taskle
 	local_irq_restore(flags);
 }
 
-static void tasklet_action(struct softirq_action *a)
+static void tasklet_action(int cpu)
 {
 	struct tasklet_struct *list;
 
@@ -209,7 +208,7 @@ static void tasklet_action(struct softir
 	}
 }
 
-static void tasklet_hi_action(struct softirq_action *a)
+static void tasklet_hi_action(int cpu)
 {
 	struct tasklet_struct *list;
 
@@ -321,8 +320,8 @@ void __init softirq_init()
 	for (i=0; i<32; i++)
 		tasklet_init(bh_task_vec+i, bh_action, i);
 
-	open_softirq(TASKLET_SOFTIRQ, tasklet_action, NULL);
-	open_softirq(HI_SOFTIRQ, tasklet_hi_action, NULL);
+	open_softirq(TASKLET_SOFTIRQ, tasklet_action);
+	open_softirq(HI_SOFTIRQ, tasklet_hi_action);
 }
 
 void __run_task_queue(task_queue *list)
diff -urpNX dontdiff linux-2.5.30/net/core/dev.c linux-2.5.30-willy/net/core/dev.c
--- linux-2.5.30/net/core/dev.c	2002-06-20 16:53:53.000000000 -0600
+++ linux-2.5.30-willy/net/core/dev.c	2002-06-29 09:10:38.000000000 -0600
@@ -1333,10 +1333,8 @@ static __inline__ void skb_bond(struct s
 		skb->dev = dev->master;
 }
 
-static void net_tx_action(struct softirq_action *h)
+static void net_tx_action(int cpu)
 {
-	int cpu = smp_processor_id();
-
 	if (softnet_data[cpu].completion_queue) {
 		struct sk_buff *clist;
 
@@ -1573,9 +1571,8 @@ job_done:
 	return 0;
 }
 
-static void net_rx_action(struct softirq_action *h)
+static void net_rx_action(int this_cpu)
 {
-	int this_cpu = smp_processor_id();
 	struct softnet_data *queue = &softnet_data[this_cpu];
 	unsigned long start_time = jiffies;
 	int budget = netdev_max_backlog;
@@ -2816,8 +2813,8 @@ static int __init net_dev_init(void)
 
 	dev_boot_phase = 0;
 
-	open_softirq(NET_TX_SOFTIRQ, net_tx_action, NULL);
-	open_softirq(NET_RX_SOFTIRQ, net_rx_action, NULL);
+	open_softirq(NET_TX_SOFTIRQ, net_tx_action);
+	open_softirq(NET_RX_SOFTIRQ, net_rx_action);
 
 	dst_init();
 	dev_mcast_init();

-- 
Revolutions do not require corporate support.
