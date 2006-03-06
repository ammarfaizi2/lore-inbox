Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWCFVWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWCFVWM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWCFVWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:22:11 -0500
Received: from relay04.roc.ny.frontiernet.net ([66.133.182.167]:8615 "EHLO
	relay04.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S1751194AbWCFVWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:22:11 -0500
Message-ID: <20060306212209.qav38uffwhkwsg00@webmail04.roc.ny.frontiernet.net>
Date: Mon, 06 Mar 2006 21:22:09 +0000
From: "lgeek@frontiernet.net" <lgeek@frontiernet.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IRQ: prevent enabling of previously disabled interrupt
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.0.5-cvs)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   This fix prevents re-disabling and enabling of a previously disabled 
interrupt in 2.6.16-rc5.  On an SMP system with irq balancing enabled; 
If an interrupt is disabled from within its own interrupt context with 
disable_irq_nosync and is also earmarked for processor migration, the 
interrupt is blindly moved to the other processor and enabled without 
regard for its current "enabled" state.  If there is an interrupt  
pending, it will unexpectedly invoke the irq handler on the new irq 
owning processor (even though the irq was previously disabled)

   The more intuitive fix would be to invoke disable_irq_nosync and 
enable_irq, but since we already have the desc->lock from __do_IRQ, we 
cannot call them directly.  Instead we can use the same logic to 
disable and enable found in disable_irq_nosync and enable_irq, with 
regards to the desc->depth.

   This now prevents a disabled interrupt from being re-disabled, and 
more importantly prevents a disabled interrupt from being incorrectly 
enabled on a different processor.

Signed-off-by: Bryan Holty <lgeek@frontiernet.net>

--- 2.6.16-rc5/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -155,9 +155,13 @@
	 * Being paranoid i guess!
	 */
	if (unlikely(!cpus_empty(tmp))) {
-		desc->handler->disable(irq);
+		if (likely(!desc->depth++))
+			desc->handler->disable(irq);
+
		desc->handler->set_affinity(irq,tmp);
-		desc->handler->enable(irq);
+
+		if (likely(!--desc->depth))
+			desc->handler->enable(irq);
	}
	cpus_clear(pending_irq_cpumask[irq]);
}

-- 
- Bryan Holty

