Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbULMRQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbULMRQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 12:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbULMRQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 12:16:51 -0500
Received: from alog0513.analogic.com ([208.224.223.50]:2176 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261288AbULMRNC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 12:13:02 -0500
Date: Mon, 13 Dec 2004 12:08:29 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
cc: Dimitris Lampridis <labis@mhl.tuc.gr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI interrupt lost
In-Reply-To: <Pine.LNX.4.61.0412130755290.22212@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.61.0412131141480.4429@chaos.analogic.com>
References: <1102941933.3415.14.camel@naousa.mhl.tuc.gr>
 <Pine.LNX.4.61.0412130755290.22212@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2004, Zwane Mwaikambo wrote:

> On Mon, 13 Dec 2004, Dimitris Lampridis wrote:
>
>> I'm writing a device driver for an embedded USB controller (philips
>> ISP116x). I'm using the evaluation board provided by philips for my
>> work. This board is a PCI board featuring the Host Controller ISP1160
>> and a PCI bridge by PLX.
>>
>> The bad news (for me) is that I don't get to see any interrupts from my
>> device.
>>
>> The good news is that I've managed to narrow down the problem. Here is
>> my case:
>> 1) The Host Controller is configured and operating and is producing
>> interrupts (I used a logic Analyzer and saw it happening).
>> 2) The driver never services these interrupts. The exact behaviour is
>> dictated by the "trigger" setting of the INT pin. If it is
>> edge-triggered, the interrupts keep on coming from the HC. If it is
>> level-triggered, only one interrupt happens and since it is never
>> serviced, it keeps on forever, blocking any further signals.
>> 3) The driver IS ABLE to service interrupts. The ISR is installed and
>> functioning (I was able to see that, when the device was sharing the IRQ
>> and the ISR was called only to return IRQ_NONE, nevertheless showing
>> that IF an interrupt was to be received, coming from the Host
>> Controller, the routine would be called, thus clearing the interrupt on
>> the controller).
>>
>> So, to make things short, my device is generating interrupts, my code
>> has a functioning and registered interrupt routine (/proc/interrupts
>> agrees as well but interrupt count is 0 for the specific IRQ), but no
>> interrupt is ever received from the PCI card.
>
> What does the PCI device report as the interrupt line? What do you
> register with request_irq?
>
> 	Zwane
>
> Ps. Isn't there already a driver for that controller?
>

Also, PCI interrupts __must__ be level. It's in the PCI specification.
If this IRQ level is raised, the kernel will call the registered 
interrupts. It has no choice and if it didn't work nobody would
be able to boot. The only  possibility is that somebody else is
using the interrupt and hasn't allocated it shared, or your
code has bug(s).

Also, returning IRQ_NONE will force your ISR to be called repeatedly
until the kernel is forced to shut off the ISR. It should return
IRQ_DONE. You need to allocate the interrupt specified in the
"dev" structure and not attempt to out-think anything. You should
never even care what the raw configuration settings are. If your
code looks at that stuff, it's broken.

     struct pci_dev *pdev;
     pdev = PCI_FIND_DEVICE(PCI_ID, PCI_DEV, pdev);

     // use ioremap_nocache() for BARS.

     request_irq(pdev->irq, my_isr, SA_INTERRUPT|SA_SHIRQ, "device", 
pointer_to_your_stuff);
     pci_set_drvdata(pdev, NULL);	// Not necessary
     pci_set_power_state(pdev, 0);	// Now mandatory
     pci_set_master(pdev);		// PLX is a master
     pci_set_dma_mask(pdev, 0xffffffffULL);	// Future needs on ix86
     pci_set_mwi(pdev);			// If you want
     pci_enable_device(pdev);		// Remember to do this


This __will__ initialize the PLX chip, but you still have to
set/unmask its interrupt registers to get an interrupt.

Both the PLX chip and the kernel code will properly handle an
interrupt. We use these extensively here, so it's just some
bug(s) in your code.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
