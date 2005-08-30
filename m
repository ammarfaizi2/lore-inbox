Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbVHaAG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbVHaAG6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 20:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVHaAG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 20:06:58 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:32452 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932294AbVHaAG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 20:06:57 -0400
Date: Wed, 31 Aug 2005 09:58:24 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jens Axboe <axboe@suse.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk queue io tracing support
Message-ID: <20050830235824.GG780@frodo>
References: <20050823123235.GG16461@suse.de> <20050824010346.GA1021@frodo> <20050824070809.GA27956@suse.de> <20050824171931.H4209301@wobbly.melbourne.sgi.com> <20050824072501.GA27992@suse.de> <20050824092838.GB28272@suse.de> <20050830234823.GF780@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830234823.GF780@frodo>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Wed, Aug 31, 2005 at 09:48:23AM +1000, Nathan Scott wrote:
> ...
> # find /relay
> /relay
> /relay/block
> /relay/block/sdd
> /relay/block/sdd/trace3
> /relay/block/sdd/trace2
> /relay/block/sdd/trace1
> /relay/block/sdd/trace0
> /relay/block/sdb
> /relay/block/sdb/trace3
> /relay/block/sdb/trace2
> /relay/block/sdb/trace1
> /relay/block/sdb/trace0
> 
> and does the correct dynamic setup and teardown of the hierarchy
> as the userspace tool starts and stops tracing.  I had to modify
> the relayfs rmdir code a bit to make this work properly, I'll
> send a separate patch for that shortly.

Here it is.  The problem was that relayfs is allowing a directory
with children to be removed rather than returning -ENOTEMPTY.  It
looks like this can be resolved by splitting the shared relayfs
unlink code (which is using simple_unlink) into separate file/dir
variants, one using simple_unlink, the other using simple_rmdir.

cheers.

-- 
Nathan


Index: 2.6.x-xfs/fs/relayfs/inode.c
===================================================================
--- 2.6.x-xfs.orig/fs/relayfs/inode.c
+++ 2.6.x-xfs/fs/relayfs/inode.c
@@ -187,8 +187,8 @@ struct dentry *relayfs_create_dir(const 
 }
 
 /**
- *	relayfs_remove - remove a file or directory in the relay filesystem
- *	@dentry: file or directory dentry
+ *	relayfs_remove - remove a file in the relay filesystem
+ *	@dentry: file dentry
  */
 int relayfs_remove(struct dentry *dentry)
 {
@@ -219,10 +219,31 @@ int relayfs_remove(struct dentry *dentry
  */
 int relayfs_remove_dir(struct dentry *dentry)
 {
+	struct dentry *parent;
+	int error = 0;
+
 	if (!dentry)
 		return -EINVAL;
+	parent = dentry->d_parent;
+	if (!parent)
+		return -EINVAL;
+
+	parent = dget(parent);
+	down(&parent->d_inode->i_sem);
+	if (dentry->d_inode) {
+		error = simple_rmdir(parent->d_inode, dentry);
+		if (!error)
+			d_delete(dentry);
+	}
+	if (!error)
+		dput(dentry);
+	up(&parent->d_inode->i_sem);
+	dput(parent);
+
+	if (!error)
+		simple_release_fs(&relayfs_mount, &relayfs_mount_count);
 
-	return relayfs_remove(dentry);
+	return error;
 }
 
 /**
