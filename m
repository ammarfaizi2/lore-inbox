Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbTETAXh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263276AbTETAXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:23:37 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:34197 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263273AbTETAXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:23:34 -0400
Message-ID: <3EC97889.6040509@nortelnetworks.com>
Date: Mon, 19 May 2003 20:36:25 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Ashley <dash@xdr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem in ARP 2.4.20 kernel
References: <200305162202.h4GM2LGN024925@xdr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Ashley wrote:

> The problem I ran into was the kernel's handling of ARP requests. What linux
> does is each interface receives the arp request, and every single one
> answers the request. So it becomes a race condition which response gets to
> the client, and the client will have usually an incorrect mac address/ip
> address arp entry.

This was hashed through on the list about a year back.  You might try googling 
next time...
This is actually standards compliant behaviour, as silly as it sounds.  However,
if you want stricter arp behaviour, and are using source-based routing, the 
following will fix it.

echo 1 > /proc/sys/net/ipv4/conf/all/arp_filter

Here is an example setup on 2.4.18:

# ip add
1: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
     inet 127.0.0.1/8 brd 127.255.255.255 scope host lo
2: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
     link/ether 00:30:65:bf:46:ba brd ff:ff:ff:ff:ff:ff
     inet 47.129.82.58/24 brd 47.129.82.255 scope global eth0
3: eth1: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 100
     link/ether 00:50:ff:90:04:44 brd ff:ff:ff:ff:ff:ff
     inet 47.129.82.107/24 brd 47.129.82.255 scope global eth1
# ip ru
0:      from all lookup local
32764:  from 47.129.82.107 lookup 101
32765:  from 47.129.82.58 lookup 100
32766:  from all lookup main
32767:  from all lookup 253
# ip ro
47.129.82.0/24 dev eth0  proto kernel  scope link  src 47.129.82.58
47.129.82.0/24 dev eth1  proto kernel  scope link  src 47.129.82.107
127.0.0.0/8 dev lo  scope link
default via 47.129.82.1 dev eth0
# ip ro li table 100
47.129.82.0/24 dev eth0  scope link
default via 47.129.82.1 dev eth0
# ip ro li table 101
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

