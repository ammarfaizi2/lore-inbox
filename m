Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262311AbTCHXjX>; Sat, 8 Mar 2003 18:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262312AbTCHXjX>; Sat, 8 Mar 2003 18:39:23 -0500
Received: from host217-35-60-74.in-addr.btopenworld.com ([217.35.60.74]:55424
	"EHLO dstc.edu.au") by vger.kernel.org with ESMTP
	id <S262311AbTCHXjS>; Sat, 8 Mar 2003 18:39:18 -0500
Message-Id: <200303082349.h28Nnpc09298@tereshkova.dstc.edu.au>
To: linux-kernel@vger.kernel.org
X-face: -[YGaR`*}M3pOPceHtP0Bb{\f!h4e?n{mXfI@DMKL-:8
Subject: [PATCH] 2.5.64 multicast: find interface correctly
Date: Sat, 08 Mar 2003 23:49:51 +0000
From: Ted Phelps <phelps@dstc.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Joining a multicast group (IP_ADD_MEMBERSHIP) with the imr_interface
set to INADDR_ANY binds to the loopback interface.  This differs from
the 2.4 behavior and appears to be because ip_mc_find_dev() calls
ip_route_output_key() with the interface address (0.0.0.0) rather than
the multicast address (which 2.4 kernels use).  The following patch
reverts to the linux-2.4 behavior.

Thanks,
-Ted

---8<---

--- linux-2.5.63/net/ipv4/igmp.c	2003-02-26 22:28:36.000000000 +0000
+++ linux-2.5.64/net/ipv4/igmp.c	2003-03-08 22:52:38.000000000 +0000
@@ -618,6 +618,7 @@
 		__dev_put(dev);
 	}
 
+	fl.nl_u.ip4_u.daddr = imr->imr_multiaddr.s_addr;
 	if (!dev && !ip_route_output_key(&rt, &fl)) {
 		dev = rt->u.dst.dev;
 		ip_rt_put(rt);
