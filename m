Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266681AbUGQB5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266681AbUGQB5p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 21:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266707AbUGQB5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 21:57:44 -0400
Received: from aun.it.uu.se ([130.238.12.36]:51163 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266681AbUGQB5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 21:57:31 -0400
Date: Sat, 17 Jul 2004 03:57:25 +0200 (MEST)
Message-Id: <200407170157.i6H1vPYl015048@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.8-rc1-mm1] perfctr inheritance 3/3: documentation updates
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Documentation changes for new task event callbacks, updated
  locking rules, API update, and TODO list update

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 Documentation/perfctr/virtual.txt |   37 ++++++++++++++++++++++---------------
 1 files changed, 22 insertions(+), 15 deletions(-)

diff -ruN linux-2.6.8-rc1-mm1/Documentation/perfctr/virtual.txt linux-2.6.8-rc1-mm1.perfctr-inheritance/Documentation/perfctr/virtual.txt
--- linux-2.6.8-rc1-mm1/Documentation/perfctr/virtual.txt	2004-07-14 12:59:21.000000000 +0200
+++ linux-2.6.8-rc1-mm1.perfctr-inheritance/Documentation/perfctr/virtual.txt	2004-07-17 00:28:21.832314000 +0200
@@ -67,12 +67,17 @@
 Virtual perfctrs hooks into several thread management events:
 
 - exit_thread(): Calls perfctr_exit_thread() to stop the counters
-  and detach the thread's vperfctr object.
+  and mark the vperfctr object as dead.
 
 - copy_thread(): Calls perfctr_copy_thread() to initialise
-  the child's vperfctr pointer. Currently the settings are
-  not inherited from parent to child, so the pointer is set
-  to NULL in the child's thread_struct.
+  the child's vperfctr pointer. The child gets a new vperfctr
+  object containing the same control data as its parent.
+  Kernel-generated threads do not inherit any vperfctr state.
+
+- release_task(): Calls perfctr_release_task() to detach the
+  vperfctr object from the thread. If the child and its parent
+  still have the same perfctr control settings, then the child's
+  final counts are propagated back into its parent.
 
 - switch_to():
   * Calls perfctr_suspend_thread() on the previous thread, to
@@ -109,7 +114,7 @@
 
 Synchronisation Rules
 ---------------------
-There are four types of accesses to a thread's perfctr state:
+There are five types of accesses to a thread's perfctr state:
 
 1. Thread management events (see above) done by the thread itself.
    Suspend, resume, and sample are lock-less.
@@ -134,10 +139,14 @@
    (creat, unlink, exit) perform a task_lock() on the owner thread
    before accessing the perfctr pointer.
 
-   When concurrent set_cpus_allowed() isn't a problem (because the
-   architecture doesn't have a notion of forbidden CPUs), atomicity
-   of updates to the thread's perfctr pointer is ensured by disabling
-   preemption.
+5. release_task().
+   While reaping a child, the kernel only takes the tasklist_lock to
+   prevent the parent from changing or disappearing. This does not
+   prevent the parent's perfctr state pointer from changing. Concurrent
+   accesses to the parent's "children counts" state are also possible.
+
+   To avoid these issues, perfctr_release_task() performs a task_lock()
+   on the parent.
 
 The Pseudo File System
 ----------------------
@@ -253,14 +262,16 @@
 Reading the State
 -----------------
 int err = sys_vperfctr_read(int fd, struct perfctr_sum_ctrs *sum,
-			    struct vperfctr_control *control);
+			    struct vperfctr_control *control,
+			    struct perfctr_sum_ctrs *children);
 
 'fd' must be the return value from a call to sys_vperfctr_open().
 
 This operation copies data from the perfctr state object to
 user-space. If 'sum' is non-NULL, then the counter sums are
 written to it. If 'control' is non-NULL, then the control data
-is written to it.
+is written to it. If 'children' is non-NULL, then the sums of
+exited childrens' counters are written to it.
 
 If the perfctr state object is attached to the current thread,
 then the counters are sampled and updated first.
@@ -346,10 +357,5 @@
 
 Limitations / TODO List
 =======================
-- Perfctr settings are not inherited from parent to child at fork().
-  The issue is not fork() but propagating final counts from children
-  to parents, and allowing user-space to distinguish "self" counts
-  from "children" counts.
-  An implementation of this feature is being planned.
 - Buffering of overflow samples is not implemented. So far, not a
   single user has requested it.
