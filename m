Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265724AbUF2Lc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265724AbUF2Lc4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 07:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265722AbUF2Lc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 07:32:56 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:44486 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S265727AbUF2LX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 07:23:28 -0400
Date: Tue, 29 Jun 2004 04:22:26 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Jack Steiner <steiner@sgi.com>,
       Jesse Barnes <jbarnes@sgi.com>, Paul Jackson <pj@sgi.com>,
       Dan Higgins <djh@sgi.com>, Matthew Dobson <colpatch@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Sylvain <sylvain.jeaugey@bull.net>,
       Simon <Simon.Derr@bull.net>
Message-Id: <20040629112226.24730.47768.69265@sam.engr.sgi.com>
In-Reply-To: <20040629112140.24730.18796.34300@sam.engr.sgi.com>
References: <20040629112140.24730.18796.34300@sam.engr.sgi.com>
Subject: [patch 6/8] cpusets v3 - The main new files: cpuset.c, cpuset.h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The main cpuset patch - including Documentation, kernel/cpuset.c,
cpuset.h, and the kernel/Makefile hook.

The main cpuset code establishes a hierarchy of cpusets, visible
in a pseudo filesystem.  Each task links to the cpuset that controls
its CPU and Memory placement.  The CPUs and Memory Nodes allowed
to any particular cpuset are always a subset of that cpusets
parent, with the top cpuset containing all CPUs and Memory Nodes
in the system.

This hierarchy is required in order to efficiently provide for strictly
exclusive cpusets - the CPUs and Memory Nodes of a strictly exclusive
cpuset are guaranteed by the kernel to not be part of any other cpuset
that is not a direct ancestor or descendent.

Follow on patches will add the necessary kernel hooks to connect
cpusets with the rest of the kernel.


Index: 2.6.7-mm4/Documentation/cpusets.txt
===================================================================
--- /dev/null
+++ 2.6.7-mm4/Documentation/cpusets.txt
@@ -0,0 +1,174 @@
+				CPUSETS
+				-------
+
+Copyright (C) 2004 BULL SA.
+Written by Simon.Derr@bull.net
+
+CONTENTS:
+=========
+
+1. cpusets
+  1.1 What are CPUSETS ?
+  1.2 What can I do with CPUSETS ?
+2. CSFS
+  2.1 Overview
+  2.2 Adding/removing cpus
+  2.3 Setting flags
+  2.4 Attaching processes
+3. Questions
+4. Contact
+
+1. cpusets
+==========
+
+1.1 What are CPUSETS ?
+----------------------
+
+Cpusets provide a simple mechanism for organizing the set of CPUs and
+Memory Nodes assigned to a set of tasks on a large SMP or NUMA system.
+
+Each task has a single cpuset pointer, to the cpuset assigned it.
+A task may only use CPUs (sched_setaffinity) and Memory Nodes (mbind
+or set_mempolicy) contained in its assigned cpuset.  If a cpuset is
+strictly exclusive, no other unrelated (not ancestor or descendent)
+cpuset may overlap (have the same CPU or Memory Node).
+
+User level code may create and destroy cpusets by name in the cpuset
+pseudo filesystem, manage the attributes and permissions of these
+cpusets and which CPUs and Memory Nodes are assigned to each cpuset,
+specify and query to which cpuset a task is assigned, and list the
+task pids assigned to a cpuset.
+
+Some domains in which it can be useful :
+
+    * Web Servers running multiple instances of the same web application.
+    * Servers running different applications (for instance, a web server and a
+      database).
+    * HPC applications, especially in NUMA machines.
+
+
+1.2 What can I do with CPUSETS ?
+--------------------------------
+
+CPUSETS allow to:
+
+   1. create sets of CPUs on the system, and bind applications to them
+
+   2. translate the masks of CPUs given to sched_setaffinity() so they stay
+inside the set of CPUs. With this mechanism, processors are virtualized, for
+the use of sched_setaffinity() and /proc information. Thus, any former
+application using this syscall to bind processes to processors will work with
+virtual CPUs without any change.
+
+   3. provide a way to create sets of cpus *inside* a set of cpus : hence a
+system administrator can partition a system among users, and users can
+partition their partition among their applications.
+
+   4. Change on the fly the execution area of a whole set of processes (to give
+more resources to a critical application, for example).
+
+
+2. CSFS
+=======
+
+You already guessed that CSFS stands for 'CpuSets FileSystem'...
+
+2.1 Overview
+------------
+
+Creating, modifying, using the cpusets can be done through the csfs pseudo
+filesystem.
+
+To mount it, type:
+# mount -t csfs none /proc/cpusets
+
+Then under /proc/cpusets you can find a tree that corresponds to the tree of the
+cpusets in the system. For instance, /proc/cpusets/top_cpuset is the cpuset that
+holds the whole system.
+
+If you want to create a new cpuset under top_cpuset:
+# cd /proc/cpusets/top_cpuset
+# mkdir my_cpuset
+
+Now you want to do something with this cpuset.
+# cd my_cpuset
+
+In this directory you can find several files:
+# ls
+autoclean  debug  reserved_cpus  strictly_reserved_cpus
+cpus       id     strict         tasks
+
+Reading them will give you information about the state of this cpuset: the CPUs
+it can use, the processes that are using it, its properties... And Writing to
+these files you can manipulate the cpuset.
+
+Set some flags:
+# /bin/echo 1 > autoclean
+
+Add some cpus:
+# /bin/echo 0-7 > cpus
+
+Now attach your shell to this cpuset:
+# /bin/echo $$ > tasks
+
+You can also create cpusets inside your cpuset by using mkdir in this directory.
+# mkdir my_sub_cs
+
+To remove a cpuset, juste use rmdir:
+# rmdir my_sub_cs
+This will fail is the cpuset is in use (has cpusets inside, or has processes
+attached).
+
+2.2 Adding/removing cpus
+------------------------
+
+This is the syntax to use when writing in /proc/cpusets/top_cpuset/foo/bar/cpus
+
+# /bin/echo 1-4 > cpus		-> set cpus list to cpus 1,2,3,4
+# /bin/echo 1,2,3,4 > cpus	-> set cpus list to cpus 1,2,3,4
+# /bin/echo +1 > cpus		-> add cpu 1 to the cpus list
+# /bin/echo -1-4 > cpus		-> remove cpus 1,2,3,4 from the cpus list
+# /bin/echo -1,2,3,4 > cpus	-> remove cpus 1,2,3,4 from the cpus list
+
+All these can be mixed together:
+# /bin/echo 1-7 -6 +9,10	-> set cpus list to 1,2,3,4,5,7,9,10
+
+2.3 Setting flags
+-----------------
+
+The syntax is very simple:
+
+# /bin/echo 1 > strict 		-> set flag 'strict'
+# /bin/echo 0 > strict 		-> unset flag 'strict'
+# /bin/echo 1 > autoclean 	-> set flag 'autoclean'
+
+2.4 Attaching processes
+-----------------------
+
+# /bin/echo PID > tasks
+
+Note that it is PID, not PIDs. You can only attach ONE task at a time.
+If you have several tasks to attach, you have to do it one after another:
+
+# /bin/echo PID1 > tasks
+# /bin/echo PID2 > tasks
+	...
+# /bin/echo PIDn > tasks
+
+
+3. Questions
+============
+
+Q: what's up with this '/bin/echo' ?
+A: bash's builtin 'echo' command does not check calls to write() against
+   errors. If you use it in the csfs cpusets interface, you won't be
+   able to tell whether a command succeeded or failed.
+
+Q: When I attach processes, only the first of the line gets really attached !
+A: We can only return one error code per call to write(). So you should also
+   put only ONE pid.
+
+4. Contact
+==========
+
+Web: http://www.bullopensource.org/cpuset
Index: 2.6.7-mm4/include/linux/cpuset.h
===================================================================
--- /dev/null
+++ 2.6.7-mm4/include/linux/cpuset.h
@@ -0,0 +1,41 @@
+#ifndef _LINUX_CPUSET_H
+#define _LINUX_CPUSET_H
+/*
+ *  cpuset interface
+ *
+ *  Copyright (C) 2003 BULL SA
+ *
+ */
+
+#include <linux/sched.h>
+#include <linux/cpumask.h>
+#include <linux/nodemask.h>
+
+#ifdef CONFIG_CPUSETS
+
+extern int cpuset_init(void);
+extern void cpuset_fork(struct task_struct *p);
+extern void cpuset_exit(struct task_struct *p);
+extern const cpumask_t cpuset_cpus_allowed(const struct task_struct *p);
+extern const nodemask_t cpuset_mems_allowed(const struct task_struct *p);
+extern int proc_pid_cspath(struct task_struct *p, char *buf, int len);
+
+#else /* !CONFIG_CPUSETS */
+
+static inline int cpuset_init(void) { return 0; }
+static inline void cpuset_fork(struct task_struct *p) {}
+static inline void cpuset_exit(struct task_struct *p) {}
+
+static inline const cpumask_t cpuset_cpus_allowed(struct task_struct *p)
+{
+	return cpu_possible_map;
+}
+
+static inline const nodemask_t cpuset_mems_allowed(struct task_struct *p)
+{
+	return node_possible_map;
+}
+
+#endif /* !CONFIG_CPUSETS */
+
+#endif /* _LINUX_CPUSET_H */
Index: 2.6.7-mm4/kernel/Makefile
===================================================================
--- 2.6.7-mm4.orig/kernel/Makefile
+++ 2.6.7-mm4/kernel/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_IKCONFIG_PROC) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
 obj-$(CONFIG_AUDIT) += audit.o
 obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
