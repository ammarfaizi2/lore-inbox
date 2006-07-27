Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161006AbWG0AJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbWG0AJl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 20:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751831AbWG0AJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 20:09:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:64634 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751830AbWG0AJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 20:09:39 -0400
X-IronPort-AV: i="4.07,185,1151910000"; 
   d="scan'208"; a="105418357:sNHT323217720"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 1/4] dmaengine: enable mutliple clients and operations
Date: Wed, 26 Jul 2006 17:07:49 -0700
To: linux-kernel@vger.kernel.org
Cc: neilb@suse.de, galak@kernel.crashing.org, christopher.leech@intel.com,
       alan@lxorguk.ukuu.org.uk, dan.j.williams@intel.com
Message-Id: <20060727000749.9744.10081.stgit@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Enable the dmaengine interface to allow multiple clients to share a
channel, and enable clients to request channels based on an operations
capability mask.  This prepares the interface for use with the RAID5 client
and the future RAID6 client.

Multi-client support is achieved by modifying channels to maintain a list
of peer clients.

Multi-operation support is achieved by modifying clients to maintain lists
of channel references.  Channel references in a given request list satisfy
a client specified capability mask.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/dma/dmaengine.c   |  338 +++++++++++++++++++++++++++++++++++++--------
 drivers/dma/ioatdma.c     |   12 +-
 include/linux/dmaengine.h |  166 +++++++++++++++++++---
 net/core/dev.c            |   21 +--
 net/ipv4/tcp.c            |    4 -
 5 files changed, 436 insertions(+), 105 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 1527804..3a5d353 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -37,8 +37,13 @@
  * Each device has a channels list, which runs unlocked but is never modified
  * once the device is registered, it's just setup by the driver.
  *
- * Each client has a channels list, it's only modified under the client->lock
- * and in an RCU callback, so it's safe to read under rcu_read_lock().
+ * Each client has 'n' lists of channel references where
+ * n == DMA_MAX_CHAN_TYPE_REQ.  These lists are only modified under the
+ * client->lock and in an RCU callback, so they are safe to read under
+ * rcu_read_lock().
+ *
+ * Each channel has a list of peer clients, it's only modified under the
+ * chan->lock.  This allows a channel to be shared amongst several clients
  *
  * Each device has a kref, which is initialized to 1 when the device is
  * registered. A kref_put is done for each class_device registered.  When the
@@ -85,6 +90,18 @@ static ssize_t show_memcpy_count(struct 
 	return sprintf(buf, "%lu\n", count);
 }
 
