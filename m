Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbSKRVnu>; Mon, 18 Nov 2002 16:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbSKRVnu>; Mon, 18 Nov 2002 16:43:50 -0500
Received: from dexter.citi.umich.edu ([141.211.133.33]:1152 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S264919AbSKRVnm>; Mon, 18 Nov 2002 16:43:42 -0500
Date: Mon, 18 Nov 2002 16:50:40 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] use kmap_atomic instaed of kmap in NFS client
Message-ID: <Pine.LNX.4.44.0211181648430.1518-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andrew morton suggested there are places in the NFS client that could make 
use of kmap_atomic instead of vanilla kmap in order to improve scalability 
on 8-way and higher SMP systems.

against 2.5.48.


diff -ruN 00-stock/fs/nfs/dir.c 01-kmap_atomic/fs/nfs/dir.c
--- 00-stock/fs/nfs/dir.c	Sun Nov 17 23:29:45 2002
+++ 01-kmap_atomic/fs/nfs/dir.c	Mon Nov 18 11:43:24 2002
@@ -208,7 +208,7 @@
 
 	/* NOTE: Someone else may have changed the READDIRPLUS flag */
 	desc->page = page;
-	desc->ptr = kmap(page);
+	desc->ptr = kmap(page);		/* matching kunmap in nfs_do_filldir */
 	status = find_dirent(desc, page);
 	if (status < 0)
 		dir_page_release(desc);
@@ -345,7 +345,7 @@
 						NFS_SERVER(inode)->dtsize,
 						desc->plus);
 	desc->page = page;
-	desc->ptr = kmap(page);
+	desc->ptr = kmap(page);		/* matching kunmap in nfs_do_filldir */
 	if (desc->error >= 0) {
 		if ((status = dir_decode(desc)) == 0)
 			desc->entry->prev_cookie = desc->target;
@@ -717,9 +717,9 @@
 
 		res = -EIO;
 		if (PageUptodate(page)) {
-			desc.ptr = kmap(page);
+			desc.ptr = kmap_atomic(page, KM_USER0);
 			res = find_dirent_name(&desc, page, dentry);
-			kunmap(page);
+			kunmap_atomic(desc.ptr, KM_USER0);
 		}
 		page_cache_release(page);
 
diff -ruN 00-stock/fs/nfs/nfs2xdr.c 01-kmap_atomic/fs/nfs/nfs2xdr.c
--- 00-stock/fs/nfs/nfs2xdr.c	Sun Nov 17 23:29:31 2002
+++ 01-kmap_atomic/fs/nfs/nfs2xdr.c	Mon Nov 18 11:43:24 2002
@@ -370,7 +370,7 @@
 	int hdrlen, recvd;
 	int status, nr;
 	unsigned int len, pglen;
-	u32 *end, *entry;
+	u32 *end, *entry, *kaddr;
 
 	if ((status = ntohl(*p++)))
 		return -nfs_stat_to_errno(status);
@@ -390,7 +390,7 @@
 	if (pglen > recvd)
 		pglen = recvd;
 	page = rcvbuf->pages;
-	p = kmap(*page);
+	kaddr = p = (u32 *)kmap_atomic(*page, KM_USER0);
 	end = (u32 *)((char *)p + pglen);
 	entry = p;
 	for (nr = 0; *p++; nr++) {
@@ -411,7 +411,7 @@
 	if (!nr && (entry[0] != 0 || entry[1] == 0))
 		goto short_pkt;
  out:
-	kunmap(*page);
+	kunmap_atomic(kaddr, KM_USER0);
 	return nr;
  short_pkt:
 	entry[0] = entry[1] = 0;
@@ -422,8 +422,8 @@
 	}
 	goto out;
 err_unmap:
-	kunmap(*page);
-	return -errno_NFSERR_IO;
+	nr = -errno_NFSERR_IO;
+	goto out;
 }
 
 u32 *
@@ -534,7 +534,7 @@
 		xdr_shift_buf(rcvbuf, iov->iov_len - hdrlen);
 	}
 
