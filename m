Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262749AbVAVUtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262749AbVAVUtR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 15:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbVAVUs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 15:48:57 -0500
Received: from cantor.suse.de ([195.135.220.2]:49104 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262738AbVAVUeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 15:34:31 -0500
Message-Id: <20050122203619.464746000@blunzn.suse.de>
References: <20050122203326.402087000@blunzn.suse.de>
Date: Sat, 22 Jan 2005 21:34:06 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Olaf Kirch <okir@suse.de>, "Andries E. Brouwer" <Andries.Brouwer@cwi.nl>,
       Buck Huppmann <buchk@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch 6/13] Lazy RPC receive buffer allocation
Content-Disposition: inline; filename=patches.suse/nfsacl-lazy-alloc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to allocate pages in the receive buffer lazily. Used for the
GETACL RPC, which has a big maximum reply size, but a small average
reply size.

Signed-off-by: Olaf Kirch <okir@suse.de>
Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.11-rc2/include/linux/sunrpc/xdr.h
===================================================================
--- linux-2.6.11-rc2.orig/include/linux/sunrpc/xdr.h
+++ linux-2.6.11-rc2/include/linux/sunrpc/xdr.h
@@ -160,7 +160,7 @@ typedef struct {
 
 typedef size_t (*skb_read_actor_t)(skb_reader_t *desc, void *to, size_t len);
 
-extern void xdr_partial_copy_from_skb(struct xdr_buf *, unsigned int,
+extern int xdr_partial_copy_from_skb(struct xdr_buf *, unsigned int,
 		skb_reader_t *, skb_read_actor_t);
 
 struct socket;
Index: linux-2.6.11-rc2/net/sunrpc/xdr.c
===================================================================
--- linux-2.6.11-rc2.orig/net/sunrpc/xdr.c
+++ linux-2.6.11-rc2/net/sunrpc/xdr.c
@@ -176,7 +176,7 @@ xdr_inline_pages(struct xdr_buf *xdr, un
 	xdr->buflen += len;
 }
 
-void
+int
 xdr_partial_copy_from_skb(struct xdr_buf *xdr, unsigned int base,
 			  skb_reader_t *desc,
 			  skb_read_actor_t copy_actor)
@@ -190,7 +190,7 @@ xdr_partial_copy_from_skb(struct xdr_buf
 		len -= base;
 		ret = copy_actor(desc, (char *)xdr->head[0].iov_base + base, len);
 		if (ret != len || !desc->count)
-			return;
+			return 0;
 		base = 0;
 	} else
 		base -= len;
@@ -210,6 +210,13 @@ xdr_partial_copy_from_skb(struct xdr_buf
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
@@ -226,13 +233,15 @@ xdr_partial_copy_from_skb(struct xdr_buf
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
 
 
Index: linux-2.6.11-rc2/net/sunrpc/xprt.c
===================================================================
--- linux-2.6.11-rc2.orig/net/sunrpc/xprt.c
+++ linux-2.6.11-rc2/net/sunrpc/xprt.c
@@ -725,7 +725,8 @@ csum_partial_copy_to_xdr(struct xdr_buf 
 		goto no_checksum;
 
 	desc.csum = csum_partial(skb->data, desc.offset, skb->csum);
-	xdr_partial_copy_from_skb(xdr, 0, &desc, skb_read_and_csum_bits);
+	if (xdr_partial_copy_from_skb(xdr, 0, &desc, skb_read_and_csum_bits) < 0)
+		return -1;
 	if (desc.offset != skb->len) {
 		unsigned int csum2;
 		csum2 = skb_checksum(skb, desc.offset, skb->len - desc.offset, 0);
@@ -737,7 +738,8 @@ csum_partial_copy_to_xdr(struct xdr_buf 
 		return -1;
 	return 0;
 no_checksum:
-	xdr_partial_copy_from_skb(xdr, 0, &desc, skb_read_bits);
+	if (xdr_partial_copy_from_skb(xdr, 0, &desc, skb_read_bits) < 0)
+		return -1;
 	if (desc.count)
 		return -1;
 	return 0;
@@ -907,6 +909,7 @@ tcp_read_request(struct rpc_xprt *xprt, 
 	struct rpc_rqst *req;
 	struct xdr_buf *rcvbuf;
 	size_t len;
+	int r;
 
 	/* Find and lock the request corresponding to this xid */
 	spin_lock(&xprt->sock_lock);
@@ -927,16 +930,30 @@ tcp_read_request(struct rpc_xprt *xprt, 
 		len = xprt->tcp_reclen - xprt->tcp_offset;
 		memcpy(&my_desc, desc, sizeof(my_desc));
 		my_desc.count = len;
-		xdr_partial_copy_from_skb(rcvbuf, xprt->tcp_copied,
+		r = xdr_partial_copy_from_skb(rcvbuf, xprt->tcp_copied,
 					  &my_desc, tcp_copy_data);
 		desc->count -= len;
 		desc->offset += len;
 	} else
-		xdr_partial_copy_from_skb(rcvbuf, xprt->tcp_copied,
+		r = xdr_partial_copy_from_skb(rcvbuf, xprt->tcp_copied,
 					  desc, tcp_copy_data);
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
@@ -949,6 +966,7 @@ tcp_read_request(struct rpc_xprt *xprt, 
 				req->rq_task->tk_pid);
 		xprt_complete_rqst(xprt, req, xprt->tcp_copied);
 	}
+out:
 	spin_unlock(&xprt->sock_lock);
 	tcp_check_recm(xprt);
 }

--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

