Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262202AbUCLVeO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 16:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbUCLVeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 16:34:14 -0500
Received: from fed1mtao05.cox.net ([68.6.19.126]:7556 "EHLO fed1mtao05.cox.net")
	by vger.kernel.org with ESMTP id S262202AbUCLVeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 16:34:12 -0500
Date: Fri, 12 Mar 2004 14:34:11 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6-BK] Fix stray pointer in e100
Message-ID: <20040312213411.GA9939@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: Plexity Networks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


e100_alloc_cbs() allocates the cb's but does not set cb->skb = NULL
which means that the following check in e100_tx_clean() will execute
even though cb->skb is not really a valid pointer an we OOPs:

	if(likely(cb->skb != NULL)) {
		...
		nic->net_stats.tx_bytes += cb->skb->len;

	}

Attached patch fixes the issue.

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-e100-cb-alloc

diff -Nru a/drivers/net/e100.c b/drivers/net/e100.c
--- a/drivers/net/e100.c	Fri Mar 12 14:26:45 2004
+++ b/drivers/net/e100.c	Fri Mar 12 14:26:45 2004
@@ -1346,6 +1346,7 @@
 		cb->dma_addr = nic->cbs_dma_addr + i * sizeof(struct cb);
 		cb->link = cpu_to_le32(nic->cbs_dma_addr +
 			((i+1) % count) * sizeof(struct cb));
+		cb->skb = NULL;
 	}
 
 	nic->cb_to_use = nic->cb_to_send = nic->cb_to_clean = nic->cbs;

--k1lZvvs/B4yU6o8G--
