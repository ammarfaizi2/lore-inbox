Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLNTqr>; Thu, 14 Dec 2000 14:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQLNTqa>; Thu, 14 Dec 2000 14:46:30 -0500
Received: from pak145.pakuni.net ([205.138.121.145]:54261 "EHLO
	postal.paktronix.com") by vger.kernel.org with ESMTP
	id <S129267AbQLNTqP>; Thu, 14 Dec 2000 14:46:15 -0500
Date: Thu, 14 Dec 2000 13:11:06 -0600 (CST)
From: "Matthew G. Marsh" <mgm@paktronix.com>
To: kuznet@ms2.inr.ac.ru
cc: Pete Toscano <pete@research.netsol.com>, linux-kernel@vger.kernel.org
Subject: Re: linux ipv6 questions.  bugs?
In-Reply-To: <200012141740.UAA02109@ms2.inr.ac.ru>
Message-ID: <Pine.LNX.4.10.10012141304150.16343-100000@netmonster.pakint.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2000 kuznet@ms2.inr.ac.ru wrote:

> Hello!

[snip] 

> I have no idea what does happen. I cannot reproduce this.
> Please, describe your setup in more details.

Hi Alexey!

I have several different boxen (test11, test12) that do something very
similar. They cannot ping6 the link-local addresses at all. As in:

[root@paksecuredX tech]# ping6 ::1
PING ::1(::1) from ::1 : 56 data bytes
64 bytes from ::1: icmp_seq=0 hops=64 time=351 usec
64 bytes from ::1: icmp_seq=1 hops=64 time=200 usec

--- ::1 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max/mdev = 0.200/0.275/0.351/0.077 ms

[root@paksecuredX tech]# ip -6 ad
1: lo: <LOOPBACK,UP> mtu 3840 qdisc noqueue
    inet6 ::1/128 scope host
2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    inet6 fe80::210:5aff:fe05:e828/10 scope link

[root@paksecuredX tech]# ip -6 ro
fe80::/10 dev eth0  proto kernel  metric 256  mtu 1500 advmss 1440
ff00::/8 dev eth0  proto kernel  metric 256  mtu 1500 advmss 1440
default dev eth0  proto kernel  metric 256  mtu 1500 advmss 1440
unreachable default dev lo  metric -1  error -101

[root@paksecuredX tech]# ping6 fe80::210:5aff:fe05:e828
connect: Invalid argument

Now if I try and setup an address such as the following it works but still
will not ping6 the link-local. IE:

[root@paksecuredX tech]# ip -6 ad ad dead:2::1/64 dev eth0

[root@paksecuredX tech]# ip -6 ad
1: lo: <LOOPBACK,UP> mtu 3840 qdisc noqueue
    inet6 ::1/128 scope host
2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    inet6 dead:2::1/64 scope global tentative
    inet6 fe80::210:5aff:fe05:e828/10 scope link

[root@paksecuredX tech]# ping6 dead:2::1
PING dead:2::1(dead:2::1) from ::1 : 56 data bytes
64 bytes from dead:2::1: icmp_seq=0 hops=64 time=377 usec
64 bytes from dead:2::1: icmp_seq=1 hops=64 time=196 usec

--- dead:2::1 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max/mdev = 0.196/0.286/0.377/0.092 ms

[root@paksecuredX tech]# ping6 fe80::210:5aff:fe05:e828
connect: Invalid argument

Now from my local box which is running 2.2.12 I can ping the link-local of
those boxes. IE:

[root@netmonster Kernel]# ping6 fe80::210:5aff:fe05:e828
PING fe80::210:5aff:fe05:e828(fe80::210:5aff:fe05:e828) from
fe80::2a0:ccff:fe21:eed3 : 56 data bytes
64 bytes from fe80::210:5aff:fe05:e828: icmp_seq=0 hops=64 time=1.291 msec
64 bytes from fe80::210:5aff:fe05:e828: icmp_seq=1 hops=64 time=520 usec
64 bytes from fe80::210:5aff:fe05:e828: icmp_seq=2 hops=64 time=500 usec

--- fe80::210:5aff:fe05:e828 ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max/mdev = 0.500/0.770/1.291/0.368 ms

So it looks like there is something going on with just the Link-Local
addresses. I have not yet started to regress the kernels to see where this
started. Hope it helps!

Note - this is using iputils 001110 and also 001011

[snip]
 
> Alexey

--------------------------------------------------
Matthew G. Marsh,  President
Paktronix Systems LLC
1506 North 59th Street
Omaha  NE  68104
Phone: (402) 932-7250
Email: mgm@paktronix.com
WWW:  http://www.paktronix.com
--------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
