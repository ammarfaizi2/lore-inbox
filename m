Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVGGMja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVGGMja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVGGMgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 08:36:54 -0400
Received: from alog0507.analogic.com ([208.224.223.44]:7623 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261324AbVGGMfo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 08:35:44 -0400
Date: Thu, 7 Jul 2005 08:34:02 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Michael Tokarev <mjt@tls.msk.ru>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sent an invalid ICMP type 11, code 0 error to a broadcast:
 0.0.0.0 on lo?
In-Reply-To: <42CD1860.1030804@tls.msk.ru>
Message-ID: <Pine.LNX.4.61.0507070801080.9558@chaos.analogic.com>
References: <42CBCEDD.2020401@tls.msk.ru> <Pine.LNX.4.61.0507061319440.5241@chaos.analogic.com>
 <42CD1860.1030804@tls.msk.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005, Michael Tokarev wrote:

> Richard B. Johnson wrote:
>> On Wed, 6 Jul 2005, Michael Tokarev wrote:
>>
>>> kernel: 192.168.4.2 sent an invalid ICMP type 11, code 0 error to a
>>> broadcast: 0.0.0.0 on lo
> []
>>> All the IP addresses mentioned are local to this box.
>
> []
>> Are you sure `lo` is configured properly, i.e.
>
> Yes.  More, rp_filter is activated on all interfaces.
>
>> ifconfig lo 127.0.0.1 netmask 255.0.0.0
>> route add -net 127.0.0.0 netmask 255.0.0.0 dev lo
>>
>> There should be no LAN routes going through lo.
>
> There's no.
>
>> It looks as though there are:
>>
>>> kernel: 192.168.4.2 sent an invalid ICMP type 11, code 0 error
>>> to a broadcast: 0.0.0.0 on lo
>>
>>                              |________ 192.168.4.2 pinged lo
>>
>> Only the 127.0.0.0 network should be routed through the loop-back
>> device.
>
> Again: All the IP addresses mentioned are local to this box.
>
> If you ping an IP address on your eth0, the traffic will "go"
> over loopback.  You can verify it using tcpdump:
>

If you ping an IP address on your computer, the traffic will go
through lo. However, I think that the IP address shown is
the result of an instrumentation error because it is impossible
to put, for instance your 192.168.1.1, through a 127.0.0.0 network,
the ONLY route through lo. This shows that 'local' traffic bypasses
the lo route filtering altogether. You can verify this by
deleting the lo route altogether, you can still ping the local
addresses.

Somebody else mentioned that lo was 'perfectly happy' to
carry whatever. The fact that something bogus appears on
lo can be a sign of a misconfiguration error, just as
the reserved 127.0.0.0 network must never appear on ethernet.

In the case of 0.0.0.0 (a possible broadcast), there is
no "local" address that could cause a bypass via lo. Instead,
any such traffic should have been on the ethernet wire. This
shows the possible configuration error that I mentioned.


> 1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue
>    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
                     ^^^^^^^^^^^^^^^^
>    inet 127.0.0.1/8 scope host lo

This looks as though there is no netmask set. My configuration
shows:

lo        Link encap:Local Loopback
           inet addr:127.0.0.1  Mask:255.0.0.0
           inet6 addr: ::1/128 Scope:Host
           UP LOOPBACK RUNNING  MTU:16436  Metric:1

This is a possible configuration error.

> 2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
>    link/ether 00:a0:d2:1d:a7:63 brd ff:ff:ff:ff:ff:ff
>    inet 192.168.1.1/24 brd 192.168.1.255 scope global eth0
>
> # tcpdump -npi lo proto ICMP
> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
> listening on lo, link-type EN10MB (Ethernet), capture size 96 bytes
> 15:55:13.679234 IP 192.168.1.1 > 192.168.1.1: icmp 64: echo request seq 1
> 15:55:13.679269 IP 192.168.1.1 > 192.168.1.1: icmp 64: echo reply seq 1
>
[SNIPPED rest]

>
> /mjt
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
