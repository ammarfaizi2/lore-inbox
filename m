Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751315AbWEHWNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbWEHWNi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 18:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWEHWNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 18:13:23 -0400
Received: from [63.64.152.142] ([63.64.152.142]:21765 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1751286AbWEHWNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 18:13:13 -0400
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 4/9] [I/OAT] Utility functions for offloading sk_buff to iovec copies
Date: Mon, 08 May 2006 15:17:40 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060508221740.15181.31611.stgit@gitlost.site>
In-Reply-To: <20060508221632.15181.50046.stgit@gitlost.site>
References: <20060508221632.15181.50046.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provides for pinning user space pages in memory, copying to iovecs,
and copying from sk_buffs including fragmented and chained sk_buffs.

Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 drivers/dma/Makefile      |    3 
 drivers/dma/iovlock.c     |  301 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dmaengine.h |   22 +++
 include/net/netdma.h      |    6 +
 net/core/Makefile         |    1 
 net/core/user_dma.c       |  127 +++++++++++++++++++
 6 files changed, 459 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index c8a5f56..bdcfdbd 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -1,2 +1,3 @@
-obj-y += dmaengine.o
+obj-$(CONFIG_DMA_ENGINE) += dmaengine.o
+obj-$(CONFIG_NET_DMA) += iovlock.o
 obj-$(CONFIG_INTEL_IOATDMA) += ioatdma.o
