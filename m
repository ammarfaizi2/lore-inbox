Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbVINWC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbVINWC5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965017AbVINWC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:02:57 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:40003
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S965014AbVINWC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:02:56 -0400
Date: Thu, 15 Sep 2005 00:03:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] per-task-predictive-write-throttling-1
Message-ID: <20050914220334.GF4966@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wrote a patch to try avoiding making dirty about half the ram of the
computer when a single task is writing to disk (like during untarring or
rsyncing). I try to detect how many pages this task wrote durign the
last dirty_ratio_centisecs (sysctl configurable), and I assume that
those pages are already dirty (since they'll be soon anyway).

This way a write-hog task will not lock dirty half the cache for no good
reason and other tasks will be allowed to use the dirty cache to avoid
blocking during writes. It's not like the write will not be noticeable,
but it should become substantially more responsive.

I did a basic test to verify that the performance of the write-hog task
didn't suffer, the bandwidth remains the same (difference of 2 seconds
over 1 min and 20sec of workload). [though this should be tested in
other configurations, it may not be stable yet, the dirty level can go
down to zero to the point of nr_reclaimable reaching 0, hence the check
needed to avoid locking up in blk_congestion_wait]

/proc/<pid>/future_pages tells about the current prediction.
/proc/sys/vm/dirty_ratio_centisecs enables/disables the feature, setting
it to 0 makes the kernel behave like current mainline, no difference,
setting it close to zero means almost disabled, large values means very
enabled, a reasonable value is 5 sec, predicting too much in the future
may not lead the best results in real life as you can guess ;).

The below example is run on a 1G box. In the below example there is no
way you'll get the workload done in less than one second with this
feature enabled, while with the feature enabled it scores less than 1
second all the time. 

Note if you try yourself, please make sure to wait just a few seconds
(watch the "Dirty" level quickly decreasing in /proc/meminfo and
/proc/`pidof cp`/future_pages quickly increasing) after you started cp,
the heuristic takes a few seconds to get into full effect.

I'm running this on my desktop too, so far so good, but it's not well
tested, and it might have corner cases. It shall be tested with dbench
too (not that I would say this is good or bad depending on dbench
though, beacuse this may actually increase the fariness of the workload
giving each task a similar portion of dirty cache depending on the I/O
that each task is doing).

I increased a bit dirty_background_ratio (from 10 to 30) so that it can
more likely reach a point where cp is the one doing all the work. Not
sure if it's really necessary, but it had the same 30 setting for both
tests below.

Patch is overall not very complex.

