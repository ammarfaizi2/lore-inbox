Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289811AbSAKAn2>; Thu, 10 Jan 2002 19:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289812AbSAKAnT>; Thu, 10 Jan 2002 19:43:19 -0500
Received: from tomts11.bellnexxia.net ([209.226.175.55]:20640 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S289811AbSAKAnK>; Thu, 10 Jan 2002 19:43:10 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [patch] O(1) scheduler, -H4 - 2.4.17 problems
Date: Thu, 10 Jan 2002 19:43:04 -0500
X-Mailer: KMail [version 1.3.2]
Cc: mingo@elte.hu
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020111004305.99D2F6C3C6@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The H4 sceduler does not boot here.  The G1 version worked.  The H4 version gets
as far as:

PCI: Using IRQ router VIA [1106/0586] at 00:07.0
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket

and Stalls.  next messages are normally 

Starting kswapd
matroxfb: Matrox Millennium G400 MAX (AGP) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x26208)
matroxfb: framebuffer at 0xE8000000, mapped to 0xe0805000, size 33554432
Console: switching to colour frame buffer device 80x30

The rmap11 patch is also installed with the follow patch used to resolve the conflict.
I have been using this varient since E1.

Incase I messed up removing and repatch I tried from a clean kernel with the same results.
Any one else seeing this?

Box is K6-III 400.

Ed Tomlinson

--- linux/mm/page_alloc.c.rmap	Tue Jan  8 18:24:10 2002
+++ linux/mm/page_alloc.c	Tue Jan  8 18:25:00 2002
@@ -471,9 +471,7 @@
 		 * NFS: we must yield the CPU (to rpciod) to avoid deadlock.
 		 */
 		if (gfp_mask & __GFP_WAIT) {
-			__set_current_state(TASK_RUNNING);
-			current->policy |= SCHED_YIELD;
-			schedule();
+			yield();
 			if (!order || free_high(ALL_ZONES) >= 0) {
 				int progress = try_to_free_pages(gfp_mask);
 				if (progress || (gfp_mask & __GFP_FS))
--- linux/include/linux/sched.h.rmap	Tue Jan  8 18:28:15 2002
+++ linux/include/linux/sched.h	Tue Jan  8 18:33:36 2002
@@ -298,34 +298,50 @@
 
 	int lock_depth;		/* Lock depth */
 
-/*
- * offset 32 begins here on 32-bit platforms. We keep
- * all fields in a single cacheline that are needed for
- * the goodness() loop in schedule().
- */
-	long counter;
-	long nice;
-	unsigned long policy;
-	struct mm_struct *mm;
-	int processor;
 	/*
-	 * cpus_runnable is ~0 if the process is not running on any
-	 * CPU. It's (1 << cpu) if it's running on a CPU. This mask
-	 * is updated under the runqueue lock.
-	 *
-	 * To determine whether a process might run on a CPU, this
-	 * mask is AND-ed with cpus_allowed.
+         * offset 32 begins here on 32-bit platforms.
 	 */
-	unsigned long cpus_runnable, cpus_allowed;
+        unsigned int cpu;
+        int prio;
+        long __nice;
+        list_t run_list;
+        prio_array_t *array;
+ 
+        unsigned int time_slice;
+        unsigned long sleep_timestamp, run_timestamp;
+
 	/*
-	 * (only the 'next' pointer fits into the cacheline, but
-	 * that's just fine.)
+         * A task's four 'sleep history' entries.
+         *
+         * We track the last 4 seconds of time. (including the current second).
+         *
+         * A value of '0' means it has spent no time sleeping in that
+         * particular past second. The maximum value of 'HZ' means that
+         * the task spent all its time running in that particular second.
+         *
+         * 'hist_idx' points to the current second, which, unlike the other
+         * 3 entries, is only partially complete. This means that a value of
+         * '25' does not mean the task slept 25% of the time in the current
+         * second, it means that it spent 25 timer ticks sleeping in the
+         * current second.
+         *
+         * All this might look a bit complex, but it can be maintained very
+         * small overhead and it gives very good statistics, based on which
+         * the scheduler can decide whether a task is 'interactive' or a
+         * 'CPU hog'. See sched.c for more details.
 	 */
-	struct list_head run_list;
-	unsigned long sleep_time;
+        #define SLEEP_HIST_SIZE 4
+ 
+        int hist_idx;
+        int hist[SLEEP_HIST_SIZE];
+ 
+        unsigned long policy;
+        unsigned long cpus_allowed;
 
 	struct task_struct *next_task, *prev_task;
-	struct mm_struct *active_mm;
+ 
+        struct mm_struct *mm, *active_mm;
+        struct list_head local_pages;
 
 /* task state */
 	struct linux_binfmt *binfmt;



