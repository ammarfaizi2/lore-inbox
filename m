Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbVLUFS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbVLUFS5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 00:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVLUFSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 00:18:13 -0500
Received: from fmr20.intel.com ([134.134.136.19]:55273 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751115AbVLUFRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 00:17:44 -0500
Subject: [RFC][PATCH 3/5] I/OAT DMA support and TCP acceleration
From: Chris Leech <christopher.leech@intel.com>
To: lkml <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Dec 2005 21:17:40 -0800
Message-Id: <1135142260.13781.20.camel@cleech-mobl>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
X-OriginalArrivalTime: 21 Dec 2005 05:17:44.0226 (UTC) FILETIME=[DF880820:01C605ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Utility functions for offloading sk_buff to iovec copies

Provides for pinning user space pages in memory, copying to iovecs, and
copying from sk_buffs including fragmented and chained sk_buffs.

---
 net/core/user_dma.c   |  410 ++++++++++++++++++++++++++++++++++++++++++++++++++
 net/core/Makefile     |    3 
 2 files changed, 412 insertions(+), 1 deletion(-)

--- /dev/null
+++ b/net/core/user_dma.c
@@ -0,0 +1,410 @@
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
+int dma_lock_iovec_pages(struct iovec *iov, size_t len,
+			struct dma_locked_list **locked_list)
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
+		                                      iov[nr_iovecs].iov_len);
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
+		page_list->nr_pages = NUM_PAGES_SPANNED(iov[i].iov_base,
+		                                        iov[i].iov_len);
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
+void dma_unlock_iovec_pages(struct dma_locked_list *locked_list)
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
+static dma_cookie_t dma_memcpy_tokerneliovec(struct dma_chan *chan,
+			struct iovec *iov, unsigned char *kdata, size_t len)
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
+static dma_cookie_t dma_memcpy_toiovec(struct dma_chan *chan, struct iovec *iov,
+			struct dma_locked_list *locked_list,
+			unsigned char *kdata, size_t len)
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
+static dma_cookie_t dma_memcpy_pg_toiovec(struct dma_chan *chan,
+			struct iovec *iov, struct dma_locked_list *locked_list,
+			struct page *page, unsigned int offset, size_t len)
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
+void dma_memcpy_toiovec_wait(struct dma_chan *chan, dma_cookie_t cookie)
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
+int dma_skb_copy_datagram_iovec(struct dma_chan *chan,
+			const struct sk_buff *skb, int offset, struct iovec *to,
+			size_t len, struct dma_locked_list *locked_list)
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
+		TCP_SKB_CB(skb)->dma_cookie = cookie;
+		return cookie;
+	}
+
+fault:
+ 	return -EFAULT;
+}
+
+#else
+
+int dma_lock_iovec_pages(struct iovec *iov, size_t len,
+			struct dma_locked_list **locked_list)
+{
+	*locked_list = NULL;
+
+	return 0;
+}
+
+void dma_unlock_iovec_pages(struct dma_locked_list* locked_list)
+{ }
+
+int dma_skb_copy_datagram_iovec(struct dma_chan *chan,
+			const struct sk_buff *skb, int offset, struct iovec *to,
+			size_t len, struct dma_locked_list *locked_list)
+{
+	return skb_copy_datagram_iovec(skb, offset, to, len);
+}
+
+void dma_memcpy_toiovec_wait(struct dma_chan *chan, dma_cookie_t cookie)
+{ }
+
+#endif
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

