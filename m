Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932450AbWEJC5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbWEJC5S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWEJC5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:57:17 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:13630 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932450AbWEJC5B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:57:01 -0400
Date: Tue, 9 May 2006 19:56:07 -0700
Message-Id: <200605100256.k4A2u7CC031767@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linville@tuxdriver.com, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] ieee80211softmac_io gcc 4.1 warning fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I searched but no usage I could find ..

Fixes the following warning,

net/ieee80211/softmac/ieee80211softmac_io.c:464: warning: 'ieee80211softmac_send_ctl_frame' defined but not used
net/ieee80211/softmac/ieee80211softmac_io.c:449: warning: 'ieee80211softmac_rts_cts' defined but not used

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/net/ieee80211/softmac/ieee80211softmac_io.c
===================================================================
--- linux-2.6.16.orig/net/ieee80211/softmac/ieee80211softmac_io.c
+++ linux-2.6.16/net/ieee80211/softmac/ieee80211softmac_io.c
@@ -440,47 +440,3 @@ ieee80211softmac_send_mgt_frame(struct i
 	return 0;
 }
 
-
-/* Create an rts/cts frame */
-static u32
-ieee80211softmac_rts_cts(struct ieee80211_hdr_2addr **pkt,
-	struct ieee80211softmac_device *mac, struct ieee80211softmac_network *net, 
-	u32 type)
-{
-	/* Allocate Packet */
-	(*pkt) = kmalloc(IEEE80211_2ADDR_LEN, GFP_ATOMIC);	
-	memset(*pkt, 0, IEEE80211_2ADDR_LEN);
-	if((*pkt) == NULL)
-		return 0;
-	ieee80211softmac_hdr_2addr(mac, (*pkt), type, net->bssid);
-	return IEEE80211_2ADDR_LEN;
-}
-
-
-/* Sends a control packet */
-static int
-ieee80211softmac_send_ctl_frame(struct ieee80211softmac_device *mac,
-	struct ieee80211softmac_network *net, u32 type, u32 arg)
-{
-	void *pkt = NULL;
-	u32 pkt_size = 0;
-	
-	switch(type) {
-	case IEEE80211_STYPE_RTS:
-	case IEEE80211_STYPE_CTS:
-		pkt_size = ieee80211softmac_rts_cts((struct ieee80211_hdr_2addr **)(&pkt), mac, net, type);
-		break;
-	default:
-		printkl(KERN_DEBUG PFX "Unsupported Control Frame type: %i\n", type);
-		return -EINVAL;
-	}
-
-	if(pkt_size == 0)
-		return -ENOMEM;
-	
-	/* Send the packet to the ieee80211 layer for tx */
-	ieee80211_tx_frame(mac->ieee, (struct ieee80211_hdr *) pkt, pkt_size);
-
-	kfree(pkt);
-	return 0;
-}
