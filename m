Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275120AbRJDULu>; Thu, 4 Oct 2001 16:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276984AbRJDULl>; Thu, 4 Oct 2001 16:11:41 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:5898 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S275120AbRJDULh>; Thu, 4 Oct 2001 16:11:37 -0400
Message-ID: <3BBCC246.2060206@zk3.dec.com>
Date: Thu, 04 Oct 2001 16:10:46 -0400
From: Peter Rival <frival@zk3.dec.com>
Organization: Tru64 QMG Performance Engineering
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Some 2.4.9 vs. 2.4.10 results
Content-Type: multipart/mixed;
 boundary="------------010309020808080301070000"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010309020808080301070000
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

	I just thought I'd pop in my two cents on this whole topic.  In short 
form, on my Alpha GS80 (8 CPUs, 8 GB, 40 U160 disks/4x2channel adapters, 
2 NUMA nodes) 2.4.9 is almost unusable while 2.4.10 flies quite nicely. 
  Under 2.4.9 even things as simple as a mke2fs on a single 18 GB drive 
took minutes, while under 2.4.10 only seconds.  When I say 2.4.10, it's 
actually 2.4.10+the vm_tweak patch.

	I'm attaching a copy of the results of an AIM VII "shared" run as well as 
a lockstat report from a 500 user datapoint under 2.4.10.  If there is 
desire, I can generate a lockstat report for 2.4.9 as well.  I'm also 
going to see if I can get our profiling package to work on this system 
again, and if so I'll forward along those results as well.

	And not to bring up another old string, but just for giggles I removed 
the lock_kernel()/unlock_kernel() in llseek() to see what came of it. 
In short, a 2.2% gain in throughput and nearly 50% drop in the amount of 
time the kernel_lock is taken under this load.  Definitely looking 
forward to 2.5. ;)  Anyway, if there is something else anyone would be 
interested in that would be useful to run under this load (or a 
different set of statistics), feel free to let me know.

  - Pete

--------------010309020808080301070000
Content-Type: text/plain;
 name="suite7.ss"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="suite7.ss"

Column explanation:
	Tasks: the number of "users" simulated, roughly a load factor
	Jobs/Min: the "throughput" of the system at this load
	JTI: a mathematical calculation of the fairness of the scheduler
	Real: amount of "wall" time this load took to complete
	CPU: amount of "CPU" time this load took to complete
	J/S/T: stands for "Jobs per Second per Task"
	user: reported user-space time in seconds
	sys: reported system (i.e. kernel) time in seconds
	idle/wait: reported "other" time in seconds (mostly disk wait)
The test stops when the "Tasks" column exceeds the "Jobs/Min" column - what AIM calls "crossover".  I didn't use the "adaptive" timer which finds the exact crossover, as that's not what I was looking for.

Linux 2.4.9
-----------
Benchmark	Version	Machine	Run Date
AIM Multiuser Benchmark - Suite VII	"1.0"	sundown2	Oct  2 07:47:40 2001

Tasks	Jobs/Min	JTI	Real	CPU	J/S/T	user	sys	idle/wait
1	11.8		100	492.0	10.9	0.1972	1.4	16.7	3917.9
500	2801.9		97	1038.6	7724.7	0.0934	701.0	7049.8	558.0
1000	1584.9		97	3672.2	20877.7	0.0264	1403.5	19525.2	8448.7
1500	977.3		98	8932.7	40021.1	0.0109	2118.2	37992.6	31350.9

Linux 2.4.10
------------
Benchmark	Version	Machine	Run Date
AIM Multiuser Benchmark - Suite VII	"1.0"	sundown2	Oct  1 15:19:53 2001

Tasks	Jobs/Min	JTI	Real	CPU	J/S/T	user	sys	idle/wait
1	45.3		100	128.3	4.2	0.7558	1.4	4.0	1021.4
500	9365.5		97	310.7	1983.8	0.3122	683.7	1301.3	500.7
1000	4250.0		98	1369.4	6144.7	0.0708	1384.7	4772.7	4798.0
1500	4022.7		98	2170.2	9567.2	0.0447	2077.3	7531.2	7752.9
2000	2832.5		98	4109.4	14865.7	0.0236	2773.5	12142.4	17959.6
2500	1881.5		98	7733.4	20815.3	0.0125	3482.7	17349.2	41035.0

