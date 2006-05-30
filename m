Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWE3KGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWE3KGN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 06:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWE3KGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 06:06:13 -0400
Received: from wmp-pc40.wavecom.fr ([81.80.89.162]:41738 "EHLO
	domino.wavecom.fr") by vger.kernel.org with ESMTP id S932206AbWE3KGM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 06:06:12 -0400
In-Reply-To: <1148493625.17131.36.camel@localhost.localdomain>
Subject: RT_PREEMPT problem with cascaded irqchip 
To: Sven-Thorsten Dietrich <sven@mvista.com>
Cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Steven Rostedt <rostedt@goodmis.org>, Esben Nielsen <simlo@phys.au.dk>,
       tglx@linutronix.de
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
Message-ID: <OF5C056C3F.1146A6FD-ONC125717E.0035221D-C125717E.00377E2F@wavecom.fr>
From: Yann.LEPROVOST@wavecom.fr
Date: Tue, 30 May 2006 12:00:03 +0200
X-MIMETrack: Serialize by Router on domino/wavecom(Release 6.5.4|March 27, 2005) at 05/30/2006
 12:00:06 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

After shared interrupt line with CONFIG_PREEMPT_HARDIRQS issue, I found
another problem with the gpio "interrupt on level change" management on
AT91RM9200.

>From the point of view of linux, there is to struct irqchip :
- one dealing with the interrupt controller (AIC)
- another one dealing with PIO controllers to mask and unmask interrupts
from gpios

The second one is cascaded with the first one through 4 irq lines (one for
each PIO controller, therefore 4 PIO controllers) using
set_irq_chained_handler.
After registering theses irqs, the gpio_irq_handler is correctly called on
gpio irqs...

However, when calling desc->chip->mask, the function at91rm9200_mask_irq is
called instead of gpio_mask_irq !
at91rm9200_mask_irq is registered on the first AIC struct irqchip.

I'm using linux-2.6.16-at91-rt23 with CONFIG_PREEMPT_HARDIRQS=yes
I have rewrite gpio_irq_handler as :

static void gpio_irq_handler(unsigned int irq, struct irqdesc* desc, struct
pt_regs* regs)
{
      desc->chip->mask(irq);
      desc->chip->unmask(irq);
}

As desc->chip->(un)mask(irq) doesn't acknowledge the PIO controller, kernel
loops in ISR...

What's wrong with desc->chip->mask ?

Regards

Yann Leprovost

