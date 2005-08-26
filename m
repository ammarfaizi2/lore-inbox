Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbVHZTYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbVHZTYZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 15:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbVHZTYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 15:24:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10711 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030218AbVHZTYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 15:24:18 -0400
Message-Id: <20050826191946.081761000@localhost.localdomain>
References: <20050826191755.052951000@localhost.localdomain>
Date: Fri, 26 Aug 2005 12:18:02 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Patrick McHardy <kaber@trash.net>,
       "David S. Miller" <davem@davemloft.net>, Chris Wright <chrisw@osdl.org>
Subject: [PATCH 7/7] [IPV6]: Fix SKB leak in ip6_input_finish()
Content-Disposition: inline; filename=ipv6-skb-leak.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any  objections, please let us know.
------------------

Changing it to how ip_input handles should fix it.

Signed-off-by: Patrick McHardy <kaber@trash.net>
Signed-off-by: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---
 net/ipv6/ip6_input.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

Index: linux-2.6.12.y/net/ipv6/ip6_input.c
===================================================================
--- linux-2.6.12.y.orig/net/ipv6/ip6_input.c
+++ linux-2.6.12.y/net/ipv6/ip6_input.c
@@ -198,12 +198,13 @@ resubmit:
 		if (!raw_sk) {
 			if (xfrm6_policy_check(NULL, XFRM_POLICY_IN, skb)) {
 				IP6_INC_STATS_BH(IPSTATS_MIB_INUNKNOWNPROTOS);
-				icmpv6_param_prob(skb, ICMPV6_UNK_NEXTHDR, nhoff);
+				icmpv6_send(skb, ICMPV6_PARAMPROB,
+				            ICMPV6_UNK_NEXTHDR, nhoff,
+				            skb->dev);
 			}
-		} else {
+		} else
 			IP6_INC_STATS_BH(IPSTATS_MIB_INDELIVERS);
-			kfree_skb(skb);
-		}
+		kfree_skb(skb);
 	}
 	rcu_read_unlock();
 	return 0;

--
