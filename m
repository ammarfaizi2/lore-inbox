Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266622AbSKZTb5>; Tue, 26 Nov 2002 14:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266626AbSKZTb5>; Tue, 26 Nov 2002 14:31:57 -0500
Received: from dexter.citi.umich.edu ([141.211.133.33]:6016 "EHLO
	dexter.citi.umich.edu") by vger.kernel.org with ESMTP
	id <S266622AbSKZTbt>; Tue, 26 Nov 2002 14:31:49 -0500
Date: Tue, 26 Nov 2002 14:39:03 -0500 (EST)
From: Chuck Lever <cel@citi.umich.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] cleanup: simplify req_offset function in NFS client
Message-ID: <Pine.LNX.4.44.0211261436450.9482-100000@dexter.citi.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description:
  everywhere the NFS client uses the req_offset() function today, it adds
  req->wb_offset to the result.  this patch simply makes "+req->wb_offset"
  a part of the req_offset() function.

Apply against:
  2.5.49

Test status:
  Passes Connectathon '02, fsx, and other stress tests on a UP HIGHMEM
  x86 system.


diff -Naur 02-set_page_dirty/fs/nfs/nfs3proc.c 03-req_offset/fs/nfs/nfs3proc.c
--- 02-set_page_dirty/fs/nfs/nfs3proc.c	Fri Nov 22 16:40:42 2002
+++ 03-req_offset/fs/nfs/nfs3proc.c	Mon Nov 25 13:21:45 2002
@@ -708,7 +708,7 @@
 	
 	req = nfs_list_entry(data->pages.next);
 	data->u.v3.args.fh     = NFS_FH(inode);
-	data->u.v3.args.offset = req_offset(req) + req->wb_offset;
+	data->u.v3.args.offset = req_offset(req);
 	data->u.v3.args.pgbase = req->wb_offset;
 	data->u.v3.args.pages  = data->pagevec;
 	data->u.v3.args.count  = count;
@@ -764,7 +764,7 @@
 	
 	req = nfs_list_entry(data->pages.next);
 	data->u.v3.args.fh     = NFS_FH(inode);
-	data->u.v3.args.offset = req_offset(req) + req->wb_offset;
+	data->u.v3.args.offset = req_offset(req);
 	data->u.v3.args.pgbase = req->wb_offset;
 	data->u.v3.args.count  = count;
 	data->u.v3.args.stable = stable;
diff -Naur 02-set_page_dirty/fs/nfs/nfs4proc.c 03-req_offset/fs/nfs/nfs4proc.c
--- 02-set_page_dirty/fs/nfs/nfs4proc.c	Mon Nov 25 13:08:30 2002
+++ 03-req_offset/fs/nfs/nfs4proc.c	Mon Nov 25 13:21:46 2002
@@ -1384,7 +1384,7 @@
 
 	nfs4_setup_compound(cp, data->u.v4.ops, NFS_SERVER(inode), "read [async]");
 	nfs4_setup_putfh(cp, NFS_FH(inode));
-	nfs4_setup_read(cp, req_offset(req) + req->wb_offset,
+	nfs4_setup_read(cp, req_offset(req),
 			count, data->pagevec, req->wb_offset,
 			&data->u.v4.res_eof,
 			&data->u.v4.res_count);
@@ -1437,7 +1437,7 @@
 
 	nfs4_setup_compound(cp, data->u.v4.ops, NFS_SERVER(inode), "write [async]");
 	nfs4_setup_putfh(cp, NFS_FH(inode));
-	nfs4_setup_write(cp, req_offset(req) + req->wb_offset,
+	nfs4_setup_write(cp, req_offset(req),
 			 count, stable, data->pagevec, req->wb_offset,
 			 &data->u.v4.res_count, &data->verf);
 
diff -Naur 02-set_page_dirty/fs/nfs/proc.c 03-req_offset/fs/nfs/proc.c
--- 02-set_page_dirty/fs/nfs/proc.c	Fri Nov 22 16:41:00 2002
+++ 03-req_offset/fs/nfs/proc.c	Mon Nov 25 13:21:46 2002
@@ -543,7 +543,7 @@
 	
 	req = nfs_list_entry(data->pages.next);
 	data->u.v3.args.fh     = NFS_FH(inode);
-	data->u.v3.args.offset = req_offset(req) + req->wb_offset;
+	data->u.v3.args.offset = req_offset(req);
 	data->u.v3.args.pgbase = req->wb_offset;
 	data->u.v3.args.pages  = data->pagevec;
 	data->u.v3.args.count  = count;
@@ -589,7 +589,7 @@
 	
 	req = nfs_list_entry(data->pages.next);
 	data->u.v3.args.fh     = NFS_FH(inode);
-	data->u.v3.args.offset = req_offset(req) + req->wb_offset;
+	data->u.v3.args.offset = req_offset(req);
 	data->u.v3.args.pgbase = req->wb_offset;
 	data->u.v3.args.count  = count;
 	data->u.v3.args.stable = NFS_FILE_SYNC;
diff -Naur 02-set_page_dirty/fs/nfs/read.c 03-req_offset/fs/nfs/read.c
--- 02-set_page_dirty/fs/nfs/read.c	Mon Nov 25 13:08:30 2002
+++ 03-req_offset/fs/nfs/read.c	Mon Nov 25 13:21:46 2002
@@ -178,7 +178,7 @@
 			inode->i_sb->s_id,
 			(long long)NFS_FILEID(inode),
 			count,
-			(unsigned long long)req_offset(req) + req->wb_offset);
+			(unsigned long long)req_offset(req));
 }
 
 static void
