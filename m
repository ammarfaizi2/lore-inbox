Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261338AbTC0UsH>; Thu, 27 Mar 2003 15:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261339AbTC0UsH>; Thu, 27 Mar 2003 15:48:07 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2023 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261338AbTC0UsB>;
	Thu, 27 Mar 2003 15:48:01 -0500
Date: Thu, 27 Mar 2003 12:55:07 -0800 (PST)
Message-Id: <20030327.125507.104718048.davem@redhat.com>
To: torvalds@transmeta.com
Cc: dane@aiinet.com, shmulik.hen@intel.com,
       bonding-devel@lists.sourceforge.net,
       bonding-announce@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       mingo@redhat.com, kuznet@ms2.inr.ac.ru
Subject: Re: BUG or not? GFP_KERNEL with interrupts disabled.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030327.113933.123322481.davem@redhat.com>
References: <20030327.111012.23672715.davem@redhat.com>
	<Pine.LNX.4.44.0303271120230.31459-100000@home.transmeta.com>
	<20030327.113933.123322481.davem@redhat.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "David S. Miller" <davem@redhat.com>
   Date: Thu, 27 Mar 2003 11:39:33 -0800 (PST)

      From: Linus Torvalds <torvalds@transmeta.com>
      Date: Thu, 27 Mar 2003 11:22:55 -0800 (PST)
   
      	if (gfp_mask & __GFP_WAIT)
      		might_sleep();
      
      and might_sleep() should be updated.
      
      Anybody want to try that and see whether things break horribly?
   
   I hadn't considered this, good idea.  I'm trying this out right now.
   
Ok, I'm running this now and it appears to work.

i386 will need similar changes to it's irq_exit() call sites.

One might_sleep still triggers, the cpufreq_register_notifier() call
during boot.  It takes a rwsem.  This will trigger on i386 too with
TSC and CPUFREQ both enabled.

Oh yeah, the fbcon cursor thing triggers too, but that's been
discussed to death in another thread and hopefully a fix will
be pushed upstream soon by the fbcon guys.

--- ./arch/sparc64/kernel/smp.c.~1~	Thu Mar 27 11:57:41 2003
+++ ./arch/sparc64/kernel/smp.c	Thu Mar 27 12:05:46 2003
@@ -1055,11 +1055,10 @@ void smp_percpu_timer_interrupt(struct p
 		clear_softint(tick_mask);
 	}
 
