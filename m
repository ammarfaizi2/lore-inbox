Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268529AbUIQHZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268529AbUIQHZh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 03:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268515AbUIQHZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 03:25:36 -0400
Received: from zeus.kernel.org ([204.152.189.113]:65507 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S268529AbUIQHYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 03:24:14 -0400
Date: Fri, 17 Sep 2004 00:22:32 -0700
From: Paul Jackson <pj@sgi.com>
To: Simon Derr <Simon.Derr@bull.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] cpusets: fix race in cpuset_add_file()
Message-Id: <20040917002232.7b4135f5.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.61.0409161715550.5423@openx3.frec.bull.fr>
References: <20040916012913.8592.85271.16927@sam.engr.sgi.com>
	<Pine.LNX.4.61.0409161548040.5423@openx3.frec.bull.fr>
	<20040916075501.20c3ee45.pj@sgi.com>
	<Pine.LNX.4.61.0409161715550.5423@openx3.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can continue to ignore this patch, Andrew.  I'm still thinking it
through with Simon.

Here's another possible way to skin this cat, Simon.

Instead of adding an inode lock, how about just extending the cpuset_sem
window.  If we hold cpuset_sem for the entire cpuset_mkdir() operation,
then no other cpuset_mkdir can overlap, and there should be no
confused overlapping directory creations.

This reduces the risks of unrecognized A-B-A deadlocks, and it removes
the concern I have that dropping the cpuset_sem before we're done opens
the way for more inconsistencies.

This needs to be tested before it goes in - there is a non-zero risk
that I made a stupid mistake and it locks up or something.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.9-rc2-mm1/kernel/cpuset.c
===================================================================
--- 2.6.9-rc2-mm1.orig/kernel/cpuset.c	2004-09-16 23:46:01.000000000 -0700
+++ 2.6.9-rc2-mm1/kernel/cpuset.c	2004-09-17 00:19:02.000000000 -0700
@@ -1235,7 +1235,6 @@ static long cpuset_create(struct cpuset 
 	if (!cs)
 		return -ENOMEM;
 
-	down(&cpuset_sem);
 	cs->flags = 0;
 	if (notify_on_release(parent))
 		set_bit(CS_NOTIFY_ON_RELEASE, &cs->flags);
@@ -1256,22 +1255,23 @@ static long cpuset_create(struct cpuset 
 		goto err;
 	err = cpuset_populate_dir(cs->dentry);
 	/* If err < 0, we have a half-filled directory - oh well ;) */
-	up(&cpuset_sem);
 	return 0;
 err:
 	list_del(&cs->sibling);
-	up(&cpuset_sem);
 	kfree(cs);
 	return err;
 }
 
 static int cpuset_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
-	struct dentry *d_parent = dentry->d_parent;
-	struct cpuset *c_parent = (struct cpuset *)d_parent->d_fsdata;
+	struct cpuset *c_parent;
+	int rc;
 
-	/* the vfs holds inode->i_sem already */
-	return cpuset_create(c_parent, dentry->d_name.name, mode | S_IFDIR);
+	down(&cpuset_sem);
+	c_parent = dentry->d_parent->d_fsdata;
+	rc = cpuset_create(c_parent, dentry->d_name.name, mode | S_IFDIR);
+	up(&cpuset_sem);
+	return rc;
 }
 
 static int cpuset_rmdir(struct inode *unused_dir, struct dentry *dentry)


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
