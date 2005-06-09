Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262216AbVFIAZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262216AbVFIAZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 20:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVFIAXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 20:23:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:653 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261408AbVFIAWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 20:22:23 -0400
Date: Wed, 8 Jun 2005 17:21:27 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, shemminger@osdl.org
Subject: [patch 08/09] [BRIDGE]: prevent bad forwarding table updates
Message-ID: <20050609002127.GO13152@shell0.pdx.osdl.net>
References: <20050608234637.GG13152@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608234637.GG13152@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid poisoning of the bridge forwarding table by frames that have been
dropped by filtering. This prevents spoofed source addresses on hostile
side of bridge from causing packet leakage, a small but possible security
risk.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>

Index: 2.6.11.11-net/net/bridge/br_input.c
===================================================================
--- 2.6.11.11-net.orig/net/bridge/br_input.c
+++ 2.6.11.11-net/net/bridge/br_input.c
@@ -54,6 +54,9 @@ int br_handle_frame_finish(struct sk_buf
 	struct net_bridge_fdb_entry *dst;
 	int passedup = 0;
 
+	/* insert into forwarding database after filtering to avoid spoofing */
+	br_fdb_insert(p->br, p, eth_hdr(skb)->h_source, 0);
+
 	if (br->dev->flags & IFF_PROMISC) {
 		struct sk_buff *skb2;
 
@@ -108,8 +111,7 @@ int br_handle_frame(struct net_bridge_po
 	if (eth_hdr(skb)->h_source[0] & 1)
 		goto err;
 
-	if (p->state == BR_STATE_LEARNING ||
-	    p->state == BR_STATE_FORWARDING)
+	if (p->state == BR_STATE_LEARNING)
 		br_fdb_insert(p->br, p, eth_hdr(skb)->h_source, 0);
 
 	if (p->br->stp_enabled &&
Index: 2.6.11.11-net/net/bridge/br_stp_bpdu.c
===================================================================
--- 2.6.11.11-net.orig/net/bridge/br_stp_bpdu.c
+++ 2.6.11.11-net/net/bridge/br_stp_bpdu.c
@@ -140,6 +140,9 @@ int br_stp_handle_bpdu(struct sk_buff *s
 	struct net_bridge *br = p->br;
 	unsigned char *buf;
 
+	/* insert into forwarding database after filtering to avoid spoofing */
+	br_fdb_insert(p->br, p, eth_hdr(skb)->h_source, 0);
+
 	/* need at least the 802 and STP headers */
 	if (!pskb_may_pull(skb, sizeof(header)+1) ||
 	    memcmp(skb->data, header, sizeof(header)))
