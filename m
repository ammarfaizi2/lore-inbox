Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265198AbUFXTmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265198AbUFXTmO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 15:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264826AbUFXTmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 15:42:14 -0400
Received: from stingr.net ([212.193.32.15]:11696 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S265198AbUFXTkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 15:40:42 -0400
Date: Thu, 24 Jun 2004 23:40:39 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: [RFC] How to implement wccp over gre tunnel ?
Message-ID: <20040624194039.GA19574@stingr.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-net@vger.kernel.org, netdev@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Currently my goal is to make squid + wccp configuration working
out-of-the box. Ideally - without any extra modules.
I suspect that to be accepted into mainline implementation of it must
be as clean as possible :)

Currently, most wccp configurations are working with this module:
http://www.squid-cache.org/WCCP-support/Linux/ip_wccp.c

For things to work we need to get stream of packets redirected from
router, as standard non-encapsulated packets, and feed it into ip
filter.
The problem is router-side wccp algorithm. Instead of doing simple gre
encapsulation, wccp does the following:
1. Change protocol from ETH_P_IP (0x0800) to 0x883E
2. if it is wccp2, then add 4 bytes of flags

So, on receiver side, we need to do reverse thing.

Module I mentioned earlier inspects all GRE protocol packets, checking
bytes where proto value of it's payload (e.g. encapsulated packet)
reside, and if it's 0x883E, then it strips gre header, strips wccp2
flags (if exist), and requeue packets on any suitable interface (if I
understood that skb->dst = NULL correctly).
This works, actually, but (a) we cannot control local-remote of gre
tunnel, (b) we cannot determine is that packet from router or from
network itself and (c) when we have 2 or more routers turned to
different ip's on one host it is complete mess.

When we, instead of using this module, properly configuring gre tunnel
between host and router, we starting getting packets with proto 0x883E
and probably (for wccp2) 4 extra bytes after proto field. Of course
this traffic is useless.

I am thinking about making decapsulated AND reconstructed (wrt proto
and wccp2 flags) packets appear on gre tunnel interface. This goal can
be implemented by following approaches:

1. Hack ip_gre.c. Add some sysctl to it, or maybe add possibility to
set specific flags on individual interfaces. When flag is set - ip_gre
rx routine parses wccp packets and converts it to acceptable ip.

2. Write module, with 0x883E protocol handler inside. That rx routine
should replace 0x883E with P_IP, check and strip v2 flags, and requeue
packet on interface where it arrived first.
This can be complemented with some settable flag specifying on which
interfaces it should do that translation.

What do you think? Which way I should do?

P.S. IIRC approach (1) is implemented inf FreeBSD.

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
