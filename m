Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266974AbSLXGAD>; Tue, 24 Dec 2002 01:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266978AbSLXGAD>; Tue, 24 Dec 2002 01:00:03 -0500
Received: from samael.donpac.ru ([195.161.172.239]:1542 "EHLO samael.donpac.ru")
	by vger.kernel.org with ESMTP id <S266974AbSLXF76>;
	Tue, 24 Dec 2002 00:59:58 -0500
From: "Andrey Panin" <pazke@orbita1.ru>
Date: Tue, 24 Dec 2002 09:03:31 +0300
To: linux-kernel@vger.kernel.org
Subject: [RFC] irq handling code consolidation (common part)
Message-ID: <20021224060331.GA1090@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

this patch moves some common parts of irq handling code to one place.
Arch specific patches will follow. Patch for i386 is tested and performed=
=20
well, but other arch specific patched are not. Please take a look.

Please CC me answering this letter, I'm not subscribed to lkml currently.

Best regards.

--=20
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net

--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-irq-common

diff --minimal -urN -X /usr/share/dontdiff linux-2.5.52.vanilla/kernel/Makefile linux-2.5.52/kernel/Makefile
--- linux-2.5.52.vanilla/kernel/Makefile	Thu Dec 19 20:03:23 2002
+++ linux-2.5.52/kernel/Makefile	Tue Dec 24 19:36:44 2002
@@ -22,6 +22,7 @@
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
 obj-$(CONFIG_COMPAT) += compat.o
