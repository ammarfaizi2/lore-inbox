Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbVAESUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbVAESUR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 13:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbVAESUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 13:20:17 -0500
Received: from alog0670.analogic.com ([208.224.223.207]:4480 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262538AbVAESSn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 13:18:43 -0500
Date: Wed, 5 Jan 2005 13:15:30 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
cc: David Vrabel <dvrabel@cantab.net>, aryix <aryix@softhome.net>,
       lug-list@lugmen.org.ar, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: dmesg: PCI interrupts are no longer routed automatically.........
In-Reply-To: <1104945236.4046.25.camel@eeyore>
Message-ID: <Pine.LNX.4.61.0501051251140.9762@chaos.analogic.com>
References: <20041229095559.5ebfc4d4@sophia>  <1104862721.1846.49.camel@eeyore>
  <Pine.LNX.4.61.0501041342070.5445@chaos.analogic.com>  <1104867678.1846.80.camel@eeyore>
  <Pine.LNX.4.61.0501041447420.5310@chaos.analogic.com>  <41DBB5F6.6070801@cantab.net>
  <Pine.LNX.4.61.0501050640430.12879@chaos.analogic.com> <1104945236.4046.25.camel@eeyore>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2005, Bjorn Helgaas wrote:

> On Wed, 2005-01-05 at 07:06 -0500, linux-os wrote:
>> The temporary work-around is....
>>  	pci_enable_device(pdev);
>>  	save_irq = pdev->irq;
>>  	pci_disable_device(pdev);	// Turn back off.
>>
>>  	init_bars(....);
>>  	request_irq(save_irq,...)	// Put ISR in place
>>
>>  	pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x08);
>>  	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0x40);
>>  	pci_set_dma_mask(pdev, 0x00000000ffffffffULL);
>>  	pci_set_drvdata(pdev, NULL);
>>  	pci_set_power_state(pdev, 0);
>>  	pci_set_master(pdev);
>>  	pci_set_mwi(pdev);
>>  	pci_write_config_dword(pdev, PCI_COMMAND, PCI_CONFIG);
>>
>>  	.... configure chip-specific stuff, clear interrupts, etc.
>>  	pci_enable_device(dev);
>
> So prior to 2.6.10, you did something like this?
>
> 	request_irq(pdev->irq, ...);
> 	pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x08);
> 	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0x40);
> 	...
> 	pci_enable_device(pdev);
>

Yes, exactly.

> What sort of interrupts does the device generate before it's
> enabled?  I can't find anything in the PCI spec that actually
> prohibits interrupts before the driver starts up the device,
> but it does seem strange.
>

The problem is that the PLX-9656BA INTCSR is not in configuration
space, but runtime registers off a BAR. The interrupt source
can be from a PLD that hasn't even had its microcode loaded
yet!

FYI, the PLX or similar clone is the bus interface chip for many
busmastering PCI boards.

> You wouldn't want your ISR mucking around with a half-initialized
> device, so does it have to check a "device_configured" flag
> or something?
>

Yes. If the device isn't configured, the ISR reads all the INTCSR
bits, then writes 0 to the register to prevent anything else.

If the PLX had been reset, then the INTCSR bits would all
be masked off. However, reset is really only guaranteed from
power OFF on some motherboards, in particuar the ones with
so-called "hot-swap" capabilites fail. There is a software
reset that, in fact, even reloads its serial EEPROM. However,
the BAR needs to be accessible for this to be used.

So it would be wonderful if the correct IRQ could be made
available before the chip could generate an interrupt.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
