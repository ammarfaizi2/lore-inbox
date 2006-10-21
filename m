Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992838AbWJUHUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992838AbWJUHUR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992789AbWJUHNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:13:55 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:14215 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S2992835AbWJUHN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:13:27 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 16 of 23] 9p: change uses of f_{dentry,vfsmnt} to use f_path
Message-Id: <89bde14feaea48bc9048.1161411461@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1161411445@thor.fsl.cs.sunysb.edu>
Date: Sat, 21 Oct 2006 02:17:41 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, hch@infradead.org, ericvh@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch changes all the uses of f_{dentry,vfsmnt} to f_path.{dentry,mnt}
in the 9p filesystem.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

3 files changed, 7 insertions(+), 7 deletions(-)
fs/9p/vfs_addr.c |    2 +-
fs/9p/vfs_dir.c  |    4 ++--
fs/9p/vfs_file.c |    8 ++++----

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -54,7 +54,7 @@ static int v9fs_vfs_readpage(struct file
 	int retval = -EIO;
 	loff_t offset = page_offset(page);
 	int count = PAGE_CACHE_SIZE;
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
 	int rsize = v9ses->maxdata - V9FS_IOHDRSZ;
 	struct v9fs_fid *v9f = filp->private_data;
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -70,7 +70,7 @@ static int v9fs_dir_readdir(struct file 
 static int v9fs_dir_readdir(struct file *filp, void *dirent, filldir_t filldir)
 {
 	struct v9fs_fcall *fcall = NULL;
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
 	struct v9fs_fid *file = filp->private_data;
 	unsigned int i, n, s;
@@ -79,7 +79,7 @@ static int v9fs_dir_readdir(struct file 
 	struct v9fs_stat stat;
 	int over = 0;
 
-	dprintk(DEBUG_VFS, "name %s\n", filp->f_dentry->d_name.name);
+	dprintk(DEBUG_VFS, "name %s\n", filp->f_path.dentry->d_name.name);
 
 	fid = file->fid;
 
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -59,7 +59,7 @@ int v9fs_file_open(struct inode *inode, 
 
 	dprintk(DEBUG_VFS, "inode: %p file: %p \n", inode, file);
 
-	vfid = v9fs_fid_lookup(file->f_dentry);
+	vfid = v9fs_fid_lookup(file->f_path.dentry);
 	if (!vfid) {
 		dprintk(DEBUG_ERROR, "Couldn't resolve fid from dentry\n");
 		return -EBADF;
@@ -132,7 +132,7 @@ static int v9fs_file_lock(struct file *f
 static int v9fs_file_lock(struct file *filp, int cmd, struct file_lock *fl)
 {
 	int res = 0;
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 
 	dprintk(DEBUG_VFS, "filp: %p lock: %p\n", filp, fl);
 
@@ -160,7 +160,7 @@ v9fs_file_read(struct file *filp, char _
 v9fs_file_read(struct file *filp, char __user * data, size_t count,
 	       loff_t * offset)
 {
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
 	struct v9fs_fid *v9f = filp->private_data;
 	struct v9fs_fcall *fcall = NULL;
@@ -224,7 +224,7 @@ v9fs_file_write(struct file *filp, const
 v9fs_file_write(struct file *filp, const char __user * data,
 		size_t count, loff_t * offset)
 {
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct inode *inode = filp->f_path.dentry->d_inode;
 	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
 	struct v9fs_fid *v9fid = filp->private_data;
 	struct v9fs_fcall *fcall;


