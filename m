Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVLOOkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVLOOkO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 09:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbVLOOjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 09:39:46 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:54938 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1750729AbVLOOjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 09:39:05 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
Message-Id: <20051215143858.104720000@elg11.watson.ibm.com>
References: <20051215143557.421393000@elg11.watson.ibm.com>
Date: Thu, 15 Dec 2005 09:36:11 -0500
To: linux-kernel@vger.kernel.org
Subject: [RFC][patch 14/21] PID Virtualization: pidspace
Content-Disposition: inline; filename=G1-pidspace.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces pitspaces to provide pid virtualization
capabilities. A pidspace will be allocated for each container
and destroyed (resources freed) when the container is 
terminated.

The global pid range ( 32 bit) is partitioned into 
PID_MAX_LIMIT sized pidspaces. The virtualization
is defined as kernel_pid ::= < pidspace_id, vpid >

In this patch we are utilizing the existing pid management,
i.e. allocation and hashing. We are providing a pidspace, as managed 
previously, for each pidspace id. 

Patch eliminates the explicit management of vpids and allows
continued usage of the existing pid hashing and lookup functions.

Signed-off-by: Hubertus Franke <frankeh@watson.ibm.com>
--

 include/linux/pid.h     |   27 +++++++++++-
 include/linux/threads.h |   17 +++++--
 kernel/fork.c           |    2 
 kernel/pid.c            |  105 +++++++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 135 insertions(+), 16 deletions(-)

