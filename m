Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbUL3I7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbUL3I7x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 03:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbUL3I7H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 03:59:07 -0500
Received: from smtp.knology.net ([24.214.63.101]:31882 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S261587AbUL3Ish (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 03:48:37 -0500
Date: Thu, 30 Dec 2004 03:48:36 -0500
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, dave@thedillows.org
From: David Dillow <dave@thedillows.org>
Subject: [RFC 2.6.10 14/22] typhoon: add inbound offload result processing
Message-Id: <20041230035000.23@ori.thedillows.org>
References: <20041230035000.22@ori.thedillows.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/30 00:54:09-05:00 dave@thedillows.org 
#   Add inbound packet crypto result processing to the Typhoon driver.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
# drivers/net/typhoon.c
#   2004/12/30 00:53:50-05:00 dave@thedillows.org +42 -0
#   Add inbound packet crypto result processing to the Typhoon driver.
#   
#   Signed-off-by: David Dillow <dave@thedillows.org>
# 
diff -Nru a/drivers/net/typhoon.c b/drivers/net/typhoon.c
--- a/drivers/net/typhoon.c	2004-12-30 01:09:23 -05:00
+++ b/drivers/net/typhoon.c	2004-12-30 01:09:23 -05:00
@@ -131,6 +131,7 @@
 #include <asm/checksum.h>
 #include <linux/version.h>
 #include <linux/dma-mapping.h>
+#include <net/xfrm.h>
 
 #include "typhoon.h"
 #include "typhoon-firmware.h"
@@ -1681,6 +1682,43 @@
 	return 0;
 }
 
+static inline void
+typhoon_ipsec_rx(struct sk_buff *skb, u16 results)
+{
+#define CHECK_OFFLOAD(good, bad) \
+	do { if(results & (good|bad)) { \
+		unsigned int tmp = XFRM_OFFLOAD_CONF | XFRM_OFFLOAD_AUTH; \
+		tmp |= (results & good) ?  XFRM_OFFLOAD_AUTH_OK : \
+					   XFRM_OFFLOAD_AUTH_FAIL; \
+		if(skb_put_xfrm_result(skb, tmp, i)) \
+				return; \
+		i++; \
+	} } while(0)
+
+	/* We have no way to determine what the order of the SAs were on
+	 * the wire, just the 1st AH seen, the 1st ESP seen, etc.
+	 *
+	 * We just walk the stack, and pretend that AH SAs get decypted
+	 * so that if we get the order wrong, the worst case scenerio is
+	 * that we indicate the failure on the wrong SA, since we'll need
+	 * to match all SAs against the policy.
+	 *
+	 * We get a "ESP good" indication for null auth hash on ESP.
+	 */
+	/* XXX think more about security indications -- can I craft a
+	 * packet to do bad things -- maybe a NULL auth ESP packet,
+	 * and a failed AH packet?
+	 */
+	int i = 0;
+
+	CHECK_OFFLOAD(TYPHOON_RX_AH1_GOOD, TYPHOON_RX_AH1_FAIL);
+	CHECK_OFFLOAD(TYPHOON_RX_ESP1_GOOD, TYPHOON_RX_ESP1_FAIL);
+	CHECK_OFFLOAD(TYPHOON_RX_AH2_GOOD, TYPHOON_RX_AH2_FAIL);
+	CHECK_OFFLOAD(TYPHOON_RX_ESP2_GOOD, TYPHOON_RX_ESP2_FAIL);
+
+#undef CHECK_OFFLOAD
+}
+
 static int
 typhoon_rx(struct typhoon *tp, struct basic_ring *rxRing, volatile u32 * ready,
 	   volatile u32 * cleared, int budget)
@@ -1745,6 +1783,10 @@
 			new_skb->ip_summed = CHECKSUM_UNNECESSARY;
 		} else
 			new_skb->ip_summed = CHECKSUM_NONE;
+
+		if((rx->rxStatus & TYPHOON_RX_IPSEC) &&
+				!(rx->rxStatus & TYPHOON_RX_IP_FRAG))
+			typhoon_ipsec_rx(new_skb, rx->ipsecResults);
 
 		spin_lock(&tp->state_lock);
 		if(tp->vlgrp != NULL && rx->rxStatus & TYPHOON_RX_VLAN)
