Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266623AbSKZT1S>; Tue, 26 Nov 2002 14:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266622AbSKZT1S>; Tue, 26 Nov 2002 14:27:18 -0500
Received: from dexter.citi.umich.edu ([141.211.133.33]:4992 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S266609AbSKZT1C>; Tue, 26 Nov 2002 14:27:02 -0500
Date: Tue, 26 Nov 2002 14:34:06 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] use kmap_atomic instaed of kmap in NFS client
Message-ID: <Pine.LNX.4.44.0211261427470.9482-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
  andrew morton suggested there are places in the NFS client that could
  make use of kmap_atomic instead of vanilla kmap in order to improve
  scalability on 8-way and higher SMP systems.

Apply Against:
  2.5.49

Test status:
  Passes Connectathon '02, fsx, and other stress tests on a UP HIGHMEM
  x86 system.


diff -Naur 00-stock/fs/nfs/dir.c 01-kmap-atomic/fs/nfs/dir.c
--- 00-stock/fs/nfs/dir.c	Fri Nov 22 16:40:42 2002
+++ 01-kmap-atomic/fs/nfs/dir.c	Mon Nov 25 13:08:29 2002
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
 
diff -Naur 00-stock/fs/nfs/nfs2xdr.c 01-kmap-atomic/fs/nfs/nfs2xdr.c
--- 00-stock/fs/nfs/nfs2xdr.c	Fri Nov 22 16:40:29 2002
+++ 01-kmap-atomic/fs/nfs/nfs2xdr.c	Mon Nov 25 13:08:29 2002
@@ -378,7 +378,7 @@
 	int hdrlen, recvd;
 	int status, nr;
 	unsigned int len, pglen;
-	u32 *end, *entry;
+	u32 *end, *entry, *kaddr;
 
 	if ((status = ntohl(*p++)))
 		return -nfs_stat_to_errno(status);
@@ -398,7 +398,7 @@
 	if (pglen > recvd)
 		pglen = recvd;
 	page = rcvbuf->pages;
-	p = kmap(*page);
+	kaddr = p = (u32 *)kmap_atomic(*page, KM_USER0);
 	end = (u32 *)((char *)p + pglen);
 	entry = p;
 	for (nr = 0; *p++; nr++) {
@@ -419,7 +419,7 @@
 	if (!nr && (entry[0] != 0 || entry[1] == 0))
 		goto short_pkt;
  out:
-	kunmap(*page);
+	kunmap_atomic(kaddr, KM_USER0);
 	return nr;
  short_pkt:
 	entry[0] = entry[1] = 0;
@@ -430,8 +430,8 @@
 	}
 	goto out;
 err_unmap:
-	kunmap(*page);
-	return -errno_NFSERR_IO;
+	nr = -errno_NFSERR_IO;
+	goto out;
 }
 
 u32 *
@@ -542,7 +542,7 @@
 		xdr_shift_buf(rcvbuf, iov->iov_len - hdrlen);
 	}
 
-	strlen = (u32*)kmap(rcvbuf->pages[0]);
+	strlen = (u32*)kmap_atomic(rcvbuf->pages[0], KM_USER0);
 	/* Convert length of symlink */
 	len = ntohl(*strlen);
 	if (len > rcvbuf->page_len)
@@ -551,7 +551,7 @@
 	/* NULL terminate the string we got */
 	string = (char *)(strlen + 1);
 	string[len] = 0;
-	kunmap(rcvbuf->pages[0]);
+	kunmap_atomic(strlen, KM_USER0);
 	return 0;
 }
 
diff -Naur 00-stock/fs/nfs/nfs3xdr.c 01-kmap-atomic/fs/nfs/nfs3xdr.c
--- 00-stock/fs/nfs/nfs3xdr.c	Fri Nov 22 16:41:13 2002
+++ 01-kmap-atomic/fs/nfs/nfs3xdr.c	Mon Nov 25 13:08:29 2002
@@ -488,7 +488,7 @@
 	int hdrlen, recvd;
 	int status, nr;
 	unsigned int len, pglen;
-	u32 *entry, *end;
+	u32 *entry, *end, *kaddr;
 
 	status = ntohl(*p++);
 	/* Decode post_op_attrs */
@@ -518,7 +518,7 @@
 	if (pglen > recvd)
 		pglen = recvd;
 	page = rcvbuf->pages;
-	p = kmap(*page);
+	kaddr = p = (u32 *)kmap_atomic(*page, KM_USER0);
 	end = (u32 *)((char *)p + pglen);
 	entry = p;
 	for (nr = 0; *p++; nr++) {
@@ -563,7 +563,7 @@
 	if (!nr && (entry[0] != 0 || entry[1] == 0))
 		goto short_pkt;
  out:
-	kunmap(*page);
+	kunmap_atomic(kaddr, KM_USER0);
 	return nr;
  short_pkt:
 	entry[0] = entry[1] = 0;
@@ -574,8 +574,8 @@
 	}
 	goto out;
 err_unmap:
