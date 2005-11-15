Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVKOCAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVKOCAX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 21:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVKOCAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 21:00:23 -0500
Received: from ns2.suse.de ([195.135.220.15]:44753 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932272AbVKOCAX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 21:00:23 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 15 Nov 2005 13:00:02 +1100
Message-Id: <1051115020002.9459@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: [PATCH ] Fix some problems with truncate and mtime semantics.
References: <20051115125657.9403.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resubmitting this patch to fix truncate/mtime semantics.  

It is against 2.6.14-mm2 and is probably suitable for 2.6.15, but can
be held over to 2.6.16 if you are feeling cautious.

NeilBrown

### Comments for Changeset

SUS requires that when truncating a file to the size that it currently
is:
  truncate and ftruncate should NOT modify ctime or mtime
  O_EXCL SHOULD modify ctime and mtime.

Currently mtime and ctime are always modified on most local
filesystems (side effect of ->truncate) or never modified (on NFS).

With this patch:
  ATTR_CTIME|ATTR_MTIME are sent with ATTR_SIZE precisely when 
    an update of these times is required whether size changes or not 
    (via a new argument to do_truncate).  This allows NFS to do
    the right thing for O_EXCL.
  inode_setattr nolonger forces ATTR_MTIME|ATTR_CTIME when the ATTR_SIZE
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
 ./fs/open.c          |    9 +++++----
 ./include/linux/fs.h |    3 ++-
 5 files changed, 16 insertions(+), 22 deletions(-)

diff ./fs/attr.c~current~ ./fs/attr.c
--- ./fs/attr.c~current~	2005-11-15 10:29:55.000000000 +1100
+++ ./fs/attr.c	2005-11-15 10:29:55.000000000 +1100
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
--- ./fs/exec.c~current~	2005-11-15 10:29:55.000000000 +1100
+++ ./fs/exec.c	2005-11-15 10:29:55.000000000 +1100
@@ -1516,7 +1516,7 @@ int do_coredump(long signr, int exit_cod
 		goto close_fail;
 	if (!file->f_op->write)
 		goto close_fail;
-	if (do_truncate(file->f_dentry, 0, file) != 0)
+	if (do_truncate(file->f_dentry, 0, 0, file) != 0)
 		goto close_fail;
 
 	retval = binfmt->core_dump(signr, regs, file);

diff ./fs/namei.c~current~ ./fs/namei.c
--- ./fs/namei.c~current~	2005-11-15 10:29:55.000000000 +1100
+++ ./fs/namei.c	2005-11-15 10:29:55.000000000 +1100
@@ -1491,7 +1491,7 @@ int may_open(struct nameidata *nd, int a
 		if (!error) {
 			DQUOT_INIT(inode);
 			
-			error = do_truncate(dentry, 0, NULL);
+			error = do_truncate(dentry, 0, ATTR_MTIME|ATTR_CTIME, NULL);
 		}
 		put_write_access(inode);
 		if (error)

diff ./fs/open.c~current~ ./fs/open.c
--- ./fs/open.c~current~	2005-11-15 10:29:55.000000000 +1100
+++ ./fs/open.c	2005-11-15 10:29:55.000000000 +1100
@@ -194,7 +194,8 @@ out:
 	return error;
 }
 
-int do_truncate(struct dentry *dentry, loff_t length, struct file *filp)
+int do_truncate(struct dentry *dentry, loff_t length, unsigned int time_attrs,
+	struct file *filp)
 {
 	int err;
 	struct iattr newattrs;
@@ -204,7 +205,7 @@ int do_truncate(struct dentry *dentry, l
 		return -EINVAL;
 
 	newattrs.ia_size = length;
-	newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME;
+	newattrs.ia_valid = ATTR_SIZE | time_attrs;
 	if (filp) {
 		newattrs.ia_file = filp;
 		newattrs.ia_valid |= ATTR_FILE;
@@ -266,7 +267,7 @@ static inline long do_sys_truncate(const
 	error = locks_verify_truncate(inode, NULL, length);
 	if (!error) {
 		DQUOT_INIT(inode);
-		error = do_truncate(nd.dentry, length, NULL);
+		error = do_truncate(nd.dentry, length, 0, NULL);
 	}
 	put_write_access(inode);
 
@@ -318,7 +319,7 @@ static inline long do_sys_ftruncate(unsi
 
 	error = locks_verify_truncate(inode, file, length);
 	if (!error)
-		error = do_truncate(dentry, length, file);
+		error = do_truncate(dentry, length, 0, file);
 out_putf:
 	fput(file);
 out:

diff ./include/linux/fs.h~current~ ./include/linux/fs.h
--- ./include/linux/fs.h~current~	2005-11-15 10:29:55.000000000 +1100
+++ ./include/linux/fs.h	2005-11-15 10:29:55.000000000 +1100
@@ -1340,7 +1340,8 @@ static inline int break_lease(struct ino
 
 /* fs/open.c */
 
-extern int do_truncate(struct dentry *, loff_t start, struct file *filp);
+extern int do_truncate(struct dentry *, loff_t start, unsigned int time_attrs,
+		       struct file *filp);
 extern long do_sys_open(const char __user *filename, int flags, int mode);
 extern struct file *filp_open(const char *, int, int);
 extern struct file * dentry_open(struct dentry *, struct vfsmount *, int);
