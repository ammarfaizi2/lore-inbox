Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264512AbUDZKcB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbUDZKcB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 06:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbUDZKbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 06:31:34 -0400
Received: from ns.suse.de ([195.135.220.2]:61141 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264490AbUDZK2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 06:28:52 -0400
Subject: [PATCH 6/11] nfsacl-lazy-alloc
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1082975192.3295.76.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 26 Apr 2004 12:28:48 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to allocate pages in the receive buffers lazily

Patch from Olaf Kirch <okir@suse.de>: Replies to the GETACL remote
procedure call can become quite big, yet in the common case replies will
be very small.  This patch checks of argument pages have already been
allocated, and allocates pages up to the maximum length of the xdr_buf
when this is not the case.

  Andreas Gruenbacher <agruen@suse.de>, SUSE Labs

Index: linux-2.6.6-rc2/include/linux/sunrpc/xdr.h
===================================================================
--- linux-2.6.6-rc2.orig/include/linux/sunrpc/xdr.h
+++ linux-2.6.6-rc2/include/linux/sunrpc/xdr.h
@@ -169,7 +169,7 @@ typedef struct {
 
 typedef size_t (*skb_read_actor_t)(skb_reader_t *desc, void *to, size_t len);
 
-extern void xdr_partial_copy_from_skb(struct xdr_buf *, unsigned int,
+extern int xdr_partial_copy_from_skb(struct xdr_buf *, unsigned int,
 		skb_reader_t *, skb_read_actor_t);
 
 struct socket;
Index: linux-2.6.6-rc2/net/sunrpc/xdr.c
===================================================================
--- linux-2.6.6-rc2.orig/net/sunrpc/xdr.c
+++ linux-2.6.6-rc2/net/sunrpc/xdr.c
@@ -303,7 +303,7 @@ void xdr_kunmap(struct xdr_buf *xdr, siz
 	}
 }
 
-void
+int
 xdr_partial_copy_from_skb(struct xdr_buf *xdr, unsigned int base,
 			  skb_reader_t *desc,
 			  skb_read_actor_t copy_actor)
@@ -317,7 +317,7 @@ xdr_partial_copy_from_skb(struct xdr_buf
 		len -= base;
 		ret = copy_actor(desc, (char *)xdr->head[0].iov_base + base, len);
 		if (ret != len || !desc->count)
-			return;
+			return 0;
 		base = 0;
 	} else
 		base -= len;
@@ -337,6 +337,13 @@ xdr_partial_copy_from_skb(struct xdr_buf
 	do {
 		char *kaddr;
 
+		/* ACL likes to be lazy in allocating pages - ACLs
+		 * are small by default but can get huge. */
+		if (unlikely(*ppage == NULL)) {
+			if (!(*ppage = alloc_page(GFP_ATOMIC)))
+				return -ENOMEM;
+		}
+
 		len = PAGE_CACHE_SIZE;
 		kaddr = kmap_atomic(*ppage, KM_SKB_SUNRPC_DATA);
 		if (base) {
@@ -353,13 +360,15 @@ xdr_partial_copy_from_skb(struct xdr_buf
 		flush_dcache_page(*ppage);
 		kunmap_atomic(kaddr, KM_SKB_SUNRPC_DATA);
 		if (ret != len || !desc->count)
-			return;
+			return 0;
 		ppage++;
 	} while ((pglen -= len) != 0);
 copy_tail:
 	len = xdr->tail[0].iov_len;
 	if (base < len)
 		copy_actor(desc, (char *)xdr->tail[0].iov_base + base, len - base);
+
+	return 0;
 }
 

Index: linux-2.6.6-rc2/net/sunrpc/xprt.c
===================================================================
--- linux-2.6.6-rc2.orig/net/sunrpc/xprt.c
+++ linux-2.6.6-rc2/net/sunrpc/xprt.c
@@ -693,7 +693,8 @@ csum_partial_copy_to_xdr(struct xdr_buf 
 		goto no_checksum;
 
 	desc.csum = csum_partial(skb->data, desc.offset, skb->csum);
-	xdr_partial_copy_from_skb(xdr, 0, &desc, skb_read_and_csum_bits);
+	if (xdr_partial_copy_from_skb(xdr, 0, &desc, skb_read_and_csum_bits) < 0)
+		return -1;
 	if (desc.offset != skb->len) {
 		unsigned int csum2;
 		csum2 = skb_checksum(skb, desc.offset, skb->len - desc.offset, 0);
@@ -705,7 +706,8 @@ csum_partial_copy_to_xdr(struct xdr_buf 
 		return -1;
 	return 0;
 no_checksum:
-	xdr_partial_copy_from_skb(xdr, 0, &desc, skb_read_bits);
+	if (xdr_partial_copy_from_skb(xdr, 0, &desc, skb_read_bits) < 0)
+		return -1;
 	if (desc.count)
 		return -1;
 	return 0;
@@ -872,6 +874,7 @@ tcp_read_request(struct rpc_xprt *xprt, 
 	struct rpc_rqst *req;
 	struct xdr_buf *rcvbuf;
 	size_t len;
+	int r;
 
 	/* Find and lock the request corresponding to this xid */
 	spin_lock(&xprt->sock_lock);
@@ -892,16 +895,30 @@ tcp_read_request(struct rpc_xprt *xprt, 
 		len = xprt->tcp_reclen - xprt->tcp_offset;
 		memcpy(&my_desc, desc, sizeof(my_desc));
 		my_desc.count = len;
-		xdr_partial_copy_from_skb(rcvbuf, xprt->tcp_copied,
-					  &my_desc, tcp_copy_data);
+		r = xdr_partial_copy_from_skb(rcvbuf, xprt->tcp_copied,
+					      &my_desc, tcp_copy_data);
 		desc->count -= len;
 		desc->offset += len;
 	} else
-		xdr_partial_copy_from_skb(rcvbuf, xprt->tcp_copied,
-					  desc, tcp_copy_data);
+		r = xdr_partial_copy_from_skb(rcvbuf, xprt->tcp_copied,
+					      desc, tcp_copy_data);
 	xprt->tcp_copied += len;
 	xprt->tcp_offset += len;
 
+	if (r < 0) {
+		/* Error when copying to the receive buffer,
+		 * usually because we weren't able to allocate
+		 * additional buffer pages. All we can do now
+		 * is turn off XPRT_COPY_DATA, so the request
+		 * will not receive any additional updates,
+		 * and time out.
+		 * Any remaining data from this record will
+		 * be discarded.
+		 */
+		xprt->tcp_flags &= ~XPRT_COPY_DATA;
+		goto out;
+	}
+
 	if (xprt->tcp_copied == req->rq_private_buf.buflen)
 		xprt->tcp_flags &= ~XPRT_COPY_DATA;
 	else if (xprt->tcp_offset == xprt->tcp_reclen) {
@@ -914,6 +931,7 @@ tcp_read_request(struct rpc_xprt *xprt, 
 				req->rq_task->tk_pid);
 		xprt_complete_rqst(xprt, req, xprt->tcp_copied);
 	}
+out:
 	spin_unlock(&xprt->sock_lock);
 	tcp_check_recm(xprt);
 }