+static ssize_t show_xor_count(struct class_device *cd, char *buf)
+{
+	struct dma_chan *chan = container_of(cd, struct dma_chan, class_dev);
+	unsigned long count = 0;
+	int i;
+
+	for_each_possible_cpu(i)
+		count += per_cpu_ptr(chan->local, i)->xor_count;
+
+	return sprintf(buf, "%lu\n", count);
+}
+
 static ssize_t show_bytes_transferred(struct class_device *cd, char *buf)
 {
 	struct dma_chan *chan = container_of(cd, struct dma_chan, class_dev);
@@ -97,16 +114,37 @@ static ssize_t show_bytes_transferred(st
 	return sprintf(buf, "%lu\n", count);
 }
 
+static ssize_t show_bytes_xor(struct class_device *cd, char *buf)
+{
+	struct dma_chan *chan = container_of(cd, struct dma_chan, class_dev);
+	unsigned long count = 0;
+	int i;
+
+	for_each_possible_cpu(i)
+		count += per_cpu_ptr(chan->local, i)->bytes_xor;
+
+	return sprintf(buf, "%lu\n", count);
+}
+
 static ssize_t show_in_use(struct class_device *cd, char *buf)
 {
+	unsigned int clients = 0;
+	struct list_head *peer;
 	struct dma_chan *chan = container_of(cd, struct dma_chan, class_dev);
 
-	return sprintf(buf, "%d\n", (chan->client ? 1 : 0));
+	rcu_read_lock();
+	list_for_each_rcu(peer, &chan->peers)
+		clients++;
+	rcu_read_unlock();
+
+	return sprintf(buf, "%d\n", clients);
 }
 
 static struct class_device_attribute dma_class_attrs[] = {
 	__ATTR(memcpy_count, S_IRUGO, show_memcpy_count, NULL),
+	__ATTR(xor_count, S_IRUGO, show_xor_count, NULL),
 	__ATTR(bytes_transferred, S_IRUGO, show_bytes_transferred, NULL),
+	__ATTR(bytes_xor, S_IRUGO, show_bytes_xor, NULL),
 	__ATTR(in_use, S_IRUGO, show_in_use, NULL),
 	__ATTR_NULL
 };
@@ -130,34 +168,79 @@ static struct class dma_devclass = {
 /**
  * dma_client_chan_alloc - try to allocate a channel to a client
  * @client: &dma_client
+ * @req: request descriptor
  *
  * Called with dma_list_mutex held.
  */
-static struct dma_chan *dma_client_chan_alloc(struct dma_client *client)
+static struct dma_chan *dma_client_chan_alloc(struct dma_client *client,
+	struct dma_req *req)
 {
 	struct dma_device *device;
 	struct dma_chan *chan;
+	struct dma_client_chan_peer *peer;
+	struct dma_chan_client_ref *chan_ref;
 	unsigned long flags;
 	int desc;	/* allocated descriptor count */
+	int allocated;	/* flag re-allocations */
 
-	/* Find a channel, any DMA engine will do */
+	/* Find a channel */
 	list_for_each_entry(device, &dma_device_list, global_node) {
+		if ((req->cap_mask & device->capabilities)
+			!= req->cap_mask)
+			continue;
 		list_for_each_entry(chan, &device->channels, device_node) {
-			if (chan->client)
+			allocated = 0;
+			rcu_read_lock();
+			list_for_each_entry_rcu(chan_ref, &req->channels, req_node) {
+				if (chan_ref->chan == chan) {
+					allocated = 1;
+					break;
+				}
+			}
+			rcu_read_unlock();
+
+			if (allocated)
 				continue;
 
+			/* can the channel be shared between multiple clients */
+			if ((req->exclusive && !list_empty(&chan->peers)) ||
+				chan->exclusive)
+				continue;
+
+			chan_ref = kmalloc(sizeof(*chan_ref), GFP_KERNEL);
+			if (!chan_ref)
+				continue;
+
+			peer = kmalloc(sizeof(*peer), GFP_KERNEL);
+			if (!peer) {
+				kfree(chan_ref);
+				continue;
+			}
+
 			desc = chan->device->device_alloc_chan_resources(chan);
-			if (desc >= 0) {
+			if (desc) {
 				kref_get(&device->refcount);
-				kref_init(&chan->refcount);
-				chan->slow_ref = 0;
-				INIT_RCU_HEAD(&chan->rcu);
-				chan->client = client;
+				kref_get(&chan->refcount);
+				INIT_RCU_HEAD(&peer->rcu);
+				INIT_RCU_HEAD(&chan_ref->rcu);
+				INIT_LIST_HEAD(&peer->peer_node);
+				INIT_LIST_HEAD(&chan_ref->req_node);
+				peer->client = client;
+				chan_ref->chan = chan;
+
+				spin_lock_irqsave(&chan->lock, flags);
+				list_add_tail_rcu(&peer->peer_node, &chan->peers);
+				spin_unlock_irqrestore(&chan->lock, flags);
+
 				spin_lock_irqsave(&client->lock, flags);
-				list_add_tail_rcu(&chan->client_node,
-				                  &client->channels);
+				chan->exclusive = req->exclusive ? client : NULL;
+				list_add_tail_rcu(&chan_ref->req_node,
+						&req->channels);
 				spin_unlock_irqrestore(&client->lock, flags);
 				return chan;
+			} else {
+				kfree(peer);
+				kfree(chan_ref);
 			}
 		}
 	}
@@ -173,7 +256,6 @@ void dma_chan_cleanup(struct kref *kref)
 {
 	struct dma_chan *chan = container_of(kref, struct dma_chan, refcount);
 	chan->device->device_free_chan_resources(chan);
-	chan->client = NULL;
 	kref_put(&chan->device->refcount, dma_async_device_cleanup);
 }
 
@@ -186,51 +268,93 @@ static void dma_chan_free_rcu(struct rcu
 		bias -= local_read(&per_cpu_ptr(chan->local, i)->refcount);
 	atomic_sub(bias, &chan->refcount.refcount);
 	kref_put(&chan->refcount, dma_chan_cleanup);
+	kref_put(&chan->device->refcount, dma_async_device_cleanup);
+}
+
+static void dma_peer_free_rcu(struct rcu_head *rcu)
+{
+	struct dma_client_chan_peer *peer =
+		container_of(rcu, struct dma_client_chan_peer, rcu);
+
+	kfree(peer);
+}
+
+static void dma_chan_ref_free_rcu(struct rcu_head *rcu)
+{
+	struct dma_chan_client_ref *chan_ref =
+		container_of(rcu, struct dma_chan_client_ref, rcu);
+
+	kfree(chan_ref);
 }
 
-static void dma_client_chan_free(struct dma_chan *chan)
+static void dma_client_chan_free(struct dma_client *client,
+				struct dma_chan_client_ref *chan_ref)
 {
+	struct dma_client_chan_peer *peer;
+	struct dma_chan *chan = chan_ref->chan;
 	atomic_add(0x7FFFFFFF, &chan->refcount.refcount);
 	chan->slow_ref = 1;
-	call_rcu(&chan->rcu, dma_chan_free_rcu);
+	rcu_read_lock();
+	list_for_each_entry_rcu(peer, &chan->peers, peer_node)
+		if (peer->client == client) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&chan->lock, flags);
+			list_del_rcu(&peer->peer_node);
+			if (list_empty(&chan->peers))
+				chan->exclusive = NULL;
+			spin_unlock_irqrestore(&chan->lock, flags);
+			call_rcu(&peer->rcu, dma_peer_free_rcu);
+			call_rcu(&chan_ref->rcu, dma_chan_ref_free_rcu);
+			call_rcu(&chan->rcu, dma_chan_free_rcu);
+			break;
+		}
+	rcu_read_unlock();
 }
 
 /**
  * dma_chans_rebalance - reallocate channels to clients
  *
- * When the number of DMA channel in the system changes,
- * channels need to be rebalanced among clients.
+ * When the number of DMA channels in the system changes,
+ * channels need to be rebalanced among clients
  */
 static void dma_chans_rebalance(void)
 {
 	struct dma_client *client;
 	struct dma_chan *chan;
+	struct dma_chan_client_ref *chan_ref;
+
 	unsigned long flags;
+	int i;
 
 	mutex_lock(&dma_list_mutex);
 
 	list_for_each_entry(client, &dma_client_list, global_node) {
-		while (client->chans_desired > client->chan_count) {
-			chan = dma_client_chan_alloc(client);
-			if (!chan)
-				break;
-			client->chan_count++;
-			client->event_callback(client,
-	                                       chan,
-	                                       DMA_RESOURCE_ADDED);
-		}
-		while (client->chans_desired < client->chan_count) {
-			spin_lock_irqsave(&client->lock, flags);
-			chan = list_entry(client->channels.next,
-			                  struct dma_chan,
-			                  client_node);
-			list_del_rcu(&chan->client_node);
-			spin_unlock_irqrestore(&client->lock, flags);
-			client->chan_count--;
-			client->event_callback(client,
-			                       chan,
-			                       DMA_RESOURCE_REMOVED);
-			dma_client_chan_free(chan);
+		for (i = 0; i < DMA_MAX_CHAN_TYPE_REQ; i++) {
+			struct dma_req *req = &client->req[i];
+			while (req->chans_desired > atomic_read(&req->chan_count)) {
+				chan = dma_client_chan_alloc(client, req);
+				if (!chan)
+					break;
+				atomic_inc(&req->chan_count);
+				client->event_callback(client,
+		                                       chan,
+		                                       DMA_RESOURCE_ADDED);
+			}
+			while (req->chans_desired < atomic_read(&req->chan_count)) {
+				spin_lock_irqsave(&client->lock, flags);
+				chan_ref = list_entry(req->channels.next,
+				                  struct dma_chan_client_ref,
+				                  req_node);
+				list_del_rcu(&chan_ref->req_node);
+				spin_unlock_irqrestore(&client->lock, flags);
+				atomic_dec(&req->chan_count);
+
+				client->event_callback(client,
+				                       chan_ref->chan,
+				                       DMA_RESOURCE_REMOVED);
+				dma_client_chan_free(client, chan_ref);
+			}
 		}
 	}
 
@@ -244,15 +368,18 @@ static void dma_chans_rebalance(void)
 struct dma_client *dma_async_client_register(dma_event_callback event_callback)
 {
 	struct dma_client *client;
+	int i;
 
 	client = kzalloc(sizeof(*client), GFP_KERNEL);
 	if (!client)
 		return NULL;
 
-	INIT_LIST_HEAD(&client->channels);
+	for (i = 0; i < DMA_MAX_CHAN_TYPE_REQ; i++) {
+		INIT_LIST_HEAD(&client->req[i].channels);
+		atomic_set(&client->req[i].chan_count, 0);
+	}
+
 	spin_lock_init(&client->lock);
-	client->chans_desired = 0;
-	client->chan_count = 0;
 	client->event_callback = event_callback;
 
 	mutex_lock(&dma_list_mutex);
@@ -270,14 +397,16 @@ struct dma_client *dma_async_client_regi
  */
 void dma_async_client_unregister(struct dma_client *client)
 {
-	struct dma_chan *chan;
+	struct dma_chan_client_ref *chan_ref;
+	int i;
 
 	if (!client)
 		return;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(chan, &client->channels, client_node)
-		dma_client_chan_free(chan);
+	for (i = 0; i < DMA_MAX_CHAN_TYPE_REQ; i++)
+		list_for_each_entry_rcu(chan_ref, &client->req[i].channels, req_node)
+			dma_client_chan_free(client, chan_ref);
 	rcu_read_unlock();
 
 	mutex_lock(&dma_list_mutex);
@@ -292,17 +421,46 @@ void dma_async_client_unregister(struct 
  * dma_async_client_chan_request - request DMA channels
  * @client: &dma_client
  * @number: count of DMA channels requested
+ * @mask: limits the DMA channels returned to those that
+ *	have the requisite capabilities
  *
  * Clients call dma_async_client_chan_request() to specify how many
  * DMA channels they need, 0 to free all currently allocated.
  * The resulting allocations/frees are indicated to the client via the
- * event callback.
+ * event callback.  If the client has exhausted the number of distinct
+ * requests allowed (DMA_MAX_CHAN_TYPE_REQ) this function will return 0.
  */
-void dma_async_client_chan_request(struct dma_client *client,
-			unsigned int number)
+int dma_async_client_chan_request(struct dma_client *client,
+			unsigned int number, unsigned int mask)
 {
-	client->chans_desired = number;
-	dma_chans_rebalance();
+	int request_slot_found = 0, i;
+
+	/* adjust an outstanding request */
+	for (i = 0; i < DMA_MAX_CHAN_TYPE_REQ; i++) {
+		struct dma_req *req = &client->req[i];
+		if (req->cap_mask == mask) {
+			req->chans_desired = number;
+			request_slot_found = 1;
+			break;
+		}
+	}
+
+	/* start a new request */
+	if (!request_slot_found)
+		for (i = 0; i < DMA_MAX_CHAN_TYPE_REQ; i++) {
+			struct dma_req *req = &client->req[i];
+			if (!req->chans_desired) {
+				req->chans_desired = number;
+				req->cap_mask = mask;
+				request_slot_found = 1;
+				break;
+			}
+		}
+
+	if (request_slot_found)
+		dma_chans_rebalance();
+
+	return request_slot_found;
 }
 
 /**
@@ -335,6 +493,7 @@ int dma_async_device_register(struct dma
 		         device->dev_id, chan->chan_id);
 
 		kref_get(&device->refcount);
+		kref_init(&chan->refcount);
 		class_device_register(&chan->class_dev);
 	}
 
@@ -348,6 +507,20 @@ int dma_async_device_register(struct dma
 }
 
 /**
+ * dma_async_chan_init - common channel initialization
+ * @chan: &dma_chan
+ * @device: &dma_device
+ */
+void dma_async_chan_init(struct dma_chan *chan, struct dma_device *device)
+{
+	INIT_LIST_HEAD(&chan->peers);
+	INIT_RCU_HEAD(&chan->rcu);
+	spin_lock_init(&chan->lock);
+	chan->device = device;
+	list_add_tail(&chan->device_node, &device->channels);
+}
+
+/**
  * dma_async_device_cleanup - function called when all references are released
  * @kref: kernel reference object
  */
@@ -366,31 +539,70 @@ static void dma_async_device_cleanup(str
 void dma_async_device_unregister(struct dma_device *device)
 {
 	struct dma_chan *chan;
+	struct dma_client_chan_peer *peer;
+	struct dma_req *req;
+	struct dma_chan_client_ref *chan_ref;
+	struct dma_client *client;
+	int i;
 	unsigned long flags;
 
 	mutex_lock(&dma_list_mutex);
 	list_del(&device->global_node);
 	mutex_unlock(&dma_list_mutex);
 
+	/* look up and free each reference to a channel
+	 * note: a channel can be allocated to a client once per
+	 * request type (DMA_MAX_CHAN_TYPE_REQ)
+	 */
 	list_for_each_entry(chan, &device->channels, device_node) {
-		if (chan->client) {
-			spin_lock_irqsave(&chan->client->lock, flags);
-			list_del(&chan->client_node);
-			chan->client->chan_count--;
-			spin_unlock_irqrestore(&chan->client->lock, flags);
-			chan->client->event_callback(chan->client,
-			                             chan,
-			                             DMA_RESOURCE_REMOVED);
-			dma_client_chan_free(chan);
+		rcu_read_lock();
+		list_for_each_entry_rcu(peer, &chan->peers, peer_node) {
+			client = peer->client;
+			for (i = 0; i < DMA_MAX_CHAN_TYPE_REQ; i++) {
+				req = &client->req[i];
+				list_for_each_entry_rcu(chan_ref,
+							&req->channels,
+							req_node) {
+					if (chan_ref->chan == chan) {
+						spin_lock_irqsave(&client->lock, flags);
+						list_del_rcu(&chan_ref->req_node);
+						spin_unlock_irqrestore(&client->lock, flags);
+						atomic_dec(&req->chan_count);
+						client->event_callback(
+						client,
+						chan,
+						DMA_RESOURCE_REMOVED);
+						dma_client_chan_free(client,
+								     chan_ref);
+						break;
+					}
+				}
+			}
 		}
-		class_device_unregister(&chan->class_dev);
+		rcu_read_unlock();
+		kref_put(&chan->refcount, dma_chan_cleanup);
+		kref_put(&device->refcount, dma_async_device_cleanup);
 	}
+
+	class_device_unregister(&chan->class_dev);
+
 	dma_chans_rebalance();
 
 	kref_put(&device->refcount, dma_async_device_cleanup);
 	wait_for_completion(&device->done);
 }
 
+/**
+ * dma_async_xor_pgs_to_pg_err - default function for dma devices that
+ *	do not support xor
+ */
+dma_cookie_t dma_async_xor_pgs_to_pg_err(struct dma_chan *chan,
+	struct page *dest_pg, unsigned int dest_off, struct page *src_pgs,
+	unsigned int src_cnt, unsigned int src_off, size_t len, u32 *result)
+{
+	return -ENXIO;
+}
+
 static int __init dma_bus_init(void)
 {
 	mutex_init(&dma_list_mutex);
@@ -405,8 +617,10 @@ EXPORT_SYMBOL(dma_async_client_chan_requ
 EXPORT_SYMBOL(dma_async_memcpy_buf_to_buf);
 EXPORT_SYMBOL(dma_async_memcpy_buf_to_pg);
 EXPORT_SYMBOL(dma_async_memcpy_pg_to_pg);
-EXPORT_SYMBOL(dma_async_memcpy_complete);
-EXPORT_SYMBOL(dma_async_memcpy_issue_pending);
+EXPORT_SYMBOL(dma_async_operation_complete);
+EXPORT_SYMBOL(dma_async_issue_pending);
 EXPORT_SYMBOL(dma_async_device_register);
 EXPORT_SYMBOL(dma_async_device_unregister);
 EXPORT_SYMBOL(dma_chan_cleanup);
+EXPORT_SYMBOL(dma_async_xor_pgs_to_pg_err);
+EXPORT_SYMBOL(dma_async_chan_init);
diff --git a/drivers/dma/ioatdma.c b/drivers/dma/ioatdma.c
index dbd4d6c..415de03 100644
--- a/drivers/dma/ioatdma.c
+++ b/drivers/dma/ioatdma.c
@@ -69,11 +69,7 @@ static int enumerate_dma_channels(struct
 		spin_lock_init(&ioat_chan->desc_lock);
 		INIT_LIST_HEAD(&ioat_chan->free_desc);
 		INIT_LIST_HEAD(&ioat_chan->used_desc);
-		/* This should be made common somewhere in dmaengine.c */
-		ioat_chan->common.device = &device->common;
-		ioat_chan->common.client = NULL;
-		list_add_tail(&ioat_chan->common.device_node,
-		              &device->common.channels);
+		dma_async_chan_init(&ioat_chan->common, &device->common);
 	}
 	return device->common.chancnt;
 }
@@ -759,8 +755,10 @@ #endif
 	device->common.device_memcpy_buf_to_buf = ioat_dma_memcpy_buf_to_buf;
 	device->common.device_memcpy_buf_to_pg = ioat_dma_memcpy_buf_to_pg;
 	device->common.device_memcpy_pg_to_pg = ioat_dma_memcpy_pg_to_pg;
-	device->common.device_memcpy_complete = ioat_dma_is_complete;
-	device->common.device_memcpy_issue_pending = ioat_dma_memcpy_issue_pending;
+	device->common.device_operation_complete = ioat_dma_is_complete;
+	device->common.device_xor_pgs_to_pg = dma_async_xor_pgs_to_pg_err;
+	device->common.device_issue_pending = ioat_dma_memcpy_issue_pending;
+	device->common.capabilities = DMA_MEMCPY;
 	printk(KERN_INFO "Intel(R) I/OAT DMA Engine found, %d channels\n",
 		device->common.chancnt);
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c94d8f1..dad909a 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -20,7 +20,7 @@
  */
 #ifndef DMAENGINE_H
 #define DMAENGINE_H
-
+#include <linux/config.h>
 #ifdef CONFIG_DMA_ENGINE
 
 #include <linux/device.h>
@@ -65,6 +65,27 @@ enum dma_status {
 };
 
 /**
+ * enum dma_capabilities - DMA operational capabilities
+ * @DMA_MEMCPY: src to dest copy
+ * @DMA_XOR: src*n to dest xor
+ * @DMA_DUAL_XOR: src*n to dest_diag and dest_horiz xor
+ * @DMA_PQ_XOR: src*n to dest_q and dest_p gf/xor
+ * @DMA_MEMCPY_CRC32C: src to dest copy and crc-32c sum
+ * @DMA_SHARE: multiple clients can use this channel
+ */
+enum dma_capabilities {
+	DMA_MEMCPY		= 0x1,
+	DMA_XOR			= 0x2,
+	DMA_PQ_XOR		= 0x4,
+	DMA_DUAL_XOR		= 0x8,
+	DMA_PQ_UPDATE		= 0x10,
+	DMA_XOR_CHECK		= 0x20,
+	DMA_PQ_XOR_CHECK	= 0x40,
+	DMA_MEMSET		= 0x80,
+	DMA_MEMCPY_CRC32C	= 0x100,
+};
+
+/**
  * struct dma_chan_percpu - the per-CPU part of struct dma_chan
  * @refcount: local_t used for open-coded "bigref" counting
  * @memcpy_count: transaction counter
@@ -75,27 +96,32 @@ struct dma_chan_percpu {
 	local_t refcount;
 	/* stats */
 	unsigned long memcpy_count;
+	unsigned long xor_count;
 	unsigned long bytes_transferred;
+	unsigned long bytes_xor;
 };
 
 /**
  * struct dma_chan - devices supply DMA channels, clients use them
- * @client: ptr to the client user of this chan, will be %NULL when unused
+ * @peers: list of the clients of this chan, will be 'empty' when unused
  * @device: ptr to the dma device who supplies this channel, always !%NULL
  * @cookie: last cookie value returned to client
+ * @exclusive: ptr to the client that is exclusively using this channel
+ * @lock: protects access to the peer list
  * @chan_id: channel ID for sysfs
  * @class_dev: class device for sysfs
  * @refcount: kref, used in "bigref" slow-mode
  * @slow_ref: indicates that the DMA channel is free
  * @rcu: the DMA channel's RCU head
- * @client_node: used to add this to the client chan list
  * @device_node: used to add this to the device chan list
  * @local: per-cpu pointer to a struct dma_chan_percpu
  */
 struct dma_chan {
-	struct dma_client *client;
+	struct list_head peers;
 	struct dma_device *device;
 	dma_cookie_t cookie;
+	struct dma_client *exclusive;
+	spinlock_t lock;
 
 	/* sysfs */
 	int chan_id;
@@ -105,7 +131,6 @@ struct dma_chan {
 	int slow_ref;
 	struct rcu_head rcu;
 
-	struct list_head client_node;
 	struct list_head device_node;
 	struct dma_chan_percpu *local;
 };
@@ -139,29 +164,66 @@ typedef void (*dma_event_callback) (stru
 		struct dma_chan *chan, enum dma_event event);
 
 /**
- * struct dma_client - info on the entity making use of DMA services
- * @event_callback: func ptr to call when something happens
+ * struct dma_req - info on the type and number of channels allocated to a client
  * @chan_count: number of chans allocated
  * @chans_desired: number of chans requested. Can be +/- chan_count
+ * @cap_mask: DMA capabilities required to satisfy this request
+ * @exclusive: Whether this client would like exclusive use of the channel(s)
+ */
+struct dma_req {
+	atomic_t	chan_count;
+	unsigned int	chans_desired;
+	unsigned int	cap_mask;
+	int		exclusive;
+	struct list_head channels;
+};
+
+/**
+ * struct dma_client - info on the entity making use of DMA services
+ * @event_callback: func ptr to call when something happens
+ * @dma_req: tracks client channel requests per capability mask
  * @lock: protects access to the channels list
  * @channels: the list of DMA channels allocated
  * @global_node: list_head for global dma_client_list
  */
+#define DMA_MAX_CHAN_TYPE_REQ 2
 struct dma_client {
 	dma_event_callback	event_callback;
-	unsigned int		chan_count;
-	unsigned int		chans_desired;
-
+	struct dma_req		req[DMA_MAX_CHAN_TYPE_REQ];
 	spinlock_t		lock;
-	struct list_head	channels;
 	struct list_head	global_node;
 };
 
 /**
+ * struct dma_client_chan_peer - info on the entities sharing a DMA channel
+ * @client: &dma_client
+ * @peer_node: node list of other clients on the channel
+ * @rcu: rcu head for the peer object
+ */
+struct dma_client_chan_peer {
+	struct dma_client *client;
+	struct list_head peer_node;
+	struct rcu_head rcu;
+};
+
+/**
+ * struct dma_chan_client_ref - reference object for clients to track channels
+ * @chan: channel reference
+ * @chan_node: node in the list of other channels on the client
+ * @rcu: rcu head for the chan_ref object
+ */
+struct dma_chan_client_ref {
+	struct dma_chan *chan;
+	struct list_head req_node;
+	struct rcu_head rcu;
+};
+
+/**
  * struct dma_device - info on the entity supplying DMA services
  * @chancnt: how many DMA channels are supported
  * @channels: the list of struct dma_chan
  * @global_node: list_head for global dma_device_list
+ * @capabilities: channel operations capabilities
  * @refcount: reference count
  * @done: IO completion struct
  * @dev_id: unique device ID
@@ -179,6 +241,7 @@ struct dma_device {
 	unsigned int chancnt;
 	struct list_head channels;
 	struct list_head global_node;
+	unsigned long capabilities;
 
 	struct kref refcount;
 	struct completion done;
@@ -195,18 +258,27 @@ struct dma_device {
 	dma_cookie_t (*device_memcpy_pg_to_pg)(struct dma_chan *chan,
 			struct page *dest_pg, unsigned int dest_off,
 			struct page *src_pg, unsigned int src_off, size_t len);
-	enum dma_status (*device_memcpy_complete)(struct dma_chan *chan,
+	dma_cookie_t (*device_xor_pgs_to_pg)(struct dma_chan *chan,
+			struct page *dest_pg, unsigned int dest_off,
+			struct page **src_pgs, unsigned int src_cnt,
+			unsigned int src_off, size_t len, u32 *result);
+	enum dma_status (*device_operation_complete)(struct dma_chan *chan,
 			dma_cookie_t cookie, dma_cookie_t *last,
 			dma_cookie_t *used);
-	void (*device_memcpy_issue_pending)(struct dma_chan *chan);
+	void (*device_issue_pending)(struct dma_chan *chan);
 };
 
 /* --- public DMA engine API --- */
 
 struct dma_client *dma_async_client_register(dma_event_callback event_callback);
 void dma_async_client_unregister(struct dma_client *client);
-void dma_async_client_chan_request(struct dma_client *client,
-		unsigned int number);
+int dma_async_client_chan_request(struct dma_client *client,
+		unsigned int number, unsigned int mask);
+void dma_async_chan_init(struct dma_chan *chan, struct dma_device *device);
+dma_cookie_t dma_async_xor_pgs_to_pg_err(struct dma_chan *chan,
+	struct page *dest_pg, unsigned int dest_off, struct page *src_pgs,
+	unsigned int src_cnt, unsigned int src_off, size_t len, u32 *result);
+
 
 /**
  * dma_async_memcpy_buf_to_buf - offloaded copy between virtual addresses
@@ -284,19 +356,67 @@ static inline dma_cookie_t dma_async_mem
 }
 
 /**
- * dma_async_memcpy_issue_pending - flush pending copies to HW
+ * dma_async_xor_pgs_to_pg - offloaded xor from pages to page
+ * @chan: DMA channel to offload xor to
+ * @dest_page: destination page
+ * @dest_off: offset in page to xor to
+ * @src_pgs: array of source pages
+ * @src_cnt: number of source pages
+ * @src_off: offset in pages to xor from
+ * @len: length
+ * @result: optionally returns whether the xor resulted in a zero sum
+ *
+ * Both @dest_page/@dest_off and @src_page/@src_off must be mappable to a bus
+ * address according to the DMA mapping API rules for streaming mappings.
+ * Both @dest_page/@dest_off and @src_page/@src_off must stay memory resident
+ * (kernel memory or locked user space pages)
+ */
+static inline dma_cookie_t dma_async_xor_pgs_to_pg(struct dma_chan *chan,
+	struct page *dest_pg, unsigned int dest_off, struct page **src_pgs,
+	unsigned int src_cnt, unsigned int src_off, size_t len, u32 *result)
+{
+	int cpu = get_cpu();
+	per_cpu_ptr(chan->local, cpu)->bytes_xor += len * src_cnt;
+	per_cpu_ptr(chan->local, cpu)->xor_count++;
+	put_cpu();
+
+	return chan->device->device_xor_pgs_to_pg(chan, dest_pg, dest_off,
+		src_pgs, src_cnt, src_off, len, result);
+}
+
+
+/**
+ * dma_async_issue_pending - flush pending copies to HW
  * @chan: target DMA channel
  *
- * This allows drivers to push copies to HW in batches,
+ * This allows drivers to push operations to HW in batches,
  * reducing MMIO writes where possible.
  */
-static inline void dma_async_memcpy_issue_pending(struct dma_chan *chan)
+static inline void dma_async_issue_pending(struct dma_chan *chan)
 {
-	return chan->device->device_memcpy_issue_pending(chan);
+	return chan->device->device_issue_pending(chan);
+}
+
+/**
+ * dma_async_issue_all - call dma_async_issue_pending on all channels
+ * @client: &dma_client
+ */
+static inline void dma_async_issue_all(struct dma_client *client)
+{
+	int i;
+	struct dma_chan_client_ref *chan_ref;
+	struct dma_req *req;
+	for (i = 0; i < DMA_MAX_CHAN_TYPE_REQ; i++) {
+		req = &client->req[i];
+		rcu_read_lock();
+		list_for_each_entry_rcu(chan_ref, &req->channels, req_node)
+			dma_async_issue_pending(chan_ref->chan);
+		rcu_read_unlock();
+	}
 }
 
 /**
- * dma_async_memcpy_complete - poll for transaction completion
+ * dma_async_operations_complete - poll for transaction completion
  * @chan: DMA channel
  * @cookie: transaction identifier to check status of
  * @last: returns last completed cookie, can be NULL
@@ -306,10 +426,10 @@ static inline void dma_async_memcpy_issu
  * internal state and can be used with dma_async_is_complete() to check
  * the status of multiple cookies without re-checking hardware state.
  */
-static inline enum dma_status dma_async_memcpy_complete(struct dma_chan *chan,
+static inline enum dma_status dma_async_operation_complete(struct dma_chan *chan,
 	dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used)
 {
-	return chan->device->device_memcpy_complete(chan, cookie, last, used);
+	return chan->device->device_operation_complete(chan, cookie, last, used);
 }
 
 /**
@@ -318,7 +438,7 @@ static inline enum dma_status dma_async_
  * @last_complete: last know completed transaction
  * @last_used: last cookie value handed out
  *
- * dma_async_is_complete() is used in dma_async_memcpy_complete()
+ * dma_async_is_complete() is used in dma_async_operation_complete()
  * the test logic is seperated for lightweight testing of multiple cookies
  */
 static inline enum dma_status dma_async_is_complete(dma_cookie_t cookie,
diff --git a/net/core/dev.c b/net/core/dev.c
index 4d2b516..a72c088 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1958,13 +1958,8 @@ #ifdef CONFIG_NET_DMA
 	 * There may not be any more sk_buffs coming right now, so push
 	 * any pending DMA copies to hardware
 	 */
-	if (net_dma_client) {
-		struct dma_chan *chan;
-		rcu_read_lock();
-		list_for_each_entry_rcu(chan, &net_dma_client->channels, client_node)
-			dma_async_memcpy_issue_pending(chan);
-		rcu_read_unlock();
-	}
+	if (net_dma_client)
+		dma_async_issue_all(net_dma_client);
 #endif
 	local_irq_enable();
 	return;
@@ -3427,7 +3422,8 @@ #ifdef CONFIG_NET_DMA
 static void net_dma_rebalance(void)
 {
 	unsigned int cpu, i, n;
-	struct dma_chan *chan;
+	struct dma_chan_client_ref *chan_ref;
+	struct dma_req *req;
 
 	lock_cpu_hotplug();
 
@@ -3441,13 +3437,16 @@ static void net_dma_rebalance(void)
 	i = 0;
 	cpu = first_cpu(cpu_online_map);
 
+	/* NET_DMA only requests one type of dma channel (memcpy) */
+	req = &net_dma_client->req[0];
+
 	rcu_read_lock();
-	list_for_each_entry(chan, &net_dma_client->channels, client_node) {
+	list_for_each_entry(chan_ref, &req->channels, req_node) {
 		n = ((num_online_cpus() / net_dma_count)
 		   + (i < (num_online_cpus() % net_dma_count) ? 1 : 0));
 
 		while(n) {
-			per_cpu(softnet_data.net_dma, cpu) = chan;
+			per_cpu(softnet_data.net_dma, cpu) = chan_ref->chan;
 			cpu = next_cpu(cpu, cpu_online_map);
 			n--;
 		}
@@ -3493,7 +3492,7 @@ static int __init netdev_dma_register(vo
 	if (net_dma_client == NULL)
 		return -ENOMEM;
 
-	dma_async_client_chan_request(net_dma_client, num_online_cpus());
+	dma_async_client_chan_request(net_dma_client, num_online_cpus(), DMA_MEMCPY);
 	return 0;
 }
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f6a2d92..51c5410 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1431,9 +1431,9 @@ #ifdef CONFIG_NET_DMA
 		struct sk_buff *skb;
 		dma_cookie_t done, used;
 
-		dma_async_memcpy_issue_pending(tp->ucopy.dma_chan);
+		dma_async_issue_pending(tp->ucopy.dma_chan);
 
-		while (dma_async_memcpy_complete(tp->ucopy.dma_chan,
+		while (dma_async_operation_complete(tp->ucopy.dma_chan,
 		                                 tp->ucopy.dma_cookie, &done,
 		                                 &used) == DMA_IN_PROGRESS) {
 			/* do partial cleanup of sk_async_wait_queue */
