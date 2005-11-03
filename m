Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbVKCOvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbVKCOvU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 09:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030233AbVKCOvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 09:51:20 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:63177 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S1030231AbVKCOvT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 09:51:19 -0500
Date: Thu, 3 Nov 2005 07:51:18 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>
Subject: Re: First steps towards making NO_IRQ a generic concept
Message-ID: <20051103145118.GW23749@parisc-linux.org>
References: <20051103144926.GV23749@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103144926.GV23749@parisc-linux.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Check the irq number is within bounds in the functions which weren't
already checking.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

---

 kernel/irq/manage.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

applies-to: d49992521230a4e302c6d4bef9191e885220b82e
2bcbc18c7e2148e9a1588e607a63f51e53d53810
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1cfdb08..4190d9e 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -35,6 +35,9 @@ void synchronize_irq(unsigned int irq)
 {
 	struct irq_desc *desc = irq_desc + irq;
 
+	if (irq >= NR_IRQS)
+		return;
+
 	while (desc->status & IRQ_INPROGRESS)
 		cpu_relax();
 }
@@ -59,6 +62,9 @@ void disable_irq_nosync(unsigned int irq
 	irq_desc_t *desc = irq_desc + irq;
 	unsigned long flags;
 
+	if (irq >= NR_IRQS)
+		return;
+
 	spin_lock_irqsave(&desc->lock, flags);
 	if (!desc->depth++) {
 		desc->status |= IRQ_DISABLED;
@@ -85,6 +91,9 @@ void disable_irq(unsigned int irq)
 {
 	irq_desc_t *desc = irq_desc + irq;
 
+	if (irq >= NR_IRQS)
+		return;
+
 	disable_irq_nosync(irq);
 	if (desc->action)
 		synchronize_irq(irq);
@@ -107,6 +116,9 @@ void enable_irq(unsigned int irq)
 	irq_desc_t *desc = irq_desc + irq;
 	unsigned long flags;
 
+	if (irq >= NR_IRQS)
+		return;
+
 	spin_lock_irqsave(&desc->lock, flags);
 	switch (desc->depth) {
 	case 0:
@@ -162,6 +174,9 @@ int setup_irq(unsigned int irq, struct i
 	unsigned long flags;
 	int shared = 0;
 
+	if (irq >= NR_IRQS)
+		return -EINVAL;
+
 	if (desc->handler == &no_irq_type)
 		return -ENOSYS;
 	/*
---
0.99.8.GIT