-	kunmap(*page);
-	return -errno_NFSERR_IO;
+	nr = -errno_NFSERR_IO;
+	goto out;
 }
 
 u32 *
@@ -738,7 +738,7 @@
 		xdr_shift_buf(rcvbuf, iov->iov_len - hdrlen);
 	}
 
-	strlen = (u32*)kmap(rcvbuf->pages[0]);
+	strlen = (u32*)kmap_atomic(rcvbuf->pages[0], KM_USER0);
 	/* Convert length of symlink */
 	len = ntohl(*strlen);
 	if (len > rcvbuf->page_len)
@@ -747,7 +747,7 @@
 	/* NULL terminate the string we got */
 	string = (char *)(strlen + 1);
 	string[len] = 0;
-	kunmap(rcvbuf->pages[0]);
+	kunmap_atomic(strlen, KM_USER0);
 	return 0;
 }
 
diff -Naur 00-stock/fs/nfs/nfs4proc.c 01-kmap-atomic/fs/nfs/nfs4proc.c
--- 00-stock/fs/nfs/nfs4proc.c	Fri Nov 22 16:40:53 2002
+++ 01-kmap-atomic/fs/nfs/nfs4proc.c	Mon Nov 25 13:08:30 2002
@@ -447,7 +447,7 @@
 	 * when talking to the server, we always send cookie 0
 	 * instead of 1 or 2.
 	 */
-	start = p = (u32 *)kmap(*pages);
+	start = p = (u32 *)kmap_atomic(*pages, KM_USER0);
 	
 	if (cookie == 0) {
 		*p++ = xdr_one;                                  /* next */
@@ -475,7 +475,7 @@
 
 	readdir->rd_pgbase = (char *)p - (char *)start;
 	readdir->rd_count -= readdir->rd_pgbase;
-	kunmap(*pages);
+	kunmap_atomic(start, KM_USER0);
 }
 
 static void
diff -Naur 00-stock/fs/nfs/nfs4xdr.c 01-kmap-atomic/fs/nfs/nfs4xdr.c
--- 00-stock/fs/nfs/nfs4xdr.c	Fri Nov 22 16:41:12 2002
+++ 01-kmap-atomic/fs/nfs/nfs4xdr.c	Mon Nov 25 13:15:27 2002
@@ -1299,7 +1299,7 @@
 	struct xdr_buf	*rcvbuf = &req->rq_rcv_buf;
 	struct page	*page = *rcvbuf->pages;
 	unsigned int	pglen = rcvbuf->page_len;
-	uint32_t *end, *entry, *p;
+	uint32_t *end, *entry, *p, *kaddr;
 	uint32_t len, attrlen, word;
 	int i;
 
@@ -1308,7 +1308,7 @@
 		COPYMEM(readdir->rd_resp_verifier, 8);
 
 		BUG_ON(pglen > PAGE_CACHE_SIZE);
-		p   = (uint32_t *) kmap(page);
+		kaddr = p = (uint32_t *) kmap_atomic(page, KM_USER0);
 		end = (uint32_t *) ((char *)p + pglen + readdir->rd_pgbase);
 
 		while (*p++) {
@@ -1352,18 +1352,18 @@
 			if (p + 1 > end)
 				goto short_pkt;
 		}
-		kunmap(page);
+		kunmap_atomic(kaddr, KM_USER0);
 	}
 	
 	return 0;
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
 
@@ -1383,18 +1383,18 @@
 		 * and and null-terminate the text (the VFS expects
 		 * null-termination).
 		 */
-		strlen = (uint32_t *) kmap(rcvbuf->pages[0]);
+		strlen = (uint32_t *) kmap_atomic(rcvbuf->pages[0], KM_USER0);
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
diff -Naur 00-stock/fs/nfs/read.c 01-kmap-atomic/fs/nfs/read.c
--- 00-stock/fs/nfs/read.c	Fri Nov 22 16:40:12 2002
+++ 01-kmap-atomic/fs/nfs/read.c	Mon Nov 25 13:08:30 2002
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
diff -Naur 00-stock/net/sunrpc/xdr.c 01-kmap-atomic/net/sunrpc/xdr.c
--- 00-stock/net/sunrpc/xdr.c	Fri Nov 22 16:40:52 2002
+++ 01-kmap-atomic/net/sunrpc/xdr.c	Mon Nov 25 13:08:30 2002
@@ -307,6 +307,7 @@
 				len = pglen;
 			ret = copy_actor(desc, kaddr, len);
 		}
+		flush_dcache_page(*ppage);
 		kunmap_atomic(kaddr, KM_SKB_SUNRPC_DATA);
 		if (ret != len || !desc->count)
 			return;

