Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWFAQUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWFAQUn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 12:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWFAQUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 12:20:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50913 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030217AbWFAQUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 12:20:42 -0400
Date: Thu, 1 Jun 2006 09:22:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, htejun@gmail.com,
       jeff@garzik.org, jbeulich@novell.com
Subject: Re: 2.6.17-rc5-mm2
Message-Id: <20060601092247.8ccc2c49.akpm@osdl.org>
In-Reply-To: <447ED6A2.5000107@reub.net>
References: <20060601014806.e86b3cc0.akpm@osdl.org>
	<447EB4AD.4060101@reub.net>
	<20060601025632.6683041e.akpm@osdl.org>
	<447EBD46.7010607@reub.net>
	<20060601103315.GA1865@elte.hu>
	<20060601105300.GA2985@elte.hu>
	<20060601112551.GA5811@elte.hu>
	<447ED6A2.5000107@reub.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2006 23:59:30 +1200
Reuben Farrelly <reuben-lkml@reub.net> wrote:

> Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
>   [<0000000000000000>]

Seems that a fix got lost.  Please add this:


From: Ingo Molnar <mingo@elte.hu>

This is a fixed up and cleaned up replacement for genirq-msi-fixes.patch,
which should solve the i386 4KSTACKS problem.  I also added Ben's idea of
pushing the __do_IRQ() check into generic_handle_irq().

I booted this with MSI enabled, but i only have MSI devices, not MSI-X
devices.  I'd still expect MSI-X to work now.

irqchip migration helper: call __do_IRQ() if a descriptor is attached to an
irqtype-style controller.  This also fixes MSI-X IRQ handling on i386 and
x86_64.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Roland Dreier <rolandd@cisco.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/irq.c |    5 +++++
 include/linux/irq.h    |   27 ++++++++++++++++-----------
 2 files changed, 21 insertions(+), 11 deletions(-)

diff -puN arch/i386/kernel/irq.c~genirq-msi-fixes-2 arch/i386/kernel/irq.c
--- devel/arch/i386/kernel/irq.c~genirq-msi-fixes-2	2006-06-01 09:21:52.000000000 -0700
+++ devel-akpm/arch/i386/kernel/irq.c	2006-06-01 09:21:52.000000000 -0700
@@ -77,6 +77,10 @@ fastcall unsigned int do_IRQ(struct pt_r
 	}
 #endif
 
+	if (!irq_desc[irq].handle_irq) {
+		__do_IRQ(irq, regs);
+		goto out_exit;
+	}
 #ifdef CONFIG_4KSTACKS
 
 	curctx = (union irq_ctx *) current_thread_info();
@@ -109,6 +113,7 @@ fastcall unsigned int do_IRQ(struct pt_r
 #endif
 		desc->handle_irq(irq, desc, regs);
 
+out_exit:
 	irq_exit();
 
 	return 1;
diff -puN include/linux/irq.h~genirq-msi-fixes-2 include/linux/irq.h
--- devel/include/linux/irq.h~genirq-msi-fixes-2	2006-06-01 09:21:52.000000000 -0700
+++ devel-akpm/include/linux/irq.h	2006-06-01 09:21:52.000000000 -0700
@@ -178,17 +178,6 @@ typedef struct irq_desc		irq_desc_t;
  */
 #include <asm/hw_irq.h>
 
-/*
- * Architectures call this to let the generic IRQ layer
- * handle an interrupt:
- */
-static inline void generic_handle_irq(unsigned int irq, struct pt_regs *regs)
-{
-	struct irq_desc *desc = irq_desc + irq;
-
-	desc->handle_irq(irq, desc, regs);
-}
-
 extern int setup_irq(unsigned int irq, struct irqaction *new);
 
 #ifdef CONFIG_GENERIC_HARDIRQS
@@ -326,6 +315,22 @@ handle_irq_name(void fastcall (*handle)(
  */
 extern fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs);
 
+/*
+ * Architectures call this to let the generic IRQ layer
+ * handle an interrupt. If the descriptor is attached to an
+ * irqchip-style controller then we call the ->handle_irq() handler,
+ * and it calls __do_IRQ() if it's attached to an irqtype-style controller.
+ */
+static inline void generic_handle_irq(unsigned int irq, struct pt_regs *regs)
+{
+	struct irq_desc *desc = irq_desc + irq;
+
+	if (likely(desc->handle_irq))
+		desc->handle_irq(irq, desc, regs);
+	else
+		__do_IRQ(irq, regs);
+}
+
 /* Handling of unhandled and spurious interrupts: */
 extern void note_interrupt(unsigned int irq, struct irq_desc *desc,
 			   int action_ret, struct pt_regs *regs);
_

