Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSENRtS>; Tue, 14 May 2002 13:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315929AbSENRs6>; Tue, 14 May 2002 13:48:58 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:30220 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S315926AbSENRrv>; Tue, 14 May 2002 13:47:51 -0400
Date: Tue, 14 May 2002 14:47:24 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] io wait statistics in /proc
Message-ID: <Pine.LNX.4.44L.0205141442550.9490-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the following patch implements io wait statistics for the
current 2.5 kernel, the patch works as follows:

1) every time a task has to sleep on IO it increments
   nr_iowait_tasks (in the slow path only)

2) in the timer interrupt we count a jiffy as iowait if
   it would otherwise have been counted as idle and there
   is a task sleeping on IO

3) to keep compatability with current procps iowait time
   is not substracted from idle time, programs like top
   can do this themselves once they get support for iowait

Please apply this patch for the next 2.5 kernel.

thank you,

Rik
-- 
	http://www.linuxsymposium.org/2002/
"You're one of those condescending OLS attendants"
"Here's a nickle kid.  Go buy yourself a real t-shirt"

http://www.surriel.com/		http://distro.conectiva.com/


 fs/buffer.c                 |    2 ++
 fs/proc/proc_misc.c         |   13 ++++++++-----
 include/linux/kernel_stat.h |    3 ++-
 include/linux/swap.h        |    1 +
 kernel/sched.c              |    2 ++
 mm/filemap.c                |    5 +++++
 6 files changed, 20 insertions(+), 6 deletions(-)


===== fs/buffer.c 1.96 vs edited =====
--- 1.96/fs/buffer.c	Sat May  4 20:46:31 2002
+++ edited/fs/buffer.c	Tue May 14 14:06:40 2002
@@ -142,7 +142,9 @@
 		set_task_state(tsk, TASK_UNINTERRUPTIBLE);
 		if (!buffer_locked(bh))
 			break;
+		atomic_inc(&nr_iowait_tasks);
 		schedule();
+		atomic_dec(&nr_iowait_tasks);
 	} while (buffer_locked(bh));
 	tsk->state = TASK_RUNNING;
 	remove_wait_queue(wq, &wait);
===== fs/proc/proc_misc.c 1.24 vs edited =====
--- 1.24/fs/proc/proc_misc.c	Fri May  3 02:01:31 2002
+++ edited/fs/proc/proc_misc.c	Tue May 14 14:06:41 2002
@@ -282,7 +282,7 @@
 	int i, len;
 	extern unsigned long total_forks;
 	unsigned long jif = jiffies;
-	unsigned int sum = 0, user = 0, nice = 0, system = 0;
+	unsigned int sum = 0, user = 0, nice = 0, system = 0, iowait = 0;
 	int major, disk;

 	for (i = 0 ; i < smp_num_cpus; i++) {
@@ -291,23 +291,26 @@
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
===== include/linux/kernel_stat.h 1.4 vs edited =====
--- 1.4/include/linux/kernel_stat.h	Thu Apr 11 01:25:39 2002
+++ edited/include/linux/kernel_stat.h	Tue May 14 14:06:44 2002
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
===== include/linux/swap.h 1.42 vs edited =====
--- 1.42/include/linux/swap.h	Sun May  5 13:55:39 2002
+++ edited/include/linux/swap.h	Tue May 14 14:07:52 2002
@@ -108,6 +108,7 @@
 extern atomic_t buffermem_pages;
 extern spinlock_t pagecache_lock;
 extern void __remove_inode_page(struct page *);
+extern atomic_t nr_iowait_tasks;

 /* Incomplete types for prototype declarations: */
 struct task_struct;
===== kernel/sched.c 1.73 vs edited =====
--- 1.73/kernel/sched.c	Mon Apr 29 09:16:24 2002
+++ edited/kernel/sched.c	Tue May 14 14:10:06 2002
@@ -679,6 +679,8 @@
 	if (p == rq->idle) {
 		if (local_bh_count(cpu) || local_irq_count(cpu) > 1)
 			kstat.per_cpu_system[cpu] += system;
+		else if (atomic_read(&nr_iowait_tasks) > 0)
+			kstat.per_cpu_iowait[cpu] += system;
 #if CONFIG_SMP
 		idle_tick();
 #endif
===== mm/filemap.c 1.87 vs edited =====
--- 1.87/mm/filemap.c	Mon May  6 12:12:36 2002
+++ edited/mm/filemap.c	Tue May 14 14:12:03 2002
@@ -48,6 +48,7 @@
  *        ->sb_lock		(fs/fs-writeback.c)
  */
 spinlock_t pagemap_lru_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
+atomic_t nr_iowait_tasks = ATOMIC_INIT(0);

 /*
  * Remove a page from the page cache and free it. Caller has to make
@@ -611,8 +612,10 @@
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
@@ -675,8 +678,10 @@
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

