Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTD2JQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 05:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbTD2JQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 05:16:28 -0400
Received: from 237.oncolt.com ([213.86.99.237]:63968 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S261294AbTD2JQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 05:16:27 -0400
Subject: [PATCH]  Fix V.110 on HiSax HFC_PCI.
From: David Woodhouse <dwmw2@infradead.org>
To: marcelo@conectiva.com.br
Cc: kkeil@suse.de, kai.germaschewski@gmx.de, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1051608519.18316.118.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Tue, 29 Apr 2003 10:28:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes V.110 dialin to HFC_PCI ISDN adapters, which weren't
sending V.110 idle frames correctly before due to missing wakeups from
the low-level driver.

This is for 2.4 only -- 2.5 with ISDN doesn't even boot for me at the moment.

--- drivers/isdn/hisax/hfc_pci.c.orig	2003-04-26 00:19:36.000000000 +0100
+++ drivers/isdn/hisax/hfc_pci.c	2003-04-26 00:19:43.000000000 +0100
@@ -687,6 +687,10 @@
 				debugl1(cs, "hfcpci_fill_fifo_trans %d frame length %d discarded",
 					bcs->channel, bcs->tx_skb->len);
 
+			if (bcs->st->lli.l1writewakeup &&
+                           (PACKET_NOACK != bcs->tx_skb->pkt_type))
+				bcs->st->lli.l1writewakeup(bcs->st, bcs->tx_skb->len);
+
 			dev_kfree_skb_any(bcs->tx_skb);
 			cli();
 			bcs->tx_skb = skb_dequeue(&bcs->squeue);	/* fetch next data */








-- 
dwmw2