-	strlen = (u32*)kmap(rcvbuf->pages[0]);
+	strlen = (u32*)kmap_atomic(rcvbuf->pages[0], KM_USER0);
 	/* Convert length of symlink */
 	len = ntohl(*strlen);
 	if (len > rcvbuf->page_len)
@@ -543,7 +543,7 @@
 	/* NULL terminate the string we got */
 	string = (char *)(strlen + 1);
 	string[len] = 0;
-	kunmap(rcvbuf->pages[0]);
+	kunmap_atomic(strlen, KM_USER0);
 	return 0;
 }
 
diff -ruN 00-stock/fs/nfs/nfs3xdr.c 01-kmap_atomic/fs/nfs/nfs3xdr.c
--- 00-stock/fs/nfs/nfs3xdr.c	Sun Nov 17 23:29:58 2002
+++ 01-kmap_atomic/fs/nfs/nfs3xdr.c	Mon Nov 18 11:43:24 2002
@@ -496,7 +496,7 @@
 	int hdrlen, recvd;
 	int status, nr;
 	unsigned int len, pglen;
-	u32 *entry, *end;
+	u32 *entry, *end, *kaddr;
 
 	status = ntohl(*p++);
 	/* Decode post_op_attrs */
@@ -526,7 +526,7 @@
 	if (pglen > recvd)
 		pglen = recvd;
 	page = rcvbuf->pages;
-	p = kmap(*page);
+	kaddr = p = (u32 *)kmap_atomic(*page, KM_USER0);
 	end = (u32 *)((char *)p + pglen);
 	entry = p;
 	for (nr = 0; *p++; nr++) {
@@ -571,7 +571,7 @@
 	if (!nr && (entry[0] != 0 || entry[1] == 0))
 		goto short_pkt;
  out:
-	kunmap(*page);
+	kunmap_atomic(kaddr, KM_USER0);
 	return nr;
  short_pkt:
 	entry[0] = entry[1] = 0;
@@ -582,8 +582,8 @@
 	}
 	goto out;
 err_unmap:
-	kunmap(*page);
-	return -errno_NFSERR_IO;
+	nr = -errno_NFSERR_IO;
+	goto out;
 }
 
 u32 *
@@ -746,7 +746,7 @@
 		xdr_shift_buf(rcvbuf, iov->iov_len - hdrlen);
 	}
 
-	strlen = (u32*)kmap(rcvbuf->pages[0]);
+	strlen = (u32*)kmap_atomic(rcvbuf->pages[0], KM_USER0);
 	/* Convert length of symlink */
 	len = ntohl(*strlen);
 	if (len > rcvbuf->page_len)
@@ -755,7 +755,7 @@
 	/* NULL terminate the string we got */
 	string = (char *)(strlen + 1);
 	string[len] = 0;
-	kunmap(rcvbuf->pages[0]);
+	kunmap_atomic(strlen, KM_USER0);
 	return 0;
 }
 
diff -ruN 00-stock/fs/nfs/nfs4proc.c 01-kmap_atomic/fs/nfs/nfs4proc.c
--- 00-stock/fs/nfs/nfs4proc.c	Sun Nov 17 23:29:51 2002
+++ 01-kmap_atomic/fs/nfs/nfs4proc.c	Mon Nov 18 11:43:24 2002
@@ -451,7 +451,7 @@
 	 * when talking to the server, we always send cookie 0
 	 * instead of 1 or 2.
 	 */
-	start = p = (u32 *)kmap(*pages);
+	start = p = (u32 *)kmap_atomic(*pages, KM_USER0);
 	
 	if (cookie == 0) {
 		*p++ = xdr_one;                                  /* next */
@@ -479,7 +479,7 @@
 
 	readdir->rd_pgbase = (char *)p - (char *)start;
 	readdir->rd_count -= readdir->rd_pgbase;
-	kunmap(*pages);
+	kunmap_atomic(start, KM_USER0);
 }
 
 static void
