Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030219AbVHZTXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbVHZTXo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbVHZTXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:23:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61142 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030214AbVHZTXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:23:42 -0400
Message-Id: <20050826191901.965850000@localhost.localdomain>
References: <20050826191755.052951000@localhost.localdomain>
Date: Fri, 26 Aug 2005 12:17:59 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Ollie Wild <aaw@rincewind.tv>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Maillist netdev <netdev@oss.sgi.com>, Patrick McHardy <kaber@trash.net>,
       "David S. Miller" <davem@davemloft.net>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 4/7] [IPV4]: Fix DST leak in icmp_push_reply()
Content-Disposition: inline; filename=fix-dst-leak-in-icmp_push_reply.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------

Based upon a bug report and initial patch by
Ollie Wild.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 net/ipv4/icmp.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.12.y/net/ipv4/icmp.c
===================================================================
--- linux-2.6.12.y.orig/net/ipv4/icmp.c
+++ linux-2.6.12.y/net/ipv4/icmp.c
@@ -349,12 +349,12 @@ static void icmp_push_reply(struct icmp_
 {
 	struct sk_buff *skb;
 
-	ip_append_data(icmp_socket->sk, icmp_glue_bits, icmp_param,
-		       icmp_param->data_len+icmp_param->head_len,
-		       icmp_param->head_len,
-		       ipc, rt, MSG_DONTWAIT);
-
-	if ((skb = skb_peek(&icmp_socket->sk->sk_write_queue)) != NULL) {
+	if (ip_append_data(icmp_socket->sk, icmp_glue_bits, icmp_param,
+		           icmp_param->data_len+icmp_param->head_len,
+		           icmp_param->head_len,
+		           ipc, rt, MSG_DONTWAIT) < 0)
+		ip_flush_pending_frames(icmp_socket->sk);
+	else if ((skb = skb_peek(&icmp_socket->sk->sk_write_queue)) != NULL) {
 		struct icmphdr *icmph = skb->h.icmph;
 		unsigned int csum = 0;
 		struct sk_buff *skb1;

--
