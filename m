Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbVCPKj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVCPKj3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 05:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbVCPKj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 05:39:29 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:11737 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262338AbVCPKhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 05:37:50 -0500
Date: Wed, 16 Mar 2005 02:36:12 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Simon Derr <Simon.Derr@bull.net>, Jack Steiner <steiner@sgi.com>,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20050316103615.6322.46456.sendpatchset@sam.engr.sgi.com>
Subject: [Patch] cpusets mems generation deadlock fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The cpuset code to update mems_generation could (in theory)
deadlock on cpuset_sem if it needed to allocate some memory
while creating (mkdir) or removing (rmdir) a cpuset, so already
held cpuset_sem.  Some other process would have to mess with
this tasks cpuset memory placement at the same time.

We avoid this possible deadlock by always updating mems_generation
after we grab cpuset_sem on such operations, before we risk any
operations that might require memory allocation.

Applies to top of Linus's bk tree (post 2.6.11)

Thanks to Jack Steiner <steiner@sgi.com> for noticing this.

Signed-off-by: Paul Jackson <pj@sgi.com>

===================================================================
--- 2.6.12-pj.orig/kernel/cpuset.c	2005-03-16 01:05:33.000000000 -0800
+++ 2.6.12-pj/kernel/cpuset.c	2005-03-16 01:14:51.000000000 -0800
@@ -505,6 +505,35 @@ static void guarantee_online_mems(const 
 }
 
 /*
+ * Refresh current tasks mems_allowed and mems_generation from
+ * current tasks cpuset.  Call with cpuset_sem held.
+ *
+ * Be sure to call refresh_mems() on any cpuset operation which
+ * (1) holds cpuset_sem, and (2) might possibly alloc memory.
+ * Call after obtaining cpuset_sem lock, before any possible
+ * allocation.  Otherwise one risks trying to allocate memory
+ * while the task cpuset_mems_generation is not the same as
+ * the mems_generation in its cpuset, which would deadlock on
+ * cpuset_sem in cpuset_update_current_mems_allowed().
+ *
+ * Since we hold cpuset_sem, once refresh_mems() is called, the
+ * test (current->cpuset_mems_generation != cs->mems_generation)
+ * in cpuset_update_current_mems_allowed() will remain false,
+ * until we drop cpuset_sem.  Anyone else who would change our
+ * cpusets mems_generation needs to lock cpuset_sem first.
+ */
+
+static void refresh_mems(void)
+{
+	struct cpuset *cs = current->cpuset;
+
+	if (current->cpuset_mems_generation != cs->mems_generation) {
+		guarantee_online_mems(cs, &current->mems_allowed);
+		current->cpuset_mems_generation = cs->mems_generation;
+	}
+}
+
+/*
  * is_cpuset_subset(p, q) - Is cpuset p a subset of cpuset q?
  *
  * One cpuset is a subset of another if all its allowed CPUs and
@@ -1224,6 +1253,7 @@ static long cpuset_create(struct cpuset 
 		return -ENOMEM;
 
 	down(&cpuset_sem);
+	refresh_mems();
 	cs->flags = 0;
 	if (notify_on_release(parent))
 		set_bit(CS_NOTIFY_ON_RELEASE, &cs->flags);
@@ -1277,6 +1307,7 @@ static int cpuset_rmdir(struct inode *un
 	/* the vfs holds both inode->i_sem already */
 
 	down(&cpuset_sem);
+	refresh_mems();
 	if (atomic_read(&cs->count) > 0) {
 		up(&cpuset_sem);
 		return -EBUSY;
@@ -1433,8 +1464,7 @@ void cpuset_update_current_mems_allowed(
 		return;		/* task is exiting */
 	if (current->cpuset_mems_generation != cs->mems_generation) {
 		down(&cpuset_sem);
-		guarantee_online_mems(cs, &current->mems_allowed);
-		current->cpuset_mems_generation = cs->mems_generation;
+		refresh_mems();
 		up(&cpuset_sem);
 	}
 }

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
