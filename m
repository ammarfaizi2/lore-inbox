Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVCBBmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVCBBmN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 20:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbVCBBmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 20:42:13 -0500
Received: from rtr-speakeasy.mukesh.agrawals.org ([69.17.59.251]:11242 "EHLO
	slash.mukesh.agrawals.org") by vger.kernel.org with ESMTP
	id S261968AbVCBBmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 20:42:07 -0500
Date: Tue, 1 Mar 2005 20:41:40 -0500 (EST)
From: mukesh agrawal <mukesh@cs.cmu.edu>
X-X-Sender: mukesh@slash.mukesh.agrawals.org
To: coreteam@netfilter.org
cc: trivial@rustcorp.com.au, netfilter-devel@lists.netfilter.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10 1/1] netfilter: fix crash on nat+icmp packets
Message-ID: <Pine.LNX.4.61.0503011830590.31296@slash.mukesh.agrawals.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes a kernel crashing bug when using NAT. The crash occurs in 
the case when we send out a UDP packet to a closed port on another host, 
with the UDP packet being SNATed. The remote host replies with an ICMP 
port unreachable (type 3, code 3). We need to adjust the ICMP packet, 
because the UDP packet was SNATed.

The cause of the crash is that udp_manip_pkt reads *pskb into iph before 
calling skb_ip_make_writable, and fails to update iph after the call. 
Since skb_ip_make_writable may delete the original skb when it makes a 
copy, a page fault may occur when udp_manip_pkt later dereferences iph.

I suspect that normally, the relevant skbuff holds a UDP packet, and 
either the skbuff is unshared (so no copy is made, and the skbuff 
remains valid), or is shared, but remains so while udp_manip_pkt is 
running (and hence, the old reference to the skbuff is still okay).

When we get an ICMP reply for a SNATed UDP packet, ip_nat_proto_udp is 
asked to modify the UDP header inside the payload of the ICMP packet. (The 
call chain is ip_nat_fn -> icmp_reply_translation -> ip_nat_manip_pkt -> 
udp_manip_pkt.)

Since the UDP header is beyond the ICMP header, skb_ip_make_writable 
copies the skbuff, and deletes the original. Then udp_manip_pkt's iph is 
invalid, and dereferencing it causes a page fault.

Glancing at the code for tcp_manip_pkt, I think it would have the same 
problem, but I haven't tested that case. The patch below fixes the UDP 
case only.

(For the record, my kernel tree also has the tproxy patch from 
http://www.balabit.com/downloads/tproxy/linux-2.4/cttproxy-2.6.10-2.0.0.tar.gz 
applied. But I think this bug is independent of that patch.)

diff -uprN linux-2.6.10.orig/net/ipv4/netfilter/ip_nat_proto_udp.c linux-2.6.10.fixed/net/ipv4/netfilter/ip_nat_proto_udp.c
--- linux-2.6.10.orig/net/ipv4/netfilter/ip_nat_proto_udp.c	2004-12-24 16:34:01.000000000 -0500
+++ linux-2.6.10.fixed/net/ipv4/netfilter/ip_nat_proto_udp.c	2005-03-01 19:32:21.000000000 -0500
@@ -95,6 +95,9 @@ udp_manip_pkt(struct sk_buff **pskb,

  	if (!skb_ip_make_writable(pskb, hdroff + sizeof(hdr)))
  		return 0;
+	/* skb_ip_make_writable may have copied the skb, and deleted
+	   the original */
+	iph = (struct iphdr *)((*pskb)->data + iphdroff);

  	hdr = (void *)(*pskb)->data + hdroff;
  	if (maniptype == IP_NAT_MANIP_SRC) {