--------------010309020808080301070000
Content-Type: text/plain;
 name="lockstats"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lockstats"

System: Linux sundown2.zk3.dec.com 2.4.10 #1 SMP Mon Oct 1 12:53:08 EST 2001 alpha
Total counts
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
SPINLOCKS         HOLD            WAIT
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )(% CPU)     TOTAL NOWAIT SPIN RJECT  NAME

        5.1%  6.5us(3348ms)  128us(2187ms)(0.00%) 150957750 94.9%  5.1%    0%  *TOTAL*

 0.00%  1.4%  0.6us(  59ms)   14us(  66ms)(0.00%)   5802063 98.6%  1.4%    0%  dcache_lock
 0.00%  2.2%  0.1us(  18us)  8.8us( 801us)(0.00%)    117683 97.8%  2.2%    0%    d_alloc+0x1b4
 0.00%  3.4%  0.2us( 183us)  8.2us( 954us)(0.00%)    121495 96.6%  3.4%    0%    d_delete+0x30
 0.00% 0.02%  0.3us( 2.6us)  9.9us(  18us)(0.00%)      8937  100% 0.02%    0%    d_delete+0x10c
 0.00%  2.9%  0.1us( 201us)  8.3us(2212us)(0.00%)    239178 97.1%  2.9%    0%    d_instantiate+0x6c
 0.00%  1.8%  0.8us(  59ms)   14us(  59ms)(0.00%)   3799941 98.2%  1.8%    0%    d_lookup+0x8c
 0.00% 0.10%  0.1us( 8.6us)  8.5us(  93us)(0.00%)    117183  100% 0.10%    0%    d_rehash+0xa0
 0.00%    0%  0.1us( 1.5us)    0us                      936  100%    0%    0%    d_unhash+0x8c
 0.00%  6.1%  0.7us( 4.0us)  8.2us(  46us)(0.00%)      1501 93.9%  6.1%    0%    path_walk+0x170
 0.00% 0.05%  0.4us(  57ms)   15us( 401us)(0.00%)   1298224  100% 0.05%    0%    path_walk+0x3cc
 0.00%    0%  0.2us( 9.3us)    0us                      897  100%    0%    0%    path_walk+0x6a0
 0.00%    0%  1.2us( 3.1us)    0us                       78  100%    0%    0%    path_walk+0x8fc
 0.00%    0%   11us( 222us)    0us                      624  100%    0%    0%    prune_dcache+0x3c
 0.00%    0%  0.6us(  41ms)    0us                    87949  100%    0%    0%    prune_dcache+0x240
 0.00%    0%   45us( 323us)    0us                      936  100%    0%    0%    select_parent+0x38
 0.00%  2.4%  2.4us(  18us)  714us(  66ms)(0.00%)      6501 97.6%  2.4%    0%    sys_getcwd+0x16c

 0.00%  1.5%  2.1us(  71us)  3.9us(  49us)(0.00%)   2286450 98.5%  1.5%    0%  device_request_lock
 0.00%  2.4%  0.4us( 5.1us)  4.1us(  49us)(0.00%)   1143120 97.6%  2.4%    0%    __scsi_release_command+0x38
 0.00% 0.57%  3.9us(  71us)  2.8us( 7.1us)(0.00%)   1143330 99.4% 0.57%    0%    scsi_allocate_device+0x70

 0.00%  1.9%  0.5us(  31ms)  7.7us(  31ms)(0.00%)   2436724 98.1%  1.9%    0%  files_lock
 0.00%  2.2%  0.1us(3084us)  5.6us(1076us)(0.00%)    812209 97.8%  2.2%    0%    file_move+0x38
 0.00%  2.2%  0.2us( 350us)   10us(  31ms)(0.00%)    800474 97.8%  2.2%    0%    fput+0x10c
 0.00%  1.3%  1.1us(  31ms)  6.3us(2052us)(0.00%)    811100 98.7%  1.3%    0%    get_empty_filp+0x30
 0.00%  1.1%  0.9us( 4.9us)  5.4us(  15us)(0.00%)      2323 98.9%  1.1%    0%    get_empty_filp+0x14c
 0.00% 0.28%  0.1us( 6.4us)  7.7us(  17us)(0.00%)     10618 99.7% 0.28%    0%    put_filp+0x4c

 0.00%  1.5%  0.8us(1458us)  5.0us(5681us)(0.00%)   3165251 98.5%  1.5%    0%  inode_lock
 0.00%  2.3%  0.2us( 724us)  5.0us(5681us)(0.00%)   1140118 97.7%  2.3%    0%    __mark_inode_dirty+0x6c
 0.00% 0.69%  0.1us(1458us)  6.4us(1263us)(0.00%)    783000 99.3% 0.69%    0%    generic_osync_inode+0x80
 0.00%  1.5%  0.2us( 173us)  5.4us( 871us)(0.00%)     83059 98.5%  1.5%    0%    get_empty_inode+0x54
 0.00% 0.50%  0.4us( 7.1us)  4.0us(  12us)(0.00%)      8404 99.5% 0.50%    0%    get_new_inode+0x74
 0.00%    0%  5.9us(  37us)    0us                       23  100%    0%    0%    get_super_to_sync+0x28
 0.00% 0.91%  0.5us( 7.0us)  4.0us(  18us)(0.00%)     18624 99.1% 0.91%    0%    iget4+0x84
 0.00%  1.1%  0.2us( 206us)  4.0us(  19us)(0.00%)     74054 98.9%  1.1%    0%    insert_inode_hash+0x78
 0.00%    0%  0.5us( 2.3us)    0us                       20  100%    0%    0%    sync_inodes_sb+0x3c
 0.00%    0%  1.4us( 3.0us)    0us                      444  100%    0%    0%    sync_inodes_sb+0x19c
 0.00%  1.8%   10us(  16us)  701us( 701us)(0.00%)        57 98.2%  1.8%    0%    sync_unlocked_inodes+0x2c
 0.00% 0.27%  2.4us( 184us)  3.6us(  16us)(0.00%)     24414 99.7% 0.27%    0%    sync_unlocked_inodes+0x1ac
 0.00% 0.11%  0.4us( 472us)  5.3us(  57us)(0.00%)    516517 99.9% 0.11%    0%    write_inode_now+0x48
 0.00%  2.2%  3.9us(1355us)  4.1us( 510us)(0.00%)    516517 97.8%  2.2%    0%    write_inode_now+0x25c

 0.00% 12.2%  6.3us(  83us)   13us(1131us)(0.00%)   6911039 87.8% 12.2%    0%  io_request_lock
 0.00%  6.4%  0.1us( 0.4us)  2.5us( 5.3us)(0.00%)        78 93.6%  6.4%    0%    __get_request_wait+0x7c
 0.00% 16.0%  6.6us(  36us)   13us( 885us)(0.00%)   1216991 84.0% 16.0%    0%    __make_request+0x13c
 0.00%  7.4%   14us(  32us)  9.3us(  21us)(0.00%)       352 92.6%  7.4%    0%    do_isp1020_intr_handler+0x4c
 0.00% 17.5%   10us(  83us)   12us(1131us)(0.00%)   1121137 82.5% 17.5%    0%    generic_unplug_device+0x34
 0.00% 17.5%   19us(  62us)   13us( 794us)(0.00%)   1142769 82.5% 17.5%    0%    scsi_dispatch_cmd+0x140
 0.00% 10.5%  8.7us(  23us)  9.4us(  40us)(0.00%)       352 89.5% 10.5%    0%    scsi_dispatch_cmd+0x1dc
 0.00%  5.2%  0.0us( 2.9us)   13us( 127us)(0.00%)   1142768 94.8%  5.2%    0%    scsi_finish_command+0x4c
 0.00% 0.28%  0.2us( 8.0us)  5.2us( 5.2us)(0.00%)       352 99.7% 0.28%    0%    scsi_old_done+0x740
 0.00% 15.7%  1.1us(  31us)   12us( 134us)(0.00%)   1143120 84.3% 15.7%    0%    scsi_queue_next_request+0x48
 0.00%  1.2%  0.3us(  32us)   15us( 433us)(0.00%)   1143120 98.8%  1.2%    0%    scsi_request_fn+0x490

 0.00% 13.2%  9.4us(  69ms)   83us(2187ms)(0.00%)   8323717 86.8% 13.2%    0%  kernel_flag
 0.00%  6.0%  0.9us( 9.4us)  134us(7015us)(0.00%)     12196 94.0%  6.0%    0%    chrdev_open+0x70
 0.00% 21.5%  0.7us( 8.5us)  111us(2877us)(0.00%)      8293 78.5% 21.5%    0%    de_put+0x3c
 0.00% 27.2%  464us(  69ms)  146us(  13ms)(0.00%)     62702 72.8% 27.2%    0%    do_exit+0x1a4
 0.00%  9.7%   17us(6217us)   40us(4783us)(0.00%)     74053 90.3%  9.7%    0%    ext2_delete_inode+0x38
 0.00% 13.5%  0.2us( 767us)   25us( 163ms)(0.00%)    706419 86.5% 13.5%    0%    ext2_discard_prealloc+0x38
 0.00% 14.6%  5.3us(  13ms)   60us(1814ms)(0.00%)   1774326 85.4% 14.6%    0%    ext2_get_block+0x84
 0.00% 18.6%   44us(7402us)  207us( 896ms)(0.00%)    516517 81.4% 18.6%    0%    ext2_write_inode+0x40
 0.00%    0%   99us( 206us)    0us                        3  100%    0%    0%    fsync_dev+0x40
 0.00% 26.5%  4.0us(  80us)  161us(  13ms)(0.00%)     10618 73.5% 26.5%    0%    get_chrfops+0xf8
 0.00% 14.0%  8.5us(1355us)   68us(  68ms)(0.00%)    100173 86.0% 14.0%    0%    lookup_hash+0xc8
 0.00% 11.5%  3.1us(1260us)   36us(  69ms)(0.00%)    502464 88.5% 11.5%    0%    notify_change+0xa0
 0.00% 21.4%   30us(  65us)  135us(4200us)(0.00%)       500 78.6% 21.4%    0%    osf_shmat+0x48
 0.00% 25.0%   31us( 789us)  144us(7949us)(0.00%)      8505 75.0% 25.0%    0%    real_lookup+0xd0
 0.00% 21.5%   13us(7861us)  175us( 151ms)(0.00%)    643746 78.5% 21.5%    0%    schedule+0x594
 0.00% 21.1% 4911us(7887us)   77us( 300us)(0.00%)        57 78.9% 21.1%    0%    sync_old_buffers+0x38
 0.00% 17.5%  1.0us( 168us)   87us(8398us)(0.00%)     25198 82.5% 17.5%    0%    sys_ioctl+0x70
 0.00% 10.3%  0.1us( 498us)   54us(2187ms)(0.00%)   3504008 89.7% 10.3%    0%    sys_lseek+0x88
 0.00%    0%  3.1us( 6.7us)    0us                       39  100%    0%    0%    sys_sysctl+0x7c
 0.00%    0%  8.6us(  34us)    0us                       63  100%    0%    0%    tty_write+0x278
 0.00%  8.3%   17us(6743us)   22us(8082us)(0.00%)     73118 91.7%  8.3%    0%    vfs_create+0xdc
 0.00%  9.7%  5.8us(1171us)   65us(  84ms)(0.00%)     47441 90.3%  9.7%    0%    vfs_link+0xf8
 0.00%    0%   67us( 194us)    0us                      936  100%    0%    0%    vfs_mkdir+0xd0
 0.00% 12.1%   11us(1034us)   43us(  30ms)(0.00%)    130847 87.9% 12.1%    0%    vfs_readdir+0xec
 0.00%    0%   11us(  31us)    0us                      936  100%    0%    0%    vfs_rmdir+0x21c
 0.00% 12.7%  6.4us( 664us)   40us(  82ms)(0.00%)    120559 87.3% 12.7%    0%    vfs_unlink+0x188

 0.00%  5.1%  0.8us(  13ms)  9.2us( 318ms)(0.00%)  18109739 94.9%  5.1%    0%  lru_list_lock
 0.00%  3.5%  2.9us(  71us)   14us( 222us)(0.00%)      7539 96.5%  3.5%    0%    __bforget+0x28
 0.00% 0.24%  0.1us( 299us)   10us( 451us)(0.00%)   2428859 99.8% 0.24%    0%    buffer_insert_inode_data_queue+0x30
 0.00%  2.2%  0.1us( 605us)  7.7us(1500us)(0.00%)   1682552 97.8%  2.2%    0%    buffer_insert_inode_queue+0x30
 0.00% 11.6%  0.1us( 318us)  7.5us(7457us)(0.00%)    783000 88.4% 11.6%    0%    fsync_inode_buffers+0x40
 0.00%  9.7%  0.3us( 9.4us)  7.4us(4675us)(0.00%)    119500 90.3%  9.7%    0%    fsync_inode_buffers+0x13c
 0.00%  5.1%  0.3us( 9.2us)  9.3us( 931us)(0.00%)    119500 94.9%  5.1%    0%    fsync_inode_buffers+0x200
 0.00% 0.73%  0.4us( 508us)  8.3us(5688us)(0.00%)    783000 99.3% 0.73%    0%    fsync_inode_data_buffers+0x40
 0.00%  7.9%  0.1us( 817us)   12us( 318ms)(0.00%)    848000 92.1%  7.9%    0%    fsync_inode_data_buffers+0x13c
 0.00%  4.7%  0.3us( 768us)   18us(  13ms)(0.00%)    846833 95.3%  4.7%    0%    fsync_inode_data_buffers+0x200
 0.00%  7.4%  1.4us(1448us)  8.4us(  13ms)(0.00%)   2312782 92.6%  7.4%    0%    getblk+0x4c
 0.00%  5.0%  0.2us(  59us)   13us(4357us)(0.00%)     91352 95.0%  5.0%    0%    inode_has_buffers+0x30
 0.00%  6.0%  0.2us(  87us)  8.9us(5212us)(0.00%)     83057 94.0%  6.0%    0%    invalidate_inode_buffers+0x30
 0.00%  3.5% 5332us(  13ms) 10.0us(  14us)(0.00%)        57 96.5%  3.5%    0%    kupdate+0x11c
 0.00% 0.10%  0.1us(  33us)  9.4us( 104us)(0.00%)    783000 99.9% 0.10%    0%    osync_inode_buffers+0x40
 0.00% 0.16%  0.2us( 191us)  9.3us( 645us)(0.00%)    783000 99.8% 0.16%    0%    osync_inode_data_buffers+0x40
 0.00%  8.1%  1.1us(1315us)  8.8us( 105ms)(0.00%)   5545785 91.9%  8.1%    0%    refile_buffer+0x2c
 0.00%  8.5%   27us(  91us)   17us( 226us)(0.00%)       316 91.5%  8.5%    0%    sync_old_buffers+0xb8
 0.00%  2.7%  3.7us( 855us)  9.0us(1000us)(0.00%)    891124 97.3%  2.7%    0%    try_to_free_buffers+0x64
 0.00%    0%  2.5us(  26us)    0us                       24  100%    0%    0%    wait_for_locked_buffers+0x3c
 0.00%    0%   18us(  27us)    0us                      459  100%    0%    0%    write_unlocked_buffers+0x2c

 0.00%  7.3%  0.4us(1172us)  5.7us( 125ms)(0.00%)  21414541 92.7%  7.3%    0%  pagecache_lock
 0.00%  9.7%  0.9us(1172us)  5.7us(1345us)(0.00%)   2995090 90.3%  9.7%    0%    __find_get_page+0x38
 0.00%  7.1%  0.1us( 546us)  5.8us( 125ms)(0.00%)   8965440 92.9%  7.1%    0%    __find_lock_page+0x38
 0.00%  7.4%  0.1us( 2.3us)  5.4us(  29us)(0.00%)       500 92.6%  7.4%    0%    __set_page_dirty+0x34
 0.00%  7.2%  7.4us(  15us)  3.5us(  14us)(0.00%)       500 92.8%  7.2%    0%    add_to_page_cache+0x48
 0.00%  6.2%  3.6us( 923us)  5.9us( 466us)(0.00%)    891572 93.8%  6.2%    0%    add_to_page_cache_unique+0x44
 0.00%  8.1%  0.2us(1149us)  5.7us(  41ms)(0.00%)   5186669 91.9%  8.1%    0%    do_generic_file_read+0x258
 0.00%    0%  2.7us(  12us)    0us                       20  100%    0%    0%    do_generic_file_read+0x5b8
 0.00%  4.5%  0.1us( 525us)  5.0us( 989us)(0.00%)    541375 95.5%  4.5%    0%    filemap_fdatasync+0x48
 0.00%  4.5%  0.1us(  14us)  4.9us( 911us)(0.00%)    541375 95.5%  4.5%    0%    filemap_fdatawait+0x34
 0.00%  1.7%  0.1us( 2.4us)  5.1us( 7.4us)(0.00%)       237 98.3%  1.7%    0%    page_cache_read+0x7c
 0.00%  6.7%  0.2us( 427us)  6.1us(  12ms)(0.00%)    891624 93.3%  6.7%    0%    remove_inode_page+0x54
 0.00%  6.3%  0.2us( 382us)  5.0us( 839us)(0.00%)    508515 93.7%  6.3%    0%    truncate_inode_pages+0x54
 0.00%  3.4%  0.2us( 200us)  6.3us( 751us)(0.00%)    891624 96.6%  3.4%    0%    truncate_list_pages+0x2ac

 0.00% 71.0%   62us( 529us)  310us(  62ms)(0.00%)   3906233 29.0% 71.0%    0%  runqueue_lock
 0.00% 64.8%  2.6us(  14us)  172us(  43ms)(0.00%)   1608940 35.2% 64.8%    0%    __wake_up+0xc8
 0.00% 20.7%  0.0us( 3.2us)  226us(  57ms)(0.00%)    500501 79.3% 20.7%    0%    deliver_signal+0x58
 0.00% 42.4%  2.4us( 6.6us)  224us( 735us)(0.00%)       118 57.6% 42.4%    0%    process_timeout+0x3c
 0.00% 83.2%  4.0us(  12us)  660us(  31ms)(0.00%)      1025 16.8% 83.2%    0%    schedule_tail+0xa4
 0.00% 90.9%  139us( 529us)  397us(  62ms)(0.00%)   1706685  9.1% 90.9%    0%    schedule+0xfc
 0.00% 70.1%  4.5us(  13us) 1028us(  55ms)(0.00%)     24689 29.9% 70.1%    0%    schedule+0x534
 0.00% 29.0%   29us( 205us)  154us( 697us)(0.00%)       310 71.0% 29.0%    0%    schedule+0x654
 0.00% 86.0%  3.8us(  11us)  394us(  55ms)(0.00%)     63965 14.0% 86.0%    0%    wake_up_process+0x44

 0.00%  2.5%  0.1us(  37us)  2.6us(  24us)(0.00%)   2541315 97.5%  2.5%    0%  timerlist_lock
 0.00%  1.7%  0.2us( 6.5us)  2.1us(  24us)(0.00%)   1143367 98.3%  1.7%    0%    add_timer+0x3c
 0.00%  3.6%  0.1us( 4.5us)  2.7us(  13us)(0.00%)   1146093 96.4%  3.6%    0%    del_timer+0x38
 0.00%  1.9%  0.2us( 3.2us)  3.1us(  11us)(0.00%)     62820 98.1%  1.9%    0%    del_timer_sync+0x48
 0.00%  2.4%  0.3us( 5.2us)  3.9us(  16us)(0.00%)     84360 97.6%  2.4%    0%    mod_timer+0x3c
 0.00% 0.07%  0.2us(  37us)  3.3us( 8.7us)(0.00%)    104039  100% 0.07%    0%    timer_bh+0x148
 0.00% 0.47%  3.3us(  24us)  6.6us( 8.9us)(0.00%)       636 99.5% 0.47%    0%    timer_bh+0x39c

 0.00%  1.4%  0.2us(1115us)   11us(  59ms)(0.00%)   6961760 98.6%  1.4%    0%  atomic_dec_and_lock+0x2c
 0.00%  2.0%  0.6us( 7.1us)  143us( 915us)(0.00%)   1578341 98.0%  2.0%    0%  remove_wait_queue+0x3c
 0.00%  1.0%  0.5us(  12us)  2.3us(  29us)(0.00%)   3515524 99.0%  1.0%    0%  rmqueue+0x64

- - - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK READS   HOLD    MAX  RDR BUSY PERIOD      WAIT
  UTIL  CON    MEAN   RDRS   MEAN(  MAX )   MEAN(  MAX )( %CPU)     TOTAL NOWAIT SPIN  NAME

       0.34%                               8.7us(1417us)(0.00%)  21605003 99.7% 0.34%  *TOTAL*

 0.00%  4.6%   1.2us     2  1.2us(  15us)  4.9us(  39us)(0.00%)     12196 95.4%  4.6%  chrdevs_lock
        4.6%                               4.9us(  39us)(0.00%)     12196 95.4%  4.6%    get_chrfops+0x54

 0.00%  3.2%   0.9us     3  114us(4373ms)  6.5us( 828us)(0.00%)   1774074 96.8%  3.2%  hash_table_lock
        3.2%                               6.5us( 828us)(0.00%)   1774074 96.8%  3.2%    get_hash_table+0x3c

 0.00%  1.6%  Data Sync Error 5003us(4374ms)   22us(1417us)(0.00%)    748135 98.4%  1.6%  tasklist_lock
          0%                                 0us                       67  100%    0%    count_active_tasks+0x24
       0.38%                               3.7us(  10us)(0.00%)     62702 99.6% 0.38%    exit_notify+0x34
          0%                                 0us                        2  100%    0%    get_pid+0xac
          0%                                 0us                        1  100%    0%    kill_pg_info+0x50
        1.8%                                16us( 877us)(0.00%)    500000 98.2%  1.8%    kill_something_info+0x14c
          0%                                 0us                      310  100%    0%    schedule+0x5d8
          0%                                 0us                        1  100%    0%    sys_setsid+0x24
        1.4%                                44us(1417us)(0.00%)    185052 98.6%  1.4%    sys_wait4+0x94

 0.00%  2.7%   0.5us     2  140us(3773ms)  3.0us(  40us)(0.00%)    180933 97.3%  2.7%  xtime_lock
        2.7%                               3.0us(  40us)(0.00%)    180933 97.3%  2.7%    do_gettimeofday+0x48

