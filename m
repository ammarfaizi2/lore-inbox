Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVCCFfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVCCFfU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 00:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVCCFer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 00:34:47 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:54897 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261349AbVCCFbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 00:31:41 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][6/11] IB/ipoib: fix rx memory leak
In-Reply-To: <2005322131.ube7cIPz9y7840bB@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Wed, 2 Mar 2005 21:31:22 -0800
Message-Id: <2005322131.6N8qBqgz1WuD4wnL@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 05:31:22.0773 (UTC) FILETIME=[3C63A450:01C51FB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix memory leak when posting a receive buffer (pointed out by Shirley Ma).

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/ulp/ipoib/ipoib_ib.c	2005-03-02 20:26:02.919854355 -0800
+++ linux-export/drivers/infiniband/ulp/ipoib/ipoib_ib.c	2005-03-02 20:26:12.514771621 -0800
@@ -137,6 +137,9 @@
 	if (ret) {
 		ipoib_warn(priv, "ipoib_ib_receive failed for buf %d (%d)\n",
 			   id, ret);
+		dma_unmap_single(priv->ca->dma_device, addr,
+				 IPOIB_BUF_SIZE, DMA_FROM_DEVICE);
+		dev_kfree_skb_any(skb);
 		priv->rx_ring[id].skb = NULL;
 	}
 

