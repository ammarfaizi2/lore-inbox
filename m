Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbUBYMi1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 07:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbUBYMi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 07:38:27 -0500
Received: from gizmo08ps.bigpond.com ([144.140.71.18]:19361 "HELO
	gizmo08ps.bigpond.com") by vger.kernel.org with SMTP
	id S261310AbUBYMiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 07:38:05 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Subject: Re: [PATCH] 2.6, 2.4, Nforce2, Experimental idle halt workaround instead of apic ack delay.
Date: Wed, 25 Feb 2004 22:38:55 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       Ian Kumlien <pomac@vapor.com>, Jesse Allen <the3dfxdude@hotmail.com>,
       Craig Bradney <cbradney@zip.com.au>, Daniel Drake <dan@reactivated.net>,
       a.verweij@student.tudelft.nl
References: <200402120122.06362.ross@datscreative.com.au> <200402141124.50880.ross@datscreative.com.au> <40395961.40608@gmx.de>
In-Reply-To: <40395961.40608@gmx.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fdJPAKurqxBhx5Z"
Message-Id: <200402252238.55834.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_fdJPAKurqxBhx5Z
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 23 February 2004 11:37, Prakash K. Cheemplavam wrote:
> Oh before I forget, I had to resolve a reject by hand, but I *think* I 
> did it right. (And yes, I used your corrected versionof the patch.) 
> Well, maybe you take a look over the patch and rediff. :-)
> 
> Prakash
> 
> 
> 

Hi Prakash,
Patches attached rediffed for 2.6.3 and 2.6.3-mm3.

Late comers see start of this thread for more detail.
Also Arjen's page at http://atlas.et.tudelft.nl/verwei90/nforce2/index.html 

Note that the ioapic patch is not essential for 2.6.3-mm3, only if you want
to use nmi_debug=1. 
2.6.3-mm3 sets up 8254 timer OK in a virtual wire mode without this patch.

It will be interesting to see if there is any clock skew associated with these
patches, I get no skew on 2.4.24. 

The kernel arg to invoke the idle halt workaround is still "idle=C1halt".
I have increased slightly the ndelay time from 500ns to 600ns - I had
some lockups on startup and shutdown with certain removable IDE drives,
this seemed to help. Feel free to adjust the value if you want to.

Also if you want snappier performance you can try different values instead of 6
in this line:
+			(apic_read(APIC_TMCCT) > (apic_read(APIC_TMICT)>>6))) {

The 6 yields a divide by 2^6 = 64 for the 1.6% (1/64 = 1.6%)

If you try say 5 for 2^5 = 32 for 3.1% or 4 for 6% or 3 for 12.5% 
then if less than this percentage of time remains in the slice the system won't
go into hlt disconnect thus avoiding the reconnect - recovery time associated
with that cycle that would have been.

I have found a need for less ndelay time with the more the percentage
(lower number)- there appears to be a tradeoff between the two. 

3 for 12.5% or 2 for 25% might even work with no ndelay time i.e. the ndelay
line removed or commented from the code, for some.

Of course expect a bit more heat under moderate loads with an increase in
the percentage but some may prefer it for their application.

Happy hacking,
Ross.


For 2.6.3 ioapic
---CUT HERE---
--- linux-2.6.3/arch/i386/kernel/io_apic.c.original	2004-02-18 13:57:22.000000000 +1000
+++ linux-2.6.3/arch/i386/kernel/io_apic.c	2004-02-24 11:57:04.000000000 +1000
@@ -2188,12 +2188,56 @@ static inline void check_timer(void)
 				check_nmi_watchdog();
 			}
 			return;
 		}
 		clear_IO_APIC_pin(0, pin1);
