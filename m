Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbUEEBGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUEEBGc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 21:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUEEBGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 21:06:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:12483 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261210AbUEEBG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 21:06:27 -0400
Date: Tue, 4 May 2004 18:06:25 -0700
From: Chris Wright <chrisw@osdl.org>
To: manfred@colorfullife.com
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] simplify mqueue_inode_info->messages allocation
Message-ID: <20040504180622.F21045@build.pdx.osdl.net>
References: <20040504174214.D21045@build.pdx.osdl.net> <20040504174713.E21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040504174713.E21045@build.pdx.osdl.net>; from chrisw@osdl.org on Tue, May 04, 2004 at 05:47:13PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if a user creates an mqueue and passes an mq_attr, the
info->messages will be created twice (and the extra one is properly
freed).  This patch simply delays the allocation so that it only ever
happens once.  The relevant mq_attr data is passed to lower levels via
the dentry->d_fsdata fs private data.  This also helps isolate the areas
we'd need to touch to do rlimits on mqueues.

--- ./ipc/mqueue.c~single_alloc	2004-05-04 15:16:34.000000000 -0700
+++ ./ipc/mqueue.c~	2004-05-04 15:59:25.000000000 -0700
@@ -97,7 +97,8 @@ static inline struct mqueue_inode_info *
 	return container_of(inode, struct mqueue_inode_info, vfs_inode);
 }
 
-static struct inode *mqueue_get_inode(struct super_block *sb, int mode)
+static struct inode *mqueue_get_inode(struct super_block *sb, int mode,
+							struct mq_attr *attr)
 {
 	struct inode *inode;
 
@@ -127,7 +128,11 @@ static struct inode *mqueue_get_inode(st
 			memset(&info->attr, 0, sizeof(info->attr));
 			info->attr.mq_maxmsg = DFLT_MSGMAX;
 			info->attr.mq_msgsize = DFLT_MSGSIZEMAX;
-			info->messages = kmalloc(DFLT_MSGMAX * sizeof(struct msg_msg *), GFP_KERNEL);
+			if (attr) {
+				info->attr.mq_maxmsg = attr->mq_maxmsg;
+				info->attr.mq_msgsize = attr->mq_msgsize;
+			}
+			info->messages = kmalloc(info->attr.mq_maxmsg * sizeof(struct msg_msg *), GFP_KERNEL);
 			if (!info->messages) {
 				make_bad_inode(inode);
 				iput(inode);
@@ -153,7 +158,7 @@ static int mqueue_fill_super(struct supe
 	sb->s_magic = MQUEUE_MAGIC;
 	sb->s_op = &mqueue_super_ops;
 
-	inode = mqueue_get_inode(sb, S_IFDIR | S_ISVTX | S_IRWXUGO);
+	inode = mqueue_get_inode(sb, S_IFDIR | S_ISVTX | S_IRWXUGO, NULL);
 	if (!inode)
 		return -ENOMEM;
 
@@ -226,6 +231,7 @@ static int mqueue_create(struct inode *d
 				int mode, struct nameidata *nd)
 {
 	struct inode *inode;
+	struct mq_attr *attr = dentry->d_fsdata;
 	int error;
 
 	spin_lock(&mq_lock);
@@ -236,7 +242,7 @@ static int mqueue_create(struct inode *d
 	queues_count++;
 	spin_unlock(&mq_lock);
 
-	inode = mqueue_get_inode(dir->i_sb, mode);
+	inode = mqueue_get_inode(dir->i_sb, mode, attr);
 	if (!inode) {
 		error = -ENOMEM;
 		spin_lock(&mq_lock);
@@ -535,9 +541,6 @@ static struct file *do_create(struct den
 			int oflag, mode_t mode, struct mq_attr __user *u_attr)
 {
 	struct file *filp;
-	struct inode *inode;
-	struct mqueue_inode_info *info;
-	struct msg_msg **msgs = NULL;
 	struct mq_attr attr;
 	int ret;
 
@@ -555,28 +558,14 @@ static struct file *do_create(struct den
 					attr.mq_msgsize > msgsize_max)
 				return ERR_PTR(-EINVAL);
 		}
-		msgs = kmalloc(attr.mq_maxmsg * sizeof(*msgs), GFP_KERNEL);
-		if (!msgs)
-			return ERR_PTR(-ENOMEM);
-	} else {
-		msgs = NULL;
+		/* store for use during create */
+		dentry->d_fsdata = &attr;
 	}
 
 	ret = vfs_create(dir->d_inode, dentry, mode, NULL);
-	if (ret) {
-		kfree(msgs);
+	dentry->d_fsdata = NULL;
+	if (ret)
 		return ERR_PTR(ret);
-	}
-
-	inode = dentry->d_inode;
-	info = MQUEUE_I(inode);
-
-	if (msgs) {
-		info->attr.mq_maxmsg = attr.mq_maxmsg;
-		info->attr.mq_msgsize = attr.mq_msgsize;
-		kfree(info->messages);
-		info->messages = msgs;
-	}
 
 	filp = dentry_open(dentry, mqueue_mnt, oflag);
 	if (!IS_ERR(filp))
