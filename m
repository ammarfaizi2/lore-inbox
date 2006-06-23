Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751920AbWFWSo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751920AbWFWSo7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbWFWSmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:42:36 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:18639 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751921AbWFWSmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:42:01 -0400
Message-Id: <20060623183915.285707000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:31:13 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 17/21] convert hp300 irq code
Content-Disposition: inline; filename=0023-M68K-convert-hp300-irq-code.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/hp300/Makefile |    2 -
 arch/m68k/hp300/config.c |   11 +--
 arch/m68k/hp300/ints.c   |  175 ----------------------------------------------
 arch/m68k/hp300/ints.h   |    9 --
 arch/m68k/hp300/time.c   |    3 -
 5 files changed, 6 insertions(+), 194 deletions(-)
 delete mode 100644 arch/m68k/hp300/ints.c
 delete mode 100644 arch/m68k/hp300/ints.h

4170e111d26ddfeabdf6af7cdedc33f665f61dff
diff --git a/arch/m68k/hp300/Makefile b/arch/m68k/hp300/Makefile
index 89b6317..288b9c6 100644
--- a/arch/m68k/hp300/Makefile
+++ b/arch/m68k/hp300/Makefile
@@ -2,4 +2,4 @@ #
 # Makefile for Linux arch/m68k/hp300 source directory
 #
 
-obj-y		:= ksyms.o config.o ints.o time.o reboot.o
+obj-y		:= ksyms.o config.o time.o reboot.o
diff --git a/arch/m68k/hp300/config.c b/arch/m68k/hp300/config.c
index 6d129ee..2ef271c 100644
--- a/arch/m68k/hp300/config.c
+++ b/arch/m68k/hp300/config.c
@@ -21,7 +21,6 @@ #include <asm/io.h>                     
 #include <asm/hp300hw.h>
 #include <asm/rtc.h>
 
-#include "ints.h"
 #include "time.h"
 
 unsigned long hp300_model;
@@ -64,8 +63,6 @@ static char *hp300_models[] __initdata =
 static char hp300_model_name[13] = "HP9000/";
 
 extern void hp300_reset(void);
-extern irqreturn_t (*hp300_default_handler[])(int, void *, struct pt_regs *);
-extern int show_hp300_interrupts(struct seq_file *, void *);
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 extern int hp300_setup_serial_console(void) __init;
 #endif
@@ -245,16 +242,16 @@ static unsigned int hp300_get_ss(void)
 		hp300_rtc_read(RTC_REG_SEC2);
 }
 
