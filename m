Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWDUGGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWDUGGl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 02:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWDUGGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 02:06:41 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:60749 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP
	id S1750924AbWDUGGl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 02:06:41 -0400
Date: Thu, 20 Apr 2006 23:06:32 -0700
Message-Id: <200604210606.k3L66WWB008480@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] invert irq/migration.c brach prediction
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	If you get to that point in the code it means that 
desc->move_irq is set, pending_irq_cpumask[irq] and cpu_online_map 
should have a value. Still pretty good chance anding those two 
you'll still have a value. So these two branch predictors should
be inverted .

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/kernel/irq/migration.c
===================================================================
--- linux-2.6.16.orig/kernel/irq/migration.c
+++ linux-2.6.16/kernel/irq/migration.c
@@ -30,7 +30,7 @@ void move_native_irq(int irq)
 
 	desc->move_irq = 0;
 
-	if (likely(cpus_empty(pending_irq_cpumask[irq])))
+	if (unlikely(cpus_empty(pending_irq_cpumask[irq])))
 		return;
 
 	if (!desc->handler->set_affinity)
@@ -49,7 +49,7 @@ void move_native_irq(int irq)
 	 * cause some ioapics to mal-function.
 	 * Being paranoid i guess!
 	 */
-	if (unlikely(!cpus_empty(tmp))) {
+	if (likely(!cpus_empty(tmp))) {
 		if (likely(!(desc->status & IRQ_DISABLED)))
 			desc->handler->disable(irq);
 
