Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVKVFTN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVKVFTN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 00:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVKVFTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 00:19:13 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:52105 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932261AbVKVFTM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 00:19:12 -0500
From: Matthew Wilcox <matthew@wil.cx>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] Don't overflow irq_desc array
Message-Id: <E1EeQYa-00055j-93@localhost.localdomain>
Date: Tue, 22 Nov 2005 00:19:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check the irq number is within bounds in the functions which weren't
already checking.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>
Acked-by: Ingo Molnar <mingo@elte.hu>

---

 kernel/irq/manage.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

applies-to: bf816f7c7055127415fc3b718e260855df815d55
ef8b1f22644fd4b6b74c41bffc80f517d5d6ac72
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 3bd7226..81c49a4 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -36,6 +36,9 @@ void synchronize_irq(unsigned int irq)
 {
 	struct irq_desc *desc = irq_desc + irq;
 
+	if (irq >= NR_IRQS)
+		return;
+
 	while (desc->status & IRQ_INPROGRESS)
 		cpu_relax();
 }
@@ -60,6 +63,9 @@ void disable_irq_nosync(unsigned int irq
 	irq_desc_t *desc = irq_desc + irq;
 	unsigned long flags;
 
+	if (irq >= NR_IRQS)
+		return;
+
 	spin_lock_irqsave(&desc->lock, flags);
 	if (!desc->depth++) {
 		desc->status |= IRQ_DISABLED;
@@ -86,6 +92,9 @@ void disable_irq(unsigned int irq)
 {
 	irq_desc_t *desc = irq_desc + irq;
 
+	if (irq >= NR_IRQS)
+		return;
+
 	disable_irq_nosync(irq);
 	if (desc->action)
 		synchronize_irq(irq);
@@ -108,6 +117,9 @@ void enable_irq(unsigned int irq)
 	irq_desc_t *desc = irq_desc + irq;
 	unsigned long flags;
 
+	if (irq >= NR_IRQS)
+		return;
+
 	spin_lock_irqsave(&desc->lock, flags);
 	switch (desc->depth) {
 	case 0:
@@ -163,6 +175,9 @@ int setup_irq(unsigned int irq, struct i
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
