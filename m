Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268699AbUIQLas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268699AbUIQLas (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 07:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268702AbUIQL3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 07:29:11 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:62434 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268697AbUIQL1C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 07:27:02 -0400
Date: Fri, 17 Sep 2004 04:25:27 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20040917112527.32393.49322.23478@sam.engr.sgi.com>
Subject: cpusets: fix race in cpuset_add_file()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a missing down()/up() pair in cpuset_add_file().

Without this patch, sometimes it is possible to have two duplicate
dentries for a single file of a cpuset, with one of them being invalid,
and thus the file is present but cannot be opened...

By holding the cpuset directory inode (after the directory is created,
while each file in it is being populated), we prevent a stat(2) or
open(2) from creating a second, invalid directory entry for one of the
files in a cpuset directory, while cpuset_populate_dir is trying to
create the same file.

Signed-off-by: Simon Derr <simon.derr@bull.net>
Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.9-rc2-mm1/kernel/cpuset.c
===================================================================
--- 2.6.9-rc2-mm1.orig/kernel/cpuset.c	2004-09-17 02:12:26.000000000 -0700
+++ 2.6.9-rc2-mm1/kernel/cpuset.c	2004-09-17 04:19:18.000000000 -0700
@@ -991,13 +991,12 @@ static int cpuset_create_dir(struct cpus
 	return error;
 }
 
-/* MUST be called with dir->d_inode->i_sem held */
-
 static int cpuset_add_file(struct dentry *dir, const struct cftype *cft)
 {
 	struct dentry *dentry;
 	int error;
 
+	down(&dir->d_inode->i_sem);
 	dentry = cpuset_get_dentry(dir, cft->name);
 	if (!IS_ERR(dentry)) {
 		error = cpuset_create_file(dentry, 0644 | S_IFREG);
@@ -1006,6 +1005,7 @@ static int cpuset_add_file(struct dentry
 		dput(dentry);
 	} else
 		error = PTR_ERR(dentry);
+	up(&dir->d_inode->i_sem);
 	return error;
 }
 
@@ -1197,7 +1197,6 @@ static struct cftype cft_notify_on_relea
 	.private = FILE_NOTIFY_ON_RELEASE,
 };
 
-/* MUST be called with ->d_inode->i_sem held */
 static int cpuset_populate_dir(struct dentry *cs_dentry)
 {
 	int err;
@@ -1254,9 +1253,16 @@ static long cpuset_create(struct cpuset 
 	err = cpuset_create_dir(cs, name, mode);
 	if (err < 0)
 		goto err;
+
+	/*
+	 * Release cpuset_sem before cpuset_populate_dir() because it
+	 * will down() this new directory's i_sem and if we race with
+	 * another mkdir, we might deadlock.
+	 */
+	up(&cpuset_sem);
+
 	err = cpuset_populate_dir(cs->dentry);
 	/* If err < 0, we have a half-filled directory - oh well ;) */
-	up(&cpuset_sem);
 	return 0;
 err:
 	list_del(&cs->sibling);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
