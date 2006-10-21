Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992862AbWJUHR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992862AbWJUHR0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992874AbWJUHOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:14:47 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:29575 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992867AbWJUHOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:14:40 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 10 of 23] nfsd: change uses of f_{dentry, vfsmnt} to use f_path
Message-Id: <9832951bba5604a73a84.1161411455@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:35 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org, neilb@cse.unsw.edu.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
in the nfs server code.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

3 files changed, 14 insertions(+), 14 deletions(-)
fs/nfsd/nfs4state.c |   10 +++++-----
fs/nfsd/nfsctl.c    |    2 +-
fs/nfsd/vfs.c       |   16 ++++++++--------

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1310,7 +1310,7 @@ nfs4_file_downgrade(struct file *filp, u
 nfs4_file_downgrade(struct file *filp, unsigned int share_access)
 {
 	if (share_access & NFS4_SHARE_ACCESS_WRITE) {
-		put_write_access(filp->f_dentry->d_inode);
+		put_write_access(filp->f_path.dentry->d_inode);
 		filp->f_mode = (filp->f_mode | FMODE_READ) & ~FMODE_WRITE;
 	}
 }
@@ -1623,7 +1623,7 @@ nfs4_upgrade_open(struct svc_rqst *rqstp
 nfs4_upgrade_open(struct svc_rqst *rqstp, struct svc_fh *cur_fh, struct nfs4_stateid *stp, struct nfsd4_open *open)
 {
 	struct file *filp = stp->st_vfs_file;
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	unsigned int share_access, new_writer;
 	__be32 status;
 
@@ -1966,7 +1966,7 @@ static inline int
 static inline int
 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stateid *stp)
 {
-	return fhp->fh_dentry->d_inode != stp->st_vfs_file->f_dentry->d_inode;
+	return fhp->fh_dentry->d_inode != stp->st_vfs_file->f_path.dentry->d_inode;
 }
 
 static int
@@ -2863,7 +2863,7 @@ nfsd4_lockt(struct svc_rqst *rqstp, stru
 	 * only the dentry:inode set.
 	 */
 	memset(&file, 0, sizeof (struct file));
-	file.f_dentry = current_fh->fh_dentry;
+	file.f_path.dentry = current_fh->fh_dentry;
 
 	status = nfs_ok;
 	if (posix_test_lock(&file, &file_lock, &conflock)) {
@@ -2953,7 +2953,7 @@ check_for_locks(struct file *filp, struc
 check_for_locks(struct file *filp, struct nfs4_stateowner *lowner)
 {
 	struct file_lock **flpp;
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	int status = 0;
 
 	lock_kernel();
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -111,7 +111,7 @@ static ssize_t (*write_op[])(struct file
 
 static ssize_t nfsctl_transaction_write(struct file *file, const char __user *buf, size_t size, loff_t *pos)
 {
-	ino_t ino =  file->f_dentry->d_inode->i_ino;
+	ino_t ino =  file->f_path.dentry->d_inode->i_ino;
 	char *data;
 	ssize_t rv;
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -736,10 +736,10 @@ nfsd_sync(struct file *filp)
 nfsd_sync(struct file *filp)
 {
         int err;
-	struct inode *inode = filp->f_dentry->d_inode;
-	dprintk("nfsd: sync file %s\n", filp->f_dentry->d_name.name);
+	struct inode *inode = filp->f_path.dentry->d_inode;
+	dprintk("nfsd: sync file %s\n", filp->f_path.dentry->d_name.name);
 	mutex_lock(&inode->i_mutex);
-	err=nfsd_dosync(filp, filp->f_dentry, filp->f_op);
+	err=nfsd_dosync(filp, filp->f_path.dentry, filp->f_op);
 	mutex_unlock(&inode->i_mutex);
 
 	return err;
@@ -845,7 +845,7 @@ nfsd_vfs_read(struct svc_rqst *rqstp, st
 	int		host_err;
 
 	err = nfserr_perm;
-	inode = file->f_dentry->d_inode;
+	inode = file->f_path.dentry->d_inode;
 #ifdef MSNFS
 	if ((fhp->fh_export->ex_flags & NFSEXP_MSNFS) &&
 		(!lock_may_read(inode, offset, *count)))
@@ -883,7 +883,7 @@ nfsd_vfs_read(struct svc_rqst *rqstp, st
 		nfsdstats.io_read += host_err;
 		*count = host_err;
 		err = 0;
-		fsnotify_access(file->f_dentry);
+		fsnotify_access(file->f_path.dentry);
 	} else 
 		err = nfserrno(host_err);
 out:
@@ -917,11 +917,11 @@ nfsd_vfs_write(struct svc_rqst *rqstp, s
 	err = nfserr_perm;
 
 	if ((fhp->fh_export->ex_flags & NFSEXP_MSNFS) &&
-		(!lock_may_write(file->f_dentry->d_inode, offset, cnt)))
+		(!lock_may_write(file->f_path.dentry->d_inode, offset, cnt)))
 		goto out;
 #endif
 
-	dentry = file->f_dentry;
+	dentry = file->f_path.dentry;
 	inode = dentry->d_inode;
 	exp   = fhp->fh_export;
 
@@ -950,7 +950,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, s
 	set_fs(oldfs);
 	if (host_err >= 0) {
 		nfsdstats.io_write += cnt;
-		fsnotify_modify(file->f_dentry);
+		fsnotify_modify(file->f_path.dentry);
 	}
 
 	/* clear setuid/setgid flag after write */


