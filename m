Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130660AbRCTUMW>; Tue, 20 Mar 2001 15:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130685AbRCTUMM>; Tue, 20 Mar 2001 15:12:12 -0500
Received: from zeus.kernel.org ([209.10.41.242]:14529 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130660AbRCTUL7>;
	Tue, 20 Mar 2001 15:11:59 -0500
Date: Tue, 20 Mar 2001 15:09:36 -0500 (EST)
From: Richard A Nelson <cowboy@vnet.ibm.com>
X-X-Sender: <cowboy@badlands.lexington.ibm.com>
To: <linux-kernel@vger.kernel.org>
Subject: IP ROUTE and multi-path route splitting
Message-ID: <Pine.LNX.4.33.0103201432590.15434-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got two tokenring cards and I'd like to play with multi-path route
splitting across the interfaces (unfortunately, both are on the same
ring and subnet, so I doubt I'll see big improvements, but I'm only playing
anyway).

kernel = 2.4.2-ac20

$ ip -V
ip utility, iproute2-ss001007

$ ip addr show tr0
5: tr0: <BROADCAST,MULTICAST,UP> mtu 2000 qdisc pfifo_fast qlen 100
   link/[800] 40:00:de:ad:be:ef brd ff:ff:ff:ff:ff:ff
   inet 9.51.81.11/21 brd 9.51.87.255 scope link tr0
   inet6 fe80::4000:dead:beef/10 scope link
   inet6 fe80::4200:deff:fead:beef/10 scope link

$ ip addr show tr1
6: tr1: <BROADCAST,MULTICAST,UP> mtu 2000 qdisc pfifo_fast qlen 100
    link/[800] 00:06:29:b0:59:63 brd ff:ff:ff:ff:ff:ff
    inet 9.51.81.9/21 brd 9.51.87.255 scope link tr1
    inet6 fe80::206:29ff:feb0:5963/10 scope link
    inet6 fe80::6:29b0:5963/10 scope link

$ ip route show dev tr0
9.51.80.0/21  proto kernel  scope link  src 9.51.81.11
multicast 224.0.0.0/4  scope host  src 9.51.81.11
default via 9.51.80.1  src 9.51.81.11  metric 1

$ ip route show dev tr1
9.51.80.0/21  proto kernel  scope link  src 9.51.81.9

If I change the default route thusly:
$ ip route add default metric 1 src 9.51.81.11 \
	nexthop via 9.51.80.1 dev tr0 nexthop via 9.51.80.1 dev tr1

Then things work fine, incomming requests are processed as normal, but
it appears that outgoing requests are always sent via dev tr0

If I leave off the src argument, then incomming smtp sessions to dev tr0
(9.51.81.11) are not properly handled - I'm guessing because the src address
could be that dev tr1 (9.51.81.9).
of tr1

What am I misunderstanding...  What I was trying to achieve was:
 *) Incomming requests are handled on whatever interface the're received on
 *) Outgoing requests are handled on either interface

Is this more than can be done via ip route ?
-- 
Rick Nelson
Life'll kill ya                         -- Warren Zevon
Then you'll be dead                     -- Life'll kill ya

