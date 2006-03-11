Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWCKXvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWCKXvM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 18:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWCKXvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 18:51:12 -0500
Received: from smtprelay06.ispgateway.de ([80.67.18.44]:17571 "EHLO
	smtprelay06.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751275AbWCKXvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 18:51:11 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "YOSHIFUJI Hideaki / =?utf-8?q?=E5=90=89=E8=97=A4=E8=8B=B1=E6=98=8E?=" 
	<yoshfuji@linux-ipv6.org>
Subject: [PATCH] IPv6: Cleanup of net/ipv6/reassambly.c
Date: Sun, 12 Mar 2006 00:49:48 +0100
User-Agent: KMail/1.9.1
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603120049.49294.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Oeser <ioe-lkml@rameria.de>

Two minor cleanups:

1. Using kzalloc() in fraq_alloc_queue() 
   saves the memset() in ipv6_frag_create().

2. Invert sense of if-statements to streamline code.
   Inverts the comment, too.


Signed-off-by: Ingo Oeser <ioe-lkml@rameria.de>
---
Hi,

I first did the kzalloc cleanup, but then decided, 
that I can do this change, too. If you consider it worse,
please tell me and I'll just do the kzalloc() one.

Regards

Ingo Oeser

diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 15e1456..6d8c9bb 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -203,7 +203,7 @@ static inline void frag_free_queue(struc
 
 static inline struct frag_queue *frag_alloc_queue(void)
 {
-	struct frag_queue *fq = kmalloc(sizeof(struct frag_queue), GFP_ATOMIC);
+	struct frag_queue *fq = kzalloc(sizeof(struct frag_queue), GFP_ATOMIC);
 
 	if(!fq)
 		return NULL;
@@ -288,6 +288,7 @@ static void ip6_evictor(void)
 static void ip6_frag_expire(unsigned long data)
 {
 	struct frag_queue *fq = (struct frag_queue *) data;
+	struct net_device *dev;
 
 	spin_lock(&fq->lock);
 
@@ -299,22 +300,22 @@ static void ip6_frag_expire(unsigned lon
 	IP6_INC_STATS_BH(IPSTATS_MIB_REASMTIMEOUT);
 	IP6_INC_STATS_BH(IPSTATS_MIB_REASMFAILS);
 
-	/* Send error only if the first segment arrived. */
-	if (fq->last_in&FIRST_IN && fq->fragments) {
-		struct net_device *dev = dev_get_by_index(fq->iif);
-
-		/*
-		   But use as source device on which LAST ARRIVED
-		   segment was received. And do not use fq->dev
-		   pointer directly, device might already disappeared.
-		 */
-		if (dev) {
-			fq->fragments->dev = dev;
-			icmpv6_send(fq->fragments, ICMPV6_TIME_EXCEED, ICMPV6_EXC_FRAGTIME, 0,
-				    dev);
-			dev_put(dev);
-		}
-	}
+	/* Don't send error if the first segment did not arrive. */
+	if (!(fq->last_in&FIRST_IN) || !fq->fragments)
+		goto out;
+	
+	dev = dev_get_by_index(fq->iif);
+	if (!dev)
+		goto out;
+
+	/*
+	   But use as source device on which LAST ARRIVED
+	   segment was received. And do not use fq->dev
+	   pointer directly, device might already disappeared.
+	 */
+	fq->fragments->dev = dev;
+	icmpv6_send(fq->fragments, ICMPV6_TIME_EXCEED, ICMPV6_EXC_FRAGTIME, 0, dev);
+	dev_put(dev);
 out:
 	spin_unlock(&fq->lock);
 	fq_put(fq, NULL);
@@ -368,8 +369,6 @@ ip6_frag_create(unsigned int hash, u32 i
 	if ((fq = frag_alloc_queue()) == NULL)
 		goto oom;
 
-	memset(fq, 0, sizeof(struct frag_queue));
-
 	fq->id = id;
 	ipv6_addr_copy(&fq->saddr, src);
 	ipv6_addr_copy(&fq->daddr, dst);