Index: linux-2.6.15-rc1/kernel/fork.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/fork.c	2005-12-12 18:39:51.000000000 -0500
+++ linux-2.6.15-rc1/kernel/fork.c	2005-12-12 18:40:32.000000000 -0500
@@ -1241,7 +1241,7 @@ long do_fork(unsigned long clone_flags,
 {
 	struct task_struct *p;
 	int trace = 0;
-	long pid = alloc_pidmap();
+	long pid = alloc_pidmap(DEFAULT_PIDSPACE);
 	long vpid;
 
 	if (pid < 0)
Index: linux-2.6.15-rc1/include/linux/pid.h
===================================================================
--- linux-2.6.15-rc1.orig/include/linux/pid.h	2005-12-12 18:37:35.000000000 -0500
+++ linux-2.6.15-rc1/include/linux/pid.h	2005-12-12 18:40:04.000000000 -0500
@@ -36,7 +36,7 @@ extern void FASTCALL(detach_pid(struct t
  */
 extern struct pid *FASTCALL(find_pid(enum pid_type, int));
 
-extern int alloc_pidmap(void);
+extern int alloc_pidmap(int pidspace_id);
 extern void FASTCALL(free_pidmap(int));
 extern void switch_exec_pids(struct task_struct *leader, struct task_struct *thread);
 
@@ -51,5 +51,30 @@ extern void switch_exec_pids(struct task
 			prefetch((task)->pids[type].pid_list.next),	\
 			hlist_unhashed(&(task)->pids[type].pid_chain));	\
 	}								\
+/*
+ * Pidspace related definition for translation  real <-> virtual
+ * and initialization functions
+ */
+
+#define DEFAULT_PIDSPACE	0
+
+extern int pidspace_init(int pidspace_id);
+extern int pidspace_free(int pidspace_id);
+
+static inline int pid_to_pidspace(int pid)
+{
+	return (pid >> PID_MAX_LIMIT_SHIFT);
+}
+
+static inline int pidspace_vpid_to_pid(int pidspace_id, pid_t pid)
+{
+	return (pidspace_id << PID_MAX_LIMIT_SHIFT) | pid;
+}
+
+static inline int pidspace_pid_to_vpid(pid_t pid)
+{
+	return (pid & (PID_MAX_LIMIT-1));
+}
+
 
 #endif /* _LINUX_PID_H */
Index: linux-2.6.15-rc1/include/linux/threads.h
===================================================================
--- linux-2.6.15-rc1.orig/include/linux/threads.h	2005-12-12 18:37:35.000000000 -0500
+++ linux-2.6.15-rc1/include/linux/threads.h	2005-12-12 18:40:04.000000000 -0500
@@ -25,12 +25,21 @@
 /*
  * This controls the default maximum pid allocated to a process
  */
-#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x8000)
+#define PID_MAX_DEFAULT_SHIFT	(CONFIG_BASE_SMALL ? 12 : 15)
+#define PID_MAX_DEFAULT 	(1<< PID_MAX_DEFAULT_SHIFT)
 
 /*
- * A maximum of 4 million PIDs should be enough for a while:
+ * The entire global pid range is devided into pidspaces
+ * each able to hold upto PID_MAX_LIMIT pids.
+ * A maximum of 512 pidspace should be enough for a while
+ * A maximum of 4 million PIDs per pidspace should be enough for a while:
+ * we keep high bit reserved for negative values
  */
-#define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
-	(sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
+#define PID_MAX_LIMIT_SHIFT (CONFIG_BASE_SMALL ? PAGE_SHIFT + 8 : \
+	(sizeof(long) > 4 ? 22 : PID_MAX_DEFAULT_SHIFT))
+#define PID_MAX_LIMIT 		(1<<PID_MAX_LIMIT_SHIFT)
+
+#define MAX_NR_PIDSPACES 	(PID_MAX_LIMIT_SHIFT > 22 ?   \
+				 1<<(32-PID_MAX_LIMIT_SHIFT-1) : 512)
 
 #endif
Index: linux-2.6.15-rc1/kernel/pid.c
===================================================================
--- linux-2.6.15-rc1.orig/kernel/pid.c	2005-12-12 18:37:35.000000000 -0500
+++ linux-2.6.15-rc1/kernel/pid.c	2005-12-12 18:40:04.000000000 -0500
@@ -35,6 +35,7 @@ int pid_max = PID_MAX_DEFAULT;
 int last_pid;
 
 #define RESERVED_PIDS		300
+#define RESERVED_PIDS_NON_DFLT    1
 
 int pid_max_min = RESERVED_PIDS + 1;
 int pid_max_max = PID_MAX_LIMIT;
@@ -57,29 +58,103 @@ typedef struct pidmap {
 	void *page;
 } pidmap_t;
 
-static pidmap_t pidmap_array[PIDMAP_ENTRIES] =
+struct pidspace {
+	int last_pid;
+	pidmap_t *pidmap_array;
+};
+
+static pidmap_t dflt_pidmap_array[PIDMAP_ENTRIES] =
 	 { [ 0 ... PIDMAP_ENTRIES-1 ] = { ATOMIC_INIT(BITS_PER_PAGE), NULL } };
 
+static struct pidspace pid_spaces[MAX_NR_PIDSPACES] =
+	{ { 0, dflt_pidmap_array } };
+
 static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(pidmap_lock);
 
+int pidspace_init(int pidspace_id)
+{
+	pidmap_t *map;
+	struct pidspace *pid_space =  &pid_spaces[pidspace_id];
+	int i;
+	int rc;
+
+	if (unlikely(pid_space->pidmap_array))
+		return -EBUSY;
+
+	map = kmalloc(PIDMAP_ENTRIES*sizeof(pidmap_t), GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	for (i=0 ; i< PIDMAP_ENTRIES ; i++)
+		map[i] = (pidmap_t){ ATOMIC_INIT(BITS_PER_PAGE), NULL };
+
+	/*
+	 * Free the pidspace if someone raced with us
+	 * installing it:
+	 */
+
+	spin_lock(&pidmap_lock);
+	if (pid_space->pidmap_array) {
+		kfree(map);
+		rc = -EAGAIN;
+	} else {
+		pid_space->pidmap_array = map;
+		pid_space->last_pid = RESERVED_PIDS_NON_DFLT;
+		rc = 0;
+	}
+	spin_unlock(&pidmap_lock);
+	return rc;
+}
+
+int pidspace_free(int pidspace_id)
+{
+	struct pidspace *pid_space =  &pid_spaces[pidspace_id];
+	pidmap_t *map;
+	int i;
+
+	spin_lock(&pidmap_lock);
+	BUG_ON(pid_space->pidmap_array == NULL);
+	map = pid_space->pidmap_array;
+	pid_space->pidmap_array = NULL;
+	spin_unlock(&pidmap_lock);
+
+	for ( i=0; i<PIDMAP_ENTRIES; i++)
+		free_page((unsigned long)map[i].page);
+	kfree(map);
+	return 0;
+}
+
 fastcall void free_pidmap(int pid)
 {
-	pidmap_t *map = pidmap_array + pid / BITS_PER_PAGE;
-	int offset = pid & BITS_PER_PAGE_MASK;
+	pidmap_t *map, *pidmap_array;
+	int offset;
+
+	pidmap_array = pid_spaces[pid_to_pidspace(pid)].pidmap_array;
+	pid = pidspace_pid_to_vpid(pid);
+	map = pidmap_array + pid / BITS_PER_PAGE;
+	offset = pid & BITS_PER_PAGE_MASK;
 
 	clear_bit(offset, map->page);
 	atomic_inc(&map->nr_free);
 }
 
-int alloc_pidmap(void)
+int alloc_pidmap(int pidspace_id)
 {
-	int i, offset, max_scan, pid, last = last_pid;
-	pidmap_t *map;
+	int i, offset, max_scan, pid, last;
+	struct pidspace *pid_space;
+	pidmap_t *map, *pidmap_array;
 
+	pid_space = &pid_spaces[pidspace_id];
+	last = pid_space->last_pid;
 	pid = last + 1;
-	if (pid >= pid_max)
-		pid = RESERVED_PIDS;
+	if (pid >= pid_max) {
+		if (pidspace_id == DEFAULT_PIDSPACE)
+			pid = RESERVED_PIDS;
+		else
+			pid = RESERVED_PIDS_NON_DFLT;
+	}
 	offset = pid & BITS_PER_PAGE_MASK;
+	pidmap_array = pid_space->pidmap_array;
 	map = &pidmap_array[pid/BITS_PER_PAGE];
 	max_scan = (pid_max + BITS_PER_PAGE - 1)/BITS_PER_PAGE - !offset;
 	for (i = 0; i <= max_scan; ++i) {
@@ -102,7 +177,12 @@ int alloc_pidmap(void)
 			do {
 				if (!test_and_set_bit(offset, map->page)) {
 					atomic_dec(&map->nr_free);
-					last_pid = pid;
+					pid_space->last_pid = pid;
+					if (pidspace_id == 0) {
+						last_pid = pid;
+						return pid;
+					}
+					pid = pidspace_vpid_to_pid(pidspace_id, pid);
 					return pid;
 				}
 				offset = find_next_offset(map, offset);
@@ -122,7 +202,10 @@ int alloc_pidmap(void)
 			offset = 0;
 		} else {
 			map = &pidmap_array[0];
-			offset = RESERVED_PIDS;
+			if (pidspace_id == DEFAULT_PIDSPACE)
+				offset = RESERVED_PIDS;
+			else
+				offset = RESERVED_PIDS_NON_DFLT;
 			if (unlikely(last == offset))
 				break;
 		}
@@ -279,6 +362,8 @@ void __init pidmap_init(void)
 {
 	int i;
 
+	pidmap_t *pidmap_array = dflt_pidmap_array;
+
 	pidmap_array->page = (void *)get_zeroed_page(GFP_KERNEL);
 	set_bit(0, pidmap_array->page);
 	atomic_dec(&pidmap_array->nr_free);

--
