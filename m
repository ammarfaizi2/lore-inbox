Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbSKRVrx>; Mon, 18 Nov 2002 16:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264968AbSKRVrx>; Mon, 18 Nov 2002 16:47:53 -0500
Received: from dexter.citi.umich.edu ([141.211.133.33]:2432 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S264963AbSKRVru>; Mon, 18 Nov 2002 16:47:50 -0500
Date: Mon, 18 Nov 2002 16:54:45 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] separate page base and file page offset in NFS client
Message-ID: <Pine.LNX.4.44.0211181652460.1518-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a pre-requisite for functioning O_DIRECT support for NFS.  with this
patch: for each request, the client now stores the in-memory page offset
in a separate field from the file page offset.  this allows direct I/O to
target user buffers at arbitrary offsets.

against 2.5.48.


diff -ruN 02-req_offset/fs/nfs/nfs3proc.c 03-wb_base/fs/nfs/nfs3proc.c
--- 02-req_offset/fs/nfs/nfs3proc.c	Mon Nov 18 11:46:05 2002
+++ 03-wb_base/fs/nfs/nfs3proc.c	Mon Nov 18 11:50:13 2002
@@ -709,7 +709,7 @@
 	req = nfs_list_entry(data->pages.next);
 	data->u.v3.args.fh     = NFS_FH(inode);
 	data->u.v3.args.offset = req_offset(req);
-	data->u.v3.args.pgbase = req->wb_offset;
+	data->u.v3.args.pgbase = req->wb_base;
 	data->u.v3.args.pages  = data->pagevec;
 	data->u.v3.args.count  = count;
 	data->u.v3.res.fattr   = &data->fattr;
@@ -765,7 +765,7 @@
 	req = nfs_list_entry(data->pages.next);
 	data->u.v3.args.fh     = NFS_FH(inode);
 	data->u.v3.args.offset = req_offset(req);
-	data->u.v3.args.pgbase = req->wb_offset;
+	data->u.v3.args.pgbase = req->wb_base;
 	data->u.v3.args.count  = count;
 	data->u.v3.args.stable = stable;
 	data->u.v3.args.pages  = data->pagevec;
diff -ruN 02-req_offset/fs/nfs/nfs4proc.c 03-wb_base/fs/nfs/nfs4proc.c
--- 02-req_offset/fs/nfs/nfs4proc.c	Mon Nov 18 11:46:05 2002
+++ 03-wb_base/fs/nfs/nfs4proc.c	Mon Nov 18 11:50:13 2002
@@ -1380,7 +1380,7 @@
 	nfs4_setup_compound(cp, data->u.v4.ops, NFS_SERVER(inode), "read [async]");
 	nfs4_setup_putfh(cp, NFS_FH(inode));
 	nfs4_setup_read(cp, req_offset(req),
-			count, data->pagevec, req->wb_offset,
+			count, data->pagevec, req->wb_base,
 			&data->u.v4.res_eof,
 			&data->u.v4.res_count);
 
@@ -1433,7 +1433,7 @@
 	nfs4_setup_compound(cp, data->u.v4.ops, NFS_SERVER(inode), "write [async]");
 	nfs4_setup_putfh(cp, NFS_FH(inode));
 	nfs4_setup_write(cp, req_offset(req),
-			 count, stable, data->pagevec, req->wb_offset,
+			 count, stable, data->pagevec, req->wb_base,
 			 &data->u.v4.res_count, &data->verf);
 
 	/* Set the initial flags for the task.  */
diff -ruN 02-req_offset/fs/nfs/pagelist.c 03-wb_base/fs/nfs/pagelist.c
--- 02-req_offset/fs/nfs/pagelist.c	Sun Nov 17 23:29:54 2002
+++ 03-wb_base/fs/nfs/pagelist.c	Mon Nov 18 11:50:13 2002
@@ -91,6 +91,7 @@
 	req->wb_index	= page->index;
 	page_cache_get(page);
 	req->wb_offset  = offset;
+	req->wb_base	= offset;
 	req->wb_bytes   = count;
 
 	if (cred)
@@ -277,14 +278,13 @@
 				break;
 			if (req->wb_index != (prev->wb_index + 1))
 				break;