+obj-$(CONFIG_GENERIC_IRQ) += irq.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff --minimal -urN -X /usr/share/dontdiff linux-2.5.52.vanilla/kernel/irq.c linux-2.5.52/kernel/irq.c
--- linux-2.5.52.vanilla/kernel/irq.c	Thu Jan  1 03:00:00 1970
+++ linux-2.5.52/kernel/irq.c	Tue Dec 24 20:32:56 2002
@@ -0,0 +1,364 @@
+/*
+ *  linux/kernel/irq.c
+ *
+ *  Mostly architecture independent parts of IRQ handling.
+ *
+ *  Copyright (C) 1992, 2002 Linus Torvalds, Ingo Molnar.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/config.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/random.h>
+
+/*
+ * Controller mappings for all interrupt sources:
+ */
+irq_desc_t irq_desc[NR_IRQS] __cacheline_aligned = {
+	[0 ... NR_IRQS - 1] = {
+		.handler =	&no_irq_type,
+		.lock =		SPIN_LOCK_UNLOCKED,
+	}
+};
+
+/*
+ * Special irq handlers.
+ */
+
+void no_action(int cpl, void *dev_id, struct pt_regs *regs) { }
+
+/*
+ * Generic no controller code
+ */
+atomic_t irq_err_count;
+
+static void no_irq_enable_disable(unsigned int irq) { }
+static unsigned int no_irq_startup(unsigned int irq) { return 0; }
+
+static void no_irq_ack(unsigned int irq)
+{
+	atomic_inc(&irq_err_count);
+	printk(KERN_CRIT "Unexpected IRQ trap at vector %u\n", irq);
+	ack_bad_irq(irq);
+}
+
+struct hw_interrupt_type no_irq_type = {
+	.typename	= "none",
+	.startup	= no_irq_startup,
+	.shutdown	= no_irq_enable_disable,
+	.enable		= no_irq_enable_disable,
+	.disable	= no_irq_enable_disable,
+	.ack		= no_irq_ack,
+	.end		= no_irq_enable_disable,
+};
+
+/*
+ * This should really return information about whether
+ * we should do bottom half handling etc. Right now we
+ * end up _always_ checking the bottom half, which is a
+ * waste of time and is not what some drivers would
+ * prefer.
+ */
+int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
+		     struct irqaction *action)
+{
+	int status = 1;	/* Force the "do bottom halves" bit */
+
+	if (!(action->flags & SA_INTERRUPT))
+		local_irq_enable();
+
+	do {
+		status |= action->flags;
+		action->handler(irq, action->dev_id, regs);
+		action = action->next;
+	} while (action);
+	if (status & SA_SAMPLE_RANDOM)
+		add_interrupt_randomness(irq);
+	local_irq_disable();
+
+	return status;
+}
+
+#if defined(CONFIG_SMP) && !defined(HAVE_ARCH_SYNCRONIZE_IRQ)
+
+inline void synchronize_irq(unsigned int irq)
+{
+        /* is there anything to synchronize with? */
+	if (!irq_desc[irq].action)
+		return;
+
+	while (irq_desc[irq].status & IRQ_INPROGRESS)
+		cpu_relax();
+}
+
+#endif
+
+/*
+ * Generic enable/disable code: this just calls
+ * down into the PIC-specific version for the actual
+ * hardware disable after having gotten the irq
+ * controller lock. 
+ */
+ 
+/**
+ *	disable_irq_nosync - disable an irq without waiting
+ *	@irq: Interrupt to disable
+ *
+ *	Disable the selected interrupt line.  Disables and Enables are
+ *	nested.
+ *	Unlike disable_irq(), this function does not ensure existing
+ *	instances of the IRQ handler have completed before returning.
+ *
+ *	This function may be called from IRQ context.
+ */
+inline void disable_irq_nosync(unsigned int irq)
+{
+	irq_desc_t *desc = irq_desc(irq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	if (!desc->depth++) {
+		desc->status |= IRQ_DISABLED;
+		desc->handler->disable(irq);
+	}
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+/**
+ *	disable_irq - disable an irq and wait for completion
+ *	@irq: Interrupt to disable
+ *
+ *	Disable the selected interrupt line.  Enables and Disables are
+ *	nested. That is for two disables you need two enables.
+ *	This function waits for any pending IRQ handlers for this interrupt
+ *	to complete before returning. If you use this function while
+ *	holding a resource the IRQ handler may need you will deadlock.
+ *
+ *	This function may be called - with care - from IRQ context.
+ */
+void disable_irq(unsigned int irq)
+{
+	disable_irq_nosync(irq);
+	synchronize_irq(irq);
+}
+
+/**
+ *	enable_irq - enable handling of an irq
+ *	@irq: Interrupt to enable
+ *
+ *	Undoes the effect of one call to disable_irq().  If this
+ *	matches the last disable, processing of interrupts on this
+ *	IRQ line is re-enabled.
+ *
+ *	This function may be called from IRQ context.
+ */
+void enable_irq(unsigned int irq)
+{
+	irq_desc_t *desc = irq_desc(irq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	switch (desc->depth) {
+	case 1: {
+		unsigned int status = desc->status & ~IRQ_DISABLED;
+		desc->status = status;
+		if ((status & (IRQ_PENDING | IRQ_REPLAY)) == IRQ_PENDING) {
+			desc->status = status | IRQ_REPLAY;
+			hw_resend_irq(desc->handler,irq);
+		}
+		desc->handler->enable(irq);
+		/* fall-through */
+	}
+	default:
+		desc->depth--;
+		break;
+	case 0:
+		printk(KERN_ERR "enable_irq(%u) unbalanced from %p\n",
+		       irq, __builtin_return_address(0));
+	}
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+/*
+ * IRQ autodetection code..
+ *
+ * This depends on the fact that any interrupt that
+ * comes in on to an unassigned handler will get stuck
+ * with "IRQ_WAITING" cleared and the interrupt
+ * disabled.
+ */
+
+static DECLARE_MUTEX(probe_sem);
+
+/**
+ *	probe_irq_on	- begin an interrupt autodetect
+ *
+ *	Commence probing for an interrupt. The interrupts are scanned
+ *	and a mask of potential interrupt lines is returned.
+ *
+ */
+unsigned long probe_irq_on(void)
+{
+	unsigned int i;
+	irq_desc_t *desc;
+	unsigned long val;
+	unsigned long delay;
+
+	down(&probe_sem);
+	/* 
+	 * something may have generated an irq long ago and we want to
+	 * flush such a longstanding irq before considering it as spurious. 
+	 */
+	for (i = NR_IRQS - 1; i > 0; i--)  {
+		desc = irq_desc + i;
+
+		spin_lock_irq(&desc->lock);
+		if (!irq_desc[i].action) 
+			irq_desc[i].handler->startup(i);
+		spin_unlock_irq(&desc->lock);
+	}
+
+	/* Wait for longstanding interrupts to trigger. */
+	for (delay = jiffies + HZ/50; time_after(delay, jiffies); )
+		/* about 20ms delay */ barrier();
+
+	/*
+	 * enable any unassigned irqs
+	 * (we must startup again here because if a longstanding irq
+	 * happened in the previous stage, it may have masked itself)
+	 */
+	for (i = NR_IRQS-1; i > 0; i--) {
+		desc = irq_desc + i;
+
+		spin_lock_irq(&desc->lock);
+		if (!desc->action) {
+			desc->status |= IRQ_AUTODETECT | IRQ_WAITING;
+			if (desc->handler->startup(i))
+				desc->status |= IRQ_PENDING;
+		}
+		spin_unlock_irq(&desc->lock);
+	}
+
+	/*
+	 * Wait for spurious interrupts to trigger
+	 */
+	for (delay = jiffies + HZ/10; time_after(delay, jiffies); )
+		/* about 100ms delay */ barrier();
+
+	/*
+	 * Now filter out any obviously spurious interrupts
+	 */
+	val = 0;
+	for (i = 0; i < NR_IRQS; i++) {
+		irq_desc_t *desc = irq_desc + i;
+		unsigned int status;
+
+		spin_lock_irq(&desc->lock);
+		status = desc->status;
+
+		if (status & IRQ_AUTODETECT) {
+			/* It triggered already - consider it spurious. */
+			if (!(status & IRQ_WAITING)) {
+				desc->status = status & ~IRQ_AUTODETECT;
+				desc->handler->shutdown(i);
+			} else
+				if (i < 32)
+					val |= 1 << i;
+		}
+		spin_unlock_irq(&desc->lock);
+	}
+
+	return val;
+}
+
+/**
+ *	probe_irq_mask - scan a bitmap of interrupt lines
+ *	@val:	mask of interrupts to consider
+ *
+ *	Scan the ISA bus interrupt lines and return a bitmap of
+ *	active interrupts. The interrupt probe logic state is then
+ *	returned to its previous value. This function can handle only 
+ *	legacy ISA interrupts
+ *
+ *	Note: we need to scan all the irq's even though we will
+ *	only return ISA irq numbers - just so that we reset them
+ *	all to a known state.
+ */
+unsigned int probe_irq_mask(unsigned long val)
+{
+	int i;
+	unsigned int mask;
+
+	mask = 0;
+	for (i = 0; i < NR_IRQS; i++) {
+		irq_desc_t *desc = irq_desc + i;
+		unsigned int status;
+
+		spin_lock_irq(&desc->lock);
+		status = desc->status;
+
+		if (status & IRQ_AUTODETECT) {
+			if (i < 16 && !(status & IRQ_WAITING))
+				mask |= 1 << i;
+
+			desc->status = status & ~IRQ_AUTODETECT;
+			desc->handler->shutdown(i);
+		}
+		spin_unlock_irq(&desc->lock);
+	}
+	up(&probe_sem);
+
+	return mask & val;
+}
+
+/**
+ *	probe_irq_off	- end an interrupt autodetect
+ *	@val: mask of potential interrupts (unused)
+ *
+ *	Scans the unused interrupt lines and returns the line which
+ *	appears to have triggered the interrupt. If no interrupt was
+ *	found then zero is returned. If more than one interrupt is
+ *	found then minus the first candidate is returned to indicate
+ *	their is doubt. This function can handle any interrupt source.
+ *
+ *	The interrupt probe logic state is returned to its previous
+ *	value.
+ *
+ *	BUGS: When used in a module (which arguably shouldnt happen)
+ *	nothing prevents two IRQ probe callers from overlapping. The
+ *	results of this are non-optimal.
+ */
+int probe_irq_off(unsigned long val)
+{
+	int i, irq_found, nr_irqs;
+
+	nr_irqs = 0;
+	irq_found = 0;
+	for (i = 0; i < NR_IRQS; i++) {
+		irq_desc_t *desc = irq_desc + i;
+		unsigned int status;
+
+		spin_lock_irq(&desc->lock);
+		status = desc->status;
+
+		if (status & IRQ_AUTODETECT) {
+			if (!(status & IRQ_WAITING)) {
+				if (!nr_irqs)
+					irq_found = i;
+				nr_irqs++;
+			}
+			desc->status = status & ~IRQ_AUTODETECT;
+			desc->handler->shutdown(i);
+		}
+		spin_unlock_irq(&desc->lock);
+	}
+	up(&probe_sem);
+
+	if (nr_irqs > 1)
+		irq_found = -irq_found;
+	return irq_found;
+}

--aM3YZ0Iwxop3KEKx--
