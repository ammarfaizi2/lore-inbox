Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUJIGBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUJIGBY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 02:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266560AbUJIGBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 02:01:24 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:57588 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266517AbUJIFsH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 01:48:07 -0400
Message-ID: <41677E87.9060400@mvista.com>
Date: Fri, 08 Oct 2004 23:00:39 -0700
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: ext-rt-dev@mvista.com
Subject: [ANNOUNCE] Linux 2.6 Real Time Kernel - 3 (Spinlock Patch 1)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  RT Prototype 2004 (C) MontaVista Software, Inc.
  This file is licensed under the terms of the GNU
  General Public License version 2. This program
  is licensed "as is" without any warranty of any kind,
  whether express or implied.


Linux-2.6.9-rc3_RT_spinlock[12].patch
=====================================
                                                                                
These are 2 patches substituting mutexes with spinlocks
in the RT kernel.
                                                                                
A number of spinlocks, especially those protecting scheduler
run queues, and some protecting hardware, notably the system timer,
cannot be substituted with mutexes.
                                                                                
These patches create a partitioning between low-level spinlocks
and mutexes in the kernel. There are some holes existing in this
partitioning in the current release.
                                                                                
As discussed in the introductory email, this can result in deadlock
situations, if a process first locks a spinlock, and then suspends
on a contended mutex. We are in the process of resolving these issues.
                                                                                
New configuration options include:
                                                                                
CONFIG_KMUTEX
                                                                                
Substitutes mutexes for the spinlock_t, and remaps corresponding
operations to mutex_lock, and mutex_unlock.
                                                                                
CONFIG_KMUTEX_STATS
                                                                                
This enables locking time tracing and other (incomplete) analysis
features.
                                                                                
CONFIG_KMUTEX_DEBUG
                                                                                
Enables additional debugging output
                                                                                
CONFIG_KMUTEX_ATOMIC_DEBUG
                                                                                
Warns while locking a mutex when the process is running with
preemption disabled ("bad: scheduling while atomic")
                                                                                
PMutex configuration:
                                                                                
CONFIG_PMUTEX
                                                                                
Enable PMutex subsystem

CONFIG_PMUTEX_PI
                                                                                
Enable priority inheritance
                                                                                
CONFIG_PMUTEX_PI_DEBUG
                                                                                
Report PI events (noisy)
 
                                                                               
Sign-off: Sven-Thorsten Dietrich (sdietrich@mvista.com)



diff -pruN a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
--- a/arch/i386/kernel/apic.c	2004-10-08 22:39:58.000000000 +0400
+++ b/arch/i386/kernel/apic.c	2004-10-09 01:26:54.000000000 +0400
@@ -39,6 +39,8 @@
 
 #include "io_ports.h"
 
+#include <linux/spin_undefs.h>
+
 /*
  * Debug level
  */
diff -pruN a/arch/i386/kernel/apm.c b/arch/i386/kernel/apm.c
--- a/arch/i386/kernel/apm.c	2004-10-08 22:39:58.000000000 +0400
+++ b/arch/i386/kernel/apm.c	2004-10-09 01:26:54.000000000 +0400
@@ -231,7 +231,7 @@
 
 #include "io_ports.h"
 
-extern spinlock_t i8253_lock;
+extern _spinlock_t i8253_lock;
 extern unsigned long get_cmos_time(void);
 extern void machine_real_restart(unsigned char *, int);
 
@@ -1169,9 +1169,8 @@ static void reinit_timer(void)
 {
 #ifdef INIT_TIMER_AFTER_SUSPEND
 	unsigned long	flags;
-	extern spinlock_t i8253_lock;
 
-	spin_lock_irqsave(&i8253_lock, flags);
+	_spin_lock_irqsave(&i8253_lock, flags);
 	/* set the clock to 100 Hz */
 	outb_p(0x34, PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
 	udelay(10);
@@ -1179,7 +1178,7 @@ static void reinit_timer(void)
 	udelay(10);
 	outb(LATCH >> 8, PIT_CH0);	/* MSB */
 	udelay(10);
-	spin_unlock_irqrestore(&i8253_lock, flags);
+	_spin_unlock_irqrestore(&i8253_lock, flags);
 #endif
 }
 
@@ -1208,14 +1207,14 @@ static int suspend(int vetoable)
 	write_seqlock_irq(&xtime_lock);
 
 	/* protect against access to timer chip registers */
-	spin_lock(&i8253_lock);
+	_spin_lock(&i8253_lock);
 
 	get_time_diff();
 	/*
 	 * Irq spinlock must be dropped around set_system_power_state.
 	 * We'll undo any timer changes due to interrupts below.
 	 */
-	spin_unlock(&i8253_lock);
+	_spin_unlock(&i8253_lock);
 	write_sequnlock_irq(&xtime_lock);
 
 	save_processor_state();
@@ -1223,12 +1222,12 @@ static int suspend(int vetoable)
 	restore_processor_state();
 
 	write_seqlock_irq(&xtime_lock);
-	spin_lock(&i8253_lock);
+	_spin_lock(&i8253_lock);
 	reinit_timer();
 	set_time();
 	ignore_normal_resume = 1;
 
-	spin_unlock(&i8253_lock);
+	_spin_unlock(&i8253_lock);
 	write_sequnlock_irq(&xtime_lock);
 
 	if (err == APM_NO_ERROR)
diff -pruN a/arch/i386/kernel/i8259.c b/arch/i386/kernel/i8259.c
--- a/arch/i386/kernel/i8259.c	2004-10-09 00:36:39.000000000 +0400
+++ b/arch/i386/kernel/i8259.c	2004-10-09 01:26:54.000000000 +0400
@@ -38,7 +38,7 @@
  * moves to arch independent land
  */
 
-spinlock_t i8259A_lock = SPIN_LOCK_UNLOCKED;
+_spinlock_t i8259A_lock = _SPIN_LOCK_UNLOCKED;
 
 static void end_8259A_irq (unsigned int irq)
 {
@@ -93,13 +93,13 @@ void disable_8259A_irq(unsigned int irq)
 	unsigned int mask = 1 << irq;
 	unsigned long flags;
 
-	spin_lock_irqsave(&i8259A_lock, flags);
+	_spin_lock_irqsave(&i8259A_lock, flags);
 	cached_irq_mask |= mask;
 	if (irq & 8)
 		outb(cached_slave_mask, PIC_SLAVE_IMR);
 	else
 		outb(cached_master_mask, PIC_MASTER_IMR);
-	spin_unlock_irqrestore(&i8259A_lock, flags);
+	_spin_unlock_irqrestore(&i8259A_lock, flags);
 }
 
 void enable_8259A_irq(unsigned int irq)
@@ -107,13 +107,13 @@ void enable_8259A_irq(unsigned int irq)
 	unsigned int mask = ~(1 << irq);
 	unsigned long flags;
 
-	spin_lock_irqsave(&i8259A_lock, flags);
+	_spin_lock_irqsave(&i8259A_lock, flags);
 	cached_irq_mask &= mask;
 	if (irq & 8)
 		outb(cached_slave_mask, PIC_SLAVE_IMR);
 	else
 		outb(cached_master_mask, PIC_MASTER_IMR);
-	spin_unlock_irqrestore(&i8259A_lock, flags);
+	_spin_unlock_irqrestore(&i8259A_lock, flags);
 }
 
 int i8259A_irq_pending(unsigned int irq)
@@ -122,12 +122,12 @@ int i8259A_irq_pending(unsigned int irq)
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&i8259A_lock, flags);
+	_spin_lock_irqsave(&i8259A_lock, flags);
 	if (irq < 8)
 		ret = inb(PIC_MASTER_CMD) & mask;
 	else
 		ret = inb(PIC_SLAVE_CMD) & (mask >> 8);
-	spin_unlock_irqrestore(&i8259A_lock, flags);
+	_spin_unlock_irqrestore(&i8259A_lock, flags);
 
 	return ret;
 }
@@ -174,7 +174,7 @@ void mask_and_ack_8259A(unsigned int irq
 	unsigned int irqmask = 1 << irq;
 	unsigned long flags;
 
-	spin_lock_irqsave(&i8259A_lock, flags);
+	_spin_lock_irqsave(&i8259A_lock, flags);
 	/*
 	 * Lightweight spurious IRQ detection. We do not want
 	 * to overdo spurious IRQ handling - it's usually a sign
@@ -205,7 +205,7 @@ handle_real_irq:
 		outb(cached_master_mask, PIC_MASTER_IMR);
 		outb(0x60+irq,PIC_MASTER_CMD);	/* 'Specific EOI to master */
 	}
-	spin_unlock_irqrestore(&i8259A_lock, flags);
+	_spin_unlock_irqrestore(&i8259A_lock, flags);
 	return;
 
 spurious_8259A_irq:
@@ -294,7 +294,7 @@ void init_8259A(int auto_eoi)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&i8259A_lock, flags);
+	_spin_lock_irqsave(&i8259A_lock, flags);
 
 	outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
 	outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-2 */
@@ -328,7 +328,7 @@ void init_8259A(int auto_eoi)
 	outb(cached_master_mask, PIC_MASTER_IMR); /* restore master IRQ mask */
 	outb(cached_slave_mask, PIC_SLAVE_IMR);	  /* restore slave IRQ mask */
 
-	spin_unlock_irqrestore(&i8259A_lock, flags);
+	_spin_unlock_irqrestore(&i8259A_lock, flags);
 }
 
 /*
diff -pruN a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	2004-10-08 22:39:59.000000000 +0400
+++ b/arch/i386/kernel/io_apic.c	2004-10-09 01:26:54.000000000 +0400
@@ -42,6 +42,8 @@
 
 #include "io_ports.h"
 
+# include <linux/spin_undefs.h>
+
 static spinlock_t ioapic_lock = SPIN_LOCK_UNLOCKED;
 
 /*
diff -pruN a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	2004-10-09 00:36:39.000000000 +0400
+++ b/arch/i386/kernel/irq.c	2004-10-09 01:26:54.000000000 +0400
@@ -47,6 +47,8 @@
 
 static DECLARE_MUTEX(probe_sem);
 
+#include <linux/spin_undefs.h>
+
 /*
  * Linux has a controller-independent x86 interrupt architecture.
  * every controller has a 'controller-template', that is used
diff -pruN a/arch/i386/kernel/semaphore.c b/arch/i386/kernel/semaphore.c
--- a/arch/i386/kernel/semaphore.c	2004-08-14 09:36:56.000000000 +0400
+++ b/arch/i386/kernel/semaphore.c	2004-10-09 01:26:54.000000000 +0400
@@ -18,6 +18,8 @@
 #include <linux/init.h>
 #include <asm/semaphore.h>
 
+#include <linux/spin_undefs.h>
+
 /*
  * Semaphores are implemented using a two-way counter:
  * The "count" variable is decremented for each process
diff -pruN a/arch/i386/kernel/signal.c b/arch/i386/kernel/signal.c
--- a/arch/i386/kernel/signal.c	2004-10-08 22:39:59.000000000 +0400
+++ b/arch/i386/kernel/signal.c	2004-10-09 01:26:54.000000000 +0400
@@ -41,11 +41,11 @@ sys_sigsuspend(int history0, int history
 	sigset_t saveset;
 
 	mask &= _BLOCKABLE;
-	spin_lock_irq(&current->sighand->siglock);
+	_spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	siginitset(&current->blocked, mask);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	_spin_unlock_irq(&current->sighand->siglock);
 
 	regs->eax = -EINTR;
 	while (1) {
@@ -69,11 +69,11 @@ sys_rt_sigsuspend(struct pt_regs regs)
 		return -EFAULT;
 	sigdelsetmask(&newset, ~_BLOCKABLE);
 
-	spin_lock_irq(&current->sighand->siglock);
+	_spin_lock_irq(&current->sighand->siglock);
 	saveset = current->blocked;
 	current->blocked = newset;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	_spin_unlock_irq(&current->sighand->siglock);
 
 	regs.eax = -EINTR;
 	while (1) {
@@ -216,10 +216,10 @@ asmlinkage int sys_sigreturn(unsigned lo
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sighand->siglock);
+	_spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	_spin_unlock_irq(&current->sighand->siglock);
 	
 	if (restore_sigcontext(regs, &frame->sc, &eax))
 		goto badframe;
@@ -243,10 +243,10 @@ asmlinkage int sys_rt_sigreturn(unsigned
 		goto badframe;
 
 	sigdelsetmask(&set, ~_BLOCKABLE);
-	spin_lock_irq(&current->sighand->siglock);
+	_spin_lock_irq(&current->sighand->siglock);
 	current->blocked = set;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	_spin_unlock_irq(&current->sighand->siglock);
 	
 	if (restore_sigcontext(regs, &frame->uc.uc_mcontext, &eax))
 		goto badframe;
@@ -557,11 +557,11 @@ handle_signal(unsigned long sig, siginfo
 		setup_frame(sig, ka, oldset, regs);
 
 	if (!(ka->sa.sa_flags & SA_NODEFER)) {
-		spin_lock_irq(&current->sighand->siglock);
+		_spin_lock_irq(&current->sighand->siglock);
 		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
-		spin_unlock_irq(&current->sighand->siglock);
+		_spin_unlock_irq(&current->sighand->siglock);
 	}
 }
 
diff -pruN a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	2004-10-08 22:39:59.000000000 +0400
+++ b/arch/i386/kernel/time.c	2004-10-09 01:26:54.000000000 +0400
@@ -67,7 +67,8 @@
 
 #include "io_ports.h"
 
-extern spinlock_t i8259A_lock;
+extern _spinlock_t i8259A_lock;
+
 int pit_latch_buggy;              /* extern */
 
 #include "do_timer.h"
@@ -82,7 +83,7 @@ extern unsigned long wall_jiffies;
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
 
-spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
+_spinlock_t i8253_lock = _SPIN_LOCK_UNLOCKED;
 EXPORT_SYMBOL(i8253_lock);
 
 struct timer_opts *cur_timer = &timer_none;
@@ -228,11 +229,11 @@ static inline void do_timer_interrupt(in
 		 * This will also deassert NMI lines for the watchdog if run
 		 * on an 82489DX-based system.
 		 */
-		spin_lock(&i8259A_lock);
+		_spin_lock(&i8259A_lock);
 		outb(0x0c, PIC_MASTER_OCW3);
 		/* Ack the IRQ; AEOI will end it automatically. */
 		inb(PIC_MASTER_POLL);
-		spin_unlock(&i8259A_lock);
+		_spin_unlock(&i8259A_lock);
 	}
 #endif
 
diff -pruN a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	2004-08-14 09:37:26.000000000 +0400
+++ b/arch/i386/kernel/timers/timer_cyclone.c	2004-10-09 01:26:54.000000000 +0400
@@ -19,7 +19,7 @@
 #include <asm/fixmap.h>
 #include "io_ports.h"
 
