Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbVB0Rog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVB0Rog (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 12:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVB0RoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 12:44:07 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:13219 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261465AbVB0RXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 12:23:05 -0500
Message-Id: <20050227170314.033611000@blunzn.suse.de>
References: <20050227165954.566746000@blunzn.suse.de>
Date: Sun, 27 Feb 2005 18:00:02 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Andrew Morton <akpm@osdl.org>
Subject: [nfsacl v2 08/16] Encode and decode arbitrary XDR arrays
Content-Disposition: inline; filename=nfsacl-encode-and-decode-arbitrary-xdr-arrays.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add xdr_encode_array2 and xdr_decode_array2 functions for encoding end
decoding arrays with arbitrary entries, such as acl entries.  The goal here is
to do this without allocating a contiguous temporary buffer.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
Acked-by: Olaf Kirch <okir@suse.de>

Index: linux-2.6.11-rc5/include/linux/sunrpc/xdr.h
===================================================================
--- linux-2.6.11-rc5.orig/include/linux/sunrpc/xdr.h
+++ linux-2.6.11-rc5/include/linux/sunrpc/xdr.h
@@ -146,7 +146,8 @@ extern void xdr_shift_buf(struct xdr_buf
 extern void xdr_buf_from_iov(struct kvec *, struct xdr_buf *);
 extern int xdr_buf_subsegment(struct xdr_buf *, struct xdr_buf *, int, int);
 extern int xdr_buf_read_netobj(struct xdr_buf *, struct xdr_netobj *, int);
-extern int read_bytes_from_xdr_buf(struct xdr_buf *buf, int base, void *obj, int len);
+extern int read_bytes_from_xdr_buf(struct xdr_buf *, int, void *, int);
+extern int write_bytes_to_xdr_buf(struct xdr_buf *, int, void *, int);
 
 /*
  * Helper structure for copying from an sk_buff.
@@ -168,6 +169,22 @@ struct sockaddr;
 extern int xdr_sendpages(struct socket *, struct sockaddr *, int,
 		struct xdr_buf *, unsigned int, int);
 
+extern int xdr_encode_word(struct xdr_buf *, int, u32);
+extern int xdr_decode_word(struct xdr_buf *, int, u32 *);
+
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
Index: linux-2.6.11-rc5/net/sunrpc/sunrpc_syms.c
===================================================================
--- linux-2.6.11-rc5.orig/net/sunrpc/sunrpc_syms.c
+++ linux-2.6.11-rc5/net/sunrpc/sunrpc_syms.c
@@ -129,6 +129,10 @@ EXPORT_SYMBOL(xdr_encode_netobj);
 EXPORT_SYMBOL(xdr_encode_pages);
 EXPORT_SYMBOL(xdr_inline_pages);
 EXPORT_SYMBOL(xdr_shift_buf);
+EXPORT_SYMBOL(xdr_encode_word);
+EXPORT_SYMBOL(xdr_decode_word);
+EXPORT_SYMBOL(xdr_encode_array2);
+EXPORT_SYMBOL(xdr_decode_array2);
 EXPORT_SYMBOL(xdr_buf_from_iov);
 EXPORT_SYMBOL(xdr_buf_subsegment);
 EXPORT_SYMBOL(xdr_buf_read_netobj);
Index: linux-2.6.11-rc5/net/sunrpc/xdr.c
===================================================================
--- linux-2.6.11-rc5.orig/net/sunrpc/xdr.c
+++ linux-2.6.11-rc5/net/sunrpc/xdr.c
@@ -868,8 +868,34 @@ out:
 	return status;
 }
 
-static int
-read_u32_from_xdr_buf(struct xdr_buf *buf, int base, u32 *obj)
+/* obj is assumed to point to allocated memory of size at least len: */
+int
+write_bytes_to_xdr_buf(struct xdr_buf *buf, int base, void *obj, int len)
+{
+	struct xdr_buf subbuf;
+	int this_len;
+	int status;
+
+	status = xdr_buf_subsegment(buf, &subbuf, base, len);
+	if (status)
+		goto out;
+	this_len = min(len, (int)subbuf.head[0].iov_len);
+	memcpy(subbuf.head[0].iov_base, obj, this_len);
+	len -= this_len;
+	obj += this_len;
+	this_len = min(len, (int)subbuf.page_len);
+	if (this_len)
+		_copy_to_pages(subbuf.pages, subbuf.page_base, obj, this_len);
+	len -= this_len;
+	obj += this_len;
+	this_len = min(len, (int)subbuf.tail[0].iov_len);
+	memcpy(subbuf.tail[0].iov_base, obj, this_len);
+out:
+	return status;
+}
+
+int
+xdr_decode_word(struct xdr_buf *buf, int base, u32 *obj)
 {
 	u32	raw;
 	int	status;
@@ -881,6 +907,14 @@ read_u32_from_xdr_buf(struct xdr_buf *bu
 	return 0;
 }
 
+int
+xdr_encode_word(struct xdr_buf *buf, int base, u32 obj)
+{
+	u32	raw = htonl(obj);
+
+	return write_bytes_to_xdr_buf(buf, base, &raw, sizeof(obj));
+}
+
 /* If the netobj starting offset bytes from the start of xdr_buf is contained
  * entirely in the head or the tail, set object to point to it; otherwise
  * try to find space for it at the end of the tail, copy it there, and
@@ -891,7 +925,7 @@ xdr_buf_read_netobj(struct xdr_buf *buf,
 	u32	tail_offset = buf->head[0].iov_len + buf->page_len;
 	u32	obj_end_offset;
 
-	if (read_u32_from_xdr_buf(buf, offset, &obj->len))
+	if (xdr_decode_word(buf, offset, &obj->len))
 		goto out;
 	obj_end_offset = offset + 4 + obj->len;
 
@@ -924,3 +958,219 @@ xdr_buf_read_netobj(struct xdr_buf *buf,
 out:
 	return -1;
 }
+
+/* Returns 0 on success, or else a negative error code. */
+static int
+xdr_xcode_array2(struct xdr_buf *buf, unsigned int base,
+		 struct xdr_array2_desc *desc, int encode)
+{
+	char *elem = NULL, *c;
+	unsigned int copied = 0, todo, avail_here;
+	struct page **ppages = NULL;
+	int err;
+
+	if (encode) {
+		if (xdr_encode_word(buf, base, desc->array_len) != 0)
+			return -EINVAL;
+	} else {
+		if (xdr_decode_word(buf, base, &desc->array_len) != 0 ||
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
+			if (!elem) {
+				elem = kmalloc(desc->elem_size, GFP_KERNEL);
+				err = -ENOMEM;
+				if (!elem)
+					goto out;
+			}
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
+		unsigned int avail_page;
+
+		avail_here = min(todo, buf->page_len - base);
+		todo -= avail_here;
+
+		base += buf->page_base;
+		ppages = buf->pages + (base >> PAGE_CACHE_SHIFT);
+		base &= ~PAGE_CACHE_MASK;
+		avail_page = min_t(unsigned int, PAGE_CACHE_SIZE - base,
+					avail_here);
+		c = kmap(*ppages) + base;
+
+		while (avail_here) {
+			avail_here -= avail_page;
+			if (copied || avail_page < desc->elem_size) {
+				unsigned int l = min(avail_page,
+					desc->elem_size - copied);
+				if (!elem) {
+					elem = kmalloc(desc->elem_size,
+						       GFP_KERNEL);
+					err = -ENOMEM;
+					if (!elem)
+						goto out;
+				}
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
+				if (!elem) {
+					elem = kmalloc(desc->elem_size,
+						       GFP_KERNEL);
+					err = -ENOMEM;
+					if (!elem)
+						goto out;
+				}
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
+	err = 0;
+
+out:
+	if (elem)
+		kfree(elem);
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

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

