Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284820AbRLEX26>; Wed, 5 Dec 2001 18:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284815AbRLEX2u>; Wed, 5 Dec 2001 18:28:50 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:17537 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S284822AbRLEX2g>;
	Wed, 5 Dec 2001 18:28:36 -0500
Date: Wed, 5 Dec 2001 15:28:34 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: [FS] Why doesn't this patch work?
Message-ID: <20011205152834.A11289@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm attempting to write this little dinky patch to see who calls fsync()
or fdatasync(), but it's spitting out compiler warnings.  I can't figure
out why, though.  What did I do wrong?

buffer.c: In function `report_culprit':
buffer.c:409: warning: assignment from incompatible pointer type
buffer.c:410: warning: passing arg 2 of `d_path' from incompatible pointer type
buffer.c:420: warning: passing arg 1 of `mntput' from incompatible pointer type

--- linux/fs/buffer.c.orig	Wed Dec  5 08:53:28 2001
+++ linux/fs/buffer.c	Wed Dec  5 15:14:38 2001
@@ -396,6 +396,30 @@
 	return ret;
 }
 
+static void report_culprit(struct dentry *dentry, struct file *file, char *action)
+{
+	struct vfsmnt * mnt;
+	char * buf = (char*)__get_free_page(GFP_KERNEL);
+	char * path;
+	int len;
+
+	if (!buf)
+		return;
+
+	mnt = mntget(file->f_vfsmnt);
+	path = d_path(dentry, mnt, buf, PAGE_SIZE - 1);
+	len = buf + PAGE_SIZE - 1 - path;
+	if (len >= PAGE_SIZE - 1)
+		len = PAGE_SIZE - 1;
+	path[len] = '\0';
+
+	printk("Process %u (%s) %s()ed \"%s\".\n",
+		current->pid, current->comm, action, path);
+
+	free_page((unsigned long)buf);
+	mntput(mnt);
+}
+
 asmlinkage long sys_fsync(unsigned int fd)
 {
 	struct file * file;
@@ -415,6 +439,8 @@
 	if (!file->f_op || !file->f_op->fsync)
 		goto out_putf;
 
+	report_culprit(dentry, file, "fsync");
+
 	/* We need to protect against concurrent writers.. */
 	down(&inode->i_sem);
 	filemap_fdatasync(inode->i_mapping);
@@ -446,6 +472,8 @@
 	err = -EINVAL;
 	if (!file->f_op || !file->f_op->fsync)
 		goto out_putf;
+
+	report_culprit(dentry, file, "fdatasync");
 
 	down(&inode->i_sem);
 	filemap_fdatasync(inode->i_mapping);

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
