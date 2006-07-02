Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWGBXcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWGBXcQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 19:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWGBXcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 19:32:16 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:6616 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750729AbWGBXcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 19:32:14 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 3 Jul 2006 01:31:50 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 19/19] ieee1394: shrink tlabel pools, remove tpool semaphores
To: Ben Collins <bcollins@ubuntu.com>
cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
Message-ID: <tkrat.881c6b6077970c63@s5r6.in-berlin.de>
References: <tkrat.8d67352567e525c1@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.907) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reduces the size of struct hpsb_host and also removes
semaphores from ieee1394_transactions.c.  On i386, struct hpsb_host
shrinks from 10656 bytes to 6688 bytes.  This is accomplished by
 - using a single wait_queue for hpsb_get_tlabel instead of many
   instances of semaphores,
 - using a single lock to serialize access to all tlabel pools (the
   protected code regions are small, i.e. lock contention very low),
 - omitting the sysfs attribute tlabels_allocations.

Drawback:  In the rare case that a process needs to sleep because all
transaction labels for the node are temporarily exhausted, it is also
woken up if a tlabel for a different node became free, checks for an
available tlabel, and is put to sleep again.  The check is not costly
and the situation occurs very rarely, therefore the benefit of reduced
tpool size outweighs this drawback.

The sysfs attributes tlabels_free and tlabels_mask are not compiled
anymore unless CONFIG_IEEE1394_VERBOSEDEBUG is set.

The by far biggest member of struct hpsb_host, the struct csr_control
csr (5272 bytes on i386), is now placed at the end of struct hpsb_host.

Note, hpsb_get_tlabel calls the macro wait_event_interruptible with a
condition argument which has a side effect (allocation of a tlabel and
manipulation of the packet).  This side effect happens only if the
condition is true.  The patch relies on wait_event_interruptible not
evaluating the condition again after it became true.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Replaces the patches
  "ieee1394: reduce size of hpsb_host by 252 bytes"
  "ieee1394: coarser locking for tlabel allocation"
  "ieee1394: nodemgr: read tlabel attributes atomically"
  "ieee1394: convert ieee1394_transactions from semaphores to waitqueue"

 drivers/ieee1394/hosts.c                 |    3
 drivers/ieee1394/hosts.h                 |   19 +---
 drivers/ieee1394/ieee1394_transactions.c |  108 +++++++++++++----------
 drivers/ieee1394/ieee1394_transactions.h |    4
 drivers/ieee1394/ieee1394_types.h        |   23 ----
 drivers/ieee1394/nodemgr.c               |   43 +++++----
 drivers/ieee1394/nodemgr.h               |    1
 7 files changed, 102 insertions(+), 99 deletions(-)

Index: linux-2.6.17-mm5/drivers/ieee1394/ieee1394_types.h
===================================================================
--- linux-2.6.17-mm5.orig/drivers/ieee1394/ieee1394_types.h	2006-07-02 13:45:10.000000000 +0200
+++ linux-2.6.17-mm5/drivers/ieee1394/ieee1394_types.h	2006-07-02 13:51:29.000000000 +0200
@@ -2,31 +2,9 @@
 #define _IEEE1394_TYPES_H
 
 #include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/types.h>
-
 #include <asm/byteorder.h>
-#include <asm/semaphore.h>
-
-/* Transaction Label handling */
-struct hpsb_tlabel_pool {
-	DECLARE_BITMAP(pool, 64);
-	spinlock_t lock;
-	u8 next;
-	u32 allocations;
-	struct semaphore count;
-};
-
-#define HPSB_TPOOL_INIT(_tp)			\
-do {						\
-	bitmap_zero((_tp)->pool, 64);		\
-	spin_lock_init(&(_tp)->lock);		\
-	(_tp)->next = 0;			\
-	(_tp)->allocations = 0;			\
-	sema_init(&(_tp)->count, 63);		\
-} while (0)
 
 typedef u32 quadlet_t;
 typedef u64 octlet_t;
