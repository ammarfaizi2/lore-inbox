Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWGCASJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWGCASJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 20:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWGCASJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 20:18:09 -0400
Received: from www.osadl.org ([213.239.205.134]:63160 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1750752AbWGCASH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 20:18:07 -0400
Subject: [PATCH] genirq:fixup missing SA_PERCPU replacement
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 03 Jul 2006 02:20:32 +0200
Message-Id: <1151886032.24611.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The irqflags consolidation converted SA_PERCPU_IRQ to IRQF_PERCPU but
did not define the new constant.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Index: linux-2.6.git/include/linux/interrupt.h
===================================================================
--- linux-2.6.git.orig/include/linux/interrupt.h	2006-07-02 23:38:32.000000000 +0200
+++ linux-2.6.git/include/linux/interrupt.h	2006-07-03 01:57:20.000000000 +0200
@@ -45,6 +45,7 @@
 #define IRQF_SHARED		0x00000080
 #define IRQF_PROBE_SHARED	0x00000100
 #define IRQF_TIMER		0x00000200
+#define IRQF_PERCPU		0x00000400
 
 /*
  * Migration helpers. Scheduled for removal in 1/2007
@@ -54,6 +55,7 @@
 #define SA_SAMPLE_RANDOM	IRQF_SAMPLE_RANDOM
 #define SA_SHIRQ		IRQF_SHARED
 #define SA_PROBEIRQ		IRQF_PROBE_SHARED
+#define SA_PERCPU		IRQF_PERCPU
 
 #define SA_TRIGGER_LOW		IRQF_TRIGGER_LOW
 #define SA_TRIGGER_HIGH		IRQF_TRIGGER_HIGH
Index: linux-2.6.git/kernel/irq/manage.c
===================================================================
--- linux-2.6.git.orig/kernel/irq/manage.c	2006-07-02 23:38:32.000000000 +0200
+++ linux-2.6.git/kernel/irq/manage.c	2006-07-03 01:58:45.000000000 +0200
@@ -234,7 +234,7 @@ int setup_irq(unsigned int irq, struct i
 		    ((old->flags ^ new->flags) & IRQF_TRIGGER_MASK))
 			goto mismatch;
 
-#if defined(CONFIG_IRQ_PER_CPU) && defined(IRQF_PERCPU)
+#if defined(CONFIG_IRQ_PER_CPU)
 		/* All handlers must agree on per-cpuness */
 		if ((old->flags & IRQF_PERCPU) !=
 		    (new->flags & IRQF_PERCPU))
@@ -250,7 +250,7 @@ int setup_irq(unsigned int irq, struct i
 	}
 
 	*p = new;
-#if defined(CONFIG_IRQ_PER_CPU) && defined(IRQF_PERCPU)
+#if defined(CONFIG_IRQ_PER_CPU)
 	if (new->flags & IRQF_PERCPU)
 		desc->status |= IRQ_PER_CPU;
 #endif


