Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbTGKOTH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 10:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTGKOS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 10:18:29 -0400
Received: from cs180094.pp.htv.fi ([213.243.180.94]:4992 "EHLO hades.pp.htv.fi")
	by vger.kernel.org with ESMTP id S262179AbTGKOSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 10:18:05 -0400
Subject: Re: 2.4.21+ - IPv6 over IPv4 tunneling b0rked
From: Mika Liljeberg <mika.liljeberg@welho.com>
To: Mika =?ISO-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: Pekka Savola <pekkas@netcore.fi>, Andre Tomt <andre@tomt.net>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <3F0EC96D.6080102@kolumbus.fi>
References: <Pine.LNX.4.44.0307111446250.27865-100000@netcore.fi>
	 <1057925366.896.24.camel@hades>  <3F0EB227.50403@kolumbus.fi>
	 <1057930712.895.32.camel@hades>  <3F0EC96D.6080102@kolumbus.fi>
Content-Type: multipart/mixed; boundary="=-DKIDlaIdFwiWn2TE4NdP"
Message-Id: <1057933954.695.6.camel@hades>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jul 2003 17:32:34 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DKIDlaIdFwiWn2TE4NdP
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-07-11 at 17:27, Mika Penttil=E4 wrote:
> afaics, ipv6_addr_type() checks just for some rfc-specified reserved=20
> anycast addresses, not the ones in device list. Anyway, it will surely=20
> also bail out from the loopback test (anycast subnet router address is=20
> ours).

Nope, since the tunnel interface will have 2002::/16. It seems to work
with the attached patch (against 2.4.21-ac4). A small fix to sit was
required as well. Look:

hades:~# ifconfig 6to4
6to4      Link encap:IPv6-in-IPv4
          inet6 addr: ::213.243.180.94/128 Scope:Compat
          inet6 addr: 2002:d5f3:b45e::1/16 Scope:Global
          UP RUNNING NOARP  MTU:1480  Metric:1
          RX packets:4 errors:0 dropped:0 overruns:0 frame:0
          TX packets:4 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:416 (416.0 b)  TX bytes:496 (496.0 b)

hades:~# ip -6 route list
::/96 via :: dev 6to4  metric 256  mtu 1480 advmss 1420
2002::/16 dev 6to4  proto kernel  metric 256  mtu 1480 advmss 1420
fe80::/64 dev eth0  proto kernel  metric 256  mtu 1500 advmss 1440
fe80::/64 dev 6to4  proto kernel  metric 256  mtu 1480 advmss 1420
ff00::/8 dev eth0  proto kernel  metric 256  mtu 1500 advmss 1440
ff00::/8 dev 6to4  proto kernel  metric 256  mtu 1480 advmss 1420
default via 2002:c058:6301:: dev 6to4  metric 1024  mtu 1480 advmss 1420
hades:~# ping6 -c4 -n www.ipv6.org
PING www.ipv6.org(2001:6b0:1:ea:a00:20ff:fe8f:708f) 56 data bytes
64 bytes from 2001:6b0:1:ea:a00:20ff:fe8f:708f: icmp_seq=3D1 ttl=3D250 time=
=3D207 ms
64 bytes from 2001:6b0:1:ea:a00:20ff:fe8f:708f: icmp_seq=3D2 ttl=3D250 time=
=3D206 ms
64 bytes from 2001:6b0:1:ea:a00:20ff:fe8f:708f: icmp_seq=3D3 ttl=3D250 time=
=3D177 ms
64 bytes from 2001:6b0:1:ea:a00:20ff:fe8f:708f: icmp_seq=3D4 ttl=3D250 time=
=3D78.5 ms

--- www.ipv6.org ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3030ms
rtt min/avg/max/mdev =3D 78.547/167.637/207.698/52.821 ms

Anyone see any problems with this?

	MikaL


--=-DKIDlaIdFwiWn2TE4NdP
Content-Disposition: attachment; filename=6to4.udiff
Content-Type: text/plain; name=6to4.udiff; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

--- route.c.org	2003-07-11 16:41:55.000000000 +0300
+++ route.c	2003-07-11 16:42:16.000000000 +0300
@@ -743,7 +743,7 @@
 			   some exceptions. --ANK
 			 */
 			err =3D -EINVAL;
-			if (!(gwa_type&IPV6_ADDR_UNICAST))
+			if (!(gwa_type&(IPV6_ADDR_UNICAST|IPV6_ADDR_ANYCAST)))
 				goto out;
=20
 			grt =3D rt6_lookup(gw_addr, NULL, rtmsg->rtmsg_ifindex, 1);
--- sit.c.org	2003-07-11 16:57:53.000000000 +0300
+++ sit.c	2003-07-11 17:17:42.000000000 +0300
@@ -495,10 +495,13 @@
 			addr_type =3D ipv6_addr_type(addr6);
 		}
=20
-		if ((addr_type & IPV6_ADDR_COMPATv4) =3D=3D 0)
-			goto tx_error_icmp;
+		if ((addr_type & IPV6_ADDR_COMPATv4))
+			dst =3D addr6->s6_addr32[3];
+		else
+			dst =3D try_6to4(addr6);
=20
-		dst =3D addr6->s6_addr32[3];
+		if (!dst)
+			goto tx_error_icmp;
 	}
=20
 	if (ip_route_output(&rt, dst, tiph->saddr, RT_TOS(tos), tunnel->parms.lin=
k)) {

--=-DKIDlaIdFwiWn2TE4NdP--