diff -ruN 00-stock/fs/nfs/nfs4xdr.c 01-kmap_atomic/fs/nfs/nfs4xdr.c
--- 00-stock/fs/nfs/nfs4xdr.c	Sun Nov 17 23:29:57 2002
+++ 01-kmap_atomic/fs/nfs/nfs4xdr.c	Mon Nov 18 11:43:25 2002
@@ -1349,7 +1349,7 @@
 	struct xdr_buf	*rcvbuf = &req->rq_rcv_buf;
 	struct page	*page = *rcvbuf->pages;
 	unsigned int	pglen = rcvbuf->page_len;
-	u32		*end, *entry;
+	u32		*end, *entry, *kaddr;
 	u32		len, attrlen, word;
 	int 		i;
 	DECODE_HEAD;
@@ -1359,7 +1359,7 @@
 		COPYMEM(readdir->rd_resp_verifier, 8);
 
 		BUG_ON(pglen > PAGE_CACHE_SIZE);
-		p   = (u32 *) kmap(page);
+		kaddr = p = (u32 *) kmap_atomic(page, KM_USER0);
 		end = (u32 *) ((char *)p + pglen + readdir->rd_pgbase);
 
 		while (*p++) {
@@ -1403,18 +1403,18 @@
 			if (p + 1 > end)
 				goto short_pkt;
 		}
-		kunmap(page);
+		kunmap_atomic(kaddr, KM_USER0);
 	}
 	
 	DECODE_TAIL;
 short_pkt:
 	printk(KERN_NOTICE "NFS: short packet in readdir reply!\n");
 	/* truncate listing */
-	kunmap(page);
+	kunmap_atomic(kaddr, KM_USER0);
 	entry[0] = entry[1] = 0;
 	return 0;
 err_unmap:
-	kunmap(page);
+	kunmap_atomic(kaddr, KM_USER0);
 	return -errno_NFSERR_IO;
 }
 
@@ -1434,18 +1434,18 @@
 		 * and and null-terminate the text (the VFS expects
 		 * null-termination).
 		 */
-		strlen = (u32 *) kmap(rcvbuf->pages[0]);
+		strlen = (u32 *) kmap_atomic(rcvbuf->pages[0], KM_USER0);
 		len = ntohl(*strlen);
 		if (len > PAGE_CACHE_SIZE - 5) {
 			printk(KERN_WARNING "nfs: server returned giant symlink!\n");
-			kunmap(rcvbuf->pages[0]);
+			kunmap_atomic(strlen, KM_USER0);
 			return -EIO;
 		}
 		*strlen = len;
 		
 		string = (char *)(strlen + 1);
 		string[len] = '\0';
-		kunmap(rcvbuf->pages[0]);
+		kunmap_atomic(strlen, KM_USER0);
 	}
 	return 0;
 }
diff -ruN 00-stock/fs/nfs/read.c 01-kmap_atomic/fs/nfs/read.c
--- 00-stock/fs/nfs/read.c	Sun Nov 17 23:29:20 2002
+++ 01-kmap_atomic/fs/nfs/read.c	Mon Nov 18 11:43:25 2002
@@ -118,12 +118,8 @@
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
@@ -272,12 +268,9 @@
 
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
@@ -293,7 +286,6 @@
 			}
 		} else
 			SetPageError(page);
-		flush_dcache_page(page);
 		unlock_page(page);
 
 		dprintk("NFS: read (%s/%Ld %d@%Ld)\n",
diff -ruN 00-stock/net/sunrpc/xdr.c 01-kmap_atomic/net/sunrpc/xdr.c
--- 00-stock/net/sunrpc/xdr.c	Sun Nov 17 23:29:50 2002
+++ 01-kmap_atomic/net/sunrpc/xdr.c	Mon Nov 18 11:43:25 2002
@@ -307,6 +307,7 @@
 				len = pglen;
 			ret = copy_actor(desc, kaddr, len);
 		}
+		flush_dcache_page(*ppage);
 		kunmap_atomic(kaddr, KM_SKB_SUNRPC_DATA);
 		if (ret != len || !desc->count)
 			return;

