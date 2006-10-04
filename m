Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030615AbWJDQSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030615AbWJDQSG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030642AbWJDQSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:18:06 -0400
Received: from www.osadl.org ([213.239.205.134]:40931 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1030615AbWJDQSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:18:02 -0400
Subject: Re: [patch] clockevents: drivers for i386, fix #2
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
In-Reply-To: <20061004090205.9c29f5bf.akpm@osdl.org>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
	 <20061002210053.16e5d23c.akpm@osdl.org> <20061003084729.GA24961@elte.hu>
	 <20061003103503.GA6350@elte.hu> <20061003203620.d85df9c6.akpm@osdl.org>
	 <20061004064620.GA22364@elte.hu> <20061004003228.98ec3b39.akpm@osdl.org>
	 <20061004075540.GA31415@elte.hu> <20061004011544.d49308de.akpm@osdl.org>
	 <20061004105315.GA24940@elte.hu>
	 <1159960776.1386.244.camel@localhost.localdomain>
	 <20061004090205.9c29f5bf.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 04 Oct 2006 18:20:15 +0200
Message-Id: <1159978815.1386.252.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 09:02 -0700, Andrew Morton wrote:
> On Wed, 04 Oct 2006 13:19:35 +0200
> Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > On Wed, 2006-10-04 at 12:53 +0200, Ingo Molnar wrote:
> > > there's one material difference we just found: in the !hres case we'll 
> > > do the timer IRQ handling mostly from the lapic vector - while in 
> > > mainline we do it from the irq0 vector. So, how does your 
> > > /proc/interrupts look like? How frequently does LOC increase, and how 
> > > frequently does IRQ 0 increase?
> 
> sony:/home/akpm> cat /proc/interrupts ; sleep 1 ; cat /proc/interrupts
>            CPU0       
>   0:      39256   IO-APIC-edge      timer
> LOC:       3131 

>   0:      39519   IO-APIC-edge      timer
> LOC:       3134 

delta IRQ == 263
delta LOC == 3

That explains the problem. The lapic frequency seems to be way off. I
have no good idea offhand how to detect such lapic brokeness.

> >  static struct clock_event_device lapic_clockevent = {
> >  	.name = "lapic",
> >  	.capabilities = CLOCK_CAP_NEXTEVT | CLOCK_CAP_PROFILE
> > +#ifdef CONFIG_SMP
> >  			| CLOCK_CAP_UPDATE,
> > +#endif
> >  	.shift = 32,
> >  	.set_mode = lapic_timer_setup,
> >  	.set_next_event = lapic_next_event,
> 
> that (after a tweak to make it compile) fixes it.   What's it do?

It brings update_process_times() back into IRQ0. On systems with a
working lapic, it would not matter. SMP moves update_process_times() to
lapic too. That's why I asked whether a SMP=y kernel has the same
problems on this box.

	tglx


