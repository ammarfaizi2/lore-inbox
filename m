Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267997AbTAIWDo>; Thu, 9 Jan 2003 17:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268008AbTAIWDo>; Thu, 9 Jan 2003 17:03:44 -0500
Received: from [195.208.223.248] ([195.208.223.248]:7296 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267997AbTAIWDn>; Thu, 9 Jan 2003 17:03:43 -0500
Date: Fri, 10 Jan 2003 01:09:17 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Grant Grundler <grundler@cup.hp.com>, Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, davidm@hpl.hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com
Subject: Re: [patch 2.5] 2-pass PCI probing, generic part
Message-ID: <20030110010917.A693@localhost.park.msu.ru>
References: <1041942820.20658.2.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0301070942440.1913-100000@home.transmeta.com> <20030109204626.A2007@jurassic.park.msu.ru> <1042134735.522.19.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1042134735.522.19.camel@zion.wanadoo.fr>; from benh@kernel.crashing.org on Thu, Jan 09, 2003 at 06:52:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 06:52:15PM +0100, Benjamin Herrenschmidt wrote:
> Yes, On these, I'll skip the pci<->pci bridge in cases there is one on
> the path too, this will add some nasty logic to the pmac pci code, but
> that's ok as long as that crap doesn't leak out of
> arch/ppc/platforms/pmac_*

I don't see why it would add any extra logic to your pci code. You only
need to implement simple pmac-specific "FIXUP_EARLY" routine for I/O ASIC.
Something like this:

static void __init fixup_io_asic(struct pci_dev *asic)
{
	struct pci_dev *bridge;

	/* Set up asic->resource[] (using firmware info?) */
	...
	asic->skip_probe = 1;
	/* Also, don't probe parent bridge */
	bridge = asic->bus->self;
	if (bridge && (bridge->class >> 8) == PCI_CLASS_BRIDGE_PCI)
		bridge->skip_probe = 1;
}

And you've done with it.
Note that in most cases PCI-PCI bridges can be safely excluded from
pci_read_bases() simply because they have neither regular BARs nor
ROM BAR (even though PCI spec allows that).

Ivan.
