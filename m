Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWEQA27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWEQA27 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWEQARj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:17:39 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:55504 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932327AbWEQARU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:17:20 -0400
Date: Wed, 17 May 2006 02:17:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 24/50] genirq: add SA_TRIGGER support
Message-ID: <20060517001706.GY12877@elte.hu>
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

From: Thomas Gleixner <tglx@linutronix.de>

enable drivers to request an IRQ with a given irq-flow (trigger/polarity)
setting.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/irq/manage.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

Index: linux-genirq.q/kernel/irq/manage.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/manage.c
+++ linux-genirq.q/kernel/irq/manage.c
@@ -214,8 +214,14 @@ int setup_irq(unsigned int irq, struct i
 	p = &desc->action;
 	old = *p;
 	if (old) {
-		/* Can't share interrupts unless both agree to */
-		if (!(old->flags & new->flags & SA_SHIRQ))
+		/*
+		 * Can't share interrupts unless both agree to and are
+		 * the same type (level, edge, polarity). So both flag
+		 * fields must have SA_SHIRQ set and the bits which
+		 * set the trigger type must match.
+		 */
+		if (!((old->flags & new->flags) & SA_SHIRQ) ||
+		    ((old->flags ^ new->flags) & SA_TRIGGER_MASK))
 			goto mismatch;
 
 #if defined(CONFIG_IRQ_PER_CPU) && defined(SA_PERCPU_IRQ)
@@ -238,6 +244,11 @@ int setup_irq(unsigned int irq, struct i
 		desc->status |= IRQ_PER_CPU;
 #endif
 	if (!shared) {
+		/* Setup the type (level, edge polarity) if configured: */
+		if (new->flags & SA_TRIGGER_MASK && desc->handler->set_type)
+			desc->handler->set_type(irq,
+						new->flags & SA_TRIGGER_MASK);
+
 		desc->status &= ~(IRQ_AUTODETECT | IRQ_WAITING |
 				  IRQ_INPROGRESS);
 
