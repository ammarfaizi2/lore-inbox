Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbWGNJys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbWGNJys (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 05:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964813AbWGNJys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 05:54:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:51609 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964812AbWGNJyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 05:54:47 -0400
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Dinakar Guniguntala <dino@in.ibm.com>, Simon.Derr@bull.net,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Date: Fri, 14 Jul 2006 02:54:34 -0700
Message-Id: <20060714095434.24283.5979.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] Cpuset: fix ABBA deadlock with cpu hotplug lock
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Fix ABBA deadlock between lock_cpu_hotplug() and the cpuset
callback_mutex lock.

It only happens on cpu_exclusive cpusets, due to the dynamic
sched domain code trying to take the cpu hotplug lock inside
the cpuset callback_mutex lock.

This bug has apparently been here for several months, but didn't
get hit until the right customer load on a large system.

This fix appears right from inspection, but it will take a few
more days running it on that customers workload to be confident
we nailed it.  We don't have any other reproducible test case.

The cpu_hotplug_lock() tends to cover large runs of code.
The other places that hold both that lock and the cpuset callback
mutex lock always nest the cpuset lock inside the hotplug lock.
This place tries to do the reverse, risking an ABBA deadlock.

This is in the cpuset_rmdir() code, where we:
  * take the callback_mutex lock
  * mark the cpuset CS_REMOVED
  * call update_cpu_domains for cpu_exclusive cpusets
  * in that call, take the cpu_hotplug lock if the
    cpuset is marked for removal.

Thanks to Jack Steiner for identifying this deadlock.

The fix is to tear down the dynamic sched domain before we grab
the cpuset callback_mutex lock.  This way, the two locks are
serialized, with the hotplug lock taken and released before
trying for the cpuset lock.

I suspect that this bug was introduced when I changed the
cpuset locking from one lock to two.  The dynamic sched domain
dependency on cpu_exclusive cpusets and its hotplug hooks were
added to this code earlier, when cpusets had only a single lock.
It may well have been fine then.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |   24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

--- 2.6.18-rc1-mm1.orig/kernel/cpuset.c	2006-07-13 01:43:26.944147637 -0700
+++ 2.6.18-rc1-mm1/kernel/cpuset.c	2006-07-13 01:43:30.144185379 -0700
@@ -761,6 +761,8 @@ static int validate_change(const struct 
  *
  * Call with manage_mutex held.  May nest a call to the
  * lock_cpu_hotplug()/unlock_cpu_hotplug() pair.
+ * Must not be called holding callback_mutex, because we must
+ * not call lock_cpu_hotplug() while holding callback_mutex.
  */
 
 static void update_cpu_domains(struct cpuset *cur)
@@ -780,7 +782,7 @@ static void update_cpu_domains(struct cp
 		if (is_cpu_exclusive(c))
 			cpus_andnot(pspan, pspan, c->cpus_allowed);
 	}
-	if (is_removed(cur) || !is_cpu_exclusive(cur)) {
+	if (!is_cpu_exclusive(cur)) {
 		cpus_or(pspan, pspan, cur->cpus_allowed);
 		if (cpus_equal(pspan, cur->cpus_allowed))
 			return;
@@ -1916,6 +1918,17 @@ static int cpuset_mkdir(struct inode *di
 	return cpuset_create(c_parent, dentry->d_name.name, mode | S_IFDIR);
 }
 
+/*
+ * Locking note on the strange update_flag() call below:
+ *
+ * If the cpuset being removed is marked cpu_exclusive, then simulate
+ * turning cpu_exclusive off, which will call update_cpu_domains().
+ * The lock_cpu_hotplug() call in update_cpu_domains() must not be
+ * made while holding callback_mutex.  Elsewhere the kernel nests
+ * callback_mutex inside lock_cpu_hotplug() calls.  So the reverse
+ * nesting would risk an ABBA deadlock.
+ */
+
 static int cpuset_rmdir(struct inode *unused_dir, struct dentry *dentry)
 {
 	struct cpuset *cs = dentry->d_fsdata;
@@ -1935,11 +1948,16 @@ static int cpuset_rmdir(struct inode *un
 		mutex_unlock(&manage_mutex);
 		return -EBUSY;
 	}
+	if (is_cpu_exclusive(cs)) {
+		int retval = update_flag(CS_CPU_EXCLUSIVE, cs, "0");
+		if (retval < 0) {
+			mutex_unlock(&manage_mutex);
+			return retval;
+		}
+	}
 	parent = cs->parent;
 	mutex_lock(&callback_mutex);
 	set_bit(CS_REMOVED, &cs->flags);
-	if (is_cpu_exclusive(cs))
-		update_cpu_domains(cs);
 	list_del(&cs->sibling);	/* delete my sibling from parent->children */
 	spin_lock(&cs->dentry->d_lock);
 	d = dget(cs->dentry);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