-
-			if (req->wb_offset != 0)
+			if (req->wb_base != 0)
 				break;
 		}
 		nfs_list_remove_request(req);
 		nfs_list_add_request(req, dst);
 		npages++;
-		if (req->wb_offset + req->wb_bytes != PAGE_CACHE_SIZE)
+		if (req->wb_base + req->wb_bytes != PAGE_CACHE_SIZE)
 			break;
 		if (npages >= nmax)
 			break;
diff -ruN 02-req_offset/fs/nfs/proc.c 03-wb_base/fs/nfs/proc.c
--- 02-req_offset/fs/nfs/proc.c	Mon Nov 18 11:46:05 2002
+++ 03-wb_base/fs/nfs/proc.c	Mon Nov 18 11:50:13 2002
@@ -544,7 +544,7 @@
 	req = nfs_list_entry(data->pages.next);
 	data->u.v3.args.fh     = NFS_FH(inode);
 	data->u.v3.args.offset = req_offset(req);
-	data->u.v3.args.pgbase = req->wb_offset;
+	data->u.v3.args.pgbase = req->wb_base;
 	data->u.v3.args.pages  = data->pagevec;
 	data->u.v3.args.count  = count;
 	data->u.v3.res.fattr   = &data->fattr;
@@ -590,7 +590,7 @@
 	req = nfs_list_entry(data->pages.next);
 	data->u.v3.args.fh     = NFS_FH(inode);
 	data->u.v3.args.offset = req_offset(req);
-	data->u.v3.args.pgbase = req->wb_offset;
+	data->u.v3.args.pgbase = req->wb_base;
 	data->u.v3.args.count  = count;
 	data->u.v3.args.stable = NFS_FILE_SYNC;
 	data->u.v3.args.pages  = data->pagevec;
diff -ruN 02-req_offset/fs/nfs/read.c 03-wb_base/fs/nfs/read.c
--- 02-req_offset/fs/nfs/read.c	Mon Nov 18 11:46:05 2002
+++ 03-wb_base/fs/nfs/read.c	Mon Nov 18 11:50:13 2002
@@ -269,7 +269,7 @@
 		if (task->tk_status >= 0) {
 			if (count < PAGE_CACHE_SIZE) {
 				memclear_highpage_flush(page,
-							req->wb_offset + count,
+							req->wb_base + count,
 							req->wb_bytes - count);
 
 				if (eof ||
diff -ruN 02-req_offset/fs/nfs/write.c 03-wb_base/fs/nfs/write.c
--- 02-req_offset/fs/nfs/write.c	Mon Nov 18 11:46:05 2002
+++ 03-wb_base/fs/nfs/write.c	Mon Nov 18 11:50:13 2002
@@ -586,6 +586,7 @@
 	/* Okay, the request matches. Update the region */
 	if (offset < req->wb_offset) {
 		req->wb_offset = offset;
+		req->wb_base = offset;
 		req->wb_bytes = rqend - req->wb_offset;
 	}
 
@@ -718,7 +719,7 @@
 	 * Call the strategy routine so it can send out a bunch
 	 * of requests.
 	 */
-	if (req->wb_offset == 0 && req->wb_bytes == PAGE_CACHE_SIZE) {
+	if (req->wb_base == 0 && req->wb_bytes == PAGE_CACHE_SIZE) {
 		SetPageUptodate(page);
 		nfs_unlock_request(req);
 		nfs_strategy(inode);
diff -ruN 02-req_offset/include/linux/nfs_page.h 03-wb_base/include/linux/nfs_page.h
--- 02-req_offset/include/linux/nfs_page.h	Sun Nov 17 23:29:22 2002
+++ 03-wb_base/include/linux/nfs_page.h	Mon Nov 18 11:50:13 2002
@@ -31,7 +31,8 @@
 	struct page		*wb_page;	/* page to read in/write out */
 	wait_queue_head_t	wb_wait;	/* wait queue */
 	unsigned long		wb_index;	/* Offset within mapping */
-	unsigned int		wb_offset,	/* Offset within page */
+	unsigned int		wb_offset,	/* Offset within file page */
+				wb_base,	/* Offset within buffer page */
 				wb_bytes,	/* Length of request */
 				wb_count;	/* reference count */
 	unsigned long		wb_flags;

