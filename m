Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932486AbVJaWx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932486AbVJaWx1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVJaWx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:53:27 -0500
Received: from ns.suse.de ([195.135.220.2]:49053 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932486AbVJaWx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:53:26 -0500
From: Neil Brown <neilb@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: Tue, 1 Nov 2005 09:53:20 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17254.41056.197429.949418@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH against 2.6.14] truncate() or ftruncate shouldn't
	change mtime if size doesn't change.
In-Reply-To: message from Trond Myklebust on Monday October 31
References: <20051031173358.9566.patches@notabene>
	<1051031063444.9586@suse.de>
	<1130763105.8802.23.camel@lade.trondhjem.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 31, trond.myklebust@fys.uio.no wrote:
> 
> What we can, however, do is to ensure that truncate() and ftruncate()
> only set ATTR_SIZE, but ensure that may_open() sets ATTR_MTIME|
> ATTR_CTIME as well.

Thanks.  This makes lots of sense, in that it gives power to the
filesystem.  We should keep the optimisations in placed where the
filesystem can over-ride them, just as inode_setattr.

So, here is a revised patch.
Comment?

Thanks,
NeilBrown


------------------
Fix some problems with truncate and mtime semantics.

SUS requires that when truncating a file to the size that it currently
is:
  truncate and ftruncate should NOT modify ctime or mtime
  O_TRUNC SHOULD modify ctime and mtime.

Currently mtime and ctime are always modified on most local
filesystems (side effect of ->truncate) or never modified (on NFS).

With this patch:
  ATTR_CTIME|ATTR_MTIME are sent with ATTR_SIZE precisely when 
    an update of these times is required whether size changes or not 
    (via a new argument to do_truncate).  This allows NFS to do
    the right thing for O_TRUNC.
  inode_setattr no longer forces ATTR_MTIME|ATTR_CTIME when the ATTR_SIZE
    sets the size to it's current value.  This allows local filesystems
    to do the right thing for f?truncate.
  
Also, the logic in inode_setattr is changed a bit so there are two
return points.  One returns the error from vmtruncate if it failed,
the other returns 0 (there can be no other failure).

Finally, if vmtruncate succeeds, and ATTR_SIZE is the only change
requested, we now fall-through and mark_inode_dirty.  If a filesystem
did not have a ->truncate function, then vmtruncate will have changed
i_size, without marking the inode as 'dirty', and I think this is wrong.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/attr.c          |   22 +++++++---------------
 ./fs/exec.c          |    2 +-
 ./fs/namei.c         |    2 +-
 ./fs/open.c          |    8 ++++----
 ./include/linux/fs.h |    2 +-
 5 files changed, 14 insertions(+), 22 deletions(-)

diff ./fs/attr.c~current~ ./fs/attr.c
--- ./fs/attr.c~current~	2005-11-01 09:42:22.000000000 +1100
+++ ./fs/attr.c	2005-11-01 09:22:40.000000000 +1100
@@ -67,20 +67,12 @@ EXPORT_SYMBOL(inode_change_ok);
 int inode_setattr(struct inode * inode, struct iattr * attr)
 {
 	unsigned int ia_valid = attr->ia_valid;
-	int error = 0;
 
-	if (ia_valid & ATTR_SIZE) {
-		if (attr->ia_size != i_size_read(inode)) {
-			error = vmtruncate(inode, attr->ia_size);
-			if (error || (ia_valid == ATTR_SIZE))
-				goto out;
-		} else {
-			/*
-			 * We skipped the truncate but must still update
-			 * timestamps
-			 */
-			ia_valid |= ATTR_MTIME|ATTR_CTIME;
-		}
+	if (ia_valid & ATTR_SIZE &&
+	    attr->ia_size != i_size_read(inode)) {
+		int error = vmtruncate(inode, attr->ia_size);
+		if (error)
+			return error;
 	}
 
 	if (ia_valid & ATTR_UID)
@@ -104,8 +96,8 @@ int inode_setattr(struct inode * inode, 
 		inode->i_mode = mode;
 	}
 	mark_inode_dirty(inode);
-out:
-	return error;
+
+	return 0;
 }
 EXPORT_SYMBOL(inode_setattr);
 

diff ./fs/exec.c~current~ ./fs/exec.c
--- ./fs/exec.c~current~	2005-11-01 09:42:22.000000000 +1100
+++ ./fs/exec.c	2005-11-01 09:19:35.000000000 +1100
@@ -1510,7 +1510,7 @@ int do_coredump(long signr, int exit_cod
 		goto close_fail;
 	if (!file->f_op->write)
 		goto close_fail;
-	if (do_truncate(file->f_dentry, 0) != 0)
+	if (do_truncate(file->f_dentry, 0, 0) != 0)
 		goto close_fail;
 
 	retval = binfmt->core_dump(signr, regs, file);

diff ./fs/namei.c~current~ ./fs/namei.c
--- ./fs/namei.c~current~	2005-11-01 09:42:22.000000000 +1100
+++ ./fs/namei.c	2005-11-01 09:24:34.000000000 +1100
@@ -1459,7 +1459,7 @@ int may_open(struct nameidata *nd, int a
 		if (!error) {
 			DQUOT_INIT(inode);
 			
-			error = do_truncate(dentry, 0);
+			error = do_truncate(dentry, 0, ATTR_MTIME|ATTR_CTIME);
 		}
 		put_write_access(inode);
 		if (error)

diff ./fs/open.c~current~ ./fs/open.c
--- ./fs/open.c~current~	2005-11-01 09:42:22.000000000 +1100
+++ ./fs/open.c	2005-11-01 09:42:26.000000000 +1100
@@ -194,7 +194,7 @@ out:
 	return error;
 }
 
-int do_truncate(struct dentry *dentry, loff_t length)
+int do_truncate(struct dentry *dentry, loff_t length, unsigned int time_attrs)
 {
 	int err;
 	struct iattr newattrs;
@@ -204,7 +204,7 @@ int do_truncate(struct dentry *dentry, l
 		return -EINVAL;
 
 	newattrs.ia_size = length;
-	newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
+	newattrs.ia_valid = ATTR_SIZE | time_attrs;
 
 	down(&dentry->d_inode->i_sem);
 	err = notify_change(dentry, &newattrs);
@@ -262,7 +262,7 @@ static inline long do_sys_truncate(const
 	error = locks_verify_truncate(inode, NULL, length);
 	if (!error) {
 		DQUOT_INIT(inode);
-		error = do_truncate(nd.dentry, length);
+		error = do_truncate(nd.dentry, length, 0);
 	}
 	put_write_access(inode);
 
@@ -314,7 +314,7 @@ static inline long do_sys_ftruncate(unsi
 
 	error = locks_verify_truncate(inode, file, length);
 	if (!error)
-		error = do_truncate(dentry, length);
+		error = do_truncate(dentry, length, 0);
 out_putf:
 	fput(file);
 out:

diff ./include/linux/fs.h~current~ ./include/linux/fs.h
--- ./include/linux/fs.h~current~	2005-11-01 09:42:22.000000000 +1100
+++ ./include/linux/fs.h	2005-11-01 09:18:35.000000000 +1100
@@ -1295,7 +1295,7 @@ static inline int break_lease(struct ino
 
 /* fs/open.c */
 
-extern int do_truncate(struct dentry *, loff_t start);
+extern int do_truncate(struct dentry *, loff_t start, unsigned int time_attrs);
 extern long do_sys_open(const char __user *filename, int flags, int mode);
 extern struct file *filp_open(const char *, int, int);
 extern struct file * dentry_open(struct dentry *, struct vfsmount *, int);
