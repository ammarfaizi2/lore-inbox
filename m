Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751523AbWDYL34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbWDYL34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 07:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWDYL34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 07:29:56 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:54799 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S1751523AbWDYL3z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 07:29:55 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <444D8047.9080403@foo-projects.org>
X-OriginalArrivalTime: 25 Apr 2006 11:29:48.0742 (UTC) FILETIME=[8F9D9660:01C6685B]
Content-class: urn:content-classes:message
Subject: Re: Van Jacobson's net channels and real-time
Date: Tue, 25 Apr 2006 07:29:40 -0400
Message-ID: <Pine.LNX.4.61.0604250717590.28279@chaos.analogic.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Van Jacobson's net channels and real-time
thread-index: AcZoW4+p5Qd/hcOJQrCD30NzVbarIw==
References: <Pine.LNX.4.44L0.0604201819040.19330-100000@lifa01.phys.au.dk> <200604221529.59899.ioe-lkml@rameria.de> <20060422134956.GC6629@wohnheim.fh-wedel.de> <200604230205.33668.ioe-lkml@rameria.de> <444CFFE5.1020509@intel.com> <Pine.LNX.4.61.0604241254180.24099@chaos.analogic.com> <444D8047.9080403@foo-projects.org>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Auke Kok" <sofar@foo-projects.org>
Cc: "Auke Kok" <auke-jan.h.kok@intel.com>, "Ingo Oeser" <ioe-lkml@rameria.de>,
       =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       "Ingo Oeser" <netdev@axxeo.de>, "David S. Miller" <davem@davemloft.net>,
       <simlo@phys.au.dk>, <linux-kernel@vger.kernel.org>, <mingo@elte.hu>,
       <netdev@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Apr 2006, Auke Kok wrote:

> linux-os (Dick Johnson) wrote:
>> On Mon, 24 Apr 2006, Auke Kok wrote:
>>
>>> Ingo Oeser wrote:
>>>> On Saturday, 22. April 2006 15:49, Jörn Engel wrote:
>>>>> That was another main point, yes.  And the endpoints should be as
>>>>> little burden on the bottlenecks as possible.  One bottleneck is the
>>>>> receive interrupt, which shouldn't wait for cachelines from other cpus
>>>>> too much.
>>>> Thats right. This will be made a non issue with early demuxing
>>>> on the NIC and MSI (or was it MSI-X?) which will select
>>>> the right CPU based on hardware channels.
>>> MSI-X. with MSI you still have only one cpu handling all MSI interrupts and
>>> that doesn't look any different than ordinary interrupts. MSI-X will allow
>>> much better interrupt handling across several cpu's.
>>>
>>> Auke
>>> -
>>
>> Message signaled interrupts are just a kudge to save a trace on a
>> PC board (read make junk cheaper still).
>
> yes. Also in PCI-Express there is no physical interrupt line anymore due to
> the architecture, so even classical interrupts are sent as "message" over the bus.
>
>> They are not faster and may even be slower.
>
> thus in the case of PCI-Express, MSI interrupts are just as fast as the
> ordinary ones. I have no numbers on whether MSI is faster or not then e.g.
> interrupts on PCI-X, but generally speaking, the PCI-Express bus is not
> designed to be "low latency" at all, at best it gives you X latency, where X
> is something like microseconds. The MSI message itself only takes 10-20
> nanoseconds though, but all the handling probably adds a large factor to that
> (1000 or so). No clue on classical interrupt line latency - anyone?
>

About 9 nanosecond per foot of FR-4 (G10) trace, plus the access time
through the gate-arrays (about 20 ns) so, from the time a device needs
the CPU, until it hits the interrupt pin, you have typically 30 to
50 nanoseconds. Of course the CPU is __much__ slower. However, these
physical latencies are in series, cannot be compensated for because
the CPU can't see into the future.


>> They will not be the salvation of any interrupt latency problems.
>
> This is also not the problem - we really don't care that our 100.000 packets
> arrive 20usec slower per packet, just as long as the bus is not idle for those
> intervals. We would care a lot if 25.000 of those arrive directly at the
> proper CPU, without the need for one of the cpu's to arbitrate on every
> interrupt. That's the idea anyway.

It forces driver-writers to loop in ISRs to handle new status changes
that happened before an asserted interrupt even got to the CPU. This
is bad. You end up polled in the ISR, with the interrupts off. Turning
on the interrupts exacerbates the problem, you may never leave the
ISR! It becomes the new "idle task". To properly use interrupts,
the hardware latency must be less than the CPUs response to the
hardware stimulus.

>
> Nowadays with irq throttling we introduce a lot of designed latency anyway,
> especially with network devices.
>
>> The solutions for increasing networking speed,
>> where the bit-rate on the wire gets close to the bit-rate on the
>> bus, is to put more and more of the networking code inside the
>> network board. The CPU get interrupted after most things (like
>> network handshakes) are complete.
>
> That is a limited vision of the situation. You could argue that the current
> CPU's have so much power that they can easily do a lot of the processing
> instead of the hardware, and thus warm caches for userspace, setup sockets
> etc. This is the whole idea of Van Jacobsen's net channels. Putting more
> offloading into the hardware just brings so much problems with itself, that
> are just far easier solved in the OS.
>
>
> Cheers,
>
> Auke
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
Warning : 98.36% of all statistics are fiction, book release in April.
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
