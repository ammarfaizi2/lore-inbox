Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262234AbVBKKEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbVBKKEp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 05:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbVBKKEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 05:04:44 -0500
Received: from mx2.elte.hu ([157.181.151.9]:63633 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262234AbVBKKEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 05:04:13 -0500
Date: Fri, 11 Feb 2005 11:04:05 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Sven Dietrich <sdietrich@mvista.com>
Cc: george@mvista.com, "'William Weston'" <weston@lysdexia.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050211100405.GA7452@elte.hu>
References: <20050211082841.GA3349@elte.hu> <000601c5101f$8ca3c1e0$c800a8c0@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000601c5101f$8ca3c1e0$c800a8c0@mvista.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Sven Dietrich <sdietrich@mvista.com> wrote:

> > this patch only changes xtime_lock back and forth - it does 
> > in no way impact the 'threadedness' of the timer IRQ. (it 
> > does not move the timer IRQ into an interrupt thread.)
> > 
> > nor do we really want to make it configurable - it's 
> > non-threaded right now and we'll see what effect this has on 
> > the worst-case latencies. 
> 
> Its clear that there are all sorts of issues with process accounting
> and other race conditions associated with running the timer in a
> thread.
> 
> The timer IRQ does have a noticable impact especially on the slower
> CPUS. In this domain, precise process time accounting may not be all
> that important, as long as the scheduler does not get confused, and
> that lone NODELAY IRQ doesn't get delayed (as much).

well, i saved the delta when i removed threaded timer IRQs, find the
patch below, apply it with -R to -RT-V0.7.37-00 to get threaded irqs
back on x86.

Right now i dont plan to reintroduce threaded timer IRQs because it
causes architecture merging problems (e.g. on x64 and MIPS) and also
caused artifacts. So the complexity vs. latency benefit is not all that
clear, especially at this stage. Also note that there were unsolved
problems wrt. time handling in the threaded setup.

(we can try it again later on. But if we do so it will have to be an
all-or-nothing item - #ifdef hell and behavioral divergence is to be
avoided.)

	Ingo

--- linux.old/Makefile	
+++ linux.new/Makefile	
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 11
-EXTRAVERSION =-rc2-RT-V0.7.36-06
+EXTRAVERSION =-rc2-RT-V0.7.37-00
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
--- linux.old/arch/i386/kernel/irq.c	
+++ linux.new/arch/i386/kernel/irq.c	
@@ -70,8 +70,6 @@ fastcall notrace unsigned int do_IRQ(str
 		}
 	}
 #endif
-	if (unlikely(!irq))
-		direct_timer_interrupt(regs);
 
 #ifdef CONFIG_4KSTACKS
 
