Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422661AbWJaBBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422661AbWJaBBK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 20:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161509AbWJaBBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 20:01:10 -0500
Received: from mx4.cs.washington.edu ([128.208.4.190]:43711 "EHLO
	mx4.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1161497AbWJaBBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 20:01:09 -0500
Date: Mon, 30 Oct 2006 17:01:07 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: starvik@axis.com, dev-etrax@axis.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers cris: return on NULL dev_alloc_skb()
In-Reply-To: <Pine.LNX.4.64N.0610301410350.17544@attu2.cs.washington.edu>
Message-ID: <Pine.LNX.4.64N.0610301659530.10486@attu3.cs.washington.edu>
References: <200610302117.24760.jesper.juhl@gmail.com>
 <Pine.LNX.4.64N.0610301410350.17544@attu2.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the next descriptor array entry cannot be allocated by dev_alloc_skb(),
return immediately so it is not dereferenced later.  We cannot register 
the device with a partial descriptor list.

Cc: Mikael Starvik <starvik@axis.com>
Signed-off-by: David Rientjes <rientjes@cs.washington.edu>
---
 drivers/net/cris/eth_v10.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/net/cris/eth_v10.c b/drivers/net/cris/eth_v10.c
index 966b563..a03d781 100644
--- a/drivers/net/cris/eth_v10.c
+++ b/drivers/net/cris/eth_v10.c
@@ -509,6 +509,8 @@ etrax_ethernet_init(void)
 		 * does not share cacheline with any other data (to avoid cache bug)
 		 */
 		RxDescList[i].skb = dev_alloc_skb(MAX_MEDIA_DATA_SIZE + 2 * L1_CACHE_BYTES);
+		if (!RxDescList[i].skb)
+			return -ENOMEM;
 		RxDescList[i].descr.ctrl   = 0;
 		RxDescList[i].descr.sw_len = MAX_MEDIA_DATA_SIZE;
 		RxDescList[i].descr.next   = virt_to_phys(&RxDescList[i + 1]);