xeon:~ # cat /proc/sys/vm/dirty_ratio_centisecs 
500
xeon:~ # cp /dev/zero /tmp/ &
[1] 6490
xeon:~ # dd if=/dev/zero of=/dev/null bs=1 count=1
1+0 records in
1+0 records out
xeon:~ # time for i in `seq 10`; do dd if=/dev/zero of=/tmp/tmp/$i bs=10M count=1 2>/dev/null ; echo -n .; done; rm /tmp/tmp/*
..........
real    0m0.514s
user    0m0.004s
sys     0m0.512s
xeon:~ # time for i in `seq 10`; do dd if=/dev/zero of=/tmp/tmp/$i bs=10M count=1 2>/dev/null ; echo -n .; done; rm /tmp/tmp/*
..........
real    0m0.550s
user    0m0.008s
sys     0m0.544s
^[[A
^[[A
xeon:~ # time for i in `seq 10`; do dd if=/dev/zero of=/tmp/tmp/$i bs=10M count=1 2>/dev/null ; echo -n .; done; rm /tmp/tmp/*
..........
real    0m0.501s
user    0m0.012s
sys     0m0.488s
^[[A
xeon:~ # time for i in `seq 10`; do dd if=/dev/zero of=/tmp/tmp/$i bs=10M count=1 2>/dev/null ; echo -n .; done; rm /tmp/tmp/*
..........
real    0m0.921s
user    0m0.008s
sys     0m0.488s
xeon:~ # time for i in `seq 10`; do dd if=/dev/zero of=/tmp/tmp/$i bs=10M count=1 2>/dev/null ; echo -n .; done; rm /tmp/tmp/*
..........
real    0m0.473s
user    0m0.008s
sys     0m0.464s
xeon:~ # fg
cp /dev/zero /tmp/
xeon:~ # rm /tmp/zero
xeon:~ # cat /proc/sys/vm/dirty_ratio_centisecs
500
xeon:~ # echo 0 > /proc/sys/vm/dirty_ratio_centisecs
xeon:~ # cat /proc/sys/vm/dirty_ratio_centisecs
0
xeon:~ # cp /dev/zero /tmp/ &
[1] 6592
xeon:~ # dd if=/dev/zero of=/dev/null bs=1 count=1
1+0 records in
1+0 records out
xeon:~ # time for i in `seq 10`; do dd if=/dev/zero of=/tmp/tmp/$i bs=10M count=1 2>/dev/null ; echo -n .; done; rm /tmp/tmp/*
..........
real    0m5.205s
user    0m0.004s
sys     0m0.580s
xeon:~ # time for i in `seq 10`; do dd if=/dev/zero of=/tmp/tmp/$i bs=10M count=1 2>/dev/null ; echo -n .; done; rm /tmp/tmp/*
..........
real    0m8.023s
user    0m0.008s
sys     0m0.608s
xeon:~ # time for i in `seq 10`; do dd if=/dev/zero of=/tmp/tmp/$i bs=10M count=1 2>/dev/null ; echo -n .; done; rm /tmp/tmp/*
..........
real    0m4.455s
user    0m0.008s
sys     0m0.640s
xeon:~ # time for i in `seq 10`; do dd if=/dev/zero of=/tmp/tmp/$i bs=10M count=1 2>/dev/null ; echo -n .; done; rm /tmp/tmp/*
..........
real    0m10.646s
user    0m0.012s
sys     0m0.732s
xeon:~ # time for i in `seq 10`; do dd if=/dev/zero of=/tmp/tmp/$i bs=10M count=1 2>/dev/null ; echo -n .; done; rm /tmp/tmp/*
..........
real    0m3.525s
user    0m0.008s
sys     0m0.624s

diff -r 8b591846b274 Documentation/filesystems/proc.txt
--- a/Documentation/filesystems/proc.txt	Sun Sep 11 17:16:07 2005
+++ b/Documentation/filesystems/proc.txt	Wed Sep 14 23:59:15 2005
@@ -1162,6 +1162,15 @@
 a process which is generating disk writes will itself start writing out dirty
 data.
 
+dirty_ratio_centisecs
+-----------------
+
+Throttle the I/O if the per-task writing bandwidth is high enough for
+the dirty_ratio to be reached in less than dirty_ratio_centisecs. This
+makes the write throttling per-process and avoids making too much
+memory dirty at the same time. Ideally in the future we should add
+some feedback from the backing_dev_info to know the max disk bandwidth.
+
 dirty_writeback_centisecs
 -------------------------
 
diff -r 8b591846b274 Documentation/sysctl/vm.txt
--- a/Documentation/sysctl/vm.txt	Sun Sep 11 17:16:07 2005
+++ b/Documentation/sysctl/vm.txt	Wed Sep 14 23:59:15 2005
@@ -19,6 +19,7 @@
 - overcommit_memory
 - page-cluster
 - dirty_ratio
+- dirty_ratio_centisecs
 - dirty_background_ratio
 - dirty_expire_centisecs
 - dirty_writeback_centisecs
@@ -29,9 +30,10 @@
 
 ==============================================================
 
-dirty_ratio, dirty_background_ratio, dirty_expire_centisecs,
-dirty_writeback_centisecs, vfs_cache_pressure, laptop_mode,
-block_dump, swap_token_timeout:
+dirty_ratio, dirty_ratio_centisecs, dirty_background_ratio,
+dirty_expire_centisecs, dirty_writeback_centisecs,
+vfs_cache_pressure, laptop_mode, block_dump,
+swap_token_timeout:
 
 See Documentation/filesystems/proc.txt
 
diff -r 8b591846b274 fs/proc/base.c
--- a/fs/proc/base.c	Sun Sep 11 17:16:07 2005
+++ b/fs/proc/base.c	Wed Sep 14 23:59:15 2005
@@ -122,6 +122,7 @@
 #endif
 	PROC_TGID_OOM_SCORE,
 	PROC_TGID_OOM_ADJUST,
+	PROC_TGID_FUTURE_DIRTY,
 	PROC_TID_INO,
 	PROC_TID_STATUS,
 	PROC_TID_MEM,
@@ -160,6 +161,7 @@
 #endif
 	PROC_TID_OOM_SCORE,
 	PROC_TID_OOM_ADJUST,
+	PROC_TID_FUTURE_DIRTY,
 
 	/* Add new entries before this */
 	PROC_TID_FD_DIR = 0x8000,	/* 0x8000-0xffff */
@@ -210,6 +212,7 @@
 #endif
 	E(PROC_TGID_OOM_SCORE, "oom_score",S_IFREG|S_IRUGO),
 	E(PROC_TGID_OOM_ADJUST,"oom_adj", S_IFREG|S_IRUGO|S_IWUSR),
+	E(PROC_TGID_FUTURE_DIRTY,"future_dirty",S_IFREG|S_IRUGO),
 #ifdef CONFIG_AUDITSYSCALL
 	E(PROC_TGID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
@@ -250,6 +253,7 @@
 #endif
 	E(PROC_TID_OOM_SCORE,  "oom_score",S_IFREG|S_IRUGO),
 	E(PROC_TID_OOM_ADJUST, "oom_adj", S_IFREG|S_IRUGO|S_IWUSR),
+	E(PROC_TID_FUTURE_DIRTY,"future_dirty",S_IFREG|S_IRUGO),
 #ifdef CONFIG_AUDITSYSCALL
 	E(PROC_TID_LOGINUID, "loginuid", S_IFREG|S_IWUSR|S_IRUGO),
 #endif
@@ -463,6 +467,12 @@
 	do_posix_clock_monotonic_gettime(&uptime);
 	points = badness(task, uptime.tv_sec);
 	return sprintf(buffer, "%lu\n", points);
+}
+
+static int proc_future_dirty(struct task_struct *task, char *buffer)
+{
+	return sprintf(buffer, "%lu\n",
+		       task->balance_dirty_state.future_dirty);
 }
 
 /************************************************************************/
@@ -1664,6 +1674,11 @@
 		case PROC_TGID_OOM_ADJUST:
 			inode->i_fop = &proc_oom_adjust_operations;
 			break;
+		case PROC_TID_FUTURE_DIRTY:
+		case PROC_TGID_FUTURE_DIRTY:
+			inode->i_fop = &proc_info_file_operations;
+			ei->op.proc_read = proc_future_dirty;
+			break;
 #ifdef CONFIG_AUDITSYSCALL
 		case PROC_TID_LOGINUID:
 		case PROC_TGID_LOGINUID:
diff -r 8b591846b274 include/linux/sched.h
--- a/include/linux/sched.h	Sun Sep 11 17:16:07 2005
+++ b/include/linux/sched.h	Wed Sep 14 23:59:15 2005
@@ -573,6 +573,12 @@
 struct io_context;			/* See blkdev.h */
 void exit_io_context(void);
 struct cpuset;
+
+struct balance_dirty_state {
+	unsigned long future_dirty;
+	unsigned long last_sync; /* jiffies */
+	int rate_limit;
+};
 
 #define NGROUPS_SMALL		32
 #define NGROUPS_PER_BLOCK	((int)(PAGE_SIZE / sizeof(gid_t)))
@@ -766,6 +772,8 @@
 
 	unsigned long ptrace_message;
 	siginfo_t *last_siginfo; /* For ptrace use.  */
+
+	struct balance_dirty_state balance_dirty_state;
 /*
  * current io wait handle: wait queue entry to use for io waits
  * If this thread is processing aio, this points at the waitqueue
diff -r 8b591846b274 include/linux/sysctl.h
--- a/include/linux/sysctl.h	Sun Sep 11 17:16:07 2005
+++ b/include/linux/sysctl.h	Wed Sep 14 23:59:15 2005
@@ -180,6 +180,7 @@
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_DIRTY_RATIO_CS=29,	/* dirty_ratio_centisecs */
 };
 
 
diff -r 8b591846b274 include/linux/writeback.h
--- a/include/linux/writeback.h	Sun Sep 11 17:16:07 2005
+++ b/include/linux/writeback.h	Wed Sep 14 23:59:15 2005
@@ -93,6 +93,7 @@
 /* These are exported to sysctl. */
 extern int dirty_background_ratio;
 extern int vm_dirty_ratio;
+extern int vm_dirty_ratio_centisecs;
 extern int dirty_writeback_centisecs;
 extern int dirty_expire_centisecs;
 extern int block_dump;
diff -r 8b591846b274 kernel/sysctl.c
--- a/kernel/sysctl.c	Sun Sep 11 17:16:07 2005
+++ b/kernel/sysctl.c	Wed Sep 14 23:59:15 2005
@@ -725,6 +725,14 @@
 		.procname	= "dirty_expire_centisecs",
 		.data		= &dirty_expire_centisecs,
 		.maxlen		= sizeof(dirty_expire_centisecs),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= VM_DIRTY_RATIO_CS,
+		.procname	= "dirty_ratio_centisecs",
+		.data		= &vm_dirty_ratio_centisecs,
+		.maxlen		= sizeof(vm_dirty_ratio_centisecs),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
diff -r 8b591846b274 mm/page-writeback.c
--- a/mm/page-writeback.c	Sun Sep 11 17:16:07 2005
+++ b/mm/page-writeback.c	Wed Sep 14 23:59:15 2005
@@ -64,12 +64,17 @@
 /*
  * Start background writeback (via pdflush) at this percentage
  */
-int dirty_background_ratio = 10;
+int dirty_background_ratio = 30;
 
 /*
  * The generator of dirty data starts writeback at this percentage
  */
 int vm_dirty_ratio = 40;
+
+/*
+ * Throttle 5 sec before reaching the dirty_ratio.
+ */
+int vm_dirty_ratio_centisecs = 5 * 100;
 
 /*
  * The interval between `kupdate'-style writebacks, in centiseconds
@@ -187,7 +192,8 @@
  * If we're over `background_thresh' then pdflush is woken to perform some
  * writeout.
  */
-static void balance_dirty_pages(struct address_space *mapping)
+static void balance_dirty_pages(struct address_space *mapping,
+				unsigned long future_dirty)
 {
 	struct writeback_state wbs;
 	long nr_reclaimable;
@@ -209,10 +215,12 @@
 		get_dirty_limits(&wbs, &background_thresh,
 					&dirty_thresh, mapping);
 		nr_reclaimable = wbs.nr_dirty + wbs.nr_unstable;
-		if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh)
+		if (nr_reclaimable + wbs.nr_writeback + future_dirty <=
+		    dirty_thresh || !nr_reclaimable)
 			break;
 
-		dirty_exceeded = 1;
+		if (nr_reclaimable + wbs.nr_writeback > dirty_thresh)
+			dirty_exceeded = 1;
 
 		/* Note: nr_reclaimable denotes nr_dirty + nr_unstable.
 		 * Unstable writes are a feature of certain networked
@@ -225,7 +233,8 @@
 			get_dirty_limits(&wbs, &background_thresh,
 					&dirty_thresh, mapping);
 			nr_reclaimable = wbs.nr_dirty + wbs.nr_unstable;
-			if (nr_reclaimable + wbs.nr_writeback <= dirty_thresh)
+			if (nr_reclaimable + wbs.nr_writeback + future_dirty <=
+			    dirty_thresh || !nr_reclaimable)
 				break;
 			pages_written += write_chunk - wbc.nr_to_write;
 			if (pages_written >= write_chunk)
@@ -253,6 +262,46 @@
 		pdflush_operation(background_writeout, 0);
 }
 
+static int task_balance_dirty_pages(struct address_space *mapping) {
+	struct balance_dirty_state * state;
+	int need_balance_dirty;
+	unsigned long future_dirty;
+	int rate_limit;
+
+	need_balance_dirty = -1;
+	if (unlikely(!vm_dirty_ratio_centisecs))
+		goto out;
+	need_balance_dirty = 0;
+
+	state = &current->balance_dirty_state;
+	state->future_dirty++;
+
+	rate_limit = ratelimit_pages;
+	if (dirty_exceeded)
+		rate_limit = 8;
+
+	if (state->rate_limit++ > rate_limit) {
+		state->rate_limit = 0;
+		need_balance_dirty = 1;
+	}
+
+	future_dirty = state->future_dirty;
+
+	if (time_after(jiffies,
+		       state->last_sync+vm_dirty_ratio_centisecs*HZ/100)) {
+		state->future_dirty >>= 1;
+		state->last_sync = jiffies;
+		state->rate_limit = 0;
+		need_balance_dirty = 1;
+	}
+
+	if (need_balance_dirty)
+		balance_dirty_pages(mapping, future_dirty);
+
+ out:
+	return need_balance_dirty;
+}
+
 /**
  * balance_dirty_pages_ratelimited - balance dirty memory state
  * @mapping: address_space which was dirtied
@@ -270,6 +319,9 @@
 {
 	static DEFINE_PER_CPU(int, ratelimits) = 0;
 	long ratelimit;
+
+	if (task_balance_dirty_pages(mapping) >= 0)
+		return;
 
 	ratelimit = ratelimit_pages;
 	if (dirty_exceeded)
@@ -282,7 +334,7 @@
 	if (get_cpu_var(ratelimits)++ >= ratelimit) {
 		__get_cpu_var(ratelimits) = 0;
 		put_cpu_var(ratelimits);
-		balance_dirty_pages(mapping);
+		balance_dirty_pages(mapping, 0);
 		return;
 	}
 	put_cpu_var(ratelimits);
