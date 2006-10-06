Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422751AbWJFRZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422751AbWJFRZP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422771AbWJFRZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:25:15 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13769 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1422751AbWJFRZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:25:13 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rajesh Shah <rajesh.shah@intel.com>, Andi Kleen <ak@muc.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Luck, Tony" <tony.luck@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@gmail.com>
Subject: Re: 2.6.19-rc1 genirq causes either boot hang or "do_IRQ: cannot handle IRQ -1"
References: <20061005212216.GA10912@rhun.haifa.ibm.com>
	<m11wpl328i.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0610060855220.3952@g5.osdl.org>
Date: Fri, 06 Oct 2006 11:22:44 -0600
In-Reply-To: <Pine.LNX.4.64.0610060855220.3952@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 6 Oct 2006 09:02:54 -0700 (PDT)")
Message-ID: <m1hcyh1hqz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 6 Oct 2006, Eric W. Biederman wrote:
>> 
>> The change the patch introduced was that we are now always
>> pointing irqs towards individual cpus, and not accepting an irq
>> if it comes into the wrong cpu.  
>
> I think we should just revert that thing. I don't think there is any real 
> reason to force irq's to specific cpu's: the vectors haven't been _that_ 
> problematic a resource, and being limited to just 200+ possible vectors 
> globally really hasn't been a real problem once we started giving out the 
> vectors more sanely.

Forcing irqs to specific cpus is not something this patch adds.  That
is the way the ioapic routes irqs.  There are certain rare circumstances
today with less than 8 cpus when cpu hotplug is not enabled that you can
route an irq at multiple cpus but they are rare, and rarely get used.

What this patch does is allows us to take advantage of the way the hardware
works.

The benefit comes when we start assigning irq numbers which we have been
artificially limiting to the number of vectors in the system.  Currently
on x86_64 we have two levels of irq number translation and compression just
to get the irq number to below 256, that code is fragile hard to understand,
hard to test, and hard to maintain.  This code you can test on practically
ever x86_64 box out there.

The other benefit is that in the form of MSI hardware devices now have their
own irq controllers.  Since those irqs don't have to go through individual
traces on the motherboard we can start expecting to see systems that can
take advantage of a lot more irqs.  On the bigger x86_64 systems today
we are just below the 224 vector limit on x86_64.  

> And the new code clearly causes problems, and it seems to limit our use of 
> irq's in fairly arbitrary ways. It also would seem to depend on the irq 
> routing being both sane and reliable, something I'm not sure we should 
> rely on.

Yes.  A single problem over several months of testing has been found.

I'm not magic I can't test all of the hardware out there, and hardware
invariably shows variation.  All I ask is a chance to root cause
this failure before we reject this code out of hand.

I have personally tested this on AMD and Intel small SMP systems as
well as arranging a little on a big Unisys machine with 64 or 128 processor
and tested it there.  The patches were simple and self contained
so people could use git bisect to find the problems. Plus the code has
been in -mm since about 2.6.18, since before kernel summit and OLS.  I
did all that I could personally think of to make certain this code
would work.  Is there something more I should have done?

As for the fairly arbitrary restrictions.  I assume you mean the
one irq per cpu thing.  This infrastructure of this patch does not
fundamentally have this limitation.  The per cpu 256 entry
vector_irq table would have no problem describing an irq that
could show up in one of several cpus simultaneously.  The vector
allocator currently doesn't support that because it seemed
pointless to implement an practically unused case. 

It probably makes sense to have some kind of spurious irq handler
instead of a bug if an irq comes in on the wrong irq.  I know I was
thinking about that at one time but for some reason I never got around
to it.  Even dropping the irq would likely have been better than
calling BUG, as the system would have booted.

I think I left the BUG there so that if there were problems in -mm.
The source of the problems would be immediately obvious, and I would
get a bug report.  But it never triggered so I completely forgot
the BUG was there.

> Also, I suspect the whole notion of only accepting an irq on one 
> particular CPU is fundamentally fragile. The irq delivery tends to be a 
> multi-phase process that we can't even _control_ from software (ie the irq 
> may be pending inside an APIC or a bridge chip or other system logic, so 
> things may be happening _while_ we possibly try to change the cpu 
> delivery).

So this is fairly fundamentally an irq migration problem.  If you
never change which cpu an irq is pointed at you don't have problems,
as there are no races.

I had a box going for several days just moving it's timer irq and
several others from one cpu to another about once a second, to prove
to myself I had fixed all of the bugs and this code as safe.

The current irq migration logic does everything in the irq handler
after an irq has been received so we can avoid various kinds of races.

For level triggered interrupts we disable the interrupt acknowledge
it, migrate it, and then enable it.

For edge triggered interrupts we disable the interrupt,
migrate it, reenable it and then acknowledge it (which
clears the local apics state and allows the irq to be
received again.

As far as I can tell the code is sane an works for good fundamental
reasons.  But it is the code that actually touches something
so I suspect it the most.

Eric

