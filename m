Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262437AbVE0LDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbVE0LDS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 07:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262438AbVE0LDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 07:03:18 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:62673 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262437AbVE0LDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 07:03:12 -0400
To: linux-kernel@vger.kernel.org
cc: xen-devel@lists.xensource.com, Keir.Fraser@cl.cam.ac.uk,
       cedric@schieli.dyndns.org, coreteam@netfilter.org
Subject: [PATCH] Avoid unncessary checksum validation in TCP/UDP netfilter
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----- =_aaaaaaaaaa0"
Content-ID: <28278.1117191788.0@cl.cam.ac.uk>
Date: Fri, 27 May 2005 12:03:08 +0100
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1DbccR-00063Q-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------- =_aaaaaaaaaa0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28278.1117191788.1@cl.cam.ac.uk>

The TCP/UDP connection-tracking code in netfilter validates the
checksum of incoming packets, to prevent nastier errors further down
the road. This check is unnecessary if the skb is marked as
CHECKSUM_UNNECESSARY. 

This patch will improve performance for networkinterfaces that perform
CHECKSUM_UNNECESSARY-style checksum offload (that's most modern
ones). More importantly (for me :-)) is that this makes netfilter play
nicely with checksum avoidance in the Xen virtual machine
monitor. Inter-domain traffic has no checksum calculated, so
validation checks will fail even though the packet data is good.
Of course, this avoidance relies on the network stack respecting
CHECKSUM_UNNECESSARY.

Signed-off-by: Keir Fraser <Keir.Fraser@xl.cam.ac.uk>


------- =_aaaaaaaaaa0
Content-Type: text/plain; name="net-csum.patch"; charset="us-ascii"
Content-ID: <28278.1117191788.2@cl.cam.ac.uk>
Content-Description: Checksum patch

diff -ur linux-2.6.11/net/ipv4/netfilter/ip_conntrack_proto_tcp.c linux-2.6.11-csum/net/ipv4/netfilter/ip_conntrack_proto_tcp.c
--- linux-2.6.11/net/ipv4/netfilter/ip_conntrack_proto_tcp.c	2005-05-27 11:47:48 +01:00
+++ linux-2.6.11-csum/net/ipv4/netfilter/ip_conntrack_proto_tcp.c	2005-05-27 11:48:07 +01:00
@@ -803,6 +803,7 @@
 	 */
 	/* FIXME: Source route IP option packets --RR */
 	if (hooknum == NF_IP_PRE_ROUTING
+	    && skb->ip_summed != CHECKSUM_UNNECESSARY
 	    && csum_tcpudp_magic(iph->saddr, iph->daddr, tcplen, IPPROTO_TCP,
 			         skb->ip_summed == CHECKSUM_HW ? skb->csum
 			      	 : skb_checksum(skb, iph->ihl*4, tcplen, 0))) {
diff -ur linux-2.6.11/net/ipv4/netfilter/ip_conntrack_proto_udp.c linux-2.6.11-csum/net/ipv4/netfilter/ip_conntrack_proto_udp.c
--- linux-2.6.11/net/ipv4/netfilter/ip_conntrack_proto_udp.c	2005-05-27 11:47:48 +01:00
+++ linux-2.6.11-csum/net/ipv4/netfilter/ip_conntrack_proto_udp.c	2005-05-27 11:48:07 +01:00
@@ -120,6 +120,7 @@
 	 * and moreover root might send raw packets.
 	 * FIXME: Source route IP option packets --RR */
 	if (hooknum == NF_IP_PRE_ROUTING
+	    && skb->ip_summed != CHECKSUM_UNNECESSARY
 	    && csum_tcpudp_magic(iph->saddr, iph->daddr, udplen, IPPROTO_UDP,
 			         skb->ip_summed == CHECKSUM_HW ? skb->csum
 			      	 : skb_checksum(skb, iph->ihl*4, udplen, 0))) {

------- =_aaaaaaaaaa0--
