Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274182AbRIXV6s>; Mon, 24 Sep 2001 17:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274165AbRIXV6i>; Mon, 24 Sep 2001 17:58:38 -0400
Received: from paloma12.e0k.nbg-hannover.de ([62.159.219.12]:9180 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S274182AbRIXV6S>; Mon, 24 Sep 2001 17:58:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Date: Mon, 24 Sep 2001 23:58:34 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>,
        Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>,
        Roger Larsson <roger.larsson@norran.net>,
        george anzinger <george@mvista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010924215825Z274182-761+12384@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, September 24, 2001 14:46:09 PM -0400 Chris Mason wrote:
> On Monday, September 24, 2001 10:09:59 PM +0800 Beau Kuiper
> <kuib-kl@ljbc.wa.edu.au> wrote:
>
> > Hi all again,
> > 
> > I have updated my last set of patches for reiserfs to run on the 2.4.10 
> > kernel.
> > 
> > The new set of patches create a new method to do kupdated syncs. On 
> > filesystems that do no support this new method, the regular write_super 
> > method is used. Then reiserfs on kupdated super_sync, simply calls the 
> > flush_old_commits code with immediate mode off. 
> > 
>
> Ok, I think the patch is missing ;-)

That's what I've found first, too :-)))

> What we need to do now is look more closely at why the performance
> increases.

I can't second that.

First let me tell you that _all_ of my previously posted benchmarks are 
recorded _WITHOUT_ write caching.
Even if my IBM DDSY-T18350N 18 GB U160 10k disk has 4 MB cache (8 and 16 MB 
versions are available, too) it is NOT enabled per default (firmware and 
Linux SCSI driver).

Do you know of a Linux SCSI tool to enable it for testing purposes?
I know it _IS_ unsave for server (journaling) systems.

Below are my numbers for 2.4.10-preempt plus some little additional patches 
and your latest patch.

Greetings,
	Dieter

*************************************************************

inode.c-schedule.patch (Andrea, me)
APPLIED
Could be the culprit for my "slow" block IO with bonnie++
But better preempting. Really?

--- linux/fs/inode.c    Mon Sep 24 00:31:58 2001
+++ linux-2.4.10-preempt/fs/inode.c     Mon Sep 24 01:07:06 2001
@@ -17,6 +17,7 @@
 #include <linux/swapctl.h>
 #include <linux/prefetch.h>
 #include <linux/locks.h>
+#include <linux/compiler.h>

 /*
  * New inode.c implementation.
@@ -296,6 +297,12 @@
                         * so we have to start looking from the list head.
                         */
                        tmp = head;
+
+                        if (unlikely(current->need_resched)) {
+                                spin_unlock(&inode_lock);
+                                schedule();
+                                spin_lock(&inode_lock);
+                        }
                }
        }

journal.c-1-patch (Chris)
APPLIED
Do we need this really?
Shouldn't hurt? -- As Chris told me.

--- linux/fs/reiserfs/journal.c Sat Sep  8 08:05:32 2001
+++ linux/fs/reiserfs/journal.c Thu Sep 20 13:15:04 2001
@@ -2872,17 +2872,12 @@
   /* write any buffers that must hit disk before this commit is done */
   fsync_inode_buffers(&(SB_JOURNAL(p_s_sb)->j_dummy_inode)) ;

-  /* honor the flush and async wishes from the caller */
+  /* honor the flush wishes from the caller, simple commits can
+  ** be done outside the journal lock, they are done below
+  */
   if (flush) {
-
     flush_commit_list(p_s_sb, SB_JOURNAL_LIST(p_s_sb) + orig_jindex, 1) ;
     flush_journal_list(p_s_sb,  SB_JOURNAL_LIST(p_s_sb) + orig_jindex , 1) ;
-  } else if (commit_now) {
-    if (wait_on_commit) {
-      flush_commit_list(p_s_sb, SB_JOURNAL_LIST(p_s_sb) + orig_jindex, 1) ;
-    } else {
-      commit_flush_async(p_s_sb, orig_jindex) ;
-    }
   }

   /* reset journal values for the next transaction */
