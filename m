Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbWJFJ0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbWJFJ0e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 05:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWJFJ0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 05:26:34 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:5618 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1751372AbWJFJ0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 05:26:34 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: torvalds@osdl.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH] IRQ: Fix AVR32 breakage
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Fri, 06 Oct 2006 11:27:42 +0200
Message-Id: <11601268623332-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <1160126862512-git-send-email-hskinnemoen@atmel.com>
References: <1160126862512-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the necessary changes to AVR32 required by the irq regs stuff.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/kernel/time.c        |   10 +++++-----
 arch/avr32/mach-at32ap/extint.c |    5 ++---
 arch/avr32/mach-at32ap/intc.c   |    7 ++++++-
 include/asm-avr32/irq_regs.h    |    1 +
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/avr32/kernel/time.c b/arch/avr32/kernel/time.c
index 3e56b9f..5a247ba 100644
--- a/arch/avr32/kernel/time.c
+++ b/arch/avr32/kernel/time.c
@@ -124,15 +124,15 @@ unsigned long long sched_clock(void)
  *
  * In UP mode, it is invoked from the (global) timer_interrupt.
  */
-static void local_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+static void local_timer_interrupt(int irq, void *dev_id)
 {
 	if (current->pid)
-		profile_tick(CPU_PROFILING, regs);
-	update_process_times(user_mode(regs));
+		profile_tick(CPU_PROFILING);
+	update_process_times(user_mode(get_irq_regs()));
 }
 
 static irqreturn_t
-timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+timer_interrupt(int irq, void *dev_id)
 {
 	unsigned int count;
 
@@ -157,7 +157,7 @@ timer_interrupt(int irq, void *dev_id, s
 	 *
 	 * SMP is not supported yet.
 	 */
-	local_timer_interrupt(irq, dev_id, regs);
+	local_timer_interrupt(irq, dev_id);
 
 	return IRQ_HANDLED;
 }
diff --git a/arch/avr32/mach-at32ap/extint.c b/arch/avr32/mach-at32ap/extint.c
index 7da9c5f..4dff1f9 100644
--- a/arch/avr32/mach-at32ap/extint.c
+++ b/arch/avr32/mach-at32ap/extint.c
@@ -102,8 +102,7 @@ struct irq_chip eim_chip = {
 	.set_type	= eim_set_irq_type,
 };
 
-static void demux_eim_irq(unsigned int irq, struct irq_desc *desc,
-			  struct pt_regs *regs)
+static void demux_eim_irq(unsigned int irq, struct irq_desc *desc)
 {
 	struct at32_sm *sm = desc->handler_data;
 	struct irq_desc *ext_desc;
@@ -121,7 +120,7 @@ static void demux_eim_irq(unsigned int i
 
 		ext_irq = i + sm->eim_first_irq;
 		ext_desc = irq_desc + ext_irq;
-		ext_desc->handle_irq(ext_irq, ext_desc, regs);
+		ext_desc->handle_irq(ext_irq, ext_desc);
 	}
 
 	spin_unlock(&sm->lock);
diff --git a/arch/avr32/mach-at32ap/intc.c b/arch/avr32/mach-at32ap/intc.c
index 74f8c9f..eb87a18 100644
--- a/arch/avr32/mach-at32ap/intc.c
+++ b/arch/avr32/mach-at32ap/intc.c
@@ -52,16 +52,19 @@ static struct intc intc0 = {
 asmlinkage void do_IRQ(int level, struct pt_regs *regs)
 {
 	struct irq_desc *desc;
+	struct pt_regs *old_regs;
 	unsigned int irq;
 	unsigned long status_reg;
 
 	local_irq_disable();
 
+	old_regs = set_irq_regs(regs);
+
 	irq_enter();
 
 	irq = intc_readl(&intc0, INTCAUSE0 - 4 * level);
 	desc = irq_desc + irq;
-	desc->handle_irq(irq, desc, regs);
+	desc->handle_irq(irq, desc);
 
 	/*
 	 * Clear all interrupt level masks so that we may handle
@@ -75,6 +78,8 @@ asmlinkage void do_IRQ(int level, struct
 	sysreg_write(SR, status_reg);
 
 	irq_exit();
+
+	set_irq_regs(old_regs);
 }
 
 void __init init_IRQ(void)
diff --git a/include/asm-avr32/irq_regs.h b/include/asm-avr32/irq_regs.h
new file mode 100644
index 0000000..3dd9c0b
--- /dev/null
+++ b/include/asm-avr32/irq_regs.h
@@ -0,0 +1 @@
+#include <asm-generic/irq_regs.h>
-- 
1.4.1.1

