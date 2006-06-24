Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933363AbWFXJd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933363AbWFXJd1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 05:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933371AbWFXJd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 05:33:26 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:57998 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S933363AbWFXJd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 05:33:26 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sat, 24 Jun 2006 11:32:09 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [RFC PATCH 2.6.17-mm1 1/3] ieee1394: reduce size of hpsb_host by 252
 bytes
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.df6845846c72176e@s5r6.in-berlin.de>
Message-ID: <tkrat.9c73406a85ae9ce4@s5r6.in-berlin.de>
References: <449BEBFB.60302@s5r6.in-berlin.de>
 <200606230904.k5N94Al3005245@shell0.pdx.osdl.net> 
 <30866.1151072338@warthog.cambridge.redhat.com>
 <tkrat.df6845846c72176e@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.89) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Struct hpsb_host contains struct hpsb_tlabel_pool 63 times, therefore
each word that can be shaved off of hpsb_tlabel_pool is a win.

Since hpsb_tlabel_pool.next is accessed twice as often as .allocations,
.next is put into the lower part of the word.  The value of .allocations
rolls over after about 67 million now but we don't care.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/ieee1394_transactions.c |   22 ++++++++++++----------
 drivers/ieee1394/ieee1394_types.h        |    9 +++++++--
 2 files changed, 19 insertions(+), 12 deletions(-)

Index: linux/drivers/ieee1394/ieee1394_types.h
===================================================================
--- linux.orig/drivers/ieee1394/ieee1394_types.h	2006-04-24 22:20:24.000000000 +0200
+++ linux/drivers/ieee1394/ieee1394_types.h	2006-06-24 09:52:37.000000000 +0200
@@ -17,8 +17,13 @@
 struct hpsb_tlabel_pool {
 	DECLARE_BITMAP(pool, 64);
 	spinlock_t lock;
-	u8 next;
-	u32 allocations;
+#ifdef __BIG_ENDIAN_BITFIELD
+	u32 allocations	:26 __attribute__((packed));
+	u32 next	:6  __attribute__((packed));
+#else
+	u32 next	:6  __attribute__((packed));
+	u32 allocations	:26 __attribute__((packed));
+#endif
 	struct semaphore count;
 };
 
Index: linux/drivers/ieee1394/ieee1394_transactions.c
===================================================================
--- linux.orig/drivers/ieee1394/ieee1394_transactions.c	2006-06-23 19:10:30.000000000 +0200
+++ linux/drivers/ieee1394/ieee1394_transactions.c	2006-06-24 09:24:00.000000000 +0200
@@ -136,7 +136,7 @@ int hpsb_get_tlabel(struct hpsb_packet *
 {
 	unsigned long flags;
 	struct hpsb_tlabel_pool *tp;
-	int n = NODEID_TO_NODE(packet->node_id);
+	int tlabel, n = NODEID_TO_NODE(packet->node_id);
 
 	if (unlikely(n == ALL_NODES))
 		return 0;
@@ -151,15 +151,17 @@ int hpsb_get_tlabel(struct hpsb_packet *
 
 	spin_lock_irqsave(&tp->lock, flags);
 
-	packet->tlabel = find_next_zero_bit(tp->pool, 64, tp->next);
-	if (packet->tlabel > 63)
-		packet->tlabel = find_first_zero_bit(tp->pool, 64);
-	tp->next = (packet->tlabel + 1) % 64;
+	tlabel = find_next_zero_bit(tp->pool, 64, tp->next);
+	if (tlabel > 63)
+		tlabel = find_first_zero_bit(tp->pool, 64);
+	/* tp->next is 6 bits wide, thus rolls over from 63 to 0 */
+	tp->next = (tlabel + 1);
 	/* Should _never_ happen */
-	BUG_ON(test_and_set_bit(packet->tlabel, tp->pool));
+	BUG_ON(test_and_set_bit(tlabel, tp->pool));
 	tp->allocations++;
-	spin_unlock_irqrestore(&tp->lock, flags);
 
+	spin_unlock_irqrestore(&tp->lock, flags);
+	packet->tlabel = tlabel;
 	return 0;
 }
 
@@ -178,16 +180,16 @@ void hpsb_free_tlabel(struct hpsb_packet
 {
 	unsigned long flags;
 	struct hpsb_tlabel_pool *tp;
-	int n = NODEID_TO_NODE(packet->node_id);
+	int tlabel = packet->tlabel, n = NODEID_TO_NODE(packet->node_id);
 
 	if (unlikely(n == ALL_NODES))
 		return;
 	tp = &packet->host->tpool[n];
 
-	BUG_ON(packet->tlabel > 63 || packet->tlabel < 0);
+	BUG_ON(tlabel > 63 || tlabel < 0);
 
 	spin_lock_irqsave(&tp->lock, flags);
-	BUG_ON(!test_and_clear_bit(packet->tlabel, tp->pool));
+	BUG_ON(!test_and_clear_bit(tlabel, tp->pool));
 	spin_unlock_irqrestore(&tp->lock, flags);
 
 	up(&tp->count);


