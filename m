Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966650AbWKOFPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966650AbWKOFPv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 00:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966651AbWKOFPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 00:15:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:15322 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S966650AbWKOFPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 00:15:50 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>, Komuro <komurojun-mbn@nifty.com>,
       tglx@linutronix.de, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use delayed disable mode of ioapic edge triggered interrupts
References: <Pine.LNX.4.64.0611080749090.3667@g5.osdl.org>
	<1162985578.8335.12.camel@localhost.localdomain>
	<Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	<20061108085235.GT4729@stusta.de>
	<7813413.118221162987983254.komurojun-mbn@nifty.com>
	<11940937.327381163162570124.komurojun-mbn@nifty.com>
	<Pine.LNX.4.64.0611130742440.22714@g5.osdl.org>
	<m13b8ns24j.fsf@ebiederm.dsl.xmission.com>
	<1163450677.7473.86.camel@earth>
	<m1bqnboxv5.fsf@ebiederm.dsl.xmission.com>
	<1163492040.28401.76.camel@earth>
	<Pine.LNX.4.64.0611140757040.31445@g5.osdl.org>
	<m18xidlxv7.fsf_-_@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0611141706300.3349@woody.osdl.org>
Date: Tue, 14 Nov 2006 22:14:39 -0700
In-Reply-To: <Pine.LNX.4.64.0611141706300.3349@woody.osdl.org> (Linus
	Torvalds's message of "Tue, 14 Nov 2006 17:17:53 -0800 (PST)")
Message-ID: <m17ixxjnpc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 14 Nov 2006, Eric W. Biederman wrote:
>> 
>> Hopefully this is the trivial patch that solves the problem.
>
> Ok, having looked more at this, I have to say that the whole 
> "IRQ_DELAYED_DISABLE" thing seems very fragile indeed.
>
> It looks like we should do it not only for APIC edge-triggered interrupts, 
> but for HT and MSI interrupts too, as far as I can tell (at least they 
> also use the "handle_edge_irq" routine)
>
> So I'm wondering how many other cases there are that are missing this.

I think it is a good question.

The big one I did not set it on is the interrupt if it comes in
through ExtInt.  I assume the 8259 is sane but I may be wrong.

> In that sense, Ingo's patch was a lot safer, although I still dislike it 
> for all the other reasons I mentioned - it's simply wrong to re-send a 
> level-triggered irq.
>
> I don't know MSI and HT interrupts well enough to tell whether they will 
> re-trigger on their own when we unmask them, but the point is, this 
> _looks_ like it might be incomplete.

Yes.   I think there is an interrupt status bit there.  
For at least one case in MSI we don't have a disable at all.

The truth is in practice I don't think it matters because I don't
think anyone actually disables MSI or hypertransport interrupts.

If it was going to change it would probably change per card.

But the real truth is that the hardware device knows what is going on.
The interrupt message is sent by the hardware device or it is not.
This isn't a case of can we detect an interrupt being raised by the
device while we disabled the interrupt at the device.  This is a
case of we disable the interrupt at the device.  So I think the whole
question of do we detect an interrupt raised by the device while
we have disabled interrupts on the device is silly.

So until I learn more I am going to assume that MSI and hypertransport
interrupts are sane like 8259 interrupts.  If that makes sense.

> I think part of the problem is a bad interface. We should simply never set 
> the IRQ handler on its own. It should be a field in the "irq_chip" 
> structure, and we should use _different_ irq chip structures for level and 
> edge-triggered. Then we should also add the "flags" thing there, and you 
> could do something like
>
> 	static struct irq_chip level_ioapic_chip = {
> 		..
>
> instead of making the insane decision to use the "same" chip for all 
> ioapic things.

I think there is probably a sensible case for a separate structure.

At this point I have two questions.
- What is the easiest path to get us to a stable 2.6.19 where
  everything works?

  I don't think that is backing out genirq.  But I haven't at all of
  these corner cases.

  I think for 2.6.19 we can get away with just my stupid patch, or
  some simple variation of it.

- What is the sanest thing for long term maintenance, of irqs?

  genirq is less code to maintain overall (a plus).
  genirq helps us do things across architectures, which is nice.
  genirq is also a little convoluted to read and to use a downside.

  My gut feel is that there is room for a lot more cleanup in this
  area but we probably need to stabilize what we have.

  Since you aren't complaining about what the code actually does but
  rather how the interface looks, I have a proposal.  I assert that
  the interface for registering an irq is much to general, and broad.


  Instead of having:

  irq_desc[irq].status |= IRQ_DELAYED_DISABLE;
  set_irq_chip_and_handler_name(irq, &ioapic_chip,
                                     handle_edge_irq, "edge");

  We should have a set of helper functions one for each common type
  of interrupt.

  set_irq_edge_lossy(irq, &ioapic_chip);
  set_irq_edge(irq, &ioapic_chip);
  set_irq_level(irq, &ioapic_chip);

  The more stupid parameters we have to set the more likely
  an implementor is to get it wrong.

  Although I do agree to some extent it has been a bit of a strain
  having both edge and level triggered interrupts with the same
  methods.  So if our goal is to make an even simpler interface
  than what we have now I will be happy.  Hopefully we can do all
  of this in helper functions instead of having to rip up all of
  the interrupt infrastructure one more time.

  I really don't know.  I'm tired and I want to see this code work.

Eric
