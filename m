Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbVHaETQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbVHaETQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 00:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVHaETP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 00:19:15 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:22526 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932351AbVHaETP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 00:19:15 -0400
From: Tom Zanussi <zanussi@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17173.12216.263860.76176@tut.ibm.com>
Date: Tue, 30 Aug 2005 23:19:04 -0500
To: Nathan Scott <nathans@sgi.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk queue io tracing support
In-Reply-To: <20050830235824.GG780@frodo>
References: <20050823123235.GG16461@suse.de>
	<20050824010346.GA1021@frodo>
	<20050824070809.GA27956@suse.de>
	<20050824171931.H4209301@wobbly.melbourne.sgi.com>
	<20050824072501.GA27992@suse.de>
	<20050824092838.GB28272@suse.de>
	<20050830234823.GF780@frodo>
	<20050830235824.GG780@frodo>
X-Mailer: VM 7.19 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott writes:
 > Hi there,
 > 
 > On Wed, Aug 31, 2005 at 09:48:23AM +1000, Nathan Scott wrote:
 > > ...
 > > # find /relay
 > > /relay
 > > /relay/block
 > > /relay/block/sdd
 > > /relay/block/sdd/trace3
 > > /relay/block/sdd/trace2
 > > /relay/block/sdd/trace1
 > > /relay/block/sdd/trace0
 > > /relay/block/sdb
 > > /relay/block/sdb/trace3
 > > /relay/block/sdb/trace2
 > > /relay/block/sdb/trace1
 > > /relay/block/sdb/trace0
 > > 
 > > and does the correct dynamic setup and teardown of the hierarchy
 > > as the userspace tool starts and stops tracing.  I had to modify
 > > the relayfs rmdir code a bit to make this work properly, I'll
 > > send a separate patch for that shortly.
 > 
 > Here it is.  The problem was that relayfs is allowing a directory
 > with children to be removed rather than returning -ENOTEMPTY.  It
 > looks like this can be resolved by splitting the shared relayfs
 > unlink code (which is using simple_unlink) into separate file/dir
 > variants, one using simple_unlink, the other using simple_rmdir.
 > 

Hi,

You're right, it should be using simple_rmdir rather than
simple_unlink for removing directories.  Thanks for sending the patch,
which I've modified a bit to avoid splitting the rmdir/unlink cases
into separate functions, since they're almost the same except for what
they end up calling.  relayfs_remove_dir now doesn't do anything but
call relayfs_remove (it didn't do much more than that before anyway),
but it makes sense to me to keep it, as the counterpart to
relayfs_create_dir.  Let me know if you see any problems with it.

Thanks,

Tom

--- inode.c~	2005-08-31 04:08:07.000000000 -0500
+++ inode.c	2005-08-31 03:44:40.000000000 -0500
@@ -189,26 +189,39 @@ struct dentry *relayfs_create_dir(const 
 /**
  *	relayfs_remove - remove a file or directory in the relay filesystem
  *	@dentry: file or directory dentry
+ *
+ *	Returns 0 if successful, negative otherwise.
  */
 int relayfs_remove(struct dentry *dentry)
 {
-	struct dentry *parent = dentry->d_parent;
+	struct dentry *parent;
+	int error = 0;
+
+	if (!dentry)
+		return -EINVAL;
+	parent = dentry->d_parent;
 	if (!parent)
 		return -EINVAL;
 
 	parent = dget(parent);
 	down(&parent->d_inode->i_sem);
 	if (dentry->d_inode) {
-		simple_unlink(parent->d_inode, dentry);
-		d_delete(dentry);
+		if (S_ISDIR(dentry->d_inode->i_mode))
+			error = simple_rmdir(parent->d_inode, dentry);
+		else
+			error = simple_unlink(parent->d_inode, dentry);
+		if (!error)
+			d_delete(dentry);
 	}
-	dput(dentry);
+	if (!error)
+		dput(dentry);
 	up(&parent->d_inode->i_sem);
 	dput(parent);
 
-	simple_release_fs(&relayfs_mount, &relayfs_mount_count);
+	if (!error)
+		simple_release_fs(&relayfs_mount, &relayfs_mount_count);
 
-	return 0;
+	return error;
 }
 
 /**
@@ -219,9 +232,6 @@ int relayfs_remove(struct dentry *dentry
  */
 int relayfs_remove_dir(struct dentry *dentry)
 {
-	if (!dentry)
-		return -EINVAL;
-
 	return relayfs_remove(dentry);
 }
 


