Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267525AbSKQRJ1>; Sun, 17 Nov 2002 12:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267526AbSKQRJ1>; Sun, 17 Nov 2002 12:09:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62225 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267525AbSKQRJ0>;
	Sun, 17 Nov 2002 12:09:26 -0500
Date: Sun, 17 Nov 2002 17:16:25 +0000
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: [PATCH] Run timers as softirqs, not tasklets
Message-ID: <20021117171625.C7530@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Seems to me that the timer code is attempting to replicate the softirq
characteristics at the tasklet level, which is a little pointless.  This
patch converts timers to be a first-class softirq citizen.

Ingo, was there a reason you didn't do it this way to begin with?

diff -u linux-2.5.47-pci/include/linux/interrupt.h linux-2.5.47-pci/include/linux/interrupt.h
--- linux-2.5.47-pci/include/linux/interrupt.h	2002-11-16 22:28:40.000000000 -0500
+++ linux-2.5.47-pci/include/linux/interrupt.h	2002-11-17 11:23:25.000000000 -0500
@@ -45,6 +45,7 @@
 enum
 {
 	HI_SOFTIRQ=0,
+	TIMER_SOFTIRQ,
 	NET_TX_SOFTIRQ,
 	NET_RX_SOFTIRQ,
 	SCSI_SOFTIRQ,
--- linux-2.5.47/kernel/timer.c	2002-11-14 10:52:17.000000000 -0500
+++ linux-2.5.47-pci/kernel/timer.c	2002-11-17 11:27:30.000000000 -0500
@@ -66,9 +66,6 @@ typedef struct tvec_t_base_s tvec_base_t
 /* Fake initialization */
 static DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { SPIN_LOCK_UNLOCKED };
 
-/* Fake initialization needed to avoid compiler breakage */
-static DEFINE_PER_CPU(struct tasklet_struct, timer_tasklet) = { NULL };
-
 static void check_timer_failed(timer_t *timer)
 {
 	static int whine_count;
@@ -766,9 +763,9 @@ rwlock_t xtime_lock __cacheline_aligned_
 unsigned long last_time_offset;
 
 /*
- * This function runs timers and the timer-tq in softirq context.
+ * This function runs timers and the timer-tq in bottom half context.
  */
-static void run_timer_tasklet(unsigned long data)
+static void run_timer_softirq(struct softirq_action *h)
 {
 	tvec_base_t *base = &per_cpu(tvec_bases, smp_processor_id());
 
@@ -781,7 +778,7 @@ static void run_timer_tasklet(unsigned l
  */
 void run_local_timers(void)
 {
-	tasklet_hi_schedule(&per_cpu(timer_tasklet, smp_processor_id()));
+	raise_softirq(TIMER_SOFTIRQ);
 }
 
 /*
@@ -1140,7 +1137,6 @@ static void __devinit init_timers_cpu(in
 	}
 	for (j = 0; j < TVR_SIZE; j++)
 		INIT_LIST_HEAD(base->tv1.vec + j);
-	tasklet_init(&per_cpu(timer_tasklet, cpu), run_timer_tasklet, 0UL);
 }
 	
 static int __devinit timer_cpu_notify(struct notifier_block *self, 
@@ -1167,4 +1163,5 @@ void __init init_timers(void)
 	timer_cpu_notify(&timers_nb, (unsigned long)CPU_UP_PREPARE,
 				(void *)(long)smp_processor_id());
 	register_cpu_notifier(&timers_nb);
+	open_softirq(TIMER_SOFTIRQ, run_timer_softirq, NULL);
 }

-- 
Revolutions do not require corporate support.