-		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
+		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC INTIN%d\n",pin1);
+	}
+
+#if defined(CONFIG_ACPI_BOOT) && defined(CONFIG_X86_UP_IOAPIC)
+	/* for nforce2 try vector 0 on pin0
+	 * Note 8259a is already masked, also by default
+	 * the io_apic_set_pci_routing call disables the 8259 irq 0
+	 * so we must be connected directly to the 8254 timer if this works
+	 * Note2: this violates the above comment re Subtle but works!
+	 */
+	printk(KERN_INFO "..TIMER: Is timer irq0 connected to IO-APIC INTIN0? ...\n");
+	if (pin1 != -1) {
+		extern spinlock_t i8259A_lock;
+		unsigned long flags;
+		int tok, saved_timer_ack = timer_ack;
+		/*
+		 * Ok, does IRQ0 through the IOAPIC work?
+		 */
+		io_apic_set_pci_routing ( 0, 0, 0, 0, 0); /* connect pin */
+		unmask_IO_APIC_irq(0);
+		timer_ack = 0;
+
+		/*
+		 * Ok, does IRQ0 through the IOAPIC work?
+		 */
+		spin_lock_irqsave(&i8259A_lock, flags);
+		Dprintk("..TIMER 8259A ints disabled?, imr1:%02x, imr2:%02x\n", inb(0x21), inb(0xA1));
+		tok = timer_irq_works();
+		spin_unlock_irqrestore(&i8259A_lock, flags);
+		if (tok) {
+			if (nmi_watchdog == NMI_IO_APIC) {
+				disable_8259A_irq(0);
+				setup_nmi();
+				enable_8259A_irq(0);
+				check_nmi_watchdog();
+			}
+			printk(KERN_INFO "..TIMER: works OK on IO-APIC INTIN0 irq0\n" );
+			return;
+		}
+		/* failed */
+		timer_ack = saved_timer_ack;
+		clear_IO_APIC_pin(0, 0);
+		io_apic_set_pci_routing ( 0, pin1, 0, 0, 0);
+		printk(KERN_ERR "..MP-BIOS: 8254 timer not connected to IO-APIC INTIN0\n");
 	}
