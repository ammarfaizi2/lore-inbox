Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLXR6q>; Sun, 24 Dec 2000 12:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLXR6h>; Sun, 24 Dec 2000 12:58:37 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:47116 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129183AbQLXR6R>;
	Sun, 24 Dec 2000 12:58:17 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200012241727.UAA31711@ms2.inr.ac.ru>
Subject: Re: test13-pre4 ip defrag oops
To: mhaque@haque.NET (Mohammad A. Haque)
Date: Sun, 24 Dec 2000 20:27:25 +0300 (MSK)
Cc: davem@redhat.com (Dave Miller), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0012232205420.7311-100000@viper.haque.net> from "Mohammad A. Haque" at Dec 24, 0 06:15:00 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> eax: 20202037   ebx: d3a406c0   ecx: cf683024   edx: c734a2a0

Ough... found eventually. skb->dev turns out to be not initialized. 8)8)

This patchlet surely fixes the bug. (plus writes are ordered)

Alexey



--- ../vger3-001222/linux/net/core/skbuff.c	Fri Dec 22 19:37:54 2000
+++ linux/net/core/skbuff.c	Sun Dec 24 20:24:20 2000
@@ -227,15 +227,20 @@
 {
 	struct sk_buff *skb = p;
 
-	skb->destructor = NULL;
-	skb->pkt_type = PACKET_HOST;	/* Default type */
-	skb->prev = skb->next = NULL;
+	skb->next = NULL;
+	skb->prev = NULL;
 	skb->list = NULL;
 	skb->sk = NULL;
 	skb->stamp.tv_sec=0;	/* No idea about time */
+	skb->dev = NULL;
+	skb->dst = NULL;
+	memset(skb->cb, 0, sizeof(skb->cb));
+	skb->pkt_type = PACKET_HOST;	/* Default type */
 	skb->ip_summed = 0;
+	skb->priority = 0;
 	skb->security = 0;	/* By default packets are insecure */
-	skb->dst = NULL;
+	skb->destructor = NULL;
+
 #ifdef CONFIG_NETFILTER
 	skb->nfmark = skb->nfcache = 0;
 	skb->nfct = NULL;
@@ -246,8 +251,6 @@
 #ifdef CONFIG_NET_SCHED
 	skb->tc_index = 0;
 #endif
-	memset(skb->cb, 0, sizeof(skb->cb));
-	skb->priority = 0;
 }
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
