Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbSKGWjS>; Thu, 7 Nov 2002 17:39:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266623AbSKGWjS>; Thu, 7 Nov 2002 17:39:18 -0500
Received: from dexter.citi.umich.edu ([141.211.133.33]:14464 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S266622AbSKGWjQ>; Thu, 7 Nov 2002 17:39:16 -0500
Date: Thu, 7 Nov 2002 17:45:54 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] bug in NFSv2 end-of-file read handling
Message-ID: <Pine.LNX.4.44.0211071743550.18237-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NFSv2 doesn't pass connectathon 2002, at least on some Linux kernels.  
Trond deemed the following modification necessary in all kernels to
address the problem.  a similar patch will go to Marcelo for 2.4.21.


diff -ruN 06-setattr/fs/nfs/nfs2xdr.c 07-readeof/fs/nfs/nfs2xdr.c
--- 06-setattr/fs/nfs/nfs2xdr.c	Mon Nov  4 17:30:22 2002
+++ 07-readeof/fs/nfs/nfs2xdr.c	Thu Nov  7 17:33:01 2002
@@ -233,7 +233,6 @@
 static int
 nfs_xdr_readres(struct rpc_rqst *req, u32 *p, struct nfs_readres *res)
 {
-	struct xdr_buf *rcvbuf = &req->rq_rcv_buf;
 	struct iovec *iov = req->rq_rvec;
 	int	status, count, recvd, hdrlen;
 
@@ -243,11 +242,6 @@
 
 	count = ntohl(*p++);
 	res->eof = 0;
-	if (rcvbuf->page_len) {
-		u32 end = page_offset(rcvbuf->pages[0]) + rcvbuf->page_base + count;
-		if (end >= res->fattr->size)
-			res->eof = 1;
-	}
 	hdrlen = (u8 *) p - (u8 *) iov->iov_base;
 	if (iov->iov_len < hdrlen) {
 		printk(KERN_WARNING "NFS: READ reply header overflowed:"
@@ -263,7 +257,6 @@
 		printk(KERN_WARNING "NFS: server cheating in read reply: "
 			"count %d > recvd %d\n", count, recvd);
 		count = recvd;
-		res->eof = 0;
 	}
 
 	dprintk("RPC:      readres OK count %d\n", count);
diff -ruN 06-setattr/fs/nfs/read.c 07-readeof/fs/nfs/read.c
--- 06-setattr/fs/nfs/read.c	Mon Nov  4 17:30:03 2002
+++ 07-readeof/fs/nfs/read.c	Thu Nov  7 17:33:01 2002
@@ -355,11 +355,12 @@
 {
 	struct nfs_read_data	*data = (struct nfs_read_data *) task->tk_calldata;
 	struct inode		*inode = data->inode;
+	struct nfs_fattr	*fattr = &data->fattr;
 
 	dprintk("NFS: %4d nfs_readpage_result, (status %d)\n",
 		task->tk_pid, task->tk_status);
 
-	nfs_refresh_inode(inode, &data->fattr);
+	nfs_refresh_inode(inode, fattr);
 	while (!list_empty(&data->pages)) {
 		struct nfs_page *req = nfs_list_entry(data->pages.next);
 		struct page *page = req->wb_page;
@@ -368,13 +369,20 @@
 		if (task->tk_status >= 0) {
 			if (count < PAGE_CACHE_SIZE) {
 				char *p = kmap(page);
-				memset(p + count, 0, PAGE_CACHE_SIZE - count);
+
+				if (count < req->wb_bytes)
+					memset(p + req->wb_offset + count, 0,
+							req->wb_bytes - count);
 				kunmap(page);
-				count = 0;
-				if (eof)
+
+				if (eof ||
+				    ((fattr->valid & NFS_ATTR_FATTR) &&
+				     ((req_offset(req) + req->wb_offset + count) >= fattr->size)))
 					SetPageUptodate(page);
 				else
-					SetPageError(page);
+					if (count < req->wb_bytes)
+						SetPageError(page);
+				count = 0;
 			} else {
 				count -= PAGE_CACHE_SIZE;
 				SetPageUptodate(page);

