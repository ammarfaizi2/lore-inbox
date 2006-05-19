Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWESSA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWESSA0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 14:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWESSA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 14:00:26 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:7662 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S932412AbWESSAZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 14:00:25 -0400
X-ORBL: [68.248.17.28]
From: Chuck Lever <cel@netapp.com>
Reply-To: Chuck Lever <cel@citi.umich.edu>
Subject: [PATCH 1/6] nfs: "open code" the NFS direct write rescheduler
Date: Fri, 19 May 2006 14:00:21 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Message-Id: <20060519180020.3244.75979.stgit@brahms.dsl.sfldmi.ameritech.net>
In-Reply-To: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
References: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support direct asynchronous vectored writes, the write
rescheduler in fs/nfs/direct.c must not depend on the I/O parameters in the
controlling nfs_direct_req structure.  Refactor the write rescheduler to
use only the information in each nfs_write_data structure to redrive writes
if the server rebooted before we can commit them.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 fs/nfs/direct.c |   71 +++++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 56 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 0980e43..0fde4bf 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -94,8 +94,19 @@ struct nfs_direct_req {
 	struct nfs_writeverf	verf;		/* unstable write verifier */
 };
 
-static void nfs_direct_write_schedule(struct nfs_direct_req *dreq, int sync);
 static void nfs_direct_write_complete(struct nfs_direct_req *dreq, struct inode *inode);
+static const struct rpc_call_ops nfs_write_direct_ops;
+
+static inline int nfs_direct_dec_outstanding(struct nfs_direct_req *dreq)
+{
+	int result;
+
+	spin_lock(&dreq->lock);
+	result = --dreq->outstanding;
+	spin_unlock(&dreq->lock);
+
+	return (result == 0);
+}
 
 /**
  * nfs_direct_IO - NFS address space operation for direct I/O
@@ -428,14 +439,52 @@ static void nfs_direct_free_writedata(st
 #if defined(CONFIG_NFS_V3) || defined(CONFIG_NFS_V4)
 static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 {
+	struct inode *inode = dreq->inode;
 	struct list_head *pos;
 
-	list_splice_init(&dreq->rewrite_list, &dreq->list);
-	list_for_each(pos, &dreq->list)
-		dreq->outstanding++;
+	/*
+	 * Prevent I/O completion while we're still rescheduling
+	 */
+	dreq->outstanding++;
+
 	dreq->count = 0;
+	list_for_each(pos, &dreq->rewrite_list) {
+		struct nfs_write_data *data =
+			list_entry(dreq->rewrite_list.next, struct nfs_write_data, pages);
+
+		spin_lock(&dreq->lock);
+		dreq->outstanding++;
+		spin_unlock(&dreq->lock);
+
+		nfs_fattr_init(&data->fattr);
+		data->res.count = data->args.count;
+		memset(&data->verf, 0, sizeof(data->verf));
+
+		rpc_init_task(&data->task, NFS_CLIENT(inode), RPC_TASK_ASYNC,
+				&nfs_write_direct_ops, data);
+		NFS_PROTO(inode)->write_setup(data, FLUSH_STABLE);
+
+		data->task.tk_priority = RPC_PRIORITY_HIGH;
+		data->task.tk_cookie = (unsigned long) inode;
 
-	nfs_direct_write_schedule(dreq, FLUSH_STABLE);
+		lock_kernel();
+		rpc_execute(&data->task);
+		unlock_kernel();
+
+		dfprintk(VFS, "NFS: %5u rescheduled direct write call (req %s/%Ld, %zu bytes @ offset %Lu)\n",
+				data->task.tk_pid,
+				inode->i_sb->s_id,
+				(long long)NFS_FILEID(inode),
+				data->args.count,
+				(unsigned long long)data->args.offset);
+	}
+
+	/*
+	 * If we raced with the rescheduled I/O and lost, then
+	 * all the I/O is already complete.
+	 */
+	if (nfs_direct_dec_outstanding(dreq))
+		nfs_direct_write_complete(dreq, inode);
 }
 
 static void nfs_direct_commit_result(struct rpc_task *task, void *calldata)
@@ -605,8 +654,6 @@ static void nfs_direct_write_result(stru
 				}
 		}
 	}
-	/* In case we have to resend */
-	data->args.stable = NFS_FILE_SYNC;
 
 	spin_unlock(&dreq->lock);
 }
@@ -620,14 +667,8 @@ static void nfs_direct_write_release(voi
 	struct nfs_write_data *data = calldata;
 	struct nfs_direct_req *dreq = (struct nfs_direct_req *) data->req;
 
-	spin_lock(&dreq->lock);
-	if (--dreq->outstanding) {
-		spin_unlock(&dreq->lock);
-		return;
-	}
-	spin_unlock(&dreq->lock);
-
-	nfs_direct_write_complete(dreq, data->inode);
+	if (nfs_direct_dec_outstanding(dreq))
+		nfs_direct_write_complete(dreq, data->inode);
 }
 
 static const struct rpc_call_ops nfs_write_direct_ops = {
