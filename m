Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263304AbUDZRTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263304AbUDZRTP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 13:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUDZRTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 13:19:14 -0400
Received: from vena.lwn.net ([206.168.112.25]:14559 "HELO lwn.net")
	by vger.kernel.org with SMTP id S263304AbUDZRS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 13:18:57 -0400
Message-ID: <20040426171856.22514.qmail@lwn.net>
To: linux-kernel@vger.kernel.org
Subject: ext3 inode cache eats system, news at 11
From: Jonathan Corbet <corbet@lwn.net>
Date: Mon, 26 Apr 2004 11:18:56 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of the remaining bits of weirdness with my x86_64 system has been that
I often find it unresponsive in the morning; it's harder to get out of bed
than my middle-school son.  Some things happen (the pointer moves in
response to the mouse) but everything on the system seems asleep.  Very
little disk activity happens.  Eventually, usually, the system comes back
to life, but that can take 15-30 minutes.

I've managed to correlate this behavior with processes which read through
the whole disk.  The nightly updatedb run is the worst offender, but a full
backup of the disk can do it as well.

A look at /proc/meminfo (appended below) shows that the bulk of main memory
is taken up by the slab cache.  I'll append a full slabinfo listing as
well, but two things stand out:

ext3_inode_cache  488356 488978   1128    7    2 : tunables   24   12    0 : slabdata  69854  69854      0 : globalstat  503845 489160 71492    0    0    4   31 : cpustat 432956  71842  15175   1288
dentry_cache      623017 623018    344   11    1 : tunables   32   16    0 : slabdata  56638  56638      0 : globalstat  844725 739068 73219    3    0    3   43 : cpustat 773061  75754 211980  13818

Of my 800MB of slab use, those two are responsible for 755MB.

This is a vanilla 2.6.5 kernel on an x86_64 system.

Any thoughts on what's going on here?  Any other information which would be
useful?

Thanks,

jon

/proc/meminfo looks like:

MemTotal:      1025088 kB
MemFree:         86292 kB
Buffers:         27444 kB
Cached:          21468 kB
SwapCached:          0 kB
Active:          84008 kB
Inactive:        27444 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:      1025088 kB
LowFree:         86292 kB
SwapTotal:     1024120 kB
SwapFree:      1024120 kB
Dirty:               0 kB
Writeback:         116 kB
Mapped:          82224 kB
Slab:           807316 kB
Committed_AS:   230944 kB
PageTables:       7112 kB
VmallocTotal: 536870911 kB
VmallocUsed:     17884 kB
VmallocChunk: 536853027 kB

And slabinfo is:

