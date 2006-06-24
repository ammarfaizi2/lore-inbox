Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933371AbWFXJfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933371AbWFXJfF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 05:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933372AbWFXJfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 05:35:04 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:64142 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S933371AbWFXJfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 05:35:02 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sat, 24 Jun 2006 11:33:49 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [RFC PATCH 2.6.17-mm1 2/3] ieee1394: coarser locking for tlabel
 allocation
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.9c73406a85ae9ce4@s5r6.in-berlin.de>
Message-ID: <tkrat.e74b06c4105348f6@s5r6.in-berlin.de>
References: <449BEBFB.60302@s5r6.in-berlin.de>
 <200606230904.k5N94Al3005245@shell0.pdx.osdl.net> 
 <30866.1151072338@warthog.cambridge.redhat.com>
 <tkrat.df6845846c72176e@s5r6.in-berlin.de>
 <tkrat.9c73406a85ae9ce4@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.891) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Full parallelism in getting and freeing transaction labels of different
nodes is not really required.  Therefore reduce the number of locks for
access to tlabel pools from 63 locks per host to 1 global lock.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/ieee1394_transactions.c |   10 ++++++----
 drivers/ieee1394/ieee1394_types.h        |    2 --
 2 files changed, 6 insertions(+), 6 deletions(-)

Index: linux/drivers/ieee1394/ieee1394_types.h
===================================================================
--- linux.orig/drivers/ieee1394/ieee1394_types.h	2006-06-24 09:53:24.000000000 +0200
+++ linux/drivers/ieee1394/ieee1394_types.h	2006-06-24 10:02:15.000000000 +0200
@@ -16,7 +16,6 @@
 /* Transaction Label handling */
 struct hpsb_tlabel_pool {
 	DECLARE_BITMAP(pool, 64);
-	spinlock_t lock;
 #ifdef __BIG_ENDIAN_BITFIELD
 	u32 allocations	:26 __attribute__((packed));
 	u32 next	:6  __attribute__((packed));
@@ -30,7 +29,6 @@ struct hpsb_tlabel_pool {
 #define HPSB_TPOOL_INIT(_tp)			\
 do {						\
 	bitmap_zero((_tp)->pool, 64);		\
-	spin_lock_init(&(_tp)->lock);		\
 	(_tp)->next = 0;			\
 	(_tp)->allocations = 0;			\
 	sema_init(&(_tp)->count, 63);		\
Index: linux/drivers/ieee1394/ieee1394_transactions.c
===================================================================
--- linux.orig/drivers/ieee1394/ieee1394_transactions.c	2006-06-24 09:24:00.000000000 +0200
+++ linux/drivers/ieee1394/ieee1394_transactions.c	2006-06-24 10:08:35.000000000 +0200
@@ -31,6 +31,8 @@
         packet->header[1] = (packet->host->node_id << 16) | (addr >> 32); \
         packet->header[2] = addr & 0xffffffff
 
+static spinlock_t hpsb_tlabel_lock = SPIN_LOCK_UNLOCKED;
+
 static void fill_async_readquad(struct hpsb_packet *packet, u64 addr)
 {
 	PREP_ASYNC_HEAD_ADDRESS(TCODE_READQ);
@@ -149,7 +151,7 @@ int hpsb_get_tlabel(struct hpsb_packet *
 		down(&tp->count);
 	}
 
-	spin_lock_irqsave(&tp->lock, flags);
+	spin_lock_irqsave(&hpsb_tlabel_lock, flags);
 
 	tlabel = find_next_zero_bit(tp->pool, 64, tp->next);
 	if (tlabel > 63)
@@ -160,7 +162,7 @@ int hpsb_get_tlabel(struct hpsb_packet *
 	BUG_ON(test_and_set_bit(tlabel, tp->pool));
 	tp->allocations++;
 
-	spin_unlock_irqrestore(&tp->lock, flags);
+	spin_unlock_irqrestore(&hpsb_tlabel_lock, flags);
 	packet->tlabel = tlabel;
 	return 0;
 }
@@ -188,9 +190,9 @@ void hpsb_free_tlabel(struct hpsb_packet
 
 	BUG_ON(tlabel > 63 || tlabel < 0);
 
-	spin_lock_irqsave(&tp->lock, flags);
+	spin_lock_irqsave(&hpsb_tlabel_lock, flags);
 	BUG_ON(!test_and_clear_bit(tlabel, tp->pool));
-	spin_unlock_irqrestore(&tp->lock, flags);
+	spin_unlock_irqrestore(&hpsb_tlabel_lock, flags);
 
 	up(&tp->count);
 }


