Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992866AbWJTTHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992866AbWJTTHi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992860AbWJTTHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:07:13 -0400
Received: from smtp-out.google.com ([216.239.45.12]:42768 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S2992859AbWJTTHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:07:08 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:references:user-agent:date:from:to:cc:
	subject:content-disposition;
	b=lh+AIjgcEry0iqhw+uBJSNljapr+1ZPLSepU2EkwroaGvma72KXfESD+eZUjYSouK
	6hZzVfCGJCuwnLYnNF6Lg==
Message-Id: <20061020190627.635199000@menage.corp.google.com>
References: <20061020183819.656586000@menage.corp.google.com>
User-Agent: quilt/0.45-1
Date: Fri, 20 Oct 2006 11:38:24 -0700
From: menage@google.com
To: akpm@osdl.org, pj@sgi.com, sekharan@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       jlan@sgi.com, mbligh@google.com, rohitseth@google.com,
       winget@google.com, Simon.Derr@bull.net
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

 Documentation/containers.txt |   13 +++++
 include/linux/container.h    |    4 +
 kernel/container.c           |  108 +++++++++++++++++++++++++++++++++++++++----
 3 files changed, 116 insertions(+), 9 deletions(-)

Index: container-2.6.19-rc2/include/linux/container.h
===================================================================
--- container-2.6.19-rc2.orig/include/linux/container.h
+++ container-2.6.19-rc2/include/linux/container.h
@@ -101,6 +101,10 @@ struct container_subsys {
 			    struct container *cont,
 			    struct container *old_cont,
 			    struct task_struct *tsk);
+	void (*fork)(struct container_subsys *ss, struct container *cont,
+		     struct task_struct *task);
+	void (*exit)(struct container_subsys *ss, struct container *cont,
+		     struct task_struct *task);
 	int (*populate)(struct container_subsys *ss,
 			struct container *cont);
 
Index: container-2.6.19-rc2/kernel/container.c
===================================================================
--- container-2.6.19-rc2.orig/kernel/container.c
+++ container-2.6.19-rc2/kernel/container.c
@@ -72,6 +72,21 @@ int number_of_containers __read_mostly;
 static struct container_subsys *subsys[MAX_CONTAINER_SUBSYS];
 static int subsys_count = 0;
 
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
@@ -487,7 +502,6 @@ static int update_flag(container_flagbit
 	return 0;
 }
 
-
 /*
  * Attack task specified by pid in 'pidbuf' to container 'cont', possibly
  * writing the path of the old container in 'ppathbuf' if it needs to be
@@ -1254,9 +1268,7 @@ static int container_rmdir(struct inode 
 
 int __init container_init_early(void)
 {
-	struct task_struct *tsk = current;
-
-	tsk->container = &top_container;
+	current->container = &top_container;
 	return 0;
 }
 
@@ -1297,6 +1309,7 @@ out:
 int container_register_subsys(struct container_subsys *new_subsys) {
 	int retval = 0;
 	int i;
+
 	mutex_lock(&manage_mutex);
 	if (number_of_containers > 1) {
 		retval = -EBUSY;
@@ -1319,8 +1332,7 @@ int container_register_subsys(struct con
 		}
 	}
 
-	subsys[subsys_count] = new_subsys;
-	new_subsys->subsys_id = subsys_count++;
+	new_subsys->subsys_id = subsys_count;
 	retval = new_subsys->create(new_subsys, &top_container);
 	if (retval) {
 		new_subsys->subsys_id = -1;
@@ -1328,6 +1340,38 @@ int container_register_subsys(struct con
 		goto out;
 	}
 
+	mutex_lock(&callback_mutex);
+	/* If this is the first subsystem that requested a fork or
+	 * exit callback, tell our fork/exit hooks that they need to
+	 * grab callback_mutex on every invocation. If they are
+	 * running concurrently with this code, they will either not
+	 * see the change now and go straight on, or they will see it
+	 * and grab callback_mutex, which will deschedule them. Either
+	 * way once synchronize_rcu() returns we know that all current
+	 * and future forks will make the callbacks. */
+	if (!need_forkexit_callback &&
+	    (new_subsys->fork || new_subsys->exit)) {
+		need_forkexit_callback = 1;
+		synchronize_rcu();
+	}
+
+	/* If this subsystem requested that it be notified with fork
+	 * events, we should send it one now for every process in the
+	 * system */
+	if (new_subsys->fork) {
+		struct task_struct *g, *p;
+
+		read_lock(&tasklist_lock);
+		do_each_thread(g, p) {
+			new_subsys->fork(new_subsys, &top_container, p);
+		} while_each_thread(g, p);
+		read_unlock(&tasklist_lock);
+	}
+
+	subsys[subsys_count] = new_subsys;
+	subsys_count++;
+	mutex_unlock(&callback_mutex);
+
 	/* Set up the per-container "enabled" file */
 	strcpy(new_subsys->enable_cft_filename, new_subsys->name);
 	strcat(new_subsys->enable_cft_filename, "_enabled");
@@ -1365,10 +1409,35 @@ int container_register_subsys(struct con
 
 void container_fork(struct task_struct *child)
 {
+	struct container *cont;
+	int s, need_callback;
+
+	rcu_read_lock();
+	/* need_forkexit_callback will be true if we might need to do
+	 * a callback */
+	need_callback = rcu_dereference(need_forkexit_callback);
+	if (need_callback) {
+		rcu_read_unlock();
+		mutex_lock(&callback_mutex);
+	}
 	task_lock(current);
-	child->container = current->container;
-	atomic_inc(&child->container->count);
+	cont = current->container;
+	child->container = cont;
+	atomic_inc(&cont->count);
+	if (need_callback) {
+		for (s = 0; s < subsys_count; s++) {
+			struct container_subsys *ss = subsys[s];
+			if (ss->fork) {
+				ss->fork(ss, cont, child);
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
@@ -1433,9 +1502,30 @@ void container_fork(struct task_struct *
 void container_exit(struct task_struct *tsk)
 {
 	struct container *cont;
+	int s, need_callback;
 
 	cont = tsk->container;
-	tsk->container = &top_container;	/* the_top_container_hack - see above */
+
+	rcu_read_lock();
+	need_callback = rcu_dereference(need_forkexit_callback);
+	if (need_callback) {
+		rcu_read_unlock();
+		mutex_lock(&callback_mutex);
+		for (s = 0; s < subsys_count; s++) {
+			struct container_subsys *ss = subsys[s];
+			if (ss->exit) {
+				ss->exit(ss, cont, tsk);
+			}
+		}
+		mutex_unlock(&callback_mutex);
+	} else {
+		rcu_read_unlock();
+	}
+
+	if (cont != &top_container) {
+		/* the_top_container_hack - see above */
+		tsk->container = &top_container;
+	}
 
 	if (notify_on_release(cont)) {
 		char *pathbuf = NULL;
Index: container-2.6.19-rc2/Documentation/containers.txt
===================================================================
--- container-2.6.19-rc2.orig/Documentation/containers.txt
+++ container-2.6.19-rc2/Documentation/containers.txt
@@ -353,6 +353,19 @@ LL=manage_mutex
 Called after the task has been attached to the container, to allow any
 post-attachment activity that requires memory allocations or blocking.
 
+void fork(struct container_subsy *ss, struct container *cont,
+	  struct task_struct *task)
+LL=callback_mutex, maybe read_lock(tasklist_lock)
+
+Called when a task is forked into a container. Also called during
+registration for all existing tasks.
+
+void exit(struct container_subsys *ss, struct container *cont,
+	  struct task_struct *task)
+LL=callback_mutex
+
+Called during task exit
+
 int populate(struct container_subsys *ss, struct container *cont)
 LL=none
 

--
