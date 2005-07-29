Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbVG2MMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbVG2MMV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 08:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbVG2MMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 08:12:21 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:39608 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262569AbVG2MMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 08:12:12 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: iptables redirect is broken on bridged setup
Date: Fri, 29 Jul 2005 15:11:35 +0300
User-Agent: KMail/1.5.4
Cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       coreteam@netfilter.org, Harald Welte <laforge@netfilter.org>,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>
References: <200507291209.37247.vda@ilport.com.ua> <Pine.LNX.4.61.0507291316140.10775@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0507291316140.10775@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507291511.35081.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 July 2005 14:23, Jan Engelhardt wrote:
> 
> >iptables -t nat -A PREROUTING -s 172.17.6.44 -d 172.16.42.201 -p tcp --dport 
> >9100 -j REDIRECT --to 9123
> >
> >Chain PREROUTING (policy ACCEPT 0 packets, 0 bytes)
> >       0        0 REDIRECT   tcp  --  *      *       172.17.6.44          172.16.42.201      tcp dpt:9100 redir ports 9123
> >
> >But now I need to bridge together two eth cards in this machine, and
> >suddenly redirect is no longer works.
> 
> I somehow have to say this is expected behavior. 
> 
> >tcpdump on real interface:
> >
> >10:44:37.964087 172.17.6.44.1385 > 172.16.42.201.9100: S 4092145578:4092145578(0) win 65535 <mss 1460,nop,nop,sackOK> (DF)
> >10:44:37.964365 172.17.0.1.9123 > 172.17.6.44.1385: S 520564491:520564491(0) ack 4092145579 win 5840 <mss 1460,nop,nop,sackOK> (DF)
> >	reply from wrong address! should be simulated as from 172.16.42.201
> 
> Not at all. The interface has more than one addresses, so it is free to choose 
> which source address to use - Linux usually takes the first, unless you have 
> some routing rules in the route tables.
> Your "ip a" output shows 17.0.1 as the first address.

This is true for connectionless UDP, but not for TCP.
For TCP, answer always comes from address where original
SYN request was directed.
 
> >10:44:37.964493 172.17.6.44.1385 > 172.17.0.1.9123: R 4092145579:4092145579(0) win 0
> >	peer didn't understand that
> 
> This seems all normal to me, and looks like the port on 17.6.44 is just 
> closed.
> 
> You also say that the [source or destination?] address should be 16.42.201, 
> but why? After all, you are using REDIRECT, not SNAT/DNAT.

REDIRECT is a form of DNAT.

You seem to misunderstand what is going on.
172.17.6.44 tries to connect to 172.16.42.201:9000 via TCP.
Packets go thru this box, which acts as a router.
REDIRECT causes this to be directed to local process listening on port 9123.
Any reply packets from local process are NATed so that 172.17.6.44
sees "faked" src address of 172.16.42.201 and not my local one, 172.17.0.1.

This works just fine on many of machines I have here.
This worked just fine on the machine I have problem with. It had two IP addrs
long before, and it worked.

It stopped working only when I created a bridge and added the only active
iface (ifi) to it. Basically, "reply packets from local process are NATed
so that 172.17.6.44 sees faked src address" does not happen anymore.
 
> >same packets on bridge interface:
> >
> >10:44:37.964087 172.17.6.44.1385 > 172.17.0.1.9123: S 4092145578:4092145578(0) win 65535 <mss 1460,nop,nop,sackOK> (DF)
> >	looks like redirect was done before bridging - dst addr is already changed
> 
> redirect, and in fact, the whole iptables-nat table, _is_ done before 
> bridging, see http://ebtables.sourceforge.net/br_fw_ia/PacketFlow.png

BTW, I filed the bug into bugzilla:
https://bugzilla.netfilter.org/bugzilla/show_bug.cgi?id=365

Note that REDIRECT loads ip_conntrack, and this seem to
cause problems, see another bugzilla entry at
https://bugzilla.netfilter.org/bugzilla/show_bug.cgi?id=339
--
vda

