Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156702AbPLQRiE>; Fri, 17 Dec 1999 12:38:04 -0500
Received: by vger.rutgers.edu id <S156534AbPLQRek>; Fri, 17 Dec 1999 12:34:40 -0500
Received: from [212.102.170.10] ([212.102.170.10]:4152 "EHLO ads.htl.de") by vger.rutgers.edu with ESMTP id <S156607AbPLQReL>; Fri, 17 Dec 1999 12:34:11 -0500
Message-ID: <385A741E.A58470F6@htl.de>
Date: Fri, 17 Dec 1999 18:34:22 +0100
From: Andreas Scherbaum <adsmail@htl.de>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.rutgers.edu
Subject: Re: Do Routing-policies have effect on local-originated packets?
References: <199912171611.TAA01369@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

> It was removed closer to the end of 2.1.xx.
> 
> > So what's the current status, are locally originated packets
> > policy-routed or aren't they,

Hei all,

so we have a little problem:
I have a machine with 4 network cards and a ip from the same subnet on
every card.
(Dont ask me, why we have 4 cards for it ;-)
Ok, here's my setup:

----- cut -----
IP=/usr/sbin/ip
ROUTE=/sbin/route

ROUTER="192.168.0.102"
IP0=192.168.0.200
IP1=192.168.0.201
IP2=192.168.0.202
IP3=192.168.0.203
NM="192.168.0.0/24"

# set up interfaces
$IP addr add $IP0 dev eth0
$IP addr add $IP1 dev eth1
$IP addr add $IP2 dev eth2
$IP addr add $IP3 dev eth3
$IP link set eth0 up
$IP link set eth1 up
$IP link set eth2 up
$IP link set eth3 up

# add rules
$IP rule add from $IP0/32 pref 100 table 10
$IP rule add from $IP1/32 pref 200 table 20
$IP rule add from $IP2/32 pref 300 table 30
$IP rule add from $IP3/32 pref 400 table 40
$ROUTE add -host $ROUTER dev eth0

# set routing tables
$IP route add $NM dev eth0 table 10
$IP route add default via $ROUTER table 10
$IP route add $NM dev eth1 table 20
$IP route add default via $ROUTER table 20
$IP route add $NM dev eth2 table 30
$IP route add default via $ROUTER table 30
$IP route add $NM dev eth3 table 40
$IP route add default via $ROUTER table 40 
$ROUTE add default gw $ROUTER
----- cut -----

Now i have the following problem:
All UDP packages are created with the right ip, but routed trough the
first network card.

Here's a tcpdump (sending a nameserver request to the second ip ...)
$ host 192.168.0.1 192.168.0.201

# tcpdump -p -i eth1:
18:13:59.988575 192.168.0.15.1128 > 192.168.0.201.domain: 34740+ (28)
18:14:00.036535 192.168.0.15.1128 > 192.168.0.201.domain: 34741+ (28)

# tcpdump -p -i eth0:
18:14:09.514938 192.168.0.201.domain > 192.168.0.15.1128: 16413 1/3/3
(161)
18:14:09.570556 192.168.0.201.domain > 192.168.0.15.1128: 16414 0/1/0
(81)

Why is the kernel sending this packages trough the first interface and
how can i change it to using the right interface?


Regards

-- 

                                  ads
                                  Andreas Scherbaum

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
