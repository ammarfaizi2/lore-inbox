Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964945AbVLMO1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbVLMO1E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 09:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbVLMO1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 09:27:04 -0500
Received: from spirit.analogic.com ([204.178.40.4]:4868 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S964945AbVLMO1D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 09:27:03 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <358302439@web.de>
X-OriginalArrivalTime: 13 Dec 2005 14:27:02.0499 (UTC) FILETIME=[48E36330:01C5FFF1]
Content-class: urn:content-classes:message
Subject: Re: Strange delay on PCI-DMA-transfer completion by wait_event_interruptible()
Date: Tue, 13 Dec 2005 09:27:02 -0500
Message-ID: <Pine.LNX.4.61.0512130909340.7816@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Strange delay on PCI-DMA-transfer completion by wait_event_interruptible()
Thread-Index: AcX/8UjqamUDqkubSJ2gqNC2lVQKDQ==
References: <358302439@web.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: =?iso-8859-1?Q?Burkhard_Sch=F6lpen?= <bschoelpen@web.de>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Dec 2005, [iso-8859-1] Burkhard Schölpen wrote:

>> "linux-os \(Dick Johnson\)" <linux-os@analogic.com> schrieb am 12.12.05 21:14:39:
>>
>>
>> On Mon, 12 Dec 2005, [iso-8859-1] Burkhard Schölpen wrote:
>>
>>> Hi all,
>>>
>>> I'm trying to write a driver for a custom PCI-Board which is DMA-Busmaster capable (kernel 2.6.13 with SMP). Unfortunately I get some strange delay between the start of the transfer >>until the interrupt appears, which signals its completion.
>>>
>>> Concerning a dma transfer from RAM to the pci device, my code does the following:
>>>
>>> while (down_interruptible(my_device->write_semaphore));
>>> my_device->dma_write_complete = 0;
>>> my_device->dma_direction  = PCI_DMA_TODEVICE;
>>> my_device->bus_addr = pci_map_single(my_device->pci_device, pointer_to_buffer, my_device->dma_size, my_device->dma_direction);
>>>
>>> writel (cpu_to_le32 (bus_addr), MY_DMA_ADDR_REGISTER);
>>> writel (cpu_to_le32 (my_device->dma_size/4), MY_DMA_COUNT_REGISTER);	    //triggers dma transfer
>>>
>>> if (wait_event_interruptible(write_wait_queue, my_device->dma_write_complete))
>>> {
>>>      //handle error...
>>> }
>>> //test, if MY_DMA_COUNT_REGISTER contains 0
>>> up(my_device->write_semaphore);
>>>
>>> Inside the Interrupt-handler I do the following:
>>>
>>> pci_unmap_single (my_device->pci_device, my_device->bus_addr,
>>> my_device->dma_size, my_device->dma_direction);
>>> my_device->dma_write_complete = 1;
>>> wake_up_interruptible(&write_wait_queue);
>>> return IRQ_HANDLED;
>>>
>>> Actually the dma transfer works but I get a strange timing issue,
>>> which seems to be caused by wait_event_interruptible(). I measured the
>>> clock ticks elapsing from the start of the transfer until the interrupt
>>> appears. Converted to microseconds I get more than 600 us for less than
>>> 3 kB buffers. If I try out busy waiting using "while  (!my_device->dma_write
>>> _complete)" instead of wait_event_interruptible() the transfer already
>>> completes successfully after about 80 us. The device has to transport very
>>> large amounts of data, so I have to get the transfer rate as high as possible.
>>>
>>> I'm sorry if I made a very simple mistake, because I'm quite unexperienced in driver development, so hints would be very appreciated.
>>>
>>
>> Don't you get an interrupt both on a completion and error?
>> I think you should be using interruptible_sleep_on(&write_wait_queue),
>> not spinning in wait_event_interruptible().
>
> Thanks a lot for your answer!
> I just tried out interruptible_sleep_on(), but couriously I got the same
> delay as before. On the hardware side, everything seems to be okay, because
> the data I'm transferring is relayed to a printhead of a laser printer (by an
> FPGA on the PCI-Board), whose LEDs light up as expected. The programmer of
> the FPGA (sitting next to me) says there would be no interrupt in the case of
> an error (so probably I should sleep with a timeout). But as there is an
> interrupt (and MY_DMA_COUNT_REGISTER contains really 0) in fact, I think the
> dma transfer succeeds, or could that be misleading? The only problem seems
> to be, that the interrupt comes much later, if I put the user process to
> sleep than let it do busy waiting. Do you have any idea, what could cause
> this strange behaviour? Could it be concerned with my SMP kernel (I use a
> processor with 2 cores)?
>

I think I know what is happening. You are writing the count across the
PCI bus, thinking this will start the DMA transfer. However, the count
won't actually get to the device until the PCI interface is flushed
(it's a FIFO, waiting for more activity). You need to force that
write to occur NOW, by performing a dummy read in your address-space
on the PCI bus.

Then, you should find that the DMA seems to occur instantly and you
get your interrupt when you expect it. We use the PLX PCI 9656BA
for PCI interface on our datalink boards so I have a lot of
experience in this area.

In the case where you were polling the interface, the first read
if its status actually flushed the PCI bus and started the DMA
transfer. In the cases where you weren't polling, the count
got to the device whenever the PCI interface timed-out or when
there was other activity such as network.

> At first I used interruptible_sleep_on(), but then I changed to
> wait_event_interruptible(), because I read that the probability of a race
> condition is higher than with wait_event_interruptible(), so one shouldn't
> use this function any longer. Do you think interruptible_sleep_on() is
> okay for this case?
>

Every time somebody wants to rewrite a macro, they declare that the
previous one had some race condition. If, in fact, you have only
one DMA occurring from your device then no race is possible with
interruptible_sleep_on(). wait_event_interruptible() is the same thing
but with an additional access to some memory variable, possibly
causing a cache refill which means it might take more time.

In any event, then both work okay.

> Kind regards,
> Burkhard


Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.56 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