@@ -61,6 +39,7 @@ typedef u16 arm_length_t;
 
 #ifdef CONFIG_IEEE1394_VERBOSEDEBUG
 #define HPSB_VERBOSE(fmt, args...)	HPSB_PRINT(KERN_DEBUG, fmt , ## args)
+#define HPSB_DEBUG_TLABELS
 #else
 #define HPSB_VERBOSE(fmt, args...)
 #endif
Index: linux-2.6.17-mm5/drivers/ieee1394/hosts.h
===================================================================
--- linux-2.6.17-mm5.orig/drivers/ieee1394/hosts.h	2006-07-02 13:45:41.000000000 +0200
+++ linux-2.6.17-mm5/drivers/ieee1394/hosts.h	2006-07-02 13:51:29.000000000 +0200
@@ -35,7 +35,6 @@ struct hpsb_host {
 	int node_count;      /* number of identified nodes on this bus */
 	int selfid_count;    /* total number of SelfIDs received */
 	int nodes_active;    /* number of nodes with active link layer */
-	u8 speed[ALL_NODES]; /* speed between each node and local node */
 
 	nodeid_t node_id;    /* node ID of this host */
 	nodeid_t irm_id;     /* ID of this bus' isochronous resource manager */
@@ -55,31 +54,29 @@ struct hpsb_host {
 	int reset_retries;
 	quadlet_t *topology_map;
 	u8 *speed_map;
-	struct csr_control csr;
-
-	/* Per node tlabel pool allocation */
-	struct hpsb_tlabel_pool tpool[ALL_NODES];
 
+	int id;
 	struct hpsb_host_driver *driver;
-
 	struct pci_dev *pdev;
-
-	int id;
-
 	struct device device;
 	struct class_device class_dev;
 
 	int update_config_rom;
 	struct work_struct delayed_reset;
-
 	unsigned int config_roms;
 
 	struct list_head addr_space;
 	u64 low_addr_space;	/* upper bound of physical DMA area */
 	u64 middle_addr_space;	/* upper bound of posted write area */
-};
 
+	u8 speed[ALL_NODES];	/* speed between each node and local node */
 
+	/* per node tlabel allocation */
+	u8 next_tl[ALL_NODES];
+	struct { DECLARE_BITMAP(map, 64); } tl_pool[ALL_NODES];
+
+	struct csr_control csr;
+};
 
 enum devctl_cmd {
 	/* Host is requested to reset its bus and cancel all outstanding async
Index: linux-2.6.17-mm5/drivers/ieee1394/hosts.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/ieee1394/hosts.c	2006-07-01 20:30:01.000000000 +0200
+++ linux-2.6.17-mm5/drivers/ieee1394/hosts.c	2006-07-02 13:55:48.000000000 +0200
@@ -143,9 +143,6 @@ struct hpsb_host *hpsb_alloc_host(struct
 	for (i = 2; i < 16; i++)
 		h->csr.gen_timestamp[i] = jiffies - 60 * HZ;
 
-	for (i = 0; i < ARRAY_SIZE(h->tpool); i++)
-		HPSB_TPOOL_INIT(&h->tpool[i]);
-
 	atomic_set(&h->generation, 0);
 
 	INIT_WORK(&h->delayed_reset, delayed_reset_bus, h);
Index: linux-2.6.17-mm5/drivers/ieee1394/ieee1394_transactions.h
===================================================================
--- linux-2.6.17-mm5.orig/drivers/ieee1394/ieee1394_transactions.h	2006-07-02 13:44:15.000000000 +0200
+++ linux-2.6.17-mm5/drivers/ieee1394/ieee1394_transactions.h	2006-07-02 13:51:29.000000000 +0200
@@ -53,4 +53,8 @@ int hpsb_read(struct hpsb_host *host, no
 int hpsb_write(struct hpsb_host *host, nodeid_t node, unsigned int generation,
 	       u64 addr, quadlet_t *buffer, size_t length);
 
+#ifdef HPSB_DEBUG_TLABELS
+extern spinlock_t hpsb_tlabel_lock;
+#endif
+
 #endif /* _IEEE1394_TRANSACTIONS_H */
Index: linux-2.6.17-mm5/drivers/ieee1394/ieee1394_transactions.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/ieee1394/ieee1394_transactions.c	2006-07-02 13:45:10.000000000 +0200
+++ linux-2.6.17-mm5/drivers/ieee1394/ieee1394_transactions.c	2006-07-02 13:51:29.000000000 +0200
@@ -9,10 +9,9 @@
  * directory of the kernel sources for details.
  */
 
-#include <linux/sched.h>
 #include <linux/bitops.h>
-#include <linux/smp_lock.h>
-#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
 
 #include <asm/bug.h>
 #include <asm/errno.h>
@@ -21,8 +20,6 @@
 #include "ieee1394_types.h"
 #include "hosts.h"
 #include "ieee1394_core.h"
-#include "highlevel.h"
-#include "nodemgr.h"
 #include "ieee1394_transactions.h"
 
 #define PREP_ASYNC_HEAD_ADDRESS(tc) \
@@ -32,6 +29,13 @@
         packet->header[1] = (packet->host->node_id << 16) | (addr >> 32); \
         packet->header[2] = addr & 0xffffffff
 
+#ifndef HPSB_DEBUG_TLABELS
+static
+#endif
+spinlock_t hpsb_tlabel_lock = SPIN_LOCK_UNLOCKED;
+
+static DECLARE_WAIT_QUEUE_HEAD(tlabel_wq);
+
 static void fill_async_readquad(struct hpsb_packet *packet, u64 addr)
 {
 	PREP_ASYNC_HEAD_ADDRESS(TCODE_READQ);
@@ -115,9 +119,41 @@ static void fill_async_stream_packet(str
 	packet->tcode = TCODE_ISO_DATA;
 }
 
+/* same as hpsb_get_tlabel, except that it returns immediately */
+static int hpsb_get_tlabel_atomic(struct hpsb_packet *packet)
+{
+	unsigned long flags, *tp;
+	u8 *next;
+	int tlabel, n = NODEID_TO_NODE(packet->node_id);
+
+	/* Broadcast transactions are complete once the request has been sent.
+	 * Use the same transaction label for all broadcast transactions. */
+	if (unlikely(n == ALL_NODES)) {
+		packet->tlabel = 0;
+		return 0;
+	}
+	tp = packet->host->tl_pool[n].map;
+	next = &packet->host->next_tl[n];
+
+	spin_lock_irqsave(&hpsb_tlabel_lock, flags);
+	tlabel = find_next_zero_bit(tp, 64, *next);
+	if (tlabel > 63)
+		tlabel = find_first_zero_bit(tp, 64);
+	if (tlabel > 63) {
+		spin_unlock_irqrestore(&hpsb_tlabel_lock, flags);
+		return -EAGAIN;
+	}
+	__set_bit(tlabel, tp);
+	*next = (tlabel + 1) & 63;
+	spin_unlock_irqrestore(&hpsb_tlabel_lock, flags);
+
+	packet->tlabel = tlabel;
+	return 0;
+}
+
 /**
  * hpsb_get_tlabel - allocate a transaction label
- * @packet: the packet who's tlabel/tpool we set
+ * @packet: the packet whose tlabel and tl_pool we set
  *
  * Every asynchronous transaction on the 1394 bus needs a transaction
  * label to match the response to the request.  This label has to be
@@ -131,42 +167,25 @@ static void fill_async_stream_packet(str
  * Return value: Zero on success, otherwise non-zero. A non-zero return
  * generally means there are no available tlabels. If this is called out
  * of interrupt or atomic context, then it will sleep until can return a
- * tlabel.
+ * tlabel or a signal is received.
  */
 int hpsb_get_tlabel(struct hpsb_packet *packet)
 {
-	unsigned long flags;
-	struct hpsb_tlabel_pool *tp;
-	int n = NODEID_TO_NODE(packet->node_id);
+	if (irqs_disabled() || in_atomic())
+		return hpsb_get_tlabel_atomic(packet);
 
-	if (unlikely(n == ALL_NODES))
-		return 0;
-	tp = &packet->host->tpool[n];
-
-	if (irqs_disabled() || in_atomic()) {
-		if (down_trylock(&tp->count))
-			return 1;
-	} else {
-		down(&tp->count);
-	}
-
-	spin_lock_irqsave(&tp->lock, flags);
-
-	packet->tlabel = find_next_zero_bit(tp->pool, 64, tp->next);
-	if (packet->tlabel > 63)
-		packet->tlabel = find_first_zero_bit(tp->pool, 64);
-	tp->next = (packet->tlabel + 1) % 64;
-	/* Should _never_ happen */
-	BUG_ON(test_and_set_bit(packet->tlabel, tp->pool));
-	tp->allocations++;
-	spin_unlock_irqrestore(&tp->lock, flags);
-
-	return 0;
+	/* NB: The macro wait_event_interruptible() is called with a condition
+	 * argument with side effect.  This is only possible because the side
+	 * effect does not occur until the condition became true, and
+	 * wait_event_interruptible() won't evaluate the condition again after
+	 * that. */
+	return wait_event_interruptible(tlabel_wq,
+					!hpsb_get_tlabel_atomic(packet));
 }
 
 /**
  * hpsb_free_tlabel - free an allocated transaction label
- * @packet: packet whos tlabel/tpool needs to be cleared
+ * @packet: packet whose tlabel and tl_pool needs to be cleared
  *
  * Frees the transaction label allocated with hpsb_get_tlabel().  The
  * tlabel has to be freed after the transaction is complete (i.e. response
@@ -177,21 +196,20 @@ int hpsb_get_tlabel(struct hpsb_packet *
  */
 void hpsb_free_tlabel(struct hpsb_packet *packet)
 {
-	unsigned long flags;
-	struct hpsb_tlabel_pool *tp;
-	int n = NODEID_TO_NODE(packet->node_id);
+	unsigned long flags, *tp;
+	int tlabel, n = NODEID_TO_NODE(packet->node_id);
 
 	if (unlikely(n == ALL_NODES))
 		return;
-	tp = &packet->host->tpool[n];
-
-	BUG_ON(packet->tlabel > 63 || packet->tlabel < 0);
-
-	spin_lock_irqsave(&tp->lock, flags);
-	BUG_ON(!test_and_clear_bit(packet->tlabel, tp->pool));
-	spin_unlock_irqrestore(&tp->lock, flags);
+	tp = packet->host->tl_pool[n].map;
+	tlabel = packet->tlabel;
+	BUG_ON(tlabel > 63 || tlabel < 0);
+
+	spin_lock_irqsave(&hpsb_tlabel_lock, flags);
+	BUG_ON(!__test_and_clear_bit(tlabel, tp));
+	spin_unlock_irqrestore(&hpsb_tlabel_lock, flags);
 
-	up(&tp->count);
+	wake_up_interruptible(&tlabel_wq);
 }
 
 int hpsb_packet_success(struct hpsb_packet *packet)
Index: linux-2.6.17-mm5/drivers/ieee1394/nodemgr.h
===================================================================
--- linux-2.6.17-mm5.orig/drivers/ieee1394/nodemgr.h	2006-07-02 13:44:15.000000000 +0200
+++ linux-2.6.17-mm5/drivers/ieee1394/nodemgr.h	2006-07-02 13:51:29.000000000 +0200
@@ -107,7 +107,6 @@ struct node_entry {
 	const char *vendor_oui;
 
 	u32 capabilities;
-	struct hpsb_tlabel_pool *tpool;
 
 	struct device device;
 	struct class_device class_dev;
Index: linux-2.6.17-mm5/drivers/ieee1394/nodemgr.c
===================================================================
--- linux-2.6.17-mm5.orig/drivers/ieee1394/nodemgr.c	2006-07-02 13:50:47.000000000 +0200
+++ linux-2.6.17-mm5/drivers/ieee1394/nodemgr.c	2006-07-02 13:51:29.000000000 +0200
@@ -327,34 +327,44 @@ static ssize_t fw_show_ne_bus_options(st
 static DEVICE_ATTR(bus_options,S_IRUGO,fw_show_ne_bus_options,NULL);
 
 
-/* tlabels_free, tlabels_allocations, tlabels_mask are read non-atomically
- * here, therefore displayed values may be occasionally wrong. */
-static ssize_t fw_show_ne_tlabels_free(struct device *dev, struct device_attribute *attr, char *buf)
+#ifdef HPSB_DEBUG_TLABELS
+static ssize_t fw_show_ne_tlabels_free(struct device *dev,
+				       struct device_attribute *attr, char *buf)
 {
 	struct node_entry *ne = container_of(dev, struct node_entry, device);
-	return sprintf(buf, "%d\n", 64 - bitmap_weight(ne->tpool->pool, 64));
+	unsigned long flags;
+	unsigned long *tp = ne->host->tl_pool[NODEID_TO_NODE(ne->nodeid)].map;
+	int tf;
+
+	spin_lock_irqsave(&hpsb_tlabel_lock, flags);
+	tf = 64 - bitmap_weight(tp, 64);
+	spin_unlock_irqrestore(&hpsb_tlabel_lock, flags);
+
+	return sprintf(buf, "%d\n", tf);
 }
 static DEVICE_ATTR(tlabels_free,S_IRUGO,fw_show_ne_tlabels_free,NULL);
 
 
-static ssize_t fw_show_ne_tlabels_allocations(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t fw_show_ne_tlabels_mask(struct device *dev,
+				       struct device_attribute *attr, char *buf)
 {
 	struct node_entry *ne = container_of(dev, struct node_entry, device);
-	return sprintf(buf, "%u\n", ne->tpool->allocations);
-}
-static DEVICE_ATTR(tlabels_allocations,S_IRUGO,fw_show_ne_tlabels_allocations,NULL);
+	unsigned long flags;
+	unsigned long *tp = ne->host->tl_pool[NODEID_TO_NODE(ne->nodeid)].map;
+	u64 tm;
 
-
-static ssize_t fw_show_ne_tlabels_mask(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct node_entry *ne = container_of(dev, struct node_entry, device);
+	spin_lock_irqsave(&hpsb_tlabel_lock, flags);
 #if (BITS_PER_LONG <= 32)
-	return sprintf(buf, "0x%08lx%08lx\n", ne->tpool->pool[0], ne->tpool->pool[1]);
+	tm = ((u64)tp[0] << 32) + tp[1];
 #else
-	return sprintf(buf, "0x%016lx\n", ne->tpool->pool[0]);
+	tm = tp[0];
 #endif
+	spin_unlock_irqrestore(&hpsb_tlabel_lock, flags);
+
+	return sprintf(buf, "0x%016llx\n", tm);
 }
 static DEVICE_ATTR(tlabels_mask, S_IRUGO, fw_show_ne_tlabels_mask, NULL);
+#endif /* HPSB_DEBUG_TLABELS */
 
 
 static ssize_t fw_set_ignore_driver(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
@@ -461,9 +471,10 @@ static struct device_attribute *const fw
 	&dev_attr_ne_vendor_id,
 	&dev_attr_ne_nodeid,
 	&dev_attr_bus_options,
+#ifdef HPSB_DEBUG_TLABELS
 	&dev_attr_tlabels_free,
-	&dev_attr_tlabels_allocations,
 	&dev_attr_tlabels_mask,
+#endif
 };
 
 
@@ -782,8 +793,6 @@ static struct node_entry *nodemgr_create
 	if (!ne)
 		return NULL;
 
-	ne->tpool = &host->tpool[nodeid & NODE_MASK];
-
 	ne->host = host;
 	ne->nodeid = nodeid;
 	ne->generation = generation;


