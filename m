Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVADUJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVADUJr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 15:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVADUIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 15:08:21 -0500
Received: from alog0168.analogic.com ([208.224.220.183]:2432 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261855AbVADUD4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 15:03:56 -0500
Date: Tue, 4 Jan 2005 14:55:25 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
cc: aryix <aryix@softhome.net>, lug-list@lugmen.org.ar,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: dmesg: PCI interrupts are no longer routed automatically.........
In-Reply-To: <1104867678.1846.80.camel@eeyore>
Message-ID: <Pine.LNX.4.61.0501041447420.5310@chaos.analogic.com>
References: <20041229095559.5ebfc4d4@sophia>  <1104862721.1846.49.camel@eeyore>
  <Pine.LNX.4.61.0501041342070.5445@chaos.analogic.com> <1104867678.1846.80.camel@eeyore>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Jan 2005, Bjorn Helgaas wrote:

> On Tue, 2005-01-04 at 13:53 -0500, linux-os wrote:
>
>> I note that pci_enable_device() needs to be executed __before__
>> the IRQ is obtained on 2.6.10, otherwise you get the wrong IRQ
>> (IRQ10 on this system)B.
>
> Right.
>
>> This doesn't seem to be correct since the IRQ connection was set
>> by the BIOS and certainly shouldn't be changed. On this system,
>> interrupts that were not shared on 2.4.n and early 2.6.n end
>> up being shared... See IRQ18 below.
>
> It's not that we are changing the IRQ, it's just that we now
> do the ACPI routing at the time the driver claims the device,
> rather than doing all the ACPI routing at boot-time.  The
> old strategy messed with IRQs that might never be used (which
> broke some things), and also didn't work for hot-plug PCI
> root bridges.
>
> Back to my original question, do you have a device that
> only works when you use "pci=routeirq"?  If so, what is
> it and what driver does it use?
>
No.
I modified our drivers to accommodate the new scheme. The problem
is that I don't feel warm and fuzzy about enabling a device
__before__ an IRQ handler is in place to handle the IRQ.
For instance,  Level interrupts from PLX chips on the PCI bus
can (read do) generate interrupts when some of the BARS are
being configured. Once you get an unhandled interrupt, you
are dead because there's nothing to reset the line.

The new scheme requires that the device be enabled to get
the correct IRQ. If you did this work, maybe it would
be much better if you added a pci_set_irq() call instead
of combining your routing with enabling the device?

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