diff --git a/drivers/dma/iovlock.c b/drivers/dma/iovlock.c
new file mode 100644
index 0000000..5ed327e
--- /dev/null
+++ b/drivers/dma/iovlock.c
@@ -0,0 +1,301 @@
+/*
+ * Copyright(c) 2004 - 2006 Intel Corporation. All rights reserved.
+ * Portions based on net/core/datagram.c and copyrighted by their authors.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ * The full GNU General Public License is included in this distribution in the
+ * file called COPYING.
+ */
+
+/*
+ * This code allows the net stack to make use of a DMA engine for
+ * skb to iovec copies.
+ */
+
+#include <linux/dmaengine.h>
+#include <linux/pagemap.h>
+#include <net/tcp.h> /* for memcpy_toiovec */
+#include <asm/io.h>
+#include <asm/uaccess.h>
+
+int num_pages_spanned(struct iovec *iov)
+{
+	return
+	((PAGE_ALIGN((unsigned long)iov->iov_base + iov->iov_len) -
+	((unsigned long)iov->iov_base & PAGE_MASK)) >> PAGE_SHIFT);
+}
+
+/*
+ * Pin down all the iovec pages needed for len bytes.
+ * Return a struct dma_pinned_list to keep track of pages pinned down.
+ *
+ * We are allocating a single chunk of memory, and then carving it up into
+ * 3 sections, the latter 2 whose size depends on the number of iovecs and the
+ * total number of pages, respectively.
+ */
+struct dma_pinned_list *dma_pin_iovec_pages(struct iovec *iov, size_t len)
+{
+	struct dma_pinned_list *local_list;
+	struct page **pages;
+	int i;
+	int ret;
+	int nr_iovecs = 0;
+	int iovec_len_used = 0;
+	int iovec_pages_used = 0;
+	long err;
+
+	/* don't pin down non-user-based iovecs */
+	if (segment_eq(get_fs(), KERNEL_DS))
+		return NULL;
+
+	/* determine how many iovecs/pages there are, up front */
+	do {
+		iovec_len_used += iov[nr_iovecs].iov_len;
+		iovec_pages_used += num_pages_spanned(&iov[nr_iovecs]);
+		nr_iovecs++;
+	} while (iovec_len_used < len);
+
+	/* single kmalloc for pinned list, page_list[], and the page arrays */
+	local_list = kmalloc(sizeof(*local_list)
+		+ (nr_iovecs * sizeof (struct dma_page_list))
+		+ (iovec_pages_used * sizeof (struct page*)), GFP_KERNEL);
+	if (!local_list) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* list of pages starts right after the page list array */
+	pages = (struct page **) &local_list->page_list[nr_iovecs];
+
+	for (i = 0; i < nr_iovecs; i++) {
+		struct dma_page_list *page_list = &local_list->page_list[i];
+
+		len -= iov[i].iov_len;
+
+		if (!access_ok(VERIFY_WRITE, iov[i].iov_base, iov[i].iov_len)) {
+			err = -EFAULT;
+			goto unpin;
+		}
+
+		page_list->nr_pages = num_pages_spanned(&iov[i]);
+		page_list->base_address = iov[i].iov_base;
+
+		page_list->pages = pages;
+		pages += page_list->nr_pages;
+
+		/* pin pages down */
+		down_read(&current->mm->mmap_sem);
+		ret = get_user_pages(
+			current,
+			current->mm,
+			(unsigned long) iov[i].iov_base,
+			page_list->nr_pages,
+			1,	/* write */
+			0,	/* force */
+			page_list->pages,
+			NULL);
+		up_read(&current->mm->mmap_sem);
+
+		if (ret != page_list->nr_pages) {
+			err = -ENOMEM;
+			goto unpin;
+		}
+
+		local_list->nr_iovecs = i + 1;
+	}
+
+	return local_list;
+
+unpin:
+	dma_unpin_iovec_pages(local_list);
+out:
+	return ERR_PTR(err);
+}
+
+void dma_unpin_iovec_pages(struct dma_pinned_list *pinned_list)
+{
+	int i, j;
+
+	if (!pinned_list)
+		return;
+
+	for (i = 0; i < pinned_list->nr_iovecs; i++) {
+		struct dma_page_list *page_list = &pinned_list->page_list[i];
+		for (j = 0; j < page_list->nr_pages; j++) {
+			set_page_dirty_lock(page_list->pages[j]);
+			page_cache_release(page_list->pages[j]);
+		}
+	}
+
+	kfree(pinned_list);
+}
+
+static dma_cookie_t dma_memcpy_to_kernel_iovec(struct dma_chan *chan, struct
+	iovec *iov, unsigned char *kdata, size_t len)
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
+ * We have already pinned down the pages we will be using in the iovecs.
+ * Each entry in iov array has corresponding entry in pinned_list->page_list.
+ * Using array indexing to keep iov[] and page_list[] in sync.
+ * Initial elements in iov array's iov->iov_len will be 0 if already copied into
+ *   by another call.
+ * iov array length remaining guaranteed to be bigger than len.
+ */
+dma_cookie_t dma_memcpy_to_iovec(struct dma_chan *chan, struct iovec *iov,
+	struct dma_pinned_list *pinned_list, unsigned char *kdata, size_t len)
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
+	if (!pinned_list)
+		return dma_memcpy_to_kernel_iovec(chan, iov, kdata, len);
+
+	iovec_idx = 0;
+	while (iovec_idx < pinned_list->nr_iovecs) {
+		struct dma_page_list *page_list;
+
+		/* skip already used-up iovecs */
+		while (!iov[iovec_idx].iov_len)
+			iovec_idx++;
+
+		page_list = &pinned_list->page_list[iovec_idx];
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
+dma_cookie_t dma_memcpy_pg_to_iovec(struct dma_chan *chan, struct iovec *iov,
+	struct dma_pinned_list *pinned_list, struct page *page,
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
+	if (!chan || !pinned_list) {
+		u8 *vaddr = kmap(page);
+		err = memcpy_toiovec(iov, vaddr + offset, len);
+		kunmap(page);
+		return err;
+	}
+
+	iovec_idx = 0;
+	while (iovec_idx < pinned_list->nr_iovecs) {
+		struct dma_page_list *page_list;
+
+		/* skip already used-up iovecs */
+		while (!iov[iovec_idx].iov_len)
+			iovec_idx++;
+
+		page_list = &pinned_list->page_list[iovec_idx];
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
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 3078154..78b236c 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -333,5 +333,27 @@ static inline enum dma_status dma_async_
 int dma_async_device_register(struct dma_device *device);
 void dma_async_device_unregister(struct dma_device *device);
 
+/* --- Helper iov-locking functions --- */
+
+struct dma_page_list {
+	char *base_address;
+	int nr_pages;
+	struct page **pages;
+};
+
+struct dma_pinned_list {
+	int nr_iovecs;
+	struct dma_page_list page_list[0];
+};
+
+struct dma_pinned_list *dma_pin_iovec_pages(struct iovec *iov, size_t len);
+void dma_unpin_iovec_pages(struct dma_pinned_list* pinned_list);
+
+dma_cookie_t dma_memcpy_to_iovec(struct dma_chan *chan, struct iovec *iov,
+	struct dma_pinned_list *pinned_list, unsigned char *kdata, size_t len);
+dma_cookie_t dma_memcpy_pg_to_iovec(struct dma_chan *chan, struct iovec *iov,
+	struct dma_pinned_list *pinned_list, struct page *page,
+	unsigned int offset, size_t len);
+
 #endif /* CONFIG_DMA_ENGINE */
 #endif /* DMAENGINE_H */
diff --git a/include/net/netdma.h b/include/net/netdma.h
index cbfe89d..19760eb 100644
--- a/include/net/netdma.h
+++ b/include/net/netdma.h
@@ -23,6 +23,7 @@
 #include <linux/config.h>
 #ifdef CONFIG_NET_DMA
 #include <linux/dmaengine.h>
+#include <linux/skbuff.h>
 
 static inline struct dma_chan *get_softnet_dma(void)
 {
@@ -34,5 +35,10 @@ static inline struct dma_chan *get_softn
 	rcu_read_unlock();
 	return chan;
 }
+
+int dma_skb_copy_datagram_iovec(struct dma_chan* chan,
+		const struct sk_buff *skb, int offset, struct iovec *to,
+		size_t len, struct dma_pinned_list *pinned_list);
+
 #endif /* CONFIG_NET_DMA */
 #endif /* NETDMA_H */
diff --git a/net/core/Makefile b/net/core/Makefile
index 79fe12c..e9bd246 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_NET_DIVERT) += dv.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
 obj-$(CONFIG_WIRELESS_EXT) += wireless.o
 obj-$(CONFIG_NETPOLL) += netpoll.o
+obj-$(CONFIG_NET_DMA) += user_dma.o
diff --git a/net/core/user_dma.c b/net/core/user_dma.c
new file mode 100644
index 0000000..9eee91b
--- /dev/null
+++ b/net/core/user_dma.c
@@ -0,0 +1,127 @@
+/*
+ * Copyright(c) 2004 - 2006 Intel Corporation. All rights reserved.
+ * Portions based on net/core/datagram.c and copyrighted by their authors.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ * The full GNU General Public License is included in this distribution in the
+ * file called COPYING.
+ */
+
+/*
+ * This code allows the net stack to make use of a DMA engine for
+ * skb to iovec copies.
+ */
+
+#include <linux/dmaengine.h>
+#include <linux/socket.h>
+#include <linux/rtnetlink.h> /* for BUG_TRAP */
+#include <net/tcp.h>
+
+/**
+ *	dma_skb_copy_datagram_iovec - Copy a datagram to an iovec.
+ *	@skb - buffer to copy
+ *	@offset - offset in the buffer to start copying from
+ *	@iovec - io vector to copy to
+ *	@len - amount of data to copy from buffer to iovec
+ *	@pinned_list - locked iovec buffer data
+ *
+ *	Note: the iovec is modified during the copy.
+ */
+int dma_skb_copy_datagram_iovec(struct dma_chan *chan,
+			struct sk_buff *skb, int offset, struct iovec *to,
+			size_t len, struct dma_pinned_list *pinned_list)
+{
+	int start = skb_headlen(skb);
+	int i, copy = start - offset;
+	dma_cookie_t cookie = 0;
+
+	/* Copy header. */
+	if (copy > 0) {
+		if (copy > len)
+			copy = len;
+		cookie = dma_memcpy_to_iovec(chan, to, pinned_list,
+		                            skb->data + offset, copy);
+		if (cookie < 0)
+			goto fault;
+		len -= copy;
+		if (len == 0)
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
+		copy = end - offset;
+		if ((copy = end - offset) > 0) {
+			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+			struct page *page = frag->page;
+
+			if (copy > len)
+				copy = len;
+
+			cookie = dma_memcpy_pg_to_iovec(chan, to, pinned_list, page,
+					frag->page_offset + offset - start, copy);
+			if (cookie < 0)
+				goto fault;
+			len -= copy;
+			if (len == 0)
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
+			copy = end - offset;
+			if (copy > 0) {
+				if (copy > len)
+					copy = len;
+				cookie = dma_skb_copy_datagram_iovec(chan, list,
+				                offset - start, to, copy,
+				                pinned_list);
+				if (cookie < 0)
+					goto fault;
+				len -= copy;
+				if (len == 0)
+					goto end;
+				offset += copy;
+			}
+			start = end;
+		}
+	}
+
+end:
+	if (!len) {
+		skb->dma_cookie = cookie;
+		return cookie;
+	}
+
+fault:
+ 	return -EFAULT;
+}

