Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVEZIZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVEZIZw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 04:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVEZIZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 04:25:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:8657 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261274AbVEZIZm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 04:25:42 -0400
Date: Thu, 26 May 2005 01:25:16 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dinakar Guniguntala <dino@in.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20050526082516.927.6806.sendpatchset@tomahawk.engr.sgi.com>
Subject: [PATCH 2.6.12-rc4] cpuset rmdir scheduling while atomic fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This fixes a complaint that I am seeing while running
a particular stress test.  Please push it along at your
convenience.

The cpuset kernel code can generate a "scheduling while atomic"
complaint from the cpuset_rmdir code.  This complaint means
that we had to sleep while trying to get the cpuset_sem global
semaphore during the handling of a 'rmdir()' call to remove
a cpuset.

The existing code tries to take the global cpuset_sem semaphore
while holding a dentry spinlock.  The fix is easy enough -
the code that requires cpuset_sem can be moved below the point
where the dentry spinlock is released.

This bug is usually only seen when running stress tests or
loads causing rapid cpuset creation and deletion and queries.

The following fix has been tested using a current -linus git
kernel.  Without the fix, I have a stress test that generates a
scheduling while atomic complaint every few seconds.  With the
fix, I've seen no more complaints in several hours of the same
stress test.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6-cpuset_path_fix/kernel/cpuset.c
===================================================================
--- 2.6-cpuset_path_fix.orig/kernel/cpuset.c	2005-05-20 22:11:48.000000000 -0700
+++ 2.6-cpuset_path_fix/kernel/cpuset.c	2005-05-20 22:12:15.000000000 -0700
@@ -1320,11 +1320,11 @@ static int cpuset_rmdir(struct inode *un
 	parent = cs->parent;
 	set_bit(CS_REMOVED, &cs->flags);
 	list_del(&cs->sibling);	/* delete my sibling from parent->children */
-	if (list_empty(&parent->children))
-		check_for_release(parent);
 	d = dget(cs->dentry);
 	cs->dentry = NULL;
 	spin_unlock(&d->d_lock);
+	if (list_empty(&parent->children))
+		check_for_release(parent);
 	cpuset_d_remove_dir(d);
 	dput(d);
 	up(&cpuset_sem);

-- 
-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