-extern spinlock_t i8253_lock;
+extern _spinlock_t i8253_lock;
 
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
@@ -55,7 +55,7 @@ static void mark_offset_cyclone(void)
 	write_seqlock(&monotonic_lock);
 	last_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
 	
-	spin_lock(&i8253_lock);
+	_spin_lock(&i8253_lock);
 	read_cyclone_counter(last_cyclone_low,last_cyclone_high);
 
 	/* read values for delay_at_last_interrupt */
@@ -74,7 +74,7 @@ static void mark_offset_cyclone(void)
 		outb(LATCH >> 8, PIT_CH0);
 		count = LATCH - 1;
 	}
-	spin_unlock(&i8253_lock);
+	_spin_unlock(&i8253_lock);
 
 	/* lost tick compensation */
 	delta = last_cyclone_low - delta;	
diff -pruN a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer_pit.c
--- a/arch/i386/kernel/timers/timer_pit.c	2004-10-08 22:39:59.000000000 +0400
+++ b/arch/i386/kernel/timers/timer_pit.c	2004-10-09 01:26:54.000000000 +0400
@@ -16,8 +16,8 @@
 #include <asm/io.h>
 #include <asm/arch_hooks.h>
 
-extern spinlock_t i8259A_lock;
-extern spinlock_t i8253_lock;
+extern _spinlock_t i8259A_lock;
+extern _spinlock_t i8253_lock;
 #include "do_timer.h"
 #include "io_ports.h"
 
