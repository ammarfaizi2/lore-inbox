Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131396AbRCKKJD>; Sun, 11 Mar 2001 05:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131400AbRCKKIy>; Sun, 11 Mar 2001 05:08:54 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:42685 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131396AbRCKKIi>; Sun, 11 Mar 2001 05:08:38 -0500
Message-ID: <3AAB4EB4.4569908A@uow.edu.au>
Date: Sun, 11 Mar 2001 21:08:52 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Keith Owens <kaos@ocs.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] nmi-watchdog-2.4.2-A1
In-Reply-To: <15973.984297609@ocs3.ocs-net> <Pine.LNX.4.30.0103110933310.1595-200000@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Sun, 11 Mar 2001, Keith Owens wrote:
> 
> > Works for me.  It even makes kdb simpler.
> 
> agreed. Also, touch_nmi_watchdog() is stateless and is thus much less
> prone to locking bugs.
> 
> i've attached nmi-watchdog-2.4.2-A1 that implements touch_nmi_watchdog(),
> ontop of 2.4.2-ac18, and changes show_state() to use this interface. (the
> patch also takes the NMI counters out of the obscure in-function place
> they used to be.)
> 
> the patch compiles & boots just fine on 2.4.2-ac18 in both SMP and
> APIC-less-UP mode. The NMI watchdog is functional, and SysRq-T does not
> cause a lockup if used with a slow serial console that takes more than 5
> seconds to output the tasklist.
> 

