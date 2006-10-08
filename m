Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751147AbWJHNat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWJHNat (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 09:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWJHNat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 09:30:49 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:28652 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751147AbWJHNas
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 09:30:48 -0400
Date: Sun, 8 Oct 2006 14:30:44 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: davem@davemloft.net
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc32 pt_regs fixes
Message-ID: <20061008133044.GJ29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/kernel/irq.c          |   23 +++++++++++++++--------
 arch/sparc/kernel/pcic.c         |    4 ++--
 arch/sparc/kernel/sun4c_irq.c    |    2 +-
 arch/sparc/kernel/sun4d_irq.c    |   12 ++++++++----
 arch/sparc/kernel/sun4d_smp.c    |    6 +++++-
 arch/sparc/kernel/sun4m_irq.c    |    2 +-
 arch/sparc/kernel/sun4m_smp.c    |    7 ++++++-
 arch/sparc/kernel/tick14.c       |    2 +-
 arch/sparc/kernel/time.c         |    7 ++++---
 drivers/parport/parport_sunbpp.c |    2 +-
 include/asm-sparc/floppy.h       |    2 +-
 include/asm-sparc/irq.h          |    6 +++---
 include/asm-sparc/irq_regs.h     |    1 +
 13 files changed, 49 insertions(+), 27 deletions(-)

diff --git a/arch/sparc/kernel/irq.c b/arch/sparc/kernel/irq.c
index 72f0201..ae4dfc8 100644
--- a/arch/sparc/kernel/irq.c
+++ b/arch/sparc/kernel/irq.c
@@ -46,6 +46,7 @@ #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/pcic.h>
 #include <asm/cacheflush.h>
+#include <asm/irq_regs.h>
 
 #ifdef CONFIG_SMP
 #define SMP_NOP2 "nop; nop;\n\t"
@@ -133,8 +134,8 @@ static void irq_panic(void)
     prom_halt();
 }
 
