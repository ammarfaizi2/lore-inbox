Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbWEQARd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbWEQARd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 20:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWEQARb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 20:17:31 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:58832 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932335AbWEQAR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 20:17:26 -0400
Date: Wed, 17 May 2006 02:17:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: [patch 27/50] genirq: ARM: dyntick quirk
Message-ID: <20060517001721.GB12877@elte.hu>
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

ARM dyntick quirk.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 kernel/irq/handle.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: linux-genirq.q/kernel/irq/handle.c
===================================================================
--- linux-genirq.q.orig/kernel/irq/handle.c
+++ linux-genirq.q/kernel/irq/handle.c
@@ -16,6 +16,10 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 
+#if defined(CONFIG_NO_IDLE_HZ) && defined(CONFIG_ARM)
+#include <asm/dyntick.h>
+#endif
+
 #include "internals.h"
 
 /**
@@ -105,6 +109,15 @@ int handle_IRQ_event(unsigned int irq, s
 {
 	int ret, retval = 0, status = 0;
 
+#if defined(CONFIG_NO_IDLE_HZ) && defined(CONFIG_ARM)
+	if (!(action->flags & SA_TIMER) && system_timer->dyn_tick != NULL) {
+		write_seqlock(&xtime_lock);
+		if (system_timer->dyn_tick->state & DYN_TICK_ENABLED)
+			system_timer->dyn_tick->handler(irq, 0, regs);
+		write_sequnlock(&xtime_lock);
+	}
+#endif
+
 	if (!(action->flags & SA_INTERRUPT))
 		local_irq_enable();
 
