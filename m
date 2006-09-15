Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWIOQni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWIOQni (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 12:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWIOQnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 12:43:37 -0400
Received: from lixom.net ([66.141.50.11]:18924 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1750707AbWIOQng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 12:43:36 -0400
Date: Fri, 15 Sep 2006 11:38:17 -0500
From: Olof Johansson <olof@lixom.net>
To: Jeff Garzik <jeff@garzik.org>, Dan Williams <dan.j.williams@intel.com>,
       christopher.leech@intel.com
Cc: neilb@suse.de, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/19] dmaengine: enable multiple clients and operations
Message-ID: <20060915113817.6154aa67@localhost.localdomain>
In-Reply-To: <4505F4D0.7010901@garzik.org>
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
	<20060911231817.4737.49381.stgit@dwillia2-linux.ch.intel.com>
	<4505F4D0.7010901@garzik.org>
X-Mailer: Sylpheed-Claws 2.1.1 (GTK+ 2.8.17; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2006 19:44:16 -0400 Jeff Garzik <jeff@garzik.org> wrote:

> Dan Williams wrote:
> > @@ -759,8 +755,10 @@ #endif
> >  	device->common.device_memcpy_buf_to_buf = ioat_dma_memcpy_buf_to_buf;
> >  	device->common.device_memcpy_buf_to_pg = ioat_dma_memcpy_buf_to_pg;
> >  	device->common.device_memcpy_pg_to_pg = ioat_dma_memcpy_pg_to_pg;
> > -	device->common.device_memcpy_complete = ioat_dma_is_complete;
> > -	device->common.device_memcpy_issue_pending = ioat_dma_memcpy_issue_pending;
> > +	device->common.device_operation_complete = ioat_dma_is_complete;
> > +	device->common.device_xor_pgs_to_pg = dma_async_xor_pgs_to_pg_err;
> > +	device->common.device_issue_pending = ioat_dma_memcpy_issue_pending;
> > +	device->common.capabilities = DMA_MEMCPY;
> 
> 
> Are we really going to add a set of hooks for each DMA engine whizbang 
> feature?
> 
> That will get ugly when DMA engines support memcpy, xor, crc32, sha1, 
> aes, and a dozen other transforms.


Yes, it will be unmaintainable. We need some sort of multiplexing with
per-function registrations.

Here's a first cut at it, just very quick. It could be improved further
but it shows that we could exorcise most of the hardcoded things pretty
easily.

Dan, would this fit with your added XOR stuff as well? If so, would you
mind rebasing on top of something like this (with your further cleanups
going in before added function, please. :-)

(Build tested only, since I lack Intel hardware).


It would be nice if we could move the type specification to only be
needed in the channel allocation. I don't know how well that fits the
model for some of the hardware platforms though, since a single channel
might be shared for different types of functions. Maybe we need a
different level of abstraction there instead, i.e. divorce the hardware
channel and software channel model and have several software channels
map onto a hardware one.





Clean up the DMA API a bit, allowing each engine to register an array
of supported functions instead of allocating static names for each possible
function.


Signed-off-by: Olof Johansson <olof@lixom.net>


diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 1527804..282ce85 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -80,7 +80,7 @@ static ssize_t show_memcpy_count(struct 
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
+	__ATTR(count, S_IRUGO, show_memcpy_count, NULL),
 	__ATTR(bytes_transferred, S_IRUGO, show_bytes_transferred, NULL),
 	__ATTR(in_use, S_IRUGO, show_in_use, NULL),
 	__ATTR_NULL
@@ -402,11 +402,11 @@ subsys_initcall(dma_bus_init);
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
diff --git a/drivers/dma/ioatdma.c b/drivers/dma/ioatdma.c
index dbd4d6c..6cbed42 100644
--- a/drivers/dma/ioatdma.c
+++ b/drivers/dma/ioatdma.c
@@ -40,6 +40,7 @@
 #define to_ioat_device(dev) container_of(dev, struct ioat_device, common)
 #define to_ioat_desc(lh) container_of(lh, struct ioat_desc_sw, node)
 
+
 /* internal functions */
 static int __devinit ioat_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
 static void __devexit ioat_remove(struct pci_dev *pdev);
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
 
diff --git a/drivers/dma/iovlock.c b/drivers/dma/iovlock.c
index d637555..8a2f642 100644
--- a/drivers/dma/iovlock.c
+++ b/drivers/dma/iovlock.c
@@ -151,11 +151,8 @@ static dma_cookie_t dma_memcpy_to_kernel
 	while (len > 0) {
 		if (iov->iov_len) {
 			int copy = min_t(unsigned int, iov->iov_len, len);
-			dma_cookie = dma_async_memcpy_buf_to_buf(
-					chan,
-					iov->iov_base,
-					kdata,
-					copy);
+			dma_cookie = dma_async_buf_to_buf(DMAFUNC_MEMCPY, chan,
+					iov->iov_base, kdata, copy);
 			kdata += copy;
 			len -= copy;
 			iov->iov_len -= copy;
@@ -210,7 +207,7 @@ dma_cookie_t dma_memcpy_to_iovec(struct 
 			copy = min_t(int, PAGE_SIZE - iov_byte_offset, len);
 			copy = min_t(int, copy, iov[iovec_idx].iov_len);
 
-			dma_cookie = dma_async_memcpy_buf_to_pg(chan,
+			dma_cookie = dma_async_buf_to_pg(DMAFUNC_MEMCPY, chan,
 					page_list->pages[page_idx],
 					iov_byte_offset,
 					kdata,
@@ -274,7 +271,7 @@ dma_cookie_t dma_memcpy_pg_to_iovec(stru
 			copy = min_t(int, PAGE_SIZE - iov_byte_offset, len);
 			copy = min_t(int, copy, iov[iovec_idx].iov_len);
 
-			dma_cookie = dma_async_memcpy_pg_to_pg(chan,
+			dma_cookie = dma_async_pg_to_pg(DMAFUNC_MEMCPY, chan,
 					page_list->pages[page_idx],
 					iov_byte_offset,
 					page,
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c94d8f1..317a7f2 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
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
 
@@ -157,6 +157,34 @@ struct dma_client {
 	struct list_head	global_node;
 };
 
+enum dma_function_type {
+	DMAFUNC_MEMCPY = 0,
+	DMAFUNC_XOR,
+	DMAFUNC_MAX
+};
+
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
@@ -168,14 +196,8 @@ struct dma_client {
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
@@ -185,20 +207,10 @@ struct dma_device {
 
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
 
 /* --- public DMA engine API --- */
@@ -209,7 +221,7 @@ void dma_async_client_chan_request(struc
 		unsigned int number);
 
 /**
- * dma_async_memcpy_buf_to_buf - offloaded copy between virtual addresses
+ * dma_async_buf_to_buf - offloaded copy between virtual addresses
  * @chan: DMA channel to offload copy to
  * @dest: destination address (virtual)
  * @src: source address (virtual)
@@ -220,19 +232,24 @@ void dma_async_client_chan_request(struc
  * Both @dest and @src must stay memory resident (kernel memory or locked
  * user space pages).
  */
-static inline dma_cookie_t dma_async_memcpy_buf_to_buf(struct dma_chan *chan,
-	void *dest, void *src, size_t len)
+static inline dma_cookie_t dma_async_buf_to_buf(enum dma_function_type type,
+		struct dma_chan *chan, void *dest, void *src, size_t len)
 {
-	int cpu = get_cpu();
+	int cpu;
+
+	if (!chan->device->funcs[type])
+		return -ENXIO;
+
+	cpu = get_cpu();
 	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
-	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
+	per_cpu_ptr(chan->local, cpu)->count++;
 	put_cpu();
 
-	return chan->device->device_memcpy_buf_to_buf(chan, dest, src, len);
+	return chan->device->funcs[type]->buf_to_buf(chan, dest, src, len);
 }
 
 /**
- * dma_async_memcpy_buf_to_pg - offloaded copy from address to page
+ * dma_async_buf_to_pg - offloaded copy from address to page
  * @chan: DMA channel to offload copy to
  * @page: destination page
  * @offset: offset in page to copy to
@@ -244,20 +261,26 @@ static inline dma_cookie_t dma_async_mem
  * Both @page/@offset and @kdata must stay memory resident (kernel memory or
  * locked user space pages)
  */
-static inline dma_cookie_t dma_async_memcpy_buf_to_pg(struct dma_chan *chan,
-	struct page *page, unsigned int offset, void *kdata, size_t len)
+static inline dma_cookie_t dma_async_buf_to_pg(enum dma_function_type type,
+		struct dma_chan *chan, struct page *page, unsigned int offset,
+		void *kdata, size_t len)
 {
-	int cpu = get_cpu();
+	int cpu;
+
+	if (!chan->device->funcs[type])
+		return -ENXIO;
+
+	cpu = get_cpu();
 	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
-	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
+	per_cpu_ptr(chan->local, cpu)->count++;
 	put_cpu();
 
-	return chan->device->device_memcpy_buf_to_pg(chan, page, offset,
-	                                             kdata, len);
+	return chan->device->funcs[type]->buf_to_pg(chan, page, offset,
+							kdata, len);
 }
 
 /**
- * dma_async_memcpy_pg_to_pg - offloaded copy from page to page
+ * dma_async_pg_to_pg - offloaded copy from page to page
  * @chan: DMA channel to offload copy to
  * @dest_pg: destination page
  * @dest_off: offset in page to copy to
@@ -270,33 +293,40 @@ static inline dma_cookie_t dma_async_mem
  * Both @dest_page/@dest_off and @src_page/@src_off must stay memory resident
  * (kernel memory or locked user space pages).
  */
-static inline dma_cookie_t dma_async_memcpy_pg_to_pg(struct dma_chan *chan,
-	struct page *dest_pg, unsigned int dest_off, struct page *src_pg,
-	unsigned int src_off, size_t len)
+static inline dma_cookie_t dma_async_pg_to_pg(enum dma_function_type type,
+		struct dma_chan *chan, struct page *dest_pg, unsigned int dest_off,
+		struct page *src_pg, unsigned int src_off, size_t len)
 {
-	int cpu = get_cpu();
+	int cpu;
+
+	if (!chan->device->funcs[type])
+		return -ENXIO;
+
+	cpu = get_cpu();
 	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
-	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
+	per_cpu_ptr(chan->local, cpu)->count++;
 	put_cpu();
 
-	return chan->device->device_memcpy_pg_to_pg(chan, dest_pg, dest_off,
-	                                            src_pg, src_off, len);
+	return chan->device->funcs[type]->pg_to_pg(chan, dest_pg, dest_off,
+							src_pg, src_off, len);
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
+static inline void dma_async_issue_pending(enum dma_function_type type,
+		struct dma_chan *chan)
 {
-	return chan->device->device_memcpy_issue_pending(chan);
+	if (chan->device->funcs[type])
+		return chan->device->funcs[type]->issue_pending(chan);
 }
 
 /**
- * dma_async_memcpy_complete - poll for transaction completion
+ * dma_async_complete - poll for transaction completion
  * @chan: DMA channel
  * @cookie: transaction identifier to check status of
  * @last: returns last completed cookie, can be NULL
@@ -306,10 +336,14 @@ static inline void dma_async_memcpy_issu
  * internal state and can be used with dma_async_is_complete() to check
  * the status of multiple cookies without re-checking hardware state.
  */
-static inline enum dma_status dma_async_memcpy_complete(struct dma_chan *chan,
-	dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used)
+static inline enum dma_status dma_async_complete(enum dma_function_type type,
+		struct dma_chan *chan, dma_cookie_t cookie, dma_cookie_t *last,
+		dma_cookie_t *used)
 {
-	return chan->device->device_memcpy_complete(chan, cookie, last, used);
+	if (!chan->device->funcs[type])
+		return -ENXIO;
+	else
+		return chan->device->funcs[type]->complete(chan, cookie, last, used);
 }
 
 /**
@@ -318,7 +352,7 @@ static inline enum dma_status dma_async_
  * @last_complete: last know completed transaction
  * @last_used: last cookie value handed out
  *
- * dma_async_is_complete() is used in dma_async_memcpy_complete()
+ * dma_async_is_complete() is used in dma_async_complete()
  * the test logic is seperated for lightweight testing of multiple cookies
  */
 static inline enum dma_status dma_async_is_complete(dma_cookie_t cookie,
diff --git a/net/core/dev.c b/net/core/dev.c
index d4a1ec3..e8a8ee9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1945,7 +1945,7 @@ out:
 		struct dma_chan *chan;
 		rcu_read_lock();
 		list_for_each_entry_rcu(chan, &net_dma_client->channels, client_node)
-			dma_async_memcpy_issue_pending(chan);
+			dma_async_issue_pending(DMAFUNC_MEMCPY, chan);
 		rcu_read_unlock();
 	}
 #endif
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 934396b..c270837 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1431,9 +1431,9 @@ skip_copy:
 		struct sk_buff *skb;
 		dma_cookie_t done, used;
 
-		dma_async_memcpy_issue_pending(tp->ucopy.dma_chan);
+		dma_async_issue_pending(DMAFUNC_MEMCPY, tp->ucopy.dma_chan);
 
-		while (dma_async_memcpy_complete(tp->ucopy.dma_chan,
+		while (dma_async_complete(DMAFUNC_MEMCPY, tp->ucopy.dma_chan,
 		                                 tp->ucopy.dma_cookie, &done,
 		                                 &used) == DMA_IN_PROGRESS) {
 			/* do partial cleanup of sk_async_wait_queue */


