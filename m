Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWEQAP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWEQAP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWEQAP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:15:28 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:4048 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932290AbWEQAP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:15:26 -0400
Date: Wed, 17 May 2006 02:15:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 03/50] genirq: cleanup: remove fastcall
Message-ID: <20060517001518.GD12877@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

now that i386 defaults to regparm, explicit uses of fastcall are
not needed anymore.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h |   11 ++++++++---
 kernel/irq/handle.c |    4 ++--
 2 files changed, 10 insertions(+), 5 deletions(-)

Index: linux-genirq.q/include/linux/irq.h
===================================================================
--- linux-genirq.q.orig/include/linux/irq.h
+++ linux-genirq.q/include/linux/irq.h
@@ -162,11 +162,16 @@ static inline void set_irq_info(int irq,
 extern int no_irq_affinity;
 extern int noirqdebug_setup(char *str);
 
-extern fastcall int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
-					struct irqaction *action);
+extern int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
+			    struct irqaction *action);
+
+/*
+ * Explicit fastcall, because i386 4KSTACKS calls it from assembly:
+ */
 extern fastcall unsigned int __do_IRQ(unsigned int irq, struct pt_regs *regs);
+
 extern void note_interrupt(unsigned int irq, irq_desc_t *desc,
-					int action_ret, struct pt_regs *regs);
+			   int action_ret, struct pt_regs *regs);
 extern int can_request_irq(unsigned int irq, unsigned long irqflags);
 
 extern void init_irq_proc(void);
Index: linux-genirq.q/kernel/irq/handle.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/handle.c
+++ linux-genirq.q/kernel/irq/handle.c
@@ -79,8 +79,8 @@ irqreturn_t no_action(int cpl, void *dev
 /*
  * Have got an event to handle:
  */
-fastcall int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
-				struct irqaction *action)
+int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
+		     struct irqaction *action)
 {
 	int ret, retval = 0, status = 0;
 
