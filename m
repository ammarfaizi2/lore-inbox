Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbSLTQ4c>; Fri, 20 Dec 2002 11:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262796AbSLTQ4c>; Fri, 20 Dec 2002 11:56:32 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32017 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262662AbSLTQ4b>; Fri, 20 Dec 2002 11:56:31 -0500
Date: Fri, 20 Dec 2002 09:05:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: davidm@hpl.hp.com
cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.x disable BAR when sizing
In-Reply-To: <15874.58889.846488.868570@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0212200849090.2035-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Fri, 20 Dec 2002, David Mosberger wrote:
>
> Could you please stop this ia64 paranoia and instead explain to me why
> it's OK to relocate a PCI device to (0x100000000-PCI_dev_size)
> temporarily?  That just seems horribly unsafe to me.

No. It's not horribly unsafe at all. It's very safe, for one simple
reason: it's how PCI probing has _always_ been done. Exactly because the
alternatives simply do not work.

I can also tell you why it does work, and why it's supposed to work: by
writing 0xffffffff to the BAR register, you basically move the BAR to high
PCI memory - even if it was enabled before. Which is fine, as long as
nobody else is in that high memory. So the secondary rule to "don't turn
off MEM or IO accesses" is "never allocate real PCI BAR resources at the
top of memory".

Think about it: if you move the BAR to high memory, you basically disable
only _that_ bar, and nothing else. You don't clobber any other associated
functions, or anything like that. It's clearly a _less_ disruptive thing
than disabling access to the whole device.

Anyway, why do you really want to add the MEM/IO disable? Do you actually
have a device that wants it, or are you just blinded by documentation
written by somebody who had no idea about what real life is all about?

>							  The PCI spec
> seems to say the same as it says pretty clearly that memory decoding
> should be disabled during BAR-sizing.  If certain bridges cause
> problems, perhaps those need to be special-cased?

No. Do it the other way around: if there is some specific chipset that
actually _needs_ the disable, you do THAT special cased.

Because the current code works on everything that we know about, and we
_know_ that the disable doesn't work. As Ivan already pointed out, it's
not just bridges. When you disable IO/MEM accesses, you often disable
_everything_, which can break pretty much anything.

(I say "often", because it does actually depend on the chipset. Some chips
only seem to disable the BAR entries. Others disable all the "extended"
ports too, and leave only config space accessible after you've disable
IO/MEM)

The cases I've seen are northbridges that stop forwarding DMA, and USB
controllers that are still in legacy mode (because the BAR probing happens
before the USB driver has had a chance to _change_ it), where disabling IO
and/or MEM will cause the SMM code that does the legacy handling to just
lock up, since suddenly the hardware they expect to be there doesn't
respond any more.

Ivan pointed out that it also disables things like VGA legacy registers.

It will disable IDE legacy registers too, btw. I'd also expect it to
disable IDE DMA access, so if you happen to be trying to probe the BAR's
after somebody started IO on the IDE, you just made that IO fail
spectacularly, and I'd not be surprised if the IDE controller just locked
up as a result.

Let me re-iterate the "turn power off at the master switch in a house when
switching a light bulb" analogy. Yes, it's a good idea if you are nervous,
but you do that only when you _know_ who is in the house and you know what
they are doing and it's ok by them.

For example, it would be fine for a low-level driver (who has already
taken control of the device) to turn the device off. But it is NOT fine to
do it in general.

One solution in the long term may be to not even probe the BAR's at all in
generic code, and only do it in the pci_enable_dev() stuff. That way it
would literally only be done by the driver, who can hopefully make sure
that the device is ok with it.

		Linus

