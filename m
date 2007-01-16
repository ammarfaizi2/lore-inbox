Return-Path: <linux-kernel-owner+w=401wt.eu-S932254AbXAPCFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbXAPCFv (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbXAPCDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:03:43 -0500
Received: from 64.221.212.177.ptr.us.xo.net ([64.221.212.177]:25129 "EHLO
	ext.agami.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932228AbXAPCDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:03:32 -0500
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jan 2007 21:03:27 EST
From: Nate Diller <nate@agami.com>
To: Nate Diller <nate.diller@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Benjamin LaHaise <bcrl@kvack.org>,
       Alexander Viro <viro@zeniv.linux.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Kenneth W Chen <kenneth.w.chen@intel.com>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       netdev@vger.kernel.org, ocfs2-devel@oss.oracle.com, linux-aio@kvack.org,
       xfs-masters@oss.sgi.com
Date: Mon, 15 Jan 2007 17:54:50 -0800
Message-Id: <20070116015450.9764.52713.patchbomb.py@nate-64.agami.com>
In-Reply-To: <20070116015450.9764.37697.patchbomb.py@nate-64.agami.com>
Subject: [PATCH -mm 3/10][RFC] aio: use iov_length instead of ki_left
X-OriginalArrivalTime: 16 Jan 2007 01:55:06.0191 (UTC) FILETIME=[584B5DF0:01C73911]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert code using iocb->ki_left to use the more generic iov_length() call. 

---

diff -urpN -X dontdiff a/fs/ocfs2/file.c b/fs/ocfs2/file.c
--- a/fs/ocfs2/file.c	2007-01-10 11:50:26.000000000 -0800
+++ b/fs/ocfs2/file.c	2007-01-10 12:42:09.000000000 -0800
@@ -1157,7 +1157,7 @@ static ssize_t ocfs2_file_aio_write(stru
 		   filp->f_path.dentry->d_name.name);
 
 	/* happy write of zero bytes */
-	if (iocb->ki_left == 0)
+	if (iov_length(iov, nr_segs) == 0)
 		return 0;
 
 	mutex_lock(&inode->i_mutex);
@@ -1177,7 +1177,7 @@ static ssize_t ocfs2_file_aio_write(stru
 	}
 
 	ret = ocfs2_prepare_inode_for_write(filp->f_path.dentry, &iocb->ki_pos,
-					    iocb->ki_left, appending);
+					iov_length(iov, nr_segs), appending);
 	if (ret < 0) {
 		mlog_errno(ret);
 		goto out;
diff -urpN -X dontdiff a/fs/smbfs/file.c b/fs/smbfs/file.c
--- a/fs/smbfs/file.c	2007-01-10 11:50:28.000000000 -0800
+++ b/fs/smbfs/file.c	2007-01-10 12:42:09.000000000 -0800
@@ -222,7 +222,7 @@ smb_file_aio_read(struct kiocb *iocb, co
 	ssize_t	status;
 
 	VERBOSE("file %s/%s, count=%lu@%lu\n", DENTRY_PATH(dentry),
-		(unsigned long) iocb->ki_left, (unsigned long) pos);
+		(unsigned long) iov_length(iov, nr_segs), (unsigned long) pos);
 
 	status = smb_revalidate_inode(dentry);
 	if (status) {
@@ -328,7 +328,7 @@ smb_file_aio_write(struct kiocb *iocb, c
 
 	VERBOSE("file %s/%s, count=%lu@%lu\n",
 		DENTRY_PATH(dentry),
-		(unsigned long) iocb->ki_left, (unsigned long) pos);
+		(unsigned long) iov_length(iov, nr_segs), (unsigned long) pos);
 
 	result = smb_revalidate_inode(dentry);
 	if (result) {
@@ -341,7 +341,7 @@ smb_file_aio_write(struct kiocb *iocb, c
 	if (result)
 		goto out;
 
-	if (iocb->ki_left > 0) {
+	if (iov_length(iov, nr_segs) > 0) {
 		result = generic_file_aio_write(iocb, iov, nr_segs, pos);
 		VERBOSE("pos=%ld, size=%ld, mtime=%ld, atime=%ld\n",
 			(long) file->f_pos, (long) dentry->d_inode->i_size,
diff -urpN -X dontdiff a/fs/udf/file.c b/fs/udf/file.c
--- a/fs/udf/file.c	2007-01-10 11:53:02.000000000 -0800
+++ b/fs/udf/file.c	2007-01-10 12:42:09.000000000 -0800
@@ -109,7 +109,7 @@ static ssize_t udf_file_aio_write(struct
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file->f_path.dentry->d_inode;
 	int err, pos;
-	size_t count = iocb->ki_left;
+	size_t count = iov_length(iov, nr_segs);
 
 	if (UDF_I_ALLOCTYPE(inode) == ICBTAG_FLAG_AD_IN_ICB)
 	{
diff -urpN -X dontdiff a/net/socket.c b/net/socket.c
--- a/net/socket.c	2007-01-10 12:40:54.000000000 -0800
+++ b/net/socket.c	2007-01-10 12:42:09.000000000 -0800
@@ -632,7 +632,7 @@ static ssize_t sock_aio_read(struct kioc
 	if (pos != 0)
 		return -ESPIPE;
 
-	if (iocb->ki_left == 0)	/* Match SYS5 behaviour */
+	if (iov_length(iov, nr_segs) == 0)	/* Match SYS5 behaviour */
 		return 0;
 
 	for (i = 0; i < nr_segs; i++)
@@ -660,7 +660,7 @@ static ssize_t sock_aio_write(struct kio
 	if (pos != 0)
 		return -ESPIPE;
 
-	if (iocb->ki_left == 0)	/* Match SYS5 behaviour */
+	if (iov_length(iov, nr_segs) == 0)	/* Match SYS5 behaviour */
 		return 0;
 
 	for (i = 0; i < nr_segs; i++)
