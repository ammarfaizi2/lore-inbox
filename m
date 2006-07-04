Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWGDXMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWGDXMo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 19:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWGDXMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 19:12:44 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:44698 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S932325AbWGDXMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 19:12:43 -0400
Message-ID: <44AAF5D9.9040908@myri.com>
Date: Tue, 04 Jul 2006 19:12:25 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
CC: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/7] Check root chipset no_msi flag instead of all parent
 busses flags
References: <20060703003959.942374000@myri.com> <20060703004055.835863000@myri.com> <20060704070643.GA16632@colo.lackof.org>
In-Reply-To: <20060704070643.GA16632@colo.lackof.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> If the "root chipset" is not a PCI device and the architecture doesn't
> fake it, the root chipset (aka "PCI Host bus controller") is not visible
> to PCI subsystem. Some of the arch code (e.g. drivers/parisc/dino.c)
> uses "bus->self == NULL" to differentiate between PCI-PCI secondary busses
> and PCI bus below a "root chipset". ISTR alpha and sparc doing the same.
>
> Can you confirm I'm remembering/understanding this bit correctly?
>   

I am not familiar enough with these architectures, but I guess somebody
else is.

Are MSI working on these architectures? The MSI code in Linux seems to
be very specific so far. And CONFIG_PCI_MSI currently depends on
(X86_LOCAL_APIC && X86_IO_APIC) || IA64

>> pci_msi_supported() now checks the no_msi flag in the root_chipset pci_dev
>> struct instead of the PCI_BUS_FLAGS_NO_MSI flag of all its parent busses.
>> The MSI quirk now sets the no_msi flag accordingly.
>>     
>
> I don't see how this could work for alpha/parisc/sparc (IIRC) or any other
> architecture that doesn't create "fake" PCI Root busses.
> I think your previous patch was correct in this regard.
>   

I don't think it was better. I had the same loop to find the root
chipset. Only the check afterwards has been changed: instead of checking
the subordinate bus flags on the root chipset, I checks its no_msi. Both
patches applied to these architectures would fail to find the root
chipset in the while loop. They will find a bridge right under the root
chipset (or the device itself). The flags are then checked on the bridge
bus, not on the bus that is right under the root chipset.


Anyway, assuming that Linux supports MSI on any of these architectures
and that we find a root chipset that does not support MSI, how would we
blacklist it? There's no way to add a quirk if there is no pci_dev
associated to this root chipset, right?
Assuming we find a place to add some code to disable MSI
(pcibios_fixup_foo?), we would have to set a no_msi flag somewhere. It
might be good to revive the bus flags for this case. But, that's a lot
of "assuming", I'd rather know whether all this is possible first :)

Thanks,
Brice

