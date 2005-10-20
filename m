Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932551AbVJTXAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbVJTXAh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 19:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbVJTXAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 19:00:23 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:25994 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932547AbVJTXAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 19:00:02 -0400
Date: Thu, 20 Oct 2005 15:59:55 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Mike Kravetz <kravetz@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Christoph Lameter <clameter@sgi.com>,
       Magnus Damm <magnus.damm@gmail.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20051020225955.19761.53060.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 4/4] Swap migration V3: sys_migrate_pages interface
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sys_migrate_pages implementation using swap based page migration

This is the original API proposed by Ray Bryant in his posts during the
first half of 2005 on linux-mm@kvack.org and linux-kernel@vger.kernel.org.

The intend of sys_migrate is to migrate memory of a process. A process may have
migrated to another node. Memory was allocated optimally for the prior context.
sys_migrate_pages allows to shift the memory to the new node.

sys_migrate_pages is also useful if the processes available memory nodes have
changed through cpuset operations to manually move the processes memory. Paul
Jackson is working on an automated mechanism that will allow an automatic
migration if the cpuset of a process is changed. However, a user may decide
to manually control the migration.

This implementation is put into the policy layer since it uses concepts and
functions that are also needed for mbind and friends. The patch also provides
a do_migrate_pages function that may be useful for cpusets to automatically move
memory. sys_migrate_pages does not modify policies in contrast to Ray's implementation.

The current code here is based on the swap based page migration capability and thus
not able to preserve the physical layout relative to it containing nodeset (which
may be a cpuset). When direct page migration becomes available then the
implementation needs to be changed to do a isomorphic move of pages between different
nodesets. The current implementation simply evicts all pages in source
nodeset that are not in the target nodeset.

