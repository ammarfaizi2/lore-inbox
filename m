Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264550AbUF1ACN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbUF1ACN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 20:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264560AbUF1ACN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 20:02:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18948 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264550AbUF1ACE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 20:02:04 -0400
Date: Mon, 28 Jun 2004 01:02:01 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Fwd: 2.6.6: IPv6 initialisation bug
Message-ID: <20040628010200.A15067@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	netdev@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I've just tried 2.6.7 out on my root-NFS'd firewall with IPv6 built
in, and it doesn't work because of the problem I described below.

Unfortunately, it's impossible to add the missing "local" routes
using /sbin/ip:

ip add route local fe80::a00:2bff:fe95:1d7b via :: dev eth0

results in an "unreachable" route being added for that address rather
than a local route.

What's the solution?

Is there a good reason why IPv6 uses the loopback device for local
routes?

(I'm copying lkml this time since afaik netdev ignored the previous
message.)

----- Forwarded message from Russell King <rmk@arm.linux.org.uk> -----
Date: Tue, 18 May 2004 16:46:44 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: netdev@oss.sgi.com
Subject: 2.6.6: IPv6 initialisation bug

Hi,

I think I've found an IPv6 initialisation bug which occurs when IPv6
is modular, and you insert this module when eth0 is up and running,
but lo may be down.

IPv6 appears to create routes for addresses which are defined as
"local" (eg, link local, addresses assigned to the host etc) using
the loopback device.

However, if the ipv6 module is loaded when lo is down and some other
interface is up (eg, in the case of a root-NFS box), then things fall
apart.

bash-2.04# ip -6 addr
1: eth0: <BROADCAST,MULTICAST,UP> mtu 1500 qlen 1000
    inet6 fec0::1:a00:2bff:fe00:193/64 scope site dynamic
       valid_lft 2591630sec preferred_lft 604430sec
    inet6 2002:xxxx:xxxx:xxxx:a00:2bff:fe00:193/64 scope global dynamic
       valid_lft 2591630sec preferred_lft 604430sec
    inet6 fe80::a00:2bff:fe00:193/64 scope link
       valid_lft forever preferred_lft forever
2: lo: <LOOPBACK,UP> mtu 16436
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
bash-2.04# ip -6 route show table all
local ::1 via :: dev lo  proto none  metric 0  mtu 16436 advmss 16376
unreachable ::/96 dev lo  metric 1024  error -101 mtu 16436 advmss 16376
unreachable ::ffff:0.0.0.0/96 dev lo  metric 1024  error -101 mtu 16436 advmss 16376
unreachable 2002:a00::/24 dev lo  metric 1024  error -101 mtu 16436 advmss 16376
unreachable 2002:7f00::/24 dev lo  metric 1024  error -101 mtu 16436 advmss 16376
unreachable 2002:a9fe::/32 dev lo  metric 1024  error -101 mtu 16436 advmss 16376
unreachable 2002:ac10::/28 dev lo  metric 1024  error -101 mtu 16436 advmss 16376
unreachable 2002:c0a8::/32 dev lo  metric 1024  error -101 mtu 16436 advmss 16376
2002:xxxx:xxxx:xxxx::/64 dev eth0  proto kernel  metric 256  expires 2591712sec mtu 1500 advmss 1440
unreachable 2002:e000::/19 dev lo  metric 1024  error -101 mtu 16436 advmss 16376
unreachable 3ffe:ffff::/32 dev lo  metric 1024  error -101 mtu 16436 advmss 16376
fe80::/64 dev eth0  metric 256  mtu 1500 advmss 1440
fec0:0:0:1::/64 dev eth0  proto kernel  metric 256  expires 2591712sec mtu 1500 advmss 1440
ff02::1 via ff02::1 dev eth0  metric 0
    cache  mtu 1500 advmss 1440
ff00::/8 dev eth0  metric 256  mtu 1500 advmss 1440
unreachable default dev lo  proto none  metric -1  error -101

As you can see, we're missing the local routes for all our addresses
against "eth0" - because we tried to add them to the IPv6 routing
table when "lo" was down.

The result is rather distasteful on the network - we start hammering
the local segment with neighbour solicitations for our link local and
global addresses, as well as sending neighbour solicitations for other
nodes addresses.  We receive neighbour advertisment replies, but because
we believe we don't own our own address, we forward them back out the
same interface triggering yet more neighbour solicitations for our own
addresses.

So... what's the solution for nodes running off root-NFS where "lo"
will always be brought up _after_ some other interface?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core

----- End forwarded message -----

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