@@ -2944,6 +2939,16 @@
   atomic_set(&(SB_JOURNAL(p_s_sb)->j_jlock), 0) ;
   /* wake up any body waiting to join. */
   wake_up(&(SB_JOURNAL(p_s_sb)->j_join_wait)) ;
+
+  if (!flush && commit_now) {
+    if (current->need_resched)
+      schedule() ;
+    if (wait_on_commit) {
+      flush_commit_list(p_s_sb, SB_JOURNAL_LIST(p_s_sb) + orig_jindex, 1) ;
+    } else {
+      commit_flush_async(p_s_sb, orig_jindex) ;
+    }
+  }
   return 0 ;
 }

vmalloc.c-patch (Andrea)
NOT APPLIED
Do we need it?

--- linux/mm/vmalloc.c.~1~     Thu Sep 20 01:44:20 2001
+++ linux/mm/vmalloc.c Fri Sep 21 00:40:48 2001
@@ -144,6 +144,7 @@
        int ret;

        dir = pgd_offset_k(address);
+       flush_cache_all();
        spin_lock(&init_mm.page_table_lock);
        do {
                pmd_t *pmd;

*************************************************************

2.4.10+
patch-rml-2.4.10-preempt-kernel-1+
patch-rml-2.4.10-preempt-ptrace-and-jobs-fix+
patch-rml-2.4.10-preempt-stats-1+
inode.c-schedule.patch+
journal.c-1-patch

32 clients started
.....................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................++............................................+.......+++..+....+++..+...+.....+.++...+.++++.+++.++++++.+++********************************
Throughput 38.6878 MB/sec (NB=48.3597 MB/sec  386.878 MBit/sec)
14.200u 54.940s 1:50.21 62.7%   0+0k 0+0io 911pf+0w
max load: 1777

Version 1.92a       ------Sequential Output------ --Sequential Input- 
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec 
%CP
SunWave1      1248M    79  97 16034  21  5719   6   147  98 22904  16 269.0   
4
Latency               138ms    2546ms     201ms   97838us   58940us    3207ms
Version 1.92a       ------Sequential Create------ --------Random 
Create--------
SunWave1            -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec 
%CP
                 16  6121  75 +++++ +++ 12753  95  8422  80 +++++ +++ 11152  
95
Latency             26126us   11425us   11879us    5325us   12082us   13025us
1.92a,1.92a,SunWave1,1001286857,1248M,79,97,16034,21,5719,6,147,98,22904,16,269.0,4,16,,,,,6121,75,+++++,+++,12753,95,8422,80,+++++,+++,11152,95,138ms,2546ms,201ms,97838us,58940us,3207ms,26126us,11425us,11879us,5325us,12082us,13025us

After running VTK (VIS app) I get this:

Worst 20 latency times of 1648 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
  7239  spin_lock        1   381/memory.c        c012808f   402/memory.c
   321        BKL        0  2754/buffer.c        c01415ba   697/sched.c
   312        BKL        0   359/buffer.c        c013d6dc  1381/sched.c
   280        BKL        0   359/buffer.c        c013d6dc  1380/sched.c
   252   reacqBKL        0  1375/sched.c         c0115334  1381/sched.c
   232  spin_lock        0   547/sched.c         c0113574   697/sched.c
   215       eth1        0   585/irq.c           c01089af   647/irq.c
   164        BKL        0   452/exit.c          c011b4d1   681/tty_io.c
   119        BKL        0  1437/namei.c         c014cabf   697/sched.c
   105        BKL        0   452/exit.c          c011b4d1   697/sched.c
   101        BKL        5   712/tty_io.c        c01a6edb   714/tty_io.c
   100        BKL        0   452/exit.c          c011b4d1  1380/sched.c
    99    unknown        1    76/softirq.c       c011cba4   119/softirq.c
    92  spin_lock        4   468/netfilter.c     c01fe263   119/softirq.c
    79        BKL        0    42/file.c          c01714b0    63/file.c
    72        BKL        0   752/namei.c         c014b73f   697/sched.c
    71        BKL        0   533/inode.c         c016e0ad  1381/sched.c
    71        BKL        0    30/inode.c         c016d531    52/inode.c
    68        BKL        0   452/exit.c          c011b4d1  1381/sched.c
    66        BKL        0   927/namei.c         c014b94f   929/namei.c

Adhoc c012808e <zap_page_range+5e/260>

Do we need Rik's patch?

****************************************************************************

2.4.10+
patch-rml-2.4.10-preempt-kernel-1+
patch-rml-2.4.10-preempt-ptrace-and-jobs-fix+
patch-rml-2.4.10-preempt-stats-1+
inode.c-schedule.patch+
journal.c-1-patch+
kupdated-patch

32 clients started
...............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+..........................................+.................+...........++.....................++.....++......+......+++++...++++++++.+++++++.++********************************
Throughput 38.9015 MB/sec (NB=48.6269 MB/sec  389.015 MBit/sec)
15.140u 60.640s 1:49.66 69.1%   0+0k 0+0io 911pf+0w
max load: 1654

Version 1.92a       ------Sequential Output------ --Sequential Input- 
--Random-
                    -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- 
--Seeks--
Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec 
%CP
SunWave1      1248M    84  99 16348  21  5746   6   142  99 23411  17 265.9   
4
Latency               130ms    1868ms     192ms   88459us   54625us    3367ms
Version 1.92a       ------Sequential Create------ --------Random 
Create--------
SunWave1            -Create-- --Read--- -Delete-- -Create-- --Read--- 
-Delete--
              files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec 
%CP
                 16  4941  65 +++++ +++ 12916  96  6847  76 +++++ +++ 10785  
94
Latency              8468us   11334us   11736us    8520us   12205us   12856us
1.92a,1.92a,SunWave1,1001358471,1248M,84,99,16348,21,5746,6,142,99,23411,17,265.9,4,16,,,,,4941,65,+++++,+++,12916,96,6847,76,+++++,+++,10785,94,130ms,1868ms,192ms,88459us,54625us,3367ms,8468us,11334us,11736us,8520us,12205us,12856us

Dbench run during MP3 playback:
32 clients started
.................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................+.........+.........................................+.+.....+...............+...........................................................................+...................++...........+.+.......+..++++.++.+.++.++++++.+++++********************************
Throughput 34.7025 MB/sec (NB=43.3782 MB/sec  347.025 MBit/sec)
15.290u 63.820s 2:02.74 64.4%   0+0k 0+0io 911pf+0w

Worst 20 latency times of 16578 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
 26795  spin_lock        1   291/buffer.c        c0141a2c   280/buffer.c
 17330  spin_lock        1   341/vmscan.c        c0133f0a   402/vmscan.c
 12925  spin_lock        1   439/vmscan.c        c0133ea5   338/vmscan.c
 11923  spin_lock        1   291/buffer.c        c0141a2c   285/buffer.c
  7253        BKL        0  1302/inode.c         c016faa9  1381/sched.c
  7117        BKL        1  1302/inode.c         c016faa9   697/sched.c
  6097        BKL        0  1302/inode.c         c016faa9  1380/sched.c
  6000        BKL        1   533/inode.c         c016e11d   697/sched.c
  4870   reacqBKL        1  1375/sched.c         c0115334   929/namei.c
  4015  spin_lock        0   439/vmscan.c        c0133ea5   402/vmscan.c
  2075        BKL        1   452/exit.c          c011b4d1   697/sched.c
  2029  spin_lock        1   547/sched.c         c0113574   697/sched.c
  2010        BKL        0  1302/inode.c         c016faa9   842/inode.c
  1730        BKL        0  2754/buffer.c        c01415ba  2757/buffer.c
  1668        BKL        1  2754/buffer.c        c01415ba   697/sched.c
  1574  spin_lock        0   483/dcache.c        c01545da   520/dcache.c
  1416  spin_lock        0  1376/sched.c         c0115353  1380/sched.c
  1396  spin_lock        1  1376/sched.c         c0115353   697/sched.c
  1387    aic7xxx        1    76/softirq.c       c011cba4   119/softirq.c
  1341        BKL        1   533/inode.c         c016e11d   842/inode.c

Adhoc c0141a2c <kupdate+11c/210>
Adhoc c0133f0a <shrink_cache+37a/5b0>
Adhoc c0133ea4 <shrink_cache+314/5b0>
Adhoc c0141a2c <kupdate+11c/210>
Adhoc c016faa8 <reiserfs_dirty_inode+58/f0>
Adhoc c016faa8 <reiserfs_dirty_inode+58/f0>
Adhoc c016faa8 <reiserfs_dirty_inode+58/f0>
Adhoc c016e11c <reiserfs_get_block+9c/f30>
Adhoc c0115334 <preempt_schedule+34/b0>
Adhoc c0133ea4 <shrink_cache+314/5b0>
Adhoc c011b4d0 <do_exit+130/360>
Adhoc c0113574 <schedule+34/550>
Adhoc c016faa8 <reiserfs_dirty_inode+58/f0>
Adhoc c01415ba <sync_old_buffers+2a/130>
Adhoc c01415ba <sync_old_buffers+2a/130>
Adhoc c01545da <select_parent+3a/100>
Adhoc c0115352 <preempt_schedule+52/b0>
Adhoc c0115352 <preempt_schedule+52/b0>
Adhoc c011cba4 <do_softirq+34/150>
Adhoc c016e11c <reiserfs_get_block+9c/f30>

Redo after some seconds:

Worst 20 latency times of 1944 measured in this period.
  usec      cause     mask   start line/file      address   end line/file
  2028        BKL        1  1302/inode.c         c016faa9   697/sched.c
   584        BKL        0  1302/inode.c         c016faa9  1306/inode.c
   572  spin_lock        0  1376/sched.c         c0115353  1380/sched.c
   415        BKL        0  1302/inode.c         c016faa9  1381/sched.c
   356        BKL        0  2754/buffer.c        c01415ba  2757/buffer.c
   353        BKL        0  2754/buffer.c        c01415ba   697/sched.c
   328        BKL        0  2754/buffer.c        c01415ba  1381/sched.c
   278  spin_lock        0   381/memory.c        c012808f   402/memory.c
   274   reacqBKL        0  1375/sched.c         c0115334  1381/sched.c
   245  spin_lock        0   547/sched.c         c0113574   697/sched.c
   208       eth1        0   585/irq.c           c01089af   647/irq.c
   188        BKL        1   301/namei.c         c014a4b1   697/sched.c
   176        BKL        1   927/namei.c         c014b9bf   929/namei.c
   161        BKL        0   301/namei.c         c014a4b1  1380/sched.c
   154        BKL        0   533/inode.c         c016e11d   842/inode.c
   147        BKL        6   712/tty_io.c        c01a6f6b   714/tty_io.c
   141        BKL        0   301/namei.c         c014a4b1  1381/sched.c
   141        BKL        0    30/inode.c         c016d5a1    52/inode.c
   126   reacqBKL        0  1375/sched.c         c0115334  2757/buffer.c
   121   reacqBKL        0  1375/sched.c         c0115334   929/namei.c

Adhoc c016faa8 <reiserfs_dirty_inode+58/f0>
Adhoc c016faa8 <reiserfs_dirty_inode+58/f0>
Adhoc c0115352 <preempt_schedule+52/b0>
Adhoc c016faa8 <reiserfs_dirty_inode+58/f0>
Adhoc c01415ba <sync_old_buffers+2a/130>
Adhoc c01415ba <sync_old_buffers+2a/130>
Adhoc c01415ba <sync_old_buffers+2a/130>
Adhoc c012808e <zap_page_range+5e/260>
Adhoc c0115334 <preempt_schedule+34/b0>
Adhoc c0113574 <schedule+34/550>
Adhoc c01089ae <do_IRQ+3e/1d0>
Adhoc c014a4b0 <real_lookup+70/150>
Adhoc c014b9be <vfs_create+ae/150>
Adhoc c014a4b0 <real_lookup+70/150>
Adhoc c016e11c <reiserfs_get_block+9c/f30>
Adhoc c01a6f6a <tty_write+21a/2f0>
Adhoc c014a4b0 <real_lookup+70/150>
Adhoc c016d5a0 <reiserfs_delete_inode+30/110>
Adhoc c0115334 <preempt_schedule+34/b0>
Adhoc c0115334 <preempt_schedule+34/b0>