Patch supports ia64, i386, x86_64 and ppc64. Patch not tested on ppc64.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.14-rc4-mm1/mm/mempolicy.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/mm/mempolicy.c	2005-10-20 13:33:12.000000000 -0700
+++ linux-2.6.14-rc4-mm1/mm/mempolicy.c	2005-10-20 14:45:45.000000000 -0700
@@ -627,6 +627,36 @@ long do_get_mempolicy(int *policy, nodem
 }
 
 /*
+ * For now migrate_pages simply swaps out the pages from nodes that are in
+ * the source set but not in the target set. In the future, we would
+ * want a function that moves pages between the two nodesets in such
+ * a way as to preserve the physical layout as much as possible.
+ *
+ * Returns the number of page that could not be moved.
+ */
+int do_migrate_pages(struct mm_struct *mm,
+	nodemask_t *from_nodes, nodemask_t *to_nodes, int flags)
+{
+	LIST_HEAD(pagelist);
+	int count = 0;
+	nodemask_t nodes;
+
+	nodes_andnot(nodes, *from_nodes, *to_nodes);
+	nodes_complement(nodes, nodes);
+
+	down_read(&mm->mmap_sem);
+	check_range(mm, mm->mmap->vm_start, TASK_SIZE, &nodes,
+			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
+	if (!list_empty(&pagelist)) {
+		swapout_pages(&pagelist);
+		if (!list_empty(&pagelist))
+			count = putback_lru_pages(&pagelist);
+	}
+	up_read(&mm->mmap_sem);
+	return count;
+}
+
+/*
  * User space interface with variable sized bitmaps for nodelists.
  */
 
@@ -720,6 +750,51 @@ asmlinkage long sys_set_mempolicy(int mo
 	return do_set_mempolicy(mode, &nodes);
 }
 
+/* Macro needed until Paul implements this function in kernel/cpusets.c */
+#define cpuset_mems_allowed(task) node_online_map
+
+asmlinkage long sys_migrate_pages(pid_t pid, unsigned long maxnode,
+		unsigned long __user *old_nodes,
+		unsigned long __user *new_nodes)
+{
+	struct mm_struct *mm;
+	struct task_struct *task;
+	nodemask_t old;
+	nodemask_t new;
+	int err;
+
+	err = get_nodes(&old, old_nodes, maxnode);
+	if (err)
+		return err;
+
+	err = get_nodes(&new, new_nodes, maxnode);
+	if (err)
+		return err;
+
+	/* Find the mm_struct */
+	read_lock(&tasklist_lock);
+	task = pid ? find_task_by_pid(pid) : current;
+	if (!task) {
+		read_unlock(&tasklist_lock);
+		return -ESRCH;
+	}
+	mm = get_task_mm(task);
+	read_unlock(&tasklist_lock);
+
+	if (!mm)
+		return -EINVAL;
+
+	/* Is the user allowed to access the target nodes? */
+	if (!nodes_subset(new, cpuset_mems_allowed(task)))
+		return -EPERM;
+
+	err = do_migrate_pages(mm, &old, &new, MPOL_MF_MOVE);
+
+	mmput(mm);
+	return err;
+}
+
+
 /* Retrieve NUMA policy */
 asmlinkage long sys_get_mempolicy(int __user *policy,
 				unsigned long __user *nmask,
Index: linux-2.6.14-rc4-mm1/kernel/sys_ni.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/kernel/sys_ni.c	2005-10-10 18:19:19.000000000 -0700
+++ linux-2.6.14-rc4-mm1/kernel/sys_ni.c	2005-10-20 13:34:43.000000000 -0700
@@ -82,6 +82,7 @@ cond_syscall(compat_sys_socketcall);
 cond_syscall(sys_inotify_init);
 cond_syscall(sys_inotify_add_watch);
 cond_syscall(sys_inotify_rm_watch);
+cond_syscall(sys_migrate_pages);
 
 /* arch-specific weak syscall entries */
 cond_syscall(sys_pciconfig_read);
Index: linux-2.6.14-rc4-mm1/arch/ia64/kernel/entry.S
===================================================================
--- linux-2.6.14-rc4-mm1.orig/arch/ia64/kernel/entry.S	2005-10-10 18:19:19.000000000 -0700
+++ linux-2.6.14-rc4-mm1/arch/ia64/kernel/entry.S	2005-10-20 13:34:43.000000000 -0700
@@ -1600,5 +1600,6 @@ sys_call_table:
 	data8 sys_inotify_init
 	data8 sys_inotify_add_watch
 	data8 sys_inotify_rm_watch
+	data8 sys_migrate_pages
 
 	.org sys_call_table + 8*NR_syscalls	// guard against failures to increase NR_syscalls
Index: linux-2.6.14-rc4-mm1/include/asm-ia64/unistd.h
===================================================================
--- linux-2.6.14-rc4-mm1.orig/include/asm-ia64/unistd.h	2005-10-17 10:24:22.000000000 -0700
+++ linux-2.6.14-rc4-mm1/include/asm-ia64/unistd.h	2005-10-20 13:34:43.000000000 -0700
@@ -269,12 +269,12 @@
 #define __NR_inotify_init		1277
 #define __NR_inotify_add_watch		1278
 #define __NR_inotify_rm_watch		1279
-
+#define __NR_migrate_pages		1280
 #ifdef __KERNEL__
 
 #include <linux/config.h>
 
-#define NR_syscalls			256 /* length of syscall table */
+#define NR_syscalls			257 /* length of syscall table */
 
 #define __ARCH_WANT_SYS_RT_SIGACTION
 
Index: linux-2.6.14-rc4-mm1/arch/ppc64/kernel/misc.S
===================================================================
--- linux-2.6.14-rc4-mm1.orig/arch/ppc64/kernel/misc.S	2005-10-17 10:24:18.000000000 -0700
+++ linux-2.6.14-rc4-mm1/arch/ppc64/kernel/misc.S	2005-10-20 13:34:43.000000000 -0700
@@ -1581,3 +1581,4 @@ _GLOBAL(sys_call_table)
 	.llong .sys_inotify_init	/* 275 */
 	.llong .sys_inotify_add_watch
 	.llong .sys_inotify_rm_watch
+	.llong .sys_migrate_pages
Index: linux-2.6.14-rc4-mm1/arch/i386/kernel/syscall_table.S
===================================================================
--- linux-2.6.14-rc4-mm1.orig/arch/i386/kernel/syscall_table.S	2005-10-10 18:19:19.000000000 -0700
+++ linux-2.6.14-rc4-mm1/arch/i386/kernel/syscall_table.S	2005-10-20 13:34:44.000000000 -0700
@@ -294,3 +294,5 @@ ENTRY(sys_call_table)
 	.long sys_inotify_init
 	.long sys_inotify_add_watch
 	.long sys_inotify_rm_watch
+	.long sys_migrate_pages
+
Index: linux-2.6.14-rc4-mm1/include/asm-x86_64/unistd.h
===================================================================
--- linux-2.6.14-rc4-mm1.orig/include/asm-x86_64/unistd.h	2005-10-17 10:24:22.000000000 -0700
+++ linux-2.6.14-rc4-mm1/include/asm-x86_64/unistd.h	2005-10-20 13:34:44.000000000 -0700
@@ -571,8 +571,10 @@ __SYSCALL(__NR_inotify_init, sys_inotify
 __SYSCALL(__NR_inotify_add_watch, sys_inotify_add_watch)
 #define __NR_inotify_rm_watch	255
 __SYSCALL(__NR_inotify_rm_watch, sys_inotify_rm_watch)
+#define __NR_migrate_pages	256
+__SYSCALL(__NR_migrate_pages, sys_migrate_pages)
 
-#define __NR_syscall_max __NR_inotify_rm_watch
+#define __NR_syscall_max __NR_migrate_pages
 #ifndef __NO_STUBS
 
 /* user-visible error numbers are in the range -1 - -4095 */
Index: linux-2.6.14-rc4-mm1/include/linux/syscalls.h
===================================================================
--- linux-2.6.14-rc4-mm1.orig/include/linux/syscalls.h	2005-10-17 10:24:22.000000000 -0700
+++ linux-2.6.14-rc4-mm1/include/linux/syscalls.h	2005-10-20 13:34:44.000000000 -0700
@@ -511,5 +511,7 @@ asmlinkage long sys_ioprio_set(int which
 asmlinkage long sys_ioprio_get(int which, int who);
 asmlinkage long sys_set_mempolicy(int mode, unsigned long __user *nmask,
 					unsigned long maxnode);
+asmlinkage long sys_migrate_pages(pid_t pid, unsigned long maxnode,
+			unsigned long __user *from, unsigned long __user *to);
 
 #endif
Index: linux-2.6.14-rc4-mm1/include/linux/mempolicy.h
===================================================================
--- linux-2.6.14-rc4-mm1.orig/include/linux/mempolicy.h	2005-10-20 13:26:28.000000000 -0700
+++ linux-2.6.14-rc4-mm1/include/linux/mempolicy.h	2005-10-20 13:50:00.000000000 -0700
@@ -159,6 +159,9 @@ extern void numa_default_policy(void);
 extern void numa_policy_init(void);
 extern struct mempolicy default_policy;
 
+int do_migrate_pages(struct mm_struct *mm,
+	nodemask_t *from_nodes, nodemask_t *to_nodes, int flags);
+
 #else
 
 struct mempolicy {};