+static void __init hp300_init_IRQ(void)
+{
+}
+
 void __init config_hp300(void)
 {
 	mach_sched_init      = hp300_sched_init;
 	mach_init_IRQ        = hp300_init_IRQ;
-	mach_request_irq     = hp300_request_irq;
-	mach_free_irq        = hp300_free_irq;
 	mach_get_model       = hp300_get_model;
-	mach_get_irq_list    = show_hp300_interrupts;
 	mach_gettimeoffset   = hp300_gettimeoffset;
-	mach_default_handler = &hp300_default_handler;
 	mach_hwclk	     = hp300_hwclk;
 	mach_get_ss	     = hp300_get_ss;
 	mach_reset           = hp300_reset;
diff --git a/arch/m68k/hp300/ints.c b/arch/m68k/hp300/ints.c
deleted file mode 100644
index 0c5bb40..0000000
--- a/arch/m68k/hp300/ints.c
+++ /dev/null
@@ -1,175 +0,0 @@
-/*
- *  linux/arch/m68k/hp300/ints.c
- *
- *  Copyright (C) 1998 Philip Blundell <philb@gnu.org>
- *
- *  This file contains the HP300-specific interrupt handling.
- *  We only use the autovector interrupts, and therefore we need to
- *  maintain lists of devices sharing each ipl.
- *  [ipl list code added by Peter Maydell <pmaydell@chiark.greenend.org.uk> 06/1998]
- */
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/kernel_stat.h>
-#include <linux/interrupt.h>
-#include <linux/spinlock.h>
-#include <asm/machdep.h>
-#include <asm/irq.h>
-#include <asm/io.h>
-#include <asm/system.h>
-#include <asm/traps.h>
-#include <asm/ptrace.h>
-#include <asm/errno.h>
-#include "ints.h"
-
-/* Each ipl has a linked list of interrupt service routines.
- * Service routines are added via hp300_request_irq() and removed
- * via hp300_free_irq(). The device driver should set IRQ_FLG_FAST
- * if it needs to be serviced early (eg FIFOless UARTs); this will
- * cause it to be added at the front of the queue rather than
- * the back.
- * Currently IRQ_FLG_SLOW and flags=0 are treated identically; if
- * we needed three levels of priority we could distinguish them
- * but this strikes me as mildly ugly...
- */
-
-/* we start with no entries in any list */
-static irq_node_t *hp300_irq_list[HP300_NUM_IRQS];
-
-static spinlock_t irqlist_lock;
-
-/* This handler receives all interrupts, dispatching them to the registered handlers */
-static irqreturn_t hp300_int_handler(int irq, void *dev_id, struct pt_regs *fp)
-{
-        irq_node_t *t;
-        /* We just give every handler on the chain an opportunity to handle
-         * the interrupt, in priority order.
-         */
-        for(t = hp300_irq_list[irq]; t; t=t->next)
-                t->handler(irq, t->dev_id, fp);
-        /* We could put in some accounting routines, checks for stray interrupts,
-         * etc, in here. Note that currently we can't tell whether or not
-         * a handler handles the interrupt, though.
-         */
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t hp300_badint(int irq, void *dev_id, struct pt_regs *fp)
-{
-	num_spurious += 1;
-	return IRQ_NONE;
-}
-
-irqreturn_t (*hp300_default_handler[SYS_IRQS])(int, void *, struct pt_regs *) = {
-	[0] = hp300_badint,
-	[1] = hp300_int_handler,
-	[2] = hp300_int_handler,
-	[3] = hp300_int_handler,
-	[4] = hp300_int_handler,
-	[5] = hp300_int_handler,
-	[6] = hp300_int_handler,
-	[7] = hp300_int_handler
-};
-
-/* dev_id had better be unique to each handler because it's the only way we have
- * to distinguish handlers when removing them...
- *
- * It would be pretty easy to support IRQ_FLG_LOCK (handler is not replacable)
- * and IRQ_FLG_REPLACE (handler replaces existing one with this dev_id)
- * if we wanted to. IRQ_FLG_FAST is needed for devices where interrupt latency
- * matters (eg the dreaded FIFOless UART...)
- */
-int hp300_request_irq(unsigned int irq,
-                      irqreturn_t (*handler) (int, void *, struct pt_regs *),
-                      unsigned long flags, const char *devname, void *dev_id)
-{
-        irq_node_t *t, *n = new_irq_node();
-
-        if (!n)                                   /* oops, no free nodes */
-                return -ENOMEM;
-
-	spin_lock_irqsave(&irqlist_lock, flags);
-
-        if (!hp300_irq_list[irq]) {
-                /* no list yet */
-                hp300_irq_list[irq] = n;
-                n->next = NULL;
-        } else if (flags & IRQ_FLG_FAST) {
-                /* insert at head of list */
-                n->next = hp300_irq_list[irq];
-                hp300_irq_list[irq] = n;
-        } else {
-                /* insert at end of list */
-                for(t = hp300_irq_list[irq]; t->next; t = t->next)
-                        /* do nothing */;
-                n->next = NULL;
-                t->next = n;
-        }
-
-        /* Fill in n appropriately */
-        n->handler = handler;
-        n->flags = flags;
-        n->dev_id = dev_id;
-        n->devname = devname;
-	spin_unlock_irqrestore(&irqlist_lock, flags);
-	return 0;
-}
-
-void hp300_free_irq(unsigned int irq, void *dev_id)
-{
-        irq_node_t *t;
-        unsigned long flags;
-
-        spin_lock_irqsave(&irqlist_lock, flags);
-
-        t = hp300_irq_list[irq];
-        if (!t)                                   /* no handlers at all for that IRQ */
-        {
-                printk(KERN_ERR "hp300_free_irq: attempt to remove nonexistent handler for IRQ %d\n", irq);
-                spin_unlock_irqrestore(&irqlist_lock, flags);
-		return;
-        }
-
-        if (t->dev_id == dev_id)
-        {                                         /* removing first handler on chain */
-                t->flags = IRQ_FLG_STD;           /* we probably don't really need these */
-                t->dev_id = NULL;
-                t->devname = NULL;
-                t->handler = NULL;                /* frees this irq_node_t */
-                hp300_irq_list[irq] = t->next;
-		spin_unlock_irqrestore(&irqlist_lock, flags);
-		return;
-        }
-
-        /* OK, must be removing from middle of the chain */
-
-        for (t = hp300_irq_list[irq]; t->next && t->next->dev_id != dev_id; t = t->next)
-                /* do nothing */;
-        if (!t->next)
-        {
-                printk(KERN_ERR "hp300_free_irq: attempt to remove nonexistent handler for IRQ %d\n", irq);
-		spin_unlock_irqrestore(&irqlist_lock, flags);
-		return;
-        }
-        /* remove the entry after t: */
-        t->next->flags = IRQ_FLG_STD;
-        t->next->dev_id = NULL;
-	t->next->devname = NULL;
-	t->next->handler = NULL;
-        t->next = t->next->next;
-
-	spin_unlock_irqrestore(&irqlist_lock, flags);
-}
-
-int show_hp300_interrupts(struct seq_file *p, void *v)
-{
-	return 0;
-}
-
-void __init hp300_init_IRQ(void)
-{
-	spin_lock_init(&irqlist_lock);
-}
diff --git a/arch/m68k/hp300/ints.h b/arch/m68k/hp300/ints.h
deleted file mode 100644
index 8cfabe2..0000000
--- a/arch/m68k/hp300/ints.h
+++ /dev/null
@@ -1,9 +0,0 @@
-extern void hp300_init_IRQ(void);
-extern void (*hp300_handlers[8])(int, void *, struct pt_regs *);
-extern void hp300_free_irq(unsigned int irq, void *dev_id);
-extern int hp300_request_irq(unsigned int irq,
-		irqreturn_t (*handler) (int, void *, struct pt_regs *),
-		unsigned long flags, const char *devname, void *dev_id);
-
-/* number of interrupts, includes 0 (what's that?) */
-#define HP300_NUM_IRQS 8
diff --git a/arch/m68k/hp300/time.c b/arch/m68k/hp300/time.c
index 8da5b1b..7df0566 100644
--- a/arch/m68k/hp300/time.c
+++ b/arch/m68k/hp300/time.c
@@ -18,7 +18,6 @@ #include <asm/io.h>
 #include <asm/system.h>
 #include <asm/traps.h>
 #include <asm/blinken.h>
-#include "ints.h"
 
 /* Clock hardware definitions */
 
@@ -71,7 +70,7 @@ void __init hp300_sched_init(irqreturn_t
 
   asm volatile(" movpw %0,%1@(5)" : : "d" (INTVAL), "a" (CLOCKBASE));
 
-  cpu_request_irq(6, hp300_tick, IRQ_FLG_STD, "timer tick", vector);
+  request_irq(IRQ_AUTO_6, hp300_tick, IRQ_FLG_STD, "timer tick", vector);
 
   out_8(CLOCKBASE + CLKCR2, 0x1);		/* select CR1 */
   out_8(CLOCKBASE + CLKCR1, 0x40);		/* enable irq */
-- 
1.3.3

--

