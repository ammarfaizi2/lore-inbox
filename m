Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWEXQi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWEXQi1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 12:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932396AbWEXQi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 12:38:27 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:31401 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932378AbWEXQi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 12:38:26 -0400
Subject: Re: Ingo's  realtime_preempt patch causes kernel oops
From: Steven Rostedt <rostedt@goodmis.org>
To: tglx@linutronix.de
Cc: Sven-Thorsten Dietrich <sven@mvista.com>, Yann.LEPROVOST@wavecom.fr,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1148486614.5239.63.camel@localhost.localdomain>
References: <OFD8B7556E.13DD6F3A-ONC1257178.002C2D9A-C1257178.002D1FC5@wavecom.fr>
	 <1148475334.24623.45.camel@localhost.localdomain>
	 <1148476383.5239.54.camel@localhost.localdomain>
	 <1148484729.14683.5.camel@localhost.localdomain>
	 <1148485943.24623.54.camel@localhost.localdomain>
	 <1148486614.5239.63.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 24 May 2006 12:38:07 -0400
Message-Id: <1148488687.24623.67.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 18:03 +0200, Thomas Gleixner wrote:
> On Wed, 2006-05-24 at 11:52 -0400, Steven Rostedt wrote:
> > > > As I said yesterday. You need a demultiplexer for such cases.
> > > > 
> > > 
> > > Would IRQs stay masked until the thread has finished running?
> > 
> > I would say yes.  But the system is basically broken if you have the
> > same interrupt line that needs both to be threaded and NODELAY.
> > 
> > Basically, the best I can think to have for such a case, is all
> > interrupt threads that have a shared NODELAY run at MAX_PRIO (99).  So
> > that they act like a NODELAY interrupt, in that they run over everything
> > else, but they can still schedule.
> 
> Err. That's why you use demultiplexers. The demux handler is always
> NODELAY.
> 
> shared IRQ
> -> demux_handler
> 	disable shared irq
> 	identify interrupt sources
> 	for all sources:
> 		calculate the interrupt number
> 		irq_desc[number]->handle_irq(.....)
> 			disable/ack a particular source
> 			if NODELAY 
> 				call handler and reenable if appropriate
> 			else 
> 				wakeup thread
> 	enable shared irq
> 
> That's the way you really want to do it. Granted, that this is not
> possible with the current implementation of PCI cards, but for the SoC
> peripherals this is usually simple to do.
> 
> The ARM tree has tons of examples which do exactly this.
> 

OK I haven't worked on arm much at all. Only had to port one board
before, and didn't need to get too involved.

Can't two devices share the same interrupt line? Not talking about a
cascading interrupt controller, but two actual devices that can trigger
a single interrupt line.  So, if this is the case, how do you disable a
particular source without going to the driver itself?

If this is not the case, and the interrupt line that is shared has
another controller that the devices are separated on, then this is
trivial.  But I don't know the setup in question.

-- Steve


