Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbUKJBvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbUKJBvI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 20:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbUKJBtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 20:49:51 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:47629 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261832AbUKJBsw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 20:48:52 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: jmerkey@drdos.com (Jeff V. Merkey)
Subject: Re: 2.6.9 RCU breakage in dev_queue_xmit
Cc: linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <4190FFE9.8000203@drdos.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1CRhaw-0001v7-00@gondolin.me.apana.org.au>
Date: Wed, 10 Nov 2004 12:48:22 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey <jmerkey@drdos.com> wrote:
> 
> Running dual gigabit interfaces at 196 MB/S (megabytes/second) on 
> receive, 12 CLK interacket gap time, 1500 bytes payload
> at 65000 packets per second per gigabit interface, and retransmitting 
> received packets at 130 MB/S out of a third gigabit interface
> with skb, RCU locks in dev_queue_xmit breaks and enters the following state:

This patch might help.
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/11/01 17:41:19-08:00 mingo@elte.hu 
#   [NET]: Fix unbalanced local_bh_enable() in dev_queue_xmit()
#   
#   Signed-off-by: Ingo Molnar <mingo@elte.hu>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# net/core/dev.c
#   2004/11/01 17:40:59-08:00 mingo@elte.hu +5 -6
#   [NET]: Fix unbalanced local_bh_enable() in dev_queue_xmit()
#   
#   Signed-off-by: Ingo Molnar <mingo@elte.hu>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	2004-11-10 12:45:48 +11:00
+++ b/net/core/dev.c	2004-11-10 12:45:48 +11:00
@@ -1261,6 +1261,11 @@
 	struct Qdisc *q;
 	int rc = -ENOMEM;
 
+	/* Disable soft irqs for various locks below. Also 
+	 * stops preemption for RCU. 
+	 */
+	local_bh_disable(); 
+
 	if (skb_shinfo(skb)->frag_list &&
 	    !(dev->features & NETIF_F_FRAGLIST) &&
 	    __skb_linearize(skb, GFP_ATOMIC))
@@ -1284,12 +1289,6 @@
 	      skb->protocol != htons(ETH_P_IP))))
 	      	if (skb_checksum_help(skb, 0))
 	      		goto out_kfree_skb;
-
-
-	/* Disable soft irqs for various locks below. Also 
-	 * stops preemption for RCU. 
-	 */
-	local_bh_disable(); 
 
 	/* Updates of qdisc are serialized by queue_lock. 
 	 * The struct Qdisc which is pointed to by qdisc is now a 
