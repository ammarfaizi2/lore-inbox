Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVAEMQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVAEMQV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 07:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVAEMQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 07:16:21 -0500
Received: from alog0174.analogic.com ([208.224.220.189]:3968 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262356AbVAEMQI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 07:16:08 -0500
Date: Wed, 5 Jan 2005 07:06:24 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: David Vrabel <dvrabel@cantab.net>
cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, aryix <aryix@softhome.net>,
       lug-list@lugmen.org.ar, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: dmesg: PCI interrupts are no longer routed automatically.........
In-Reply-To: <41DBB5F6.6070801@cantab.net>
Message-ID: <Pine.LNX.4.61.0501050640430.12879@chaos.analogic.com>
References: <20041229095559.5ebfc4d4@sophia>  <1104862721.1846.49.camel@eeyore>
  <Pine.LNX.4.61.0501041342070.5445@chaos.analogic.com> <1104867678.1846.80.camel@eeyore>
 <Pine.LNX.4.61.0501041447420.5310@chaos.analogic.com> <41DBB5F6.6070801@cantab.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2005, David Vrabel wrote:

> linux-os wrote:
>> 
>> For instance,  Level interrupts from PLX chips on the PCI bus
>> can (read do) generate interrupts when some of the BARS are
>> being configured. Once you get an unhandled interrupt, you
>> are dead because there's nothing to reset the line.
>
> Why not unconditionally clear all interrupts after configuring the chip?
>
> David Vrabel
>

You can't configure the chip until the BARS are set up for
access. You _must_ know what the interrupt line is, before
you touch any registers so that any "waiting" interrupt
gets handled, i.e., cleared. Otherwise, the code that
inspects the PCI bus, looking for a device to claim, finds
the device, then (in order to make its IRQ correct) enables
it ... BAM that's all she wrote. No messages, no nothing,
a halted machine because the IRQ line is permanently TRUE
with no code in place to reset it.

The temporary work-around is....
 	pci_enable_device(pdev);
 	save_irq = pdev->irq;
 	pci_disable_device(pdev);	// Turn back off.

 	init_bars(....);
 	request_irq(save_irq,...)	// Put ISR in place

 	pci_write_config_byte(pdev, PCI_CACHE_LINE_SIZE, 0x08);
 	pci_write_config_byte(pdev, PCI_LATENCY_TIMER, 0x40);
 	pci_set_dma_mask(pdev, 0x00000000ffffffffULL);
 	pci_set_drvdata(pdev, NULL);
 	pci_set_power_state(pdev, 0);
 	pci_set_master(pdev);
 	pci_set_mwi(pdev);
 	pci_write_config_dword(pdev, PCI_COMMAND, PCI_CONFIG);

 	.... configure chip-specific stuff, clear interrupts, etc.
 	pci_enable_device(dev);


Now, the temporary work-around is a MACRO called ROUTE_IRQ().
If the guy who changed the PCI API adds a seperate callable
procedure to do this routing without actually enabling the
chip, I will substitute.

This work-round is a new Linux-2.6.10 bug-hack. It was never
required before

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
