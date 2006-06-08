Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWFHOuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWFHOuG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 10:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWFHOuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 10:50:05 -0400
Received: from pat.uio.no ([129.240.10.4]:28668 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964851AbWFHOuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 10:50:03 -0400
Subject: Re: Still data corruption with LTP doio on 2.6.17rc
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andi Kleen <ak@suse.de>
Cc: neilb@cse.unsw.edu.au, resource@suse.de, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, okir@suse.de
In-Reply-To: <200606081244.13000.ak@suse.de>
References: <200606081244.13000.ak@suse.de>
Content-Type: multipart/mixed; boundary="=-IKSn8Ajk8uTDVBTQP4Ct"
Date: Thu, 08 Jun 2006 10:49:37 -0400
Message-Id: <1149778177.15644.19.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.12, required 12,
	autolearn=disabled, AWL 1.69, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IKSn8Ajk8uTDVBTQP4Ct
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2006-06-08 at 12:44 +0200, Andi Kleen wrote:
> I'm still seeing data corruption when running LTP over NFS
> between two 2.6.17rc* hosts. I already saw this before 2.6.16
> and reported.
> 
> Server is running knfsd 2.6.17-rc4-git9, client is running 2.6.17-rc6
> with nfsroot. Both x86-64 and SUSE 10.0 userland. The file system
> is exported as async and mounted with
> /dev/root / nfs rw,vers=2,rsize=4096,wsize=4096,hard,nolock,proto=udp,timeo=11,retrans=2,addr=10.23.204.1 0 0
> 
> First I always get lots of
> 
> do_vfs_lock: VFS is out of sync with lock manager!
> 
> messages on the client. They don't seem to be directly related though. 
> 
> I set up ltp-full-20051103 on the NFS root and run it on the client
> with runltplite.sh. Eventually it reports
> 
> 
> <<<test_start>>>
> tag=rwtest03 stime=1149754762
> cmdline="export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:mm-buff-$$"
> contacts=""
> analysis=exit
> initiation_status="ok"
> <<<test_output>>>
> 
> doio(rwtest03) ( 8155) 08:19:23
> ---------------------
> *** DATA COMPARISON ERROR ***
> check_file(/tmp/ltp-2256/mm-buff-8139, 7813848, 81293, U:8155:bigfoot:doio*, 20, 0) failed
> 
> Comparison fd is 3, with open flags 0
> Corrupt regions follow - unprintable chars are represented as '.'
> -----------------------------------------------------------------
> corrupt bytes starting at file offset 7813848
>     1st 32 expected bytes:  U:8155:bigfoot:doio*U:8155:bigfo
>     1st 32 actual bytes:    ................................
> 
> Request number 36
>           fd 4 is file /tmp/ltp-2256/mm-buff-8139 - open flags are 02 O_RDWR,
>           write done at file offset 7813848 - pattern is U (0125)
>           number of requests is 1, strides per request is 1
>           i/o byte count = 81293
>           memory alignment is unaligned
> 
> syscall:  mmap-write(NULL, 12800000, PROT_WRITE, MAP_SHARED, 4, 0)
>         file is mmaped to: 0x2b73b87f0000
>         file-mem=0x2b73b8f63ad8, length=81293, buffer=0x52d540
> 
> 
> est03) ( 8152) 08:19:23
> ---------------------
> (parent) pid 8155 exited because of data compare errors

mmap() is still not 100% safe when the client believes that the file has
changed on the server and needs to call invalidate_inode_pages2(): if
there is dirty data on the page when unmap_mapping_range() gets called,
then that dirty data may be lost (basically, we need a VM helper that
does unmap+flush+invalidate_page).

The attached patch may, however reduce the number of calls to
invalidate_inode_pages2() since it ensures that revalidations only occur
if and when we're going to read from the page cache (i.e. in places when
we _need_ the assurance that the page cache is valid).

Cheers,
  Trond


--=-IKSn8Ajk8uTDVBTQP4Ct
Content-Disposition: inline; filename=linux-2.6.17-009-reduce_number_invalidations.dif
Content-Type: text/plain; name=linux-2.6.17-009-reduce_number_invalidations.dif; charset=utf-8
Content-Transfer-Encoding: 7bit

