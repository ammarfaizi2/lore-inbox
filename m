Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316428AbSEOQNs>; Wed, 15 May 2002 12:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316429AbSEOQNr>; Wed, 15 May 2002 12:13:47 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:1543 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S316428AbSEOQNq>; Wed, 15 May 2002 12:13:46 -0400
Date: Wed, 15 May 2002 13:13:33 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH] iowait statistics
In-Reply-To: <200205151514.g4FFEmY13920@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44L.0205151310130.9490-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2002, Denis Vlasenko wrote:

> I think two patches for same kernel piece at the same time is
> too many. Go ahead and code this if you want.

OK, here it is.   Changes against yesterday's patch:

1) make sure idle time can never go backwards by incrementing
   the idle time in the timer interrupt too (surely we can
   take this overhead if we're idle anyway ;))

2) get_request_wait also raises nr_iowait_tasks (thanks akpm)

This patch is against the latest 2.5 kernel from bk and
pretty much untested. If you have the time, please test
it and let me know if it works.

regards,

Rik
-- 

 drivers/block/ll_rw_blk.c   |    5 ++++-
 fs/buffer.c                 |    2 ++
 fs/proc/proc_misc.c         |   15 ++++++++-------
 include/linux/kernel_stat.h |    4 +++-
 include/linux/swap.h        |    1 +
 kernel/sched.c              |    4 ++++
 mm/filemap.c                |    5 +++++
 7 files changed, 27 insertions(+), 9 deletions(-)


===== drivers/block/ll_rw_blk.c 1.65 vs edited =====
--- 1.65/drivers/block/ll_rw_blk.c	Mon May  6 12:17:09 2002
+++ edited/drivers/block/ll_rw_blk.c	Wed May 15 13:06:49 2002
@@ -1068,8 +1068,11 @@
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
+++ edited/fs/proc/proc_misc.c	Wed May 15 13:05:21 2002
@@ -282,7 +282,7 @@
 	int i, len;
 	extern unsigned long total_forks;
 	unsigned long jif = jiffies;
-	unsigned int sum = 0, user = 0, nice = 0, system = 0;
+	unsigned int sum = 0, user = 0, nice = 0, system = 0, idle = 0, iowait = 0;
 	int major, disk;

 	for (i = 0 ; i < smp_num_cpus; i++) {
@@ -291,23 +291,24 @@
 		user += kstat.per_cpu_user[cpu];
 		nice += kstat.per_cpu_nice[cpu];
 		system += kstat.per_cpu_system[cpu];
+		idle += kstat.per_cpu_idle[cpu];
+		iowait += kstat.per_cpu_iowait[cpu];
 #if !defined(CONFIG_ARCH_S390)
 		for (j = 0 ; j < NR_IRQS ; j++)
 			sum += kstat.irqs[cpu][j];
 #endif
 	}

-	len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
-		      jif * smp_num_cpus - (user + nice + system));
+	len = sprintf(page, "cpu  %u %u %u %u %u\n", user, nice, system,
+		      idle, iowait);
 	for (i = 0 ; i < smp_num_cpus; i++)
-		len += sprintf(page + len, "cpu%d %u %u %u %lu\n",
+		len += sprintf(page + len, "cpu%d %u %u %u %u %u\n",
 			i,
 			kstat.per_cpu_user[cpu_logical_map(i)],
 			kstat.per_cpu_nice[cpu_logical_map(i)],
 			kstat.per_cpu_system[cpu_logical_map(i)],
-			jif - (  kstat.per_cpu_user[cpu_logical_map(i)] \
-				   + kstat.per_cpu_nice[cpu_logical_map(i)] \
-				   + kstat.per_cpu_system[cpu_logical_map(i)]));
+			kstat.per_cpu_idle[cpu_logical_map(i)],
+			kstat.per_cpu_iowait[cpu_logical_map(i)]);
 	len += sprintf(page + len,
 		"page %u %u\n"
 		"swap %u %u\n"
===== include/linux/kernel_stat.h 1.4 vs edited =====
--- 1.4/include/linux/kernel_stat.h	Thu Apr 11 01:25:39 2002
+++ edited/include/linux/kernel_stat.h	Wed May 15 12:58:38 2002
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
+++ edited/kernel/sched.c	Wed May 15 12:58:18 2002
@@ -679,6 +679,10 @@
 	if (p == rq->idle) {
 		if (local_bh_count(cpu) || local_irq_count(cpu) > 1)
 			kstat.per_cpu_system[cpu] += system;
+		else if (atomic_read(&nr_iowait_tasks) > 0)
+			kstat.per_cpu_iowait[cpu] += system;
+		else
+			kstat.per_cpu_idle[cpu] += system;
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

