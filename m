Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161051AbWJFOzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbWJFOzR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 10:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161059AbWJFOzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 10:55:17 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:18483 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161051AbWJFOzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 10:55:13 -0400
Date: Fri, 6 Oct 2006 16:55:14 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] irq change build fixes.
Message-ID: <20061006145514.GD26371@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] irq change build fixes.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/s390_ext.c    |    9 ++++++---
 arch/s390/kernel/smp.c         |    2 +-
 arch/s390/kernel/time.c        |   15 +++++++++------
 arch/s390/kernel/traps.c       |    2 +-
 arch/s390/kernel/vtime.c       |    5 +++--
 arch/s390/mm/fault.c           |    2 +-
 drivers/s390/block/dasd_diag.c |    2 +-
 drivers/s390/char/ctrlchar.c   |    2 +-
 drivers/s390/char/keyboard.c   |    2 +-
 drivers/s390/char/sclp.c       |    4 ++--
 drivers/s390/cio/cio.c         |    6 +++++-
 drivers/s390/net/iucv.c        |    4 ++--
 include/asm-s390/hardirq.h     |    2 +-
 include/asm-s390/irq_regs.h    |    1 +
 include/asm-s390/s390_ext.h    |    2 +-
 15 files changed, 36 insertions(+), 24 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/s390_ext.c linux-2.6-patched/arch/s390/kernel/s390_ext.c
--- linux-2.6/arch/s390/kernel/s390_ext.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/s390_ext.c	2006-10-06 16:29:58.000000000 +0200
@@ -16,6 +16,7 @@
 
 #include <asm/lowcore.h>
 #include <asm/s390_ext.h>
+#include <asm/irq_regs.h>
 #include <asm/irq.h>
 
 /*
@@ -114,26 +115,28 @@ void do_extint(struct pt_regs *regs, uns
 {
         ext_int_info_t *p;
         int index;
+	struct pt_regs *old_regs;
 
 	irq_enter();
+	old_regs = set_irq_regs(regs);
 	asm volatile ("mc 0,0");
 	if (S390_lowcore.int_clock >= S390_lowcore.jiffy_timer)
 		/**
 		 * Make sure that the i/o interrupt did not "overtake"
 		 * the last HZ timer interrupt.
 		 */
-		account_ticks(regs);
+		account_ticks();
 	kstat_cpu(smp_processor_id()).irqs[EXTERNAL_INTERRUPT]++;
         index = ext_hash(code);
 	for (p = ext_int_hash[index]; p; p = p->next) {
 		if (likely(p->code == code)) {
 			if (likely(p->handler))
-				p->handler(regs, code);
+				p->handler(code);
 		}
 	}
+	set_irq_regs(old_regs);
 	irq_exit();
 }
 
 EXPORT_SYMBOL(register_external_interrupt);
 EXPORT_SYMBOL(unregister_external_interrupt);
-
diff -urpN linux-2.6/arch/s390/kernel/smp.c linux-2.6-patched/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	2006-10-06 16:29:26.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/smp.c	2006-10-06 16:29:58.000000000 +0200
@@ -339,7 +339,7 @@ void machine_power_off_smp(void)
  * cpus are handled.
  */
 
