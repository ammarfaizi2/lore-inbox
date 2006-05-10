Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWEJUSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWEJUSE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 16:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWEJUSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 16:18:04 -0400
Received: from smtp-out.google.com ([216.239.45.12]:22592 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932456AbWEJUSC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 16:18:02 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:cc:subject:message-id:mime-version:content-type;
	b=Tf7f44P6V0OXYaDJhgkRsJvo/1oMZwzGCegbjFkbrz+YDHp72cSHe9roCAaE+N6x2
	ybsC47bZdQYULekwI+VBQ==
Date: Wed, 10 May 2006 13:17:39 -0700 (PDT)
From: Ranjit Manomohan <ranjitm@google.com>
To: linux-kernel@vger.kernel.org
cc: netdev@vger.kernel.org
Subject: [PATCH] tcpdump may trace some outbound packets twice.
Message-ID: <Pine.LNX.4.56.0605101315380.8735@ranjit.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the problem where tcpdump shows duplicate packets
while tracing outbound packets on drivers which support lockless
transmit. The patch changes the current behaviour to tracing the
packets only on a successful transmit.

Signed-off-by: Ranjit Manomohan <ranjitm@google.com>

--- linux-2.6/net/sched/sch_generic.c	2006-05-10 12:34:52.000000000 -0700
+++ linux/net/sched/sch_generic.c	2006-05-10 12:39:38.000000000 -0700
@@ -136,8 +136,12 @@
 
 			if (!netif_queue_stopped(dev)) {
 				int ret;
+				struct sk_buff *skbc = NULL;
+				/* Clone the skb so that we hold a reference
+				 * to its data and we can trace it after a
+				 * successful transmit. */
 				if (netdev_nit)
-					dev_queue_xmit_nit(skb, dev);
+					skbc = skb_clone(skb, GFP_ATOMIC);
 
 				ret = dev->hard_start_xmit(skb, dev);
 				if (ret == NETDEV_TX_OK) { 
@@ -145,6 +149,15 @@
 						dev->xmit_lock_owner = -1;
 						spin_unlock(&dev->xmit_lock);
 					}
+					if(skbc) {
+						/* transmit succeeded, 
+						 * trace the clone. */
+						dev_queue_xmit_nit(skbc,dev);
+						kfree_skb(skbc);
+					}
+					/* Free clone if it exists */
+					if(skbc)
+						kfree_skb(skbc);
 					spin_lock(&dev->queue_lock);
 					return -1;
 				}
