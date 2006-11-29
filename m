Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758284AbWK2WIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758284AbWK2WIv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758286AbWK2WDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:03:24 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:48340 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758284AbWK2WDS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:03:18 -0500
Message-Id: <20061129220445.699466000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:22 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       "David S. Miller" <davem@davemloft.net>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Patrick McHardy <kaber@trash.net>,
       Faidon Liambotis <paravoid@debian.org>
Subject: [patch 11/23] NETFILTER: H.323 conntrack: fix crash with CONFIG_IP_NF_CT_ACCT
Content-Disposition: inline; filename=netfilter-h.323-conntrack-fix-crash-with-config_ip_nf_ct_acct.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Patrick McHardy <kaber@trash.net>

H.323 connection tracking code calls ip_ct_refresh_acct() when
processing RCFs and URQs but passes NULL as the skb.
When CONFIG_IP_NF_CT_ACCT is enabled, the connection tracking core tries
to derefence the skb, which results in an obvious panic.
A similar fix was applied on the SIP connection tracking code some time
ago.

Signed-off-by: Faidon Liambotis <paravoid@debian.org>
Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
commit 76b0c2b63fd5a2da358b36a22b7bf99298dde0b7
tree cd96ddb4c4cd5ffb44ed5a47fa3be41267eea99a
parent 1b9bb3c14c60324b54645ffefbe6d270f9fd191c
author Faidon Liambotis <paravoid@debian.org> Fri, 17 Nov 2006 21:01:25 +0100
committer Patrick McHardy <kaber@trash.net> Fri, 17 Nov 2006 21:01:25 +0100

 net/ipv4/netfilter/ip_conntrack_helper_h323.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.18.4.orig/net/ipv4/netfilter/ip_conntrack_helper_h323.c
+++ linux-2.6.18.4/net/ipv4/netfilter/ip_conntrack_helper_h323.c
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

--
