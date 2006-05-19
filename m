Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWESSAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWESSAm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 14:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWESSAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 14:00:41 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:43213 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S932448AbWESSAj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 14:00:39 -0400
X-ORBL: [68.248.17.28]
From: Chuck Lever <cel@netapp.com>
Reply-To: Chuck Lever <cel@citi.umich.edu>
Subject: [PATCH 5/6] nfs: check all iov segments for correct memory access rights
Date: Fri, 19 May 2006 14:00:36 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trond.myklebust@fys.uio.no
Message-Id: <20060519180036.3244.70897.stgit@brahms.dsl.sfldmi.ameritech.net>
In-Reply-To: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
References: <20060519175652.3244.7079.stgit@brahms.dsl.sfldmi.ameritech.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add Badari's function to check access for all the segments in a passed-in
iov.  We can use the total byte count later.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 fs/nfs/direct.c |   65 +++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 9cd6b96..3d4ded0 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -374,7 +374,6 @@ static ssize_t nfs_direct_read(struct ki
 	if (!is_sync_kiocb(iocb))
 		dreq->iocb = iocb;
 
-	nfs_add_stats(inode, NFSIOS_DIRECTREADBYTES, count);
 	rpc_clnt_sigmask(clnt, &oldset);
 	if (nfs_direct_read_schedule(dreq, user_addr, count, pos))
 		result = nfs_direct_wait(dreq);
@@ -709,8 +708,6 @@ static ssize_t nfs_direct_write(struct k
 	if (!is_sync_kiocb(iocb))
 		dreq->iocb = iocb;
 
-	nfs_add_stats(inode, NFSIOS_DIRECTWRITTENBYTES, count);
-
 	nfs_begin_data_update(inode);
 
 	rpc_clnt_sigmask(clnt, &oldset);
@@ -721,6 +718,36 @@ static ssize_t nfs_direct_write(struct k
 	return result;
 }
 
+/*
+ * Check:
+ * 1.  All bytes in the user buffers are properly accessible
+ * 2.  The resulting number of bytes won't overflow ssize_t
+ */
+static ssize_t check_access_ok(int type, const struct iovec *iov, unsigned long nr_segs)
+{
+	ssize_t count = 0;
+	ssize_t retval = -EINVAL;
+	unsigned long seg;
+
+	for (seg = 0; seg < nr_segs; seg++) {
+		void __user *buf = iov[seg].iov_base;
+		ssize_t len = (ssize_t) iov[seg].iov_len;
+
+		if (len < 0)		/* size_t not fitting an ssize_t .. */
+			goto out;
+		if (unlikely(!access_ok(type, buf, len))) {
+			retval = -EFAULT;
+			goto out;
+		}
+		count += len;
+		if (count < 0)		/* math overflow on the ssize_t */
+			goto out;
+	}
+	retval = count;
+out:
+	return retval;
+}
+
 /**
  * nfs_file_direct_read - file direct read operation for NFS files
  * @iocb: target I/O control block
@@ -745,13 +772,18 @@ static ssize_t nfs_direct_write(struct k
 ssize_t nfs_file_direct_read(struct kiocb *iocb, const struct iovec *iov,
 				unsigned long nr_segs, loff_t pos)
 {
-	ssize_t retval = -EINVAL;
+	ssize_t retval;
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	/* XXX: temporary */
 	const char __user *buf = iov[0].iov_base;
 	size_t count = iov[0].iov_len;
 
+	retval = check_access_ok(VERIFY_WRITE, iov, nr_segs);
+	if (retval <= 0)
+		goto out;
+	nfs_add_stats(mapping->host, NFSIOS_DIRECTREADBYTES, retval);
+
 	dprintk("nfs: direct read(%s/%s, %lu@%Ld)\n",
 		file->f_dentry->d_parent->d_name.name,
 		file->f_dentry->d_name.name,
@@ -760,15 +792,6 @@ ssize_t nfs_file_direct_read(struct kioc
 	if (nr_segs != 1)
 		return -EINVAL;
 
-	if (count < 0)
-		goto out;
-	retval = -EFAULT;
-	if (!access_ok(VERIFY_WRITE, buf, count))
-		goto out;
-	retval = 0;
-	if (!count)
-		goto out;
-
 	retval = nfs_sync_mapping(mapping);
 	if (retval)
 		goto out;
@@ -816,6 +839,11 @@ ssize_t nfs_file_direct_write(struct kio
 	const char __user *buf = iov[0].iov_base;
 	size_t count = iov[0].iov_len;
 
+	retval = check_access_ok(VERIFY_READ, iov, nr_segs);
+	if (retval <= 0)
+		goto out;
+	nfs_add_stats(mapping->host, NFSIOS_DIRECTWRITTENBYTES, retval);
+
 	dfprintk(VFS, "nfs: direct write(%s/%s, %lu@%Ld)\n",
 		file->f_dentry->d_parent->d_name.name,
 		file->f_dentry->d_name.name,
@@ -828,17 +856,6 @@ ssize_t nfs_file_direct_write(struct kio
 	if (retval)
 		goto out;
 
-	retval = -EINVAL;
-	if ((ssize_t) count < 0)
-		goto out;
-	retval = 0;
-	if (!count)
-		goto out;
-
-	retval = -EFAULT;
-	if (!access_ok(VERIFY_READ, buf, count))
-		goto out;
-
 	retval = nfs_sync_mapping(mapping);
 	if (retval)
 		goto out;
