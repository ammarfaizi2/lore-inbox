Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314929AbSENBTy>; Mon, 13 May 2002 21:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314938AbSENBTx>; Mon, 13 May 2002 21:19:53 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:2577 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S314929AbSENBTu>; Mon, 13 May 2002 21:19:50 -0400
Date: Mon, 13 May 2002 22:19:26 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: linux-kernel@vger.kernel.org
cc: linux-mm@kvack.org
Subject: [RFC][PATCH] iowait statistics
Message-ID: <Pine.LNX.4.44L.0205132214480.32261-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patch implements iowait statistics in a simple way:

1) if we go to sleep while waiting on a page or buffer, we
   increment nr_iowait_tasks, note that this is done only in
   the slow path so overhead shouldn't even be measurable

2) if no process is running, the timer interrupt adds a jiffy
   to the iowait time

3) iowait time is counted separately from user/system/idle and
   can overlap with either system or idle (when no process is
   running the system can still be busy processing interrupts)

4) on SMP systems the iowait time can be overestimated, no big
   deal IMHO but cheap suggestions for improvement are welcome

The only issue I could see with this patch is (3), should iowait
be counted the same as user/system/idle and should /proc/stat
be changed or should we keep the thing backward compatible and
have iowait "differently" accounted for ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


===== fs/buffer.c 1.64 vs edited =====
--- 1.64/fs/buffer.c	Mon May 13 19:04:59 2002
+++ edited/fs/buffer.c	Mon May 13 19:16:57 2002
@@ -156,8 +156,10 @@
 	get_bh(bh);
 	add_wait_queue(&bh->b_wait, &wait);
 	do {
+		atomic_inc(&nr_iowait_tasks);
 		run_task_queue(&tq_disk);
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
+		atomic_dec(&nr_iowait_tasks);
 		if (!buffer_locked(bh))
 			break;
 		schedule();
===== fs/proc/proc_misc.c 1.14 vs edited =====
--- 1.14/fs/proc/proc_misc.c	Sun Apr  7 18:04:14 2002
+++ edited/fs/proc/proc_misc.c	Mon May 13 19:16:59 2002
@@ -169,7 +169,7 @@
 		"Active:       %8u kB\n"
 		"Inact_dirty:  %8u kB\n"
 		"Inact_clean:  %8u kB\n"
-		"Inact_target: %8lu kB\n"
+		"Inact_target: %8u kB\n"
 		"HighTotal:    %8lu kB\n"
 		"HighFree:     %8lu kB\n"
 		"LowTotal:     %8lu kB\n"
@@ -266,7 +266,7 @@
 	int i, len;
 	extern unsigned long total_forks;
 	unsigned long jif = jiffies;
-	unsigned int sum = 0, user = 0, nice = 0, system = 0;
+	unsigned int sum = 0, user = 0, nice = 0, system = 0, iowait = 0;
 	int major, disk;

 	for (i = 0 ; i < smp_num_cpus; i++) {
@@ -275,23 +275,26 @@
 		user += kstat.per_cpu_user[cpu];
 		nice += kstat.per_cpu_nice[cpu];
 		system += kstat.per_cpu_system[cpu];
+		iowait += kstat.per_cpu_iowait[cpu];
 #if !defined(CONFIG_ARCH_S390)
 		for (j = 0 ; j < NR_IRQS ; j++)
 			sum += kstat.irqs[cpu][j];
 #endif
 	}

-	len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
-		      jif * smp_num_cpus - (user + nice + system));
+	len = sprintf(page, "cpu  %u %u %u %lu %u\n", user, nice, system,
+		      jif * smp_num_cpus - (user + nice + system),
+		      iowait);
 	for (i = 0 ; i < smp_num_cpus; i++)
