Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284144AbRLTLSG>; Thu, 20 Dec 2001 06:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284181AbRLTLR5>; Thu, 20 Dec 2001 06:17:57 -0500
Received: from unamed.infotel.bg ([212.39.68.18]:57095 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id <S284144AbRLTLRl>;
	Thu, 20 Dec 2001 06:17:41 -0500
Date: Thu, 20 Dec 2001 13:21:30 +0200 (EET)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: <ja@l>
To: bert hubert <ahu@ds9a.nl>
cc: <kuznet@ms2.inr.ac.ru>, <netdev@oss.sgi.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [BUG/WANT TO FIX] Equal Cost Multipath Broken in 2.4.x
In-Reply-To: <20011220112728.A11112@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.33.0112201316210.4670-100000@l>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Thu, 20 Dec 2001, bert hubert wrote:

>  # ip ro add dev eth0 default nexthop via 10.0.0.1 dev eth0 nexthop via
>    10.0.0.202 dev eth0
>  # ip ro ls
>  10.0.0.0/8 dev eth0  proto kernel  scope link  src 10.0.0.11
>  default
>  	nexthop via 10.0.0.1  dev eth0 weight 1 dead
>  	nexthop via 10.0.0.202  dev eth0 weight 1
>
> 10.0.0.1 however is far from dead, if we add yet another nexthop:
>
>  # ip ro add dev eth0 default nexthop via 10.10.10.10 dev eth0 nexthop via
>    10.0.0.1 dev eth0 nexthop via 10.0.0.202 dev eth0
>
>  # ip ro ls
>  10.0.0.0/8 dev eth0  proto kernel  scope link  src 10.0.0.11
>  default
>  	nexthop via 10.10.10.10  dev eth0 weight 1 dead
>  	nexthop via 10.0.0.1  dev eth0 weight 1
>  	nexthop via 10.0.0.202  dev eth0 weight 1
>
> This first nexthop is *always* declared dead. Linux 2.4.x, iproute 20010824.
>
> If anybody can point me in the direction of this problem, it must be known
> as it has been there for a *long* time, it would be appreciated. I'll try to

	Yes, I remember people to report for this problem for long
time but I was not able to reproduce it. May be it could be fixed
with the following change (only compiled):

--- iproute2/ip/iproute.c.orig	Mon Aug  6 03:31:52 2001
+++ iproute2/ip/iproute.c	Thu Dec 20 13:14:06 2001
@@ -620,6 +620,8 @@
 		}
 		rtnh->rtnh_len = sizeof(*rtnh);
 		rtnh->rtnh_ifindex = 0;
+		rtnh->rtnh_flags = 0;
+		rtnh->rtnh_hops = 0;
 		rta->rta_len += rtnh->rtnh_len;
 		parse_one_nh(rta, rtnh, &argc, &argv);
 		rtnh = RTNH_NEXT(rtnh);

> fix it.
>
> Thanks!
>
> Regards,
>
> bert

Regards

--
Julian Anastasov <ja@ssi.bg>

