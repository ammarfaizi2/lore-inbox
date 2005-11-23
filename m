Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVKWU0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVKWU0y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVKWU0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:26:53 -0500
Received: from fmr17.intel.com ([134.134.136.16]:64671 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932353AbVKWU0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:26:47 -0500
Date: Wed, 23 Nov 2005 12:26:46 -0800 (PST)
From: Andrew Grover <andrew.grover@intel.com>
X-X-Sender: agrover@isotope.jf.intel.com
To: netdev@vger.kernel.org, <linux-kernel@vger.kernel.org>
cc: john.ronciak@intel.com, <christopher.leech@intel.com>
Subject: [RFC] [PATCH 2/3] ioat: user buffer pin; net DMA client register
Message-ID: <Pine.LNX.4.44.0511231215020.32487-100000@isotope.jf.intel.com>
ReplyTo: "Andrew Grover" <andrew.grover@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff --git a/net/core/Makefile b/net/core/Makefile
index 630da0f..d02132b 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -8,7 +8,8 @@ obj-y := sock.o request_sock.o skbuff.o 
 obj-$(CONFIG_SYSCTL) += sysctl_net_core.o
 
 obj-y		     += dev.o ethtool.o dev_mcast.o dst.o \
-			neighbour.o rtnetlink.o utils.o link_watch.o filter.o
+			neighbour.o rtnetlink.o utils.o link_watch.o filter.o \
+			user_dma.o
 
 obj-$(CONFIG_XFRM) += flow.o
 obj-$(CONFIG_SYSFS) += net-sysfs.o
diff --git a/net/core/dev.c b/net/core/dev.c
index a44eeef..a81bee8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -113,6 +113,7 @@
 #include <linux/wireless.h>		/* Note : will define WIRELESS_EXT */
 #include <net/iw_handler.h>
 #endif	/* CONFIG_NET_RADIO */
+#include <linux/dmaengine.h>
 #include <asm/current.h>
 
 /*
@@ -147,6 +148,12 @@ static DEFINE_SPINLOCK(ptype_lock);
 static struct list_head ptype_base[16];	/* 16 way hashed list */
 static struct list_head ptype_all;		/* Taps */
 
+#ifdef CONFIG_NET_DMA
+struct dma_client *net_dma_client;
+DEFINE_PER_CPU(struct dma_chan *, net_dma);
+static unsigned int net_dma_count;
+#endif
+
 /*
  * The @dev_base list is protected by @dev_base_lock and the rtln
  * semaphore.
@@ -1708,6 +1715,9 @@ static void net_rx_action(struct softirq
 	unsigned long start_time = jiffies;
 	int budget = netdev_budget;
 	void *have;
+#ifdef CONFIG_NET_DMA
+	struct dma_chan *chan;
+#endif
 
 	local_irq_disable();
 
@@ -1739,6 +1749,10 @@ static void net_rx_action(struct softirq
 		}
 	}
 out:
+#ifdef CONFIG_NET_DMA
+	list_for_each_entry(chan, &net_dma_client->channels, client_node)
+		dma_async_memcpy_issue_pending(chan);
+#endif
 	local_irq_enable();
 	return;
 
@@ -3171,6 +3185,68 @@ static int dev_cpu_callback(struct notif
 }
 #endif /* CONFIG_HOTPLUG_CPU */
 
+#ifdef CONFIG_NET_DMA
+static void net_dma_rebalance(void)
+{
+	unsigned int cpu, i, n;
+	struct dma_chan *chan;
+
+	lock_cpu_hotplug();
+
+	if (net_dma_count == 0) {
+		for_each_online_cpu(cpu)
+			per_cpu(net_dma, cpu) = NULL;
+		unlock_cpu_hotplug();
+		return;
+	}
+
+	i = 0;
+	cpu = first_cpu(cpu_online_map);
+
+	list_for_each_entry(chan, &net_dma_client->channels, client_node) {
+		/* cpus_clear(chan->cpumask); */
+		n = ((num_online_cpus() / net_dma_count) + (i < (num_online_cpus() % net_dma_count) ? 1 : 0));
+
+		while(n) {
+			per_cpu(net_dma, cpu) = chan;
+			/* cpu_set(cpu, chan->cpumask); */
+			cpu = next_cpu(cpu, cpu_online_map);
+			n--;
+		}
+		i++;
+	}
+
+	unlock_cpu_hotplug();
+}
+
+static void netdev_dma_event(struct dma_client *client, struct dma_chan *chan, enum dma_event_t event)
+{
+	switch (event) {
+	case DMA_RESOURCE_ADDED:
+		net_dma_count++;
+		net_dma_rebalance();
+		break;
+	case DMA_RESOURCE_REMOVED:
+		net_dma_count--;
+		net_dma_rebalance();
+		break;
+	default:
+		break;
+	}
+}
+
+static int __init netdev_dma_register(void)
+{
+	net_dma_client = dma_async_client_register(netdev_dma_event);
+
+	dma_async_client_chan_request(net_dma_client, num_online_cpus());
+
+	return 0;
+}
+
+#else
+static int __init netdev_dma_register(void) { return -ENODEV; }
+#endif /* CONFIG_NET_DMA */
 
 /*
  *	Initialize the DEV module. At boot time this walks the device list and
@@ -3224,6 +3300,8 @@ static int __init net_dev_init(void)
 		atomic_set(&queue->backlog_dev.refcnt, 1);
 	}
 
+	netdev_dma_register();
+
 	dev_boot_phase = 0;
 
 	open_softirq(NET_TX_SOFTIRQ, net_tx_action, NULL);
diff --git a/net/core/user_dma.c b/net/core/user_dma.c
new file mode 100644
index 0000000..958e2c8
--- /dev/null
+++ b/net/core/user_dma.c
@@ -0,0 +1,422 @@
+/*
+  Copyright(c) 2004 - 2005 Intel Corporation
+  Portions based on net/core/datagram.c and copyrighted by their authors.
+
+  This code allows the net stack to make use of a DMA engine for
+  skb to iovec copies.
+*/
+
+#include <linux/dmaengine.h>
+#include <linux/pagemap.h>
+#include <linux/socket.h>
+#include <linux/rtnetlink.h> /* for BUG_TRAP */
+#include <net/tcp.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+#ifdef CONFIG_NET_DMA
+
+#define NUM_PAGES_SPANNED(start, length) \
+	((PAGE_ALIGN((unsigned long)start + length) - \
+	((unsigned long)start & PAGE_MASK)) >> PAGE_SHIFT)
+
+/*
+ * Lock down all the iovec pages needed for len bytes.
+ * Return a struct dma_locked_list to keep track of pages locked down.
+ *
+ * We are allocating a single chunk of memory, and then carving it up into
+ * 3 sections, the latter 2 whose size depends on the number of iovecs and the
+ * total number of pages, respectively.
+ */
+int
+dma_lock_iovec_pages(struct iovec *iov, size_t len, struct dma_locked_list **locked_list)
+{
+	struct dma_locked_list *local_list;
+	struct page **pages;
+	int i;
+	int ret;
+
+	int nr_iovecs = 0;
+	int iovec_len_used = 0;
+	int iovec_pages_used = 0;
+
+	/* don't lock down non-user-based iovecs */
+	if (segment_eq(get_fs(), KERNEL_DS)) {
+		*locked_list = NULL;
+		return 0;
+	}
+
+	/* determine how many iovecs/pages there are, up front */
+	do {
+		iovec_len_used += iov[nr_iovecs].iov_len;
+		iovec_pages_used += NUM_PAGES_SPANNED(iov[nr_iovecs].iov_base,
+			iov[nr_iovecs].iov_len);
+		nr_iovecs++;
+	} while (iovec_len_used < len);
+
+	/* single kmalloc for locked list, page_list[], and the page arrays */
+	local_list = kmalloc(sizeof(*local_list)
+		+ (nr_iovecs * sizeof (struct dma_page_list))
+		+ (iovec_pages_used * sizeof (struct page*)), GFP_KERNEL);
+	if (!local_list)
+		return -ENOMEM;
+
+	/* list of pages starts right after the page list array */
+	pages = (struct page **) &local_list->page_list[nr_iovecs];
+
+	/* it's a userspace pointer */
+	might_sleep();
+
+	for (i = 0; i < nr_iovecs; i++) {
+		struct dma_page_list *page_list = &local_list->page_list[i];
+
+		len -= iov[i].iov_len;
+
+		if (!access_ok(VERIFY_WRITE, iov[i].iov_base, iov[i].iov_len)) {
+			dma_unlock_iovec_pages(local_list);
+			return -EFAULT;
+		}
+
+		page_list->nr_pages = NUM_PAGES_SPANNED(iov[i].iov_base, iov[i].iov_len);
+		page_list->base_address = iov[i].iov_base;
+
+		page_list->pages = pages;
+		pages += page_list->nr_pages;
+
+		/* lock pages down */
+		down_read(&current->mm->mmap_sem);
+		ret = get_user_pages(
+			current,
+			current->mm,
+			(unsigned long) iov[i].iov_base,
+			page_list->nr_pages,
+			1,
+			0,
+			page_list->pages,
+			NULL);
+		up_read(&current->mm->mmap_sem);
+
+		if (ret != page_list->nr_pages) {
+			goto mem_error;
+		}
+
+		local_list->nr_iovecs = i + 1;
+	}
+
+	*locked_list = local_list;
+	return 0;
+
+mem_error:
+	dma_unlock_iovec_pages(local_list);
+	return -ENOMEM;
+}
+
+void
+dma_unlock_iovec_pages(struct dma_locked_list *locked_list)
+{
+	int i, j;
+
+	if (!locked_list)
+		return;
+
+	for (i = 0; i < locked_list->nr_iovecs; i++) {
+		struct dma_page_list *page_list = &locked_list->page_list[i];
+		for (j = 0; j < page_list->nr_pages; j++) {
+			SetPageDirty(page_list->pages[j]);
+			page_cache_release(page_list->pages[j]);
+		}
+	}
+
+	kfree(locked_list);
+}
+
+static dma_cookie_t
+dma_memcpy_tokerneliovec(struct dma_chan *chan, struct iovec *iov,
+	unsigned char *kdata, size_t len)
+{
+	dma_cookie_t dma_cookie = 0;
+
+	while (len > 0) {
+		if (iov->iov_len) {
+			int copy = min_t(unsigned int, iov->iov_len, len);
+			dma_cookie = dma_async_memcpy_buf_to_buf(
+					chan,
+					iov->iov_base,
+					kdata,
+					copy);
+			kdata += copy;
+			len -= copy;
+			iov->iov_len -= copy;
+			iov->iov_base += copy;
+		}
+		iov++;
+	}
+
+	return dma_cookie;
+}
+
+/*
+ * We have already locked down the pages we will be using in the iovecs.
+ * Each entry in iov array has corresponding entry in locked_list->page_list.
+ * Using array indexing to keep iov[] and page_list[] in sync.
+ * Initial elements in iov array's iov->iov_len will be 0 if already copied into
+ *   by another call.
+ * iov array length remaining guaranteed to be bigger than len.
+ */
+static dma_cookie_t
+dma_memcpy_toiovec(struct dma_chan *chan, struct iovec *iov,
+	struct dma_locked_list *locked_list, unsigned char *kdata, size_t len)
+{
+	int iov_byte_offset;
+	int copy;
+	dma_cookie_t dma_cookie = 0;
+	int iovec_idx;
+	int page_idx;
+
+	if (!chan)
+		return memcpy_toiovec(iov, kdata, len);
+
+	/* -> kernel copies (e.g. smbfs) */
+	if (!locked_list)
+		return dma_memcpy_tokerneliovec(chan, iov, kdata, len);
+
+	iovec_idx = 0;
+	while (iovec_idx < locked_list->nr_iovecs) {
+		struct dma_page_list *page_list;
+
+		/* skip already used-up iovecs */
+		while (!iov[iovec_idx].iov_len)
+			iovec_idx++;
+
+		page_list = &locked_list->page_list[iovec_idx];
+
+		iov_byte_offset = ((unsigned long)iov[iovec_idx].iov_base & ~PAGE_MASK);
+		page_idx = (((unsigned long)iov[iovec_idx].iov_base & PAGE_MASK)
+			 - ((unsigned long)page_list->base_address & PAGE_MASK)) >> PAGE_SHIFT;
+
+		/* break up copies to not cross page boundary */
+		while (iov[iovec_idx].iov_len) {
+			copy = min_t(int, PAGE_SIZE - iov_byte_offset, len);
+			copy = min_t(int, copy, iov[iovec_idx].iov_len);
+
+			dma_cookie = dma_async_memcpy_buf_to_pg(chan,
+					page_list->pages[page_idx],
+					iov_byte_offset,
+					kdata,
+					copy);
+
+			len -= copy;
+			iov[iovec_idx].iov_len -= copy;
+			iov[iovec_idx].iov_base += copy;
+
+			if (!len)
+				return dma_cookie;
+
+			kdata += copy;
+			iov_byte_offset = 0;
+			page_idx++;
+		}
+		iovec_idx++;
+	}
+
+	/* really bad if we ever run out of iovecs */
+	BUG();
+	return -EFAULT;
+}
+
+static dma_cookie_t
+dma_memcpy_pg_toiovec(struct dma_chan *chan, struct iovec *iov,
+	struct dma_locked_list *locked_list, struct page *page,
+	unsigned int offset, size_t len)
+{
+	int iov_byte_offset;
+	int copy;
+	dma_cookie_t dma_cookie = 0;
+	int iovec_idx;
+	int page_idx;
+	int err;
+
+	/* this needs as-yet-unimplemented buf-to-buff, so punt. */
+	/* TODO: use dma for this */
+	if (!chan || !locked_list) {
+		u8 *vaddr = kmap(page);
+		err = memcpy_toiovec(iov, vaddr + offset, len);
+		kunmap(page);
+		return err;
+	}
+
+	iovec_idx = 0;
+	while (iovec_idx < locked_list->nr_iovecs) {
+		struct dma_page_list *page_list;
+
+		/* skip already used-up iovecs */
+		while (!iov[iovec_idx].iov_len)
+			iovec_idx++;
+
+		page_list = &locked_list->page_list[iovec_idx];
+
+		iov_byte_offset = ((unsigned long)iov[iovec_idx].iov_base & ~PAGE_MASK);
+		page_idx = (((unsigned long)iov[iovec_idx].iov_base & PAGE_MASK)
+			 - ((unsigned long)page_list->base_address & PAGE_MASK)) >> PAGE_SHIFT;
+
+		/* break up copies to not cross page boundary */
+		while (iov[iovec_idx].iov_len) {
+			copy = min_t(int, PAGE_SIZE - iov_byte_offset, len);
+			copy = min_t(int, copy, iov[iovec_idx].iov_len);
+
+			dma_cookie = dma_async_memcpy_pg_to_pg(chan,
+					page_list->pages[page_idx],
+					iov_byte_offset,
+					page,
+					offset,
+					copy);
+
+			len -= copy;
+			iov[iovec_idx].iov_len -= copy;
+			iov[iovec_idx].iov_base += copy;
+
+			if (!len)
+				return dma_cookie;
+
+			offset += copy;
+			iov_byte_offset = 0;
+			page_idx++;
+		}
+		iovec_idx++;
+	}
+
+	/* really bad if we ever run out of iovecs */
+	BUG();
+	return -EFAULT;
+}
+
+void
+dma_memcpy_toiovec_wait(struct dma_chan *chan, dma_cookie_t cookie)
+{
+	if (cookie <= 0)
+		return;
+
+	dma_async_wait_for_completion(chan, cookie);
+}
+
+/**
+ *	dma_skb_copy_datagram_iovec - Copy a datagram to an iovec.
+ *	@skb - buffer to copy
+ *	@offset - offset in the buffer to start copying from
+ *	@iovec - io vector to copy to
+ *	@len - amount of data to copy from buffer to iovec
+ *	@locked_list - locked iovec buffer data
+ *
+ *	Note: the iovec is modified during the copy.
+ */
+int
+dma_skb_copy_datagram_iovec(
+	struct dma_chan *chan,
+	const struct sk_buff *skb,
+	int offset,
+	struct iovec *to,
+	size_t len,
+	struct dma_locked_list *locked_list)
+{
+	int start = skb_headlen(skb);
+	int i, copy = start - offset;
+	dma_cookie_t cookie = 0;
+
+	/* Copy header. */
+	if (copy > 0) {
+		if (copy > len)
+			copy = len;
+		if ((cookie = dma_memcpy_toiovec(chan, to, locked_list,
+		     skb->data + offset, copy)) < 0)
+			goto fault;
+		if ((len -= copy) == 0)
+			goto end;
+		offset += copy;
+	}
+
+	/* Copy paged appendix. Hmm... why does this look so complicated? */
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		int end;
+
+		BUG_TRAP(start <= offset + len);
+
+		end = start + skb_shinfo(skb)->frags[i].size;
+		if ((copy = end - offset) > 0) {
+			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+			struct page *page = frag->page;
+
+			if (copy > len)
+				copy = len;
+
+			cookie = dma_memcpy_pg_toiovec(chan, to, locked_list, page,
+					frag->page_offset + offset - start, copy);
+			if (cookie < 0)
+				goto fault;
+			if (!(len -= copy))
+				goto end;
+			offset += copy;
+		}
+		start = end;
+	}
+
+	if (skb_shinfo(skb)->frag_list) {
+		struct sk_buff *list = skb_shinfo(skb)->frag_list;
+
+		for (; list; list = list->next) {
+			int end;
+
+			BUG_TRAP(start <= offset + len);
+
+			end = start + list->len;
+			if ((copy = end - offset) > 0) {
+				if (copy > len)
+					copy = len;
+				if ((cookie = dma_skb_copy_datagram_iovec(chan, list,
+					        offset - start, to, copy, locked_list)) < 0)
+					goto fault;
+				if ((len -= copy) == 0)
+					goto end;
+				offset += copy;
+			}
+			start = end;
+		}
+	}
+
+end:
+	if (!len) {
+#if 0
+		TCP_SKB_CB(skb)->dma_cookie = cookie;
+#endif
+		return cookie;
+	}
+
+fault:
+ 	return -EFAULT;
+}
+
+#else
+
+int
+dma_lock_iovec_pages(struct iovec *iov, size_t len, struct dma_locked_list **locked_list)
+{
+	*locked_list = NULL;
+
+	return 0;
+}
+
+void
+dma_unlock_iovec_pages(struct dma_locked_list* locked_list)
+{ }
+
+int
+dma_skb_copy_datagram_iovec(struct dma_chan *chan, const struct sk_buff *skb, int offset,
+			    struct iovec *to, size_t len, struct dma_locked_list *locked_list)
+{
+	return skb_copy_datagram_iovec(skb, offset, to, len);
+}
+
+void
+dma_memcpy_toiovec_wait(struct dma_chan *chan, dma_cookie_t cookie)
+{ }
+
+#endif




