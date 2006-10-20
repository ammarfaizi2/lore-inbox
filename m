Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992833AbWJTTHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992833AbWJTTHL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 15:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992860AbWJTTHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 15:07:10 -0400
Received: from smtp-out.google.com ([216.239.45.12]:42512 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S2992833AbWJTTHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 15:07:06 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:references:user-agent:date:from:to:cc:
	subject:content-disposition;
	b=NYyAHX2QBfeAbPYKzuOSarrytxBscmLoMvu9GSLhtU8lMN5iivy023LUAH/N61oPW
	igh+9ljX0OgmU3gv9YX7A==
Message-Id: <20061020190627.165204000@menage.corp.google.com>
References: <20061020183819.656586000@menage.corp.google.com>
User-Agent: quilt/0.45-1
Date: Fri, 20 Oct 2006 11:38:22 -0700
From: menage@google.com
To: akpm@osdl.org, pj@sgi.com, sekharan@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       jlan@sgi.com, mbligh@google.com, rohitseth@google.com,
       winget@google.com, Simon.Derr@bull.net
Subject: [PATCH 3/6] Add generic multi-subsystem API to containers
Content-Disposition: inline; filename=multiuser_container.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes all cpuset-specific knowlege from the container
system, replacing it with a generic API that can be used by multiple
subsystems. Cpusets is adapted to be a container subsystem.

Signed-off-by: Paul Menage <menage@google.com>

---
 Documentation/containers.txt |  160 ++++++++++++++++++++++++++++++++++++++-
 include/linux/container.h    |   43 +++++++++-
 include/linux/cpuset.h       |   11 --
 kernel/container.c           |  175 ++++++++++++++++++++++++++++++++++++-------
 kernel/cpuset.c              |  126 ++++++++++++++++++++----------
 5 files changed, 427 insertions(+), 88 deletions(-)

Index: container-2.6.19-rc2/include/linux/container.h
===================================================================
--- container-2.6.19-rc2.orig/include/linux/container.h
+++ container-2.6.19-rc2/include/linux/container.h
@@ -30,6 +30,8 @@ extern void container_unlock(void);
 extern void container_manage_lock(void);
 extern void container_manage_unlock(void);
 
+#define MAX_CONTAINER_SUBSYS 8
+
 struct container {
 	unsigned long flags;		/* "unsigned long" so bitops work */
 
@@ -48,9 +50,8 @@ struct container {
 	struct container *parent;	/* my parent */
 	struct dentry *dentry;		/* container fs entry */
 
-#ifdef CONFIG_CPUSETS
-	struct cpuset *cpuset;
-#endif
+	/* Private pointers for each registered subsystem */
+	void *subsys[MAX_CONTAINER_SUBSYS];
 };
 
 /* struct cftype:
@@ -87,6 +88,42 @@ int container_is_removed(const struct co
 void container_set_release_agent_path(const char *path);
 #endif
 
+/* Container subsystem type. See Documentation/containers.txt for details */
+
+struct container_subsys {
+	int (*create)(struct container_subsys *ss, struct container *cont);
+	void (*destroy)(struct container_subsys *ss, struct container *cont);
+	int (*can_attach)(struct container_subsys *ss,
+			  struct container *cont, struct task_struct *tsk);
+	void (*attach)(struct container_subsys *ss, struct container *cont,
+			struct container *old_cont, struct task_struct *tsk);
+	void (*post_attach)(struct container_subsys *ss,
+			    struct container *cont,
+			    struct container *old_cont,
+			    struct task_struct *tsk);
+	int (*populate)(struct container_subsys *ss,
+			struct container *cont);
+
+	int subsys_id;
+#define MAX_CONTAINER_TYPE_NAMELEN 32
+	const char *name;
+
+	/* enabled/disabled flag - managed by container.c, but can be
+	 * set to a default value before registration */
+	int enabled;
+
+	/* Fields below here are managed by container.c and should not
+	 * be accessed by subsystems. */
+
+	/* file handler for enable/disable */
+	struct cftype enable_cft;
+	char enable_cft_filename[MAX_CONTAINER_TYPE_NAMELEN + 10];
+
+
+};
+
+int container_register_subsys(struct container_subsys *subsys);
+
 #else /* !CONFIG_CONTAINERS */
 
 static inline int container_init_early(void) { return 0; }
Index: container-2.6.19-rc2/include/linux/cpuset.h
===================================================================
--- container-2.6.19-rc2.orig/include/linux/cpuset.h
+++ container-2.6.19-rc2/include/linux/cpuset.h
@@ -60,17 +60,6 @@ static inline int cpuset_do_slab_mem_spr
 
 extern void cpuset_track_online_nodes(void);
 
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
Index: container-2.6.19-rc2/kernel/container.c
===================================================================
--- container-2.6.19-rc2.orig/kernel/container.c
+++ container-2.6.19-rc2/kernel/container.c
@@ -55,7 +55,6 @@
 #include <linux/time.h>
 #include <linux/backing-dev.h>
 #include <linux/sort.h>
-#include <linux/cpuset.h>
 
 #include <asm/uaccess.h>
 #include <asm/atomic.h>
@@ -70,6 +69,9 @@
  */
 int number_of_containers __read_mostly;
 
+static struct container_subsys *subsys[MAX_CONTAINER_SUBSYS];
+static int subsys_count = 0;
+
 /* bits in struct container flags field */
 typedef enum {
 	CONT_REMOVED,
@@ -501,6 +503,7 @@ static int attach_task(struct container 
 	struct task_struct *tsk;
 	struct container *oldcont;
 	int retval = 0;
+	int s;
 
 	if (sscanf(pidbuf, "%d", &pid) != 1)
 		return -EIO;
@@ -527,12 +530,15 @@ static int attach_task(struct container 
 		get_task_struct(tsk);
 	}
 
-#ifdef CONFIG_CPUSETS
-	retval = cpuset_can_attach_task(cont, tsk);
-#endif
-	if (retval) {
-		put_task_struct(tsk);
-		return retval;
+	for (s = 0; s < subsys_count; s++) {
+		struct container_subsys *ss = subsys[s];
+		if (ss->enabled && ss->can_attach) {
+			retval = ss->can_attach(ss, cont, tsk);
+			if (retval) {
+				put_task_struct(tsk);
+				return retval;
+			}
+		}
 	}
 
 	mutex_lock(&callback_mutex);
@@ -549,15 +555,21 @@ static int attach_task(struct container 
 	rcu_assign_pointer(tsk->container, cont);
 	task_unlock(tsk);
 
-#ifdef CONFIG_CPUSETS
-	cpuset_attach_task(cont, tsk);
-#endif
+	for (s = 0; s < subsys_count; s++) {
+		struct container_subsys *ss = subsys[s];
+		if (ss->enabled && ss->attach) {
+			ss->attach(ss, cont, oldcont, tsk);
+		}
+	}
 
 	mutex_unlock(&callback_mutex);
 
-#ifdef CONFIG_CPUSETS
-	cpuset_post_attach_task(cont, oldcont, tsk);
-#endif
+	for (s = 0; s < subsys_count; s++) {
+		struct container_subsys *ss = subsys[s];
+		if (ss->enabled && ss->post_attach) {
+			ss->post_attach(ss, cont, oldcont, tsk);
+		}
+	}
 
 	put_task_struct(tsk);
 	synchronize_rcu();
@@ -574,6 +586,7 @@ typedef enum {
 	FILE_NOTIFY_ON_RELEASE,
 	FILE_TASKLIST,
 	FILE_RELEASE_AGENT,
+	FILE_ENABLED,
 } container_filetype_t;
 
 static ssize_t container_common_file_write(struct container *cont,
@@ -628,6 +641,18 @@ static ssize_t container_common_file_wri
 		}
 		break;
 	}
+	case FILE_ENABLED: {
+		struct container_subsys *ss;
+		if (number_of_containers != 1) {
+			retval = -EBUSY;
+			goto out2;
+		}
+		/* The cftype object is embedded in the subsys */
+		ss = container_of(cft, struct container_subsys, enable_cft);
+		ss->enabled = simple_strtoul(buffer, NULL, 10) != 0;
+		retval = 0;
+		break;
+	}
 	default:
 		retval = -EINVAL;
 		goto out2;
@@ -692,6 +717,13 @@ static ssize_t container_common_file_rea
 		s += n;
 		break;
 	}
+	case FILE_ENABLED: {
+		struct container_subsys *ss;
+		/* The cftype object is embedded in the subsys */
+		ss = container_of(cft, struct container_subsys, enable_cft);
+		*s++ = ss->enabled ? '1' : '0';
+		break;
+	}
 	default:
 		retval = -EINVAL;
 		goto out;
@@ -1034,9 +1066,17 @@ static struct cftype cft_release_agent =
 	.private = FILE_RELEASE_AGENT,
 };
 
+/* This is just a template for the per-subsystem xxx_enabled file */
+static struct cftype cft_enabled_template = {
+	.read = container_common_file_read,
+	.write = container_common_file_write,
+	.private = FILE_ENABLED,
+};
+
 static int container_populate_dir(struct container *cont)
 {
 	int err;
+	int s;
 
 	if ((err = container_add_file(cont, &cft_notify_on_release)) < 0)
 		return err;
@@ -1045,10 +1085,19 @@ static int container_populate_dir(struct
 	if ((cont == &top_container) &&
 	    (err = container_add_file(cont, &cft_release_agent)) < 0)
 		return err;
-#ifdef CONFIG_CPUSETS
-	if ((err = cpuset_populate_dir(cont)) < 0)
-		return err;
-#endif
+	for (s = 0; s < subsys_count; s++) {
+		struct container_subsys *ss = subsys[s];
+		/* All subsystems have an "xxx_enabled" file in the top dir */
+		if (cont == &top_container &&
+		    (err = container_add_file(cont, &ss->enable_cft)) < 0)
+			return err;
+		/* All subsystems live in the top dir; only enabled
+		 * subsystems live in subdirs */
+		if (ss->enabled || (cont == &top_container)) {
+			if (ss->populate && (err = ss->populate(ss, cont)) < 0)
+				return err;
+		}
+	}
 	return 0;
 }
 
@@ -1065,6 +1114,7 @@ static long container_create(struct cont
 {
 	struct container *cont;
 	int err;
+	int s = 0;
 
 	cont = kmalloc(sizeof(*cont), GFP_KERNEL);
 	if (!cont)
@@ -1080,11 +1130,23 @@ static long container_create(struct cont
 
 	cont->parent = parent;
 
-#ifdef CONFIG_CPUSETS
-	err = cpuset_create(cont);
-	if (err)
-		goto err_unlock_free;
-#endif
+	for (s = 0; s < subsys_count; s++) {
+		struct container_subsys *ss = subsys[s];
+		if (ss->enabled) {
+			err = ss->create(ss, cont);
+			if (err) {
+				for (s--; s >= 0; s--) {
+					ss = subsys[s];
+					if (ss->enabled)
+						ss->destroy(ss, cont);
+				}
+				goto err_unlock_free;
+			}
+		} else {
+			/* Just copy subsys object from parent */
+			cont->subsys[s] = parent->subsys[s];
+		}
+	}
 
 	mutex_lock(&callback_mutex);
 	list_add(&cont->sibling, &cont->parent->children);
@@ -1107,9 +1169,12 @@ static long container_create(struct cont
 	return 0;
 
  err_remove:
-#ifdef CONFIG_CPUSETS
-	cpuset_destroy(cont);
-#endif
+	for (s = subsys_count - 1; s >= 0; s--) {
+		struct container_subsys *ss = subsys[s];
+		if (ss->enabled)
+			ss->destroy(ss, cont);
+	}
+
 	mutex_lock(&callback_mutex);
 	list_del(&cont->sibling);
 	number_of_containers--;
@@ -1145,6 +1210,7 @@ static int container_rmdir(struct inode 
 	struct dentry *d;
 	struct container *parent;
 	char *pathbuf = NULL;
+	int s;
 
 	/* the vfs holds both inode->i_mutex already */
 
@@ -1169,9 +1235,11 @@ static int container_rmdir(struct inode 
 	dput(d);
 	number_of_containers--;
 	mutex_unlock(&callback_mutex);
-#ifdef CONFIG_CPUSETS
-	cpuset_destroy(cont);
-#endif
+	for (s = 0; s < subsys_count; s++) {
+                struct container_subsys *ss = subsys[s];
+		if (ss->enabled)
+			ss->destroy(ss, cont);
+	}
 	if (list_empty(&parent->children))
 		check_for_release(parent, &pathbuf);
 	mutex_unlock(&manage_mutex);
@@ -1226,6 +1294,57 @@ out:
 	return err;
 }
 
+int container_register_subsys(struct container_subsys *new_subsys) {
+	int retval = 0;
+	int i;
+	mutex_lock(&manage_mutex);
+	if (number_of_containers > 1) {
+		retval = -EBUSY;
+		goto out;
+	}
+	if (subsys_count == MAX_CONTAINER_SUBSYS) {
+		retval = -ENOSPC;
+		goto out;
+	}
+	if (!new_subsys->name ||
+	    (strlen(new_subsys->name) > MAX_CONTAINER_TYPE_NAMELEN) ||
+	    !new_subsys->create || !new_subsys->destroy) {
+		retval = -EINVAL;
+		goto out;
+	}
+	for (i = 0; i < subsys_count; i++) {
+		if (!strcmp(subsys[i]->name, new_subsys->name)) {
+			retval = -EEXIST;
+			goto out;
+		}
+	}
+
+	subsys[subsys_count] = new_subsys;
+	new_subsys->subsys_id = subsys_count++;
+	retval = new_subsys->create(new_subsys, &top_container);
+	if (retval) {
+		new_subsys->subsys_id = -1;
+		subsys_count--;
+		goto out;
+	}
+
+	/* Set up the per-container "enabled" file */
+	strcpy(new_subsys->enable_cft_filename, new_subsys->name);
+	strcat(new_subsys->enable_cft_filename, "_enabled");
+	new_subsys->enable_cft = cft_enabled_template;
+	new_subsys->enable_cft.name = new_subsys->enable_cft_filename;
+
+	/* Only populate the top container if we've done
+	 * container_init() */
+	if (container_mount && new_subsys->populate) {
+		new_subsys->populate(new_subsys, &top_container);
+		container_add_file(&top_container, &new_subsys->enable_cft);
+	}
+ out:
+	mutex_unlock(&manage_mutex);
+	return retval;
+}
+
 /**
  * container_fork - attach newly forked task to its parents container.
  * @tsk: pointer to task_struct of forking parent process.
Index: container-2.6.19-rc2/kernel/cpuset.c
===================================================================
--- container-2.6.19-rc2.orig/kernel/cpuset.c
+++ container-2.6.19-rc2/kernel/cpuset.c
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2003 BULL SA.
  *  Copyright (C) 2004-2006 Silicon Graphics, Inc.
+ *  Copyright (C) 2006 Google, Inc
  *
  *  Portions derived from Patrick Mochel's sysfs code.
  *  sysfs is Copyright (c) 2001-3 Patrick Mochel
@@ -12,6 +13,7 @@
  *  2003-10-10 Written by Simon Derr.
  *  2003-10-22 Updates by Stephen Hemminger.
  *  2004 May-July Rework by Paul Jackson.
+ *  2006 Rework by Paul Menage to use generic containers
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License.  See the file COPYING in the main directory of the Linux
@@ -61,6 +63,25 @@
  */
 int number_of_cpusets __read_mostly;
 
+/* Retrieve the cpuset from a container */
+static struct container_subsys cpuset_subsys;
+static inline struct cpuset *container_cs(struct container *cont)
+{
+	return (struct cpuset *)cont->subsys[cpuset_subsys.subsys_id];
+}
+
+/* Update the cpuset for a container */
+static inline void set_container_cs(struct container *cont, struct cpuset *cs)
+{
+	cont->subsys[cpuset_subsys.subsys_id] = cs;
+}
+
+/* Retrieve the cpuset for a task */
+static inline struct cpuset *task_cs(struct task_struct *task)
+{
+	return container_cs(task->container);
+}
+
 /* See "Frequency meter" comments, below. */
 
 struct fmeter {
@@ -166,6 +187,12 @@ static int cpuset_get_sb(struct file_sys
 					   data, mnt);
 		put_filesystem(container_fs);
 	}
+	container_manage_lock();
+	if (number_of_containers == 1) {
+		/* For legacy compatibility, cpuset starts enabled */
+		cpuset_subsys.enabled = 1;
+	}
+	container_manage_unlock();
 	return ret;
 }
 
@@ -271,20 +298,21 @@ void cpuset_update_task_memory_state(voi
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
@@ -344,8 +372,7 @@ static int validate_change(const struct 
 
 	/* Each of our child cpusets must be a subset of us */
 	list_for_each_entry(cont, &cur->container->children, sibling) {
-		c = cont->cpuset;
-		if (!is_cpuset_subset(c, trial))
+		if (!is_cpuset_subset(container_cs(cont), trial))
 			return -EBUSY;
 	}
 
@@ -359,7 +386,7 @@ static int validate_change(const struct 
 
 	/* If either I or some sibling (!= me) is exclusive, we can't overlap */
 	list_for_each_entry(cont, &par->container->children, sibling) {
-		c = cont->cpuset;
+		c = container_cs(cont);
 		if ((is_cpu_exclusive(trial) || is_cpu_exclusive(c)) &&
 		    c != cur &&
 		    cpus_intersects(trial->cpus_allowed, c->cpus_allowed))
@@ -402,7 +429,7 @@ static void update_cpu_domains(struct cp
 	 */
 	pspan = par->cpus_allowed;
 	list_for_each_entry(cont, &par->container->children, sibling) {
-		c = cont->cpuset;
+		c = container_cs(cont);
 		if (is_cpu_exclusive(c))
 			cpus_andnot(pspan, pspan, c->cpus_allowed);
 	}
@@ -420,7 +447,7 @@ static void update_cpu_domains(struct cp
 		 * of exclusive children
 		 */
 		list_for_each_entry(cont, &cur->container->children, sibling) {
-			c = cont->cpuset;
+			c = container_cs(cont);
 			if (is_cpu_exclusive(c))
 				cpus_andnot(cspan, cspan, c->cpus_allowed);
 		}
@@ -508,7 +535,7 @@ static void cpuset_migrate_mm(struct mm_
 	do_migrate_pages(mm, from, to, MPOL_MF_MOVE_ALL);
 
 	container_lock();
-	guarantee_online_mems(tsk->container->cpuset, &tsk->mems_allowed);
+	guarantee_online_mems(task_cs(tsk),&tsk->mems_allowed);
 	container_unlock();
 }
 
@@ -796,9 +823,10 @@ static int fmeter_getrate(struct fmeter 
 	return val;
 }
 
-int cpuset_can_attach_task(struct container *cont, struct task_struct *tsk)
+int cpuset_can_attach(struct container_subsys *ss,
+                      struct container *cont, struct task_struct *tsk)
 {
-	struct cpuset *cs = cont->cpuset;
+	struct cpuset *cs = container_cs(cont);
 
 	if (cpus_empty(cs->cpus_allowed) || nodes_empty(cs->mems_allowed))
 		return -ENOSPC;
@@ -806,22 +834,23 @@ int cpuset_can_attach_task(struct contai
 	return security_task_setscheduler(tsk, 0, NULL);
 }
 
-void cpuset_attach_task(struct container *cont, struct task_struct *tsk)
+void cpuset_attach(struct container_subsys *ss, struct container *cont,
+                   struct container *old_cont, struct task_struct *tsk)
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
+void cpuset_post_attach(struct container_subsys *ss,
+			struct container *cont,
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
@@ -855,7 +884,7 @@ static ssize_t cpuset_common_file_write(
 					const char __user *userbuf,
 					size_t nbytes, loff_t *unused_ppos)
 {
-	struct cpuset *cs = cont->cpuset;
+	struct cpuset *cs = container_cs(cont);
 	cpuset_filetype_t type = cft->private;
 	char *buffer;
 	int retval = 0;
@@ -965,7 +994,7 @@ static ssize_t cpuset_common_file_read(s
 				       char __user *buf,
 				       size_t nbytes, loff_t *ppos)
 {
-	struct cpuset *cs = cont->cpuset;
+	struct cpuset *cs = container_cs(cont);
 	cpuset_filetype_t type = cft->private;
 	char *page;
 	ssize_t retval = 0;
@@ -1084,7 +1113,7 @@ static struct cftype cft_spread_slab = {
 	.private = FILE_SPREAD_SLAB,
 };
 
-int cpuset_populate_dir(struct container *cont)
+int cpuset_populate(struct container_subsys *ss, struct container *cont)
 {
 	int err;
 
@@ -1119,11 +1148,21 @@ int cpuset_populate_dir(struct container
  *	Must be called with the mutex on the parent inode held
  */
 
-int cpuset_create(struct container *cont)
+int cpuset_create(struct container_subsys *ss, struct container *cont)
 {
 	struct cpuset *cs;
-	struct cpuset *parent = cont->parent->cpuset;
+	struct cpuset *parent;
+
+	if (!cont->parent) {
+		/* This is early initialization for the top container */
+		set_container_cs(cont, &top_cpuset);
+		top_cpuset.container = cont;
+		top_cpuset.mems_generation = cpuset_mems_generation++;
+
+		return 0;
+	}
 
+	parent = container_cs(cont->parent);
 	cs = kmalloc(sizeof(*cs), GFP_KERNEL);
 	if (!cs)
 		return -ENOMEM;
@@ -1140,7 +1179,7 @@ int cpuset_create(struct container *cont
 	fmeter_init(&cs->fmeter);
 
 	cs->parent = parent;
-	cont->cpuset = cs;
+	set_container_cs(cont, cs);
 	cs->container = cont;
 	number_of_cpusets++;
 	return 0;
@@ -1157,9 +1196,9 @@ int cpuset_create(struct container *cont
  * nesting would risk an ABBA deadlock.
  */
 
-void cpuset_destroy(struct container *cont)
+void cpuset_destroy(struct container_subsys *ss, struct container *cont)
 {
-	struct cpuset *cs = cont->cpuset;
+	struct cpuset *cs = container_cs(cont);
 
 	cpuset_update_task_memory_state();
 	if (is_cpu_exclusive(cs)) {
@@ -1169,6 +1208,16 @@ void cpuset_destroy(struct container *co
 	number_of_cpusets--;
 }
 
+static struct container_subsys cpuset_subsys = {
+	.name = "cpuset",
+	.create = cpuset_create,
+	.destroy  = cpuset_destroy,
+	.can_attach = cpuset_can_attach,
+	.attach = cpuset_attach,
+	.post_attach = cpuset_post_attach,
+	.populate = cpuset_populate,
+};
+
 /*
  * cpuset_init_early - just enough so that the calls to
  * cpuset_update_task_memory_state() in early init code
@@ -1177,10 +1226,8 @@ void cpuset_destroy(struct container *co
 
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
 
@@ -1337,7 +1384,7 @@ cpumask_t cpuset_cpus_allowed(struct tas
 
 	container_lock();
 	task_lock(tsk);
-	guarantee_online_cpus(tsk->container->cpuset, &mask);
+	guarantee_online_cpus(task_cs(tsk), &mask);
 	task_unlock(tsk);
 	container_unlock();
 
@@ -1365,7 +1412,7 @@ nodemask_t cpuset_mems_allowed(struct ta
 
 	container_lock();
 	task_lock(tsk);
-	guarantee_online_mems(tsk->container->cpuset, &mask);
+	guarantee_online_mems(task_cs(tsk), &mask);
 	task_unlock(tsk);
 	container_unlock();
 
@@ -1470,7 +1517,7 @@ int __cpuset_zone_allowed(struct zone *z
 	container_lock();
 
 	task_lock(current);
-	cs = nearest_exclusive_ancestor(current->container->cpuset);
+	cs = nearest_exclusive_ancestor(task_cs(current));
 	task_unlock(current);
 
 	allowed = node_isset(node, cs->mems_allowed);
@@ -1538,7 +1585,7 @@ int cpuset_excl_nodes_overlap(const stru
 		task_unlock(current);
 		goto done;
 	}
-	cs1 = nearest_exclusive_ancestor(current->container->cpuset);
+	cs1 = nearest_exclusive_ancestor(task_cs(current));
 	task_unlock(current);
 
 	task_lock((struct task_struct *)p);
@@ -1546,7 +1593,7 @@ int cpuset_excl_nodes_overlap(const stru
 		task_unlock((struct task_struct *)p);
 		goto done;
 	}
-	cs2 = nearest_exclusive_ancestor(p->container->cpuset);
+	cs2 = nearest_exclusive_ancestor(task_cs((struct task_struct *)p));
 	task_unlock((struct task_struct *)p);
 
 	overlap = nodes_intersects(cs1->mems_allowed, cs2->mems_allowed);
@@ -1582,11 +1629,8 @@ int cpuset_memory_pressure_enabled __rea
 
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
 
Index: container-2.6.19-rc2/Documentation/containers.txt
===================================================================
--- container-2.6.19-rc2.orig/Documentation/containers.txt
+++ container-2.6.19-rc2/Documentation/containers.txt
@@ -17,12 +17,16 @@ CONTENTS:
   1.2 Why are containers needed ?
   1.3 How are containers implemented ?
   1.4 What does notify_on_release do ?
-  1.5 How do I use containers ?
+  1.5 What do the xxx_enabled files do ?
+  1.6 How do I use containers ?
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
@@ -129,7 +133,18 @@ The default value of notify_on_release i
 boot is disabled (0).  The default value of other containers at creation
 is the current value of their parents notify_on_release setting.
 
-1.5 How do I use containers ?
+1.5 What do the xxx_enabled files do ?
+--------------------------------------
+
+In the top-level container directory there are a series of
+<subsys>_enabled files, one for each registered subsystem.  Each of
+these files contains 0 or 1 to indicate whether the named container
+subsystem is enabled, and can only be modified when there are no
+subcontainers.  Disabled container subsystems don't get new instances
+created when a subcontainer is created; the subsystem-specific state
+is simply inherited from the parent container.
+
+1.6 How do I use containers ?
 --------------------------
 
 To start a new job that is to be contained within a container, the steps are:
@@ -214,8 +229,143 @@ If you have several tasks to attach, you
 	...
 # /bin/echo PIDn > tasks
 
+3. Kernel API
+=============
+
+3.1 Overview
+------------
+
+Each kernel subsystem that wants to hook into the generic container
+system needs to create a container_subsys object. This contains
+various methods, which are callbacks from the container system, along
+with a subsystem id which will be assigned by the container system.
+
+Other fields in the container_subsys object include:
+
+- subsys_id: a unique array index for the subsystem, indicating which
+  entry in container->subsys[] this subsystem should be
+  managing. Initialized by container_register_subsys();
+
+- name: should be initialized to a unique subsystem name prior to
+  calling container_register_subsystem. Should be no longer than
+  MAX_CONTAINER_TYPE_NAMELEN
+
+- enabled: determines whether that container type is in use when
+  creating subcontainers. It's managed by the container system, but
+  may be initialized to either 0 or 1 prior to calling
+  container_register_subsystem
+
+Each container object created by the system has an array of pointers,
+indexed by subsystem id; this pointer is entirely managed by the
+subsystem; the generic container code will never touch this pointer.
+
+Note that all subsystems share the same hierarchy of containers; it's
+not currently possible to have independent hierarchies and container
+memberships for different subsystems.
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
+Each subsystem may export the following methods. The only mandatory
+methods are create/destroy. Any others that are null are presumed to
+be successful no-ops.
+
+int create(struct container *cont)
+LL=manage_mutex
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
+int can_attach(struct container_subsys *ss, struct container *cont,
+               struct task_struct *task)
+LL=manage_mutex
+
+Called prior to moving a task into a container; if the subsystem
+returns an error, this will abort the attach operation.  Note that
+this isn't called on a fork.
+
+void attach(struct container_subsys *ss, struct container *cont,
+	    struct container *old_cont, struct task_struct *task)
+LL=manage_mutex & callback_mutex
+
+Called during the attach operation.  The subsystem should do any
+necessary work that can be accomplished without memory allocations or
+sleeping.
+
+void post_attach(struct container_subsys *ss, struct container *cont,
+		 struct container *old_cont, struct task_struct *task)
+LL=manage_mutex
+
+Called after the task has been attached to the container, to allow any
+post-attachment activity that requires memory allocations or blocking.
+
+int populate(struct container_subsys *ss, struct container *cont)
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
 
-3. Questions
+4. Questions
 ============
 
 Q: what's up with this '/bin/echo' ?

--
