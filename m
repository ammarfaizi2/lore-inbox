Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbUKOGAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbUKOGAe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 01:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbUKOGAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 01:00:34 -0500
Received: from colo.lackof.org ([198.49.126.79]:13723 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261489AbUKOGAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 01:00:24 -0500
Date: Sun, 14 Nov 2004 23:00:21 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Andi Kleen <ak@suse.de>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Michael Chan <mchan@broadcom.com>, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, akpm@osdl.org, greg@kroah.com,
       "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Subject: Re: [PATCH] pci-mmconfig fix for 2.6.9
Message-ID: <20041115060021.GA3302@colo.lackof.org>
References: <B1508D50A0692F42B217C22C02D849720312DED3@NT-IRVA-0741.brcm.ad.broadcom.com> <20041113194634.GC3023@colo.lackof.org> <20041114085831.GF16795@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041114085831.GF16795@wotan.suse.de>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 09:58:31AM +0100, Andi Kleen wrote:
> > Other chipsets can implement postable config space. To be compliant
> > with the ECN, the architecture must define a method to guarantee
> > the posted writes have reached the target device. I think the
> > ECN we've been talking about assumes that method will be implemented
> > in firmware somehow and NOT as a direct access method in the OS.
> 
> Hmm, but there is no way for the chipset to tell us that this 
> is needed. 

Why not?
Can't we just "know" if specific chipsets implement posted
mmconfig writes or not?

Intel folks have confirmed their chipsets to date implement
non-postable mmconfig writes.


> Perhaps we really need to special case this and add posted pci config
> writes to handle Michael's power management issue properly. 
> That would be definitely the safer approach.

hrm...are you suggesting another entry point in the struct raw_pci_ops?

There are two tests in arch/i386/pci/mmconfig.c:pci_mmcfg_init() before
the raw_pci_ops is set to &pci_mmcfg. Perhaps some additional crude tests
could select a different set of pci_raw_ops to deal with posted writes
to mmconfig space. Someone more familiar with those chipsets might
find a more elegant solution.

> > That means someone has to introduce a new method to access
> > mmconfig if they implement postable writes.
> 
> 
> Problem is that it adds silently a very subtle bug and there
> is no way I know of for ACPI to tell the firmware it shouldn't use
> posting.

Uhm, ACPI needs to tell the firmware?
I would expect firmware to be platform/chip specific and "just know".

If you meant OS, we already embed knowledge about specific chipsets
for bug workarounds (e.g. tg3 driver). I think that's an option here too.
I mean tweaking mmconfig.c to install a (possibly) chip specific
method (raw_pci_ops) to flush posted mmconfig writes.

>  The driver should know when the read is forbidden though.

Yeah, I would expect it to also. But I certainly don't expect
it to know how to flush a posted write with anything but a
config read.

If the chipset that implemented posted mmconfig writes is compliant
with the ECN we've been talking about, then there must be some other
method to guarantee the writes reaches the device. I would expect
another raw_pci_ops method to be able to deal with it but can't
promise that's true for every chipset out there.

grant
