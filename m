Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265096AbTAJN3v>; Fri, 10 Jan 2003 08:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbTAJN3v>; Fri, 10 Jan 2003 08:29:51 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:10758 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S265096AbTAJN3t>; Fri, 10 Jan 2003 08:29:49 -0500
Date: Fri, 10 Jan 2003 16:35:03 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Grant Grundler <grundler@cup.hp.com>, Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
Message-ID: <20030110163503.A4486@jurassic.park.msu.ru>
References: <20030110021904.A15863@localhost.park.msu.ru> <Pine.LNX.4.44.0301091531260.1506-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0301091531260.1506-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jan 09, 2003 at 03:35:32PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 03:35:32PM -0800, Linus Torvalds wrote:
> 
> On Fri, 10 Jan 2003, Ivan Kokshaysky wrote:
> > 
> > PCI-PCI, PCI-ISA bridges - probably, but not host bridges. On x86 they
> > often have quite a few BARs, like AGP window, AGP MMIO, power management
> > etc., which we cannot ignore.
> 
> Oh, but we _can_ ignore it.
> 
> All those things are stuff that if the kernel doesn't use them, the kernel 
> doesn't even need to know they are there. 

It does - even if we don't use it, this stuff occupies regions in the bus
address space. If we ignore it we'll end up with incomplete resource
tree and pci_assign_resource() won't work anymore. Especially with AGP
aperture window, which tends to be large (32-128M), we'd have very good
chances to allocate a new resource (either by hotplug drivers or just
working around BIOS allocation bugs) in the middle of this window. Ouch.

> Sure, if we support AGP, we need to see the aperture size etc, but then 
> we'd have the AGP driver just do the "pci_enable_dev()" thing to work it 
> out.
> 
> The only real reason to worry about BAR sizing is really to do resource
> discovery in order to make sure that out bridges have sufficiently big
> windows for the IO regions. Agreed?

Yes, and as Grant already pointed out, to deal with overlapping (or just
incorrectly allocated) regions.

> And that should be a non-issue especially on a host bridge, since we 
> almost certainly don't want to reprogram the bridge windows there anyway.

[Hmm, on alpha we're doing that for years. :-)]
But even if we don't reprogram the bridge, we need to know about the
ranges that it decodes as we don't want to step on them accidentally.

> So I'd like to make the _default_ be to probe the minimal possible, 
> _especially_ for host bridges. Then, the PCI quirks could be used to 
> expand on that default.

I agree in general. Reasonable probing policy certainly is a good thing.
"Don't probe by default" would work wonderfully for PCI and ISA bridges -
I've yet to see one with normal BARs.
I'm just afraid that with the default "don't probe northbridges" we'll end
up with a lot more quirks than with "probe by default".

In either case, all of this can be trivially implemented on the top of
that patch. I'd suggest another pci_dev bit - "force_probe", to override
default policy:

static inline int default_probing_policy(struct pci_dev *dev)
{
	switch (dev->class >> 8) {
	case PCI_CLASS_BRIDGE_ISA:
	case PCI_CLASS_BRIDGE_EISA:
	case PCI_CLASS_BRIDGE_PCI:
		return 0;	/* Don't probe */
	case PCI_CLASS_BRIDGE_HOST:
		return ???
	default:
		return 1;	/* Do probe */
	}
}

static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
{
	...

	if (dev->skip_probe ||
	    (!dev->force_probe && !default_probing_policy(dev)))
		return;

	/* Disable I/O & memory decoding while we size the BARs. */
	pci_read_config_word(dev, PCI_COMMAND, &cmd);
	...

Ivan.
