Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbTBILBO>; Sun, 9 Feb 2003 06:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267209AbTBILBO>; Sun, 9 Feb 2003 06:01:14 -0500
Received: from packet.digeo.com ([12.110.80.53]:58816 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267208AbTBILBN>;
	Sun, 9 Feb 2003 06:01:13 -0500
Date: Sun, 9 Feb 2003 03:10:54 -0800
From: Andrew Morton <akpm@digeo.com>
To: Florian Schmitt <florian@galois.de>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: routing oddity in 2.5.59-mm8
Message-Id: <20030209031054.2b9ae2a2.akpm@digeo.com>
In-Reply-To: <200302091154.13187.florian@galois.de>
References: <200302091154.13187.florian@galois.de>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Feb 2003 11:10:50.0203 (UTC) FILETIME=[E74512B0:01C2D02B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schmitt <florian@galois.de> wrote:
>
> in 2.5.59-mm8 the routing table behaves a bit strange:

me too:

vmm:/home/akpm# ip route show
192.168.2.0/24 dev eth0  scope link 
127.0.0.0/8 dev lo  scope link 
default via 192.168.2.1 dev eth0 
vmm:/home/akpm# route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.2.0     0.0.0.0         255.255.255.0   U     0      0        0 eth0
127.0.0.0       0.0.0.0         255.0.0.0       U     0      0        0 lo
vmm:/home/akpm# route del default
vmm:/home/akpm# route del default
SIOCDELRT: No such process

So `ip' can see the default route, but `route' cannot.

Reverting the spurious semicolon fix fixes it up.

diff -puN net/ipv4/fib_hash.c~a net/ipv4/fib_hash.c
--- 25/net/ipv4/fib_hash.c~a	2003-02-09 03:04:29.000000000 -0800
+++ 25-akpm/net/ipv4/fib_hash.c	2003-02-09 03:04:32.000000000 -0800
@@ -941,7 +941,7 @@ static __inline__ struct fib_node *fib_g
 
 			if (!iter->zone)
 				goto out;
-			if (iter->zone->fz_next)
+			if (iter->zone->fz_next);
 				break;
 		}
 		

_

