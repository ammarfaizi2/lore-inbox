Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbVLMJaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVLMJaG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 04:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbVLMJaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 04:30:06 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:8406 "EHLO
	fmmailgate04.web.de") by vger.kernel.org with ESMTP id S964855AbVLMJaD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 04:30:03 -0500
Date: Tue, 13 Dec 2005 10:29:59 +0100
Message-Id: <358302439@web.de>
MIME-Version: 1.0
From: =?iso-8859-1?Q?Burkhard=20Sch=F6lpen?= <bschoelpen@web.de>
To: linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange delay on PCI-DMA-transfer completion by wait_event_interruptible()
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>"linux-os \(Dick Johnson\)" <linux-os@analogic.com> schrieb am 12.12.05 21:14:39:
>
>
>On Mon, 12 Dec 2005, [iso-8859-1] Burkhard Schölpen wrote:
>
>> Hi all,
>>
>> I'm trying to write a driver for a custom PCI-Board which is DMA-Busmaster capable (kernel 2.6.13 with SMP). Unfortunately I get some strange delay between the start of the transfer >>until the interrupt appears, which signals its completion.
>>
>> Concerning a dma transfer from RAM to the pci device, my code does the following:
>>
>> while (down_interruptible(my_device->write_semaphore));
>> my_device->dma_write_complete = 0;
>> my_device->dma_direction  = PCI_DMA_TODEVICE;
>> my_device->bus_addr = pci_map_single(my_device->pci_device, pointer_to_buffer, my_device->dma_size, my_device->dma_direction);
>>
>> writel (cpu_to_le32 (bus_addr), MY_DMA_ADDR_REGISTER);
>> writel (cpu_to_le32 (my_device->dma_size/4), MY_DMA_COUNT_REGISTER);	    //triggers dma transfer
>>
>> if (wait_event_interruptible(write_wait_queue, my_device->dma_write_complete))
>> {
>>      //handle error...
>> }
>> //test, if MY_DMA_COUNT_REGISTER contains 0
>> up(my_device->write_semaphore);
>>
>> Inside the Interrupt-handler I do the following:
>>
>> pci_unmap_single (my_device->pci_device, my_device->bus_addr,
>> my_device->dma_size, my_device->dma_direction);
>> my_device->dma_write_complete = 1;
>> wake_up_interruptible(&write_wait_queue);
>> return IRQ_HANDLED;
>>
>> Actually the dma transfer works but I get a strange timing issue,
>> which seems to be caused by wait_event_interruptible(). I measured the
>> clock ticks elapsing from the start of the transfer until the interrupt
>> appears. Converted to microseconds I get more than 600 us for less than
>> 3 kB buffers. If I try out busy waiting using "while  (!my_device->dma_write
>>_complete)" instead of wait_event_interruptible() the transfer already
>> completes successfully after about 80 us. The device has to transport very
>> large amounts of data, so I have to get the transfer rate as high as possible.
>>
>> I'm sorry if I made a very simple mistake, because I'm quite unexperienced in driver development, so hints would be very appreciated.
>>
>
>Don't you get an interrupt both on a completion and error?
>I think you should be using interruptible_sleep_on(&write_wait_queue),
>not spinning in wait_event_interruptible().

Thanks a lot for your answer!
I just tried out interruptible_sleep_on(), but couriously I got the same delay as before. On the hardware side, everything seems to be okay, because the data I'm transferring is relayed to a printhead of a laser printer (by an FPGA on the PCI-Board), whose LEDs light up as expected. The programmer of the FPGA (sitting next to me) says there would be no interrupt in the case of an error (so probably I should sleep with a timeout). But as there is an interrupt (and MY_DMA_COUNT_REGISTER contains really 0) in fact, I think the dma transfer succeeds, or could that be misleading? The only problem seems to be, that the interrupt comes much later, if I put the user process to sleep than let it do busy waiting. Do you have any idea, what could cause this strange behaviour? Could it be concerned with my SMP kernel (I use a processor with 2 cores)?

At first I used interruptible_sleep_on(), but then I changed to wait_event_interruptible(), because I read that the probability of a race condition is higher than with wait_event_interruptible(), so one shouldn't use this function any longer. Do you think interruptible_sleep_on() is okay for this case?

Kind regards,
Burkhard

>Most all my DMA transfers use as above and from the time the DMA
>completion occurs until the time user-mode code gets awakened in
>poll()  (Much worse latency than your code), the time is always
>less than 120 us on a 400 MHz ix86 embedded machine with a 100 MHz
>front-side bus.
>
>> Kind regards,
>> Burkhard

>Cheers,
>Dick Johnson
>Penguin : Linux version 2.6.13.4 on an i686 machine (5589.56 BogoMips).
>Warning : 98.36% of all statistics are fiction.
>
>****************************************************************
>The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities >other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email >to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.
>
>Thank you.


______________________________________________________________________
XXL-Speicher, PC-Virenschutz, Spartarife & mehr: Nur im WEB.DE Club!		
Jetzt gratis testen! http://freemail.web.de/home/landingpad/?mc=021130

