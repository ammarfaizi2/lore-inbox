Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262322AbSKHUGH>; Fri, 8 Nov 2002 15:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262325AbSKHUGH>; Fri, 8 Nov 2002 15:06:07 -0500
Received: from pat.uio.no ([129.240.130.16]:18323 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S262322AbSKHUGE>;
	Fri, 8 Nov 2002 15:06:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15820.6839.78077.996924@charged.uio.no>
Date: Fri, 8 Nov 2002 21:12:39 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Add nfs_writepages & backing_dev...
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch adds a simple ->writepages method that interprets
the extra information passed down in Andrew's writeback_control
structure, and translates it into nfs-speak.

It also adds a backing_dev_info structure that scales the readahead in
terms of the rsize. Maximum readahead is still 128k if you use 32k
rsize, but it is scaled down to 4k if you use 1k rsize.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.46/fs/nfs/file.c linux-2.5.46-03-writepages/fs/nfs/file.c
--- linux-2.5.46/fs/nfs/file.c	2002-11-05 07:52:59.000000000 -0500
+++ linux-2.5.46-03-writepages/fs/nfs/file.c	2002-11-08 14:16:27.000000000 -0500
@@ -169,6 +169,7 @@
 	.readpage = nfs_readpage,
 	.readpages = nfs_readpages,
 	.writepage = nfs_writepage,
+	.writepages = nfs_writepages,
 	.prepare_write = nfs_prepare_write,
 	.commit_write = nfs_commit_write,
 #ifdef CONFIG_NFS_DIRECTIO
diff -u --recursive --new-file linux-2.5.46/fs/nfs/inode.c linux-2.5.46-03-writepages/fs/nfs/inode.c
--- linux-2.5.46/fs/nfs/inode.c	2002-11-05 07:52:59.000000000 -0500
+++ linux-2.5.46-03-writepages/fs/nfs/inode.c	2002-11-08 14:16:27.000000000 -0500
@@ -106,7 +106,7 @@
 {
 	int flags = sync ? FLUSH_WAIT : 0;
 
-	nfs_sync_file(inode, NULL, 0, 0, flags);
+	nfs_commit_file(inode, NULL, 0, 0, flags);
 }
 
 static void
@@ -327,6 +327,7 @@
 		server->acdirmin = server->acdirmax = 0;
 		sb->s_flags |= MS_SYNCHRONOUS;
 	}
+	server->backing_dev_info.ra_pages = server->rpages << 2;
 
 	sb->s_maxbytes = fsinfo.maxfilesize;
 	if (sb->s_maxbytes > MAX_LFS_FILESIZE) 
@@ -696,6 +697,7 @@
 		if (S_ISREG(inode->i_mode)) {
 			inode->i_fop = &nfs_file_operations;
 			inode->i_data.a_ops = &nfs_file_aops;
+			inode->i_data.backing_dev_info = &NFS_SB(sb)->backing_dev_info;
 		} else if (S_ISDIR(inode->i_mode)) {
 			inode->i_op = &nfs_dir_inode_operations;
 			inode->i_fop = &nfs_dir_operations;
diff -u --recursive --new-file linux-2.5.46/fs/nfs/write.c linux-2.5.46-03-writepages/fs/nfs/write.c
--- linux-2.5.46/fs/nfs/write.c	2002-10-11 18:21:46.000000000 -0400
+++ linux-2.5.46-03-writepages/fs/nfs/write.c	2002-11-08 14:16:27.000000000 -0500
@@ -52,6 +52,8 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/file.h>
+#include <linux/mpage.h>
+#include <linux/writeback.h>
 
 #include <linux/sunrpc/clnt.h>
 #include <linux/nfs_fs.h>
@@ -277,6 +279,25 @@
 	return 0;
 }
 
+int
+nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
+{
+	struct inode *inode = mapping->host;
+	int is_sync = !wbc->nonblocking;
+	int err;
+
+	err = generic_writepages(mapping, wbc);
+	if (err)
+		goto out;
+	err = nfs_flush_file(inode, NULL, 0, 0, 0);
+	if (err < 0)
+		goto out;
+	if (is_sync)
+		err = nfs_wb_all(inode);
+out:
+	return err;
+}
+
 /*
  * Insert a write request into an inode
  */
@@ -850,6 +871,7 @@
 		req = nfs_list_entry(head->next);
 		nfs_list_remove_request(req);
 		nfs_list_add_request(req, &data->pages);
+		SetPageWriteback(req->wb_page);
 		*pages++ = req->wb_page;
 		count += req->wb_bytes;
 	}
@@ -1005,10 +1027,12 @@
 			SetPageError(page);
 			if (req->wb_file)
 				req->wb_file->f_error = task->tk_status;
+			end_page_writeback(page);
 			nfs_inode_remove_request(req);
 			dprintk(", error = %d\n", task->tk_status);
 			goto next;
 		}
+		end_page_writeback(page);
 
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 		if (stable != NFS_UNSTABLE || data->verf.committed == NFS_FILE_SYNC) {
diff -u --recursive --new-file linux-2.5.46/include/linux/nfs_fs.h linux-2.5.46-03-writepages/include/linux/nfs_fs.h
--- linux-2.5.46/include/linux/nfs_fs.h	2002-11-07 12:29:59.000000000 -0500
+++ linux-2.5.46-03-writepages/include/linux/nfs_fs.h	2002-11-08 14:18:31.000000000 -0500
@@ -319,6 +319,7 @@
  * linux/fs/nfs/write.c
  */
 extern int  nfs_writepage(struct page *);
+extern int  nfs_writepages(struct address_space *, struct writeback_control *);
 extern int  nfs_flush_incompatible(struct file *file, struct page *page);
 extern int  nfs_updatepage(struct file *, struct page *, unsigned int, unsigned int);
 extern void nfs_writeback_done(struct rpc_task *task, int stable,
@@ -343,6 +344,13 @@
 extern int  nfs_commit_list(struct list_head *, int);
 extern int  nfs_scan_lru_commit(struct nfs_server *, struct list_head *);
 extern int  nfs_scan_lru_commit_timeout(struct nfs_server *, struct list_head *);
+#else
+static inline int
+nfs_commit_file(struct inode *inode, struct file *file, unsigned long offset,
+		unsigned int len, int flags)
+{
+	return 0;
+}
 #endif
 
 static inline int
diff -u --recursive --new-file linux-2.5.46/include/linux/nfs_fs_sb.h linux-2.5.46-03-writepages/include/linux/nfs_fs_sb.h
--- linux-2.5.46/include/linux/nfs_fs_sb.h	2002-10-14 10:03:25.000000000 -0400
+++ linux-2.5.46-03-writepages/include/linux/nfs_fs_sb.h	2002-11-08 14:16:27.000000000 -0500
@@ -2,6 +2,7 @@
 #define _NFS_FS_SB
 
 #include <linux/list.h>
+#include <linux/backing-dev.h>
 
 /*
  * NFS client parameters stored in the superblock.
@@ -9,6 +10,7 @@
 struct nfs_server {
 	struct rpc_clnt *	client;		/* RPC client handle */
 	struct nfs_rpc_ops *	rpc_ops;	/* NFS protocol vector */
+	struct backing_dev_info	backing_dev_info;
 	int			flags;		/* various flags */
 	unsigned int		caps;		/* server capabilities */
 	unsigned int		rsize;		/* read size */
