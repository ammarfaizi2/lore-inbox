Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269632AbRHaW0f>; Fri, 31 Aug 2001 18:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269645AbRHaW00>; Fri, 31 Aug 2001 18:26:26 -0400
Received: from intranet.resilience.com ([209.245.157.33]:14811 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S269632AbRHaW0U>; Fri, 31 Aug 2001 18:26:20 -0400
Mime-Version: 1.0
Message-Id: <p05100307b7b5b293eb46@[10.128.7.49]>
In-Reply-To: <Pine.LNX.4.33.0108310655590.15502-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0108310655590.15502-100000@penguin.transmeta.com>
Date: Fri, 31 Aug 2001 15:25:59 -0700
To: Linus Torvalds <torvalds@transmeta.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: [PATCH] i386 SA_INTERRUPT logic
Cc: <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herewith a patch to arch/i386/kernel/irq.c:handle_IRQ_event(). To 
belabor the obvious, the SA_INTERRUPT flag ought to affect just the 
handler it's set (or not) for. The existing code can enable 
interrupts for drivers that don't want them enabled, or disable them 
for drivers that do. We've done cursory testing, but can't test all 
possible cases; it looks straightforward enough, though.

I notice that this is fixed in alpha, broken in arm, cris, ia64, 
mips, ppc, sh. The respective architecture maintainers might like to 
have a closer look.



--- /usr/src/linux-2.4.9/arch/i386/kernel/irq.c	Wed Jun 20 11:06:38 2001
+++ irq.c	Fri Aug 31 14:29:11 2001
@@ -443,17 +443,16 @@

  	status = 1;	/* Force the "do bottom halves" bit */

-	if (!(action->flags & SA_INTERRUPT))
-		__sti();
-
  	do {
  		status |= action->flags;
+		if (!(action->flags & SA_INTERRUPT))
+			__sti();
  		action->handler(irq, action->dev_id, regs);
+		__cli();
  		action = action->next;
  	} while (action);
  	if (status & SA_SAMPLE_RANDOM)
  		add_interrupt_randomness(irq);
-	__cli();

  	irq_exit(cpu, irq);

-- 
/Jonathan Lundell.
