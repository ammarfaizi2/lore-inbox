Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265178AbSJaEI3>; Wed, 30 Oct 2002 23:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265179AbSJaEI3>; Wed, 30 Oct 2002 23:08:29 -0500
Received: from 653277hfc248.tampabay.rr.com ([65.32.77.248]:48654 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id <S265178AbSJaEI1>; Wed, 30 Oct 2002 23:08:27 -0500
Message-ID: <3DC0AE2E.5040801@davehollis.com>
Date: Wed, 30 Oct 2002 23:14:38 -0500
From: David T Hollis <dhollis@davehollis.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.45 net/ipv4/netfilter/ipt_TCPMSS.c - Fix for pmtu changes
Content-Type: multipart/mixed;
 boundary="------------090304090108080306070301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090304090108080306070301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch fixes ipt_TCPMSS.c to use the dst_pmtu function to pull the 
destination MTU value.  

--------------090304090108080306070301
Content-Type: text/plain;
 name="linux-2.4.45-ipt_TCPMSS.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.45-ipt_TCPMSS.patch"

--- net/ipv4/netfilter/ipt_TCPMSS.c.orig	2002-10-30 22:59:53.000000000 -0500
+++ net/ipv4/netfilter/ipt_TCPMSS.c	2002-10-30 23:08:58.000000000 -0500
@@ -48,6 +48,7 @@
 	u_int16_t tcplen, newtotlen, oldval, newmss;
 	unsigned int i;
 	u_int8_t *opt;
+	struct rtable *rt;
 
 	/* raw socket (tcpdump) may have clone of incoming skb: don't
 	   disturb it --RR */
@@ -85,14 +86,16 @@
 			return NF_DROP; /* or IPT_CONTINUE ?? */
 		}
 
-		if((*pskb)->dst->pmtu <= (sizeof(struct iphdr) + sizeof(struct tcphdr))) {
+		rt = (struct rtable *)(*pskb)->dst;
+
+		if(dst_pmtu(&rt->u.dst) <= (sizeof(struct iphdr) + sizeof(struct tcphdr))) {
 			if (net_ratelimit())
 				printk(KERN_ERR
-		       			"ipt_tcpmss_target: unknown or invalid path-MTU (%d)\n", (*pskb)->dst->pmtu);
+		       			"ipt_tcpmss_target: unknown or invalid path-MTU (%d)\n", dst_pmtu(&rt->u.dst));
 			return NF_DROP; /* or IPT_CONTINUE ?? */
 		}
 
-		newmss = (*pskb)->dst->pmtu - sizeof(struct iphdr) - sizeof(struct tcphdr);
+		newmss = dst_pmtu(&rt->u.dst) - sizeof(struct iphdr) - sizeof(struct tcphdr);
 	} else
 		newmss = tcpmssinfo->mss;
 

--------------090304090108080306070301--

