Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWJGP3Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWJGP3Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 11:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWJGP3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 11:29:24 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:51895 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932265AbWJGP3X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 11:29:23 -0400
Date: Sat, 7 Oct 2006 16:29:18 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hirokazu Takata <takata@linux-m32r.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m32r pt_regs fixes
Message-ID: <20061007152918.GF29920@ftp.linux.org.uk>
References: <20061007152100.GE29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061007152100.GE29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

... and now with irq_regs.h not forgotten...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
1aac5d9fca282f7fc1c29ea1f3cfb4f4483eb1b4
diff --git a/arch/m32r/kernel/irq.c b/arch/m32r/kernel/irq.c
index 3841861..f8d8650 100644
--- a/arch/m32r/kernel/irq.c
+++ b/arch/m32r/kernel/irq.c
@@ -77,13 +77,16 @@ skip:
  */
 asmlinkage unsigned int do_IRQ(int irq, struct pt_regs *regs)
 {
+	struct pt_regs *old_regs;
+	old_regs = set_irq_regs(regs);
 	irq_enter();
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	/* FIXME M32R */
 #endif
-	__do_IRQ(irq, regs);
+	__do_IRQ(irq);
 	irq_exit();
+	set_irq_regs(old_regs);
 
 	return 1;
 }
diff --git a/arch/m32r/kernel/smp.c b/arch/m32r/kernel/smp.c
index 8b1f6eb..722e21f 100644
--- a/arch/m32r/kernel/smp.c
+++ b/arch/m32r/kernel/smp.c
@@ -101,7 +101,7 @@ void smp_call_function_interrupt(void);
 
 void smp_send_timer(void);
 void smp_ipi_timer_interrupt(struct pt_regs *);
-void smp_local_timer_interrupt(struct pt_regs *);
+void smp_local_timer_interrupt(void);
 
 void send_IPI_allbutself(int, int);
 static void send_IPI_mask(cpumask_t, int, int);
@@ -734,9 +734,12 @@ void smp_send_timer(void)
  *==========================================================================*/
 void smp_ipi_timer_interrupt(struct pt_regs *regs)
 {
+	struct pt_regs *old_regs;
+	old_regs = set_irq_regs(regs);
 	irq_enter();
-	smp_local_timer_interrupt(regs);
+	smp_local_timer_interrupt();
 	irq_exit();
+	set_irq_regs(old_regs);
 }
 
 /*==========================================================================*
@@ -762,9 +765,9 @@ void smp_ipi_timer_interrupt(struct pt_r
  * ---------- --- --------------------------------------------------------
  * 2003-06-24 hy  use per_cpu structure.
  *==========================================================================*/
-void smp_local_timer_interrupt(struct pt_regs *regs)
+void smp_local_timer_interrupt(void)
 {
-	int user = user_mode(regs);
+	int user = user_mode(get_irq_regs());
 	int cpu_id = smp_processor_id();
 
 	/*
@@ -774,7 +777,7 @@ void smp_local_timer_interrupt(struct pt
 	 * useful with a profiling multiplier != 1
 	 */
 
-	profile_tick(CPU_PROFILING, regs);
+	profile_tick(CPU_PROFILING);
 
 	if (--per_cpu(prof_counter, cpu_id) <= 0) {
 		/*
diff --git a/arch/m32r/kernel/time.c b/arch/m32r/kernel/time.c
index d8af155..a090382 100644
--- a/arch/m32r/kernel/time.c
+++ b/arch/m32r/kernel/time.c
@@ -35,7 +35,7 @@ #include <asm/hw_irq.h>
 
 #ifdef CONFIG_SMP
 extern void send_IPI_allbutself(int, int);
-extern void smp_local_timer_interrupt(struct pt_regs *);
+extern void smp_local_timer_interrupt(void);
 #endif
 
 #define TICK_SIZE	(tick_nsec / 1000)
@@ -188,15 +188,15 @@ static long last_rtc_update = 0;
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+irqreturn_t timer_interrupt(int irq, void *dev_id)
 {
 #ifndef CONFIG_SMP
-	profile_tick(CPU_PROFILING, regs);
+	profile_tick(CPU_PROFILING);
 #endif
 	do_timer(1);
 
 #ifndef CONFIG_SMP
-	update_process_times(user_mode(regs));
+	update_process_times(user_mode(get_irq_regs()));
 #endif
 	/*
 	 * If we have an externally synchronized Linux clock, then update
@@ -221,7 +221,7 @@ #endif
 	   a hack, so don't look closely for now.. */
 
 #ifdef CONFIG_SMP
-	smp_local_timer_interrupt(regs);
+	smp_local_timer_interrupt();
 	smp_send_timer();
 #endif
 
diff --git a/drivers/net/smc91x.c b/drivers/net/smc91x.c
index 506807f..95b6478 100644
--- a/drivers/net/smc91x.c
+++ b/drivers/net/smc91x.c
@@ -1400,7 +1400,7 @@ #ifdef CONFIG_NET_POLL_CONTROLLER
 static void smc_poll_controller(struct net_device *dev)
 {
 	disable_irq(dev->irq);
-	smc_interrupt(dev->irq, dev, NULL);
+	smc_interrupt(dev->irq, dev);
 	enable_irq(dev->irq);
 }
 #endif
diff --git a/drivers/pcmcia/m32r_pcc.c b/drivers/pcmcia/m32r_pcc.c
index 0964fd7..bbf0258 100644
--- a/drivers/pcmcia/m32r_pcc.c
+++ b/drivers/pcmcia/m32r_pcc.c
@@ -395,7 +395,7 @@ static irqreturn_t pcc_interrupt(int irq
 
 static void pcc_interrupt_wrapper(u_long data)
 {
-	pcc_interrupt(0, NULL, NULL);
+	pcc_interrupt(0, NULL);
 	init_timer(&poll_timer);
 	poll_timer.expires = jiffies + poll_interval;
 	add_timer(&poll_timer);
diff --git a/drivers/serial/m32r_sio.c b/drivers/serial/m32r_sio.c
index c85ac1a..7656a35 100644
--- a/drivers/serial/m32r_sio.c
+++ b/drivers/serial/m32r_sio.c
@@ -590,7 +590,7 @@ static void m32r_sio_timeout(unsigned lo
 	sts = sio_in(up, SIOSTS);
 	if (sts & 0x5) {
 		spin_lock(&up->port.lock);
-		m32r_sio_handle_port(up, sts, NULL);
+		m32r_sio_handle_port(up, sts);
 		spin_unlock(&up->port.lock);
 	}
 
diff --git a/include/asm-m32r/irq_regs.h b/include/asm-m32r/irq_regs.h
new file mode 100644
index 0000000..3dd9c0b
--- /dev/null
+++ b/include/asm-m32r/irq_regs.h
@@ -0,0 +1 @@
+#include <asm-generic/irq_regs.h>
