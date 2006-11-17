Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755821AbWKQTOf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755821AbWKQTOf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 14:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755819AbWKQTOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 14:14:35 -0500
Received: from smtp-out.google.com ([216.239.33.17]:46721 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1755818AbWKQTOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 14:14:18 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:references:user-agent:date:from:to:cc:
	subject:content-disposition;
	b=Lv4l8hAVgUw/aHXFIyN0QXUZt9swG3g9NudlwheglrXejFGcGp+TOG07/+3qLVijO
	nzm6Lh5K7asAv6u+jWWhw==
Message-Id: <20061117191339.665462000@menage.corp.google.com>
References: <20061117191159.151894000@menage.corp.google.com>
User-Agent: quilt/0.45-1
Date: Fri, 17 Nov 2006 11:12:04 -0800
From: menage@google.com
To: akpm@osdl.org, pj@sgi.com, sekharan@us.ibm.com
Cc: ckrm-tech@lists.sourceforge.net, jlan@sgi.com, simon.derr@bull.net,
       linux-kernel@vger.kernel.org, mbligh@google.com, winget@google.com,
       rohitseth@google.com
Subject: [PATCH 5/6] Extension to container system to allow fork/exit callbacks
Content-Disposition: inline; filename=container_forkexit_callback.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds fork/exit callbacks to container subsystems, and
ensures that every registered container has received one fork callback
for each task running int the system, and one exit callback for each
task that exited since it was registered.

Since the fork/exit path is performance sensitive, an RCU-protected
flag indicates to the fork/exit hooks whether they need to take the
callback mutex and scan the list of registered subsystems to look for
fork/exit handlers.

 Documentation/containers.txt |   11 +++++
 include/linux/container.h    |    2 
 kernel/container.c           |   89 +++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 98 insertions(+), 4 deletions(-)

Index: container-2.6.19-rc5/include/linux/container.h
===================================================================
--- container-2.6.19-rc5.orig/include/linux/container.h
+++ container-2.6.19-rc5/include/linux/container.h
@@ -108,6 +108,8 @@ struct container_subsys {
 			    struct container *cont,
 			    struct container *old_cont,
 			    struct task_struct *tsk);
+	void (*fork)(struct container_subsys *ss, struct task_struct *task);
+	void (*exit)(struct container_subsys *ss, struct task_struct *task);
 	int (*populate)(struct container_subsys *ss,
 			struct container *cont);
 
Index: container-2.6.19-rc5/kernel/container.c
===================================================================
--- container-2.6.19-rc5.orig/kernel/container.c
+++ container-2.6.19-rc5/kernel/container.c
@@ -84,6 +84,21 @@ struct containerfs_root {
 
 static struct containerfs_root rootnode[CONFIG_MAX_CONTAINER_HIERARCHIES];
 
+/* This flag indicates whether tasks in the fork and exit paths should
+ * take callback_mutex and check for fork/exit handlers to call. This
+ * avoids us having to take locks in the fork/exit path if none of the
+ * subsystems need to be called.
+ *
+ * It is protected via RCU, with the invariant that a process in an
+ * rcu_read_lock() section will never see this as 0 if there are
+ * actually registered subsystems with a fork or exit
+ * handler. (Sometimes it may be 1 without there being any registered
+ * subsystems with such a handler, but such periods are safe and of
+ * short duration).
+ */
+
+static int need_forkexit_callback = 0;
+
 /* bits in struct container flags field */
 typedef enum {
 	CONT_REMOVED,
@@ -1505,11 +1520,40 @@ int container_register_subsys(struct con
 		goto out;
 	}
 	dummytop->subsys[subsys_count]->container = dummytop;
-	subsys[subsys_count++] = new_subsys;
+ 	mutex_lock(&callback_mutex);
+ 	/* If this is the first subsystem that requested a fork or
+ 	 * exit callback, tell our fork/exit hooks that they need to
+ 	 * grab callback_mutex on every invocation. If they are
+ 	 * running concurrently with this code, they will either not
+ 	 * see the change now and go straight on, or they will see it
+ 	 * and grab callback_mutex, which will deschedule them. Either
+ 	 * way once synchronize_rcu() returns we know that all current
+ 	 * and future forks will make the callbacks. */
+ 	if (!need_forkexit_callback &&
+ 	    (new_subsys->fork || new_subsys->exit)) {
+ 		need_forkexit_callback = 1;
+ 		synchronize_rcu();
+ 	}
+
+ 	/* If this subsystem requested that it be notified with fork
+ 	 * events, we should send it one now for every process in the
+ 	 * system */
+ 	if (new_subsys->fork) {
+ 		struct task_struct *g, *p;
+
+ 		read_lock(&tasklist_lock);
+ 		do_each_thread(g, p) {
+ 			new_subsys->fork(new_subsys, p);
+ 		} while_each_thread(g, p);
+ 		read_unlock(&tasklist_lock);
+ 	}
 
+	subsys[subsys_count++] = new_subsys;
+ 	mutex_unlock(&callback_mutex);
  out:
-	mutex_unlock(&manage_mutex);
-	return retval;
+ 	mutex_unlock(&manage_mutex);
+ 	return retval;
+
 }
 
 /**
@@ -1532,7 +1576,16 @@ int container_register_subsys(struct con
 
 void container_fork(struct task_struct *child)
 {
-	int i;
+	int i, need_callback;
+
+	rcu_read_lock();
+	/* need_forkexit_callback will be true if we might need to do
+ 	 * a callback */
+	need_callback = rcu_dereference(need_forkexit_callback);
+	if (need_callback) {
+		rcu_read_unlock();
+		mutex_lock(&callback_mutex);
+	}
 	task_lock(current);
 	for (i = 0; i < CONFIG_MAX_CONTAINER_HIERARCHIES; i++) {
 		struct container *cont = current->container[i];
@@ -1540,7 +1593,20 @@ void container_fork(struct task_struct *
 		child->container[i] = cont;
 		atomic_inc(&cont->count);
 	}
+	if (need_callback) {
+		for (i = 0; i < subsys_count; i++) {
+			struct container_subsys *ss = subsys[i];
+			if (ss->fork) {
+				ss->fork(ss, child);
+			}
+		}
+	}
 	task_unlock(current);
+	if (need_callback) {
+		mutex_unlock(&callback_mutex);
+	} else {
+		rcu_read_unlock();
+	}
 }
 
 /**
@@ -1606,6 +1672,21 @@ void container_exit(struct task_struct *
 {
 	struct container *cont;
 	int i;
+	rcu_read_lock();
+	if (rcu_dereference(need_forkexit_callback)) {
+		rcu_read_unlock();
+		mutex_lock(&callback_mutex);
+		for (i = 0; i < subsys_count; i++) {
+			struct container_subsys *ss = subsys[i];
+			if (ss->exit) {
+				ss->exit(ss, tsk);
+			}
+		}
+		mutex_unlock(&callback_mutex);
+	} else {
+		rcu_read_unlock();
+	}
+
 	for (i = 0; i < CONFIG_MAX_CONTAINER_HIERARCHIES; i++) {
 		cont = tsk->container[i];
 		if (!cont) continue;
Index: container-2.6.19-rc5/Documentation/containers.txt
===================================================================
--- container-2.6.19-rc5.orig/Documentation/containers.txt
+++ container-2.6.19-rc5/Documentation/containers.txt
@@ -375,6 +375,17 @@ LL=manage_mutex
 Called after the task has been attached to the container, to allow any
 post-attachment activity that requires memory allocations or blocking.
 
+void fork(struct container_subsy *ss, struct task_struct *task)
+LL=callback_mutex, maybe read_lock(tasklist_lock)
+
+Called when a task is forked into a container. Also called during
+registration for all existing tasks.
+
+void exit(struct container_subsys *ss, struct task_struct *task)
+LL=callback_mutex
+
+Called during task exit
+
 int populate(struct container_subsys *ss, struct container *cont)
 LL=none
 

--