+obj-$(CONFIG_CPUSETS) += cpuset.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: 2.6.7-mm4/kernel/cpuset.c
===================================================================
--- /dev/null
+++ 2.6.7-mm4/kernel/cpuset.c
@@ -0,0 +1,1531 @@
+/*
+ *  kernel/cpuset.c
+ *
+ *  Processor and Memory placement constraints for sets of tasks.
+ *
+ *  Copyright (C) 2003 BULL SA.
+ *
+ *  Portions derived from Patrick Mochel's sysfs code.
+ *  sysfs is Copyright (c) 2001-3 Patrick Mochel
+ *
+ *  2003-10-10 Written by Simon Derr <simon.derr@bull.net>
+ *  2003-10-22 Updates by Stephen Hemminger.
+ *  2004 May-June Some rework by Paul Jackson <pj@sgi.com>
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of the Linux
+ *  distribution for more details.
+ */
+
+#include <linux/config.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/cpuset.h>
+#include <linux/errno.h>
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include <linux/pagemap.h>
+#include <linux/proc_fs.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/spinlock.h>
+#include <linux/stat.h>
+#include <linux/string.h>
+#include <linux/time.h>
+#include <linux/backing-dev.h>
+
+#include <asm/uaccess.h>
+#include <asm/atomic.h>
+#include <asm/semaphore.h>
+
+#define CPUSET_SUPER_MAGIC 		0x27e0eb
+
+struct cpuset {
+	unsigned long flags;		/* "unsigned long" so bitops work */
+	cpumask_t cpus_allowed;		/* CPUs allowed to tasks in cpuset */
+	nodemask_t mems_allowed;	/* Memory Nodes allowed to tasks */
+	struct cpuset *parent;		/* my parent */
+	/*
+	 * We link our 'sibling' struct into our parents 'children'.
+	 * Our children link their 'sibling' into our 'children'.
+	 */
+	struct list_head sibling;	/* my parents children */
+	struct list_head children;	/* my children */
+	atomic_t count;			/* count all users (tasks + children) */
+	struct dentry *dentry;		/* cpuset fs entry */
+};
+
+/* bits in struct cpuset flags field */
+typedef enum {
+	CS_CPUSTRICT,
+	CS_MEMSTRICT,
+	CS_AUTOCLEAN,
+	CS_HAS_BEEN_ATTACHED,
+	CS_REMOVED,
+} cpuset_flagbits_t;
+
+/* convenient tests for these bits */
+static inline int is_cpustrict(const struct cpuset *cs)
+{
+	return !!test_bit(CS_CPUSTRICT, &cs->flags);
+}
+
+static inline int is_memstrict(const struct cpuset *cs)
+{
+	return !!test_bit(CS_MEMSTRICT, &cs->flags);
+}
+
+static inline int is_autoclean(const struct cpuset *cs)
+{
+	return !!test_bit(CS_AUTOCLEAN, &cs->flags);
+}
+
+static inline int has_been_attached(const struct cpuset *cs)
+{
+	return !!test_bit(CS_HAS_BEEN_ATTACHED, &cs->flags);
+}
+
+static inline int is_removed(const struct cpuset *cs)
+{
+	return !!test_bit(CS_REMOVED, &cs->flags);
+}
+
+static struct cpuset top_cpuset = {
+	.flags = ((1 << CS_CPUSTRICT) | (1 << CS_MEMSTRICT)),
+	.parent = NULL,
+	.sibling = LIST_HEAD_INIT(top_cpuset.sibling),
+	.children = LIST_HEAD_INIT(top_cpuset.children),
+	.count = ATOMIC_INIT(1),	/* top_cpuset can't be deleted */
+	.cpus_allowed = CPU_MASK_ALL,
+	.mems_allowed = NODE_MASK_ALL,
+};
+
+static struct vfsmount *cpuset_mount;
+static struct super_block *cpuset_sb = NULL;
+
+/*
+ * cpuset_sem should be held by anyone who is depending on the children
+ * or sibling lists of any cpuset, or performing non-atomic operations
+ * on the flags or *_allowed values of a cpuset, such as raising the
+ * CS_REMOVED flag bit iff it is not already raised, or reading and
+ * conditionally modifying the *_allowed values.  One kernel global
+ * cpuset semaphore should be sufficient - these things don't change
+ * that much.
+ */
+static DECLARE_MUTEX(cpuset_sem);
+
+static long cpuset_create(struct cpuset *parent, const char *name, int mode);
+static int cpuset_populate_dir(struct dentry *cs_dentry);
+static void release_cpuset_unlocked(struct cpuset *cs);
+static int cpuset_destroy(struct cpuset *cs);
+static int create_dir(struct cpuset *cs, struct dentry *p, const char *n,
+						struct dentry **d, int mode);
+
+static struct backing_dev_info cpuset_backing_dev_info = {
+	.ra_pages = 0,		/* No readahead */
+	.memory_backed = 1,	/* Does not contribute to dirty memory */
+};
+
+static struct inode *cpuset_new_inode(mode_t mode)
+{
+	struct inode *inode = new_inode(cpuset_sb);
+	if (inode) {
+		inode->i_mode = mode;
+		inode->i_uid = current->fsuid;
+		inode->i_gid = current->fsgid;
+		inode->i_blksize = PAGE_CACHE_SIZE;
+		inode->i_blocks = 0;
+		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		inode->i_mapping->backing_dev_info = &cpuset_backing_dev_info;
+	}
+	return inode;
+}
+
+static void cpuset_diput(struct dentry *dentry, struct inode *inode)
+{
+	/* is dentry a directory ? if so, kfree() associated cpuset */
+	if (S_ISDIR(inode->i_mode)) {
+		struct cpuset *cs = (struct cpuset *)dentry->d_fsdata;
+		BUG_ON(!(is_removed(cs)));
+		kfree(cs);
+	}
+	iput(inode);
+}
+
+static struct dentry_operations cpuset_dops = {
+	.d_iput = cpuset_diput,
+};
+
+static struct dentry *cpuset_get_dentry(struct dentry *parent, const char *name)
+{
+	struct qstr qstr;
+	struct dentry *d;
+
+	qstr.name = name;
+	qstr.len = strlen(name);
+	qstr.hash = full_name_hash(name, qstr.len);
+	d = lookup_hash(&qstr, parent);
+	if (d)
+		d->d_op = &cpuset_dops;
+	return d;
+}
+
+static int cpuset_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+{
+	struct dentry *d_parent = dentry->d_parent;
+	struct cpuset *c_parent = (struct cpuset *)d_parent->d_fsdata;
+
+	/* the vfs holds inode->i_sem already */
+	return cpuset_create(c_parent, dentry->d_name.name, mode | S_IFDIR);
+}
+
+static void use_cpuset(struct cpuset * cs)
+{
+	atomic_inc(&cs->count);
+}
+
+static void remove_dir(struct dentry *d)
+{
+	struct dentry *parent = dget(d->d_parent);
+
+	d_delete(d);
+	simple_rmdir(parent->d_inode, d);
+	dput(parent);
+}
+
+/*
+ * NOTE : the dentry must have been dget()'ed
+ */
+static void cpuset_d_remove_dir(struct dentry *dentry)
+{
+	struct list_head *node;
+
+	spin_lock(&dcache_lock);
+	node = dentry->d_subdirs.next;
+	while (node != &dentry->d_subdirs) {
+		struct dentry *d = list_entry(node, struct dentry, d_child);
+		list_del_init(node);
+		if (d->d_inode) {
+			d = dget_locked(d);
+			spin_unlock(&dcache_lock);
+			d_delete(d);
+			simple_unlink(dentry->d_inode, d);
+			dput(d);
+			spin_lock(&dcache_lock);
+		}
+		node = dentry->d_subdirs.next;
+	}
+	list_del_init(&dentry->d_child);
+	spin_unlock(&dcache_lock);
+	remove_dir(dentry);
+}
+
+/*
+ *	cpuset_remove - remove a cpuset
+ *	cs:		the cpuset to remove
+ *
+ *	The cpuset struct is cleaned, and it is removed from the lists
+ *	The cpuset still exists so if there are still files opened in
+ *	cpuset we are not in trouble -- but it's plain useless.
+ *	It will be freed when all the dentries' use drop to zero.
+ */
+
+static void cpuset_remove(struct cpuset *cs)
+{
+	struct dentry *d;
+
+	set_bit(CS_REMOVED, &cs->flags);
+	list_del(&cs->sibling);
+	d = dget(cs->dentry);
+	cs->dentry = NULL;
+	spin_unlock(&d->d_lock);
+	cpuset_d_remove_dir(d);
+	dput(d);
+}
+
+/*
+ *	check_cpuset_autoclean - check if an unused cpuset must be deleted.
+ *	cs: 		the cpuset to check and maybe delete.
+ *	take_sem:	non-zero means we were called by
+ *			release_cpuset_unlocked and thus need to lock
+ *			the cpuset inode.
+ *			zero means we were called by release_cpuset_locked
+ *			and thus the cpuset inode is already locked.
+ *			(locked = inode->i_sem is taken)
+ *
+ *	Called when usage count of a cpuset drops to zero.
+ *	If cs has CS_AUTOCLEAN flag set, delete cs.
+ */
+
+static void check_cpuset_autoclean(struct cpuset *cs, int take_sem)
+{
+	struct inode *inode = NULL;	/* damn gcc warning */
+	struct inode *inodep;
+	struct cpuset *parent = NULL;
+
+	/* always hold parent's inode semaphore, in all cases */
+	inodep = igrab(cs->dentry->d_parent->d_inode);
+	down(&inodep->i_sem);
+
+	/* hold cs' inode's semaphore only if caller didn't */
+	if (take_sem) {
+		inode = igrab(cs->dentry->d_inode);
+		down(&inode->i_sem);
+	}
+
+	down(&cpuset_sem);
+
+	if (atomic_read(&cs->count) == 0 &&
+	    !is_removed(cs) &&
+	    is_autoclean(cs) &&
+	    has_been_attached(cs)
+	) {
+		parent = cs->parent;
+
+		/* Actual deletion occurs here : */
+		cpuset_remove(cs);
+	}
+
+	up(&cpuset_sem);
+
+	if (take_sem) {
+		up(&inode->i_sem);
+		iput(inode);
+	}
+
+	up(&inodep->i_sem);
+	iput(inodep);
+	if (parent)
+		release_cpuset_unlocked(parent);
+}
+
+/*
+ *	Why two flavours of release_cpuset() ?
+ *	When doing a rmdir(), the vfs will take the semaphore on the inode of
+ *	the directory to remove, and also on the inode of its parent. Now if
+ *	the parent is autoclean, and has to be removed, we don't need to down()
+ *	its inode because the vfs did it. Fine.
+ *	But if the cpuset autoclean has to be removed because a process exited()
+ *	the semaphore has to be held.
+ *	So we call:
+ *	release_cpuset_locked   : if the semaphore on the inode has been taken
+ *	release_cpuset_unlocked : else.
+ */
+
+static void release_cpuset_locked(struct cpuset *cs)
+{
+	if (atomic_dec_and_test(&cs->count))
+		check_cpuset_autoclean(cs, 0);
+}
+
+/*
+ * release_cpuset_unlocked(cs) - decrement cpuset 'cs' use count
+ * If use count drops to zero, check_cpuset_autoclean() is called.
+ * Locking: cpuset_sem MUST NOT BE HELD, as check_cpuset_autoclean
+ * will grab it.
+ */
+
+static void release_cpuset_unlocked(struct cpuset *cs)
+{
+	if (atomic_dec_and_test(&cs->count))
+		check_cpuset_autoclean(cs, 1);
+}
+
+static int cpuset_rmdir(struct inode *unused_dir, struct dentry *dentry)
+{
+	struct cpuset *cs = (struct cpuset *)dentry->d_fsdata;
+	int retval;
+
+	use_cpuset(cs);
+	/* the vfs holds both inode->i_sem already */
+	retval = cpuset_destroy(cs);
+	/*
+	 * Even if deletion succeeded, we can call release_cpuset_unlocked()
+	 * Because the cpuset will be freed only when the dentry is.
+	 */
+	release_cpuset_unlocked(cs);
+	return retval;
+}
+
+static struct inode_operations cpuset_dir_inode_operations = {
+	.lookup = simple_lookup,
+	.mkdir = cpuset_mkdir,
+	.rmdir = cpuset_rmdir,
+};
+
+/*
+ *	cpuset_create_dir - create a directory for an object.
+ *	cs: 	the cpuset we create the directory for.
+ *		It must have a valid ->parent field
+ *		And we are going to fill its ->dentry field.
+ *	name:	The name to give to the cpuset directory. Will be copied.
+ *	mode:	mode to set on new directory.
+ */
+
+static int cpuset_create_dir(struct cpuset *cs, const char *name, int mode)
+{
+	struct dentry *dentry = NULL;
+	struct dentry *parent;
+	int error = 0;
+	struct cpuset *csp;
+
+	if (!cs)
+		return -EINVAL;
+
+	csp = cs->parent;
+
+	/* find parent dentry : parent cpuset or fs root ? */
+	if (csp)
+		parent = csp->dentry;
+	else if (cpuset_mount && cpuset_mount->mnt_sb)
+		parent = cpuset_mount->mnt_sb->s_root;
+	else
+		return -EFAULT;
+
+	error = create_dir(cs, parent, name, &dentry, mode);
+	if (!error)
+		cs->dentry = dentry;
+	return error;
+}
+
+static struct super_operations cpuset_ops = {
+	.statfs = simple_statfs,
+	.drop_inode = generic_delete_inode,
+};
+
+static int cpuset_fill_super(struct super_block *sb, void *unused_data,
+							int unused_silent)
+{
+	struct inode *inode;
+	struct dentry *root;
+
+	sb->s_blocksize = PAGE_CACHE_SIZE;
+	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
+	sb->s_magic = CPUSET_SUPER_MAGIC;
+	sb->s_op = &cpuset_ops;
+	cpuset_sb = sb;
+
+	inode = cpuset_new_inode(S_IFDIR | S_IRUGO | S_IXUGO | S_IWUSR);
+	if (inode) {
+		inode->i_op = &simple_dir_inode_operations;
+		inode->i_fop = &simple_dir_operations;
+		/* directories start off with i_nlink == 2 (for "." entry) */
+		inode->i_nlink++;
+	} else {
+		return -ENOMEM;
+	}
+
+	root = d_alloc_root(inode);
+	if (!root) {
+		iput(inode);
+		return -ENOMEM;
+	}
+	sb->s_root = root;
+	return 0;
+}
+
+static struct super_block *cpuset_get_sb(struct file_system_type *fs_type,
+					int flags, const char *unused_dev_name,
+					void *data)
+{
+	return get_sb_single(fs_type, flags, data, cpuset_fill_super);
+}
+
+static struct file_system_type cpuset_fs_type = {
+	.name = "cpuset",
+	.get_sb = cpuset_get_sb,
+	.kill_sb = kill_litter_super,
+};
+
+/* struct cftype:
+ *
+ * The files in the cpuset filesystem mostly have a very simple read/write
+ * handling, some common function will take care of it. Nevertheless some cases
+ * (read tasks) are special and therefore I define this structure for every
+ * kind of file.
+ *
+ *
+ * When reading/writing to a file:
+ *	- the cpuset to use in file->f_dentry->d_parent->d_fsdata
+ *	- the 'cftype' of the file is file->f_dentry->d_fsdata
+ */
+
+struct cftype {
+	char *name;
+	int private;
+	int (*open) (struct inode *inode, struct file *file);
+	ssize_t (*read) (struct file *file, char __user *buf, size_t nbytes,
+							loff_t *ppos);
+	int (*write) (struct file *file, const char *buf, size_t nbytes,
+							loff_t *ppos);
+	int (*release) (struct inode *inode, struct file *file);
+};
+
+static inline struct cpuset *__d_cs(struct dentry *dentry)
+{
+	return (struct cpuset *)dentry->d_fsdata;
+}
+
+static inline struct cftype *__d_cft(struct dentry *dentry)
+{
+	return (struct cftype *)dentry->d_fsdata;
+}
+
+/*
+ * is_cpuset_subset(p, q) - Is cpuset p a subset of cpuset q?
+ *
+ * One cpuset is a subset of another if all its allowed CPUs and
+ * Memory Nodes are a subset of the other, and its strict flags are
+ * only set if the other's are set.
+ */
+
+static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
+{
+	return	cpus_subset(p->cpus_allowed, q->cpus_allowed) &&
+		nodes_subset(p->mems_allowed, q->mems_allowed) &&
+		is_cpustrict(p) <= is_cpustrict(q) &&
+		is_memstrict(p) <= is_memstrict(q);
+}
+
+/*
+ * validate_change() - Used to validate that any proposed cpuset change
+ *		       follows the structural rules for cpusets.
+ *
+ * If we replaced the flag and mask values of the current cpuset
+ * (cur) with those values in the trial cpuset (trial), would
+ * our various subset and strict rules still be valid?  Presumes
+ * cpuset_sem held.
+ *
+ * 'cur' is the address of an actual, in-use cpuset.  Operations
+ * such as list traversal that depend on the actual address of the
+ * cpuset in the list must use cur below, not trial.
+ *
+ * 'trial' is the address of bulk structure copy of cur, with
+ * perhaps one or more of the fields cpus_allowed, mems_allowed,
+ * or flags changed to new, trial values.
+ *
+ * Return 0 if valid, -errno if not.
+ */
+
+static int validate_change(const struct cpuset *cur, const struct cpuset *trial)
+{
+	struct cpuset *c, *par = cur->parent;
+
+	/*
+	 * Don't mess with Big Daddy - top_cpuset must remain maximal.
+	 * And besides, the rest of this routine blows chunks if par == 0.
+	 */
+	if (cur == &top_cpuset)
+		return -EPERM;
+
+	/* Any in-use cpuset must have at least ONE cpu and mem */
+	if (atomic_read(&trial->count) > 1) {
+		if (cpus_empty(trial->cpus_allowed))
+			return -ENOSPC;
+		if (nodes_empty(trial->mems_allowed))
+			return -ENOSPC;
+	}
+
+	/* We must be a subset of our parent cpuset */
+	if (!is_cpuset_subset(trial, par))
+		return -EACCES;
+
+	/* Each of our child cpusets must be a subset of us */
+	list_for_each_entry(c, &cur->children, sibling) {
+		if (!is_cpuset_subset(c, trial))
+			return -EBUSY;
+	}
+
+	/* If either I or some sibling (!= me) is strict, we can't overlap */
+	list_for_each_entry(c, &par->children, sibling) {
+		if ((is_cpustrict(trial) || is_cpustrict(c)) &&
+		    c != cur &&
+		    cpus_intersects(trial->cpus_allowed, c->cpus_allowed)
+		) {
+			return -EINVAL;
+		}
+		if ((is_memstrict(trial) || is_memstrict(c)) &&
+		    c != cur &&
+		    nodes_intersects(trial->mems_allowed, c->mems_allowed)
+		) {
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ *	update_cpus - change the list of cpus of a cpuset
+ *	cs:		the cpuset
+ *	new_mask:	the new list of cpus
+ */
+
+static int update_cpus(struct cpuset *cs, const cpumask_t *new_mask)
+{
+	int err;
+	struct cpuset trialcs;
+
+	down(&cpuset_sem);
+
+	trialcs = *cs;
+	trialcs.cpus_allowed = *new_mask;
+
+	err = validate_change(cs, &trialcs);
+	if (err == 0)
+		cs->cpus_allowed = *new_mask;
+
+	up(&cpuset_sem);
+	return err;
+}
+
+static int update_cpumask_from_str(struct cpuset *cs, char *buf)
+{
+	cpumask_t new_mask;
+	int retval;
+
+	new_mask = cs->cpus_allowed;
+	retval = cpulist_parse(buf, new_mask);
+	if (retval < 0)
+		return retval;
+
+	use_cpuset(cs);
+	if (is_removed(cs))
+		retval = -ENODEV;
+	else
+		retval = update_cpus(cs, &new_mask);
+	release_cpuset_unlocked(cs);
+	return retval;
+}
+
+/*
+ *	update_mems - change the list of mems of a cpuset
+ *	cs:		the cpuset
+ *	new_mask:	the new list of mems
+ */
+
+static int update_mems(struct cpuset *cs, const nodemask_t *new_mask)
+{
+	int err;
+	struct cpuset trialcs;
+
+	down(&cpuset_sem);
+
+	trialcs = *cs;
+	trialcs.mems_allowed = *new_mask;
+
+	err = validate_change(cs, &trialcs);
+	if (err == 0)
+		cs->mems_allowed = *new_mask;
+
+	up(&cpuset_sem);
+	return err;
+}
+
+static int update_nodemask_from_str(struct cpuset *cs, char *buf)
+{
+	nodemask_t new_mask;
+	int retval;
+
+	new_mask = cs->mems_allowed;
+	retval = nodelist_parse(buf, new_mask);
+	if (retval < 0)
+		return retval;
+
+	use_cpuset(cs);
+	if (is_removed(cs))
+		retval = -ENODEV;
+	else
+		retval = update_mems(cs, &new_mask);
+	release_cpuset_unlocked(cs);
+	return retval;
+}
+
+/*
+ * update_flag - read a 0 or a 1 in a file and update associated flag
+ * bit:	the bit to update (CPUSTRICT, MEMSTRICT, AUTOCLEAN)
+ * cs:	the cpuset to update
+ * buf:	the buffer where we read the 0 or 1
+ */
+
+static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs, char *buf)
+{
+	int turning_on;
+	struct cpuset trialcs;
+	int err;
+
+	turning_on = (simple_strtoul(buf, NULL, 10) != 0);
+
+	use_cpuset(cs);
+	down(&cpuset_sem);
+	trialcs = *cs;
+	if (turning_on)
+		set_bit(bit, &trialcs.flags);
+	else
+		clear_bit(bit, &trialcs.flags);
+
+	err = validate_change(cs, &trialcs);
+	if (err == 0) {
+		if (turning_on)
+			set_bit(bit, &cs->flags);
+		else
+			clear_bit(bit, &cs->flags);
+	}
+
+	up(&cpuset_sem);
+	/*
+	 * If cs has been attached, and we add the autoclean flag,
+	 * the cs will be destroyed on this call to release_cpuset_unlocked().
+	 */
+	release_cpuset_unlocked(cs);
+	return err;
+}
+
+
+static int cpuset_attach_task_by_pid(struct cpuset *cs, int pid)
+{
+	struct task_struct *tsk;
+	struct cpuset *oldcs;
+
+	if (cpus_empty(cs->cpus_allowed) || nodes_empty(cs->mems_allowed))
+		return -ENOSPC;
+
+	if (pid) {
+		read_lock(&tasklist_lock);
+
+		tsk = find_task_by_pid(pid);
+		if (!tsk) {
+			read_unlock(&tasklist_lock);
+			return -ESRCH;
+		}
+
+		get_task_struct(tsk);
+		read_unlock(&tasklist_lock);
+
+		if ((current->euid) && (current->euid != tsk->uid)
+		    && (current->euid != tsk->suid)) {
+			put_task_struct(tsk);
+			return -EACCES;
+		}
+	} else {
+		tsk = current;
+		get_task_struct(tsk);
+	}
+
+	task_lock(tsk);
+	oldcs = tsk->cpuset;
+	if (!oldcs) {
+		task_unlock(tsk);
+		put_task_struct(tsk);
+		return -ESRCH;
+	}
+	use_cpuset(cs);
+	set_bit(CS_HAS_BEEN_ATTACHED, &cs->flags);
+	tsk->cpuset = cs;
+	task_unlock(tsk);
+
+	put_task_struct(tsk);
+	release_cpuset_unlocked(oldcs);
+	return 0;
+}
+
+static int attach_task_from_str(struct cpuset *cs, char *buf)
+{
+	int pid;
+
+	int err = -EIO;
+	int conv = sscanf(buf, "%d", &pid);
+
+	if (conv == 1) {
+		use_cpuset(cs);
+		if (is_removed(cs))
+			err = -ENODEV;
+		else
+			err = cpuset_attach_task_by_pid(cs, pid);
+		release_cpuset_unlocked(cs);
+	}
+
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+/* The various types of files and directories in a cpuset file system */
+
+typedef enum {
+	FILE_ROOT,
+	FILE_DIR,
+	FILE_CPULIST,
+	FILE_MEMLIST,
+	FILE_CPUSTRICT,
+	FILE_MEMSTRICT,
+	FILE_AUTOCLEAN,
+	FILE_TASKLIST,
+} cpuset_filetype_t;
+
+static ssize_t cpuset_common_file_write(struct file *file, const char *userbuf,
+					size_t nbytes, loff_t *unused_ppos)
+{
+	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
+	struct cftype *cft = __d_cft(file->f_dentry);
+	cpuset_filetype_t type = cft->private;
+	char *buffer;
+	int retval = 0;
+
+	/* Crude upper limit on largest legitimate cpulist user might write. */
+	if (nbytes > 100 + 6 * NR_CPUS)
+		return -E2BIG;
+
+	/* +1 for nul-terminator */
+	if ((buffer = kmalloc(nbytes + 1, GFP_KERNEL)) == 0)
+		return -ENOMEM;
+
+	if (copy_from_user(buffer, userbuf, nbytes)) {
+		retval = -EFAULT;
+		goto out;
+	}
+	buffer[nbytes] = 0;	/* nul-terminate */
+
+	switch (type) {
+	default:
+		retval = -EINVAL;
+		goto out;
+	case FILE_CPULIST:
+		retval = update_cpumask_from_str(cs, buffer);
+		break;
+	case FILE_MEMLIST:
+		retval = update_nodemask_from_str(cs, buffer);
+		break;
+	case FILE_CPUSTRICT:
+		retval = update_flag(CS_CPUSTRICT, cs, buffer);
+		break;
+	case FILE_MEMSTRICT:
+		retval = update_flag(CS_MEMSTRICT, cs, buffer);
+		break;
+	case FILE_AUTOCLEAN:
+		retval = update_flag(CS_AUTOCLEAN, cs, buffer);
+		break;
+	case FILE_TASKLIST:
+		retval = attach_task_from_str(cs, buffer);
+		break;
+	}
+	if (retval == 0)
+		retval = nbytes;
+out:
+	kfree(buffer);
+	return retval;
+}
+
+static ssize_t cpuset_file_write(struct file *file, const char *buf,
+						size_t nbytes, loff_t *ppos)
+{
+	ssize_t retval = 0;
+	struct cftype *cft = __d_cft(file->f_dentry);
+	if (!cft)
+		return -ENODEV;
+
+	/* special function ? */
+	if (cft->write)
+		retval = cft->write(file, buf, nbytes, ppos);
+	else
+		retval = cpuset_common_file_write(file, buf, nbytes, ppos);
+
+	return retval;
+}
+
+static int cpuset_sprintf_list(char *page, unsigned long *mask, int max)
+{
+	char *s = page;
+	int i;
+	int p = 0;		/* n -> n previous cpus were present   */
+	int f = 0;		/* 1 -> at least one cpu was found */
+	/* loop one time more in the case where last cpu is part of a range */
+	for (i = 0; i < max + 1; i++) {
+		if ((i < max) && (test_bit(i, mask))) {
+			if (!p) {
+				if (f)
+					*(s++) = ',';
+				s += sprintf(s, "%d", i);
+			}
+			f = 1;
+			p++;
+		} else {
+			if (f && (p > 1))
+				s += sprintf(s, "-%d", i - 1);
+			p = 0;
+		}
+	}
+	return s - page;
+}
+
+static int cpuset_sprintf_cpulist(char *page, cpumask_t mask)
+{
+	return cpuset_sprintf_list(page, cpus_addr(mask), NR_CPUS);
+}
+
+static int cpuset_sprintf_memlist(char *page, nodemask_t mask)
+{
+	return cpuset_sprintf_list(page, nodes_addr(mask), MAX_NUMNODES);
+}
+
+static ssize_t cpuset_common_file_read(struct file *file, char __user *buf,
+				size_t nbytes, loff_t *ppos)
+{
+	struct cftype *cft = __d_cft(file->f_dentry);
+	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
+	cpuset_filetype_t type = cft->private;
+	char *page;
+	ssize_t retval = 0;
+	char *s;
+	char *start;
+	size_t n;
+
+	if (!(page = (char *)__get_free_page(GFP_KERNEL)))
+		return -ENOMEM;
+
+	s = page;
+
+	switch (type) {
+	default:
+		retval = -EINVAL;
+		goto out;
+	case FILE_CPULIST:
+		s += cpuset_sprintf_cpulist(s, cs->cpus_allowed);
+		break;
+	case FILE_MEMLIST:
+		s += cpuset_sprintf_memlist(s, cs->mems_allowed);
+		break;
+	case FILE_CPUSTRICT:
+		*s++ = is_cpustrict(cs) ? '1' : '0';
+		break;
+	case FILE_MEMSTRICT:
+		*s++ = is_memstrict(cs) ? '1' : '0';
+		break;
+	case FILE_AUTOCLEAN:
+		*s++ = is_autoclean(cs) ? '1' : '0';
+		break;
+	}
+	*s++ = '\n';
+	*s = '\0';
+
+	start = page + *ppos;
+	n = s - start;
+	retval = n - copy_to_user(buf, start, min(n, nbytes));
+	*ppos += retval;
+out:
+	free_page((unsigned long)page);
+	return retval;
+}
+
+static ssize_t cpuset_file_read(struct file *file, char *buf, size_t nbytes,
+								loff_t *ppos)
+{
+	ssize_t retval = 0;
+	struct cftype *cft = __d_cft(file->f_dentry);
+	if (!cft)
+		return -ENODEV;
+
+	/* special function ? */
+	if (cft->read)
+		retval = cft->read(file, buf, nbytes, ppos);
+	else
+		retval = cpuset_common_file_read(file, buf, nbytes, ppos);
+
+	return retval;
+}
+
+static int cpuset_file_open(struct inode *inode, struct file *file)
+{
+	int err;
+	struct cftype *cft;
+
+	err = generic_file_open(inode, file);
+	if (err)
+		return err;
+
+	cft = __d_cft(file->f_dentry);
+	if (!cft)
+		return -ENODEV;
+	if (cft->open)
+		err = cft->open(inode, file);
+	else
+		err = 0;
+
+	return err;
+}
+
+static int cpuset_file_release(struct inode *inode, struct file *file)
+{
+	struct cftype *cft = __d_cft(file->f_dentry);
+	if (cft->release)
+		return cft->release(inode, file);
+	return 0;
+}
+
+static struct file_operations cpuset_file_operations = {
+	.read = cpuset_file_read,
+	.write = cpuset_file_write,
+	.llseek = generic_file_llseek,
+	.open = cpuset_file_open,
+	.release = cpuset_file_release,
+};
+
+static int cpuset_create_file(struct dentry *dentry, int mode)
+{
+	struct inode *inode;
+
+	if (!dentry)
+		return -ENOENT;
+	if (dentry->d_inode)
+		return -EEXIST;
+	
+	inode = cpuset_new_inode(mode);
+	if (!inode)
+		return -ENOMEM;
+
+	if (S_ISDIR(mode)) {
+		inode->i_op = &cpuset_dir_inode_operations;
+		inode->i_fop = &simple_dir_operations;
+	
+		/* start off with i_nlink == 2 (for "." entry) */
+		inode->i_nlink++;
+	} else if (S_ISREG(mode)) {
+		inode->i_size = PAGE_SIZE;
+		inode->i_fop = &cpuset_file_operations;
+	}
+
+	d_instantiate(dentry, inode);
+	dget(dentry);	/* Extra count - pin the dentry in core */
+	return 0;
+}
+
+static int create_dir(struct cpuset *cs, struct dentry *p, const char *n,
+						struct dentry **d, int mode)
+{
+	int error;
+
+	*d = cpuset_get_dentry(p, n);
+	if (!IS_ERR(*d)) {
+		error = cpuset_create_file(*d, S_IFDIR | mode);
+		if (!error) {
+			(*d)->d_fsdata = cs;
+			p->d_inode->i_nlink++;
+		}
+		dput(*d);
+	} else
+		error = PTR_ERR(*d);
+	return error;
+}
+
+/* MUST be called with dir->d_inode->i_sem held */
+
+static int cpuset_add_file(struct dentry *dir, const struct cftype *cft)
+{
+	struct dentry *dentry;
+	int error;
+
+	dentry = cpuset_get_dentry(dir, cft->name);
+	if (!IS_ERR(dentry)) {
+		error = cpuset_create_file(dentry, 0644 | S_IFREG);
+		if (!error)
+			dentry->d_fsdata = (void *)cft;
+		dput(dentry);
+	} else
+		error = PTR_ERR(dentry);
+	return error;
+}
+
+/*
+ * Stuff for reading the 'tasks' file.
+ *
+ * Reading this file can return large amounts of data if a cpuset has
+ * *lots* of attached tasks. So it may need several calls to read(),
+ * but we cannot guarantee that the information we produce is correct
+ * unless we produce it entirely atomically.
+ *
+ * Upon first file read(), a struct ctr_struct is allocated, that
+ * will have a pointer to an array (also allocated here).  The struct
+ * ctr_struct * is stored in file->private_data.  Its resources will
+ * be freed by release() when the file is closed.  The array is used
+ * to sprintf the PIDs and then used by read().
+ */
+
+/* cpusets_tasks_read array */
+
+struct ctr_struct {
+	int *array;
+	int count;
+};
+
+static struct ctr_struct *cpuset_tasks_mkctr(struct file *file)
+{
+	struct cpuset *cs = __d_cs(file->f_dentry->d_parent);
+	struct ctr_struct *ctr;
+	pid_t *array;
+	int n, max;
+	pid_t i, j, last;
+	struct task_struct *g, *p;
+
+	ctr = kmalloc(sizeof(*ctr), GFP_KERNEL);
+	if (!ctr)
+		return NULL;
+
+	/*
+	 * If cpuset gets more users after we read count, we won't have
+	 * enough space - tough.  This race is indistinguishable to the
+	 * caller from the case that the additional cpuset users didn't
+	 * show up until sometime later on.
+	 */
+
+	max = atomic_read(&cs->count);
+	array = kmalloc(max * sizeof(pid_t), GFP_KERNEL);
+	if (!array) {
+		kfree(ctr);
+		return NULL;
+	}
+
+	n = 0;
+	read_lock(&tasklist_lock);
+	do_each_thread(g, p) {
+		if (p->cpuset == cs) {
+			array[n++] = p->pid;
+			if (unlikely(n == max))
+				goto array_full;
+		}
+	}
+	while_each_thread(g, p);
+array_full:
+	read_unlock(&tasklist_lock);
+
+	/* stupid bubble sort */
+	for (i = 0; i < n - 1; i++) {
+		for (j = 0; j < n - 1 - i; j++)
+			if (array[j + 1] < array[j]) {
+				pid_t tmp = array[j];
+				array[j] = array[j + 1];
+				array[j + 1] = tmp;
+			}
+	}
+
+	/*
+	 * Collapse sorted array by grouping consecutive pids.
+	 * Code range of pids with a negative pid on the second.
+	 * Read from array[i]; write to array]j]; j <= i always.
+	 */
+	last = array[0];  /* any value != array[0] - 1 */
+	j = -1;
+	for (i = 0; i < n; i++) {
+		pid_t curr = array[i];
+		/* consecutive pids ? */
+		if (curr - last == 1) {
+			/* move destination index if it has not been done */
+			if (array[j] > 0)
+				j++;
+			array[j] = -curr;
+		} else
+			array[++j] = curr;
+		last = curr;
+	}
+
+	ctr->array = array;
+	ctr->count = j + 1;
+	file->private_data = (void *)ctr;
+	return ctr;
+}
+
+/* printf one pid from an array
+ * different formatting depending on whether it is positive or negative,
+ * or whether it is or not the first pid or the last
+ */
+static int array_pid_sprintf(char *buf, pid_t *array, int idx, int last)
+{
+	pid_t v = array[idx];
+	int l = 0;
+
+	if (v < 0) {		/* second pid of a range of pids */
+		v = -v;
+		buf[l++] = '-';
+	} else {		/* first pid of a range, or not a range */
+		if (idx)	/* comma only if it's not the first */
+			buf[l++] = ',';
+	}
+	l += sprintf(buf + l, "%d", v);
+	/* newline after last record */
+	if (idx == last)
+		l += sprintf(buf + l, "\n");
+	return l;
+}
+
+static ssize_t cpuset_tasks_read(struct file *file, char __user *buf,
+						size_t nbytes, loff_t *ppos)
+{
+	struct ctr_struct *ctr = (struct ctr_struct *)file->private_data;
+	int *array, nr_pids, i;
+	size_t len, lastlen = 0;
+	char *page;
+
+	/* allocate buffer and fill it on first call to read() */
+	if (!ctr) {
+		ctr = cpuset_tasks_mkctr(file);
+		if (!ctr)
+			return -ENOMEM;
+	}
+
+	array = ctr->array;
+	nr_pids = ctr->count;
+
+	if (!(page = (char *)__get_free_page(GFP_KERNEL)))
+		return -ENOMEM;
+
+	i = *ppos;		/* index of pid being printed */
+	len = 0;		/* length of data sprintf'ed in the page */
+
+	while ((len < PAGE_SIZE - 10) && (i < nr_pids) && (len < nbytes)) {
+		lastlen = array_pid_sprintf(page + len, array, i++, nr_pids - 1);
+		len += lastlen;
+	}
+
+	/* if we wrote too much, remove last record */
+	if (len > nbytes) {
+		len -= lastlen;
+		i--;
+	}
+
+	*ppos = i;
+
+	if (copy_to_user(buf, page, len))
+		len = -EFAULT;
+	free_page((unsigned long)page);
+	return len;
+}
+
+static int cpuset_tasks_release(struct inode *unused_inode, struct file *file)
+{
+	struct ctr_struct *ctr;
+
+	/* we have nothing to do if no read-access is needed */
+	if (!(file->f_mode & FMODE_READ))
+		return 0;
+
+	ctr = (struct ctr_struct *)file->private_data;
+	kfree(ctr->array);
+	kfree(ctr);
+	return 0;
+}
+
+/*
+ *	cpuset_create - create a cpuset
+ *	parent:	cpuset that will be parent of the new cpuset.
+ *	name:		name of the new cpuset. Will be strcpy'ed.
+ *	mode:		mode to set on new inode
+ *
+ *	Must be called with the semaphore on the parent inode held
+ */
+
+static long cpuset_create(struct cpuset *parent, const char *name, int mode)
+{
+	struct cpuset *cs;
+	int err;
+
+	cs = kmalloc(sizeof(*cs), GFP_KERNEL);
+	if (!cs)
+		return -ENOMEM;
+
+	use_cpuset(parent);	/* child needs parent to live */
+	down(&cpuset_sem);
+	cs->flags = 0;
+	cs->cpus_allowed = parent->cpus_allowed;
+	cs->mems_allowed = parent->mems_allowed;
+	atomic_set(&cs->count, 0);
+	INIT_LIST_HEAD(&cs->sibling);
+	INIT_LIST_HEAD(&cs->children);
+
+
+	cs->parent = parent;
+
+	list_add(&cs->sibling, &cs->parent->children);
+
+	err = cpuset_create_dir(cs, name, mode);
+	if (err < 0)
+		goto err;
+	err = cpuset_populate_dir(cs->dentry);
+	up(&cpuset_sem);
+	return err;
+err:
+	list_del(&cs->sibling);
+	up(&cpuset_sem);
+	release_cpuset_unlocked(parent);
+	kfree(cs);
+	return err;
+}
+
+/*
+ *	cpuset_destroy: destroy a cpuset
+ *	cs:	cpuset to be destroyed
+ *
+ *	Calls cpuset_remove(). The memory will only be freed when the cpuset'
+ *	dentries are dropped.
+ *
+ *	This is how cpuset removal occurs actually:
+ *	cpuset_destroy -> cpuset_remove -> list_del,removed=1...
+ *	.... later...(depending on filesystem use)...
+ *	dput(dentry)->iput(inode)->kfree().
+ *
+ *
+ * 	cpuset_destroy MUST be called with:
+ *		* use count at least 1
+ *		* semaphores on inode and parent's inode held.
+ *
+ *	Return: ZERO on success.
+ */
+
+static int cpuset_destroy(struct cpuset *cs)
+{
+	struct cpuset *parent = cs->parent;
+
+	down(&cpuset_sem);
+	spin_lock(&cs->dentry->d_lock);
+	/* whoever called us incremented count, so it is at least 1 */
+	if (atomic_read(&cs->count) > 1) {
+		spin_unlock(&cs->dentry->d_lock);
+		up(&cpuset_sem);
+		return -EBUSY;
+	}
+	/* everything OK, now we pull the trigger */
+
+	/* make this cpuset unusable, remove it from the lists */
+	cpuset_remove(cs); /* also unlocks &cs->dentry->d_lock */
+
+	up(&cpuset_sem);
+
+	/*
+	 * If the parent also has to be deleted (autoclean), we already hold
+	 * the inode semaphore => hence the call to release_cpuset_locked.
+	 */
+	release_cpuset_locked(parent);
+	return 0;
+}
+
+/*
+ * for the common functions, 'private' gives the type of file
+ */
+
+static struct cftype cft_tasks = {
+	.name = "tasks",
+	.read = cpuset_tasks_read,
+	.release = cpuset_tasks_release,
+	.private = FILE_TASKLIST,
+};
+
+static struct cftype cft_cpus = {
+	.name = "cpus",
+	.private = FILE_CPULIST,
+};
+
+static struct cftype cft_mems = {
+	.name = "mems",
+	.private = FILE_MEMLIST,
+};
+
+static struct cftype cft_cpustrict = {
+	.name = "cpustrict",
+	.private = FILE_CPUSTRICT,
+};
+
+static struct cftype cft_memstrict = {
+	.name = "memstrict",
+	.private = FILE_MEMSTRICT,
+};
+
+static struct cftype cft_autoclean = {
+	.name = "autoclean",
+	.private = FILE_AUTOCLEAN,
+};
+
+/* MUST be called with ->d_inode->i_sem held */
+static int cpuset_populate_dir(struct dentry *cs_dentry)
+{
+	int err;
+
+	if ((err = cpuset_add_file(cs_dentry, &cft_cpus)) < 0)
+		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_mems)) < 0)
+		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_cpustrict)) < 0)
+		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_memstrict)) < 0)
+		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_autoclean)) < 0)
+		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_tasks)) < 0)
+		return err;
+	return 0;
+}
+
+/**
+ * cpuset_init - initialize cpusets at system boot
+ *
+ * Description: Initialize top_cpuset and the cpuset internal file system,
+ **/
+
+int __init cpuset_init(void)
+{
+	int err;
+
+	top_cpuset.cpus_allowed = cpu_possible_map;
+	top_cpuset.mems_allowed = node_possible_map;
+
+	init_task.cpuset = &top_cpuset;
+	set_bit(CS_HAS_BEEN_ATTACHED, &init_task.cpuset->flags);
+
+	err = register_filesystem(&cpuset_fs_type);
+	if (err < 0)
+		goto out;
+	cpuset_mount = kern_mount(&cpuset_fs_type);
+	if (IS_ERR(cpuset_mount)) {
+		printk(KERN_ERR "cpuset: could not mount!\n");
+		err = PTR_ERR(cpuset_mount);
+		cpuset_mount = NULL;
+		goto out;
+	}
+	err = cpuset_create_dir(&top_cpuset, "top_cpuset", 0644);
+	if (err < 0)
+		goto out;
+	err = cpuset_populate_dir(top_cpuset.dentry);
+out:
+	return err;
+}
+
+/**
+ * cpuset_fork - attach newly forked task to its parents cpuset.
+ * @p: pointer to task_struct of forking parent process.
+ *
+ * Description: By default, on fork, a task inherits its
+ * parents cpuset.  The pointer to the shared cpuset is
+ * automatically copied in fork.c by dup_task_struct().
+ * This cpuset_fork() routine need only increment the usage
+ * counter in that cpuset.
+ **/
+
+void cpuset_fork(struct task_struct *tsk)
+{
+	atomic_inc(&tsk->cpuset->count);
+}
+
+/**
+ * cpuset_exit - detach exiting task from cpuset
+ * @tsk: pointer to task_struct of exiting process
+ *
+ * Description: Detach @tsk from its cpuset and release
+ * that cpuset (which will decrement its usage and perhaps
+ * remove it.)
+ **/
+
+void cpuset_exit(struct task_struct *tsk)
+{
+	struct cpuset *cs;
+
+	task_lock(tsk);
+	cs = tsk->cpuset;
+	tsk->cpuset = NULL;
+	task_unlock(tsk);
+
+	release_cpuset_unlocked(cs);
+}
+
+/**
+ * cpuset_cpus_allowed - return cpus_allowed mask from a tasks cpuset.
+ * @tsk: pointer to task_struct from which to obtain cpuset->cpus_allowed.
+ *
+ * Description: Returns the cpumask_t cpus_allowed of the cpuset
+ * attached to the specified @tsk.
+ **/
+
+const cpumask_t cpuset_cpus_allowed(const struct task_struct *tsk)
+{
+	cpumask_t mask;
+
+	task_lock((struct task_struct *)tsk);
+	if (tsk->cpuset)
+		mask = tsk->cpuset->cpus_allowed;
+	else
+		mask = CPU_MASK_ALL;
+	task_unlock((struct task_struct *)tsk);
+
+	return mask;
+}
+
+/**
+ * cpuset_mems_allowed - return mems_allowed mask from a tasks cpuset.
+ * @tsk: pointer to task_struct from which to obtain cpuset->mems_allowed.
+ *
+ * Description: Returns the nodemask_t mems_allowed of the cpuset
+ * attached to the specified @tsk.
+ **/
+
+const nodemask_t cpuset_mems_allowed(const struct task_struct *tsk)
+{
+	nodemask_t mask;
+
+	task_lock((struct task_struct *)tsk);
+	if (tsk->cpuset)
+		mask = tsk->cpuset->mems_allowed;
+	else
+		mask = NODE_MASK_ALL;
+	task_unlock((struct task_struct *)tsk);
+
+	return mask;
+}
+
+/**
+ * proc_pid_cspath - print tasks cpuset path into buffer
+ * @tsk: pointer to task_struct of task whose cpuset's path to print
+ * @buf: pointer to buffer into which to print path
+ * @buflen: length of @buf
+ *
+ * Description: Print task's cpuset path (without mountpoint)
+ * in the given buffer. Used for /proc/<pid>/cpuset.
+ */
+
+int proc_pid_cspath(struct task_struct *tsk, char *buf, int buflen)
+{
+	char *endbuf = buf + buflen;
+	char *start = endbuf;
+	struct cpuset *cs, *bottomcs;
+	int count;
+
+	task_lock(tsk);
+	bottomcs = cs = tsk->cpuset;
+	use_cpuset(bottomcs);
+	task_unlock(tsk);
+	*--start = '\n';
+	for (;;) {
+		int l = cs->dentry->d_name.len;
+		start -= l;
+		if (start < buf)
+			goto toolong;
+		memcpy(start, cs->dentry->d_name.name, l);
+		cs = cs->parent;
+		if (!cs)
+			break;
+		if (--start < buf)
+			goto toolong;
+		*start = '/';
+	}
+	count = endbuf - start;
+	memmove(buf, start, count);
+	release_cpuset_unlocked(bottomcs);
+	return count;
+toolong:
+	release_cpuset_unlocked(bottomcs);
+	return -ENAMETOOLONG;
+}

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
