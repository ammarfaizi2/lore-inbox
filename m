Return-Path: <linux-kernel-owner+w=401wt.eu-S1751387AbXALNfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbXALNfX (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 08:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbXALNfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 08:35:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:45361 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbXALNfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 08:35:21 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=Q+7L2wX/U+J7L0mr3jdrthliQrJBkFvD2zF6A1ocTlR1fGe64u3bTAJsnhi3fTyaoWIZggro7bKqKjy0BqzbaaSacAnKXazaUiV57lV7dUsdDJv0huzlnNZ23tiBlM9bFqVxztsJhv2HmPw7MfkAYYRk3Oy4ONcp1X+Lvi67h70=
Date: Fri, 12 Jan 2007 13:33:09 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: [-mm patch] remove tcp header from tcp_v4_check
Message-ID: <20070112133309.GF5941@slug>
References: <20070111222627.66bb75ab.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070111222627.66bb75ab.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 10:26:27PM -0800, Andrew Morton wrote:
> 
>   ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc4-mm1/
> 
Hi,

The tcphdr struct passed to tcp_v4_check is not used, the following
patch removes it from the parameter list.
(This adds the netfilter modifications missing in the patch I sent
for rc3-mm1)

Regards,
Frederik 


Index: 2.6.20-rc4-mm1/include/net/tcp.h
===================================================================
--- 2.6.20-rc4-mm1.orig/include/net/tcp.h	2007-01-12 11:19:16.000000000 +0100
+++ 2.6.20-rc4-mm1/include/net/tcp.h	2007-01-12 11:21:43.000000000 +0100
@@ -802,9 +802,8 @@
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
Index: 2.6.20-rc4-mm1/net/ipv4/netfilter/ipt_REJECT.c
===================================================================
--- 2.6.20-rc4-mm1.orig/net/ipv4/netfilter/ipt_REJECT.c	2007-01-12 11:19:16.000000000 +0100
+++ 2.6.20-rc4-mm1/net/ipv4/netfilter/ipt_REJECT.c	2007-01-12 11:21:43.000000000 +0100
@@ -116,11 +116,11 @@
 
 	/* Adjust TCP checksum */
 	tcph->check = 0;
-	tcph->check = tcp_v4_check(tcph, sizeof(struct tcphdr),
+	tcph->check = tcp_v4_check(sizeof(struct tcphdr),
 				   nskb->nh.iph->saddr,
 				   nskb->nh.iph->daddr,
 				   csum_partial((char *)tcph,
-						sizeof(struct tcphdr), 0));
+				   sizeof(struct tcphdr), 0));
 
 	/* Set DF, id = 0 */
 	nskb->nh.iph->frag_off = htons(IP_DF);
Index: 2.6.20-rc4-mm1/net/ipv4/tcp_ipv4.c
===================================================================
--- 2.6.20-rc4-mm1.orig/net/ipv4/tcp_ipv4.c	2007-01-12 11:19:16.000000000 +0100
+++ 2.6.20-rc4-mm1/net/ipv4/tcp_ipv4.c	2007-01-12 11:21:43.000000000 +0100
@@ -502,11 +502,11 @@
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
 						      th->doff << 2,
 						      skb->csum));
@@ -525,7 +525,7 @@
 	th = skb->h.th;
 
 	th->check = 0;
-	th->check = ~tcp_v4_check(th, skb->len, iph->saddr, iph->daddr, 0);
+	th->check = ~tcp_v4_check(skb->len, iph->saddr, iph->daddr, 0);
 	skb->csum_offset = offsetof(struct tcphdr, check);
 	skb->ip_summed = CHECKSUM_PARTIAL;
 	return 0;
@@ -747,7 +747,7 @@
 	if (skb) {
 		struct tcphdr *th = skb->h.th;
 
-		th->check = tcp_v4_check(th, skb->len,
+		th->check = tcp_v4_check(skb->len,
 					 ireq->loc_addr,
 					 ireq->rmt_addr,
 					 csum_partial((char *)th, skb->len,
@@ -1514,7 +1514,7 @@
 static __sum16 tcp_v4_checksum_init(struct sk_buff *skb)
 {
 	if (skb->ip_summed == CHECKSUM_COMPLETE) {
-		if (!tcp_v4_check(skb->h.th, skb->len, skb->nh.iph->saddr,
+		if (!tcp_v4_check(skb->len, skb->nh.iph->saddr,
 				  skb->nh.iph->daddr, skb->csum)) {
 			skb->ip_summed = CHECKSUM_UNNECESSARY;
 			return 0;
Index: 2.6.20-rc4-mm1/net/ipv4/netfilter/ip_nat_helper.c
===================================================================
--- 2.6.20-rc4-mm1.orig/net/ipv4/netfilter/ip_nat_helper.c	2007-01-12 11:19:56.000000000 +0100
+++ 2.6.20-rc4-mm1/net/ipv4/netfilter/ip_nat_helper.c	2007-01-12 11:21:43.000000000 +0100
@@ -183,7 +183,7 @@
 	datalen = (*pskb)->len - iph->ihl*4;
 	if ((*pskb)->ip_summed != CHECKSUM_PARTIAL) {
 		tcph->check = 0;
-		tcph->check = tcp_v4_check(tcph, datalen,
+		tcph->check = tcp_v4_check(datalen,
 					   iph->saddr, iph->daddr,
 					   csum_partial((char *)tcph,
 					   		datalen, 0));
Index: 2.6.20-rc4-mm1/net/ipv4/netfilter/nf_nat_helper.c
===================================================================
--- 2.6.20-rc4-mm1.orig/net/ipv4/netfilter/nf_nat_helper.c	2007-01-12 11:20:50.000000000 +0100
+++ 2.6.20-rc4-mm1/net/ipv4/netfilter/nf_nat_helper.c	2007-01-12 11:21:43.000000000 +0100
@@ -176,7 +176,7 @@
 	datalen = (*pskb)->len - iph->ihl*4;
 	if ((*pskb)->ip_summed != CHECKSUM_PARTIAL) {
 		tcph->check = 0;
-		tcph->check = tcp_v4_check(tcph, datalen,
+		tcph->check = tcp_v4_check(datalen,
 					   iph->saddr, iph->daddr,
 					   csum_partial((char *)tcph,
 					   		datalen, 0));
