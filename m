Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbTA0Wca>; Mon, 27 Jan 2003 17:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263794AbTA0Wca>; Mon, 27 Jan 2003 17:32:30 -0500
Received: from server2.h07.org ([217.172.178.252]:44689 "EHLO server2.h07.org")
	by vger.kernel.org with ESMTP id <S263760AbTA0Wc2>;
	Mon, 27 Jan 2003 17:32:28 -0500
Date: Mon, 27 Jan 2003 23:40:56 +0100
From: Thomas Walpuski <thomas@bender.thinknerd.de>
To: davem@nuts.ninka.net, kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org
Subject: bugfix for xfrm user interface
Message-ID: <20030127224056.GA317@server2.h07.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By playing around with the xfrm user interface I found two bugs.

The xfrm user interface does not transmit authentication and/or
encryption keys, when it is asked for via netlink-sockets. IMO the keys
should be transmitted at least for debugging purpose.

ATM it's impossible to make the kernel dump all security policies via
netlink-sockets due to a semantic error in xfrm_user_rcv_msg().

The following patch fixes both issues:

--- /usr/src/linux/net/ipv4/xfrm_user.c.orig	2003-01-16 19:44:49.000000000 +0100
+++ /usr/src/linux/net/ipv4/xfrm_user.c	2003-01-16 20:41:54.000000000 +0100
@@ -276,9 +276,11 @@
 	copy_to_user_state(x, p);
 
 	if (x->aalg)
-		RTA_PUT(skb, XFRMA_ALG_AUTH, sizeof(*(x->aalg)), x->aalg);
+		RTA_PUT(skb, XFRMA_ALG_AUTH,
+			sizeof(*(x->aalg))+(x->aalg->alg_key_len+7)/8, x->aalg);
 	if (x->ealg)
-		RTA_PUT(skb, XFRMA_ALG_CRYPT, sizeof(*(x->ealg)), x->ealg);
+		RTA_PUT(skb, XFRMA_ALG_CRYPT,
+			sizeof(*(x->ealg))+(x->ealg->alg_key_len+7)/8, x->ealg);
 	if (x->calg)
 		RTA_PUT(skb, XFRMA_ALG_COMP, sizeof(*(x->calg)), x->calg);
 
@@ -655,6 +657,7 @@
 	info.in_skb = cb->skb;
 	info.out_skb = skb;
 	info.nlmsg_seq = cb->nlh->nlmsg_seq;
+	info.this_idx = 0;
 	info.start_idx = cb->args[0];
 	(void) xfrm_policy_walk(dump_one_policy, &info);
 	cb->args[0] = info.this_idx;
@@ -752,7 +755,7 @@
 {
 	struct rtattr *xfrma[XFRMA_MAX];
 	struct xfrm_link *link;
-	int type, min_len, kind;
+	int type, min_len;
 
 	if (!(nlh->nlmsg_flags & NLM_F_REQUEST))
 		return 0;
@@ -768,7 +771,6 @@
 		goto err_einval;
 
 	type -= XFRM_MSG_BASE;
-	kind = (type & 3);
 	link = &xfrm_dispatch[type];
 
 	/* All operations require privileges, even GET */
@@ -777,7 +779,7 @@
 		return -1;
 	}
 
-	if (kind == 2 && (nlh->nlmsg_flags & NLM_F_DUMP)) {
+	if ((type == 2 || type == 5) && (nlh->nlmsg_flags & NLM_F_DUMP)) {
 		u32 rlen;
 
 		if (link->dump == NULL)

BTW: I've done a port of isakmpd to Linux 2.5 which uses PFKEYv2-sockets
for sake of simplicity (read: because I'm lazy). The patch and tarballs
with prepatched sources can be found at http://bender.thinknerd.de/
~thomas/isakmpd-linux-2.5/. I've done some testing on 2.5.56 and it
seems to be quite stable (there have been no problems within one week
heavy usage).
