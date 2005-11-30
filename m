Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbVK3HK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVK3HK1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 02:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbVK3HK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 02:10:26 -0500
Received: from pat.uio.no ([129.240.130.16]:39382 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750828AbVK3HK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 02:10:26 -0500
Subject: Re: NFS cache consistancy appears to be broken...
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Steve Dickson <SteveD@redhat.com>
Cc: Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <438D0E80.2020905@RedHat.com>
References: <200510281607.j9SG7Tll024133@hera.kernel.org>
	 <438D0E80.2020905@RedHat.com>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 02:10:08 -0500
Message-Id: <1133334608.8010.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.956, required 12,
	autolearn=disabled, AWL 1.86, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-29 at 21:29 -0500, Steve Dickson wrote:
> Hey Trond,
> 
> The attached patch seems to break cache consistence in a big way....
> Doing the following:
> 1. On server:
> $ mkdir ~/t
> $ echo Hello > ~/t/tmp
> 
> 2. On client, wait for a string to appear in this file:
> $ until grep -q foo t/tmp ; do echo -n . ; sleep 1 ; done
> 
> 3. On server, create a *new* file with the same name containing that string:
> $ mv ~/t/tmp ~/t/tmp.old; echo foo > ~/t/tmp
> 
> will shows how the client will never (and I mean never ;-) ) see
> the updated file. I reverted this patch and everything started
> work as expected... so it appears using a jiffy-based cache
> verifiers may not be such a good idea....

There is nothing above that can possible race with a jiffy update, so
clearly there is something else at work here. To me it looks like there
is a mismatch between the way we update nfsi->cache_change_attribute and
its actual purpose.

The following patch fixes the "never update" issue for me. There is
still a lag between the time when the file is renamed on the server and
the time when the client notices this, but that can be attributed to
directory metadata caching.

Cheers,
 Trond
-------------------------------------------------
NFS: Fix a few cache consistency races

 Steve Dickson writes:

 The attached patch seems to break cache consistence in a big way....
 Doing the following:
 1. On server:
 $ mkdir ~/t
 $ echo Hello > ~/t/tmp

 2. On client, wait for a string to appear in this file:
 $ until grep -q foo t/tmp ; do echo -n . ; sleep 1 ; done

 3. On server, create a *new* file with the same name containing that
 string:
 $ mv ~/t/tmp ~/t/tmp.old; echo foo > ~/t/tmp

 will shows how the client will never (and I mean never ;-) ) see
 the updated file.

 Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
---

 fs/nfs/inode.c |   54 ++++++++++++++++++++----------------------------------
 1 files changed, 20 insertions(+), 34 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index aaab1a5..3100142 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -54,7 +54,7 @@
 #define NFS_MAX_READAHEAD	(RPC_DEF_SLOT_TABLE - 1)
 
 static void nfs_invalidate_inode(struct inode *);
-static int nfs_update_inode(struct inode *, struct nfs_fattr *, unsigned long);
+static int nfs_update_inode(struct inode *, struct nfs_fattr *);
 
 static struct inode *nfs_alloc_inode(struct super_block *sb);
 static void nfs_destroy_inode(struct inode *);
@@ -1080,8 +1080,6 @@ __nfs_revalidate_inode(struct nfs_server
 	int		 status = -ESTALE;
 	struct nfs_fattr fattr;
 	struct nfs_inode *nfsi = NFS_I(inode);
-	unsigned long verifier;
-	unsigned long cache_validity;
 
 	dfprintk(PAGECACHE, "NFS: revalidating (%s/%Ld)\n",
 		inode->i_sb->s_id, (long long)NFS_FILEID(inode));
@@ -1106,8 +1104,6 @@ __nfs_revalidate_inode(struct nfs_server
 		}
 	}
 