slabinfo - version: 2.0 (statistics)
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail> : globalstat <listallocs> <maxobjs> <grown> <reaped> <error> <maxfreeable> <freelimit> : cpustat <allochit> <allocmiss> <freehit> <freemiss>
nfs_write_data        36     40    816    5    1 : tunables   32   16    0 : slabdata      8      8      0 : globalstat      44     40     8    0    0    0   37 : cpustat     37      9     10      0
nfs_read_data         32     35    784    5    1 : tunables   32   16    0 : slabdata      7      7      0 : globalstat      38     35     7    0    0    0   37 : cpustat     27      8      3      0
nfs_inode_cache       10     12   1216    3    1 : tunables   24   12    0 : slabdata      4      4      0 : globalstat      16     12     4    0    0    0   27 : cpustat      5      7      2      0
nfs_page               0      0    208   19    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat      16     16     1    1    0    0   51 : cpustat      8      1      9      0
rpc_buffers            8      9   2072    3    2 : tunables   24   12    0 : slabdata      3      3      0 : globalstat       9      9     3    0    0    0   27 : cpustat      5      3      0      0
rpc_tasks              8      9    400    9    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      10      9     1    0    0    0   41 : cpustat      8      2      2      0
rpc_inode_cache       10     14   1136    7    2 : tunables   24   12    0 : slabdata      2      2      0 : globalstat      14     14     2    0    0    0   31 : cpustat      8      2      0      0
unix_sock            157    160   1024    4    1 : tunables   32   16    0 : slabdata     40     40      0 : globalstat     242    176    47    7    0    0   36 : cpustat   1379     64   1286      0
tcp_tw_bucket          2     24    160   24    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat     128     18     6    5    0    0   56 : cpustat     23      8     29      0
tcp_bind_bucket       12     67     56   67    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat     176     32     1    0    0    0   99 : cpustat     30     11     29      0
tcp_open_request       0      0    104   37    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat      32     16     2    2    0    0   69 : cpustat      8      2     10      0
inet_peer_cache        0      0     96   40    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat      16     16     1    1    0    0   72 : cpustat      0      1      1      0
secpath_cache          0      0    160   24    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   56 : cpustat      0      0      0      0
xfrm_dst_cache         0      0    360   11    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   43 : cpustat      0      0      0      0
ip_fib_hash           11     77     48   77    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      16     16     1    0    0    0  109 : cpustat     12      1      2      0
ip_dst_cache          13     22    360   11    1 : tunables   32   16    0 : slabdata      2      2      0 : globalstat     152     33     3    1    0    0   43 : cpustat     45     14     46      0
arp_cache              3     11    336   11    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      47     11     1    0    0    0   43 : cpustat      1      5      3      0
raw4_sock              0      0   1040    7    2 : tunables   24   12    0 : slabdata      0      0      0 : globalstat       7      7     1    1    0    0   31 : cpustat      3      1      4      0
udp_sock               8     14   1048    7    2 : tunables   24   12    0 : slabdata      2      2      0 : globalstat      24     14     2    0    0    0   31 : cpustat     52      4     48      0
tcp_sock              14     14   1840    2    1 : tunables   24   12    0 : slabdata      7      7      0 : globalstat      37     16    18   11    0    0   26 : cpustat    145     19    150      0
flow_cache             0      0    136   28    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   60 : cpustat      0      0      0      0
uhci_urb_priv          1     34    112   34    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      32     16     2    1    0    0   66 : cpustat   6020      2   6021      0
scsi_cmd_cache         2      8    512    8    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat       8      8     1    0    0    0   40 : cpustat     65      1     64      0
isofs_inode_cache      0      0    872    9    2 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   41 : cpustat      0      0      0      0
ext2_inode_cache       0      0    960    4    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   36 : cpustat      0      0      0      0
journal_handle         2     53     72   53    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat    1248     17    65   64    0    0   85 : cpustat  73166     78  73244      0
journal_head        5709   5814    112   34    1 : tunables   32   16    0 : slabdata    171    171      0 : globalstat   29999   6272   349   19    0    1   66 : cpustat  34786   2152  29833   1398
revoke_table          10     91     40   91    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      32     18     1    0    0    0  123 : cpustat      8      2      0      0
revoke_record          0      0     56   67    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat      48     16     3    3    0    0   99 : cpustat      7      3     10      0
ext3_inode_cache  504677 504707   1128    7    2 : tunables   24   12    0 : slabdata  72098  72101      0 : globalstat  528110 505001 74279    1    0    4   31 : cpustat 454350  75045  22779   1950
ext3_xattr             0      0    112   34    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   66 : cpustat      0      0      0      0
eventpoll_pwq          0      0     96   40    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   72 : cpustat      0      0      0      0
eventpoll_epi          0      0    152   25    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   57 : cpustat      0      0      0      0
kioctx                 0      0    520    7    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   39 : cpustat      0      0      0      0
kiocb                  0      0    320   12    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   44 : cpustat      0      0      0      0
dnotify_cache          3     59     64   59    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      16     16     1    0    0    0   91 : cpustat      2      1      0      0
file_lock_cache        3     17    232   17    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat     215     17     2    1    0    0   49 : cpustat   3018     15   3030      0
fasync_cache           2     77     48   77    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      16     16     1    0    0    0  109 : cpustat      1      1      0      0
shmem_inode_cache     10     14   1080    7    2 : tunables   24   12    0 : slabdata      2      2      0 : globalstat      39     14     2    0    0    0   31 : cpustat      6      8      4      0
posix_timers_cache      0      0    256   15    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   47 : cpustat      0      0      0      0
uid_cache             10     59     64   59    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      32     18     1    0    0    0   91 : cpustat      9      2      1      0
sgpool-128            32     32   4096    1    1 : tunables   24   12    0 : slabdata     32     32      0 : globalstat      32     32    32    0    0    0   25 : cpustat      0     32      0      0
sgpool-64             32     33   2072    3    2 : tunables   24   12    0 : slabdata     11     11      0 : globalstat      33     33    11    0    0    0   27 : cpustat     21     11      0      0
sgpool-32             32     35   1048    7    2 : tunables   24   12    0 : slabdata      5      5      0 : globalstat      35     35     5    0    0    0   31 : cpustat     27      5      0      0
sgpool-16             32     35    536    7    1 : tunables   32   16    0 : slabdata      5      5      0 : globalstat      35     35     5    0    0    0   39 : cpustat     27      5      0      0
sgpool-8              32     42    280   14    1 : tunables   32   16    0 : slabdata      3      3      0 : globalstat      42     42     3    0    0    0   46 : cpustat     29      3      0      0
deadline_drq           0      0    120   32    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   64 : cpustat      0      0      0      0
as_arq                79     84    136   28    1 : tunables   32   16    0 : slabdata      3      3      0 : globalstat    5254    240    79   27    0    1   60 : cpustat  93815    350  93866    227
blkdev_requests       78     78    288   13    1 : tunables   32   16    0 : slabdata      6      6      0 : globalstat    4928    247   196   89    0    1   45 : cpustat  93739    426  93869    224
biovec-BIO_MAX_PAGES    256    256   4096    1    1 : tunables   24   12    0 : slabdata    256    256      0 : globalstat     280    280   280   24    0    0   25 : cpustat    130    280    154      0
biovec-128           256    258   2072    3    2 : tunables   24   12    0 : slabdata     86     86      0 : globalstat     272    270    90    4    0    0   27 : cpustat    262     91     97      0
biovec-64            256    259   1048    7    2 : tunables   24   12    0 : slabdata     37     37      0 : globalstat     306    280    40    3    0    0   31 : cpustat    448     49    241      0
biovec-16            256    266    280   14    1 : tunables   32   16    0 : slabdata     19     19      0 : globalstat     590    266    19    0    0    0   46 : cpustat   1833     52   1629      0
biovec-4             258    258     88   43    1 : tunables   32   16    0 : slabdata      6      6      0 : globalstat     570    274    19   13    0    0   75 : cpustat   1421     78   1243      0
biovec-1             343    364     40   91    1 : tunables   32   16    0 : slabdata      4      4      0 : globalstat   29681    776   162   29    0    1  123 : cpustat 119410   1925 119276   1726
bio                  336    352    120   32    1 : tunables   32   16    0 : slabdata     11     11      0 : globalstat   27975    832   536   87    0    2   64 : cpustat 127754   1760 127566   1615
sock_inode_cache     182    184    968    4    1 : tunables   32   16    0 : slabdata     46     46      0 : globalstat     296    200    57   11    0    0   36 : cpustat   1176     75   1069      0
skbuff_head_cache    418    450    256   15    1 : tunables   32   16    0 : slabdata     30     30      0 : globalstat     592    450    30    0    0    0   47 : cpustat 242750     39 242391     10
sock                   2      9    840    9    2 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      52      9     1    0    0    0   41 : cpustat     24      7     29      0
proc_inode_cache     328    369    880    9    2 : tunables   32   16    0 : slabdata     41     41      0 : globalstat     954    459    54    4    0    1   41 : cpustat  43712     94  43471     20
sigqueue              17     21    184   21    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      64     18     1    0    0    0   53 : cpustat  27228      4  27231      0
radix_tree_node     1804   2660    544    7    1 : tunables   32   16    0 : slabdata    380    380      0 : globalstat   13843  10381  1483    2    0    2   39 : cpustat  14785   1708  14070    640
bdev_cache            10     14   1040    7    2 : tunables   24   12    0 : slabdata      2      2      0 : globalstat      21     14     2    0    0    0   31 : cpustat     65      4     59      0
mnt_cache             26     28    136   28    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat      49     28     1    0    0    0   60 : cpustat     24      5      3      0
inode_cache         1437   1449    848    9    2 : tunables   32   16    0 : slabdata    161    161      0 : globalstat    1741   1449   161    0    0    0   41 : cpustat   2198    186    947      0
dentry_cache      591866 591866    344   11    1 : tunables   32   16    0 : slabdata  53806  53806      0 : globalstat  866469 739068 74379    3    0    3   43 : cpustat 793511  77496 262026  17120
filp                1571   1596    312   12    1 : tunables   32   16    0 : slabdata    133    133      0 : globalstat    3242   1656   156   12    0    2   44 : cpustat 133936    254 132546     73
names_cache            2      2   4096    1    1 : tunables   24   12    0 : slabdata      2      2      0 : globalstat     170      5    77   75    0    0   25 : cpustat 992031    166 992196      0
idr_layer_cache        3      7    552    7    1 : tunables   32   16    0 : slabdata      1      1      0 : globalstat       7      7     1    0    0    0   39 : cpustat      2      1      0      0
buffer_head         7276  31744    120   32    1 : tunables   32   16    0 : slabdata    992    992      0 : globalstat   93855  60576  2058    4    0    2   64 : cpustat 101591   5867  94918   5288
mm_struct             69     69   1352    3    1 : tunables   24   12    0 : slabdata     23     23      0 : globalstat     216     78    40   17    0    0   27 : cpustat   2954     83   2969      0
vm_area_struct      4414   4450    152   25    1 : tunables   32   16    0 : slabdata    178    178      0 : globalstat   52668   4916   668   13    0    2   57 : cpustat  99786   3596  96034   2942
fs_cache              90     96     80   48    1 : tunables   32   16    0 : slabdata      2      2      0 : globalstat     590     94     2    0    0    0   80 : cpustat   1778     38   1741      0
files_cache           72     72    888    9    2 : tunables   32   16    0 : slabdata      8      8      0 : globalstat     270     81    14    6    0    0   41 : cpustat   1760     49   1741      0
signal_cache         109    129     88   43    1 : tunables   32   16    0 : slabdata      3      3      0 : globalstat     617    113     4    1    0    0   75 : cpustat   1918     43   1867      0
sighand_cache         93     93   2128    3    2 : tunables   24   12    0 : slabdata     31     31      0 : globalstat     195     99    42   11    0    0   27 : cpustat   1879     79   1867      0
task_struct           96     96   2304    3    2 : tunables   24   12    0 : slabdata     32     32      0 : globalstat     217    102    54   22    0    0   27 : cpustat   1884     80   1868      0
pte_chain          15989  16107     64   59    1 : tunables   32   16    0 : slabdata    273    273      0 : globalstat   78859  16831   405    2    0    1   91 : cpustat  97169   5057  82371   3873
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9 : cpustat      0      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9 : cpustat      0      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9 : cpustat      0      0      0      0
size-65536             1      1  65536    1   16 : tunables    8    4    0 : slabdata      1      1      0 : globalstat       1      1     1    0    0    0    9 : cpustat      0      1      0      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9 : cpustat      0      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       1      1     1    1    0    0    9 : cpustat      0      1      1      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9 : cpustat      0      0      0      0
size-16384             6      6  16384    1    4 : tunables    8    4    0 : slabdata      6      6      0 : globalstat      67      9    54   48    0    0    9 : cpustat  75388     67  75449      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0    9 : cpustat      0      0      0      0
size-8192             21     21   8192    1    2 : tunables    8    4    0 : slabdata     21     21      0 : globalstat      76     24    63   42    0    0    9 : cpustat   2615     74   2668      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   25 : cpustat      0      0      0      0
size-4096             48     48   4096    1    1 : tunables   24   12    0 : slabdata     48     48      0 : globalstat     358     96   323  264    0   25   25 : cpustat   1330    347   1624      5
size-2048(DMA)         0      0   2072    3    2 : tunables   24   12    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   27 : cpustat      0      0      0      0
size-2048            447    447   2072    3    2 : tunables   24   12    0 : slabdata    149    149      0 : globalstat     448    447   149    0    0    0   27 : cpustat  26285    150  25997      0
size-1024(DMA)         0      0   1048    7    2 : tunables   24   12    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   31 : cpustat      0      0      0      0
size-1024            189    189   1048    7    2 : tunables   24   12    0 : slabdata     27     27      0 : globalstat     206    189    27    0    0    0   31 : cpustat  81861     29  81723      1
size-512(DMA)          0      0    536    7    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   39 : cpustat      0      0      0      0
size-512             339    364    536    7    1 : tunables   32   16    0 : slabdata     52     52      0 : globalstat     570    378    56    4    0    2   39 : cpustat  90134     71  89875     12
size-256(DMA)          0      0    280   14    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat      14     14     1    1    0    0   46 : cpustat     63      1     64      0
size-256             196    196    280   14    1 : tunables   32   16    0 : slabdata     14     14      0 : globalstat    2154    196    15    0    0    0   46 : cpustat   1022    164   1002      2
size-192(DMA)          0      0    216   18    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   50 : cpustat      0      0      0      0
size-192            1510   1512    216   18    1 : tunables   32   16    0 : slabdata     84     84      0 : globalstat    1529   1510    84    0    0    0   50 : cpustat 135669    170 134347      0
size-128(DMA)          0      0    152   25    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   57 : cpustat      0      0      0      0
size-128            1796   2050    152   25    1 : tunables   32   16    0 : slabdata     82     82      0 : globalstat  151875   2116   347    0    0    1   57 : cpustat 274866   9641 273346   9379
size-64(DMA)           0      0     88   43    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   75 : cpustat      0      0      0      0
size-64             2989   3096     88   43    1 : tunables   32   16    0 : slabdata     72     72      0 : globalstat  235012   3956   549    0    0    1   75 : cpustat 431289  14911 428723  14501
size-32(DMA)           0      0     56   67    1 : tunables   32   16    0 : slabdata      0      0      0 : globalstat       0      0     0    0    0    0   99 : cpustat      0      0      0      0
size-32              847    871     56   67    1 : tunables   32   16    0 : slabdata     13     13      0 : globalstat    1382    852    13    0    0    0   99 : cpustat  20215    123  19506      0
kmem_cache           108    108    320   12    1 : tunables   32   16    0 : slabdata      9      9      0 : globalstat     108    108     9    0    0    0   44 : cpustat     71     35      0      0
