Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751405AbVJWGEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbVJWGEF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 02:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbVJWGEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 02:04:05 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:21949 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751405AbVJWGEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 02:04:04 -0400
Date: Sat, 22 Oct 2005 23:03:42 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>,
       Linus Torvalds <torvalds@osdl.org>
Message-Id: <20051023060342.24806.52611.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] cpuset simple rename
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for renaming cpusets.  Only allow simple rename
of cpuset directories in place.  Don't allow moving cpusets
elsewhere in hierarchy or renaming the special cpuset files in
each cpuset directory.

The usefulness of this simple rename became apparent when
developing task migration facilities.  It allows building a
second cpuset hierarchy using new names and containing new CPUs
and Memory Nodes, moving tasks from the old to the new cpusets,
removing the old cpusets, and then renaming the new cpusets
to be just like the old names, so that any knowledge that the
tasks had of their cpuset names will still be valid.

Leaf node cpusets can be migrated to other CPUs or Memory
Nodes by just updating their 'cpus' and 'mems' files, but
because no cpuset can contain CPUs or Nodes not in its
parent cpuset, one cannot do this in a cpuset hierarchy
without first expanding all the non-leaf cpusets to contain
the union of both the old and new CPUs and Nodes, which would
obfuscate the one-to-one migration of a task from one cpuset
to another required to correctly migrate the physical page
frames currently allocated to that task.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+)

--- 2.6.14-rc4-mm1-cpuset-patches.orig/kernel/cpuset.c	2005-10-22 21:41:46.097394572 -0700
+++ 2.6.14-rc4-mm1-cpuset-patches/kernel/cpuset.c	2005-10-22 22:40:30.595885046 -0700
@@ -1113,6 +1113,21 @@ static int cpuset_file_release(struct in
 	return 0;
 }
 
+/*
+ * cpuset_rename - Only allow simple rename of directories in place.
+ */
+static int cpuset_rename(struct inode *old_dir, struct dentry *old_dentry,
+                  struct inode *new_dir, struct dentry *new_dentry)
+{
+	if (!S_ISDIR(old_dentry->d_inode->i_mode))
+		return -ENOTDIR;
+	if (new_dentry->d_inode)
+		return -EEXIST;
+	if (old_dir != new_dir)
+		return -EIO;
+	return simple_rename(old_dir, old_dentry, new_dir, new_dentry);
+}
+
 static struct file_operations cpuset_file_operations = {
 	.read = cpuset_file_read,
 	.write = cpuset_file_write,
@@ -1125,6 +1140,7 @@ static struct inode_operations cpuset_di
 	.lookup = simple_lookup,
 	.mkdir = cpuset_mkdir,
 	.rmdir = cpuset_rmdir,
+	.rename = cpuset_rename,
 };
 
 static int cpuset_create_file(struct dentry *dentry, int mode)

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
