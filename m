Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTGKOz1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbTGKOz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:55:27 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:47876 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S262874AbTGKOzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:55:14 -0400
Message-ID: <3F0ED4B9.9000105@kolumbus.fi>
Date: Fri, 11 Jul 2003 18:16:09 +0300
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mika Liljeberg <mika.liljeberg@welho.com>
CC: Pekka Savola <pekkas@netcore.fi>, Andre Tomt <andre@tomt.net>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
References: <Pine.LNX.4.44.0307111446250.27865-100000@netcore.fi>	 <1057925366.896.24.camel@hades>  <3F0EB227.50403@kolumbus.fi>	 <1057930712.895.32.camel@hades>  <3F0EC96D.6080102@kolumbus.fi> <1057933954.695.6.camel@hades>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 11.07.2003 18:11:18,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 11.07.2003 18:10:43,
	Serialize complete at 11.07.2003 18:10:43
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mika Liljeberg wrote:

>Nope, since the tunnel interface will have 2002::/16. It seems to work
>with the attached patch (against 2.4.21-ac4). A small fix to sit was
>required as well. Look:
>  
>
ok, forgot that...looks ok to me.

--Mika


>hades:~# ifconfig 6to4
>6to4      Link encap:IPv6-in-IPv4
>          inet6 addr: ::213.243.180.94/128 Scope:Compat
>          inet6 addr: 2002:d5f3:b45e::1/16 Scope:Global
>          UP RUNNING NOARP  MTU:1480  Metric:1
>          RX packets:4 errors:0 dropped:0 overruns:0 frame:0
>          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
>          collisions:0 txqueuelen:0
>          RX bytes:416 (416.0 b)  TX bytes:496 (496.0 b)
>
>hades:~# ip -6 route list
>::/96 via :: dev 6to4  metric 256  mtu 1480 advmss 1420
>2002::/16 dev 6to4  proto kernel  metric 256  mtu 1480 advmss 1420
>fe80::/64 dev eth0  proto kernel  metric 256  mtu 1500 advmss 1440
>fe80::/64 dev 6to4  proto kernel  metric 256  mtu 1480 advmss 1420
>ff00::/8 dev eth0  proto kernel  metric 256  mtu 1500 advmss 1440
>ff00::/8 dev 6to4  proto kernel  metric 256  mtu 1480 advmss 1420
>default via 2002:c058:6301:: dev 6to4  metric 1024  mtu 1480 advmss 1420
>hades:~# ping6 -c4 -n www.ipv6.org
>PING www.ipv6.org(2001:6b0:1:ea:a00:20ff:fe8f:708f) 56 data bytes
>64 bytes from 2001:6b0:1:ea:a00:20ff:fe8f:708f: icmp_seq=1 ttl=250 time=207 ms
>64 bytes from 2001:6b0:1:ea:a00:20ff:fe8f:708f: icmp_seq=2 ttl=250 time=206 ms
>64 bytes from 2001:6b0:1:ea:a00:20ff:fe8f:708f: icmp_seq=3 ttl=250 time=177 ms
>64 bytes from 2001:6b0:1:ea:a00:20ff:fe8f:708f: icmp_seq=4 ttl=250 time=78.5 ms
>
>--- www.ipv6.org ping statistics ---
>4 packets transmitted, 4 received, 0% packet loss, time 3030ms
>rtt min/avg/max/mdev = 78.547/167.637/207.698/52.821 ms
>
>Anyone see any problems with this?
>
>	MikaL
>
>  
>
>------------------------------------------------------------------------
>
>--- route.c.org	2003-07-11 16:41:55.000000000 +0300
>+++ route.c	2003-07-11 16:42:16.000000000 +0300
>@@ -743,7 +743,7 @@
> 			   some exceptions. --ANK
> 			 */
> 			err = -EINVAL;
>-			if (!(gwa_type&IPV6_ADDR_UNICAST))
>+			if (!(gwa_type&(IPV6_ADDR_UNICAST|IPV6_ADDR_ANYCAST)))
> 				goto out;
> 
> 			grt = rt6_lookup(gw_addr, NULL, rtmsg->rtmsg_ifindex, 1);
>--- sit.c.org	2003-07-11 16:57:53.000000000 +0300
>+++ sit.c	2003-07-11 17:17:42.000000000 +0300
>@@ -495,10 +495,13 @@
> 			addr_type = ipv6_addr_type(addr6);
> 		}
> 
>-		if ((addr_type & IPV6_ADDR_COMPATv4) == 0)
>-			goto tx_error_icmp;
>+		if ((addr_type & IPV6_ADDR_COMPATv4))
>+			dst = addr6->s6_addr32[3];
>+		else
>+			dst = try_6to4(addr6);
> 
>-		dst = addr6->s6_addr32[3];
>+		if (!dst)
>+			goto tx_error_icmp;
> 	}
> 
> 	if (ip_route_output(&rt, dst, tiph->saddr, RT_TOS(tos), tunnel->parms.link)) {
>  
>


