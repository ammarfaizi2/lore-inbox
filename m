Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932539AbVI3CZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbVI3CZA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbVI3CXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:23:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2474 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932539AbVI3CXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:23:18 -0400
Message-Id: <20050930022239.411732000@localhost.localdomain>
References: <20050930022016.640197000@localhost.localdomain>
Date: Thu, 29 Sep 2005 19:20:23 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>,
       Mitsuru KANDA <mk@linux-ipv6.org>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 07/10] [PATCH] check connect(2) status for IPv6 UDP socket
Content-Disposition: inline; filename=check-connect-status-for-IPv6-UDP-socket.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

I think we should cache the per-socket route(dst_entry) only when the
IPv6 UDP socket is connect(2)'ed.
(which is same as IPv4 UDP send behavior)

Signed-off-by: Mitsuru KANDA <mk@linux-ipv6.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 net/ipv6/udp.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

Index: linux-2.6.13.y/net/ipv6/udp.c
===================================================================
--- linux-2.6.13.y.orig/net/ipv6/udp.c
+++ linux-2.6.13.y/net/ipv6/udp.c
@@ -638,6 +638,7 @@ static int udpv6_sendmsg(struct kiocb *i
 	int hlimit = -1;
 	int corkreq = up->corkflag || msg->msg_flags&MSG_MORE;
 	int err;
+	int connected = 0;
 
 	/* destination address check */
 	if (sin6) {
@@ -747,6 +748,7 @@ do_udp_sendmsg:
 		fl->fl_ip_dport = inet->dport;
 		daddr = &np->daddr;
 		fl->fl6_flowlabel = np->flow_label;
+		connected = 1;
 	}
 
 	if (!fl->oif)
@@ -769,6 +771,7 @@ do_udp_sendmsg:
 		}
 		if (!(opt->opt_nflen|opt->opt_flen))
 			opt = NULL;
+		connected = 0;
 	}
 	if (opt == NULL)
 		opt = np->opt;
@@ -787,10 +790,13 @@ do_udp_sendmsg:
 		ipv6_addr_copy(&final, &fl->fl6_dst);
 		ipv6_addr_copy(&fl->fl6_dst, rt0->addr);
 		final_p = &final;
+		connected = 0;
 	}
 
-	if (!fl->oif && ipv6_addr_is_multicast(&fl->fl6_dst))
+	if (!fl->oif && ipv6_addr_is_multicast(&fl->fl6_dst)) {
 		fl->oif = np->mcast_oif;
+		connected = 0;
+	}
 
 	err = ip6_dst_lookup(sk, &dst, fl);
 	if (err)
@@ -841,7 +847,7 @@ do_append_data:
 	else if (!corkreq)
 		err = udp_v6_push_pending_frames(sk, up);
 
-	if (dst)
+	if (dst&&connected)
 		ip6_dst_store(sk, dst,
 			      ipv6_addr_equal(&fl->fl6_dst, &np->daddr) ?
 			      &np->daddr : NULL);

--
