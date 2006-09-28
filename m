Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751815AbWI1LOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbWI1LOt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 07:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbWI1LOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 07:14:49 -0400
Received: from smtp-out.google.com ([216.239.45.12]:9434 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751815AbWI1LOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 07:14:48 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:references:user-agent:date:from:to:cc:
	subject:content-disposition:sender;
	b=vCMAA+WwwBS2l5behEtkPWjW3QeQIOl0ccMXwaaP+8UUp3vTjpWVj5IoLKTPpFS5n
	pg258e3r5c1zQhZrnOpKw==
Message-Id: <20060928111408.447901000@menage.corp.google.com>
References: <20060928104035.840699000@menage.corp.google.com>
User-Agent: quilt/0.45-1
Date: Thu, 28 Sep 2006 03:40:38 -0700
From: menage@google.com
To: pj@sgi.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       mbligh@google.com, rohitseth@google.com, winget@google.com, dev@sw.ru,
       sekharan@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 3/4] Add generic multi-subsystem API to containers
Content-Disposition: inline; filename=multiuser_container.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes all cpuset-specific knowlege from the container
system, replacing it with a generic API that can be used by multiple
subsystems. Cpusets is adapted to be a container subsystem.

---
 Documentation/containers.txt |  121 +++++++++++++++++++++++++++++++++++++++++--
 include/linux/container.h    |   24 +++++++-
 include/linux/cpuset.h       |   11 ---
 kernel/container.c           |   95 ++++++++++++++++++++++++---------
 kernel/cpuset.c              |  101 ++++++++++++++++++++++-------------
 5 files changed, 269 insertions(+), 83 deletions(-)

Index: linux-2.6.18/include/linux/container.h
===================================================================
--- linux-2.6.18.orig/include/linux/container.h
+++ linux-2.6.18/include/linux/container.h
@@ -30,6 +30,8 @@ extern void container_unlock(void);
 extern void container_manage_lock(void);
 extern void container_manage_unlock(void);
 
+#define MAX_CONTAINER_SUBSYS 8
+
 struct container {
 	unsigned long flags;		/* "unsigned long" so bitops work */
 
@@ -48,9 +50,8 @@ struct container {
 	struct container *parent;		/* my parent */
 	struct dentry *dentry;		/* container fs entry */
 
-#ifdef CONFIG_CPUSETS
-	struct cpuset *cpuset;
-#endif
+	/* Private pointers for each registered subsystem */
+	void *subsys[MAX_CONTAINER_SUBSYS];
 };
 
 /* struct cftype:
@@ -84,6 +85,23 @@ int container_add_file(struct container 
 
 int container_is_removed(const struct container *cont);
 
+/* Container subsystem type. See Documentation/containers.txt for details */
+
+struct container_subsys {
+	int (*create)(struct container *cont);
+	void (*destroy)(struct container *cont);
+	int (*can_attach)(struct container *cont, struct task_struct *tsk);
+	void (*attach)(struct container *cont, struct task_struct *tsk);
+	void (*post_attach)(struct container *cont,
+			   struct container *old_cont,
+			   struct task_struct *tsk);
+	int (*populate)(struct container *cont);
+
+	int subsys_id;
+};
+
+int container_register_subsys(struct container_subsys *subsys);
+
 #else /* !CONFIG_CONTAINERS */
 
 static inline int container_init_early(void) { return 0; }
Index: linux-2.6.18/include/linux/cpuset.h
===================================================================
--- linux-2.6.18.orig/include/linux/cpuset.h
+++ linux-2.6.18/include/linux/cpuset.h
@@ -56,17 +56,6 @@ static inline int cpuset_do_slab_mem_spr
 	return current->flags & PF_SPREAD_SLAB;
 }
 
-extern int cpuset_can_attach_task(struct container *cont,
-				  struct task_struct *tsk);
-extern void cpuset_attach_task(struct container *cont,
-				struct task_struct *tsk);
-extern void cpuset_post_attach_task(struct container *cont,
-				    struct container *oldcont,
-				    struct task_struct *tsk);
-extern int cpuset_populate_dir(struct container *cont);
-extern int cpuset_create(struct container *cont);
-extern void cpuset_destroy(struct container *cont);
-
 #else /* !CONFIG_CPUSETS */
 
 static inline int cpuset_init_early(void) { return 0; }
Index: linux-2.6.18/kernel/container.c
===================================================================
--- linux-2.6.18.orig/kernel/container.c
+++ linux-2.6.18/kernel/container.c
@@ -49,7 +49,6 @@
 #include <linux/time.h>
 #include <linux/backing-dev.h>
 #include <linux/sort.h>
