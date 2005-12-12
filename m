Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbVLLUOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbVLLUOX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbVLLUOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:14:23 -0500
Received: from spirit.analogic.com ([204.178.40.4]:59666 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932201AbVLLUOV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:14:21 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <356942780@web.de>
X-OriginalArrivalTime: 12 Dec 2005 20:14:20.0566 (UTC) FILETIME=[A2EE5360:01C5FF58]
Content-class: urn:content-classes:message
Subject: Re: Strange delay on PCI-DMA-transfer completion by wait_event_interruptible()
Date: Mon, 12 Dec 2005 15:14:20 -0500
Message-ID: <Pine.LNX.4.61.0512121501340.4578@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Strange delay on PCI-DMA-transfer completion by wait_event_interruptible()
Thread-Index: AcX/WKL183GkZ9DySP+dLvVui+CKHg==
References: <356942780@web.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: =?iso-8859-1?Q?Burkhard_Sch=F6lpen?= <bschoelpen@web.de>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Dec 2005, [iso-8859-1] Burkhard Schölpen wrote:

> Hi all,
>
> I'm trying to write a driver for a custom PCI-Board which is DMA-Busmaster capable (kernel 2.6.13 with SMP). Unfortunately I get some strange delay between the start of the transfer until the interrupt appears, which signals its completion.
>
> Concerning a dma transfer from RAM to the pci device, my code does the following:
>
> while (down_interruptible(my_device->write_semaphore));
> my_device->dma_write_complete = 0;
> my_device->dma_direction  = PCI_DMA_TODEVICE;
> my_device->bus_addr = pci_map_single(my_device->pci_device, pointer_to_buffer, my_device->dma_size, my_device->dma_direction);
>
> writel (cpu_to_le32 (bus_addr), MY_DMA_ADDR_REGISTER);
> writel (cpu_to_le32 (my_device->dma_size/4), MY_DMA_COUNT_REGISTER);	    //triggers dma transfer
>
> if (wait_event_interruptible(write_wait_queue, my_device->dma_write_complete))
> {
>      //handle error...
> }
> //test, if MY_DMA_COUNT_REGISTER contains 0
> up(my_device->write_semaphore);
>
> Inside the Interrupt-handler I do the following:
>
> pci_unmap_single (my_device->pci_device, my_device->bus_addr,
> my_device->dma_size, my_device->dma_direction);
> my_device->dma_write_complete = 1;
> wake_up_interruptible(&write_wait_queue);
> return IRQ_HANDLED;
>
> Actually the dma transfer works but I get a strange timing issue,
> which seems to be caused by wait_event_interruptible(). I measured the
> clock ticks elapsing from the start of the transfer until the interrupt
> appears. Converted to microseconds I get more than 600 us for less than
> 3 kB buffers. If I try out busy waiting using "while  (!my_device->dma_write
>_complete)" instead of wait_event_interruptible() the transfer already
> completes successfully after about 80 us. The device has to transport very
> large amounts of data, so I have to get the transfer rate as high as possible.
>
> I'm sorry if I made a very simple mistake, because I'm quite unexperienced in driver development, so hints would be very appreciated.
>

Don't you get an interrupt both on a completion and error?
I think you should be using interruptible_sleep_on(&write_wait_queue),
not spinning in wait_event_interruptible().

Most all my DMA transfers use as above and from the time the DMA
completion occurs until the time user-mode code gets awakened in
poll()  (Much worse latency than your code), the time is always
less than 120 us on a 400 MHz ix86 embedded machine with a 100 MHz
front-side bus.

> Kind regards,
> Burkhard

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.56 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
