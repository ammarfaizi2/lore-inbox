Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319259AbSHNUe5>; Wed, 14 Aug 2002 16:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319282AbSHNUe4>; Wed, 14 Aug 2002 16:34:56 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:42968 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319259AbSHNUeP>; Wed, 14 Aug 2002 16:34:15 -0400
Date: Wed, 14 Aug 2002 16:38:02 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@vanguard.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: REPOST patch 04/38: CLIENT: change CONFIG_NFS_V3 to CONFIG_NFS_V3
 || CONFIG_NFS_V4
Message-ID: <Pine.SOL.4.44.0208141637270.1834-100000@vanguard.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In a number of places in the NFS client, I had to change

  #ifdef CONFIG_NFS_V3
     /* ... */
  #endif

to

  #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
     /* ... */
  #endif

This is a trivial patch which collects all changes of this type.

--- old/fs/nfs/flushd.c	Thu Aug  1 16:16:29 2002
+++ new/fs/nfs/flushd.c	Sun Aug 11 20:26:05 2002
@@ -171,7 +171,7 @@ nfs_flushd(struct rpc_task *task)
 			nfs_pagein_list(&head, server->rpages);
 			continue;
 		}
-#ifdef CONFIG_NFS_V3
+#if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 		if (nfs_scan_lru_commit_timeout(server, &head)) {
 			spin_unlock(&nfs_wreq_lock);
 			nfs_commit_list(&head, FLUSH_AGING);
--- old/fs/nfs/pagelist.c	Sun Aug 11 19:20:53 2002
+++ new/fs/nfs/pagelist.c	Sun Aug 11 20:26:05 2002
@@ -458,7 +458,7 @@ nfs_try_to_free_pages(struct nfs_server
 			continue;
 		}

-#ifdef CONFIG_NFS_V3
+#if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 		/* Let's try to free up some completed NFSv3 unstable writes */
 		nfs_scan_lru_commit(server, &head);
 		if (!list_empty(&head)) {
--- old/fs/nfs/write.c	Thu Aug  1 16:16:12 2002
+++ new/fs/nfs/write.c	Sun Aug 11 20:26:05 2002
@@ -88,7 +88,7 @@ static struct nfs_page * nfs_update_requ
 					    unsigned int, unsigned int);
 static void	nfs_strategy(struct inode *inode);
 static void	nfs_writeback_done(struct rpc_task *);
-#ifdef CONFIG_NFS_V3
+#if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 static void	nfs_commit_done(struct rpc_task *);
 #endif

@@ -414,7 +414,7 @@ nfs_dirty_request(struct nfs_page *req)
 	return !list_empty(&req->wb_list) && req->wb_list_head == &nfsi->dirty;
 }

-#ifdef CONFIG_NFS_V3
+#if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 /*
  * Add a request to the inode's commit list.
  */
@@ -554,7 +554,7 @@ nfs_scan_dirty(struct inode *inode, stru
 	return res;
 }

-#ifdef CONFIG_NFS_V3
+#if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 /**
  * nfs_scan_lru_commit_timeout - Scan LRU list for timed out commit requests
  * @server: NFS superblock data
@@ -749,7 +749,7 @@ nfs_strategy(struct inode *inode)

 	dirty  = NFS_I(inode)->ndirty;
 	wpages = NFS_SERVER(inode)->wpages;
-#ifdef CONFIG_NFS_V3
+#if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 	if (NFS_PROTO(inode)->version == 2) {
 		if (dirty >= NFS_STRATEGY_PAGES * wpages)
 			nfs_flush_file(inode, NULL, 0, 0, 0);
@@ -1034,7 +1034,7 @@ nfs_writeback_done(struct rpc_task *task
 		 * an error. */
 		task->tk_status = -EIO;
 	}
-#ifdef CONFIG_NFS_V3
+#if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 	if (resp->verf->committed < argp->stable && task->tk_status >= 0) {
 		/* We tried a write call, but the server did not
 		 * commit data to stable storage even though we
@@ -1084,7 +1084,7 @@ nfs_writeback_done(struct rpc_task *task
 			goto next;
 		}

-#ifdef CONFIG_NFS_V3
+#if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 		if (argp->stable != NFS_UNSTABLE || resp->verf->committed == NFS_FILE_SYNC) {
 			nfs_inode_remove_request(req);
 			dprintk(" OK\n");
@@ -1103,7 +1103,7 @@ nfs_writeback_done(struct rpc_task *task
 }


-#ifdef CONFIG_NFS_V3
+#if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 /*
  * Set up the argument/result storage required for the RPC call.
  */
@@ -1267,7 +1267,7 @@ int nfs_flush_file(struct inode *inode,
 	return res;
 }

-#ifdef CONFIG_NFS_V3
+#if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 int nfs_commit_file(struct inode *inode, struct file *file, unsigned long idx_start,
 		    unsigned int npages, int how)
 {
@@ -1304,7 +1304,7 @@ int nfs_sync_file(struct inode *inode, s
 			error = nfs_wait_on_requests(inode, file, idx_start, npages);
 		if (error == 0)
 			error = nfs_flush_file(inode, file, idx_start, npages, how);
-#ifdef CONFIG_NFS_V3
+#if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 		if (error == 0)
 			error = nfs_commit_file(inode, file, idx_start, npages, how);
 #endif
--- old/include/linux/nfs_fs.h	Sun Aug 11 19:20:53 2002
+++ new/include/linux/nfs_fs.h	Sun Aug 11 20:26:05 2002
@@ -322,7 +322,7 @@ extern int  nfs_flush_file(struct inode
 extern int  nfs_flush_list(struct list_head *, int, int);
 extern int  nfs_scan_lru_dirty(struct nfs_server *, struct list_head *);
 extern int  nfs_scan_lru_dirty_timeout(struct nfs_server *, struct list_head *);
-#ifdef CONFIG_NFS_V3
+#if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 extern int  nfs_commit_file(struct inode *, struct file *, unsigned long, unsigned int, int);
 extern int  nfs_commit_list(struct list_head *, int);
 extern int  nfs_scan_lru_commit(struct nfs_server *, struct list_head *);

