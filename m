Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbWHPV4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbWHPV4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 17:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWHPV4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 17:56:50 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:13716 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932272AbWHPV4u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 17:56:50 -0400
Message-Id: <20060816215339.904402000@mvista.com>
User-Agent: quilt/0.45-1
Date: Wed, 16 Aug 2006 14:53:39 -0700
From: dwalker@mvista.com
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -rt] spin lock imbalance in ibm emac
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not really sure where this code came from. There was a spin_unlock 
imbalance inside emac_start_xmit_sg().. It only effects the driver when 
CONFIG_IBM_EMAC_TAH is enabled.

This might need a little more review .. 

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