Sorry, this doesn't look right. Are you sure you booted
with `nmi_watchdog=1'?  It was turned off by default in -ac18.

Two things:

- CPU A could be doing the SYSRQ printing, while
  CPU B is spinning on a lock which CPU A holds. The
  NMI watchdog will then whack CPU B.  So touch_nmi_watchdog()
  needs to touch *all* CPUs.  (kbd_controller_lock, for example).

- We need to touch the NMI more than once during the 
  SYSRQ-T output - five seconds isn't enough.

  The correctest way is, I think, to touch_nmi() in
  rs285_console_write(), lp_console_write() and serial_console_write().
  We _could_ just touch it in show_state(), but that means
  we still get whacked if we do a lot of printk()s with interrupts
  disabled from some random place in the kernel.


--- linux-2.4.2-ac18/arch/i386/kernel/nmi.c	Sun Mar 11 15:12:31 2001
+++ linux-ac/arch/i386/kernel/nmi.c	Sun Mar 11 21:03:18 2001
@@ -226,37 +226,39 @@
 }
 
 static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
-static atomic_t nmi_watchdog_disabled = ATOMIC_INIT(0);
 
-void nmi_watchdog_disable(void)
-{
-	atomic_inc(&nmi_watchdog_disabled);
-}
+/*
+ * The best way to detect whether a CPU has a 'hard lockup' problem
+ * is to check its local APIC timer IRQ counts. If they are not
+ * changing then that CPU has some problem.
+ *
+ * as these watchdog NMI IRQs are generated on every CPU, we only
+ * have to check the current processor.
+ *
+ * since NMIs dont listen to _any_ locks, we have to be extremely
+ * careful not to rely on unsafe variables. The printk might lock
+ * up though, so we have to break up any console locks first ...
+ * [when there will be more tty-related locks, break them up
+ *  here too!]
+ */
+
+static unsigned int
+	last_irq_sums [NR_CPUS],
+	alert_counter [NR_CPUS];
 
-void nmi_watchdog_enable(void)
+void touch_nmi_watchdog (void)
 {
-	atomic_dec(&nmi_watchdog_disabled);
+	/*
+	 * Just reset the alert counters.
+	 */
+	int cpu;
+
+	for (cpu = 0; cpu < smp_num_cpus; cpu++)
+		alert_counter[cpu] = 0;
 }
 
 void nmi_watchdog_tick (struct pt_regs * regs)
 {
-	/*
-	 * the best way to detect wether a CPU has a 'hard lockup' problem
-	 * is to check it's local APIC timer IRQ counts. If they are not
-	 * changing then that CPU has some problem.
-	 *
-	 * as these watchdog NMI IRQs are broadcasted to every CPU, here
-	 * we only have to check the current processor.
-	 *
-	 * since NMIs dont listen to _any_ locks, we have to be extremely
-	 * careful not to rely on unsafe variables. The printk might lock
-	 * up though, so we have to break up any console locks first ...
-	 * [when there will be more tty-related locks, break them up
-	 *  here too!]
-	 */
-
-	static unsigned int last_irq_sums [NR_CPUS],
-				alert_counter [NR_CPUS];
 
 	/*
 	 * Since current-> is always on the stack, and we always switch
@@ -266,7 +268,7 @@
 
 	sum = apic_timer_irqs[cpu];
 
-	if (last_irq_sums[cpu] == sum && atomic_read(&nmi_watchdog_disabled) == 0) {
+	if (last_irq_sums[cpu] == sum) {
 		/*
 		 * Ayiee, looks like this CPU is stuck ...
 		 * wait a few IRQs (5 seconds) before doing the oops ...
--- linux-2.4.2-ac18/drivers/char/sysrq.c	Sun Mar 11 15:12:34 2001
+++ linux-ac/drivers/char/sysrq.c	Sun Mar 11 20:57:30 2001
@@ -70,11 +70,6 @@
 	if (!key)
 		return;
 
-	/*
-	 * Interrupts are disabled, and serial consoles are slow. So
-	 * Let's suspend the NMI watchdog.
-	 */
-	nmi_watchdog_disable();
 	console_loglevel = 7;
 	printk(KERN_INFO "SysRq: ");
 	switch (key) {
@@ -158,7 +153,6 @@
 		/* Don't use 'A' as it's handled specially on the Sparc */
 	}
 
-	nmi_watchdog_enable();
 	console_loglevel = orig_log_level;
 }
 
--- linux-2.4.2-ac18/drivers/char/serial.c	Sun Mar 11 15:12:34 2001
+++ linux-ac/drivers/char/serial.c	Sun Mar 11 20:58:58 2001
@@ -5478,10 +5478,11 @@
 /*
  *	Wait for transmitter & holding register to empty
  */
-static inline void wait_for_xmitr(struct async_struct *info)
+static void wait_for_xmitr(struct async_struct *info)
 {
 	unsigned int status, tmout = 1000000;
 
+	touch_nmi_watchdog();
 	do {
 		status = serial_in(info, UART_LSR);
 
--- linux-2.4.2-ac18/drivers/char/serial_21285.c	Sun Feb 25 17:37:03 2001
+++ linux-ac/drivers/char/serial_21285.c	Sun Mar 11 21:00:26 2001
@@ -385,6 +385,7 @@
 			while (*CSR_UARTFLG & 0x20);
 			*CSR_UARTDR = '\r';
 		}
+		touch_nmi_watchdog();
 	}
 	enable_irq(IRQ_CONTX);
 }
--- linux-2.4.2-ac18/drivers/char/lp.c	Sun Mar 11 15:12:34 2001
+++ linux-ac/drivers/char/lp.c	Sun Mar 11 21:01:29 2001
@@ -576,8 +576,8 @@
 			canwrite = lf - s;
 
 		if (canwrite > 0) {
+			touch_nmi_watchdog();
 			written = parport_write (port, s, canwrite);
-
 			if (written <= 0)
 				continue;
 
@@ -594,6 +594,7 @@
 			s++;
 			count--;
 			do {
+				touch_nmi_watchdog();
 				written = parport_write (port, crlf, i);
 				if (written > 0)
 					i -= written, crlf += written;
--- linux-2.4.2-ac18/include/linux/irq.h	Sun Mar 11 15:12:48 2001
+++ linux-ac/include/linux/irq.h	Sun Mar 11 20:37:16 2001
@@ -57,18 +57,16 @@
 #include <asm/hw_irq.h> /* the arch dependent stuff */
 
 /**
- * nmi_watchdog_disable - disable NMI watchdog checking.
+ * touch_nmi_watchdog - restart NMI watchdog timeout.
  * 
- * If the architecture supports the NMI watchdog, nmi_watchdog_disable() may be used
- * to temporarily disable it.  Use nmi_watchdog_enable() later on.  It is implemented
- * via an up/down counter, so you must keep the calls balanced.
+ * If the architecture supports the NMI watchdog, touch_nmi_watchdog()
+ * may be used to reset the timeout - for code which intentionally
+ * disables interrupts for a long time. This call is stateless.
  */
 #ifdef ARCH_HAS_NMI_WATCHDOG
-extern void nmi_watchdog_disable(void);
-extern void nmi_watchdog_enable(void);
+extern void touch_nmi_watchdog(void);
 #else
-#define nmi_watchdog_disable() do{} while(0)
-#define nmi_watchdog_enable() do{} while(0)
+# define touch_nmi_watchdog() do { } while(0)
 #endif
 
 extern int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
