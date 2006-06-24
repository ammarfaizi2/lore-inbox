Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWFXRdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWFXRdq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 13:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWFXRdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 13:33:46 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:16532 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750942AbWFXRdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 13:33:45 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sat, 24 Jun 2006 19:32:28 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [RFC PATCH 2.6.17-mm1 4/3] ieee1394: convert ieee1394_transactions
 from semaphores to waitqueue
To: linux1394-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.2ff7b57397a5a37e@s5r6.in-berlin.de>
Message-ID: <tkrat.3f9c07538e381afd@s5r6.in-berlin.de>
References: <449BEBFB.60302@s5r6.in-berlin.de>
 <200606230904.k5N94Al3005245@shell0.pdx.osdl.net> 
 <30866.1151072338@warthog.cambridge.redhat.com>
 <tkrat.df6845846c72176e@s5r6.in-berlin.de>
 <tkrat.9c73406a85ae9ce4@s5r6.in-berlin.de>
 <tkrat.e74b06c4105348f6@s5r6.in-berlin.de>
 <tkrat.2ff7b57397a5a37e@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.894) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There were 63 instances of counting semaphores used for each hpsb_host.
All of them are now replaced by a single wait_queue.

Note, it is rather unlikely that a process has to wait for a transaction
label to become free.  This condition occurs only if more than 64
transactions are initiated before the receiving node is able to complete
any of them.

A slight change in behaviour is introduced:  Allocation of a tlabel will
fail if a signal was received while the process had to sleep until a
tlabel becomes available.  Previously, the process slept uninterruptibly
on the semaphore until availability of a tlabel.  Furthermore, error
return values of hpsb_get_tlabel() are now -ERESTARTSYS or -EAGAIN
instead of 1.  However an error return value has always been defined as
"non-zero" in the API and all in-tree callers respect that.

The macro HPSB_TPOOL_INIT is no longer necessary since struct hpsb_host
is kzalloc'd.

The spinlock-protected code which accesses tlabel pools can use the
non-atomic variants of bitmap manipulation functions.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/hosts.c                 |    3
 drivers/ieee1394/ieee1394_transactions.c |   82 ++++++++++++-----------
 drivers/ieee1394/ieee1394_types.h        |   10 --
 3 files changed, 46 insertions(+), 49 deletions(-)

Index: linux-2.6.17-mm1/drivers/ieee1394/ieee1394_types.h
===================================================================
--- linux-2.6.17-mm1.orig/drivers/ieee1394/ieee1394_types.h	2006-06-24 11:11:55.000000000 +0200
+++ linux-2.6.17-mm1/drivers/ieee1394/ieee1394_types.h	2006-06-24 18:03:24.000000000 +0200
@@ -23,18 +23,8 @@ struct hpsb_tlabel_pool {
 	u32 next	:6  __attribute__((packed));
 	u32 allocations	:26 __attribute__((packed));
 #endif
-	struct semaphore count;
 };
 
-#define HPSB_TPOOL_INIT(_tp)			\
-do {						\
-	bitmap_zero((_tp)->pool, 64);		\
-	(_tp)->next = 0;			\
-	(_tp)->allocations = 0;			\
-	sema_init(&(_tp)->count, 63);		\
-} while (0)
-
-
 typedef u32 quadlet_t;
 typedef u64 octlet_t;
 typedef u16 nodeid_t;
