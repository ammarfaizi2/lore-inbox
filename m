Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268690AbUJTSnx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268690AbUJTSnx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 14:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268915AbUJTSWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 14:22:04 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:60430 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268980AbUJTSQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 14:16:31 -0400
Date: Wed, 20 Oct 2004 19:16:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Stop people including linux/irq.h
Message-ID: <20041020191626.G14627@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Andrew,

Here is an extreme attempt at preventing the fuckage known as including
linux/irq.h inappropriately.  Since people don't seem to get the message,
the only option is to remove the bloody file.

Shame this breaks everyone using the generic IRQ infrastructure, but I
see no other option to educate people.

Maybe someone can add it back as linux/include/asm-generic/irq.h, which
is where it should've been in the first place.

--- linux/include/linux/irq.h	Tue Apr 13 14:10:15 2004
+++ /dev/null	Sat Apr 26 08:56:46 1997
@@ -1,80 +0,0 @@
-#ifndef __irq_h
-#define __irq_h
-
-/*
- * Please do not include this file in generic code.  There is currently
- * no requirement for any architecture to implement anything held
- * within this file.
- *
- * Thanks. --rmk
- */
-
-#include <linux/config.h>
-
-#if !defined(CONFIG_ARCH_S390)
-
-#include <linux/cache.h>
-#include <linux/spinlock.h>
-#include <linux/cpumask.h>
-
-#include <asm/irq.h>
-#include <asm/ptrace.h>
-
-/*
- * IRQ line status.
- */
-#define IRQ_INPROGRESS	1	/* IRQ handler active - do not enter! */
-#define IRQ_DISABLED	2	/* IRQ disabled - do not enter! */
-#define IRQ_PENDING	4	/* IRQ pending - replay on enable */
-#define IRQ_REPLAY	8	/* IRQ has been replayed but not acked yet */
-#define IRQ_AUTODETECT	16	/* IRQ is being autodetected */
-#define IRQ_WAITING	32	/* IRQ not yet seen - for autodetection */
-#define IRQ_LEVEL	64	/* IRQ level triggered */
-#define IRQ_MASKED	128	/* IRQ masked - shouldn't be seen again */
-#define IRQ_PER_CPU	256	/* IRQ is per CPU */
-
-/*
- * Interrupt controller descriptor. This is all we need
- * to describe about the low-level hardware. 
- */
-struct hw_interrupt_type {
-	const char * typename;
-	unsigned int (*startup)(unsigned int irq);
-	void (*shutdown)(unsigned int irq);
-	void (*enable)(unsigned int irq);
-	void (*disable)(unsigned int irq);
-	void (*ack)(unsigned int irq);
-	void (*end)(unsigned int irq);
-	void (*set_affinity)(unsigned int irq, cpumask_t dest);
-};
-
-typedef struct hw_interrupt_type  hw_irq_controller;
-
-/*
- * This is the "IRQ descriptor", which contains various information
- * about the irq, including what kind of hardware handling it has,
- * whether it is disabled etc etc.
- *
- * Pad this out to 32 bytes for cache and indexing reasons.
- */
-typedef struct irq_desc {
-	unsigned int status;		/* IRQ status */
-	hw_irq_controller *handler;
-	struct irqaction *action;	/* IRQ action list */
-	unsigned int depth;		/* nested irq disables */
-	unsigned int irq_count;		/* For detecting broken interrupts */
-	unsigned int irqs_unhandled;
-	spinlock_t lock;
-} ____cacheline_aligned irq_desc_t;
-
-extern irq_desc_t irq_desc [NR_IRQS];
-
-#include <asm/hw_irq.h> /* the arch dependent stuff */
-
-extern int setup_irq(unsigned int , struct irqaction * );
-
-extern hw_irq_controller no_irq_type;  /* needed in every arch ? */
-
-#endif
-
-#endif /* __irq_h */


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
