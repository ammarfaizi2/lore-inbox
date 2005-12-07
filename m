Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbVLGDYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVLGDYz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 22:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbVLGDYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 22:24:55 -0500
Received: from pat.uio.no ([129.240.130.16]:22712 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964821AbVLGDYy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 22:24:54 -0500
Subject: Re: another nfs puzzle
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Kenny Simpson <theonetruekenny@yahoo.com>,
       Charles Lever <cel@citi.umich.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051206220448.82860.qmail@web34109.mail.mud.yahoo.com>
References: <20051206220448.82860.qmail@web34109.mail.mud.yahoo.com>
Content-Type: multipart/mixed; boundary="=-K3YC4bqeGNJFboRr6CsJ"
Date: Tue, 06 Dec 2005 22:24:40 -0500
Message-Id: <1133925880.8197.86.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.001, required 12,
	autolearn=disabled, AWL 1.81, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-K3YC4bqeGNJFboRr6CsJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-12-06 at 14:04 -0800, Kenny Simpson wrote:
> Hi again,
>   I am seeing some odd behavior with O_DIRECT.  If a file opened with O_DIRECT has a page mmap'd,
> and the file is extended via pwrite, then the mmap'd region seems to get lost - i.e. it neither
> takes up system memory, nor does it get written out.
> 

Does the attached patch fix it?

Cheers,
  Trond


--=-K3YC4bqeGNJFboRr6CsJ
Content-Disposition: inline; filename=linux-2.6.15-27-unmap_before_odirect.dif
Content-Type: text/plain; name=linux-2.6.15-27-unmap_before_odirect.dif; charset=UTF-8
Content-Transfer-Encoding: 7bit

NFS: Fix another O_DIRECT race

 Ensure we call unmap_mapping_range() and sync dirty pages to disk before
 doing an NFS direct write.

 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/direct.c |   43 ++++++++++++++++++++++++-------------------
 1 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index a2d2814..ce83000 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -111,6 +111,21 @@ nfs_get_user_pages(int rw, unsigned long
 	return result;
 }
 
+static int nfs_sync_mapping(struct address_space *mapping, loff_t offset, size_t len)
+{
+	int ret;
+	if (mapping->nrpages)
+		return 0;
+
+	unmap_mapping_range(mapping, offset, len, 0);
+	ret = filemap_fdatawrite(mapping);
+	if (ret == 0)
+		ret = filemap_fdatawait(mapping);
+	if (ret == 0)
+		ret = nfs_wb_all(mapping->host);
+	return ret;
+}
+
 /**
  * nfs_free_user_pages - tear down page struct array
  * @pages: array of page struct pointers underlying target buffer
@@ -676,15 +691,9 @@ nfs_file_direct_read(struct kiocb *iocb,
 	if (!count)
 		goto out;
 
-	if (mapping->nrpages) {
-		retval = filemap_fdatawrite(mapping);
-		if (retval == 0)
-			retval = nfs_wb_all(inode);
-		if (retval == 0)
-			retval = filemap_fdatawait(mapping);
-		if (retval)
-			goto out;
-	}
+	retval = nfs_sync_mapping(mapping, pos, count);
+	if (retval)
+		goto out;
 
 	retval = nfs_direct_read(inode, ctx, &iov, pos, 1);
 	if (retval > 0)
@@ -762,19 +771,15 @@ nfs_file_direct_write(struct kiocb *iocb
 	if (!count)
 		goto out;
 
-	if (mapping->nrpages) {
-		retval = filemap_fdatawrite(mapping);
-		if (retval == 0)
-			retval = nfs_wb_all(inode);
-		if (retval == 0)
-			retval = filemap_fdatawait(mapping);
-		if (retval)
-			goto out;
-	}
+	retval = nfs_sync_mapping(mapping, pos, count);
+	if (retval)
+		goto out;
 
 	retval = nfs_direct_write(inode, ctx, &iov, pos, 1);
 	if (mapping->nrpages)
-		invalidate_inode_pages2(mapping);
+		invalidate_inode_pages2_range(mapping,
+				pos >> PAGE_CACHE_SHIFT,
+				(pos + count - 1) >> PAGE_CACHE_SHIFT);
 	if (retval > 0)
 		*ppos = pos + retval;
 

--=-K3YC4bqeGNJFboRr6CsJ--

