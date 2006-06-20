Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWFTRmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWFTRmf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 13:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWFTRmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 13:42:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62145 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750720AbWFTRmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 13:42:35 -0400
Subject: Re: 2.6.17-rc6-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060608050047.GB16729@redhat.com>
References: <20060607104724.c5d3d730.akpm@osdl.org>
	 <20060608050047.GB16729@redhat.com>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 19:42:29 +0200
Message-Id: <1150825349.2891.219.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 01:00 -0400, Dave Jones wrote:
> On Wed, Jun 07, 2006 at 10:47:24AM -0700, Andrew Morton wrote:
>  > 
>  > ftp://ftp.kernel.org/pub/linux/kernel/peopleD/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/
>  > 
>  > - Many more lockdep updates
> 
> Needs more.
> 
> ====================================
> [ BUG: possible deadlock detected! ]
> ------------------------------------
> nfsd/11429 is trying to acquire lock:
>  (&inode->i_mutex){--..}, at: [<c032286a>] mutex_lock+0x21/0x24
> 
> but task is already holding lock:
>  (&inode->i_mutex){--..}, at: [<c032286a>] mutex_lock+0x21/0x24
> 
> which could potentially lead to deadlocks!

Does this fix it for you? (it fixes the case for me)

---
 fs/nfsd/vfs.c              |   10 +++++-----
 include/linux/nfsd/nfsd.h  |    1 -
 include/linux/nfsd/nfsfh.h |   31 +++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 6 deletions(-)

Index: linux-2.6.17-rc6-mm2/fs/nfsd/vfs.c
===================================================================
--- linux-2.6.17-rc6-mm2.orig/fs/nfsd/vfs.c
+++ linux-2.6.17-rc6-mm2/fs/nfsd/vfs.c
@@ -1115,7 +1115,7 @@ nfsd_create(struct svc_rqst *rqstp, stru
 	 */
 	if (!resfhp->fh_dentry) {
 		/* called from nfsd_proc_mkdir, or possibly nfsd3_proc_create */
-		fh_lock(fhp);
+		fh_lock_parent(fhp);
 		dchild = lookup_one_len(fname, dentry, flen);
 		err = PTR_ERR(dchild);
 		if (IS_ERR(dchild))
@@ -1241,7 +1241,7 @@ nfsd_create_v3(struct svc_rqst *rqstp, s
 	err = nfserr_notdir;
 	if(!dirp->i_op || !dirp->i_op->lookup)
 		goto out;
-	fh_lock(fhp);
+	fh_lock_parent(fhp);
 
 	/*
 	 * Compose the response file handle.
@@ -1426,7 +1426,7 @@ nfsd_symlink(struct svc_rqst *rqstp, str
 	err = fh_verify(rqstp, fhp, S_IFDIR, MAY_CREATE);
 	if (err)
 		goto out;
-	fh_lock(fhp);
+	fh_lock_parent(fhp);
 	dentry = fhp->fh_dentry;
 	dnew = lookup_one_len(fname, dentry, flen);
 	err = PTR_ERR(dnew);
@@ -1495,7 +1495,7 @@ nfsd_link(struct svc_rqst *rqstp, struct
 	if (isdotent(name, len))
 		goto out;
 
-	fh_lock(ffhp);
+	fh_lock_parent(ffhp);
 	ddir = ffhp->fh_dentry;
 	dirp = ddir->d_inode;
 
@@ -1644,7 +1644,7 @@ nfsd_unlink(struct svc_rqst *rqstp, stru
 	if (err)
 		goto out;
 
-	fh_lock(fhp);
+	fh_lock_parent(fhp);
 	dentry = fhp->fh_dentry;
 	dirp = dentry->d_inode;
 
Index: linux-2.6.17-rc6-mm2/include/linux/nfsd/nfsd.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/include/linux/nfsd/nfsd.h
+++ linux-2.6.17-rc6-mm2/include/linux/nfsd/nfsd.h
@@ -67,7 +67,6 @@ int		nfsd_svc(unsigned short port, int n
 int		nfsd_dispatch(struct svc_rqst *rqstp, u32 *statp);
 
 /* nfsd/vfs.c */
-int		fh_lock_parent(struct svc_fh *, struct dentry *);
 int		nfsd_racache_init(int);
 void		nfsd_racache_shutdown(void);
 int		nfsd_cross_mnt(struct svc_rqst *rqstp, struct dentry **dpp,
Index: linux-2.6.17-rc6-mm2/include/linux/nfsd/nfsfh.h
===================================================================
--- linux-2.6.17-rc6-mm2.orig/include/linux/nfsd/nfsfh.h
+++ linux-2.6.17-rc6-mm2/include/linux/nfsd/nfsfh.h
@@ -322,6 +322,37 @@ fh_lock(struct svc_fh *fhp)
 }
 
 /*
+ * Lock a file handle/inode to be used as parent dir for another
+ * NOTE: both fh_lock and fh_unlock are done "by hand" in
+ * vfs.c:nfsd_rename as it needs to grab 2 i_mutex's at once
+ * so, any changes here should be reflected there.
+ */
+static inline void
+fh_lock_parent(struct svc_fh *fhp)
+{
+	struct dentry	*dentry = fhp->fh_dentry;
+	struct inode	*inode;
+
+	dfprintk(FILEOP, "nfsd: fh_lock(%s) locked = %d\n",
+			SVCFH_fmt(fhp), fhp->fh_locked);
+
+	if (!fhp->fh_dentry) {
+		printk(KERN_ERR "fh_lock: fh not verified!\n");
+		return;
+	}
+	if (fhp->fh_locked) {
+		printk(KERN_WARNING "fh_lock: %s/%s already locked!\n",
+			dentry->d_parent->d_name.name, dentry->d_name.name);
+		return;
+	}
+
+	inode = dentry->d_inode;
+	mutex_lock_nested(&inode->i_mutex, I_MUTEX_PARENT);
+	fill_pre_wcc(fhp);
+	fhp->fh_locked = 1;
+}
+
+/*
  * Unlock a file handle/inode
  */
 static inline void


