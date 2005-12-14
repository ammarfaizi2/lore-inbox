Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbVLNOML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbVLNOML (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 09:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVLNOML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 09:12:11 -0500
Received: from spirit.analogic.com ([204.178.40.4]:18960 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S964784AbVLNOMK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 09:12:10 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C600B8.5E236C00"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <360494674@web.de>
X-OriginalArrivalTime: 14 Dec 2005 14:12:08.0947 (UTC) FILETIME=[5EB3EC30:01C600B8]
Content-class: urn:content-classes:message
Subject: Re: Strange delay on PCI-DMA-transfer completion by wait_event_interruptible()
Date: Wed, 14 Dec 2005 09:12:08 -0500
Message-ID: <Pine.LNX.4.61.0512140904440.12944@chaos.analogic.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: Strange delay on PCI-DMA-transfer completion by wait_event_interruptible()
Thread-Index: AcYAuF7EhS64zpoASxmA25YSluF4Ww==
References: <360494674@web.de>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: =?iso-8859-1?Q?Burkhard_Sch=F6lpen?= <bschoelpen@web.de>
Cc: <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C600B8.5E236C00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


On Wed, 14 Dec 2005, [iso-8859-1] Burkhard Sch=F6lpen wrote:

>> On Tue, 13 Dec 2005, [iso-8859-1] Burkhard Sch=F6lpen wrote:
>>
>>> Thanks a lot for your answer!
>>> I just tried out interruptible_sleep_on(), but couriously I got the=
 same
>>> delay as before. On the hardware side, everything seems to be okay,=
 because
>>> the data I'm transferring is relayed to a printhead of a laser printer=
 (by an
>>> FPGA on the PCI-Board), whose LEDs light up as expected. The programmer=
 of
>>> the FPGA (sitting next to me) says there would be no interrupt in the=
 case of
>>> an error (so probably I should sleep with a timeout). But as there is=
 an
>>> interrupt (and MY_DMA_COUNT_REGISTER contains really 0) in fact, I=
 think the
>>> dma transfer succeeds, or could that be misleading? The only problem=
 seems
>>> to be, that the interrupt comes much later, if I put the user process=
 to
>>> sleep than let it do busy waiting. Do you have any idea, what could=
 cause
>>> this strange behaviour? Could it be concerned with my SMP kernel (I use=
 a
>>> processor with 2 cores)?
>>>
> "linux-os \(Dick Johnson\)" <linux-os@analogic.com> schrieb am 13.12.05=
 15:30:33:
>>
>> I think I know what is happening. You are writing the count across the
>> PCI bus, thinking this will start the DMA transfer. However, the count
>> won't actually get to the device until the PCI interface is flushed
>> (it's a FIFO, waiting for more activity). You need to force that
>> write to occur NOW, by performing a dummy read in your address-space
>> on the PCI bus.
>>
>> Then, you should find that the DMA seems to occur instantly and you
>> get your interrupt when you expect it. We use the PLX PCI 9656BA
>> for PCI interface on our datalink boards so I have a lot of
>> experience in this area.
>>
>> In the case where you were polling the interface, the first read
>> if its status actually flushed the PCI bus and started the DMA
>> transfer. In the cases where you weren't polling, the count
>> got to the device whenever the PCI interface timed-out or when
>> there was other activity such as network.
>
> Thank you for your help! The dummy read was a very helpful hint to get=
 the DMA stuff more reliable (although the fpga programmer had to admit=
 that there was some other problem in the hardware after all). I think it=
 should work fine soon.
>
> I'm glad to meet somebody with dma experience, because I have some other=
 difficulties concerning DMA buffers in RAM. The PCI-Board is to be applied=
 in a large size copying machine, so it essentially has to transfer tons of=
 data in 2 directions very fast without wasting cpu time (because the cpu=
 has to run many image processing algorithms meanwhile on this data). So my=
 approach is to allocate a quite large ringbuffer in kernel space (or more=
 precisely one ringbuffer for each direction) which is capable of dma.=
 Afterwards I would map this buffer to user space to avoid unnecessary=
 memcopies/cpu usage. My problem is for now to get such a large DMA buffer.=
 I tried out several things I read in O'Reilly's book, but they all failed=
 so far. My current attempt is to take a high memory area with ioremap:
>
> buffer_addr =3D ioremap( virt_to_phys(high_memory), large_size );
>
> Mapping this buffer to user space works, but it does not seem to be DMA=
 capable. Maybe it's just wrong to use ioremap() for that? I would be very=
 glad for getting some advice.
>
> Kind regards,
> Burkhard

I have attached a "driver" that does nothing but map DMA-able pages
to user-space. It should show you what you need to do. It's really
quite simple, but the devil is in the details.

Also, if you are using the PLX or similar PCI interface device, you
can use the scatter-list capability so that the DMA pages don't
have to be contiguous. The mapping to user-space makes them
virtually contiguous to the user, but you can use pages from
anywhere in memory as long as its addressable by your controller.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.13.4 on an i686 machine (5589.56 BogoMips).
Warning : 98.36% of all statistics are fiction.

****************************************************************
The information transmitted in this message is confidential and may be=
 privileged.  Any review, retransmission, dissemination, or other use of=
 this information by persons or entities other than the intended recipient=
 is prohibited.  If you are not the intended recipient, please notify=
 Analogic Corporation immediately - by replying to this message or by=
 sending an email to DeliveryErrors@analogic.com - and destroy all copies=
 of this information, including any attachments, without reading or=
 disclosing them.

Thank you.
------_=_NextPart_001_01C600B8.5E236C00--
