Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267247AbSLEHlG>; Thu, 5 Dec 2002 02:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267256AbSLEHlF>; Thu, 5 Dec 2002 02:41:05 -0500
Received: from holomorphy.com ([66.224.33.161]:54152 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267247AbSLEHlA>;
	Thu, 5 Dec 2002 02:41:00 -0500
Date: Wed, 04 Dec 2002 23:48:27 -0800
From: wli@holomorphy.com
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu
Subject: [pidhash] [5/4] make get_pid_list() scan the PID bitmap
Message-ID: <0212042348.Ic0cdcccIcvchaKdUcrcWbraUbzcZbvc15950@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <0212042348.Lc~dAa2dkcWdYdAaHamaUdNaHbxbwdzb15950@holomorphy.com>
X-Mailer: patchbomb 0.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make get_pid_list() walk the PID bitmap instead of the tasklist.
This is not quite as good as it could be, because the PID search
structures are not appropriately arranged for range queries.

 fs/proc/base.c |   22 +---------------------
 kernel/pid.c   |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 21 deletions(-)


diff -urpN wli-2.5.50-5/fs/proc/base.c wli-2.5.50-6/fs/proc/base.c
--- wli-2.5.50-5/fs/proc/base.c	2002-11-27 14:36:06.000000000 -0800
+++ wli-2.5.50-6/fs/proc/base.c	2002-12-04 19:15:00.000000000 -0800
@@ -1153,28 +1153,8 @@ out:
  * tasklist lock while doing this, and we must release it before
  * we actually do the filldir itself, so we use a temp buffer..
  */
-static int get_pid_list(int index, unsigned int *pids)
-{
-	struct task_struct *p;
-	int nr_pids = 0;
-
-	index--;
-	read_lock(&tasklist_lock);
-	for_each_process(p) {
-		int pid = p->pid;
-		if (!pid)
-			continue;
-		if (--index >= 0)
-			continue;
-		pids[nr_pids] = pid;
-		nr_pids++;
-		if (nr_pids >= PROC_MAXPIDS)
-			break;
-	}
-	read_unlock(&tasklist_lock);
-	return nr_pids;
-}
 
+int get_pid_list(int ordinal_of_pid, unsigned int *pid_buf);
 int proc_pid_readdir(struct file * filp, void * dirent, filldir_t filldir)
 {
 	unsigned int pid_array[PROC_MAXPIDS];
diff -urpN wli-2.5.50-5/kernel/pid.c wli-2.5.50-6/kernel/pid.c
--- wli-2.5.50-5/kernel/pid.c	2002-11-27 14:36:03.000000000 -0800
+++ wli-2.5.50-6/kernel/pid.c	2002-12-04 19:15:59.000000000 -0800
@@ -258,6 +258,59 @@ void switch_exec_pids(task_t *leader, ta
 	attach_pid(leader, PIDTYPE_SID, leader->session);
 }
 
+int get_pid_list(int ordinal, unsigned int *pid_buf)
+{
+	pidmap_t *map = pidmap_array;
+	int count = 0, k = 0, pos = 0;
+
+	BUG_ON(ordinal <= 0);
+	ordinal--;
+
+	while (pos + BITS_PER_PAGE < ordinal && map - pidmap_array < PIDMAP_ENTRIES) {
+		pos += BITS_PER_PAGE - atomic_read(&map->nr_free);
+		++map;
+	}
+
+	if (map - pidmap_array >= PIDMAP_ENTRIES || !map->page)
+		return 0;
+
+	while (pos < ordinal && k < BITS_PER_PAGE) {
+		task_t *task;
+		if (test_bit(k, map->page)
+			&& (map - pidmap_array)*BITS_PER_PAGE + k) {
+			int pid = (map-pidmap_array)*BITS_PER_PAGE + k;
+			read_lock(&tasklist_lock);
+			task = find_task_by_pid(pid);
+			if (task && thread_group_leader(task))
+				++pos;
+			read_unlock(&tasklist_lock);
+		}
+		++k;
+	}
+
+	while (map - pidmap_array < PIDMAP_ENTRIES && map->page && count < 20) {
+		while (k < BITS_PER_PAGE && count < 20) {
+			task_t *task;
+
+			if (test_bit(k, map->page)
+				&& (map - pidmap_array)*BITS_PER_PAGE + k) {
+				int pid = (map-pidmap_array)*BITS_PER_PAGE + k;
+				read_lock(&tasklist_lock);
+				task = find_task_by_pid(pid);
+				if (task && thread_group_leader(task)) {
+					pid_buf[count] = task->pid;
+					++count;
+				}
+				read_unlock(&tasklist_lock);
+			}
+			++k;
+		}
+		++map;
+		k = 0;
+	}
+	return count;
+}
+
 void __init pidhash_init(void)
 {
 	int i, j;