NFS: Separate metadata and page cache revalidation mechanisms

From: Trond Myklebust <Trond.Myklebust@netapp.com>

Separate out the function of revalidating the inode metadata, and
revalidating the mapping. The former may be called by lookup(),
and only really needs to check that permissions, ctime, etc haven't changed
whereas the latter needs only done when we want to read data from the page
cache, and may need to sync and then invalidate the mapping.

Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/dir.c           |    2 +-
 fs/nfs/file.c          |   24 +++---------------------
 fs/nfs/inode.c         |   16 +++++++++++-----
 fs/nfs/symlink.c       |    2 +-
 include/linux/nfs_fs.h |    2 +-
 5 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index cae74dd..1d3d892 100644
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
index eddd0e9..69036ef 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1220,7 +1220,7 @@ __nfs_revalidate_inode(struct nfs_server
 		status = -ESTALE;
 		/* Do we trust the cached ESTALE? */
 		if (NFS_ATTRTIMEO(inode) != 0) {
-			if (nfsi->cache_validity & (NFS_INO_INVALID_ATTR|NFS_INO_INVALID_DATA|NFS_INO_INVALID_ATIME)) {
+			if (nfsi->cache_validity & (NFS_INO_INVALID_ATTR|NFS_INO_INVALID_ATIME)) {
 				/* no */
 			} else
 				goto out;
@@ -1251,8 +1251,6 @@ __nfs_revalidate_inode(struct nfs_server
 	}
 	spin_unlock(&inode->i_lock);
 
-	nfs_revalidate_mapping(inode, inode->i_mapping);
-
 	if (nfsi->cache_validity & NFS_INO_INVALID_ACL)
 		nfs_zap_acl_cache(inode);
 
@@ -1287,7 +1285,7 @@ int nfs_attribute_timeout(struct inode *
 int nfs_revalidate_inode(struct nfs_server *server, struct inode *inode)
 {
 	nfs_inc_stats(inode, NFSIOS_INODEREVALIDATE);
-	if (!(NFS_I(inode)->cache_validity & (NFS_INO_INVALID_ATTR|NFS_INO_INVALID_DATA))
+	if (!(NFS_I(inode)->cache_validity & NFS_INO_INVALID_ATTR)
 			&& !nfs_attribute_timeout(inode))
 		return NFS_STALE(inode) ? -ESTALE : 0;
 	return __nfs_revalidate_inode(server, inode);
@@ -1298,9 +1296,16 @@ int nfs_revalidate_inode(struct nfs_serv
  * @inode - pointer to host inode
  * @mapping - pointer to mapping
  */
-void nfs_revalidate_mapping(struct inode *inode, struct address_space *mapping)
+int nfs_revalidate_mapping(struct inode *inode, struct address_space *mapping)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
+	int ret = 0;
+
+	if (NFS_STALE(inode))
+		ret = -ESTALE;
+	if ((nfsi->cache_validity & NFS_INO_REVAL_PAGECACHE)
+			|| nfs_attribute_timeout(inode))
+		ret = __nfs_revalidate_inode(NFS_SERVER(inode), inode);
 
 	if (nfsi->cache_validity & NFS_INO_INVALID_DATA) {
 		nfs_inc_stats(inode, NFSIOS_DATAINVALIDATE);
@@ -1321,6 +1326,7 @@ void nfs_revalidate_mapping(struct inode
 				inode->i_sb->s_id,
 				(long long)NFS_FILEID(inode));
 	}
+	return ret;
 }
 
 /**
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
index 1d81e7d..1b524b9 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -301,7 +301,7 @@ extern int nfs_release(struct inode *, s
 extern int nfs_attribute_timeout(struct inode *inode);
 extern int nfs_revalidate_inode(struct nfs_server *server, struct inode *inode);
 extern int __nfs_revalidate_inode(struct nfs_server *, struct inode *);
-extern void nfs_revalidate_mapping(struct inode *inode, struct address_space *mapping);
+extern int nfs_revalidate_mapping(struct inode *inode, struct address_space *mapping);
 extern int nfs_setattr(struct dentry *, struct iattr *);
 extern void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr);
 extern void nfs_begin_attr_update(struct inode *);

--=-IKSn8Ajk8uTDVBTQP4Ct--

