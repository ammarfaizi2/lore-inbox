Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932449AbWESSAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbWESSAz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 14:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWESSAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 14:00:49 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:7812 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S932453AbWESSAn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 14:00:43 -0400
X-ORBL: [68.248.17.28]
From: Chuck Lever <cel@netapp.com>
Reply-To: Chuck Lever <cel@citi.umich.edu>
Subject: [PATCH 6/6] nfs: Support vector I/O throughout the NFS direct I/O path
Date: Fri, 19 May 2006 14:00:39 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Message-Id: <20060519180039.3244.68051.stgit@brahms.dsl.sfldmi.ameritech.net>
In-Reply-To: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
References: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the preliminaries are complete, it is safe to loop over all the
segments in an iovec, dispatching all of the requests against a single
nfs_direct_req.

Test plan:
Specialized test applications using vectored synchronous and asynchronous
I/O.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 fs/nfs/direct.c |   78 +++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 3d4ded0..e62b905 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -281,8 +281,6 @@ static int nfs_direct_read_schedule(stru
 	unsigned int pgbase;
 	unsigned int started = 0;
 
-	dreq->outstanding++;
-
 	pgbase = user_addr & ~PAGE_MASK;
 	do {
 		struct nfs_read_data *data;
@@ -351,13 +349,30 @@ static int nfs_direct_read_schedule(stru
 		count -= bytes;
 	} while (count != 0);
 
+	return started;
+}
+
+static int nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq, const struct iovec *iov, unsigned long nr_segs, loff_t pos)
+{
+	ssize_t started = 0;
+	unsigned long seg;
+
+	dreq->outstanding++;
+
+	for (seg = 0; seg < nr_segs; seg++) {
+		unsigned long user_addr = (unsigned long) iov[seg].iov_base;
+		size_t count = iov[seg].iov_len;
+		started += nfs_direct_read_schedule(dreq, user_addr, count, pos);
+		pos += count;
+	}
+
 	if (nfs_direct_dec_outstanding(dreq))
 		nfs_direct_complete(dreq);
 
 	return started;
 }
 
