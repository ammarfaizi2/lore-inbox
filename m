Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132195AbRCYUjN>; Sun, 25 Mar 2001 15:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132194AbRCYUjD>; Sun, 25 Mar 2001 15:39:03 -0500
Received: from pak200.pakuni.net ([207.91.34.200]:52723 "EHLO
	postal.paktronix.com") by vger.kernel.org with ESMTP
	id <S132195AbRCYUis>; Sun, 25 Mar 2001 15:38:48 -0500
Date: Sun, 25 Mar 2001 14:42:37 -0600 (CST)
From: "Matthew G. Marsh" <mgm@paktronix.com>
To: Richard A Nelson <cowboy@vnet.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: IP ROUTE and multi-path route splitting
In-Reply-To: <Pine.LNX.4.33.0103201432590.15434-100000@badlands.lexington.ibm.com>
Message-ID: <Pine.LNX.4.10.10103251431210.2055-100000@netmonster.pakint.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001, Richard A Nelson wrote:

[snip]
> $ ip addr show tr0
> 5: tr0: <BROADCAST,MULTICAST,UP> mtu 2000 qdisc pfifo_fast qlen 100
>    link/[800] 40:00:de:ad:be:ef brd ff:ff:ff:ff:ff:ff
>    inet 9.51.81.11/21 brd 9.51.87.255 scope link tr0
>    inet6 fe80::4000:dead:beef/10 scope link
>    inet6 fe80::4200:deff:fead:beef/10 scope link
> 
> $ ip addr show tr1
> 6: tr1: <BROADCAST,MULTICAST,UP> mtu 2000 qdisc pfifo_fast qlen 100
>     link/[800] 00:06:29:b0:59:63 brd ff:ff:ff:ff:ff:ff
>     inet 9.51.81.9/21 brd 9.51.87.255 scope link tr1
>     inet6 fe80::206:29ff:feb0:5963/10 scope link
>     inet6 fe80::6:29b0:5963/10 scope link

Npte that all ipv4 addresses on the system when leaving the system as
locally originated will appear to leave lo first. So to control them
with rules use the following type of structure:

ip rule add from 9.51.81.11 dev lo table 1 prio 10000
ip rule add from 9.51.81.9  dev lo table 2 prio 20000

This will capture all originated traffic (such as host responses to pings
etc...) from each address and send it to a different table. Then you can
populate the tables as needed. 
 
[snip]

> If I change the default route thusly:
> $ ip route add default metric 1 src 9.51.81.11 \
> 	nexthop via 9.51.80.1 dev tr0 nexthop via 9.51.80.1 dev tr1
> 
> Then things work fine, incomming requests are processed as normal, but
> it appears that outgoing requests are always sent via dev tr0

"appears" as in 'ip link sh dev tr1' never increases... or as in a tcpdump
on the ring only shows ip src 9.51.81.11 ? Please supply the info if
possible as I suspect that that both tr interfaces are being used but the
src command is honored thus the src addresses will always look to be tr0. 

IE: look at 'ip -s link show' and see if both tr0 and tr1 are increasing
the packets sent...
 
> If I leave off the src argument, then incomming smtp sessions to dev tr0
> (9.51.81.11) are not properly handled - I'm guessing because the src address
> could be that dev tr1 (9.51.81.9).
> of tr1

Yes. In this case you could try variations on the rules above with both
route tables having the same default route with different src statements
but I suspect that is not exactly what you want.
 
> What am I misunderstanding...  What I was trying to achieve was:
>  *) Incomming requests are handled on whatever interface the're received on
>  *) Outgoing requests are handled on either interface

Your confusion stems from the fact that the ipv4 addresses are _not_
assigned to the interfaces per se but actually 'exist' as a definition of
a service (ipv4 transport) to the machine itself. Consider DECnetIV type
addressing with multiply connected hosts...  
 
> Is this more than can be done via ip route ?

No - but it is usually not seen for two cards connected to the same
physical network ;-}

> -- 
> Rick Nelson
> Life'll kill ya                         -- Warren Zevon
> Then you'll be dead                     -- Life'll kill ya

--------------------------------------------------
Matthew G. Marsh,  President
Paktronix Systems LLC
1506 North 59th Street
Omaha  NE  68104
Phone: (402) 932-7250
Email: mgm@paktronix.com
WWW:  http://www.paktronix.com
--------------------------------------------------

