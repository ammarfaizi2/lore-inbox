Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319170AbSHTPuX>; Tue, 20 Aug 2002 11:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319171AbSHTPuX>; Tue, 20 Aug 2002 11:50:23 -0400
Received: from pat.uio.no ([129.240.130.16]:57006 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S319170AbSHTPuV>;
	Tue, 20 Aug 2002 11:50:21 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15714.26159.193042.740338@charged.uio.no>
Date: Tue, 20 Aug 2002 17:54:23 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Improve NFS READ reply sanity checking
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  - Fix the check for whether or not the received message length has
    somehow been truncated: we need to use req->rq_received rather
    than the receive buffer length (req->rq_rlen).
  - Ensure that we set res->eof correctly. In particular, we need to
    clear it if we find ourselves attempting to recover from a
    truncated READ.
  - Don't set PageUptodate() on those pages that are the victim of
    message truncation.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.31/fs/nfs/nfs2xdr.c linux-2.5.31-fix_read/fs/nfs/nfs2xdr.c
--- linux-2.5.31/fs/nfs/nfs2xdr.c	Wed Jul 31 17:35:17 2002
+++ linux-2.5.31-fix_read/fs/nfs/nfs2xdr.c	Tue Aug 20 17:10:08 2002
@@ -233,6 +233,7 @@
 static int
 nfs_xdr_readres(struct rpc_rqst *req, u32 *p, struct nfs_readres *res)
 {
+	struct xdr_buf *rcvbuf = &req->rq_rcv_buf;
 	struct iovec *iov = req->rq_rvec;
 	int	status, count, recvd, hdrlen;
 
@@ -241,25 +242,33 @@
 	p = xdr_decode_fattr(p, res->fattr);
 
 	count = ntohl(*p++);
+	res->eof = 0;
+	if (rcvbuf->page_len) {
+		u32 end = page_offset(rcvbuf->pages[0]) + rcvbuf->page_base + count;
+		if (end >= res->fattr->size)
+			res->eof = 1;
+	}
 	hdrlen = (u8 *) p - (u8 *) iov->iov_base;
-	if (iov->iov_len > hdrlen) {
+	if (iov->iov_len < hdrlen) {
+		printk(KERN_WARNING "NFS: READ reply header overflowed:"
+				"length %d > %d\n", hdrlen, iov->iov_len);
+		return -errno_NFSERR_IO;
+	} else if (iov->iov_len != hdrlen) {
 		dprintk("NFS: READ header is short. iovec will be shifted.\n");
 		xdr_shift_buf(&req->rq_rcv_buf, iov->iov_len - hdrlen);
 	}
 
-	recvd = req->rq_rlen - hdrlen;
+	recvd = req->rq_received - hdrlen;
 	if (count > recvd) {
 		printk(KERN_WARNING "NFS: server cheating in read reply: "
 			"count %d > recvd %d\n", count, recvd);
 		count = recvd;
+		res->eof = 0;
 	}
 
 	dprintk("RPC:      readres OK count %d\n", count);
-	if (count < res->count) {
+	if (count < res->count)
 		res->count = count;
-		res->eof = 1;  /* Silly NFSv3ism which can't be helped */
-	} else
-		res->eof = 0;
 
 	return count;
 }
diff -u --recursive --new-file linux-2.5.31/fs/nfs/nfs3xdr.c linux-2.5.31-fix_read/fs/nfs/nfs3xdr.c
--- linux-2.5.31/fs/nfs/nfs3xdr.c	Wed Jul 31 17:31:30 2002
+++ linux-2.5.31-fix_read/fs/nfs/nfs3xdr.c	Tue Aug 20 17:10:08 2002
@@ -793,16 +793,21 @@
 	}
 
 	hdrlen = (u8 *) p - (u8 *) iov->iov_base;
-	if (iov->iov_len > hdrlen) {
+	if (iov->iov_len < hdrlen) {
+		printk(KERN_WARNING "NFS: READ reply header overflowed:"
+				"length %d > %d\n", hdrlen, iov->iov_len);
+       		return -errno_NFSERR_IO;
+	} else if (iov->iov_len != hdrlen) {
 		dprintk("NFS: READ header is short. iovec will be shifted.\n");
 		xdr_shift_buf(&req->rq_rcv_buf, iov->iov_len - hdrlen);
 	}
 
-	recvd = req->rq_rlen - hdrlen;
+	recvd = req->rq_received - hdrlen;
 	if (count > recvd) {
 		printk(KERN_WARNING "NFS: server cheating in read reply: "
 			"count %d > recvd %d\n", count, recvd);
 		count = recvd;
+		res->eof = 0;
 	}
 
 	if (count < res->count)
diff -u --recursive --new-file linux-2.5.31/fs/nfs/read.c linux-2.5.31-fix_read/fs/nfs/read.c
--- linux-2.5.31/fs/nfs/read.c	Thu May 23 17:10:17 2002
+++ linux-2.5.31-fix_read/fs/nfs/read.c	Tue Aug 20 17:10:08 2002
@@ -424,9 +424,14 @@
 				memset(p + count, 0, PAGE_CACHE_SIZE - count);
 				kunmap(page);
 				count = 0;
-			} else
+				if (data->res.eof)
+					SetPageUptodate(page);
+				else
+					SetPageError(page);
+			} else {
 				count -= PAGE_CACHE_SIZE;
-			SetPageUptodate(page);
+				SetPageUptodate(page);
+			}
 		} else
 			SetPageError(page);
 		flush_dcache_page(page);