+#endif
 
 	printk(KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
 	if (pin2 != -1) {
 		printk("\n..... (found pin %d) ...", pin2);
 		/*
---CUT HERE---


For 2.6.3 idleC1halt
---CUT HERE---
--- linux-2.6.3/arch/i386/kernel/process.c.original	2004-02-18 13:57:11.000000000 +1000
+++ linux-2.6.3/arch/i386/kernel/process.c	2004-02-24 11:25:56.000000000 +1000
@@ -48,10 +48,11 @@
 #include <asm/irq.h>
 #include <asm/desc.h>
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
+#include <asm/apic.h>
 
 #include <linux/irq.h>
 #include <linux/err.h>
 
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
@@ -87,11 +88,11 @@ EXPORT_SYMBOL(enable_hlt);
 
 /*
  * We use this if we don't have any better
  * idle routine..
  */
-void default_idle(void)
+static void default_idle(void)
 {
 	if (!hlt_counter && current_cpu_data.hlt_works_ok) {
 		local_irq_disable();
 		if (!need_resched())
 			safe_halt();
@@ -99,10 +100,29 @@ void default_idle(void)
 			local_irq_enable();
 	}
 }
 
 /*
+ * We use this to avoid nforce2 lockups
+ * Reduces frequency of C1 disconnects
+ */
+static void c1halt_idle(void)
+{
+	if (!hlt_counter && current_cpu_data.hlt_works_ok) {
+		local_irq_disable();
+		/* only hlt disconnect if more than 1.6% of apic interval remains */
+		if( (!need_resched()) &&
+			(apic_read(APIC_TMCCT) > (apic_read(APIC_TMICT)>>6))) {
+			ndelay(600); /* helps nforce2 but adds 0.6us hard int latency */
+			safe_halt();  /* nothing better to do until we wake up */
+		}
+		else
+			local_irq_enable();
+	}
+}
+
+/*
  * On SMP it's slightly faster (but much more power-consuming!)
  * to poll the ->work.need_resched flag instead of waiting for the
  * cross-CPU IPI to arrive. Use this option with caution.
  */
 static void poll_idle (void)
@@ -136,20 +156,18 @@ static void poll_idle (void)
  * The idle thread. There's no useful work to be
  * done, so just try to conserve power and have a
  * low exit latency (ie sit in a loop waiting for
  * somebody to say that they'd like to reschedule)
  */
+static void (*idle)(void);
 void cpu_idle (void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
-			void (*idle)(void) = pm_idle;
-
 			if (!idle)
-				idle = default_idle;
-
+				idle = pm_idle ? pm_idle : default_idle;
 			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
 			idle();
 		}
 		schedule();
 	}
@@ -200,16 +218,18 @@ void __init select_idle_routine(const st
 
 static int __init idle_setup (char *str)
 {
 	if (!strncmp(str, "poll", 4)) {
 		printk("using polling idle threads.\n");
-		pm_idle = poll_idle;
+		idle = poll_idle;
 	} else if (!strncmp(str, "halt", 4)) {
 		printk("using halt in idle threads.\n");
-		pm_idle = default_idle;
+		idle = default_idle;
+	} else if (!strncmp(str, "C1halt", 6)) {
+		printk("using C1 halt disconnect friendly idle threads.\n");
+		idle = c1halt_idle;
 	}
-
 	return 1;
 }
 
 __setup("idle=", idle_setup);
 
---CUT HERE---

For 2.6.3-mm3 ioapic
---CUT HERE---
--- linux-2.6.3-mm3/arch/i386/kernel/io_apic.c.original	2004-02-24 12:26:32.000000000 +1000
+++ linux-2.6.3-mm3/arch/i386/kernel/io_apic.c	2004-02-24 16:40:56.000000000 +1000
@@ -2206,12 +2206,54 @@ static inline void check_timer(void)
 					timer_ack = !cpu_has_tsc;
 			}
 			return;
 		}
 		clear_IO_APIC_pin(0, pin1);
-		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
+		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC INTIN%d\n",pin1);
+	}
+
+#if defined(CONFIG_ACPI_BOOT) && defined(CONFIG_X86_UP_IOAPIC)
+	/* for nforce2 try vector 0 on pin0
+	 * Note 8259a is already masked, also by default
+	 * the io_apic_set_pci_routing call disables the 8259 irq 0
+	 * so we must be connected directly to the 8254 timer if this works
+	 */
+	printk(KERN_INFO "..TIMER: Is timer irq0 connected to IO-APIC INTIN0? ...\n");
+	if (pin1 != -1) {
+		extern spinlock_t i8259A_lock;
+		unsigned long flags;
+		int tok;
+		/*
+		 * Ok, does IRQ0 through the IOAPIC work?
+		 */
+		io_apic_set_pci_routing ( 0, 0, 0, 0, 0); /* connect pin */
+		unmask_IO_APIC_irq(0);
+
+		/*
+		 * Ok, does IRQ0 through the IOAPIC work?
+		 */
+		spin_lock_irqsave(&i8259A_lock, flags);
+		Dprintk("..TIMER 8259A ints disabled?, imr1:%02x, imr2:%02x\n", inb(0x21), inb(0xA1));
+		tok = timer_irq_works();
+		spin_unlock_irqrestore(&i8259A_lock, flags);
+		if (tok) {
+			if (nmi_watchdog == NMI_IO_APIC) {
+				disable_8259A_irq(0);
+				setup_nmi();
+				enable_8259A_irq(0);
+				if (check_nmi_watchdog() < 0);
+					timer_ack = !cpu_has_tsc;
+			}
+			printk(KERN_INFO "..TIMER: works OK on IO-APIC INTIN0 irq0\n" );
+			return;
+		}
+		/* failed */
+		clear_IO_APIC_pin(0, 0);
+		io_apic_set_pci_routing ( 0, pin1, 0, 0, 0);
+		printk(KERN_ERR "..MP-BIOS: 8254 timer not connected to IO-APIC INTIN0\n");
 	}
