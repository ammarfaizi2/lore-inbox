Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263081AbSJDWJS>; Fri, 4 Oct 2002 18:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263089AbSJDWJS>; Fri, 4 Oct 2002 18:09:18 -0400
Received: from dexter.citi.umich.edu ([141.211.133.33]:13952 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S263081AbSJDWJL>; Fri, 4 Oct 2002 18:09:11 -0400
Date: Fri, 4 Oct 2002 18:14:40 -0400 (EDT)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux NFS List <nfs@lists.sourceforge.net>
Subject: [PATCH] remove page_index() from NFS client
Message-ID: <Pine.LNX.4.44.0210041810310.8094-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Linus-

this patch is a pre-requisite for NFS direct I/O support, and prepares the 
NFS client for dealing with I/O directly into anonymously mapped pages.  
please apply this to 2.5.40.

this patch removes direct dependencies on page->index from underlying
support functions in the NFS client.  the page index value is now copied
out of the page struct when I/O is initiated.

trond recommended this approach, and has seen, and blessed, this patch.


diff -drN -U2 06-odirect1/fs/nfs/file.c 07-odirect2/fs/nfs/file.c
--- 06-odirect1/fs/nfs/file.c	Tue Oct  1 03:07:10 2002
+++ 07-odirect2/fs/nfs/file.c	Fri Oct  4 15:28:35 2002
@@ -177,5 +177,5 @@
 	struct address_space *mapping;
 	struct inode	*inode;
-	unsigned long	index = page_index(page);
+	unsigned long	index = page->index;
 	unsigned int	rpages;
 	int		result;
diff -drN -U2 06-odirect1/fs/nfs/pagelist.c 07-odirect2/fs/nfs/pagelist.c
--- 06-odirect1/fs/nfs/pagelist.c	Tue Oct  1 03:06:30 2002
+++ 07-odirect2/fs/nfs/pagelist.c	Fri Oct  4 15:28:35 2002
@@ -104,4 +104,5 @@
 	 * update_nfs_request below if the region is not locked. */
 	req->wb_page    = page;
+	req->wb_index	= page->index;
 	page_cache_get(page);
 	req->wb_offset  = offset;
@@ -189,5 +190,4 @@
 {
 	struct list_head *pos;
-	unsigned long pg_idx = page_index(req->wb_page);
 
 #ifdef NFS_PARANOIA
@@ -199,5 +199,5 @@
 	list_for_each_prev(pos, head) {
 		struct nfs_page	*p = nfs_list_entry(pos);
-		if (page_index(p->wb_page) < pg_idx)
+		if (p->wb_index < req->wb_index)
 			break;
 	}
@@ -248,5 +248,5 @@
 			if (req->wb_cred != prev->wb_cred)
 				break;
-			if (page_index(req->wb_page) != page_index(prev->wb_page)+1)
+			if (req->wb_index != (prev->wb_index + 1))
 				break;
 
@@ -281,5 +281,5 @@
 	struct list_head *pos, *head = req->wb_list_head;
 	struct rpc_cred *cred = req->wb_cred;
-	unsigned long idx = page_index(req->wb_page) + 1;
+	unsigned long idx = req->wb_index + 1;
 	int npages = 0;
 
@@ -297,5 +297,5 @@
 			break;
 		req = nfs_list_entry(pos);
-		if (page_index(req->wb_page) != idx++)
+		if (req->wb_index != idx++)
 			break;
 		if (req->wb_offset != 0)
@@ -394,5 +394,4 @@
 
 	list_for_each_safe(pos, tmp, head) {
-		unsigned long pg_idx;
 
 		req = nfs_list_entry(pos);
@@ -401,8 +400,7 @@
 			continue;
 
-		pg_idx = page_index(req->wb_page);
-		if (pg_idx < idx_start)
+		if (req->wb_index < idx_start)
 			continue;
-		if (pg_idx > idx_end)
+		if (req->wb_index > idx_end)
 			break;
 
diff -drN -U2 06-odirect1/fs/nfs/read.c 07-odirect2/fs/nfs/read.c
--- 06-odirect1/fs/nfs/read.c	Tue Oct  1 03:05:46 2002
+++ 07-odirect2/fs/nfs/read.c	Fri Oct  4 15:28:35 2002
@@ -180,5 +180,5 @@
 
 	if (nfsi->nread >= NFS_SERVER(inode)->rpages ||
-	    page_index(page) == (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT)
+	    page->index == (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT)
 		nfs_pagein_inode(inode, 0, 0);
 	return 0;
@@ -208,5 +208,5 @@
 	data->cred	  = req->wb_cred;
 	data->args.fh     = NFS_FH(req->wb_inode);
-	data->args.offset = page_offset(req->wb_page) + req->wb_offset;
+	data->args.offset = req_offset(req) + req->wb_offset;
 	data->args.pgbase = req->wb_offset;
 	data->args.count  = count;
@@ -442,5 +442,5 @@
                         (long long)NFS_FILEID(req->wb_inode),
                         req->wb_bytes,
-                        (long long)(page_offset(page) + req->wb_offset));
+                        (long long)(req_offset(req) + req->wb_offset));
 		nfs_clear_request(req);
 		nfs_release_request(req);
diff -drN -U2 06-odirect1/fs/nfs/write.c 07-odirect2/fs/nfs/write.c
--- 06-odirect1/fs/nfs/write.c	Tue Oct  1 03:07:34 2002
+++ 07-odirect2/fs/nfs/write.c	Fri Oct  4 15:28:35 2002
@@ -292,5 +292,5 @@
 		return 0;
 
-	rqstart = page_offset(req->wb_page) + req->wb_offset;
+	rqstart = req_offset(req) + req->wb_offset;
 	rqend = rqstart + req->wb_bytes;
 	for (fl = inode->i_flock; fl; fl = fl->fl_next) {
@@ -358,5 +358,5 @@
  */
 static inline struct nfs_page *
-_nfs_find_request(struct inode *inode, struct page *page)
+_nfs_find_request(struct inode *inode, unsigned long index)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
@@ -368,5 +368,5 @@
 		struct nfs_page *req = nfs_inode_wb_entry(next);
 		next = next->next;
-		if (page_index(req->wb_page) != page_index(page))
+		if (req->wb_index != index)
 			continue;
 		req->wb_count++;
@@ -377,10 +377,10 @@
 
 static struct nfs_page *
-nfs_find_request(struct inode *inode, struct page *page)
+nfs_find_request(struct inode *inode, unsigned long index)
 {
 	struct nfs_page		*req;
 
 	spin_lock(&nfs_wreq_lock);
-	req = _nfs_find_request(inode, page);
+	req = _nfs_find_request(inode, index);
 	spin_unlock(&nfs_wreq_lock);
 	return req;
@@ -458,5 +458,4 @@
 	p = head->next;
 	while (p != head) {
-		unsigned long pg_idx;
 		struct nfs_page *req = nfs_inode_wb_entry(p);
 
@@ -466,6 +465,5 @@
 			continue;
 
-		pg_idx = page_index(req->wb_page);
-		if (pg_idx < idx_start || pg_idx > idx_end)
+		if (req->wb_index < idx_start || req->wb_index > idx_end)
 			continue;
 
@@ -655,5 +653,5 @@
 		 */
 		spin_lock(&nfs_wreq_lock);
-		req = _nfs_find_request(inode, page);
+		req = _nfs_find_request(inode, page->index);
 		if (req) {
 			if (!nfs_lock_request_dontget(req)) {
@@ -777,5 +775,5 @@
 	 * dropped page.
 	 */
-	req = nfs_find_request(inode,page);
+	req = nfs_find_request(inode, page->index);
 	if (req) {
 		if (req->wb_file != file || req->wb_cred != cred || req->wb_page != page)
@@ -885,5 +883,5 @@
 	data->cred = req->wb_cred;
 	data->args.fh     = NFS_FH(req->wb_inode);
-	data->args.offset = page_offset(req->wb_page) + req->wb_offset;
+	data->args.offset = req_offset(req) + req->wb_offset;
 	data->args.pgbase = req->wb_offset;
 	data->args.count  = count;
@@ -1073,5 +1071,5 @@
 			(long long)NFS_FILEID(req->wb_inode),
 			req->wb_bytes,
-			(long long)(page_offset(page) + req->wb_offset));
+			(long long)(req_offset(req) + req->wb_offset));
 
 		if (task->tk_status < 0) {
@@ -1127,6 +1125,6 @@
 	 * We rely on the fact that data->pages is an ordered list...
 	 */
-	start = page_offset(first->wb_page) + first->wb_offset;
-	end = page_offset(last->wb_page) + (last->wb_offset + last->wb_bytes);
+	start = req_offset(first) + first->wb_offset;
+	end = req_offset(last) + (last->wb_offset + last->wb_bytes);
 	len = end - start;
 	/* If 'len' is not a 32-bit quantity, pass '0' in the COMMIT call */
@@ -1225,5 +1223,5 @@
 			(long long)NFS_FILEID(req->wb_inode),
 			req->wb_bytes,
-			(long long)(page_offset(req->wb_page) + req->wb_offset));
+			(long long)(req_offset(req) + req->wb_offset));
 		if (task->tk_status < 0) {
 			if (req->wb_file)
diff -drN -U2 06-odirect1/include/linux/nfs_fs.h 07-odirect2/include/linux/nfs_fs.h
--- 06-odirect1/include/linux/nfs_fs.h	Fri Oct  4 15:23:13 2002
+++ 07-odirect2/include/linux/nfs_fs.h	Fri Oct  4 15:28:35 2002
@@ -26,4 +26,5 @@
 #include <linux/nfs2.h>
 #include <linux/nfs3.h>
+#include <linux/nfs_page.h>
 #include <linux/nfs_xdr.h>
 
@@ -240,11 +241,11 @@
 loff_t page_offset(struct page *page)
 {
-	return ((loff_t)page->index) << PAGE_CACHE_SHIFT;
+	return ((loff_t) page->index) << PAGE_CACHE_SHIFT;
 }
 
 static inline
-unsigned long page_index(struct page *page)
+loff_t req_offset(struct nfs_page *req)
 {
-	return page->index;
+	return ((loff_t) req->wb_index) << PAGE_CACHE_SHIFT;
 }
 
@@ -361,5 +362,6 @@
 nfs_wb_page(struct inode *inode, struct page* page)
 {
-	int error = nfs_sync_file(inode, 0, page_index(page), 1, FLUSH_WAIT | FLUSH_STABLE);
+	int error = nfs_sync_file(inode, 0, page->index, 1,
+						FLUSH_WAIT | FLUSH_STABLE);
 	return (error < 0) ? error : 0;
 }
diff -drN -U2 06-odirect1/include/linux/nfs_page.h 07-odirect2/include/linux/nfs_page.h
--- 06-odirect1/include/linux/nfs_page.h	Tue Oct  1 03:06:17 2002
+++ 07-odirect2/include/linux/nfs_page.h	Fri Oct  4 15:28:35 2002
@@ -34,5 +34,6 @@
 	wait_queue_head_t	wb_wait;	/* wait queue */
 	unsigned long		wb_timeout;	/* when to read/write/commit */
-	unsigned int		wb_offset,	/* Offset of read/write */
+	unsigned long		wb_index;	/* Offset within mapping */
+	unsigned int		wb_offset,	/* Offset within page */
 				wb_bytes,	/* Length of request */
 				wb_count;	/* reference count */

-- 

corporate:	<cel at netapp dot com>
personal:	<chucklever at bigfoot dot com>

