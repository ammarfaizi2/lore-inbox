Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbUL1XEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbUL1XEc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 18:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbUL1XEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 18:04:32 -0500
Received: from holomorphy.com ([207.189.100.168]:17120 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261152AbUL1XES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 18:04:18 -0500
Date: Tue, 28 Dec 2004 15:04:16 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: davem@davemloft.net
Subject: [sunrpc] remove xdr_kmap()
Message-ID: <20041228230416.GM771@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was auditing nfs for missing flush_dcache_page() calls. They appear
to be done almost nowhere in nfs and so likely nowhere near enough, and
that makes nfs one of the primary suspects for breaking various machines
I have.

In this process, I stumbled over a blatant kmap() deadlock in
xdr_kmap(), which fortunately is never called.

This patch removes these dangerous nowhere-called functions.
vs. 2.6.10-bk1


-- wli


Index: wli-2.6.10-bk1/include/linux/sunrpc/xdr.h
===================================================================
--- wli-2.6.10-bk1.orig/include/linux/sunrpc/xdr.h	2004-08-13 22:38:10.000000000 -0700
+++ wli-2.6.10-bk1/include/linux/sunrpc/xdr.h	2004-12-28 14:27:16.000000000 -0800
@@ -145,8 +145,6 @@
 /*
  * XDR buffer helper functions
  */
-extern int xdr_kmap(struct kvec *, struct xdr_buf *, size_t);
-extern void xdr_kunmap(struct xdr_buf *, size_t);
 extern void xdr_shift_buf(struct xdr_buf *, size_t);
 extern void _copy_from_pages(char *, struct page **, size_t, size_t);
 extern void xdr_buf_from_iov(struct kvec *, struct xdr_buf *);
Index: wli-2.6.10-bk1/net/sunrpc/xdr.c
===================================================================
--- wli-2.6.10-bk1.orig/net/sunrpc/xdr.c	2004-08-13 22:37:26.000000000 -0700
+++ wli-2.6.10-bk1/net/sunrpc/xdr.c	2004-12-28 14:27:16.000000000 -0800
@@ -216,93 +216,6 @@
 	}
 }
 
-/*
- * Map a struct xdr_buf into an kvec array.
- */
-int xdr_kmap(struct kvec *iov_base, struct xdr_buf *xdr, size_t base)
-{
-	struct kvec	*iov = iov_base;
-	struct page	**ppage = xdr->pages;
-	unsigned int	len, pglen = xdr->page_len;
-
-	len = xdr->head[0].iov_len;
-	if (base < len) {
-		iov->iov_len = len - base;
-		iov->iov_base = (char *)xdr->head[0].iov_base + base;
-		iov++;
-		base = 0;
-	} else
-		base -= len;
-
-	if (pglen == 0)
-		goto map_tail;
-	if (base >= pglen) {
-		base -= pglen;
-		goto map_tail;
-	}
-	if (base || xdr->page_base) {
-		pglen -= base;
-		base  += xdr->page_base;
-		ppage += base >> PAGE_CACHE_SHIFT;
-		base &= ~PAGE_CACHE_MASK;
-	}
-	do {
-		len = PAGE_CACHE_SIZE;
-		iov->iov_base = kmap(*ppage);
-		if (base) {
-			iov->iov_base += base;
-			len -= base;
-			base = 0;
-		}
-		if (pglen < len)
-			len = pglen;
-		iov->iov_len = len;
-		iov++;
-		ppage++;
-	} while ((pglen -= len) != 0);
-map_tail:
-	if (xdr->tail[0].iov_len) {
-		iov->iov_len = xdr->tail[0].iov_len - base;
-		iov->iov_base = (char *)xdr->tail[0].iov_base + base;
-		iov++;
-	}
-	return (iov - iov_base);
-}
-
-void xdr_kunmap(struct xdr_buf *xdr, size_t base)
-{
-	struct page	**ppage = xdr->pages;
-	unsigned int	pglen = xdr->page_len;
-
-	if (!pglen)
-		return;
-	if (base > xdr->head[0].iov_len)
-		base -= xdr->head[0].iov_len;
-	else
-		base = 0;
-
-	if (base >= pglen)
-		return;
-	if (base || xdr->page_base) {
-		pglen -= base;
-		base  += xdr->page_base;
-		ppage += base >> PAGE_CACHE_SHIFT;
-		/* Note: The offset means that the length of the first
-		 * page is really (PAGE_CACHE_SIZE - (base & ~PAGE_CACHE_MASK)).
-		 * In order to avoid an extra test inside the loop,
-		 * we bump pglen here, and just subtract PAGE_CACHE_SIZE... */
-		pglen += base & ~PAGE_CACHE_MASK;
-	}
-	for (;;) {
-		flush_dcache_page(*ppage);
-		kunmap(*ppage);
-		if (pglen <= PAGE_CACHE_SIZE)
-			break;
-		pglen -= PAGE_CACHE_SIZE;
-		ppage++;
-	}
-}
-
 void
 xdr_partial_copy_from_skb(struct xdr_buf *xdr, unsigned int base,
 			  skb_reader_t *desc,
