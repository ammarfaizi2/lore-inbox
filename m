Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132318AbREHMdW>; Tue, 8 May 2001 08:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132392AbREHMdM>; Tue, 8 May 2001 08:33:12 -0400
Received: from www.wen-online.de ([212.223.88.39]:261 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S132318AbREHMdG>;
	Tue, 8 May 2001 08:33:06 -0400
Date: Tue, 8 May 2001 14:32:24 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        MOLNAR Ingo <mingo@chiara.elte.hu>
Subject: [PATCH] eliminate a truckload of context switches
Message-ID: <Pine.LNX.4.33.0105081355290.363-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

While running a ktrace enabled kernel (IKD), I noticed many useless
context switches.  The problem is that we continually pester kswapd/
kflushd at times when they can't do anything other than go back to
sleep.  As you'll see below, we do this quite a bit under heavy load.

Before:
user  :       0:08:02.33  58.7%  page in :   763148
nice  :       0:00:00.00   0.0%  page out:   569132
system:       0:02:39.83  19.4%  swap in :   125546
idle  :       0:02:59.73  21.9%  swap out:   133831
uptime:       0:13:41.88         context :   685149

After:
user  :       0:08:01.93  59.8%  page in :   768532
nice  :       0:00:00.00   0.0%  page out:   578009
system:       0:02:17.27  17.0%  swap in :   127100
idle  :       0:03:06.34  23.1%  swap out:   136101
uptime:       0:13:25.53         context :   391966

Instrumentation sample:
c0185cf0  submit_bh +<10/80> (0.34) pid(4)
c0185bb3  generic_make_request +<13/140> (0.32) pid(4)
c0184e03  blk_get_queue +<f/4c> (0.24) pid(4)
c01b2195  ide_get_queue +<d/38> (0.39) pid(4)
c0185527  __make_request +<13/68c> (0.54) pid(4)
c0186ac7  elevator_linus_merge +<13/130> (7.72) pid(4)
c0133977  __wait_on_buffer +<13/9c> (1.32) pid(4)
c01141c3  add_wait_queue +<f/38> (0.38) pid(4)
c011323b  schedule +<13/398> (4.66) pid(4->6)
...
c011323b  schedule +<13/398> (3.75) pid(381->4)
c01057e3  __switch_to +<13/cc> (2.66) pid(4)
c011323b  schedule +<13/398> (2.49) pid(4->426)
...
c011323b  schedule +<13/398> (4.97) pid(426->4)
c01057e3  __switch_to +<13/cc> (3.77) pid(4)
c011323b  schedule +<13/398> (1.76) pid(4->419)
...
c011323b  schedule +<13/398> (1.47) pid(400->4)
c01057e3  __switch_to +<13/cc> (0.66) pid(4)
c011323b  schedule +<13/398> (0.65) pid(4->400)
...
c011323b  schedule +<13/398> (1.46) pid(400->4)
c01057e3  __switch_to +<13/cc> (1.66) pid(4)
c011323b  schedule +<13/398> (0.73) pid(4->400)
...zzz


--- linux-2.4.4.ikd/mm/vmscan.c.org	Tue May  8 10:54:33 2001
+++ linux-2.4.4.ikd/mm/vmscan.c	Tue May  8 11:16:17 2001
@@ -964,7 +964,7 @@

 void wakeup_kswapd(void)
 {
-	if (current != kswapd_task)
+	if (waitqueue_active(&kswapd_wait))
 		wake_up_process(kswapd_task);
 }

--- linux-2.4.4.ikd/fs/buffer.c.org	Tue May  8 10:55:33 2001
+++ linux-2.4.4.ikd/fs/buffer.c	Tue May  8 11:15:22 2001
@@ -2578,16 +2578,16 @@
 	return flushed;
 }

+DECLARE_WAIT_QUEUE_HEAD(kflushd_wait);
 struct task_struct *bdflush_tsk = 0;

 void wakeup_bdflush(int block)
 {
-	if (current != bdflush_tsk) {
+	if (waitqueue_active(&kflushd_wait))
 		wake_up_process(bdflush_tsk);

-		if (block)
-			flush_dirty_buffers(0);
-	}
+	if (block)
+		flush_dirty_buffers(0);
 }

 /*
@@ -2711,14 +2711,10 @@
 		 * skip the sleep and flush some more. Otherwise, we
 		 * go to sleep waiting a wakeup.
 		 */
-		set_current_state(TASK_INTERRUPTIBLE);
 		if (!flushed || balance_dirty_state(NODEV) < 0) {
 			run_task_queue(&tq_disk);
-			schedule();
+			interruptible_sleep_on(&kflushd_wait);
 		}
-		/* Remember to mark us as running otherwise
-		   the next schedule will block. */
-		__set_current_state(TASK_RUNNING);
 	}
 }


