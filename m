Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751513AbWDYBuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbWDYBuF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 21:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWDYBuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 21:50:05 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:26067 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751513AbWDYBuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 21:50:03 -0400
Message-ID: <444D8047.9080403@foo-projects.org>
Date: Mon, 24 Apr 2006 18:49:59 -0700
From: Auke Kok <sofar@foo-projects.org>
User-Agent: Mail/News 1.5.0.2 (X11/20060424)
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
CC: Auke Kok <auke-jan.h.kok@intel.com>, Ingo Oeser <ioe-lkml@rameria.de>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Ingo Oeser <netdev@axxeo.de>, "David S. Miller" <davem@davemloft.net>,
       simlo@phys.au.dk, linux-kernel@vger.kernel.org, mingo@elte.hu,
       netdev@vger.kernel.org
Subject: Re: Van Jacobson's net channels and real-time
References: <Pine.LNX.4.44L0.0604201819040.19330-100000@lifa01.phys.au.dk> <200604221529.59899.ioe-lkml@rameria.de> <20060422134956.GC6629@wohnheim.fh-wedel.de> <200604230205.33668.ioe-lkml@rameria.de> <444CFFE5.1020509@intel.com> <Pine.LNX.4.61.0604241254180.24099@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0604241254180.24099@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Mon, 24 Apr 2006, Auke Kok wrote:
> 
>> Ingo Oeser wrote:
>>> On Saturday, 22. April 2006 15:49, Jörn Engel wrote:
>>>> That was another main point, yes.  And the endpoints should be as
>>>> little burden on the bottlenecks as possible.  One bottleneck is the
>>>> receive interrupt, which shouldn't wait for cachelines from other cpus
>>>> too much.
>>> Thats right. This will be made a non issue with early demuxing
>>> on the NIC and MSI (or was it MSI-X?) which will select
>>> the right CPU based on hardware channels.
>> MSI-X. with MSI you still have only one cpu handling all MSI interrupts and
>> that doesn't look any different than ordinary interrupts. MSI-X will allow
>> much better interrupt handling across several cpu's.
>>
>> Auke
>> -
> 
> Message signaled interrupts are just a kudge to save a trace on a
> PC board (read make junk cheaper still).

yes. Also in PCI-Express there is no physical interrupt line anymore due to 
the architecture, so even classical interrupts are sent as "message" over the bus.

> They are not faster and may even be slower.

thus in the case of PCI-Express, MSI interrupts are just as fast as the 
ordinary ones. I have no numbers on whether MSI is faster or not then e.g. 
interrupts on PCI-X, but generally speaking, the PCI-Express bus is not 
designed to be "low latency" at all, at best it gives you X latency, where X 
is something like microseconds. The MSI message itself only takes 10-20 
nanoseconds though, but all the handling probably adds a large factor to that 
(1000 or so). No clue on classical interrupt line latency - anyone?

> They will not be the salvation of any interrupt latency problems. 

This is also not the problem - we really don't care that our 100.000 packets 
arrive 20usec slower per packet, just as long as the bus is not idle for those 
intervals. We would care a lot if 25.000 of those arrive directly at the 
proper CPU, without the need for one of the cpu's to arbitrate on every 
interrupt. That's the idea anyway.

Nowadays with irq throttling we introduce a lot of designed latency anyway, 
especially with network devices.

> The solutions for increasing networking speed,
> where the bit-rate on the wire gets close to the bit-rate on the
> bus, is to put more and more of the networking code inside the
> network board. The CPU get interrupted after most things (like
> network handshakes) are complete.

That is a limited vision of the situation. You could argue that the current 
CPU's have so much power that they can easily do a lot of the processing 
instead of the hardware, and thus warm caches for userspace, setup sockets 
etc. This is the whole idea of Van Jacobsen's net channels. Putting more 
offloading into the hardware just brings so much problems with itself, that 
are just far easier solved in the OS.


Cheers,

Auke
