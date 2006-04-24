Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWDXWDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWDXWDi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 18:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWDXWDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 18:03:38 -0400
Received: from pat.uio.no ([129.240.10.6]:58321 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750916AbWDXWDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 18:03:37 -0400
Subject: Re: NFS client (10x) performance regression 2.6.14.7 -> 2.6.15
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jakob Oestergaard <jakob@unthought.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060404092243.GC14981@unthought.net>
References: <20060331132131.GI9811@unthought.net>
	 <1143812658.8096.18.camel@lade.trondhjem.org>
	 <20060331140816.GJ9811@unthought.net>
	 <1143814889.8096.22.camel@lade.trondhjem.org>
	 <20060331143500.GK9811@unthought.net>
	 <1143820520.8096.24.camel@lade.trondhjem.org>
	 <20060331160426.GN9811@unthought.net>
	 <20060403152628.GA14981@unthought.net>
	 <1144078900.9111.41.camel@lade.trondhjem.org>
	 <20060403154519.GB14981@unthought.net>
	 <20060404092243.GC14981@unthought.net>
Content-Type: multipart/mixed; boundary="=-tbn/+55Z9MzgsYCr7HXE"
Date: Mon, 24 Apr 2006 18:03:23 -0400
Message-Id: <1145916203.10974.55.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.096, required 12,
	autolearn=disabled, AWL 1.72, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tbn/+55Z9MzgsYCr7HXE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-04-04 at 11:22 +0200, Jakob Oestergaard wrote:
> On Mon, Apr 03, 2006 at 05:45:19PM +0200, Jakob Oestergaard wrote:
> > On Mon, Apr 03, 2006 at 11:41:40AM -0400, Trond Myklebust wrote:
> > ..
> > > OK. Thanks for helping narrow this down! I'm travelling right now, so I
> > > can't promise that I'll be able to run any tests until tomorrow. I'll
> > > have a look, though.
> 
> Just another datapoint;
> 
> 2.6.16.1 with that one patch reverted does no longer exhibit the
> problem.

Sorry it has taken such a long time to get round to looking into this
problem. Can you see if the attached patch helps in any way?

Cheers,
  Trond

--=-tbn/+55Z9MzgsYCr7HXE
Content-Disposition: inline; filename=linux-2.6.17-032-reduce_number_invalidations.dif
Content-Type: message/rfc822; name=linux-2.6.17-032-reduce_number_invalidations.dif

From: Trond Myklebust <Trond.Myklebust@netapp.com>
NFS: Separate metadata and page cache revalidation mechanisms
Date: Mon, 24 Apr 2006 18:03:23 -0400
Subject: No Subject
Message-Id: <1145916203.10974.56.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

Separate out the function of revalidating the inode metadata, and
revalidating the mapping. The former may be called by lookup(),
and only really needs to check that permissions, ctime, etc haven't changed
whereas the latter needs only done when we want to read data from the page
cache, and may need to sync and then invalidate the mapping.

Fix up a bug in the handling of NFS_INO_REVAL_PAGECACHE: make sure that
nfs_update_inode() clears it when we're sure we're not racing with other
updates.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/dir.c           |    2 +-
 fs/nfs/file.c          |   24 +++---------------------
 fs/nfs/inode.c         |   21 ++++++++++++---------
 fs/nfs/symlink.c       |    2 +-
 include/linux/nfs_fs.h |    2 +-
 5 files changed, 18 insertions(+), 33 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2ab69cf..3ddda6f 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -528,7 +528,7 @@ static int nfs_readdir(struct file *filp
 
 	lock_kernel();
 
-	res = nfs_revalidate_inode(NFS_SERVER(inode), inode);
+	res = nfs_revalidate_mapping(inode, filp->f_mapping);
 	if (res < 0) {
 		unlock_kernel();
 		return res;
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index fade02c..6315407 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -127,23 +127,6 @@ nfs_file_release(struct inode *inode, st
 }
 
 /**
- * nfs_revalidate_file - Revalidate the page cache & related metadata
- * @inode - pointer to inode struct
- * @file - pointer to file
- */
-static int nfs_revalidate_file(struct inode *inode, struct file *filp)
-{
-	struct nfs_inode *nfsi = NFS_I(inode);
-	int retval = 0;
-
-	if ((nfsi->cache_validity & (NFS_INO_REVAL_PAGECACHE|NFS_INO_INVALID_ATTR))
-			|| nfs_attribute_timeout(inode))
-		retval = __nfs_revalidate_inode(NFS_SERVER(inode), inode);
-	nfs_revalidate_mapping(inode, filp->f_mapping);
-	return 0;
-}
-
-/**
  * nfs_revalidate_size - Revalidate the file size
  * @inode - pointer to inode struct
  * @file - pointer to struct file
@@ -228,7 +211,7 @@ #endif
 		dentry->d_parent->d_name.name, dentry->d_name.name,
 		(unsigned long) count, (unsigned long) pos);
 
-	result = nfs_revalidate_file(inode, iocb->ki_filp);
+	result = nfs_revalidate_mapping(inode, iocb->ki_filp->f_mapping);
 	nfs_add_stats(inode, NFSIOS_NORMALREADBYTES, count);
 	if (!result)
 		result = generic_file_aio_read(iocb, buf, count, pos);
@@ -247,7 +230,7 @@ nfs_file_sendfile(struct file *filp, lof
 		dentry->d_parent->d_name.name, dentry->d_name.name,
 		(unsigned long) count, (unsigned long long) *ppos);
 
-	res = nfs_revalidate_file(inode, filp);
+	res = nfs_revalidate_mapping(inode, filp->f_mapping);
 	if (!res)
 		res = generic_file_sendfile(filp, ppos, count, actor, target);
 	return res;
@@ -263,7 +246,7 @@ nfs_file_mmap(struct file * file, struct
 	dfprintk(VFS, "nfs: mmap(%s/%s)\n",
 		dentry->d_parent->d_name.name, dentry->d_name.name);
 
-	status = nfs_revalidate_file(inode, file);
+	status = nfs_revalidate_mapping(inode, file->f_mapping);
 	if (!status)
 		status = generic_file_mmap(file, vma);
 	return status;
@@ -373,7 +356,6 @@ #endif
 		if (result)
 			goto out;
 	}
-	nfs_revalidate_mapping(inode, iocb->ki_filp->f_mapping);
 
 	result = count;
 	if (!count)
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 9a344be..f041b76 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1271,7 +1271,7 @@ __nfs_revalidate_inode(struct nfs_server
 		status = -ESTALE;
 		/* Do we trust the cached ESTALE? */
 		if (NFS_ATTRTIMEO(inode) != 0) {
-			if (nfsi->cache_validity & (NFS_INO_INVALID_ATTR|NFS_INO_INVALID_DATA|NFS_INO_INVALID_ATIME)) {
+			if (nfsi->cache_validity & (NFS_INO_INVALID_ATTR|NFS_INO_INVALID_ATIME)) {
 				/* no */
 			} else
 				goto out;
@@ -1302,8 +1302,6 @@ __nfs_revalidate_inode(struct nfs_server
 	}
 	spin_unlock(&inode->i_lock);
 
-	nfs_revalidate_mapping(inode, inode->i_mapping);
-
 	if (nfsi->cache_validity & NFS_INO_INVALID_ACL)
 		nfs_zap_acl_cache(inode);
 
@@ -1338,7 +1336,7 @@ int nfs_attribute_timeout(struct inode *
 int nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 {
 	nfs_inc_stats(inode, NFSIOS_INODEREVALIDATE);
-	if (!(NFS_I(inode)->cache_validity & (NFS_INO_INVALID_ATTR|NFS_INO_INVALID_DATA))
+	if (!(NFS_I(inode)->cache_validity & NFS_INO_INVALID_ATTR)
 			&& !nfs_attribute_timeout(inode))
 		return NFS_STALE(inode) ? -ESTALE : 0;
 	return __nfs_revalidate_inode(server, inode);
@@ -1349,15 +1347,19 @@ int nfs_revalidate_inode(struct nfs_serv
  * @inode - pointer to host inode
  * @mapping - pointer to mapping
  */
-void nfs_revalidate_mapping(struct inode *inode, struct address_space *mapping)
+int nfs_revalidate_mapping(struct inode *inode, struct address_space *mapping)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
+	int ret = 0;
+
+	if ((nfsi->cache_validity & NFS_INO_REVAL_PAGECACHE)
+			|| nfs_attribute_timeout(inode))
+		ret = __nfs_revalidate_inode(NFS_SERVER(inode), inode);
 
 	if (nfsi->cache_validity & NFS_INO_INVALID_DATA) {
 		nfs_inc_stats(inode, NFSIOS_DATAINVALIDATE);
 		if (S_ISREG(inode->i_mode))
 			nfs_sync_mapping(mapping);
-		invalidate_inode_pages2(mapping);
 
 		spin_lock(&inode->i_lock);
 		nfsi->cache_validity &= ~NFS_INO_INVALID_DATA;
@@ -1367,11 +1369,13 @@ void nfs_revalidate_mapping(struct inode
 			nfsi->cache_change_attribute = jiffies;
 		}
 		spin_unlock(&inode->i_lock);
+		invalidate_inode_pages2(mapping);
 
 		dfprintk(PAGECACHE, "NFS: (%s/%Ld) data cache invalidated\n",
 				inode->i_sb->s_id,
 				(long long)NFS_FILEID(inode));
 	}
+	return ret;
 }
 
 /**
@@ -1510,7 +1514,6 @@ int nfs_refresh_inode(struct inode *inod
 	if ((fattr->valid & NFS_ATTR_FATTR) == 0)
 		return 0;
 	spin_lock(&inode->i_lock);
-	nfsi->cache_validity &= ~NFS_INO_REVAL_PAGECACHE;
 	if (time_after(fattr->time_start, nfsi->last_updated))
 		status = nfs_update_inode(inode, fattr);
 	else
@@ -1535,7 +1538,7 @@ int nfs_post_op_update_inode(struct inod
 
 	spin_lock(&inode->i_lock);
 	if (unlikely((fattr->valid & NFS_ATTR_FATTR) == 0)) {
-		nfsi->cache_validity |= NFS_INO_INVALID_ATTR | NFS_INO_INVALID_ACCESS;
+		nfsi->cache_validity |= NFS_INO_INVALID_ACCESS|NFS_INO_INVALID_ATTR|NFS_INO_REVAL_PAGECACHE;
 		goto out;
 	}
 	status = nfs_update_inode(inode, fattr);
@@ -1592,7 +1595,7 @@ static int nfs_update_inode(struct inode
 	/* Are we racing with known updates of the metadata on the server? */
 	data_stable = nfs_verify_change_attribute(inode, fattr->time_start);
 	if (data_stable)
-		nfsi->cache_validity &= ~(NFS_INO_INVALID_ATTR|NFS_INO_INVALID_ATIME);
+		nfsi->cache_validity &= ~(NFS_INO_INVALID_ATTR|NFS_INO_REVAL_PAGECACHE|NFS_INO_INVALID_ATIME);
 
 	/* Do atomic weak cache consistency updates */
 	nfs_wcc_update_inode(inode, fattr);
diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
index 18dc95b..636c479 100644
--- a/fs/nfs/symlink.c
+++ b/fs/nfs/symlink.c
@@ -52,7 +52,7 @@ static void *nfs_follow_link(struct dent
 {
 	struct inode *inode = dentry->d_inode;
 	struct page *page;
-	void *err = ERR_PTR(nfs_revalidate_inode(NFS_SERVER(inode), inode));
+	void *err = ERR_PTR(nfs_revalidate_mapping(inode, inode->i_mapping));
 	if (err)
 		goto read_failed;
 	page = read_cache_page(&inode->i_data, 0,
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 363eced..2250144 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -298,7 +298,7 @@ extern int nfs_release(struct inode *, s
 extern int nfs_attribute_timeout(struct inode *inode);
 extern int nfs_revalidate_inode(struct nfs_server *server, struct inode *inode);
 extern int __nfs_revalidate_inode(struct nfs_server *, struct inode *);
-extern void nfs_revalidate_mapping(struct inode *inode, struct address_space *mapping);
+extern int nfs_revalidate_mapping(struct inode *inode, struct address_space *mapping);
 extern int nfs_setattr(struct dentry *, struct iattr *);
 extern void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr);
 extern void nfs_begin_attr_update(struct inode *);

--=-tbn/+55Z9MzgsYCr7HXE--

