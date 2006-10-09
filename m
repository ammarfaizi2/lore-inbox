Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932912AbWJIOs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932912AbWJIOs4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932910AbWJIOs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:48:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7145 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751886AbWJIOsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:48:55 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>, Roland Dreier <rdreier@cisco.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot handle IRQ -1"
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
	<m11wpl328i.fsf@ebiederm.dsl.xmission.com>
	<20061006155021.GE14186@rhun.haifa.ibm.com>
	<m1d5951gm7.fsf@ebiederm.dsl.xmission.com>
	<20061006202324.GJ14186@rhun.haifa.ibm.com>
	<m1y7rtxb7z.fsf@ebiederm.dsl.xmission.com>
	<20061007080315.GM14186@rhun.haifa.ibm.com>
	<m14pugxe47.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0610071154510.3952@g5.osdl.org>
	<1160249585.3000.159.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0610071255480.3952@g5.osdl.org>
	<m1hcyerpjc.fsf@ebiederm.dsl.xmission.com>
	<1160379606.3000.195.camel@laptopd505.fenrus.org>
Date: Mon, 09 Oct 2006 08:46:08 -0600
In-Reply-To: <1160379606.3000.195.camel@laptopd505.fenrus.org> (Arjan van de
	Ven's message of "Mon, 09 Oct 2006 09:40:05 +0200")
Message-ID: <m1y7rpr1hr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

>> > So yes, having software say "We want to steer this particular interrupt to 
>> > this L3 cache domain" sounds eminently sane.
>> >
>> > Having software specify which L1 cache domain it wants to pollute is 
>> > likely just crazy micro-management.
>> 
>> The current interrupt delivery abstraction in the kernel is a
>> set of cpus an interrupt can be delivered to.  Which seem sufficient
>> to the cause of aiming at a cache domain.  Frequently the lower
>> levels of interrupt delivery map this to a single cpu because of
>> hardware limitations but in certain cases we can honor a multiple cpu
>> request.
>> 
>> I believe the scheduler has knowledge about different locality domains
>> for NUMA and everything else.  So what is wanting on our side is some
>> architecture? work to do the broad steering by default.
>
>
> well normally this is the job of the userspace IRQ balancer to get
> right; the thing is undergoing a redesign right now to be smarter and
> deal better with dual/quad core, numa etc etc, but as a principle thing
> this is best done in userspace (simply because there's higher level
> information there, like "is this interrupt for a network device", so
> that policy can take that into account)

So far I have seen all of that higher level information in the kernel,
and it has to export it to user space for the user space daemon to
do anything about it.

The only time I have seen user space control being useful is when
there isn't a proper default policy so at least you can distribute
things between the cache domains properly.  So far I have been
more tempted to turn it off as it will routinely change which
NUMA node an irq is pointing at, which is not at all ideal
for performance, and I haven't seen a way (short of replacing it)
to tell the user space irq balancer that it got it's default policy
wrong.

It is quite possible I don't have the whole story, but so far it
just feels like we are making a questionable decision by pushing
things out to user space.  If nothing else it seems to make changes
more difficult in the irq handling infrastructure because we
have to maintain stable interfaces.  Things like per cpu counters
for every irq start to look really questionable when you scale
the system up in size.

Eric