-void do_ext_call_interrupt(struct pt_regs *regs, __u16 code)
+void do_ext_call_interrupt(__u16 code)
 {
         unsigned long bits;
 
diff -urpN linux-2.6/arch/s390/kernel/time.c linux-2.6-patched/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	2006-10-06 16:29:26.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/time.c	2006-10-06 16:29:58.000000000 +0200
@@ -34,6 +34,7 @@
 #include <asm/s390_ext.h>
 #include <asm/div64.h>
 #include <asm/irq.h>
+#include <asm/irq_regs.h>
 #include <asm/timer.h>
 
 /* change this if you have some constant time drift */
@@ -150,9 +151,9 @@ EXPORT_SYMBOL(do_settimeofday);
 
 
 #ifdef CONFIG_PROFILING
-#define s390_do_profile(regs)	profile_tick(CPU_PROFILING, regs)
+#define s390_do_profile()	profile_tick(CPU_PROFILING)
 #else
-#define s390_do_profile(regs)  do { ; } while(0)
+#define s390_do_profile()	do { ; } while(0)
 #endif /* CONFIG_PROFILING */
 
 
@@ -160,7 +161,7 @@ EXPORT_SYMBOL(do_settimeofday);
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-void account_ticks(struct pt_regs *regs)
+void account_ticks(void)
 {
 	__u64 tmp;
 	__u32 ticks;
@@ -221,10 +222,10 @@ void account_ticks(struct pt_regs *regs)
 	account_tick_vtime(current);
 #else
 	while (ticks--)
-		update_process_times(user_mode(regs));
+		update_process_times(user_mode(get_irq_regs()));
 #endif
 
-	s390_do_profile(regs);
+	s390_do_profile();
 }
 
 #ifdef CONFIG_NO_IDLE_HZ
@@ -285,9 +286,11 @@ static inline void stop_hz_timer(void)
  */
 static inline void start_hz_timer(void)
 {
+	BUG_ON(!in_interrupt());
+
 	if (!cpu_isset(smp_processor_id(), nohz_cpu_mask))
 		return;
-	account_ticks(task_pt_regs(current));
+	account_ticks();
 	cpu_clear(smp_processor_id(), nohz_cpu_mask);
 }
 
diff -urpN linux-2.6/arch/s390/kernel/traps.c linux-2.6-patched/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	2006-10-06 16:29:26.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/traps.c	2006-10-06 16:29:58.000000000 +0200
@@ -61,7 +61,7 @@ extern pgm_check_handler_t do_dat_except
 #ifdef CONFIG_PFAULT
 extern int pfault_init(void);
 extern void pfault_fini(void);
-extern void pfault_interrupt(struct pt_regs *regs, __u16 error_code);
+extern void pfault_interrupt(__u16 error_code);
 static ext_int_info_t ext_int_pfault;
 #endif
 extern pgm_check_handler_t do_monitor_call;
diff -urpN linux-2.6/arch/s390/kernel/vtime.c linux-2.6-patched/arch/s390/kernel/vtime.c
--- linux-2.6/arch/s390/kernel/vtime.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/vtime.c	2006-10-06 16:29:58.000000000 +0200
@@ -22,6 +22,7 @@
 
 #include <asm/s390_ext.h>
 #include <asm/timer.h>
+#include <asm/irq_regs.h>
 
 static ext_int_info_t ext_int_info_timer;
 DEFINE_PER_CPU(struct vtimer_queue, virt_cpu_timer);
@@ -241,7 +242,7 @@ static void do_callbacks(struct list_hea
 /*
  * Handler for the virtual CPU timer.
  */
-static void do_cpu_timer_interrupt(struct pt_regs *regs, __u16 error_code)
+static void do_cpu_timer_interrupt(__u16 error_code)
 {
 	int cpu;
 	__u64 next, delta;
@@ -274,7 +275,7 @@ static void do_cpu_timer_interrupt(struc
 		list_move_tail(&event->entry, &cb_list);
 	}
 	spin_unlock(&vt_list->lock);
-	do_callbacks(&cb_list, regs);
+	do_callbacks(&cb_list, get_irq_regs());
 
 	/* next event is first in list */
 	spin_lock(&vt_list->lock);
diff -urpN linux-2.6/arch/s390/mm/fault.c linux-2.6-patched/arch/s390/mm/fault.c
--- linux-2.6/arch/s390/mm/fault.c	2006-10-06 16:29:26.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/fault.c	2006-10-06 16:29:58.000000000 +0200
@@ -451,7 +451,7 @@ void pfault_fini(void)
 }
 
 asmlinkage void
-pfault_interrupt(struct pt_regs *regs, __u16 error_code)
+pfault_interrupt(__u16 error_code)
 {
 	struct task_struct *tsk;
 	__u16 subcode;
diff -urpN linux-2.6/drivers/s390/block/dasd_diag.c linux-2.6-patched/drivers/s390/block/dasd_diag.c
--- linux-2.6/drivers/s390/block/dasd_diag.c	2006-10-06 16:29:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_diag.c	2006-10-06 16:29:58.000000000 +0200
@@ -218,7 +218,7 @@ dasd_diag_term_IO(struct dasd_ccw_req * 
 
 /* Handle external interruption. */
 static void
-dasd_ext_handler(struct pt_regs *regs, __u16 code)
+dasd_ext_handler(__u16 code)
 {
 	struct dasd_ccw_req *cqr, *next;
 	struct dasd_device *device;
diff -urpN linux-2.6/drivers/s390/char/ctrlchar.c linux-2.6-patched/drivers/s390/char/ctrlchar.c
--- linux-2.6/drivers/s390/char/ctrlchar.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/ctrlchar.c	2006-10-06 16:29:58.000000000 +0200
@@ -20,7 +20,7 @@ static int ctrlchar_sysrq_key;
 static void
 ctrlchar_handle_sysrq(void *tty)
 {
-	handle_sysrq(ctrlchar_sysrq_key, NULL, (struct tty_struct *) tty);
+	handle_sysrq(ctrlchar_sysrq_key, (struct tty_struct *) tty);
 }
 
 static DECLARE_WORK(ctrlchar_work, ctrlchar_handle_sysrq, NULL);
diff -urpN linux-2.6/drivers/s390/char/keyboard.c linux-2.6-patched/drivers/s390/char/keyboard.c
--- linux-2.6/drivers/s390/char/keyboard.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/keyboard.c	2006-10-06 16:29:58.000000000 +0200
@@ -304,7 +304,7 @@ kbd_keycode(struct kbd_data *kbd, unsign
 		if (kbd->sysrq) {
 			if (kbd->sysrq == K(KT_LATIN, '-')) {
 				kbd->sysrq = 0;
-				handle_sysrq(value, NULL, kbd->tty);
+				handle_sysrq(value, kbd->tty);
 				return;
 			}
 			if (value == '-') {
diff -urpN linux-2.6/drivers/s390/char/sclp.c linux-2.6-patched/drivers/s390/char/sclp.c
--- linux-2.6/drivers/s390/char/sclp.c	2006-10-06 16:29:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/char/sclp.c	2006-10-06 16:29:58.000000000 +0200
@@ -324,7 +324,7 @@ __sclp_find_req(u32 sccb)
  * Prepare read event data request if necessary. Start processing of next
  * request on queue. */
 static void
-sclp_interrupt_handler(struct pt_regs *regs, __u16 code)
+sclp_interrupt_handler(__u16 code)
 {
 	struct sclp_req *req;
 	u32 finished_sccb;
@@ -743,7 +743,7 @@ EXPORT_SYMBOL(sclp_reactivate);
 /* Handler for external interruption used during initialization. Modify
  * request state to done. */
 static void
-sclp_check_handler(struct pt_regs *regs, __u16 code)
+sclp_check_handler(__u16 code)
 {
 	u32 finished_sccb;
 
diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2006-10-06 16:29:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2006-10-06 16:29:58.000000000 +0200
@@ -19,6 +19,7 @@
 #include <asm/cio.h>
 #include <asm/delay.h>
 #include <asm/irq.h>
+#include <asm/irq_regs.h>
 #include <asm/setup.h>
 #include "airq.h"
 #include "cio.h"
@@ -606,15 +607,17 @@ do_IRQ (struct pt_regs *regs)
 	struct tpi_info *tpi_info;
 	struct subchannel *sch;
 	struct irb *irb;
+	struct pt_regs *old_regs;
 
 	irq_enter ();
+	old_regs = set_irq_regs(regs);
 	asm volatile ("mc 0,0");
 	if (S390_lowcore.int_clock >= S390_lowcore.jiffy_timer)
 		/**
 		 * Make sure that the i/o interrupt did not "overtake"
 		 * the last HZ timer interrupt.
 		 */
-		account_ticks(regs);
+		account_ticks();
 	/*
 	 * Get interrupt information from lowcore
 	 */
@@ -652,6 +655,7 @@ do_IRQ (struct pt_regs *regs)
 		 * out of the sie which costs more cycles than it saves.
 		 */
 	} while (!MACHINE_IS_VM && tpi (NULL) != 0);
+	set_irq_regs(old_regs);
 	irq_exit ();
 }
 
diff -urpN linux-2.6/drivers/s390/net/iucv.c linux-2.6-patched/drivers/s390/net/iucv.c
--- linux-2.6/drivers/s390/net/iucv.c	2006-10-06 16:29:35.000000000 +0200
+++ linux-2.6-patched/drivers/s390/net/iucv.c	2006-10-06 16:29:58.000000000 +0200
@@ -116,7 +116,7 @@ static DEFINE_SPINLOCK(iucv_irq_queue_lo
  *Internal function prototypes
  */
 static void iucv_tasklet_handler(unsigned long);
-static void iucv_irq_handler(struct pt_regs *, __u16);
+static void iucv_irq_handler(__u16);
 
 static DECLARE_TASKLET(iucv_tasklet,iucv_tasklet_handler,0);
 
@@ -2251,7 +2251,7 @@ iucv_sever(__u16 pathid, __u8 user_data[
  * Places the interrupt buffer on a queue and schedules iucv_tasklet_handler().
  */
 static void
-iucv_irq_handler(struct pt_regs *regs, __u16 code)
+iucv_irq_handler(__u16 code)
 {
 	iucv_irqdata *irqdata;
 
diff -urpN linux-2.6/include/asm-s390/hardirq.h linux-2.6-patched/include/asm-s390/hardirq.h
--- linux-2.6/include/asm-s390/hardirq.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/hardirq.h	2006-10-06 16:29:58.000000000 +0200
@@ -32,6 +32,6 @@ typedef struct {
 
 #define HARDIRQ_BITS	8
 
-extern void account_ticks(struct pt_regs *);
+extern void account_ticks(void);
 
 #endif /* __ASM_HARDIRQ_H */
diff -urpN linux-2.6/include/asm-s390/irq_regs.h linux-2.6-patched/include/asm-s390/irq_regs.h
--- linux-2.6/include/asm-s390/irq_regs.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/irq_regs.h	2006-10-06 16:29:58.000000000 +0200
@@ -0,0 +1 @@
+#include <asm-generic/irq_regs.h>
diff -urpN linux-2.6/include/asm-s390/s390_ext.h linux-2.6-patched/include/asm-s390/s390_ext.h
--- linux-2.6/include/asm-s390/s390_ext.h	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/s390_ext.h	2006-10-06 16:29:58.000000000 +0200
@@ -10,7 +10,7 @@
  *               Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
 
-typedef void (*ext_int_handler_t)(struct pt_regs *regs, __u16 code);
+typedef void (*ext_int_handler_t)(__u16 code);
 
 /*
  * Warning: if you change ext_int_info_t you have to change the
