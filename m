Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVGGTNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVGGTNV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 15:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVGGTIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 15:08:24 -0400
Received: from unused.mind.net ([69.9.134.98]:13239 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S261916AbVGGTGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 15:06:20 -0400
Date: Thu, 7 Jul 2005 12:05:27 -0700 (PDT)
From: William Weston <weston@sysex.net>
X-X-Sender: weston@echo.lysdexia.org
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.51-08
In-Reply-To: <20050706100451.GA7336@elte.hu>
Message-ID: <Pine.LNX.4.58.0507070120100.22287@echo.lysdexia.org>
References: <200506281927.43959.annabellesgarden@yahoo.de>
 <200506301952.22022.annabellesgarden@yahoo.de> <20050630205029.GB1824@elte.hu>
 <200507010027.33079.annabellesgarden@yahoo.de> <20050701071850.GA18926@elte.hu>
 <Pine.LNX.4.58.0507011739550.27619@echo.lysdexia.org> <20050703140432.GA19074@elte.hu>
 <20050703181229.GA32741@elte.hu> <Pine.LNX.4.58.0507051155050.13165@echo.lysdexia.org>
 <20050706100451.GA7336@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Ingo Molnar wrote:

> do the 51-02 (and later) kernels work on the UP Athlon box?

Hi Ingo,

-51-06 and -51-08 are looking stable on the UP Athlon box with the
following patch which causes edge triggered hardirqs to be masked when
pending _and/or_ disabled (instead of both pending _and_ disabled) and
backs out a change from -50-44 that prevents pending edge triggered irqs
from being unmasked:

--- linux.orig/arch/i386/kernel/io_apic.c	2005-07-06 11:08:39.000000000 -0700
+++ linux/arch/i386/kernel/io_apic.c	2005-07-07 03:40:37.000000000 -0700
@@ -1949,8 +1949,7 @@
 static void ack_edge_ioapic_irq(unsigned int irq)
 {
 	move_irq(irq);
-	if ((irq_desc[irq].status & (IRQ_PENDING | IRQ_DISABLED))
-					== (IRQ_PENDING | IRQ_DISABLED))
+	if (irq_desc[irq].status & (IRQ_PENDING | IRQ_DISABLED))
 		mask_IO_APIC_irq(irq);
 	ack_APIC_irq();
 }
@@ -1997,8 +1996,6 @@
 	unsigned long v;
 	int i;
 
-	if (!(irq_desc[irq].status & IRQ_DISABLED))
-		unmask_IO_APIC_irq(irq);
 /*
  * It appears there is an erratum which affects at least version 0x11
  * of I/O APIC (that's the 82093AA and cores integrated into various
--- linux.orig/kernel/irq/manage.c	2005-07-06 11:08:40.000000000 -0700
+++ linux/kernel/irq/manage.c	2005-07-07 01:04:38.000000000 -0700
@@ -434,6 +434,8 @@
 		 * The ->end() handler has to deal with interrupts which got
 		 * disabled while the handler was running.
 		 */
+		if (!(desc->status & IRQ_DISABLED))
+			desc->handler->enable(irq);
 		desc->handler->end(irq);
 	}
 	spin_unlock_irq(&desc->lock);

The first chunk is based on my understanding of the comments in io_apic.c,
and is not necessary to keep the UP Athlon box stable.  Is my logic OK 
here, or am I missing something really important?

Without the last two chunks of this patch, the UP Athlon box locks up hard
as soon as jackd is started up.

Best Regards,
--ww
