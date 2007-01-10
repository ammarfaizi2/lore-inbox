Return-Path: <linux-kernel-owner+w=401wt.eu-S932587AbXAJAX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbXAJAX7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 19:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbXAJAX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 19:23:58 -0500
Received: from vs02.svr02.mucip.net ([83.170.6.69]:57448 "EHLO mx01.mucip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932585AbXAJAX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 19:23:57 -0500
Date: Wed, 10 Jan 2007 01:23:52 +0100
From: Bernhard Schmidt <berni@birkenwald.de>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [IPv6] PROBLEM? Network unreachable despite correct route
Message-ID: <20070110002352.GA31743@obelix.birkenwald.de>
References: <20070109193624.GA27718@obelix.birkenwald.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109193624.GA27718@obelix.birkenwald.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 08:36:24PM +0100, Bernhard Schmidt wrote:

Hi,

I did some additional testing

> I'm having a really ugly problem I'm trying to pinpoint, but failed so
> far. I'm neither completely convinced it is not related to my local
> setup(s), nor do I have any clue how this might be caused.
[...]
> - Dell OptiPlex GX<something> (P4 with HT, Single Core), SuSE 10.2,
>   distribution kernel 2.6.18.5-3-default, connected (tg3) to one
>   upstream Cisco 6500/Sup720, default route learned through stateless
>   autoconfiguration (RA)

Running tcpdump on this (target) box shows that ICMPv6 echo requests
(which is what mtr sends to the target box) are received by the box, but
not replied to

01:02:09.884692 IP6 2001:a60:f001:1:218:f3ff:fe66:xxxx > 2001:4ca0:0:f000:211:43ff:fe7e:yyyy: ICMP6, echo request, seq 54173, length 64
01:02:09.884706 IP6 2001:4ca0:0:f000:211:43ff:fe7e:yyyy > 2001:a60:f001:1:218:f3ff:fe66:xxxx: ICMP6, echo reply, seq 54173, length 64
01:02:10.428063 IP6 2001:a60:f001:1:218:f3ff:fe66:xxxx > 2001:4ca0:0:f000:211:43ff:fe7e:yyyy: ICMP6, echo request, seq 55453, length 64
01:02:11.056871 IP6 2001:a60:f001:1:218:f3ff:fe66:xxxx > 2001:4ca0:0:f000:211:43ff:fe7e:yyyy: ICMP6, echo request, seq 56733, length 64
01:02:11.700772 IP6 2001:a60:f001:1:218:f3ff:fe66:xxxx > 2001:4ca0:0:f000:211:43ff:fe7e:yyyy: ICMP6, echo request, seq 58013, length 64
[...]
01:02:17.301169 IP6 2001:a60:f001:1:218:f3ff:fe66:xxxx > 2001:4ca0:0:f000:211:43ff:fe7e:yyyy: ICMP6, echo request, seq 3998, length 64
01:02:17.941020 IP6 2001:a60:f001:1:218:f3ff:fe66:xxxx > 2001:4ca0:0:f000:211:43ff:fe7e:yyyy: ICMP6, echo request, seq 5278, length 64
01:02:18.581037 IP6 2001:a60:f001:1:218:f3ff:fe66:xxxx > 2001:4ca0:0:f000:211:43ff:fe7e:yyyy: ICMP6, echo request, seq 6558, length 64
01:02:18.581050 IP6 2001:4ca0:0:f000:211:43ff:fe7e:yyyy > 2001:a60:f001:1:218:f3ff:fe66:xxxx: ICMP6, echo reply, seq 6558, length 64

while this is happening, the SSH session (between the very same hosts) is
perfectly fine. ip6_tables.ko is not loaded, there is no other ICMPv6 packet
(e.g. neighbor solicitation or router advertisement) anywhere near the
beginning of my problem. Incoming TCP SYN (an additional SSH session I
tried to establish when I saw the box was not responding) are also 
visible on the interface, but not answered.

01:18:35.638744 IP6 2001:a60:f001:1:218:f3ff:fe66:xxxx.57045 > 2001:4ca0:0:f000:211:43ff:fe7e:yyyy.22: SWE 1448406153:1448406153(0) win 5760 <mss 1440,sackOK,timestamp 13958554 0,nop,wscale 2>
01:18:35.701523 IP6 2001:a60:f001:1:218:f3ff:fe66:xxxx > 2001:4ca0:0:f000:211:43ff:fe7e:yyyy: ICMP6, echo request, seq 41148, length 64
01:18:36.328728 IP6 2001:a60:f001:1:218:f3ff:fe66:xxxx > 2001:4ca0:0:f000:211:43ff:fe7e:yyyy: ICMP6, echo request, seq 42428, length 64

I managed to pull ip -6 route, ip -6 neigh and ip -6 addr while the box
was not responding:

ip -6 route:
2001:4ca0:0:f000::/64 dev eth0  proto kernel  metric 256  expires 86322sec mtu 1500 advmss 1440 fragtimeout 4294967295
fe80::/64 dev eth0  metric 256  expires 21225804sec mtu 1500 advmss 1440 fragtimeout 4294967295
ff00::/8 dev eth0  metric 256  expires 21225804sec mtu 1500 advmss 1440 fragtimeout 4294967295
default via fe80::2d0:4ff:fe12:2400 dev eth0  proto kernel  metric 1024  expires 1717sec mtu 1500 advmss 1440 fragtimeout 64
unreachable default dev lo  proto none  metric -1  error -101 fragtimeout 255

ip -6 neigh:
fe80::2d0:4ff:fe12:2400 dev eth0 lladdr 00:d0:04:12:24:00 router REACHABLE

ip -6 addr:
2: eth0: <BROADCAST,MULTICAST,NOTRAILERS,UP,10000> mtu 1500 qlen 1000
    inet6 2001:4ca0:0:f000:211:43ff:fe7e:yyyy/64 scope global dynamic 
       valid_lft 86318sec preferred_lft 14318sec
    inet6 fe80::211:43ff:fe7e:yyyy/64 scope link 
       valid_lft forever preferred_lft forever

Nothing in dmesg or any file in /var/log (except the notorious "Network
is unreachable" messages from OpenVPN).

I was wrong before by the way, some outgoing connections from the affected
machine still work, I was able to ping6, traceroute6 and telnet. At least
on this particular machine, I am very sure I have seen "Network unreachable"
on outgoing connects at some point.

I'll try to downgrade this machine to 2.6.16 (and eventually upgrade to 
2.6.19.1) and have a look whether the problem is gone.

> - Dell PowerEdge 750 (P4 with HT), Debian Etch, self compiled kernel
>   2.6.17.11, connected (e1000) to two upstream Cisco 7200, default route
>   is learned from RIPng (Quagga), static addresses

Still too soon to be absolutely sure, but I think the problem is gone
since the upgrade to 2.6.19.1.

Regards,
Bernhard
