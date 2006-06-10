Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWFJKcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWFJKcF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 06:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWFJKcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 06:32:05 -0400
Received: from www.osadl.org ([213.239.205.134]:55955 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751480AbWFJKcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 06:32:04 -0400
Message-Id: <20060610085435.487020000@cruncher.tec.linutronix.de>
References: <20060610085428.366868000@cruncher.tec.linutronix.de>
Date: Sat, 10 Jun 2006 10:15:11 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: [patch 1/2] genirq: allow usage of no_irq_chip
Content-Disposition: inline; filename=genirq-allow-usage-of-no-irq-chip.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some dumb interrupt hardware has no way to ack/mask.... Instead of creating a
seperate chip structure we allow to reuse the already existing no_irq_chip

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 kernel/irq/handle.c |    8 ++++++--
 kernel/irq/manage.c |    2 +-
 kernel/irq/proc.c   |    5 ++---
 3 files changed, 9 insertions(+), 6 deletions(-)

Index: linux-2.6.17-rc6-mm/kernel/irq/handle.c
===================================================================
--- linux-2.6.17-rc6-mm.orig/kernel/irq/handle.c	2006-06-10 10:32:51.000000000 +0200
+++ linux-2.6.17-rc6-mm/kernel/irq/handle.c	2006-06-10 10:42:22.000000000 +0200
@@ -63,8 +63,12 @@
  */
 static void ack_bad(unsigned int irq)
 {
-	print_irq_desc(irq, irq_desc + irq);
-	ack_bad_irq(irq);
+	struct irq_desc *desc = irq_desc + irq;
+
+	if (desc->handle_irq == handle_bad_irq) {
+		print_irq_desc(irq, desc);
+		ack_bad_irq(irq);
+	}
 }
 
 /*
@@ -89,6 +93,7 @@
 	.enable		= noop,
 	.disable	= noop,
 	.ack		= ack_bad,
+	.unmask		= noop,
 	.end		= noop,
 };
 
Index: linux-2.6.17-rc6-mm/kernel/irq/manage.c
===================================================================
--- linux-2.6.17-rc6-mm.orig/kernel/irq/manage.c	2006-06-10 10:32:53.000000000 +0200
+++ linux-2.6.17-rc6-mm/kernel/irq/manage.c	2006-06-10 10:42:22.000000000 +0200
@@ -199,7 +199,7 @@
 	if (irq >= NR_IRQS)
 		return -EINVAL;
 
-	if (desc->chip == &no_irq_chip)
+	if (desc->handle_irq == &handle_bad_irq)
 		return -ENOSYS;
 	/*
 	 * Some drivers like serial.c use request_irq() heavily,
Index: linux-2.6.17-rc6-mm/kernel/irq/proc.c
===================================================================
--- linux-2.6.17-rc6-mm.orig/kernel/irq/proc.c	2006-06-10 10:32:49.000000000 +0200
+++ linux-2.6.17-rc6-mm/kernel/irq/proc.c	2006-06-10 10:42:22.000000000 +0200
@@ -116,9 +116,8 @@
 {
 	char name [MAX_NAMELEN];
 
-	if (!root_irq_dir ||
-		(irq_desc[irq].chip == &no_irq_chip) ||
-			irq_desc[irq].dir)
+	if (!root_irq_dir || (irq_desc[irq].handle_irq == &handle_bad_irq) ||
+	    irq_desc[irq].dir)
 		return;
 
 	memset(name, 0, MAX_NAMELEN);

--

