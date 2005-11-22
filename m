Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965205AbVKVVKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbVKVVKX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965206AbVKVVKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:10:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44959 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965199AbVKVVKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:10:02 -0500
Date: Tue, 22 Nov 2005 13:08:04 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Harald Welte <laforge@netfilter.org>,
       Krzysztof Piotr Oledzki <ole@ans.pl>,
       Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [patch 13/23] [PATCH] [NETFILTER] ctnetlink: Fix oops when no ICMP ID info in message
Message-ID: <20051122210804.GN28140@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ctnetlink-fix-oops-when-no-icpm-id-info-in-message.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

This patch fixes an userspace triggered oops. If there is no ICMP_ID
info the reference to attr will be NULL.

Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Harald Welte <laforge@netfilter.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 net/ipv4/netfilter/ip_conntrack_proto_icmp.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- linux-2.6.14.2.orig/net/ipv4/netfilter/ip_conntrack_proto_icmp.c
+++ linux-2.6.14.2/net/ipv4/netfilter/ip_conntrack_proto_icmp.c
@@ -151,13 +151,13 @@ icmp_error_message(struct sk_buff *skb,
 	/* Not enough header? */
 	inside = skb_header_pointer(skb, skb->nh.iph->ihl*4, sizeof(_in), &_in);
 	if (inside == NULL)
-		return NF_ACCEPT;
+		return -NF_ACCEPT;
 
 	/* Ignore ICMP's containing fragments (shouldn't happen) */
 	if (inside->ip.frag_off & htons(IP_OFFSET)) {
 		DEBUGP("icmp_error_track: fragment of proto %u\n",
 		       inside->ip.protocol);
-		return NF_ACCEPT;
+		return -NF_ACCEPT;
 	}
 
 	innerproto = ip_conntrack_proto_find_get(inside->ip.protocol);
@@ -166,7 +166,7 @@ icmp_error_message(struct sk_buff *skb,
 	if (!ip_ct_get_tuple(&inside->ip, skb, dataoff, &origtuple, innerproto)) {
 		DEBUGP("icmp_error: ! get_tuple p=%u", inside->ip.protocol);
 		ip_conntrack_proto_put(innerproto);
-		return NF_ACCEPT;
+		return -NF_ACCEPT;
 	}
 
 	/* Ordinarily, we'd expect the inverted tupleproto, but it's
@@ -174,7 +174,7 @@ icmp_error_message(struct sk_buff *skb,
 	if (!ip_ct_invert_tuple(&innertuple, &origtuple, innerproto)) {
 		DEBUGP("icmp_error_track: Can't invert tuple\n");
 		ip_conntrack_proto_put(innerproto);
-		return NF_ACCEPT;
+		return -NF_ACCEPT;
 	}
 	ip_conntrack_proto_put(innerproto);
 
@@ -190,7 +190,7 @@ icmp_error_message(struct sk_buff *skb,
 
 		if (!h) {
 			DEBUGP("icmp_error_track: no match\n");
-			return NF_ACCEPT;
+			return -NF_ACCEPT;
 		}
 		/* Reverse direction from that found */
 		if (DIRECTION(h) != IP_CT_DIR_REPLY)
@@ -296,7 +296,8 @@ static int icmp_nfattr_to_tuple(struct n
 				struct ip_conntrack_tuple *tuple)
 {
 	if (!tb[CTA_PROTO_ICMP_TYPE-1]
-	    || !tb[CTA_PROTO_ICMP_CODE-1])
+	    || !tb[CTA_PROTO_ICMP_CODE-1]
+	    || !tb[CTA_PROTO_ICMP_ID-1])
 		return -1;
 
 	tuple->dst.u.icmp.type = 

--
