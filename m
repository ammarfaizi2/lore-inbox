Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317309AbSGIGVb>; Tue, 9 Jul 2002 02:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317312AbSGIGVa>; Tue, 9 Jul 2002 02:21:30 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:1188 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317309AbSGIGV3>;
	Tue, 9 Jul 2002 02:21:29 -0400
Message-ID: <3D2A8152.7040200@us.ibm.com>
Date: Mon, 08 Jul 2002 23:23:14 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: readprofile from 2.5.25 web server benchmark
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox and I were talking about spin-then-sleep semaphores the 
last few days and I asked for a workload that uses a lot of semaphores 
to cause a lot of schedule()s.  I think I found one:

Here's a quick readprofile during a Specweb99 run.  Note, this is a 
completely "stupid" run.  I have done _no_ tuning and applied _no_ 
patches to the stock 2.5.25.  I'm using Apache 2.0, without Tux, but 
with mod_specweb99 on an 8xPIII-700-1MB with 18GB of RAM (no you can't 
have one).  I probably shouldn't state how many connections I'm 
attempting, but it's more than 1 and less than a million :)

       1 copy_files                                 0.0014
       1 do_fork                                    0.0005
       1 dup_task_struct                            0.0089
       1 error_code                                 0.0167
       1 flush_tlb_all                              0.0078
       1 flush_tlb_page                             0.0089
       1 __global_cli                               0.0027
       1 init_bh                                    0.0312
       1 sys_getgid                                 0.0625
       1 sys_ipc                                    0.0016
       2 alloc_ldt                                  0.0054
       2 copy_mm                                    0.0026
       2 init_new_context                           0.0074
       2 ksoftirqd                                  0.0074
       2 sys_rt_sigprocmask                         0.0037
       2 tqueue_bh                                  0.0625
       2 try_to_wake_up                             0.0039
       3 cpu_idle                                   0.0268
       3 sys_getpid                                 0.1875
       6 __write_lock_failed                        0.1875
       7 pgd_alloc                                  0.0312
       7 resume_userspace                           0.4375
       8 sys_getppid                                0.1667
      10 ret_from_intr                              0.6250
      10 smp_call_function                          0.0284
      11 __wake_up_sync                             0.0625
      12 __run_task_queue                           0.1071
      12 __up_wakeup                                1.0000
      13 pte_alloc_one                              0.0739
      13 will_become_orphaned_pgrp                  0.1016
      14 add_wait_queue                             0.2917
      14 __down_failed_interruptible                1.1667
      15 __up                                       0.4688
      18 __down_failed                              1.5000
      18 .text.lock.fault                           0.1295
      21 __tasklet_schedule                         0.1875
      22 exit_notify                                0.0275
      28 session_of_pgrp                            0.2188
      31 syscall_call                               2.8182
      32 __down_interruptible                       0.1250
      38 sys_time                                   0.4750
      45 del_timer                                  0.5625
      50 bh_action                                  0.3906
      57 tasklet_hi_action                          0.2969
      65 sys_wait4                                  0.0616
      88 sys_mmap2                                  0.5500
      94 tasklet_action                             0.4896
     127 .text.lock.sched                           0.2433
     135 syscall_exit                              12.2727
     141 schedule_timeout                           0.8812
     204 sys_gettimeofday                           1.2750
     350 __down                                     1.6827
     399 flush_tlb_mm                               3.5625
     507 remove_wait_queue                          7.9219
     558 add_wait_queue_exclusive                  11.6250
     562 do_page_fault                              0.4166
     672 add_timer                                  3.0000
     777 del_timer_sync                             4.8563
     850 handle_IRQ_event                           5.9028
     902 timer_bh                                   1.2812
    1489 system_call                               33.8409
    1574 default_idle                              24.5938
    2594 do_softirq                                12.4712
    5222 do_gettimeofday                           36.2639
    5767 __wake_up                                 51.4911
    5822 mod_timer                                 24.2583
    5850 schedule                                   6.3039
   35291 total                                      0.2881

Notice the large number of calls to down().  We're hitting a lot of
semaphores which are probably causing a big chunk of the scheduling. 
I also Matthew's nemisis, the bottom half.

we (IBM LTC) have fixes for this: (John Stultz)
    5222 do_gettimeofday                          36.2639

and some which help this too: (akpm's smptimers and some smart 
updating logic)
    5822 mod_timer                                 24.2583

-- 
Dave Hansen
haveblue@us.ibm.com


