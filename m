Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030525AbWJ3Ja4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030525AbWJ3Ja4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 04:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965498AbWJ3Ja4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 04:30:56 -0500
Received: from [213.46.243.16] ([213.46.243.16]:23418 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S965488AbWJ3Jaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 04:30:55 -0500
Subject: [PATCH 2/2] lockdep: annotate bcsp driver - v2
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Ingo Molnar <mingo@elte.hu>, Jiri Kosina <jikos@jikos.cz>,
       Marcel Holtmann <marcel@holtmann.org>,
       David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1162199192.24143.172.camel@taijtu>
References: <1162199005.24143.169.camel@taijtu>
	 <1162199192.24143.172.camel@taijtu>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 10:31:43 +0100
Message-Id: <1162200703.24143.177.camel@taijtu>
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

Moving a skb from the unack'ed to the rel(iable) list nests the two list locks.
Reliable packets are never moved the other way, hence no circular dependency
exists.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 drivers/bluetooth/hci_bcsp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
@@ -696,7 +696,7 @@ static void bcsp_timed_event(unsigned lo
 
 	BT_DBG("hu %p retransmitting %u pkts", hu, bcsp->unack.qlen);
 
-	spin_lock_irqsave(&bcsp->unack.lock, flags);
+	spin_lock_irqsave_nested(&bcsp->unack.lock, flags, SINGLE_DEPTH_NESTING);
 
 	while ((skb = __skb_dequeue_tail(&bcsp->unack)) != NULL) {
 		bcsp->msgq_txseq = (bcsp->msgq_txseq - 1) & 0x07;


