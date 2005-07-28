Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVG1Udt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVG1Udt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVG1Udq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:33:46 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:23839 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S262186AbVG1UcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:32:08 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 2/2] [IPoIB] Handle sending of unicast RARP responses
In-Reply-To: <20057281331.7vqhiAJ1Yc0um2je@cisco.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 28 Jul 2005 13:31:45 -0700
Message-Id: <20057281331.6BOCwhBG35vXYVIR@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <rolandd@cisco.com>
X-OriginalArrivalTime: 28 Jul 2005 20:31:56.0835 (UTC) FILETIME=[65EC6F30:01C593B3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hal Rosenstock <halr@voltaire.com>

RARP replies are another valid case where IPoIB may need to send a
unicast packet with no neighbour structure.

Signed-off-by: Hal Rosenstock <halr@voltaire.com>
Signed-off-by: Roland Dreier <rolandd@cisco.com>
---

 drivers/infiniband/ulp/ipoib/ipoib_main.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

0dca0f7bf82face7b700890318d5550fd542cabf
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -600,9 +600,10 @@ static int ipoib_start_xmit(struct sk_bu
 
 			ipoib_mcast_send(dev, (union ib_gid *) (phdr->hwaddr + 4), skb);
 		} else {
-			/* unicast GID -- should be ARP reply */
+			/* unicast GID -- should be ARP or RARP reply */
 
-			if (be16_to_cpup((u16 *) skb->data) != ETH_P_ARP) {
+			if ((be16_to_cpup((__be16 *) skb->data) != ETH_P_ARP) &&
+			    (be16_to_cpup((__be16 *) skb->data) != ETH_P_RARP)) {
 				ipoib_warn(priv, "Unicast, no %s: type %04x, QPN %06x "
 					   IPOIB_GID_FMT "\n",
 					   skb->dst ? "neigh" : "dst",
