Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130315AbRABI6u>; Tue, 2 Jan 2001 03:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130272AbRABI6l>; Tue, 2 Jan 2001 03:58:41 -0500
Received: from www.wen-online.de ([212.223.88.39]:17674 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129904AbRABI6c>;
	Tue, 2 Jan 2001 03:58:32 -0500
Date: Tue, 2 Jan 2001 09:27:43 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>
Subject: scheduling problem?
Message-ID: <Pine.Linu.4.10.10101020857530.1024-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am seeing (what I believe is;) severe process CPU starvation in
2.4.0-prerelease.  At first, I attributed it to semaphore troubles
as when I enable semaphore deadlock detection in IKD and set it to
5 seconds, it triggers 100% of the time on nscd when I do sequential
I/O (iozone eg).  In the meantime, I've done a slew of tracing, and
I think the holder of the semaphore I'm timing out on just flat isn't
being scheduled so it can release it.  In the usual case of nscd, I
_think_ it's another nscd holding the semaphore.  In no trace can I
go back far enough to catch the taker of the semaphore or any user
task other than iozone running between __down() time and timeout 5
seconds later.  (trace buffer covers ~8 seconds of kernel time)

I think the snippet below captures the gist of the problem.

c012f32e  nr_free_pages +<e/4c> (0.16) pid(256)
c012f37a  nr_inactive_clean_pages +<e/44> (0.22) pid(256)
c01377f2  wakeup_bdflush +<12/a0> (0.14) pid(256)
c011620a  wake_up_process +<e/58> (0.29) pid(256)
c012eea4  __alloc_pages_limit +<10/b8> (0.28) pid(256)
c012eea4  __alloc_pages_limit +<10/b8> (0.30) pid(256)
c012e3fa  wakeup_kswapd +<12/d4> (0.25) pid(256)
c0115613  __wake_up +<13/130> (0.41) pid(256)
c011527b  schedule +<13/398> (0.66) pid(256->6)
c01077db  __switch_to +<13/d0> (0.70) pid(6)
c01893c6  generic_unplug_device +<e/38> (0.25) pid(6)
c011527b  schedule +<13/398> (0.50) pid(6->256)
c01077db  __switch_to +<13/d0> (0.29) pid(256)
c012eea4  __alloc_pages_limit +<10/b8> (0.22) pid(256)
c012d267  reclaim_page +<13/408> (0.54) pid(256)
c012679e  __remove_inode_page +<e/74> (0.54) pid(256)
c0126fe0  add_to_page_cache_unique +<10/e4> (0.23) pid(256)
c0126751  add_page_to_hash_queue +<d/4c> (0.16) pid(256)
c012c9fa  lru_cache_add +<e/f4> (0.29) pid(256)
c0153ac5  ext2_prepare_write +<d/28> (0.15) pid(256)
c013697f  block_prepare_write +<f/4c> (0.15) pid(256)
c0136233  __block_prepare_write +<13/214> (0.17) pid(256)
c0135fd4  create_empty_buffers +<10/7c> (0.17) pid(256)
c0135d13  create_buffers +<13/1bc> (0.14) pid(256)
(repeats zillion times)

Despite wakeup_kswapd(0), we never schedule kswapd until much
later when we hit a wakeup_kswapd(1).. in the interrum, we
bounce back and forth betweem bdflush and iozone.. no other
task is scheduled through very many schedules.
(Per kdb, I had a few tasks which would have liked some CPU ;-)

In addition, kswapd is quite the CPU piggie when it's doing
page_launder() as this profiled snippet of one of kswapd's
running periods shows.  (60ms with no schedule)

  0.1093%          66.06       11.01        6 c010d9c2 timer_interrupt
  0.1462%          88.39        0.28      313 c0134ea2 __remove_from_lru_list
  0.1489%          90.02       11.25        8 c01b2077 do_rw_disk
  0.1599%          96.66       32.22        3 c018a9e7 elevator_linus_merge
  0.1624%          98.18        0.30      325 c0115613 __wake_up
  0.2016%         121.88        0.42      290 c012c01f kmem_cache_free
  0.2075%         125.43        0.66      189 c0189f1d end_buffer_io_sync
  0.2089%         126.32       15.79        8 c01ad533 ide_build_sglist
 34.8258%       21054.55        0.53    39486 c0137667 try_to_free_buffers
 62.4743%       37769.90        0.95    39796 c012f2b9 __free_pages
Total entries: 81970  Total usecs:     60456.69 Idle: 0.00%

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
