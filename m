Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129677AbRBOSue>; Thu, 15 Feb 2001 13:50:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129662AbRBOSuY>; Thu, 15 Feb 2001 13:50:24 -0500
Received: from gateway.sequent.com ([192.148.1.10]:60046 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S129677AbRBOSuK>; Thu, 15 Feb 2001 13:50:10 -0500
Date: Thu, 15 Feb 2001 10:46:56 -0800
From: Jonathan Lahr <lahr@sequent.com>
To: linux-kernel@vger.kernel.org
Subject: kernel lock contention and scalability
Message-ID: <20010215104656.A6856@w-lahr.des.sequent.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


To discover possible locking limitations to scalability, I have collected 
locking statistics on a 2-way, 4-way, and 8-way performing as networked
database servers.  I patched the [48]-way kernels with Kravetz's multiqueue 
patch in the hope that mitigating runqueue_lock contention might better 
reveal other lock contention.

In the attached document, I describe my test environment and excerpt
lockstat output to show the more contentious locks for a typical run on 
each of my server configurations.  I'm interested in comparing these data 
to other lock contention data, so information regarding previous or ongoing 
lock contention work would be appreciated.  I'm aware of timer scalability 
work ongoing at people.redhat.com/mingo/scalable-timers, but is anyone 
working on reducing sem_ids contention?

--
Jonathan Lahr
IBM Linux Technology Center
Beaverton, Oregon
lahr@us.ibm.com
503-578-3385


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="note.att"


server configuration:
  hardware:
    memory:
      2-way:  .5 Gb
      4-way:  1 Gb
      8-way:  1 Gb
    cpus:
      2-way:  Pentium II, 300 MHz
      [48]-way:  Pentium III, 700 MHz
    NICs:  100 Mbps ethernet (2)
  software:
    distribution:  Redhat 7.0
    kernel:  
      2-way:  2.4.0-test10 patched with lockmeter1.4.5-2.4.0 
      [48]-way:  2.4.0 patched with lockmeter1.4.5-2.4.0, 2.4.0.MQ1-sched.rt
    database:  postgresql-7.0.2-17
    client:  pgbench (distributed with postgresql)

lockstat excerpts:

  2way:

    SPINLOCKS             HOLD              WAIT
       UTIL     CON    MEAN (   MAX  )   MEAN (   MAX  )      TOTAL     NOWAIT       SPIN REJECT  NAME
    
       4.04%   1.22%    50us(  3344us)   5.2us(  2014us)      36515      36068        447      0  kernel_flag
       0.01%   3.47%    46us(   427us)    17us(  2014us)        144        139          5      0    do_coredump+0x24
       0.00%   0.00%   960us(   960us)     0us                    1          1          0      0    do_exit+0x94
       0.00%   4.00%   2.0us(   4.2us)    75us(  1876us)         25         24          1      0    ext2_discard_prealloc+0x24
       0.03%   0.70%    11us(  1048us)   1.3us(   682us)       1144       1136          8      0    ext2_get_block+0x50
       1.78%   0.79%   455us(  3344us)   0.8us(   759us)       1766       1752         14      0    ext2_sync_file+0x28
       0.62%   0.84%    12us(  1289us)   2.5us(  1717us)      23353      23157        196      0    real_lookup+0x68
       1.46%   1.29%   186us(  2980us)   5.4us(  1824us)       3553       3507         46      0    schedule+0x490
       0.01%   0.00%   456us(   596us)     0us                    9          9          0      0    sync_old_buffers+0x20
       0.01%   1.83%   9.4us(    84us)   0.7us(    92us)        328        322          6      0    sys_fcntl64+0x44
       0.00%   3.87%   8.0us(   329us)   6.7us(  1011us)        155        149          6      0    sys_ioctl+0x48
       0.02%   2.79%   1.9us(   805us)    19us(  1986us)       5483       5330        153      0    sys_lseek+0x70
       0.00%   0.00%    22us(    22us)     0us                    1          1          0      0    sys_sysctl+0x50
       0.01%   3.23%    17us(    84us)   0.5us(    25us)        155        150          5      0    tty_read+0xbc
       0.02%   2.35%    39us(   110us)   0.2us(    11us)        213        208          5      0    tty_write+0x1dc
       0.07%   1.09%   168us(  1442us)   0.7us(   116us)        184        182          2      0    vfs_readdir+0x70
       0.00%   0.00%    31us(    31us)     0us                    1          1          0      0    vfs_statfs+0x54
    
      24.38%  23.93%    15us(   218us)   4.3us(   111us)     744475     566289     178186      0  runqueue_lock
       0.06%  15.97%   4.5us(    26us)   2.6us(    67us)       5592       4699        893      0    __wake_up+0xdc
       0.00%  10.27%   0.4us(   1.3us)   1.5us(    60us)        146        131         15      0    deliver_signal+0x58
       1.16%   8.59%   1.5us(    27us)   2.3us(   111us)     360313     329373      30940      0    process_timeout+0x14
       0.00%   0.00%   0.6us(   0.6us)     0us                    1          1          0      0    release+0x28
      23.15%  38.78%    28us(   218us)   6.2us(   108us)     376292     230381     145911      0    schedule+0xe0
       0.01%  45.34%   3.7us(    24us)    16us(    82us)        686        375        311      0    schedule+0x458
       0.00%   0.00%   2.8us(    70us)     0us                   89         89          0      0    schedule+0x504
       0.01%   8.55%   3.0us(    18us)   1.9us(    68us)       1356       1240        116      0    wake_up_process+0x14
    
       0.11%   4.97%    12us(  1113us)   1.0us(  1540us)       4041       3840        201      0  sem_ids+0x24
       0.00%   1.32%   7.1us(    88us)   0.1us(    11us)        303        299          4      0    semctl_main+0x4c
       0.06%   3.85%    11us(   281us)   0.5us(    81us)       2392       2300         92      0    sys_semop+0xe8
       0.04%   7.80%    15us(  1113us)   2.2us(  1540us)       1346       1241        105      0    sys_semop+0x3c8
    
       2.31%   6.86%   0.9us(    15us)   0.2us(    13us)    1102822    1027206      75616      0  timerlist_lock
       1.07%   4.75%   1.3us(    11us)   0.1us(   8.8us)     365451     348102      17349      0    add_timer+0x14
       0.00%   1.91%   0.3us(   4.2us)   0.1us(   4.5us)       3935       3860         75      0    del_timer+0x14
       0.32%   5.71%   0.4us(   7.2us)   0.2us(    13us)     362967     342246      20721      0    del_timer_sync+0x2c
       0.02%   1.47%   1.8us(   9.1us)   0.0us(   6.2us)       3942       3884         58      0    mod_timer+0x18
       0.02%   0.09%   2.3us(    15us)   0.0us(   2.8us)       4514       4510          4      0    timer_bh+0xd0
       0.89%  10.33%   1.1us(   7.6us)   0.3us(   8.2us)     362013     324604      37409      0    timer_bh+0x26c


  4way:

    SPINLOCKS             HOLD              WAIT
       UTIL     CON    MEAN (   MAX  )   MEAN (   MAX  )      TOTAL     NOWAIT       SPIN REJECT  NAME
    
       0.18%  33.57%   6.0us(    89us)   3.2us(   114us)      97322      64653      32669      0  sem_ids+0x24
       0.01%  15.07%   2.0us(    69us)   0.9us(    44us)      10551       8961       1590      0    semctl_main+0x50
       0.00%   0.00%   1.3us(   3.7us)     0us                  248        248          0      0    sys_semget+0xd0
       0.07%  23.57%   4.1us(    86us)   3.1us(   105us)      54350      41537      12813      0    sys_semop+0xf0
       0.10%  56.77%    10us(    89us)   4.2us(   114us)      32173      13907      18266      0    sys_semop+0x35c
    
       0.13%  10.71%   0.4us(   3.6us)   0.2us(    18us)    1147726    1024826     122900      0  timerlist_lock
       0.06%   9.85%   0.6us(   3.0us)   0.2us(    14us)     361475     325856      35619      0    add_timer+0x10
       0.00%   0.19%   0.1us(   1.2us)   0.0us(   6.2us)      45152      45068         84      0    del_timer+0x14
       0.03%  11.15%   0.3us(   2.4us)   0.2us(    18us)     341333     303277      38056      0    del_timer_sync+0x1c
       0.01%   0.44%   0.5us(   3.6us)   0.0us(   7.2us)      46186      45981        205      0    mod_timer+0x18
       0.01%   0.01%   0.5us(   2.9us)   0.0us(   1.2us)      32429      32425          4      0    timer_bh+0xcc
       0.03%  15.24%   0.3us(   2.0us)   0.3us(    10us)     321151     272219      48932      0    timer_bh+0x254
    
       0.00%   7.03%   0.2us(   2.3us)   0.2us(    20us)       6882       6398        484      0  add_wait_queue_exclusive+0x10
       0.00%  50.00%   0.1us(   0.1us)   3.2us(   6.4us)          2          1          1      0  inet_wait_for_connect+0x104
       0.07%   7.48%   0.8us(    13us)   0.2us(    13us)     294222     272202      22020      0  process_timeout+0x24
       0.02%  10.56%   0.5us(   4.6us)     0us               114853     102721          0  12132  reschedule_idle+0x3a4
       0.04%  15.82%   1.2us(   5.7us)     0us               101053      85069          0  15984  schedule+0x5a8
       0.00%  12.64%   2.3us(    12us)   0.3us(    11us)       2461       2150        311      0  schedule+0xb44
       0.00%  16.00%   1.6us(   3.0us)   0.5us(   3.5us)         50         42          8      0  schedule+0xb80
       0.00%  10.36%   0.4us(    13us)   1.4us(    20us)        251        225         26      0  tcp_close+0x30
       0.00%   5.24%   0.1us(   1.4us)   1.1us(    39us)        248        235         13      0  tcp_setsockopt+0x98
    
    
  8way:
    
    SPINLOCKS             HOLD              WAIT
       UTIL     CON    MEAN (   MAX  )   MEAN (   MAX  )      TOTAL     NOWAIT       SPIN REJECT  NAME
    
       1.15%   9.78%   7.6us(   363us)   2.1us(   862us)    1560956    1408297     152659      0  io_request_lock
       0.00%  45.45%   0.5us(   5.3us)    13us(   250us)      58066      31677      26389      0    __get_request_wait+0x70
       0.72%  12.06%    28us(   363us)   2.5us(   696us)     266880     234706      32174      0    __make_request+0xfc
       0.01%  21.74%   0.2us(   7.0us)   3.9us(   862us)     241846     189278      52568      0    blk_get_queue+0x14
       0.25%   4.19%   8.2us(    87us)   0.8us(   303us)     310337     297332      13005      0    do_aic7xxx_isr+0x20
       0.02%   3.39%   2.7us(    35us)   0.3us(   233us)      63155      61015       2140      0    generic_unplug_device+0x10
       0.04%   6.39%   2.4us(    34us)   2.2us(   314us)     155168     145259       9909      0    scsi_dispatch_cmd+0x12c
       0.03%   6.09%   1.9us(    12us)   1.2us(   285us)     155168     145725       9443      0    scsi_old_done+0x614
       0.07%   0.06%   4.9us(    65us)   0.0us(   177us)     155168     155080         88      0    scsi_queue_next_request+0x18
       0.02%   4.47%   1.2us(    11us)   0.9us(   349us)     155168     148225       6943      0    scsi_request_fn+0x338
    
       0.28%  36.38%   7.1us(   973us)   4.6us(   987us)     405038     257673     147365      0  sem_ids+0x24
       0.01%  19.36%   2.2us(    42us)   2.3us(   149us)      56047      45198      10849      0    semctl_main+0x50
       0.00%   0.00%   1.9us(    98us)     0us                  992        992          0      0    sys_semget+0xd0
       0.12%  23.36%   5.6us(   232us)   3.4us(   987us)     214063     164056      50007      0    sys_semop+0xf0
       0.15%  64.59%    12us(   973us)   7.5us(   973us)     133936      47427      86509      0    sys_semop+0x35c
    
       0.54%  14.58%   0.6us(    12us)   0.5us(    78us)    8829923    7542237    1287686      0  timerlist_lock
       0.21%  11.40%   0.8us(    12us)   0.4us(    78us)    2856951    2531286     325665      0    add_timer+0x10
       0.00%   0.82%   0.1us(   8.1us)   0.0us(    28us)     158853     157543       1310      0    del_timer+0x14
       0.12%  15.81%   0.4us(   7.8us)   0.5us(    76us)    2787756    2347125     440631      0    del_timer_sync+0x1c
       0.02%   1.19%   0.9us(   9.6us)   0.0us(    28us)     183111     180931       2180      0    mod_timer+0x18
       0.02%   0.08%   1.6us(   9.1us)   0.0us(   5.5us)     102552     102466         86      0    timer_bh+0xcc
       0.18%  18.89%   0.7us(   8.0us)   0.5us(    42us)    2740700    2222886     517814      0    timer_bh+0x254
    
    

--a8Wt8u1KmwUX3Y2C--
