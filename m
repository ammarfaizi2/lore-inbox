Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265006AbTGBOO7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 10:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265009AbTGBOO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 10:14:59 -0400
Received: from gate.corvil.net ([213.94.219.177]:25356 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S265006AbTGBOO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 10:14:56 -0400
Message-ID: <3F02EAE2.8050609@draigBrady.com>
Date: Wed, 02 Jul 2003 15:23:30 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030617
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: nf@hipac.org
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [ANNOUNCE] nf-hipac v0.8 released
References: <Pine.LNX.4.44.0307020826530.23232-100000@netcore.fi> <200307021426.56138.nf@hipac.org> <3F02D964.7050301@draigBrady.com> <200307021548.19989.nf@hipac.org>
In-Reply-To: <200307021548.19989.nf@hipac.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Bellion and Thomas Heinz wrote:
> Hi Pádraig
> 
> 
>>>Since real world network traffic always consists of a lot of different
>>>sized packets taking maximum sized packets is very euphemistic. 1450 byte
>>>packets at 950 Mbit/s correspond to approx. 80,000 packets/sec.
>>>We are really interested in how our algorithm performs at higher packet
>>>rates. Our performance tests are based on 100 Mbit hardware so we coudn't
>>>test with more than approx. 80,000 packets/sec even with minimum sized
>>>packets.
>>
>>Interrupt latency is the problem here. You'll require napi et. al
>>to get over this hump.
>
> Yes we know, but with 128 byte frame size you can archieve a packet rate of at 
> most 97,656 packets/sec (in theory) on 100 Mbit hardware. We don't think this 
> few more packets would have changed the results fundamentally, so it's 
> probably not worth it on 100 Mbit.

I was testing with 64 byte packets (so around 190Kpps). e100 cards at 
least have a handy mode for continually sending a packet as fast as 
possible. Also you can use more than one interface. So 100Mb
is very useful for testing. For the test below I was using
a rate of around 85Kpps.

> Certainly you are right, that napi is required on gigabit to saturate the link 
> with small sized packets. 
>
>>Cool. The same sort of test with ordinary netfilter that
>>I did showed it could only handle around 125 rules at this
>>packet rate on a 1.4GHz PIII, e1000 @ 100Mb/s.
>>
>># ./readprofile -m /boot/System.map | sort -nr | head -30
>>   6779 total                                      0.0047
>>   4441 default_idle                              69.3906
>>    787 handle_IRQ_event                           7.0268
>>    589 ip_packet_match                            1.6733
>>    433 ipt_do_table                               0.6294
>>    106 eth_type_trans                             0.5521
>>    [...]
> 
> What do you want to show with this profile? Most of the time is spend in the 
> idle loop and in irq handling and only a few percentage in ip_packet_match 
> and ipt_do_table, so we don't quite get how this matches your statement 
> above. Could you explain this in a few words?

Confused me too. The system would lock up and start dropping
packets after 125 rules. I.E. it would linearly degrade
as more rules were added. I'm guessing there is a fixed
interrupt overhead that is accounted for
by default_idle? Note the e1000 drivers were
left in the default config so there could definitely
be some tuning done here.

Note I changed netfilter slightly to accept promiscuous traffic
which is done in ip_rcv() and then the packets are just dropped
after the (match any in the test case) rules are traversed.

Pádraig.

