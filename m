Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVAMMuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVAMMuX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 07:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVAMMuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 07:50:23 -0500
Received: from alog0356.analogic.com ([208.224.222.132]:3200 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261609AbVAMMuL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 07:50:11 -0500
Date: Thu, 13 Jan 2005 07:49:44 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Dimitris Lampridis <soth@softhome.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI lost interrupts and PLX chips
In-Reply-To: <1105617881.3203.4.camel@localhost>
Message-ID: <Pine.LNX.4.61.0501130728520.10535@chaos.analogic.com>
References: <1105573129.3218.11.camel@localhost> 
 <Pine.LNX.4.61.0501130647420.10398@chaos.analogic.com> <1105617881.3203.4.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2005, Dimitris Lampridis wrote:

> On Thu, 2005-01-13 at 13:49, linux-os wrote:
>> On Thu, 13 Jan 2005, Dimitris Lampridis wrote:
>>
>>> Hi everybody,
>>> I noticed a conversation some days ago that also mentioned something
>>> about PLX chips and a certain problem resulting in loss of interrupt
>>> signals.
>>>
>>> I'm writing a driver for a PCI-based device (an embedded USB Host
>>> Controller) and it uses a PLX bridge (device ID 5406). Although I've set
>>> up the device correctly and a logical analyzer shows the interrupts
>>> being generated on the USB HC chip, nothing comes past the bridge, thus
>>> nothing reaches the system. I use a typical pci_enable_device() followed
>>> but some request_region() and of course request_irq() on a kernel
>>> 2.6.10-rc3 (i386 system, VIA KT133, no APIC...)
>>> Does this have something to do with the discussion about PLX chips
>>> mentioned above? If it does, can anybody make clear what I have to do to
>>> see those interrupts coming?
>>>
>>> You can find the mail in question at:
>>> http://seclists.org/lists/linux-kernel/2005/Jan/0792.html
>>>
>>> Thanks,
>>> Dimitris
>>
>> Make sure you execute pci_enable_device() __before__ you believe
>> the IRQ number in the structure.
>
> I was doing that all the time. I'm calling pci_enable_device(pdev), then
> reading pdev->irq, then calling request_irq(pdev->irq,...). But I don't
> get interrupts. Is it possible for the compiler to rearrange the order
> of execution?

No! Not that much! A sequence-point like the ';' after the first call
will guarantee that everything up to that point was executed. Make
sure you requested a level interrupt, i.e. SA_INTERRUPT|SA_SHIRQ.

> I was talking about that strange phenonomenon you were saying with PLX
> and interrupts going mad when initializing the device, ie the trick with
> enable->disable->do whatever(this is where I need help if it applies to
> me)->reenable.
>

You can look at /proc/interrupts to see if your device ever interrupted.
If it did, then got shut off, you probably forgot to return IRQ_HANDLED
in the interrupt-service-routine. The newer code requires a return-value
from the ISR.

If it got a bunch of spurious interrupts that made it impossible
to initialize the device properly, then use some flag to tell
your ISR that the device wasn't enabled yet. If it got an interrupt
before the device was enabled, the ISR writes 0 to the PLX CSR after
reading and throwing away the existing value. That will quiet the
device until it can be properly initialized.

If you never got any interrupts, then you have some other bug.
You can readily force the PLX to generate interrupts for testing
purposes.

> Thanks,
> Dimitris
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