Index: linux-2.6.17-mm1/drivers/ieee1394/hosts.c
===================================================================
--- linux-2.6.17-mm1.orig/drivers/ieee1394/hosts.c	2006-06-23 17:58:03.000000000 +0200
+++ linux-2.6.17-mm1/drivers/ieee1394/hosts.c	2006-06-24 18:03:24.000000000 +0200
@@ -143,9 +143,6 @@ struct hpsb_host *hpsb_alloc_host(struct
 	for (i = 2; i < 16; i++)
 		h->csr.gen_timestamp[i] = jiffies - 60 * HZ;
 
-	for (i = 0; i < ARRAY_SIZE(h->tpool); i++)
-		HPSB_TPOOL_INIT(&h->tpool[i]);
-
 	atomic_set(&h->generation, 0);
 
 	INIT_WORK(&h->delayed_reset, delayed_reset_bus, h);
Index: linux-2.6.17-mm1/drivers/ieee1394/ieee1394_transactions.c
===================================================================
--- linux-2.6.17-mm1.orig/drivers/ieee1394/ieee1394_transactions.c	2006-06-24 11:12:01.000000000 +0200
+++ linux-2.6.17-mm1/drivers/ieee1394/ieee1394_transactions.c	2006-06-24 18:03:24.000000000 +0200
@@ -9,10 +9,9 @@
  * directory of the kernel sources for details.
  */
 
-#include <linux/sched.h>
 #include <linux/bitops.h>
-#include <linux/smp_lock.h>
-#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
 
 #include <asm/errno.h>
 
@@ -20,8 +19,6 @@
 #include "ieee1394_types.h"
 #include "hosts.h"
 #include "ieee1394_core.h"
-#include "highlevel.h"
-#include "nodemgr.h"
 #include "ieee1394_transactions.h"
 
 #define PREP_ASYNC_HEAD_ADDRESS(tc) \
@@ -32,6 +29,7 @@
         packet->header[2] = addr & 0xffffffff
 
 spinlock_t hpsb_tlabel_lock = SPIN_LOCK_UNLOCKED;
+static DECLARE_WAIT_QUEUE_HEAD(tlabel_wq);
 
 static void fill_async_readquad(struct hpsb_packet *packet, u64 addr)
 {
@@ -116,50 +114,35 @@ static void fill_async_stream_packet(str
 	packet->tcode = TCODE_ISO_DATA;
 }
 
-/**
- * hpsb_get_tlabel - allocate a transaction label
- * @packet: the packet who's tlabel/tpool we set
- *
- * Every asynchronous transaction on the 1394 bus needs a transaction
- * label to match the response to the request.  This label has to be
- * different from any other transaction label in an outstanding request to
- * the same node to make matching possible without ambiguity.
- *
- * There are 64 different tlabels, so an allocated tlabel has to be freed
- * with hpsb_free_tlabel() after the transaction is complete (unless it's
- * reused again for the same target node).
- *
- * Return value: Zero on success, otherwise non-zero. A non-zero return
- * generally means there are no available tlabels. If this is called out
- * of interrupt or atomic context, then it will sleep until can return a
- * tlabel.
- */
-int hpsb_get_tlabel(struct hpsb_packet *packet)
+/* same as hpsb_get_tlabel, except that it returns immediately */
+static int hpsb_get_tlabel_atomic(struct hpsb_packet *packet)
 {
 	unsigned long flags;
 	struct hpsb_tlabel_pool *tp;
 	int tlabel, n = NODEID_TO_NODE(packet->node_id);
 
-	if (unlikely(n == ALL_NODES))
+	/* Broadcast transactions are complete once the request has been sent.
+	 * Use the same transaction label for all broadcast transactions. */
+	if (unlikely(n == ALL_NODES)) {
+		packet->tlabel = 0;
 		return 0;
-	tp = &packet->host->tpool[n];
-
-	if (irqs_disabled() || in_atomic()) {
-		if (down_trylock(&tp->count))
-			return 1;
-	} else {
-		down(&tp->count);
 	}
+	BUG_ON(n > ARRAY_SIZE(packet->host->tpool));
+	tp = &packet->host->tpool[n];
 
 	spin_lock_irqsave(&hpsb_tlabel_lock, flags);
 
 	tlabel = find_next_zero_bit(tp->pool, 64, tp->next);
 	if (tlabel > 63)
 		tlabel = find_first_zero_bit(tp->pool, 64);
+	if (tlabel > 63) {
+		spin_unlock_irqrestore(&hpsb_tlabel_lock, flags);
+		return -EAGAIN;
+	}
+	__set_bit(tlabel, tp->pool);
+
 	/* tp->next is 6 bits wide, thus rolls over from 63 to 0 */
 	tp->next = (tlabel + 1);
-	/* Should _never_ happen */
-	BUG_ON(test_and_set_bit(tlabel, tp->pool));
 	tp->allocations++;
 
 	spin_unlock_irqrestore(&hpsb_tlabel_lock, flags);
@@ -168,6 +151,33 @@ int hpsb_get_tlabel(struct hpsb_packet *
 }
 
 /**
+ * hpsb_get_tlabel - allocate a transaction label
+ * @packet: the packet who's tlabel/tpool we set
+ *
+ * Every asynchronous transaction on the 1394 bus needs a transaction
+ * label to match the response to the request.  This label has to be
+ * different from any other transaction label in an outstanding request to
+ * the same node to make matching possible without ambiguity.
+ *
+ * There are 64 different tlabels, so an allocated tlabel has to be freed
+ * with hpsb_free_tlabel() after the transaction is complete (unless it's
+ * reused again for the same target node).
+ *
+ * Return value: Zero on success, otherwise non-zero. A non-zero return
+ * generally means there are no available tlabels. If this is called out
+ * of interrupt or atomic context, then it will sleep until can return a
+ * tlabel or a signal is received.
+ */
+int hpsb_get_tlabel(struct hpsb_packet *packet)
+{
+	if (irqs_disabled() || in_atomic())
+		return hpsb_get_tlabel_atomic(packet);
+
+	return wait_event_interruptible(tlabel_wq,
+					!hpsb_get_tlabel_atomic(packet));
+}
+
+/**
  * hpsb_free_tlabel - free an allocated transaction label
  * @packet: packet whos tlabel/tpool needs to be cleared
  *
@@ -191,10 +201,10 @@ void hpsb_free_tlabel(struct hpsb_packet
 	BUG_ON(tlabel > 63 || tlabel < 0);
 
 	spin_lock_irqsave(&hpsb_tlabel_lock, flags);
-	BUG_ON(!test_and_clear_bit(tlabel, tp->pool));
+	BUG_ON(!__test_and_clear_bit(tlabel, tp->pool));
 	spin_unlock_irqrestore(&hpsb_tlabel_lock, flags);
 
-	up(&tp->count);
+	wake_up_interruptible(&tlabel_wq);
 }
 
 int hpsb_packet_success(struct hpsb_packet *packet)


