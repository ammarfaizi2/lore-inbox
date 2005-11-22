Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965200AbVKVVKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbVKVVKN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbVKVVJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:09:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35998 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965188AbVKVVHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:07:47 -0500
Date: Tue, 22 Nov 2005 13:06:50 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Harald Welte <laforge@netfilter.org>,
       Yasuyuki Kozakai <yasuyuki.kozakai@toshiba.co.jp>
Subject: [patch 10/23] [PATCH] [NETFILTER] refcount leak of proto when ctnetlink dumping tuple
Message-ID: <20051122210650.GK28140@shell0.pdx.osdl.net>
References: <20051122205223.099537000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="recount-leak-of-proto-when-ctnetlink-dumping-tuple.patch"
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

---
 net/ipv4/netfilter/ip_conntrack_netlink.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- linux-2.6.14.2.orig/net/ipv4/netfilter/ip_conntrack_netlink.c
+++ linux-2.6.14.2/net/ipv4/netfilter/ip_conntrack_netlink.c
@@ -58,14 +58,17 @@ ctnetlink_dump_tuples_proto(struct sk_bu
 			    const struct ip_conntrack_tuple *tuple)
 {
 	struct ip_conntrack_protocol *proto;
+	int ret = 0;
 
 	NFA_PUT(skb, CTA_PROTO_NUM, sizeof(u_int8_t), &tuple->dst.protonum);
 
 	proto = ip_conntrack_proto_find_get(tuple->dst.protonum);
-	if (proto && proto->tuple_to_nfattr)
-		return proto->tuple_to_nfattr(skb, tuple);
+	if (likely(proto && proto->tuple_to_nfattr)) {
+		ret = proto->tuple_to_nfattr(skb, tuple);
+		ip_conntrack_proto_put(proto);
+	}
 
-	return 0;
+	return ret;
 
 nfattr_failure:
 	return -1;

--
