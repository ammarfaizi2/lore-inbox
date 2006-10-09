Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932934AbWJIP23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932934AbWJIP23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 11:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932937AbWJIP23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 11:28:29 -0400
Received: from usea-naimss3.unisys.com ([192.61.61.105]:48134 "EHLO
	usea-naimss3.unisys.com") by vger.kernel.org with ESMTP
	id S932934AbWJIP22 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 11:28:28 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot handle IRQ -1"
Date: Mon, 9 Oct 2006 10:28:13 -0500
Message-ID: <19D0D50E9B1D0A40A9F0323DBFA04ACC023B0D17@USRV-EXCH4.na.uis.unisys.com>
In-Reply-To: <m1y7rpr1hr.fsf@ebiederm.dsl.xmission.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot handle IRQ -1"
Thread-Index: Acbrsg6/9iHoY3caQfuL+ezlGD696QABD0vw
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Arjan van de Ven" <arjan@infradead.org>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Muli Ben-Yehuda" <muli@il.ibm.com>,
       "Ingo Molnar" <mingo@elte.hu>, "Thomas Gleixner" <tglx@linutronix.de>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Rajesh Shah" <rajesh.shah@intel.com>, "Andi Kleen" <ak@muc.de>,
       "Luck, Tony" <tony.luck@intel.com>, "Andrew Morton" <akpm@osdl.org>,
       "Linux-Kernel" <linux-kernel@vger.kernel.org>,
       "Badari Pulavarty" <pbadari@gmail.com>,
       "Roland Dreier" <rdreier@cisco.com>
X-OriginalArrivalTime: 09 Oct 2006 15:28:15.0075 (UTC) FILETIME=[89D70330:01C6EBB7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Eric W. Biederman [mailto:ebiederm@xmission.com] 
> Sent: Monday, October 09, 2006 8:46 AM
> To: Arjan van de Ven
> Cc: Linus Torvalds; Muli Ben-Yehuda; Ingo Molnar; Thomas 
> Gleixner; Benjamin Herrenschmidt; Rajesh Shah; Andi Kleen; 
> Protasevich, Natalie; Luck, Tony; Andrew Morton; 
> Linux-Kernel; Badari Pulavarty; Roland Dreier
> Subject: Re: 2.6.19-rc1 genirq causes either boot hang or 
> "do_IRQ: cannot handle IRQ -1"
> 
> Arjan van de Ven <arjan@infradead.org> writes:
> 
> >> > So yes, having software say "We want to steer this particular 
> >> > interrupt to this L3 cache domain" sounds eminently sane.
> >> >
> >> > Having software specify which L1 cache domain it wants 
> to pollute 
> >> > is likely just crazy micro-management.
> >> 
> >> The current interrupt delivery abstraction in the kernel 
> is a set of 
> >> cpus an interrupt can be delivered to.  Which seem 
> sufficient to the 
> >> cause of aiming at a cache domain.  Frequently the lower levels of 
> >> interrupt delivery map this to a single cpu because of hardware 
> >> limitations but in certain cases we can honor a multiple 
> cpu request.
> >> 
> >> I believe the scheduler has knowledge about different locality 
> >> domains for NUMA and everything else.  So what is wanting 
> on our side 
> >> is some architecture? work to do the broad steering by default.
> >
> >
> > well normally this is the job of the userspace IRQ balancer to get 
> > right; the thing is undergoing a redesign right now to be 
> smarter and 
> > deal better with dual/quad core, numa etc etc, but as a principle 
> > thing this is best done in userspace (simply because there's higher 
> > level information there, like "is this interrupt for a network 
> > device", so that policy can take that into account)
> 
> So far I have seen all of that higher level information in 
> the kernel, and it has to export it to user space for the 
> user space daemon to do anything about it.
> 
> The only time I have seen user space control being useful is 
> when there isn't a proper default policy so at least you can 
> distribute things between the cache domains properly.  So far 
> I have been more tempted to turn it off as it will routinely 
> change which NUMA node an irq is pointing at, which is not at 
> all ideal for performance, and I haven't seen a way (short of 
> replacing it) to tell the user space irq balancer that it got 
> it's default policy wrong.
> 
> It is quite possible I don't have the whole story, but so far 
> it just feels like we are making a questionable decision by 
> pushing things out to user space.  If nothing else it seems 
> to make changes more difficult in the irq handling 
> infrastructure because we have to maintain stable interfaces. 
>  Things like per cpu counters for every irq start to look 
> really questionable when you scale the system up in size.

I'd like also to question current policies of user space irqbalanced. It
seems to just go round-robin without much heuristics involved. We are
seeing loss of timer interrupts on our systems - and the more processors
the more noticeable it is, but it starts even on 8x partitions; on 48x
system I see about 50% loss, on both ia32 and x86_64 (haven't checked on
ia64 yet). With say 16 threads it is unsettling to see 70% overall idle
time, and still only 40-50% of interrupts go through. System's time is
not affected, so the problem is on the back burner for now :) It's not
clear yet whether this is software or hardware fault, and how much
damage it does (performance wise etc.) I will provide more information
as it becomes available, just wanted to raise red flag, maybe others
also see such phenomena.
Thanks,
--Natalie
