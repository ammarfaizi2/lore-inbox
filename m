Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288479AbSADD4t>; Thu, 3 Jan 2002 22:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288480AbSADD4k>; Thu, 3 Jan 2002 22:56:40 -0500
Received: from tomts10.bellnexxia.net ([209.226.175.54]:19606 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S288479AbSADD4a>; Thu, 3 Jan 2002 22:56:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
Date: Thu, 3 Jan 2002 22:56:14 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020104035615.6BB33BAFE1@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Building against 2.4.17 (with rmap-10c applied) I get:

loop.c: In function `loop_thread':
loop.c:574: structure has no member named `nice'
make[2]: *** [loop.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/block'
make[1]: *** [_modsubdir_block] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2

and

md.c: in function `md_thread':
md.c:2934: structure has no member named `nice'
md.c: In function `md_do_sync_Rdc586d8a':
md.c:3387: structure has no member named `nice'
md.c:3466: structure has no member named `nice'
md.c:3475: structure has no member named `nice'
make[2]: *** [md.o] Error 1
make[2]: Leaving directory `/usr/src/linux/drivers/md'
make[1]: *** [_modsubdir_md] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_mod_drivers] Error 2

Changing nice to __nice lets the compile work.  Is this correct?

When installing modules I get:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.17rmap10c+O1A0; fi
depmod: *** Unresolved symbols in /lib/modules/2.4.17rmap10c+O1A0/kernel/fs/jbd/jbd.o
depmod:         sys_sched_yield
depmod: *** Unresolved symbols in /lib/modules/2.4.17rmap10c+O1A0/kernel/fs/nfs/nfs.o
depmod:         sys_sched_yield
depmod: *** Unresolved symbols in /lib/modules/2.4.17rmap10c+O1A0/kernel/net/sunrpc/sunrpc.o
depmod:         sys_sched_yield

What needs to be done to fix these symbols?

I used the following correction to fix the rejects in A0 caused 
by rmap...

TIA,

Ed Tomlinson

--- x/include/linux/sched.h.orig	Thu Jan  3 21:23:48 2002
+++ x/include/linux/sched.h	Thu Jan  3 21:32:39 2002
@@ -295,34 +295,28 @@
 
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
-	/*
-	 * cpus_runnable is ~0 if the process is not running on any
-	 * CPU. It's (1 << cpu) if it's running on a CPU. This mask
-	 * is updated under the runqueue lock.
-	 *
-	 * To determine whether a process might run on a CPU, this
-	 * mask is AND-ed with cpus_allowed.
-	 */
-	unsigned long cpus_runnable, cpus_allowed;
 	/*
-	 * (only the 'next' pointer fits into the cacheline, but
-	 * that's just fine.)
+	 * offset 32 begins here on 32-bit platforms.
 	 */
-	struct list_head run_list;
-	unsigned long sleep_time;
+	unsigned int cpu;
+	int prio;
+	long __nice;
+	list_t run_list;
+	prio_array_t *array;
+
+	unsigned int time_slice;
+	unsigned long sleep_timestamp, run_timestamp;
+
+	#define SLEEP_HIST_SIZE 4
+	int sleep_hist[SLEEP_HIST_SIZE];
+	int sleep_idx;
+
+	unsigned long policy;
+	unsigned long cpus_allowed;
 
 	struct task_struct *next_task, *prev_task;
-	struct mm_struct *active_mm;
+
+	struct mm_struct *mm, *active_mm;
 
 /* task state */
 	struct linux_binfmt *binfmt;
--- x/mm/page_alloc.c.orig	Thu Jan  3 21:20:57 2002
+++ x/mm/page_alloc.c	Thu Jan  3 21:21:57 2002
@@ -465,9 +465,7 @@
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
