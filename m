Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWESSCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWESSCH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 14:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWESSAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 14:00:44 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:64219 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S932424AbWESSAc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 14:00:32 -0400
X-ORBL: [68.248.17.28]
From: Chuck Lever <cel@netapp.com>
Reply-To: Chuck Lever <cel@citi.umich.edu>
Subject: [PATCH 2/6] nfs: remove user_addr and user_count from nfs_direct_req
Date: Fri, 19 May 2006 14:00:24 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Message-Id: <20060519180024.3244.7319.stgit@brahms.dsl.sfldmi.ameritech.net>
In-Reply-To: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
References: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These fields won't fit the iovec API, and are no longer used for anything
but passing a parameter to nfs_direct_read/write_schedule.  Make the
parameters explicit, and remove the fields from nfs_direct_req.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 fs/nfs/direct.c |   29 ++++++++---------------------
 1 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 0fde4bf..aef0b98 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -73,9 +73,6 @@ struct nfs_direct_req {
 	struct nfs_open_context	*ctx;		/* file open context info */
 	struct kiocb *		iocb;		/* controlling i/o request */
 	struct inode *		inode;		/* target file of i/o */
-	unsigned long		user_addr;	/* location of user's buffer */
-	size_t			user_count;	/* total bytes to move */
-	loff_t			pos;		/* starting offset in file */
 	struct page **		pages;		/* pages in our buffer */
 	unsigned int		npages;		/* count of pages */
 
@@ -331,19 +328,17 @@ static const struct rpc_call_ops nfs_rea
  * For each nfs_read_data struct that was allocated on the list, dispatch
  * an NFS READ operation
  */
-static void nfs_direct_read_schedule(struct nfs_direct_req *dreq)
+static void nfs_direct_read_schedule(struct nfs_direct_req *dreq, unsigned long user_addr, size_t count, loff_t pos)
 {
 	struct nfs_open_context *ctx = dreq->ctx;
 	struct inode *inode = ctx->dentry->d_inode;
 	struct list_head *list = &dreq->list;
 	struct page **pages = dreq->pages;
-	size_t count = dreq->user_count;
-	loff_t pos = dreq->pos;
 	size_t rsize = NFS_SERVER(inode)->rsize;
 	unsigned int curpage, pgbase;
 
 	curpage = 0;
-	pgbase = dreq->user_addr & ~PAGE_MASK;
+	pgbase = user_addr & ~PAGE_MASK;
 	do {
 		struct nfs_read_data *data;
 		size_t bytes;
@@ -407,9 +402,6 @@ static ssize_t nfs_direct_read(struct ki
 	if (!dreq)
 		return -ENOMEM;
 
-	dreq->user_addr = user_addr;
-	dreq->user_count = count;
-	dreq->pos = pos;
 	dreq->pages = pages;
 	dreq->npages = nr_pages;
 	dreq->inode = inode;
@@ -419,7 +411,7 @@ static ssize_t nfs_direct_read(struct ki
 
 	nfs_add_stats(inode, NFSIOS_DIRECTREADBYTES, count);
 	rpc_clnt_sigmask(clnt, &oldset);
-	nfs_direct_read_schedule(dreq);
+	nfs_direct_read_schedule(dreq, user_addr, count, pos);
 	result = nfs_direct_wait(dreq);
 	rpc_clnt_sigunmask(clnt, &oldset);
 
@@ -521,8 +513,8 @@ static void nfs_direct_commit_schedule(s
 	data->cred = dreq->ctx->cred;
 
 	data->args.fh = NFS_FH(data->inode);
-	data->args.offset = dreq->pos;
-	data->args.count = dreq->user_count;
+	data->args.offset = 0;
+	data->args.count = 0;
 	data->res.count = 0;
 	data->res.fattr = &data->fattr;
 	data->res.verf = &data->verf;
@@ -680,19 +672,17 @@ static const struct rpc_call_ops nfs_wri
  * For each nfs_write_data struct that was allocated on the list, dispatch
  * an NFS WRITE operation
  */
-static void nfs_direct_write_schedule(struct nfs_direct_req *dreq, int sync)
+static void nfs_direct_write_schedule(struct nfs_direct_req *dreq, unsigned long user_addr, size_t count, loff_t pos, int sync)
 {
 	struct nfs_open_context *ctx = dreq->ctx;
 	struct inode *inode = ctx->dentry->d_inode;
 	struct list_head *list = &dreq->list;
 	struct page **pages = dreq->pages;
-	size_t count = dreq->user_count;
-	loff_t pos = dreq->pos;
 	size_t wsize = NFS_SERVER(inode)->wsize;
 	unsigned int curpage, pgbase;
 
 	curpage = 0;
-	pgbase = dreq->user_addr & ~PAGE_MASK;
+	pgbase = user_addr & ~PAGE_MASK;
 	do {
 		struct nfs_write_data *data;
 		size_t bytes;
@@ -761,9 +751,6 @@ static ssize_t nfs_direct_write(struct k
 	if (dreq->commit_data == NULL || count < wsize)
 		sync = FLUSH_STABLE;
 
-	dreq->user_addr = user_addr;
-	dreq->user_count = count;
-	dreq->pos = pos;
 	dreq->pages = pages;
 	dreq->npages = nr_pages;
 	dreq->inode = inode;
@@ -776,7 +763,7 @@ static ssize_t nfs_direct_write(struct k
 	nfs_begin_data_update(inode);
 
 	rpc_clnt_sigmask(clnt, &oldset);
-	nfs_direct_write_schedule(dreq, sync);
+	nfs_direct_write_schedule(dreq, user_addr, count, pos, sync);
 	result = nfs_direct_wait(dreq);
 	rpc_clnt_sigunmask(clnt, &oldset);
 
