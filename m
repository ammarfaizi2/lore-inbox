Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319239AbSH2PaW>; Thu, 29 Aug 2002 11:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319237AbSH2P3t>; Thu, 29 Aug 2002 11:29:49 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:57351
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319234AbSH2P2k>; Thu, 29 Aug 2002 11:28:40 -0400
Subject: [PATCH] misc. kernel preemption bits
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Aug 2002 11:33:01 -0400
Message-Id: <1030635181.978.2559.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Misc. kernel preemption-related bits.  Specifically,

	- update to Documentation/preempt-locking.txt (me)

	- preempt-safe arch/i386/kernel/ioport.c :: sys_ioperm()
	  (George Anzinger)

	- remove "kernel_lock()" cruft in include/linux/smp.h
	  (Andrew Morton)

	- we have a debug check in preempt_schedule that, even
	  on detecting a schedule with irqs disabled, still goes
	  ahead and reschedules.  We should return. (me)

	- preempt-safe net/core/dev.c :: netif_rx() (George Anzinger)

All fairly trivial and/or simple.  Patch is against 2.5.32-bk.  Please,
apply.

	Robert Love

diff -urN linux-2.5.32/Documentation/preempt-locking.txt linux/Documentation/preempt-locking.txt
--- linux-2.5.32/Documentation/preempt-locking.txt	Tue Aug 27 15:26:32 2002
+++ linux/Documentation/preempt-locking.txt	Wed Aug 28 23:23:30 2002
@@ -1,7 +1,7 @@
 		  Proper Locking Under a Preemptible Kernel:
 		       Keeping Kernel Code Preempt-Safe
-			  Robert Love <rml@tech9.net>
-			   Last Updated: 22 Jan 2002
+			 Robert Love <rml@tech9.net>
+			  Last Updated: 28 Aug 2002
 

 INTRODUCTION
@@ -112,3 +112,24 @@
 
 This code is not preempt-safe, but see how easily we can fix it by simply
 moving the spin_lock up two lines.
+
+
+PREVENTING PREEMPTION USING INTERRUPT DISABLING
+
+
+It is possible to prevent a preemption event using local_irq_disable and
+local_irq_save.  Note, when doing so, you must be very careful to not cause
+an event that would set need_resched and result in a preemption check.  When
+in doubt, rely on locking or explicit preemption disabling.
+
+Note in 2.5 interrupt disabling is now only per-CPU (e.g. local).
+
+An additional concern is proper usage of local_irq_disable and local_irq_save.
+These may be used to protect from preemption, however, on exit, if preemption
+may be enabled, a test to see if preemption is required should be done.  If
+these are called from the spin_lock and read/write lock macros, the right thing
+is done.  They may also be called within a spin-lock protected region, however,
+if they are ever called outside of this context, a test for preemption should
+be made. Do note that calls from interrupt context or bottom half/ tasklets
+are also protected by preemption locks and so may use the versions which do
+not check preemption.
diff -urN linux-2.5.32/arch/i386/kernel/ioport.c linux/arch/i386/kernel/ioport.c
--- linux-2.5.32/arch/i386/kernel/ioport.c	Tue Aug 27 15:26:42 2002
+++ linux/arch/i386/kernel/ioport.c	Wed Aug 28 23:23:30 2002
@@ -55,12 +55,16 @@
 asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int turn_on)
 {
 	struct thread_struct * t = &current->thread;
-	struct tss_struct * tss = init_tss + smp_processor_id();
+	struct tss_struct * tss;
+	int ret = 0;
 
 	if ((from + num <= from) || (from + num > IO_BITMAP_SIZE*32))
 		return -EINVAL;
 	if (turn_on && !capable(CAP_SYS_RAWIO))
 		return -EPERM;
+
+	tss = init_tss + get_cpu();
+
 	/*
 	 * If it's the first ioperm() call in this thread's lifetime, set the
 	 * IO bitmap up. ioperm() is much less timing critical than clone(),
@@ -69,8 +73,11 @@
 	if (!t->ts_io_bitmap) {
 		unsigned long *bitmap;
 		bitmap = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
-		if (!bitmap)
-			return -ENOMEM;
+		if (!bitmap) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
 		/*
 		 * just in case ...
 		 */
@@ -88,7 +95,9 @@
 	set_bitmap(t->ts_io_bitmap, from, num, !turn_on);
 	set_bitmap(tss->io_bitmap, from, num, !turn_on);
 
-	return 0;
+out:
+	put_cpu();
+	return ret;
 }
 
 /*
diff -urN linux-2.5.32/include/linux/smp.h linux/include/linux/smp.h
--- linux-2.5.32/include/linux/smp.h	Tue Aug 27 15:26:43 2002
+++ linux/include/linux/smp.h	Wed Aug 28 23:23:30 2002
@@ -87,9 +87,6 @@
 #define smp_processor_id()			0
 #define hard_smp_processor_id()			0
 #define smp_threads_ready			1
-#ifndef CONFIG_PREEMPT
-#define kernel_lock()
-#endif
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
diff -urN linux-2.5.32/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.32/kernel/sched.c	Tue Aug 27 15:26:37 2002
+++ linux/kernel/sched.c	Wed Aug 28 23:23:24 2002
@@ -1039,6 +1039,7 @@
 		printk("bad: schedule() with irqs disabled!\n");
 		show_stack(NULL);
 		preempt_enable_no_resched();
+		return;
 	}
 
 need_resched:
diff -urN linux-2.5.32/net/core/dev.c linux/net/core/dev.c
--- linux-2.5.32/net/core/dev.c	Tue Aug 27 15:26:43 2002
+++ linux/net/core/dev.c	Wed Aug 28 23:23:30 2002
@@ -1229,19 +1229,20 @@
 
 int netif_rx(struct sk_buff *skb)
 {
-	int this_cpu = smp_processor_id();
+	int this_cpu;
 	struct softnet_data *queue;
 	unsigned long flags;
 
 	if (!skb->stamp.tv_sec)
 		do_gettimeofday(&skb->stamp);
 
-	/* The code is rearranged so that the path is the most
-	   short when CPU is congested, but is still operating.
+	/*
+	 * The code is rearranged so that the path is the most
+	 * short when CPU is congested, but is still operating.
 	 */
-	queue = &softnet_data[this_cpu];
-
 	local_irq_save(flags);
+	this_cpu = smp_processor_id();
+	queue = &softnet_data[this_cpu];
 
 	netdev_rx_stat[this_cpu].total++;
 	if (queue->input_pkt_queue.qlen <= netdev_max_backlog) {
@@ -1252,10 +1253,10 @@
 enqueue:
 			dev_hold(skb->dev);
 			__skb_queue_tail(&queue->input_pkt_queue, skb);
-			local_irq_restore(flags);
 #ifndef OFFLINE_SAMPLE
 			get_sample_stats(this_cpu);
 #endif
+			local_irq_restore(flags);
 			return queue->cng_level;
 		}
 



