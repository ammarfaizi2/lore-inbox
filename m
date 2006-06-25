Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWFYRWP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWFYRWP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 13:22:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWFYRWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 13:22:15 -0400
Received: from www.osadl.org ([213.239.205.134]:7592 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751331AbWFYRWO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 13:22:14 -0400
Subject: Re: Problem with 2.6.17-mm2
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060625034913.315755ae.akpm@osdl.org>
References: <20060625103523.GY27143@charite.de>
	 <20060625034913.315755ae.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 25 Jun 2006 19:24:06 +0200
Message-Id: <1151256246.25491.398.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Sun, 2006-06-25 at 03:49 -0700, Andrew Morton wrote:
> OK, thanks.
> 
> > 1) A lot of "unexpected IRQ trap at vector X" for X=[09,07]
> 
> hm, ack_bad_irq().  That isn't supposed to happen.
> 
> Ingo, Thomas - it's possible that -mm2's genirq is affecting x86?

I did some tests by asserting spurious interrupts. genirq is just making
them visible, backing out the genirq changes makes them invisible again.

The reason is:

ack_bad_irq() in !genirq is only called, when no hw_irq_controller has
been installed. The interrupts in question have the PIC/APIC/IOAPIC
functions installed.

Now when a spurios interrupt comes in we do

	desc->handler->ack(irq);

	if (!desc->action)
		goto out;

So in fact this just silently acks spurious interrupts which have an
hw_irq_controller assigned. If there is no action, then nothing has
called setup_irq/request_irq for this interrupt line and therefor it is
an spurious interrupt which should not happen.


genirq makes these visible and informs noisily about those events. 

Looking at the debug output we see:

irq 7, desc: c037bc00, depth: 1, count: 0, unhandled: 0
->handle_irq():  c013d360, handle_bad_irq+0x0/0x270
->chip(): c037f980, 0xc037f980
->action(): 00000000
IRQ_DISABLED set

The interrupt is disabled and action is NULL.

	tglx