+#endif
 
 	printk(KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
 	if (pin2 != -1) {
 		printk("\n..... (found pin %d) ...", pin2);
 		/*
---CUT HERE---

For 2.6.3-mm3 idleC1halt
---CUT HERE---
--- linux-2.6.3-mm3/arch/i386/kernel/process.c.original	2004-02-24 12:26:32.000000000 +1000
+++ linux-2.6.3-mm3/arch/i386/kernel/process.c	2004-02-24 15:54:26.000000000 +1000
@@ -49,10 +49,11 @@
 #include <asm/desc.h>
 #include <asm/atomic_kmap.h>
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
 #endif
+#include <asm/apic.h>
 
 #include <linux/irq.h>
 #include <linux/err.h>
 
 asmlinkage void ret_from_fork(void) __asm__("ret_from_fork");
@@ -88,11 +89,11 @@ EXPORT_SYMBOL(enable_hlt);
 
 /*
  * We use this if we don't have any better
  * idle routine..
  */
-void default_idle(void)
+static void default_idle(void)
 {
 	if (!hlt_counter && current_cpu_data.hlt_works_ok) {
 		local_irq_disable();
 		if (!need_resched())
 			safe_halt();
@@ -100,10 +101,29 @@ void default_idle(void)
 			local_irq_enable();
 	}
 }
 
 /*
+ * We use this to avoid nforce2 lockups
+ * Reduces frequency of C1 disconnects
+ */
+static void c1halt_idle(void)
+{
+	if (!hlt_counter && current_cpu_data.hlt_works_ok) {
+		local_irq_disable();
+		/* only hlt disconnect if more than 1.6% of apic interval remains */
+		if( (!need_resched()) &&
+			(apic_read(APIC_TMCCT) > (apic_read(APIC_TMICT)>>6))) {
+			ndelay(600); /* helps nforce2 but adds 0.6us hard int latency */
+			safe_halt();  /* nothing better to do until we wake up */
+		}
+		else
+			local_irq_enable();
+	}
+}
+
+/*
  * On SMP it's slightly faster (but much more power-consuming!)
  * to poll the ->work.need_resched flag instead of waiting for the
  * cross-CPU IPI to arrive. Use this option with caution.
  */
 static void poll_idle (void)
@@ -137,20 +157,18 @@ static void poll_idle (void)
  * The idle thread. There's no useful work to be
  * done, so just try to conserve power and have a
  * low exit latency (ie sit in a loop waiting for
  * somebody to say that they'd like to reschedule)
  */
+static void (*idle)(void);
 void cpu_idle (void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
 		while (!need_resched()) {
-			void (*idle)(void) = pm_idle;
-
 			if (!idle)
-				idle = default_idle;
-
+				idle = pm_idle ? pm_idle : default_idle;
 			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
 			idle();
 		}
 		schedule();
 	}
@@ -201,16 +219,18 @@ void __init select_idle_routine(const st
 
 static int __init idle_setup (char *str)
 {
 	if (!strncmp(str, "poll", 4)) {
 		printk("using polling idle threads.\n");
-		pm_idle = poll_idle;
+		idle = poll_idle;
 	} else if (!strncmp(str, "halt", 4)) {
 		printk("using halt in idle threads.\n");
-		pm_idle = default_idle;
+		idle = default_idle;
+	} else if (!strncmp(str, "C1halt", 6)) {
+		printk("using C1 halt disconnect friendly idle threads.\n");
+		idle = c1halt_idle;
 	}
-
 	return 1;
 }
 
 __setup("idle=", idle_setup);
 
---CUT HERE---

Attached patches also in tarballs if whitespace problems.

--Boundary-00=_fdJPAKurqxBhx5Z
Content-Type: application/x-tgz;
  name="nforce2-lockup-patches-rd-2.6.3.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="nforce2-lockup-patches-rd-2.6.3.tgz"

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

--Boundary-00=_fdJPAKurqxBhx5Z
Content-Type: application/x-tgz;
  name="nforce2-lockup-patches-rd-2.6.3-mm3.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="nforce2-lockup-patches-rd-2.6.3-mm3.tgz"

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
bWhDG9rQhja0oQ1t6I9L/wYmjzjQACgAAA==

--Boundary-00=_fdJPAKurqxBhx5Z--

