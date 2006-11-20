Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966560AbWKTTkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966560AbWKTTkZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966565AbWKTTkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:40:24 -0500
Received: from ulysses.noc.ntua.gr ([147.102.222.230]:1740 "EHLO
	ulysses.noc.ntua.gr") by vger.kernel.org with ESMTP id S966560AbWKTTkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:40:23 -0500
Date: Mon, 20 Nov 2006 21:39:31 +0200
From: Faidon Liambotis <paravoid@debian.org>
To: coreteam@netfilter.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org
Subject: [PATCH 2.6.19-rc6] netfilter: fix panic on ip_conntrack_h323 with CONFIG_IP_NF_CT_ACCT
Message-ID: <20061120193931.GA9913@void.cube.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H.323 connection tracking code calls ip_ct_refresh_acct() when
processing RCFs and URQs but passes NULL as the skb.
When CONFIG_IP_NF_CT_ACCT is enabled, the connection tracking core tries
to derefence the skb, which results in an obvious panic.
ago.

The patch uses ip_ct_refresh() instead of ip_ct_refresh_acct() to avoid
double accounting (suggested by Patrick McHardy).

Signed-off-by: Faidon Liambotis <paravoid@debian.org>

--- a/net/ipv4/netfilter/ip_conntrack_helper_h323.c	2006-11-15 19:07:50.000000000 +0200
+++ b/net/ipv4/netfilter/ip_conntrack_helper_h323.c	2006-11-16 11:09:46.000000000 +0200
@@ -1417,7 +1417,7 @@ static int process_rcf(struct sk_buff **
 		DEBUGP
 		    ("ip_ct_ras: set RAS connection timeout to %u seconds\n",
 		     info->timeout);
-		ip_ct_refresh_acct(ct, ctinfo, NULL, info->timeout * HZ);
+		ip_ct_refresh(ct, *pskb, info->timeout * HZ);
 
 		/* Set expect timeout */
 		read_lock_bh(&ip_conntrack_lock);
@@ -1465,7 +1465,7 @@ static int process_urq(struct sk_buff **
 	info->sig_port[!dir] = 0;
 
 	/* Give it 30 seconds for UCF or URJ */
-	ip_ct_refresh_acct(ct, ctinfo, NULL, 30 * HZ);
+	ip_ct_refresh(ct, *pskb, 30 * HZ);
 
 	return 0;
 }