-#include <linux/cpuset.h>
 
 #include <asm/uaccess.h>
 #include <asm/atomic.h>
@@ -64,6 +63,9 @@
  */
 int number_of_containers __read_mostly;
 
+static struct container_subsys *subsys[MAX_CONTAINER_SUBSYS];
+static int subsys_count = 0;
+
 /* bits in struct container flags field */
 typedef enum {
 	CONT_REMOVED,
@@ -483,6 +485,7 @@ static int attach_task(struct container 
 	struct task_struct *tsk;
 	struct container *oldcont;
 	int retval = 0;
+	int s;
 
 	if (sscanf(pidbuf, "%d", &pid) != 1)
 		return -EIO;
@@ -509,12 +512,13 @@ static int attach_task(struct container 
 		get_task_struct(tsk);
 	}
 
-#ifdef CONFIG_CPUSETS
-	retval = cpuset_can_attach_task(cont, tsk);
-#endif
-	if (retval) {
-		put_task_struct(tsk);
-		return retval;
+	for (s = 0; s < subsys_count; s++) {
+		if (!subsys[s]->can_attach) continue;
+		retval = subsys[s]->can_attach(cont, tsk);
+		if (retval) {
+			put_task_struct(tsk);
+			return retval;
+		}
 	}
 
 	mutex_lock(&callback_mutex);
@@ -531,15 +535,17 @@ static int attach_task(struct container 
 	rcu_assign_pointer(tsk->container, cont);
 	task_unlock(tsk);
 
-#ifdef CONFIG_CPUSETS
-	cpuset_attach_task(cont, tsk);
-#endif
+	for (s = 0; s < subsys_count; s++) {
+		if (!subsys[s]->attach) continue;
+		subsys[s]->attach(cont, tsk);
+	}
 
 	mutex_unlock(&callback_mutex);
 
-#ifdef CONFIG_CPUSETS
-	cpuset_post_attach_task(cont, oldcont, tsk);
-#endif
+	for (s = 0; s < subsys_count; s++) {
+		if (!subsys[s]->post_attach) continue;
+		subsys[s]->post_attach(cont, oldcont, tsk);
+	}
 
 	put_task_struct(tsk);
 	synchronize_rcu();
@@ -987,15 +993,17 @@ static struct cftype cft_notify_on_relea
 static int container_populate_dir(struct container *cont)
 {
 	int err;
+	int s;
 
 	if ((err = container_add_file(cont, &cft_notify_on_release)) < 0)
 		return err;
 	if ((err = container_add_file(cont, &cft_tasks)) < 0)
 		return err;
-#ifdef CONFIG_CPUSETS
-	if ((err = cpuset_populate_dir(cont)) < 0)
-		return err;
-#endif
+	for (s = 0; s < subsys_count; s++) {
+		if (!subsys[s]->populate) continue;
+		if ((err = subsys[s]->populate(cont)) < 0)
+			return err;
+	}
 	return 0;
 }
 
@@ -1012,6 +1020,7 @@ static long container_create(struct cont
 {
 	struct container *cont;
 	int err;
+	int s = 0;
 
 	cont = kmalloc(sizeof(*cont), GFP_KERNEL);
 	if (!cont)
@@ -1027,10 +1036,17 @@ static long container_create(struct cont
 
 	cont->parent = parent;
 
-#ifdef CONFIG_CPUSETS
-	err = cpuset_create(cont);
-	if (err) goto err_unlock_free;
-#endif
+	for (s = 0; s < subsys_count; s++) {
+		if (!subsys[s]->create) continue;
+		err = subsys[s]->create(cont);
+		if (err) {
+			for (s--; s >= 0; s--) {
+				if (!subsys[s]->destroy) continue;
+				subsys[s]->destroy(cont);
+			}
+			goto err_unlock_free;
+		}
+	}
 
 	mutex_lock(&callback_mutex);
 	list_add(&cont->sibling, &cont->parent->children);
@@ -1053,9 +1069,11 @@ static long container_create(struct cont
 	return 0;
 
  err_remove:
-#ifdef CONFIG_CPUSETS
-	cpuset_destroy(cont);
-#endif
+	for (s = subsys_count - 1; s >= 0; s--) {
+		if (!subsys[s]->destroy) continue;
+		subsys[s]->destroy(cont);
+	}
+
 	mutex_lock(&callback_mutex);
 	list_del(&cont->sibling);
 	number_of_containers--;
@@ -1091,6 +1109,7 @@ static int container_rmdir(struct inode 
 	struct dentry *d;
 	struct container *parent;
 	char *pathbuf = NULL;
+	int s;
 
 	/* the vfs holds both inode->i_mutex already */
 
@@ -1115,9 +1134,10 @@ static int container_rmdir(struct inode 
 	dput(d);
 	number_of_containers--;
 	mutex_unlock(&callback_mutex);
-#ifdef CONFIG_CPUSETS
-	cpuset_destroy(cont);
-#endif
+	for (s = 0; s < subsys_count; s++) {
+		if (!subsys[s]->destroy) continue;
+		subsys[s]->destroy(cont);
+	}
 	if (list_empty(&parent->children))
 		check_for_release(parent, &pathbuf);
 	mutex_unlock(&manage_mutex);
@@ -1172,6 +1192,27 @@ out:
 	return err;
 }
 
+int container_register_subsys(struct container_subsys *new_subsys) {
+	if (number_of_containers > 1) return -EBUSY;
+	if (subsys_count == MAX_CONTAINER_SUBSYS) return -ENOSPC;
+	subsys[subsys_count] = new_subsys;
+	new_subsys->subsys_id = subsys_count++;
+	if (new_subsys->create) {
+		int err = new_subsys->create(&top_container);
+		if (err) {
+			new_subsys->subsys_id = -1;
+			subsys_count--;
+			return err;
+		}
+	}
+	/* Only populate the top container if we've done
+	 * container_init() */
+	if (container_mount && new_subsys->populate) {
+		new_subsys->populate(&top_container);
+	}
+	return 0;
+}
+
 /**
  * container_fork - attach newly forked task to its parents container.
  * @tsk: pointer to task_struct of forking parent process.
Index: linux-2.6.18/kernel/cpuset.c
===================================================================
--- linux-2.6.18.orig/kernel/cpuset.c
+++ linux-2.6.18/kernel/cpuset.c
@@ -54,6 +54,16 @@
 #include <asm/atomic.h>
 #include <linux/mutex.h>
 
+/* Retrieve the cpuset from a container */
+extern struct container_subsys cpuset_subsys;
+#define container_cs(_cont) ((struct cpuset *)(_cont)->subsys[cpuset_subsys.subsys_id])
+
+/* Retrieve the cpuset for a task */
+static inline struct cpuset *task_cs(struct task_struct *task)
+{
+	return container_cs(task->container);
+}
+
 /* See "Frequency meter" comments, below. */
 
 struct fmeter {
@@ -239,20 +249,21 @@ void cpuset_update_task_memory_state(voi
 	struct task_struct *tsk = current;
 	struct cpuset *cs;
 
-	if (tsk->container->cpuset == &top_cpuset) {
+	if (task_cs(tsk) == &top_cpuset) {
 		/* Don't need rcu for top_cpuset.  It's never freed. */
 		my_cpusets_mem_gen = top_cpuset.mems_generation;
 	} else {
+		struct container *cont;
 		rcu_read_lock();
-		cs = rcu_dereference(tsk->container->cpuset);
-		my_cpusets_mem_gen = cs->mems_generation;
+		cont = rcu_dereference(tsk->container);
+		my_cpusets_mem_gen = container_cs(cont)->mems_generation;
 		rcu_read_unlock();
 	}
 
 	if (my_cpusets_mem_gen != tsk->cpuset_mems_generation) {
 		container_lock();
 		task_lock(tsk);
-		cs = tsk->container->cpuset; /* Maybe changed when task not locked */
+		cs = task_cs(tsk); /* Maybe changed when task not locked */
 		guarantee_online_mems(cs, &tsk->mems_allowed);
 		tsk->cpuset_mems_generation = cs->mems_generation;
 		if (is_spread_page(cs))
@@ -312,8 +323,7 @@ static int validate_change(const struct 
 
 	/* Each of our child cpusets must be a subset of us */
 	list_for_each_entry(cont, &cur->container->children, sibling) {
-		c = cont->cpuset;
-		if (!is_cpuset_subset(c, trial))
+		if (!is_cpuset_subset(container_cs(cont), trial))
 			return -EBUSY;
 	}
 
@@ -327,7 +337,7 @@ static int validate_change(const struct 
 
 	/* If either I or some sibling (!= me) is exclusive, we can't overlap */
 	list_for_each_entry(cont, &par->container->children, sibling) {
-		c = cont->cpuset;
+		c = container_cs(cont);
 		if ((is_cpu_exclusive(trial) || is_cpu_exclusive(c)) &&
 		    c != cur &&
 		    cpus_intersects(trial->cpus_allowed, c->cpus_allowed))
@@ -370,7 +380,7 @@ static void update_cpu_domains(struct cp
 	 */
 	pspan = par->cpus_allowed;
 	list_for_each_entry(cont, &par->container->children, sibling) {
-		c = cont->cpuset;
+		c = container_cs(cont);
 		if (is_cpu_exclusive(c))
 			cpus_andnot(pspan, pspan, c->cpus_allowed);
 	}
@@ -388,7 +398,7 @@ static void update_cpu_domains(struct cp
 		 * of exclusive children
 		 */
 		list_for_each_entry(cont, &cur->container->children, sibling) {
-			c = cont->cpuset;
+			c = container_cs(cont);
 			if (is_cpu_exclusive(c))
 				cpus_andnot(cspan, cspan, c->cpus_allowed);
 		}
@@ -476,7 +486,7 @@ static void cpuset_migrate_mm(struct mm_
 	do_migrate_pages(mm, from, to, MPOL_MF_MOVE_ALL);
 
 	container_lock();
-	guarantee_online_mems(tsk->container->cpuset, &tsk->mems_allowed);
+	guarantee_online_mems(task_cs(tsk),&tsk->mems_allowed);
 	container_unlock();
 }
 
@@ -760,9 +770,9 @@ static int fmeter_getrate(struct fmeter 
 	return val;
 }
 
-int cpuset_can_attach_task(struct container *cont, struct task_struct *tsk)
+int cpuset_can_attach(struct container *cont, struct task_struct *tsk)
 {
-	struct cpuset *cs = cont->cpuset;
+	struct cpuset *cs = container_cs(cont);
 
 	if (cpus_empty(cs->cpus_allowed) || nodes_empty(cs->mems_allowed))
 		return -ENOSPC;
@@ -770,22 +780,21 @@ int cpuset_can_attach_task(struct contai
 	return security_task_setscheduler(tsk, 0, NULL);
 }
 
-void cpuset_attach_task(struct container *cont, struct task_struct *tsk)
+void cpuset_attach(struct container *cont, struct task_struct *tsk)
 {
 	cpumask_t cpus;
-	struct cpuset *cs = cont->cpuset;
-	guarantee_online_cpus(cs, &cpus);
+	guarantee_online_cpus(container_cs(cont), &cpus);
 	set_cpus_allowed(tsk, cpus);
 }
 
-void cpuset_post_attach_task(struct container *cont,
-			     struct container *oldcont,
-			     struct task_struct *tsk)
+void cpuset_post_attach(struct container *cont,
+			struct container *oldcont,
+			struct task_struct *tsk)
 {
 	nodemask_t from, to;
 	struct mm_struct *mm;
-	struct cpuset *cs = cont->cpuset;
-	struct cpuset *oldcs = oldcont->cpuset;
+	struct cpuset *cs = container_cs(cont);
+	struct cpuset *oldcs = container_cs(oldcont);
 
 	from = oldcs->mems_allowed;
 	to = cs->mems_allowed;
@@ -819,7 +828,7 @@ static ssize_t cpuset_common_file_write(
 					const char __user *userbuf,
 					size_t nbytes, loff_t *unused_ppos)
 {
-	struct cpuset *cs = cont->cpuset;
+	struct cpuset *cs = container_cs(cont);
 	cpuset_filetype_t type = cft->private;
 	char *buffer;
 	int retval = 0;
@@ -929,7 +938,7 @@ static ssize_t cpuset_common_file_read(s
 				       char __user *buf,
 				       size_t nbytes, loff_t *ppos)
 {
-	struct cpuset *cs = cont->cpuset;
+	struct cpuset *cs = container_cs(cont);
 	cpuset_filetype_t type = cft->private;
 	char *page;
 	ssize_t retval = 0;
@@ -1048,7 +1057,7 @@ static struct cftype cft_spread_slab = {
 	.private = FILE_SPREAD_SLAB,
 };
 
-int cpuset_populate_dir(struct container *cont)
+int cpuset_populate(struct container *cont)
 {
 	int err;
 
@@ -1086,8 +1095,18 @@ int cpuset_populate_dir(struct container
 int cpuset_create(struct container *cont)
 {
 	struct cpuset *cs;
-	struct cpuset *parent = cont->parent->cpuset;
+	struct cpuset *parent;
+
+	if (!cont->parent) {
+		/* This is early initialization for the top container */
+		container_cs(cont) = &top_cpuset;
+		top_cpuset.container = cont;
+		top_cpuset.mems_generation = cpuset_mems_generation++;
+
+		return 0;
+	}
 
+	parent = container_cs(cont->parent);
 	cs = kmalloc(sizeof(*cs), GFP_KERNEL);
 	if (!cs)
 		return -ENOMEM;
@@ -1104,7 +1123,7 @@ int cpuset_create(struct container *cont
 	fmeter_init(&cs->fmeter);
 
 	cs->parent = parent;
-	cont->cpuset = cs;
+	container_cs(cont) = cs;
 	cs->container = cont;
 	return 0;
 }
@@ -1122,7 +1141,7 @@ int cpuset_create(struct container *cont
 
 void cpuset_destroy(struct container *cont)
 {
-	struct cpuset *cs = cont->cpuset;
+	struct cpuset *cs = container_cs(cont);
 
 	cpuset_update_task_memory_state();
 	if (is_cpu_exclusive(cs)) {
@@ -1131,6 +1150,15 @@ void cpuset_destroy(struct container *co
 	}
 }
 
+static struct container_subsys cpuset_subsys = {
+  .create = cpuset_create,
+  .destroy  = cpuset_destroy,
+  .can_attach = cpuset_can_attach,
+  .attach = cpuset_attach,
+  .post_attach = cpuset_post_attach,
+  .populate = cpuset_populate,
+};
+
 /*
  * cpuset_init_early - just enough so that the calls to
  * cpuset_update_task_memory_state() in early init code
@@ -1139,10 +1167,8 @@ void cpuset_destroy(struct container *co
 
 int __init cpuset_init_early(void)
 {
-	struct container *cont = current->container;
-	cont->cpuset = &top_cpuset;
-	top_cpuset.container = cont;
-	cont->cpuset->mems_generation = cpuset_mems_generation++;
+	if (container_register_subsys(&cpuset_subsys) < 0)
+		panic("Couldn't register cpuset subsystem");
 	return 0;
 }
 
@@ -1220,7 +1246,7 @@ cpumask_t cpuset_cpus_allowed(struct tas
 
 	container_lock();
 	task_lock(tsk);
-	guarantee_online_cpus(tsk->container->cpuset, &mask);
+	guarantee_online_cpus(task_cs(tsk), &mask);
 	task_unlock(tsk);
 	container_unlock();
 
@@ -1248,7 +1274,7 @@ nodemask_t cpuset_mems_allowed(struct ta
 
 	container_lock();
 	task_lock(tsk);
-	guarantee_online_mems(tsk->container->cpuset, &mask);
+	guarantee_online_mems(task_cs(tsk), &mask);
 	task_unlock(tsk);
 	container_unlock();
 
@@ -1353,7 +1379,7 @@ int __cpuset_zone_allowed(struct zone *z
 	container_lock();
 
 	task_lock(current);
-	cs = nearest_exclusive_ancestor(current->container->cpuset);
+	cs = nearest_exclusive_ancestor(task_cs(current));
 	task_unlock(current);
 
 	allowed = node_isset(node, cs->mems_allowed);
@@ -1421,7 +1447,7 @@ int cpuset_excl_nodes_overlap(const stru
 		task_unlock(current);
 		goto done;
 	}
-	cs1 = nearest_exclusive_ancestor(current->container->cpuset);
+	cs1 = nearest_exclusive_ancestor(task_cs(current));
 	task_unlock(current);
 
 	task_lock((struct task_struct *)p);
@@ -1429,7 +1455,7 @@ int cpuset_excl_nodes_overlap(const stru
 		task_unlock((struct task_struct *)p);
 		goto done;
 	}
-	cs2 = nearest_exclusive_ancestor(p->container->cpuset);
+	cs2 = nearest_exclusive_ancestor(task_cs((struct task_struct *)p));
 	task_unlock((struct task_struct *)p);
 
 	overlap = nodes_intersects(cs1->mems_allowed, cs2->mems_allowed);
@@ -1465,11 +1491,8 @@ int cpuset_memory_pressure_enabled __rea
 
 void __cpuset_memory_pressure_bump(void)
 {
-	struct cpuset *cs;
-
 	task_lock(current);
-	cs = current->container->cpuset;
-	fmeter_markevent(&cs->fmeter);
+	fmeter_markevent(&task_cs(current)->fmeter);
 	task_unlock(current);
 }
 
Index: linux-2.6.18/Documentation/containers.txt
===================================================================
--- linux-2.6.18.orig/Documentation/containers.txt
+++ linux-2.6.18/Documentation/containers.txt
@@ -21,8 +21,11 @@ CONTENTS:
 2. Usage Examples and Syntax
   2.1 Basic Usage
   2.2 Attaching processes
-3. Questions
-4. Contact
+3. Kernel API
+  3.1 Overview
+  3.2 Synchronization
+  3.3 Subsystem API
+4. Questions
 
 1. Containers
 ==========
@@ -214,8 +217,120 @@ If you have several tasks to attach, you
 	...
 # /bin/echo PIDn > tasks
 
+3. Kernel API
+=============
 
-3. Questions
+3.1 Overview
+------------
+
+Each kernel subsystem that wants to hook into the generic container
+system needs to create a container_subsys object. This contains
+various methods, which are callbacks from the container system, along
+with a subsystem id which will be assigned by the container system.
+
+Each container object created by the system has an array of pointers,
+indexed by subsystem id; this pointer is entirely managed by the
+subsystem; the generic container code will never touch this pointer.
+
+3.2 Synchronization
+-------------------
+
+There are two global mutexes used by the container system. The first
+is the manage_mutex, which should be taken by anything that wants to
+modify a container; The second if the callback_mutex, which should be
+taken by holders of the manage_mutex at the point when they actually
+make changes, and by callbacks from lower-level subsystems that want
+to ensure that no container changes occur.  Note that memory
+allocations cannot be made while holding callback_mutex.
+
+The callback_mutex nests inside the manage_mutex.
+
+In general, the pattern of use is:
+
+1) take manage_mutex
+2) verify that the change is valid and do any necessary allocations\
+3) take callback_mutex
+4) make changes
+5) release callback_mutex
+6) release manage_mutex
+
+See kernel/container.c for more details.
+
+Subsystems can take/release the manage_mutex via the functions
+container_manage_lock()/container_manage_unlock(), and can
+take/release the callback_mutex via the functions
+container_lock()/container_unlock().
+
+Accessing a task's container pointer may be done in the following ways:
+- while holding manage_mutex
+- while holding callback_mutex
+- while holding the task's alloc_lock (via task_lock())
+- inside an rcu_read_lock() section via rcu_dereference()
+
+3.3 Subsystem API
+--------------------------
+
+Each subsystem should call container_register_subsys() with a pointer
+to its subsystem object. This will store the new subsystem id in the
+subsystem subsys_id field and return 0, or a negative error.  There's
+currently no facility for deregestering a subsystem nor for
+registering a subsystem after any containers (other than the default
+"top_container") have been created.
+
+Each subsystem may export the following methods. Any that are null are
+presumed to be successful no-ops.
+
+int create(struct container *cont)
+LL=manage_mutext
+
+The subsystem should appropriately initialize its subsystem pointer
+for the passed container, returning 0 on success or a negative error
+code. Typically this will involve allocating a new per-container
+structure and storing a reference to it in the container, but there's
+nothing to stop a subsystem having multiple containers with pointers
+to the same subsystem object.  Note that this will be called during
+container_register_subsys() to initialize this subsystem on the root
+container.
+
+void destroy(struct container *cont)
+LL=manage_mutex
+
+The container system is about to destroy the passed container; the
+subsystem should do any necessary cleanup
+
+int can_attach(struct container *cont, struct task_struct *task)
+LL=manage_mutex
+
+Called prior to moving a task into a container; if the subsystem
+returns an error, this will abort the attach operation.  Note that
+this isn't called on a fork.
+
+void attach(struct container *cont, struct task_struct *task)
+LL=manage_mutex & callback_mutex
+
+Called during the attach operation.  The subsystem should do any
+necessary work that can be accomplished without memory allocations or
+sleeping.
+
+void post_attach(struct container *cont, struct container *old_cont,
+                 struct task_struct *task)
+LL=manage_mutex
+
+Called after the task has been attached to the container, to allow any
+post-attachment activity that requires memory allocations or blocking.
+
+int populate(struct container *cont)
+LL=none
+
+Called after creation of a container to allow a subsystem to populate
+the container directory with file entries.  The subsystem should make
+calls to container_add_file() with objects of type cftype (see
+include/linux/container.h for details).  Called during
+container_register_subsys() to populate the root container.  Note that
+although this method can return an error code, the error code is
+currently not always handled well.
+
+4. Questions
 ============
 
 Q: what's up with this '/bin/echo' ?

--
