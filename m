Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbUKVSUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbUKVSUN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 13:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbUKVSRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:17:52 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:13737 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S262262AbUKVSQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:16:05 -0500
Message-ID: <41A23040.8080505@devicelogics.com>
Date: Mon, 22 Nov 2004 11:30:24 -0700
From: "Jeff V. Merkey" <jmerkey@devicelogics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9 pktgen module causes INIT process respawning  and
 sickness
Content-Type: multipart/mixed;
 boundary="------------090808060306040101000709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090808060306040101000709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------090808060306040101000709
Content-Type: message/rfc822;
 name="Re: Linux 2.6.9 pktgen module causes INIT process respawning  and sickness"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: Linux 2.6.9 pktgen module causes INIT process respawning  and sickness"

Message-ID: <41A21C82.3060105@devicelogics.com>
Date: Mon, 22 Nov 2004 10:06:10 -0700
From: "Jeff V. Merkey" <jmerkey@devicelogics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lincoln Dale <ltd@cisco.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9 pktgen module causes INIT process respawning  and
 sickness
References: <419E6B44.8050505@devicelogics.com> <419E6B44.8050505@devicelogics.com> <5.1.0.14.2.20041122144144.04e3d9f0@171.71.163.14>
In-Reply-To: <5.1.0.14.2.20041122144144.04e3d9f0@171.71.163.14>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Lincoln,

I've studied these types of problems for years, and I think it's 
possible even for Linux. The
problem with small packet sizes on x86 hardware is related to 
non-cachable writes to
the adapter ring buffer for preloading of addresses. From my 
measurements, I have observed
that the increased memory write traffic increases latency to the point 
that the OS is unable to
receive data off the card at high enough rates. With testing against 
Linux with a Spirent Smartbits,
at @ 3,00,000 packets per second for 64 byte packets aboutn 80% of the 
packets get dropped
at 1000 mbs rates. It's true that Linux is simply incapable of 
generating at these rates, but the
reason in Linux is due to poor design at the xmit layer. You see a lot 
better behavior at
1500 byte packet sizes, but this is because the card doesnt have to 
preload as many addresses
into the ring buffer since you are only dealing with 150,000 packets per 
second in the 1500
byte case, not in the millions for the 64 byte case.

Linux uses polling (bad) and the tx queue does not feed packets back to 
the adapter on tx cleaning
of the queue via tx complete (or terminal dma count) interrupts 
durectly, instead they go through
a semaphore to trigger the next send -- horribly broken for high speed 
communications. They should
just post the packets and allow tx complete interrupts to feed them off 
the queues. The queue depths
in qdisc are far too short before Linux starts dropping packets 
internally. I've had to increase
the depth of tx_queue_len for some apps to work properly without 
dropping all the skbs on the floor.

So how to get around this problem. At present, the design of the Intel 
drivers allow all the ripe ring buffers
to be reaped at once from a single interrupt. This is very efficient on 
the RX side and in fact, with static
tests, I have been able to program the Intel card to accept 64 byte 
packets at the maximum rate for
gigabit saturation on Linux provided the ring buffers are loaded with 
static addresses. This indicates
the problem in the design is related to the preloading anbd serializing 
memory behavior of Intel's
architecture at the ring buffer level on the card. This also means that 
Linux on current PC architecture,
(and most OS for that matter) will not be able to sustain 10 gigabit 
rates unless the packet sizes get larger
and larger due to the nature of this problem. The solution for he card 
vendors is to instrument the
ability to load a descriptor to the card once which contains the 
addresses of all the ring buffers
for a session of the card and reap them in A / B lists. i.e. two active 
preload memory tables which
contain a listing of preload addresses for receive and when the card 
fills one list, it switches to the second
for receives, sends an interruptr, and the ISR loads the next table into 
the card.

I see no other way for OS to sustain high packet loading about 500,000 
packets per second on Linux
or even come close to dealing with small packets or full 10 gigabite 
ethernet without such a model.
The bus speeds are actually fine for dealing with this on current 
hardware. The problem is realated
to the serializing behavior of non-cachable memory references on IO 
mapped card memory, and this
suggestion could be implemented in Intel Gigabit and 10 gE hardware with 
microcode and minor changes
to the DMA designs of their chipsets. It would allow all OS to reach 
performance levels of a Smartbits
or even a CISCO router without the need for custom hardware design.

My 2 cents.

Jeff






Lincoln Dale wrote:

> Jeff,
>
> you're using commodity x86 hardware. what do you expect?
>
> while the speed of PCs has increased significantly, there are still 
> significant bottlenecks when it comes to PCI bandwidth, PCI 
> arbitration efficiency & # of interrupts/second.
> linux ain't bad -- but there are other OSes which still do slightly 
> better given equivalent hardware.
>
> with a PC comes flexibility.
> that won't match the speed of the FPGAs in a Spirent Smartbits, 
> Agilent RouterTester, IXIA et al ...
>
> cheers,
>
> lincoln.
>
> At 09:06 AM 20/11/2004, Jeff V. Merkey wrote:
>
>> Additionally, when packets sizes 64, 128, and 256 are selected, 
>> pktgen is unable to achieve > 500,000 pps (349,000 only on my system).
>> A Smartbits generator can achieve over 1 million pps with 64 byte 
>> packets on gigabit. This is one performance
>> issue for this app. However, at 1500 and 1048 sizes, gigabit 
>> saturation is achievable.
>> Jeff
>>
>> Jeff V. Merkey wrote:
>>
>>>
>>> With pktgen.o configured to send 123MB/S on a gigabit on a system 
>>> using pktgen set to the following parms:
>>>
>>> pgset "odev eth1"
>>> pgset "pkt_size 1500"
>>> pgset "count 0"
>>> pgset "ipg 5000"
>>> pgset "src_min 10.0.0.1"
>>> pgset "src_max 10.0.0.254"
>>> pgset "dst_min 192.168.0.1"
>>> pgset "dst_max 192.168.0.254"
>>>
>>> After 37 hours of continual packet generation into a gigabit 
>>> regeneration tap device,
>>> the server system console will start to respawn the INIT process 
>>> about every 10-12
>>> hours of continuous packet generation.
>>>
>>> As a side note, this module in Linux is extremely useful and the 
>>> "USE WITH CAUTION" warnings
>>> are certainly will stated. The performance of this tool is excellent.
>>>
>>> Jeff
>>
>
>



--------------090808060306040101000709--
