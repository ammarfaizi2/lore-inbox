Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267409AbTBDV1b>; Tue, 4 Feb 2003 16:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267411AbTBDV1b>; Tue, 4 Feb 2003 16:27:31 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:59038 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267409AbTBDV1Y>;
	Tue, 4 Feb 2003 16:27:24 -0500
Message-ID: <3E403240.2060105@us.ibm.com>
Date: Tue, 04 Feb 2003 13:36:00 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: john stultz <johnstul@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] make lost-tick detection more informative
Content-Type: multipart/mixed;
 boundary="------------080202040400020409040902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080202040400020409040902
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus,
Andrew Morton mentioned this when he sent you the lost tick detection
patch.

The new lost-tick detection code can be relatively uninformative when
something using the common_interrupt->do_IRQ path keeps interrupts
disabled for a long time. This patch will record the last interrupt on
the current CPU, and spit it out along with the stack trace.  I ignore
the timer interrupt, because it is always running when this detection
occurs, and would overwrite the previous interrupt that took a long time.

You can now turn this on with a boot-time option with the same name as
x86-64: "report_lost_ticks".  I don't like the default of 5, so I let it
take a plain report_lost_ticks, or report_lost_ticks=100, if you want.

Warning! Detected 4094446 micro-second gap between interrupts.
  Compensating for 4093 lost ticks.
Call Trace:
 [<c010ab60>] handle_IRQ_event+0x28/0x50
 [<c010ad44>] do_IRQ+0xa0/0x10c
 [<c01097b3>] common_interrupt+0x43/0x58
  Last run common irq: 24: eth2

 irq.c  |    6 ++++++
 time.c |   41 ++++++++++++++++++++++++++++++++---------
 2 files changed, 38 insertions(+), 9 deletions(-)


-- 
Dave Hansen
haveblue@us.ibm.com


--------------080202040400020409040902
Content-Type: text/plain;
 name="lost-tick-culprit-2.5.59-bk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lost-tick-culprit-2.5.59-bk.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.981   -> 1.983  
#	arch/i386/kernel/irq.c	1.25    -> 1.26   
#	arch/i386/kernel/time.c	1.25    -> 1.27   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/02/04	haveblue@elm3b96.(none)	1.982
# report better lock-tick information
# --------------------------------------------
# 03/02/04	haveblue@elm3b96.(none)	1.983
# irq.c:
#   add better last irq description
# time.c:
#   add missing variable
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/irq.c b/arch/i386/kernel/irq.c
--- a/arch/i386/kernel/irq.c	Tue Feb  4 13:30:21 2003
+++ b/arch/i386/kernel/irq.c	Tue Feb  4 13:30:21 2003
@@ -68,6 +68,9 @@
 irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned =
 	{ [0 ... NR_IRQS-1] = { 0, &no_irq_type, NULL, 0, SPIN_LOCK_UNLOCKED}};
 
+/* used to determine the culprits who disabled interrupts for a long time */
+int last_do_IRQ_interrupt[NR_CPUS] = { [0 ... NR_CPUS-1] = -1 };
+
 static void register_irq_proc (unsigned int irq);
 
 /*
@@ -328,6 +331,9 @@
 	irq_desc_t *desc = irq_desc + irq;
 	struct irqaction * action;
 	unsigned int status;
+
+	if(irq) /* don't count the timer */
+		last_do_IRQ_interrupt[cpu] = irq;
 
 	irq_enter();
 
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Tue Feb  4 13:30:21 2003
+++ b/arch/i386/kernel/time.c	Tue Feb  4 13:30:21 2003
@@ -265,25 +265,39 @@
 #endif
 }
 
+static int report_lost_ticks;
+int __init report_lost_ticks_setup(char *str)
+{
+	char* numstr;
+	
+	if (str[0] == '=') {
+		numstr = &str[1];
+		return get_option(&numstr,&report_lost_ticks) ? 1 : 0;
+	} else if (str[0] == '\0') {
+		report_lost_ticks = 5;
+		return 1;
+	}
+
+	return 0;
+}
+
+__setup("report_lost_ticks", report_lost_ticks_setup);
+
 /*
  * Lost tick detection and compensation
  */
+extern int last_do_IRQ_interrupt[];
 static inline void detect_lost_tick(void)
 {
 	/* read time since last interrupt */
 	unsigned long delta = timer->get_offset();
-	static unsigned long dbg_print;
 	
 	/* check if delta is greater then two ticks */
 	if(delta >= 2*(1000000/HZ)){
 
-		/*
-		 * only print debug info first 5 times
-		 */
-		/*
-		 * AKPM: disable this for now; it's nice, but irritating.
-		 */
-		if (0 && dbg_print < 5) {
+		if(report_lost_ticks > 0){
+			int last_irq = last_do_IRQ_interrupt[smp_processor_id()];
+			struct irqaction * action;
 			printk(KERN_WARNING "\nWarning! Detected %lu "
 				"micro-second gap between interrupts.\n",
 				delta);
@@ -291,7 +305,16 @@
 				"ticks.\n",
 				delta/(1000000/HZ)-1);
 			dump_stack();
-			dbg_print++;
+
+			if(last_irq >= 0 && (action = irq_desc[last_irq].action)) {
+				printk(KERN_WARNING "  Last run common irq: %d: %s", 
+					last_irq, action->name);
+				for (action=action->next; action; action = action->next)
+					printk(", %s", action->name);
+				printk("\n");	
+			}
+
+			report_lost_ticks--;
 		}
 		/* calculate number of missed ticks */
 		delta = delta/(1000000/HZ)-1;

--------------080202040400020409040902--

