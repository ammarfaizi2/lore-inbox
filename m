Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbTEHVlc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 17:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbTEHVlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 17:41:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:33422 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262148AbTEHVl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 17:41:28 -0400
Date: Thu, 08 May 2003 14:53:37 -0700 (PDT)
Message-Id: <20030508.145337.44959912.davem@redhat.com>
To: tomlins@cam.org
Cc: wli@holomorphy.com, helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, akpm@digeo.com
Subject: Re: 2.5.69-mm2 Kernel panic, possibly network related
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305081734.54621.tomlins@cam.org>
References: <20030508013854.GW8931@holomorphy.com>
	<20030508.102155.132908119.davem@redhat.com>
	<200305081734.54621.tomlins@cam.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ed Tomlinson <tomlins@cam.org>
   Date: Thu, 8 May 2003 17:34:54 -0400

   Since I have not noticed anyone posting one, here is the opps that
   kills -mm3

Oh yeah, thats a seperate problem.  This should fix it:

--- ./net/ipv4/netfilter/ip_fw_compat_masq.c.~1~	Thu May  8 14:38:01 2003
+++ ./net/ipv4/netfilter/ip_fw_compat_masq.c	Thu May  8 14:49:19 2003
@@ -103,19 +103,19 @@ do_masquerade(struct sk_buff **pskb, con
 }
 
 void
-check_for_masq_error(struct sk_buff *skb)
+check_for_masq_error(struct sk_buff **pskb)
 {
 	enum ip_conntrack_info ctinfo;
 	struct ip_conntrack *ct;
 
-	ct = ip_conntrack_get(skb, &ctinfo);
+	ct = ip_conntrack_get(*pskb, &ctinfo);
 	/* Wouldn't be here if not tracked already => masq'ed ICMP
            ping or error related to masq'd connection */
 	IP_NF_ASSERT(ct);
 	if (ctinfo == IP_CT_RELATED) {
-		icmp_reply_translation(skb, ct, NF_IP_PRE_ROUTING,
+		icmp_reply_translation(pskb, ct, NF_IP_PRE_ROUTING,
 				       CTINFO2DIR(ctinfo));
-		icmp_reply_translation(skb, ct, NF_IP_POST_ROUTING,
+		icmp_reply_translation(pskb, ct, NF_IP_POST_ROUTING,
 				       CTINFO2DIR(ctinfo));
 	}
 }
@@ -152,10 +152,10 @@ check_for_demasq(struct sk_buff **pskb)
 				    && skb_linearize(*pskb, GFP_ATOMIC) != 0)
 					return NF_DROP;
 
-				icmp_reply_translation(*pskb, ct,
+				icmp_reply_translation(pskb, ct,
 						       NF_IP_PRE_ROUTING,
 						       CTINFO2DIR(ctinfo));
-				icmp_reply_translation(*pskb, ct,
+				icmp_reply_translation(pskb, ct,
 						       NF_IP_POST_ROUTING,
 						       CTINFO2DIR(ctinfo));
 			}
--- ./net/ipv4/netfilter/ip_fw_compat.c.~1~	Thu May  8 14:39:58 2003
+++ ./net/ipv4/netfilter/ip_fw_compat.c	Thu May  8 14:40:08 2003
@@ -35,7 +35,7 @@ extern unsigned int
 do_masquerade(struct sk_buff **pskb, const struct net_device *dev);
 
 extern unsigned int
-check_for_masq_error(struct sk_buff *pskb);
+check_for_masq_error(struct sk_buff **pskb);
 
 extern unsigned int
 check_for_demasq(struct sk_buff **pskb);
@@ -167,7 +167,7 @@ fw_in(unsigned int hooknum,
 			/* Handle ICMP errors from client here */
 			if ((*pskb)->nh.iph->protocol == IPPROTO_ICMP
 			    && (*pskb)->nfct)
-				check_for_masq_error(*pskb);
+				check_for_masq_error(pskb);
 		}
 		return NF_ACCEPT;
 
