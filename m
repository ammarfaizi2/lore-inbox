Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751585AbWIOTqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585AbWIOTqL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 15:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWIOTqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 15:46:11 -0400
Received: from lixom.net ([66.141.50.11]:64938 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1751531AbWIOTqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 15:46:05 -0400
Date: Fri, 15 Sep 2006 14:44:23 -0500
From: Olof Johansson <olof@lixom.net>
To: Dan Williams <dan.j.williams@intel.com>, christopher.leech@intel.com
Cc: Jeff Garzik <jeff@garzik.org>, neilb@suse.de, linux-raid@vger.kernel.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: clean up and abstract function types (was Re:
 [PATCH 08/19] dmaengine: enable multiple clients and operations)
Message-ID: <20060915144423.500b529d@localhost.localdomain>
In-Reply-To: <20060915113817.6154aa67@localhost.localdomain>
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
	<20060911231817.4737.49381.stgit@dwillia2-linux.ch.intel.com>
	<4505F4D0.7010901@garzik.org>
	<20060915113817.6154aa67@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.1.1 (GTK+ 2.8.17; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006 11:38:17 -0500 Olof Johansson <olof@lixom.net> wrote:

> On Mon, 11 Sep 2006 19:44:16 -0400 Jeff Garzik <jeff@garzik.org> wrote:

> > Are we really going to add a set of hooks for each DMA engine whizbang 
> > feature?
> > 
> > That will get ugly when DMA engines support memcpy, xor, crc32, sha1, 
> > aes, and a dozen other transforms.
> 
> 
> Yes, it will be unmaintainable. We need some sort of multiplexing with
> per-function registrations.
> 
> Here's a first cut at it, just very quick. It could be improved further
> but it shows that we could exorcise most of the hardcoded things pretty
> easily.

Ok, that was obviously a naive and not so nice first attempt, but I
figured it was worth it to show how it can be done.

This is a little more proper: Specify at client registration time what
the function the client will use is, and make the channel use it. This
way most of the error checking per call can be removed too.

Chris/Dan: Please consider picking this up as a base for the added
functionality and cleanups.





Clean up dmaengine a bit. Make the client registration specify which
channel functions ("type") the client will use. Also, make devices
register which functions they will provide.

Also exorcise most of the memcpy-specific references from the generic
dma engine code. There's still some left in the iov stuff.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: linux-2.6/drivers/dma/dmaengine.c
===================================================================
--- linux-2.6.orig/drivers/dma/dmaengine.c
+++ linux-2.6/drivers/dma/dmaengine.c
@@ -73,14 +73,14 @@ static LIST_HEAD(dma_client_list);
 
 /* --- sysfs implementation --- */
 
-static ssize_t show_memcpy_count(struct class_device *cd, char *buf)
+static ssize_t show_count(struct class_device *cd, char *buf)
 {
 	struct dma_chan *chan = container_of(cd, struct dma_chan, class_dev);
 	unsigned long count = 0;
 	int i;
 
 	for_each_possible_cpu(i)
-		count += per_cpu_ptr(chan->local, i)->memcpy_count;
+		count += per_cpu_ptr(chan->local, i)->count;
 
 	return sprintf(buf, "%lu\n", count);
 }
@@ -105,7 +105,7 @@ static ssize_t show_in_use(struct class_
 }
 
 static struct class_device_attribute dma_class_attrs[] = {
-	__ATTR(memcpy_count, S_IRUGO, show_memcpy_count, NULL),
+	__ATTR(count, S_IRUGO, show_count, NULL),
 	__ATTR(bytes_transferred, S_IRUGO, show_bytes_transferred, NULL),
 	__ATTR(in_use, S_IRUGO, show_in_use, NULL),
 	__ATTR_NULL
@@ -142,6 +142,10 @@ static struct dma_chan *dma_client_chan_
 
 	/* Find a channel, any DMA engine will do */
 	list_for_each_entry(device, &dma_device_list, global_node) {
+		/* Skip devices that don't provide the right function */
+		if (!device->funcs[client->type])
+			continue;
+
 		list_for_each_entry(chan, &device->channels, device_node) {
 			if (chan->client)
 				continue;
@@ -241,7 +245,8 @@ static void dma_chans_rebalance(void)
  * dma_async_client_register - allocate and register a &dma_client
  * @event_callback: callback for notification of channel addition/removal
  */
-struct dma_client *dma_async_client_register(dma_event_callback event_callback)
+struct dma_client *dma_async_client_register(enum dma_function_type type,
+		dma_event_callback event_callback)
 {
 	struct dma_client *client;
 
@@ -254,6 +259,7 @@ struct dma_client *dma_async_client_regi
 	client->chans_desired = 0;
 	client->chan_count = 0;
 	client->event_callback = event_callback;
+	client->type = type;
 
 	mutex_lock(&dma_list_mutex);
 	list_add_tail(&client->global_node, &dma_client_list);
@@ -402,11 +408,11 @@ subsys_initcall(dma_bus_init);
 EXPORT_SYMBOL(dma_async_client_register);
 EXPORT_SYMBOL(dma_async_client_unregister);
 EXPORT_SYMBOL(dma_async_client_chan_request);
-EXPORT_SYMBOL(dma_async_memcpy_buf_to_buf);
-EXPORT_SYMBOL(dma_async_memcpy_buf_to_pg);
-EXPORT_SYMBOL(dma_async_memcpy_pg_to_pg);
-EXPORT_SYMBOL(dma_async_memcpy_complete);
-EXPORT_SYMBOL(dma_async_memcpy_issue_pending);
+EXPORT_SYMBOL(dma_async_buf_to_buf);
+EXPORT_SYMBOL(dma_async_buf_to_pg);
+EXPORT_SYMBOL(dma_async_pg_to_pg);
+EXPORT_SYMBOL(dma_async_complete);
+EXPORT_SYMBOL(dma_async_issue_pending);
 EXPORT_SYMBOL(dma_async_device_register);
 EXPORT_SYMBOL(dma_async_device_unregister);
 EXPORT_SYMBOL(dma_chan_cleanup);
Index: linux-2.6/drivers/dma/ioatdma.c
===================================================================
--- linux-2.6.orig/drivers/dma/ioatdma.c
+++ linux-2.6/drivers/dma/ioatdma.c
@@ -681,6 +682,14 @@ out:
 	return err;
 }
 
+struct dma_function ioat_memcpy_functions = {
+	.buf_to_buf = ioat_dma_memcpy_buf_to_buf,
+	.buf_to_pg = ioat_dma_memcpy_buf_to_pg,
+	.pg_to_pg = ioat_dma_memcpy_pg_to_pg,
+	.complete = ioat_dma_is_complete,
+	.issue_pending = ioat_dma_memcpy_issue_pending,
+};
+
 static int __devinit ioat_probe(struct pci_dev *pdev,
                                 const struct pci_device_id *ent)
 {
@@ -756,11 +765,8 @@ static int __devinit ioat_probe(struct p
 
 	device->common.device_alloc_chan_resources = ioat_dma_alloc_chan_resources;
 	device->common.device_free_chan_resources = ioat_dma_free_chan_resources;
-	device->common.device_memcpy_buf_to_buf = ioat_dma_memcpy_buf_to_buf;
-	device->common.device_memcpy_buf_to_pg = ioat_dma_memcpy_buf_to_pg;
-	device->common.device_memcpy_pg_to_pg = ioat_dma_memcpy_pg_to_pg;
-	device->common.device_memcpy_complete = ioat_dma_is_complete;
-	device->common.device_memcpy_issue_pending = ioat_dma_memcpy_issue_pending;
+	device->common.funcs[DMAFUNC_MEMCPY] = &ioat_memcpy_functions;
+
 	printk(KERN_INFO "Intel(R) I/OAT DMA Engine found, %d channels\n",
 		device->common.chancnt);
 
Index: linux-2.6/include/linux/dmaengine.h
===================================================================
--- linux-2.6.orig/include/linux/dmaengine.h
+++ linux-2.6/include/linux/dmaengine.h
@@ -67,14 +67,14 @@ enum dma_status {
 /**
  * struct dma_chan_percpu - the per-CPU part of struct dma_chan
  * @refcount: local_t used for open-coded "bigref" counting
- * @memcpy_count: transaction counter
+ * @count: transaction counter
  * @bytes_transferred: byte counter
  */
 
 struct dma_chan_percpu {
 	local_t refcount;
 	/* stats */
-	unsigned long memcpy_count;
+	unsigned long count;
 	unsigned long bytes_transferred;
 };
 
@@ -138,6 +138,15 @@ static inline void dma_chan_put(struct d
 typedef void (*dma_event_callback) (struct dma_client *client,
 		struct dma_chan *chan, enum dma_event event);
 
+/*
+ * dma_function_type - one entry for every possible function type provided
+ */
+enum dma_function_type {
+	DMAFUNC_MEMCPY = 0,
+	DMAFUNC_XOR,
+	DMAFUNC_MAX
+};
+
 /**
  * struct dma_client - info on the entity making use of DMA services
  * @event_callback: func ptr to call when something happens
@@ -152,11 +161,35 @@ struct dma_client {
 	unsigned int		chan_count;
 	unsigned int		chans_desired;
 
+	enum dma_function_type	type;
+
 	spinlock_t		lock;
 	struct list_head	channels;
 	struct list_head	global_node;
 };
 
+/* struct dma_function
+ * @buf_to_pg: buf pointer to struct page
+ * @pg_to_pg: struct page/offset to struct page/offset
+ * @complete: poll the status of a DMA transaction
+ * @issue_pending: push appended descriptors to hardware
+ */
+struct dma_function {
+	dma_cookie_t (*buf_to_buf)(struct dma_chan *chan,
+				void *dest, void *src, size_t len);
+	dma_cookie_t (*buf_to_pg)(struct dma_chan *chan,
+				struct page *page, unsigned int offset,
+				void *kdata, size_t len);
+	dma_cookie_t (*pg_to_pg)(struct dma_chan *chan,
+				struct page *dest_pg, unsigned int dest_off,
+				struct page *src_pg, unsigned int src_off,
+				size_t len);
+	enum dma_status (*complete)(struct dma_chan *chan,
+				dma_cookie_t cookie, dma_cookie_t *last,
+				dma_cookie_t *used);
+	void (*issue_pending)(struct dma_chan *chan);
+};
+
 /**
  * struct dma_device - info on the entity supplying DMA services
  * @chancnt: how many DMA channels are supported
@@ -168,14 +201,8 @@ struct dma_client {
  * @device_alloc_chan_resources: allocate resources and return the
  *	number of allocated descriptors
  * @device_free_chan_resources: release DMA channel's resources
- * @device_memcpy_buf_to_buf: memcpy buf pointer to buf pointer
- * @device_memcpy_buf_to_pg: memcpy buf pointer to struct page
- * @device_memcpy_pg_to_pg: memcpy struct page/offset to struct page/offset
- * @device_memcpy_complete: poll the status of an IOAT DMA transaction
- * @device_memcpy_issue_pending: push appended descriptors to hardware
  */
 struct dma_device {
-
 	unsigned int chancnt;
 	struct list_head channels;
 	struct list_head global_node;
@@ -185,31 +212,24 @@ struct dma_device {
 
 	int dev_id;
 
+	struct dma_function *funcs[DMAFUNC_MAX];
+
 	int (*device_alloc_chan_resources)(struct dma_chan *chan);
 	void (*device_free_chan_resources)(struct dma_chan *chan);
-	dma_cookie_t (*device_memcpy_buf_to_buf)(struct dma_chan *chan,
-			void *dest, void *src, size_t len);
-	dma_cookie_t (*device_memcpy_buf_to_pg)(struct dma_chan *chan,
-			struct page *page, unsigned int offset, void *kdata,
-			size_t len);
-	dma_cookie_t (*device_memcpy_pg_to_pg)(struct dma_chan *chan,
-			struct page *dest_pg, unsigned int dest_off,
-			struct page *src_pg, unsigned int src_off, size_t len);
-	enum dma_status (*device_memcpy_complete)(struct dma_chan *chan,
-			dma_cookie_t cookie, dma_cookie_t *last,
-			dma_cookie_t *used);
-	void (*device_memcpy_issue_pending)(struct dma_chan *chan);
 };
 
+#define CHAN2FUNCS(chan) (chan->device->funcs[chan->client->type])
+
 /* --- public DMA engine API --- */
 
-struct dma_client *dma_async_client_register(dma_event_callback event_callback);
+struct dma_client *dma_async_client_register(enum dma_function_type type,
+		dma_event_callback event_callback);
 void dma_async_client_unregister(struct dma_client *client);
 void dma_async_client_chan_request(struct dma_client *client,
 		unsigned int number);
 
 /**
- * dma_async_memcpy_buf_to_buf - offloaded copy between virtual addresses
+ * dma_async_buf_to_buf - offloaded copy between virtual addresses
  * @chan: DMA channel to offload copy to
  * @dest: destination address (virtual)
  * @src: source address (virtual)
@@ -220,19 +240,19 @@ void dma_async_client_chan_request(struc
  * Both @dest and @src must stay memory resident (kernel memory or locked
  * user space pages).
  */
-static inline dma_cookie_t dma_async_memcpy_buf_to_buf(struct dma_chan *chan,
-	void *dest, void *src, size_t len)
+static inline dma_cookie_t dma_async_buf_to_buf(struct dma_chan *chan,
+		void *dest, void *src, size_t len)
 {
 	int cpu = get_cpu();
 	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
-	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
+	per_cpu_ptr(chan->local, cpu)->count++;
 	put_cpu();
 
-	return chan->device->device_memcpy_buf_to_buf(chan, dest, src, len);
+	return CHAN2FUNCS(chan)->buf_to_buf(chan, dest, src, len);
 }
 
 /**
- * dma_async_memcpy_buf_to_pg - offloaded copy from address to page
+ * dma_async_buf_to_pg - offloaded copy from address to page
  * @chan: DMA channel to offload copy to
  * @page: destination page
  * @offset: offset in page to copy to
@@ -244,20 +264,21 @@ static inline dma_cookie_t dma_async_mem
  * Both @page/@offset and @kdata must stay memory resident (kernel memory or
  * locked user space pages)
  */
-static inline dma_cookie_t dma_async_memcpy_buf_to_pg(struct dma_chan *chan,
-	struct page *page, unsigned int offset, void *kdata, size_t len)
+static inline dma_cookie_t dma_async_buf_to_pg(struct dma_chan *chan,
+		struct page *page, unsigned int offset,
+		void *kdata, size_t len)
 {
 	int cpu = get_cpu();
 	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
-	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
+	per_cpu_ptr(chan->local, cpu)->count++;
 	put_cpu();
 
-	return chan->device->device_memcpy_buf_to_pg(chan, page, offset,
-	                                             kdata, len);
+	return CHAN2FUNCS(chan)->buf_to_pg(chan, page, offset,
+						kdata, len);
 }
 
 /**
- * dma_async_memcpy_pg_to_pg - offloaded copy from page to page
+ * dma_async_pg_to_pg - offloaded copy from page to page
  * @chan: DMA channel to offload copy to
  * @dest_pg: destination page
  * @dest_off: offset in page to copy to
@@ -270,33 +291,33 @@ static inline dma_cookie_t dma_async_mem
  * Both @dest_page/@dest_off and @src_page/@src_off must stay memory resident
  * (kernel memory or locked user space pages).
  */
-static inline dma_cookie_t dma_async_memcpy_pg_to_pg(struct dma_chan *chan,
-	struct page *dest_pg, unsigned int dest_off, struct page *src_pg,
-	unsigned int src_off, size_t len)
+static inline dma_cookie_t dma_async_pg_to_pg( struct dma_chan *chan,
+		struct page *dest_pg, unsigned int dest_off,
+		struct page *src_pg, unsigned int src_off, size_t len)
 {
 	int cpu = get_cpu();
 	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
-	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
+	per_cpu_ptr(chan->local, cpu)->count++;
 	put_cpu();
 
-	return chan->device->device_memcpy_pg_to_pg(chan, dest_pg, dest_off,
-	                                            src_pg, src_off, len);
+	return CHAN2FUNCS(chan)->pg_to_pg(chan, dest_pg, dest_off,
+						src_pg, src_off, len);
 }
 
 /**
- * dma_async_memcpy_issue_pending - flush pending copies to HW
+ * dma_async_issue_pending - flush pending copies to HW
  * @chan: target DMA channel
  *
  * This allows drivers to push copies to HW in batches,
  * reducing MMIO writes where possible.
  */
-static inline void dma_async_memcpy_issue_pending(struct dma_chan *chan)
+static inline void dma_async_issue_pending(struct dma_chan *chan)
 {
-	return chan->device->device_memcpy_issue_pending(chan);
+	return CHAN2FUNCS(chan)->issue_pending(chan);
 }
 
 /**
- * dma_async_memcpy_complete - poll for transaction completion
+ * dma_async_complete - poll for transaction completion
  * @chan: DMA channel
  * @cookie: transaction identifier to check status of
  * @last: returns last completed cookie, can be NULL
@@ -306,10 +327,11 @@ static inline void dma_async_memcpy_issu
  * internal state and can be used with dma_async_is_complete() to check
  * the status of multiple cookies without re-checking hardware state.
  */
-static inline enum dma_status dma_async_memcpy_complete(struct dma_chan *chan,
-	dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used)
+static inline enum dma_status dma_async_complete(struct dma_chan *chan,
+		dma_cookie_t cookie, dma_cookie_t *last,
+		dma_cookie_t *used)
 {
-	return chan->device->device_memcpy_complete(chan, cookie, last, used);
+	return CHAN2FUNCS(chan)->complete(chan, cookie, last, used);
 }
 
 /**
@@ -318,7 +340,7 @@ static inline enum dma_status dma_async_
  * @last_complete: last know completed transaction
  * @last_used: last cookie value handed out
  *
- * dma_async_is_complete() is used in dma_async_memcpy_complete()
+ * dma_async_is_complete() is used in dma_async_complete()
  * the test logic is seperated for lightweight testing of multiple cookies
  */
 static inline enum dma_status dma_async_is_complete(dma_cookie_t cookie,
Index: linux-2.6/net/core/dev.c
===================================================================
--- linux-2.6.orig/net/core/dev.c
+++ linux-2.6/net/core/dev.c
@@ -1945,7 +1945,7 @@ out:
 		struct dma_chan *chan;
 		rcu_read_lock();
 		list_for_each_entry_rcu(chan, &net_dma_client->channels, client_node)
-			dma_async_memcpy_issue_pending(chan);
+			dma_async_issue_pending(chan);
 		rcu_read_unlock();
 	}
 #endif
@@ -3467,7 +3467,7 @@ static void netdev_dma_event(struct dma_
 static int __init netdev_dma_register(void)
 {
 	spin_lock_init(&net_dma_event_lock);
-	net_dma_client = dma_async_client_register(netdev_dma_event);
+	net_dma_client = dma_async_client_register(DMAFUNC_MEMCPY, netdev_dma_event);
 	if (net_dma_client == NULL)
 		return -ENOMEM;
 
