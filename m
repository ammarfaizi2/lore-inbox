Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313918AbSDFCP7>; Fri, 5 Apr 2002 21:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313923AbSDFCPx>; Fri, 5 Apr 2002 21:15:53 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:18627 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313918AbSDFCPq>;
	Fri, 5 Apr 2002 21:15:46 -0500
Message-ID: <3CAE5A45.9020209@us.ibm.com>
Date: Fri, 05 Apr 2002 18:15:33 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020405
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: lse-tech <lse-tech@lists.sourceforge.net>
Subject: Lock contention data for 2.5.8-pre1
Content-Type: multipart/mixed;
 boundary="------------070500030806000405010903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070500030806000405010903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I've attached my latest lockmeter data from 2.5.8-pre1.  This is an 
8-way PIII Xeon machine, running dbench 16.  The clearest win that I saw 
for the BKL between the 2.5.7 and the current 2.5.8-pre1 is in do_exit. 
   The BKL was removed from do_exit, and pushed down into 2 other 
functions.  Granted, disassociate_ctty and sem_exit weren't called loads 
of times, and the tasks probably weren't holding a lot of semaphores, 
but that is part of the point.

2.5.7:               avg hold(   max)
do_exit+0xd8           5003us(  19ms)

reduced to this in 2.5.8-pre1:
disassociate_ctty+0x28  1.8us( 1.8us)
sem_exit+0x24           1.5us( 3.0us)

As for other locks, kmap_lock, lru_list_lock, and pagecache_lock are the 
ones that stick out most.  But, things are looking better.  Are there 
any workloads which people are really interested in?  Name it, and I'll 
run it on the 8-way Xeon and a 16-way NUMA-Q.

I also ported lockmeter to 2.5.8-pre1.  If you want it, I've got it.

-- 
Dave Hansen
haveblue@us.ibm.com

--------------070500030806000405010903
Content-Type: text/plain;
 name="lockstat.dch1.16.processed"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lockstat.dch1.16.processed"

___________________________________________________________________________________________
System: Linux elm3b96.eng 2.5.8-pre1-lm-dch1 #24 SMP Fri Apr 5 17:15:19 PST 2002 i686
Total counts

All (8) CPUs

Start time: Fri Apr  5 17:21:45 2002
End   time: Fri Apr  5 17:23:30 2002
Delta Time: 105.27 sec.
Hash table slots in use:      335.
Global read lock slots in use: 999.

*************************** Warnings! ******************************
	Read Lock table overflowed.

	The data in this report may be in error due to this.
