Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263944AbUFFSWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbUFFSWO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 14:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbUFFSWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 14:22:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30403 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263944AbUFFSWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 14:22:09 -0400
Message-ID: <40C360C4.7010703@pobox.com>
Date: Sun, 06 Jun 2004 14:21:56 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: ktech@wanadoo.es, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: 2.6.7-rc1 breaks forcedeth
References: <E1BWmws-0005aN-Nw@mb04.in.mad.eresmas.com> <Pine.LNX.4.58.0406051958150.7010@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0406051958150.7010@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> The thing is, the driver seems to not actually even register the irq 
> handler until the device is opened, which seems a bit bogus. It will 

That's normal.  The net driver model is:

Probe phase (struct pci_driver::probe):
* make sure device isn't actively sending irqs or DMA'ing
* read MAC address from EEPROM
* put device in low power state (D3 is acceptable)

Interface-up (dev->open):
* power-up device
* allocate consistent DMA memory
* request_irq
* activate DMA engine
* activate link state machine (hardware or software)

Interface-down (dev->stop):
* reverse the interface-up steps

So by definition it is a driver bug if the hardware is sending irqs 
outside of when the driver indicates interest in the irq via 
request_irq...free_irq.

This is very nice because the sysadmin knows the device is inactive when 
the interface is down, providing a clear and clean correlation between 
interface state and hardware state.

In a _very few_ situations, it is impossible to do this because the 
hardware (or virtual hardware, such as ppc64 hypervisor or s/390) sends 
interesting (or necessary) events while the interface is down.


> certainly result in problems if the device ever sends an interrupt. And 
> that seems to be exactly the behaviour you see.
> 
> I suspect that the driver should at the very least make sure to disable
> any potentially pending interrupts in the "nv_probe()" function. I have no 
> idea how to do that, but it looks like something like
> 
> 	writel(0, base + NvRegIrqMask);
> 	writel(NVREG_IRQSTAT_MASK, base + NvRegIrqStatus);


Agreed; this naturally falls out of the above "Probe phase" description, 
in a properly written driver.

Also, PCI 2.3 devices have an "interrupt disable" bit in PCI_COMMAND 
they can use, iff (a) it's implemented and (b) the driver isn't using MSI.

	Jeff