--- linux.old/arch/i386/kernel/time.c	
+++ linux.new/arch/i386/kernel/time.c	
@@ -82,7 +82,7 @@ unsigned long cpu_khz;	/* Detected as we
 
 extern unsigned long wall_jiffies;
 
-DEFINE_SPINLOCK(rtc_lock);
+DEFINE_RAW_SPINLOCK(rtc_lock);
 
 #include <asm/i8253.h>
 
@@ -217,19 +217,6 @@ unsigned long notrace profile_pc(struct 
 EXPORT_SYMBOL(profile_pc);
 #endif
 
-#ifdef CONFIG_PREEMPT_HARDIRQS
-
-/*
- * If the timer is redirected then this is the minimal
- * interrupt-context processing we have to do:
- */
-void direct_timer_interrupt(struct pt_regs *regs)
-{
-	do_timer_interrupt_hook(regs);
-}
-
-#endif
-
 /*
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
@@ -254,9 +241,7 @@ static inline void do_timer_interrupt(in
 	}
 #endif
 
-#ifndef CONFIG_PREEMPT_HARDIRQS
 	do_timer_interrupt_hook(regs);
-#endif
 
 	/*
 	 * If we have an externally synchronized Linux clock, then update
@@ -313,7 +298,6 @@ irqreturn_t timer_interrupt(int irq, voi
 	write_seqlock(&xtime_lock);
 
 	cur_timer->mark_offset();
-	do_timer(regs);
  
 	do_timer_interrupt(irq, NULL, regs);
 
--- linux.old/arch/i386/mach-default/setup.c	
+++ linux.new/arch/i386/mach-default/setup.c	
@@ -71,7 +71,7 @@ void __init trap_init_hook(void)
 {
 }
 
-static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
+static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT | SA_NODELAY, CPU_MASK_NONE, "timer", NULL, NULL};
 
 /**
  * time_init_hook - do any specific initialisations for the system timer.
--- linux.old/drivers/char/rtc.c	
+++ linux.new/drivers/char/rtc.c	
@@ -380,6 +380,8 @@ static inline void rtc_close_event(void)
 
 irqreturn_t rtc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
+	int mod;
+
 	/*
 	 *	Can be an alarm interrupt, update complete interrupt,
 	 *	or a periodic interrupt. We store the status in the
@@ -401,10 +403,13 @@ irqreturn_t rtc_interrupt(int irq, void 
 		rtc_irq_data |= (CMOS_READ(RTC_INTR_FLAGS) & 0xF0);
 	}
 
+	mod = 0;
 	if (rtc_status & RTC_TIMER_ON)
-		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
+		mod = 1;
 
 	spin_unlock (&rtc_lock);
+	if (mod)
+		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
 
 	/* Now do the rest of the actions */
 	spin_lock(&rtc_task_lock);
@@ -569,8 +574,8 @@ static int rtc_do_ioctl(unsigned int cmd
 		if (rtc_status & RTC_TIMER_ON) {
 			spin_lock_irq (&rtc_lock);
 			rtc_status &= ~RTC_TIMER_ON;
-			del_timer(&rtc_irq_timer);
 			spin_unlock_irq (&rtc_lock);
+			del_timer(&rtc_irq_timer);
 		}
 		return 0;
 	}
