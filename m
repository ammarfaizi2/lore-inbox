Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315273AbSDWR16>; Tue, 23 Apr 2002 13:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSDWR15>; Tue, 23 Apr 2002 13:27:57 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:56459 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S315273AbSDWR1y>; Tue, 23 Apr 2002 13:27:54 -0400
Message-ID: <3CC58DF3.A6AB95B1@nortelnetworks.com>
Date: Tue, 23 Apr 2002 12:38:11 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vincent Guffens <guffens@auto.ucl.ac.be>
Cc: "Christopher Friesen" <cfriesen@nortelnetworks.com>,
        Frank Louwers <frank@openminds.be>, linux-kernel@vger.kernel.org
Subject: Re: BUG: 2 NICs on same network
In-Reply-To: <20020423113935.A30329@openminds.be> <3CC55D62.1501C94A@nortelnetworks.com> <20020423172051.A22111@auto.ucl.ac.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Guffens wrote:
> 
> On Tue, Apr 23, 2002 at 09:10:58AM -0400, Chris Friesen wrote:

> > This is actually standards compliant behaviour, as silly as it sounds.  However,
> > if you want stricter arp behaviour I *think* that the following will fix it.  At
> > least it used to...
> >
> > echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter

> I'm looking at that as well and it doesn't look as it solves the problem, in fact I think that the arp_filter is meant to
> insure that the reply will be sent out to the interface where linux would route it, that is to say, the other way around.

Actually, as long as you have your system set up to route based on source
address (which you probably should if you care about strict arp replies)
arp_filter seems to work properly.  I just tested with a 2.4.18 box, with the
following address configuration:


[root@pcary1k5 /]# ip add
1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 brd 127.255.255.255 scope host lo
2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:30:65:bf:46:ba brd ff:ff:ff:ff:ff:ff
    inet 47.129.82.58/24 brd 47.129.82.255 scope global eth0
3: eth1: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
    link/ether 00:50:ff:90:04:44 brd ff:ff:ff:ff:ff:ff
    inet 47.129.82.107/24 brd 47.129.82.255 scope global eth1
[root@pcary1k5 /]# ip ru
0:      from all lookup local
32764:  from 47.129.82.107 lookup 101
32765:  from 47.129.82.58 lookup 100
32766:  from all lookup main
32767:  from all lookup 253
[root@pcary1k5 /]# ip ro
47.129.82.0/24 dev eth0  proto kernel  scope link  src 47.129.82.58
47.129.82.0/24 dev eth1  proto kernel  scope link  src 47.129.82.107
127.0.0.0/8 dev lo  scope link
default via 47.129.82.1 dev eth0
[root@pcary1k5 /]# ip ro li table 100
47.129.82.0/24 dev eth0  scope link
default via 47.129.82.1 dev eth0
[root@pcary1k5 /]# ip ro li table 101
47.129.82.0/24 dev eth1  scope link
default via 47.129.82.1 dev eth1


With this setup, arp requests for 47.129.82.58 will only be answered by eth0,
and similarly for 47.129.82.107 and eth1.

Chris

                                                                             
-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