-static ssize_t nfs_direct_read(struct kiocb *iocb, unsigned long user_addr, size_t count, loff_t pos)
+static ssize_t nfs_direct_read(struct kiocb *iocb, const struct iovec *iov, unsigned long nr_segs, loff_t pos)
 {
 	ssize_t result = 0;
 	sigset_t oldset;
@@ -375,7 +390,7 @@ static ssize_t nfs_direct_read(struct ki
 		dreq->iocb = iocb;
 
 	rpc_clnt_sigmask(clnt, &oldset);
-	if (nfs_direct_read_schedule(dreq, user_addr, count, pos))
+	if (nfs_direct_read_schedule_iovec(dreq, iov, nr_segs, pos))
 		result = nfs_direct_wait(dreq);
 	rpc_clnt_sigunmask(clnt, &oldset);
 
@@ -606,8 +621,6 @@ static int nfs_direct_write_schedule(str
 	unsigned int pgbase;
 	unsigned int started = 0;
 
-	dreq->outstanding++;
-
 	pgbase = user_addr & ~PAGE_MASK;
 	do {
 		struct nfs_write_data *data;
@@ -679,13 +692,31 @@ static int nfs_direct_write_schedule(str
 		count -= bytes;
 	} while (count != 0);
 
+	return started;
+}
+
+
+static int nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq, const struct iovec *iov, unsigned long nr_segs, loff_t pos, int sync)
+{
+	ssize_t started = 0;
+	unsigned long seg;
+
+	dreq->outstanding++;
+
+	for (seg = 0; seg < nr_segs; seg++) {
+		unsigned long user_addr = (unsigned long) iov[seg].iov_base;
+		size_t count = iov[seg].iov_len;
+		started += nfs_direct_write_schedule(dreq, user_addr, count, pos, sync);
+		pos += count;
+	}
+
 	if (nfs_direct_dec_outstanding(dreq))
-		nfs_direct_write_complete(dreq, inode);
+		nfs_direct_write_complete(dreq, dreq->inode);
 
 	return started;
 }
 
-static ssize_t nfs_direct_write(struct kiocb *iocb, unsigned long user_addr, size_t count, loff_t pos)
+static ssize_t nfs_direct_write(struct kiocb *iocb, const struct iovec *iov, unsigned long nr_segs, loff_t pos, size_t count)
 {
 	ssize_t result = 0;
 	sigset_t oldset;
@@ -711,7 +742,7 @@ static ssize_t nfs_direct_write(struct k
 	nfs_begin_data_update(inode);
 
 	rpc_clnt_sigmask(clnt, &oldset);
-	if (nfs_direct_write_schedule(dreq, user_addr, count, pos, sync))
+	if (nfs_direct_write_schedule_iovec(dreq, iov, nr_segs, pos, sync))
 		result = nfs_direct_wait(dreq);
 	rpc_clnt_sigunmask(clnt, &oldset);
 
@@ -775,28 +806,22 @@ ssize_t nfs_file_direct_read(struct kioc
 	ssize_t retval;
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
-	/* XXX: temporary */
-	const char __user *buf = iov[0].iov_base;
-	size_t count = iov[0].iov_len;
 
 	retval = check_access_ok(VERIFY_WRITE, iov, nr_segs);
 	if (retval <= 0)
 		goto out;
 	nfs_add_stats(mapping->host, NFSIOS_DIRECTREADBYTES, retval);
 
-	dprintk("nfs: direct read(%s/%s, %lu@%Ld)\n",
+	dprintk("nfs: direct read(%s/%s, %zd@%Ld)\n",
 		file->f_dentry->d_parent->d_name.name,
 		file->f_dentry->d_name.name,
-		(unsigned long) count, (long long) pos);
-
-	if (nr_segs != 1)
-		return -EINVAL;
+		retval, (long long) pos);
 
 	retval = nfs_sync_mapping(mapping);
 	if (retval)
 		goto out;
 
-	retval = nfs_direct_read(iocb, (unsigned long) buf, count, pos);
+	retval = nfs_direct_read(iocb, iov, nr_segs, pos);
 	if (retval > 0)
 		iocb->ki_pos = pos + retval;
 
@@ -832,35 +857,32 @@ out:
 ssize_t nfs_file_direct_write(struct kiocb *iocb, const struct iovec *iov,
 				unsigned long nr_segs, loff_t pos)
 {
-	ssize_t retval;
+	ssize_t retval, count;
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
-	/* XXX: temporary */
-	const char __user *buf = iov[0].iov_base;
-	size_t count = iov[0].iov_len;
 
 	retval = check_access_ok(VERIFY_READ, iov, nr_segs);
 	if (retval <= 0)
 		goto out;
 	nfs_add_stats(mapping->host, NFSIOS_DIRECTWRITTENBYTES, retval);
 
-	dfprintk(VFS, "nfs: direct write(%s/%s, %lu@%Ld)\n",
+	dfprintk(VFS, "nfs: direct write(%s/%s, %zd@%Ld)\n",
 		file->f_dentry->d_parent->d_name.name,
 		file->f_dentry->d_name.name,
-		(unsigned long) count, (long long) pos);
-
-	if (nr_segs != 1)
-		return -EINVAL;
+		retval, (long long) pos);
 
+	count = retval;
 	retval = generic_write_checks(file, &pos, &count, 0);
 	if (retval)
 		goto out;
+	if (!count)
+		goto out;	/* return 0 */
 
 	retval = nfs_sync_mapping(mapping);
 	if (retval)
 		goto out;
 
-	retval = nfs_direct_write(iocb, (unsigned long) buf, count, pos);
+	retval = nfs_direct_write(iocb, iov, nr_segs, pos, count);
 
 	/*
 	 * XXX: nfs_end_data_update() already ensures this file's