************************ End of Warnings! **************************


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME

       13.9%  1.0us(8442us)   25us(8365us)(18.4%)  43825003 86.1% 13.9% 0.00%  *TOTAL*

 0.00%    0%  0.1us( 0.1us)    0us                       20  100%    0%    0%  [0xc4034fd0]
 0.00%    0%  0.1us( 0.1us)    0us                        5  100%    0%    0%    shmem_delete_inode+0x60
 0.00%    0%  0.1us( 0.1us)    0us                        5  100%    0%    0%    shmem_get_inode+0x18
 0.00%    0%  0.1us( 0.1us)    0us                        5  100%    0%    0%    shmem_getpage_locked+0x270
 0.00%    0%  0.1us( 0.1us)    0us                        5  100%    0%    0%    shmem_recalc_inode+0x40

 0.03% 0.34%  4.8us(  70us)   13us(  41us)(0.00%)      6268 99.7% 0.34%    0%  [0xc4047c88]
 0.01% 0.33%  4.6us(  38us)   11us(  29us)(0.00%)      1803 99.7% 0.33%    0%    __make_request+0x8c
 0.01% 0.24%  7.9us(  70us)  5.3us( 8.2us)(0.00%)       837 99.8% 0.24%    0%    ahc_linux_isr+0x2f8
 0.00%    0%   15us(  37us)    0us                      218  100%    0%    0%    generic_unplug_device+0x14
 0.00%    0%  1.1us( 1.1us)    0us                        1  100%    0%    0%    get_request_wait+0xa8
 0.01% 0.68%  6.9us(  43us)   12us(  31us)(0.00%)       886 99.3% 0.68%    0%    scsi_dispatch_cmd+0xf8
 0.00% 0.36%  0.8us( 6.3us)  3.1us( 3.6us)(0.00%)       835 99.6% 0.36%    0%    scsi_finish_command+0x18
 0.00% 0.36%  2.9us( 9.8us)   23us(  30us)(0.00%)       835 99.6% 0.36%    0%    scsi_queue_next_request+0x18
 0.00% 0.12%  3.0us(  17us)   41us(  41us)(0.00%)       853 99.9% 0.12%    0%    scsi_request_fn+0x3ec

 0.00%    0%  0.4us( 1.0us)    0us                        4  100%    0%    0%  [0xf3765ce0]
 0.00%    0%  0.3us( 0.3us)    0us                        2  100%    0%    0%    inet_autobind+0x24
 0.00%    0%  0.6us( 1.0us)    0us                        2  100%    0%    0%    inet_autobind+0x16c

 0.00%    0%  2.2us( 4.2us)    0us                        2  100%    0%    0%  [0xf3765d18]
 0.00%    0%  2.2us( 4.2us)    0us                        2  100%    0%    0%    udp_queue_rcv_skb+0x5c

 0.00%  1.1%  5.0us( 192us)   17us(  17us)(0.00%)        90 98.9%  1.1%    0%  [0xf3816ce0]
 0.00%    0%  0.1us( 0.1us)    0us                        1  100%    0%    0%    inet_accept+0x50
 0.00%    0%  0.1us( 0.1us)    0us                        1  100%    0%    0%    inet_accept+0x13c
 0.00%    0%  4.0us( 4.0us)    0us                        1  100%    0%    0%    inet_shutdown+0x4c
 0.00%    0%  2.3us( 2.3us)    0us                        1  100%    0%    0%    inet_shutdown+0x150
 0.00%    0%  0.9us( 0.9us)    0us                        1  100%    0%    0%    ip_getsockopt+0x80
 0.00%    0%  1.8us( 1.8us)    0us                        1  100%    0%    0%    ip_getsockopt+0x134
 0.00%    0%  0.4us( 0.4us)    0us                        1  100%    0%    0%    sock_setsockopt+0x8c
 0.00%    0%  1.3us( 1.3us)    0us                        1  100%    0%    0%    sock_setsockopt+0x4f8
 0.00%    0%  0.8us( 0.8us)    0us                        1  100%    0%    0%    tcp_close+0x28
 0.00%    0%  1.6us( 1.6us)    0us                        1  100%    0%    0%    tcp_close+0x2d0
 0.00%    0%  3.3us( 3.3us)    0us                        1  100%    0%    0%    tcp_close+0x36c
 0.00%    0%  2.3us( 2.3us)    0us                        1  100%    0%    0%    tcp_close+0x408
 0.00%    0%  192us( 192us)    0us                        1  100%    0%    0%    tcp_close+0x490
 0.00%    0%   84us(  84us)    0us                        1  100%    0%    0%    tcp_create_openreq_child+0x84
 0.00%    0%  0.5us( 0.8us)    0us                        2  100%    0%    0%    tcp_data_wait+0x90
 0.00%    0%  1.2us( 2.2us)    0us                        2  100%    0%    0%    tcp_data_wait+0x134
 0.00%    0%   69us(  74us)    0us                        2  100%    0%    0%    tcp_delack_timer+0x18
 0.00%  2.9%  0.2us( 1.8us)   17us(  17us)(0.00%)        35 97.1%  2.9%    0%    tcp_recvmsg+0x40
 0.00%    0%  0.3us( 1.7us)    0us                       35  100%    0%    0%    tcp_recvmsg+0x7e4

 0.00%    0%  0.8us( 1.6us)    0us                        2  100%    0%    0%  [0xf458c9ac]
 0.00%    0%  0.8us( 1.6us)    0us                        2  100%    0%    0%    mprotect_fixup+0xdc

 0.00%    0%  0.3us( 1.5us)    0us                       52  100%    0%    0%  [0xf70aac24]
 0.00%    0%  0.4us( 1.5us)    0us                       31  100%    0%    0%    n_tty_receive_buf+0x44
 0.00%    0%  0.1us( 0.1us)    0us                        7  100%    0%    0%    read_chan+0x504
 0.00%    0%  0.1us( 0.1us)    0us                        7  100%    0%    0%    read_chan+0x568
 0.00%    0%  0.1us( 0.2us)    0us                        7  100%    0%    0%    read_chan+0x5a4

 0.00%    0%  1.7us( 2.2us)    0us                        2  100%    0%    0%  [0xf72889c0]
 0.00%    0%  2.2us( 2.2us)    0us                        1  100%    0%    0%    tcp_accept+0x2c
 0.00%    0%  1.2us( 1.2us)    0us                        1  100%    0%    0%    tcp_accept+0x148

 0.00%    0%  2.2us( 4.3us)    0us                        2  100%    0%    0%  [0xf72aea38]
 0.00%    0%  2.2us( 4.3us)    0us                        2  100%    0%    0%    unix_dgram_sendmsg+0x360

 0.00%    0%  4.8us( 5.6us)    0us                        5  100%    0%    0%  [0xf7672d2c]
 0.00%    0%  4.2us( 4.2us)    0us                        1  100%    0%    0%    unmap_fixup+0x8c
 0.00%    0%  5.0us( 5.6us)    0us                        4  100%    0%    0%    unmap_fixup+0x134

 0.00%    0%  1.5us( 2.3us)    0us                        2  100%    0%    0%  [0xf76800b0]
 0.00%    0%  2.3us( 2.3us)    0us                        1  100%    0%    0%    tcp_put_port+0x38
 0.00%    0%  0.6us( 0.6us)    0us                        1  100%    0%    0%    tcp_v4_syn_recv_sock+0x218

 0.00%    0%  5.2us(  11us)    0us                       30  100%    0%    0%  [0xf77c50dc]
 0.00%    0%  5.2us(  11us)    0us                       30  100%    0%    0%    qdisc_restart+0x2c

 0.00%    0%  2.1us( 8.9us)    0us                       60  100%    0%    0%  [0xf77c50e4]
 0.00%    0%  3.5us( 8.9us)    0us                       30  100%    0%    0%    dev_queue_xmit+0x12c
 0.00%    0%  0.6us( 4.1us)    0us                       30  100%    0%    0%    qdisc_restart+0x90

 0.00%    0%  3.8us( 9.3us)    0us                       60  100%    0%    0%  [0xf77c5504]
 0.00%    0%  5.1us( 9.3us)    0us                       30  100%    0%    0%    tulip_interrupt+0xe8
 0.00%    0%  2.5us( 4.6us)    0us                       30  100%    0%    0%    tulip_start_xmit+0x18

 0.08% 0.02%  0.3us( 136us)  2.9us(  60us)(0.00%)    300436  100% 0.02%    0%  arbitration_lock
 0.00%    0%  0.2us( 2.9us)    0us                      108  100%    0%    0%    deny_write_access+0xc
 0.08% 0.02%  0.3us( 136us)  2.9us(  60us)(0.00%)    300328  100% 0.02%    0%    get_write_access+0xc

 0.05%    0%   26us( 223us)    0us                     2111  100%    0%    0%  call_lock
 0.05%    0%   26us( 223us)    0us                     2111  100%    0%    0%    smp_call_function+0x58

  3.2%  5.9%  0.6us( 506us)  6.5us( 695us)(0.24%)   5273764 94.1%  5.9%    0%  dcache_lock
 0.03%  6.0%  0.3us(  47us)  6.5us( 695us)(0.00%)    102099 94.0%  6.0%    0%    d_alloc+0x12c
 0.03%  9.1%  0.3us(  83us)  5.7us( 373us)(0.00%)     77765 90.9%  9.1%    0%    d_delete+0x10
 0.02%  3.9%  0.3us(  65us)  6.7us( 367us)(0.00%)     77765 96.1%  3.9%    0%    d_delete+0x94
 0.05%  8.3%  0.3us(  63us)  5.7us( 438us)(0.01%)    179876 91.7%  8.3%    0%    d_instantiate+0x24
  2.7%  5.7%  0.7us( 250us)  6.6us( 610us)(0.19%)   4242518 94.3%  5.7%    0%    d_lookup+0x5c
 0.04%  8.4%  2.9us(  86us)  6.0us( 269us)(0.00%)     15600 91.6%  8.4%    0%    d_move+0x3c
 0.02%  5.1%  0.3us(  97us)  5.6us( 445us)(0.00%)    102094 94.9%  5.1%    0%    d_rehash+0x48
 0.00%  3.2%  0.2us( 3.2us)  6.8us(  66us)(0.00%)       560 96.8%  3.2%    0%    d_unhash+0x3c
 0.29%  6.9%  0.7us( 170us)  6.7us( 490us)(0.03%)    464871 93.1%  6.9%    0%    dput+0x30
 0.00%    0%  1.5us( 4.0us)    0us                       29  100%    0%    0%    link_path_walk+0x358
 0.00% 11.9%  2.2us(  15us)  5.0us(  22us)(0.00%)       134 88.1% 11.9%    0%    prune_dcache+0x14
 0.01%  4.7%  0.9us(  19us)  4.2us(  63us)(0.00%)      9918 95.3%  4.7%    0%    prune_dcache+0x138
 0.01%  1.3%   18us( 506us)  2.2us( 4.0us)(0.00%)       534 98.7%  1.3%    0%    select_parent+0x20
 0.00%    0%  3.4us( 3.4us)    0us                        1  100%    0%    0%    sys_getcwd+0xe0

 0.00% 0.06%  1.8us(  11us)  4.9us( 4.9us)(0.00%)      1688  100% 0.06%    0%  device_request_lock
 0.00% 0.12%  0.6us( 7.8us)  4.9us( 4.9us)(0.00%)       835 99.9% 0.12%    0%    __scsi_release_command+0x14
 0.00%    0%  2.9us(  11us)    0us                      853  100%    0%    0%    scsi_allocate_device+0x30

 0.73%  2.1%  0.9us(  89us)  2.7us(  86us)(0.01%)    871905 97.9%  2.1%    0%  files_lock
 0.00%    0%  0.1us( 0.1us)    0us                       10  100%    0%    0%    check_tty_count+0x10
 0.13%  3.0%  0.5us(  66us)  2.9us(  63us)(0.00%)    290489 97.0%  3.0%    0%    file_move+0x18
 0.08%  1.8%  0.3us(  45us)  2.8us(  65us)(0.00%)    290534 98.2%  1.8%    0%    fput+0x80
 0.52%  1.5%  1.9us(  89us)  2.4us(  86us)(0.00%)    290536 98.5%  1.5%    0%    get_empty_filp+0xc
 0.00%  1.8%  1.3us( 4.3us)  2.3us( 4.1us)(0.00%)       335 98.2%  1.8%    0%    get_empty_filp+0xe0
 0.00%    0%  2.6us( 2.6us)    0us                        1  100%    0%    0%    put_filp+0x18

 0.11% 0.06%  9.8us( 169us)    0us                    11915  100%    0% 0.06%  global_bh_lock
 0.11% 0.06%  9.8us( 169us)    0us                    11915  100%    0% 0.06%    bh_action+0x18

 0.09%    0%  8.7us( 103us)    0us                    10528  100%    0%    0%  i8253_lock
 0.09%    0%  8.7us( 103us)    0us                    10528  100%    0%    0%    timer_interrupt+0x2c

 0.03%    0%  2.7us(  23us)    0us                    10528  100%    0%    0%  i8259A_lock
 0.03%    0%  2.7us(  23us)    0us                    10528  100%    0%    0%    timer_interrupt+0x90

 0.00%    0%  0.8us( 0.8us)    0us                        1  100%    0%    0%  inet_peer_unused_lock
 0.00%    0%  0.8us( 0.8us)    0us                        1  100%    0%    0%    cleanup_once+0x24

 0.00%    0%  0.4us( 1.0us)    0us                        6  100%    0%    0%  init_mm+0x2c
 0.00%    0%  1.0us( 1.0us)    0us                        1  100%    0%    0%    __vmalloc+0x78
 0.00%    0%  0.3us( 0.4us)    0us                        5  100%    0%    0%    __vmalloc+0x120

 0.25% 0.41%  0.7us( 163us)  2.4us(  33us)(0.00%)    366892 99.6% 0.41%    0%  inode_lock
 0.06% 0.22%  0.6us( 108us)  2.4us( 8.7us)(0.00%)     97654 99.8% 0.22%    0%    __mark_inode_dirty+0x48
 0.00%    0%  0.8us( 2.0us)    0us                       12  100%    0%    0%    get_new_inode+0x28
 0.02% 0.62%  2.4us(  25us)  2.7us(  16us)(0.00%)      8571 99.4% 0.62%    0%    iget4+0x3c
 0.04% 0.36%  0.5us( 163us)  2.4us(  20us)(0.00%)     77777 99.6% 0.36%    0%    insert_inode_hash+0x44
 0.06% 0.53%  0.7us(  41us)  2.7us(  33us)(0.00%)     86997 99.5% 0.53%    0%    iput+0x68
 0.06% 0.52%  0.8us(  41us)  2.2us(  11us)(0.00%)     77813 99.5% 0.52%    0%    new_inode+0x1c
 0.00%    0%   15us( 127us)    0us                       21  100%    0%    0%    sync_unlocked_inodes+0x10
 0.02% 0.38%  1.3us(  18us)  2.0us( 6.5us)(0.00%)     18047 99.6% 0.38%    0%    sync_unlocked_inodes+0x110

 0.68% 0.59%  0.9us(8442us)  128us(8365us)(0.07%)    756604 99.4% 0.59%    0%  kernel_flag
 0.00%    0%  8.5us(  12us)    0us                        7  100%    0%    0%    chrdev_open+0x50
 0.00%    0%  0.7us( 1.2us)    0us                       11  100%    0%    0%    de_put+0x2c
 0.00%    0%  1.8us( 1.8us)    0us                        1  100%    0%    0%    disassociate_ctty+0x28
 0.00%    0%  1.9us( 4.7us)    0us                        4  100%    0%    0%    do_fcntl+0x15c
 0.05% 0.51%  0.3us(  48us)  187us(7933us)(0.02%)    201715 99.5% 0.51%    0%    ext2_free_blocks+0x244
 0.05% 0.91%  0.3us( 163us)  177us(8365us)(0.03%)    173140 99.1% 0.91%    0%    ext2_new_block+0x94
 0.03% 0.32%  0.2us(  59us)  4.7us( 105us)(0.00%)    172253 99.7% 0.32%    0%    ext2_new_block+0xfc
 0.06% 0.61%  0.4us(  59us)   41us(7707us)(0.01%)    173140 99.4% 0.61%    0%    ext2_new_block+0x5e8
 0.00%    0%  4.2us( 5.4us)    0us                        6  100%    0%    0%    get_chrfops+0x8c
 0.01%  1.0%  0.8us(  63us)  219us(6466us)(0.00%)     10240 99.0%  1.0%    0%    inode_change_ok+0x34
 0.28% 0.47%   29us( 480us)  5.0us(  42us)(0.00%)     10240 99.5% 0.47%    0%    inode_setattr+0x34
 0.00%  9.1%   22us(  39us)  0.4us( 0.4us)(0.00%)        11 90.9%  9.1%    0%    proc_lookup+0x38
 0.00%    0%  0.6us( 2.0us)    0us                       11  100%    0%    0%    proc_root_lookup+0x2c
 0.02%  1.3%  313us(2986us)  0.4us( 0.4us)(0.00%)        79 98.7%  1.3%    0%    schedule+0x398
 0.00%  2.0%  1.5us( 3.0us)  0.7us( 1.2us)(0.00%)        98 98.0%  2.0%    0%    sem_exit+0x24
 0.00%    0%  0.4us( 0.7us)    0us                        2  100%    0%    0%    sock_ioctl+0x60
 0.10%  4.8% 5251us(8442us)  2.1us( 2.1us)(0.00%)        21 95.2%  4.8%    0%    sync_old_buffers+0x1c
 0.00%    0%  3.3us( 4.2us)    0us                        2  100%    0%    0%    sys_ioctl+0x44
 0.00%    0%   13us(  18us)    0us                        7  100%    0%    0%    tty_read+0xc4
 0.00%    0%  9.6us(10.0us)    0us                        5  100%    0%    0%    tty_release+0x1c
 0.00%    0%   26us(  35us)    0us                        7  100%    0%    0%    tty_write+0x1f4
 0.00%    0%   56us( 112us)    0us                        2  100%    0%    0%    vfs_readdir+0x5c
 0.07% 0.86%  4.6us( 273us)  282us(8217us)(0.00%)     15600 99.1% 0.86%    0%    vfs_rename_other+0xa0
 0.00% 50.0%  7.4us( 7.8us)  2.1us( 2.1us)(0.00%)         2 50.0% 50.0%    0%    vfs_statfs+0x50

 13.7% 24.6%  1.0us( 490us)   24us(1081us)(10.9%)  15171922 75.4% 24.6%    0%  kmap_lock
  7.6% 24.9%  1.1us( 490us)   24us( 899us)( 5.4%)   7585961 75.1% 24.9%    0%    kmap_high+0x10
  6.1% 24.4%  0.8us( 201us)   25us(1081us)( 5.4%)   7585961 75.6% 24.4%    0%    kunmap_high+0xc

 0.00%    0%  0.2us( 1.2us)    0us                       98  100%    0%    0%  lastpid_lock
 0.00%    0%  0.2us( 1.2us)    0us                       98  100%    0%    0%    get_pid+0x28

  9.4% 21.1%  1.7us( 415us)   48us(1581us)( 6.9%)   5736517 78.9% 21.1%    0%  lru_list_lock
 0.61% 10.5%  0.4us( 415us)   16us(1554us)(0.32%)   1673139 89.5% 10.5%    0%    buffer_insert_list+0x10
 0.00% 16.7%  1.0us( 1.7us)  2.3us( 2.3us)(0.00%)         6 83.3% 16.7%    0%    fsync_buffers_list+0x24
 0.00%    0%  1.4us( 3.9us)    0us                        3  100%    0%    0%    fsync_buffers_list+0xb4
 0.00%    0%  1.2us( 2.0us)    0us                        3  100%    0%    0%    fsync_buffers_list+0x130
 0.04% 15.1%  0.5us( 166us)   33us(1268us)(0.05%)     77812 84.9% 15.1%    0%    inode_has_buffers+0x10
 0.04% 15.4%  0.5us( 108us)   32us(1023us)(0.05%)     77800 84.6% 15.4%    0%    invalidate_inode_buffers+0x10
 0.00%  9.5%  8.1us(  67us)   87us( 143us)(0.00%)        21 90.5%  9.5%    0%    kupdate+0xe8
 0.00% 16.7%  0.9us( 2.6us)  1.3us( 1.3us)(0.00%)         6 83.3% 16.7%    0%    osync_buffers_list+0x14
  3.3% 24.9%  1.8us( 215us)   46us(1576us)( 2.7%)   1969117 75.1% 24.9%    0%    refile_buffer+0xc
  2.2% 27.1%  2.4us( 282us)   62us(1581us)( 1.9%)    968245 72.9% 27.1%    0%    remove_from_queues+0xc
 0.00% 17.5%   14us(  64us)   18us(  85us)(0.00%)        40 82.5% 17.5%    0%    sync_old_buffers+0x64
  3.2% 26.6%  3.5us( 411us)   62us(1314us)( 1.9%)    970325 73.4% 26.6%    0%    try_to_free_buffers+0x3c

 0.00%    0%  0.4us( 3.9us)    0us                      196  100%    0%    0%  mmlist_lock
 0.00%    0%  0.1us( 0.7us)    0us                       98  100%    0%    0%    copy_mm+0x120
 0.00%    0%  0.6us( 3.9us)    0us                       98  100%    0%    0%    mmput+0x28

 0.00%    0%  0.7us( 2.9us)    0us                     1014  100%    0%    0%  page_uptodate_lock.0
 0.00%    0%  0.7us( 2.9us)    0us                     1014  100%    0%    0%    end_buffer_io_async+0x38

  5.3%  8.4%  0.8us( 227us)  3.2us( 348us)(0.24%)   7413275 91.6%  8.4%    0%  pagecache_lock
 0.16%  9.8%  0.6us(  80us)  3.1us( 301us)(0.01%)    295180 90.2%  9.8%    0%    __find_get_page+0x18
  1.7%  8.8%  0.6us(  97us)  3.2us( 244us)(0.10%)   3016015 91.2%  8.8%    0%    __find_lock_page+0xc
 0.00%    0%  0.8us( 1.1us)    0us                        5  100%    0%    0%    add_to_page_cache+0x18
  1.5%  7.7%  1.6us( 227us)  3.4us( 249us)(0.03%)    968410 92.3%  7.7%    0%    add_to_page_cache_unique+0x18
 0.84%  8.8%  0.8us(  91us)  3.1us( 229us)(0.03%)   1073811 91.2%  8.8%    0%    do_generic_file_read+0x154
 0.00%  6.8%  1.5us(  10us)  3.1us(  31us)(0.00%)      2086 93.2%  6.8%    0%    do_generic_file_read+0x320
 0.00%  4.0%  0.1us(  13us)  2.4us( 104us)(0.00%)     18050 96.0%  4.0%    0%    filemap_fdatasync+0x20
 0.00%  4.1%  0.1us( 9.4us)  2.1us(  35us)(0.00%)     18050 95.9%  4.1%    0%    filemap_fdatawait+0x14
 0.01% 10.9%  0.9us(  37us)  3.6us( 117us)(0.00%)     12963 89.1% 10.9%    0%    find_or_create_page+0x38
 0.03% 12.0%  2.5us(  61us)  3.9us(  87us)(0.00%)     12963 88.0% 12.0%    0%    find_or_create_page+0x78
 0.00% 11.0%  0.7us(  38us)  8.9us( 134us)(0.00%)      5627 89.0% 11.0%    0%    page_cache_read+0x48
 0.60%  7.3%  0.7us(  66us)  3.1us( 247us)(0.03%)    970330 92.7%  7.3%    0%    remove_inode_page+0x1c
 0.00% 20.0%  0.6us( 1.9us)  1.1us( 1.1us)(0.00%)         5 80.0% 20.0%    0%    set_page_dirty+0x24
 0.05%  9.3%  1.0us(  46us)  3.2us( 149us)(0.00%)     49450 90.7%  9.3%    0%    truncate_inode_pages+0x38
 0.37%  8.2%  0.4us(  89us)  3.1us( 348us)(0.03%)    970330 91.8%  8.2%    0%    truncate_list_pages+0x1e8

  1.1%  1.7%  0.6us( 121us)  1.7us(  99us)(0.01%)   2072770 98.3%  1.7%    0%  pagemap_lru_lock
 0.16%  3.8%  1.5us(  76us)  2.0us(  47us)(0.00%)    112414 96.2%  3.8%    0%    activate_page+0xc
 0.52%  2.3%  0.6us( 121us)  1.5us(  99us)(0.00%)    986746 97.7%  2.3%    0%    lru_cache_add+0x1c
 0.43% 0.94%  0.5us(  49us)  2.1us(  97us)(0.00%)    973610 99.1% 0.94%    0%    lru_cache_del+0xc

 0.00%    0%  1.5us( 8.3us)    0us                      113  100%    0%    0%  sb_lock
 0.00%    0%  0.1us( 0.6us)    0us                       21  100%    0%    0%    drop_super+0x24
 0.00%    0%  0.9us( 4.3us)    0us                       42  100%    0%    0%    sync_supers+0x8
 0.00%    0%  5.7us( 8.3us)    0us                       21  100%    0%    0%    sync_unlocked_inodes+0x18
 0.00%    0%  0.5us( 1.6us)    0us                       29  100%    0%    0%    sync_unlocked_inodes+0x194

 0.00%    0%  0.4us(  25us)    0us                     2528  100%    0%    0%  scsi_bhqueue_lock
 0.00%    0%  0.2us(  11us)    0us                     1660  100%    0%    0%    scsi_bottom_half_handler+0x1c
 0.00%    0%  0.8us(  25us)    0us                      868  100%    0%    0%    scsi_done+0x3c

 0.09%  1.7%  0.8us(  43us)  2.6us(  46us)(0.00%)    130557 98.3%  1.7%    0%  semaphore_lock
 0.02%  2.1%  0.5us(  38us)  2.4us(  16us)(0.00%)     50740 97.9%  2.1%    0%    __down+0x48
 0.07%  1.5%  0.9us(  43us)  2.7us(  46us)(0.00%)     79817 98.5%  1.5%    0%    __down+0x7c

 0.00%    0%  0.9us( 4.8us)    0us                      191  100%    0%    0%  shm_ids+0x24
 0.00%    0%  0.1us( 0.1us)    0us                        1  100%    0%    0%    grow_ary+0x8c
 0.00%    0%  0.7us( 0.8us)    0us                        5  100%    0%    0%    ipc_addid+0x98
 0.00%    0%  1.7us( 4.8us)    0us                       85  100%    0%    0%    shm_close+0x54
 0.00%    0%  0.3us( 0.3us)    0us                        5  100%    0%    0%    shm_mmap+0x54
 0.00%    0%  0.2us( 1.2us)    0us                       80  100%    0%    0%    shm_open+0x3c
 0.00%    0%  1.5us( 1.7us)    0us                        5  100%    0%    0%    sys_shmat+0xb8
 0.00%    0%  0.2us( 0.2us)    0us                        5  100%    0%    0%    sys_shmat+0x264
 0.00%    0%  0.9us( 1.0us)    0us                        5  100%    0%    0%    sys_shmctl+0x684

 0.00%    0%  0.1us( 0.1us)    0us                       10  100%    0%    0%  shmem_ilock
 0.00%    0%  0.1us( 0.1us)    0us                        5  100%    0%    0%    shmem_delete_inode+0x34
 0.00%    0%  0.1us( 0.1us)    0us                        5  100%    0%    0%    shmem_get_inode+0x14c

 0.03%    0% 4487us(5106us)    0us                        6  100%    0%    0%  swaplock
 0.03%    0% 4487us(5106us)    0us                        6  100%    0%    0%    si_swapinfo+0x18

 0.02% 0.01%  1.5us(  28us)  2.0us( 2.0us)(0.00%)     12944  100% 0.01%    0%  timerlist_lock
 0.00%    0%  0.6us(  20us)    0us                      999  100%    0%    0%    add_timer+0x10
 0.00%    0%  0.8us( 9.0us)    0us                      871  100%    0%    0%    del_timer+0x14
 0.00%    0%  1.0us(  20us)    0us                      212  100%    0%    0%    del_timer_sync+0x1c
 0.00% 0.66%  1.3us( 4.4us)  2.0us( 2.0us)(0.00%)       151 99.3% 0.66%    0%    mod_timer+0x18
 0.02%    0%  1.7us(  28us)    0us                    10528  100%    0%    0%    timer_bh+0xcc
 0.00%    0%  0.3us( 2.9us)    0us                      183  100%    0%    0%    timer_bh+0x254

 0.00% 0.07%  0.4us( 9.8us)  2.1us( 2.1us)(0.00%)      1537  100% 0.07%    0%  tqueue_lock
 0.00%    0%  0.3us( 9.8us)    0us                      769  100%    0%    0%    __run_task_queue+0x14
 0.00%    0%  0.5us( 3.8us)    0us                      551  100%    0%    0%    batch_entropy_store+0x7c
 0.00% 0.46%  0.5us( 9.4us)  2.1us( 2.1us)(0.00%)       217 99.5% 0.46%    0%    blk_plug_device+0x3c

  1.1%  1.1%  0.6us( 131us)  2.8us( 123us)(0.01%)   1953784 98.9%  1.1%    0%  unused_list_lock
 0.58%  1.4%  0.6us( 128us)  3.2us( 123us)(0.01%)    983459 98.6%  1.4%    0%    get_unused_buffer_head+0x8
 0.53% 0.68%  0.6us( 131us)  2.1us(  77us)(0.00%)    970325 99.3% 0.68%    0%    try_to_free_buffers+0x74

 0.83%  2.1%  0.9us(  77us)  2.2us(  97us)(0.01%)    974344 97.9%  2.1%    0%  __free_pages_ok+0x11c
 0.76% 0.29%  0.7us( 234us)  3.8us(  83us)(0.00%)   1091337 99.7% 0.29%    0%  __wake_up+0x1c
 0.00%    0%  0.2us(  13us)    0us                     3492  100%    0%    0%  add_wait_queue+0x10
 0.01% 12.1%  0.3us(  39us)  5.9us( 158us)(0.00%)     50764 87.9% 12.1%    0%  add_wait_queue_exclusive+0x10
 0.01% 0.24%  9.1us(  62us)  4.7us( 7.8us)(0.00%)      1674 99.8% 0.24%    0%  ahc_linux_isr+0x28
 0.00%    0%  1.0us( 3.8us)    0us                       58  100%    0%    0%  change_protection+0x40
 0.00%    0%   27us(  49us)    0us                      116  100%    0%    0%  clear_page_tables+0x1c
 0.00%    0%  0.1us( 2.1us)    0us                     1002  100%    0%    0%  copy_mm+0x1f8
 0.00%    0%  1.6us(  66us)    0us                     1429  100%    0%    0%  copy_mm+0x22c
 0.00%    0%  1.8us(  67us)    0us                     1429  100%    0%    0%  copy_page_range+0xe8
 0.01%    0%  1.0us(  16us)    0us                    11451  100%    0%    0%  do_IRQ+0x40
 0.00%    0%  0.4us(  31us)    0us                    11451  100%    0%    0%  do_IRQ+0xc0
 0.00%    0%  1.9us(  17us)    0us                     1096  100%    0%    0%  do_anonymous_page+0xc4
 0.00%    0%  0.3us( 0.7us)    0us                       18  100%    0%    0%  do_brk+0x1e0
 0.00%    0%  0.2us( 1.5us)    0us                       98  100%    0%    0%  do_exit+0x110
 0.00%    0%  0.2us( 2.7us)    0us                       98  100%    0%    0%  do_exit+0x1c0
 0.00%    0%  0.2us( 1.1us)    0us                       98  100%    0%    0%  do_exit+0x8c
 0.00%    0%  0.1us( 1.6us)    0us                       98  100%    0%    0%  do_exit+0xe0
 0.00%    0%  0.9us( 5.0us)    0us                      337  100%    0%    0%  do_mmap_pgoff+0x414
 0.00%    0%  0.6us( 5.7us)    0us                      542  100%    0%    0%  do_mmap_pgoff+0x420
 0.00%    0%  0.2us( 0.6us)    0us                      125  100%    0%    0%  do_munmap+0x1b8
 0.00%    0%  1.0us( 6.8us)    0us                      279  100%    0%    0%  do_munmap+0xe0
 0.00%    0%  0.2us( 5.4us)    0us                     5325  100%    0%    0%  do_no_page+0x19c
 0.00%    0%  0.2us( 1.9us)    0us                      112  100%    0%    0%  do_page_fault+0x128
 0.00%    0%  0.6us( 5.6us)    0us                      260  100%    0%    0%  do_sigaction+0x58
 0.00%    0%  0.5us( 2.3us)    0us                       45  100%    0%    0%  do_sigaction+0xe0
 0.00%    0%  4.2us(  12us)    0us                       95  100%    0%    0%  do_signal+0x54
 0.00%    0%  2.2us(  18us)    0us                     2002  100%    0%    0%  do_wp_page+0x1fc
 0.00%    0%  0.2us( 3.2us)    0us                      116  100%    0%    0%  exit_mmap+0x18
 0.00%    0%  0.3us( 2.8us)    0us                     1303  100%    0%    0%  exit_mmap+0x88
 0.00%    0%  1.9us( 4.6us)    0us                       98  100%    0%    0%  exit_sighand+0x18
 0.17%    0%   32us( 129us)    0us                     5444  100%    0%    0%  free_block+0x1c
 0.01%    0%  0.6us(  15us)    0us                     9760  100%    0%    0%  handle_mm_fault+0x34
 0.00%    0%  0.5us( 2.5us)    0us                       95  100%    0%    0%  handle_signal+0xb0
 0.00%    0%  0.4us( 0.8us)    0us                       18  100%    0%    0%  insert_vm_struct+0x64
 0.08% 0.24%  7.7us( 116us)  6.9us(  29us)(0.00%)     11064 99.8% 0.24%    0%  kmem_cache_alloc_batch+0x20
 0.00% 0.28%  0.2us(  21us)  2.4us( 6.8us)(0.00%)      3191 99.7% 0.28%    0%  kmem_cache_grow+0x1e4
 0.00% 0.13%  0.7us(  11us)  2.1us( 3.0us)(0.00%)      3191 99.9% 0.13%    0%  kmem_cache_grow+0x8c
 0.11%  2.7%  2.4us(  48us)    0us                    47297 97.3%    0%  2.7%  load_balance+0x110
 0.00% 67.3%  3.2us(  14us)  3.3us(  20us)(0.00%)       648 32.7% 67.3%    0%  load_balance+0x12c
 0.00%  5.9%  3.8us(  34us)  3.2us( 6.7us)(0.00%)       648 94.1%  5.9%    0%  load_balance+0x134
 0.00% 71.7%  2.3us(  12us)  3.5us(  59us)(0.00%)       607 28.3% 71.7%    0%  load_balance+0x168
 0.00%    0%  1.5us( 7.0us)    0us                       56  100%    0%    0%  mprotect_fixup+0x2a8
 0.00%    0%  0.8us( 2.5us)    0us                       56  100%    0%    0%  mprotect_fixup+0x2b4
 0.00%    0%  0.4us( 1.8us)    0us                       28  100%    0%    0%  n_tty_chars_in_buffer+0x18
 0.00%    0%  2.6us(  68us)    0us                      348  100%    0%    0%  pte_alloc_map+0xdc
 0.00%    0%  0.2us( 0.3us)    0us                       18  100%    0%    0%  put_dirty_page+0x3c
 0.02% 23.6%  0.3us(  71us)  6.0us(  56us)(0.01%)     54256 76.4% 23.6%    0%  remove_wait_queue+0x10
  2.0%  6.1%  2.2us(  82us)  3.6us( 154us)(0.03%)    990685 93.9%  6.1%    0%  rmqueue+0x28
 0.29%    0%  2.6us( 160us)    0us                   117844  100%    0%    0%  schedule+0x1a8
 0.50%  2.0%  4.3us( 231us)  3.0us(  71us)(0.00%)    121815 98.0%  2.0%    0%  schedule+0x8c
 0.07% 0.05%  0.9us(  46us)  4.7us(  20us)(0.00%)     75935  100% 0.05%    0%  scheduler_tick+0x10c
 0.02% 0.11%  2.8us(  36us)  4.5us( 9.0us)(0.00%)      8296 99.9% 0.11%    0%  scheduler_tick+0x80
 0.00%    0%  2.3us(  16us)    0us                      201  100%    0%    0%  send_sig_info+0x4c
 0.00%    0%  0.9us( 0.9us)    0us                        5  100%    0%    0%  shmem_getpage_locked+0xd4
 0.00%    0%  3.1us( 5.8us)    0us                       10  100%    0%    0%  shmem_truncate+0x44
 0.00%    0%  1.0us( 3.3us)    0us                        4  100%    0%    0%  skb_recv_datagram+0x90
 0.00%    0%  0.5us( 3.1us)    0us                       14  100%    0%    0%  sock_fasync+0x288
 0.00%    0%  0.4us( 2.7us)    0us                       14  100%    0%    0%  sock_fasync+0x70
 0.00%    0%  0.2us( 2.7us)    0us                       63  100%    0%    0%  sys_rt_sigprocmask+0x1ac
 0.00%    0%  0.3us( 3.6us)    0us                      914  100%    0%    0%  sys_rt_sigprocmask+0x98
 0.00%    0%  0.4us( 2.6us)    0us                       95  100%    0%    0%  sys_sigreturn+0x80
 0.00%    0%  0.6us( 3.2us)    0us                       19  100%    0%    0%  tcp_sendmsg+0x1054
 0.00%    0%  0.4us( 0.7us)    0us                       19  100%    0%    0%  tcp_sendmsg+0x3c
 0.00%    0%   68us( 260us)    0us                       29  100%    0%    0%  tcp_v4_rcv+0x2f0
 0.00%    0%  2.2us( 2.6us)    0us                        7  100%    0%    0%  tcp_write_timer+0x18
 0.19%  9.3%  2.3us(  51us)  6.3us( 231us)(0.01%)     88428 90.7%  9.3%    0%  try_to_wake_up+0x3c
 0.00%    0%  0.2us( 1.6us)    0us                       16  100%    0%    0%  unix_release_sock+0x1bc
 0.00%    0%  0.8us(  10us)    0us                       16  100%    0%    0%  unix_sock_destructor+0x2c
 0.00%    0%  0.9us( 3.1us)    0us                        4  100%    0%    0%  unix_stream_recvmsg+0x11c
 0.00%    0%  2.2us( 3.4us)    0us                        2  100%    0%    0%  unix_stream_sendmsg+0x230
 0.00%    0%  1.2us( 4.4us)    0us                       33  100%    0%    0%  unmap_fixup+0xa8
 0.00%    0%  0.8us( 2.6us)    0us                       33  100%    0%    0%  unmap_fixup+0xb8
 0.00%    0%  0.2us( 1.4us)    0us                      111  100%    0%    0%  vma_merge+0x54
 0.00%    0%  0.4us(  10us)    0us                    10240  100%    0%    0%  vmtruncate+0x50
 0.00%  2.1%  0.3us( 2.3us)  2.5us( 3.5us)(0.00%)        97 97.9%  2.1%    0%  wait_task_inactive+0x6c
 0.00%    0%  0.4us( 3.2us)    0us                       98  100%    0%    0%  wake_up_forked_process+0x30
 0.02%    0%   12us( 239us)    0us                     2100  100%    0%    0%  zap_page_range+0x58

- - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK READS   HOLD    MAX  RDR BUSY PERIOD      WAIT
  UTIL  CON    MEAN   RDRS   MEAN(  MAX )   MEAN(  MAX )( %CPU)     TOTAL NOWAIT SPIN  NAME

       0.50%                               3.7us( 199us)(0.01%)   5940740 99.5% 0.50%  *TOTAL*

 0.00%    0%   0.4us     1  0.4us( 2.3us)    0us                       14  100%    0%  [0xf712c3c4]
          0%                                 0us                       14  100%    0%    do_select+0x28

 0.00%    0%   0.7us     1  0.7us( 2.8us)    0us                       30  100%    0%  [0xf72c1534]
          0%                                 0us                       30  100%    0%    ip_output+0x68

 0.00%    0%   1.6us     1  1.6us( 1.9us)    0us                        7  100%    0%  [0xf74ef8f0]
          0%                                 0us                        7  100%    0%    tcp_v4_rcv+0x1b0

 0.00%    0%   1.5us     1  1.5us( 2.1us)    0us                        7  100%    0%  [0xf7706ef4]
          0%                                 0us                        7  100%    0%    ip_route_input+0x88

 0.00%    0%   0.7us     1  0.7us( 1.3us)    0us                       18  100%    0%  binfmt_lock
          0%                                 0us                       18  100%    0%    search_binary_handler+0x38

 0.00%    0%   0.7us     1  0.7us( 1.2us)    0us                        7  100%    0%  chrdevs_lock
          0%                                 0us                        7  100%    0%    get_chrfops+0x28

 0.96% 0.02%   0.4us     4  0.4us( 115us)  1.9us(  40us)(0.00%)   2335803  100% 0.02%  dparent_lock
          0%                                 0us                        3  100%    0%    do_readv_writev+0x28c
          0%                                 0us                    10240  100%    0%    notify_change+0xcc
       0.03%                               1.8us( 7.9us)(0.00%)    459501  100% 0.03%    sys_read+0xac
       0.02%                               2.0us(  40us)(0.00%)   1866059  100% 0.02%    sys_write+0xac

 0.00%    0%   0.4us     1  0.4us( 1.4us)    0us                       26  100%    0%  fasync_lock
          0%                                 0us                       26  100%    0%    kill_fasync+0x18

 0.00%    0%   0.4us     1  0.4us(  26us)    0us                     3604  100%    0%  gendisk_lock
          0%                                 0us                     3604  100%    0%    get_gendisk+0x10

  1.3%  1.6%   0.8us     5  0.8us( 227us)  3.7us( 199us)(0.01%)   1819524 98.4%  1.6%  hash_table_lock
        1.6%                               3.7us( 199us)(0.01%)   1819524 98.4%  1.6%    __get_hash_table+0x58

 0.00% 0.31%  10.4us     1   10us(  72us)  2.2us( 2.2us)(0.00%)       320 99.7% 0.31%  tasklist_lock
        4.8%                               2.2us( 2.2us)(0.00%)        21 95.2%  4.8%    count_active_tasks+0xc
          0%                                 0us                       98  100%    0%    exit_notify+0x18
          0%                                 0us                        5  100%    0%    kill_pg_info+0x20
          0%                                 0us                        1  100%    0%    sys_setsid+0x10
          0%                                 0us                      195  100%    0%    sys_wait4+0x94

 0.00%    0%   1.2us     1  1.2us( 7.9us)    0us                       81  100%    0%  xtime_lock
          0%                                 0us                       81  100%    0%    do_gettimeofday+0x14

          0%                                 0us                       48  100%    0%  copy_files+0x100
          0%                                 0us                       48  100%    0%  do_fork+0x38c
          0%                                 0us                   338296  100%    0%  ext2_get_branch+0x84
          0%                                 0us                  1214624  100%    0%  fget+0x1c
          0%                                 0us                       24  100%    0%  net_rx_action+0x48
          0%                                 0us                   227983  100%    0%  path_init+0x12c
          0%                                 0us                      276  100%    0%  path_init+0x34

- - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK WRITES     HOLD           WAIT (ALL)           WAIT (WW) 
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )( %CPU)   MEAN(  MAX )     TOTAL NOWAIT SPIN(  WW )  NAME

       0.50%  0.4us( 185us)  2.7us( 295us)(0.01%)  0.8us(  58us)   6553030 99.5% 0.45%(0.04%)  *TOTAL*

    0%    0%                   0us                   0us                 4  100%    0%(   0%)  [0xf3765d00]
    0%    0%                   0us                   0us                 2  100%    0%(   0%)    udp_connect+0x40
    0%    0%                   0us                   0us                 2  100%    0%(   0%)    udp_connect+0x1d4

    0%    0%                   0us                   0us                 2  100%    0%(   0%)  [0xf3765d70]
    0%    0%                   0us                   0us                 2  100%    0%(   0%)    inet_sock_release+0x44

    0%    0%                   0us                   0us                 2  100%    0%(   0%)  [0xf3816d70]
    0%    0%                   0us                   0us                 1  100%    0%(   0%)    inet_accept+0xd8
    0%    0%                   0us                   0us                 1  100%    0%(   0%)    tcp_close+0x4c4

    0%    0%                   0us                   0us                 1  100%    0%(   0%)  [0xf6f3a4e4]
    0%    0%                   0us                   0us                 1  100%    0%(   0%)    sys_chdir+0x5c

    0%    0%                   0us                   0us                 3  100%    0%(   0%)  [0xf70eaf44]
    0%    0%                   0us                   0us                 3  100%    0%(   0%)    neigh_periodic_timer__thr+0xa8

 0.00%    0%  0.2us( 0.2us)    0us                   0us                 6  100%    0%(   0%)  [0xf712c204]
 0.00%    0%  0.2us( 0.2us)    0us                   0us                 6  100%    0%(   0%)    flush_old_exec+0x27c

    0%    0%                   0us                   0us                 3  100%    0%(   0%)  [0xf71c51ec]
    0%    0%                   0us                   0us                 3  100%    0%(   0%)    unix_shutdown+0x28

    0%    0%                   0us                   0us                 3  100%    0%(   0%)  [0xf71c536c]
    0%    0%                   0us                   0us                 3  100%    0%(   0%)    unix_shutdown+0x88

    0%    0%                   0us                   0us                 2  100%    0%(   0%)  [0xf7288c98]
    0%    0%                   0us                   0us                 1  100%    0%(   0%)    tcp_check_req+0x268
    0%    0%                   0us                   0us                 1  100%    0%(   0%)    tcp_v4_synq_add+0x68

    0%    0%                   0us                   0us                 2  100%    0%(   0%)  [0xf74ea8a0]
    0%    0%                   0us                   0us                 1  100%    0%(   0%)    tcp_unhash+0x60
    0%    0%                   0us                   0us                 1  100%    0%(   0%)    tcp_v4_syn_recv_sock+0x1bc

    0%    0%                   0us                   0us                 1  100%    0%(   0%)  [0xf7706f74]
    0%    0%                   0us                   0us                 1  100%    0%(   0%)    rt_intern_hash+0x64

    0%    0%                   0us                   0us                 3  100%    0%(   0%)  arp_tbl+0xc4
    0%    0%                   0us                   0us                 3  100%    0%(   0%)    neigh_periodic_timer__thr+0x20

 0.00%    0%  1.0us( 1.3us)    0us                   0us                11  100%    0%(   0%)  dn_lock
 0.00%    0%  1.0us( 1.3us)    0us                   0us                11  100%    0%(   0%)    fcntl_dirnotify+0x94

 0.01%  2.8%  0.4us(  41us)  3.2us(  82us)(0.00%)  0.4us( 2.8us)     15600 97.2%  2.6%(0.26%)  dparent_lock
 0.01%  2.8%  0.4us(  41us)  3.2us(  82us)(0.00%)  0.4us( 2.8us)     15600 97.2%  2.6%(0.26%)    d_move+0xdc

 0.00%    0%  0.5us( 0.6us)    0us                   0us                 5  100%    0%(   0%)  fasync_lock
 0.00%    0%  0.5us( 0.6us)    0us                   0us                 5  100%    0%(   0%)    fasync_helper+0x68

  2.0%  1.6%  1.1us( 185us)  2.7us( 295us)(0.01%)  0.8us(  58us)   1950646 98.4%  1.5%(0.15%)  hash_table_lock
 0.02%  7.5%  1.3us(  26us)  5.0us(  58us)(0.00%)  2.8us(  58us)     12076 92.5%  5.1%( 2.3%)    hash_page_buffers+0x38
 0.34%  1.6%  0.4us( 153us)  2.5us( 217us)(0.00%)  0.5us(  24us)    968245 98.4%  1.4%(0.18%)    remove_from_queues+0x18
  1.6%  1.6%  1.7us( 185us)  2.7us( 295us)(0.01%)  0.7us(  13us)    970325 98.4%  1.5%(0.09%)    try_to_free_buffers+0x44

 0.00%    0%  4.6us(  49us)    0us                   0us               293  100%    0%(   0%)  tasklist_lock
 0.00%    0%  0.4us( 2.7us)    0us                   0us                98  100%    0%(   0%)    do_fork+0x5a4
 0.00%    0%   12us(  49us)    0us                   0us                98  100%    0%(   0%)    exit_notify+0x1b4
 0.00%    0%  1.6us( 6.3us)    0us                   0us                97  100%    0%(   0%)    release_task+0x40

    0%    0%                   0us                   0us                 4  100%    0%(   0%)  udp_hash_lock
    0%    0%                   0us                   0us                 2  100%    0%(   0%)    udp_v4_get_port+0x34
    0%    0%                   0us                   0us                 2  100%    0%(   0%)    udp_v4_unhash+0x20

    0%    0%                   0us                   0us                32  100%    0%(   0%)  unix_table_lock
    0%    0%                   0us                   0us                16  100%    0%(   0%)    unix_create1+0x100
    0%    0%                   0us                   0us                16  100%    0%(   0%)    unix_release_sock+0x14

 0.00%    0%  3.2us( 3.2us)    0us                   0us                 1  100%    0%(   0%)  vmlist_lock
 0.00%    0%  3.2us( 3.2us)    0us                   0us                 1  100%    0%(   0%)    get_vm_area+0x3c

 0.19% 0.00%  9.7us( 145us)   17us( 8.6us)(0.00%)  8.6us( 8.6us)     21056  100%    0%(0.00%)  xtime_lock
 0.02% 0.01%  2.1us(  22us)   17us( 8.6us)(0.00%)  8.6us( 8.6us)     10528  100%    0%(0.01%)    timer_bh+0xc
 0.17%    0%   17us( 145us)    0us                   0us             10528  100%    0%(   0%)    timer_interrupt+0x10

 0.00%    0%  0.1us( 2.6us)    0us                   0us                80  100%    0%(   0%)  expand_fd_array+0x13c
 0.00%    0%  1.5us(  15us)    0us                   0us                80  100%    0%(   0%)  expand_fd_array+0x88
 0.10%    0%  0.1us(  75us)    0us                   0us            984210  100%    0%(   0%)  ext2_alloc_block+0x18
 0.07%    0%  0.1us(  60us)    0us                   0us            599617  100%    0%(   0%)  ext2_discard_prealloc+0x10
 0.14%    0%  0.1us( 110us)    0us                   0us            968289  100%    0%(   0%)  ext2_get_block+0x128
 0.11%    0%  0.1us( 104us)    0us                   0us            968289  100%    0%(   0%)  ext2_get_block+0x28c
 0.04%    0%  0.2us(  56us)    0us                   0us            173140  100%    0%(   0%)  ext2_new_block+0x4c4
 0.01%    0%  0.0us(  23us)    0us                   0us            290512  100%    0%(   0%)  fd_install+0x20
 0.00%    0%  0.2us( 0.5us)    0us                   0us                18  100%    0%(   0%)  flush_old_exec+0x214
 0.04%    0%  0.1us(  52us)    0us                   0us            290548  100%    0%(   0%)  get_unused_fd+0x24
 0.00%    0%  0.1us( 0.3us)    0us                   0us                36  100%    0%(   0%)  put_unused_fd+0x1c
    0%    0%                   0us                   0us               369  100%    0%(   0%)  rt_check_expire__thr+0x64
 0.00%    0%  0.1us( 0.2us)    0us                   0us                27  100%    0%(   0%)  set_close_on_exec+0x1c
 0.02%    0%  0.1us(  20us)    0us                   0us            290079  100%    0%(   0%)  sys_close+0x20
 0.00%    0%  0.4us( 1.1us)    0us                   0us                18  100%    0%(   0%)  sys_dup2+0x2c
    0%    0%                   0us                   0us                 2  100%    0%(   0%)  unix_dgram_connect+0x8c
    0%    0%                   0us                   0us                 4  100%    0%(   0%)  unix_release_sock+0x114
    0%    0%                   0us                   0us                16  100%    0%(   0%)  unix_release_sock+0x34
    0%    0%                   0us                   0us                16  100%    0%(   0%)  unix_release_sock+0x54
_________________________________________________________________________________________________________________________
Number of read locks found=12

--------------070500030806000405010903--

