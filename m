Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbVJaWfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbVJaWfB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbVJaWet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:34:49 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:59658 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932340AbVJaWes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:34:48 -0500
Subject: [git patch review 2/5] [IPoIB] use spin_trylock_irqsave()
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 31 Oct 2005 22:34:42 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1130798082548-c351d7732f360685@cisco.com>
In-Reply-To: <1130798082548-646b24d6f405c5f5@cisco.com>
X-OriginalArrivalTime: 31 Oct 2005 22:34:43.0819 (UTC) FILETIME=[4A3B3BB0:01C5DE6B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use spin_trylock_irqsave() in ipoib_start_xmit() instead of
reinventing it out of local_irq_save(), spin_trylock() and
local_irq_restore().

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/ulp/ipoib/ipoib_main.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

applies-to: e4e6a0f5f2203569b6ada4c101a146c3a4f24c28
a20583a7c2e35d80b1dfc1f60c9729498838725e
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband/ulp/ipoib/ipoib_main.c
index cd4f423..273d5f4 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -551,11 +551,8 @@ static int ipoib_start_xmit(struct sk_bu
 	struct ipoib_neigh *neigh;
 	unsigned long flags;
 
-	local_irq_save(flags);
-	if (!spin_trylock(&priv->tx_lock)) {
-		local_irq_restore(flags);
+	if (!spin_trylock_irqsave(&priv->tx_lock, flags))
 		return NETDEV_TX_LOCKED;
-	}
 
 	/*
 	 * Check if our queue is stopped.  Since we have the LLTX bit
---
0.99.9
