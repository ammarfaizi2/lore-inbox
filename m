Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbWJJVAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWJJVAO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbWJJVAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:00:13 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:58065 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030367AbWJJVAL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:00:11 -0400
Date: Tue, 10 Oct 2006 16:00:04 -0500
To: akpm@osdl.org
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: [PATCH 4/21]: powerpc/cell spidernet force-end fix
Message-ID: <20061010210004.GA4381@austin.ibm.com>
References: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010204946.GW4381@austin.ibm.com>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bugfix: when cleaning up the transmit queue upon device close,
be sure to walk the entire queue.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: James K Lewis <jklewis@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>

----
 drivers/net/spider_net.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6.18-mm2/drivers/net/spider_net.c
===================================================================
--- linux-2.6.18-mm2.orig/drivers/net/spider_net.c	2006-10-10 12:21:40.000000000 -0500
+++ linux-2.6.18-mm2/drivers/net/spider_net.c	2006-10-10 12:22:49.000000000 -0500
@@ -699,6 +699,8 @@ spider_net_release_tx_descr(struct spide
 
 	/* unmap the skb */
 	skb = descr->skb;
+	if (!skb)
+		return;
 	pci_unmap_single(card->pdev, descr->buf_addr, skb->len,
 			PCI_DMA_TODEVICE);
 	dev_kfree_skb_any(skb);
@@ -751,7 +753,8 @@ spider_net_release_tx_chain(struct spide
 
 		default:
 			card->netdev_stats.tx_dropped++;
-			return 1;
+			if (!brutal)
+				return 1;
 		}
 		spider_net_release_tx_descr(card);
 	}
