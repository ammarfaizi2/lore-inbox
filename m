Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVDZQPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVDZQPM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVDZQMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:12:08 -0400
Received: from alog0566.analogic.com ([208.224.223.103]:19945 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261637AbVDZQJa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 12:09:30 -0400
Date: Tue, 26 Apr 2005 12:07:41 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Grant Grundler <grundler@parisc-linux.org>
cc: Alan Stern <stern@rowland.harvard.edu>, Alexander Nyberg <alexn@dsv.su.se>,
       Greg KH <greg@kroah.com>, Amit Gud <gud@eth.net>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       akpm@osdl.org, jgarzik@pobox.com, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [PATCH] PCI: Add pci shutdown ability
In-Reply-To: <20050426154149.GA2612@colo.lackof.org>
Message-ID: <Pine.LNX.4.61.0504261156470.15142@chaos.analogic.com>
References: <1114458325.983.17.camel@localhost.localdomain>
 <Pine.LNX.4.44L0.0504251609420.7408-100000@iolanthe.rowland.org>
 <20050426154149.GA2612@colo.lackof.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005, Grant Grundler wrote:

> On Mon, Apr 25, 2005 at 04:14:13PM -0400, Alan Stern wrote:
>>> Not sure what you mean by "make kexec work nicer" but if it is because
>>> some devices don't work after a kexec I have some objections.
>>
>> That was indeed the reason, at least in my case.  The newly-rebooted
>> kernel doesn't work too well when there are active devices, with no driver
>> loaded, doing DMA and issuing IRQs because they were never shut down.
>
> This is also a problem at "normal" boot time.  BIOS may leave devices
> still doing DMA if BIOS (or the arch equivalent) was using the device.
> This problem is obvious for systems with an IOMMU (e.g. parisc).
> See drivers/parisc/sba_iommu.c for an example of where I try to
> deal with active DMA at boot time *before* PCI bus walks have occurred.
> Masking IRQs is trivial in comparison to dealing with active DMA.
>
>>> What about the kexec-on-panic?
>
> Same problem - just much more likely to hit the issue and completely
> crash the box or corrupt memory.
>
> grant

DMAs don't go on "forever" and at the time they are started they
are doing DMA to or from memory that is "owned" by the user of
the DMA device. In order for DMAs to continue past that point,
there needs to be something that got notified of a previous
completion to start the next one that you state is erroneous.
If such an erroneous DMA is occurring, it can only occur as
as result of an interrupt and ISR that is still in-place to
reprogram and restart DMA on the interrupting device. Therefore,
all you need to do to quiet any such erroneous DMA operations,
if they are occurring at all, is to mask off the interrupts
on anything that hasn't been initialized yet.

The newer PCI code design has a built-in problem that you
can't find out the interrupt it will use until you enable
the device. This means that there is some possibility of
a race between getting that information and putting in a
ISR to quiet the device which may still be active because
it was used during the boot. It think this is the more
likely scenario than some DMA that is still active.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