@@ -274,7 +274,7 @@
 
 				if (eof ||
 				    ((fattr->valid & NFS_ATTR_FATTR) &&
-				     ((req_offset(req) + req->wb_offset + count) >= fattr->size)))
+				     ((req_offset(req) + count) >= fattr->size)))
 					SetPageUptodate(page);
 				else
 					if (count < req->wb_bytes)
@@ -292,7 +292,7 @@
                         req->wb_inode->i_sb->s_id,
                         (long long)NFS_FILEID(req->wb_inode),
                         req->wb_bytes,
-                        (long long)(req_offset(req) + req->wb_offset));
+                        (long long)req_offset(req));
 		nfs_clear_request(req);
 		nfs_release_request(req);
 		nfs_unlock_request(req);
diff -Naur 02-set_page_dirty/fs/nfs/write.c 03-req_offset/fs/nfs/write.c
--- 02-set_page_dirty/fs/nfs/write.c	Fri Nov 22 16:40:53 2002
+++ 03-req_offset/fs/nfs/write.c	Mon Nov 25 13:21:46 2002
@@ -768,7 +768,7 @@
 		inode->i_sb->s_id,
 		(long long)NFS_FILEID(inode),
 		count,
-		(unsigned long long)req_offset(req) + req->wb_offset);
+		(unsigned long long)req_offset(req));
 }
 
 /*
@@ -902,7 +902,7 @@
 			req->wb_inode->i_sb->s_id,
 			(long long)NFS_FILEID(req->wb_inode),
 			req->wb_bytes,
-			(long long)(req_offset(req) + req->wb_offset));
+			(long long)req_offset(req));
 
 		if (task->tk_status < 0) {
 			ClearPageUptodate(page);
@@ -958,8 +958,8 @@
 	 * Determine the offset range of requests in the COMMIT call.
 	 * We rely on the fact that data->pages is an ordered list...
 	 */
-	start = req_offset(first) + first->wb_offset;
-	end = req_offset(last) + (last->wb_offset + last->wb_bytes);
+	start = req_offset(first);
+	end = req_offset(last) + last->wb_bytes;
 	len = end - start;
 	/* If 'len' is not a 32-bit quantity, pass '0' in the COMMIT call */
 	if (end >= inode->i_size || len < 0 || len > (~((u32)0) >> 1))
@@ -1031,7 +1031,7 @@
 			req->wb_inode->i_sb->s_id,
 			(long long)NFS_FILEID(req->wb_inode),
 			req->wb_bytes,
-			(long long)(req_offset(req) + req->wb_offset));
+			(long long)req_offset(req));
 		if (task->tk_status < 0) {
 			if (req->wb_file)
 				req->wb_file->f_error = task->tk_status;
diff -Naur 02-set_page_dirty/include/linux/nfs_fs.h 03-req_offset/include/linux/nfs_fs.h
--- 02-set_page_dirty/include/linux/nfs_fs.h	Fri Nov 22 16:40:29 2002
+++ 03-req_offset/include/linux/nfs_fs.h	Mon Nov 25 13:21:46 2002
@@ -222,7 +222,7 @@
 static inline
 loff_t req_offset(struct nfs_page *req)
 {
-	return ((loff_t)req->wb_index) << PAGE_CACHE_SHIFT;
+	return (((loff_t)req->wb_index) << PAGE_CACHE_SHIFT) + req->wb_offset;
 }
 
 /*

