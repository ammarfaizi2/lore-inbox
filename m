Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbVHDUrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbVHDUrK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbVHDUom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:44:42 -0400
Received: from ip18.tpack.net ([213.173.228.18]:16064 "HELO mail.tpack.net")
	by vger.kernel.org with SMTP id S262673AbVHDUoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:44:12 -0400
Message-ID: <42F27E6D.2030200@tpack.net>
Date: Thu, 04 Aug 2005 22:45:33 +0200
From: Tommy Christensen <tommy.christensen@tpack.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: "David S. Miller" <davem@davemloft.net>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: 2.6.11-rc5 and 2.6.12: cannot transmit anything - more info
References: <200508030947.01901.vda@ilport.com.ua>
In-Reply-To: <200508030947.01901.vda@ilport.com.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> Hi,
> 
> As reported earlier, sometimes my home box don't want
> to send anything.
> 
> # ip r
> 1.1.5.5 dev tun0  proto kernel  scope link  src 1.1.5.6
> 1.1.4.0/24 dev if  proto kernel  scope link  src 1.1.4.6
> default via 1.1.5.5 dev tun0
> # ping 1.1.4.1 -i 0.01

> 2005-08-02_19:12:18.19551 kern.info: qdisc_restart: start, q->dequeue=c03e8662
> 2005-08-02_19:12:19.19536 kern.info: qdisc_restart: start, q->dequeue=c03e8662
> 
> System.map:
> c03e8662 t noop_dequeue
> 
> I guess this explains why I do not see calls to pfifo_fast_dequeue! :)
> But how come my interface is using noop queue, is a mystery to me.

Because link is down.  Or at least the kernel thinks so.

> # ip l
> 1: if: <BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast qlen 1000
>     link/ether 00:0a:e6:7c:dd:79 brd ff:ff:ff:ff:ff:ff
> 2: lo: <LOOPBACK,UP> mtu 16436 qdisc noqueue
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 17: tun0: <POINTOPOINT,MULTICAST,NOARP,UP> mtu 1464 qdisc pfifo_fast qlen 100
>     link/[65534]
> 
> As you can see, ip l reports that iface 'if' uses pfifo_fast, not noop...

Yeah, a bit confusing.  pfifo_fast is the *configured* qdisc, but in this
case it is not the *active* qdisc.  The qdisc is set to noop when carrier
is lost.

> Any ideas?

Try tracking the calls to netif_carrier_on/off.


-Tommy
