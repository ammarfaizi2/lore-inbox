Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130486AbRCIOW3>; Fri, 9 Mar 2001 09:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130497AbRCIOWU>; Fri, 9 Mar 2001 09:22:20 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:2787 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130486AbRCIOV7>; Fri, 9 Mar 2001 09:21:59 -0500
Message-ID: <3AA8E6E5.A4AD5035@uow.edu.au>
Date: Sat, 10 Mar 2001 01:21:25 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
        Keith Owens <kaos@ocs.com.au>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] serial console vs NMI watchdog
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SYSRQ-T on serial console can crash the machine.  This
is because a large amount of output is sent to a slow
device while interrupts are disabled.  The NMI
watchdog triggers.

The interrupt disabling happens in pc_keyb.c:keyboard_interrupt().
Changing this code to *not* disable interrupts looks complex.

I see two ways of fixing this.  One is to do the sysrq
stuff outside the spin_lock_irq(), with:

static void keyboard_interrupt(int irq, void *dev_id, struct pt_regs *regs)
{
+	extern void (*sysrq_handler)(void);
+	void (*my_sysrq_handler)(void);

        spin_lock_irq(&kbd_controller_lock);
        handle_kbd_event();
+	my_sysrq_handler = sysrq_handler;
+	sysrq_handler = 0;
        spin_unlock_irq(&kbd_controller_lock);
+	if (my_sysrq_handler)
+		(*my_sysrq_handler)();
}

But I didn't do that, because I suspect there are other
places in the kernel (development and debug stuff) where
we want to turn the NMI watchdog handler off for a while.

So this patch creates a new API function

	enable_nmi_watchdog(int yes);

and uses it within the sysrq code.

BTW: NMI watchdog is now disabled by default in 2.4.3-pre3.
The `nmi_watchdog=1' boot option is needed to enable it.



--- linux-2.4.2-ac16/include/linux/irq.h	Fri Mar  9 17:11:17 2001
+++ linux-ac/include/linux/irq.h	Sat Mar 10 01:02:12 2001
@@ -56,6 +56,20 @@
 
 #include <asm/hw_irq.h> /* the arch dependent stuff */
 
+/**
+ * enable_nmi_watchdog - enables/disables NMI watchdog checking.
+ * @yes: If zero, disable
+ * 
+ * If the architecture supports the NMI watchdog, enable_nmi_watchdog() may be used
+ * to temporarily disable it.  Calls to enable_nmi_watchdog() may be nested - it is
+ * implemented as an up/down counter, so the calls must be balanced.
+ */
+#ifdef ARCH_HAS_NMI_WATCHDOG
+extern void enable_nmi_watchdog(int yes);
+#else
+#define enable_nmi_watchdog(yes) do{} while(0)
+#endif
+
 extern int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
 extern int setup_irq(unsigned int , struct irqaction * );
 
--- linux-2.4.2-ac16/include/asm-i386/irq.h	Fri Oct  8 03:17:09 1999
+++ linux-ac/include/asm-i386/irq.h	Fri Mar  9 22:59:15 2001
@@ -32,4 +32,8 @@
 extern void disable_irq_nosync(unsigned int);
 extern void enable_irq(unsigned int);
 
+#ifdef CONFIG_X86_LOCAL_APIC
+#define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/irq.h */
+#endif
+
 #endif /* _ASM_IRQ_H */
--- linux-2.4.2-ac16/drivers/char/sysrq.c	Sun Feb 25 17:37:04 2001
+++ linux-ac/drivers/char/sysrq.c	Fri Mar  9 23:00:39 2001
@@ -23,6 +23,7 @@
 #include <linux/quotaops.h>
 #include <linux/smp_lock.h>
 #include <linux/module.h>
+#include <linux/irq.h>
 
 #include <asm/ptrace.h>
 
@@ -69,6 +70,11 @@
 	if (!key)
 		return;
 
+	/*
+	 * Interrupts are disabled, and serial consoles are slow. So
+	 * Let's suspend the NMI watchdog.
+	 */
+	enable_nmi_watchdog(0);
 	console_loglevel = 7;
 	printk(KERN_INFO "SysRq: ");
 	switch (key) {
@@ -152,6 +158,7 @@
 		/* Don't use 'A' as it's handled specially on the Sparc */
 	}
 
+	enable_nmi_watchdog(1);
 	console_loglevel = orig_log_level;
 }
 
--- linux-2.4.2-ac16/arch/i386/kernel/nmi.c	Fri Mar  9 17:10:51 2001
+++ linux-ac/arch/i386/kernel/nmi.c	Sat Mar 10 01:10:50 2001
@@ -226,6 +226,15 @@
 }
 
 static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
+static atomic_t nmi_watchdog_enabled = ATOMIC_INIT(0);	/* 0 == enabled */
+
+void enable_nmi_watchdog(int yes)
+{
+	if (yes)
+		atomic_inc(&nmi_watchdog_enabled);
+	else
+		atomic_dec(&nmi_watchdog_enabled);
+}
 
 void nmi_watchdog_tick (struct pt_regs * regs)
 {
@@ -255,7 +264,7 @@
 
 	sum = apic_timer_irqs[cpu];
 
-	if (last_irq_sums[cpu] == sum) {
+	if (last_irq_sums[cpu] == sum && atomic_read(&nmi_watchdog_enabled) == 0) {
 		/*
 		 * Ayiee, looks like this CPU is stuck ...
 		 * wait a few IRQs (5 seconds) before doing the oops ...