+	irq_enter();
 	do {
 		sparc64_do_profile(regs);
 		if (!--prof_counter(cpu)) {
-			irq_enter();
-
 			if (cpu == boot_cpu_id) {
 				kstat_cpu(cpu).irqs[0]++;
 				timer_tick_interrupt(regs);
@@ -1067,7 +1066,6 @@ void smp_percpu_timer_interrupt(struct p
 
 			update_process_times(user);
 
-			irq_exit();
 
 			prof_counter(cpu) = prof_multiplier(cpu);
 		}
@@ -1088,6 +1086,9 @@ void smp_percpu_timer_interrupt(struct p
 				     : /* no outputs */
 				     : "r" (pstate));
 	} while (time_after_eq(tick, compare));
+
+	local_irq_enable();
+	irq_exit();
 }
 
 static void __init smp_setup_percpu_timer(void)
--- ./arch/sparc64/kernel/irq.c.~1~	Thu Mar 27 11:57:41 2003
+++ ./arch/sparc64/kernel/irq.c	Thu Mar 27 12:42:13 2003
@@ -356,7 +356,7 @@ int request_irq(unsigned int irq, void (
 	}	
 	if (action == NULL)
 	    action = (struct irqaction *)kmalloc(sizeof(struct irqaction),
-						 GFP_KERNEL);
+						 GFP_ATOMIC);
 	
 	if (!action) { 
 		spin_unlock_irqrestore(&irq_action_lock, flags);
@@ -376,7 +376,7 @@ int request_irq(unsigned int irq, void (
 				goto free_and_ebusy;
 			}
 			if ((bucket->flags & IBF_MULTI) == 0) {
-				vector = kmalloc(sizeof(void *) * 4, GFP_KERNEL);
+				vector = kmalloc(sizeof(void *) * 4, GFP_ATOMIC);
 				if (vector == NULL)
 					goto free_and_enomem;
 
@@ -793,6 +793,7 @@ void handler_irq(int irq, struct pt_regs
 
 		bp->flags &= ~IBF_INPROGRESS;
 	}
+	local_irq_enable();
 	irq_exit();
 }
 
@@ -900,7 +901,7 @@ int request_fast_irq(unsigned int irq,
 	}
 	if (action == NULL)
 		action = (struct irqaction *)kmalloc(sizeof(struct irqaction),
-						     GFP_KERNEL);
+						     GFP_ATOMIC);
 	if (!action) {
 		spin_unlock_irqrestore(&irq_action_lock, flags);
 		return -ENOMEM;
--- ./arch/sparc64/kernel/traps.c.~1~	Thu Mar 27 12:13:23 2003
+++ ./arch/sparc64/kernel/traps.c	Thu Mar 27 12:15:53 2003
@@ -1575,6 +1575,9 @@ void show_trace_raw(struct thread_info *
 	struct reg_window *rw;
 	int count = 0;
 
+	if (tp == current_thread_info())
+		flushw_all();
+
 	fp = ksp + STACK_BIAS;
 	thread_base = (unsigned long) tp;
 	do {
@@ -1595,6 +1598,15 @@ void show_trace_task(struct task_struct 
 	if (tsk)
 		show_trace_raw(tsk->thread_info,
 			       tsk->thread_info->ksp);
+}
+
+void dump_stack(void)
+{
+	unsigned long ksp;
+
+	__asm__ __volatile__("mov	%%fp, %0"
+			     : "=r" (ksp));
+	show_trace_raw(current_thread_info(), ksp);
 }
 
 void die_if_kernel(char *str, struct pt_regs *regs)
--- ./kernel/sched.c.~1~	Thu Mar 27 11:27:01 2003
+++ ./kernel/sched.c	Thu Mar 27 11:27:41 2003
@@ -2554,7 +2554,7 @@ void __might_sleep(char *file, int line)
 #if defined(in_atomic)
 	static unsigned long prev_jiffy;	/* ratelimiting */
 
-	if (in_atomic()) {
+	if (in_atomic() || irqs_disabled()) {
 		if (time_before(jiffies, prev_jiffy + HZ))
 			return;
 		prev_jiffy = jiffies;
--- ./kernel/softirq.c.~1~	Thu Mar 27 11:28:20 2003
+++ ./kernel/softirq.c	Thu Mar 27 11:52:35 2003
@@ -60,6 +60,9 @@ asmlinkage void do_softirq()
 	if (in_interrupt())
 		return;
 
+	if (irqs_disabled())
+		BUG();
+
 	local_irq_save(flags);
 	cpu = smp_processor_id();
 
--- ./net/core/skbuff.c.~1~	Thu Mar 27 11:28:53 2003
+++ ./net/core/skbuff.c	Thu Mar 27 11:29:12 2003
@@ -170,15 +170,8 @@ struct sk_buff *alloc_skb(unsigned int s
 	struct sk_buff *skb;
 	u8 *data;
 
-	if (in_interrupt() && (gfp_mask & __GFP_WAIT)) {
-		static int count;
-		if (++count < 5) {
-			printk(KERN_ERR "alloc_skb called nonatomically "
-			       "from interrupt %p\n", NET_CALLER(size));
- 			BUG();
-		}
-		gfp_mask &= ~__GFP_WAIT;
-	}
+	if (gfp_mask & __GFP_WAIT)
+		might_sleep();
 
 	/* Get the HEAD */
 	skb = skb_head_from_pool();
