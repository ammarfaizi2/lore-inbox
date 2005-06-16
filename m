Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVFPUO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVFPUO7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 16:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVFPUO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 16:14:59 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:7611 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261801AbVFPUOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 16:14:44 -0400
Subject: Re: 2.6.12-rc6-mm1 & 2K lun testing
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20050616002451.01f7e9ed.akpm@osdl.org>
References: <1118856977.4301.406.camel@dyn9047017072.beaverton.ibm.com>
	 <20050616002451.01f7e9ed.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-Gxikca/k6dV1W1LzAMgr"
Organization: 
Message-Id: <1118951458.4301.478.camel@dyn9047017072.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Jun 2005 12:50:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Gxikca/k6dV1W1LzAMgr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-06-16 at 00:24, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> >
> > I sniff tested 2K lun support with 2.6.12-rc6-mm1 on
> >  my AMD64 box. I had to tweak qlogic driver and
> >  scsi_scan.c to see all the luns.
> > 
> >  (2.6.12-rc6 doesn't see all the LUNS due to max_lun
> >  issue - which is fixed in scsi-git tree).
> > 
> >  Test 1:
> >  	run dds on all 2048 "raw" devices - worked
> >  great. No issues.
> > 
> >  Tests 2: 
> >  	run "dds" on 2048 filesystems (one file
> >  per filesystem). Kind of works. I was expecting better
> >  responsiveness & stability.
> > 
> > 
> >  Overall - Good news is, it works. 
> > 
> >  Not so good news - with filesystem tests, machine becomes 
> >  unresponsive, lots of page allocation failures but machine 
> >  stays up and completes the tests and recovers.
> 
> Any chance of getting a peek at /proc/slabinfo?
> 
> Presumably increasing /proc/sys/vm/min_free_kbytes will help.
> 
> We seem to be always ooming when allocating scsi command structures. 
> Perhaps the block-level request structures are being allocated with
> __GFP_WAIT, but it's a bit odd.  Which I/O scheduler?  If cfq, does
> reducing /sys/block/*/queue/nr_requests help?

Yes. I am using CFQ scheduler. I changed nr_requests to 4 for all
my devices. I also changed "min_free_kbytes" to 64M.

Response time is still bad. Here is the vmstat, meminfo, slabinfo
and profle output. I am not sure why profile output shows 
default_idle(), when vmstat shows 100% CPU sys.

Thanks
Badari



--=-Gxikca/k6dV1W1LzAMgr
Content-Disposition: attachment; filename=info
Content-Type: text/plain; name=info; charset=UTF-8
Content-Transfer-Encoding: 7bit

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
153 1926      4  76340   2512 6021272    0    0     3 17117  622  1611  0 100  0  0
103 1951      4  75772   2512 6023852    0    0    12 16905  635  1596  0 99  0  1
96 1799      4  75880   2508 6027468    0    0    18 15918  635  1564  0 99  0  1
58 1835      4  75856   2520 6030552    0    0   134 16289  642  1576  0 99  0  1
64 1949      4  76076   2520 6029520    0    0     6 17625  652  1680  0 100  0  0
51 1913      4  76500   2520 6027972    0    0    10 17326  643  1530  0 98  0  2
72 1917      4  76384   2520 6027456    0    0     4 17583  639  1473  0 97  0  3
95 1806      4  76028   2580 6028428    0    0     6 16613  638  1408  0 99  0  1
130 1748      4  75528   2560 6028448    0    0     8 17307  641  1402  0 100  0  0
154 1574      4  76172   2560 6028448    0    0     8 16299  629  1541  0 99  0  1
56 1991      4  75100   2540 6026920    0    0    46 38906 1419  3793  0 81  0 19
 9 1855      4  75900   2540 6026404    0    0    10 20220  776  2214  0 85  0 15
127 1924      4  76096   2540 6026920    0    0     4 17924  640  1719  0 100  0  0
27 1859      4  75936   2540 6027436    0    0     3 18290  629  1783  0 98  0  2
72 1910      4  75856   2568 6022764    0    0    77 17395  628  1677  0 100  0  0
116 1729      4  75784   2540 6025372    0    0    28 19086  697  2001  0 98  0  2
35 1986      4  75856   2556 6025872    0    0     6 16844  612  1796  0 99  0  1
90 1844      4  75632   2580 6026364    0    0    11 17891  630  1585  0 100  0  0
59 1964      4  75928   2568 6024828    0    0     7 17234  626  1656  0 98  0  2
88 1959      4  76140   2568 6026892    0    0     4 16050  617  1657  0 97  0  3
55 1956      4  75996   2564 6028444    0    0    24 16584  636  1840  0 99  0  1

elm3b29:/home/netapp # echo 2 > /proc/profile; sleep 15; readprofile -m /usr/src/linux-2.6.12-rc6/System.map | sort -nr +2 | head -30
 32043 default_idle                             667.5625
 17480 __wake_up_bit                            364.1667
 17436 unlock_page                              272.4375
843789 shrink_zone                              214.3773
  5936 lru_add_drain                             74.2000
 21214 rotate_reclaimable_page                   73.6597
  4466 page_waitqueue                            46.5208
 14714 page_referenced                           43.7917
 15628 release_pages                             34.8839
  3480 cond_resched                              31.0714
  1408 __mod_page_state                          29.3333
  6132 scsi_end_request                          23.9531
 13384 check_poison_obj                          23.2361
  6289 copy_user_generic                         21.1040
 22178 scsi_request_fn                           19.2517
  8692 kmem_cache_free                           15.5214
  1929 kmem_cache_alloc                          15.0703
  2922 __do_softirq                              12.1750
   299 __pagevec_release                          9.3438
  2042 __pagevec_lru_add                          9.1161
   115 obj_dbghead                                7.1875
   316 bio_get_nr_vecs                            4.9375
    76 blk_unplug_work                            4.7500
  1190 test_set_page_writeback                    3.9145
   283 end_page_writeback                         3.5375
   654 memset                                     3.4062
   430 __read_page_state                          3.3594
   549 scsi_queue_insert                          3.1193
    48 obj_reallen                                3.0000
  3971 __make_request                             2.8859

MemTotal:      7209056 kB
MemFree:         75972 kB
Buffers:          2568 kB
Cached:        6001608 kB
SwapCached:          0 kB
Active:         412260 kB
Inactive:      5675056 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      7209056 kB
LowFree:         75972 kB
SwapTotal:     1048784 kB
SwapFree:      1048780 kB
Dirty:         5896240 kB
Writeback:       81312 kB
Mapped:         410788 kB
Slab:           364192 kB
CommitLimit:   4653312 kB
Committed_AS:  2577920 kB
PageTables:      67528 kB
VmallocTotal: 34359738367 kB
VmallocUsed:      9920 kB
VmallocChunk: 34359728439 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     2048 kB
slabinfo - version: 2.1 (statistics)
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <limit> <batchcount> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail> : globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <nodeallocs> <remotefrees> : cpustat <allochit> <allocmiss> <freehit> <freemiss>
fib6_nodes             5     54     72   54    1 : tunables   32   16    8 : slabdata      1      1      0 : globalstat      32     32     2    1 				   0    0    0    5 : cpustat      8      2      0      0
ip6_dst_cache          4     12    320   12    1 : tunables   32   16    8 : slabdata      1      1      0 : globalstat      24     24     2    1 				   0    0    0    3 : cpustat     10      2      5      0
ndisc_cache            1     15    256   15    1 : tunables   32   16    8 : slabdata      1      1      0 : globalstat      30     30     2    1 				   0    0    0    1 : cpustat      2      2      2      0
RAWv6                  6      8    904    4    1 : tunables   32   16    8 : slabdata      2      2      0 : globalstat       8      8     2    0 				   0    0    0    0 : cpustat      4      2      0      0
UDPv6                  0      0    880    9    2 : tunables   32   16    8 : slabdata      0      0      0 : globalstat      90     29    10   10 				   0    0    0    0 : cpustat     14     10     24      0
request_sock_TCPv6      0      0    152   26    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
TCPv6                 10     20   1536    5    2 : tunables   24   12    8 : slabdata      4      4      0 : globalstat      38     13     4    0 				   0    0    0    0 : cpustat      8      9      7      0
scsi_cmd_cache      1649   1704    488    8    1 : tunables   32   16    8 : slabdata    209    213      0 : globalstat  271823   2040 19045  331 				   0    0    0 267119 : cpustat 7820052  27928 7578980    279
qla2xxx_srbs        1580   1700    160   25    1 : tunables   32   16    8 : slabdata     67     68      0 : globalstat  258249   1648  4839  353 				   0    0    0 254141 : cpustat 15170681  21793 14933929   2869
ip_fib_alias          11    207     56   69    1 : tunables   32   16    8 : slabdata      3      3      0 : globalstat      64     37     3    0 				   0    0    0    0 : cpustat      7      4      0      0
ip_fib_hash           11    183     64   61    1 : tunables   32   16    8 : slabdata      3      3      0 : globalstat      64     37     3    0 				   0    0    0    0 : cpustat      7      4      0      0
dm_tio                 0      0     48   81    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
dm_io                  0      0     56   69    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
rpc_buffers            8      9   2072    3    2 : tunables   24   12    8 : slabdata      3      3      0 : globalstat       9      9     3    0 				   0    0    0    0 : cpustat      5      3      0      0
rpc_tasks              8     10    384   10    1 : tunables   32   16    8 : slabdata      1      1      0 : globalstat      10     10     1    0 				   0    0    0    0 : cpustat      7      1      0      0
rpc_inode_cache        0      0    824    4    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
UNIX                  93    120    664    6    1 : tunables   32   16    8 : slabdata     20     20      0 : globalstat    5650   1530   269   32 				   0    1    0 4492 : cpustat  57136    750  53175    126
ip_mrt_cache           0      0    120   33    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
tcp_tw_bucket          0      0    200   20    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat      48     32     3    3 				   0    0    0    1 : cpustat      0      3      2      0
tcp_bind_bucket       11    276     56   69    1 : tunables   32   16    8 : slabdata      4      4      0 : globalstat     128     48     4    0 				   0    0    0    2 : cpustat      7      8      2      0
inet_peer_cache        1     45     88   45    1 : tunables   32   16    8 : slabdata      1      1      0 : globalstat      16     16     1    0 				   0    0    0    0 : cpustat      0      1      0      0
secpath_cache          0      0    160   25    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
xfrm_dst_cache         0      0    376   10    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
ip_dst_cache          34     55    352   11    1 : tunables   32   16    8 : slabdata      5      5      0 : globalstat    1372     45    20   15 				   0    0    0  238 : cpustat     99    171      1      0
arp_cache              2     16    248   16    1 : tunables   32   16    8 : slabdata      1      1      0 : globalstat      31     16     1    0 				   0    0    0    2 : cpustat      2      2      0      0
RAW                    5      5    728    5    1 : tunables   32   16    8 : slabdata      1      1      0 : globalstat       5      5     1    0 				   0    0    0    0 : cpustat      4      1      0      0
UDP                    8     20    736    5    1 : tunables   32   16    8 : slabdata      4      4      0 : globalstat      96     22    12    8 				   0    0    0    4 : cpustat     49     21     58      0
request_sock_TCP       0      0    104   38    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat      96     31     6    6 				   0    0    0    1 : cpustat      1      6      6      0
TCP                   12     25   1392    5    2 : tunables   24   12    8 : slabdata      5      5      0 : globalstat      63     20    10    5 				   0    0    0    3 : cpustat     19     14     18      0
flow_cache             0      0    136   29    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
cfq_ioc_pool           0      0    120   33    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
cfq_pool               0      0    176   22    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
crq_pool               0      0    112   35    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
deadline_drq           0      0    120   33    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
as_arq             20788  24354    144   27    1 : tunables   32   16    8 : slabdata    902    902    128 : globalstat 7302594  20552  3143   42 				   0    0    0 7028907 : cpustat 7831852 464581 1225487  21516
mqueue_inode_cache      1      4    912    4    1 : tunables   32   16    8 : slabdata      1      1      0 : globalstat       4      4     1    0 				   0    0    0    0 : cpustat      0      1      0      0
jfs_mp              9898  22572    144   27    1 : tunables   32   16    8 : slabdata    836    836      0 : globalstat   36371  19456   836    0 				   0    0    0 12035 : cpustat  22235   2728   2862    188
jfs_ip             14336  14340   1240    3    1 : tunables   24   12    8 : slabdata   4780   4780      0 : globalstat   14469  14338  4783    3 				   0    0    0    0 : cpustat   9562   4879    105      0
nfs_direct_cache       0      0     96   41    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
nfs_write_data        36     40    808    5    1 : tunables   32   16    8 : slabdata      8      8      0 : globalstat      40     40     8    0 				   0    0    0    0 : cpustat     28      8      0      0
nfs_read_data         32     35    776    5    1 : tunables   32   16    8 : slabdata      7      7      0 : globalstat      35     35     7    0 				   0    0    0    0 : cpustat     25      7      0      0
nfs_inode_cache        0      0   1024    4    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
nfs_page               0      0    120   33    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
isofs_inode_cache      0      0    672    6    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
minix_inode_cache      0      0    688    5    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
hugetlbfs_inode_cache      1      6    640    6    1 : tunables   32   16    8 : slabdata      1      1      0 : globalstat       6      6     1    0 				   0    0    0    0 : cpustat      0      1      0      0
ext2_inode_cache       0      0    784    5    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat      10      6     2    2 				   0    0    0    2 : cpustat      1      2      1      0
ext2_xattr             0      0    112   35    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
journal_handle         0      0     48   81    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
journal_head           0      0    120   33    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
revoke_table           0      0     40   96    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
revoke_record          0      0     56   69    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
ext3_inode_cache       0      0    832    4    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
ext3_xattr             0      0    112   35    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
reiser_inode_cache   2479   4645    744    5    1 : tunables   32   16    8 : slabdata    929    929      0 : globalstat   47749  38713  7992   12 				   0    5    0 36777 : cpustat  46050   8794  15147    441
dnotify_cache          0      0     64   61    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
dquot                  0      0    240   16    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
eventpoll_pwq          0      0     96   41    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
eventpoll_epi          0      0    176   22    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
inotify_event_cache      0      0     64   61    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
inotify_watch_cache      0      0     88   45    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
kioctx                 0      0    344   11    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
kiocb                  0      0    240   16    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
fasync_cache           1     81     48   81    1 : tunables   32   16    8 : slabdata      1      1      0 : globalstat      16     16     1    0 				   0    0    0    0 : cpustat      0      1      0      0
shmem_inode_cache     13     27    832    9    2 : tunables   32   16    8 : slabdata      3      3      0 : globalstat     207     36     7    4 				   0    0    0   13 : cpustat     45     27     46      0
posix_timers_cache      0      0    192   20    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
uid_cache              5    180     88   45    1 : tunables   32   16    8 : slabdata      4      4      0 : globalstat     160     48     4    0 				   0    0    0    2 : cpustat      1     10      4      0
sgpool-128            40     41   4096    1    1 : tunables   24   12    8 : slabdata     40     41      0 : globalstat   10180   1897  6838 3329 				   0   25    0 7536 : cpustat  23608   7788  23715    107
sgpool-64             48     54   2072    3    2 : tunables   24   12    8 : slabdata     17     18      0 : globalstat    9936    142   946  912 				   0    0    0 7932 : cpustat  32703   2991  27687     17
sgpool-32             76     91   1048    7    2 : tunables   24   12    8 : slabdata     12     13      0 : globalstat   23205    863   552  413 				   0    0    0 21347 : cpustat  88941   3350  70773     98
sgpool-16             57     84    536    7    1 : tunables   32   16    8 : slabdata     11     12      0 : globalstat   15172   1105   898  675 				   0    1    0 10527 : cpustat 104403   2486  96225     95
sgpool-8            1638   1694    280   14    1 : tunables   32   16    8 : slabdata    120    121      0 : globalstat  225720   1678 10531  485 				   0    0    0 221585 : cpustat 7581493  16716 7374798    222
blkdev_ioc          2396   3724     80   49    1 : tunables   32   16    8 : slabdata     76     76      0 : globalstat    8786   2807   124    1 				   0    0    0 3417 : cpustat   6496    668   1363      3
blkdev_queue        2077   2090    736    5    1 : tunables   32   16    8 : slabdata    418    418      0 : globalstat    2175   2088   418    0 				   0    0    0    0 : cpustat   1621    456      0      0
blkdev_requests    20704  24063    288   13    1 : tunables   32   16    8 : slabdata   1851   1851    128 : globalstat 7302343  20139  9680   74 				   0    1    0 7029127 : cpustat 7828154 468475 1225524  21502
biovec-(256)         260    260   4096    1    1 : tunables   24   12    8 : slabdata    260    260      0 : globalstat     260    260   260    0 				   0    0    0    0 : cpustat      0    260      0      0
biovec-128         20130  21342   2072    3    2 : tunables   24   12    8 : slabdata   7108   7114     96 : globalstat 14305237  50839 426881  321 				   0    9    0 13561933 : cpustat 14336409 1735813 2211056 104468
biovec-64            279    301   1048    7    2 : tunables   24   12    8 : slabdata     43     43      1 : globalstat    6048    349   566  461 				   0    0    0 3557 : cpustat   5398    887   2389     49
biovec-16            284    294    280   14    1 : tunables   32   16    8 : slabdata     21     21      0 : globalstat    4492    336   156  135 				   0    0    0  717 : cpustat   1590    365    966      0
biovec-4             288    315     88   45    1 : tunables   32   16    8 : slabdata      7      7      0 : globalstat    4115    334   104   97 				   0    0    0  351 : cpustat   1286    268    931      0
biovec-1             295    480     40   96    1 : tunables   32   16    8 : slabdata      5      5      0 : globalstat 1167384 998515 10923  307 				   0    1    0 950046 : cpustat 1172129  75246 282589  14462
bio                20200  26158    136   29    1 : tunables   32   16    8 : slabdata    902    902    128 : globalstat 15436635 998436 44317  109 				   0    2    0 14525763 : cpustat 16155826 1007812 2529700  88177
file_lock_cache        3     63    184   21    1 : tunables   32   16    8 : slabdata      3      3      0 : globalstat   23157 18446744073709551615   107   18 				   0    1    0 18144 : cpustat 235351   6364 218466   5102
sock_inode_cache     145    185    704    5    1 : tunables   32   16    8 : slabdata     37     37      0 : globalstat    3733   1520   311   27 				   0    0    0 1832 : cpustat  56540    630  55116     77
skbuff_head_cache    223    377    296   13    1 : tunables   32   16    8 : slabdata     28     29      0 : globalstat   89310    754   355  126 				   0    1    0 82912 : cpustat 166581   6053  89470     40
proc_inode_cache      30     72    656    6    1 : tunables   32   16    8 : slabdata     12     12      0 : globalstat   52914  14318  5085   17 				   0    1    0 35491 : cpustat 187956   7259 158540   1166
sigqueue              32     60    192   20    1 : tunables   32   16    8 : slabdata      3      3      0 : globalstat   43177    178   506  485 				   0    0    0 34643 : cpustat 161274   2921 129550      0
radix_tree_node    98990 100149    560    7    1 : tunables   32   16    8 : slabdata  14307  14307      0 : globalstat  308422  98990 18756   36 				   0    2    0 197446 : cpustat 340075  34275  77395    607
bdev_cache          2053   2065    816    5    1 : tunables   32   16    8 : slabdata    413    413      0 : globalstat    7161   2069   871   72 				   0    3    0 4039 : cpustat  12144   1224   7264     12
sysfs_dir_cache   107730 107830     96   41    1 : tunables   32   16    8 : slabdata   2630   2630      0 : globalstat  108179 107788  2633    3 				   0    0    0  237 : cpustat 223728   7915 123676      0
mnt_cache           2067   2116    168   23    1 : tunables   32   16    8 : slabdata     92     92      0 : globalstat    2236   2078    93    1 				   0    0    0    1 : cpustat   1986    190    108      0
inode_cache        15454  27840    624    6    1 : tunables   32   16    8 : slabdata   4640   4640      0 : globalstat   96641  84757 14283    4 				   0    2    0 60059 : cpustat 245872  15846 184712   1508
dentry_cache       22193  73488    248   16    1 : tunables   32   16    8 : slabdata   4593   4593     16 : globalstat  476186 155539 16442    4 				   0    2    0 162244 : cpustat 977680  42042 806406  28921
filp               17126  19558    272   14    1 : tunables   32   16    8 : slabdata   1397   1397      0 : globalstat  293377  86331  8745   14 				   0    0    0 148612 : cpustat 1991096  26474 1838295  13557
names_cache            6      6   4096    1    1 : tunables   24   12    8 : slabdata      6      6      0 : globalstat   31097   3452  8779 1892 				   0   25    0 28367 : cpustat 5531755  11901 5514840    446
idr_layer_cache       99    105    552    7    1 : tunables   32   16    8 : slabdata     15     15      0 : globalstat     214    102    16    1 				   0    0    0    5 : cpustat     91     48     35      0
buffer_head          685    770    112   35    1 : tunables   32   16    8 : slabdata     22     22      0 : globalstat 1174381 18446744073709547780 32092   15 				   0    1    0 845030 : cpustat 1087765 100094 321492  20698
mm_struct           4166   4466   1136    7    2 : tunables   24   12    8 : slabdata    638    638      0 : globalstat   77172  14665  3164   33 				   0    1    0 60988 : cpustat 480310   8968 422435   1700
vm_area_struct     53415  61826    208   19    1 : tunables   32   16    8 : slabdata   3254   3254      0 : globalstat 1922533 267113 23347    3 				   0    2    0 1422609 : cpustat 8994889 279735 7629557 169064
fs_cache            4170   4320     88   45    1 : tunables   32   16    8 : slabdata     96     96      0 : globalstat   68318  14653   450    2 				   0    0    0 54135 : cpustat 308299   5014 254064    959
files_cache         4161   4221    840    9    2 : tunables   32   16    8 : slabdata    469    469      0 : globalstat   67848  14651  2384   10 				   0    0    0 54135 : cpustat 307057   6257 254079    944
signal_cache        4213   4230    656    6    1 : tunables   32   16    8 : slabdata    705    705      0 : globalstat   42774  14765  3526   21 				   0    3    0 27535 : cpustat 308378   5860 281293   1197
sighand_cache       4205   4212   2088    3    2 : tunables   24   12    8 : slabdata   1403   1404      0 : globalstat   43170  14754  7299   35 				   0    1    0 27474 : cpustat 303872  10260 280698   1757
task_struct         4231   4240   1776    4    2 : tunables   24   12    8 : slabdata   1060   1060      0 : globalstat   43644  14780  5375   17 				   0    0    0 28078 : cpustat 305889   8357 280225   1723
anon_vma           17095  23409     48   81    1 : tunables   32   16    8 : slabdata    289    289      0 : globalstat  323371 113848  1827    0 				   0    0    0 130563 : cpustat 1324543  30791 1187916  19777
shared_policy_node      0      0     80   49    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
numa_policy           52    576     40   96    1 : tunables   32   16    8 : slabdata      6      6      0 : globalstat   52186  14679   156    2 				   0    0    0 44918 : cpustat 291287   3858 249238    937
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
size-65536             1      1  65536    1   16 : tunables    8    4    0 : slabdata      1      1      0 : globalstat       1      1     1    0 				   0    0    0    0 : cpustat      0      1      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
size-32768             3      4  32768    1    8 : tunables    8    4    0 : slabdata      3      4      0 : globalstat       6      5     6    2 				   0    0    0    2 : cpustat      1      6      2      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
size-16384            16     24  16384    1    4 : tunables    8    4    0 : slabdata     16     24      0 : globalstat     107     42    74   14 				   0    0    0   82 : cpustat     27     93     22      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
size-8192           6205   6208   8192    1    2 : tunables    8    4    0 : slabdata   6205   6208      0 : globalstat    6435   6208  6238   30 				   0    0    0   54 : cpustat 133422   6374 133537      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
size-4096             78     92   4096    1    1 : tunables   24   12    8 : slabdata     78     92      0 : globalstat    2950     93   327  233 				   0    0    0  321 : cpustat 100236    723 100580      0
size-2048(DMA)         0      0   2072    3    2 : tunables   24   12    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
size-2048           4825   6261   2072    3    2 : tunables   24   12    8 : slabdata   2083   2087      0 : globalstat   49346  11316  4775    4 				   0    2  309 36653 : cpustat 151297   8238 117695    682
size-1024(DMA)         0      0   1048    7    2 : tunables   24   12    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
size-1024           8469   8519   1048    7    2 : tunables   24   12    8 : slabdata   1213   1217      0 : globalstat   17053   8533  1259   30 				   0    0   69 4532 : cpustat  42692   2096  31844     22
size-512(DMA)          0     21    536    7    1 : tunables   32   16    8 : slabdata      0      3      0 : globalstat     269     28     4    1 				   0    0    0  105 : cpustat   4056     40   3991      0
size-512            9372  12159    536    7    1 : tunables   32   16    8 : slabdata   1737   1737      0 : globalstat  122828  14020  2133    1 				   0    1  711 106723 : cpustat 817549   9562 711605    153
size-256(DMA)          0      0    280   14    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
size-256            7943   8036    280   14    1 : tunables   32   16    8 : slabdata    574    574      0 : globalstat   14951   8058   580    0 				   0    0  105 1031 : cpustat 278113   1176 270419      1
size-128(DMA)          0      0    152   26    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
size-64(DMA)           0      0     88   45    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
size-64            35404  37215     88   45    1 : tunables   32   16    8 : slabdata    827    827      0 : globalstat   56241  38196   940    0 				   0    0 12399 14124 : cpustat 188926   3815 155491    150
size-32(DMA)           0      0     56   69    1 : tunables   32   16    8 : slabdata      0      0      0 : globalstat       0      0     0    0 				   0    0    0    0 : cpustat      0      0      0      0
size-128           54824  56108    152   26    1 : tunables   32   16    8 : slabdata   2158   2158      0 : globalstat   63409  54921  2230    0 				   0    0 1698 3782 : cpustat 333072   5101 281240     54
size-32            49995  50163     56   69    1 : tunables   32   16    8 : slabdata    727    727      0 : globalstat   56325  50193   731    2 				   0    0   39 2001 : cpustat 281278   4059 233361     19
kmem_cache           138    138   1280    3    1 : tunables   24   12    8 : slabdata     46     46      0 : globalstat     138    138    46    0 				   0    0    0    0 : cpustat     69     64      0      0

--=-Gxikca/k6dV1W1LzAMgr--