-	/* Protect against RPC races by saving the change attribute */
-	verifier = nfs_save_change_attribute(inode);
 	status = NFS_PROTO(inode)->getattr(server, NFS_FH(inode), &fattr);
 	if (status != 0) {
 		dfprintk(PAGECACHE, "nfs_revalidate_inode: (%s/%Ld) getattr failed, error=%d\n",
@@ -1122,7 +1118,7 @@ __nfs_revalidate_inode(struct nfs_server
 	}
 
 	spin_lock(&inode->i_lock);
-	status = nfs_update_inode(inode, &fattr, verifier);
+	status = nfs_update_inode(inode, &fattr);
 	if (status) {
 		spin_unlock(&inode->i_lock);
 		dfprintk(PAGECACHE, "nfs_revalidate_inode: (%s/%Ld) refresh failed, error=%d\n",
@@ -1130,20 +1126,11 @@ __nfs_revalidate_inode(struct nfs_server
 			 (long long)NFS_FILEID(inode), status);
 		goto out;
 	}
-	cache_validity = nfsi->cache_validity;
-	nfsi->cache_validity &= ~NFS_INO_REVAL_PAGECACHE;
-
-	/*
-	 * We may need to keep the attributes marked as invalid if
-	 * we raced with nfs_end_attr_update().
-	 */
-	if (time_after_eq(verifier, nfsi->cache_change_attribute))
-		nfsi->cache_validity &= ~(NFS_INO_INVALID_ATTR|NFS_INO_INVALID_ATIME);
 	spin_unlock(&inode->i_lock);
 
 	nfs_revalidate_mapping(inode, inode->i_mapping);
 
-	if (cache_validity & NFS_INO_INVALID_ACL)
+	if (nfsi->cache_validity & NFS_INO_INVALID_ACL)
 		nfs_zap_acl_cache(inode);
 
 	dfprintk(PAGECACHE, "NFS: (%s/%Ld) revalidation complete\n",
@@ -1346,10 +1333,8 @@ int nfs_refresh_inode(struct inode *inod
 		return 0;
 	spin_lock(&inode->i_lock);
 	nfsi->cache_validity &= ~NFS_INO_REVAL_PAGECACHE;
-	if (nfs_verify_change_attribute(inode, fattr->time_start))
-		nfsi->cache_validity &= ~(NFS_INO_INVALID_ATTR|NFS_INO_INVALID_ATIME);
 	if (time_after(fattr->time_start, nfsi->last_updated))
-		status = nfs_update_inode(inode, fattr, fattr->time_start);
+		status = nfs_update_inode(inode, fattr);
 	else
 		status = nfs_check_inode_attributes(inode, fattr);
 
@@ -1375,10 +1360,7 @@ int nfs_post_op_update_inode(struct inod
 		nfsi->cache_validity |= NFS_INO_INVALID_ATTR | NFS_INO_INVALID_ACCESS;
 		goto out;
 	}
-	status = nfs_update_inode(inode, fattr, fattr->time_start);
-	if (time_after_eq(fattr->time_start, nfsi->cache_change_attribute))
-		nfsi->cache_validity &= ~(NFS_INO_INVALID_ATTR|NFS_INO_INVALID_ATIME|NFS_INO_REVAL_PAGECACHE);
-	nfsi->cache_change_attribute = jiffies;
+	status = nfs_update_inode(inode, fattr);
 out:
 	spin_unlock(&inode->i_lock);
 	return status;
@@ -1396,12 +1378,12 @@ out:
  *
  * A very similar scenario holds for the dir cache.
  */
-static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr, unsigned long verifier)
+static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	loff_t cur_isize, new_isize;
 	unsigned int	invalid = 0;
-	int data_unstable;
+	int data_stable;
 
 	dfprintk(VFS, "NFS: %s(%s/%ld ct=%d info=0x%x)\n",
 			__FUNCTION__, inode->i_sb->s_id, inode->i_ino,
@@ -1432,8 +1414,9 @@ static int nfs_update_inode(struct inode
 	nfsi->last_updated = jiffies;
 
 	/* Are we racing with known updates of the metadata on the server? */
-	data_unstable = ! (nfs_verify_change_attribute(inode, verifier) ||
-		(nfsi->cache_validity & NFS_INO_REVAL_PAGECACHE));
+	data_stable = nfs_verify_change_attribute(inode, fattr->time_start);
+	if (data_stable)
+		nfsi->cache_validity &= ~(NFS_INO_INVALID_ATTR|NFS_INO_INVALID_ATIME);
 
 	/* Check if our cached file size is stale */
  	new_isize = nfs_size_to_loff_t(fattr->size);
@@ -1442,7 +1425,7 @@ static int nfs_update_inode(struct inode
 		/* Do we perhaps have any outstanding writes? */
 		if (nfsi->npages == 0) {
 			/* No, but did we race with nfs_end_data_update()? */
-			if (time_after_eq(verifier,  nfsi->cache_change_attribute)) {
+			if (data_stable) {
 				inode->i_size = new_isize;
 				invalid |= NFS_INO_INVALID_DATA;
 			}
@@ -1451,6 +1434,7 @@ static int nfs_update_inode(struct inode
 			inode->i_size = new_isize;
 			invalid |= NFS_INO_INVALID_ATTR|NFS_INO_INVALID_DATA;
 		}
+		nfsi->cache_change_attribute = jiffies;
 		dprintk("NFS: isize change on server for file %s/%ld\n",
 				inode->i_sb->s_id, inode->i_ino);
 	}
@@ -1460,8 +1444,8 @@ static int nfs_update_inode(struct inode
 		memcpy(&inode->i_mtime, &fattr->mtime, sizeof(inode->i_mtime));
 		dprintk("NFS: mtime change on server for file %s/%ld\n",
 				inode->i_sb->s_id, inode->i_ino);
-		if (!data_unstable)
-			invalid |= NFS_INO_INVALID_ATTR|NFS_INO_INVALID_DATA;
+		invalid |= NFS_INO_INVALID_ATTR|NFS_INO_INVALID_DATA;
+		nfsi->cache_change_attribute = jiffies;
 	}
 
 	if ((fattr->valid & NFS_ATTR_FATTR_V4)
@@ -1469,15 +1453,15 @@ static int nfs_update_inode(struct inode
 		dprintk("NFS: change_attr change on server for file %s/%ld\n",
 		       inode->i_sb->s_id, inode->i_ino);
 		nfsi->change_attr = fattr->change_attr;
-		if (!data_unstable)
-			invalid |= NFS_INO_INVALID_ATTR|NFS_INO_INVALID_DATA|NFS_INO_INVALID_ACCESS|NFS_INO_INVALID_ACL;
+		invalid |= NFS_INO_INVALID_ATTR|NFS_INO_INVALID_DATA|NFS_INO_INVALID_ACCESS|NFS_INO_INVALID_ACL;
+		nfsi->cache_change_attribute = jiffies;
 	}
 
 	/* If ctime has changed we should definitely clear access+acl caches */
 	if (!timespec_equal(&inode->i_ctime, &fattr->ctime)) {
-		if (!data_unstable)
-			invalid |= NFS_INO_INVALID_ACCESS|NFS_INO_INVALID_ACL;
+		invalid |= NFS_INO_INVALID_ACCESS|NFS_INO_INVALID_ACL;
 		memcpy(&inode->i_ctime, &fattr->ctime, sizeof(inode->i_ctime));
+		nfsi->cache_change_attribute = jiffies;
 	}
 	memcpy(&inode->i_atime, &fattr->atime, sizeof(inode->i_atime));
 
@@ -1515,6 +1499,8 @@ static int nfs_update_inode(struct inode
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)
 				|| S_ISLNK(inode->i_mode)))
 		invalid &= ~NFS_INO_INVALID_DATA;
+	if (data_stable)
+		invalid &= ~(NFS_INO_INVALID_ATTR|NFS_INO_INVALID_ATIME|NFS_INO_REVAL_PAGECACHE);
 	if (!nfs_have_delegation(inode, FMODE_READ))
 		nfsi->cache_validity |= invalid;
 


