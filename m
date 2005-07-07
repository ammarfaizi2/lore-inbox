Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVGGNW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVGGNW6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 09:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVGGNHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 09:07:10 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:30301 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S261478AbVGGNFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 09:05:33 -0400
Message-ID: <42CD289B.5080403@tls.msk.ru>
Date: Thu, 07 Jul 2005 17:05:31 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sent an invalid ICMP type 11, code 0 error to a broadcast: 0.0.0.0
 on lo?
References: <42CBCEDD.2020401@tls.msk.ru> <Pine.LNX.4.61.0507061319440.5241@chaos.analogic.com> <42CD1860.1030804@tls.msk.ru> <Pine.LNX.4.61.0507070801080.9558@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0507070801080.9558@chaos.analogic.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
[]
> If you ping an IP address on your computer, the traffic will go
> through lo. However, I think that the IP address shown is
> the result of an instrumentation error because it is impossible
> to put, for instance your 192.168.1.1, through a 127.0.0.0 network,
> the ONLY route through lo. This shows that 'local' traffic bypasses
> the lo route filtering altogether. You can verify this by
> deleting the lo route altogether, you can still ping the local
> addresses.

Hmm.  I can't parse this. ;)
Well, I can bring loopback down, but in this case I can't even
ping my local IP addresses anymore, ping reports 'Invalid argument'
error (there's only one route left after deleting lo on my test
machine - 192.168.1.0/24).

> Somebody else mentioned that lo was 'perfectly happy' to
> carry whatever. The fact that something bogus appears on
> lo can be a sign of a misconfiguration error, just as
> the reserved 127.0.0.0 network must never appear on ethernet.

I'm not denying it may be some misconfiguration.  The problem
is that I don't see what/where it is.  All the stuff looks pretty
normal.

> In the case of 0.0.0.0 (a possible broadcast), there is
> no "local" address that could cause a bypass via lo. Instead,
> any such traffic should have been on the ethernet wire. This
> shows the possible configuration error that I mentioned.

Again, I don't understand what do you mean.  The message
in $subj says that something *on this box* sent that bogus
ICMP packet, with source address on this same box.  It may
be a reply to bogus packet sent with src=0.0.0.0 somehow,
or maybe not.  Maybe the host is trying to reply to a packet
sent to one of its local IPs -- eg, imagine I send packet
with src=0.0.0.0 to another host to non-listening port
(rp_filter should be activated in that case I think, but
IF that packet comes from the interface where the default
route goes, rp_filter may not trigger) - and kernel is trying
to send an ICMP reply... back to 0.0.0.0...

Even that does not explain everything still.  My 'default route'
interface - the one which goes to my ISP - I doubt it's possible
from the ISP side to send a packet destined to 192.168.4.2 so
that the packet will come to us - unless their routing is hosed.

The problem is, I can't see what is causing this misconfiguration
or whatever.  I wasn't able to capture such a packet so far either --
it never happened while tcpdump was running.

 Note the local IP address mentioned is different, I've
seen 3 so far, all 3 are local on this box and are on 3
different (ethernet) interfaces (but the ICMP always comes
from lo).

> 
>> 1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue
>>    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 
>                     ^^^^^^^^^^^^^^^^
> 
>>    inet 127.0.0.1/8 scope host lo
> 
> 
> This looks as though there is no netmask set. My configuration
> shows:

The netmask is perfect - it's 127.255.255.255.  The thing you
quoted is *ethernet* address, not IP address - and for loopback,
it's ok to have that as all-zeros.

> lo        Link encap:Local Loopback
>           inet addr:127.0.0.1  Mask:255.0.0.0
>           inet6 addr: ::1/128 Scope:Host
>           UP LOOPBACK RUNNING  MTU:16436  Metric:1
> 
> This is a possible configuration error.

Here's how ifconfig shows my interface:

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1

The above output is from `ip addr'.

/mjt
