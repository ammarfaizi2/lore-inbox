Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWFUBeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWFUBeh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWFUBeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:34:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:48079 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751921AbWFUBef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:34:35 -0400
Subject: Re: [PATCH 9/25] irq: Add a dynamic irq creation API
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       discuss@x86-64.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       Natalie Protasevich <Natalie.Protasevich@UNISYS.com>,
       Len Brown <len.brown@intel.com>,
       Kimball Murray <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Roland Dreier <rdreier@cisco.com>, Tony Luck <tony.luck@intel.com>
In-Reply-To: <m1veqvb9tr.fsf@ebiederm.dsl.xmission.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com>
	 <11508425183073-git-send-email-ebiederm@xmission.com>
	 <11508425191381-git-send-email-ebiederm@xmission.com>
	 <11508425192220-git-send-email-ebiederm@xmission.com>
	 <11508425191063-git-send-email-ebiederm@xmission.com>
	 <1150842520235-git-send-email-ebiederm@xmission.com>
	 <11508425201406-git-send-email-ebiederm@xmission.com>
	 <1150842520775-git-send-email-ebiederm@xmission.com>
	 <11508425213394-git-send-email-ebiederm@xmission.com>
	 <115084252131-git-send-email-ebiederm@xmission.com>
	 <1150847764.1901.64.camel@localhost.localdomain>
	 <m1veqvb9tr.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 11:33:03 +1000
Message-Id: <1150853583.12507.53.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Sure.  I know by the end of my patchset I have separated out hw numbers
> from the linux irq numbers, so this should work for powerpc.

Almost :) I have to look in more details but we have more nasty
issues...

Some of the things I need for powerpc is:

 - On Hypervisor machines, the firmware does it all... that is, it
allocates hardware vectors, enables the stuff on the device, etc etc...
all of it. The only step we might still add on top of it is mapping
those hw vectors to linux irq numbers. (Note that my new core stuff for
powerpc that I'll post has explcit mecanisms for doing just that ...
mapping hw interrupts/controller pairs to linux irq numbers)

 - We need control on what is in the irq_desc->chip and
irq_desc->chip->ops of MSIs. That should be filled by something in
msi_ops and not always set to the functions that muck with the config
space etc...  (same goes for affinity, no need for an msi_ops callback
for that, just let us set what is in the irq_desc->chip and possibly
provide "helpers" that do the config space way that intel can use
there). For all of these, on both the above (hypervisor), but also MPIC
based platforms like the G5 etc..., we need to use the normal IRQ ops of
the PIC for enable/disable/affinity, etc... 

 - msi_ops shall be per PCI bus. We can have completely different MSI
handling hardware on separate busses of a given machine. For example, an
Apple quad G5 has a register that triggers any source on the main MPIC
on the primary PCIe segment (the one used by the gfx card), and has a
completely separate HT2000 bridge on hypertransport that generates HT
interrupts.

Those are some of the basic requirements. Plus of course it has to fit
in what I'm currently coding of course :)

> I would love to hear feedback on it though.
> 
> So to be very clear what we mean, because I have gotten bitten in the
> past.  I understand the linux irq number to be:

> a) An index in the irq_desc array.

Yes.

> b) An enumeration of the hardware interrupts sources.

Hrm... 

> c) Human visible so ideally it is neither arbitrary, nor
>    very dynamic if the hardware is not.

Hrm...

I have neither b) nor c) nowadays on powerpc.... "linux" irq numbers are
purely a virtual thing, that is an index in irq_desc array and something
we give to drivers to do request_irq() from. They can map onto hw
interrupts, MSI-like messages, environment interrupts, could be
hypervisor messgaes, in fact, it could be anything that remotely looks
like an interrupt and the concept of "hw vector" is very blurry here...
every interrupt controller defines it's own hardware vector space. On
pSeries, hardware vectors are fairly big numbers that can encode the
geographical location of the slot where the device is connected to, on
some other hypervisor, they are 64 bits "tokens" representing an
hypervisor object that can send events, etc etc....

My remapper _tries_ to assign a linux irq number that is equal to the
hardware number whenever possible (because it's indeed nicer that way)
but there is no hard requirement nor anything like that here. I might
even add a hook to /proc/interrupt to be able to display the HW infos
for each interrupts.

> Then there is the destination cookie (vector on x86) that is
> available to the cpu when the interrupt is delivered.

Not sure what you mean by "destination cookie". I suppose you talk about
the hw vector. That is, whatever hardware (or hypervisor) number/object
represents a given interrupt source. I call that the hardware number.

> I think we are on a similar track but I'm not at all certain I like
> the idea of a fully dynamic linux irq number except in cases like MSI
> where your sources are dynamic.   But I may be making the wrong
> assumptions about what you are doing.

I'm doing a fully dynamic numbering. However, on a machine with a static
hardware setup (like a powermac with no MSIs), you'll always end up with
the same virtual numbers after boot and they'll happen to match the
hardware source numbers because I'm nice and my remapper "tries" to
allocate the same number if possible.

> I think implementations where we expose the hardware cookie instead
> of an enumeration of irq sources like ia64 does, impedes debugging
> because the irq number will be different between boots, or loads
> of the kernel module.  At the same time as long as we don't assume
> the irq number is the hardware cookie I don't see any maintenance
> problems with an implementation like that.

I'm not sure I understood completely your above sentence but if you mean
that doing full virtual makes debugging harder... well.. it might not
help _some_ classes of problem, but mostly it can be solved by having a
hook to display the HW infos on the same line in /proc/interrupts.

My remapper also reserved linux numbers 0...15 to map then 1:1 to legacy
interrupts when a 8259 is present in the machine and keeeps them
reserved (un-requestable) if not. That avoids tons of problems with
legacy drivers loading on machines like powermac with no legacy stuff. 

> What I do know is that on x86_64 the multiple levels of translation
> from the firmwares notion of the irq number to linux different
> notion of the irq number made the code overly complex and fragile.
> Which is one of the things I address in this patchset.

It was a bit dodgy on powerpc too, which is why I'm doing a nice layer
to handle it in a way that should be solid enough. A hardware number can
be anything in the context of a given controller (I call it "host", bad
name maybe, could be "domain" instead, it's a bit different than the
"chip" exposed by genirq because a given hw numbering domain may span
several chips on some archs and a given hw controller may use several
chip structures for different classes of interrupts). 

Essentially, when you "discover" an interrupt and needs to map it to a
linux interrupt (for example, when you discover a PCI device and need to
fill pci_dev->irq, or whatever else), you call irq_create_mapping(host,
hw_number, trigger). I also provide additional helpers that
automatically give you those 3 informations from the firmware for
various sort of devices, that sort of thing.

> But I would be happy to have a look, and I very much
> hope we can our implementations working together.

I'm trying to split the giant patch so I can post only the bit that adds
the new stuff :) Due to the way I work, I always first remove the old
stuff so that things don't build unless I've fixed them all but that
sucks for posting patch so I need ot do a bit of cleanup :)

Ben.


