Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbVAKBEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbVAKBEm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbVAKA7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:59:42 -0500
Received: from alog0183.analogic.com ([208.224.220.198]:6528 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262727AbVAJWGL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:06:11 -0500
Date: Mon, 10 Jan 2005 17:03:03 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
cc: David Vrabel <dvrabel@cantab.net>, aryix <aryix@softhome.net>,
       lug-list@lugmen.org.ar, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: dmesg: PCI interrupts are no longer routed automatically.........
In-Reply-To: <1105393108.29910.60.camel@eeyore>
Message-ID: <Pine.LNX.4.61.0501101646300.14001@chaos.analogic.com>
References: <20041229095559.5ebfc4d4@sophia>  <1104862721.1846.49.camel@eeyore>
  <Pine.LNX.4.61.0501041342070.5445@chaos.analogic.com>  <1104867678.1846.80.camel@eeyore>
  <Pine.LNX.4.61.0501041447420.5310@chaos.analogic.com>  <41DBB5F6.6070801@cantab.net>
  <Pine.LNX.4.61.0501050640430.12879@chaos.analogic.com>  <1104945236.4046.25.camel@eeyore>
  <Pine.LNX.4.61.0501051251140.9762@chaos.analogic.com> <1105393108.29910.60.camel@eeyore>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2005, Bjorn Helgaas wrote:

> On Wed, 2005-01-05 at 13:15 -0500, linux-os wrote:
>> The problem is that the PLX-9656BA INTCSR is not in configuration
>> space, but runtime registers off a BAR. The interrupt source
>> can be from a PLD that hasn't even had its microcode loaded
>> yet!
>>
>> FYI, the PLX or similar clone is the bus interface chip for many
>> busmastering PCI boards.
>>
>>> You wouldn't want your ISR mucking around with a half-initialized
>>> device, so does it have to check a "device_configured" flag
>>> or something?
>>
>> Yes. If the device isn't configured, the ISR reads all the INTCSR
>> bits, then writes 0 to the register to prevent anything else.
>
> The PLX might be a common device, but it sounds like this
> particular issue depends on the design of the rest of the
> board.  And presumably, nobody who cared about performance
> would design a board with this property, right?  I mean, to
> add a test in the ISR for a condition that exists only for
> a few milliseconds at driver startup-time seems sub-optimal.
>

I'm not so sure about that. There are many hardware registers
to be read in the ISR before the ISR can "decide" what it is
supposed to do. I'm not sure that the few hundred nanoseconds
required to read/test a variable is all the consequential.

What I do know is that the board must recover from all known
errors because you can't irradiate a patient with X-Rays and
then decide to throw away the data.

Also, like most bus-mastering devices, you only get an interrupt
to report something, basically one interrupt per transmitted
packet and one per received. There are a few diagnostic thing
that make more, but they are not common events. The 'packets'
are 10 megabytes in length so the interrupts are really hidden
in the noise. Even Ethernet drivers with their 1500 max byte
packets that use this interface chip should really check for
a "real" interrupt now that hot-swap is commonplace.

>> If the PLX had been reset, then the INTCSR bits would all
>> be masked off. However, reset is really only guaranteed from
>> power OFF on some motherboards, in particuar the ones with
>> so-called "hot-swap" capabilites fail. There is a software
>> reset that, in fact, even reloads its serial EEPROM. However,
>> the BAR needs to be accessible for this to be used.
>>
>> So it would be wonderful if the correct IRQ could be made
>> available before the chip could generate an interrupt.
>
> If we exposed a new pcibios_route_irq() (to hide the arch-
> specific nature of IRQ routing via ACPI or other information),
> could you do what you need in a pci_fixup_early quirk?
>

That would be wonderful. If you have a patch I will install
it immediately and change the content of my macro (the source-code
even compiles on 2.4.x so there are lots of macros).

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
