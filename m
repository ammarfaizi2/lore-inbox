Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWJEWqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWJEWqH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 18:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbWJEWqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 18:46:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51389 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751350AbWJEWqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 18:46:04 -0400
Date: Thu, 5 Oct 2006 15:45:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes
In-Reply-To: <452564B9.4010209@garzik.org>
Message-ID: <Pine.LNX.4.64.0610051536590.3952@g5.osdl.org>
References: <200610051910.25418.ak@suse.de> <200610051953.23510.ak@suse.de>
 <45255D34.804@garzik.org> <200610052142.29692.ak@suse.de> <452564B9.4010209@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Oct 2006, Jeff Garzik wrote:

> Andi Kleen wrote:
> > If the choice is between a secret NDA only card with dubious
> > functionality and booting on lots of modern boards I know what to choose.
> 
> That's a strawman argument.  There is no need to choose.  You can clearly boot
> on lots of modern boards with mmconfig just fine.  We just need to narrow down
> which ones.

Jeff, _that_ is the strawman argument.

The thing is, nobody has been able to so far come up with a way to narrow 
down which ones.

I think Andi's response was quite on the mark: if you have a patch to 
narrow it down, please share. Until then, the fact is, we don't know 
_how_, and you're barking up the wrong tree.

It is entirely possible that the only reasonable solution is to 
potentially _never_ use MMIO as the main config mechanism (where "never" 
is "in the next few years" - at some point we may be able to just say 
"screw it, we don't care any more"), and that the drivers that want to use 
MMIO for config accesses will have to use special operations for that.

In other words, right now we have

	int pci_read_config_byte(struct pci_dev *dev, int where, u8 *val)

and maybe we will simply have to add a totally new function like

	int pci_read_mmio_config_byte(struct pci_dev *dev, int where, u8 *val)

for drivers that literally _require_ the mmio accesses for one reason or 
another.

Alternatively, we could just have a "ioremap()" kind of thing, and use 
readl/writel on the end result, ie maybe we could do

	void __iomem *cfg = mmiocfg_remap(dev);

	if (!cfg) {
		printk("MMIO PCI configuration cycles not supported\n");
		return -EIO;
	}

	/* Read the extended error register or some-such crud.. */
	val = readl(cfg + 0x180);
	..

See?  The thign is, at least right now the _advantages_ of MMIOCFG are 
basically zero for all regular hardware, and as such the disadvantages (in 
the form of machines that hang on device discovery) are way way _way_ 
bigger, and no way will do start using MMIO config cycles by default just 
because some unreleased hardware might want to.

But using them explicitly in drivers - that's another thing.

What do you think about this simple solution?

		Linus
