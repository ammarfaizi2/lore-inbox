Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264484AbUDZKcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264484AbUDZKcD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 06:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUDZKal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 06:30:41 -0400
Received: from ns.suse.de ([195.135.220.2]:60885 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264488AbUDZK2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 06:28:51 -0400
Subject: [PATCH 5/11] sunrpc-xdr-arrays
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1082975187.3295.75.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 26 Apr 2004 12:28:48 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sunrpc: Encode/decode arrays that may become large

Callbacks are used to actually encode/decode array elements.

  Andreas Gruenbacher <agruen@suse.de>, SUSE Labs

Index: linux-2.6.6-rc2/include/linux/sunrpc/xdr.h
===================================================================
--- linux-2.6.6-rc2.orig/include/linux/sunrpc/xdr.h
+++ linux-2.6.6-rc2/include/linux/sunrpc/xdr.h
@@ -177,6 +177,19 @@ struct sockaddr;
 extern int xdr_sendpages(struct socket *, struct sockaddr *, int,
 		struct xdr_buf *, unsigned int, int);
 
+struct xdr_array2_desc;
+typedef int (*xdr_xcode_elem_t)(struct xdr_array2_desc *desc, void *elem);
+struct xdr_array2_desc {
+	unsigned int elem_size;
+	unsigned int array_len;
+	xdr_xcode_elem_t xcode;
+};
+
+extern int xdr_decode_array2(struct xdr_buf *buf, unsigned int base,
+                             struct xdr_array2_desc *desc);
+extern int xdr_encode_array2(struct xdr_buf *buf, unsigned int base,
+			     struct xdr_array2_desc *desc);
+
 /*
  * Provide some simple tools for XDR buffer overflow-checking etc.
  */
Index: linux-2.6.6-rc2/net/sunrpc/sunrpc_syms.c
===================================================================
--- linux-2.6.6-rc2.orig/net/sunrpc/sunrpc_syms.c
+++ linux-2.6.6-rc2/net/sunrpc/sunrpc_syms.c
@@ -135,6 +135,8 @@ EXPORT_SYMBOL(read_bytes_from_xdr_buf);
 EXPORT_SYMBOL(read_u32_from_xdr_buf);
 EXPORT_SYMBOL(write_bytes_to_xdr_buf);
 EXPORT_SYMBOL(write_u32_to_xdr_buf);
+EXPORT_SYMBOL(xdr_encode_array2);
+EXPORT_SYMBOL(xdr_decode_array2);
 
 /* Debugging symbols */
 #ifdef RPC_DEBUG
Index: linux-2.6.6-rc2/net/sunrpc/xdr.c
===================================================================
--- linux-2.6.6-rc2.orig/net/sunrpc/xdr.c
+++ linux-2.6.6-rc2/net/sunrpc/xdr.c
@@ -1085,3 +1085,194 @@ xdr_buf_read_netobj(struct xdr_buf *buf,
 out:
 	return -1;
 }
+
+/* Returns 0 on success, or else a negative error code. */
+static int
+xdr_xcode_array2(struct xdr_buf *buf, unsigned int base,
+		 struct xdr_array2_desc *desc, int encode)
+{
+	char elem[desc->elem_size], *c;
+	unsigned int copied = 0, todo, avail_here;
+	struct page **ppages = NULL;
+	int err = 0;
+
+	if (encode) {
+		if (write_u32_to_xdr_buf(buf, base, desc->array_len) != 0)
+			return -EINVAL;
+	} else {
+		if (read_u32_from_xdr_buf(buf, base, &desc->array_len) != 0 ||
+		    (unsigned long) base + 4 + desc->array_len *
+				    desc->elem_size > buf->len)
+			return -EINVAL;
+	}
+	base += 4;
+
+	if (!desc->xcode)
+		return 0;
+
+	todo = desc->array_len * desc->elem_size;
+	
+	/* process head */
+	if (todo && base < buf->head->iov_len) {
+		c = buf->head->iov_base + base;
+		avail_here = min_t(unsigned int, todo,
+				   buf->head->iov_len - base);
+		todo -= avail_here;
+
+		while (avail_here >= desc->elem_size) {
+			err = desc->xcode(desc, c);
+			if (err)
+				goto out;
+			c += desc->elem_size;
+			avail_here -= desc->elem_size;
+		}
+		if (avail_here) {
+			if (encode) {
+				err = desc->xcode(desc, elem);
+				if (err)
+					goto out;
+				memcpy(c, elem, avail_here);
+			} else
+				memcpy(elem, c, avail_here);
+			copied = avail_here;
+		}
+		base = buf->head->iov_len;  /* align to start of pages */
+	}
+
+	/* process pages array */
+	base -= buf->head->iov_len;
+	if (todo && base < buf->page_len) {
+		avail_here = min(todo, buf->page_len - base);
+		todo -= avail_here;
+
+		base += buf->page_base;
+		ppages = buf->pages + (base >> PAGE_CACHE_SHIFT);
+		base &= ~PAGE_CACHE_MASK;
+		unsigned int avail_page = min_t(unsigned int,
+			PAGE_CACHE_SIZE - base, avail_here);
+		c = kmap(*ppages) + base;
+
+		while (avail_here) {
+			avail_here -= avail_page;
+			if (copied || avail_page < desc->elem_size) {
+				unsigned int l = min(avail_page,
+					desc->elem_size - copied);
+				if (encode) {
+					if (!copied) {
+						err = desc->xcode(desc, elem);
+						if (err)
+							goto out;
+					}
+					memcpy(c, elem + copied, l);
+					copied += l;
+					if (copied == desc->elem_size)
+						copied = 0;
+				} else {
+					memcpy(elem + copied, c, l);
+					copied += l;
+					if (copied == desc->elem_size) {
+						err = desc->xcode(desc, elem);
+						if (err)
+							goto out;
+						copied = 0;
+					}
+				}
+				avail_page -= l;
+				c += l;
+			}
+			while (avail_page >= desc->elem_size) {
+				err = desc->xcode(desc, c);
+				if (err)
+					goto out;
+				c += desc->elem_size;
+				avail_page -= desc->elem_size;
+			}
+			if (avail_page) {
+				unsigned int l = min(avail_page,
+					    desc->elem_size - copied);
+				if (encode) {
+					if (!copied) {
+						err = desc->xcode(desc, elem);
+						if (err)
+							goto out;
+					}
+					memcpy(c, elem + copied, l);
+					copied += l;
+					if (copied == desc->elem_size)
+						copied = 0;
+				} else {
+					memcpy(elem + copied, c, l);
+					copied += l;
+					if (copied == desc->elem_size) {
+						err = desc->xcode(desc, elem);
+						if (err)
+							goto out;
+						copied = 0;
+					}
+				}
+			}
+			if (avail_here) {
+				kunmap(*ppages);
+				ppages++;
+				c = kmap(*ppages);
+			}
+
+			avail_page = min(avail_here,
+				 (unsigned int) PAGE_CACHE_SIZE);
+		}
+		base = buf->page_len;  /* align to start of tail */
+	}
+
+	/* process tail */
+	base -= buf->page_len;
+	if (todo) {
+		c = buf->tail->iov_base + base;
+		if (copied) {
+			unsigned int l = desc->elem_size - copied;
+
+			if (encode)
+				memcpy(c, elem + copied, l);
+			else {
+				memcpy(elem + copied, c, l);
+				err = desc->xcode(desc, elem);
+				if (err)
+					goto out;
+			}
+			todo -= l;
+			c += l;
+		}
+		while (todo) {
+			err = desc->xcode(desc, c);
+			if (err)
+				goto out;
+			c += desc->elem_size;
+			todo -= desc->elem_size;
+		}
+	}
+	
+out:
+	if (ppages)
+		kunmap(*ppages);
+	return err;
+}
+
+int
+xdr_decode_array2(struct xdr_buf *buf, unsigned int base,
+		  struct xdr_array2_desc *desc)
+{
+	if (base >= buf->len)
+		return -EINVAL;
+
+	return xdr_xcode_array2(buf, base, desc, 0);
+}
+
+int
+xdr_encode_array2(struct xdr_buf *buf, unsigned int base,
+		  struct xdr_array2_desc *desc)
+{
+	if ((unsigned long) base + 4 + desc->array_len * desc->elem_size >
+	    buf->head->iov_len + buf->page_len + buf->tail->iov_len)
+		return -EINVAL;
+
+	return xdr_xcode_array2(buf, base, desc, 1);
+}