@@ -588,9 +593,9 @@ static int rtc_do_ioctl(unsigned int cmd
 		if (!(rtc_status & RTC_TIMER_ON)) {
 			spin_lock_irq (&rtc_lock);
 			rtc_irq_timer.expires = jiffies + HZ/rtc_freq + 2*HZ/100;
-			add_timer(&rtc_irq_timer);
 			rtc_status |= RTC_TIMER_ON;
 			spin_unlock_irq (&rtc_lock);
+			add_timer(&rtc_irq_timer);
 		}
 		set_rtc_irq_bit(RTC_PIE);
 		return 0;
@@ -882,6 +887,7 @@ static int rtc_release(struct inode *ino
 {
 #ifdef RTC_IRQ
 	unsigned char tmp;
+	int del;
 
 	if (rtc_has_irq == 0)
 		goto no_irq;
@@ -900,11 +906,14 @@ static int rtc_release(struct inode *ino
 		CMOS_WRITE(tmp, RTC_CONTROL);
 		CMOS_READ(RTC_INTR_FLAGS);
 	}
+	del = 0;
 	if (rtc_status & RTC_TIMER_ON) {
 		rtc_status &= ~RTC_TIMER_ON;
-		del_timer(&rtc_irq_timer);
+		del = 1;
 	}
 	spin_unlock_irq(&rtc_lock);
+	if (del)
+		del_timer(&rtc_irq_timer);
 
 	if (file->f_flags & FASYNC) {
 		rtc_fasync (-1, file, 0);
@@ -981,6 +990,7 @@ int rtc_unregister(rtc_task_t *task)
 	return -EIO;
 #else
 	unsigned char tmp;
+	int del;
 
 	spin_lock_irq(&rtc_lock);
 	spin_lock(&rtc_task_lock);
@@ -1000,12 +1010,15 @@ int rtc_unregister(rtc_task_t *task)
 		CMOS_WRITE(tmp, RTC_CONTROL);
 		CMOS_READ(RTC_INTR_FLAGS);
 	}
+	del = 0;
 	if (rtc_status & RTC_TIMER_ON) {
 		rtc_status &= ~RTC_TIMER_ON;
-		del_timer(&rtc_irq_timer);
+		del = 1;
 	}
 	rtc_status &= ~RTC_IS_OPEN;
 	spin_unlock(&rtc_task_lock);
+	if (del)
+		del_timer(&rtc_irq_timer);
 	spin_unlock_irq(&rtc_lock);
 	return 0;
 #endif
@@ -1254,6 +1267,7 @@ module_exit(rtc_exit);
 static void rtc_dropped_irq(unsigned long data)
 {
 	unsigned long freq;
+	int mod;
 
 	spin_lock_irq (&rtc_lock);
 
@@ -1263,8 +1277,9 @@ static void rtc_dropped_irq(unsigned lon
 	}
 
 	/* Just in case someone disabled the timer from behind our back... */
+	mod = 0;
 	if (rtc_status & RTC_TIMER_ON)
-		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
+		mod = 1;
 
 	rtc_irq_data += ((rtc_freq/HZ)<<8);
 	rtc_irq_data &= ~0xff;
@@ -1273,6 +1288,8 @@ static void rtc_dropped_irq(unsigned lon
 	freq = rtc_freq;
 
 	spin_unlock_irq(&rtc_lock);
+	if (mod)
+		mod_timer(&rtc_irq_timer, jiffies + HZ/rtc_freq + 2*HZ/100);
 
 	printk(KERN_WARNING "rtc: lost some interrupts at %ldHz.\n", freq);
 
--- linux.old/include/asm-i386/mach-default/do_timer.h	
+++ linux.new/include/asm-i386/mach-default/do_timer.h	
@@ -16,6 +16,7 @@
 
 static inline void do_timer_interrupt_hook(struct pt_regs *regs)
 {
+	do_timer(regs);
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
--- linux.old/include/linux/mc146818rtc.h	
+++ linux.new/include/linux/mc146818rtc.h	
@@ -17,7 +17,7 @@
 
 #ifdef __KERNEL__
 #include <linux/spinlock.h>		/* spinlock_t */
-extern spinlock_t rtc_lock;		/* serialize CMOS RAM access */
+extern raw_spinlock_t rtc_lock;		/* serialize CMOS RAM access */
 #endif
 
 /**********************************************************************
--- linux.old/include/linux/sched.h	
+++ linux.new/include/linux/sched.h	
@@ -39,10 +39,8 @@ extern int softirq_preemption;
 #endif
 #ifdef CONFIG_PREEMPT_HARDIRQS
 extern int hardirq_preemption;
-extern void direct_timer_interrupt(struct pt_regs *regs);
 #else
 # define hardirq_preemption 0
-# define direct_timer_interrupt(regs) do { } while (0)
 #endif
 
 #ifdef CONFIG_PREEMPT_BKL
--- linux.old/include/linux/time.h	
+++ linux.new/include/linux/time.h	
@@ -80,7 +80,7 @@ mktime (unsigned int year, unsigned int 
 
 extern struct timespec xtime;
 extern struct timespec wall_to_monotonic;
-extern seqlock_t xtime_lock;
+extern raw_seqlock_t xtime_lock;
 
 static inline unsigned long get_seconds(void)
 { 
--- linux.old/kernel/timer.c	
+++ linux.new/kernel/timer.c	
@@ -852,14 +852,7 @@ void update_process_times(int user_tick)
  */
 static unsigned long count_active_tasks(void)
 {
-#ifdef CONFIG_PREEMPT_RT
-	/*
-	 * -1 for the timer IRQ thread:
-	 */
-	return (nr_running() - 1 + nr_uninterruptible()) * FIXED_1;
-#else
 	return (nr_running() + nr_uninterruptible()) * FIXED_1;
-#endif
 }
 
 /*
@@ -899,7 +892,7 @@ unsigned long wall_jiffies = INITIAL_JIF
  * playing with xtime and avenrun.
  */
 #ifndef ARCH_HAVE_XTIME_LOCK
-DECLARE_SEQLOCK(xtime_lock);
+DECLARE_RAW_SEQLOCK(xtime_lock);
 
 EXPORT_SYMBOL(xtime_lock);
 #endif
