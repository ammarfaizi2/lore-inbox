Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965470AbWJ3JFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965470AbWJ3JFi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 04:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965471AbWJ3JFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 04:05:38 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:26035 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S965470AbWJ3JFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 04:05:37 -0500
Subject: [PATCH 2/2] lockdep: annotate bcsp driver
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Jiri Kosina <jikos@jikos.cz>, Marcel Holtmann <marcel@holtmann.org>,
       David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1162199005.24143.169.camel@taijtu>
References: <1162199005.24143.169.camel@taijtu>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 10:06:32 +0100
Message-Id: <1162199192.24143.172.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


=============================================
[ INFO: possible recursive locking detected ]
2.6.18-1.2699.fc6 #1
---------------------------------------------
swapper/0 is trying to acquire lock:
 (&list->lock#3){+...}, at: [<c05ad307>] skb_dequeue+0x12/0x43

but task is already holding lock:
 (&list->lock#3){+...}, at: [<df98cd79>] bcsp_dequeue+0x6a/0x11e [hci_uart]


Two different list locks nest, annotate so.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 drivers/bluetooth/hci_bcsp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/bluetooth/hci_bcsp.c
===================================================================
--- linux-2.6.orig/drivers/bluetooth/hci_bcsp.c
+++ linux-2.6/drivers/bluetooth/hci_bcsp.c
@@ -330,7 +330,7 @@ static struct sk_buff *bcsp_dequeue(stru
 	   reliable packet if the number of packets sent but not yet ack'ed
 	   is < than the winsize */
 
-	spin_lock_irqsave(&bcsp->unack.lock, flags);
+	spin_lock_irqsave_nested(&bcsp->unack.lock, flags, SINGLE_DEPTH_NESTING);
 
 	if (bcsp->unack.qlen < BCSP_TXWINSIZE && (skb = skb_dequeue(&bcsp->rel)) != NULL) {
 		struct sk_buff *nskb = bcsp_prepare_pkt(bcsp, skb->data, skb->len, bt_cb(skb)->pkt_type);