@@ -100,7 +100,7 @@ static unsigned long get_offset_pit(void
 	 */
 	unsigned long jiffies_t;
 
-	spin_lock_irqsave(&i8253_lock, flags);
+	_spin_lock_irqsave(&i8253_lock, flags);
 	/* timer count may underflow right here */
 	outb_p(0x00, PIT_MODE);	/* latch the count ASAP */
 
@@ -141,7 +141,7 @@ static unsigned long get_offset_pit(void
 
 	count_p = count;
 
-	spin_unlock_irqrestore(&i8253_lock, flags);
+	_spin_unlock_irqrestore(&i8253_lock, flags);
 
 	count = ((LATCH-1) - count) * TICK_SIZE;
 	count = (count + LATCH/2) / LATCH;
@@ -162,16 +162,16 @@ struct timer_opts timer_pit = {
 
 void setup_pit_timer(void)
 {
-	extern spinlock_t i8253_lock;
+	extern _spinlock_t i8253_lock;
 	unsigned long flags;
 
-	spin_lock_irqsave(&i8253_lock, flags);
+	_spin_lock_irqsave(&i8253_lock, flags);
 	outb_p(0x34,PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
 	udelay(10);
 	outb_p(LATCH & 0xff , PIT_CH0);	/* LSB */
 	udelay(10);
 	outb(LATCH >> 8 , PIT_CH0);	/* MSB */
-	spin_unlock_irqrestore(&i8253_lock, flags);
+	_spin_unlock_irqrestore(&i8253_lock, flags);
 }
 
 static int timer_resume(struct sys_device *dev)
diff -pruN a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	2004-10-08 22:39:59.000000000 +0400
+++ b/arch/i386/kernel/timers/timer_tsc.c	2004-10-09 01:26:54.000000000 +0400
@@ -35,7 +35,7 @@ static inline void cpufreq_delayed_get(v
 
 int tsc_disable __initdata = 0;
 
-extern spinlock_t i8253_lock;
+extern _spinlock_t i8253_lock;
 
 static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
@@ -348,7 +348,7 @@ static void mark_offset_tsc(void)
 
 	rdtsc(last_tsc_low, last_tsc_high);
 
-	spin_lock(&i8253_lock);
+	_spin_lock(&i8253_lock);
 	outb_p(0x00, PIT_MODE);     /* latch the count ASAP */
 
 	count = inb_p(PIT_CH0);    /* read the latched count */
@@ -365,7 +365,7 @@ static void mark_offset_tsc(void)
 		count = LATCH - 1;
 	}
 
-	spin_unlock(&i8253_lock);
+	_spin_unlock(&i8253_lock);
 
 	if (pit_latch_buggy) {
 		/* get center value of last 3 time lutch */
diff -pruN a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
--- a/arch/i386/kernel/traps.c	2004-10-08 22:39:59.000000000 +0400
+++ b/arch/i386/kernel/traps.c	2004-10-09 01:26:55.000000000 +0400
@@ -311,11 +311,11 @@ bug:
 void die(const char * str, struct pt_regs * regs, long err)
 {
 	static struct {
-		spinlock_t lock;
+		_spinlock_t lock;
 		u32 lock_owner;
 		int lock_owner_depth;
 	} die = {
-		.lock =			SPIN_LOCK_UNLOCKED,
+		.lock =			_SPIN_LOCK_UNLOCKED,
 		.lock_owner =		-1,
 		.lock_owner_depth =	0
 	};
@@ -323,7 +323,7 @@ void die(const char * str, struct pt_reg
 
 	if (die.lock_owner != smp_processor_id()) {
 		console_verbose();
-		spin_lock_irq(&die.lock);
+		_spin_lock_irq(&die.lock);
 		die.lock_owner = smp_processor_id();
 		die.lock_owner_depth = 0;
 		bust_spinlocks(1);
@@ -354,7 +354,7 @@ void die(const char * str, struct pt_reg
 
 	bust_spinlocks(0);
 	die.lock_owner = -1;
-	spin_unlock_irq(&die.lock);
+	_spin_unlock_irq(&die.lock);
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 
diff -pruN a/arch/i386/kernel/vm86.c b/arch/i386/kernel/vm86.c
--- a/arch/i386/kernel/vm86.c	2004-10-08 22:39:59.000000000 +0400
+++ b/arch/i386/kernel/vm86.c	2004-10-09 01:26:55.000000000 +0400
@@ -142,7 +142,7 @@ static void mark_screen_rdonly(struct ta
 	int i;
 
 	preempt_disable();
-	spin_lock(&tsk->mm->page_table_lock);
+	_spin_lock(&tsk->mm->page_table_lock);
 	pgd = pgd_offset(tsk->mm, 0xA0000);
 	if (pgd_none(*pgd))
 		goto out;
@@ -167,7 +167,7 @@ static void mark_screen_rdonly(struct ta
 	}
 	pte_unmap(mapped);
 out:
-	spin_unlock(&tsk->mm->page_table_lock);
+	_spin_unlock(&tsk->mm->page_table_lock);
 	preempt_enable();
 	flush_tlb();
 }
@@ -532,10 +532,10 @@ int handle_vm86_trap(struct kernel_vm86_
 		return 1; /* we let this handle by the calling routine */
 	if (current->ptrace & PT_PTRACED) {
 		unsigned long flags;
-		spin_lock_irqsave(&current->sighand->siglock, flags);
+		_spin_lock_irqsave(&current->sighand->siglock, flags);
 		sigdelset(&current->blocked, SIGTRAP);
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+		_spin_unlock_irqrestore(&current->sighand->siglock, flags);
 	}
 	send_sig(SIGTRAP, current, 1);
 	current->thread.trap_no = trapno;
diff -pruN a/arch/i386/lib/dec_and_lock.c b/arch/i386/lib/dec_and_lock.c
--- a/arch/i386/lib/dec_and_lock.c	2004-08-14 09:36:32.000000000 +0400
+++ b/arch/i386/lib/dec_and_lock.c	2004-10-09 01:26:55.000000000 +0400
@@ -10,7 +10,7 @@
 #include <linux/spinlock.h>
 #include <asm/atomic.h>
 
-int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
+int _atomic_dec_and_lock(atomic_t *atomic, _spinlock_t *lock)
 {
 	int counter;
 	int newcount;
@@ -32,9 +32,11 @@ repeat:
 	return 0;
 
 slow_path:
-	spin_lock(lock);
+	_spin_lock(lock);
 	if (atomic_dec_and_test(atomic))
 		return 1;
-	spin_unlock(lock);
+	_spin_unlock(lock);
 	return 0;
 }
+
+
diff -pruN a/arch/i386/mach-visws/visws_apic.c b/arch/i386/mach-visws/visws_apic.c
--- a/arch/i386/mach-visws/visws_apic.c	2004-08-14 09:36:13.000000000 +0400
+++ b/arch/i386/mach-visws/visws_apic.c	2004-10-09 01:26:55.000000000 +0400
@@ -199,7 +199,7 @@ static irqreturn_t piix4_master_intr(int
 	irq_desc_t *desc;
 	unsigned long flags;
 
-	spin_lock_irqsave(&i8259A_lock, flags);
+	_spin_lock_irqsave(&i8259A_lock, flags);
 
 	/* Find out what's interrupting in the PIIX4 master 8259 */
 	outb(0x0c, 0x20);		/* OCW3 Poll command */
@@ -236,7 +236,7 @@ static irqreturn_t piix4_master_intr(int
 		outb(0x60 + realirq, 0x20);
 	}
 
-	spin_unlock_irqrestore(&i8259A_lock, flags);
+	_spin_unlock_irqrestore(&i8259A_lock, flags);
 
 	desc = irq_desc + realirq;
 
@@ -254,7 +254,7 @@ static irqreturn_t piix4_master_intr(int
 	return IRQ_HANDLED;
 
 out_unlock:
-	spin_unlock_irqrestore(&i8259A_lock, flags);
+	_spin_unlock_irqrestore(&i8259A_lock, flags);
 	return IRQ_NONE;
 }
 
diff -pruN a/arch/i386/mach-voyager/voyager_basic.c b/arch/i386/mach-voyager/voyager_basic.c
--- a/arch/i386/mach-voyager/voyager_basic.c	2004-08-14 09:36:32.000000000 +0400
+++ b/arch/i386/mach-voyager/voyager_basic.c	2004-10-09 01:26:55.000000000 +0400
@@ -31,6 +31,8 @@
 #include <asm/tlbflush.h>
 #include <asm/arch_hooks.h>
 
+
+# include <linux/spin_undefs.h>
 /*
  * Power off function, if any
  */
diff -pruN a/arch/i386/mm/hugetlbpage.c b/arch/i386/mm/hugetlbpage.c
--- a/arch/i386/mm/hugetlbpage.c	2004-08-14 09:37:42.000000000 +0400
+++ b/arch/i386/mm/hugetlbpage.c	2004-10-09 01:26:55.000000000 +0400
@@ -19,6 +19,8 @@
 #include <asm/tlbflush.h>
 
 static pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr)
+ # include <linux/spin_undefs.h>
+
 {
 	pgd_t *pgd;
 	pmd_t *pmd = NULL;
diff -pruN a/arch/i386/mm/ioremap.c b/arch/i386/mm/ioremap.c
--- a/arch/i386/mm/ioremap.c	2004-10-08 22:39:59.000000000 +0400
+++ b/arch/i386/mm/ioremap.c	2004-10-09 01:26:55.000000000 +0400
@@ -18,6 +18,8 @@
 #include <asm/pgtable.h>
 
 static inline void remap_area_pte(pte_t * pte, unsigned long address, unsigned long size,
+# include <linux/spin_undefs.h>
+
 	unsigned long phys_addr, unsigned long flags)
 {
 	unsigned long end;
diff -pruN a/arch/i386/mm/pageattr.c b/arch/i386/mm/pageattr.c
--- a/arch/i386/mm/pageattr.c	2004-10-08 22:39:59.000000000 +0400
+++ b/arch/i386/mm/pageattr.c	2004-10-09 01:26:55.000000000 +0400
@@ -13,7 +13,7 @@
 #include <asm/processor.h>
 #include <asm/tlbflush.h>
 
-static spinlock_t cpa_lock = SPIN_LOCK_UNLOCKED;
+static _spinlock_t cpa_lock = _SPIN_LOCK_UNLOCKED;
 static struct list_head df_list = LIST_HEAD_INIT(df_list);
 
 
@@ -38,9 +38,9 @@ static struct page *split_large_page(uns
 	struct page *base;
 	pte_t *pbase;
 
-	spin_unlock_irq(&cpa_lock);
+	_spin_unlock_irq(&cpa_lock);
 	base = alloc_pages(GFP_KERNEL, 0);
-	spin_lock_irq(&cpa_lock);
+	_spin_lock_irq(&cpa_lock);
 	if (!base) 
 		return NULL;
 
@@ -74,7 +74,7 @@ static void set_pmd_pte(pte_t *kpte, uns
 	if (PTRS_PER_PMD > 1)
 		return;
 
-	spin_lock_irqsave(&pgd_lock, flags);
+	_spin_lock_irqsave(&pgd_lock, flags);
 	for (page = pgd_list; page; page = (struct page *)page->index) {
 		pgd_t *pgd;
 		pmd_t *pmd;
@@ -82,7 +82,7 @@ static void set_pmd_pte(pte_t *kpte, uns
 		pmd = pmd_offset(pgd, address);
 		set_pte_atomic((pte_t *)pmd, pte);
 	}
-	spin_unlock_irqrestore(&pgd_lock, flags);
+	_spin_unlock_irqrestore(&pgd_lock, flags);
 }
 
 /* 
@@ -165,13 +165,13 @@ int change_page_attr(struct page *page, 
 	int i; 
 	unsigned long flags;
 
-	spin_lock_irqsave(&cpa_lock, flags);
+	_spin_lock_irqsave(&cpa_lock, flags);
 	for (i = 0; i < numpages; i++, page++) { 
 		err = __change_page_attr(page, prot);
 		if (err) 
 			break; 
 	} 	
-	spin_unlock_irqrestore(&cpa_lock, flags);
+	_spin_unlock_irqrestore(&cpa_lock, flags);
 	return err;
 }
 
@@ -182,9 +182,9 @@ void global_flush_tlb(void)
 
 	BUG_ON(irqs_disabled());
 
-	spin_lock_irq(&cpa_lock);
+	_spin_lock_irq(&cpa_lock);
 	list_splice_init(&df_list, &l);
-	spin_unlock_irq(&cpa_lock);
+	_spin_unlock_irq(&cpa_lock);
 	flush_map();
 	n = l.next;
 	while (n != &l) {
diff -pruN a/arch/i386/mm/pgtable.c b/arch/i386/mm/pgtable.c
--- a/arch/i386/mm/pgtable.c	2004-08-14 09:38:11.000000000 +0400
+++ b/arch/i386/mm/pgtable.c	2004-10-09 01:26:55.000000000 +0400
@@ -171,7 +171,7 @@ void pmd_ctor(void *pmd, kmem_cache_t *c
  * manfred's recommendations and having no core impact whatsoever.
  * -- wli
  */
-spinlock_t pgd_lock = SPIN_LOCK_UNLOCKED;
+_spinlock_t pgd_lock = _SPIN_LOCK_UNLOCKED;
 struct page *pgd_list;
 
 static inline void pgd_list_add(pgd_t *pgd)
@@ -199,7 +199,7 @@ void pgd_ctor(void *pgd, kmem_cache_t *c
 	unsigned long flags;
 
 	if (PTRS_PER_PMD == 1)
-		spin_lock_irqsave(&pgd_lock, flags);
+		_spin_lock_irqsave(&pgd_lock, flags);
 
 	memcpy((pgd_t *)pgd + USER_PTRS_PER_PGD,
 			swapper_pg_dir + USER_PTRS_PER_PGD,
@@ -209,7 +209,7 @@ void pgd_ctor(void *pgd, kmem_cache_t *c
 		return;
 
 	pgd_list_add(pgd);
-	spin_unlock_irqrestore(&pgd_lock, flags);
+	_spin_unlock_irqrestore(&pgd_lock, flags);
 	memset(pgd, 0, USER_PTRS_PER_PGD*sizeof(pgd_t));
 }
 
@@ -218,9 +218,9 @@ void pgd_dtor(void *pgd, kmem_cache_t *c
 {
 	unsigned long flags; /* can be called from interrupt context */
 
-	spin_lock_irqsave(&pgd_lock, flags);
+	_spin_lock_irqsave(&pgd_lock, flags);
 	pgd_list_del(pgd);
-	spin_unlock_irqrestore(&pgd_lock, flags);
+	_spin_unlock_irqrestore(&pgd_lock, flags);
 }
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
diff -pruN a/arch/ppc64/kernel/process.c b/arch/ppc64/kernel/process.c
--- a/arch/ppc64/kernel/process.c	2004-10-08 22:40:07.000000000 +0400
+++ b/arch/ppc64/kernel/process.c	2004-10-09 01:26:55.000000000 +0400
@@ -62,7 +62,7 @@ struct mm_struct ioremap_mm = {
 	.mm_users	= ATOMIC_INIT(2),
 	.mm_count	= ATOMIC_INIT(1),
 	.cpu_vm_mask	= CPU_MASK_ALL,
-	.page_table_lock = SPIN_LOCK_UNLOCKED,
+	.page_table_lock = _SPIN_LOCK_UNLOCKED,
 };
 
 /*
diff -pruN a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c	2004-10-08 22:40:10.000000000 +0400
+++ b/arch/x86_64/kernel/time.c	2004-10-09 01:26:55.000000000 +0400
@@ -48,7 +48,7 @@ static void cpufreq_delayed_get(void);
 extern int using_apic_timer;
 
 spinlock_t rtc_lock = SPIN_LOCK_UNLOCKED;
-spinlock_t i8253_lock = SPIN_LOCK_UNLOCKED;
+old_spinlock_t i8253_lock = OLD_SPIN_LOCK_UNLOCKED;
 
 static int nohpet __initdata = 0;
 
@@ -365,11 +365,11 @@ static irqreturn_t timer_interrupt(int i
 		offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
 		delay = hpet_readl(HPET_COUNTER) - offset;
 	} else {
-		spin_lock(&i8253_lock);
+		old_spin_lock(&i8253_lock);
 		outb_p(0x00, 0x43);
 		delay = inb_p(0x40);
 		delay |= inb(0x40) << 8;
-		spin_unlock(&i8253_lock);
+		old_spin_unlock(&i8253_lock);
 		delay = LATCH - 1 - delay;
 	}
 
@@ -694,7 +694,7 @@ static unsigned int __init pit_calibrate
 	unsigned long start, end;
 	unsigned long flags;
 
-	spin_lock_irqsave(&i8253_lock, flags);
+	old_spin_lock_irqsave(&i8253_lock, flags);
 
 	outb((inb(0x61) & ~0x02) | 0x01, 0x61);
 
@@ -707,7 +707,7 @@ static unsigned int __init pit_calibrate
 	sync_core();
 	rdtscll(end);
 
-	spin_unlock_irqrestore(&i8253_lock, flags);
+	old_spin_unlock_irqrestore(&i8253_lock, flags);
 	
 	return (end - start) / 50;
 }
@@ -772,11 +772,11 @@ void __init pit_init(void)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&i8253_lock, flags);
+	old_spin_lock_irqsave(&i8253_lock, flags);
 	outb_p(0x34, 0x43);		/* binary, mode 2, LSB/MSB, ch 0 */
 	outb_p(LATCH & 0xff, 0x40);	/* LSB */
 	outb_p(LATCH >> 8, 0x40);	/* MSB */
-	spin_unlock_irqrestore(&i8253_lock, flags);
+	old_spin_unlock_irqrestore(&i8253_lock, flags);
 }
 
 int __init time_setup(char *str)
diff -pruN a/drivers/block/nbd.c b/drivers/block/nbd.c
--- a/drivers/block/nbd.c	2004-10-08 22:40:10.000000000 +0400
+++ b/drivers/block/nbd.c	2004-10-09 01:26:55.000000000 +0400
@@ -154,12 +154,12 @@ static int sock_xmit(struct socket *sock
 
 	/* Allow interception of SIGKILL only
 	 * Don't allow other signals to interrupt the transmission */
-	spin_lock_irqsave(&current->sighand->siglock, flags);
+	_spin_lock_irqsave(&current->sighand->siglock, flags);
 	oldset = current->blocked;
 	sigfillset(&current->blocked);
 	sigdelsetmask(&current->blocked, sigmask(SIGKILL));
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sighand->siglock, flags);
+	_spin_unlock_irqrestore(&current->sighand->siglock, flags);
 
 	do {
 		sock->sk->sk_allocation = GFP_NOIO;
@@ -179,11 +179,11 @@ static int sock_xmit(struct socket *sock
 
 		if (signal_pending(current)) {
 			siginfo_t info;
-			spin_lock_irqsave(&current->sighand->siglock, flags);
+			_spin_lock_irqsave(&current->sighand->siglock, flags);
 			printk(KERN_WARNING "nbd (pid %d: %s) got signal %d\n",
 				current->pid, current->comm, 
 				dequeue_signal(current, &current->blocked, &info));
-			spin_unlock_irqrestore(&current->sighand->siglock, flags);
+			_spin_unlock_irqrestore(&current->sighand->siglock, flags);
 			result = -EINTR;
 			break;
 		}
@@ -197,10 +197,10 @@ static int sock_xmit(struct socket *sock
 		buf += result;
 	} while (size > 0);
 
-	spin_lock_irqsave(&current->sighand->siglock, flags);
+	_spin_lock_irqsave(&current->sighand->siglock, flags);
 	current->blocked = oldset;
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sighand->siglock, flags);
+	_spin_unlock_irqrestore(&current->sighand->siglock, flags);
 
 	return result;
 }
diff -pruN a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2004-10-08 22:40:12.000000000 +0400
+++ b/drivers/ide/ide-io.c	2004-10-09 01:26:55.000000000 +0400
@@ -6,6 +6,9 @@
  * This code was split off from ide.c. See ide.c for history and original
  * copyrights.
  *
+ *  2004-07-16 Modified by Eugeny S. Mints for RT Prototype.
+ *             RT Prototype 2004 (C) MontaVista Software, Inc.
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
  * Free Software Foundation; either version 2, or (at your option) any
@@ -1007,8 +1010,16 @@ void ide_do_request (ide_hwgroup_t *hwgr
 	ide_get_lock(ide_intr, hwgroup);
 
 	/* caller must own ide_lock */
+        /* XXX: emints: since irqs in threads patch is employed only routines 
+         * executed from do_IRQ() are executed from a real interrupt context. 
+         * For others holding a lock should be enough. Thus while irqs in 
+         * threads, !irqs_disabled() doesn't a sign that we are not protected 
+         * properly. May be substituted by checking corresponding lock later 
+         * if paranoja.  
+         */
+#ifndef CONFIG_KMUTEX
 	BUG_ON(!irqs_disabled());
-
+#endif
 	while (!hwgroup->busy) {
 		hwgroup->busy = 1;
 		drive = choose_drive(hwgroup);
diff -pruN a/drivers/ide/legacy/hd.c b/drivers/ide/legacy/hd.c
--- a/drivers/ide/legacy/hd.c	2004-08-14 09:36:10.000000000 +0400
+++ b/drivers/ide/legacy/hd.c	2004-10-09 01:26:55.000000000 +0400
@@ -160,16 +160,16 @@ unsigned long last_req;
 
 unsigned long read_timer(void)
 {
-        extern spinlock_t i8253_lock;
+        extern _spinlock_t i8253_lock;
 	unsigned long t, flags;
 	int i;
 
-	spin_lock_irqsave(&i8253_lock, flags);
+	_spin_lock_irqsave(&i8253_lock, flags);
 	t = jiffies * 11932;
     	outb_p(0, 0x43);
 	i = inb_p(0x40);
 	i |= inb(0x40) << 8;
-	spin_unlock_irqrestore(&i8253_lock, flags);
+	_spin_unlock_irqrestore(&i8253_lock, flags);
 	return(t - i);
 }
 #endif
diff -pruN a/drivers/input/gameport/gameport.c b/drivers/input/gameport/gameport.c
--- a/drivers/input/gameport/gameport.c	2004-08-14 09:36:58.000000000 +0400
+++ b/drivers/input/gameport/gameport.c	2004-10-09 01:26:55.000000000 +0400
@@ -19,6 +19,9 @@
 #include <linux/stddef.h>
 #include <linux/delay.h>
 
+# include <linux/spin_undefs.h>
+
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Generic gameport layer");
 MODULE_LICENSE("GPL");
@@ -42,15 +45,15 @@ static LIST_HEAD(gameport_dev_list);
 
 static unsigned int get_time_pit(void)
 {
-	extern spinlock_t i8253_lock;
+	extern _spinlock_t i8253_lock;
 	unsigned long flags;
 	unsigned int count;
 
-	spin_lock_irqsave(&i8253_lock, flags);
+	_spin_lock_irqsave(&i8253_lock, flags);
 	outb_p(0x00, 0x43);
 	count = inb_p(0x40);
 	count |= inb_p(0x40) << 8;
-	spin_unlock_irqrestore(&i8253_lock, flags);
+	_spin_unlock_irqrestore(&i8253_lock, flags);
 
 	return count;
 }
diff -pruN a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-10-09 00:36:39.000000000 +0400
+++ b/drivers/input/serio/i8042.c	2004-10-09 01:26:55.000000000 +0400
@@ -24,6 +24,8 @@
 #include <linux/serio.h>
 #include <linux/err.h>
 
+# include <linux/spin_undefs.h>
+
 #include <asm/io.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
diff -pruN a/drivers/media/video/saa5249.c b/drivers/media/video/saa5249.c
--- a/drivers/media/video/saa5249.c	2004-08-14 09:37:37.000000000 +0400
+++ b/drivers/media/video/saa5249.c	2004-10-09 01:26:56.000000000 +0400
@@ -12,7 +12,7 @@
  *
  *	Copyright (c) 1998 Richard Guenther <richard.guenther@student.uni-tuebingen.de>
  *
- * $Id: saa5249.c,v 1.1 1998/03/30 22:23:23 alan Exp $
+ * $Id$
  *
  *	Derived From
  *
@@ -269,17 +269,17 @@ static void jdelay(unsigned long delay) 
 {
 	sigset_t oldblocked = current->blocked;
 
-	spin_lock_irq(&current->sighand->siglock);
+	_spin_lock_irq(&current->sighand->siglock);
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	_spin_unlock_irq(&current->sighand->siglock);
 	current->state = TASK_INTERRUPTIBLE;
 	schedule_timeout(delay);
 
-	spin_lock_irq(&current->sighand->siglock);
+	_spin_lock_irq(&current->sighand->siglock);
 	current->blocked = oldblocked;
 	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	_spin_unlock_irq(&current->sighand->siglock);
 }
 
 
diff -pruN a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
--- a/drivers/mtd/mtd_blkdevs.c	2004-08-14 09:36:11.000000000 +0400
+++ b/drivers/mtd/mtd_blkdevs.c	2004-10-09 01:26:56.000000000 +0400
@@ -1,5 +1,5 @@
 /*
- * $Id: mtd_blkdevs.c,v 1.22 2004/07/12 12:35:28 dwmw2 Exp $
+ * $Id$
  *
  * (C) 2003 David Woodhouse <dwmw2@infradead.org>
  *
@@ -89,10 +89,10 @@ static int mtd_blktrans_thread(void *arg
 	   actually want to deal with signals. We can't just call 
 	   exit_sighand() since that'll cause an oops when we finally
 	   do exit. */
-	spin_lock_irq(&current->sighand->siglock);
+	_spin_lock_irq(&current->sighand->siglock);
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	_spin_unlock_irq(&current->sighand->siglock);
 
 	spin_lock_irq(rq->queue_lock);
 		
diff -pruN a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
--- a/drivers/scsi/dpt_i2o.c	2004-08-14 09:37:38.000000000 +0400
+++ b/drivers/scsi/dpt_i2o.c	2004-10-09 01:26:56.000000000 +0400
@@ -1159,9 +1159,9 @@ static int adpt_i2o_post_wait(adpt_hba* 
 	// this code is taken from kernel/sched.c:interruptible_sleep_on_timeout
 	wait.task = current;
 	init_waitqueue_entry(&wait, current);
-	spin_lock_irqsave(&adpt_wq_i2o_post.lock, flags);
+	_spin_lock_irqsave(&adpt_wq_i2o_post.lock, flags);
 	__add_wait_queue(&adpt_wq_i2o_post, &wait);
-	spin_unlock(&adpt_wq_i2o_post.lock);
+	_spin_unlock(&adpt_wq_i2o_post.lock);
 
 	msg[2] |= 0x80000000 | ((u32)wait_data->id);
 	timeout *= HZ;
@@ -1184,9 +1184,9 @@ static int adpt_i2o_post_wait(adpt_hba* 
 		if(pHba->host)
 			spin_lock_irq(pHba->host->host_lock);
 	}
-	spin_lock_irq(&adpt_wq_i2o_post.lock);
+	_spin_lock_irq(&adpt_wq_i2o_post.lock);
 	__remove_wait_queue(&adpt_wq_i2o_post, &wait);
-	spin_unlock_irqrestore(&adpt_wq_i2o_post.lock, flags);
+	_spin_unlock_irqrestore(&adpt_wq_i2o_post.lock, flags);
 
 	if(status == -ETIMEDOUT){
 		printk(KERN_INFO"dpti%d: POST WAIT TIMEOUT\n",pHba->unit);
diff -pruN a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
--- a/drivers/video/console/vgacon.c	2004-08-14 09:36:57.000000000 +0400
+++ b/drivers/video/console/vgacon.c	2004-10-09 01:26:56.000000000 +0400
@@ -52,6 +52,8 @@
 #include <video/vga.h>
 #include <asm/io.h>
 
+# include <linux/spin_undefs.h>
+
 static spinlock_t vga_lock = SPIN_LOCK_UNLOCKED;
 static struct vgastate state;
 
diff -pruN a/fs/afs/internal.h b/fs/afs/internal.h
--- a/fs/afs/internal.h	2004-08-14 09:38:11.000000000 +0400
+++ b/fs/afs/internal.h	2004-10-09 01:26:56.000000000 +0400
@@ -45,9 +45,9 @@ static inline void afs_discard_my_signal
 	while (signal_pending(current)) {
 		siginfo_t sinfo;
 
-		spin_lock_irq(&current->sighand->siglock);
+		_spin_lock_irq(&current->sighand->siglock);
 		dequeue_signal(current,&current->blocked, &sinfo);
-		spin_unlock_irq(&current->sighand->siglock);
+		_spin_unlock_irq(&current->sighand->siglock);
 	}
 }
 
diff -pruN a/fs/aio.c b/fs/aio.c
--- a/fs/aio.c	2004-10-08 22:40:22.000000000 +0400
+++ b/fs/aio.c	2004-10-09 01:26:56.000000000 +0400
@@ -571,13 +571,18 @@ static void use_mm(struct mm_struct *mm)
 	struct task_struct *tsk = current;
 
 	task_lock(tsk);
+#ifdef CONFIG_KMUTEX
+        local_irq_disable();
+#endif
 	active_mm = tsk->active_mm;
 	atomic_inc(&mm->mm_count);
 	tsk->mm = mm;
 	tsk->active_mm = mm;
 	activate_mm(active_mm, mm);
+#ifdef CONFIG_KMUTEX
+       local_irq_enable();
+#endif
 	task_unlock(tsk);
-
 	mmdrop(active_mm);
 }
 
diff -pruN a/fs/autofs/waitq.c b/fs/autofs/waitq.c
--- a/fs/autofs/waitq.c	2004-08-14 09:36:32.000000000 +0400
+++ b/fs/autofs/waitq.c	2004-10-09 01:26:56.000000000 +0400
@@ -70,10 +70,10 @@ static int autofs_write(struct file *fil
 	/* Keep the currently executing process from receiving a
 	   SIGPIPE unless it was already supposed to get one */
 	if (wr == -EPIPE && !sigpipe) {
-		spin_lock_irqsave(&current->sighand->siglock, flags);
+		_spin_lock_irqsave(&current->sighand->siglock, flags);
 		sigdelset(&current->pending.signal, SIGPIPE);
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+		_spin_unlock_irqrestore(&current->sighand->siglock, flags);
 	}
 
 	return (bytes > 0);
diff -pruN a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
--- a/fs/autofs4/waitq.c	2004-08-14 09:38:04.000000000 +0400
+++ b/fs/autofs4/waitq.c	2004-10-09 01:26:56.000000000 +0400
@@ -75,10 +75,10 @@ static int autofs4_write(struct file *fi
 	/* Keep the currently executing process from receiving a
 	   SIGPIPE unless it was already supposed to get one */
 	if (wr == -EPIPE && !sigpipe) {
-		spin_lock_irqsave(&current->sighand->siglock, flags);
+		_spin_lock_irqsave(&current->sighand->siglock, flags);
 		sigdelset(&current->pending.signal, SIGPIPE);
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+		_spin_unlock_irqrestore(&current->sighand->siglock, flags);
 	}
 
 	return (bytes > 0);
@@ -244,18 +244,18 @@ int autofs4_wait(struct autofs_sb_info *
 		sigset_t oldset;
 		unsigned long irqflags;
 
-		spin_lock_irqsave(&current->sighand->siglock, irqflags);
+		_spin_lock_irqsave(&current->sighand->siglock, irqflags);
 		oldset = current->blocked;
 		siginitsetinv(&current->blocked, SHUTDOWN_SIGS & ~oldset.sig[0]);
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
+		_spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
 
 		wait_event_interruptible(wq->queue, wq->name == NULL);
 
-		spin_lock_irqsave(&current->sighand->siglock, irqflags);
+		_spin_lock_irqsave(&current->sighand->siglock, irqflags);
 		current->blocked = oldset;
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
+		_spin_unlock_irqrestore(&current->sighand->siglock, irqflags);
 	} else {
 		DPRINTK("skipped sleeping");
 	}
diff -pruN a/fs/block_dev.c b/fs/block_dev.c
--- a/fs/block_dev.c	2004-08-14 09:38:10.000000000 +0400
+++ b/fs/block_dev.c	2004-10-09 01:26:56.000000000 +0400
@@ -25,6 +25,8 @@
 #include <linux/namei.h>
 #include <asm/uaccess.h>
 
+# include <linux/spin_undefs.h>
+
 struct bdev_inode {
 	struct block_device bdev;
 	struct inode vfs_inode;
diff -pruN a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	2004-10-08 22:40:22.000000000 +0400
+++ b/fs/buffer.c	2004-10-09 01:26:56.000000000 +0400
@@ -605,7 +605,7 @@ static void free_more_memory(void)
  */
 static void end_buffer_async_read(struct buffer_head *bh, int uptodate)
 {
-	static spinlock_t page_uptodate_lock = SPIN_LOCK_UNLOCKED;
+	static _spinlock_t page_uptodate_lock = _SPIN_LOCK_UNLOCKED;
 	unsigned long flags;
 	struct buffer_head *tmp;
 	struct page *page;
@@ -627,7 +627,7 @@ static void end_buffer_async_read(struct
 	 * two buffer heads end IO at almost the same time and both
 	 * decide that the page is now completely done.
 	 */
-	spin_lock_irqsave(&page_uptodate_lock, flags);
+	_spin_lock_irqsave(&page_uptodate_lock, flags);
 	clear_buffer_async_read(bh);
 	unlock_buffer(bh);
 	tmp = bh;
@@ -640,7 +640,7 @@ static void end_buffer_async_read(struct
 		}
 		tmp = tmp->b_this_page;
 	} while (tmp != bh);
-	spin_unlock_irqrestore(&page_uptodate_lock, flags);
+	_spin_unlock_irqrestore(&page_uptodate_lock, flags);
 
 	/*
 	 * If none of the buffers had errors and they are all
@@ -652,7 +652,7 @@ static void end_buffer_async_read(struct
 	return;
 
 still_busy:
-	spin_unlock_irqrestore(&page_uptodate_lock, flags);
+	_spin_unlock_irqrestore(&page_uptodate_lock, flags);
 	return;
 }
 
@@ -663,7 +663,7 @@ still_busy:
 void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 {
 	char b[BDEVNAME_SIZE];
-	static spinlock_t page_uptodate_lock = SPIN_LOCK_UNLOCKED;
+	static _spinlock_t page_uptodate_lock = _SPIN_LOCK_UNLOCKED;
 	unsigned long flags;
 	struct buffer_head *tmp;
 	struct page *page;
@@ -685,7 +685,7 @@ void end_buffer_async_write(struct buffe
 		SetPageError(page);
 	}
 
-	spin_lock_irqsave(&page_uptodate_lock, flags);
+	_spin_lock_irqsave(&page_uptodate_lock, flags);
 	clear_buffer_async_write(bh);
 	unlock_buffer(bh);
 	tmp = bh->b_this_page;
@@ -696,12 +696,12 @@ void end_buffer_async_write(struct buffe
 		}
 		tmp = tmp->b_this_page;
 	}
-	spin_unlock_irqrestore(&page_uptodate_lock, flags);
+	_spin_unlock_irqrestore(&page_uptodate_lock, flags);
 	end_page_writeback(page);
 	return;
 
 still_busy:
-	spin_unlock_irqrestore(&page_uptodate_lock, flags);
+	_spin_unlock_irqrestore(&page_uptodate_lock, flags);
 	return;
 }
 
@@ -942,7 +942,7 @@ int __set_page_dirty_buffers(struct page
 	spin_unlock(&mapping->private_lock);
 
 	if (!TestSetPageDirty(page)) {
-		spin_lock_irq(&mapping->tree_lock);
+		_spin_lock_irq(&mapping->tree_lock);
 		if (page->mapping) {	/* Race with truncate? */
 			if (!mapping->backing_dev_info->memory_backed)
 				inc_page_state(nr_dirty);
@@ -950,7 +950,7 @@ int __set_page_dirty_buffers(struct page
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
 		}
-		spin_unlock_irq(&mapping->tree_lock);
+		_spin_unlock_irq(&mapping->tree_lock);
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 	}
 	
@@ -1427,8 +1427,13 @@ static DEFINE_PER_CPU(struct bh_lru, bh_
 
 static inline void check_irqs_on(void)
 {
-#ifdef irqs_disabled
+#ifdef irqs_disabled 
+# if !defined CONFIG_KMUTEX
 	BUG_ON(irqs_disabled());
+# else
+	if (irqs_disabled())
+		printk("buffer.c/check_irqs_on %d\n", irqs_disabled());
+# endif
 #endif
 }
 
diff -pruN a/fs/exec.c b/fs/exec.c
--- a/fs/exec.c	2004-10-08 22:40:23.000000000 +0400
+++ b/fs/exec.c	2004-10-09 01:26:56.000000000 +0400
@@ -308,7 +308,7 @@ void install_arg_page(struct vm_area_str
 	flush_dcache_page(page);
 	pgd = pgd_offset(mm, address);
 
-	spin_lock(&mm->page_table_lock);
+	_spin_lock(&mm->page_table_lock);
 	pmd = pmd_alloc(mm, pgd, address);
 	if (!pmd)
 		goto out;
@@ -325,12 +325,12 @@ void install_arg_page(struct vm_area_str
 					page, vma->vm_page_prot))));
 	page_add_anon_rmap(page, vma, address);
 	pte_unmap(pte);
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 
 	/* no need for flush_tlb */
 	return;
 out:
-	spin_unlock(&mm->page_table_lock);
+	_spin_unlock(&mm->page_table_lock);
 out_sig:
 	__free_page(page);
 	force_sig(SIGKILL, current);
@@ -530,10 +530,10 @@ static int exec_mmap(struct mm_struct *m
 	struct mm_struct * old_mm, *active_mm;
 
 	/* Add it to the list of mm's */
-	spin_lock(&mmlist_lock);
+	_spin_lock(&mmlist_lock);
 	list_add(&mm->mmlist, &init_mm.mmlist);
 	mmlist_nr++;
-	spin_unlock(&mmlist_lock);
+	_spin_unlock(&mmlist_lock);
 
 	/* Notify parent that we're no longer interested in the old VM */
 	tsk = current;
@@ -541,10 +541,16 @@ static int exec_mmap(struct mm_struct *m
 	mm_release(tsk, old_mm);
 
 	task_lock(tsk);
+#ifdef CONFIG_KMUTEX
+	local_irq_disable();
+#endif
 	active_mm = tsk->active_mm;
 	tsk->mm = mm;
 	tsk->active_mm = mm;
 	activate_mm(active_mm, mm);
+#ifdef CONFIG_KMUTEX
+	local_irq_enable();
+#endif
 	task_unlock(tsk);
 	arch_pick_mmap_layout(mm);
 	if (old_mm) {
@@ -566,7 +572,7 @@ static inline int de_thread(struct task_
 {
 	struct signal_struct *newsig, *oldsig = tsk->signal;
 	struct sighand_struct *newsighand, *oldsighand = tsk->sighand;
-	spinlock_t *lock = &oldsighand->siglock;
+	_spinlock_t *lock = &oldsighand->siglock;
 	int count;
 
 	/*
@@ -580,7 +586,7 @@ static inline int de_thread(struct task_
 	if (!newsighand)
 		return -ENOMEM;
 
-	spin_lock_init(&newsighand->siglock);
+	_spin_lock_init(&newsighand->siglock);
 	atomic_set(&newsighand->count, 1);
 	memcpy(newsighand->action, oldsighand->action, sizeof(newsighand->action));
 
@@ -618,13 +624,13 @@ static inline int de_thread(struct task_
 	 * We must hold tasklist_lock to call zap_other_threads.
 	 */
 	read_lock(&tasklist_lock);
-	spin_lock_irq(lock);
+	_spin_lock_irq(lock);
 	if (oldsig->group_exit) {
 		/*
 		 * Another group action in progress, just
 		 * return so that the signal is processed.
 		 */
-		spin_unlock_irq(lock);
+		_spin_unlock_irq(lock);
 		read_unlock(&tasklist_lock);
 		kmem_cache_free(sighand_cachep, newsighand);
 		if (newsig)
@@ -645,11 +651,11 @@ static inline int de_thread(struct task_
 		oldsig->group_exit_task = current;
 		oldsig->notify_count = count;
 		__set_current_state(TASK_UNINTERRUPTIBLE);
-		spin_unlock_irq(lock);
+		_spin_unlock_irq(lock);
 		schedule();
-		spin_lock_irq(lock);
+		_spin_lock_irq(lock);
 	}
-	spin_unlock_irq(lock);
+	_spin_unlock_irq(lock);
 
 	/*
 	 * At this point all other threads have exited, all we have to
@@ -726,8 +732,8 @@ static inline int de_thread(struct task_
 no_thread_group:
 
 	write_lock_irq(&tasklist_lock);
-	spin_lock(&oldsighand->siglock);
-	spin_lock(&newsighand->siglock);
+	_spin_lock(&oldsighand->siglock);
+	_spin_lock(&newsighand->siglock);
 
 	if (current == oldsig->curr_target)
 		oldsig->curr_target = next_thread(current);
@@ -737,8 +743,8 @@ no_thread_group:
 	init_sigpending(&current->pending);
 	recalc_sigpending();
 
-	spin_unlock(&newsighand->siglock);
-	spin_unlock(&oldsighand->siglock);
+	_spin_unlock(&newsighand->siglock);
+	_spin_unlock(&oldsighand->siglock);
 	write_unlock_irq(&tasklist_lock);
 
 	if (newsig && atomic_dec_and_test(&oldsig->count)) {
diff -pruN a/fs/inode.c b/fs/inode.c
--- a/fs/inode.c	2004-10-08 22:40:23.000000000 +0400
+++ b/fs/inode.c	2004-10-09 01:26:56.000000000 +0400
@@ -196,7 +196,7 @@ void inode_init_once(struct inode *inode
 	sema_init(&inode->i_sem, 1);
 	init_rwsem(&inode->i_alloc_sem);
 	INIT_RADIX_TREE(&inode->i_data.page_tree, GFP_ATOMIC);
-	spin_lock_init(&inode->i_data.tree_lock);
+	_spin_lock_init(&inode->i_data.tree_lock);
 	spin_lock_init(&inode->i_data.i_mmap_lock);
 	atomic_set(&inode->i_data.truncate_count, 0);
 	INIT_LIST_HEAD(&inode->i_data.private_list);
diff -pruN a/fs/jffs/intrep.c b/fs/jffs/intrep.c
--- a/fs/jffs/intrep.c	2004-08-14 09:37:14.000000000 +0400
+++ b/fs/jffs/intrep.c	2004-10-09 01:26:56.000000000 +0400
@@ -10,7 +10,7 @@
  * the Free Software Foundation; either version 2 of the License, or
  * (at your option) any later version.
  *
- * $Id: intrep.c,v 1.102 2001/09/23 23:28:36 dwmw2 Exp $
+ * $Id$
  *
  * Ported to Linux 2.3.x and MTD:
  * Copyright (C) 2000  Alexander Larsson (alex@cendio.se), Cendio Systems AB
@@ -3343,10 +3343,10 @@ jffs_garbage_collect_thread(void *ptr)
 
 	lock_kernel();
 	init_completion(&c->gc_thread_comp); /* barrier */ 
-	spin_lock_irq(&current->sighand->siglock);
+	_spin_lock_irq(&current->sighand->siglock);
 	siginitsetinv (&current->blocked, sigmask(SIGHUP) | sigmask(SIGKILL) | sigmask(SIGSTOP) | sigmask(SIGCONT));
 	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	_spin_unlock_irq(&current->sighand->siglock);
 
 	D1(printk (KERN_NOTICE "jffs_garbage_collect_thread(): Starting infinite loop.\n"));
 
@@ -3373,9 +3373,9 @@ jffs_garbage_collect_thread(void *ptr)
 			siginfo_t info;
 			unsigned long signr = 0;
 
-			spin_lock_irq(&current->sighand->siglock);
+			_spin_lock_irq(&current->sighand->siglock);
 			signr = dequeue_signal(current, &current->blocked, &info);
-			spin_unlock_irq(&current->sighand->siglock);
+			_spin_unlock_irq(&current->sighand->siglock);
 
 			switch(signr) {
 			case SIGSTOP:
diff -pruN a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
--- a/fs/lockd/clntproc.c	2004-10-08 22:40:23.000000000 +0400
+++ b/fs/lockd/clntproc.c	2004-10-09 01:26:56.000000000 +0400
@@ -225,7 +225,7 @@ nlmclnt_proc(struct inode *inode, int cm
 	}
 
 	/* Keep the old signal mask */
-	spin_lock_irqsave(&current->sighand->siglock, flags);
+	_spin_lock_irqsave(&current->sighand->siglock, flags);
 	oldset = current->blocked;
 
 	/* If we're cleaning up locks because the process is exiting,
@@ -235,7 +235,7 @@ nlmclnt_proc(struct inode *inode, int cm
 	    && (current->flags & PF_EXITING)) {
 		sigfillset(&current->blocked);	/* Mask all signals */
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+		_spin_unlock_irqrestore(&current->sighand->siglock, flags);
 
 		call = nlmclnt_alloc_call();
 		if (!call) {
@@ -244,7 +244,7 @@ nlmclnt_proc(struct inode *inode, int cm
 		}
 		call->a_flags = RPC_TASK_ASYNC;
 	} else {
-		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+		_spin_unlock_irqrestore(&current->sighand->siglock, flags);
 		memset(call, 0, sizeof(*call));
 		locks_init_lock(&call->a_args.lock.fl);
 		locks_init_lock(&call->a_res.lock.fl);
@@ -268,10 +268,10 @@ nlmclnt_proc(struct inode *inode, int cm
 		status = -EINVAL;
 
  out_restore:
-	spin_lock_irqsave(&current->sighand->siglock, flags);
+	_spin_lock_irqsave(&current->sighand->siglock, flags);
 	current->blocked = oldset;
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sighand->siglock, flags);
+	_spin_unlock_irqrestore(&current->sighand->siglock, flags);
 
 done:
 	dprintk("lockd: clnt proc returns %d\n", status);
@@ -702,11 +702,11 @@ nlmclnt_cancel(struct nlm_host *host, st
 	int		status;
 
 	/* Block all signals while setting up call */
-	spin_lock_irqsave(&current->sighand->siglock, flags);
+	_spin_lock_irqsave(&current->sighand->siglock, flags);
 	oldset = current->blocked;
 	sigfillset(&current->blocked);
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sighand->siglock, flags);
+	_spin_unlock_irqrestore(&current->sighand->siglock, flags);
 
 	req = nlmclnt_alloc_call();
 	if (!req)
@@ -723,10 +723,10 @@ nlmclnt_cancel(struct nlm_host *host, st
 		kfree(req);
 	}
 
-	spin_lock_irqsave(&current->sighand->siglock, flags);
+	_spin_lock_irqsave(&current->sighand->siglock, flags);
 	current->blocked = oldset;
 	recalc_sigpending();
-	spin_unlock_irqrestore(&current->sighand->siglock, flags);
+	_spin_unlock_irqrestore(&current->sighand->siglock, flags);
 
 	return status;
 }
diff -pruN a/fs/lockd/svc.c b/fs/lockd/svc.c
--- a/fs/lockd/svc.c	2004-10-08 22:40:23.000000000 +0400
+++ b/fs/lockd/svc.c	2004-10-09 01:26:56.000000000 +0400
@@ -305,9 +305,9 @@ lockd_down(void)
 			"lockd_down: lockd failed to exit, clearing pid\n");
 		nlmsvc_pid = 0;
 	}
-	spin_lock_irq(&current->sighand->siglock);
+	_spin_lock_irq(&current->sighand->siglock);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	_spin_unlock_irq(&current->sighand->siglock);
 out:
 	up(&nlmsvc_sema);
 }
diff -pruN a/fs/ncpfs/sock.c b/fs/ncpfs/sock.c
--- a/fs/ncpfs/sock.c	2004-08-14 09:36:56.000000000 +0400
+++ b/fs/ncpfs/sock.c	2004-10-09 01:26:56.000000000 +0400
@@ -717,7 +717,7 @@ static int ncp_do_request(struct ncp_ser
 		sigset_t old_set;
 		unsigned long mask, flags;
 
-		spin_lock_irqsave(&current->sighand->siglock, flags);
+		_spin_lock_irqsave(&current->sighand->siglock, flags);
 		old_set = current->blocked;
 		if (current->flags & PF_EXITING)
 			mask = 0;
@@ -736,14 +736,15 @@ static int ncp_do_request(struct ncp_ser
 		}
 		siginitsetinv(&current->blocked, mask);
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+		_spin_unlock_irqrestore(&current->sighand->siglock, flags);
 		
 		result = do_ncp_rpc_call(server, size, reply, max_reply_size);
 
-		spin_lock_irqsave(&current->sighand->siglock, flags);
+		_spin_lock_irqsave(&current->sighand->siglock, flags);
+
 		current->blocked = old_set;
 		recalc_sigpending();
-		spin_unlock_irqrestore(&current->sighand->siglock, flags);
+		_spin_unlock_irqrestore(&current->sighand->siglock, flags);
 	}
 
 	DDPRINTK("do_ncp_rpc_call returned %d\n", result);
diff -pruN a/fs/proc/array.c b/fs/proc/array.c
--- a/fs/proc/array.c	2004-10-08 22:40:24.000000000 +0400
+++ b/fs/proc/array.c	2004-10-09 01:26:57.000000000 +0400
@@ -248,13 +248,13 @@ static inline char * task_sig(struct tas
 	/* Gather all the data with the appropriate locks held */
 	read_lock(&tasklist_lock);
 	if (p->sighand) {
-		spin_lock_irq(&p->sighand->siglock);
+		_spin_lock_irq(&p->sighand->siglock);
 		pending = p->pending.signal;
 		shpending = p->signal->shared_pending.signal;
 		blocked = p->blocked;
 		collect_sigign_sigcatch(p, &ignored, &caught);
 		num_threads = atomic_read(&p->signal->count);
-		spin_unlock_irq(&p->sighand->siglock);
+		_spin_unlock_irq(&p->sighand->siglock);
 	}
 	read_unlock(&tasklist_lock);
 
@@ -331,10 +331,10 @@ int proc_pid_stat(struct task_struct *ta
 	sigemptyset(&sigcatch);
 	read_lock(&tasklist_lock);
 	if (task->sighand) {
-		spin_lock_irq(&task->sighand->siglock);
+		_spin_lock_irq(&task->sighand->siglock);
 		num_threads = atomic_read(&task->signal->count);
 		collect_sigign_sigcatch(task, &sigign, &sigcatch);
-		spin_unlock_irq(&task->sighand->siglock);
+		_spin_unlock_irq(&task->sighand->siglock);
 	}
 	if (task->signal) {
 		if (task->signal->tty) {
diff -pruN a/fs/xfs/linux-2.6/xfs_buf.c b/fs/xfs/linux-2.6/xfs_buf.c
--- a/fs/xfs/linux-2.6/xfs_buf.c	2004-10-08 22:40:24.000000000 +0400
+++ b/fs/xfs/linux-2.6/xfs_buf.c	2004-10-09 01:26:57.000000000 +0400
@@ -878,7 +878,6 @@ pagebuf_rele(
 	pb_hash_t		*hash = pb_hash(pb);
 
 	PB_TRACE(pb, "rele", pb->pb_relse);
-
 	if (atomic_dec_and_lock(&pb->pb_hold, &hash->pb_hash_lock)) {
 		int		do_free = 1;
 
diff -pruN a/include/asm-arm/cacheflush.h b/include/asm-arm/cacheflush.h
--- a/include/asm-arm/cacheflush.h	2004-10-08 22:40:25.000000000 +0400
+++ b/include/asm-arm/cacheflush.h	2004-10-09 01:26:57.000000000 +0400
@@ -312,9 +312,9 @@ flush_cache_page(struct vm_area_struct *
 extern void flush_dcache_page(struct page *);
 
 #define flush_dcache_mmap_lock(mapping) \
-	spin_lock_irq(&(mapping)->tree_lock)
+	_spin_lock_irq(&(mapping)->tree_lock)
 #define flush_dcache_mmap_unlock(mapping) \
-	spin_unlock_irq(&(mapping)->tree_lock)
+	_spin_unlock_irq(&(mapping)->tree_lock)
 
 #define flush_icache_user_range(vma,page,addr,len) \
 	flush_dcache_page(page)
diff -pruN a/include/asm-i386/i8259.h b/include/asm-i386/i8259.h
--- a/include/asm-i386/i8259.h	2004-08-14 09:36:33.000000000 +0400
+++ b/include/asm-i386/i8259.h	2004-10-09 01:26:57.000000000 +0400
@@ -7,7 +7,7 @@ extern unsigned int cached_irq_mask;
 #define cached_master_mask	(__byte(0, cached_irq_mask))
 #define cached_slave_mask	(__byte(1, cached_irq_mask))
 
-extern spinlock_t i8259A_lock;
+extern _spinlock_t i8259A_lock;
 
 extern void init_8259A(int auto_eoi);
 extern void enable_8259A_irq(unsigned int irq);
diff -pruN a/include/asm-i386/mach-default/do_timer.h b/include/asm-i386/mach-default/do_timer.h
--- a/include/asm-i386/mach-default/do_timer.h	2004-10-08 22:40:25.000000000 +0400
+++ b/include/asm-i386/mach-default/do_timer.h	2004-10-09 01:26:57.000000000 +0400
@@ -47,13 +47,13 @@ static inline int do_timer_overflow(int 
 {
 	int i;
 
-	spin_lock(&i8259A_lock);
+	_spin_lock(&i8259A_lock);
 	/*
 	 * This is tricky when I/O APICs are used;
 	 * see do_timer_interrupt().
 	 */
 	i = inb(0x20);
-	spin_unlock(&i8259A_lock);
+	_spin_unlock(&i8259A_lock);
 	
 	/* assumption about timer being IRQ0 */
 	if (i & 0x01) {
diff -pruN a/include/asm-i386/mach-visws/do_timer.h b/include/asm-i386/mach-visws/do_timer.h
--- a/include/asm-i386/mach-visws/do_timer.h	2004-10-08 22:40:25.000000000 +0400
+++ b/include/asm-i386/mach-visws/do_timer.h	2004-10-09 01:26:57.000000000 +0400
@@ -26,13 +26,13 @@ static inline int do_timer_overflow(int 
 {
 	int i;
 
-	spin_lock(&i8259A_lock);
+	_spin_lock(&i8259A_lock);
 	/*
 	 * This is tricky when I/O APICs are used;
 	 * see do_timer_interrupt().
 	 */
 	i = inb(0x20);
-	spin_unlock(&i8259A_lock);
+	_spin_unlock(&i8259A_lock);
 	
 	/* assumption about timer being IRQ0 */
 	if (i & 0x01) {
diff -pruN a/include/asm-i386/pgtable.h b/include/asm-i386/pgtable.h
--- a/include/asm-i386/pgtable.h	2004-10-08 22:40:25.000000000 +0400
+++ b/include/asm-i386/pgtable.h	2004-10-09 01:26:57.000000000 +0400
@@ -34,7 +34,7 @@ extern unsigned long empty_zero_page[102
 extern pgd_t swapper_pg_dir[1024];
 extern kmem_cache_t *pgd_cache;
 extern kmem_cache_t *pmd_cache;
-extern spinlock_t pgd_lock;
+extern _spinlock_t pgd_lock;
 extern struct page *pgd_list;
 
 void pmd_ctor(void *, kmem_cache_t *, unsigned long);
diff -pruN a/include/asm-i386/rwsem.h b/include/asm-i386/rwsem.h
--- a/include/asm-i386/rwsem.h	2004-08-14 09:36:56.000000000 +0400
+++ b/include/asm-i386/rwsem.h	2004-10-09 01:26:57.000000000 +0400
@@ -59,7 +59,7 @@ struct rw_semaphore {
 #define RWSEM_WAITING_BIAS		(-0x00010000)
 #define RWSEM_ACTIVE_READ_BIAS		RWSEM_ACTIVE_BIAS
 #define RWSEM_ACTIVE_WRITE_BIAS		(RWSEM_WAITING_BIAS + RWSEM_ACTIVE_BIAS)
-	spinlock_t		wait_lock;
+	_spinlock_t		wait_lock;
 	struct list_head	wait_list;
 #if RWSEM_DEBUG
 	int			debug;
@@ -76,7 +76,8 @@ struct rw_semaphore {
 #endif
 
 #define __RWSEM_INITIALIZER(name) \
-{ RWSEM_UNLOCKED_VALUE, SPIN_LOCK_UNLOCKED, LIST_HEAD_INIT((name).wait_list) \
+{ RWSEM_UNLOCKED_VALUE, _SPIN_LOCK_UNLOCKED, \
+	LIST_HEAD_INIT((name).wait_list) \
 	__RWSEM_DEBUG_INIT }
 
 #define DECLARE_RWSEM(name) \
@@ -85,7 +86,7 @@ struct rw_semaphore {
 static inline void init_rwsem(struct rw_semaphore *sem)
 {
 	sem->count = RWSEM_UNLOCKED_VALUE;
-	spin_lock_init(&sem->wait_lock);
+	_spin_lock_init(&sem->wait_lock);
 	INIT_LIST_HEAD(&sem->wait_list);
 #if RWSEM_DEBUG
 	sem->debug = 0;
diff -pruN a/include/asm-i386/spinlock.h b/include/asm-i386/spinlock.h
--- a/include/asm-i386/spinlock.h	2004-10-08 22:40:25.000000000 +0400
+++ b/include/asm-i386/spinlock.h	2004-10-09 01:26:57.000000000 +0400
@@ -19,7 +19,7 @@ typedef struct {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned magic;
 #endif
-} spinlock_t;
+} _spinlock_t;
 
 #define SPINLOCK_MAGIC	0xdead4ead
 
@@ -29,9 +29,9 @@ typedef struct {
 #define SPINLOCK_MAGIC_INIT	/* */
 #endif
 
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { 1 SPINLOCK_MAGIC_INIT }
+#define _SPIN_LOCK_UNLOCKED (_spinlock_t) { 1 SPINLOCK_MAGIC_INIT }
 
-#define spin_lock_init(x)	do { *(x) = SPIN_LOCK_UNLOCKED; } while(0)
+#define _spin_lock_init(x)	do { *(x) = _SPIN_LOCK_UNLOCKED; } while(0)
 
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
@@ -40,8 +40,8 @@ typedef struct {
  * We make no fairness assumptions. They have a cost.
  */
 
-#define spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
-#define spin_unlock_wait(x)	do { barrier(); } while(spin_is_locked(x))
+#define _spin_is_locked(x)	(*(volatile signed char *)(&(x)->lock) <= 0)
+#define _spin_unlock_wait(x)	do { barrier(); } while(_spin_is_locked(x))
 
 #define spin_lock_string \
 	"\n1:\t" \
@@ -83,11 +83,11 @@ typedef struct {
 		:"=m" (lock->lock) : : "memory"
 
 
-static inline void _raw_spin_unlock(spinlock_t *lock)
+static inline void _raw_spin_unlock(_spinlock_t *lock)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(lock->magic != SPINLOCK_MAGIC);
-	BUG_ON(!spin_is_locked(lock));
+	BUG_ON(!_spin_is_locked(lock));
 #endif
 	__asm__ __volatile__(
 		spin_unlock_string
@@ -101,12 +101,12 @@ static inline void _raw_spin_unlock(spin
 		:"=q" (oldval), "=m" (lock->lock) \
 		:"0" (oldval) : "memory"
 
-static inline void _raw_spin_unlock(spinlock_t *lock)
+static inline void _raw_spin_unlock(_spinlock_t *lock)
 {
 	char oldval = 1;
 #ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(lock->magic != SPINLOCK_MAGIC);
-	BUG_ON(!spin_is_locked(lock));
+	BUG_ON(!_spin_is_locked(lock));
 #endif
 	__asm__ __volatile__(
 		spin_unlock_string
@@ -115,7 +115,7 @@ static inline void _raw_spin_unlock(spin
 
 #endif
 
-static inline int _raw_spin_trylock(spinlock_t *lock)
+static inline int _raw_spin_trylock(_spinlock_t *lock)
 {
 	char oldval;
 	__asm__ __volatile__(
@@ -125,7 +125,7 @@ static inline int _raw_spin_trylock(spin
 	return oldval > 0;
 }
 
-static inline void _raw_spin_lock(spinlock_t *lock)
+static inline void _raw_spin_lock(_spinlock_t *lock)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	if (unlikely(lock->magic != SPINLOCK_MAGIC)) {
@@ -138,7 +138,7 @@ static inline void _raw_spin_lock(spinlo
 		:"=m" (lock->lock) : : "memory");
 }
 
-static inline void _raw_spin_lock_flags (spinlock_t *lock, unsigned long flags)
+static inline void _raw_spin_lock_flags (_spinlock_t *lock, unsigned long flags)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	if (unlikely(lock->magic != SPINLOCK_MAGIC)) {
diff -pruN a/include/asm-parisc/cacheflush.h b/include/asm-parisc/cacheflush.h
--- a/include/asm-parisc/cacheflush.h	2004-10-08 22:40:26.000000000 +0400
+++ b/include/asm-parisc/cacheflush.h	2004-10-09 01:26:57.000000000 +0400
@@ -68,9 +68,9 @@ flush_user_icache_range(unsigned long st
 extern void flush_dcache_page(struct page *page);
 
 #define flush_dcache_mmap_lock(mapping) \
-	spin_lock_irq(&(mapping)->tree_lock)
+	old_spin_lock_irq(&(mapping)->tree_lock)
 #define flush_dcache_mmap_unlock(mapping) \
-	spin_unlock_irq(&(mapping)->tree_lock)
+	old_spin_unlock_irq(&(mapping)->tree_lock)
 
 #define flush_icache_page(vma,page)	do { flush_kernel_dcache_page(page_address(page)); flush_kernel_icache_page(page_address(page)); } while (0)
 
diff -pruN a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	2004-10-08 22:40:27.000000000 +0400
+++ b/include/linux/fs.h	2004-10-09 01:26:57.000000000 +0400
@@ -334,7 +334,7 @@ struct backing_dev_info;
 struct address_space {
 	struct inode		*host;		/* owner: inode, block_device */
 	struct radix_tree_root	page_tree;	/* radix tree of all pages */
-	spinlock_t		tree_lock;	/* and spinlock protecting it */
+	_spinlock_t		tree_lock;	/* and spinlock protecting it */
 	unsigned int		i_mmap_writable;/* count VM_SHARED mappings */
 	struct prio_tree_root	i_mmap;		/* tree of private and shared mappings */
 	struct list_head	i_mmap_nonlinear;/*list VM_NONLINEAR mappings */
diff -pruN a/include/linux/init_task.h b/include/linux/init_task.h
--- a/include/linux/init_task.h	2004-08-14 09:36:16.000000000 +0400
+++ b/include/linux/init_task.h	2004-10-09 01:26:57.000000000 +0400
@@ -38,7 +38,7 @@
 	.mm_users	= ATOMIC_INIT(2), 			\
 	.mm_count	= ATOMIC_INIT(1), 			\
 	.mmap_sem	= __RWSEM_INITIALIZER(name.mmap_sem),	\
-	.page_table_lock =  SPIN_LOCK_UNLOCKED, 		\
+	.page_table_lock =  _SPIN_LOCK_UNLOCKED, 		\
 	.mmlist		= LIST_HEAD_INIT(name.mmlist),		\
 	.cpu_vm_mask	= CPU_MASK_ALL,				\
 	.default_kioctx = INIT_KIOCTX(name.default_kioctx, name),	\
@@ -55,7 +55,7 @@
 #define INIT_SIGHAND(sighand) {	\
 	.count		= ATOMIC_INIT(1), 		\
 	.action		= { {{NULL,}}, },		\
-	.siglock	= SPIN_LOCK_UNLOCKED, 		\
+	.siglock	= _SPIN_LOCK_UNLOCKED, 		\
 }
 
 extern struct group_info init_groups;
diff -pruN a/include/linux/irq.h b/include/linux/irq.h
--- a/include/linux/irq.h	2004-10-09 00:36:39.000000000 +0400
+++ b/include/linux/irq.h	2004-10-09 01:26:57.000000000 +0400
@@ -91,7 +91,7 @@ typedef struct irq_desc {
          * this lock is used from a real interrupt context (do_IRQ) even if
          * irqs in threads patch is employed.
          */
-	spinlock_t lock;
+	_spinlock_t lock;
 
 #if defined CONFIG_INGO_IRQ_THREADS || defined CONFIG_IRQ_THREADS
         struct task_struct *thread;
diff -pruN a/include/linux/mmzone.h b/include/linux/mmzone.h
--- a/include/linux/mmzone.h	2004-10-08 22:40:27.000000000 +0400
+++ b/include/linux/mmzone.h	2004-10-09 01:26:57.000000000 +0400
@@ -130,7 +130,7 @@ struct zone {
 
 	ZONE_PADDING(_pad1_)
 
-	spinlock_t		lru_lock;	
+	_spinlock_t		lru_lock;	
 	struct list_head	active_list;
 	struct list_head	inactive_list;
 	unsigned long		nr_scan_active;
diff -pruN a/include/linux/preempt.h b/include/linux/preempt.h
--- a/include/linux/preempt.h	2004-08-14 09:36:32.000000000 +0400
+++ b/include/linux/preempt.h	2004-10-09 01:26:57.000000000 +0400
@@ -45,7 +45,8 @@ do { \
 
 #define preempt_enable() \
 do { \
-	preempt_enable_no_resched(); \
+	barrier(); \
+        dec_preempt_count(); \
 	preempt_check_resched(); \
 } while (0)
 
diff -pruN a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	2004-10-09 00:36:39.000000000 +0400
+++ b/include/linux/sched.h	2004-10-09 01:26:57.000000000 +0400
@@ -142,7 +142,7 @@ struct sched_param {
  * a separate lock).
  */
 extern rwlock_t tasklist_lock;
-extern spinlock_t mmlist_lock;
+extern _spinlock_t mmlist_lock;
 
 typedef struct task_struct task_t;
 
@@ -218,7 +218,7 @@ struct mm_struct {
 	atomic_t mm_count;			/* How many references to "struct mm_struct" (users count as 1) */
 	int map_count;				/* number of VMAs */
 	struct rw_semaphore mmap_sem;
-	spinlock_t page_table_lock;		/* Protects task page tables and mm->rss */
+	_spinlock_t page_table_lock;		/* Protects task page tables and mm->rss */
 	struct list_head mmlist;		/* List of all active mm's.  These are globally strung
 						 * together off init_mm.mmlist, and are protected
 						 * by mmlist_lock
@@ -258,7 +258,7 @@ extern int mmlist_nr;
 struct sighand_struct {
 	atomic_t		count;
 	struct k_sigaction	action[_NSIG];
-	spinlock_t		siglock;
+	_spinlock_t		siglock;
 };
 
 /*
@@ -740,9 +740,9 @@ static inline int dequeue_signal_lock(st
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&tsk->sighand->siglock, flags);
+	_spin_lock_irqsave(&tsk->sighand->siglock, flags);
 	ret = dequeue_signal(tsk, mask, info);
-	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
+	_spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
 
 	return ret;
 }	
@@ -989,13 +989,17 @@ static inline void cond_resched(void)
  * operations here to prevent schedule() from being called twice (once via
  * spin_unlock(), once by hand).
  */
+#ifdef CONFIG_KMUTEX
+static inline void _cond_resched_lock(_spinlock_t * lock)
+#else
 static inline void cond_resched_lock(spinlock_t * lock)
+#endif
 {
 	if (need_resched()) {
 		_raw_spin_unlock(lock);
 		preempt_enable_no_resched();
 		__cond_resched();
-		spin_lock(lock);
+		_spin_lock(lock);
 	}
 }
 
diff -pruN a/include/linux/seqlock.h b/include/linux/seqlock.h
--- a/include/linux/seqlock.h	2004-08-14 09:36:57.000000000 +0400
+++ b/include/linux/seqlock.h	2004-10-09 01:26:57.000000000 +0400
@@ -30,17 +30,21 @@
 #include <linux/spinlock.h>
 #include <linux/preempt.h>
 
+/* 
+ * this type of lock is used from timer interrupt handler which is 
+ * implemented in interrupt context 
+ */
 typedef struct {
 	unsigned sequence;
-	spinlock_t lock;
+	_spinlock_t lock; 
 } seqlock_t;
 
 /*
  * These macros triggered gcc-3.x compile-time problems.  We think these are
  * OK now.  Be cautious.
  */
-#define SEQLOCK_UNLOCKED { 0, SPIN_LOCK_UNLOCKED }
-#define seqlock_init(x)	do { *(x) = (seqlock_t) SEQLOCK_UNLOCKED; } while (0)
+#define SEQLOCK_UNLOCKED { 0, _SPIN_LOCK_UNLOCKED }
+#define seqlock_init(x)	  do { *(x) = (seqlock_t) SEQLOCK_UNLOCKED; } while (0)
 
 
 /* Lock out other writers and update the count.
@@ -49,7 +53,7 @@ typedef struct {
  */
 static inline void write_seqlock(seqlock_t *sl)
 {
-	spin_lock(&sl->lock);
+	_spin_lock(&sl->lock);
 	++sl->sequence;
 	smp_wmb();			
 }	
@@ -58,12 +62,12 @@ static inline void write_sequnlock(seqlo
 {
 	smp_wmb();
 	sl->sequence++;
-	spin_unlock(&sl->lock);
+	_spin_unlock(&sl->lock);
 }
 
 static inline int write_tryseqlock(seqlock_t *sl)
 {
-	int ret = spin_trylock(&sl->lock);
+	int ret = _spin_trylock(&sl->lock);
 
 	if (ret) {
 		++sl->sequence;
diff -pruN a/include/linux/signal.h b/include/linux/signal.h
--- a/include/linux/signal.h	2004-10-08 22:40:28.000000000 +0400
+++ b/include/linux/signal.h	2004-10-09 01:26:57.000000000 +0400
@@ -16,7 +16,7 @@
 
 struct sigqueue {
 	struct list_head list;
-	spinlock_t *lock;
+	_spinlock_t *lock;
 	int flags;
 	siginfo_t info;
 	struct user_struct *user;
diff -pruN a/include/linux/smp_lock.h b/include/linux/smp_lock.h
--- a/include/linux/smp_lock.h	2004-10-09 00:36:39.000000000 +0400
+++ b/include/linux/smp_lock.h	2004-10-09 01:26:57.000000000 +0400
@@ -17,7 +17,7 @@
 
 #  define get_kernel_lock()	_spin_lock(&kernel_flag)
 #  define put_kernel_lock()	_spin_unlock(&kernel_flag)
-   extern spinlock_t kernel_flag;
+   extern _spinlock_t kernel_flag;
 
 /*
  * Release global kernel lock.
diff -pruN a/include/linux/wait.h b/include/linux/wait.h
--- a/include/linux/wait.h	2004-10-08 22:40:28.000000000 +0400
+++ b/include/linux/wait.h	2004-10-09 01:26:57.000000000 +0400
@@ -38,7 +38,7 @@ struct __wait_queue {
 };
 
 struct __wait_queue_head {
-	spinlock_t lock;
+	_spinlock_t lock;
 	struct list_head task_list;
 };
 typedef struct __wait_queue_head wait_queue_head_t;
@@ -57,7 +57,7 @@ typedef struct __wait_queue_head wait_qu
 	wait_queue_t name = __WAITQUEUE_INITIALIZER(name, tsk)
 
 #define __WAIT_QUEUE_HEAD_INITIALIZER(name) {				\
-	.lock		= SPIN_LOCK_UNLOCKED,				\
+	.lock		= _SPIN_LOCK_UNLOCKED,				\
 	.task_list	= { &(name).task_list, &(name).task_list } }
 
 #define DECLARE_WAIT_QUEUE_HEAD(name) \
@@ -65,7 +65,7 @@ typedef struct __wait_queue_head wait_qu
 
 static inline void init_waitqueue_head(wait_queue_head_t *q)
 {
-	q->lock = SPIN_LOCK_UNLOCKED;
+	q->lock = _SPIN_LOCK_UNLOCKED;
 	INIT_LIST_HEAD(&q->task_list);
 }
 
diff -pruN a/kernel/exit.c b/kernel/exit.c
--- a/kernel/exit.c	2004-10-08 22:40:49.000000000 +0400
+++ b/kernel/exit.c	2004-10-09 01:26:57.000000000 +0400
@@ -277,7 +277,7 @@ int allow_signal(int sig)
 	if (sig < 1 || sig > _NSIG)
 		return -EINVAL;
 
-	spin_lock_irq(&current->sighand->siglock);
+	_spin_lock_irq(&current->sighand->siglock);
 	sigdelset(&current->blocked, sig);
 	if (!current->mm) {
 		/* Kernel threads handle their own signals.
@@ -287,7 +287,7 @@ int allow_signal(int sig)
 		current->sighand->action[(sig)-1].sa.sa_handler = (void __user *)2;
 	}
 	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	_spin_unlock_irq(&current->sighand->siglock);
 	return 0;
 }
 
@@ -298,10 +298,10 @@ int disallow_signal(int sig)
 	if (sig < 1 || sig > _NSIG)
 		return -EINVAL;
 
-	spin_lock_irq(&current->sighand->siglock);
+	_spin_lock_irq(&current->sighand->siglock);
 	sigaddset(&current->blocked, sig);
 	recalc_sigpending();
-	spin_unlock_irq(&current->sighand->siglock);
+	_spin_unlock_irq(&current->sighand->siglock);
 	return 0;
 }
 
@@ -669,14 +669,14 @@ static void exit_notify(struct task_stru
 		 * sure someone gets all the pending signals.
 		 */
 		read_lock(&tasklist_lock);
-		spin_lock_irq(&tsk->sighand->siglock);
+		_spin_lock_irq(&tsk->sighand->siglock);
 		for (t = next_thread(tsk); t != tsk; t = next_thread(t))
 			if (!signal_pending(t) && !(t->flags & PF_EXITING)) {
 				recalc_sigpending_tsk(t);
 				if (signal_pending(t))
 					signal_wake_up(t, 0);
 			}
-		spin_unlock_irq(&tsk->sighand->siglock);
+		_spin_unlock_irq(&tsk->sighand->siglock);
 		read_unlock(&tasklist_lock);
 	}
 
@@ -855,7 +855,7 @@ task_t fastcall *next_thread(const task_
 #ifdef CONFIG_SMP
 	if (!p->sighand)
 		BUG();
-	if (!spin_is_locked(&p->sighand->siglock) &&
+	if (!_spin_is_locked(&p->sighand->siglock) &&
 				!rwlock_is_locked(&tasklist_lock))
 		BUG();
 #endif
@@ -879,7 +879,7 @@ do_group_exit(int exit_code)
 		struct signal_struct *const sig = current->signal;
 		struct sighand_struct *const sighand = current->sighand;
 		read_lock(&tasklist_lock);
-		spin_lock_irq(&sighand->siglock);
+		_spin_lock_irq(&sighand->siglock);
 		if (sig->group_exit)
 			/* Another thread got here before we took the lock.  */
 			exit_code = sig->group_exit_code;
@@ -888,7 +888,7 @@ do_group_exit(int exit_code)
 			sig->group_exit_code = exit_code;
 			zap_other_threads(current);
 		}
-		spin_unlock_irq(&sighand->siglock);
+		_spin_unlock_irq(&sighand->siglock);
 		read_unlock(&tasklist_lock);
 	}
 
@@ -1041,7 +1041,7 @@ static int wait_task_zombie(task_t *p, i
 		 * as other threads in the parent group can be right
 		 * here reaping other children at the same time.
 		 */
-		spin_lock_irq(&p->parent->sighand->siglock);
+		_spin_lock_irq(&p->parent->sighand->siglock);
 		p->parent->signal->cutime +=
 			p->utime + p->signal->utime + p->signal->cutime;
 		p->parent->signal->cstime +=
@@ -1054,7 +1054,7 @@ static int wait_task_zombie(task_t *p, i
 			p->nvcsw + p->signal->nvcsw + p->signal->cnvcsw;
 		p->parent->signal->cnivcsw +=
 			p->nivcsw + p->signal->nivcsw + p->signal->cnivcsw;
-		spin_unlock_irq(&p->parent->sighand->siglock);
+		_spin_unlock_irq(&p->parent->sighand->siglock);
 	}
 
 	/*
@@ -1292,14 +1292,14 @@ check_continued:
 					continue;
 				if (unlikely(!p->signal))
 					continue;
-				spin_lock_irq(&p->sighand->siglock);
+				_spin_lock_irq(&p->sighand->siglock);
 				if (p->signal->stop_state < 0) {
 					pid_t pid;
 					uid_t uid;
 
 					if (!(options & WNOWAIT))
 						p->signal->stop_state = 0;
-					spin_unlock_irq(&p->sighand->siglock);
+					_spin_unlock_irq(&p->sighand->siglock);
 					pid = p->pid;
 					uid = p->uid;
 					get_task_struct(p);
@@ -1310,7 +1310,7 @@ check_continued:
 					BUG_ON(retval == 0);
 					goto end;
 				}
-				spin_unlock_irq(&p->sighand->siglock);
+				_spin_unlock_irq(&p->sighand->siglock);
 				break;
 			}
 		}
diff -pruN a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	2004-10-08 22:40:49.000000000 +0400
+++ b/kernel/fork.c	2004-10-09 01:26:57.000000000 +0400
@@ -105,9 +105,9 @@ void fastcall add_wait_queue(wait_queue_
 	unsigned long flags;
 
 	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
-	spin_lock_irqsave(&q->lock, flags);
+	_spin_lock_irqsave(&q->lock, flags);
 	__add_wait_queue(q, wait);
-	spin_unlock_irqrestore(&q->lock, flags);
+	_spin_unlock_irqrestore(&q->lock, flags);
 }
 
 EXPORT_SYMBOL(add_wait_queue);
@@ -117,9 +117,9 @@ void fastcall add_wait_queue_exclusive(w
 	unsigned long flags;
 
 	wait->flags |= WQ_FLAG_EXCLUSIVE;
-	spin_lock_irqsave(&q->lock, flags);
+	_spin_lock_irqsave(&q->lock, flags);
 	__add_wait_queue_tail(q, wait);
-	spin_unlock_irqrestore(&q->lock, flags);
+	_spin_unlock_irqrestore(&q->lock, flags);
 }
 
 EXPORT_SYMBOL(add_wait_queue_exclusive);
@@ -128,9 +128,9 @@ void fastcall remove_wait_queue(wait_que
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&q->lock, flags);
+	_spin_lock_irqsave(&q->lock, flags);
 	__remove_wait_queue(q, wait);
-	spin_unlock_irqrestore(&q->lock, flags);
+	_spin_unlock_irqrestore(&q->lock, flags);
 }
 
 EXPORT_SYMBOL(remove_wait_queue);
@@ -153,7 +153,7 @@ void fastcall prepare_to_wait(wait_queue
 	unsigned long flags;
 
 	wait->flags &= ~WQ_FLAG_EXCLUSIVE;
-	spin_lock_irqsave(&q->lock, flags);
+	_spin_lock_irqsave(&q->lock, flags);
 	if (list_empty(&wait->task_list))
 		__add_wait_queue(q, wait);
 	/*
@@ -162,7 +162,7 @@ void fastcall prepare_to_wait(wait_queue
 	 */
 	if (is_sync_wait(wait))
 		set_current_state(state);
-	spin_unlock_irqrestore(&q->lock, flags);
+	_spin_unlock_irqrestore(&q->lock, flags);
 }
 
 EXPORT_SYMBOL(prepare_to_wait);
@@ -173,7 +173,7 @@ prepare_to_wait_exclusive(wait_queue_hea
 	unsigned long flags;
 
 	wait->flags |= WQ_FLAG_EXCLUSIVE;
-	spin_lock_irqsave(&q->lock, flags);
+	_spin_lock_irqsave(&q->lock, flags);
 	if (list_empty(&wait->task_list))
 		__add_wait_queue_tail(q, wait);
 	/*
@@ -182,7 +182,7 @@ prepare_to_wait_exclusive(wait_queue_hea
 	 */
 	if (is_sync_wait(wait))
 		set_current_state(state);
-	spin_unlock_irqrestore(&q->lock, flags);
+	_spin_unlock_irqrestore(&q->lock, flags);
 }
 
 EXPORT_SYMBOL(prepare_to_wait_exclusive);
@@ -206,9 +206,9 @@ void fastcall finish_wait(wait_queue_hea
 	 *    the list).
 	 */
 	if (!list_empty_careful(&wait->task_list)) {
-		spin_lock_irqsave(&q->lock, flags);
+		_spin_lock_irqsave(&q->lock, flags);
 		list_del_init(&wait->task_list);
-		spin_unlock_irqrestore(&q->lock, flags);
+		_spin_unlock_irqrestore(&q->lock, flags);
 	}
 }
 
@@ -309,10 +309,10 @@ static inline int dup_mmap(struct mm_str
 	 * and fork() won't mess up the ordering significantly.
 	 * Add it first so that swapoff can see any swap entries.
 	 */
-	spin_lock(&mmlist_lock);
+	_spin_lock(&mmlist_lock);
 	list_add(&mm->mmlist, &current->mm->mmlist);
 	mmlist_nr++;
-	spin_unlock(&mmlist_lock);
+	_spin_unlock(&mmlist_lock);
 
 	for (mpnt = current->mm->mmap ; mpnt ; mpnt = mpnt->vm_next) {
 		struct file *file;
@@ -362,7 +362,7 @@ static inline int dup_mmap(struct mm_str
 		 * link in first so that swapoff can see swap entries,
 		 * and try_to_unmap_one's find_vma find the new vma.
 		 */
-		spin_lock(&mm->page_table_lock);
+		_spin_lock(&mm->page_table_lock);
 		*pprev = tmp;
 		pprev = &tmp->vm_next;
 
@@ -372,7 +372,7 @@ static inline int dup_mmap(struct mm_str
 
 		mm->map_count++;
 		retval = copy_page_range(mm, current->mm, tmp);
-		spin_unlock(&mm->page_table_lock);
+		_spin_unlock(&mm->page_table_lock);
 
 		if (tmp->vm_ops && tmp->vm_ops->open)
 			tmp->vm_ops->open(tmp);
@@ -412,7 +412,7 @@ static inline void mm_free_pgd(struct mm
 #define mm_free_pgd(mm)
 #endif /* CONFIG_MMU */
 
-spinlock_t mmlist_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+_spinlock_t mmlist_lock __cacheline_aligned_in_smp = _SPIN_LOCK_UNLOCKED;
 int mmlist_nr;
 
 #define allocate_mm()	(kmem_cache_alloc(mm_cachep, SLAB_KERNEL))
@@ -426,7 +426,7 @@ static struct mm_struct * mm_init(struct
 	atomic_set(&mm->mm_count, 1);
 	init_rwsem(&mm->mmap_sem);
 	mm->core_waiters = 0;
-	mm->page_table_lock = SPIN_LOCK_UNLOCKED;
+	mm->page_table_lock = _SPIN_LOCK_UNLOCKED;
 	mm->ioctx_list_lock = RW_LOCK_UNLOCKED;
 	mm->ioctx_list = NULL;
 	mm->default_kioctx = (struct kioctx)INIT_KIOCTX(mm->default_kioctx, *mm);
@@ -473,18 +473,19 @@ void fastcall __mmdrop(struct mm_struct 
  */
 void mmput(struct mm_struct *mm)
 {
-	if (atomic_dec_and_lock(&mm->mm_users, &mmlist_lock)) {
+	if (_atomic_dec_and_lock(&mm->mm_users, &mmlist_lock)) {
+
 		list_del(&mm->mmlist);
 		mmlist_nr--;
-		spin_unlock(&mmlist_lock);
+		_spin_unlock(&mmlist_lock);
 		exit_aio(mm);
 		exit_mmap(mm);
-		put_swap_token(mm);
 		mmdrop(mm);
 	}
 }
-EXPORT_SYMBOL_GPL(mmput);
 
+EXPORT_SYMBOL_GPL(mmput);
+                                                                                             
 /**
  * get_task_mm - acquire a reference to the task's mm
  *
@@ -500,23 +501,24 @@ EXPORT_SYMBOL_GPL(mmput);
  */
 struct mm_struct *get_task_mm(struct task_struct *task)
 {
-	struct mm_struct *mm;
+       struct mm_struct *mm;
 
-	task_lock(task);
-	mm = task->mm;
-	if (mm) {
-		spin_lock(&mmlist_lock);
-		if (!atomic_read(&mm->mm_users))
-			mm = NULL;
-		else
-			atomic_inc(&mm->mm_users);
-		spin_unlock(&mmlist_lock);
-	}
-	task_unlock(task);
-	return mm;
+       task_lock(task);
+       mm = task->mm;
+       if (mm) {
+               _spin_lock(&mmlist_lock);
+               if (!atomic_read(&mm->mm_users))
+                       mm = NULL;
+               else
+                       atomic_inc(&mm->mm_users);
+               _spin_unlock(&mmlist_lock);
+       }
+       task_unlock(task);
+        return mm;
 }
 EXPORT_SYMBOL_GPL(get_task_mm);
 
+
 /* Please note the differences between mmput and mm_release.
  * mmput is called whenever we stop holding onto a mm_struct,
  * error success whatever.
@@ -584,7 +586,7 @@ static int copy_mm(unsigned long clone_f
 		 * allows optimizing out ipis; the tlb_gather_mmu code
 		 * is an example.
 		 */
-		spin_unlock_wait(&oldmm->page_table_lock);
+		_spin_unlock_wait(&oldmm->page_table_lock);
 		goto good_mm;
 	}
 
@@ -835,7 +837,7 @@ static inline int copy_sighand(unsigned 
 	tsk->sighand = sig;
 	if (!sig)
 		return -ENOMEM;
-	spin_lock_init(&sig->siglock);
+	_spin_lock_init(&sig->siglock);
 	atomic_set(&sig->count, 1);
 	memcpy(sig->action, current->sighand->action, sizeof(sig->action));
 	return 0;
@@ -1093,14 +1095,14 @@ static task_t *copy_process(unsigned lon
 	p->parent = p->real_parent;
 
 	if (clone_flags & CLONE_THREAD) {
-		spin_lock(&current->sighand->siglock);
+		_spin_lock(&current->sighand->siglock);
 		/*
 		 * Important: if an exit-all has been started then
 		 * do not create this new thread - the whole thread
 		 * group is supposed to exit anyway.
 		 */
 		if (current->signal->group_exit) {
-			spin_unlock(&current->sighand->siglock);
+			_spin_unlock(&current->sighand->siglock);
 			write_unlock_irq(&tasklist_lock);
 			retval = -EAGAIN;
 			goto bad_fork_cleanup_namespace;
@@ -1118,7 +1120,7 @@ static task_t *copy_process(unsigned lon
 			set_tsk_thread_flag(p, TIF_SIGPENDING);
 		}
 
-		spin_unlock(&current->sighand->siglock);
+		_spin_unlock(&current->sighand->siglock);
 	}
 
 	SET_LINKS(p);
diff -pruN a/include/linux/spinlock.h b/include/linux/spinlock.h
--- a/include/linux/spinlock.h	2004-10-09 08:13:41.000000000 +0400
+++ b/include/linux/spinlock.h	2004-10-09 07:44:41.000000000 +0400
@@ -40,35 +40,40 @@
 
 #define __lockfunc fastcall __attribute__((section(".spinlock.text")))
 
-int __lockfunc _spin_trylock(spinlock_t *lock);
+int __lockfunc _spin_trylock(_spinlock_t *lock);
 int __lockfunc _write_trylock(rwlock_t *lock);
-void __lockfunc _spin_lock(spinlock_t *lock);
+void __lockfunc _spin_lock(_spinlock_t *lock);
 void __lockfunc _write_lock(rwlock_t *lock);
-void __lockfunc _spin_lock(spinlock_t *lock);
+void __lockfunc _spin_lock(_spinlock_t *lock);
 void __lockfunc _read_lock(rwlock_t *lock);
-void __lockfunc _spin_unlock(spinlock_t *lock);
+void __lockfunc _spin_unlock(_spinlock_t *lock);
 void __lockfunc _write_unlock(rwlock_t *lock);
 void __lockfunc _read_unlock(rwlock_t *lock);
-unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock);
+unsigned long __lockfunc __spin_lock_irqsave(_spinlock_t *lock);
 unsigned long __lockfunc _read_lock_irqsave(rwlock_t *lock);
 unsigned long __lockfunc _write_lock_irqsave(rwlock_t *lock);
-void __lockfunc _spin_lock_irq(spinlock_t *lock);
-void __lockfunc _spin_lock_bh(spinlock_t *lock);
+void __lockfunc _spin_lock_irq(_spinlock_t *lock);
+void __lockfunc _spin_lock_bh(_spinlock_t *lock);
 void __lockfunc _read_lock_irq(rwlock_t *lock);
 void __lockfunc _read_lock_bh(rwlock_t *lock);
 void __lockfunc _write_lock_irq(rwlock_t *lock);
 void __lockfunc _write_lock_bh(rwlock_t *lock);
-void __lockfunc _spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags);
-void __lockfunc _spin_unlock_irq(spinlock_t *lock);
-void __lockfunc _spin_unlock_bh(spinlock_t *lock);
+void __lockfunc _spin_unlock_irqrestore(_spinlock_t *lock, unsigned long flags);
+void __lockfunc _spin_unlock_irq(_spinlock_t *lock);
+void __lockfunc _spin_unlock_bh(_spinlock_t *lock);
 void __lockfunc _read_unlock_irqrestore(rwlock_t *lock, unsigned long flags);
 void __lockfunc _read_unlock_irq(rwlock_t *lock);
 void __lockfunc _read_unlock_bh(rwlock_t *lock);
 void __lockfunc _write_unlock_irqrestore(rwlock_t *lock, unsigned long flags);
 void __lockfunc _write_unlock_irq(rwlock_t *lock);
 void __lockfunc _write_unlock_bh(rwlock_t *lock);
-int __lockfunc _spin_trylock_bh(spinlock_t *lock);
+int __lockfunc _spin_trylock_bh(_spinlock_t *lock);
 int in_lock_functions(unsigned long addr);
+
+#define _spin_lock_irqsave(lock, flags)  flags = __spin_lock_irqsave(lock)
+#define read_lock_irqsave(lock, flags)  flags = _read_lock_irqsave(lock)
+#define write_lock_irqsave(lock, flags)  flags = _write_lock_irqsave(lock)
+                                                                                             
 #else
 
 #define in_lock_functions(ADDR) 0
@@ -88,10 +93,10 @@ typedef struct {
 	const char *module;
 	char *owner;
 	int oline;
-} spinlock_t;
-#define SPIN_LOCK_UNLOCKED (spinlock_t) { SPINLOCK_MAGIC, 0, 10, __FILE__ , NULL, 0}
+} _spinlock_t;
+#define _SPIN_LOCK_UNLOCKED (_spinlock_t) { SPINLOCK_MAGIC, 0, 10, __FILE__ , NULL, 0}
 
-#define spin_lock_init(x) \
+#define _spin_lock_init(x) \
 	do { \
 		(x)->magic = SPINLOCK_MAGIC; \
 		(x)->lock = 0; \
@@ -125,7 +130,7 @@ typedef struct {
 
 /* without debugging, spin_is_locked on UP always says
  * FALSE. --> printk if already locked. */
-#define spin_is_locked(x) \
+#define _spin_is_locked(x) \
 	({ \
 	 	CHECK_LOCK(x); \
 		if ((x)->lock&&(x)->babble) { \
@@ -154,7 +159,7 @@ typedef struct {
 		1; \
 	})
 
-#define spin_unlock_wait(x)	\
+#define _spin_unlock_wait(x)	\
 	do { \
 	 	CHECK_LOCK(x); \
 		if ((x)->lock&&(x)->babble) { \
@@ -180,21 +185,21 @@ typedef struct {
  * gcc versions before ~2.95 have a nasty bug with empty initializers.
  */
 #if (__GNUC__ > 2)
-  typedef struct { } spinlock_t;
-  #define SPIN_LOCK_UNLOCKED (spinlock_t) { }
+  typedef struct { } _spinlock_t;
+  #define _SPIN_LOCK_UNLOCKED (_spinlock_t) { }
 #else
-  typedef struct { int gcc_is_buggy; } spinlock_t;
-  #define SPIN_LOCK_UNLOCKED (spinlock_t) { 0 }
+  typedef struct { int gcc_is_buggy; } _spinlock_t;
+  #define _SPIN_LOCK_UNLOCKED (_spinlock_t) { 0 }
 #endif
 
 /*
  * If CONFIG_SMP is unset, declare the _raw_* definitions as nops
  */
-#define spin_lock_init(lock)	do { (void)(lock); } while(0)
+#define _spin_lock_init(lock)	do { (void)(lock); } while(0)
 #define _raw_spin_lock(lock)	do { (void)(lock); } while(0)
-#define spin_is_locked(lock)	((void)(lock), 0)
+#define _spin_is_locked(lock)	((void)(lock), 0)
 #define _raw_spin_trylock(lock)	(((void)(lock), 1))
-#define spin_unlock_wait(lock)	(void)(lock);
+#define _spin_unlock_wait(lock)	(void)(lock);
 #define _raw_spin_unlock(lock) do { (void)(lock); } while(0)
 #endif /* CONFIG_DEBUG_SPINLOCK */
 
@@ -218,7 +223,8 @@ typedef struct {
 #define _spin_trylock(lock)	({preempt_disable(); _raw_spin_trylock(lock) ? \
 				1 : ({preempt_enable(); 0;});})
 
-#define _write_trylock(lock)	({preempt_disable(); _raw_write_trylock(lock) ? \
+#define _write_trylock(lock)	({preempt_disable(); \
+				 _raw_write_trylock(lock) ? \
 				1 : ({preempt_enable(); 0;});})
 
 #define _spin_trylock_bh(lock)	({preempt_disable(); local_bh_disable(); \
@@ -395,6 +401,8 @@ do { \
 
 #endif /* !SMP */
 
+
+#ifndef CONFIG_KMUTEX
 /*
  * Define the various spin_lock and rw_lock methods.  Note we define these
  * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The various
@@ -403,6 +411,16 @@ do { \
 #define spin_trylock(lock)	_spin_trylock(lock)
 #define write_trylock(lock)	_write_trylock(lock)
 
+#define spinlock_t			_spinlock_t 
+#define spin_lock_init			_spin_lock_init
+
+#define spin_unlock_wait		 _spin_unlock_wait
+
+#define cond_resched_lock		_cond_resched_lock
+
+# define spin_is_locked			_spin_is_locked
+# define SPIN_LOCK_UNLOCKED		_SPIN_LOCK_UNLOCKED  
+                                                                                                            
 /* Where's read_trylock? */
 
 #define spin_lock(lock)		_spin_lock(lock)
@@ -413,7 +431,7 @@ do { \
 #define read_unlock(lock)	_read_unlock(lock)
 
 #ifdef CONFIG_SMP
-#define spin_lock_irqsave(lock, flags)	flags = _spin_lock_irqsave(lock)
+#define spin_lock_irqsave(lock, flags)	_spin_lock_irqsave(lock, flags)
 #define read_lock_irqsave(lock, flags)	flags = _read_lock_irqsave(lock)
 #define write_lock_irqsave(lock, flags)	flags = _write_lock_irqsave(lock)
 #else
@@ -435,19 +453,20 @@ do { \
 #define spin_unlock_bh(lock)		_spin_unlock_bh(lock)
 
 #define read_unlock_irqrestore(lock, flags)	_read_unlock_irqrestore(lock, flags)
-#define read_unlock_irq(lock)			_read_unlock_irq(lock)
-#define read_unlock_bh(lock)			_read_unlock_bh(lock)
-
+#define read_unlock_irq(lock)		_read_unlock_irq(lock)
+#define read_unlock_bh(lock)		_read_unlock_bh(lock)
 #define write_unlock_irqrestore(lock, flags)	_write_unlock_irqrestore(lock, flags)
-#define write_unlock_irq(lock)			_write_unlock_irq(lock)
-#define write_unlock_bh(lock)			_write_unlock_bh(lock)
+#define write_unlock_irq(lock)		_write_unlock_irq(lock)
+#define write_unlock_bh(lock)		_write_unlock_bh(lock)
+
+#define spin_trylock_bh(lock)		_spin_trylock_bh(lock)
 
-#define spin_trylock_bh(lock)			_spin_trylock_bh(lock)
+#define atomic_dec_and_lock  		_atomic_dec_and_lock
 
 #ifdef CONFIG_LOCKMETER
-extern void _metered_spin_lock   (spinlock_t *lock);
-extern void _metered_spin_unlock (spinlock_t *lock);
-extern int  _metered_spin_trylock(spinlock_t *lock);
+extern void _metered_spin_lock   (_spinlock_t *lock);
+extern void _metered_spin_unlock (_spinlock_t *lock);
+extern int  _metered_spin_trylock(_spinlock_t *lock);
 extern void _metered_read_lock    (rwlock_t *lock);
 extern void _metered_read_unlock  (rwlock_t *lock);
 extern void _metered_write_lock   (rwlock_t *lock);
@@ -455,10 +474,78 @@ extern void _metered_write_unlock (rwloc
 extern int  _metered_write_trylock(rwlock_t *lock);
 #endif
 
+#else
+
+# include <linux/kmutex.h>
+
+# define SPIN_LOCK_UNLOCKED  KMUTEX_INIT
+
+# define spinlock_t                     struct kmutex
+# define spin_lock_init                 kmutex_init
+                                                                                
+#define spin_trylock(lock)              kmutex_trylock(lock)
+
+#define spin_lock(lock)                 kmutex_lock(lock)
+#define spin_unlock(lock)               kmutex_unlock(lock)
+
+#define spin_lock_irqsave(lock, flags)  \
+		do { \
+			(void)flags; kmutex_lock(lock); \
+	 	} while (0)
+                                             
+#define spin_lock_irq(lock)             kmutex_lock(lock)
+#define spin_lock_bh(lock)              kmutex_lock(lock)
+#define spin_unlock_irqrestore(lock, flags) \
+		do { \
+			(void)flags; kmutex_unlock(lock); \
+		} while (0)
+#define spin_unlock_irq(lock)           kmutex_unlock(lock)
+#define spin_unlock_bh(lock)            kmutex_unlock(lock)
+                                                         
+#define spin_trylock_bh(lock)           kmutex_trylock(lock)
+                                                                 
+# define spin_trylock_bh(lock)          kmutex_trylock(lock)
+
+# define spin_is_locked(lock)		kmutex_is_locked(lock)
+# define spin_unlock_wait(lock)		kmutex_unlock_wait(lock)
+
+/* move to kmutex.h after resolving atomic header file loop */
+extern int  atomic_dec_and_kmutex_lock(atomic_t *atomic, struct kmutex *mtx);
+
+# define atomic_dec_and_lock  atomic_dec_and_kmutex_lock
+
+#define  cond_resched_lock(lock) 	cond_resched()
+
+#define write_trylock(lock)	_write_trylock(lock)
+#define write_lock(lock)	_write_lock(lock)
+#define read_lock(lock)		_read_lock(lock)
+#define write_unlock(lock)	_write_unlock(lock)
+#define read_unlock(lock)	_read_unlock(lock)
+#ifdef CONFIG_SMP
+#define read_lock_irqsave(lock, flags)	flags = _read_lock_irqsave(lock)
+#define write_lock_irqsave(lock, flags)	flags = _write_lock_irqsave(lock)
+#else
+#define read_lock_irqsave(lock, flags)	_read_lock_irqsave(lock, flags)
+#define write_lock_irqsave(lock, flags)	_write_lock_irqsave(lock, flags)
+#endif
+#define read_lock_irq(lock)		_read_lock_irq(lock)
+#define read_lock_bh(lock)		_read_lock_bh(lock)
+
+#define write_lock_irq(lock)		_write_lock_irq(lock)
+#define write_lock_bh(lock)		_write_lock_bh(lock)
+#define read_unlock_irqrestore(lock, flags)	_read_unlock_irqrestore(lock, flags)
+#define read_unlock_irq(lock)		_read_unlock_irq(lock)
+#define read_unlock_bh(lock)		_read_unlock_bh(lock)
+#define write_unlock_irqrestore(lock, flags)	_write_unlock_irqrestore(lock, flags)
+#define write_unlock_irq(lock)		_write_unlock_irq(lock)
+#define write_unlock_bh(lock)		_write_unlock_bh(lock)
+
+#endif
+
 /* "lock on reference count zero" */
 #ifndef ATOMIC_DEC_AND_LOCK
 #include <asm/atomic.h>
-extern int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock);
+extern int _atomic_dec_and_lock(atomic_t *atomic, _spinlock_t *lock);
 #endif
 
 /*