- - - - - - - - - - -  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
RWLOCK WRITES     HOLD           WAIT (ALL)           WAIT (WW) 
  UTIL  CON    MEAN(  MAX )   MEAN(  MAX )( %CPU)   MEAN(  MAX )     TOTAL NOWAIT SPIN(  WW )  NAME

       0.63%  1.5us(1144us)  143us(  68ms)(0.00%)   14us(9399us)   6361658 99.4% 0.52%(0.11%)  *TOTAL*

 0.00%  2.5%  0.4us( 6.7us)  9.4us(  40us)(0.00%)  4.7us(  40us)      3911 97.5%    0%( 2.5%)  dn_lock
 0.00%  2.5%  0.4us( 6.7us)  9.4us(  40us)(0.00%)  4.7us(  40us)      3911 97.5%    0%( 2.5%)    fcntl_dirnotify+0xb8

 0.00%  9.2%   25us(1144us)  326us(  68ms)(0.00%)   55us(9399us)    188108 90.8%  8.3%(0.90%)  tasklist_lock
 0.00% 11.5%  1.9us(  10us)  353us(  50ms)(0.00%)   66us( 700us)     62704 88.5% 10.4%( 1.2%)    do_fork+0x5fc
 0.00%  4.0%   71us(1144us)   90us(  68ms)(0.00%)  4.7us(  42us)     62702 96.0%  2.9%( 1.2%)    exit_notify+0x21c
 0.00% 12.0%  1.9us( 9.8us)  381us(  55ms)(0.00%)  190us(9399us)     62702 88.0% 11.6%(0.35%)    release_task+0xf0
_________________________________________________________________________________________________________________________
Number of read locks found=13

--------------010309020808080301070000--

