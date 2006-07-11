Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWGKWTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWGKWTa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWGKWTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:19:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:24775 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932199AbWGKWT3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:19:29 -0400
Subject: Re: [PATCH 2/2] Initial generic hypertransport interrupt support.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, Dave Olson <olson@unixfolk.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <m1irm3gbkl.fsf@ebiederm.dsl.xmission.com>
References: <m1fyh9m7k6.fsf@ebiederm.dsl.xmission.com>
	 <m1bqrxm6zm.fsf@ebiederm.dsl.xmission.com>
	 <1152571162.1576.122.camel@localhost.localdomain>
	 <m14pxolryw.fsf@ebiederm.dsl.xmission.com>
	 <1152595205.6346.26.camel@localhost.localdomain>
	 <m1veq4iri1.fsf@ebiederm.dsl.xmission.com>
	 <9ABD3384-5829-4365-988C-43310D374CE5@kernel.crashing.org>
	 <m18xn0h99q.fsf@ebiederm.dsl.xmission.com>
	 <1152609347.6346.38.camel@localhost.localdomain>
	 <m1irm3gbkl.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 08:18:59 +1000
Message-Id: <1152656339.6346.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 13:56 -0600, Eric W. Biederman wrote:

> Interesting.  In the short term I can see how that is a sane design.
> In the long term that appears to require more hardware and be a
> bottle neck on the number of irqs you can have so I don't expect
> the current ppc model to be the long term one.  
> 
> Does the current ppc model give hypervisors more control then they
> would get without going through an existing interrupt controller?

Well, it's actually fairly scalable as the interrupt "controller" itself
isn't a always single chip design. For example, on pSeries, there are
interrupt "source" controllers scattered around the fabric, in the PCI
bridges that connect to LSI IRQs and are recipients of MSIs as well. All
of these then send the actual interrupt events as messages to one or
more "presentation" controller(s) attached to the CPUs. The protocol
between those is not visible to the operating system.

One of the reasons the above is especially interesting is that MSI don't
have to travel all the way through the fabric via the mormal bus
protocols. Which means that they potentially lose ordering vs. normal
transactions passed the first or second level of PCI bridges. But that
"ordering" of MSIs has always been a bit dodgy anyway, since it's really
fully enforceable if your MSI recipient is also your toplevel bridge,
which simply can't always be the case. At least you get a guarantee at
the device level. 

Regarding hypervisors, on pSeries, the whole thing is completely
abstracted (including the interrupt presentation controller). Basically,
the HV assigns MSIs or MSI-X to devices and tells you how much it did
and what "vectors" at the toplevel controller were assigned to a given
device. You have some calls to disable them or try to change the amount
of assigned MSIs but that's it. HV is the one doing the config space
stuff, enabling MSIs, choosing vector numbers, etc...We just use HV/RTAS
calls to mask/unmask/set-affinity of a given interrupts wether it's an
MSI or an LSI


.../...

> The combination allows an architecture to take bus specific details
into
> an account, and have it's own irq handler methods.  At the same time
> it is still the generic infrastructure controlling access to the
> chip registers.
> 

Well, on HV machinesm we can't even use that infrastructure since we
aren't supposed to write to the chip registers even. That's why we have
that very preliminary patch that allows powerpc, for now, to just hook
at the toplevel of the implementation (re-implement pci_enable_msi()
basically) so we can handle the HV case. But, we still have to find a
way to have a given kernel handle both "more classical" MSI setups
(where we have to program the chip config space & assign vectors
ourselves) and the "hypervisor" scheme. 

On PowerMac, and other machines using the Apple U4 / IBM CPC945 bridge,
things are a bit different. On those, the MSIs coming from the PCIe
segment land into a register that simply turns stores it receives into
triggers of a line of the MPIC interrupt controller in that bridge (that
value stored is the line number). But that register, for some stupid
reasons, doesn't work when accessed from the HyperTransport link (it has
a wrong endian on it). So for MSIs on devices on HT<->PCIe tunnels, we
need to use whatever facilities are provided by those tunnels to turn
them into HT interrupts. Appart from that, HT interrupts are treated the
same way: there is a "magic" register in the bridge that turns them into
sources for the MPIC. 

So the later is more "classical", though it still doesn't fit the
IO-APIC model where you need to mask/unmask at the controller level.

But there is some more weird hardware in the ppc world. Some stuffs I'm
not sure I can talk about much but who handles MSIs but storing the
messages in a hardware FIFO and sending one upstream interrupt when
there is something in there. That hardware can't mask/unmask a given MSI
so manipulating the config space to do so (with MSI-X at least) might
makes sense (though MSIs being naturally "edge" messages, one can always
just drop them and use the retrigger mecanism of genirq to mask them,
might be more efficient than masking at the device... depends how likely
it is to actually take an MSI while "masked").

> So I honest expect things like msi_ops to become an arch specific detail.
> At the very least I think it is too early to start generalizing that way
> if we really don't need to.



