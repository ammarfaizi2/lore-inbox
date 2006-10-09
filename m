Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751781AbWJIKvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbWJIKvU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 06:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbWJIKvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 06:51:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:56035 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751781AbWJIKvU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 06:51:20 -0400
Date: Mon, 9 Oct 2006 11:51:14 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
       Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] Fix call to profile_tick() for non-SMP SPARC64
Message-ID: <20061009105114.GL29920@ftp.linux.org.uk>
References: <200610090243.k992hEOi010287@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610090243.k992hEOi010287@laptop13.inf.utfsm.cl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2006 at 10:43:14PM -0400, Horst von Brand wrote:
> 
> Signed-off-by: Horst von Brand <vonbrand@pincoya.inf.utfsm.cl>

NAK.  That gives you junk data used by profile_tick().  Real fix
follows:

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff --git a/arch/sparc64/kernel/irq.c b/arch/sparc64/kernel/irq.c
index ce05deb..d64b1ea 100644
--- a/arch/sparc64/kernel/irq.c
+++ b/arch/sparc64/kernel/irq.c
@@ -522,12 +522,13 @@ void ack_bad_irq(unsigned int virt_irq)
 }
 
 #ifndef CONFIG_SMP
-extern irqreturn_t timer_interrupt(int, void *, struct pt_regs *);
+extern irqreturn_t timer_interrupt(int, void *);
 
 void timer_irq(int irq, struct pt_regs *regs)
 {
 	unsigned long clr_mask = 1 << irq;
 	unsigned long tick_mask = tick_ops->softint_mask;
+	struct pt_regs *old_regs;
 
 	if (get_softint() & tick_mask) {
 		irq = 0;
@@ -535,12 +536,14 @@ void timer_irq(int irq, struct pt_regs *
 	}
 	clear_softint(clr_mask);
 
+	old_regs = set_irq_regs(regs);
 	irq_enter();
 
 	kstat_this_cpu.irqs[0]++;
-	timer_interrupt(irq, NULL, regs);
+	timer_interrupt(irq, NULL);
 
 	irq_exit();
+	set_irq_regs(old_regs);
 }
 #endif
 
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index 00f6fc4..061e1b1 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -45,6 +45,7 @@ #include <asm/sections.h>
 #include <asm/cpudata.h>
 #include <asm/uaccess.h>
 #include <asm/prom.h>
+#include <asm/irq_regs.h>
 
 DEFINE_SPINLOCK(mostek_lock);
 DEFINE_SPINLOCK(rtc_lock);
@@ -452,7 +453,7 @@ static inline void timer_check_rtc(void)
 	}
 }
 
-irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs * regs)
+irqreturn_t timer_interrupt(int irq, void *dev_id)
 {
 	unsigned long ticks, compare, pstate;
 
@@ -460,8 +461,8 @@ irqreturn_t timer_interrupt(int irq, voi
 
 	do {
 #ifndef CONFIG_SMP
-		profile_tick(CPU_PROFILING, regs);
-		update_process_times(user_mode(regs));
+		profile_tick(CPU_PROFILING);
+		update_process_times(user_mode(get_irq_regs()));
 #endif
 		do_timer(1);
 