-		len += sprintf(page + len, "cpu%d %u %u %u %lu\n",
+		len += sprintf(page + len, "cpu%d %u %u %u %lu %u\n",
 			i,
 			kstat.per_cpu_user[cpu_logical_map(i)],
 			kstat.per_cpu_nice[cpu_logical_map(i)],
 			kstat.per_cpu_system[cpu_logical_map(i)],
 			jif - (  kstat.per_cpu_user[cpu_logical_map(i)] \
 				   + kstat.per_cpu_nice[cpu_logical_map(i)] \
-				   + kstat.per_cpu_system[cpu_logical_map(i)]));
+				   + kstat.per_cpu_system[cpu_logical_map(i)]),
+			kstat.per_cpu_iowait[cpu_logical_map(i)]);
 	len += sprintf(page + len,
 		"page %u %u\n"
 		"swap %u %u\n"
===== include/linux/kernel_stat.h 1.3 vs edited =====
--- 1.3/include/linux/kernel_stat.h	Thu Apr 11 01:27:34 2002
+++ edited/include/linux/kernel_stat.h	Mon May 13 19:31:31 2002
@@ -18,7 +18,8 @@
 struct kernel_stat {
 	unsigned int per_cpu_user[NR_CPUS],
 	             per_cpu_nice[NR_CPUS],
-	             per_cpu_system[NR_CPUS];
+	             per_cpu_system[NR_CPUS],
+	             per_cpu_iowait[NR_CPUS];
 	unsigned int dk_drive[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];
===== include/linux/swap.h 1.35 vs edited =====
--- 1.35/include/linux/swap.h	Mon May 13 19:04:59 2002
+++ edited/include/linux/swap.h	Mon May 13 19:17:32 2002
@@ -90,6 +90,7 @@
 extern int nr_inactive_clean_pages;
 extern atomic_t page_cache_size;
 extern atomic_t buffermem_pages;
+extern atomic_t nr_iowait_tasks;

 extern spinlock_cacheline_t pagecache_lock_cacheline;
 #define pagecache_lock (pagecache_lock_cacheline.lock)
===== kernel/timer.c 1.4 vs edited =====
--- 1.4/kernel/timer.c	Tue Apr 30 13:38:16 2002
+++ edited/kernel/timer.c	Mon May 13 22:04:48 2002
@@ -608,8 +608,16 @@
 		else
 			kstat.per_cpu_user[cpu] += user_tick;
 		kstat.per_cpu_system[cpu] += system;
-	} else if (local_bh_count(cpu) || local_irq_count(cpu) > 1)
-		kstat.per_cpu_system[cpu] += system;
+	} else {
+		/*
+		 * No process is running, but if we're handling interrupts
+		 * or processes are waiting on disk IO, we're not really idle.
+		 */
+	       	if (local_bh_count(cpu) || local_irq_count(cpu) > 1)
+			kstat.per_cpu_system[cpu] += system;
+		if (atomic_read(&nr_iowait_tasks) > 0)
+			kstat.per_cpu_iowait[cpu] += system;
+	}
 }

 /*
===== mm/filemap.c 1.69 vs edited =====
--- 1.69/mm/filemap.c	Mon May 13 19:05:00 2002
+++ edited/mm/filemap.c	Mon May 13 22:04:18 2002
@@ -44,6 +44,7 @@
  */

 atomic_t page_cache_size = ATOMIC_INIT(0);
+atomic_t nr_iowait_tasks = ATOMIC_INIT(0);
 unsigned int page_hash_bits;
 struct page **page_hash_table;

@@ -828,8 +829,10 @@
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (!PageLocked(page))
 			break;
+		atomic_inc(&nr_iowait_tasks);
 		sync_page(page);
 		schedule();
+		atomic_dec(&nr_iowait_tasks);
 	} while (PageLocked(page));
 	__set_task_state(tsk, TASK_RUNNING);
 	remove_wait_queue(waitqueue, &wait);
@@ -864,8 +867,10 @@
 	for (;;) {
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (PageLocked(page)) {
+			atomic_inc(&nr_iowait_tasks);
 			sync_page(page);
 			schedule();
+			atomic_dec(&nr_iowait_tasks);
 		}
 		if (!TryLockPage(page))
 			break;

