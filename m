Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130873AbRCJCmE>; Fri, 9 Mar 2001 21:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130882AbRCJCly>; Fri, 9 Mar 2001 21:41:54 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:35245 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130873AbRCJClk>; Fri, 9 Mar 2001 21:41:40 -0500
Message-ID: <3AA9944B.679E5BD3@uow.edu.au>
Date: Sat, 10 Mar 2001 13:41:15 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
CC: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ingo Molnar <mingo@elte.hu>, Keith Owens <kaos@ocs.com.au>
Subject: Re: [patch] serial console vs NMI watchdog
In-Reply-To: <3AA8E6E5.A4AD5035@uow.edu.au> <200103091635.f29GZmC19160@moisil.dev.hydraweb.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> 
> On Sat, 10 Mar 2001 01:21:25 +1100, Andrew Morton <andrewm@uow.edu.au> wrote:
> 
> > +/**
> > + * enable_nmi_watchdog - enables/disables NMI watchdog checking.
> > + * @yes: If zero, disable
> 
> Ugh. I have a feeling that your chances to get Linus to accept this are
> extremely slim.
> 
> Just have two functions, enable_nmi_watchdog and disable_nmi_watchdog.
> You can make them inline, or even macros...

You're right.



--- linux-2.4.2-ac16/include/linux/irq.h	Fri Mar  9 17:11:17 2001
+++ linux-ac/include/linux/irq.h	Sat Mar 10 13:34:22 2001
@@ -56,6 +56,21 @@
 
 #include <asm/hw_irq.h> /* the arch dependent stuff */
 
+/**
+ * nmi_watchdog_disable - disable NMI watchdog checking.
+ * 
+ * If the architecture supports the NMI watchdog, nmi_watchdog_disable() may be used
+ * to temporarily disable it.  Use nmi_watchdog_enable() later on.  It is implemented
+ * via an up/down counter, so you must keep the calls balanced.
+ */
+#ifdef ARCH_HAS_NMI_WATCHDOG
+extern void nmi_watchdog_disable(void);
+extern void nmi_watchdog_enable(void);
+#else
+#define nmi_watchdog_disable() do{} while(0)
+#define nmi_watchdog_enable() do{} while(0)
+#endif
+
 extern int handle_IRQ_event(unsigned int, struct pt_regs *, struct irqaction *);
 extern int setup_irq(unsigned int , struct irqaction * );
 
--- linux-2.4.2-ac16/include/asm-i386/irq.h	Fri Oct  8 03:17:09 1999
+++ linux-ac/include/asm-i386/irq.h	Sat Mar 10 02:17:47 2001
@@ -32,4 +32,8 @@
 extern void disable_irq_nosync(unsigned int);
 extern void enable_irq(unsigned int);
 
+#ifdef CONFIG_X86_LOCAL_APIC
+#define ARCH_HAS_NMI_WATCHDOG		/* See include/linux/irq.h */
+#endif
+
 #endif /* _ASM_IRQ_H */
--- linux-2.4.2-ac16/drivers/char/sysrq.c	Sun Feb 25 17:37:04 2001
+++ linux-ac/drivers/char/sysrq.c	Sat Mar 10 13:07:46 2001
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
+	nmi_watchdog_disable();
 	console_loglevel = 7;
 	printk(KERN_INFO "SysRq: ");
 	switch (key) {
@@ -152,6 +158,7 @@
 		/* Don't use 'A' as it's handled specially on the Sparc */
 	}
 
+	nmi_watchdog_enable();
 	console_loglevel = orig_log_level;
 }
 
--- linux-2.4.2-ac16/arch/i386/kernel/nmi.c	Fri Mar  9 17:10:51 2001
+++ linux-ac/arch/i386/kernel/nmi.c	Sat Mar 10 13:21:59 2001
@@ -226,6 +226,17 @@
 }
 
 static spinlock_t nmi_print_lock = SPIN_LOCK_UNLOCKED;
+static atomic_t nmi_watchdog_disabled = ATOMIC_INIT(0);
+
+void nmi_watchdog_disable(void)
+{
+	atomic_inc(&nmi_watchdog_disabled);
+}
+
+void nmi_watchdog_enable(void)
+{
+	atomic_dec(&nmi_watchdog_disabled);
+}
 
 void nmi_watchdog_tick (struct pt_regs * regs)
 {
@@ -255,7 +266,7 @@
 
 	sum = apic_timer_irqs[cpu];
 
-	if (last_irq_sums[cpu] == sum) {
+	if (last_irq_sums[cpu] == sum && atomic_read(&nmi_watchdog_disabled) == 0) {
 		/*
 		 * Ayiee, looks like this CPU is stuck ...
 		 * wait a few IRQs (5 seconds) before doing the oops ...
