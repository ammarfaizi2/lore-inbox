Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262468AbSI2NKa>; Sun, 29 Sep 2002 09:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbSI2NKa>; Sun, 29 Sep 2002 09:10:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46351 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262468AbSI2NK3>; Sun, 29 Sep 2002 09:10:29 -0400
Date: Sun, 29 Sep 2002 14:15:50 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: free_irq
Message-ID: <20020929141550.A15924@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The comments surrounding free_irq() include these line:

 *      On a shared IRQ the caller must ensure the interrupt is disabled
 *      on the card it drives before calling this function. The function
 *      does not return until any executing interrupts for this IRQ
 *      have completed.
 *
 *      This function may be called from interrupt context.

This last line is quite bogus.

- if we call this function to free IRQ "n" from an interrupt handler
  running on IRQ "n", then we will deadlock; we call synchronize_irq(n)
  which will wait for us to exit.

- if we call this function to free IRQ "n" from an interrupt handler
  running on IRQ "b", and a handler for IRQ "n" is already running and
  IRQ "n" interrupted IRQ "n", then we will deadlock.

In light of the above, I'd suggest changing the last line to:

 *	This function must not be called from interrupt context.

This patch is against 2.5.34:

--- orig/arch/i386/kernel/irq.c	Fri Aug 30 14:52:51 2002
+++ linux/arch/i386/kernel/irq.c	Sun Sep 29 14:13:39 2002
@@ -483,10 +483,7 @@
  *	does not return until any executing interrupts for this IRQ
  *	have completed.
  *
- *	This function may be called from interrupt context. 
- *
- *	Bugs: Attempting to free an irq in a handler for the same irq hangs
- *	      the machine.
+ *	This function must not be called from interrupt context. 
  */
  
 void free_irq(unsigned int irq, void *dev_id)


-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

