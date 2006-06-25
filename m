Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWFYRdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWFYRdE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 13:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWFYRdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 13:33:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27270 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751336AbWFYRdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 13:33:02 -0400
Date: Sun, 25 Jun 2006 10:32:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: Ralf.Hildebrandt@charite.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: Problem with 2.6.17-mm2
Message-Id: <20060625103246.a309d67b.akpm@osdl.org>
In-Reply-To: <1151256246.25491.398.camel@localhost.localdomain>
References: <20060625103523.GY27143@charite.de>
	<20060625034913.315755ae.akpm@osdl.org>
	<1151256246.25491.398.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006 19:24:06 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> Andrew,
> 
> On Sun, 2006-06-25 at 03:49 -0700, Andrew Morton wrote:
> > OK, thanks.
> > 
> > > 1) A lot of "unexpected IRQ trap at vector X" for X=[09,07]
> > 
> > hm, ack_bad_irq().  That isn't supposed to happen.
> > 
> > Ingo, Thomas - it's possible that -mm2's genirq is affecting x86?
> 
> I did some tests by asserting spurious interrupts. genirq is just making
> them visible, backing out the genirq changes makes them invisible again.
> 
> The reason is:
> 
> ack_bad_irq() in !genirq is only called, when no hw_irq_controller has
> been installed. The interrupts in question have the PIC/APIC/IOAPIC
> functions installed.
> 
> Now when a spurios interrupt comes in we do
> 
> 	desc->handler->ack(irq);
> 
> 	if (!desc->action)
> 		goto out;
> 
> So in fact this just silently acks spurious interrupts which have an
> hw_irq_controller assigned. If there is no action, then nothing has
> called setup_irq/request_irq for this interrupt line and therefor it is
> an spurious interrupt which should not happen.
> 
> 
> genirq makes these visible and informs noisily about those events. 
> 

hm, OK.  I guess we can let it ride for now.  Later we can decide whether
we need to shut that warning up.  I suspect we should, if the machine's
working OK.
