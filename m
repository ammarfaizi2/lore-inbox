Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932415AbVI3CWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932415AbVI3CWw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVI3CWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:22:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49833 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932415AbVI3CWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:22:50 -0400
Message-Id: <20050930022209.125719000@localhost.localdomain>
References: <20050930022016.640197000@localhost.localdomain>
Date: Thu, 29 Sep 2005 19:20:19 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Stevens <dlstevens@us.ibm.com>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 03/10] [PATCH] fix IPv6 per-socket multicast filtering in exact-match case
Content-Disposition: inline; filename=ipv6-fix-per-socket-multicast-filtering.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

per-socket multicast filters were not being applied to all sockets
in the case of an exact-match bound address, due to an over-exuberant
"return" in the look-up code. Fix below. IPv4 does not have this problem.

Thanks to Hoerdt Mickael for reporting the bug.

Signed-off-by: David L Stevens <dlstevens@us.ibm.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 net/ipv6/udp.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6.13.y/net/ipv6/udp.c
===================================================================
--- linux-2.6.13.y.orig/net/ipv6/udp.c
+++ linux-2.6.13.y/net/ipv6/udp.c
@@ -404,9 +404,8 @@ static struct sock *udp_v6_mcast_next(st
 				continue;
 
 			if (!ipv6_addr_any(&np->rcv_saddr)) {
-				if (ipv6_addr_equal(&np->rcv_saddr, loc_addr))
-					return s;
-				continue;
+				if (!ipv6_addr_equal(&np->rcv_saddr, loc_addr))
+					continue;
 			}
 			if(!inet6_mc_check(s, loc_addr, rmt_addr))
 				continue;

--
