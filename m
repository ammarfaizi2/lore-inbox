Return-Path: <linux-kernel-owner+w=401wt.eu-S1762255AbWLJQje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762255AbWLJQje (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 11:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762256AbWLJQje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 11:39:34 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:8470 "EHLO
	dwalker1.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762255AbWLJQjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 11:39:33 -0500
Message-Id: <20061210163848.101585000@mvista.com>
User-Agent: quilt/0.45-1
Date: Sun, 10 Dec 2006 08:38:48 -0800
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -rt][RESEND] spin lock imbalance in ibm emac
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sent this a long time ago, still exists. 

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.17/drivers/net/ibm_emac/ibm_emac_core.c
===================================================================
--- linux-2.6.17.orig/drivers/net/ibm_emac/ibm_emac_core.c
+++ linux-2.6.17/drivers/net/ibm_emac/ibm_emac_core.c
@@ -1140,6 +1140,8 @@ static int emac_start_xmit_sg(struct sk_
 	if (likely(!nr_frags && len <= MAL_MAX_TX_SIZE))
 		return emac_start_xmit(skb, ndev);
 
+	spin_lock(&dev->tx_lock);
+
 	len -= skb->data_len;
 
 	/* Note, this is only an *estimation*, we can still run out of empty
@@ -1208,6 +1210,7 @@ static int emac_start_xmit_sg(struct sk_
       stop_queue:
 	netif_stop_queue(ndev);
 	DBG2("%d: stopped TX queue" NL, dev->def->index);
+	spin_unlock(&dev->tx_lock);
 	return 1;
 }
 #else
--
