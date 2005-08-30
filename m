Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbVH3ErX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbVH3ErX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 00:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbVH3ErX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 00:47:23 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:7335 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932128AbVH3ErW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 00:47:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YMUxOsbWZQMJoFj9NMtXf7VUXoVyraDMDYVHbrd8t1Dlb6A3yqcSK9VkAhDqXdKvBvmIsJikQJsMxmIpmeSHXfMFE4f00xwXGDjD5S3GJ4e3VtReUfQvIZBM7v+0SB68z5Srsv3XDzOCABLdHHsv1m3fDXlZq7v+0KouYqX3E0w=
Message-ID: <9e4733910508292147556a4413@mail.gmail.com>
Date: Tue, 30 Aug 2005 00:47:21 -0400
From: Jon Smirl <jonsmirl@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Ignore disabled ROM resources at setup
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, helgehaf@aitel.hist.no
In-Reply-To: <Pine.LNX.4.58.0508291956210.3243@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508261859.j7QIxT0I016917@hera.kernel.org>
	 <1125369485.11949.27.camel@gaston>
	 <Pine.LNX.4.58.0508291956210.3243@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Tue, 30 Aug 2005, Benjamin Herrenschmidt wrote:
> >
> > pci_map_rom "sees" that the resource is unassigned by testing the parent
> > pointer, and calls pci_assign_resource() which, with this new patch,
> > will do nothing.
> 
> Ehh.. It didn't do anything with the old code either for that case, so
> there's apparently something else also going on.
> 
> It would write the base address, but since it wouldn't _enable_ the ROM
> mapping (only the "non-enabled" case changed by this commit), the end
> result from a hw standpoint should be exactly the same: the ROM isn't
> actually mapped.
> 
> So after pci_assign_resource(), the resource has literally been assigned,
> but that patch should not have mattered in any way whether it was actually
> _enabled_ or not.
> 
> Now, there's clearly a difference. What has always worked is then to do
> 
>         pci_write_config_dword(dev,
>                 PCI_ROM_ADDRESS,
>                 PCI_ROM_ADDRESS_ENABLE | res->start)
> 
> (well, these days you're supposed to use "pcibios_resource_to_bus()" to
> get the start value to write out).
> 
> Much preferable is probably to just enable the resource manually _before_
> calling pci_assign_resource, ie do something like.
> 
>         dev->resource[PCI_ROM_RESOURCE].flags |= IORESOURCE_ROM_ENABLE;
>         pci_assign_resource(dev, PCI_ROM_RESOURCE);
> 
> But yes, if something used to just blindly set PCI_ROM_ADDRESS_ENABLE,
> then that got broken. I grepped for that and didn't see anything like it,
> but I guess people are doing it with the magic constant "1"..

Nothing in the driver tree should be using PCI_ROM_ADDRESS_ENABLE
except drivers/pci/*. Drivers that are still manipulating ROMs
directly should be converted to use the PCI ROM API.

I started to fix these but some of the use is non-obvious. It is best
if the maintainers do it. These files are still directly manipulating
ROMs:

ide/pci/aec62xx.c
ide/pci/cmd64x.c
ide/pci/hpt34x.c
ide/pci/hpt366.c
ide/pci/pdc202xx_new.
ide/pci/pdc202xx_old.c
mtd/maps/pci.c
net/sungem.c
net/sunhme.c
scsi/qla2xxx/qla_init.c
video/console/sticore.c
video/matrox/matroxfb_misc.c
video/sis/sis_main.c

-- 
Jon Smirl
jonsmirl@gmail.com
