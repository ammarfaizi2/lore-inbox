Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318541AbSIFQcj>; Fri, 6 Sep 2002 12:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318497AbSIFQci>; Fri, 6 Sep 2002 12:32:38 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:4070 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S318541AbSIFQcg>; Fri, 6 Sep 2002 12:32:36 -0400
Date: Fri, 6 Sep 2002 13:36:59 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] iowait stats for 2.5.33
Message-ID: <Pine.LNX.4.44L.0209061332190.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patch, against 2.5.33-mm4, implements iowait
statistics in /proc/stat.  This can be used to determine how
much of your machine's idle time is truly idle and how much
time it should have been doing something but was waiting on
(disk) IO instead.

Please add this to your patch queue or let me know if you want
any changes to it.

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Spamtraps of the month:  september@surriel.com trac@trac.org


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.657   -> 1.658
#	include/linux/swap.h	1.57    -> 1.58
#	drivers/block/ll_rw_blk.c	1.102   -> 1.103
#	      kernel/sched.c	1.125   -> 1.126
#	        mm/filemap.c	1.140   -> 1.141
#	include/linux/kernel_stat.h	1.6     -> 1.7
#	         fs/buffer.c	1.149   -> 1.150
#	      fs/direct-io.c	1.7     -> 1.8
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/06	riel@imladris.surriel.com	1.658
# iowait statistics
# --------------------------------------------
#
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Fri Sep  6 13:30:24 2002
+++ b/drivers/block/ll_rw_blk.c	Fri Sep  6 13:30:24 2002
@@ -1214,8 +1214,11 @@
 	add_wait_queue_exclusive(&rl->wait, &wait);
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (!rl->count)
+		if (!rl->count) {
+			atomic_inc(&nr_iowait_tasks);
 			schedule();
+			atomic_dec(&nr_iowait_tasks);
+		}
 		spin_lock_irq(q->queue_lock);
 		rq = get_request(q, rw);
 		spin_unlock_irq(q->queue_lock);
@@ -1447,8 +1450,11 @@
 	blk_run_queues();
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	add_wait_queue(wq, &wait);
-	if (atomic_read(&nr_congested_queues))
+	if (atomic_read(&nr_congested_queues)) {
+		atomic_inc(&nr_iowait_tasks);
 		schedule_timeout(timeout);
+		atomic_dec(&nr_iowait_tasks);
+	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(wq, &wait);
 }
diff -Nru a/fs/buffer.c b/fs/buffer.c
--- a/fs/buffer.c	Fri Sep  6 13:30:24 2002
+++ b/fs/buffer.c	Fri Sep  6 13:30:24 2002
@@ -139,7 +139,9 @@
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (!buffer_locked(bh))
 			break;
+		atomic_inc(&nr_iowait_tasks);
 		schedule();
+		atomic_dec(&nr_iowait_tasks);
 	} while (buffer_locked(bh));
 	tsk->state = TASK_RUNNING;
 	remove_wait_queue(wq, &wait);
diff -Nru a/fs/direct-io.c b/fs/direct-io.c
--- a/fs/direct-io.c	Fri Sep  6 13:30:24 2002
+++ b/fs/direct-io.c	Fri Sep  6 13:30:24 2002
@@ -227,8 +227,10 @@
 		if (dio->bio_list == NULL) {
 			dio->waiter = current;
 			spin_unlock_irqrestore(&dio->bio_list_lock, flags);
+			atomic_inc(&nr_iowait_tasks);
 			blk_run_queues();
 			schedule();
+			atomic_dec(&nr_iowait_tasks);
 			spin_lock_irqsave(&dio->bio_list_lock, flags);
 			dio->waiter = NULL;
 		}
diff -Nru a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
--- a/include/linux/kernel_stat.h	Fri Sep  6 13:30:24 2002
+++ b/include/linux/kernel_stat.h	Fri Sep  6 13:30:24 2002
@@ -18,7 +18,9 @@
 struct kernel_stat {
 	unsigned int per_cpu_user[NR_CPUS],
 	             per_cpu_nice[NR_CPUS],
-	             per_cpu_system[NR_CPUS];
+	             per_cpu_system[NR_CPUS],
+	             per_cpu_idle[NR_CPUS],
+	             per_cpu_iowait[NR_CPUS];
 	unsigned int dk_drive[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];
diff -Nru a/include/linux/swap.h b/include/linux/swap.h
--- a/include/linux/swap.h	Fri Sep  6 13:30:24 2002
+++ b/include/linux/swap.h	Fri Sep  6 13:30:24 2002
@@ -133,6 +133,7 @@
 extern unsigned int nr_free_pages(void);
 extern unsigned int nr_free_buffer_pages(void);
 extern unsigned int nr_free_pagecache_pages(void);
+extern atomic_t nr_iowait_tasks;

 /* Incomplete types for prototype declarations: */
 struct task_struct;
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Fri Sep  6 13:30:24 2002
+++ b/kernel/sched.c	Fri Sep  6 13:30:24 2002
@@ -862,6 +862,10 @@
 		/* note: this timer irq context must be accounted for as well */
 		if (irq_count() - HARDIRQ_OFFSET >= SOFTIRQ_OFFSET)
 			kstat.per_cpu_system[cpu] += sys_ticks;
+		else if (atomic_read(&nr_iowait_tasks) > 0)
+			kstat.per_cpu_iowait[cpu] += sys_ticks;
+		else
+			kstat.per_cpu_idle[cpu] += sys_ticks;
 #if CONFIG_SMP
 		idle_tick(rq);
 #endif
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Fri Sep  6 13:30:24 2002
+++ b/mm/filemap.c	Fri Sep  6 13:30:24 2002
@@ -49,7 +49,7 @@
  *
  * SMP-threaded pagemap-LRU 1999, Andrea Arcangeli <andrea@suse.de>
  */
-
+atomic_t nr_iowait_tasks = ATOMIC_INIT(0);

 /*
  * Lock ordering:
@@ -639,8 +639,10 @@
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (!test_bit(bit_nr, &page->flags))
 			break;
+		atomic_inc(&nr_iowait_tasks);
 		sync_page(page);
 		schedule();
+		atomic_dec(&nr_iowait_tasks);
 	} while (test_bit(bit_nr, &page->flags));
 	__set_task_state(tsk, TASK_RUNNING);
 	remove_wait_queue(waitqueue, &wait);
@@ -702,8 +704,10 @@
 	for (;;) {
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (PageLocked(page)) {
+			atomic_inc(&nr_iowait_tasks);
 			sync_page(page);
 			schedule();
+			atomic_dec(&nr_iowait_tasks);
 		}
 		if (!TestSetPageLocked(page))
 			break;

