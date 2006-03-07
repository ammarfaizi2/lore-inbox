Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752499AbWCGMlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbWCGMlO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 07:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbWCGMlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 07:41:14 -0500
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:17820 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1752499AbWCGMlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 07:41:13 -0500
Date: Tue, 7 Mar 2006 07:43:04 -0500
From: Latchesar Ionkov <lucho@advancedsolutions.com>
To: akpm@osdl.org
Cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       v9fs-developer@lists.sourceforge.net
Subject: [PATCH] v9fs: fix for access to unitialized variables or freed memory
Message-ID: <20060307124304.GA15195@ionkov.net>
References: <20060306070456.GA16478@redhat.com> <f158dc670603061749t18196e63tab3409441942ac3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f158dc670603061749t18196e63tab3409441942ac3@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miscellaneous fixes related to accessing uninitialized variables or memory
that was already freed. Adds function declarations missed in
v9fs-print-9p-messages.patch.

Signed-off-by: Latchesar Ionkov <lucho@ionkov.net>

---
commit f6abafa691503c0a0c8663a1797c867f0f87f13a
tree c3b48d2342dacf62f7b3ce01b72d5a5ec7511481
parent 066de5e57e6c8c8a1e0a6c49a342118f474b21e9
author Latchesar Ionkov <lucho@ionkov.net> Tue, 07 Mar 2006 07:35:04 -0500
committer Latchesar Ionkov <lucho@ionkov.net> Tue, 07 Mar 2006 07:35:04 -0500

 fs/9p/9p.c        |    1 -
 fs/9p/9p.h        |    3 +++
 fs/9p/trans_fd.c  |    1 +
 fs/9p/vfs_inode.c |    8 +++-----
 fs/9p/vfs_super.c |    1 -
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/9p/9p.c b/fs/9p/9p.c
index 1a6d087..f86a28d 100644
--- a/fs/9p/9p.c
+++ b/fs/9p/9p.c
@@ -111,7 +111,6 @@ static void v9fs_t_clunk_cb(void *a, str
 	if (!rc)
 		return;
 
-	dprintk(DEBUG_9P, "tcall id %d rcall id %d\n", tc->id, rc->id);
 	v9ses = a;
 	if (rc->id == RCLUNK)
 		v9fs_put_idpool(fid, &v9ses->fidpool);
diff --git a/fs/9p/9p.h b/fs/9p/9p.h
index 0cd374d..bb8cbac 100644
--- a/fs/9p/9p.h
+++ b/fs/9p/9p.h
@@ -374,3 +374,6 @@ int v9fs_t_read(struct v9fs_session_info
 int v9fs_t_write(struct v9fs_session_info *v9ses, u32 fid, u64 offset,
 		 u32 count, const char __user * data,
 		 struct v9fs_fcall **rcall);
+int v9fs_printfcall(char *, int, struct v9fs_fcall *, int);
+int v9fs_dumpdata(char *, int, u8 *, int);
+int v9fs_printstat(char *, int, struct v9fs_stat *, int);
diff --git a/fs/9p/trans_fd.c b/fs/9p/trans_fd.c
index 1a28ef9..5b2ce21 100644
--- a/fs/9p/trans_fd.c
+++ b/fs/9p/trans_fd.c
@@ -80,6 +80,7 @@ static int v9fs_fd_send(struct v9fs_tran
 	if (!trans || trans->status != Connected || !ts)
 		return -EIO;
 
+	oldfs = get_fs();
 	set_fs(get_ds());
 	/* The cast to a user pointer is valid due to the set_fs() */
 	ret = vfs_write(ts->out_file, (void __user *)v, len, &ts->out_file->f_pos);
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index dce729d..3ad8455 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -265,8 +265,7 @@ v9fs_create(struct v9fs_session_info *v9
 	fid = v9fs_get_idpool(&v9ses->fidpool);
 	if (fid < 0) {
 		eprintk(KERN_WARNING, "no free fids available\n");
-		err = -ENOSPC;
-		goto error;
+		return -ENOSPC;
 	}
 
 	err = v9fs_t_walk(v9ses, pfid, fid, NULL, &fcall);
@@ -313,8 +312,7 @@ v9fs_clone_walk(struct v9fs_session_info
 	nfid = v9fs_get_idpool(&v9ses->fidpool);
 	if (nfid < 0) {
 		eprintk(KERN_WARNING, "no free fids available\n");
-		err = -ENOSPC;
-		goto error;
+		return ERR_PTR(-ENOSPC);
 	}
 
 	err = v9fs_t_walk(v9ses, fid, nfid, (char *) dentry->d_name.name,
@@ -612,7 +610,7 @@ static struct dentry *v9fs_vfs_lookup(st
 	int result = 0;
 
 	dprintk(DEBUG_VFS, "dir: %p dentry: (%s) %p nameidata: %p\n",
-		dir, dentry->d_iname, dentry, nameidata);
+		dir, dentry->d_name.name, dentry, nameidata);
 
 	sb = dir->i_sb;
 	v9ses = v9fs_inode2v9ses(dir);
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index cdf787e..d05318f 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -156,7 +156,6 @@ static struct super_block *v9fs_get_sb(s
 	stat_result = v9fs_t_stat(v9ses, newfid, &fcall);
 	if (stat_result < 0) {
 		dprintk(DEBUG_ERROR, "stat error\n");
-		kfree(fcall);
 		v9fs_t_clunk(v9ses, newfid);
 	} else {
 		/* Setup the Root Inode */
