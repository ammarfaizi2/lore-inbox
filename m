Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbVLNH7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVLNH7K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 02:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVLNH7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 02:59:10 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:4542 "EHLO
	fmmailgate04.web.de") by vger.kernel.org with ESMTP
	id S1751120AbVLNH7J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 02:59:09 -0500
Date: Wed, 14 Dec 2005 08:59:06 +0100
Message-Id: <360494674@web.de>
MIME-Version: 1.0
From: =?iso-8859-1?Q?Burkhard=20Sch=F6lpen?= <bschoelpen@web.de>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange delay on PCI-DMA-transfer completion by wait_event_interruptible()
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, 13 Dec 2005, [iso-8859-1] Burkhard Schölpen wrote:
>
>> Thanks a lot for your answer!
>> I just tried out interruptible_sleep_on(), but couriously I got the same
>> delay as before. On the hardware side, everything seems to be okay, because
>> the data I'm transferring is relayed to a printhead of a laser printer (by an
>> FPGA on the PCI-Board), whose LEDs light up as expected. The programmer of
>> the FPGA (sitting next to me) says there would be no interrupt in the case of
>> an error (so probably I should sleep with a timeout). But as there is an
>> interrupt (and MY_DMA_COUNT_REGISTER contains really 0) in fact, I think the
>> dma transfer succeeds, or could that be misleading? The only problem seems
>> to be, that the interrupt comes much later, if I put the user process to
>> sleep than let it do busy waiting. Do you have any idea, what could cause
>> this strange behaviour? Could it be concerned with my SMP kernel (I use a
>> processor with 2 cores)?
>>
"linux-os \(Dick Johnson\)" <linux-os@analogic.com> schrieb am 13.12.05 15:30:33:
>
>I think I know what is happening. You are writing the count across the
>PCI bus, thinking this will start the DMA transfer. However, the count
>won't actually get to the device until the PCI interface is flushed
>(it's a FIFO, waiting for more activity). You need to force that
>write to occur NOW, by performing a dummy read in your address-space
>on the PCI bus.
>
>Then, you should find that the DMA seems to occur instantly and you
>get your interrupt when you expect it. We use the PLX PCI 9656BA
>for PCI interface on our datalink boards so I have a lot of
>experience in this area.
>
>In the case where you were polling the interface, the first read
>if its status actually flushed the PCI bus and started the DMA
>transfer. In the cases where you weren't polling, the count
>got to the device whenever the PCI interface timed-out or when
>there was other activity such as network.

Thank you for your help! The dummy read was a very helpful hint to get the DMA stuff more reliable (although the fpga programmer had to admit that there was some other problem in the hardware after all). I think it should work fine soon. 

I'm glad to meet somebody with dma experience, because I have some other difficulties concerning DMA buffers in RAM. The PCI-Board is to be applied in a large size copying machine, so it essentially has to transfer tons of data in 2 directions very fast without wasting cpu time (because the cpu has to run many image processing algorithms meanwhile on this data). So my approach is to allocate a quite large ringbuffer in kernel space (or more precisely one ringbuffer for each direction) which is capable of dma. Afterwards I would map this buffer to user space to avoid unnecessary memcopies/cpu usage. My problem is for now to get such a large DMA buffer. I tried out several things I read in O'Reilly's book, but they all failed so far. My current attempt is to take a high memory area with ioremap:

buffer_addr = ioremap( virt_to_phys(high_memory), large_size );

Mapping this buffer to user space works, but it does not seem to be DMA capable. Maybe it's just wrong to use ioremap() for that? I would be very glad for getting some advice.

Kind regards,
Burkhard

______________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt bei WEB.DE FreeMail: http://f.web.de/?mc=021193

