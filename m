Return-Path: <linux-kernel-owner+w=401wt.eu-S1751385AbXAKSbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbXAKSbB (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 13:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbXAKSbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 13:31:00 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:4084 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbXAKSbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 13:31:00 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=hp6Yyl8WePGFgdD15jPiiL72c4Gs8zphTMAHw+0j8u56eVeJpnCcWEi9Zl6+hfA3Ok/4nbRvo6w1ASwaHwhP3Bk5yGXovzWqaIFP8ZkHlXBRvWvbgRsGn+GC2EUX7FDLikBHXOdplV0h1bjcdci8BPEzVfLdD2z0G6FnMx7lmMg=
Date: Thu, 11 Jan 2007 18:28:49 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: [-mm patch] remove tcp header from tcp_v4_check
Message-ID: <20070111182849.GA5941@slug>
References: <20070104220200.ae4e9a46.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070104220200.ae4e9a46.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 10:02:00PM -0800, Andrew Morton wrote:
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/
> 
The tcphdr struct passed to tcp_v4_check is not used, the following patch
removes it from the parameter list.

Regards,
Frederik


Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>


Index: 2.6.20-rc3-mm1/include/net/tcp.h
===================================================================
--- 2.6.20-rc3-mm1.orig/include/net/tcp.h
+++ 2.6.20-rc3-mm1/include/net/tcp.h
@@ -802,9 +802,8 @@ static inline void tcp_update_wl(struct 
 /*
  * Calculate(/check) TCP checksum
  */
-static inline __sum16 tcp_v4_check(struct tcphdr *th, int len,
-			       __be32 saddr, __be32 daddr,
-			       __wsum base)
+static inline __sum16 tcp_v4_check(int len, __be32 saddr,
+				   __be32 daddr, __wsum base)
 {
 	return csum_tcpudp_magic(saddr,daddr,len,IPPROTO_TCP,base);
 }
Index: 2.6.20-rc3-mm1/net/ipv4/netfilter/ipt_REJECT.c
===================================================================
--- 2.6.20-rc3-mm1.orig/net/ipv4/netfilter/ipt_REJECT.c
+++ 2.6.20-rc3-mm1/net/ipv4/netfilter/ipt_REJECT.c
@@ -116,7 +116,7 @@ static void send_reset(struct sk_buff *o
 
 	/* Adjust TCP checksum */
 	tcph->check = 0;
-	tcph->check = tcp_v4_check(tcph, sizeof(struct tcphdr),
+	tcph->check = tcp_v4_check(sizeof(struct tcphdr),
 				   nskb->nh.iph->saddr,
 				   nskb->nh.iph->daddr,
 				   csum_partial((char *)tcph,
Index: 2.6.20-rc3-mm1/net/ipv4/tcp_ipv4.c
===================================================================
--- 2.6.20-rc3-mm1.orig/net/ipv4/tcp_ipv4.c
+++ 2.6.20-rc3-mm1/net/ipv4/tcp_ipv4.c
@@ -502,14 +502,13 @@ void tcp_v4_send_check(struct sock *sk, 
 	struct tcphdr *th = skb->h.th;
 
 	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		th->check = ~tcp_v4_check(th, len,
-					  inet->saddr, inet->daddr, 0);
+		th->check = ~tcp_v4_check(len, inet->saddr,
+					  inet->daddr, 0);
 		skb->csum_offset = offsetof(struct tcphdr, check);
 	} else {
-		th->check = tcp_v4_check(th, len, inet->saddr, inet->daddr,
+		th->check = tcp_v4_check(len, inet->saddr, inet->daddr,
 					 csum_partial((char *)th,
-						      th->doff << 2,
-						      skb->csum));
+						th->doff << 2, skb->csum));
 	}
 }
 
@@ -525,7 +524,7 @@ int tcp_v4_gso_send_check(struct sk_buff
 	th = skb->h.th;
 
 	th->check = 0;
-	th->check = ~tcp_v4_check(th, skb->len, iph->saddr, iph->daddr, 0);
+	th->check = ~tcp_v4_check(skb->len, iph->saddr, iph->daddr, 0);
 	skb->csum_offset = offsetof(struct tcphdr, check);
 	skb->ip_summed = CHECKSUM_PARTIAL;
 	return 0;
@@ -747,7 +746,7 @@ static int tcp_v4_send_synack(struct soc
 	if (skb) {
 		struct tcphdr *th = skb->h.th;
 
-		th->check = tcp_v4_check(th, skb->len,
+		th->check = tcp_v4_check(skb->len,
 					 ireq->loc_addr,
 					 ireq->rmt_addr,
 					 csum_partial((char *)th, skb->len,
@@ -1514,7 +1513,7 @@ static struct sock *tcp_v4_hnd_req(struc
 static __sum16 tcp_v4_checksum_init(struct sk_buff *skb)
 {
 	if (skb->ip_summed == CHECKSUM_COMPLETE) {
-		if (!tcp_v4_check(skb->h.th, skb->len, skb->nh.iph->saddr,
+		if (!tcp_v4_check(skb->len, skb->nh.iph->saddr,
 				  skb->nh.iph->daddr, skb->csum)) {
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 			return 0;
