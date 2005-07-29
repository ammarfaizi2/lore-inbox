Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262526AbVG2LZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262526AbVG2LZc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 07:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbVG2LZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 07:25:31 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:22468 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262496AbVG2LYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 07:24:17 -0400
Date: Fri, 29 Jul 2005 13:23:17 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Denis Vlasenko <vda@ilport.com.ua>
cc: netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       coreteam@netfilter.org, Harald Welte <laforge@netfilter.org>,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>
Subject: Re: iptables redirect is broken on bridged setup
In-Reply-To: <200507291209.37247.vda@ilport.com.ua>
Message-ID: <Pine.LNX.4.61.0507291316140.10775@yvahk01.tjqt.qr>
References: <200507291209.37247.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>iptables -t nat -A PREROUTING -s 172.17.6.44 -d 172.16.42.201 -p tcp --dport 
>9100 -j REDIRECT --to 9123
>
>Chain PREROUTING (policy ACCEPT 0 packets, 0 bytes)
>       0        0 REDIRECT   tcp  --  *      *       172.17.6.44          172.16.42.201      tcp dpt:9100 redir ports 9123
>
>But now I need to bridge together two eth cards in this machine, and
>suddenly redirect is no longer works.

I somehow have to say this is expected behavior. 

>tcpdump on real interface:
>
>10:44:37.964087 172.17.6.44.1385 > 172.16.42.201.9100: S 4092145578:4092145578(0) win 65535 <mss 1460,nop,nop,sackOK> (DF)
>10:44:37.964365 172.17.0.1.9123 > 172.17.6.44.1385: S 520564491:520564491(0) ack 4092145579 win 5840 <mss 1460,nop,nop,sackOK> (DF)
>	reply from wrong address! should be simulated as from 172.16.42.201

Not at all. The interface has more than one addresses, so it is free to choose 
which source address to use - Linux usually takes the first, unless you have 
some routing rules in the route tables.
Your "ip a" output shows 17.0.1 as the first address.

>10:44:37.964493 172.17.6.44.1385 > 172.17.0.1.9123: R 4092145579:4092145579(0) win 0
>	peer didn't understand that

This seems all normal to me, and looks like the port on 17.6.44 is just 
closed.


You also say that the [source or destination?] address should be 16.42.201, 
but why? After all, you are using REDIRECT, not SNAT/DNAT.

>same packets on bridge interface:
>
>10:44:37.964087 172.17.6.44.1385 > 172.17.0.1.9123: S 4092145578:4092145578(0) win 65535 <mss 1460,nop,nop,sackOK> (DF)
>	looks like redirect was done before bridging - dst addr is already changed

redirect, and in fact, the whole iptables-nat table, _is_ done before 
bridging, see http://ebtables.sourceforge.net/br_fw_ia/PacketFlow.png



Jan Engelhardt
-- 
