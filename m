Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVH3DPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVH3DPX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 23:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVH3DPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 23:15:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2711 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932109AbVH3DPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 23:15:22 -0400
Date: Mon, 29 Aug 2005 20:15:04 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, helgehaf@aitel.hist.no
Subject: Re: Ignore disabled ROM resources at setup
In-Reply-To: <1125369485.11949.27.camel@gaston>
Message-ID: <Pine.LNX.4.58.0508291956210.3243@g5.osdl.org>
References: <200508261859.j7QIxT0I016917@hera.kernel.org> <1125369485.11949.27.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Aug 2005, Benjamin Herrenschmidt wrote:
> 
> pci_map_rom "sees" that the resource is unassigned by testing the parent
> pointer, and calls pci_assign_resource() which, with this new patch,
> will do nothing.

Ehh.. It didn't do anything with the old code either for that case, so 
there's apparently something else also going on.

It would write the base address, but since it wouldn't _enable_ the ROM
mapping (only the "non-enabled" case changed by this commit), the end
result from a hw standpoint should be exactly the same: the ROM isn't
actually mapped.

So after pci_assign_resource(), the resource has literally been assigned, 
but that patch should not have mattered in any way whether it was actually 
_enabled_ or not.

Now, there's clearly a difference. What has always worked is then to do

	pci_write_config_dword(dev,
		PCI_ROM_ADDRESS,
		PCI_ROM_ADDRESS_ENABLE | res->start)

(well, these days you're supposed to use "pcibios_resource_to_bus()" to
get the start value to write out).

Much preferable is probably to just enable the resource manually _before_
calling pci_assign_resource, ie do something like.

	dev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_ENABLE;
	pci_assign_resource(dev, PCI_ROM_RESOURCE);

But yes, if something used to just blindly set PCI_ROM_ADDRESS_ENABLE,
then that got broken. I grepped for that and didn't see anything like it,
but I guess people are doing it with the magic constant "1"..

I don't even find any access to "PCI_ROM_ADDRESS" in radeonfb, so I wonder
if it has ever worked? I get the feeling that if the ROM wasn't enabled,
it didn't work before either, but perhaps the change makes the failure
mode more spectacular?

			Linus
