Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWGKT5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWGKT5T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWGKT5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:57:18 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:37042 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932112AbWGKT5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:57:17 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, Dave Olson <olson@unixfolk.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Initial generic hypertransport interrupt support.
References: <m1fyh9m7k6.fsf@ebiederm.dsl.xmission.com>
	<m1bqrxm6zm.fsf@ebiederm.dsl.xmission.com>
	<1152571162.1576.122.camel@localhost.localdomain>
	<m14pxolryw.fsf@ebiederm.dsl.xmission.com>
	<1152595205.6346.26.camel@localhost.localdomain>
	<m1veq4iri1.fsf@ebiederm.dsl.xmission.com>
	<9ABD3384-5829-4365-988C-43310D374CE5@kernel.crashing.org>
	<m18xn0h99q.fsf@ebiederm.dsl.xmission.com>
	<1152609347.6346.38.camel@localhost.localdomain>
Date: Tue, 11 Jul 2006 13:56:26 -0600
In-Reply-To: <1152609347.6346.38.camel@localhost.localdomain> (Benjamin
	Herrenschmidt's message of "Tue, 11 Jul 2006 19:15:46 +1000")
Message-ID: <m1irm3gbkl.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

>> Examples? details? patches?
>> 
>> Part of the problem with plain MSI is that you can't mask irqs at the
>> source, in a generic way.
>
> This is an interesting point, because this shows precisely the different
> of approach between most HW PPC implementations vs what x86 does and
> what the current code does...
>
> Our MSIs are always routed as just additional sources to an existing IRQ
> controller that will itself then handle things like masking, affinity,
> etc...

Interesting.  In the short term I can see how that is a sane design.
In the long term that appears to require more hardware and be a
bottle neck on the number of irqs you can have so I don't expect
the current ppc model to be the long term one.  

Does the current ppc model give hypervisors more control then they
would get without going through an existing interrupt controller?

> Thus, we don't need nor want any kind of generic MSI code setting up an
> irq_chip with enable/disable functions etc... Those should stay the ones
> from the system's main PIC, maybe a different version of them, but
> that's up to the system PIC to set that up.

For the hypertransport case I have coded it this way and I think there
are good general cleanliness arguments for making this change to x86 as
well.  I think doing so actually winds up being less code.

> That's one of the reason why I think we need to work the MSI arch side
> API such that the MSI "controller" is the one to setup the irq_desc. The
> "generic" mask/unmask/etc... using the MSI(X) config space can be
> provided as optional helpers but it should be under arch, or more
> specifically MSI controller control to pick up how to setup the irq_desc
> and its associated irq_chip.
>
> Another one is the fact that we have multiple different MSI mecanisms on
> the same machines (like the Apple Quad G5 which have on one side an MSI
> "register" that devices write to and that triggers sources on the MPIC,
> and on the other side, HT interrupts which can be generated from MSIs by
> the broadcom HT<->PCIe bridge). Thus that msi_ops stucture I've seen
> around shall really be per PCI host bridge at the very least. One
> propsal I have, but I didn't have time to actually implement it, was to
> have the msi_ops pointer be a field in pci_bus that is inherited by
> default. That is, the arch can call pci_set_msi_ops() on a given bus and
> this will propagate to childs.


So to be very concise what I did on the HT side is that I have a function:
arch_setup_ht_irq(struct pci_dev, int irq).
That is used by the arch code to setup the irq_chip handler and the rest.

There are helper functions:
void write_ht_irq_low(unsigned int irq, u32 data);
void write_ht_irq_high(unsigned int irq, u32 data);
u32 read_ht_irq_low(unsigned int irq);
u32 read_ht_irq_high(unsigned int irq);

That read and write the individual hypertransport irq routing values per irq.

I suspect this is the right general direction to move the msi code to.

The combination allows an architecture to take bus specific details into
an account, and have it's own irq handler methods.  At the same time
it is still the generic infrastructure controlling access to the
chip registers.

So I honest expect things like msi_ops to become an arch specific detail.
At the very least I think it is too early to start generalizing that way
if we really don't need to.

Eric