-void (*sparc_init_timers)(irqreturn_t (*)(int, void *,struct pt_regs *)) =
-    (void (*)(irqreturn_t (*)(int, void *,struct pt_regs *))) irq_panic;
+void (*sparc_init_timers)(irqreturn_t (*)(int, void *)) =
+    (void (*)(irqreturn_t (*)(int, void *))) irq_panic;
 
 /*
  * Dave Redman (djhr@tadpole.co.uk)
@@ -319,12 +320,14 @@ void unexpected_irq(int irq, void *dev_i
 
 void handler_irq(int irq, struct pt_regs * regs)
 {
+	struct pt_regs *old_regs;
 	struct irqaction * action;
 	int cpu = smp_processor_id();
 #ifdef CONFIG_SMP
 	extern void smp4m_irq_rotate(int cpu);
 #endif
 
+	old_regs = set_irq_regs(regs);
 	irq_enter();
 	disable_pil_irq(irq);
 #ifdef CONFIG_SMP
@@ -338,27 +341,31 @@ #endif
 	do {
 		if (!action || !action->handler)
 			unexpected_irq(irq, NULL, regs);
-		action->handler(irq, action->dev_id, regs);
+		action->handler(irq, action->dev_id);
 		action = action->next;
 	} while (action);
 	sparc_irq[irq].flags &= ~SPARC_IRQ_INPROGRESS;
 	enable_pil_irq(irq);
 	irq_exit();
+	set_irq_regs(old_regs);
 }
 
 #ifdef CONFIG_BLK_DEV_FD
-extern void floppy_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+extern void floppy_interrupt(int irq, void *dev_id)
 
 void sparc_floppy_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
+	struct pt_regs *old_regs;
 	int cpu = smp_processor_id();
 
+	old_regs = set_irq_regs(regs);
 	disable_pil_irq(irq);
 	irq_enter();
 	kstat_cpu(cpu).irqs[irq]++;
-	floppy_interrupt(irq, dev_id, regs);
+	floppy_interrupt(irq, dev_id);
 	irq_exit();
 	enable_pil_irq(irq);
+	set_irq_regs(old_regs);
 	// XXX Eek, it's totally changed with preempt_count() and such
 	// if (softirq_pending(cpu))
 	//	do_softirq();
@@ -369,7 +376,7 @@ #endif
  * thus no sharing possible.
  */
 int request_fast_irq(unsigned int irq,
-		     irqreturn_t (*handler)(int, void *, struct pt_regs *),
+		     irqreturn_t (*handler)(int, void *),
 		     unsigned long irqflags, const char *devname)
 {
 	struct irqaction *action;
@@ -468,7 +475,7 @@ out:
 }
 
 int request_irq(unsigned int irq,
-		irqreturn_t (*handler)(int, void *, struct pt_regs *),
+		irqreturn_t (*handler)(int, void *),
 		unsigned long irqflags, const char * devname, void *dev_id)
 {
 	struct irqaction * action, **actionp;
@@ -478,7 +485,7 @@ int request_irq(unsigned int irq,
 	
 	if (sparc_cpu_model == sun4d) {
 		extern int sun4d_request_irq(unsigned int, 
-					     irqreturn_t (*)(int, void *, struct pt_regs *),
+					     irqreturn_t (*)(int, void *),
 					     unsigned long, const char *, void *);
 		return sun4d_request_irq(irq, handler, irqflags, devname, dev_id);
 	}
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
index edb6cc6..b4e50ae 100644
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -708,13 +708,13 @@ static void pcic_clear_clock_irq(void)
 	pcic_timer_dummy = readl(pcic0.pcic_regs+PCI_SYS_LIMIT);
 }
 
-static irqreturn_t pcic_timer_handler (int irq, void *h, struct pt_regs *regs)
+static irqreturn_t pcic_timer_handler (int irq, void *h)
 {
 	write_seqlock(&xtime_lock);	/* Dummy, to show that we remember */
 	pcic_clear_clock_irq();
 	do_timer(1);
 #ifndef CONFIG_SMP
-	update_process_times(user_mode(regs));
+	update_process_times(user_mode(get_irq_regs()));
 #endif
 	write_sequnlock(&xtime_lock);
 	return IRQ_HANDLED;
diff --git a/arch/sparc/kernel/sun4c_irq.c b/arch/sparc/kernel/sun4c_irq.c
index 4be2c86..2eaa0d0 100644
--- a/arch/sparc/kernel/sun4c_irq.c
+++ b/arch/sparc/kernel/sun4c_irq.c
@@ -154,7 +154,7 @@ static void sun4c_load_profile_irq(int c
 	/* Errm.. not sure how to do this.. */
 }
 
-static void __init sun4c_init_timers(irqreturn_t (*counter_fn)(int, void *, struct pt_regs *))
+static void __init sun4c_init_timers(irqreturn_t (*counter_fn)(int, void *))
 {
 	int irq;
 
diff --git a/arch/sparc/kernel/sun4d_irq.c b/arch/sparc/kernel/sun4d_irq.c
index 74eed97..836d156 100644
--- a/arch/sparc/kernel/sun4d_irq.c
+++ b/arch/sparc/kernel/sun4d_irq.c
@@ -38,6 +38,7 @@ #include <asm/pgtable.h>
 #include <asm/sbus.h>
 #include <asm/sbi.h>
 #include <asm/cacheflush.h>
+#include <asm/irq_regs.h>
 
 /* If you trust current SCSI layer to handle different SCSI IRQs, enable this. I don't trust it... -jj */
 /* #define DISTRIBUTE_IRQS */
@@ -198,6 +199,7 @@ extern void unexpected_irq(int, void *, 
 
 void sun4d_handler_irq(int irq, struct pt_regs * regs)
 {
+	struct pt_regs *old_regs;
 	struct irqaction * action;
 	int cpu = smp_processor_id();
 	/* SBUS IRQ level (1 - 7) */
@@ -208,6 +210,7 @@ void sun4d_handler_irq(int irq, struct p
 	
 	cc_set_iclr(1 << irq);
 	
+	old_regs = set_irq_regs(regs);
 	irq_enter();
 	kstat_cpu(cpu).irqs[irq]++;
 	if (!sbusl) {
@@ -215,7 +218,7 @@ void sun4d_handler_irq(int irq, struct p
 		if (!action)
 			unexpected_irq(irq, NULL, regs);
 		do {
-			action->handler(irq, action->dev_id, regs);
+			action->handler(irq, action->dev_id);
 			action = action->next;
 		} while (action);
 	} else {
@@ -242,7 +245,7 @@ void sun4d_handler_irq(int irq, struct p
 						if (!action)
 							unexpected_irq(irq, NULL, regs);
 						do {
-							action->handler(irq, action->dev_id, regs);
+							action->handler(irq, action->dev_id);
 							action = action->next;
 						} while (action);
 						release_sbi(SBI2DEVID(sbino), slot);
@@ -250,6 +253,7 @@ void sun4d_handler_irq(int irq, struct p
 			}
 	}
 	irq_exit();
+	set_irq_regs(old_regs);
 }
 
 unsigned int sun4d_build_irq(struct sbus_dev *sdev, int irq)
@@ -272,7 +276,7 @@ unsigned int sun4d_sbint_to_irq(struct s
 }
 
 int sun4d_request_irq(unsigned int irq,
-		irqreturn_t (*handler)(int, void *, struct pt_regs *),
+		irqreturn_t (*handler)(int, void *),
 		unsigned long irqflags, const char * devname, void *dev_id)
 {
 	struct irqaction *action, *tmp = NULL, **actionp;
@@ -466,7 +470,7 @@ static void sun4d_load_profile_irq(int c
 	bw_set_prof_limit(cpu, limit);
 }
 
-static void __init sun4d_init_timers(irqreturn_t (*counter_fn)(int, void *, struct pt_regs *))
+static void __init sun4d_init_timers(irqreturn_t (*counter_fn)(int, void *))
 {
 	int irq;
 	int cpu;
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index 3ff4edd..c80ea61 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -23,6 +23,7 @@ #include <linux/profile.h>
 
 #include <asm/ptrace.h>
 #include <asm/atomic.h>
+#include <asm/irq_regs.h>
 
 #include <asm/delay.h>
 #include <asm/irq.h>
@@ -369,10 +370,12 @@ void smp4d_message_pass(int target, int 
 
 void smp4d_percpu_timer_interrupt(struct pt_regs *regs)
 {
+	struct pt_regs *old_regs;
 	int cpu = hard_smp4d_processor_id();
 	static int cpu_tick[NR_CPUS];
 	static char led_mask[] = { 0xe, 0xd, 0xb, 0x7, 0xb, 0xd };
 
+	old_regs = set_irq_regs(regs);
 	bw_get_prof_limit(cpu);	
 	bw_clear_intr_mask(0, 1);	/* INTR_TABLE[0] & 1 is Profile IRQ */
 
@@ -384,7 +387,7 @@ void smp4d_percpu_timer_interrupt(struct
 		show_leds(cpu);
 	}
 
-	profile_tick(CPU_PROFILING, regs);
+	profile_tick(CPU_PROFILING);
 
 	if(!--prof_counter(cpu)) {
 		int user = user_mode(regs);
@@ -395,6 +398,7 @@ void smp4d_percpu_timer_interrupt(struct
 
 		prof_counter(cpu) = prof_multiplier(cpu);
 	}
+	set_irq_regs(old_regs);
 }
 
 extern unsigned int lvl14_resolution;
diff --git a/arch/sparc/kernel/sun4m_irq.c b/arch/sparc/kernel/sun4m_irq.c
index 7cefa30..28bcf8e 100644
--- a/arch/sparc/kernel/sun4m_irq.c
+++ b/arch/sparc/kernel/sun4m_irq.c
@@ -228,7 +228,7 @@ static void sun4m_load_profile_irq(int c
 	sun4m_timers->cpu_timers[cpu].l14_timer_limit = limit;
 }
 
-static void __init sun4m_init_timers(irqreturn_t (*counter_fn)(int, void *, struct pt_regs *))
+static void __init sun4m_init_timers(irqreturn_t (*counter_fn)(int, void *))
 {
 	int reg_count, irq, cpu;
 	struct linux_prom_registers cnt_regs[PROMREG_MAX];
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 7d4a649..e2d9c01 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -19,6 +19,7 @@ #include <linux/swap.h>
 #include <linux/profile.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <asm/irq_regs.h>
 
 #include <asm/ptrace.h>
 #include <asm/atomic.h>
@@ -353,11 +354,14 @@ void smp4m_cross_call_irq(void)
 
 void smp4m_percpu_timer_interrupt(struct pt_regs *regs)
 {
+	struct pt_regs *old_regs;
 	int cpu = smp_processor_id();
 
+	old_regs = set_irq_regs(regs);
+
 	clear_profile_irq(cpu);
 
-	profile_tick(CPU_PROFILING, regs);
+	profile_tick(CPU_PROFILING);
 
 	if(!--prof_counter(cpu)) {
 		int user = user_mode(regs);
@@ -368,6 +372,7 @@ void smp4m_percpu_timer_interrupt(struct
 
 		prof_counter(cpu) = prof_multiplier(cpu);
 	}
+	set_irq_regs(old_regs);
 }
 
 extern unsigned int lvl14_resolution;
diff --git a/arch/sparc/kernel/tick14.c b/arch/sparc/kernel/tick14.c
index d3b4daa..7107d2f 100644
--- a/arch/sparc/kernel/tick14.c
+++ b/arch/sparc/kernel/tick14.c
@@ -55,7 +55,7 @@ void install_obp_ticker(void)
 	linux_lvl14[3] =  obp_lvl14[3]; 
 }
 
-void claim_ticker14(irqreturn_t (*handler)(int, void *, struct pt_regs *),
+void claim_ticker14(irqreturn_t (*handler)(int, void *),
 		    int irq_nr, unsigned int timeout )
 {
 	int cpu = smp_processor_id();
diff --git a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time.c
index e10dc83..7dcd1a1 100644
--- a/arch/sparc/kernel/time.c
+++ b/arch/sparc/kernel/time.c
@@ -42,6 +42,7 @@ #include <asm/sun4paddr.h>
 #include <asm/page.h>
 #include <asm/pcic.h>
 #include <asm/of_device.h>
+#include <asm/irq_regs.h>
 
 DEFINE_SPINLOCK(rtc_lock);
 enum sparc_clock_type sp_clock_typ;
@@ -104,13 +105,13 @@ __volatile__ unsigned int *master_l10_li
 
 #define TICK_SIZE (tick_nsec / 1000)
 
-irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs * regs)
+irqreturn_t timer_interrupt(int irq, void *dev_id)
 {
 	/* last time the cmos clock got updated */
 	static long last_rtc_update;
 
 #ifndef CONFIG_SMP
-	profile_tick(CPU_PROFILING, regs);
+	profile_tick(CPU_PROFILING);
 #endif
 
 	/* Protect counter clear so that do_gettimeoffset works */
@@ -128,7 +129,7 @@ #endif
 
 	do_timer(1);
 #ifndef CONFIG_SMP
-	update_process_times(user_mode(regs));
+	update_process_times(user_mode(get_irq_regs()));
 #endif
 
 
diff --git a/drivers/parport/parport_sunbpp.c b/drivers/parport/parport_sunbpp.c
index d758c90..9793533 100644
--- a/drivers/parport/parport_sunbpp.c
+++ b/drivers/parport/parport_sunbpp.c
@@ -48,7 +48,7 @@ #endif
 
 static irqreturn_t parport_sunbpp_interrupt(int irq, void *dev_id)
 {
-	parport_generic_irq(irq, (struct parport *) dev_id, regs);
+	parport_generic_irq(irq, (struct parport *) dev_id);
 	return IRQ_HANDLED;
 }
 
diff --git a/include/asm-sparc/floppy.h b/include/asm-sparc/floppy.h
index c53b332..9073c84 100644
--- a/include/asm-sparc/floppy.h
+++ b/include/asm-sparc/floppy.h
@@ -262,7 +262,7 @@ static __inline__ void sun_fd_enable_dma
 }
 
 /* Our low-level entry point in arch/sparc/kernel/entry.S */
-irqreturn_t floppy_hardint(int irq, void *unused, struct pt_regs *regs);
+irqreturn_t floppy_hardint(int irq, void *unused);
 
 static int sun_fd_request_irq(void)
 {
diff --git a/include/asm-sparc/irq.h b/include/asm-sparc/irq.h
index 3141ddf..7086733 100644
--- a/include/asm-sparc/irq.h
+++ b/include/asm-sparc/irq.h
@@ -76,8 +76,8 @@ static inline void load_profile_irq(int 
 	BTFIXUP_CALL(load_profile_irq)(cpu, limit);
 }
 
-extern void (*sparc_init_timers)(irqreturn_t (*lvl10_irq)(int, void *, struct pt_regs *));
-extern void claim_ticker14(irqreturn_t (*irq_handler)(int, void *, struct pt_regs *),
+extern void (*sparc_init_timers)(irqreturn_t (*lvl10_irq)(int, void *));
+extern void claim_ticker14(irqreturn_t (*irq_handler)(int, void *),
 			   int irq,
 			   unsigned int timeout);
 
@@ -91,7 +91,7 @@ #define clear_cpu_int(cpu,level) BTFIXUP
 #define set_irq_udt(cpu) BTFIXUP_CALL(set_irq_udt)(cpu)
 #endif
 
-extern int request_fast_irq(unsigned int irq, irqreturn_t (*handler)(int, void *, struct pt_regs *), unsigned long flags, __const__ char *devname);
+extern int request_fast_irq(unsigned int irq, irqreturn_t (*handler)(int, void *), unsigned long flags, __const__ char *devname);
 
 /* On the sun4m, just like the timers, we have both per-cpu and master
  * interrupt registers.
diff --git a/include/asm-sparc/irq_regs.h b/include/asm-sparc/irq_regs.h
new file mode 100644
index 0000000..3dd9c0b
--- /dev/null
+++ b/include/asm-sparc/irq_regs.h
@@ -0,0 +1 @@
+#include <asm-generic/irq_regs.h>
-- 
1.4.2.GIT

