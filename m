Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267371AbSLRXLt>; Wed, 18 Dec 2002 18:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267374AbSLRXLs>; Wed, 18 Dec 2002 18:11:48 -0500
Received: from dexter.citi.umich.edu ([141.211.133.33]:1408 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S267371AbSLRXLo>; Wed, 18 Dec 2002 18:11:44 -0500
Date: Wed, 18 Dec 2002 18:19:43 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] use kmap_atomic instaed of kmap in NFS client
Message-ID: <Pine.LNX.4.44.0212181810570.1373-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
  andrew morton suggested there are places in the NFS client that could
  make use of kmap_atomic instead of vanilla kmap in order to improve
  scalability on 8-way and higher SMP systems.

Apply Against:
  2.5.52

Test status:
  Passes all Connectathon '02 tests with v2 and v3, UDP and TCP; passes
  NFS torture tests on a UP HIGHMEM x86 system.


diff -Naurp 00-stock/fs/nfs/dir.c 01-kmap_atomic/fs/nfs/dir.c
--- 00-stock/fs/nfs/dir.c	Sun Dec 15 21:07:57 2002
+++ 01-kmap_atomic/fs/nfs/dir.c	Wed Dec 18 17:22:06 2002
@@ -208,7 +208,7 @@ int find_dirent_page(nfs_readdir_descrip
 
 	/* NOTE: Someone else may have changed the READDIRPLUS flag */
 	desc->page = page;
-	desc->ptr = kmap(page);
+	desc->ptr = kmap(page);		/* matching kunmap in nfs_do_filldir */
 	status = find_dirent(desc, page);
 	if (status < 0)
 		dir_page_release(desc);
@@ -345,7 +345,7 @@ int uncached_readdir(nfs_readdir_descrip
 						NFS_SERVER(inode)->dtsize,
 						desc->plus);
 	desc->page = page;
-	desc->ptr = kmap(page);
+	desc->ptr = kmap(page);		/* matching kunmap in nfs_do_filldir */
 	if (desc->error >= 0) {
 		if ((status = dir_decode(desc)) == 0)
 			desc->entry->prev_cookie = desc->target;
@@ -717,9 +717,9 @@ int nfs_cached_lookup(struct inode *dir,
 
 		res = -EIO;
 		if (PageUptodate(page)) {
-			desc.ptr = kmap(page);
+			desc.ptr = kmap_atomic(page, KM_USER0);
 			res = find_dirent_name(&desc, page, dentry);
-			kunmap(page);
+			kunmap_atomic(desc.ptr, KM_USER0);
 		}
 		page_cache_release(page);
 
diff -Naurp 00-stock/fs/nfs/nfs2xdr.c 01-kmap_atomic/fs/nfs/nfs2xdr.c
--- 00-stock/fs/nfs/nfs2xdr.c	Sun Dec 15 21:07:53 2002
+++ 01-kmap_atomic/fs/nfs/nfs2xdr.c	Wed Dec 18 17:22:06 2002
@@ -378,7 +378,7 @@ nfs_xdr_readdirres(struct rpc_rqst *req,
 	int hdrlen, recvd;
 	int status, nr;
 	unsigned int len, pglen;
-	u32 *end, *entry;
+	u32 *end, *entry, *kaddr;
 
 	if ((status = ntohl(*p++)))
 		return -nfs_stat_to_errno(status);
@@ -398,7 +398,7 @@ nfs_xdr_readdirres(struct rpc_rqst *req,
 	if (pglen > recvd)
 		pglen = recvd;
 	page = rcvbuf->pages;
-	p = kmap(*page);
+	kaddr = p = (u32 *)kmap_atomic(*page, KM_USER0);
 	end = (u32 *)((char *)p + pglen);
 	entry = p;
 	for (nr = 0; *p++; nr++) {
@@ -419,7 +419,7 @@ nfs_xdr_readdirres(struct rpc_rqst *req,
 	if (!nr && (entry[0] != 0 || entry[1] == 0))
 		goto short_pkt;
  out:
-	kunmap(*page);
+	kunmap_atomic(kaddr, KM_USER0);
 	return nr;
  short_pkt:
 	entry[0] = entry[1] = 0;
@@ -430,8 +430,8 @@ nfs_xdr_readdirres(struct rpc_rqst *req,
 	}
 	goto out;
 err_unmap:
-	kunmap(*page);
-	return -errno_NFSERR_IO;
+	nr = -errno_NFSERR_IO;
+	goto out;
 }
 
 u32 *
@@ -542,7 +542,7 @@ nfs_xdr_readlinkres(struct rpc_rqst *req
 		xdr_shift_buf(rcvbuf, iov->iov_len - hdrlen);
 	}
 
-	strlen = (u32*)kmap(rcvbuf->pages[0]);
+	strlen = (u32*)kmap_atomic(rcvbuf->pages[0], KM_USER0);
 	/* Convert length of symlink */
 	len = ntohl(*strlen);
 	if (len > rcvbuf->page_len)
@@ -551,7 +551,7 @@ nfs_xdr_readlinkres(struct rpc_rqst *req
 	/* NULL terminate the string we got */
 	string = (char *)(strlen + 1);
 	string[len] = 0;
-	kunmap(rcvbuf->pages[0]);
+	kunmap_atomic(strlen, KM_USER0);
 	return 0;
 }
 
diff -Naurp 00-stock/fs/nfs/nfs3xdr.c 01-kmap_atomic/fs/nfs/nfs3xdr.c
--- 00-stock/fs/nfs/nfs3xdr.c	Sun Dec 15 21:08:24 2002
+++ 01-kmap_atomic/fs/nfs/nfs3xdr.c	Wed Dec 18 17:22:06 2002
@@ -488,7 +488,7 @@ nfs3_xdr_readdirres(struct rpc_rqst *req
 	int hdrlen, recvd;
 	int status, nr;
 	unsigned int len, pglen;
-	u32 *entry, *end;
+	u32 *entry, *end, *kaddr;
 
 	status = ntohl(*p++);
 	/* Decode post_op_attrs */
@@ -518,7 +518,7 @@ nfs3_xdr_readdirres(struct rpc_rqst *req
 	if (pglen > recvd)
 		pglen = recvd;
 	page = rcvbuf->pages;
-	p = kmap(*page);
+	kaddr = p = (u32 *)kmap_atomic(*page, KM_USER0);
 	end = (u32 *)((char *)p + pglen);
 	entry = p;
 	for (nr = 0; *p++; nr++) {
@@ -563,7 +563,7 @@ nfs3_xdr_readdirres(struct rpc_rqst *req
 	if (!nr && (entry[0] != 0 || entry[1] == 0))
 		goto short_pkt;
  out:
-	kunmap(*page);
+	kunmap_atomic(kaddr, KM_USER0);
 	return nr;
  short_pkt:
 	entry[0] = entry[1] = 0;
@@ -574,8 +574,8 @@ nfs3_xdr_readdirres(struct rpc_rqst *req
 	}
 	goto out;
 err_unmap:
-	kunmap(*page);
-	return -errno_NFSERR_IO;
+	nr = -errno_NFSERR_IO;
+	goto out;
 }
 
 u32 *
@@ -738,7 +738,7 @@ nfs3_xdr_readlinkres(struct rpc_rqst *re
 		xdr_shift_buf(rcvbuf, iov->iov_len - hdrlen);
 	}
 
-	strlen = (u32*)kmap(rcvbuf->pages[0]);
+	strlen = (u32*)kmap_atomic(rcvbuf->pages[0], KM_USER0);
 	/* Convert length of symlink */
 	len = ntohl(*strlen);
 	if (len > rcvbuf->page_len)
@@ -747,7 +747,7 @@ nfs3_xdr_readlinkres(struct rpc_rqst *re
 	/* NULL terminate the string we got */
 	string = (char *)(strlen + 1);
 	string[len] = 0;
-	kunmap(rcvbuf->pages[0]);
+	kunmap_atomic(strlen, KM_USER0);
 	return 0;
 }
 
diff -Naurp 00-stock/fs/nfs/nfs4proc.c 01-kmap_atomic/fs/nfs/nfs4proc.c
--- 00-stock/fs/nfs/nfs4proc.c	Sun Dec 15 21:08:14 2002
+++ 01-kmap_atomic/fs/nfs/nfs4proc.c	Wed Dec 18 17:22:06 2002
@@ -447,7 +447,7 @@ nfs4_setup_readdir(struct nfs4_compound 
 	 * when talking to the server, we always send cookie 0
 	 * instead of 1 or 2.
 	 */
-	start = p = (u32 *)kmap(*pages);
+	start = p = (u32 *)kmap_atomic(*pages, KM_USER0);
 	
 	if (cookie == 0) {
 		*p++ = xdr_one;                                  /* next */
@@ -475,7 +475,7 @@ nfs4_setup_readdir(struct nfs4_compound 
 
 	readdir->rd_pgbase = (char *)p - (char *)start;
 	readdir->rd_count -= readdir->rd_pgbase;
-	kunmap(*pages);
+	kunmap_atomic(start, KM_USER0);
 }
 
 static void
diff -Naurp 00-stock/fs/nfs/nfs4xdr.c 01-kmap_atomic/fs/nfs/nfs4xdr.c
--- 00-stock/fs/nfs/nfs4xdr.c	Sun Dec 15 21:08:24 2002
+++ 01-kmap_atomic/fs/nfs/nfs4xdr.c	Wed Dec 18 17:31:28 2002
@@ -1410,7 +1410,7 @@ decode_readdir(struct xdr_stream *xdr, s
 	struct page	*page = *rcvbuf->pages;
 	struct iovec	*iov = rcvbuf->head;
 	unsigned int	nr, pglen = rcvbuf->page_len;
-	uint32_t	*end, *entry, *p;
+	uint32_t	*end, *entry, *p, *kaddr;
 	uint32_t	len, attrlen, word;
 	int 		i, hdrlen, recvd, status;
 
@@ -1434,7 +1434,7 @@ decode_readdir(struct xdr_stream *xdr, s
 		pglen = recvd;
 
 	BUG_ON(pglen + readdir->rd_pgbase > PAGE_CACHE_SIZE);
-	p   = (uint32_t *) kmap(page);
+	kaddr = p = (uint32_t *) kmap_atomic(page, KM_USER0);
 	end = (uint32_t *) ((char *)p + pglen + readdir->rd_pgbase);
 	entry = p;
 	for (nr = 0; *p++; nr++) {
@@ -1480,7 +1480,7 @@ decode_readdir(struct xdr_stream *xdr, s
 	if (!nr && (entry[0] != 0 || entry[1] == 0))
 		goto short_pkt;
 out:	
-	kunmap(page);
+	kunmap_atomic(kaddr, KM_USER0);
 	return 0;
 short_pkt:
 	entry[0] = entry[1] = 0;
@@ -1491,7 +1491,7 @@ short_pkt:
 	}
 	goto out;
 err_unmap:
-	kunmap(page);
+	kunmap_atomic(kaddr, KM_USER0);
 	return -errno_NFSERR_IO;
 }
 
@@ -1522,18 +1522,18 @@ decode_readlink(struct xdr_stream *xdr, 
 	 * and and null-terminate the text (the VFS expects
 	 * null-termination).
 	 */
-	strlen = (uint32_t *) kmap(rcvbuf->pages[0]);
+	strlen = (uint32_t *) kmap_atomic(rcvbuf->pages[0], KM_USER0);
 	len = ntohl(*strlen);
 	if (len > PAGE_CACHE_SIZE - 5) {
 		printk(KERN_WARNING "nfs: server returned giant symlink!\n");
-		kunmap(rcvbuf->pages[0]);
+		kunmap_atomic(strlen, KM_USER0);
 		return -EIO;
 	}
 	*strlen = len;
 
 	string = (char *)(strlen + 1);
 	string[len] = '\0';
-	kunmap(rcvbuf->pages[0]);
+	kunmap_atomic(strlen, KM_USER0);
 	return 0;
 }
 
diff -Naurp 00-stock/fs/nfs/read.c 01-kmap_atomic/fs/nfs/read.c
--- 00-stock/fs/nfs/read.c	Sun Dec 15 21:07:42 2002
+++ 01-kmap_atomic/fs/nfs/read.c	Wed Dec 18 17:22:06 2002
@@ -118,12 +118,8 @@ nfs_readpage_sync(struct file *file, str
 			break;
 	} while (count);
 
-	if (count) {
-		char *kaddr = kmap(page);
-		memset(kaddr + offset, 0, count);
-		kunmap(page);
-	}
-	flush_dcache_page(page);
+	if (count)
+		memclear_highpage_flush(page, offset, count);
 	SetPageUptodate(page);
 	if (PageError(page))
 		ClearPageError(page);
@@ -272,12 +268,9 @@ nfs_readpage_result(struct rpc_task *tas
 
 		if (task->tk_status >= 0) {
 			if (count < PAGE_CACHE_SIZE) {
-				char *p = kmap(page);
-
-				if (count < req->wb_bytes)
-					memset(p + req->wb_offset + count, 0,
+				memclear_highpage_flush(page,
+							req->wb_offset + count,
 							req->wb_bytes - count);
-				kunmap(page);
 
 				if (eof ||
 				    ((fattr->valid & NFS_ATTR_FATTR) &&
@@ -293,7 +286,6 @@ nfs_readpage_result(struct rpc_task *tas
 			}
 		} else
 			SetPageError(page);
-		flush_dcache_page(page);
 		unlock_page(page);
 
 		dprintk("NFS: read (%s/%Ld %d@%Ld)\n",
diff -Naurp 00-stock/net/sunrpc/xdr.c 01-kmap_atomic/net/sunrpc/xdr.c
--- 00-stock/net/sunrpc/xdr.c	Sun Dec 15 21:08:13 2002
+++ 01-kmap_atomic/net/sunrpc/xdr.c	Wed Dec 18 17:22:06 2002
@@ -306,6 +306,7 @@ xdr_partial_copy_from_skb(struct xdr_buf
 				len = pglen;
 			ret = copy_actor(desc, kaddr, len);
 		}
+		flush_dcache_page(*ppage);
 		kunmap_atomic(kaddr, KM_SKB_SUNRPC_DATA);
 		if (ret != len || !desc->count)
 			return;

