Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267609AbTA3SsF>; Thu, 30 Jan 2003 13:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267611AbTA3SsF>; Thu, 30 Jan 2003 13:48:05 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:9357 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267609AbTA3SsD>;
	Thu, 30 Jan 2003 13:48:03 -0500
Message-ID: <3E39756F.6080400@us.ibm.com>
Date: Thu, 30 Jan 2003 10:56:47 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: [PATCH] make lost-tick detection more informative
Content-Type: multipart/mixed;
 boundary="------------070606050407070604000209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070606050407070604000209
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The new lost-tick detection code is pretty cool, but it can be
relatively uninformative when something using the
common_interrupt->do_IRQ path keeps interrupts disabled for a long time.
This patch will record the last interrupt on the current CPU, and spit
it out along with the stack trace.

There are no guarantees here.  If preemption is enabled, all bets are
off, and this data could be incorrect.  It would be relatively silly to
disable preemption, just to get some debugging data to be more accurate.

Warning! Detected 4094446 micro-second gap between interrupts.
  Compensating for 4093 lost ticks.
Call Trace:
 [<c010ab60>] handle_IRQ_event+0x28/0x50
 [<c010ad44>] do_IRQ+0xa0/0x10c
 [<c01097b3>] common_interrupt+0x43/0x58
  Last run common irq: 24: eth2


-- 
Dave Hansen
haveblue@us.ibm.com

--------------070606050407070604000209
Content-Type: text/plain;
 name="lost-tick-culprit-2.5.59-mjb2-1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lost-tick-culprit-2.5.59-mjb2-1.patch"

diff -ru linux-2.5.59-mjb2-clean/arch/i386/kernel/irq.c linux-2.5.59-mjb2-8way/arch/i386/kernel/irq.c
--- linux-2.5.59-mjb2-clean/arch/i386/kernel/irq.c	Wed Jan 29 19:02:39 2003
+++ linux-2.5.59-mjb2-8way/arch/i386/kernel/irq.c	Wed Jan 29 22:54:22 2003
@@ -68,6 +68,9 @@
 irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =
 	{ [0 ... NR_IRQS-1] = { 0, &no_irq_type, NULL, 0, SPIN_LOCK_UNLOCKED}};
 
+/* used to determine the culprits who disabled interrupts for a long time */
+int last_do_IRQ_interrupt[NR_CPUS] = { [0 ... NR_CPUS-1] = -1 };
+
 static void register_irq_proc (unsigned int irq);
 
 /*
@@ -330,6 +333,9 @@
 	struct irqaction * action;
 	unsigned int status;
 
+	if(irq) /* don't count the timer */
+		last_do_IRQ_interrupt[cpu] = irq;
+	
 	irq_enter();
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
diff -ru linux-2.5.59-mjb2-clean/arch/i386/kernel/time.c linux-2.5.59-mjb2-8way/arch/i386/kernel/time.c
--- linux-2.5.59-mjb2-clean/arch/i386/kernel/time.c	Wed Jan 29 19:02:39 2003
+++ linux-2.5.59-mjb2-8way/arch/i386/kernel/time.c	Thu Jan 30 10:51:55 2003
@@ -267,7 +267,7 @@
 #endif
 }
 
-
+extern int last_do_IRQ_interrupt[];
 /* Lost tick detection and compensation */
 static inline void detect_lost_tick(void)
 {
@@ -280,12 +280,21 @@
 
 		/* only print debug info first 5 times */
 		if(dbg_print < 5){
+			int last_irq = last_do_IRQ_interrupt[smp_processor_id()];
+			struct irqaction * action;
 			printk(KERN_WARNING "\nWarning! Detected %lu micro-second"
 					" gap between interrupts.\n",delta);
 			printk(KERN_WARNING "  Compensating for %lu lost ticks.\n",
 					delta/(1000000/HZ)-1);
 			/* dump trace info */
 			show_trace(NULL);
+			if(last_irq >= 0 && (action = irq_desc[last_irq].action)) {
+				printk(KERN_WARNING "  Last run common irq: %d: %s", 
+					last_irq, action->name);
+				for (action=action->next; action; action = action->next)
+					printk(", %s", action->name);
+				printk("\n");	
+			}
 			dbg_print++;
 		}
 		/* calculate number of missed ticks */

--------------070606050407070604000209--

