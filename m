Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161051AbWJKNea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbWJKNea (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 09:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbWJKNea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 09:34:30 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:48920 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161051AbWJKNe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 09:34:29 -0400
Date: Wed, 11 Oct 2006 15:34:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] irq change improvements.
Message-ID: <20061011133421.GA9305@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] irq change improvements.

Remove the last few places where a pointer to pt_regs gets passed.
Also make sure we call set_irq_regs() before irq_enter() and after
irq_exit(). This doesn't fix anything but makes sure s390 looks the
same like all other architectures.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/appldata/appldata_base.c |    2 +-
 arch/s390/kernel/s390_ext.c        |    4 ++--
 arch/s390/kernel/vtime.c           |    8 ++++----
 drivers/s390/cio/cio.c             |    4 ++--
 include/asm-s390/timer.h           |    2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff -urpN linux-2.6/arch/s390/appldata/appldata_base.c linux-2.6-patched/arch/s390/appldata/appldata_base.c
--- linux-2.6/arch/s390/appldata/appldata_base.c	2006-10-11 15:23:16.000000000 +0200
+++ linux-2.6-patched/arch/s390/appldata/appldata_base.c	2006-10-11 15:23:34.000000000 +0200
@@ -109,7 +109,7 @@ static LIST_HEAD(appldata_ops_list);
  *
  * schedule work and reschedule timer
  */
-static void appldata_timer_function(unsigned long data, struct pt_regs *regs)
+static void appldata_timer_function(unsigned long data)
 {
 	P_DEBUG("   -= Timer =-\n");
 	P_DEBUG("CPU: %i, expire_count: %i\n", smp_processor_id(),
diff -urpN linux-2.6/arch/s390/kernel/s390_ext.c linux-2.6-patched/arch/s390/kernel/s390_ext.c
--- linux-2.6/arch/s390/kernel/s390_ext.c	2006-10-11 15:23:16.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/s390_ext.c	2006-10-11 15:23:34.000000000 +0200
@@ -117,8 +117,8 @@ void do_extint(struct pt_regs *regs, uns
         int index;
 	struct pt_regs *old_regs;
 
-	irq_enter();
 	old_regs = set_irq_regs(regs);
+	irq_enter();
 	asm volatile ("mc 0,0");
 	if (S390_lowcore.int_clock >= S390_lowcore.jiffy_timer)
 		/**
@@ -134,8 +134,8 @@ void do_extint(struct pt_regs *regs, uns
 				p->handler(code);
 		}
 	}
-	set_irq_regs(old_regs);
 	irq_exit();
+	set_irq_regs(old_regs);
 }
 
 EXPORT_SYMBOL(register_external_interrupt);
diff -urpN linux-2.6/arch/s390/kernel/vtime.c linux-2.6-patched/arch/s390/kernel/vtime.c
--- linux-2.6/arch/s390/kernel/vtime.c	2006-10-11 15:23:16.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/vtime.c	2006-10-11 15:23:34.000000000 +0200
@@ -209,11 +209,11 @@ static void list_add_sorted(struct vtime
  * Do the callback functions of expired vtimer events.
  * Called from within the interrupt handler.
  */
-static void do_callbacks(struct list_head *cb_list, struct pt_regs *regs)
+static void do_callbacks(struct list_head *cb_list)
 {
 	struct vtimer_queue *vt_list;
 	struct vtimer_list *event, *tmp;
-	void (*fn)(unsigned long, struct pt_regs*);
+	void (*fn)(unsigned long);
 	unsigned long data;
 
 	if (list_empty(cb_list))
@@ -224,7 +224,7 @@ static void do_callbacks(struct list_hea
 	list_for_each_entry_safe(event, tmp, cb_list, entry) {
 		fn = event->function;
 		data = event->data;
-		fn(data, regs);
+		fn(data);
 
 		if (!event->interval)
 			/* delete one shot timer */
@@ -275,7 +275,7 @@ static void do_cpu_timer_interrupt(__u16
 		list_move_tail(&event->entry, &cb_list);
 	}
 	spin_unlock(&vt_list->lock);
-	do_callbacks(&cb_list, get_irq_regs());
+	do_callbacks(&cb_list);
 
 	/* next event is first in list */
 	spin_lock(&vt_list->lock);
diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2006-10-11 15:23:22.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2006-10-11 15:23:34.000000000 +0200
@@ -609,8 +609,8 @@ do_IRQ (struct pt_regs *regs)
 	struct irb *irb;
 	struct pt_regs *old_regs;
 
-	irq_enter ();
 	old_regs = set_irq_regs(regs);
+	irq_enter();
 	asm volatile ("mc 0,0");
 	if (S390_lowcore.int_clock >= S390_lowcore.jiffy_timer)
 		/**
@@ -655,8 +655,8 @@ do_IRQ (struct pt_regs *regs)
 		 * out of the sie which costs more cycles than it saves.
 		 */
 	} while (!MACHINE_IS_VM && tpi (NULL) != 0);
+	irq_exit();
 	set_irq_regs(old_regs);
-	irq_exit ();
 }
 
 #ifdef CONFIG_CCW_CONSOLE
diff -urpN linux-2.6/include/asm-s390/timer.h linux-2.6-patched/include/asm-s390/timer.h
--- linux-2.6/include/asm-s390/timer.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/timer.h	2006-10-11 15:23:34.000000000 +0200
@@ -26,7 +26,7 @@ struct vtimer_list {
 	spinlock_t lock;
 	unsigned long magic;
 
-	void (*function)(unsigned long, struct pt_regs*);
+	void (*function)(unsigned long);
 	unsigned long data;
 };
 
